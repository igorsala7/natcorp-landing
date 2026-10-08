/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · MANUTENÇÃO DE ATESTADOS  —  o "arrumador" da tela (JavaScript)                ║
   ║  App 2937 (Medicina Ocupacional) · Página 12 · Manutenção de Atestados Médicos           ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia desta página: MANUTENCAOATESTADOS-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   É onde o profissional de saúde LANÇA e CORRIGE os atestados de um colaborador. Quem usa tem
   pouca intimidade com tecnologia, então a tela vira:
     • no alto, a busca de sempre (Empresa e Matrícula) e, escolhido o colaborador, QUEM é:
       nome, situação (Desligado em vermelho), cargo, setor, local, sangue;
     • um resumo: está afastado agora? quantos dias afastado nos últimos 60 dias e 12 meses;
     • os atestados em CARTÕES, do mais novo ao mais antigo, por ano: tipo, período com os dias,
       motivo, CID, médico, clínica, observação — com "Em vigor", "Sem término", "Ocupacional";
     • "Lançar atestado" (botão grande) e tocar num cartão abrem uma GAVETA com a ficha do
       atestado por assunto (O atestado · Quem atestou · Afastamento · Depois do afastamento ·
       Observação), com dicas nos campos que confundem;
     • "Tabela": a grade original, só para consultar.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava por conta própria: a gaveta é a "vista de um registro" da PRÓPRIA grade. As
     listas (tipo, motivo que depende do tipo, CID, médico, entidade), as contas automáticas
     (dias ↔ término), a conferência de férias, a justificativa que vem do tipo, as horas que
     ligam/desligam, as validações e o salvar (com os processos "Set ENTIDADE", "Set Dados
     Complementares"…) são os da página. Tirou as URLs deste arquivo: a página volta a ser a
     de sempre.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 12 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_ManutencaoAtestados.js
     Página 12 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_ManutencaoAtestados.css

   ── O "COMBINADO" COM O APEX ──────────────────────────────────────────────────────────────
     A busca é achada pelo item P12_MATRICULA; a grade, pela coluna COD_ATESTADO_MEDICO junto
     com DT_INICIO_AFASTAMENTO (a grade "Atestados" que nunca aparece não entra: não está na
     página). Os campos da ficha, pelo NOME da coluna (FICHA, [M2]).

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [M1]  Como a página é reconhecida                                      CUIDADO
     [M2]  A ficha: campos, nomes, blocos e dicas                           PODE MEXER
     [M3]  Ferramentas
     [M4]  Quem é (o alto)
     [M5]  Ler a grade (os atestados)                                       CUIDADO
     [M6]  O resumo e os cartões
     [M7]  Tabela (a grade original, só consulta)
     [M8]  Lançar e corrigir (a ficha da grade numa gaveta)                 CUIDADO
     [M9]  O maestro

   ── LEGENDA ───────────────────────────────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, cores.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
*/
(function () {
  'use strict';
  if (window.__ncManutAtest || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [M2] A FICHA: CAMPOS, NOMES, BLOCOS E DICAS ════════════════════════════════════════
     Cada linha: [coluna da grade, nome na gaveta, 'meia' (meia linha) ou null, dica embaixo].
     { sec, dica } é um título de bloco. Coluna fora da lista não aparece na gaveta (a grade
     preenche sozinha: empresa, matrícula, data do lançamento, usuário, campos auxiliares).
     PODE MEXER os nomes, a ordem, os blocos, as dicas; a coluna tem de ser a da grade. */
  var FICHA = [
    { sec: 'O atestado' },
    ['COD_ATESTADO_MEDICO', 'Tipo de atestado'],
    ['COD_MOTIVO', 'Motivo', null, 'A lista muda conforme o tipo de atestado.'],
    ['COD_DOENCA', 'CID (doença)', null, 'Digite o código ou parte do nome. Ex.: J11 ou gripe.'],
    ['OCUPACIONAL', 'É ocupacional?', 'meia'], ['TIPO_ACIDENTE_ES', 'Tipo de acidente', 'meia'],
    ['COD_JUSTIFICATIVA', 'Justificativa no ponto', null, 'Vem preenchida pelo tipo de atestado. Mude só se precisar.'],
    { sec: 'Quem atestou' },
    ['COD_PREST_SERV', 'Médico', null, 'Não está na lista? Use "Cadastro de Médico", no alto da página.'],
    ['ENTIDADE_LOV', 'Clínica ou hospital', null, 'Não está na lista? Use "Cadastro de Entidade", no alto da página.'],
    { sec: 'Afastamento', dica: 'Informe o início e a quantidade de dias, ou o início e o término: o outro é calculado sozinho.' },
    ['DT_INICIO_AFASTAMENTO', 'Início', 'meia'], ['HORA_INICIO_AFASTAMENTO', 'Hora do início', 'meia', 'Só se for parte do dia. Ex.: 13:30'],
    ['QTDE_DIAS_AFASTAMENTO', 'Quantos dias', 'meia'], ['DT_TERMINO_AFASTAMENTO', 'Término', 'meia'],
    ['HORA_TERMINO_AFASTAMENTO', 'Hora do término', 'meia'],
    { sec: 'Mais informações' },
    ['DT_ALT_PROG', 'Alta programada', 'meia'], ['DT_PERICIA', 'Perícia', 'meia'],
    ['OBSERVACAO', 'Observação']
  ];
  /* janelas do resumo, em dias (PODE MEXER) */
  var JANELA_CURTA = 60, JANELA_LONGA = 365;

  /* ═══ [M3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function nome(t) {
    return String(t || '').toLowerCase().replace(/(^|[\s'(/-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); })
      .replace(/\s(De|Da|Do|Das|Dos|E|Em|Sem|Com|Por|Para|Ao|A|O)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  /* "007 - LICENÇA SEM CID" → "007 - Licença sem CID" (siglas curtas ficam em maiúsculas) */
  function codDesc(t) {
    t = String(t || '').trim(); if (!t || t === '-') return '';
    var m = /^([^\s-][^\s]*?)\s*-\s*(.+)$/.exec(t);
    var arruma = function (x) { return /[a-zà-ú]/.test(x) ? x : nome(x).replace(/\b(Cid|Crm|Cro|Nit|Uf|Inss|Sp|Rj|Mg)\b/g, function (s) { return s.toUpperCase(); }); };
    if (!m || !/\d/.test(m[1])) return arruma(t);
    return m[1] + ' - ' + arruma(m[2]);
  }
  function limpo(t) { t = String(t == null ? '' : t).replace(/\s+/g, ' ').trim(); return t === '-' || t === '.' ? '' : t; }
  function texto(id) { var e = $id(id + '_DISPLAY') || $id(id); if (!e) return ''; if (e.tagName === 'SELECT') return e.selectedIndex >= 0 && e.value ? e.options[e.selectedIndex].text.trim() : ''; return limpo(/^(INPUT|TEXTAREA)$/.test(e.tagName) ? e.value : e.textContent); }
  function dataBR(t) { var m = /(\d{2})\/(\d{2})\/(\d{2,4})/.exec(t || ''); if (!m) return null; var a = +m[3]; if (a < 100) a += 2000; return new Date(a, +m[2] - 1, +m[1]); }
  function dd(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear(); }
  function hoje() { var n = new Date(); return new Date(n.getFullYear(), n.getMonth(), n.getDate()); }
  function somaDias(d, n) { return new Date(d.getFullYear(), d.getMonth(), d.getDate() + n); }
  function dias(a, b) { return Math.round((b - a) / 864e5); }
  function hora(t) { t = String(t || '').replace(/\D/g, ''); if (t.length === 3) t = '0' + t; return t.length === 4 ? t.slice(0, 2) + ':' + t.slice(2) : ''; }
  function plural(n, um, varios) { return n + ' ' + (n === 1 ? um : varios); }
  var IC = {
    doc: '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4M9.5 12.5h6M9.5 16h6"/>',
    mais: '<path d="M12 5v14M5 12h14"/>', fechar: '<path d="M6 6l12 12M18 6L6 18"/>', check: '<path d="M5 12.5l4.5 4.5L19 7.5"/>',
    lapis: '<path d="M14.5 5.5l4 4L9 19H5v-4z"/>', seta: '<path d="M9.5 6l6 6-6 6"/>', olho: '<path d="M2.5 12s3.5-6.5 9.5-6.5 9.5 6.5 9.5 6.5-3.5 6.5-9.5 6.5S2.5 12 2.5 12z"/><circle cx="12" cy="12" r="2.6"/>',
    lixo: '<path d="M4.5 7h15M9.5 7V4.5h5V7M6.5 7l1 13h9l1-13M10.5 11v5.5M13.5 11v5.5"/>',
    lista: '<path d="M9 6h11M9 12h11M9 18h11M4.5 6h.01M4.5 12h.01M4.5 18h.01"/>', cartoes: '<rect x="4" y="4.5" width="16" height="6" rx="1.5"/><rect x="4" y="13.5" width="16" height="6" rx="1.5"/>',
    medico: '<circle cx="12" cy="7.5" r="3.5"/><path d="M5 20.5c.6-4 3.4-6 7-6s6.4 2 7 6"/><path d="M12 15v3.5M10.3 16.8h3.4"/>',
    predio: '<path d="M5 20.5V6.5l7-3 7 3v14M3.5 20.5h17M9 9.5h.01M15 9.5h.01M9 13.5h.01M15 13.5h.01M10.5 20.5v-3.5h3v3.5"/>',
    busca: '<circle cx="11" cy="11" r="6"/><path d="M20 20l-4.2-4.2"/>', relogio: '<circle cx="12" cy="12" r="8"/><path d="M12 7.5V12l3 2"/>'
  };
  function ic(n) { return '<svg class="nc-ma-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }

  function iniciar() {
    if (window.__ncManutAtest) return;
    /* ═══ [M1] COMO A PÁGINA É RECONHECIDA ════════════════════════════════════════════════
       CUIDADO  A região de busca é a que tem P12_MATRICULA; a grade só existe com o
                colaborador escolhido (condição da própria página).
       ════════════════════════════════════════════════════════════════════════════════════ */
    var mat = $id('P12_MATRICULA'), regBusca = mat && mat.closest('.t-Region');
    if (!regBusca || !$id('P12_COD_EMPRESA')) return;
    window.__ncManutAtest = true;
    document.body.classList.add('nc-ma-ativo');
    regBusca.classList.add('nc-ma-busca');

    /* ═══ [M4] QUEM É (O ALTO) ═══════════════════════════════════════════════════════════
       A busca continua a original (Empresa, Matrícula — mudar a matrícula recarrega a página,
       como sempre). Os 10 campos de leitura viram um cartão; os originais saem da vista.
       ════════════════════════════════════════════════════════════════════════════════════ */
    var titulo = regBusca.querySelector('.t-Region-title'); if (titulo) titulo.textContent = 'Colaborador';
    var LEITURA = ['P12_IDADE', 'P12_DESC_SITUACAO', 'P12_CARGO', 'P12_COD_CCUSTO', 'P12_COD_LOCALIZACAO', 'P12_PREDIO', 'P12_ANDAR', 'P12_SALA', 'P12_TIPO_SANGUINEO', 'P12_FATOR_RH'];
    LEITURA.forEach(function (id) { var c = $id(id + '_CONTAINER'), col = c && c.closest('.col'); (col || c || { classList: { add: function () {} } }).classList.add('nc-ma-guardado'); });
    [].forEach.call(regBusca.querySelectorAll('.t-Region-headerItems--buttons .t-Button, .t-Region-header .t-Button'), function (b) {
      b.classList.add(/cancelar/i.test(b.textContent) ? 'nc-ma-bt-cancelar' : 'nc-ma-bt-cadastro');
      if (/m[eé]dico/i.test(b.textContent)) b.title = 'Abre o cadastro de médicos (sai desta página)';
      if (/entidade/i.test(b.textContent)) b.title = 'Abre o cadastro de clínicas e hospitais (sai desta página)';
    });
    var corpoBusca = regBusca.querySelector('.t-Region-body') || regBusca;
    var quem = el('div', 'nc-ma-quem');
    corpoBusca.appendChild(quem);
    function desenharQuem() {
      var cod = apex.item('P12_MATRICULA').getValue();
      if (!cod) {
        quem.innerHTML = '<div class="nc-ma-vazio-quem">' + ic('busca') + '<div><b>Escolha a empresa e a matrícula do colaborador.</b>' +
          '<span>Os atestados dele aparecem logo abaixo, com o botão para lançar um novo.</span></div></div>';
        return;
      }
      var disp = texto('P12_MATRICULA');                 /* "205818-0 - TONY OLIVEIRA | 01 - ATIVO" */
      var nm = (disp.split(' | ')[0].split(' - ').slice(1).join(' - ') || '').trim();
      nm = nm ? (/[a-zà-ú]/.test(nm) ? nm : nome(nm)) : 'Colaborador';
      var num = (disp.split(' - ')[0] || cod).trim();
      var sitCod = parseInt(apex.item('P12_SITUACAO').getValue(), 10), sit = codDesc(texto('P12_DESC_SITUACAO')) || '';
      var deslig = sitCod >= 90;
      var ini = nm.split(/\s+/).filter(function (p) { return p.length > 2; });
      ini = ((ini[0] || '?').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '')).toUpperCase();
      var lugar = [texto('P12_PREDIO'), texto('P12_ANDAR') ? texto('P12_ANDAR') + 'º andar' : '', texto('P12_SALA') ? 'sala ' + texto('P12_SALA') : ''].filter(Boolean).join(' · ');
      var sangue = [texto('P12_TIPO_SANGUINEO'), texto('P12_FATOR_RH')].filter(function (x) { return x && x !== 'NI'; }).join(' ');
      var dados = [['Idade', texto('P12_IDADE') ? texto('P12_IDADE') + ' anos' : ''], ['Cargo', codDesc(texto('P12_CARGO'))], ['Setor', codDesc(texto('P12_COD_CCUSTO'))],
        ['Local', codDesc(texto('P12_COD_LOCALIZACAO'))], ['Onde fica', lugar], ['Sangue', sangue]].filter(function (d) { return d[1]; });
      quem.innerHTML = '<div class="nc-ma-pessoa">' +
        '<span class="nc-ma-avatar" aria-hidden="true">' + esc(ini) + '</span>' +
        '<div class="nc-ma-pessoa-txt"><p class="nc-ma-nome"><span class="nc-ma-num">' + esc(num) + ' - </span>' + esc(nm) +
          (sit ? '<span class="nc-ma-sit" data-tom="' + (deslig ? 'ruim' : 'bom') + '">' + esc(deslig ? 'Desligado · ' + sit.replace(/^\S+\s+-\s+/, '') : sit.replace(/^\S+\s+-\s+/, '')) + '</span>' : '') + '</p>' +
        '<dl class="nc-ma-dados">' + dados.map(function (d) { return '<div><dt>' + esc(d[0]) + '</dt><dd>' + esc(d[1]) + '</dd></div>'; }).join('') + '</dl></div></div>';
    }
    desenharQuem();

    /* ═══ [M5] LER A GRADE (OS ATESTADOS) ═════════════════════════════════════════════════
       CUIDADO  Só leitura do modelo da grade: valor e texto da lista ({v, d}). Atestados antigos
                gravados sem os zeros ("7" no lugar de "007") não acham o texto na lista: o nome
                é emprestado de outro atestado com o mesmo código.
       ════════════════════════════════════════════════════════════════════════════════════ */
    var G = null;
    (function () {
      [].some.call(document.querySelectorAll('.a-IG'), function (e) {
        var v; try { v = $(e).interactiveGrid('getViews', 'grid'); } catch (x) { return false; }
        if (!v || !v.modelColumns || !v.modelColumns.COD_ATESTADO_MEDICO || !v.modelColumns.DT_INICIO_AFASTAMENTO) return false;
        G = { v: v, ig: e, reg: e.closest('.t-IRR-region, .t-Region') || e };
        return true;
      });
    })();
    function val(rec, col) {
      if (!G.v.modelColumns[col]) return { v: '', d: '' };
      var x = G.v.model.getValue(rec, col);
      if (x && typeof x === 'object') return { v: x.v == null ? '' : String(x.v), d: limpo(x.d == null ? x.v : x.d) };
      return { v: x == null ? '' : String(x), d: limpo(x) };
    }
    function chave(v) { return /^\d+$/.test(v) ? String(+v) : v; }
    var NOMES = {};
    function rotulo(rec, col) {
      var x = val(rec, col); if (!x.v && !x.d) return '';
      if (/\s-\s/.test(x.d)) return codDesc(x.d);
      var n = NOMES[col] && NOMES[col][chave(x.v)];
      return n || codDesc(x.d || x.v);
    }
    /* "231 - Licenca sem CID" e "007 - Licença sem CID" dizem o mesmo: o motivo igual ao tipo não se repete */
    function semCod(t) { return String(t || '').replace(/^\S+\s+-\s+/, '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase().trim(); }
    function novoNaoGravado(rec) { var m = G.v.model.getRecordMetadata(G.v.model.getRecordId(rec)); return !!(m && (m.inserted || m.deleted)); }
    function atestados() {
      var out = [];
      NOMES = {};
      ['COD_ATESTADO_MEDICO', 'COD_MOTIVO', 'COD_PREST_SERV'].forEach(function (col) {
        NOMES[col] = {};
        G.v.model.forEach(function (rec) { var x = val(rec, col); if (/\s-\s/.test(x.d)) NOMES[col][chave(x.v)] = codDesc(x.d); });
      });
      G.v.model.forEach(function (rec) {
        if (novoNaoGravado(rec)) return;
        var ini = dataBR(val(rec, 'DT_INICIO_AFASTAMENTO').v), fim = dataBR(val(rec, 'DT_TERMINO_AFASTAMENTO').v);
        var qd = parseInt(val(rec, 'QTDE_DIAS_AFASTAMENTO').v, 10);
        if (!fim && ini && qd > 0) fim = somaDias(ini, qd - 1);
        var tipo = rotulo(rec, 'COD_ATESTADO_MEDICO'), mot = rotulo(rec, 'COD_MOTIVO');
        out.push({
          rid: G.v.model.getRecordId(rec), ini: ini, fim: fim, semFim: ini && !val(rec, 'DT_TERMINO_AFASTAMENTO').v && !(qd > 0), dias: qd > 0 ? qd : (ini && fim ? dias(ini, fim) + 1 : 0),
          lanc: dataBR(val(rec, 'DT_ATESTADO_MEDICO').v), hIni: hora(val(rec, 'HORA_INICIO_AFASTAMENTO').v), hFim: hora(val(rec, 'HORA_TERMINO_AFASTAMENTO').v),
          tipo: tipo || 'Atestado', motivo: mot && semCod(mot) !== semCod(tipo) ? mot : '',
          cid: codDesc(val(rec, 'COD_DOENCA').d), medico: rotulo(rec, 'COD_PREST_SERV'), entidade: codDesc(val(rec, 'ENTIDADE_LOV').d),
          ocup: val(rec, 'OCUPACIONAL').v === 'S', acid: limpo(val(rec, 'TIPO_ACIDENTE_ES').d), obs: limpo(val(rec, 'OBSERVACAO').v),
          alta: dataBR(val(rec, 'DT_ALT_PROG').v), pericia: dataBR(val(rec, 'DT_PERICIA').v), usuario: limpo(val(rec, 'USUARIO').d)
        });
      });
      out.sort(function (a, b) { return ((b.ini || b.lanc || 0) - (a.ini || a.lanc || 0)); });
      return out;
    }

    /* ═══ [M6] O RESUMO E OS CARTÕES ══════════════════════════════════════════════════════ */
    var app = null, TODOS = [], BUSCA = '';
    if (G) {
      app = el('section', 'nc-ma'); app.setAttribute('aria-label', 'Atestados do colaborador');
      G.reg.parentNode.insertBefore(app, G.reg);
      G.reg.classList.add('nc-ma-grade');
      app.innerHTML = '<div class="nc-ma-topo"><div><h2 class="nc-ma-h2">Atestados</h2><p class="nc-ma-conta"></p></div>' +
        '<div class="nc-ma-acoes"><div class="nc-ma-vistas" role="tablist" aria-label="Como ver">' +
          '<button type="button" role="tab" data-vista="lista" aria-selected="true">' + ic('cartoes') + 'Cartões</button>' +
          '<button type="button" role="tab" data-vista="tabela" aria-selected="false">' + ic('lista') + 'Tabela</button></div>' +
        '<button type="button" class="nc-ma-bt nc-ma-bt--primario nc-ma-novo" data-novo>' + ic('mais') + 'Lançar atestado</button></div></div>' +
        '<div class="nc-ma-resumo"></div>' +
        '<label class="nc-ma-busca-lista">' + ic('busca') + '<span class="nc-ma-so-leitor">Buscar nos atestados</span><input type="search" placeholder="Buscar: CID, médico, motivo, data…" autocomplete="off"></label>' +
        '<div class="nc-ma-lista"></div>';
    }
    var resumo = app && app.querySelector('.nc-ma-resumo'), listaEl = app && app.querySelector('.nc-ma-lista'), conta = app && app.querySelector('.nc-ma-conta'), buscaEl = app && app.querySelector('.nc-ma-busca-lista');
    /* dias de afastamento dentro da janela [hoje - n + 1, hoje] */
    function diasNaJanela(n) {
      var h = hoje(), de = somaDias(h, -(n - 1)), total = 0;
      TODOS.forEach(function (a) {
        if (!a.ini) return;
        var f = a.semFim ? h : (a.fim || a.ini), i = a.ini > de ? a.ini : de, t = f < h ? f : h;
        if (t >= i) total += dias(i, t) + 1;
      });
      return total;
    }
    function emVigor(a) { var h = hoje(); return a.ini && a.ini <= h && (a.semFim || (a.fim && a.fim >= h)); }
    function desenharLista() {
      if (!app) return;
      var podeNovo = pode('novo');
      app.querySelector('[data-novo]').hidden = !podeNovo;
      conta.textContent = TODOS.length ? plural(TODOS.length, 'atestado lançado', 'atestados lançados') : 'Nenhum atestado lançado';
      var agora = TODOS.filter(emVigor)[0];
      var curto = diasNaJanela(JANELA_CURTA), longo = diasNaJanela(JANELA_LONGA);
      resumo.innerHTML = TODOS.length ?
        '<div class="nc-ma-fato" data-tom="' + (agora ? 'ruim' : 'bom') + '"><span>Hoje</span><b>' + (agora ? (agora.semFim ? 'Afastado, sem término' : 'Afastado até ' + dd(agora.fim)) : 'Não está afastado') + '</b></div>' +
        '<div class="nc-ma-fato"><span>Últimos ' + JANELA_CURTA + ' dias</span><b>' + plural(curto, 'dia afastado', 'dias afastado') + '</b></div>' +
        '<div class="nc-ma-fato"><span>Últimos 12 meses</span><b>' + plural(longo, 'dia afastado', 'dias afastado') + '</b></div>' : '';
      resumo.hidden = !TODOS.length;
      buscaEl.hidden = TODOS.length < 6;
      if (!TODOS.length) {
        listaEl.innerHTML = '<div class="nc-ma-vazio">' + ic('doc') + '<b>Este colaborador ainda não tem atestado.</b>' +
          (podeNovo ? '<span>Toque em "Lançar atestado" para começar.</span>' : '') + '</div>';
        return;
      }
      var b = BUSCA.toLowerCase();
      var vis = TODOS.filter(function (a) {
        if (!b) return true;
        return [a.tipo, a.motivo, a.cid, a.medico, a.entidade, a.obs, a.ini ? dd(a.ini) : '', a.fim ? dd(a.fim) : ''].join(' ').toLowerCase().indexOf(b) >= 0;
      });
      if (!vis.length) { listaEl.innerHTML = '<div class="nc-ma-vazio"><b>Nada encontrado para "' + esc(BUSCA) + '".</b></div>'; return; }
      var html = '', ano = null, podeEd;
      vis.forEach(function (a) {
        var y = a.ini ? a.ini.getFullYear() : (a.lanc ? a.lanc.getFullYear() : 'Sem data');
        if (y !== ano) { if (ano !== null) html += '</ol>'; html += '<h3 class="nc-ma-ano">' + y + '</h3><ol class="nc-ma-itens">'; ano = y; }
        podeEd = pode('editar', a.rid);
        var vig = emVigor(a);
        var periodo = a.ini ? dd(a.ini) + (a.semFim ? ' · sem término' : a.fim && +a.fim !== +a.ini ? ' a ' + dd(a.fim) : '') : '';
        var dur = a.dias ? plural(a.dias, 'dia', 'dias') : '';
        var horas = a.hIni || a.hFim ? (a.hIni ? 'das ' + a.hIni : '') + (a.hFim ? ' às ' + a.hFim : '') : '';
        var marcas = (vig ? '<span class="nc-ma-marca" data-tom="ruim">Em vigor</span>' : '') + (a.semFim ? '<span class="nc-ma-marca" data-tom="atencao">Sem término</span>' : '') +
          (a.ocup ? '<span class="nc-ma-marca" data-tom="info">Ocupacional</span>' : '');
        html += '<li><button type="button" class="nc-ma-cartao' + (vig ? ' is-vigor' : '') + '" data-rid="' + esc(a.rid) + '">' +
          '<span class="nc-ma-quando">' + (a.ini ? '<b>' + ('0' + a.ini.getDate()).slice(-2) + '</b><span>' + MESES[a.ini.getMonth()] + '</span>' : '<b>—</b>') + '</span>' +
          '<span class="nc-ma-corpo">' +
            '<span class="nc-ma-tit">' + esc(a.tipo) + marcas + '</span>' +
            '<span class="nc-ma-periodo">' + ic('relogio') + '<span>' + esc([periodo, dur, horas].filter(Boolean).join(' · ') || 'Sem período informado') + '</span></span>' +
            ((a.motivo || a.cid) ? '<span class="nc-ma-linha">' + (a.motivo ? '<span><i>Motivo</i> ' + esc(a.motivo) + '</span>' : '') + (a.cid ? '<span><i>CID</i> ' + esc(a.cid) + '</span>' : '') + '</span>' : '') +
            ((a.medico || a.entidade) ? '<span class="nc-ma-linha nc-ma-fraco">' + (a.medico ? '<span>' + ic('medico') + esc(a.medico) + '</span>' : '') + (a.entidade ? '<span>' + ic('predio') + esc(a.entidade) + '</span>' : '') + '</span>' : '') +
            ((a.alta || a.pericia) ? '<span class="nc-ma-linha nc-ma-fraco">' + (a.alta ? '<span><i>Alta programada</i> ' + dd(a.alta) + '</span>' : '') + (a.pericia ? '<span><i>Perícia</i> ' + dd(a.pericia) + '</span>' : '') + '</span>' : '') +
            (a.obs ? '<span class="nc-ma-obs">' + esc(a.obs) + '</span>' : '') +
          '</span>' +
          '<span class="nc-ma-ir">' + ic(podeEd ? 'lapis' : 'olho') + '<span>' + (podeEd ? 'Editar' : 'Ver') + '</span></span>' +
        '</button></li>';
      });
      listaEl.innerHTML = html + '</ol>';
    }
    if (app) {
      app.addEventListener('click', function (ev) {
        var t = ev.target.closest('[data-novo],[data-rid],[data-vista]'); if (!t) return;
        if (t.hasAttribute('data-vista')) return vista(t.getAttribute('data-vista'));
        if (t.hasAttribute('data-novo')) return abrirFicha(null, t);
        abrirFicha(t.getAttribute('data-rid'), t);
      });
      buscaEl.querySelector('input').addEventListener('input', function (ev) { BUSCA = ev.target.value.trim(); desenharLista(); });
    }

    /* ═══ [M7] TABELA (A GRADE ORIGINAL, SÓ CONSULTA) ═════════════════════════════════════
       Os botões de editar, salvar e adicionar da grade ficam escondidos (CSS): lançar e
       corrigir é na gaveta.
       ════════════════════════════════════════════════════════════════════════════════════ */
    function vista(v) {
      document.body.classList.toggle('nc-ma-tabela', v === 'tabela');
      [].forEach.call(app.querySelectorAll('[data-vista]'), function (b) { b.setAttribute('aria-selected', b.getAttribute('data-vista') === v ? 'true' : 'false'); });
      if (v === 'tabela') $(window).trigger('resize'); else atualizar();
    }

    /* ═══ [M8] LANÇAR E CORRIGIR (A FICHA DA GRADE NUMA GAVETA) ═══════════════════════════
       CUIDADO  A gaveta é a "vista de um registro" (Single Row View) da PRÓPRIA grade: a região
                da grade entra na gaveta enquanto ela está aberta e volta ao fechar. Todas as
                ações dinâmicas das colunas (dias ↔ término, férias, justificativa, horas) e as
                validações continuam valendo. Salvar = o salvar da grade.
       Só aparece o que a página deixa: os esquemas de autorização de incluir/alterar/excluir.
       ════════════════════════════════════════════════════════════════════════════════════ */
    var GAV = null, EDIT = null;
    function pode(op, rid) {
      if (!G) return false;
      var m = G.v.model, rec;
      try {
        if (!m.getOption('editable')) return false;
        if (op === 'novo') return !!m.allowAdd();
        rec = m.getRecord(rid); if (!rec) return false;
        return !!(op === 'excluir' ? m.allowDelete(rec) : m.allowEdit(rec));
      } catch (x) { return false; }
    }
    function montarGaveta() {
      if (GAV) return;
      GAV = { fundo: el('div', 'nc-ma-gfundo'), caixa: el('aside', 'nc-ma-gaveta') };
      GAV.caixa.tabIndex = -1; GAV.caixa.setAttribute('role', 'dialog'); GAV.caixa.setAttribute('aria-modal', 'true'); GAV.caixa.setAttribute('aria-labelledby', 'nc-ma-gtit');
      GAV.cab = el('header', 'nc-ma-gcab'); GAV.corpo = el('div', 'nc-ma-gcorpo'); GAV.pe = el('footer', 'nc-ma-gpe');
      GAV.caixa.appendChild(GAV.cab); GAV.caixa.appendChild(GAV.corpo); GAV.caixa.appendChild(GAV.pe);
      document.body.appendChild(GAV.fundo); document.body.appendChild(GAV.caixa);
      GAV.fundo.addEventListener('click', function () { fecharComCuidado(); });
      GAV.caixa.addEventListener('click', function (ev) {
        if (ev.target.closest('[data-gfechar]')) fecharComCuidado();
        else if (ev.target.closest('[data-gcancelar]')) fecharFicha(true);
        else if (ev.target.closest('[data-gsalvar]')) salvarFicha();
        else if (ev.target.closest('[data-gexcluir]')) excluirFicha();
      });
      /* captura: com a gaveta aberta, o Esc é dela (calendário e avisos abertos ficam com o
         próprio Esc); Ctrl+S salva */
      window.addEventListener('keydown', function (ev) {
        if (!EDIT) return;
        if (ev.key === 'Escape') {
          if ([].some.call(document.querySelectorAll('.ui-datepicker, .ui-dialog, #alertify'), function (d) { return d.offsetParent !== null && getComputedStyle(d).visibility !== 'hidden'; })) return;
          ev.preventDefault(); ev.stopImmediatePropagation(); fecharComCuidado();
        }
        if ((ev.ctrlKey || ev.metaKey) && (ev.key === 's' || ev.key === 'S')) { ev.preventDefault(); ev.stopImmediatePropagation(); salvarFicha(); }
      }, true);
    }
    function idsDe(m) { var ids = []; m.forEach(function (r) { ids.push(m.getRecordId(r)); }); return ids; }
    function abrirFicha(rid, volta) {
      if (EDIT || !G) return;
      var novo = rid == null, edita = novo ? pode('novo') : pode('editar', rid), acoes;
      if (novo && !edita) return;
      try { acoes = $(G.ig).interactiveGrid('getActions'); } catch (x) { return; }
      montarGaveta();
      var v = G.v, m = v.model;
      EDIT = { novo: novo, rid: rid, edita: edita, acoes: acoes, volta: volta, lugar: document.createComment('nc-ma-grade') };
      G.reg.parentNode.insertBefore(EDIT.lugar, G.reg);
      GAV.corpo.appendChild(G.reg); G.reg.classList.add('nc-ma-motor');
      document.body.classList.add('nc-ma-editando');
      if (edita) { try { acoes.set('edit', true); } catch (x) { /* já está em edição */ } }
      if (novo) {
        var antes = idsDe(m);
        acoes.invoke('selection-add-row');
        EDIT.rid = idsDe(m).filter(function (id) { return antes.indexOf(id) < 0; })[0];
        if (EDIT.rid == null) { fecharFicha(false); return; }
      }
      /* a vista de um registro mostra o registro da célula ATIVA (como na Agenda Médica) */
      try { v.view$.grid('gotoCell', EDIT.rid, 'COD_ATESTADO_MEDICO'); } catch (x) { /* ok */ }
      acoes.invoke('single-row-view');
      try {
        var atual = function () { var r = v.singleRowView$ && v.singleRowView$.recordView('getRecord'); return r ? m.getRecordId(r) : null; };
        var lista = idsDe(m), alvo = lista.indexOf(EDIT.rid);
        for (var passo = 0; passo < 300 && atual() !== EDIT.rid; passo++) {
          var aqui = lista.indexOf(atual()); if (aqui < 0 || alvo < 0) break;
          acoes.invoke(aqui < alvo ? 'next-record' : 'previous-record');
        }
      } catch (x) { /* ok: segue com o que abriu */ }
      arrumarFicha();
      prepararHoras(G.v, EDIT.rid);
      var nm = (quem.querySelector('.nc-ma-nome') || {}).textContent || '';
      var rec = m.getRecord(EDIT.rid), meta = '';
      if (!novo && rec) {
        var lanc = val(rec, 'DT_ATESTADO_MEDICO').d, us = val(rec, 'USUARIO').d;
        meta = lanc ? 'Lançado em ' + lanc + (us ? ' por ' + us : '') : '';
      }
      GAV.cab.innerHTML = '<div><h2 id="nc-ma-gtit">' + (novo ? 'Lançar atestado' : edita ? 'Editar atestado' : 'Atestado') + '</h2>' +
        '<p class="nc-ma-gsub">' + esc(nm.replace(/(Ativo|Desligado.*)$/, '').trim()) + '</p>' + (meta ? '<p class="nc-ma-gmeta">' + esc(meta) + '</p>' : '') + '</div>' +
        '<button type="button" class="nc-ma-bt nc-ma-bt--icone" data-gfechar aria-label="Fechar">' + ic('fechar') + '</button>';
      GAV.pe.innerHTML = edita ?
        (!novo && pode('excluir', EDIT.rid) ? '<button type="button" class="nc-ma-bt nc-ma-bt--perigo" data-gexcluir>' + ic('lixo') + 'Excluir</button>' : '') +
        '<span class="nc-ma-gpe-espaco"></span><button type="button" class="nc-ma-bt" data-gcancelar>Cancelar</button>' +
        '<button type="button" class="nc-ma-bt nc-ma-bt--primario" data-gsalvar>' + ic('check') + (novo ? 'Lançar atestado' : 'Salvar') + '</button>'
        : '<span class="nc-ma-gpe-espaco"></span><button type="button" class="nc-ma-bt" data-gcancelar>Fechar</button>';
      GAV.caixa.classList.toggle('is-leitura', !edita);
      GAV.corpo.scrollTop = 0;
      setTimeout(function () {
        var f = [].filter.call(GAV.corpo.querySelectorAll('.u-Form > .u-Form-fieldContainer:not(.is-readonly) :is(input:not([type="hidden"]):not([readonly]):not([disabled]), select:not([disabled]))'), function (x) { return x.offsetParent !== null; })[0];
        (f && f.focus ? f : GAV.caixa).focus();
      }, 120);
    }
    /* os campos de FICHA ganham ordem, largura, nome e dica; os outros somem; os blocos ganham
       título. CUIDADO: a ficha do grid REESCREVE as classes dos campos a cada registro — por isso
       ordem, largura e o que aparece vão numa folha presa ao ID de cada campo (feita uma vez), e
       o nome e a dica são conferidos a cada abertura. */
    var folhaFicha = null;
    function arrumarFicha() {
      var rv = G.reg.querySelector('.a-RV'), form = rv && rv.querySelector('.u-Form'); if (!form) return;
      var regras = [];
      FICHA.forEach(function (f, i) {
        if (!f.length) {
          if (!form.querySelector('.nc-ma-gsec[data-i="' + i + '"]')) {
            var h = el('div', 'nc-ma-gsec', '<p>' + esc(f.sec) + '</p>' + (f.dica ? '<span>' + esc(f.dica) + '</span>' : ''));
            h.setAttribute('data-i', i); h.style.order = i; form.appendChild(h);
          }
          return;
        }
        var mc = G.v.modelColumns[f[0]], id = mc && (mc.elementId || '') + '_CONTAINER', c = id && $id(id);
        if (!c) return;
        regras.push('html body:not(#nc-a1):not(#nc-a2).nc-ma-ativo .nc-ma-motor .a-RV .u-Form > #' + id + ':not(#nc-ma-x){display:flex!important;order:' + i + '!important;grid-column:' + (f[2] === 'meia' ? 'auto' : '1 / -1') + '!important}');
        var lb = c.querySelector('.u-Form-label, label'); if (lb && f[1] && lb.textContent !== f[1]) lb.textContent = f[1];
        if (f[3] && !c.querySelector('.nc-ma-dica')) c.appendChild(el('p', 'nc-ma-dica', esc(f[3])));
      });
      if (!folhaFicha) { folhaFicha = el('style'); folhaFicha.id = 'nc-ma-ficha'; document.head.appendChild(folhaFicha); folhaFicha.textContent = regras.join('\n'); }
      /* campo travado (tipo e motivo de atestado já gravado): mostra o nome, não só o código */
      var rec = G.v.model.getRecord(EDIT.rid);
      if (rec) ['COD_ATESTADO_MEDICO', 'COD_MOTIVO', 'COD_PREST_SERV'].forEach(function (col) {
        var mc = G.v.modelColumns[col], c = mc && $id((mc.elementId || '') + '_CONTAINER'), alvo = c && c.classList.contains('is-readonly') && c.querySelector('.u-Form-inputContainer');
        var r = rotulo(rec, col); if (alvo && r && alvo.children.length === 0) alvo.textContent = r;   /* travado: o valor é texto puro no contêiner */
      });
    }
    /* HORAS: hora do início e do término são TEXTO no banco (5 posições) e chegam de todo jeito
       ("1100", "11:00", "930"). Na gaveta: máscara 00:00 ao digitar (só números, os dois-pontos
       entram sozinhos), o que veio do banco aparece já como HH:MM, hora inválida avisa no campo, e
       ao salvar o registro vai SEMPRE com ":" (o que estava sem é corrigido na mesma gravação). */
    var HORAS = ['HORA_INICIO_AFASTAMENTO', 'HORA_TERMINO_AFASTAMENTO'];
    function fmtHora(t) {                       /* '' = vazio · null = inválida · 'HH:MM' */
      t = String(t == null ? '' : t).trim(); if (!t) return '';
      var d = t.replace(/\D/g, ''); if (!d || d.length > 4) return null;
      if (d.length <= 2) d = ('0' + d).slice(-2) + '00'; else if (d.length === 3) d = '0' + d;
      return +d.slice(0, 2) > 23 || +d.slice(2) > 59 ? null : d.slice(0, 2) + ':' + d.slice(2);
    }
    function valorDe(m, rec, col) { var x = m.getValue(rec, col); return x && typeof x === 'object' ? x.v : x; }
    function prepararHoras(v, rid) {
      var rec = v.model.getRecord(rid);
      HORAS.forEach(function (col) {
        var mc = v.modelColumns[col], inp = mc && $id(mc.elementId);
        if (!inp || inp.tagName !== 'INPUT') return;
        var cont = inp.closest('.u-Form-fieldContainer');
        if (!inp.getAttribute('data-nc-hora')) {
          inp.setAttribute('data-nc-hora', '1'); inp.setAttribute('inputmode', 'numeric'); inp.setAttribute('placeholder', '00:00');
          inp.setAttribute('autocomplete', 'off'); inp.maxLength = 5;
          var aviso = el('p', 'nc-hora-aviso', 'Hora inválida. Use de 00:00 a 23:59.'); aviso.hidden = true; if (cont) cont.appendChild(aviso);
          inp.addEventListener('input', function () {
            var d = inp.value.replace(/\D/g, '').slice(0, 4), novo = d.length > 2 ? d.slice(0, 2) + ':' + d.slice(2) : d;
            if (novo !== inp.value) inp.value = novo;
            aviso.hidden = true; if (cont) cont.classList.remove('nc-hora-ruim');
          });
          /* no "change" do próprio campo (antes de a grade ler o valor): completa "930" → "09:30" */
          inp.addEventListener('change', function () {
            var f = fmtHora(inp.value);
            if (f !== null) inp.value = f;
            aviso.hidden = f !== null; if (cont) cont.classList.toggle('nc-hora-ruim', f === null);
          }, true);
        }
        /* o que veio do banco aparece formatado (sem mexer no registro: só muda se ele salvar) */
        var f = rec ? fmtHora(valorDe(v.model, rec, col)) : null;
        if (f && inp.value !== f && document.activeElement !== inp) inp.value = f;
        var av = cont && cont.querySelector('.nc-hora-aviso'); if (av) av.hidden = true; if (cont) cont.classList.remove('nc-hora-ruim');
      });
    }
    /* antes de salvar: false se alguma hora é inválida; senão põe ":" no que estiver sem */
    function horasNoPadrao(v, rid) {
      var m = v.model, rec = m.getRecord(rid), md = rec && m.getRecordMetadata(rid), ok = true;
      if (!rec || (md && md.deleted)) return true;
      HORAS.forEach(function (col) {
        if (!v.modelColumns[col]) return;
        var atual = valorDe(m, rec, col), f = fmtHora(atual);
        if (f === null) { ok = false; var mc = v.modelColumns[col], inp = $id(mc.elementId), cont = inp && inp.closest('.u-Form-fieldContainer'); if (cont) { cont.classList.add('nc-hora-ruim'); var av = cont.querySelector('.nc-hora-aviso'); if (av) av.hidden = false; } return; }
        if (f !== String(atual == null ? '' : atual)) m.setValue(rec, col, f);
      });
      return ok;
    }
    /* CUIDADO: a ficha da grade só passa o valor de um campo para a grade quando o foco vai para
       OUTRO campo dela (Tab); clicar no Salvar da gaveta (fora da ficha) não passa — o último campo
       digitado ficava de fora. Antes de salvar, cada campo da ficha é copiado do formulário. */
    function numeroF(t) { t = String(t == null ? '' : t).trim(); if (!t) return NaN; if (t.indexOf(',') > -1) t = t.replace(/\./g, '').replace(',', '.'); return Number(t); }
    function sincronizarFicha(v, rid, cols) {
      var m = v.model, rec = m.getRecord(rid); if (!rec) return;
      cols.forEach(function (col) {
        var mc = v.modelColumns[col], it; if (!mc) return;
        try { it = apex.item(mc.elementId); } catch (e) { return; }
        if (!it || !it.node || it.node.disabled) return;
        var nv = it.getValue(); if (Array.isArray(nv)) nv = nv.join(':'); nv = nv == null ? '' : String(nv);
        var atual = m.getValue(rec, col), obj = !!atual && typeof atual === 'object', av = obj ? String(atual.v == null ? '' : atual.v) : String(atual == null ? '' : atual);
        if (nv === av) return;
        if (!obj && nv && av && numeroF(nv) === numeroF(av)) return;
        if (obj) { var d = ''; try { d = it.displayValueFor ? it.displayValueFor(nv) : ''; } catch (e) {} m.setValue(rec, col, { v: nv, d: d || nv }); }
        else m.setValue(rec, col, nv);
      });
    }
    function fecharComCuidado() {
      if (!EDIT || EDIT.ocupado) return;
      var mudou = false; try { mudou = G.v.model.isChanged(); } catch (x) { /* ok */ }
      if (!mudou) return fecharFicha(true);
      apex.message.confirm('Sair sem salvar? O que foi preenchido será descartado.', function (ok) { if (ok) fecharFicha(true); });
    }
    function fecharFicha(desfazer) {
      if (!EDIT) return;
      var e = EDIT, m = G.v.model;
      /* desfazer: linha NOVA sai da grade (revertRecords não a tira, no APEX 19.2); linha que já
         existia volta ao que estava gravado */
      if (desfazer) {
        try {
          var r = m.getRecord(e.rid), md = r && m.getRecordMetadata(e.rid);
          if (r) { if (md && md.inserted) m.deleteRecords([r]); else m.revertRecords([r]); }
        } catch (x) { /* ok */ }
      }
      try { e.acoes.invoke('close-single-row-view'); } catch (x) { /* ok */ }
      try { if (!m.isChanged()) e.acoes.set('edit', false); } catch (x) { /* ok */ }
      G.reg.classList.remove('nc-ma-motor');
      if (e.lugar.parentNode) { e.lugar.parentNode.insertBefore(G.reg, e.lugar); e.lugar.parentNode.removeChild(e.lugar); }
      document.body.classList.remove('nc-ma-editando');
      EDIT = null;
      atualizar();
      if (e.volta && document.body.contains(e.volta)) e.volta.focus();
    }
    /* Salvar: o salvar da grade. Se a grade barrar antes de ir ao servidor (campo obrigatório
       ou inválido — ela já marca o campo), a gaveta destrava e avisa. */
    function salvarFicha(oQue) {
      if (!EDIT || EDIT.ocupado || !EDIT.edita) return;
      /* 04/10: o último campo mexido dispara as ações dinâmicas da coluna (dias ↔ término,
         justificativa, horas…) ao sair dele — o clique no Salvar. Espera essas chamadas voltarem
         (até 6 s) antes de copiar a ficha e salvar, senão o valor que a ação traz fica de fora. */
      if ($.active > 0 && (!EDIT.espera || Date.now() - EDIT.espera < 6000)) {
        var e0 = EDIT; if (!e0.espera) e0.espera = Date.now();
        return setTimeout(function () { if (EDIT === e0) salvarFicha(oQue); }, 80);
      }
      EDIT.espera = 0;
      var e = EDIT, m = G.v.model;
      if (oQue !== 'excluido') sincronizarFicha(G.v, e.rid, FICHA.filter(function (f) { return f.length; }).map(function (f) { return f[0]; }));
      if (!m.isChanged()) return fecharFicha(false);
      if (oQue !== 'excluido' && !horasNoPadrao(G.v, e.rid)) return avisar('Confira a hora: use de 00:00 a 23:59.', true);
      e.ocupado = true; e.oQue = oQue || (e.novo ? 'lancado' : 'salvo'); ocupado(true);
      try { e.acoes.invoke('save'); } catch (x) { e.ocupado = false; ocupado(false); return avisar('Não foi possível salvar. Tente de novo.', true); }
      setTimeout(function () {
        if (EDIT !== e || !e.ocupado || $.active > 0 || !m.isChanged()) return;
        e.ocupado = false; ocupado(false);
        avisar('Falta preencher ou corrigir os campos marcados em vermelho.', true);
        var errado = GAV.corpo.querySelector('.u-Form > .is-error, .u-Form .is-error');
        if (errado) errado.scrollIntoView({ block: 'center', behavior: 'smooth' });
      }, 450);
    }
    function excluirFicha() {
      if (!EDIT || EDIT.ocupado) return;
      var e = EDIT;
      apex.message.confirm('Excluir este atestado? Depois de excluir não dá para desfazer.', function (ok) {
        if (!ok || EDIT !== e) return;
        try { G.v.model.deleteRecords([G.v.model.getRecord(e.rid)]); } catch (x) { return avisar('Não foi possível excluir.', true); }
        salvarFicha('excluido');
      });
    }
    function ocupado(sim) {
      if (!GAV) return;
      GAV.caixa.classList.toggle('is-ocupada', sim);
      [].forEach.call(GAV.pe.querySelectorAll('button'), function (b) { b.disabled = sim; });
      var bs = GAV.pe.querySelector('[data-gsalvar]'); if (bs) bs.lastChild.textContent = sim ? 'Salvando…' : (EDIT && EDIT.novo ? 'Lançar atestado' : 'Salvar');
    }
    /* CUIDADO: a grade dispara "interactivegridsave" também quando a gravação FALHA (com status
       de erro). Só é sucesso com status ok E sem nada pendente no modelo; senão a gaveta fica
       aberta com o que foi digitado. */
    if (G) $(G.reg).on('interactivegridsave', function (ev, data) {
      if (!EDIT || !EDIT.ocupado) return;
      var e = EDIT, ok = (!data || data.status === undefined || data.status === 'success') && !G.v.model.isChanged();
      e.ocupado = false; ocupado(false);
      if (!ok) return avisar('Não foi possível salvar. Confira a mensagem e tente de novo.', true);
      avisar({ lancado: 'Atestado lançado', salvo: 'Atestado atualizado', excluido: 'Atestado excluído' }[e.oQue] || 'Atestado salvo');
      fecharFicha(false);
      /* busca de novo: o servidor completa campos ao gravar (descrição do motivo, entidade…) */
      setTimeout(function () { try { apex.region(G.reg.id).refresh(); } catch (x) { /* ok */ } }, 50);
    });
    /* erro do servidor (validação da página: férias, término, exclusão…): a gaveta destrava e
       fica aberta, com a mensagem da própria página */
    $(document).on('apexerror', function () { if (EDIT && EDIT.ocupado) { EDIT.ocupado = false; ocupado(false); } });

    var toast = el('div', 'nc-ma-aviso'); toast.setAttribute('role', 'status'); toast.setAttribute('aria-live', 'polite');
    document.body.appendChild(toast);
    var tAviso = null;
    function avisar(t, erro) {
      toast.innerHTML = (erro ? '' : ic('check')) + '<span>' + esc(t) + '</span>';
      toast.classList.toggle('is-erro', !!erro); toast.classList.add('is-visivel');
      clearTimeout(tAviso); tAviso = setTimeout(function () { toast.classList.remove('is-visivel'); }, 4000);
    }

    /* ═══ [M9] O MAESTRO ══════════════════════════════════════════════════════════════════ */
    function atualizar() { if (!G) return; try { TODOS = atestados(); desenharLista(); } catch (x) { if (window.console) console.warn('Natcorp_ManutencaoAtestados', x); } }
    atualizar();
    if (G) {
      var t0 = null, refaz = function () { clearTimeout(t0); t0 = setTimeout(function () { if (!EDIT && !document.body.classList.contains('nc-ma-tabela')) atualizar(); }, 120); };
      $(G.reg).on('apexafterrefresh interactivegridsave', refaz);
      try { G.v.model.subscribe({ onChange: refaz }); } catch (x) { /* ok */ }
    }
  }

  $(window).on('apexreadyend', function () { setTimeout(iniciar, 0); });
  if (document.readyState === 'complete') setTimeout(iniciar, 300);
  else window.addEventListener('load', function () { setTimeout(iniciar, 300); });
})();
