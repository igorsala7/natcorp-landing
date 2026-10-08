/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · GRADE PADRÃO  —  todo Interactive Grid em linhas + gaveta (JavaScript)         ║
   ║  Todas as apps · o mesmo desenho das páginas da Medicina (2937: 6, 10, 12)               ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia: GRADE-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Pedido 08/10: "padronizar o Interactive Grid para ser como funciona em algumas páginas que
   você alterou, onde o registro muda de estilo e a linha vira um menu lateral para popular os
   campos". Em cada Interactive Grid da página:
     1. A LISTA: um registro por linha. O título é a 1ª coluna de dados; ao lado, as 4 colunas
        seguintes com o nome delas — na ORDEM das colunas do grid (reordenar no grid muda a
        linha). Contagem, busca nos registros carregados, "Adicionar" (se o grid deixa) e
        "Ver como tabela" (volta ao grid original; a escolha fica guardada por região).
     2. A GAVETA: tocar numa linha abre, do lado, a "vista de um registro" DO PRÓPRIO GRID (Single
        Row View) com os campos em duas colunas. Como é o formulário do grid, as ações dinâmicas
        das colunas, as validações e o salvar da página continuam valendo — nada é refeito aqui.
        Salvar / Cancelar / Excluir seguem o que o grid permite; ‹ › anda entre os registros;
        grid só de leitura abre a gaveta para CONSULTA. Esc fecha (pergunta se há algo não
        salvo), Ctrl+S salva.
     3. Se a gravação for recusada (validação da página, campo obrigatório), a gaveta fica aberta
        com o que foi digitado e a mensagem da própria página.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não grava nada por conta própria: o Salvar é o "save" do grid.
     • Não mexe em página com DESENHO PRÓPRIO (um Natcorp_<X>.js que não é dos globais) nem em
       grid com a classe nc-grade-nao. Para ligar numa página com desenho próprio: classe
       nc-grade-sim no grid (ou no body).
     • Sem este arquivo, os grids voltam ao visual padrão do APEX. Nada se perde.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [G1] Textos e ferramentas ............ frases, ícones                          PODE MEXER
     [G2] Quem entra ...................... quais grids viram lista                    CUIDADO
     [G3] A leitura do grid ............... colunas, valores, permissões              CUIDADO
     [G4] A lista ......................... cabeçalho, linhas, busca, vazio           PODE MEXER
     [G5] A gaveta ........................ abrir, andar, salvar, cancelar, excluir    CUIDADO
     [G6] O maestro ....................... quando monta e redesenha                  CUIDADO
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncGrade || !window.apex || !window.apex.jQuery) return;
  window.__ncGrade = true;
  var $ = apex.jQuery;
  /* o endereço deste arquivo (para se repassar aos iframes, [G7]) */
  var EU = (document.currentScript && document.currentScript.src) || window.__ncGradeSrc || '';
  if (EU) window.__ncGradeSrc = EU;

  /* ═══ [G1] TEXTOS E FERRAMENTAS ═════════════════════════════════════════════════════════ */
  var IC = {
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    tabela: '<rect x="3" y="4.5" width="18" height="15" rx="2"/><path d="M3 9.5h18M9 9.5v10"/>',
    lista: '<path d="M8 6.5h12M8 12h12M8 17.5h12"/><circle cx="4" cy="6.5" r="1"/><circle cx="4" cy="12" r="1"/><circle cx="4" cy="17.5" r="1"/>',
    dir: '<path d="M9 6l6 6-6 6"/>',
    esq: '<path d="M15 6l-6 6 6 6"/>',
    fechar: '<path d="M6 6l12 12M18 6L6 18"/>',
    check: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    lixo: '<path d="M5 7h14M10 7V5h4v2M7 7l1 13h8l1-13"/>',
    olho: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="3"/>',
    vazio: '<rect x="4" y="5" width="16" height="14" rx="2.5"/><path d="M4 10h16M9 14.5h6"/>',
    cima: '<path d="M12 19V5M6 11l6-6 6 6"/>',
    baixo: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    ordem: '<path d="M8 9l4-4 4 4M8 15l4 4 4-4"/>',
    expande: '<path d="M3 12h18M7 8l-4 4 4 4M17 8l4 4-4 4"/>',
    menu: '<path d="M7 10l5 5 5-5"/>',
    funil: '<path d="M4 5h16l-6 7.5V19l-4-2v-4.5z"/>',
    cadeado: '<rect x="5.5" y="10.5" width="13" height="9.5" rx="2"/><path d="M8.5 10.5V8a3.5 3.5 0 0 1 7 0v2.5"/>'
  };
  function ic(n) { return '<svg class="nc-gr-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function limpo(t) { t = String(t == null ? '' : t).replace(/<[^>]*>/g, ' ').replace(/\s+/g, ' ').trim(); return t === '-' || t === '.' ? '' : t; }
  function semAcento(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase(); }
  function plural(n, um, varios) { return n + ' ' + (n === 1 ? um : varios); }
  function guardar(k, v) { try { if (v) localStorage.setItem('nc-gr-' + k, v); else localStorage.removeItem('nc-gr-' + k); } catch (e) { /* sem memória */ } }
  function lembrar(k) { try { return localStorage.getItem('nc-gr-' + k); } catch (e) { return null; } }

  /* ═══ [G2] QUEM ENTRA ═══════════════════════════════════════════════════════════════════
     CUIDADO  GLOBAIS = os arquivos Natcorp_ que não são desenho de uma página. Qualquer outro
              Natcorp_<X>.js na página = desenho próprio = os grids ficam como estão (a não ser
              com nc-grade-sim). Acompanhe a lista PECAS do Natcorp_Temas.js.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var GLOBAIS = /^Natcorp_(Allow_Unload_Iframes|Temas|Registros|Trilha|Editor|Lov|Colab|Grade|Carregando)(\.min)?\.js$/i;
  function desenhoProprio() {
    return [].some.call(document.scripts, function (s) {
      var n = (s.src || '').split('/').pop().split('?')[0];
      return /^Natcorp_.+\.js$/i.test(n) && !GLOBAIS.test(n);
    });
  }
  function entra(reg) {
    if (!reg || reg.classList.contains('nc-grade-nao') || reg.closest('.nc-grade-nao')) return false;
    if (reg.closest('[class*="-gaveta"], [class*="-motor"]')) return false;             /* já está na gaveta de um desenho */
    if (reg.classList.contains('nc-grade-sim') || document.body.classList.contains('nc-grade-sim') || window.NC_GRADE_FORCAR) return true;
    return !desenhoProprio();
  }

  /* ═══ [G3] A LEITURA DO GRID ════════════════════════════════════════════════════════════ */
  var GRADES = [];
  function ler(reg) {
    var w, g;
    try { w = apex.region(reg.id).widget(); g = w.interactiveGrid('getViews', 'grid'); } catch (e) { return null; }
    if (!g || !g.model) return null;
    return { reg: reg, w: w, g: g, m: g.model, acoes: w.interactiveGrid('getActions') };
  }
  function titulo(G) {
    var t = G.reg.querySelector(':scope > .t-Region-header .t-Region-title, .t-Region-title');
    return limpo(t && t.textContent) || 'Registros';
  }
  /* as colunas à vista, na ordem do grid; sem as de controle (ação da linha, seleção) */
  function colunas(G) {
    var cs = [];
    try { cs = G.g.view$.grid('getColumns'); } catch (e) { return []; }
    return cs.filter(function (c) { return !c.hidden && c.property && !/^APEX\$/.test(c.property) && c.property !== '_meta'; })
      .sort(function (a, b) { return (a.seq || 0) - (b.seq || 0); })
      .map(function (c) { return { p: c.property, h: limpo(c.heading) || c.property, ro: !!c.readonly, w: c.width || c.curWidth || 0, sort: c.canSort !== false }; });
  }
  function valor(G, rec, col) {
    var v; try { v = G.m.getValue(rec, col); } catch (e) { return ''; }
    if (v && typeof v === 'object') v = v.d !== undefined && v.d !== null && v.d !== '' ? v.d : v.v;
    return limpo(v);
  }
  /* o id do registro SEMPRE como texto: grid sem chave usa números, e a linha da lista guarda texto
     (data-gr-id) — "1" ≠ 1 fazia a gaveta não achar o registro */
  function rid(G, rec) {
    try { var i = G.m.getRecordId(rec); if (i != null) return String(i); } catch (e) { /* segue */ }
    /* grid SEM chave (ex.: Exames da 2937:6): getRecordId devolve null; o id é o que o forEach dá */
    var achado = null;
    try { G.m.forEach(function (r, n, id) { if (achado === null && r === rec) achado = String(id); }); } catch (e) { /* ok */ }
    return achado;
  }
  function meta(G, id) { try { return G.m.getRecordMetadata(id) || {}; } catch (e) { return {}; } }
  function pode(G, op, id) {
    try {
      if (!G.m.getOption('editable')) return false;
      if (op === 'novo') return !!G.m.allowAdd();
      var rec = G.m.getRecord(id); if (!rec) return false;
      return !!(op === 'excluir' ? G.m.allowDelete(rec) : G.m.allowEdit(rec));
    } catch (e) { return false; }
  }
  function registros(G) {
    var out = [];
    G.m.forEach(function (rec, n, idForEach) {
      var id = null; try { id = G.m.getRecordId(rec); } catch (e) { /* ok */ }
      id = String(id != null ? id : idForEach);
      var md = meta(G, id); if (md.deleted || md.agg) return;
      out.push({ rec: rec, id: id, md: md });
    });
    return out;
  }

  /* ═══ [G4] A LISTA ══════════════════════════════════════════════════════════════════════
     O QUE FAZ  Uma tabela leve no lugar do grid:
                • CABEÇALHO com o título das colunas, preso no alto ao rolar (abaixo de qualquer
                  faixa fixa da página). Tocar num título ORDENA NO SERVIDOR (a ordenação do
                  próprio grid: crescente → decrescente → sem ordem), valendo para todos os
                  registros, não só os carregados;
                • BUSCA NO SERVIDOR (a busca do próprio grid), que acha também o que não carregou;
                • CARREGA AOS POUCOS: chegando ao fim da lista, busca o próximo bloco do servidor
                  (o tamanho de página do grid, ex.: 100) — "Mostrando 100 de 437";
                • quantas colunas couberem, na ordem e na proporção de largura do grid; as outras
                  ficam na ficha ("+N na ficha");
                • "código - descrição" mostra o código mais leve; resultados conhecidos (Apto,
                  Normal, Inapto…) viram selo colorido; Sim/Não viram selo neutro.
     CUIDADO    Com a lista à vista o grid fica fora da tela e NÃO busca os dados sozinho depois de
                ordenar ou buscar: buscarDados() pede o bloco ao modelo (model.fetch).
     PODE MEXER os textos; TOM (as palavras de cada cor do selo).
     VISUAL     Natcorp_Grade.css › [GC2] a [GC4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var TOM = {
    bom: /^(apto|normal|ativo|aprovad|conclu|liberad|regular|ok\b|v[aá]lid|realizad)/i,
    ruim: /^(inapto|reprovad|cancelad|vencid|bloquead|alterad|irregular|recusad|inv[aá]lid)/i,
    aviso: /^(pendente|aguard|em an[aá]lise|em andamento|parcial|a vencer)/i,
    neutro: /^(sim|n[aã]o)$/i
  };
  function codDesc(t) { var m = /^(\S{1,10})\s+-\s+(.+)$/.exec(t || ''); return m ? [m[1], m[2]] : null; }
  function tomDe(t) {
    var cd = codDesc(t), x = cd ? cd[1] : t;
    if (!x || x.length > 24) return null;
    for (var k in TOM) if (TOM[k].test(x.trim())) return k;
    return null;
  }
  function celulaHtml(t) {
    if (!t) return '<span class="nc-gr-nada">—</span>';
    var tom = tomDe(t), cd = codDesc(t);
    if (tom) return '<span class="nc-gr-selo nc-gr-selo--' + tom + '">' + esc(cd ? cd[1] : t) + '</span>';
    if (cd) return '<span class="nc-gr-cod">' + esc(cd[0]) + '</span>' + esc(cd[1]);
    return esc(t);
  }

  function montarLista(G) {
    /* montagem limpa: tira controles que tenham sobrado de uma montagem anterior nesta região */
    [].forEach.call(G.reg.querySelectorAll('.nc-gr-ctl, :scope > .t-Region-header .nc-gr-vistas'), function (x) { x.remove(); });
    G.caixa = el('section', 'nc-gr');
    G.caixa.setAttribute('aria-label', titulo(G));
    G.caixa.innerHTML =
      '<div class="nc-gr-barra">' +
        '<p class="nc-gr-conta" aria-live="polite"></p>' +
        '<label class="nc-gr-busca">' + ic('busca') + '<span class="nc-gr-vis">Buscar em ' + esc(titulo(G)) + '</span>' +
          '<input type="search" placeholder="Buscar em todos os registros" autocomplete="off"><button type="button" class="nc-gr-limpa" data-gr-limpa hidden aria-label="Limpar a busca">' + ic('fechar') + '</button></label>' +
        '<span class="nc-gr-espaco"></span>' +
        '<div class="nc-gr-ctl">' +
          '<button type="button" class="nc-gr-expande" data-gr-expande aria-pressed="false" title="Alarga todas as colunas até caber o conteúdo inteiro">' + ic('expande') + '<span>Expandir colunas</span></button>' +
          '<div class="nc-gr-vistas" role="group" aria-label="Como mostrar"><button type="button" aria-pressed="true" data-gr-vista="lista">' + ic('lista') + '<span>Lista</span></button>' +
          '<button type="button" aria-pressed="false" data-gr-vista="tabela" title="O grid original do APEX">' + ic('tabela') + '<span>Tabela</span></button></div>' +
        '</div>' +
        '<button type="button" class="nc-gr-bt nc-gr-bt--forte" data-gr-novo hidden>' + ic('mais') + '<span>Adicionar</span></button>' +
      '</div>' +
      '<div class="nc-gr-chips" hidden></div>' +
      '<div class="nc-gr-tab" role="table" aria-label="' + esc(titulo(G)) + '">' +
        '<div class="nc-gr-cab" role="row"></div>' +
        '<ul class="nc-gr-lista" role="rowgroup"></ul>' +
        '<span class="nc-gr-sentinela" aria-hidden="true"></span>' +
      '</div>' +
      '<div class="nc-gr-rodape"><p class="nc-gr-mais" aria-live="polite"></p></div>';
    var ig = G.reg.querySelector('.a-IG');
    ig.parentNode.insertBefore(G.caixa, ig);
    G.vistas = G.caixa.querySelector('.nc-gr-vistas');
    G.ctl = G.caixa.querySelector('.nc-gr-ctl');
    G.ctl.addEventListener('click', function (e) {
      var bv = e.target.closest('[data-gr-vista]');
      if (bv) { e.stopPropagation(); modo(G, bv.getAttribute('data-gr-vista')); return; }
      if (e.target.closest('[data-gr-expande]')) { e.stopPropagation(); expandir(G); }
    });
    G.busca = '';
    var inp = G.caixa.querySelector('input[type="search"]'), tb = null;
    inp.addEventListener('input', function () {
      G.caixa.querySelector('[data-gr-limpa]').hidden = !inp.value;
      clearTimeout(tb); tb = setTimeout(function () { buscar(G, inp.value); }, 450);
    });
    inp.addEventListener('keydown', function (e) { if (e.key === 'Enter') { e.preventDefault(); clearTimeout(tb); buscar(G, inp.value); } });
    G.caixa.addEventListener('click', function (e) {
      var b;
      if (e.target.closest('[data-gr-novo]')) { abrir(G, null, e.target.closest('button')); return; }
      if (e.target.closest('[data-gr-limpa]')) { inp.value = ''; e.target.closest('[data-gr-limpa]').hidden = true; buscar(G, ''); inp.focus(); return; }
      /* soltar o mouse no título depois de arrastar a borda NÃO é um clique para ordenar */
      if ((b = e.target.closest('[data-gr-ordem]'))) { if (Date.now() - (G.arrastouEm || 0) > 400) ordenar(G, b.getAttribute('data-gr-ordem')); return; }
      if (e.target.closest('[data-gr-carregar]')) { carregarMais(G); return; }
      if ((b = e.target.closest('[data-gr-menu]'))) { e.stopPropagation(); if (MENU && MENU.__prop === b.getAttribute('data-gr-menu')) fecharMenuCol(); else abrirMenuCol(G, b.getAttribute('data-gr-menu'), b); return; }
      if ((b = e.target.closest('[data-gr-tira-filtro]'))) { tirarFiltro(G, b.getAttribute('data-gr-tira-filtro')); return; }
      if (e.target.closest('[data-gr-tira-filtros]')) { G.filtroLocal = {}; Object.keys(filtrosDeColuna(G)).forEach(function (p) { var f = filtrosDeColuna(G)[p]; if (f && !f.local) try { G.w.interactiveGrid('deleteFilter', f.id, { save: true, refreshData: false }); } catch (x) { /* ok */ } }); buscarDados(G); return; }
      if (e.target.closest('[data-gr-larg-volta]')) { G.larguras = {}; G.expLista = false; guardar('larg-' + chave(G), ''); guardar('exp-' + chave(G), ''); desenhar(G); estadoExpande(G); return; }
      if (e.target.closest('[data-gr-larg]')) return;
      var li = e.target.closest('[data-gr-id]');
      if (!li) return;
      if (ED && ED.G === G) irParaRegistro(li.getAttribute('data-gr-id'));
      else abrir(G, li.getAttribute('data-gr-id'), li);
    });
    ligarLarguras(G);
    ligarMover(G);
    var tabela = G.caixa.querySelector('.nc-gr-tab');
    tabela.addEventListener('scroll', function () { tabela.classList.toggle('is-rolado', tabela.scrollLeft > 2); }, { passive: true });
    G.caixa.addEventListener('keydown', function (e) {
      var al = e.target.closest && e.target.closest('[data-gr-larg]');
      if (al && (e.key === 'ArrowLeft' || e.key === 'ArrowRight')) {
        e.preventDefault();
        var pr = al.getAttribute('data-gr-larg');
        mudarLargura(G, pr, larguraAtual(G, pr) + (e.key === 'ArrowRight' ? 16 : -16), true);
        var de = G.caixa.querySelector('[data-gr-larg="' + pr + '"]'); if (de) de.focus();
        return;
      }
      var li = e.target.closest && e.target.closest('[data-gr-id]');
      if (!li) return;
      if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); if (ED && ED.G === G) irParaRegistro(li.getAttribute('data-gr-id')); else abrir(G, li.getAttribute('data-gr-id'), li); }
      if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
        e.preventDefault();
        var alvo = e.key === 'ArrowDown' ? li.nextElementSibling : li.previousElementSibling;
        if (alvo && alvo.matches('[data-gr-id]')) alvo.focus();
      }
    });
    /* respiro: região sem padding nas laterais (modelo "sem padding", comum em grid) → a lista ganha 16 px */
    var corpo = G.reg.querySelector('.t-Region-body') || G.caixa.parentNode;
    if (parseFloat(getComputedStyle(corpo).paddingLeft) < 8) G.caixa.classList.add('nc-gr--respiro');
    /* as larguras que a pessoa escolheu para as colunas (arrastar a borda do título) */
    try { G.larguras = JSON.parse(lembrar('larg-' + chave(G)) || '{}') || {}; } catch (e) { G.larguras = {}; }
    G.expLista = lembrar('exp-' + chave(G)) === '1';
    var cg = lembrar('cong-' + chave(G)); G.cong = cg === null || cg === '' ? 1 : +cg;
    /* carrega mais ao chegar perto do fim da lista */
    if (window.IntersectionObserver) {
      G.obs = new IntersectionObserver(function (es) { if (es.some(function (x) { return x.isIntersecting; })) carregarMais(G); }, { root: G.caixa.querySelector('.nc-gr-tab'), rootMargin: '0px 0px 400px 0px' });
      G.obs.observe(G.caixa.querySelector('.nc-gr-sentinela'));
    }
    medirTopo(G);
    larguraDoGrid(G);
    /* quantas colunas cabem depende da largura: aba escondida que abre (largura 0 → real), gaveta
       que abre ao lado, janela que muda — redesenha quando a largura da lista muda */
    if (window.ResizeObserver) {
      G.larg = 0;
      /* a TABELA (não a caixa): a gaveta abre espaço com padding na caixa, e só a tabela encolhe */
      var tab = G.caixa.querySelector('.nc-gr-tab');
      G.ro = new ResizeObserver(function () {
        var w = Math.round(tab.getBoundingClientRect().width);
        if (w && Math.abs(w - G.larg) > 8) { G.larg = w; larguraDoGrid(G); medirTopo(G); desenhar(G); }
      });
      G.ro.observe(tab);
    }
  }
  /* ---------- largura das colunas: arrastar a borda do título, dois cliques = ajustar ao conteúdo ---------- */
  function larguraAtual(G, prop) {
    var th = G.caixa.querySelector('.nc-gr-cab [data-gr-ordem="' + prop + '"]');
    return th ? Math.round(th.getBoundingClientRect().width) : 160;
  }
  function mudarLargura(G, prop, px, guarda) {
    G.larguras[prop] = Math.max(60, Math.min(Math.round(px), 900));
    if (guarda) { guardar('larg-' + chave(G), JSON.stringify(G.larguras)); desenhar(G); }
    if (guarda && G.expLista) { G.expLista = false; guardar('exp-' + chave(G), ''); estadoExpande(G); }
    else {
      /* durante o arrasto só troca o molde das colunas (sem redesenhar as linhas) */
      G.caixa.style.setProperty('--gr-tpl', molde(G));
    }
  }
  /* ---------- medir o conteúdo: a largura que o texto de cada valor ocupa (canvas, sem mexer na tela) ---------- */
  var regua = null;
  function medir(t, fonte) {
    if (!regua) regua = document.createElement('canvas').getContext('2d');
    regua.font = fonte; return regua.measureText(String(t || '')).width;
  }
  /* medir com o MESMO estilo de um elemento da tela (fonte, algarismos, ligaduras, espaçamento): a
     régua de canvas ignora font-feature-settings (a Inter NC tem algarismos e formas próprios) */
  var reguaDom = null;
  function medirComo(ref, textos) {
    if (!reguaDom) { reguaDom = document.createElement('span'); reguaDom.setAttribute('aria-hidden', 'true'); reguaDom.style.cssText = 'position:absolute;left:-9999px;top:0;visibility:hidden;white-space:nowrap;'; document.body.appendChild(reguaDom); }
    var cs = getComputedStyle(ref);
    ['fontFamily', 'fontSize', 'fontWeight', 'fontStyle', 'letterSpacing', 'fontFeatureSettings', 'fontVariantNumeric', 'fontKerning', 'textTransform'].forEach(function (k) { reguaDom.style[k] = cs[k]; });
    var max = 0;
    textos.forEach(function (t) { if (!t) return; reguaDom.textContent = t; max = Math.max(max, reguaDom.getBoundingClientRect().width); });
    return max;
  }
  function fonteDe(sel, raiz, padrao) { var e = (raiz || document).querySelector(sel); if (!e) return padrao; var c = getComputedStyle(e); return c.fontWeight + ' ' + c.fontSize + ' ' + c.fontFamily; }
  /* a largura que a coluna precisa para mostrar TODOS os valores carregados inteiros (com o título) */
  function precisaLista(G, x, i) {
    var f = fonteDe('.nc-gr-td:not(.nc-gr-td--tit)', G.caixa, '400 14px Inter, sans-serif');
    var ft = fonteDe('.nc-gr-td--tit', G.caixa, '700 14px Inter, sans-serif');
    var fc = '700 11.5px ' + f.replace(/^\S+ \S+ /, ''), fs = '700 12px ' + f.replace(/^\S+ \S+ /, '');
    var fh = fonteDe('.nc-gr-th span', G.caixa, '700 12px Inter, sans-serif');
    var max = medir(x.c.h, fh) + 24 + 22;                                 /* título da coluna + seta de ordem */
    registros(G).forEach(function (r) {
      var v = valor(G, r.rec, x.c.p); if (!v) return;
      var cd = codDesc(v), tom = tomDe(v), w;
      if (tom) w = medir(cd ? cd[1] : v, fs) + 18;
      else if (cd) w = medir(cd[0], fc) + 12 + 6 + medir(cd[1], i === 0 ? ft : f);
      else w = medir(v, i === 0 ? ft : f);
      max = Math.max(max, w + (i === 0 ? 28 : 24) + 2);
    });
    return Math.ceil(max);
  }
  function ajustarAoConteudo(G, prop) {
    var x = (G.vis || []).filter(function (y) { return y.c.p === prop; })[0]; if (!x) return;
    mudarLargura(G, prop, precisaLista(G, x, G.vis.indexOf(x)), true);
  }
  function ligarLarguras(G) {
    var arr = null;
    G.caixa.addEventListener('pointerdown', function (e) {
      var al = e.target.closest('[data-gr-larg]'); if (!al || e.button !== 0) return;
      e.preventDefault();
      var prop = al.getAttribute('data-gr-larg');
      arr = { prop: prop, x0: e.clientX, w0: larguraAtual(G, prop), al: al };
      al.setPointerCapture(e.pointerId);
      G.caixa.classList.add('is-arrastando');
    });
    G.caixa.addEventListener('pointermove', function (e) {
      if (!arr) return;
      mudarLargura(G, arr.prop, arr.w0 + (e.clientX - arr.x0), false);
    });
    var soltar = function (e) {
      if (!arr) return;
      var a = arr; arr = null;
      G.caixa.classList.remove('is-arrastando');
      if (Math.abs(e.clientX - a.x0) > 2) { G.arrastouEm = Date.now(); mudarLargura(G, a.prop, a.w0 + (e.clientX - a.x0), true); }
    };
    G.caixa.addEventListener('pointerup', soltar);
    G.caixa.addEventListener('pointercancel', soltar);
    G.caixa.addEventListener('dblclick', function (e) {
      var al = e.target.closest('[data-gr-larg]'); if (!al) return;
      e.preventDefault(); ajustarAoConteudo(G, al.getAttribute('data-gr-larg'));
    });
  }
  /* fora da tela o grid fica com a largura da REGIÃO: ao voltar (modo Tabela) as colunas e a barra
     dele já estão certas (antes ficava com 1100 px e rolado para o lado) */
  function larguraDoGrid(G) {
    var w = Math.round((G.reg.querySelector('.t-Region-body') || G.reg).clientWidth);
    if (w > 200) G.reg.style.setProperty('--gr-ig-w', w + 'px');
  }
  /* onde a chave mora (ver modo()). Conferido também a cada desenho: a região pode ter nascido numa aba
     ESCONDIDA (cabeçalho "invisível" naquela hora) e a chave tem de ir para o cabeçalho quando ela abre */
  function posicionarChave(G) {
    if (!G.ctl || G.morto) return;
    var cab = G.reg.querySelector(':scope > .t-Region-header');
    /* só pela ESTRUTURA da região (ela tem cabeçalho e ele não está escondido por si): nunca pela aba
       estar aberta ou fechada naquele instante — senão a chave mudava de lugar ao trocar de aba */
    var visivel = cab && getComputedStyle(cab).display !== 'none' && !G.reg.classList.contains('t-Region--removeHeader') && !G.reg.classList.contains('t-Region--hiddenHeader');
    var lugarCab = visivel ? (cab.querySelector('.t-Region-headerItems--buttons') || cab) : null;
    if (lugarCab) { if (G.ctl.parentNode !== lugarCab) lugarCab.appendChild(G.ctl); G.reg.classList.add('nc-gr-chave-no-cab'); }
    else { var barra = G.caixa.querySelector('.nc-gr-barra'); if (barra.lastElementChild !== G.ctl) barra.appendChild(G.ctl); G.reg.classList.remove('nc-gr-chave-no-cab'); }
    estadoExpande(G);
  }
  /* ---------- "Expandir colunas" (o mesmo botão nos dois modos, age no modo que está à vista) ----------
     Lista : cada coluna ganha a largura que o conteúdo carregado pede (precisaLista); de novo = padrão.
     Tabela: mede o texto de cada coluna e aplica com o comando de largura DO PRÓPRIO GRID
             (setColumnWidth — o mesmo de arrastar a borda; o grid guarda no relatório); de novo = volta
             às larguras de antes. */
  function semEsticar(G) {
    /* o grid "estica" as colunas para ocupar a largura toda: mudar uma mexia nas outras. Sem esticar,
       cada uma fica do tamanho que tem e o que sobra fica em branco à direita */
    try { G.g.view$.grid('getColumns').forEach(function (c) { c.noStretch = true; }); } catch (e) { /* ok */ }
  }
  function expandirLista(G) {
    if (G.expLista) { G.larguras = {}; G.expLista = false; }
    else { (G.vis || []).forEach(function (x, i) { G.larguras[x.c.p] = Math.max(60, Math.min(precisaLista(G, x, i), 900)); }); G.expLista = true; }
    guardar('larg-' + chave(G), Object.keys(G.larguras).length ? JSON.stringify(G.larguras) : '');
    guardar('exp-' + chave(G), G.expLista ? '1' : '');
    desenhar(G);
  }
  function expandirGrid(G) {
    var g = G.g, cols; try { cols = g.view$.grid('getColumns').filter(function (c) { return !c.hidden && c.property && !/^APEX\$/.test(c.property); }); } catch (e) { return; }
    semEsticar(G);
    if (G.expGrid && G.igAntes) {
      cols.forEach(function (c) { if (G.igAntes[c.property]) try { g.view$.grid('setColumnWidth', c.property, G.igAntes[c.property]); } catch (e) { /* ok */ } });
      G.expGrid = false;
    } else {
      G.igAntes = {}; cols.forEach(function (c) { G.igAntes[c.property] = c.width || c.curWidth; });
      /* mede NA PRÓPRIA TELA: a largura do texto dentro de cada célula (Range — vale mesmo cortada com
         "…") + o padding dela. Sem estimar fonte: a Inter NC tem algarismos e formas próprios. As
         células e os títulos são ligados à coluna pela posição na linha (a mesma do cabeçalho). */
      var precisa = {}, rg = document.createRange();
      var larguraTexto = function (el) { rg.selectNodeContents(el); return rg.getBoundingClientRect().width; };
      var caixa = function (el) { var cs = getComputedStyle(el); return parseFloat(cs.paddingLeft) + parseFloat(cs.paddingRight) + parseFloat(cs.borderLeftWidth) + parseFloat(cs.borderRightWidth); };
      /* cada tabela do grid (cabeçalho e corpo; parte congelada e parte que rola) tem <col data-idx>:
         a posição da célula na linha → o <col> da mesma posição → a coluna na lista INTERNA do grid */
      var internas = []; try { internas = g.view$.grid('instance').columns || []; } catch (e) { /* ok */ }
      [].forEach.call(G.reg.querySelectorAll('.a-GV table'), function (tab) {
        var cs = [].slice.call(tab.querySelectorAll(':scope > colgroup > col, :scope > col'));
        if (!cs.length) return;
        [].forEach.call(tab.querySelectorAll('tr'), function (tr) {
          [].forEach.call(tr.children, function (cel, k) {
            var col = cs[k], c = col && internas[+col.getAttribute('data-idx')];
            if (!c || !c.property || /^APEX\$/.test(c.property) || !cel.textContent.trim()) return;
            var alvo = cel.tagName === 'TH' ? (cel.querySelector('.a-GV-headerLabel') || cel) : cel;
            var extra = cel.tagName === 'TH' ? 26 : 2;                                /* título: menu/ordem */
            precisa[c.property] = Math.max(precisa[c.property] || 0, larguraTexto(alvo) + caixa(cel) + extra);
          });
        });
      });
      cols.forEach(function (c) {
        if (!precisa[c.property]) return;
        try { g.view$.grid('setColumnWidth', c.property, Math.max(60, Math.min(Math.ceil(precisa[c.property]), 900))); } catch (e) { /* ok */ }
      });
      G.expGrid = true;
    }
    try { g.view$.grid('refreshColumns'); g.view$.grid('resize'); } catch (e) { /* ok */ }
  }
  function expandir(G) {
    if (G.modo === 'tabela') expandirGrid(G); else expandirLista(G);
    estadoExpande(G);
  }
  function estadoExpande(G) {
    var b = G.ctl && G.ctl.querySelector('[data-gr-expande]'); if (!b) return;
    var on = G.modo === 'tabela' ? !!G.expGrid : !!G.expLista;
    b.setAttribute('aria-pressed', String(on));
    b.querySelector('span').textContent = on ? 'Larguras padrão' : 'Expandir colunas';
    b.title = on ? 'Volta as colunas à largura de antes' : 'Alarga todas as colunas até caber o conteúdo inteiro';
  }
  /* ═══ [G4b] O MENU DA COLUNA: ordenar, filtrar, congelar, mover ═════════════════════════════
     Tudo pelo PRÓPRIO GRID, que guarda no relatório e vale também no modo Tabela:
       filtro  → interactiveGrid('addFilter', {type:'column', columnName, operator:'IN', value}) — o IN
                 compara o TEXTO MOSTRADO ("241 - HEMOGRAMA", não o código "241"); vários valores com ";"
       mover   → grid('moveColumn', nome, posição na lista INTERNA do grid)
       ordenar → ordenar() (o mesmo do clique no título)
     Congelar é desta lista (as N primeiras colunas presas ao rolar para o lado), guardado no navegador.
     Os valores do filtro são os que a coluna tem nos registros CARREGADOS (contados).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MENU = null;
  function idColuna(G, prop) { try { var c = G.g.view$.grid('getColumns').filter(function (x) { return x.property === prop; })[0]; return c && c.id; } catch (e) { return null; } }
  function filtrosDeColuna(G) {
    var out = {}, cols = {};
    try { G.g.view$.grid('getColumns').forEach(function (c) { cols[c.id] = c.property; }); } catch (e) { return out; }
    var fs = []; try { fs = G.w.interactiveGrid('getFilters') || []; } catch (e) { /* ok */ }
    fs.forEach(function (f) {
      if (f.type !== 'column' || f.operation === 'd' || f.isEnabled === false || !cols[f.columnId]) return;
      var vals = String(f.value == null ? '' : f.value).split('\u0001').filter(function (v) { return v !== ''; });
      out[cols[f.columnId]] = { id: f.id, operador: f.operator, valores: vals.length ? vals : [String(f.value)] };
    });
    Object.keys(G.filtroLocal || {}).forEach(function (p) { out[p] = { id: 'local:' + p, valores: G.filtroLocal[p], local: true }; });
    return out;
  }
  /* coluna que o grid sabe filtrar no servidor? Coluna sem fonte na consulta (Médico, na 2937:6) vem
     com filter:false — o servidor IGNORA o filtro dela e devolve tudo, sem erro. Essa é filtrada aqui,
     nos registros carregados (G.filtroLocal; não fica guardada no relatório) */
  function filtraNoServidor(G, prop) {
    try { var cm = G.w.interactiveGrid('instance').columnMap || {}; for (var k in cm) if (cm[k] && cm[k].name === prop) return cm[k].filter !== false; } catch (e) { /* ok */ }
    return true;
  }
  function tirarFiltro(G, id) {
    if (/^local:/.test(id)) { delete (G.filtroLocal || {})[id.slice(6)]; return desenhar(G); }
    try { G.w.interactiveGrid('deleteFilter', id); } catch (e) { return avisar('Não foi possível tirar o filtro.', true); }
    buscarDados(G);
  }
  function filtrar(G, prop, valores) {
    if (!filtraNoServidor(G, prop)) {
      G.filtroLocal = G.filtroLocal || {};
      if (valores.length) G.filtroLocal[prop] = valores; else delete G.filtroLocal[prop];
      return desenhar(G);
    }
    var atual = filtrosDeColuna(G)[prop];
    try {
      if (atual) G.w.interactiveGrid('deleteFilter', atual.id, { save: !valores.length, refreshData: false });
      if (valores.length) G.w.interactiveGrid('addFilter', { type: 'column', columnType: 'column', columnName: prop, operator: 'IN', value: valores.join('\u0001'), isCaseSensitive: false });   /* o IN do grid separa por \u0001 (com ';' volta vazio) */
    } catch (e) { return avisar('Não foi possível filtrar esta coluna.', true); }
    buscarDados(G);
  }
  function distintos(G, prop) {
    var n = {}; registros(G).forEach(function (r) { var v = valor(G, r.rec, prop); if (v) n[v] = (n[v] || 0) + 1; });
    /* na ordem natural, como o filtro de planilha: data por data (dd/mm/aaaa → aaaammdd), número por número */
    var chave = function (t) { var d = /^(\d{2})\/(\d{2})\/(\d{4})/.exec(t); return d ? d[3] + d[2] + d[1] + t.slice(10) : t; };
    return Object.keys(n).map(function (k) { return { t: k, n: n[k] }; }).sort(function (a, b) { return chave(a.t).localeCompare(chave(b.t), 'pt-BR', { numeric: true }); });
  }
  function moverColuna(G, prop, novaVis) {
    var vis = (G.vis || []).map(function (x) { return x.c.p; }), de = vis.indexOf(prop);
    if (de < 0 || novaVis === de || novaVis < 0 || novaVis >= vis.length) return;
    var alvo = vis[novaVis], internas = [];
    try { internas = G.g.view$.grid('instance').columns || []; } catch (e) { /* ok */ }
    var pos = internas.map(function (c) { return c.property; }).indexOf(alvo);
    if (pos < 0) return;
    try { G.g.view$.grid('moveColumn', prop, pos); } catch (e) { return avisar('Não foi possível mover a coluna.', true); }
    desenhar(G);
    var th = G.caixa.querySelector('[data-gr-col="' + prop + '"]');
    if (th) { th.classList.add('is-movida'); setTimeout(function () { th.classList.remove('is-movida'); }, 900); }
  }
  function congelar(G, n) { G.cong = n; guardar('cong-' + chave(G), String(n)); desenhar(G); }
  function fecharMenuCol() {
    if (!MENU) return;
    var volta = MENU.__volta; MENU.remove(); MENU = null;
    document.removeEventListener('pointerdown', foraDoMenu, true);
    if (volta && document.body.contains(volta)) volta.focus({ preventScroll: true });
  }
  function foraDoMenu(e) { if (MENU && !MENU.contains(e.target) && !e.target.closest('[data-gr-menu]')) fecharMenuCol(); }
  function abrirMenuCol(G, prop, ancora) {
    fecharMenuCol();
    var vis = G.vis || [], i = vis.map(function (x) { return x.c.p; }).indexOf(prop), x = vis[i]; if (!x) return;
    var o = ordemDe(G)[prop], fl = filtrosDeColuna(G)[prop], sel = {}, vals = distintos(G, prop);
    if (fl) fl.valores.forEach(function (v) { sel[v] = 1; });
    var cong = G.cong == null ? 1 : G.cong;
    MENU = el('div', 'nc-gr-menu');
    MENU.__prop = prop; MENU.__volta = ancora;
    MENU.setAttribute('role', 'dialog'); MENU.setAttribute('aria-label', 'Opções da coluna ' + x.c.h);
    MENU.innerHTML =
      '<p class="nc-gr-menu-tit">' + esc(x.c.h) + '</p>' +
      (x.c.sort ? '<div class="nc-gr-menu-sec"><p class="nc-gr-menu-rot">Ordenar</p><div class="nc-gr-seg">' +
        [['asc', 'cima', 'Crescente'], ['desc', 'baixo', 'Decrescente'], ['', 'ordem', 'Sem ordem']].map(function (a) {
          return '<button type="button" data-m-ordem="' + a[0] + '" aria-pressed="' + ((o || '') === a[0]) + '">' + ic(a[1]) + '<span>' + a[2] + '</span></button>';
        }).join('') + '</div></div>' : '') +
      '<div class="nc-gr-menu-sec"><p class="nc-gr-menu-rot">Filtrar por ' + esc(x.c.h.toLowerCase()) + '</p>' +
        (vals.length > 6 ? '<label class="nc-gr-menu-busca">' + ic('busca') + '<input type="search" placeholder="Procurar valor" data-m-busca></label>' : '') +
        '<div class="nc-gr-menu-vals" role="group" aria-label="Valores">' + (vals.length ? vals.map(function (v) {
          return '<label class="nc-gr-menu-val" data-t="' + esc(semAcento(v.t)) + '"><input type="checkbox" value="' + esc(v.t) + '"' + (sel[v.t] ? ' checked' : '') + '><span>' + esc(v.t) + '</span><em>' + v.n + '</em></label>';
        }).join('') : '<p class="nc-gr-menu-nada">Nenhum valor nesta coluna.</p>') + '</div>' +
        (vals.length ? '<div class="nc-gr-menu-acoes"><button type="button" class="nc-gr-link" data-m-todos>Marcar todos</button>' +
          '<span class="nc-gr-espaco"></span>' + (fl ? '<button type="button" class="nc-gr-bt" data-m-limpa>Limpar</button>' : '') +
          '<button type="button" class="nc-gr-bt nc-gr-bt--forte" data-m-aplica>Filtrar</button></div>' : '') +
        (haMais(G) ? '<p class="nc-gr-menu-nota">' + (filtraNoServidor(G, prop) ? 'Valores dos ' + carregados(G) + ' registros carregados.' : 'Esta coluna filtra só os ' + carregados(G) + ' registros carregados.') + '</p>' : '') + '</div>' +
      '<div class="nc-gr-menu-sec nc-gr-menu-lista">' +
        (i < cong ? '<button type="button" data-m-cong="' + (i === 0 && cong === 1 ? 0 : i) + '">' + ic('cadeado') + '<span>' + (i === 0 && cong === 1 ? 'Descongelar a 1ª coluna' : 'Descongelar daqui em diante') + '</span></button>'
                  : '<button type="button" data-m-cong="' + (i + 1) + '">' + ic('cadeado') + '<span>Congelar até esta coluna</span></button>') +
        '<button type="button" data-m-mover="-1"' + (i === 0 ? ' disabled' : '') + '>' + ic('esq') + '<span>Mover para a esquerda</span></button>' +
        '<button type="button" data-m-mover="1"' + (i === vis.length - 1 ? ' disabled' : '') + '>' + ic('dir') + '<span>Mover para a direita</span></button>' +
        '<button type="button" data-m-ajusta>' + ic('expande') + '<span>Ajustar largura ao conteúdo</span></button>' +
      '</div>';
    document.body.appendChild(MENU);
    /* fica embaixo do título, sem sair da tela */
    var r = ancora.closest('.nc-gr-thc').getBoundingClientRect(), mw = MENU.offsetWidth, mh = MENU.offsetHeight;
    var left = Math.max(8, Math.min(r.left, window.innerWidth - mw - 8)), top = r.bottom + 4;
    if (top + mh > window.innerHeight - 8) top = Math.max(8, window.innerHeight - mh - 8);
    MENU.style.left = Math.round(left) + 'px'; MENU.style.top = Math.round(top) + 'px';
    document.addEventListener('pointerdown', foraDoMenu, true);
    MENU.addEventListener('keydown', function (e) { if (e.key === 'Escape') { e.preventDefault(); e.stopPropagation(); fecharMenuCol(); } });
    var busca = MENU.querySelector('[data-m-busca]');
    if (busca) busca.addEventListener('input', function () { var q = semAcento(busca.value.trim()); [].forEach.call(MENU.querySelectorAll('.nc-gr-menu-val'), function (l) { l.hidden = q && l.getAttribute('data-t').indexOf(q) < 0; }); });
    MENU.addEventListener('click', function (e) {
      var b = e.target.closest('button'); if (!b) return;
      if (b.hasAttribute('data-m-ordem')) {
        var d = b.getAttribute('data-m-ordem'), at = ordemDe(G)[prop];
        fecharMenuCol();
        if (!d) { if (at) ordenarPara(G, prop, at); }                      /* mesma direção = limpar */
        else if (d !== at) ordenarPara(G, prop, d);
        return;
      }
      if (b.hasAttribute('data-m-todos')) { var cx = [].filter.call(MENU.querySelectorAll('.nc-gr-menu-val:not([hidden]) input'), function () { return true; }); var tudo = cx.every(function (c) { return c.checked; }); cx.forEach(function (c) { c.checked = !tudo; }); b.textContent = tudo ? 'Marcar todos' : 'Desmarcar todos'; return; }
      if (b.hasAttribute('data-m-aplica')) { var vs = [].filter.call(MENU.querySelectorAll('.nc-gr-menu-val input'), function (c) { return c.checked; }).map(function (c) { return c.value; }); fecharMenuCol(); filtrar(G, prop, vs); return; }
      if (b.hasAttribute('data-m-limpa')) { fecharMenuCol(); filtrar(G, prop, []); return; }
      if (b.hasAttribute('data-m-cong')) { fecharMenuCol(); congelar(G, +b.getAttribute('data-m-cong')); return; }
      if (b.hasAttribute('data-m-mover')) { fecharMenuCol(); moverColuna(G, prop, i + (+b.getAttribute('data-m-mover'))); return; }
      if (b.hasAttribute('data-m-ajusta')) { fecharMenuCol(); ajustarAoConteudo(G, prop); }
    });
    var f1 = MENU.querySelector('[data-m-busca]') || MENU.querySelector('.nc-gr-menu-val input') || MENU.querySelector('button');
    if (f1) f1.focus({ preventScroll: true });
  }
  /* ordenar numa direção certa (o menu): o clique no título alterna; aqui vai direto */
  function ordenarPara(G, prop, dir) {
    var th = thDoGrid(G, prop);
    if (!th) return avisar('Esta coluna não pode ser ordenada.', true);
    try { G.g.view$.grid('instance')._sortChange($.Event('click'), $(th), dir); } catch (e) { return avisar('Não foi possível ordenar.', true); }
    buscarDados(G);
  }
  /* a célula de título do grid daquela coluna: pelo data-idx (a posição dela na lista interna do
     grid). Pelo texto não dá: "Médico" também é o começo de "Médico Origem", e depois de ordenada a
     célula ganha o texto do indicador de ordem */
  function thDoGrid(G, prop) {
    try {
      var cols = G.g.view$.grid('instance').columns || [], i = cols.map(function (c) { return c.property; }).indexOf(prop);
      var col = cols[i]; if (i < 0 || !col || col.canSort === false) return null;
      return G.g.view$[0].querySelector('.a-GV-header[data-idx="' + i + '"]');
    } catch (e) { return null; }
  }
  /* arrastar o título para outra posição (um toque sem arrastar = ordenar) */
  function ligarMover(G) {
    var m = null;
    G.caixa.addEventListener('pointerdown', function (e) {
      var b = e.target.closest('[data-gr-ordem]'); if (!b || e.button !== 0 || window.innerWidth <= 760) return;
      m = { prop: b.getAttribute('data-gr-ordem'), x0: e.clientX, b: b, ativo: false, id: e.pointerId };
    });
    G.caixa.addEventListener('pointermove', function (e) {
      if (!m) return;
      if (!m.ativo) {
        if (Math.abs(e.clientX - m.x0) < 8) return;
        m.ativo = true; m.b.setPointerCapture(m.id);
        m.th = m.b.closest('.nc-gr-thc'); m.th.classList.add('is-arrastada');
        m.linha = el('span', 'nc-gr-solta'); G.caixa.querySelector('.nc-gr-tab').appendChild(m.linha);
        G.caixa.classList.add('is-movendo');
      }
      /* onde soltar: antes da coluna cujo meio está à direita do ponteiro */
      var ths = [].slice.call(G.caixa.querySelectorAll('.nc-gr-cab .nc-gr-thc[data-gr-col]')), tab = G.caixa.querySelector('.nc-gr-tab'), rt = tab.getBoundingClientRect();
      var k = ths.length, x = 0;
      for (var j = 0; j < ths.length; j++) { var r = ths[j].getBoundingClientRect(); if (e.clientX < r.left + r.width / 2) { k = j; x = r.left; break; } x = r.right; }
      m.k = k;
      m.linha.style.left = Math.round(x - rt.left + tab.scrollLeft - 1) + 'px';
      m.linha.style.height = tab.scrollHeight + 'px';
    });
    var fim = function () {
      if (!m) return;
      var a = m; m = null;
      if (!a.ativo) return;
      G.arrastouEm = Date.now();
      a.th.classList.remove('is-arrastada'); a.linha.remove(); G.caixa.classList.remove('is-movendo');
      var vis = (G.vis || []).map(function (x) { return x.c.p; }), de = vis.indexOf(a.prop), para = a.k > de ? a.k - 1 : a.k;
      moverColuna(G, a.prop, para);
    };
    G.caixa.addEventListener('pointerup', fim);
    G.caixa.addEventListener('pointercancel', fim);
  }
  function chave(G) { return (document.getElementById('pFlowId') || {}).value + ':' + (document.getElementById('pFlowStepId') || {}).value + ':' + G.reg.id; }
  function modo(G, m, foco) {
    G.modo = m;
    guardar('modo-' + chave(G), m === 'tabela' ? 'tabela' : '');
    G.reg.classList.toggle('nc-gr-on', m !== 'tabela');
    G.reg.classList.toggle('nc-gr-tabela', m === 'tabela');
    [].forEach.call(G.vistas.querySelectorAll('[data-gr-vista]'), function (x) { x.setAttribute('aria-pressed', String(x.getAttribute('data-gr-vista') === (m === 'tabela' ? 'tabela' : 'lista'))); });
    /* 08/10: a chave Lista | Tabela fica SEMPRE NO MESMO LUGAR nos dois modos (controle que muda de
       lugar faz o próximo clique errar): no CABEÇALHO DA REGIÃO, à direita do título — onde a barra
       "grudada" do grid (z-index 308) nunca a cobre. Sem cabeçalho visível: último item da barra da
       lista, no canto de cima à direita, que no modo Tabela continua à vista só com ela. */
    posicionarChave(G);
    if (m === 'tabela') {
      /* o grid estava fora da tela: as colunas e a barra presa dele foram calculadas lá. Recalcula
         tudo depois que ele volta (o mesmo aviso que o APEX dá quando a janela muda de tamanho) */
      requestAnimationFrame(function () {
        /* rolagem lateral que ficou de quando o grid estava fora da tela (a 1ª coluna sumia) */
        [].forEach.call(G.reg.querySelectorAll('.a-GV-w-scroll, .a-GV-w-hdr'), function (x) { x.scrollLeft = 0; });
        semEsticar(G);
        try { G.g.view$.grid('refreshColumns'); G.g.view$.grid('resize'); } catch (e) { /* ok */ }
        try { G.w.interactiveGrid('resize'); } catch (e) { /* ok */ }
        $(window).trigger('apexwindowresized');
        try { window.dispatchEvent(new Event('resize')); } catch (e) { /* ok */ }
      });
    } else desenhar(G);
    if (foco) { var b = G.vistas.querySelector('[data-gr-vista="' + (m === 'tabela' ? 'tabela' : 'lista') + '"]'); if (b) b.focus({ preventScroll: true }); }
  }

  /* o cabeçalho gruda logo abaixo do que já fica fixo no alto da página (cabeçalho do APEX, faixa
     do colaborador…): mede o que está fixo/grudado no topo */
  function medirTopo(G) {
    var h = 0;
    [].forEach.call(document.body.querySelectorAll('body > *, .t-Header, .t-Body-title, [class*="cab-fixo"], [class*="-fixo"]'), function (x) {
      if (x.closest('.nc-gr, .nc-gr-gaveta')) return;
      var cs = getComputedStyle(x); if (!/fixed|sticky/.test(cs.position)) return;
      var r = x.getBoundingClientRect(); if (r.top <= 1 && r.bottom > 0 && r.bottom < window.innerHeight / 2 && r.width > window.innerWidth / 2) h = Math.max(h, r.bottom);
    });
    G.caixa.style.setProperty('--gr-topo', Math.round(h) + 'px');
  }

  /* ---------- os dados: total, carregar mais, buscar, ordenar ---------- */
  function totalServidor(G) { try { var t = G.m.getServerTotalRecords(); return t >= 0 ? t : null; } catch (e) { return null; } }
  function carregados(G) { var n = 0; try { n = G.m.getTotalRecords(true); } catch (e) { G.m.forEach(function () { n++; }); } return n; }
  function haMais(G) {
    var t = totalServidor(G), n = carregados(G);
    if (t != null) return n < t;
    /* grid sem "total de linhas": se o último bloco veio cheio, pode haver mais */
    var pag = 0; try { pag = G.m.getOption('pageSize') || 0; } catch (e) { /* ok */ }
    return !G.semMais && pag > 0 && n > 0 && n % pag === 0;
  }
  function carregarMais(G) {
    if (G.buscando || G.modo === 'tabela' || !haMais(G)) return;
    G.buscando = true; desenharRodape(G);
    var antes = carregados(G);
    var fim = function () { G.buscando = false; if (carregados(G) <= antes) G.semMais = true; desenhar(G); };
    try { var r = G.m.fetch(carregados(G)); if (r && r.then) r.then(fim, fim); else setTimeout(fim, 1500); } catch (e) { fim(); }
  }
  /* depois de ordenar/buscar o grid guarda a escolha mas, fora da tela, não busca: pede o 1º bloco */
  function buscarDados(G) {
    G.buscando = true; G.semMais = false; desenhar(G);
    var feito = false, ir = function () {
      if (feito) return; feito = true;
      /* sempre do zero: o grid fora da tela às vezes já buscou, às vezes não (ex.: busca apagada) */
      try { G.m.clearData(); var r = G.m.fetch(0); if (r && r.then) return r.then(function () { G.buscando = false; desenhar(G); }, function () { G.buscando = false; desenhar(G); }); } catch (e) { /* ok */ }
      G.buscando = false; desenhar(G);
    };
    $(document).one('ajaxStop', function () { setTimeout(ir, 60); });
    setTimeout(ir, 4000);
  }
  function campoBuscaIg(G) { return G.reg.querySelector('[id$="_ig_toolbar_search_field"]') || G.reg.querySelector('.a-IG-header input[type="text"], .a-IG-header input[type="search"]'); }
  /* CUIDADO: a busca do grid vira um FILTRO guardado no relatório ("Procurar 'HEMO'", com o botão
     "Remover Filtro") e buscar texto vazio NÃO o tira. Então a busca da lista tira o filtro da busca
     anterior (pelo texto entre aspas) antes de pôr o novo — e "limpar" só tira. */
  function tirarFiltroBusca(G, texto) {
    if (!texto) return 0;
    var alvo = "'" + texto + "'", n = 0;
    [].forEach.call(G.reg.querySelectorAll('.a-IG-controls-item--filter'), function (it) {
      var rot = limpo((it.querySelector('.a-IG-controlsLabel') || it).textContent);
      var bt = it.querySelector('.a-IG-button--remove');
      if (bt && rot.slice(-alvo.length) === alvo) { bt.click(); n++; }
    });
    return n;
  }
  function buscar(G, q) {
    q = String(q || '').trim();
    if (q === G.busca) return;
    var antes = G.busca;
    G.busca = q;
    var f = campoBuscaIg(G);
    if (f) {
      tirarFiltroBusca(G, antes);
      if (q) { f.value = q; try { G.acoes.invoke('search'); } catch (e) { /* ok */ } f.value = ''; }
      buscarDados(G);
    } else desenhar(G);                                          /* sem busca do grid: filtra o que carregou */
  }
  function ordemDe(G) {
    var o = {}; try { G.g.view$.grid('getColumns').forEach(function (c) { if (c.sortIndex && (c.sortDirection === 'asc' || c.sortDirection === 'desc')) o[c.property] = c.sortDirection; }); } catch (e) { /* ok */ }
    return o;
  }
  /* ordena como o menu da coluna do próprio grid: mesma direção de novo = tira a ordem */
  function ordenar(G, prop) {
    var g = G.g, th = thDoGrid(G, prop), atual = ordemDe(G)[prop];
    if (!th) return avisar('Esta coluna não pode ser ordenada.', true);
    var dir = !atual ? 'asc' : atual === 'asc' ? 'desc' : atual;   /* 3º toque: a mesma direção = limpar */
    try { g.view$.grid('instance')._sortChange($.Event('click'), $(th), dir); } catch (e) { return avisar('Não foi possível ordenar.', true); }
    buscarDados(G);
  }

  /* ---------- quantas colunas cabem, e com qual largura ---------- */
  /* TODAS as colunas (como no modo Tabela), cada uma com a SUA largura em px: a do grid, ou a que a
     pessoa escolheu. Mudar uma não muda as outras — a tabela fica mais larga e rola para o lado. */
  function caber(G, cols) {
    G.larguras = G.larguras || {};
    return cols.map(function (c, i) {
      var minimo = Math.max(110, Math.min(Math.ceil(c.h.length * 7.4) + 78, 250));   /* o nome inteiro + o botão de opções */
      var w = i === 0 ? Math.max(200, c.w || 220) : Math.max(minimo, c.w || 140);
      if (G.larguras[c.p]) w = G.larguras[c.p];
      return { c: c, w: w };
    });
  }
  function molde(G) {
    return (G.vis || []).map(function (x) { return Math.round(G.larguras[x.c.p] || x.w) + 'px'; }).join(' ') + ' 40px';
  }
  function desenhar(G) {
    if (G.morto) return;
    posicionarChave(G);
    if (!G.caixa || G.modo === 'tabela') return;
    var todas = colunas(G), vis = caber(G, todas);
    /* cada coluna nunca fica menor que a largura calculada (as que não cabem vão para "+N na ficha") */
    G.vis = vis;
    G.caixa.style.setProperty('--gr-tpl', molde(G));
    var ordem = ordemDe(G), leitura = !G.m.getOption('editable');
    var temBuscaIg = !!campoBuscaIg(G), q = semAcento(G.busca);
    var regs = registros(G);
    if (!temBuscaIg && q) regs = regs.filter(function (r) { return todas.some(function (c) { return semAcento(valor(G, r.rec, c.p)).indexOf(q) >= 0; }); });
    var loc = G.filtroLocal || {}, nLoc = null;
    Object.keys(loc).forEach(function (p) { var ok = {}; loc[p].forEach(function (v) { ok[v] = 1; }); regs = regs.filter(function (r) { return ok[valor(G, r.rec, p)]; }); });
    if (Object.keys(loc).length) nLoc = regs.length;
    var tot = totalServidor(G), n = carregados(G);
    /* cabeçalho */
    /* congeladas: as N primeiras ficam presas à esquerda (left = soma das larguras anteriores) */
    var cong = Math.min(G.cong == null ? 1 : G.cong, vis.length), esq = 0;
    vis.forEach(function (x, i) { x.left = i < cong ? esq : null; if (i < cong) esq += Math.round(G.larguras[x.c.p] || x.w); });
    var filtrosCol = filtrosDeColuna(G);
    G.caixa.querySelector('.nc-gr-cab').innerHTML = vis.map(function (x, i) {
      var o = ordem[x.c.p], fl = filtrosCol[x.c.p];
      return '<div class="nc-gr-thc' + (x.left != null ? ' is-cong' + (i === cong - 1 ? ' is-cong-fim' : '') : '') + (fl ? ' is-filtro' : '') + '" role="columnheader" data-gr-col="' + esc(x.c.p) + '" aria-sort="' + (o === 'asc' ? 'ascending' : o === 'desc' ? 'descending' : 'none') + '"' + (x.left != null ? ' style="left:' + x.left + 'px"' : '') + '>' +
        '<button type="button" class="nc-gr-th' + (o ? ' is-ordem' : '') + (x.c.sort ? '' : ' is-sem-ordem') + '" data-gr-ordem="' + esc(x.c.p) + '" title="' + (x.c.sort ? 'Ordenar por ' + esc(x.c.h) + ' · arraste' : 'Arraste') + ' para mudar a posição">' +
        '<span>' + esc(x.c.h) + '</span>' + (x.c.sort ? ic(o === 'desc' ? 'baixo' : o === 'asc' ? 'cima' : 'ordem') : '') + '</button>' +
        '<button type="button" class="nc-gr-thm' + (fl || x.left != null && i > 0 ? ' is-vivo' : '') + '" data-gr-menu="' + esc(x.c.p) + '" aria-haspopup="dialog" aria-label="Opções da coluna ' + esc(x.c.h) + '" title="Filtrar, congelar, mover">' + ic(fl ? 'funil' : 'menu') + '</button>' +
        '<span class="nc-gr-arrasta" role="separator" aria-orientation="vertical" tabindex="0" data-gr-larg="' + esc(x.c.p) + '" title="Arraste para mudar a largura · dois cliques ajustam ao conteúdo" aria-label="Largura da coluna ' + esc(x.c.h) + '"></span></div>';
    }).join('') + '<span class="nc-gr-thc nc-gr-thc--fim" aria-hidden="true"></span>';
    /* contagem */
    var nVe = nLoc != null ? nLoc : tot != null ? tot : n;
    G.caixa.querySelector('.nc-gr-conta').innerHTML = '<b>' + nVe.toLocaleString('pt-BR') + '</b> ' + (nVe === 1 ? 'registro' : 'registros') +
      (nLoc != null && haMais(G) ? ' <span class="nc-gr-tag">dos ' + n.toLocaleString('pt-BR') + ' carregados</span>' : '') +
      (G.busca ? ' <span class="nc-gr-tag nc-gr-tag--busca">com “' + esc(G.busca) + '”</span>' : '') + (leitura ? ' <span class="nc-gr-tag">só consulta</span>' : '');
    G.caixa.querySelector('[data-gr-novo]').hidden = !pode(G, 'novo');
    var chips = G.caixa.querySelector('.nc-gr-chips'), lst = Object.keys(filtrosCol);
    chips.hidden = !lst.length;
    chips.innerHTML = lst.map(function (p) {
      var f = filtrosCol[p], col = todas.filter(function (c) { return c.p === p; })[0];
      return '<span class="nc-gr-chip">' + ic('funil') + '<span><b>' + esc(col ? col.h : p) + ':</b> ' + esc(f.valores.join(', ')) + '</span>' +
        '<button type="button" data-gr-tira-filtro="' + esc(f.id) + '" aria-label="Tirar o filtro de ' + esc(col ? col.h : p) + '">' + ic('fechar') + '</button></span>';
    }).join('') + (lst.length > 1 ? '<button type="button" class="nc-gr-link" data-gr-tira-filtros>Tirar todos</button>' : '');
    /* linhas */
    var html = regs.map(function (r) {
      var md = r.md, mudou = md.updated || md.inserted, aberto = ED && ED.G === G && ED.id === r.id;
      var t = valor(G, r.rec, vis[0].c.p);
      return '<li class="nc-gr-l' + (mudou ? ' is-mudou' : '') + (aberto ? ' is-aberto' : '') + '" role="row" data-gr-id="' + esc(r.id) + '" tabindex="0"' + (aberto ? ' aria-current="true"' : '') +
        ' aria-label="' + esc((leitura ? 'Ver ' : 'Abrir ') + (t || 'registro')) + '">' +
        vis.map(function (x, i) {
          var v = valor(G, r.rec, x.c.p);
          return '<span role="cell" class="nc-gr-td' + (i === 0 ? ' nc-gr-td--tit' : '') + (x.left != null ? ' is-cong' + (i === cong - 1 ? ' is-cong-fim' : '') : '') + '" data-h="' + esc(x.c.h) + '" data-p="' + esc(x.c.p) + '"' + (x.left != null ? ' style="left:' + x.left + 'px"' : '') + (v.length > 18 ? ' title="' + esc(v) + '"' : '') + '><span class="nc-gr-tx">' + celulaHtml(v) + '</span>' +
            (i === 0 && md.inserted ? ' <em class="nc-gr-tag nc-gr-tag--novo">novo</em>' : i === 0 && md.updated ? ' <em class="nc-gr-tag nc-gr-tag--novo">alterado</em>' : '') + '</span>';
        }).join('') + '<span class="nc-gr-seta" aria-hidden="true">' + ic(leitura ? 'olho' : 'dir') + '</span></li>';
    }).join('');
    var lista = G.caixa.querySelector('.nc-gr-lista');
    if (html) lista.innerHTML = html;
    else if (G.buscando) lista.innerHTML = esqueleto(vis.length, 6);
    else lista.innerHTML = '<li class="nc-gr-vazio">' + ic('vazio') + '<p>' + (G.busca ? 'Nada encontrado com <b>' + esc(G.busca) + '</b>.' : 'Nenhum registro em <b>' + esc(titulo(G)) + '</b> ainda.') + '</p>' +
      (G.busca ? '<button type="button" class="nc-gr-bt" data-gr-limpa>Limpar a busca</button>' : pode(G, 'novo') ? '<button type="button" class="nc-gr-bt nc-gr-bt--forte" data-gr-novo>' + ic('mais') + '<span>Adicionar o primeiro</span></button>' : '') + '</li>';
    desenharRodape(G);
  }
  function esqueleto(cols, linhas) {
    var s = ''; for (var i = 0; i < linhas; i++) { s += '<li class="nc-gr-l nc-gr-l--esq" aria-hidden="true">'; for (var k = 0; k < cols; k++) s += '<span class="nc-gr-td"><i></i></span>'; s += '<span></span></li>'; }
    return s;
  }
  function desenharRodape(G) {
    var p = G.caixa.querySelector('.nc-gr-mais'), tot = totalServidor(G), n = carregados(G), mais = haMais(G);
    var lista = G.caixa.querySelector('.nc-gr-lista');
    var esq = lista.querySelector('.nc-gr-l--esq.is-fim'); if (esq) esq.remove();
    if (G.buscando && n) lista.insertAdjacentHTML('beforeend', esqueleto(Math.max(1, (G.caixa.querySelector('.nc-gr-cab').children.length - 1)), 3).replace(/nc-gr-l--esq/g, 'nc-gr-l--esq is-fim'));
    p.innerHTML = !n ? '' : (tot != null && tot > n ? 'Mostrando <b>' + n.toLocaleString('pt-BR') + '</b> de ' + tot.toLocaleString('pt-BR') + (G.buscando ? ' · carregando…' : ' · <button type="button" class="nc-gr-link" data-gr-carregar>carregar mais</button>') : (n > 12 ? 'Todos os ' + n.toLocaleString('pt-BR') + ' registros' : ''));
    G.caixa.classList.toggle('is-buscando', !!G.buscando);
    if (G.larguras && Object.keys(G.larguras).length) p.innerHTML += (p.innerHTML ? ' · ' : '') + '<button type="button" class="nc-gr-link" data-gr-larg-volta>Larguras originais</button>';
    void mais;
  }

  /* ═══ [G5] A GAVETA ═════════════════════════════════════════════════════════════════════
     O QUE FAZ  A região do grid MUDA para dentro da gaveta enquanto ela está aberta (a vista de
                um registro mora dentro do grid) e volta para o lugar ao fechar. A vista mostra o
                registro da CÉLULA ATIVA: gotoCell + conferir + next/previous-record.
     CUIDADO    • linha NOVA cancelada sai com deleteRecords (revertRecords não a tira no 19.2);
                • "interactivegridsave" acontece também na FALHA: sucesso = status ok E nada
                  pendente no modelo;
                • antes de salvar, espera as chamadas das ações dinâmicas do último campo mexido.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var GAV = null, ED = null;
  function montarGaveta() {
    if (GAV) return;
    GAV = { fundo: el('div', 'nc-gr-fundo'), caixa: el('aside', 'nc-gr-gaveta') };
    GAV.caixa.setAttribute('role', 'dialog'); GAV.caixa.setAttribute('aria-modal', 'true'); GAV.caixa.setAttribute('aria-labelledby', 'nc-gr-gtit'); GAV.caixa.tabIndex = -1;
    GAV.cab = el('header', 'nc-gr-gcab'); GAV.corpo = el('div', 'nc-gr-gcorpo'); GAV.pe = el('footer', 'nc-gr-gpe');
    GAV.caixa.appendChild(GAV.cab); GAV.caixa.appendChild(GAV.corpo); GAV.caixa.appendChild(GAV.pe);
    document.body.appendChild(GAV.fundo); document.body.appendChild(GAV.caixa);
    GAV.fundo.addEventListener('click', fecharComCuidado);
    GAV.caixa.addEventListener('click', function (e) {
      if (e.target.closest('[data-g-fechar]')) fecharComCuidado();
      else if (e.target.closest('[data-g-cancelar]')) fechar(true);
      else if (e.target.closest('[data-g-salvar]')) salvar();
      else if (e.target.closest('[data-g-excluir]')) excluir();
      else if (e.target.closest('[data-g-anda]')) andar(+e.target.closest('[data-g-anda]').getAttribute('data-g-anda'));
    });
    /* com a gaveta aberta o Esc é dela (calendário, lista e avisos abertos ficam com o próprio Esc);
       Ctrl+S salva. Em captura: o Esc de uma janela do APEX fecharia a página inteira. */
    window.addEventListener('keydown', function (e) {
      if (!ED) return;
      if (e.key === 'Escape') {
        if ([].some.call(document.querySelectorAll('.ui-datepicker, .ui-dialog, #alertify, .a-PopupLOV-dialog'), function (d) { return d.offsetParent !== null && getComputedStyle(d).visibility !== 'hidden'; })) return;
        e.preventDefault(); e.stopImmediatePropagation(); fecharComCuidado();
      }
      if ((e.ctrlKey || e.metaKey) && (e.key === 's' || e.key === 'S') && ED.edita) { e.preventDefault(); e.stopImmediatePropagation(); salvar(); }
    }, true);
  }
  function ids(G) { var o = []; G.m.forEach(function (r, n, idForEach) { var id = null; try { id = G.m.getRecordId(r); } catch (e) { /* ok */ } o.push(String(id != null ? id : idForEach)); }); return o; }
  function atual(G) { try { var r = G.g.singleRowView$ && G.g.singleRowView$.recordView('getRecord'); return r ? rid(G, r) : null; } catch (e) { return null; } }
  function irPara(G, id) {
    try { var c = colunas(G)[0]; G.g.view$.grid('gotoCell', id, c ? c.p : undefined); } catch (e) { /* ok */ }
    var lista = ids(G), alvo = lista.indexOf(id);
    for (var i = 0; i < 400 && atual(G) !== id; i++) {
      var aqui = lista.indexOf(atual(G)); if (aqui < 0 || alvo < 0) break;
      try { ED.acoes.invoke(aqui < alvo ? 'next-record' : 'previous-record'); } catch (e) { break; }
    }
  }
  function abrir(G, id, volta) {
    if (ED) return;
    var novo = id == null, edita = novo ? pode(G, 'novo') : pode(G, 'editar', id);
    if (novo && !edita) return;
    montarGaveta();
    ED = { G: G, novo: novo, id: id, edita: edita, acoes: G.acoes, volta: volta, lugar: document.createComment('nc-grade') };
    /* 08/10: só o GRID (o elemento .a-IG, onde mora a vista de um registro) vai para a gaveta; a
       região fica no lugar com o título e a lista — antes ia a região inteira e a página ficava
       com um buraco onde estava o relatório */
    G.ig = G.w[0];
    G.ig.parentNode.insertBefore(ED.lugar, G.ig);
    GAV.corpo.appendChild(G.ig);
    G.ig.classList.add('nc-gr-motor');
    G.reg.classList.add('nc-gr-aberta');
    document.body.classList.add('nc-gr-editando');
    if (edita) { try { G.acoes.set('edit', true); } catch (e) { /* já em edição */ } }
    if (novo) {
      var antes = ids(G);
      try { G.acoes.invoke('selection-add-row'); } catch (e) { /* segue */ }
      ED.id = ids(G).filter(function (x) { return antes.indexOf(x) < 0; })[0];
      if (ED.id == null) { fechar(false); return; }
    }
    try { G.acoes.invoke('single-row-view'); } catch (e) { fechar(false); return; }
    irPara(G, ED.id);
    cabecalho();
    desenhar(G);
    abrirEspaco(G);
    GAV.caixa.classList.toggle('is-leitura', !edita);
    GAV.caixa.classList.add('is-aberta'); GAV.fundo.classList.add('is-aberta');
    GAV.corpo.scrollTop = 0;
    setTimeout(function () {
      var f = [].filter.call(GAV.corpo.querySelectorAll('.a-RV .u-Form input:not([type="hidden"]):not([readonly]):not([disabled]), .a-RV .u-Form select:not([disabled]), .a-RV .u-Form textarea:not([readonly])'), function (x) { return x.offsetParent !== null; })[0];
      (edita && f ? f : GAV.caixa).focus({ preventScroll: true });
    }, 120);
  }
  /* com a gaveta aberta a lista continua à vista: se a gaveta cobre o lado direito da região, a
     lista encolhe exatamente essa medida (a linha aberta fica inteira ao lado da gaveta) */
  function abrirEspaco(G) {
    var lista = G.caixa; if (!lista) return;
    lista.style.paddingRight = '';
    if (!ED || ED.G !== G || !GAV) return;
    var rg = lista.getBoundingClientRect(), gv = GAV.caixa.getBoundingClientRect();
    if (gv.width >= window.innerWidth - 40) return;                       /* celular: gaveta em tela cheia */
    var cobre = Math.round(rg.right - gv.left + 16);
    var base = lista.classList.contains('nc-gr--respiro') ? 16 : 0;
    if (cobre > 0 && rg.width - cobre >= 420) lista.style.paddingRight = (cobre + base) + 'px';
  }
  window.addEventListener('resize', function () { if (ED) abrirEspaco(ED.G); });

  function cabecalho() {
    var G = ED.G, cols = colunas(G), rec = null;
    try { rec = G.m.getRecord(ED.id); } catch (e) { /* ok */ }
    var t = ED.novo ? 'Novo registro' : (rec && cols[0] ? valor(G, rec, cols[0].p) : '') || 'Registro';
    var lista = registros(G).map(function (r) { return r.id; }), pos = lista.indexOf(ED.id);
    var mudou = false; try { mudou = G.m.isChanged(); } catch (e) { /* ok */ }
    var anda = !ED.novo && lista.length > 1;
    GAV.cab.innerHTML =
      '<div class="nc-gr-gtits"><p class="nc-gr-gsec">' + esc(titulo(G)) + (ED.edita ? '' : ' · consulta') + '</p><h2 id="nc-gr-gtit">' + esc(t) + '</h2>' +
        (anda ? '<p class="nc-gr-gpos">' + (pos + 1) + ' de ' + lista.length + '</p>' : '') + '</div>' +
      (anda ? '<div class="nc-gr-ganda"><button type="button" class="nc-gr-bt nc-gr-bt--icone" data-g-anda="-1" aria-label="Registro anterior"' + (pos <= 0 || mudou ? ' disabled' : '') + '>' + ic('esq') + '</button>' +
        '<button type="button" class="nc-gr-bt nc-gr-bt--icone" data-g-anda="1" aria-label="Próximo registro"' + (pos >= lista.length - 1 || mudou ? ' disabled' : '') + '>' + ic('dir') + '</button></div>' : '') +
      '<button type="button" class="nc-gr-bt nc-gr-bt--icone" data-g-fechar aria-label="Fechar">' + ic('fechar') + '</button>';
    GAV.pe.innerHTML = ED.edita
      ? (!ED.novo && pode(G, 'excluir', ED.id) ? '<button type="button" class="nc-gr-bt nc-gr-bt--perigo" data-g-excluir>' + ic('lixo') + '<span>Excluir</span></button>' : '') +
        '<span class="nc-gr-espaco"></span><button type="button" class="nc-gr-bt" data-g-cancelar>Cancelar</button>' +
        '<button type="button" class="nc-gr-bt nc-gr-bt--forte" data-g-salvar>' + ic('check') + '<span>' + (ED.novo ? 'Adicionar' : 'Salvar') + '</span></button>'
      : '<span class="nc-gr-espaco"></span><button type="button" class="nc-gr-bt" data-g-cancelar>Fechar</button>';
  }
  function andar(d) {
    if (!ED) return;
    var lista = registros(ED.G).map(function (r) { return r.id; }), i = lista.indexOf(ED.id) + d;
    if (i >= 0 && i < lista.length) irParaRegistro(lista[i]);
  }
  /* troca o registro da gaveta (‹ › ou clique noutra linha da lista, que continua à vista) */
  function irParaRegistro(id) {
    if (!ED || ED.ocupado || id === ED.id) return;
    var G = ED.G, mudou = false; try { mudou = G.m.isChanged(); } catch (e) { /* ok */ }
    if (mudou) return avisar('Salve ou cancele antes de ir para outro registro.', true);
    ED.id = id;
    ED.edita = pode(G, 'editar', ED.id);
    if (ED.edita) { try { G.acoes.set('edit', true); } catch (e) { /* ok */ } }
    irPara(G, ED.id);
    cabecalho();
    desenhar(G);
    GAV.caixa.classList.toggle('is-leitura', !ED.edita);
    GAV.corpo.scrollTop = 0;
    var li = G.caixa.querySelector('[data-gr-id="' + ED.id + '"]');
    if (li && li.scrollIntoView) li.scrollIntoView({ block: 'nearest' });
  }
  function fecharComCuidado() {
    if (!ED || ED.ocupado) return;
    var mudou = false; try { mudou = ED.G.m.isChanged(); } catch (e) { /* ok */ }
    if (!mudou) return fechar(true);
    apex.message.confirm('Sair sem salvar? O que foi preenchido será descartado.', function (ok) { if (ok) fechar(true); });
  }
  function fechar(desfazer) {
    if (!ED) return;
    var e = ED, G = e.G, m = G.m;
    if (desfazer) {
      try {
        var r = m.getRecord(e.id), md = r && meta(G, e.id);
        if (r) { if (md && md.inserted) m.deleteRecords([r]); else m.revertRecords([r]); }
      } catch (x) { /* ok */ }
    }
    try { e.acoes.invoke('close-single-row-view'); } catch (x) { /* ok */ }
    try { if (!m.isChanged()) e.acoes.set('edit', false); } catch (x) { /* ok */ }
    G.ig.classList.remove('nc-gr-motor');
    G.reg.classList.remove('nc-gr-aberta');
    if (e.lugar.parentNode) { e.lugar.parentNode.insertBefore(G.ig, e.lugar); e.lugar.parentNode.removeChild(e.lugar); }
    document.body.classList.remove('nc-gr-editando');
    GAV.caixa.classList.remove('is-aberta', 'is-ocupada'); GAV.fundo.classList.remove('is-aberta');
    ED = null;
    if (G.caixa) G.caixa.style.paddingRight = '';
    try { G.g.view$.grid('resize'); } catch (x) { /* ok */ }
    desenhar(G);
    var alvo = e.volta && document.body.contains(e.volta) ? e.volta : G.caixa && G.caixa.querySelector('[data-gr-id="' + (e.id || '') + '"]');
    if (alvo && alvo.focus) alvo.focus({ preventScroll: true });
  }
  function ocupado(sim) {
    GAV.caixa.classList.toggle('is-ocupada', sim);
    [].forEach.call(GAV.pe.querySelectorAll('button'), function (b) { b.disabled = sim; });
    var s = GAV.pe.querySelector('[data-g-salvar] span'); if (s) s.textContent = sim ? 'Salvando…' : (ED && ED.novo ? 'Adicionar' : 'Salvar');
  }
  function salvar(oQue) {
    if (!ED || ED.ocupado || !ED.edita) return;
    /* as ações dinâmicas do último campo mexido rodam ao sair dele (o clique no Salvar): espera
       as chamadas voltarem (até 6 s), senão o valor que elas trazem fica de fora */
    if ($.active > 0 && (!ED.espera || Date.now() - ED.espera < 6000)) {
      var e0 = ED; if (!e0.espera) e0.espera = Date.now();
      return setTimeout(function () { if (ED === e0) salvar(oQue); }, 80);
    }
    ED.espera = 0;
    var e = ED, m = e.G.m;
    if (!m.isChanged()) return fechar(false);
    e.ocupado = true; e.oQue = oQue || (e.novo ? 'novo' : 'salvo'); ocupado(true);
    try { e.acoes.invoke('save'); } catch (x) { e.ocupado = false; ocupado(false); return avisar('Não foi possível salvar. Tente de novo.', true); }
    /* o grid barrou antes de ir ao servidor (obrigatório/inválido, já marcado no campo) */
    setTimeout(function () {
      if (ED !== e || !e.ocupado || $.active > 0 || !m.isChanged()) return;
      e.ocupado = false; ocupado(false);
      avisar('Falta preencher ou corrigir os campos marcados em vermelho.', true);
      var errado = GAV.corpo.querySelector('.a-RV .is-error');
      if (errado) errado.scrollIntoView({ block: 'center', behavior: 'smooth' });
    }, 450);
  }
  function excluir() {
    if (!ED || ED.ocupado) return;
    var e = ED;
    apex.message.confirm('Excluir este registro? Depois de salvo, não dá para desfazer.', function (ok) {
      if (!ok || ED !== e) return;
      try { e.G.m.deleteRecords([e.G.m.getRecord(e.id)]); } catch (x) { return avisar('Não foi possível excluir.', true); }
      salvar('excluido');
    });
  }
  function aoSalvar(G, data) {
    if (!ED || ED.G !== G || !ED.ocupado) return;
    var e = ED, ok = (!data || data.status === undefined || data.status === 'success') && !G.m.isChanged();
    e.ocupado = false; ocupado(false);
    if (!ok) return avisar('Não foi possível salvar. Confira a mensagem e tente de novo.', true);
    avisar({ novo: 'Registro adicionado', salvo: 'Registro salvo', excluido: 'Registro excluído' }[e.oQue] || 'Salvo');
    fechar(false);
    /* busca de novo: o servidor completa campos ao gravar */
    setTimeout(function () { try { apex.region(G.reg.id).refresh(); } catch (x) { /* ok */ } }, 50);
  }

  var toast = null, tAviso = null;
  function avisar(t, erro) {
    if (!toast) { toast = el('div', 'nc-gr-aviso'); toast.setAttribute('role', 'status'); toast.setAttribute('aria-live', 'polite'); document.body.appendChild(toast); }
    toast.innerHTML = (erro ? '' : ic('check')) + '<span>' + esc(t) + '</span>';
    toast.classList.toggle('is-erro', !!erro); toast.classList.add('is-visivel');
    clearTimeout(tAviso); tAviso = setTimeout(function () { toast.classList.remove('is-visivel'); }, 4000);
  }

  /* ═══ [G6] O MAESTRO ════════════════════════════════════════════════════════════════════
     Liga em cada grid que entra ([G2]) e redesenha a lista quando o grid muda (dados novos,
     registro alterado, região atualizada). Grid que aparece depois (região escondida que abre,
     aba) é pego no próximo apexafterrefresh / a cada mudança de tamanho.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function ligar() {
    [].forEach.call(document.querySelectorAll('.a-IG'), function (ig) {
      var reg = document.getElementById(ig.id.replace(/_ig$/, ''));
      if (!reg || reg.__ncGr || !entra(reg)) return;
      var G = ler(reg); if (!G) return;
      reg.__ncGr = G; GRADES.push(G);
      montarLista(G);
      modo(G, lembrar('modo-' + chave(G)) === 'tabela' ? 'tabela' : 'lista');
      var t = null, refaz = function () { clearTimeout(t); t = setTimeout(function () { desenhar(G); if (ED && ED.G === G) cabecalho(); }, 60); };
      try { G.sub = G.m.subscribe({ onChange: refaz }); } catch (e) { /* ok */ }
      $(reg).on('apexafterrefresh.ncgr interactivegridviewmodelcreate.ncgr', function () {
        try { var g2 = G.w.interactiveGrid('getViews', 'grid'); if (g2 && g2.model !== G.m) { G.g = g2; G.m = g2.model; G.sub = G.m.subscribe({ onChange: refaz }); } } catch (e) { /* ok */ }
        refaz();
      });
      $(G.w).on('interactivegridsave.ncgr', function (ev, data) { aoSalvar(G, data); });   /* no grid: ele vai junto para a gaveta */
    });
    if (GRADES.length) document.body.classList.add('nc-gr-ativo');
  }
  /* erro do servidor (validação da página): a gaveta destrava e fica aberta com a mensagem */
  $(document).on('apexerror', function () { if (ED && ED.ocupado) { ED.ocupado = false; ocupado(false); } });
  $(document).on('apexafterrefresh', function () { setTimeout(ligar, 30); });
  /* a largura muda quantas colunas cabem; a altura do que é fixo no alto muda onde o cabeçalho gruda */
  var tRes = null;
  window.addEventListener('resize', function () { clearTimeout(tRes); tRes = setTimeout(function () { GRADES.forEach(function (G) { medirTopo(G); desenhar(G); }); }, 150); });

  /* para teste: desliga tudo e devolve os grids como estavam */
  window.__ncGradeDesligar = function () {
    fecharMenuCol();
    if (ED) fechar(true);
    GRADES.forEach(function (G) {
      /* a inscrição no modelo continuava chamando desenhar(G), que recolocava a chave no cabeçalho:
         cada script carregado de novo deixava mais um par de botões (08/10) */
      G.morto = true; try { G.m.unSubscribe(G.sub); } catch (e) { /* ok */ }
      $(G.reg).off('.ncgr'); $(G.w).off('.ncgr');
      if (G.obs) G.obs.disconnect(); if (G.ro) G.ro.disconnect(); if (G.ctl) G.ctl.remove(); if (G.caixa) G.caixa.remove();
      G.reg.classList.remove('nc-gr-on', 'nc-gr-tabela', 'nc-gr-aberta', 'nc-gr-chave-no-cab'); delete G.reg.__ncGr;
      try { G.g.view$.grid('resize'); } catch (e) { /* ok */ }
    });
    GRADES.length = 0;
    if (GAV) { GAV.caixa.remove(); GAV.fundo.remove(); GAV = null; }
    document.body.classList.remove('nc-gr-ativo', 'nc-gr-editando');
    window.__ncGrade = false;
  };

  /* ═══ [G7] ESPALHAR PARA AS JANELAS E IFRAMES DAS OUTRAS APLICAÇÕES ══════════════════════
     O Natcorp_Temas.js (casca, app 200) traz este arquivo; as outras aplicações e as janelas
     modais são iframes. Igual ao Natcorp_Registros.js [R7]: entra em cada iframe do MESMO endereço
     que tenha APEX, e a cópia de lá faz o mesmo com os iframes dela.
     CUIDADO  Não carrega duas vezes: cada janela guarda window.__ncGrade.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function porNoIframe(f) {
    try {
      var w = f.contentWindow, d = f.contentDocument;
      if (!w || !d || w.__ncGrade || !w.apex || !d.head || !EU) return;
      if (d.querySelector('script[src*="Natcorp_Grade.js"]')) return;
      var sc = d.createElement('script');
      sc.src = EU;
      d.head.appendChild(sc);
    } catch (e) { /* iframe de outro endereço: não é nosso */ }
  }
  function vigiar(f) {
    if (f.__ncGrVigia) return;
    f.__ncGrVigia = true;
    f.addEventListener('load', function () { porNoIframe(f); });
    porNoIframe(f);
  }
  [].forEach.call(document.querySelectorAll('iframe'), vigiar);
  if (window.MutationObserver) {
    new MutationObserver(function (ms) {
      ms.forEach(function (m) {
        [].forEach.call(m.addedNodes, function (n) {
          if (n.nodeType !== 1) return;
          if (n.tagName === 'IFRAME') vigiar(n); else if (n.querySelector) [].forEach.call(n.querySelectorAll('iframe'), vigiar);
        });
      });
    }).observe(document.documentElement, { childList: true, subtree: true });
  }

  function iniciar() { try { ligar(); } catch (e) { if (window.console) console.warn('[Natcorp grade]', e); } }
  $(document).one('apexreadyend', function () { setTimeout(iniciar, 0); });
  if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  window.addEventListener('load', function () { setTimeout(iniciar, 300); });
})();
