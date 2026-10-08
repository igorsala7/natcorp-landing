/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · PROCESSOS SELETIVOS  —  o "arrumador" da tela (JavaScript)                    ║
   ║  App 9113 (Recrutamento e Seleção) · Página 28 ("Relação de Vagas")                      ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia desta página: PROCESSOSSELETIVOS-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   O recrutador acompanha aqui os processos seletivos (abertos, em andamento, fechados…). Antes:
   um cartão enorme por vaga (3 por tela), cada dado com o rótulo na frente, e os filtros mais
   usados no meio de outros 13 campos. Agora:
     • uma LINHA por processo, em colunas que se comparam de cima a baixo: Vaga (cargo, número,
       empresa · filial · centro de custo) · Fase · Candidatos · Selecionador · Prazo de
       contratação · Situação. Tocar na linha abre o processo (a página 29, como sempre);
     • o prazo de contratação com a CONTAGEM ("vencido há 12 dias" em vermelho, "faltam 5 dias"
       em âmbar) nos processos em andamento;
     • no alto: o total, "Minhas vagas | Todas as vagas" e a Situação em botões de um toque
       (pesquisam na hora), a busca (Enter pesquisa em TODOS os processos) e Lista | Tabela
       (a Tabela é o relatório interativo original);
     • a coluna de filtros arrumada: título, Pesquisar sempre à vista, "Limpar filtros".

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     A consulta, os filtros e a pesquisa são os da página: este arquivo LÊ as linhas do
     relatório "Relatório de Vagas 1" (o HTML que a consulta monta) e escreve nos itens P28_*
     de sempre, apertando o botão Pesquisar original. Nada é gravado no banco.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 28 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_ProcessosSeletivos.js
     Página 28 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_ProcessosSeletivos.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [P1]  Situações e textos                                              PODE MEXER
     [P2]  Ferramentas
     [P3]  Ler as linhas do relatório                                      CUIDADO
     [P4]  Desenhar a lista
     [P5]  O alto dos resultados (total, Minhas/Todas, Situação, busca, Lista/Tabela)
     [P6]  A coluna de filtros
     [P7]  O maestro
