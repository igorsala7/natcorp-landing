/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · MEDICINA DO TRABALHO  —  o resumo das consultas (JavaScript)                   ║
   ║  App 2937 · Página 39 (Pesquisa Consulta Médica)                                          ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: SESMTPAINEL-MANUTENCAO.md. A roupa é a MESMA dos outros painéis
   (Natcorp_SesmtPainel.css = cópia do Natcorp_Afastamentos.css; as peças só daqui são .nc-sm-*).

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Acima da lista de consultas, os quantitativos que o SESMT pediu (13/10), SÓ com o que a página mostra
   (as mesmas tabelas e o mesmo filtro de acesso da tabela — os números batem com ela):
     NÚMEROS     Consultas na semana · Consultas no mês (cada um com os MESMOS dias do período anterior)
                 · Colaboradores atendidos · Total de consultas. Tocar em semana ou mês abre o que entrou
                 nele: por tipo de consulta e por médico, com o número do período anterior ao lado.
     NO PERÍODO  12 meses, 2 anos, 5 anos ou tudo: a frase (consultas, colaboradores, comparação, quem mais
                 atendeu), consultas no tempo, por tipo de consulta, por médico e a idade de quem foi atendido.
   ASO vencido, exames, restrições e doenças NÃO entram aqui (são outras tabelas): ficam para os
   dashboards das páginas delas. Os números vêm do processo NC_SESMT_INDICADORES.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não grava nada. "Ver na tabela" põe o filtro da própria tabela (o mesmo de Ações › Filtro;
       a pessoa tira no × do filtro).

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 39 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_SesmtPainel.js
     Página 39 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_SesmtPainel.css
     Página 39 › Processing › Ajax Callback NC_SESMT_INDICADORES (NC_SESMT_INDICADORES.plsql.sql)
   Tudo já vem na exportação f2937_page_39.sql (aplicar-sesmt-pagina39.py).

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [S1] Textos e regras ................ os 4 números, as faixas, as colunas da tabela  PODE MEXER
     [S2] Os dados · [S3] A moldura · [S4] Os números · [S5] No período · [S6] Ver na tabela · [S7] O começo
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncSesmt) return;
  window.__ncSesmt = true;

  /* ═══ [S1] TEXTOS E REGRAS ══════════════════════════════════════════════════════════════ */
  var PROCESSO = 'NC_SESMT_INDICADORES';
  var POR_VEZ = 30, POR_VEZ_Q = 6;
  var GUARDA = 'nc-sm-aberto', GUARDA_PER = 'nc-sm-per';
  var VALIDADE = 10 * 60 * 1000;           /* o painel calculado vale 10 min nesta aba */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  var PERIODOS = [{ m: 12, t: '12 meses' }, { m: 24, t: '2 anos' }, { m: 60, t: '5 anos' }, { m: 0, t: 'Tudo' }];
  /* a classificação do ASO do tipo (tipo_consulta.classificacao_aso): quando o cadastro tem, o nome vai
     embaixo do tipo no quadro "Por tipo de consulta" ("ASO periódico") */
  var ASO = [
    { c: 'A', t: 'Admissional',          d: 'antes de começar' },
    { c: 'P', t: 'Periódico',            d: 'durante o contrato, no prazo do PCMSO' },
    { c: 'R', t: 'Retorno ao trabalho',  d: 'depois de afastamento de 30 dias ou mais' },
    { c: 'M', t: 'Mudança de função',    d: 'antes de mudar de risco' },
    { c: 'D', t: 'Demissional',          d: 'na saída' }
  ];
  var ASO_C = {}; ASO.forEach(function (x) { ASO_C[x.c] = x; });
  var FAIXAS = ['até 24 anos', '25 a 34 anos', '35 a 44 anos', '45 a 54 anos', '55 anos ou mais', 'sem data de nascimento'];
  /* as colunas da tabela que o "Ver na tabela" filtra */
  var COL = { tipo: 'DESCRICAO_CONSULTA', med: 'ATENDENTE', mat: 'MATRICULA' };

  /* os 4 NÚMEROS (pedido do cliente): semana e mês abrem o que entrou neles */
  var NUMEROS = [
    { k: 'sem', cor: 'roxo',  ic: 'calend',  diz: 'Consultas na semana', abre: true },
    { k: 'mes', cor: 'rosa',  ic: 'mes',     diz: 'Consultas no mês',    abre: true },
    { k: 'col', cor: 'verde', ic: 'pessoas', diz: 'Colaboradores atendidos' },
    { k: 'tot', cor: 'roxo',  ic: 'pasta',   diz: 'Total de consultas' }
  ];
  var SEMANA = ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sáb'];

  var IC = {
    tabela: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    descer: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    atualiza: '<path d="M20 11a8 8 0 0 0-14.6-4.5L4 8"/><path d="M4 4v4h4"/><path d="M4 13a8 8 0 0 0 14.6 4.5L20 16"/><path d="M20 20v-4h-4"/>',
    calend: '<rect x="4" y="5" width="16" height="15" rx="2.5"/><path d="M4 9.5h16M8.5 3v4M15.5 3v4M8 13.5h2M8 16.5h2"/>',
    mes: '<rect x="4" y="5" width="16" height="15" rx="2.5"/><path d="M4 9.5h16M8.5 3v4M15.5 3v4M8 13h8M8 16.5h8"/>',
    pessoas: '<circle cx="9" cy="8" r="3.2"/><path d="M3.5 19c.6-3.2 2.8-5 5.5-5s4.9 1.8 5.5 5"/><circle cx="17" cy="9" r="2.4"/><path d="M15.5 14.2c2.4.1 4.3 1.6 5 4.8"/>',
    pasta: '<path d="M4 7.5V18a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 20 18V9.5A1.5 1.5 0 0 0 18.5 8H12l-2-2.5H5.5A1.5 1.5 0 0 0 4 7v.5z"/>',
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
  function semAcento(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase(); }
  function partes(t) { var m = /^(\S+)\s+-\s*(.*)$/.exec(t || ''); return m ? [m[1], m[2]] : ['', t || '']; }
  function pctTxt(a, b) { if (!b) return ''; var p = (a - b) / Math.abs(b) * 100; return (p > 0 ? '+' : '') + p.toLocaleString('pt-BR', { maximumFractionDigits: Math.abs(p) < 10 ? 1 : 0 }) + '%'; }
  /* nomes em MAIÚSCULAS ficam com a primeira letra de cada palavra (de/da/do continuam miúdos) */
  function bonito(t) {
    t = String(t == null ? '' : t).trim();
    if (t !== t.toUpperCase()) return t;
    return t.toLowerCase().replace(/[^\s\/()\-.,]+/g, function (w, i) {
      return i > 0 && /^(de|da|do|das|dos|e)$/.test(w) ? w : w.charAt(0).toUpperCase() + w.slice(1);
    });
  }
  function ym(d) { return d.getFullYear() * 100 + d.getMonth() + 1; }
  function ymTxt(k) { k = String(k); return MESES[+k.slice(4, 6) - 1] + '/' + k.slice(0, 4); }

  /* ═══ [S2] OS DADOS ═════════════════════════════════════════════════════════════════════ */
  function buscar(forcar) {
    var k = 'nc-sm-dados1', c = null;
    try { c = JSON.parse(sessionStorage.getItem(k) || 'null'); } catch (e) { /* ok */ }
    if (!forcar && c && c.d && Date.now() - c.t < VALIDADE) { desenhar(c.d, c.t); return; }
    carregando();
    apex.server.process(PROCESSO, {}, { dataType: 'json', error: function () { /* tratado no .fail */ } })
      .done(function (d) {
        pararCalculo();
        if (!d || d.erro) return erro(d && d.erro);
        try { sessionStorage.setItem(k, JSON.stringify({ t: Date.now(), d: d })); } catch (e) { /* cheio: só não guarda */ }
        try { desenhar(d, Date.now()); } catch (e) { erro(e && e.message); }
      })
      .fail(function (x) { pararCalculo(); erro(x && (x.status === 404 || (x.status === 200 && !x.responseText)) ? 'processo ausente' : (x && x.responseText || '').slice(0, 160)); });
  }

  /* ═══ [S3] A MOLDURA ═══════════════════════════════════════════════════════════════════ */
  var P = null;
  /* a região da lista de consultas: o primeiro Interactive Report da página */
  function relatorio() {
    /* a REGIÃO (não o widget "…_ir" de dentro dela, que também começa com R) */
    var w = document.querySelector('.a-IRR-container'), r = w && (w.closest('.t-IRR-region') || w.closest('.t-Region'));
    return r ? { el: r, id: r.id } : null;
  }
  function montar() {
    if (P) return true;
    var ir = relatorio();
    if (!ir) return false;
    ir.el.classList.add('nc-reg-sim');
    var caixa = el('section', 'nc-af nc-sm');
    caixa.setAttribute('aria-labelledby', 'nc-sm-titulo');
    caixa.innerHTML =
      '<header class="nc-af-cab"><h2 id="nc-sm-titulo">Resumo das consultas</h2>' +
      '<p class="nc-af-quando" aria-live="polite"></p><span class="nc-af-espaco"></span>' +
      '<button type="button" class="nc-af-bt" data-af-ir-tabela>' + ic('descer') + '<span>Ir para a tabela</span></button>' +
      '<button type="button" class="nc-af-bt" data-sm-atualiza hidden>' + ic('atualiza') + '<span>Atualizar</span></button>' +
      '<button type="button" class="nc-af-bt" data-sm-esconde aria-controls="nc-sm-corpo"></button></header>' +
      '<div class="nc-af-corpo" id="nc-sm-corpo"></div>';
    ir.el.parentNode.insertBefore(caixa, ir.el);
    P = { caixa: caixa, corpo: caixa.querySelector('.nc-af-corpo'), quando: caixa.querySelector('.nc-af-quando'), botao: caixa.querySelector('[data-sm-esconde]'),
          ir: ir.id, filtro: null, per: 12 };
    try { var per = localStorage.getItem(GUARDA_PER); if (per != null && PERIODOS.some(function (x) { return String(x.m) === per; })) P.per = +per; } catch (e) { /* ok */ }
    var aberto = false; try { aberto = localStorage.getItem(GUARDA) === '1'; } catch (e) { /* ok */ }
    abrirFechar(aberto);
    caixa.addEventListener('click', clique);
    return true;
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
    if (b.hasAttribute('data-sm-esconde')) return abrirFechar(P.caixa.classList.contains('is-fechado'));
    if (b.hasAttribute('data-sm-num')) { var k = b.getAttribute('data-sm-num'); P.filtro = P.filtro === k ? null : k; desenharNumeros(); return; }
    if (b.hasAttribute('data-sm-per')) {
      P.per = +b.getAttribute('data-sm-per');
      try { localStorage.setItem(GUARDA_PER, String(P.per)); } catch (e2) { /* ok */ }
      desenharPeriodo();
      var f = P.caixa.querySelector('[data-sm-per="' + P.per + '"]'); if (f) f.focus({ preventScroll: true });
      return;
    }
    if (b.hasAttribute('data-af-revela')) { revelar(b.previousElementSibling, +b.getAttribute('data-af-revela'), true); return; }
    if (b.hasAttribute('data-sm-f')) { filtrar(P.fx[+b.getAttribute('data-sm-f')]); return; }
    if (b.hasAttribute('data-af-ir-tabela')) { irParaTabela(); return; }
    if (b.hasAttribute('data-sm-tenta') || b.hasAttribute('data-sm-atualiza')) buscar(true);
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
    P.corpo.innerHTML = '<div class="nc-af-secao" aria-busy="true"><div class="nc-af-regua">' + NUMEROS.map(function (h) {
      return '<div class="nc-af-num is-carregando"><span class="nc-af-sinal">' + ic(h.ic) + '</span><span class="nc-af-valor"><i class="nc-af-esq" style="width:56px;height:26px"></i></span><span class="nc-af-diz">' + h.diz + '</span></div>';
    }).join('') + '</div></div>';
    P.quando.textContent = 'Calculando…';
    P.caixa.querySelector('[data-sm-atualiza]').hidden = true;
    pararCalculo();
    P.lento = calculando(['Contando as consultas…', 'Separando por tipo e por médico…', 'Contando os colaboradores atendidos…', 'Ainda calculando: com muitas consultas leva mais tempo']);
  }
  function erro(msg) {
    var falta = /processo ausente|NC_SESMT|ERR-1002|not found/i.test(msg || '');
    P.quando.textContent = '';
    P.corpo.innerHTML = '<div class="nc-af-aviso" role="alert">' + ic('aviso') + '<div><b>Não foi possível montar o painel agora.</b>' +
      (falta ? 'Falta instalar nesta página o processo ' + PROCESSO + ' (veja o guia SESMTPAINEL-MANUTENCAO.md). A tabela abaixo funciona normalmente.'
             : 'A tabela abaixo continua funcionando. Tente de novo em instantes; se continuar, avise a equipe de sistemas.' + (msg ? ' <small>(' + esc(msg) + ')</small>' : '')) +
      '</div><span class="nc-af-espaco"></span><button type="button" class="nc-af-bt" data-sm-tenta>Tentar de novo</button></div>';
  }

  /* ═══ [S4] OS NÚMEROS ══════════════════════════════════════════════════════════════════════
     SEMANA  da segunda-feira até hoje; comparada com os MESMOS dias da semana passada.
     MÊS     do dia 1 até hoje; comparado com os MESMOS dias do mês passado.
     (comparar a semana inteira de antes com uma semana pela metade daria sempre "caiu")
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function falhou(bloco) { return (P.dados.falhas || []).filter(function (f) { return f.indexOf(bloco + ':') === 0; })[0]; }
  function jan(k) { return ((P.dados.jan || {})[k]) || null; }
  function dma(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2); }
  function ymd(d) { return d.getFullYear() * 10000 + (d.getMonth() + 1) * 100 + d.getDate(); }
  /* os dias de cada janela (AAAAMMDD), para somar o "dia" do servidor */
  function dias(k) {
    var h = P.hoje, ini, fim = h;
    if (k === 'sem' || k === 'semAnt') { var seg = new Date(h.getFullYear(), h.getMonth(), h.getDate() - ((h.getDay() + 6) % 7)); ini = seg; }
    else { ini = new Date(h.getFullYear(), h.getMonth(), 1); }
    if (k === 'semAnt') { ini = new Date(ini.getFullYear(), ini.getMonth(), ini.getDate() - 7); fim = new Date(h.getFullYear(), h.getMonth(), h.getDate() - 7); }
    if (k === 'mesAnt') {
      ini = new Date(h.getFullYear(), h.getMonth() - 1, 1);
      var ult = new Date(h.getFullYear(), h.getMonth(), 0).getDate();
      fim = new Date(h.getFullYear(), h.getMonth() - 1, Math.min(h.getDate(), ult));
    }
    return { ini: ini, fim: fim, a: ymd(ini), b: ymd(fim) };
  }
  /* o que entrou numa janela: por tipo e por médico (do "dia" do servidor) */
  function quebra(k) {
    var J = dias(k), o = { n: 0, tipo: {}, med: {} };
    (P.dados.dia || []).forEach(function (r) {
      var d = +r[0], n = +r[3] || 0; if (d < J.a || d > J.b) return;
      o.n += n; o.tipo[r[1]] = (o.tipo[r[1]] || 0) + n; o.med[r[2]] = (o.med[r[2]] || 0) + n;
    });
    return o;
  }
  function desenhar(d, quando) {
    pararCalculo();
    P.caixa.classList.add('is-novo'); setTimeout(function () { P.caixa.classList.remove('is-novo'); }, 1400);
    var hoje = data(d.hoje) || new Date();
    P.hoje = new Date(hoje.getFullYear(), hoje.getMonth(), hoje.getDate());
    P.dados = d; P.filtro = null; P.fx = [];
    P.hm = quando ? new Date(quando).toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }) : '';
    P.quando.innerHTML = 'Hoje, <b>' + esc(d.hoje) + '</b> · as consultas da tabela abaixo' + (P.hm ? ' · calculado às ' + P.hm : '');
    P.caixa.querySelector('[data-sm-atualiza]').hidden = false;
    P.corpo.innerHTML = '<div class="nc-af-secao"><div class="nc-af-regua" role="group" aria-label="Os números das consultas"></div>' +
      '<div class="nc-af-quem nc-sm-quebra" id="nc-sm-quem" hidden aria-live="polite"></div></div><div class="nc-af-secao nc-af-periodo"></div>';
    desenharNumeros();
    desenharPeriodo();
  }
  function comp(a, b, quando) {
    if (b == null) return '';
    if (!a && !b) return '<span class="nc-sm-comp">nenhuma ' + quando + ' também</span>';
    /* neutro: mais ou menos consultas não é bom nem ruim por si */
    return '<span class="nc-sm-comp">' + (a === b ? 'igual a ' : (pctTxt(a, b) || '+' + num(a)) + ' sobre ') + quando + ' (' + num(b) + ')</span>';
  }
  function desenharNumeros() {
    var f = falhou('jan'), S = jan('sem'), SA = jan('semAnt'), M = jan('mes'), MA = jan('mesAnt'), A12 = jan('12'), T = jan('0');
    var Js = dias('sem'), Jm = dias('mes');
    P.caixa.querySelector('.nc-af-regua').innerHTML = NUMEROS.map(function (h) {
      var v = null, unid = ['consulta', 'consultas'], dica = '', extra = '';
      if (h.k === 'sem' && S) {
        v = S.n; dica = (Js.ini.getTime() === Js.fim.getTime() ? 'hoje, ' + SEMANA[Js.ini.getDay()] : SEMANA[Js.ini.getDay()] + ' ' + dma(Js.ini) + ' a hoje') + ' · ' + plural(S.p, 'colaborador', 'colaboradores');
        extra = comp(S.n, SA && SA.n, 'a semana passada');
      } else if (h.k === 'mes' && M) {
        v = M.n; dica = (P.hoje.getDate() === 1 ? 'hoje, dia 1' : 'dia 1 a ' + dma(Jm.fim)) + ' · ' + plural(M.p, 'colaborador', 'colaboradores');
        extra = comp(M.n, MA && MA.n, 'o mês passado');
      } else if (h.k === 'col' && A12) {
        v = A12.p; unid = ['colaborador', 'colaboradores'];
        dica = 'nos últimos 12 meses' + (M ? ' · ' + num(M.p) + ' no mês' : '') + (S ? ' · ' + num(S.p) + ' na semana' : '');
      } else if (h.k === 'tot' && T) {
        var pri = primeiroMes();
        v = T.n; dica = 'de ' + plural(T.p, 'colaborador', 'colaboradores') + (pri ? ' · desde ' + ymTxt(pri) : '');
      }
      var toca = h.abre && v, on = P.filtro === h.k;
      var valor = v == null ? '<span class="nc-af-valor is-texto">—</span>' : '<span class="nc-af-valor">' + num(v) + '<small>' + (v === 1 ? unid[0] : unid[1]) + '</small></span>';
      return '<' + (toca ? 'button type="button" data-sm-num="' + h.k + '" aria-pressed="' + on + '" aria-controls="nc-sm-quem"' : 'div') +
        ' class="nc-af-num nc-af-num--' + h.cor + (v ? '' : ' is-zero') + (toca ? '' : ' nc-sm-fixo') + '"' + (f && v == null ? ' title="' + esc(f) + '"' : '') + '>' +
        '<span class="nc-af-sinal">' + ic(h.ic) + '</span>' + valor + '<span class="nc-af-diz">' + h.diz + '</span>' +
        '<span class="nc-af-dica">' + (v == null ? 'não foi possível calcular' : dica + (toca ? ' · toque para ver por tipo' : '')) + '</span>' + extra +
        '</' + (toca ? 'button' : 'div') + '>';
    }).join('');
    desenharQuebra();
  }
  function primeiroMes() { var p = null; (P.dados.cons || []).forEach(function (r) { var k = +r[0]; if (k && (!p || k < p)) p = k; }); return p; }
  /* tocar em SEMANA ou MÊS: o que entrou nele, por tipo de consulta e por médico, com o anterior ao lado */
  function desenharQuebra() {
    var box = P.caixa.querySelector('.nc-af-quem');
    if (!P.filtro) { box.hidden = true; box.innerHTML = ''; return; }
    var k = P.filtro, ant = k === 'sem' ? 'semAnt' : 'mesAnt', A = quebra(k), B = quebra(ant), J = dias(k), JB = dias(ant), dm = P.dados.dims || {};
    var rot = k === 'sem' ? 'Nesta semana' : 'Neste mês', rotAnt = (k === 'sem' ? 'da semana passada' : 'do mês passado') + ' (' + dma(JB.ini) + ' a ' + dma(JB.fim) + ')';
    function lado(o, ob, nomes, unid) {
      var ks = Object.keys(o).concat(Object.keys(ob).filter(function (x) { return !(x in o); }));
      var xs = ks.map(function (x) { return { t: nomes[x], q: o[x] || 0, a: ob[x] || 0 }; }).sort(function (p, q) { return q.q - p.q || q.a - p.a; });
      if (!xs.length) return '<p class="nc-af-vazio-q">Nenhuma consulta.</p>';
      var max = Math.max.apply(null, xs.map(function (x) { return Math.max(x.q, x.a); })) || 1;
      return '<ol class="nc-af-barras">' + xs.map(function (x) {
        var p = partes(x.t);
        return '<li><div class="nc-af-b nc-af-b--fixa"><span class="nc-af-b-nome">' + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(bonito(p[1] || x.t)) + '</span>' +
          '<span class="nc-af-b-trilho nc-sm-duplo" aria-hidden="true"><i style="width:' + (x.q ? Math.max(3, Math.round(x.q / max * 100)) : 0) + '%"></i><b style="left:' + Math.round(x.a / max * 100) + '%"></b></span>' +
          '<span class="nc-af-b-num">' + num(x.q) + ' <small>' + (x.q === 1 ? unid[0] : unid[1]) + ' · antes ' + num(x.a) + '</small></span></div></li>';
      }).join('') + '</ol>';
    }
    box.hidden = false;
    box.innerHTML = '<div class="nc-af-quem-cab"><h3>' + rot + ': ' + plural(A.n, 'consulta', 'consultas') + '</h3><p>' + dma(J.ini) + ' a ' + dma(J.fim) +
      ' · "antes" = os mesmos dias ' + rotAnt + ' · a marca na barra mostra o antes</p></div>' +
      (falhou('dia') ? '<p class="nc-af-nota">Não foi possível ler as consultas dia a dia nesta base.</p>' :
      '<div class="nc-af-quadros nc-sm-quebra-q"><section class="nc-af-q"><h3>Por tipo de consulta</h3>' + lado(A.tipo, B.tipo, dm.tipo || [], ['consulta', 'consultas']) + '</section>' +
      '<section class="nc-af-q"><h3>Por médico</h3>' + lado(A.med, B.med, dm.med || [], ['consulta', 'consultas']) + '</section></div>');
  }

  /* ── listas que vão aparecendo (a mesma mecânica dos outros painéis) ── */
  function rolo(tag, cls, itens, passo, unid) {
    return '<div class="nc-af-rolo" data-sm-unid="' + unid.join('|') + '"><' + tag + ' class="' + cls + '">' +
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
    var falta = escondidos(r).length, passo = +bt.getAttribute('data-af-revela'), u = r.getAttribute('data-sm-unid').split('|');
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

  /* ═══ [S5] NO PERÍODO ═══════════════════════════════════════════════════════════════════
     As contas são feitas aqui, por mês: período = os últimos N meses contando o mês de hoje; o
     anterior = os N meses antes dele. "Pessoas" vem pronto do servidor (não dá para somar meses).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function janela(m) {
    if (!m) return { ini: 0, fim: 999999, aIni: null, aFim: null };
    var h = P.hoje, ini = new Date(h.getFullYear(), h.getMonth() - (m - 1), 1), aIni = new Date(h.getFullYear(), h.getMonth() - (2 * m - 1), 1);
    return { ini: ym(ini), fim: ym(h), aIni: ym(aIni), aFim: ym(new Date(ini.getFullYear(), ini.getMonth() - 1, 1)), dIni: ini };
  }
  function agregar() {
    var d = P.dados, J = janela(P.per);
    var A = { n: 0, antes: 0, meses: {}, tipo: {}, med: {}, fx: [0, 0, 0, 0, 0, 0], primeiro: null };
    function soma(o, k, v) { o[k] = (o[k] || 0) + v; }
    (d.cons || []).forEach(function (r) {
      var k = +r[0], n = +r[4] || 0; if (!k) return;
      if (!A.primeiro || k < A.primeiro) A.primeiro = k;
      if (J.aIni && k >= J.aIni && k <= J.aFim) A.antes += n;
      if (k < J.ini || k > J.fim) return;
      A.n += n;
      soma(A.meses, k, n);
      soma(A.tipo, r[1], n);
      soma(A.med, r[2], n);
      A.fx[r[3]] = (A.fx[r[3]] || 0) + n;
    });
    var jj = jan(String(P.per)); A.pessoas = jj ? jj.p : null;
    A.J = J;
    return A;
  }
  function lista(o, nomes) {
    return Object.keys(o).map(function (k) { return { k: k, t: nomes ? nomes[k] : k, q: o[k] }; }).filter(function (x) { return x.q; }).sort(function (a, b) { return b.q - a.q; });
  }
  function desenharPeriodo() {
    var A = P.A = agregar(), d = P.dados, dm = d.dims || {}, per = PERIODOS.filter(function (x) { return x.m === P.per; })[0];
    var rot = P.per ? 'Nos últimos ' + per.t : 'Desde o primeiro registro';
    var seletor = '<div class="nc-ac-per" role="group" aria-label="Período do painel">' + PERIODOS.map(function (x) {
      return '<button type="button" data-sm-per="' + x.m + '" aria-pressed="' + (x.m === P.per) + '">' + x.t + '</button>';
    }).join('') + '</div>';
    var frase;
    if (falhou('cons')) frase = '<p class="nc-af-frase">Não foi possível contar as consultas nesta base <small>(' + esc(falhou('cons')) + ')</small>.</p>';
    else if (!A.n) frase = '<p class="nc-af-frase">Nenhuma consulta neste período.' + (A.primeiro ? ' A mais recente é de <b>' + ymTxt(ultimoMes()) + '</b> — toque em "Tudo".' : '') + '</p>';
    else {
      var tipos = lista(A.tipo, dm.tipo), top = tipos[0];
      frase = '<p class="nc-af-frase"><b>' + plural(A.n, 'consulta', 'consultas') + '</b>' + (A.pessoas ? ' de <b>' + plural(A.pessoas, 'colaborador', 'colaboradores') + '</b>' : '') +
        (top ? '. A mais comum: <b>' + esc(bonito(partes(top.t)[1] || top.t)) + '</b> (' + plural(top.q, 'consulta', 'consultas') + ', ' + Math.round(top.q / A.n * 100) + '%)' : '') + '.';
      var extra = [];
      if (P.per && A.antes) {
        var dif = A.n - A.antes;
        extra.push('No período anterior, do mesmo tamanho: ' + plural(A.antes, 'consulta', 'consultas') + (dif === 0 ? ' — igual.' : ' — <b>' + pctTxt(A.n, A.antes) + '</b> agora.'));
      }
      var med = lista(A.med, dm.med)[0];
      if (med && A.n) extra.push('Quem mais atendeu: <b>' + esc(bonito(partes(med.t)[1] || med.t)) + '</b> (' + Math.round(med.q / A.n * 100) + '% das consultas).');
      frase += (extra.length ? '<span class="nc-af-taxa">' + extra.join(' ') + '</span>' : '') + '</p>';
    }
    var tem = A.n > 0;
    P.caixa.querySelector('.nc-af-periodo').innerHTML = '<div class="nc-ac-per-cab"><p class="nc-af-rot">' + rot + '</p>' + seletor + '</div>' + frase +
      (tem ? '<div class="nc-af-quadros nc-af-quadros--3">' +
        quadro('Consultas no tempo', 'Passe o mouse nas colunas para ver o número', meses(A.meses, A.J.dIni || inicio(A.primeiro), P.hoje), 'nc-af-q--meses') +
        quadro('Por tipo de consulta', 'Quantas de cada tipo · toque para ver na tabela',
          barras(lista(A.tipo, dm.tipo).map(function (x) { var c = ASO_C[(dm.cls || [])[x.k]]; if (c) x.sub = 'ASO ' + c.t.toLowerCase(); return x; }), A.n, function (x) { return { col: COL.tipo, vals: [(dm.tipoDesc || [])[x.k]], rot: 'as consultas de ' + bonito(partes(x.t)[1]) }; })) +
        quadro('Por médico', 'Quantas consultas cada um fez · toque para ver na tabela',
          barras(lista(A.med, dm.med), A.n, function (x) { return { col: COL.med, vals: [x.t], rot: 'os atendimentos de ' + bonito(partes(x.t)[1]) }; })) +
        quadro('Idade de quem foi atendido', 'Na data do atendimento', idades(A)) +
        '</div>' : '');
    ligarRolos(P.caixa.querySelector('.nc-af-periodo'));
    ajustarMeses();
  }
  function ultimoMes() { var p = null; (P.dados.cons || []).forEach(function (r) { var k = +r[0]; if (k && (!p || k > p)) p = k; }); return p; }
  function inicio(k) { k = String(k || ''); return k ? new Date(+k.slice(0, 4), +k.slice(4, 6) - 1, 1) : P.hoje; }
  function quadro(tit, dica, corpo, cls) { return '<section class="nc-af-q' + (cls ? ' ' + cls : '') + '"><h3>' + tit + '</h3><p>' + dica + '</p>' + corpo + '</section>'; }
  /* um filtro guardado para o botão (data-sm-f = posição na lista) */
  function fx(f) { if (!f || !f.col || !f.vals || !f.vals.length || !f.vals[0]) return ''; P.fx.push(f); return ' data-sm-f="' + (P.fx.length - 1) + '"'; }
  function barras(xs, total, filtro, unid) {
    unid = unid || ['consulta', 'consultas'];
    if (!xs.length) return '<p class="nc-af-vazio-q">Nada neste período.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return x.q; })) || 1;
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var p = partes(x.t), pct = total ? Math.round(x.q / total * 100) : null, f = filtro ? fx(filtro(x)) : '';
      var miolo = '<span class="nc-af-b-nome">' + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(bonito(p[1] || x.t)) + (x.sub ? '<small class="nc-sm-sub">' + esc(x.sub) + '</small>' : '') + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(x.q / max * 100)) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + num(x.q) + ' <small>' + (x.q === 1 ? unid[0] : unid[1]) + (pct != null ? ' · ' + (pct < 1 ? '&lt;1' : pct) + '%' : '') + '</small></span>';
      return f ? '<li><button type="button" class="nc-af-b' + (i === 0 ? ' is-maior' : '') + '"' + f + ' title="Ver na tabela">' + miolo + '<span class="nc-af-b-ir" aria-hidden="true">Ver na tabela' + ic('tabela') + '</span></button></li>'
               : '<li><div class="nc-af-b nc-af-b--fixa' + (i === 0 ? ' is-maior' : '') + '">' + miolo + '</div></li>';
    }), POR_VEZ_Q, ['linha', 'linhas']);
  }
  function idades(A) {
    var tot = A.fx.reduce(function (a, b) { return a + (b || 0); }, 0);
    if (!tot) return '<p class="nc-af-vazio-q">Nada neste período.</p>';
    var max = Math.max.apply(null, A.fx.slice(0, 5)) || 1;
    return '<ol class="nc-af-barras">' + FAIXAS.map(function (t, i) {
      var q = A.fx[i] || 0; if (i === 5 && !q) return '';
      return '<li><div class="nc-af-b nc-af-b--fixa"><span class="nc-af-b-nome">' + t + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + (q ? Math.max(3, Math.round(q / max * 100)) : 0) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + num(q) + ' <small>' + Math.round(q / tot * 100) + '%</small></span></div></li>';
    }).join('') + '</ol><p class="nc-af-pico">Acima de 45 anos, o PCMSO costuma pedir exame periódico todo ano.</p>';
  }
  /* MÊS A MÊS que se adapta ao período: até 24 meses, por mês; até 72, por trimestre; acima, por ano */
  function meses(ms, ini, fim) {
    if (!ini || !fim) return '';
    var lista2 = [], c = new Date(ini.getFullYear(), ini.getMonth(), 1), ultimo = new Date(fim.getFullYear(), fim.getMonth(), 1);
    while (c <= ultimo && lista2.length < 600) { lista2.push(new Date(c)); c.setMonth(c.getMonth() + 1); }
    var nMes = lista2.length, modo = nMes <= 24 ? 'mes' : nMes <= 72 ? 'tri' : 'ano', grupos = [];
    lista2.forEach(function (m) {
      var tri = Math.floor(m.getMonth() / 3) + 1;
      var k = modo === 'mes' ? ym(m) : modo === 'tri' ? m.getFullYear() + 'T' + tri : String(m.getFullYear());
      var g = grupos[grupos.length - 1];
      if (!g || g.k !== k) {
        g = { k: k, v: 0, ano: m.getFullYear(),
              curto: modo === 'mes' ? MESES[m.getMonth()] : modo === 'tri' ? tri + 'º tri' : String(m.getFullYear()),
              dica: modo === 'mes' ? MESES[m.getMonth()] + '/' + m.getFullYear() : modo === 'tri' ? tri + 'º trimestre de ' + m.getFullYear() : String(m.getFullYear()),
              novoAno: modo !== 'ano' && (grupos.length === 0 || m.getMonth() < (modo === 'mes' ? 1 : 3)),
              marco: modo === 'ano' || grupos.length === 0 || (modo === 'mes' ? m.getMonth() % 3 === 0 : tri === 1),
              atual: m.getFullYear() === fim.getFullYear() && (modo === 'ano' || (modo === 'mes' ? m.getMonth() === fim.getMonth() : Math.floor(m.getMonth() / 3) === Math.floor(fim.getMonth() / 3))) };
        grupos.push(g);
      }
      g.v += ms[ym(m)] || 0;
    });
    if (!grupos.some(function (g) { return g.v; })) return '<p class="nc-af-vazio-q">Nenhuma consulta neste período.</p>';
    var max = Math.max.apply(null, grupos.map(function (g) { return g.v; })) || 1;
    var pico = grupos.reduce(function (a, g) { return g.v > a.v ? g : a; }, grupos[0]);
    var por = modo === 'mes' ? 'mês' : modo === 'tri' ? 'trimestre' : 'ano';
    return '<p class="nc-af-por">Por ' + por + '</p><ol class="nc-af-meses">' + grupos.map(function (g) {
      var rot = g.dica + ': ' + plural(g.v, 'consulta', 'consultas');
      return '<li class="nc-af-mes' + (g.atual ? ' is-atual' : '') + (g.marco ? ' is-marco' : '') + (g === pico ? ' is-pico' : '') + '" tabindex="0" aria-label="' + rot + '" data-dica="' + rot + '">' +
        '<b>' + (g.v ? num(g.v) : '') + '</b><i style="height:' + (g.v ? Math.max(4, Math.round(g.v / max * 100)) : 0) + '%"></i><span>' + g.curto + (g.novoAno ? '<em>' + g.ano + '</em>' : '') + '</span></li>';
    }).join('') + '</ol><p class="nc-af-pico">' + (modo === 'mes' ? 'Mês' : modo === 'tri' ? 'Trimestre' : 'Ano') + ' com mais: <b>' + pico.dica + '</b> · ' + plural(pico.v, 'consulta', 'consultas') + '</p>';
  }
  function ajustarMeses() {
    var ol = P && P.caixa.querySelector('.nc-af-meses'); if (!ol || !ol.children.length) return;
    ol.classList.toggle('is-denso', ol.clientWidth / ol.children.length < 34);
  }
  window.addEventListener('resize', function () { clearTimeout(window.__ncSmAj); window.__ncSmAj = setTimeout(ajustarMeses, 120); });

  /* ═══ [S6] VER NA TABELA ════════════════════════════════════════════════════════════════
     O FILTRO da própria tabela (o mesmo de Ações › Filtro): um valor = "=", vários = "em" (separado
     por vírgula). Tocar de novo noutra coisa da MESMA coluna troca o filtro que o painel pôs; um filtro
     posto à mão na mesma coluna é DESLIGADO (fica na lista, desmarcado). Sem o widget, a busca da tabela.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function widget() { return document.getElementById(P.ir + '_ir') || (P.caixa.parentNode && P.caixa.parentNode.querySelector('[id$="_ir"]')); }
  function idsFiltros() {
    var w = widget(); if (!w) return [];
    return [].map.call(w.querySelectorAll('input[data-setting="filter"][data-filter-id]'), function (e) { return e.getAttribute('data-filter-id'); });
  }
  function textoFiltro(id) { var t = document.getElementById('control_text_' + id); return t ? t.textContent.trim() : ''; }
  function mesmaColuna(id) {
    var m = /^(.+?) (=|em|in) /i.exec(textoFiltro(id)); if (!m) return [];
    var col = m[1] + ' ', w = widget();
    return [].filter.call(w.querySelectorAll('input[data-setting="filter"][data-filter-id]'), function (e) {
      var o = e.getAttribute('data-filter-id');
      return o !== id && e.checked && textoFiltro(o).indexOf(col) === 0;
    }).map(function (e) { return e.getAttribute('data-filter-id'); });
  }
  function meusFiltros(novo) {
    var k = 'nc-sm-filtros:' + P.ir;
    try { if (novo) sessionStorage.setItem(k, JSON.stringify(novo)); return novo || JSON.parse(sessionStorage.getItem(k) || '{}'); } catch (e) { return novo || {}; }
  }
  function filtrar(f) {
    if (!f) return;
    var vals = [];
    (f.vals || []).forEach(function (v) { v = String(v == null ? '' : v); if (v.trim() && v.indexOf(',') < 0 && vals.indexOf(v) < 0) vals.push(v); });
    var w = widget(), inst = null;
    try { inst = w && apex.jQuery(w).interactiveReport('instance'); } catch (e) { /* sem o widget */ }
    if (!vals.length) return irParaTabela();
    if (!inst || typeof inst._action !== 'function') return naTabela(vals[0]);
    var meus = meusFiltros(), ant = meus[f.col], antes = idsFiltros();
    if (ant && antes.indexOf(ant) < 0) ant = null;
    irParaTabela();
    P.quando.textContent = 'Filtrando a tabela…';
    var pronto = false;
    function depois() {
      if (pronto) return; pronto = true;
      var novo = idsFiltros().filter(function (id) { return antes.indexOf(id) < 0; })[0] || ant;
      if (novo) { meus[f.col] = novo; meusFiltros(meus); }
      var outros = novo ? mesmaColuna(novo) : [];
      P.quando.innerHTML = 'A tabela agora mostra só ' + esc(f.rot) + '. Para ver tudo de novo, toque no <b>×</b> do filtro, em cima da tabela.';
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
  function naTabela(texto) {
    var pre = P.ir, f = document.getElementById(pre + '_search_field'), b = document.getElementById(pre + '_search_button');
    if (!f || !b) return irParaTabela();
    irParaTabela();
    f.value = texto; b.click();
    P.quando.innerHTML = 'A tabela abaixo agora mostra só <b>' + esc(texto) + '</b>. Para ver tudo de novo, toque no <b>×</b> do filtro, em cima da tabela.';
  }
  function irParaTabela() {
    var ir = widget() || document.getElementById(P.ir); if (!ir) return;
    ir.scrollIntoView({ behavior: window.matchMedia && matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth', block: 'start' });
  }

  /* ═══ [S7] O COMEÇO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() { if (window.__ncSesmtIniciou) return; if (montar()) { window.__ncSesmtIniciou = true; buscar(); } }
  window.__ncSesmtDesenhar = function (d) { if (montar()) desenhar(d, Date.now()); };   /* para conferir o desenho com dados de teste */
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).one('apexreadyend', iniciar);
    if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  }
})();
