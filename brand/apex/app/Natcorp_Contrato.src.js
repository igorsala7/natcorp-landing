/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CONTRATO DE GESTÃO (AS METAS)  —  o "arrumador" das páginas (JavaScript)      ║
   ║  App 300 (Portal do Colaborador) · Página 106 (as metas) + Página 109 (uma meta, janela) ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia destas páginas: CONTRATO-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quem usa é o colaborador, quase sempre no celular, e muitos leem com dificuldade. Então
   tudo é dito com poucas palavras e com números grandes:
     Página 106 (Contrato de Gestão: Avaliado)
       • o alto diz "Suas metas", de quando a quando, e a nota final (ou que ainda não saiu);
         os botões originais Concluir, Gerar Relatório e Adicionar Meta ficam ali, com uma
         frase curta do que fazem;
       • as duas pessoas: o colaborador e quem avalia (foto, nome, o botão Visualizar);
       • "Como a nota é dividida": uma barra com o pedaço de cada meta (o peso);
       • cada meta é um cartão: o nome, quanto vale na nota, a meta combinada e quanto
         alcançou, lado a lado; tocar abre a meta (o lápis da linha);
       • "Ver como tabela" mostra o relatório original com todas as ferramentas.
     Página 109 (a janela de uma meta)
       • no alto: "Meta 1 de 5" com uma régua, o nome da meta e quanto ela vale;
       • só leitura (sem Salvar/Criar): a meta vira texto — o que fazer, a meta combinada,
         quanto alcançou e o resultado;
       • editando: os MESMOS campos, em duas partes ("A meta" e "O resultado"), cada um com
         uma frase de ajuda, e o % ao lado quando a meta é em percentual;
       • os botões de baixo com texto: Meta anterior, Próxima meta, Salvar, Feedback, Voltar.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada e não decide o que aparece: os botões são os ORIGINAIS (mudam de lugar e
     de roupa); quem mostra/esconde Concluir, Adicionar Meta, Salvar etc. continua sendo a
     página (as ações dinâmicas). Os dados da 106 são LIDOS do relatório pelo TÍTULO de cada
     coluna. Tirou as URLs: volta o de antes.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Páginas 106 e 109 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Contrato.js
     Páginas 106 e 109 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Contrato.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [K1] Como as páginas são reconhecidas                                 CUIDADO
     [K2] Os textos                                                        PODE MEXER
     [K3] Ferramentas (números, nomes, ícones)
     [K4] 106 · lê as metas do relatório (pelos títulos)                   CUIDADO
     [K5] 106 · o alto, as pessoas, a divisão da nota
     [K6] 106 · os cartões e o modo tabela
     [K7] 109 · a janela de uma meta                                       CUIDADO
     [K8] O maestro
