/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · LANÇAMENTOS DE OCORRÊNCIAS — filtros ao lado, lançamentos no meio (JavaScript) ║
   ║  App 9132 (Movimentações Financeiro) · Página 5 (Lançamentos)                             ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: LANCOCORR-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Antes: os "Parâmetros de Pesquisa" ocupavam a página inteira, e os lançamentos (com os botões
   Inserir / Alterar / Calcular) só apareciam depois, lá embaixo. Agora:
     À ESQUERDA  os filtros ORIGINAIS reunidos por assunto —
                   O que você vai lançar (o Processo vira cartões de escolha) · Empresa e período ·
                   De quem · Quais lançamentos · Quem lançou
                 e no pé o resumo do que vai ser pesquisado + o Pesquisar (o MESMO botão).
     NO MEIO     antes de pesquisar: o passo a passo (o que já foi escolhido fica marcado);
                 depois: o processo escolhido, os botões de lançar e o relatório.
   No celular a coluna dos filtros fica em cima; depois de pesquisar ela se recolhe num resumo
   ("Mudar filtros"), para os lançamentos aparecerem logo.

   CUIDADO  O APEX confere, no envio, a ORDEM dos itens contra a ordem em que a página foi desenhada.
   Este arquivo move os campos para os grupos — a exportação precisa ter a MESMA ordem (o
   aplicar-lancocorr-pagina5.py grava as sequências na ordem de GRUPOS). Mudou um grupo aqui? Mude a
   ORDEM lá, senão o Pesquisar dá "Violação de proteção da página".

   ── O QUE NÃO MUDA ────────────────────────────────────────────────────────────────────────
   Os campos, as listas em cascata, as validações, as ações dinâmicas (Executa Pesquisa, Disable
   Report, Atribui Processo TXT, situações de demitido…) e os processos são os da página. Os grupos
   são montados DENTRO da região "Parametros", porque a ação "Disable Report" escuta as mudanças
   nela. O Processo continua sendo o item P5_PROCESSO (escondido): os cartões só escrevem nele.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 5 › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_LancOcorr.js
     Página 5 › CSS › File URLs:         #WORKSPACE_IMAGES#Natcorp_HistFiltros.css
                                         #WORKSPACE_IMAGES#Natcorp_LancOcorr.css
     (aplicar-lancocorr-pagina5.py). O COMBINADO com a página: filtros na região "PSQ1",
     resultado na região "BLOCO".

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [L1] Os processos e os grupos ......... nomes, dicas, quem vai em qual grupo     PODE MEXER
     [L2] As duas colunas
     [L3] Os grupos de filtros ............. move os campos, faixas De/Até, o pé
     [L4] Os cartões do processo
     [L5] O passo a passo (antes de pesquisar)
     [L6] O começo
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncLancOcorr) return;
  window.__ncLancOcorr = true;

  /* ═══ [L1] OS PROCESSOS E OS GRUPOS ═════════════════════════════════════════════════════
     PODE MEXER  nomes e dicas. CUIDADO: o valor e o texto ("1-Folha | Rescisão") são os da lista
     estática do item P5_PROCESSO — o APEX guarda os dois.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PROCESSOS = [
    { v: '1', t: '1-Folha | Rescisão', nome: 'Folha e rescisão', dica: 'o salário do mês e as rescisões' },
    { v: '2', t: '2-Adiantamento', nome: 'Adiantamento', dica: 'o vale do meio do mês' },
    { v: '3', t: '3-Férias', nome: 'Férias', dica: 'o pagamento das férias' },
    { v: '4', t: '4-13º Salário', nome: '13º salário', dica: 'a 1ª ou a 2ª parcela' },
    { v: '5', t: '5-Participação no Lucros - PLR', nome: 'Participação nos lucros', dica: 'PLR' },
    { v: '6', t: '6-Pagamentos Diversos', nome: 'Pagamentos diversos', dica: 'fora da folha' },
    { v: '7', t: '7-Todos os Processos - Somente Consulta', nome: 'Todos os processos', dica: 'só para consultar, sem lançar' }
  ];
  var GRUPOS = [
    { k: 'oque', tit: 'O que você vai lançar', fixo: true, processo: true },
    { k: 'quando', tit: 'Empresa e período', fixo: true, dica: 'Obrigatório: a empresa e o mês (ou os meses) dos lançamentos.',
      itens: ['P5_EMPRESAS', 'P5_DATAREF'] },
    { k: 'quem', tit: 'De quem', dica: 'Vazio = todos. Use para lançar só para parte das pessoas.', itens: [
      'P5_FILIAIS', 'P5_CCUSTOS', 'P5_CARGOS', 'P5_MATRICULAS',
      'P5_SITUACOES', { dupla: 'Demitidos (só com situação de demitido)', a: ['P5_DATASIT', 'Data da demissão'], b: ['P5_MESANOSIT', 'Mês/ano da demissão'] },
      'P5_VINCULOS', 'P5_SINDICATOS', 'P5_TIPOSAL', 'P5_TIPOPAG',
      { faixa: 'Data de admissão', de: 'P5_DTADMINI', ate: 'P5_DTADMFIM', datas: true }] },
    { k: 'lanc', tit: 'Quais lançamentos', dica: 'Vazio = todos.', itens: [
      'P5_TIPOEVENT', 'P5_OCORRPAGTO',
      { faixa: 'Data de validade', de: 'P5_DTVALINI', ate: 'P5_DTVALFIM', datas: true }] },
    { k: 'autor', tit: 'Quem lançou', dica: 'Para conferir o que alguém lançou ou alterou.', itens: ['P5_USUARIO', 'P5_DTATLZ'] }
  ];
  var VISTO = '<svg viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M5 12.5l4.5 4.5L19 7.5" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/></svg>';
  var SETA = '<svg class="nc-hf-seta" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M6 9l6 6 6-6" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>';

  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html != null) e.innerHTML = html; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function caixaDe(id) { return document.getElementById(id + '_CONTAINER'); }
  function valor(id) { if (!document.getElementById(id)) return ''; var v = apex.item(id).getValue(); return Array.isArray(v) ? v.join(':') : (v || ''); }
  function vazio(v) { return v == null || v === '' || (Array.isArray(v) && !v.length); }
  function exibido(id) {   /* o texto que a pessoa vê numa lista (popup LOV guarda o "display") */
    var c = caixaDe(id); if (!c) return '';
    var tags = c.querySelectorAll('.apex-item-multi-item:not(:has(input)) span, .apex-item-multi-item[data-value] span');
    if (tags.length) return [].map.call(tags, function (t) { return t.textContent.trim(); }).filter(Boolean);
    var i = c.querySelector('input.apex-item-popup-lov, input.apex-item-text'); return i ? i.value : '';
  }

  /* ═══ [L2] AS DUAS COLUNAS ══════════════════════════════════════════════════════════════
     A região PSQ1 (os filtros) vai para a coluna da esquerda; a BLOCO (o processo, os botões e o
     relatório) para o meio. Sem BLOCO (ainda não pesquisou), o meio mostra o passo a passo.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var L = null;
  function montarColunas() {
    var psq = document.getElementById('PSQ1');
    if (!psq || L) return false;
    var bloco = document.getElementById('BLOCO');
    var casa = psq.closest('.row') || psq.parentNode;      /* a linha da grade onde a PSQ1 nasceu */
    var grade = el('div', 'nc-lc');
    var lado = el('aside', 'nc-lc-filtros'); lado.setAttribute('aria-label', 'Filtros da pesquisa');
    var meio = el('section', 'nc-lc-principal'); meio.setAttribute('aria-label', 'Lançamentos');
    grade.appendChild(lado); grade.appendChild(meio);
    casa.parentNode.insertBefore(grade, casa);
    lado.appendChild(psq);
    if (bloco) meio.appendChild(bloco);
    /* CUIDADO  linha "vazia" da grade NUNCA é apagada: pode guardar itens escondidos (os P0_* da página
       global são PROTEGIDOS — sem eles no envio o APEX dá "Violação de proteção da página", visto 09/10).
       Só sai da vista a linha sem nenhum campo, nem escondido. */
    [].forEach.call(document.querySelectorAll('.t-Body-contentInner .row'), function (r) {
      if (!r.closest('.nc-lc') && !r.querySelector('.t-Region, .t-Form-fieldContainer, button, input, select, textarea')) r.classList.add('nc-lc-vazia');
    });
    L = { grade: grade, lado: lado, meio: meio, psq: psq, bloco: bloco };
    document.body.classList.add('nc-lc-pagina');
    return true;
  }

  /* ═══ [L3] OS GRUPOS DE FILTROS ══════════════════════════════════════════════════════════
     CUIDADO  os campos são MOVIDOS (não copiados): o APEX continua dono deles. Tudo fica dentro
     da região "Parametros" (a mesma onde a ação Disable Report escuta as mudanças).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var F = null;
  function montarFiltros() {
    var cProc = caixaDe('P5_PROCESSO'); if (!cProc || F) return;
    /* CUIDADO  "Parametros", "Processo" e "Filtros" usam a moldura "Blank with Attributes" neste app:
       são div#R<id> SEM a classe .t-Region (visto em 09/10). A "Parametros" é a região-avó do Processo. */
    var regProc = cProc.parentElement.closest('div[id^="R"]'), regParam = regProc && regProc.parentElement.closest('div[id^="R"]');
    if (!regParam || !L.psq.contains(regParam)) return;
    var corpo = regParam;
    var grupos = el('div', 'nc-hf-grupos');
    F = { grupos: [], mudou: false };
    GRUPOS.forEach(function (g) {
      var sec = el('section', 'nc-hf-grupo nc-lc-g-' + g.k), cid = 'nc-lc-g-' + g.k;
      var cab = el('button', 'nc-hf-cab', '<span>' + g.tit + '</span><span class="nc-hf-uso" hidden></span>' + (g.fixo ? '' : SETA));
      cab.type = 'button'; cab.setAttribute('aria-controls', cid);
      if (g.fixo) cab.setAttribute('aria-disabled', 'true');
      var bd = el('div', 'nc-hf-corpo'); bd.id = cid;
      if (g.dica) bd.appendChild(el('p', 'nc-hf-dica', g.dica));
      var ids = [], tem = 0;
      if (g.processo) { bd.appendChild(cartoesProcesso(cProc)); ids.push('P5_PROCESSO'); tem++; }
      else g.itens.forEach(function (it) {
        if (typeof it === 'string') { var c = caixaDe(it); if (c) { bd.appendChild(c); ids.push(it); tem++; } return; }
        if (it.dupla) {
          var ca = caixaDe(it.a[0]), cb = caixaDe(it.b[0]); if (!ca && !cb) return;
          var fd = el('fieldset', 'nc-hf-faixa nc-lc-dupla', '<legend>' + it.dupla + '</legend>');
          [[ca, it.a], [cb, it.b]].forEach(function (x) { if (!x[0]) return; var lb = x[0].querySelector('.t-Form-label'); if (lb) lb.textContent = x[1][1]; fd.appendChild(x[0]); ids.push(x[1][0]); });
          bd.appendChild(fd); tem++; return;
        }
        var cd = caixaDe(it.de), cat = caixaDe(it.ate); if (!cd && !cat) return;
        var fs = el('fieldset', 'nc-hf-faixa' + (it.datas ? ' nc-hf-faixa--datas' : ''), '<legend>' + it.faixa + '</legend>');
        [[cd, 'De', it.de], [cat, 'Até', it.ate]].forEach(function (x) { if (!x[0]) return; var lb = x[0].querySelector('.t-Form-label'); if (lb) lb.textContent = x[1]; fs.appendChild(x[0]); ids.push(x[2]); });
        bd.appendChild(fs); tem++;
      });
      if (!tem) return;
      sec.appendChild(cab); sec.appendChild(bd); grupos.appendChild(sec);
      var gr = { g: g, cab: cab, corpo: bd, ids: ids };
      F.grupos.push(gr);
      if (!g.fixo) {
        var aberto = usados(gr) > 0;
        try { var mem = localStorage.getItem('nc-lc-g-' + g.k); if (mem) aberto = aberto || mem === '1'; } catch (e) { /* ok */ }
        abrirGrupo(gr, aberto);
        cab.addEventListener('click', function () { var ab = cab.getAttribute('aria-expanded') !== 'true'; gr.mexeu = true; abrirGrupo(gr, ab); try { localStorage.setItem('nc-lc-g-' + g.k, ab ? '1' : '0'); } catch (e) { /* ok */ } });
      }
    });
    corpo.insertBefore(grupos, corpo.firstChild);
    /* só agora (com os grupos na página) o APEX acha o valor do Processo: marca o cartão */
    marcarProcesso(grupos.querySelector('.nc-lc-proc-lista'));
    /* as sub-regiões "Processo" e "Filtros" ficaram vazias (só itens escondidos): saem da vista */
    [].forEach.call(regParam.querySelectorAll('div[id^="R"]'), function (r) { if (!r.querySelector('.t-Form-fieldContainer:not(.nc-hf-guardado)')) r.classList.add('nc-lc-casca'); });
    [].forEach.call(regParam.querySelectorAll(':scope > .container'), function (c) { if (!c.querySelector('.t-Form-fieldContainer:not(.nc-hf-guardado)')) c.classList.add('nc-lc-casca'); });
    /* o pé: resumo + o MESMO Pesquisar (a ação dinâmica "Executa Pesquisa" segue no botão) */
    var bt = L.psq.querySelector('.t-Region-headerItems--buttons button, .t-Region-buttons button');
    var pe = el('div', 'nc-hf-pe', '<p class="nc-hf-resumo" aria-live="polite"></p>');
    if (bt) pe.appendChild(bt);
    L.psq.querySelector('.t-Region-body').appendChild(pe);
    F.resumo = pe.querySelector('.nc-hf-resumo');
    resumir();
    setTimeout(function () { F.grupos.forEach(function (gr) { if (!gr.g.fixo && !gr.mexeu && usados(gr) > 0) abrirGrupo(gr, true); }); resumir(); }, 900);
    /* as listas em cascata se preenchem sozinhas ao abrir: só conta o que vem depois */
    var t0 = Date.now(), mexeu = function () { if (Date.now() - t0 > 1500) F.mudou = true; setTimeout(function () { resumir(); passos(); }, 0); };
    L.psq.addEventListener('change', mexeu);
    if (window.apex && apex.jQuery) apex.jQuery(L.psq).on('change', mexeu);
  }
  function abrirGrupo(gr, aberto) { gr.cab.setAttribute('aria-expanded', String(aberto)); gr.corpo.hidden = !aberto; }
  function usados(gr) { return gr.ids.filter(function (id) { return id !== 'P5_PROCESSO' && !vazio(valor(id)); }).length; }
  function processoEscolhido() { var v = valor('P5_PROCESSO'); return PROCESSOS.filter(function (p) { return p.v === String(v); })[0] || null; }
  function mesesTexto() {
    var d = exibido('P5_DATAREF');
    if (Array.isArray(d) && d.length) return d.length > 3 ? d.length + ' meses' : d.join(', ');
    return d || '';
  }
  function resumir() {
    if (!F) return;
    F.grupos.forEach(function (gr) {
      var u = gr.cab.querySelector('.nc-hf-uso'), n = gr.g.fixo ? 0 : usados(gr);
      u.hidden = !n; u.textContent = n; u.setAttribute('aria-label', n + ' em uso');
    });
    var p = processoEscolhido(), emp = exibido('P5_EMPRESAS'), meses = mesesTexto(), falta = [];
    if (!p) falta.push('o que lançar'); if (vazio(valor('P5_EMPRESAS'))) falta.push('a empresa'); if (vazio(valor('P5_DATAREF'))) falta.push('o período');
    var outros = F.grupos.filter(function (gr) { return !gr.g.fixo; }).reduce(function (s, gr) { return s + usados(gr); }, 0);
    var html;
    if (falta.length) html = 'Falta escolher <b>' + falta.join(', ').replace(/, ([^,]*)$/, ' e $1') + '</b>.';
    else html = (F.mudou ? 'Você mudou os filtros: toque em <b>Pesquisar</b>. ' : 'Vai pesquisar: ') + '<b>' + esc(p.nome) + '</b> · ' + esc(Array.isArray(emp) ? emp.join(', ') : emp) + ' · ' + esc(meses) +
      (outros ? ' · ' + outros + (outros === 1 ? ' filtro a mais' : ' filtros a mais') : '') + '.';
    F.resumo.classList.toggle('is-mudou', F.mudou && !falta.length);
    F.resumo.innerHTML = html;
    if (L && L.resumoCel) L.resumoCel.innerHTML = html;
  }

  /* ═══ [L4] OS CARTÕES DO PROCESSO ═══════════════════════════════════════════════════════
     Uma escolha só (como rádio). Escrever no P5_PROCESSO dispara as ações da página ("Atribui
     Processo TXT" e "Disable Report"). O erro da validação do Processo aparece aqui em cima.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function cartoesProcesso(cProc) {
    var box = el('div', 'nc-lc-procs');
    var erro = document.getElementById('P5_PROCESSO_error');
    var msg = erro && erro.textContent.trim();
    var lista = el('div', 'nc-lc-proc-lista');
    lista.setAttribute('role', 'radiogroup'); lista.setAttribute('aria-label', 'O que você vai lançar');
    PROCESSOS.forEach(function (p) {
      var b = el('button', 'nc-lc-proc' + (p.v === '7' ? ' is-consulta' : ''), '<i aria-hidden="true">' + VISTO + '</i><span><b>' + p.nome + '</b><small>' + p.dica + '</small></span>');
      b.type = 'button'; b.setAttribute('role', 'radio'); b.setAttribute('data-lc-proc', p.v);
      b.addEventListener('click', function () { escolher(p); });
      b.addEventListener('keydown', function (e) {   /* setas andam entre as opções, como num grupo de rádio */
        var bs = [].slice.call(lista.querySelectorAll('.nc-lc-proc')), i = bs.indexOf(b), j = null;
        if (e.key === 'ArrowDown' || e.key === 'ArrowRight') j = (i + 1) % bs.length;
        if (e.key === 'ArrowUp' || e.key === 'ArrowLeft') j = (i - 1 + bs.length) % bs.length;
        if (j != null) { e.preventDefault(); bs[j].focus(); escolher(PROCESSOS[j]); }
      });
      lista.appendChild(b);
    });
    if (msg) box.appendChild(el('p', 'nc-lc-erro', '<b>' + esc(msg) + '</b>'));
    box.appendChild(lista);
    cProc.classList.add('nc-hf-guardado');
    box.appendChild(cProc);
    marcarProcesso(lista);
    return box;
  }
  function escolher(p) {
    apex.item('P5_PROCESSO').setValue(p.v, p.t);
    marcarProcesso(document.querySelector('.nc-lc-proc-lista'));
    var e = document.querySelector('.nc-lc-erro'); if (e) e.remove();
    resumir(); passos();
  }
  function marcarProcesso(lista) {
    if (!lista) return;
    var v = String(valor('P5_PROCESSO') || '');
    var bs = lista.querySelectorAll('.nc-lc-proc');
    [].forEach.call(bs, function (b, i) {
      var on = b.getAttribute('data-lc-proc') === v;
      b.setAttribute('aria-checked', String(on));
      b.tabIndex = on || (!v && i === 0) ? 0 : -1;    /* um ponto de parada do Tab no grupo, como o rádio */
    });
  }

  /* ═══ [L5] O PASSO A PASSO (antes de pesquisar) ═════════════════════════════════════════ */
  function montarGuia() {
    if (!L || L.bloco) return;
    var g = el('div', 'nc-lc-guia');
    g.innerHTML = '<h2>Lançar ocorrências</h2><p class="nc-lc-guia-sub">Escolha na coluna ao lado e toque em Pesquisar. Os lançamentos e os botões para inserir, alterar ou excluir aparecem aqui.</p>' +
      '<ol class="nc-lc-passos"></ol>';
    L.meio.appendChild(g);
    L.guia = g;
    passos();
  }
  function passos() {
    if (!L || !L.guia) return;
    var p = processoEscolhido(), ok1 = !!p, ok2 = !vazio(valor('P5_EMPRESAS')) && !vazio(valor('P5_DATAREF'));
    var itens = [
      [ok1, 'O que você vai lançar', ok1 ? p.nome : 'Folha, adiantamento, férias, 13º…'],
      [ok2, 'A empresa e o período', ok2 ? [].concat(exibido('P5_EMPRESAS')).join(', ') + ' · ' + mesesTexto() : 'Os dois são obrigatórios'],
      [false, 'Toque em Pesquisar', 'Se quiser, antes escolha de quem e quais lançamentos (opcional)']
    ];
    var atual = !ok1 ? 0 : !ok2 ? 1 : 2;
    L.guia.querySelector('.nc-lc-passos').innerHTML = itens.map(function (x, i) {
      return '<li class="' + (x[0] ? 'is-feito' : i === atual ? 'is-agora' : '') + '"><span class="nc-lc-marca" aria-hidden="true">' + (x[0] ? VISTO : i + 1) + '</span>' +
        '<span><b>' + x[1] + '</b><small>' + esc(x[2]) + '</small></span>' + (x[0] ? '<span class="nc-lc-vis">(feito)</span>' : '') + '</li>';
    }).join('');
  }

  /* O TÍTULO DOS LANÇAMENTOS: a região BLOCO usa &P5_PROC_TXT. no título, e esse item só se preenche
     quando alguém TROCA o processo (ação "Atribui Processo TXT"). Vindo pela moldura (processo na URL)
     o título nascia vazio: aqui ele mostra o processo e, embaixo, a empresa e o período pesquisados. */
  function tituloLancamentos() {
    if (!L || !L.bloco) return;
    var t = L.bloco.querySelector('.t-Region-header .t-Region-title'), p = processoEscolhido();
    if (!t || !p) return;
    var emp = [].concat(exibido('P5_EMPRESAS')).join(', '), meses = mesesTexto();
    t.innerHTML = '<span class="nc-lc-tit">' + esc(p.nome) + '</span>' + (emp || meses ? '<small class="nc-lc-tit-sub">' + esc([emp, meses].filter(Boolean).join(' · ')) + '</small>' : '');
  }

  /* celular: depois de pesquisar, os filtros viram um resumo com "Mudar filtros" */
  function recolherNoCelular() {
    if (!L || !L.bloco || !window.matchMedia || !matchMedia('(max-width: 900px)').matches) return;
    var barra = el('div', 'nc-lc-cel', '<p class="nc-lc-cel-resumo"></p><button type="button" class="t-Button nc-lc-cel-bt" aria-expanded="false">Mudar filtros</button>');
    L.lado.insertBefore(barra, L.lado.firstChild);
    L.resumoCel = barra.querySelector('.nc-lc-cel-resumo');
    L.lado.classList.add('is-recolhido');
    barra.querySelector('button').addEventListener('click', function () {
      var ab = L.lado.classList.toggle('is-recolhido') === false;
      this.setAttribute('aria-expanded', String(ab)); this.textContent = ab ? 'Esconder filtros' : 'Mudar filtros';
    });
    resumir();
  }

  /* ═══ [L6] O COMEÇO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() {
    if (window.__ncLancOcorrIniciou) return;
    window.__ncLancOcorrIniciou = true;
    try {
      if (!montarColunas()) return;
      montarFiltros();
      montarGuia();
      tituloLancamentos();
      recolherNoCelular();
    } catch (e) { if (window.console) console.warn('Natcorp_LancOcorr', e); }   /* a página original continua funcionando */
  }
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).one('apexreadyend', iniciar);
    if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  }
})();