*/
(function () {
  'use strict';
  if (window.__ncProcessosSeletivos || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [P1] SITUAÇÕES E TEXTOS ════════════════════════════════════════════════════════════
     SITUACOES  o selo de cada situação (a chave é o texto que a consulta devolve) e o código
                do P28_STATUS (a lista da página: Prevista 1, Fechada 2, Cancelada 3,
                Reprovada 4, Aberta 5 — "Publicada" é uma Aberta já publicada, também 5).
     EM_CURSO   as situações em que o prazo de contratação ainda corre (mostra a contagem).
     PODE MEXER (rótulos e ordem; o código tem de ser o da lista do P28_STATUS)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var SITUACOES = [
    { k: 'prevista', rot: 'Prevista', cod: '1' },
    { k: 'aberta', rot: 'Aberta', cod: '5' },
    { k: 'publicada', rot: 'Publicada', cod: null },
    { k: 'fechada', rot: 'Fechada', cod: '2' },
    { k: 'cancelada', rot: 'Cancelada', cod: '3' },
    { k: 'reprovada', rot: 'Reprovada', cod: '4' }
  ];
  var EM_CURSO = { aberta: 1, publicada: 1 };
  var AVISO_DIAS = 7;   /* faltando até tantos dias, o prazo fica âmbar */

  /* ═══ [P2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function nome(t) {
    return String(t || '').toLowerCase().replace(/(^|[\s'(/-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); })
      .replace(/\s(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  /* "0002 - MATHEUS ALVES MACHADO" → "0002 - Matheus Alves Machado"; "Natcorp Do Brasil" → "Natcorp do Brasil" */
  function codNome(t) {
    t = String(t || '').trim(); if (!t || t === '-') return '';
    var m = /^(\S+)\s+-\s+(.+)$/.exec(t);
    return m ? m[1] + ' - ' + nome(m[2]) : nome(t);
  }
  function semAcento(t) { return String(t || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  function data(t) { var m = /(\d{1,2})\/(\d{1,2})\/(\d{4})/.exec(String(t || '')); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function hoje() { var n = new Date(); return new Date(n.getFullYear(), n.getMonth(), n.getDate()); }
  function dias(n) { return n === 1 ? '1 dia' : n + ' dias'; }
  var IC = {
    pessoas: '<circle cx="9" cy="8.5" r="3"/><path d="M3.5 19a5.5 5.5 0 0 1 11 0"/><path d="M15.5 6a3 3 0 0 1 0 5.6M17 14a5.5 5.5 0 0 1 3.5 5"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4 4"/>',
    seta: '<path d="M9.5 6l6 6-6 6"/>',
    lista: '<path d="M9 6.5h11M9 12h11M9 17.5h11"/><circle cx="4.8" cy="6.5" r="1"/><circle cx="4.8" cy="12" r="1"/><circle cx="4.8" cy="17.5" r="1"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M3.5 14.5h17M9.5 10v9"/>',
    filtro: '<path d="M4 6h16M7 12h10M10 18h4"/>',
    relogio: '<circle cx="12" cy="12" r="8"/><path d="M12 7.5V12l3 2"/>'
  };
  function ic(n) { return '<svg class="nc-ps-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  function digitando(e) { return e && (/^(TEXTAREA|SELECT)$/.test(e.tagName) || (e.tagName === 'INPUT' && !/^(button|checkbox|radio)$/i.test(e.type)) || e.isContentEditable); }
  /* o botão "Pesquisar" original: marca a pesquisa e envia a página (ação dinâmica "Search") */
  function pesquisar() {
    var b = [].filter.call(document.querySelectorAll('button.t-Button'), function (x) { return /^\s*pesquisar\s*$/i.test(x.textContent); })[0];
    if (b) b.click();
  }

  /* ═══ [P3] LER AS LINHAS DO RELATÓRIO ════════════════════════════════════════════════════
     CUIDADO  Cada linha vem do "Relatório de Vagas 1" (lista de mídia): o cargo no <h3><b>, o
              número no <p> logo depois, os dados como "<b>Rótulo: </b>valor<br>" numa tabela,
              a situação no selo e o link para a página 29 no <a>. Os rótulos são lidos pelo
              nome — mudou o rótulo na consulta, mude aqui (CAMPOS).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var CAMPOS = { 'empresa': 'emp', 'filial': 'fil', 'centro de custo': 'cc', 'unidade adm.': 'ua', 'selecionador': 'sel', 'fase do processo': 'fase',
    'quantidade de candidatos': 'cand', 'data de solicitacao': 'dSol', 'data de aprovacao': 'dApr', 'data da situacao': 'dSit', 'prazo inicial': 'dIni', 'prazo de contratacao': 'dPrazo' };
  function lerLinha(li) {
    var b = li.querySelector('h3 b'), cod = '', p = b && b.closest('h3').nextElementSibling;
    if (p && p.tagName === 'P') cod = p.textContent.trim();
    var o = { cargo: b ? b.textContent.trim() : '', cod: cod };
    [].forEach.call(li.querySelectorAll('.tabela td'), function (td) {
      td.innerHTML.split(/<br\s*\/?>/i).forEach(function (parte) {
        var m = /<b>\s*([^<:]+):\s*<\/b>([\s\S]*)$/i.exec(parte); if (!m) return;
        var k = CAMPOS[semAcento(m[1]).trim()]; if (!k) return;
        var v = el('div', null, m[2]).textContent.replace(/\s+/g, ' ').trim();
        o[k] = v === '-' ? '' : v;
      });
    });
    var sit = (li.querySelector('.t-MediaList-badge') || {}).textContent || '';
    sit = sit.trim(); o.sitTxt = sit && sit !== '-' ? sit : 'Sem situação';
    o.sit = semAcento(o.sitTxt).replace(/\s+/g, '-');
    var a = li.querySelector('a.t-MediaList-itemWrap[href]');
    o.href = a && !/^#|^javascript:void/.test(a.getAttribute('href')) ? a.getAttribute('href') : '';
    return o;
  }

  /* ═══ [P4] DESENHAR A LISTA ══════════════════════════════════════════════════════════════ */
  function prazo(o) {
    var d = data(o.dPrazo); if (!d) return '<span class="nc-ps-fraco">—</span>';
    var txt = '<b>' + esc(o.dPrazo) + '</b>';
    if (!EM_CURSO[o.sit]) return txt;
    var n = Math.round((d - hoje()) / 864e5);
    var tom = n < 0 ? 'vencido' : n <= AVISO_DIAS ? 'perto' : 'ok';
    var rel = n < 0 ? 'vencido há ' + dias(-n) : n === 0 ? 'vence hoje' : 'faltam ' + dias(n);
    return txt + '<small class="nc-ps-prazo" data-tom="' + tom + '">' + rel + '</small>';
  }
  function linha(o) {
    var onde = [o.emp && nome(o.emp), o.fil && o.fil].filter(Boolean).join(' · ');
    var fase = /^(\d+)\s*-\s*(.+)$/.exec(o.fase || '');
    var tag = o.href ? 'a' : 'div';
    return '<li class="nc-ps-linha" data-sit="' + esc(o.sit) + '">' +
      '<' + tag + ' class="nc-ps-alvo"' + (o.href ? ' href="' + esc(o.href) + '"' : ' title="Requisição ainda sem processo seletivo"') + '>' +
        '<div class="nc-ps-vaga"><p class="nc-ps-cargo">' + esc(o.cargo || 'Cargo não informado') + (o.cod ? ' <span class="nc-ps-num">' + esc(o.cod) + '</span>' : '') + '</p>' +
          (onde ? '<p class="nc-ps-onde">' + esc(onde) + '</p>' : '') +
          (o.cc || o.ua ? '<p class="nc-ps-cc">' + esc([o.cc && 'CC ' + o.cc, o.ua && 'UA ' + o.ua].filter(Boolean).join(' · ')) + '</p>' : '') + '</div>' +
        '<div class="nc-ps-col nc-ps-fase" data-rot="Fase">' + (o.fase ? '<span class="nc-ps-fase-chip">' + (fase ? '<i>' + esc(fase[1]) + '</i>' + esc(fase[2]) : esc(o.fase)) + '</span>' : '<span class="nc-ps-fraco">—</span>') + '</div>' +
        '<div class="nc-ps-col nc-ps-cand" data-rot="Candidatos">' + (o.cand !== undefined && o.cand !== '' ? ic('pessoas') + '<b>' + esc(o.cand) + '</b>' : '<span class="nc-ps-fraco">—</span>') + '</div>' +
        '<div class="nc-ps-col nc-ps-sel" data-rot="Selecionador">' + (o.sel ? esc(codNome(o.sel)) : '<span class="nc-ps-fraco">Sem selecionador</span>') + '</div>' +
        '<div class="nc-ps-col nc-ps-pz" data-rot="Prazo de contratação">' + prazo(o) +
          (o.dSol ? '<small class="nc-ps-fraco">solicitada ' + esc(o.dSol) + '</small>' : '') + '</div>' +
        '<div class="nc-ps-col nc-ps-sit"><span class="nc-ps-selo" data-sit="' + esc(o.sit) + '">' + esc(o.sitTxt) + '</span>' + (o.href ? ic('seta') : '') + '</div>' +
      '</' + tag + '></li>';
  }
  function desenharLista(reg, app) {
    var lista = app.querySelector('.nc-ps-lista');
    var lis = reg.querySelectorAll('.t-MediaList-item');
    var linhas = [].map.call(lis, lerLinha);
    var tot = /de\s+([\d.]+)/i.exec((reg.querySelector('.t-Report-paginationText') || {}).textContent || '');
    var total = tot ? +tot[1].replace(/\./g, '') : linhas.length;
    app.querySelector('.nc-ps-total').innerHTML = '<b>' + total.toLocaleString('pt-BR') + '</b> ' + (total === 1 ? 'processo' : 'processos');
    if (!linhas.length) {
      lista.innerHTML = '<li class="nc-ps-vazio"><p><b>Nenhum processo com estes filtros.</b></p><p>Mude a situação, o período ou troque para "Todas as vagas".</p><button type="button" class="nc-ps-bt" data-limpar>Limpar filtros</button></li>';
      return;
    }
    lista.innerHTML = linhas.map(linha).join('');
  }

  /* ═══ [P5] O ALTO DOS RESULTADOS ═════════════════════════════════════════════════════════ */
  function montarResultados(reg) {
    var corpo = reg.querySelector('.t-Region-body') || reg;
    var app = el('section', 'nc-ps');
    app.setAttribute('aria-label', 'Processos seletivos');
    var envolvido = apex.item('P28_ENVOLVIDO') ? apex.item('P28_ENVOLVIDO').getValue() : 'S';
    var status = String(apex.item('P28_STATUS') ? [].concat(apex.item('P28_STATUS').getValue() || []).join(',') : '');
    var visao = apex.item('P28_RELATORIO') ? apex.item('P28_RELATORIO').getValue() : 'C';
    var busca = apex.item('P28_PESQUISAR') ? apex.item('P28_PESQUISAR').getValue() : (apex.item('P28_PESQUISAR_1') ? apex.item('P28_PESQUISAR_1').getValue() : '');
    /* o botão do código 5 é "Em aberto": pega as Abertas E as Publicadas (o selo da linha distingue) */
    var chips = [{ cod: '', rot: 'Todas' }].concat(SITUACOES.filter(function (s) { return s.cod; }).map(function (s) { return { cod: s.cod, rot: s.cod === '5' ? 'Em aberto' : s.rot, k: s.k }; }));
    app.innerHTML =
      '<header class="nc-ps-cab">' +
        '<h2 class="nc-ps-total" aria-live="polite"></h2>' +
        '<div class="nc-ps-grupo" role="group" aria-label="De quem">' +
          '<button type="button" data-envolvido="S" aria-pressed="' + (envolvido === 'S') + '">Minhas vagas</button>' +
          '<button type="button" data-envolvido="T" aria-pressed="' + (envolvido === 'T') + '">Todas as vagas</button></div>' +
        '<label class="nc-ps-busca">' + ic('busca') + '<span class="nc-ps-oculto">Buscar</span><input type="search" value="' + esc(busca) + '" placeholder="Buscar cargo, número, filial… (Enter)" autocomplete="off"></label>' +
        '<div class="nc-ps-grupo nc-ps-visao" role="group" aria-label="Ver como">' +
          '<button type="button" data-visao="C" aria-pressed="' + (visao !== 'I') + '">' + ic('lista') + 'Lista</button>' +
          '<button type="button" data-visao="I" aria-pressed="' + (visao === 'I') + '">' + ic('tabela') + 'Tabela</button></div>' +
      '</header>' +
      '<div class="nc-ps-sits" role="group" aria-label="Situação">' + chips.map(function (c) {
        return '<button type="button" data-status="' + c.cod + '"' + (c.k ? ' data-sit="' + c.k + '"' : '') + ' aria-pressed="' + (status === c.cod) + '">' + esc(c.rot) + '</button>';
      }).join('') + '</div>' +
      (visao === 'I' ? '' :
        '<div class="nc-ps-titulos" aria-hidden="true"><span>Vaga</span><span>Fase</span><span>Candidatos</span><span>Selecionador</span><span>Prazo de contratação</span><span>Situação</span></div>' +
        '<ol class="nc-ps-lista"></ol>');
    corpo.insertBefore(app, corpo.firstChild);
    reg.classList.add('nc-ps-reg');
    /* as escolhas de um toque pesquisam na hora */
    app.addEventListener('click', function (ev) {
      var b = ev.target.closest('button'); if (!b) return;
      if (b.hasAttribute('data-envolvido')) { apex.item('P28_ENVOLVIDO').setValue(b.getAttribute('data-envolvido')); return pesquisar(); }
      if (b.hasAttribute('data-status')) {
        var c = b.getAttribute('data-status'), rot = c ? b.textContent : '';
        apex.item('P28_STATUS').setValue(c, rot); return pesquisar();
      }
      if (b.hasAttribute('data-visao')) { apex.item('P28_RELATORIO').setValue(b.getAttribute('data-visao')); return pesquisar(); }
      if (b.hasAttribute('data-limpar')) return limpar();
    });
    var q = app.querySelector('.nc-ps-busca input');
    q.addEventListener('keydown', function (ev) {
      if (ev.key !== 'Enter') return;
      ev.preventDefault();
      ['P28_PESQUISAR', 'P28_PESQUISAR_1'].forEach(function (i) { if (apex.item(i) && apex.item(i).node) apex.item(i).setValue(q.value.trim()); });
      pesquisar();
    });
    document.addEventListener('keydown', function (ev) { if (ev.key === '/' && !digitando(ev.target) && !ev.ctrlKey && !ev.metaKey) { ev.preventDefault(); q.focus(); q.select(); } });
    return app;
  }

  /* ═══ [P6] A COLUNA DE FILTROS ═══════════════════════════════════════════════════════════
     Os campos são os originais (P28_*). Sai da vista o que agora está no alto dos resultados
     (De quem, Situação, Tipo de relatório); entra um título, "Limpar filtros" e o Pesquisar
     fixo no pé da coluna.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var LIMPAR = ['P28_REQUISICAO', 'P28_STATUS', 'P28_ETAPA', 'P28_DT_INI', 'P28_DT_FIM', 'P28_EMP_ID', 'P28_CARGO', 'P28_FILIAL', 'P28_CENTRO_CUSTO', 'P28_UNIDADE_ADM',
    'P28_VINCULO_CARGO', 'P28_TIPO_MODALIDADE', 'P28_LOCAL_TRAB', 'P28_SELECIONADOR', 'P28_AVALIADOR', 'P28_GESTOR', 'P28_APROVADOR', 'P28_PESQUISAR', 'P28_PESQUISAR_1'];
  function limpar() {
    LIMPAR.forEach(function (i) { if (apex.item(i) && apex.item(i).node) apex.item(i).setValue(''); });
    if (apex.item('P28_TIPO_PUBLICACAO') && apex.item('P28_TIPO_PUBLICACAO').node) apex.item('P28_TIPO_PUBLICACAO').setValue('T', 'Todas');
    pesquisar();
  }
  function arrumarFiltros() {
    var c = $id('P28_ENVOLVIDO_CONTAINER'), reg = c && c.closest('.t-Region:not(#PARAMETROS_ITENS)');
    if (!reg) return;
    reg.classList.add('nc-ps-filtros');
    ['P28_ENVOLVIDO', 'P28_STATUS', 'P28_RELATORIO'].forEach(function (i) { var x = $id(i + '_CONTAINER'); if (x) x.classList.add('nc-ps-guardado'); });
    var cab = el('div', 'nc-ps-filtros-cab', '<h2>' + ic('filtro') + 'Filtros</h2><button type="button" class="nc-ps-link" data-limpar>Limpar filtros</button>');
    var dentro = reg.querySelector('.t-Region-body') || reg;
    dentro.insertBefore(cab, dentro.firstChild);
    cab.querySelector('[data-limpar]').addEventListener('click', limpar);
    /* Enter num campo de texto/data dos filtros = Pesquisar */
    reg.addEventListener('keydown', function (ev) { if (ev.key === 'Enter' && ev.target.matches('input[type=text], input:not([type])')) { ev.preventDefault(); pesquisar(); } });
  }

  /* ═══ [P7] O MAESTRO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() {
    window.__ncProcessosSeletivos = true;
    document.body.classList.add('nc-ps-ativo');
    arrumarFiltros();
    var lista = document.querySelector('.t-MediaList');
    var reg = lista ? lista.closest('.t-Region') : $id('VAGAS');
    if (!reg) return;
    var app = montarResultados(reg);
    if (app.querySelector('.nc-ps-lista')) {
      desenharLista(reg, app);
      /* paginação (Próximo/Anterior) recarrega só o relatório: redesenha */
      $(reg).on('apexafterrefresh', function () { desenharLista(reg, app); var t = app.getBoundingClientRect().top; if (t < 0) app.scrollIntoView({ block: 'start' }); });
    } else {
      app.querySelector('.nc-ps-total').textContent = 'Tabela completa';
    }
  }
  var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp processos seletivos]', e); } }, 0); };
  if (document.readyState === 'complete') vai();
  else { if (window.apex.gPageContext$) $(apex.gPageContext$).one('apexreadyend', vai); window.addEventListener('load', vai); }
})();