*/
(function () {
  'use strict';
  if (window.__ncContrato || !window.apex || !window.apex.jQuery) return;

  /* ═══ [K1] COMO AS PÁGINAS SÃO RECONHECIDAS ══════════════════════════════════════════════
     CUIDADO  pelos ITENS, não pelo nº da página:
              106 = P106_COD_CONTRATO + P106_SUM_PERC_PESO (o relatório .a-IRR é montado pelo
                    JS dele DEPOIS deste arquivo: é procurado na montagem, com novas tentativas);
              109 = P109_ROWID_COUNT + P109_VALOR_ATINGIDO.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  var PAG = $id('P106_COD_CONTRATO') && $id('P106_SUM_PERC_PESO') ? 106 : ($id('P109_ROWID_COUNT') && $id('P109_VALOR_ATINGIDO') ? 109 : 0);
  if (!PAG) return;
  window.__ncContrato = true;
  var $ = window.apex.jQuery;

  /* ═══ [K2] OS TEXTOS ═════════════════════════════════════════════════════════════════════
     PODE MEXER  frases curtas, palavras do dia a dia.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T = {
    titulo: 'Suas metas',
    periodo: function (a, b) { return 'De ' + a + ' até ' + b; },
    notaFinal: 'Nota final',
    semNota: 'A nota final ainda não saiu.',
    cancelado: 'Este contrato foi cancelado.',
    concluirDica: 'Toque em Concluir quando terminar de conferir todas as metas.',
    relatorio: 'Baixar em PDF',
    adicionar: 'Adicionar meta',
    adicionarDica: 'Crie uma meta nova para este contrato.',
    colaborador: 'Colaborador',
    avaliador: 'Quem avalia',
    divisao: 'Como a nota é dividida',
    divisaoFrase: function (n) { return n === 1 ? 'É 1 meta. Ela vale a nota inteira.' : 'São ' + n + ' metas. Cada uma vale um pedaço da nota.'; },
    somaOk: 'As metas somam 100%.',
    somaErrada: function (s) { return 'As metas somam ' + s + '%. Precisam somar 100%.'; },
    vale: function (p) { return 'Vale ' + p + '% da nota'; },
    oQueFazer: 'O que fazer',
    meta: 'Meta combinada',
    alcancou: 'Alcançado',
    semResultado: 'Ainda sem resultado',
    cumpriu: function (p) { return 'Cumpriu ' + p + ' da meta'; },
    desempenho: 'Desempenho',
    abrir: 'Abrir meta',
    nenhuma: 'Ainda não há metas neste contrato.',
    verTabela: 'Ver como tabela',
    verCartoes: 'Ver como cartões',
    /* 109 */
    metaN: function (a, b) { return 'Meta ' + a + ' de ' + b; },
    novaMeta: 'Nova meta',
    janelaLer: 'Sua meta',
    janelaEditar: 'Editar meta',
    parteMeta: 'A meta',
    parteResultado: 'O resultado',
    anterior: 'Meta anterior',
    proxima: 'Próxima meta',
    dicas: {
      P109_COD_OBJETIVO: 'O assunto da meta.',
      P109_PERC_PESO: 'Quanto esta meta vale na nota. Todas juntas somam 100.',
      P109_ACAO: 'O que vai ser feito para chegar na meta.',
      P109_TIPO_META: 'Valor: um número (ex.: 5.000). Percentual: em % (ex.: 30%).',
      P109_META: 'O número que precisa ser alcançado.',
      P109_VALOR_ATINGIDO: 'O número que foi alcançado de verdade.',
      P109_PERC_ATINGIDO: 'Calculado sozinho.',
      P109_DESEMP_ATINGIDO: 'Calculado sozinho.'
    },
    rotulos: {
      P109_ACAO: 'O que fazer',
      P109_META: 'Meta combinada',
      P109_VALOR_ATINGIDO: 'Quanto foi alcançado',
      P109_PERC_ATINGIDO: 'Quanto da meta (%)',
      P109_DESEMP_ATINGIDO: 'Desempenho'
    }
  };

  /* ═══ [K3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/\s+/g, ' ').trim(); }
  function sem(t) { return limpo(t).toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  function nomeDe(t) { return limpo(String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '')); }
  var MIUDAS = /^(da|de|do|das|dos|e|em|na|no|a|o)$/;
  /* "TURNOVER" → "Turnover"; "Natcorp Do Brasil" → "Natcorp do Brasil" */
  function bonito(t) {
    t = limpo(t); if (!t) return t;
    var caixa = t === t.toUpperCase() && /[A-Z]/.test(t);
    return (caixa ? t.toLowerCase() : t).replace(/[^\s\-\/().]+/g, function (w, i) {
      if (i > 0 && MIUDAS.test(w.toLowerCase())) return w.toLowerCase();
      if (!caixa) return w;
      if (!/[aeiouáéíóúâêôãõà]/.test(w)) return w.toUpperCase();
      return w.charAt(0).toUpperCase() + w.slice(1);
    });
  }
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  function dataExtenso(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? (+m[1] === 1 ? '1º' : +m[1]) + ' de ' + MESES[+m[2] - 1] + ' de ' + m[3] : ''; }
  /* "1.234,5" / "1234.5" / "1,5%" → número */
  function num(t) {
    t = limpo(t).replace(/%$/, '').trim(); if (!t || t === '-') return null;
    if (/,/.test(t)) t = t.replace(/\./g, '').replace(',', '.');
    var n = parseFloat(t); return isNaN(n) ? null : n;
  }
  function br(n) { return n.toLocaleString('pt-BR', { maximumFractionDigits: 2 }); }
  /* o valor como a pessoa lê: "5.000", "800.000", "1,5%"; vazio/"-"/"%" sozinho → '' */
  function valor(t, pct) { var n = num(t); if (n === null) return ''; return br(n) + (pct ? '%' : ''); }
  var IC = {
    pdf: '<path d="M7 3h7l5 5v13H7z"/><path d="M14 3v5h5"/><path d="M10 13v5m-2-2 2 2 2-2"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    ok: '<path d="m5 12.5 4.5 4.5L19 7.5"/>',
    alerta: '<path d="M12 4 2.8 19.5h18.4z"/><path d="M12 10v4.5M12 17.2v.1"/>',
    seta: '<path d="m9 5 7 7-7 7"/>',
    volta: '<path d="m15 5-7 7 7 7"/>',
    alvo: '<circle cx="12" cy="12" r="8.2"/><circle cx="12" cy="12" r="4.4"/><circle cx="12" cy="12" r=".9"/>',
    pessoa: '<circle cx="12" cy="8.5" r="3.7"/><path d="M5 20c.9-3.6 3.6-5.6 7-5.6s6.1 2 7 5.6"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M9 10v9"/>',
    cartoes: '<rect x="4" y="4.5" width="16" height="6.5" rx="1.8"/><rect x="4" y="13" width="16" height="6.5" rx="1.8"/>',
    calendario: '<rect x="4" y="5.5" width="16" height="14.5" rx="2"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4"/>'
  };
  function ic(n, cls) { return '<svg class="nc-ct-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  function iniciais(n) { var p = limpo(n).split(' ').filter(function (w) { return w && !MIUDAS.test(w.toLowerCase()); }); return ((p[0] || '?').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  function rotuloBotao(b, txt) { var lb = b.querySelector('.t-Button-label'); if (lb) lb.textContent = txt; else b.insertAdjacentHTML('beforeend', '<span class="t-Button-label">' + esc(txt) + '</span>'); }

  /* ═══ [K4] 106 · LÊ AS METAS DO RELATÓRIO (PELOS TÍTULOS) ════════════════════════════════
     CUIDADO  as colunas são achadas pelo TÍTULO (th) e ligadas às células pelo td[headers].
              Mudou o título de uma coluna no APEX? Ajuste COLS. Linhas sem o lápis (a soma
              dos pesos, no fim) não são metas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var COLS = {
    n: /^n[ºo°]?$/, objetivo: /^objetivo/, categoria: /^categoria/, peso: /^peso/, acao: /^acao/,
    tipo: /^tipo/, meta: /^meta$/, alcancado: /^valor atingido/, perc: /^% atingido/, desemp: /^desempenho/
  };
  var IR, IRREG, CAIXA, METAS = [];
  function lerMetas() {
    var tb = [].slice.call(IR.querySelectorAll('.a-IRR-table')).sort(function (a, b) { return b.rows.length - a.rows.length; })[0];
    if (!tb) return [];
    var col = {};
    [].forEach.call(IR.querySelectorAll('th[id]'), function (th) {
      var s = sem(th.textContent);
      Object.keys(COLS).forEach(function (k) { if (!col[k] && COLS[k].test(s)) col[k] = th.id; });
    });
    return [].filter.call(tb.rows, function (tr) { return tr.querySelector('td[headers] a'); }).map(function (tr) {
      function c(k) { var td = col[k] && tr.querySelector('td[headers="' + col[k] + '"]'); return td ? limpo(td.textContent) : ''; }
      var pct = /percent/.test(sem(c('tipo')));
      return {
        n: c('n'), objetivo: bonito(c('objetivo')), categoria: bonito(c('categoria')),
        peso: num(c('peso')), acao: bonito(c('acao')), pct: pct,
        meta: valor(c('meta'), pct), alcancado: valor(c('alcancado'), pct),
        perc: valor(c('perc'), true), desemp: valor(c('desemp'), pct),
        link: tr.querySelector('td[headers] a')
      };
    });
  }

  /* ═══ [K5] 106 · O ALTO, AS PESSOAS, A DIVISÃO DA NOTA ═══════════════════════════════════ */
  function v(id) { var e = $id(id); return e ? limpo(e.value != null ? e.value : e.textContent) : ''; }
  function regiaoDe(id) { var e = $id(id); return e && e.closest('.t-Region'); }
  function botaoNa(reg, re) { return reg && [].filter.call(reg.querySelectorAll('button.t-Button, a.t-Button'), function (b) { return re.test(sem(b.textContent + ' ' + (b.title || ''))); })[0]; }
  function montarTopo() {
    var ciclo = v('P106_CICLO'), d = (ciclo.match(/\d{2}\/\d{2}\/\d{4}/g) || []);
    var quando = d.length === 2 ? T.periodo(dataExtenso(d[0]), dataExtenso(d[1])) : nomeDe(ciclo);
    var nota = v('P106_RESULTADO_FINAL'), dim = nomeDe(v('P106_DIMENSAO')), per = nomeDe(v('P106_DESC_STATUS_CONTRATO'));
    var cancel = $id('P106_DESC_CANCELADO') && v('P106_DESC_CANCELADO');
    var topo = el('section', 'nc-ct-topo');
    topo.innerHTML =
      '<div class="nc-ct-topo-txt">' +
        '<h2 class="nc-ct-h1">' + ic('alvo', 'nc-ct-h1-ic') + esc(T.titulo) + '</h2>' +
        (quando ? '<p class="nc-ct-quando">' + ic('calendario') + '<span>' + esc(quando) + '</span></p>' : '') +
        ((dim || per) ? '<p class="nc-ct-etiquetas">' + (dim ? '<span>Metas: ' + esc(bonito(dim)) + '</span>' : '') + (per ? '<span>' + esc(bonito(per)) + '</span>' : '') + '</p>' : '') +
        (cancel ? '<p class="nc-ct-cancelado">' + ic('alerta') + esc(T.cancelado) + '</p>' : '') +
      '</div>' +
      '<div class="nc-ct-nota' + (nota ? '' : ' nc-ct-nota--sem') + '">' +
        (nota ? '<span class="nc-ct-nota-rot">' + esc(T.notaFinal) + '</span><b class="nc-ct-nota-num">' + esc(nota) + '</b>' : '<span class="nc-ct-nota-rot">' + esc(T.notaFinal) + '</span><span class="nc-ct-nota-sem">' + esc(T.semNota) + '</span>') +
      '</div>' +
      '<div class="nc-ct-acoes"></div>';
    var acoes = topo.querySelector('.nc-ct-acoes');
    var regC = regiaoDe('P106_CICLO');
    /* os botões ORIGINAIS: a página continua mostrando/escondendo cada um (ações dinâmicas) */
    var concluir = botaoNa(regC, /^concluir/), relatorio = botaoNa(regC, /relatorio/), revisar = botaoNa(regC, /^revisar/);
    var adicionar = [].filter.call(document.querySelectorAll('button.t-Button'), function (b) { return /adicionar meta/.test(sem(b.textContent)); })[0];
    function poe(b, cls, dica, txt) {
      if (!b) return;
      var w = el('div', 'nc-ct-acao ' + cls);
      b.classList.add('nc-ct-bt');
      if (txt) rotuloBotao(b, txt);
      w.appendChild(b);
      if (dica) w.appendChild(el('p', 'nc-ct-acao-dica', esc(dica)));
      acoes.appendChild(w);
    }
    poe(concluir, 'nc-ct-acao--principal', T.concluirDica);
    poe(revisar, 'nc-ct-acao--principal');
    poe(adicionar, '', T.adicionarDica, T.adicionar);
    if (relatorio) {
      poe(relatorio, 'nc-ct-acao--leve', '', T.relatorio);
      [].forEach.call(relatorio.querySelectorAll('.t-Icon, .fa'), function (i) { i.remove(); });
      relatorio.insertAdjacentHTML('afterbegin', ic('pdf'));
    }
    return topo;
  }
  /* a foto é a imagem ORIGINAL, movida (não um pedido novo ao servidor) */
  function pessoa(papel, foto, nome, linha, bt) {
    var temFoto = foto && foto.tagName === 'IMG' && foto.getAttribute('src') && !/PROFILE\.jpg/i.test(foto.getAttribute('src'));
    var c = el('div', 'nc-ct-pessoa');
    c.innerHTML = (temFoto ? '' : '<span class="nc-ct-foto nc-ct-foto--ini" aria-hidden="true">' + esc(iniciais(nome)) + '</span>') +
      '<div class="nc-ct-pessoa-txt"><span class="nc-ct-papel">' + esc(papel) + '</span><b>' + esc(nome || '—') + '</b>' + (linha ? '<span>' + esc(linha) + '</span>' : '') + '</div>';
    if (temFoto) { foto.classList.add('nc-ct-foto'); foto.alt = ''; c.insertBefore(foto, c.firstChild); }
    if (bt) { bt.classList.add('nc-ct-pessoa-bt'); bt.setAttribute('aria-label', 'Ver ' + (nome || papel)); c.appendChild(bt); }
    return c;
  }
  function montarPessoas() {
    var regA = regiaoDe('P106_MATRICULA_AVAL'), regB = regiaoDe('P106_MATRICULA_COLAB');
    var raizA = regA && (regA.parentNode.closest('.t-Region') || regA), raizB = regB && (regB.parentNode.closest('.t-Region') || regB);
    var btA = raizA && [].filter.call(raizA.querySelectorAll('.t-Region-headerItems--buttons .t-Button'), function (b) { return !b.closest('.js-maximizeButtonContainer'); })[0];
    var btB = raizB && [].filter.call(raizB.querySelectorAll('.t-Region-headerItems--buttons .t-Button'), function (b) { return !b.closest('.js-maximizeButtonContainer'); })[0];
    var box = el('section', 'nc-ct-pessoas');
    box.appendChild(pessoa(T.colaborador, $id('P106_FOTO_COLAB'), bonito(nomeDe(v('P106_MATRICULA_COLAB'))), bonito(nomeDe(v('P106_CARGO_COLAB'))), btB));
    box.appendChild(pessoa(T.avaliador, $id('P106_FOTO_AVAL'), bonito(nomeDe(v('P106_MATRICULA_AVAL'))), bonito(nomeDe(v('P106_COD_CCUSTO_AVAL'))), btA));
    /* as regiões substituídas saem da vista (os campos continuam na página) */
    [regiaoDe('P106_CICLO'), raizA, raizB].forEach(function (r) { if (r) r.classList.add('nc-ct-substituida'); });
    return box;
  }
  /* tons da divisão: o roxo do tema em intensidades, da meta 1 à última */
  var TONS = [1, .78, .6, .46, .34, .25, .18];
  function tom(i) { return TONS[i % TONS.length]; }
  function divisao(lista) {
    var soma = 0; lista.forEach(function (m) { soma += m.peso || 0; });
    var sum = num(v('P106_SUM_PERC_PESO')); if (sum !== null) soma = sum;
    var ok = Math.round(soma) === 100;
    var s = el('section', 'nc-ct-divisao');
    s.innerHTML = '<h3 class="nc-ct-h2">' + esc(T.divisao) + '</h3>' +
      '<p class="nc-ct-frase">' + esc(T.divisaoFrase(lista.length)) + '</p>' +
      '<div class="nc-ct-barra" role="img" aria-label="' + esc(lista.map(function (m) { return m.objetivo + ' ' + br(m.peso || 0) + '%'; }).join(', ')) + '">' +
        lista.map(function (m, i) {
          return '<span class="nc-ct-pedaco' + (tom(i) < .5 ? ' nc-ct-claro' : '') + '" style="flex-grow:' + (m.peso || 0) + ';--ct-tom:' + tom(i) + '" title="' + esc(m.objetivo + ': ' + br(m.peso || 0) + '%') + '">' +
            '<b>' + esc(m.n || i + 1) + '</b><i>' + esc(br(m.peso || 0)) + '%</i></span>';
        }).join('') +
      '</div>' +
      '<p class="nc-ct-soma nc-ct-soma--' + (ok ? 'ok' : 'erro') + '">' + ic(ok ? 'ok' : 'alerta') + '<span>' + esc(ok ? T.somaOk : T.somaErrada(br(soma))) + '</span></p>';
    return s;
  }

  /* ═══ [K6] 106 · OS CARTÕES E O MODO TABELA ══════════════════════════════════════════════ */
  function cartao(m, i) {
    var acao = m.acao && sem(m.acao) !== sem(m.objetivo) ? m.acao : '';
    var pc = num(m.perc);
    return '<li class="nc-ct-meta' + (tom(i) < .5 ? ' nc-ct-claro' : '') + '" style="--ct-tom:' + tom(i) + '">' +
      '<div class="nc-ct-meta-cab">' +
        '<span class="nc-ct-num" aria-hidden="true">' + esc(m.n || i + 1) + '</span>' +
        '<div class="nc-ct-meta-nome"><h3>' + esc(m.objetivo || 'Meta ' + (m.n || i + 1)) + '</h3>' +
          (m.categoria ? '<span>' + esc(m.categoria) + '</span>' : '') + '</div>' +
        (m.peso !== null ? '<span class="nc-ct-vale">' + esc(T.vale(br(m.peso))) + '</span>' : '') +
      '</div>' +
      (acao ? '<p class="nc-ct-fazer"><span>' + esc(T.oQueFazer) + '</span>' + esc(acao) + '</p>' : '') +
      '<div class="nc-ct-par">' +
        '<div class="nc-ct-dado"><span>' + esc(T.meta) + '</span><b>' + esc(m.meta || '—') + '</b></div>' +
        '<div class="nc-ct-dado' + (m.alcancado ? ' nc-ct-dado--forte' : ' nc-ct-dado--vazio') + '"><span>' + esc(T.alcancou) + '</span><b>' + esc(m.alcancado || T.semResultado) + '</b></div>' +
      '</div>' +
      (pc !== null ? '<div class="nc-ct-cumpriu"><div class="nc-ct-trilho"><i style="width:' + Math.max(2, Math.min(100, pc)) + '%"></i></div><p>' + esc(T.cumpriu(m.perc)) + (m.desemp ? ' · ' + esc(T.desempenho) + ' ' + esc(m.desemp) : '') + '</p></div>' : '') +
      '<button type="button" class="nc-ct-abrir" data-abrir="' + i + '"><span>' + esc(T.abrir) + '</span>' + ic('seta') + '</button>' +
    '</li>';
  }
  function desenhar() {
    METAS = lerMetas();
    var c = CAIXA.querySelector('.nc-ct-lista');
    var div = CAIXA.querySelector('.nc-ct-divisao');
    var nova = METAS.length ? divisao(METAS) : el('section', 'nc-ct-divisao nc-ct-divisao--vazia');
    if (div) div.replaceWith(nova); else c.parentNode.insertBefore(nova, c);
    c.innerHTML = METAS.length ? '<ol class="nc-ct-metas">' + METAS.map(cartao).join('') + '</ol>' : '<p class="nc-ct-nenhuma">' + esc(T.nenhuma) + '</p>';
  }
  var CHAVE_MODO = 'nc-ct-modo';
  function modo(m) {
    try { localStorage.setItem(CHAVE_MODO, m); } catch (e) { /* sem armazenamento */ }
    document.body.classList.toggle('nc-ct-tabela', m === 'tabela');
    [].forEach.call(document.querySelectorAll('.nc-ct-modo'), function (b) { b.hidden = b.getAttribute('data-modo') === m; });
  }
  var montado = false;
  function iniciar106() {
    if (montado) return;
    IR = document.querySelector('.a-IRR');
    if (!IR) return;   /* o relatório ainda não montou: tenta no próximo sinal */
    montado = true;
    try {
      document.body.classList.add('nc-ct-ativo');
      IRREG = IR.closest('.t-IRR-region, .t-Region') || IR.parentNode;
      var antes = regiaoDe('P106_CICLO') || IRREG;
      var ancora = antes.closest('.row') || antes;
      CAIXA = el('div', 'nc-ct');
      CAIXA.appendChild(montarTopo());
      CAIXA.appendChild(montarPessoas());
      var lista = el('div', 'nc-ct-lista'); CAIXA.appendChild(lista);
      var tb = el('button', 'nc-ct-modo', ic('tabela') + '<span>' + esc(T.verTabela) + '</span>'); tb.type = 'button'; tb.setAttribute('data-modo', 'tabela');
      CAIXA.appendChild(tb);
      ancora.parentNode.insertBefore(CAIXA, ancora);
      var volta = el('button', 'nc-ct-modo nc-ct-modo--volta', ic('cartoes') + '<span>' + esc(T.verCartoes) + '</span>'); volta.type = 'button'; volta.setAttribute('data-modo', 'cartoes');
      IRREG.parentNode.insertBefore(volta, IRREG);
      desenhar();
      var m = 'cartoes'; try { m = localStorage.getItem(CHAVE_MODO) || 'cartoes'; } catch (e) { /* padrão */ }
      modo(m);
      $(document).on('apexafterrefresh', function (e) { if (IRREG.contains(e.target) || e.target === IRREG) desenhar(); });
      document.addEventListener('click', function (e) {
        var md = e.target.closest('.nc-ct-modo'); if (md) { modo(md.getAttribute('data-modo')); return; }
        var a = e.target.closest('.nc-ct [data-abrir]');
        var card = !a && !e.target.closest('button, a') && e.target.closest('.nc-ct-meta');
        if (card) a = card.querySelector('[data-abrir]');
        if (a) { var mm = METAS[+a.getAttribute('data-abrir')]; if (mm && mm.link) mm.link.click(); }
      });
    } catch (e) { if (window.console) console.error('Natcorp_Contrato', e); }
  }

  /* ═══ [K7] 109 · A JANELA DE UMA META ════════════════════════════════════════════════════
     CUIDADO  "só leitura" = os itens ocultos P109_BTN_SAVE e P109_BTN_CREATE (o servidor os
              preenche ao abrir) não são 'S'. Aí os campos saem da vista e a meta vira texto;
              senão os campos ficam (os mesmos, com as ações dinâmicas deles) e ganham ajuda.
              Habilitar/desabilitar continua sendo das ações dinâmicas da página.
              Anterior/Próxima: os botões originais (GET_PREVIOUS_ROWID / GET_NEXT_ROWID).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function textoSel(id) { var s = $id(id); if (!s) return ''; if (s.tagName === 'SELECT') { var o = s.options[s.selectedIndex]; return o && o.value ? nomeDe(o.text) : ''; } return limpo(s.value); }
  function container(id) { return $id(id + '_CONTAINER'); }
  function iniciar109() {
    if (document.body.classList.contains('nc-ct-janela')) return;
    var reg = regiaoDe('P109_ACAO'); if (!reg) return;
    document.body.classList.add('nc-ct-janela');
    reg.classList.add('nc-ct-form');
    var leitura = v('P109_BTN_SAVE') !== 'S' && v('P109_BTN_CREATE') !== 'S';
    var nova = !v('P109_ROWID');
    document.body.classList.toggle('nc-ct-leitura', leitura);
    var pct = function () { return v('P109_TIPO_META') === 'P'; };

    /* o título da janela (fica na página de cima) */
    try {
      var dlg = window.frameElement && window.frameElement.closest('.ui-dialog');
      var tt = dlg && dlg.querySelector('.ui-dialog-title');
      if (tt) tt.textContent = nova ? T.novaMeta : (leitura ? T.janelaLer : T.janelaEditar);
    } catch (e) { /* janela de outra origem: fica o título original */ }

    /* o alto: Meta 1 de 5, a régua, o nome, quanto vale */
    var cont = /(\d+)\s*de\s*(\d+)/.exec(v('P109_ROWID_COUNT')), a = cont ? +cont[1] : 0, b = cont ? +cont[2] : 0;
    var cab = el('div', 'nc-ct-cab');
    function cabHtml() {
      var nome = textoSel('P109_COD_OBJETIVO'), cat = textoSel('P109_COD_CATEGORIA'), peso = num(v('P109_PERC_PESO'));
      var regua = '';
      if (b > 1 && b <= 30) { regua = '<div class="nc-ct-regua" aria-hidden="true">'; for (var i = 1; i <= b; i++) regua += '<i class="' + (i < a ? 'foi' : i === a ? 'aqui' : '') + '"></i>'; regua += '</div>'; }
      return (nova ? '<p class="nc-ct-passo">' + esc(T.novaMeta) + '</p>' : (b ? '<p class="nc-ct-passo">' + esc(T.metaN(a, b)) + '</p>' + regua : '')) +
        '<h2 class="nc-ct-cab-nome">' + esc(bonito(nome) || (nova ? T.novaMeta : 'Meta')) + '</h2>' +
        '<p class="nc-ct-cab-sub">' + (cat ? '<span>' + esc(bonito(cat)) + '</span>' : '') + (peso !== null ? '<span class="nc-ct-vale">' + esc(T.vale(br(peso))) + '</span>' : '') + '</p>';
    }
    cab.innerHTML = cabHtml();
    var corpo = reg.querySelector('.t-Region-body');
    corpo.insertBefore(cab, corpo.firstChild);
    $('#P109_COD_OBJETIVO, #P109_COD_CATEGORIA, #P109_PERC_PESO').on('change', function () { cab.innerHTML = cabHtml(); });

    if (leitura) {
      var fatos = el('div', 'nc-ct-fatos');
      function fatosHtml() {
        var acao = v('P109_ACAO'); if (sem(acao) === sem(textoSel('P109_COD_OBJETIVO'))) acao = '';   /* igual ao nome: não repete */
        var meta = valor(v('P109_META'), pct()), alc = valor(v('P109_VALOR_ATINGIDO'), pct());
        var perc = valor(v('P109_PERC_ATINGIDO'), true), des = valor(v('P109_DESEMP_ATINGIDO'), pct()), pc = num(perc);
        return (acao ? '<div class="nc-ct-fazer nc-ct-fazer--grande"><span>' + esc(T.oQueFazer) + '</span><p>' + esc(bonito(acao)) + '</p></div>' : '') +
          '<div class="nc-ct-par nc-ct-par--grande">' +
            '<div class="nc-ct-dado"><span>' + esc(T.meta) + '</span><b>' + esc(meta || '—') + '</b></div>' +
            '<div class="nc-ct-dado' + (alc ? ' nc-ct-dado--forte' : ' nc-ct-dado--vazio') + '"><span>' + esc(T.alcancou) + '</span><b>' + esc(alc || T.semResultado) + '</b></div>' +
          '</div>' +
          (pc !== null ? '<div class="nc-ct-cumpriu"><div class="nc-ct-trilho"><i style="width:' + Math.max(2, Math.min(100, pc)) + '%"></i></div><p>' + esc(T.cumpriu(perc)) + (des ? ' · ' + esc(T.desempenho) + ' ' + esc(des) : '') + '</p></div>' : '');
      }
      fatos.innerHTML = fatosHtml();
      corpo.insertBefore(fatos, cab.nextSibling);
      /* um valor que chega por ação dinâmica refaz o texto */
      $('#P109_VALOR_ATINGIDO, #P109_PERC_ATINGIDO, #P109_DESEMP_ATINGIDO').on('change', function () { fatos.innerHTML = fatosHtml(); });
    } else {
      /* editando: duas partes, rótulos do dia a dia e uma frase de ajuda em cada campo */
      function parte(antesDe, txt) { var c = container(antesDe); var row = c && c.closest('.row'); if (row) row.parentNode.insertBefore(el('h3', 'nc-ct-parte', esc(txt)), row); }
      parte('P109_COD_OBJETIVO', T.parteMeta);
      parte('P109_VALOR_ATINGIDO', T.parteResultado);
      Object.keys(T.dicas).forEach(function (id) {
        var c = container(id); if (!c) return;
        var ic2 = c.querySelector('.t-Form-inputContainer') || c;
        if (!c.querySelector('.nc-ct-dica')) ic2.appendChild(el('p', 'nc-ct-dica', esc(T.dicas[id])));
      });
      Object.keys(T.rotulos).forEach(function (id) { var c = container(id), l = c && c.querySelector('.t-Form-label'); if (l) l.textContent = T.rotulos[id]; });
      /* o % ao lado do número quando a meta é em percentual */
      ['P109_META', 'P109_VALOR_ATINGIDO'].forEach(function (id) {
        var i = $id(id); if (!i) return;
        var w = i.closest('.t-Form-itemWrapper') || i.parentNode;
        if (!w.querySelector('.nc-ct-unid')) w.appendChild(el('span', 'nc-ct-unid', '%'));
      });
      var unid = function () { document.body.classList.toggle('nc-ct-pct', pct()); };
      unid(); $('#P109_TIPO_META').on('change', unid);
    }

    /* os botões de baixo, com texto */
    [].forEach.call(reg.querySelectorAll('.t-Region-buttons button.t-Button, .t-Region-buttons a.t-Button'), function (bt) {
      var h = bt.outerHTML;
      if (/GET_NEXT_ROWID|GET_PREVIOUS_ROWID/.test(h) || /^(next|previous)$/i.test(bt.title || '')) bt.classList.remove('t-Button--noLabel', 't-Button--icon');   /* era só ícone: agora tem texto */
      if (/GET_NEXT_ROWID/.test(h) || /^next$/i.test(bt.title || '')) { bt.classList.add('nc-ct-prox'); rotuloBotao(bt, T.proxima); bt.querySelectorAll('.t-Icon').forEach(function (i) { i.remove(); }); if (!bt.querySelector('.nc-ct-ic')) bt.insertAdjacentHTML('beforeend', ic('seta')); }
      else if (/GET_PREVIOUS_ROWID/.test(h) || /^previous$/i.test(bt.title || '')) { bt.classList.add('nc-ct-ant'); rotuloBotao(bt, T.anterior); bt.querySelectorAll('.t-Icon').forEach(function (i) { i.remove(); }); if (!bt.querySelector('.nc-ct-ic')) bt.insertAdjacentHTML('afterbegin', ic('volta')); }
      else if (/salvar|criar/i.test(bt.textContent)) bt.classList.add('nc-ct-salvar');
      else if (/deletar/i.test(bt.textContent)) { bt.classList.add('nc-ct-apagar'); rotuloBotao(bt, 'Apagar meta'); }
      else if (/feedback/i.test(bt.textContent)) bt.classList.add('nc-ct-feedback');
      else if (/voltar/i.test(bt.textContent)) bt.classList.add('nc-ct-voltar');
    });
  }

  /* ═══ [K8] O MAESTRO ═════════════════════════════════════════════════════════════════════
     106: espera o relatório (apexreadyend, e de novo em 0,8 s e 3 s). 109: no apexreadyend
     (os valores das ações de abertura já chegaram), com reserva de 3 s.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var iniciar = PAG === 106 ? iniciar106 : iniciar109;
  $(window).one('apexreadyend', function () { setTimeout(iniciar, 0); });
  $(function () { setTimeout(iniciar, 800); setTimeout(iniciar, 3000); });
  if (document.readyState === 'complete') setTimeout(iniciar, 200);
})();
