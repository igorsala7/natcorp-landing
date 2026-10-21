/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · HISTÓRICO FINANCEIRO  —  filtros organizados + resumo da folha (JavaScript)    ║
   ║  App 200 · Página 21 (Histórico Financeiro)                                               ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: HISTFIN-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   1. OS FILTROS (coluna da esquerda): os campos ORIGINAIS reunidos por assunto —
        Quando · O que somar · De quem · Quais verbas · Mais opções
      As 10 listas "Sim / Não" das origens viram botões de marcar; as faixas inicial/final ficam
      num bloco "De / Até"; no pé, o resumo do que vai ser pesquisado e o Pesquisar (o MESMO botão,
      com a mesma ação dinâmica). Mudou um filtro? O pé avisa até o Pesquisar.
   2. O RESUMO DA FOLHA (acima da tabela): Ganhos · Descontos · Líquido · Horas extras · Saldo
      negativo; aberto: mês a mês, o que mais mudou, para onde vai o dinheiro, descontos, centros
      de custo, tipo de cálculo, horas extras, faltas e encargos da empresa. Nasce COMPACTO: a
      tabela é a função principal da página.
   Os números vêm do servidor (NC_HISTFIN_INDICADORES) com os filtros da ÚLTIMA pesquisa (a mesma
   que a tabela mostra) e só com o valor de quem o usuário pode ver (a regra da coluna Valor).

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 21 › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_HistFin.js
     Página 21 › CSS › File URLs:         #WORKSPACE_IMAGES#Natcorp_HistFin.css
     Página 21 › Processing › Ajax Callback NC_HISTFIN_INDICADORES   (aplicar-histfin-pagina21.py)
   O COMBINADO com a página: filtros na região "PARAMETROS", relatório "HST", totais "TOTAIS".

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [F1] Os grupos de filtros ............ quem vai em qual grupo, nomes e dicas     PODE MEXER
     [F2] Montar os filtros ............... grupos, faixas, botões de marcar, o pé
     [J1] Textos e ferramentas do resumo .. frases, ícones                            PODE MEXER
     [J2] Os dados ........................ chamada ao servidor                        CUIDADO
     [J3] A moldura e a faixa de números
     [J4] A análise ....................... os quadros                                 PODE MEXER
     [J5] O começo
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncHistFin) return;
  window.__ncHistFin = true;
  var RID = 'HST';

  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html != null) e.innerHTML = html; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function valor(id) { return document.getElementById(id) ? (apex.item(id).getValue() || '') : ''; }
  function vazio(v) { return v == null || v === '' || (Array.isArray(v) && !v.length); }

  /* ═══ [F1] OS GRUPOS DE FILTROS ═════════════════════════════════════════════════════════
     PODE MEXER  Os nomes, as dicas e a ordem. CUIDADO: os ids são os itens da página.
     faixa = os dois campos inicial/final viram "De / Até" com o nome em cima.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ORIGENS = [
    ['P21_H_FINAN', 'Folha do mês atual'], ['P21_H_FINAN_ACM', 'Folha dos meses anteriores'],
    ['P21_H_FERIAS', 'Férias'], ['P21_H_13', '13º salário'], ['P21_H_RESC', 'Rescisão'], ['P21_H_RECALC', 'Recálculo de rescisão'],
    ['P21_H_ADIANT', 'Adiantamento'], ['P21_H_PART', 'Participação nos lucros'],
    ['P21_H_DIVERSOS', 'Diversos do mês atual'], ['P21_H_DIVERSOS_ACM', 'Diversos dos meses anteriores']
  ];
  var GRUPOS = [
    { k: 'quando', tit: 'Quando', fixo: true, dica: 'Escolha um ou mais meses. Com dois ou mais, o resumo compara um mês com o outro.',
      itens: ['P21_EMPRESA', 'P21_DATA_REF'] },
    { k: 'somar', tit: 'O que somar', fixo: true, origens: true,
      dica: 'Para ver a folha inteira de qualquer mês, deixe marcadas a do mês atual e a dos meses anteriores.' },
    { k: 'quem', tit: 'De quem', itens: [
      { faixa: 'Filial', de: 'P21_FILIAL_INI', ate: 'P21_FILIAL_FIM' },
      { faixa: 'Centro de custo', de: 'P21_CCUSTO_INI', ate: 'P21_CCUSTO_FIM' },
      { faixa: 'Matrícula', de: 'P21_MATRICULA_INI', ate: 'P21_MATRICULA_FIM' },
      'P21_SITUACOES', 'P21_VINCULOS', 'P21_SINDICATO',
      { faixa: 'Data de admissão', de: 'P21_DT_ADM_INI', ate: 'P21_DT_ADM_FIM', datas: true }] },
    { k: 'verbas', tit: 'Quais verbas', dica: 'Vazio = todas. Escolha o tipo para a lista de ocorrências ficar menor.',
      itens: ['P21_TIPO_RUBRICA', 'P21_COD_OCORR'] },
    { k: 'mais', tit: 'Mais opções', itens: [
      { faixa: 'Centro de custo contábil', de: 'P21_CCUSTO_CONT_INI', ate: 'P21_CCUSTO_CONT_FIM' },
      { faixa: 'Data de retenção', de: 'P21_DT_RETENCAO_INI', ate: 'P21_DT_RETENCAO_FIM', datas: true },
      { marca: 'P21_OCULTAR', texto: 'Esconder as linhas de total (996 a 999)' }] }
  ];
  var VISTO = '<svg viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M5 12.5l4.5 4.5L19 7.5" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/></svg>';
  var SETA = '<svg class="nc-hf-seta" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M6 9l6 6 6-6" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>';

  /* ═══ [F2] MONTAR OS FILTROS ═════════════════════════════════════════════════════════════
     CUIDADO  Os campos são MOVIDOS (não copiados): o APEX continua dono deles — valor, cascata,
     ação dinâmica. A lista "Sim / Não" de cada origem fica escondida e recebe o valor do botão.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var F = null;
  function caixaDe(id) { return document.getElementById(id + '_CONTAINER'); }
  function simDe(id) {   /* o valor "Sim" de uma lista de origem (Folha, Ferias, 13 Salario…) */
    var s = document.getElementById(id); if (!s || !s.options) return null;
    for (var i = 0; i < s.options.length; i++) if (/^sim$/i.test(s.options[i].text.trim())) return s.options[i].value;
    return null;
  }
  function marcado(id) { var v = valor(id); return !!v && v !== 'N'; }
  function montarFiltros() {
    var reg = document.getElementById('PARAMETROS');
    if (!reg || F) return;
    var corpo = reg.querySelector('.t-Region-body'); if (!corpo) return;
    var grupos = el('div', 'nc-hf-grupos');
    F = { reg: reg, grupos: [], mudou: false };
    GRUPOS.forEach(function (g) {
      var sec = el('section', 'nc-hf-grupo'), cid = 'nc-hf-g-' + g.k;
      var cab = el('button', 'nc-hf-cab', '<span>' + g.tit + '</span><span class="nc-hf-uso" hidden></span>' + (g.fixo ? '' : SETA));
      cab.type = 'button'; cab.setAttribute('aria-controls', cid);
      if (g.fixo) cab.setAttribute('aria-disabled', 'true');
      var bd = el('div', 'nc-hf-corpo'); bd.id = cid;
      if (g.dica) bd.appendChild(el('p', 'nc-hf-dica', g.dica));
      var tem = 0, ids = [];
      if (g.origens) {
        var marcas = el('div', 'nc-hf-marcas'); marcas.setAttribute('role', 'group'); marcas.setAttribute('aria-label', g.tit);
        ORIGENS.forEach(function (o) {
          var c = caixaDe(o[0]); if (!c || !simDe(o[0])) return;
          marcas.appendChild(botaoMarca(o[0], o[1], false));
          c.classList.add('nc-hf-guardado'); bd.appendChild(c); ids.push(o[0]); tem++;
        });
        bd.appendChild(marcas);
      } else {
        g.itens.forEach(function (it) {
          if (typeof it === 'string') { var c = caixaDe(it); if (c) { bd.appendChild(c); ids.push(it); tem++; } return; }
          if (it.marca) {
            var cm = caixaDe(it.marca); if (!cm || !simDe(it.marca)) return;
            cm.classList.add('nc-hf-guardado'); bd.appendChild(cm);
            var b = botaoMarca(it.marca, it.texto, true); bd.appendChild(b); ids.push(it.marca); tem++; return;
          }
          var cd = caixaDe(it.de), ca = caixaDe(it.ate); if (!cd && !ca) return;
          var fs = el('fieldset', 'nc-hf-faixa' + (it.datas ? ' nc-hf-faixa--datas' : ''), '<legend>' + it.faixa + '</legend>');
          [[cd, 'De', it.de], [ca, 'Até', it.ate]].forEach(function (x) {
            if (!x[0]) return;
            var lb = x[0].querySelector('.t-Form-label'); if (lb) lb.textContent = x[1];
            fs.appendChild(x[0]); ids.push(x[2]);
          });
          bd.appendChild(fs); tem++;
        });
      }
      if (!tem) return;   /* colaborador aberto pela ficha: o APEX não desenha os filtros de estrutura */
      sec.appendChild(cab); sec.appendChild(bd); grupos.appendChild(sec);
      var gr = { g: g, cab: cab, corpo: bd, ids: ids };
      F.grupos.push(gr);
      if (!g.fixo) {
        var aberto = usados(gr) > 0;
        try { var mem = localStorage.getItem('nc-hf-g-' + g.k); if (mem) aberto = aberto || mem === '1'; } catch (e) { /* ok */ }
        abrirGrupo(gr, aberto);
        cab.addEventListener('click', function () { var ab = cab.getAttribute('aria-expanded') !== 'true'; gr.mexeu = true; abrirGrupo(gr, ab); try { localStorage.setItem('nc-hf-g-' + g.k, ab ? '1' : '0'); } catch (e) { /* ok */ } });
      }
    });
    corpo.insertBefore(grupos, corpo.firstChild);
    /* o que sobrou da grade original (linhas e colunas vazias) sai */
    /* CUIDADO  nunca apagar: a linha pode guardar itens escondidos (protegidos = "Violação de proteção da
       página" no envio, visto na 9132:5). Só esconde a que não tem campo nenhum. */
    [].forEach.call(corpo.querySelectorAll('.row'), function (r) { if (!r.closest('.nc-hf-grupos') && !r.querySelector('.t-Form-fieldContainer, input, select, textarea')) r.style.display = 'none'; });
    /* o pé: resumo + o MESMO botão Pesquisar */
    var bt = reg.querySelector('.t-Region-headerItems--buttons button, .t-Region-buttons button');
    var pe = el('div', 'nc-hf-pe', '<p class="nc-hf-resumo" aria-live="polite"></p>');
    if (bt) pe.appendChild(bt);
    corpo.appendChild(pe);
    F.resumo = pe.querySelector('.nc-hf-resumo');
    resumir();
    setTimeout(function () { F.grupos.forEach(function (gr) { if (!gr.g.fixo && !gr.mexeu && usados(gr) > 0) abrirGrupo(gr, true); }); resumir(); }, 900);
    /* as listas em cascata se preenchem sozinhas ao abrir (disparam "change"): só conta o que vem
       depois de a página assentar */
    var t0 = Date.now(), mexeu = function () { if (Date.now() - t0 > 1500) F.mudou = true; setTimeout(resumir, 0); };
    reg.addEventListener('change', mexeu);
    if (window.apex && apex.jQuery) apex.jQuery(reg).on('change', mexeu);
  }
  function botaoMarca(id, texto, larga) {
    var b = el('button', 'nc-hf-marca' + (larga ? ' nc-hf-marca--larga' : ''), '<i>' + VISTO + '</i><span>' + texto + '</span>');
    b.type = 'button'; b.setAttribute('data-hf-item', id); b.setAttribute('aria-pressed', String(marcado(id)));
    b.addEventListener('click', function () {
      var liga = b.getAttribute('aria-pressed') !== 'true';
      apex.item(id).setValue(liga ? simDe(id) : 'N');     /* dispara o "change": a tabela fica marcada como velha */
      b.setAttribute('aria-pressed', String(liga));
    });
    return b;
  }
  function abrirGrupo(gr, aberto) { gr.cab.setAttribute('aria-expanded', String(aberto)); gr.corpo.hidden = !aberto; }
  function usados(gr) {
    var n = 0;
    gr.ids.forEach(function (id) {
      var v = apex.item(id).getValue();
      if (gr.g.origens) return;
      if (id === 'P21_OCULTAR') { if (v === 'S') n++; return; }
      if (!vazio(v)) n++;
    });
    return n;
  }
  /* o resumo do pé, em palavras: meses, o que soma, quantos filtros */
  function resumir() {
    if (!F) return;
    F.grupos.forEach(function (gr) {
      var u = gr.cab.querySelector('.nc-hf-uso'), n = gr.g.origens ? ORIGENS.filter(function (o) { return marcado(o[0]); }).length : usados(gr);
      if (gr.g.k === 'quando') n = 0;
      u.hidden = !n; u.textContent = n;
      u.setAttribute('aria-label', n + (gr.g.origens ? ' marcadas' : ' em uso'));
      if (gr.g.origens) [].forEach.call(gr.corpo.querySelectorAll('[data-hf-item]'), function (b) { b.setAttribute('aria-pressed', String(marcado(b.getAttribute('data-hf-item')))); });
    });
    var meses = mesesEscolhidos(), soma = ORIGENS.filter(function (o) { return document.getElementById(o[0]) && marcado(o[0]); }).map(function (o) { return o[1].toLowerCase(); });
    var outros = F.grupos.filter(function (gr) { return !gr.g.fixo; }).reduce(function (s, gr) { return s + usados(gr); }, 0);
    var html = meses.length ? '<b>' + (meses.length === 1 ? meses[0] : meses.length > 3 ? meses.length + ' meses (' + meses[0] + ' a ' + meses[meses.length - 1] + ')' : meses.slice(0, -1).join(', ') + ' e ' + meses[meses.length - 1]) + '</b>' : '<b>Escolha ao menos um mês</b>';
    html += soma.length ? ' · ' + soma.join(', ') : ' · <b>marque o que somar</b>';
    if (outros) html += ' · ' + outros + (outros === 1 ? ' filtro a mais' : ' filtros a mais');
    F.resumo.classList.toggle('is-mudou', F.mudou);
    F.resumo.innerHTML = (F.mudou ? 'Você mudou os filtros: toque em <b>Pesquisar</b> para atualizar a tabela. ' : 'Vai pesquisar: ') + html + '.';
  }
  function mesesEscolhidos() {
    var v = valor('P21_DATA_REF'); if (Array.isArray(v)) v = v.join(':');
    return String(v || '').split(':').filter(Boolean).map(function (t) { var d = data(t); return d ? mesAno(d) : t; })
      .sort(function (a, b) { return chaveMes(a) < chaveMes(b) ? -1 : 1; });
  }
  function chaveMes(t) { var m = /^(\w{3})\/(\d{4})$/.exec(t); return m ? m[2] + ('0' + (MESES.indexOf(m[1]) + 1)).slice(-2) : t; }

  /* ═══ [J1] TEXTOS E FERRAMENTAS DO RESUMO ═══════════════════════════════════════════════ */
  var PROCESSO = 'NC_HISTFIN_INDICADORES';
  var POR_VEZ = 30, POR_VEZ_Q = 6;
  var GUARDA = 'nc-hf-fechado';
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  var HOJE = [
    { k: 'prov', cor: 'roxo', ic: 'entra', diz: 'Ganhos', semLista: true, dinheiro: true },
    { k: 'desc', cor: 'roxo', ic: 'sai', diz: 'Descontos', semLista: true, dinheiro: true },
    { k: 'liq', cor: 'roxo', ic: 'dinheiro', diz: 'Líquido', semLista: true, dinheiro: true },
    { k: 'he', cor: 'ambar', ic: 'relogio', diz: 'Horas extras', dinheiro: true, lista: 'hepessoas', total: 'he_pessoas' },
    { k: 'negativos', cor: 'vermelho', ic: 'alarme', diz: 'Saldo negativo', alerta: true, lista: 'negativos', total: 'negativos' }
  ];
  var IC = {
    tabela: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    descer: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    atualiza: '<path d="M20 11a8 8 0 0 0-14.6-4.5L4 8"/><path d="M4 4v4h4"/><path d="M4 13a8 8 0 0 0 14.6 4.5L20 16"/><path d="M20 20v-4h-4"/>',
    dinheiro: '<rect x="3" y="6.5" width="18" height="11" rx="2.5"/><circle cx="12" cy="12" r="2.6"/><path d="M6.5 9.5v5M17.5 9.5v5"/>',
    entra: '<path d="M12 19V6M6.5 11.5 12 6l5.5 5.5"/><path d="M5 20h14"/>',
    sai: '<path d="M12 5v13M6.5 12.5 12 18l5.5-5.5"/><path d="M5 4h14"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    alarme: '<circle cx="12" cy="13" r="7"/><path d="M12 9.5V13l2 1.5M5 4.5 3 6.5M19 4.5l2 2"/>',
    fechar: '<path d="M6 15l6-6 6 6"/>',
    abrir: '<path d="M6 9l6 6 6-6"/>',
    aviso: '<path d="M12 4 2.8 19.5h18.4z"/><path d="M12 10v4.5M12 17.2h.01"/>'
  };
  function ic(n) { return '<svg class="nc-af-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }
  function num(n) { return Number(n || 0).toLocaleString('pt-BR'); }
  function plural(n, um, varios) { return num(n) + ' ' + (Number(n) === 1 ? um : varios); }
  function reais(v) { return Number(v || 0).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL', maximumFractionDigits: 0 }); }
  function reaisCurto(v) {   /* no quadrinho: acima de 100 mil, "R$ 730 mil" / "R$ 1,2 milhão" (o exato vai no title) */
    v = Number(v || 0); var s = v < 0 ? '−' : ''; v = Math.abs(v);
    if (v >= 1e6) { var m = v / 1e6; return { v: s + 'R$ ' + m.toLocaleString('pt-BR', { maximumFractionDigits: m < 10 ? 2 : 1 }), u: m < 2 ? 'milhão' : 'milhões' }; }
    if (v >= 1e5) return { v: s + 'R$ ' + Math.round(v / 1e3).toLocaleString('pt-BR'), u: 'mil' };
    return { v: s + reais(v), u: '' };
  }
  function pct(a, b) { if (!b) return 0; var x = a / b * 100; return a && x < 1 ? '&lt;1' : Math.round(x); }
  function data(t) { var m = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function mesAno(d) { return d ? MESES[d.getMonth()] + '/' + d.getFullYear() : ''; }
  function mesDe(k) { return MESES[+k.slice(5, 7) - 1] + '/' + k.slice(0, 4); }   /* "2026-06" → "jun/2026" */
  function semAcento(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase(); }
  function partes(t) { var m = /^(\S+)\s+-\s+(.+)$/.exec(t || ''); return m ? [m[1], m[2]] : ['', t || '']; }

  /* ═══ [J2] OS DADOS ═════════════════════════════════════════════════════════════════════
     CUIDADO  SEM pageItems: o servidor usa os filtros da SESSÃO (o último Pesquisar), igual à
     tabela. Mandar os campos da tela mostraria números de uma pesquisa que a tabela não fez.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function buscar() {
    carregando();
    apex.server.process(PROCESSO, {}, { dataType: 'json', error: function () { /* tratado no .fail */ } })
      .done(function (d) {
        pararCalculo();
        if (!d || d.erro) return erro(d && d.erro);
        try { desenhar(d, Date.now()); } catch (e) { erro(e && e.message); }
      })
      .fail(function (x) { pararCalculo(); erro(x && (x.status === 404 || (x.status === 200 && !x.responseText)) ? 'processo ausente' : (x && x.responseText || '').slice(0, 160)); });
  }

  /* ═══ [J3] A MOLDURA E A FAIXA DE NÚMEROS ══════════════════════════════════════════════ */
  var P = null;
  function montar() {
    if (P) return true;
    var ir = document.getElementById(RID); if (!ir) return false;
    ir.classList.add('nc-reg-sim');
    var caixa = el('section', 'nc-af nc-hf');
    caixa.setAttribute('aria-labelledby', 'nc-af-titulo');
    caixa.innerHTML =
      '<header class="nc-af-cab"><h2 id="nc-af-titulo">Resumo da folha</h2>' +
      '<p class="nc-af-quando" aria-live="polite"></p><span class="nc-af-espaco"></span>' +
      '<button type="button" class="nc-af-bt" data-af-ir-tabela>' + ic('descer') + '<span>Ir para a tabela</span></button>' +
      '<button type="button" class="nc-af-bt" data-af-esconde aria-controls="nc-af-corpo"></button></header>' +
      '<div class="nc-af-corpo" id="nc-af-corpo"></div>';
    ir.parentNode.insertBefore(caixa, ir);
    P = { caixa: caixa, corpo: caixa.querySelector('.nc-af-corpo'), quando: caixa.querySelector('.nc-af-quando'), botao: caixa.querySelector('[data-af-esconde]'), filtro: null };
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
    if (aberto) setTimeout(ajustarMeses, 0);
  }
  function clique(e) {
    var b = e.target.closest('button'); if (!b || !P.caixa.contains(b)) return;
    if (b.hasAttribute('data-af-esconde')) return abrirFechar(P.caixa.classList.contains('is-fechado'));
    if (b.hasAttribute('data-af-num')) { var k = b.getAttribute('data-af-num'); P.filtro = P.filtro === k ? null : k; desenharHoje(); return; }
    if (b.hasAttribute('data-af-revela')) { revelar(b.previousElementSibling, +b.getAttribute('data-af-revela'), true); return; }
    if (b.hasAttribute('data-af-tabela')) { naTabela(b.getAttribute('data-af-tabela')); return; }
    if (b.hasAttribute('data-af-ir-tabela')) { irParaTabela(); return; }
    if (b.hasAttribute('data-af-tenta')) buscar();
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
    P.corpo.innerHTML = '<div class="nc-af-secao" aria-busy="true"><p class="nc-af-rot">No período</p><div class="nc-af-regua">' + HOJE.map(function (h) {
      return '<div class="nc-af-num is-carregando"><span class="nc-af-sinal">' + ic(h.ic) + '</span><span class="nc-af-valor"><i class="nc-af-esq" style="width:56px;height:26px"></i></span><span class="nc-af-diz">' + h.diz + '</span></div>';
    }).join('') + '</div></div>';
    P.quando.textContent = 'Calculando…';
    pararCalculo();
    P.lento = calculando(["Buscando a folha…", "Somando ganhos e descontos…", "Comparando os meses…", "Ainda calculando: folha grande leva mais tempo"]);
  }
  function erro(msg) {
    var falta = /processo ausente|ERR-1002|not found/i.test(msg || '');
    P.quando.textContent = '';
    P.corpo.innerHTML = '<div class="nc-af-aviso" role="alert">' + ic('aviso') + '<div><b>Não foi possível montar o resumo agora.</b>' +
      (falta ? 'Falta instalar nesta página o processo ' + PROCESSO + ' (veja o guia HISTFIN-MANUTENCAO.md).'
             : 'A tabela abaixo continua funcionando. Tente de novo em instantes; se continuar, avise a equipe de sistemas.' + (msg ? ' <small>(' + esc(msg) + ')</small>' : '')) +
      '</div><span class="nc-af-espaco"></span><button type="button" class="nc-af-bt" data-af-tenta>Tentar de novo</button></div>';
  }
  function desenhar(d, quando) {
    pararCalculo();
    chegou();
    P.dados = d; P.filtro = null;
    var a = d.agora || {}, ms = (d.meses || []).map(function (m) { return mesDe(m.m); });
    var hm = quando ? new Date(quando).toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }) : '';
    P.quando.innerHTML = (ms.length ? (ms.length === 1 ? '<b>' + ms[0] + '</b>' : '<b>' + ms[0] + '</b> a <b>' + ms[ms.length - 1] + '</b>') : 'Sem meses') +
      ' · com os filtros da última pesquisa' + (hm ? ' · calculado às ' + hm : '');
    if (d.sem_pesquisa) {   /* a regra do relatório: sem Pesquisar, nada é calculado (abrir a página fica rápido) */
      P.quando.textContent = '';
      P.corpo.innerHTML = '<div class="nc-af-aviso nc-qd-convite">' + ic('busca') + '<div><b>Escolha os meses e o que somar na coluna ao lado e toque em Pesquisar.</b>' +
        'O resumo da folha (ganhos, descontos, horas extras e o que mudou de um mês para o outro) aparece aqui, com os mesmos filtros da tabela.</div></div>';
      totais(false);
      return;
    }
    if (!a.pessoas) {
      P.corpo.innerHTML = '<div class="nc-af-aviso nc-qd-convite">' + ic('busca') + '<div><b>' +
        (d.sem_acesso ? 'Você não pode ver o salário das pessoas destes filtros.' : 'Nenhum lançamento com estes filtros.') + '</b>' +
        (d.sem_acesso ? 'O resumo só soma valores que você tem permissão de ver.' : 'Confira os meses e o que somar na coluna de filtros e toque em Pesquisar.') + '</div></div>';
      totais(false);
      return;
    }
    totais(true);   /* a região "Totais" sai: o resumo já mostra os totais */
    P.corpo.innerHTML =
      '<div class="nc-af-secao"><p class="nc-af-rot">No período</p><div class="nc-af-regua" role="group" aria-label="A folha no período"></div>' +
      '<div class="nc-af-quem" id="nc-af-quem" hidden aria-live="polite"></div></div>' +
      '<div class="nc-af-secao nc-af-periodo"></div>';
    desenharHoje();
    desenharAnalise();
  }
  function totais(esconde) { var t = document.getElementById('TOTAIS'); if (t) t.classList.toggle('nc-hf-repetida', esconde); }
  function dicaDe(h, a, d) {
    var nm = (d.meses || []).length, porMes = (d.meses || []).reduce(function (s, m) { return s + m.n; }, 0);
    switch (h.k) {
      case 'prov': return 'pagos a ' + plural(a.pessoas, 'pessoa', 'pessoas') + (nm > 1 ? ' em ' + nm + ' meses' : '');
      case 'desc': return pct(a.desc, a.prov) + '% dos ganhos';
      case 'liq': return reais(a.liq / Math.max(1, porMes)) + ' por pessoa' + (nm > 1 ? ' por mês' : '') + ', em média';
      case 'he': return a.he ? plural(a.he_pessoas, 'pessoa', 'pessoas') + ' · ' + pct(a.he, a.prov) + '% dos ganhos' + (a.he_horas ? ' · ' + num(Math.round(a.he_horas)) + ' horas' : '') : 'nenhuma hora extra paga no período';
      case 'negativos': return a.negativos ? 'descontos maiores que os ganhos no mês: a pessoa fica devendo' : 'ninguém com descontos maiores que os ganhos';
    }
    return '';
  }
  function desenharHoje() {
    var a = P.dados.agora || {}, d = P.dados;
    P.caixa.querySelector('.nc-af-regua').innerHTML = HOJE.map(function (h) {
      var v = Number(a[h.k] || 0), on = P.filtro === h.k, temLista = h.lista && v && (d[h.lista] || []).length;
      var zeroBom = h.alerta && !v, vd = h.dinheiro ? reaisCurto(v) : { v: num(v), u: v === 1 ? 'pessoa' : 'pessoas' };
      return '<button type="button" class="nc-af-num nc-af-num--' + (zeroBom ? 'verde' : h.cor) + (v || h.semLista ? '' : ' is-zero') + (h.alerta && v ? ' is-alerta' : '') + '" data-af-num="' + h.k + '"' +
        ' aria-pressed="' + on + '" aria-controls="nc-af-quem"' + (temLista ? '' : ' disabled') + (h.dinheiro ? ' title="' + reais(v) + '"' : '') + '>' +
        '<span class="nc-af-sinal">' + ic(h.ic) + '</span>' +
        '<span class="nc-af-valor' + (zeroBom ? ' is-texto' : '') + '">' + (zeroBom ? 'Ninguém' : vd.v + (vd.u ? '<small>' + vd.u + '</small>' : '')) + '</span>' +
        '<span class="nc-af-diz">' + h.diz + '</span><span class="nc-af-dica">' + dicaDe(h, a, d) + '</span></button>';
    }).join('');
    desenharLista();
  }
  var LISTA = {
    he: { tit: 'Quem recebeu hora extra', ordem: 'o maior valor primeiro', lista: 'hepessoas', total: 'he_pessoas',
      det: function (p) { return [esc(p.t || ''), '<span class="nc-af-volta nc-af-volta--sem">' + reais(p.v) + '</span>']; } },
    negativos: { tit: 'Saldo negativo no mês', ordem: 'por mês, o maior saldo devedor primeiro', lista: 'negativos', total: 'negativos',
      det: function (p) { return [esc(p.t || ''), '<span class="nc-af-volta nc-af-volta--atrasada">Fica devendo ' + reais(Math.abs(p.v)) + '</span>']; } }
  };
  function desenharLista() {
    var box = P.caixa.querySelector('.nc-af-quem');
    if (!P.filtro || !LISTA[P.filtro]) { box.hidden = true; box.innerHTML = ''; return; }
    var c = LISTA[P.filtro];
    listaPessoas(box, c.tit, c.ordem, P.dados[c.lista], c.det, Number((P.dados.agora || {})[c.total] || 0));
  }
  function listaPessoas(box, titulo, ordem, lista, det, tot) {
    var ps = (lista || []).slice();
    box.hidden = false;
    box.innerHTML = '<div class="nc-af-quem-cab"><h3>' + titulo + ': ' + plural(tot, 'pessoa', 'pessoas') + '</h3><p>' + ordem + ' · toque numa pessoa para ver na tabela</p>' +
      (ps.length > 12 ? '<label class="nc-af-procura">' + ic('busca') + '<span class="nc-af-vis">Procurar nesta lista</span><input type="search" placeholder="Procurar nome ou centro de custo" data-af-procura autocomplete="off"></label>' : '') + '</div>' +
      rolo('ul', 'nc-af-lista', ps.map(function (p) { return linhaPessoa(p, det(p)); }), POR_VEZ, 'pessoas') +
      (tot > ps.length ? '<p class="nc-af-nota">A lista mostra ' + num(ps.length) + ' de ' + num(tot) + '. Use os filtros para ver menos de cada vez.</p>' : '');
    ligarRolos(box);
    var pr = box.querySelector('[data-af-procura]');
    if (pr) pr.addEventListener('input', function () { procurar(box, pr.value); });
  }
  function linhaPessoa(p, dt) {
    return '<li data-af-texto="' + esc(semAcento([p.n, p.s, p.t].join(' '))) + '"><button type="button" class="nc-af-p nc-fp-p" data-af-tabela="' + esc(p.q || p.n) + '" title="Ver ' + esc(partes(p.n)[1]) + ' na tabela">' +
      '<span class="nc-af-p-quem"><b>' + esc(p.n) + '</b><span>' + esc(p.s || '') + '</span></span>' +
      '<span class="nc-af-p-tipo">' + dt[0] + '</span>' + dt[1] + '<span class="nc-af-p-ir" aria-hidden="true">' + ic('tabela') + '</span></button></li>';
  }
  function procurar(box, q) {
    var r = box.querySelector('.nc-af-rolo'), lis = r.querySelectorAll('li'), t = semAcento(q.trim()), n = 0;
    if (!t) { desenharLista(); var p2 = P.caixa.querySelector('[data-af-procura]'); if (p2) p2.focus(); return; }
    [].forEach.call(lis, function (li) { var ok = li.getAttribute('data-af-texto').indexOf(t) >= 0; li.hidden = !ok; if (ok) n++; });
    var bt = r.nextElementSibling; if (bt && bt.hasAttribute('data-af-revela')) bt.hidden = true;
    var nada = r.querySelector('.nc-af-nada'); if (nada) nada.remove();
    if (!n) r.insertAdjacentHTML('beforeend', '<p class="nc-af-nada">Ninguém nesta lista com “' + esc(q.trim()) + '”.</p>');
  }
  /* listas que vão aparecendo (caixa de altura máxima, revela de N em N) */
  function rolo(tag, cls, itens, passo, unid) {
    return '<div class="nc-af-rolo" data-af-unid="' + unid + '"><' + tag + ' class="' + cls + '">' +
      itens.map(function (h, i) { return i < passo ? h : h.replace(/^<li/, '<li hidden'); }).join('') +
      '</' + tag + '><span class="nc-af-sentinela" aria-hidden="true"></span></div>' +
      (itens.length > passo ? '<button type="button" class="nc-af-mais" data-af-revela="' + passo + '"></button>' : '');
  }
  function escondidos(r) { return r.querySelectorAll('li[hidden]:not(.is-filtrado)'); }
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
  /* ver na tabela: a PRÓPRIA busca do relatório (campo + "Ir"), esperando a página ficar livre */
  function naTabela(texto) {
    var f = document.getElementById(RID + '_search_field'), b = document.getElementById(RID + '_search_button');
    if (!f || !b) return irParaTabela();
    P.quando.textContent = 'Filtrando a tabela…';
    irParaTabela();
    var t0 = Date.now();
    (function quandoLivre() {
      if (apex.jQuery.active > 0 && Date.now() - t0 < 8000) return setTimeout(quandoLivre, 120);
      f.value = texto; b.click();
      P.quando.innerHTML = 'A tabela abaixo agora mostra só <b>' + esc(texto) + '</b>. Para ver tudo de novo, toque no <b>×</b> do filtro, em cima da tabela.';
    })();
  }
  function irParaTabela() {
    var ir = document.getElementById(RID); if (!ir) return;
    ir.scrollIntoView({ behavior: window.matchMedia && matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth', block: 'start' });
  }

  /* ═══ [J4] A ANÁLISE ════════════════════════════════════════════════════════════════════ */
  function desenharAnalise() {
    var d = P.dados, a = d.agora || {}, ms = d.meses || [], per = P.caixa.querySelector('.nc-af-periodo');
    var ult = ms[ms.length - 1], ant = ms.length > 1 ? ms[ms.length - 2] : null;
    var frase;
    if (ant) {
      var lu = ult.p - ult.d, la = ant.p - ant.d, dl = lu - la, dp = ult.p - ant.p;
      frase = '<p class="nc-af-frase">De <b>' + mesDe(ant.m) + '</b> para <b>' + mesDe(ult.m) + '</b> os ganhos ' + (dp >= 0 ? 'subiram' : 'caíram') + ' <b>' + reais(Math.abs(dp)) + '</b>' +
        (ant.p ? ' (' + (dp >= 0 ? '+' : '−') + Math.abs(dp / ant.p * 100).toLocaleString('pt-BR', { maximumFractionDigits: 1 }) + '%)' : '') +
        ' e o líquido ' + (dl >= 0 ? 'subiu' : 'caiu') + ' <b>' + reais(Math.abs(dl)) + '</b>.';
    } else {
      frase = '<p class="nc-af-frase">' + (ult ? 'Em <b>' + mesDe(ult.m) + '</b> a' : 'A') + ' folha somou <b>' + reais(a.prov) + '</b> em ganhos e <b>' + reais(a.desc) + '</b> em descontos: <b>' +
        reais(a.liq) + '</b> líquidos para ' + plural(a.pessoas, 'pessoa', 'pessoas') + '.' +
        '<span class="nc-af-taxa">Para comparar um mês com o outro, escolha dois meses ou mais em “Quando”, na coluna de filtros.</span>';
    }
    if (a.encargos) frase += '<span class="nc-af-taxa">Encargos da empresa lançados na folha (FGTS e outros da categoria “Encargos Empresa”): <b>' + reais(a.encargos) + '</b>.</span>';
    if (d.sem_acesso) frase += '<span class="nc-af-taxa">' + plural(d.sem_acesso, 'pessoa ficou', 'pessoas ficaram') + ' de fora: você não pode ver o salário ' + (d.sem_acesso === 1 ? 'dela' : 'delas') + '.</span>';
    frase += '</p>';
    var q = [];
    if (ant) {
      q.push(quadro('Mês a mês', 'Ganhos e descontos de cada mês · passe o mouse nas colunas', mesAMes(ms), 'nc-af-q--meses'));
      q.push(quadro('O que mais mudou', 'Verbas de ' + mesDe(ant.m) + ' para ' + mesDe(ult.m) + ' · a maior diferença primeiro', mudou(d.mudou || [])));
      q.push(quadro('Líquido que mais mudou', 'Pessoas, de ' + mesDe(ant.m) + ' para ' + mesDe(ult.m) + ' · toque para ver na tabela', pessoasMudou(d.pessoasmudou || [])));
    }
    q.push(quadro('Para onde vai o dinheiro', 'Ganhos por categoria da verba · toque para ver na tabela', barrasValor(d.catp || [], a.prov)));
    q.push(quadro('Descontos', 'Por categoria da verba · toque para ver na tabela', barrasValor(d.catd || [], a.desc)));
    q.push(quadro('Ganhos por centro de custo', 'Toque para ver na tabela', barrasValor(d.setores || [], a.prov)));
    if ((d.origens || []).length > 1) q.push(quadro('Por tipo de cálculo', 'Folha, férias, rescisão, 13º…', barrasValor(d.origens, a.prov)));
    if ((d.hepessoas || []).length) q.push(quadro('Quem fez mais hora extra', 'Valor no período · toque para ver na tabela', pessoasValor(d.hepessoas, function (p) { return esc(p.t || ''); })));
    if ((d.faltaspessoas || []).length) q.push(quadro('Faltas e atrasos descontados', plural(a.faltas_pessoas, 'pessoa', 'pessoas') + ' · ' + reais(a.faltas) + ' no período', pessoasValor(d.faltaspessoas, function () { return ''; })));
    if ((d.encargos || []).length) q.push(quadro('Encargos da empresa', 'Lançados na folha (não descontam de ninguém)', barrasValor(d.encargos, a.encargos)));
    per.innerHTML = frase + '<div class="nc-af-quadros nc-af-quadros--3">' + q.join('') + '</div>';
    ligarRolos(per);
    ajustarMeses();
  }
  function quadro(tit, dica, corpo, cls) { return '<section class="nc-af-q' + (cls ? ' ' + cls : '') + '"><h3>' + tit + '</h3><p>' + dica + '</p>' + corpo + '</section>'; }
  /* barras de VALOR: R$, % do total e (quando há) pessoas; com texto de busca (k ou t) = ver na tabela */
  function barrasValor(xs, total) {
    if (!xs.length) return '<p class="nc-af-vazio-q">Sem lançamentos.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return x.q; })) || 1;
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var p = partes(x.t);
      return '<li><button type="button" class="nc-af-b' + (i === 0 ? ' is-maior' : '') + '" data-af-tabela="' + esc(x.k || p[1]) + '" title="Ver ' + esc(x.t) + ' na tabela">' +
        '<span class="nc-af-b-nome">' + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1]) + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(x.q / max * 100)) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + reais(x.q) + ' <small>· ' + pct(x.q, total) + '%' + (x.n != null ? ' · ' + plural(x.n, 'pessoa', 'pessoas') : '') + '</small></span>' +
        '<span class="nc-af-b-ir" aria-hidden="true">Ver na tabela' + ic('tabela') + '</span></button></li>';
    }), POR_VEZ_Q, 'linhas');
  }
  function pessoasValor(xs, meio) {
    return rolo('ul', 'nc-af-lista', xs.map(function (p) { return linhaPessoa(p, [meio(p), '<span class="nc-af-volta">' + reais(p.v) + '</span>']); }), POR_VEZ_Q, 'pessoas');
  }
  /* verbas: o valor de antes → o de agora; desconto vem negativo do servidor (mostra sem sinal) */
  function mudou(xs) {
    if (!xs.length) return '<p class="nc-af-vazio-q">Nenhuma verba mudou de um mês para o outro.</p>';
    return rolo('ul', 'nc-af-lista', xs.map(function (x) {
      var desconto = x.a < 0 || x.b < 0, a = Math.abs(x.a), b = Math.abs(x.b), dif = b - a, p = partes(x.t);
      var selo = !a ? 'Nova em ' + mesDe(P.dados.meses[P.dados.meses.length - 1].m) : !b ? 'Não veio' : (dif > 0 ? 'Subiu ' : 'Caiu ') + reais(Math.abs(dif));
      return '<li data-af-texto="' + esc(semAcento(x.t)) + '"><button type="button" class="nc-af-p nc-fp-p" data-af-tabela="' + esc(p[1]) + '" title="Ver ' + esc(x.t) + ' na tabela">' +
        '<span class="nc-af-p-quem"><b>' + esc(x.t) + '</b><span>' + (desconto ? 'desconto' : 'ganho') + '</span></span>' +
        '<span class="nc-af-p-tipo">' + reais(a) + ' → ' + reais(b) + '</span>' +
        '<span class="nc-af-volta">' + selo + '</span><span class="nc-af-p-ir" aria-hidden="true">' + ic('tabela') + '</span></button></li>';
    }), POR_VEZ_Q, 'linhas');
  }
  function pessoasMudou(xs) {
    if (!xs.length) return '<p class="nc-af-vazio-q">Ninguém com o líquido diferente de um mês para o outro.</p>';
    return rolo('ul', 'nc-af-lista', xs.map(function (p) {
      return linhaPessoa(p, [reais(p.a) + ' → ' + reais(p.b), '<span class="nc-af-volta">' + (p.v > 0 ? 'Subiu ' : 'Caiu ') + reais(Math.abs(p.v)) + '</span>']);
    }), POR_VEZ_Q, 'pessoas');
  }
  /* MÊS A MÊS: duas colunas por mês (ganhos em roxo, descontos em rosa) */
  function mesAMes(ms) {
    var max = Math.max.apply(null, ms.map(function (m) { return Math.max(m.p, m.d); })) || 1;
    return '<p class="nc-af-legenda"><span class="nc-af-leg nc-af-leg--e"></span>Ganhos <span class="nc-af-leg nc-af-leg--s"></span>Descontos</p>' +
      '<ol class="nc-af-meses nc-af-meses--par">' + ms.map(function (m, i) {
        var rot = mesDe(m.m) + ': ganhos ' + reais(m.p) + ' · descontos ' + reais(m.d) + ' · ' + plural(m.n, 'pessoa', 'pessoas');
        var ano = m.m.slice(5) === '01' || i === 0 ? '<em>' + m.m.slice(0, 4) + '</em>' : '';
        return '<li class="nc-af-mes' + (i === 0 || +m.m.slice(5) % 3 === 1 ? ' is-marco' : '') + '" tabindex="0" aria-label="' + rot + '" data-dica="' + rot + '">' +
          '<b></b><span class="nc-af-par"><i class="nc-af-par-e" style="height:' + (m.p ? Math.max(4, Math.round(m.p / max * 100)) : 0) + '%"></i><i class="nc-af-par-s" style="height:' + (m.d ? Math.max(4, Math.round(m.d / max * 100)) : 0) + '%"></i></span>' +
          '<span>' + MESES[+m.m.slice(5) - 1] + ano + '</span></li>';
      }).join('') + '</ol>';
  }
  function ajustarMeses() {
    var ol = P && P.caixa.querySelector('.nc-af-meses'); if (!ol || !ol.children.length) return;
    ol.classList.toggle('is-denso', ol.clientWidth / ol.children.length < 34);
  }
  var tAj = 0;
  window.addEventListener('resize', function () { clearTimeout(tAj); tAj = setTimeout(ajustarMeses, 120); });

  /* ═══ [J5] O COMEÇO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() {
    if (window.__ncHistFinIniciou) return;
    window.__ncHistFinIniciou = true;
    try { montarFiltros(); } catch (e) { /* os filtros originais continuam funcionando */ if (window.console) console.warn('Natcorp_HistFin filtros', e); }
    if (montar()) buscar();
  }
  window.__ncHistFinDesenhar = function (d) { if (montar()) desenhar(d); };   /* para conferir o desenho com dados de teste */
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).one('apexreadyend', iniciar);
    if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  }
})();
