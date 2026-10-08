/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · LANÇAMENTO DE EXAMES  —  o "arrumador" da tela (JavaScript)                   ║
   ║  App 2937 (Medicina Ocupacional) · Página 11 · Manutenção de Exames Médicos (modal)      ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia desta página: LANCAMENTOEXAMES-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   É onde o médico LANÇA os exames do paciente (aberta pelo botão Exames do Exame Médico
   Ocupacional, 2937:19). Troca a planilha (o Interactive Grid "Exames", 18 colunas cortadas)
   por um HISTÓRICO legível e uma ficha para lançar:
     • no alto, fixo, QUEM é o paciente (código - nome, idade, cargo, setor, local, tipo
       sanguíneo), "Trocar paciente" (abre empresa e matrícula) e os cadastros (médico,
       entidade);
     • a SITUAÇÃO de cada exame: o último de cada um, com o próximo — vencido, vence em breve
       ou em dia — e um toque lança de novo;
     • o HISTÓRICO, do mais novo para o mais antigo: data, exame, tipo, resultado (com cor),
       próximo, médico e procedimento; busca e filtro por exame; um toque abre para editar;
     • tocar num exame abre o RESUMO (só leitura) com Editar, Lançar de novo e Excluir;
     • "Lançar exame" (e "Lançar de novo", que já vem com o exame, o tipo, o médico, a entidade
       e o procedimento do anterior) e "Editar" abrem a FICHA numa gaveta, em quatro partes —
       O exame, Resultado e próximo exame, Quem fez, Procedimento e laboratório —, com atalhos
       para o próximo exame (+6 meses, +1 ano, +2 anos) e o aviso do código do laboratório no
       Toxicológico. Salvar grava SÓ o exame da ficha.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     O Interactive Grid continua sendo o MOTOR: os dados, as listas (exame, resultado, médico,
     entidade, procedimento), as validações ("Obriga se Toxicológico"), o salvar (processo
     "Exames - Save Interactive Grid Data", "Set ENTIDADE", "Atualiza Tipo Prest Serv") e a
     ação do CGC são os de sempre. A ficha da gaveta é a "vista de um registro" do próprio grid.
     Nada é gravado sem o médico apertar "Salvar exame" ou confirmar "Excluir".
     Tirou as URLs deste arquivo: a página volta a ser o grid.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 11 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_LancamentoExames.js
     Página 11 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_LancamentoExames.css

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
     • o Interactive Grid com as colunas COD_EXAME, DT_EXAME, COD_RESULTADO e
       DT_PROX_EXAME_PERIOD (as outras são opcionais);
     • os itens P11_COD_EMPRESA e P11_MATRICULA (e os de mostrar: cargo, setor, idade…).
     Os ids das colunas (C130937…) NÃO são usados: mudam de uma base para a outra; o arquivo
     pergunta ao grid (modelColumns[...].elementId).

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [X1]  Como a página é reconhecida                                      CUIDADO
     [X2]  Textos, partes da ficha, cores do resultado e prazos             PODE MEXER
     [X3]  Ferramentas
     [X4]  Quem é o paciente (o alto)
     [X5]  Ler o grid (os exames)
     [X6]  A situação de cada exame
     [X7]  O histórico
     [X8]  O resumo e a ficha (a vista de um registro do grid, numa gaveta)  CUIDADO
     [X9]  Salvar e excluir (pelo grid)                                     CUIDADO
     [X10] O maestro                                                        CUIDADO

   ── LEGENDA ───────────────────────────────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, cores.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
*/
(function () {
  'use strict';
  if (window.__ncLancamentoExames || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [X2] TEXTOS, PARTES DA FICHA, CORES DO RESULTADO E PRAZOS ══════════════════════════
     PARTES     as quatro partes da ficha e as colunas de cada uma, na ordem (rótulo novo).
     COPIAR     o que "Lançar de novo" traz do exame anterior (data, resultado e próximo, não).
     TOM        a cor do resultado pelo texto (Apto/Normal → bom; Inapto/Alterado → atenção).
     PRAZOS     os atalhos do próximo exame, em meses a partir da data do exame.
     PERTO      com quantos dias antes o próximo exame fica "vence em breve".
     TOXICO     o código do exame que exige o código do laboratório (validação da página).
     PODE MEXER tudo daqui.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PARTES = [
    ['O exame', [['COD_EXAME', 'Exame'], ['DT_EXAME', 'Data do exame'], ['TIPO_EXAME', 'Tipo'], ['OCUPACIONAL', 'Ocupacional'], ['ORDEM_EXAME', 'Ordem'], ['COMPLEMENTO_EXAME', 'Complemento']]],
    ['Resultado e próximo exame', [['COD_RESULTADO', 'Resultado'], ['DT_PROX_EXAME_PERIOD', 'Próximo exame']]],
    ['Quem fez', [['COD_PREST_SERV', 'Médico'], ['COD_PREST_SERV_ORIGEM', 'Origem'], ['COD_ENTIDADE_LOV', 'Entidade'], ['CGC_LAB', 'CNPJ do laboratório'], ['DC_CGC_LAB', 'Dígito']]],
    ['Procedimento e laboratório', [['COD_PROCEDIMENTO', 'Procedimento'], ['OBS_PROCEDIMENTO', 'Observação do procedimento'], ['COD_EXAME_LAB', 'Código do exame no laboratório']]]
  ];
  /* 04/10: CGC_LAB e DC_CGC_LAB vêm junto com a entidade — na página, quem os preenche é a ação
     SET CGC ao escolher a entidade, e a cópia (setValue no modelo) não dispara essa ação */
  var COPIAR = ['COD_EXAME', 'TIPO_EXAME', 'OCUPACIONAL', 'ORDEM_EXAME', 'COMPLEMENTO_EXAME', 'COD_PREST_SERV', 'COD_PREST_SERV_ORIGEM', 'COD_ENTIDADE_LOV', 'CGC_LAB', 'DC_CGC_LAB', 'COD_PROCEDIMENTO'];
  function TOM(t) { t = String(t || ''); if (/inapto|alterad|anormal|reprov/i.test(t)) return 'atencao'; if (/apto|normal|aprovad/i.test(t)) return 'bom'; return 'neutro'; }
  var PRAZOS = [[6, '+6 meses'], [12, '+1 ano'], [24, '+2 anos']];
  var PERTO = 30;
  var TOXICO = 'TO';

  /* ═══ [X3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function nome(t) {
    return String(t || '').toLowerCase().replace(/(^|[\s'(/-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); })
      .replace(/\s(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  /* "478 - CONFEITEIRO" → "478 - Confeiteiro" (o código fica, o nome se arruma) */
  function codDesc(t) {
    t = String(t || '').trim(); if (!t) return '';
    var m = /^(\S+)\s+-\s+(.+)$/.exec(t);
    if (!m) return /[a-zà-ú]/.test(t) ? t : nome(t);
    return m[1] + ' - ' + (/[a-zà-ú]/.test(m[2]) ? m[2] : nome(m[2]));
  }
  function texto(id) { var e = $id(id + '_DISPLAY') || $id(id); if (!e) return ''; return String(/^(INPUT|SELECT|TEXTAREA)$/.test(e.tagName) ? e.value : e.textContent).trim(); }
  function dataBR(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function dd(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear(); }
  function hoje() { var n = new Date(); return new Date(n.getFullYear(), n.getMonth(), n.getDate()); }
  function dias(a, b) { return Math.round((b - a) / 864e5); }
  /* 9848 dias → "27 anos"; 75 → "2 meses"; 12 → "12 dias" */
  function quanto(n) {
    n = Math.abs(n);
    if (n >= 365) { var a = Math.floor(n / 365.25), m = Math.floor((n - a * 365.25) / 30.44); return a + (a === 1 ? ' ano' : ' anos') + (m > 0 && a < 3 ? ' e ' + m + (m === 1 ? ' mês' : ' meses') : ''); }
    if (n >= 60) { var mm = Math.floor(n / 30.44); return mm + ' meses'; }
    return n + (n === 1 ? ' dia' : ' dias');
  }
  function maisMeses(d, m) { var r = new Date(d.getFullYear(), d.getMonth() + m, d.getDate()); if (r.getDate() !== d.getDate()) r.setDate(0); return r; }
  var IC = {
    mais: '<path d="M12 5.5v13M5.5 12h13"/>', fechar: '<path d="M7 7l10 10M17 7L7 17"/>',
    lapis: '<path d="M14.5 5.5l4 4L9 19H5v-4z"/>', repetir: '<path d="M4.5 12a7.5 7.5 0 0 1 12.9-5.2M19.5 12a7.5 7.5 0 0 1-12.9 5.2"/><path d="M17.5 3.5v3.6h-3.6M6.5 20.5v-3.6h3.6"/>',
    lixo: '<path d="M5 7h14M10 7V5h4v2M7 7l1 12h8l1-12"/>', check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>',
    busca: '<circle cx="11" cy="11" r="6"/><path d="M20 20l-4.2-4.2"/>', pessoa: '<circle cx="12" cy="8.5" r="3.5"/><path d="M5 20a7 7 0 0 1 14 0"/>',
    trocar: '<path d="M4 8h12.5M13 4.5L16.5 8 13 11.5M20 16H7.5M11 12.5L7.5 16l3.5 3.5"/>', ouvido: '<path d="M8 9.5a4.5 4.5 0 1 1 9 0c0 3-3 3.5-3 6.5a2.5 2.5 0 0 1-5 0"/><path d="M11 9.5a1.5 1.5 0 0 1 3 0"/>',
    frasco: '<path d="M9.5 3.5h5M10.5 3.5v5.2L5.6 17.3A2 2 0 0 0 7.3 20.3h9.4a2 2 0 0 0 1.7-3l-4.9-8.6V3.5"/><path d="M7.7 14h8.6"/>'
  };
  function ic(n) { return '<svg class="nc-lx-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }

  function iniciar() {
    if (window.__ncLancamentoExames) return;
    /* ═══ [X1] COMO A PÁGINA É RECONHECIDA ════════════════════════════════════════════════
       Pelo grid (as colunas do exame) e pelo item da matrícula — nunca pelo número do app. Sem
       eles, o arquivo para aqui e a página fica como o APEX desenhou.
       ════════════════════════════════════════════════════════════════════════════════════ */
    var igEl = document.querySelector('.a-IG');
    var ig = igEl ? $(igEl) : null;
    if (!ig || !ig.interactiveGrid || !$id('P11_MATRICULA')) return;
    var vista = function () { return ig.interactiveGrid('getViews', 'grid'); };
    var v0 = vista();
    if (!v0 || !v0.model || !v0.modelColumns || !v0.modelColumns.COD_EXAME || !v0.modelColumns.DT_EXAME || !v0.modelColumns.COD_RESULTADO) return;
    window.__ncLancamentoExames = true;
    var acoes = ig.interactiveGrid('getActions');
    var regIG = igEl.closest('.t-IRR-region, .t-Region') || igEl.parentElement;
    var regPesq = $id('P11_MATRICULA').closest('.t-Region');
    document.body.classList.add('nc-lx-ativo');
    regIG.classList.add('nc-lx-motor');
    if (regPesq) regPesq.classList.add('nc-lx-pesquisa');

    var corpoDlg = document.querySelector('.t-Dialog-body') || regIG.parentNode;
    var cabDlg = document.querySelector('.t-Dialog-header');
    var app = el('section', 'nc-lx'); app.setAttribute('aria-label', 'Exames do paciente');
    corpoDlg.insertBefore(app, corpoDlg.firstChild);

    /* ═══ [X4] QUEM É O PACIENTE ══════════════════════════════════════════════════════════
       Lido dos itens da região "Pesquisar Funcionário". "Trocar paciente" mostra só empresa e
       matrícula (a troca de matrícula recarrega a página, como sempre). Os botões de cadastro
       (médico, entidade) são os originais, mudados para cá.
       ════════════════════════════════════════════════════════════════════════════════════ */
    var pac = el('header', 'nc-lx-paciente');
    var estreito = window.matchMedia && window.matchMedia('(max-width: 720px)');
    function lugarPaciente() { if ((estreito && estreito.matches) || !cabDlg) app.insertBefore(pac, app.firstChild); else cabDlg.appendChild(pac); document.body.classList.toggle('nc-lx-cab-fixo', pac.parentNode === cabDlg); }
    function desenharPaciente() {
      var quem = texto('P11_MATRICULA'), m = /^\s*(\S+)\s+-\s+(.+)$/.exec(quem);
      var cod = m ? m[1] : '', nm = m ? m[2] : quem;
      if (nm && !/[a-zà-ú]/.test(nm)) nm = nome(nm);
      var ini = String(nm || '?').split(/\s+/).filter(function (p) { return p.length > 2; });
      ini = ((ini[0] || '?').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '')).toUpperCase();
      var sangue = [texto('P11_TIPO_SANGUINEO'), texto('P11_FATOR_RH')].filter(function (x) { return x && x !== 'NI'; }).join(' ');
      var idade = texto('P11_IDADE');
      var dados = [
        ['Idade', idade ? idade + (/ano/.test(idade) ? '' : ' anos') : ''],
        ['Cargo', codDesc(texto('P11_CARGO'))],
        ['Setor', codDesc(texto('P11_COD_CCUSTO'))],
        ['Local', codDesc(texto('P11_COD_LOCALIZACAO'))],
        ['Empresa', codDesc(texto('P11_COD_EMPRESA'))],
        ['Sangue', sangue || (texto('P11_TIPO_SANGUINEO') === 'NI' ? 'Não informado' : '')],
        ['Prédio', texto('P11_PREDIO')], ['Andar', texto('P11_ANDAR')], ['Sala', texto('P11_SALA')]
      ].filter(function (d) { return d[1]; });
      pac.querySelector('.nc-lx-pac-id').innerHTML = quem ?
        '<span class="nc-lx-avatar" aria-hidden="true">' + esc(ini) + '</span>' +
        '<div class="nc-lx-pac-nome"><h1>' + (cod ? '<span class="nc-lx-cod">' + esc(cod) + ' - </span>' : '') + esc(nm) + '</h1>' +
        '<dl class="nc-lx-pac-dados">' + dados.map(function (d) { return '<div data-k="' + esc(d[0].toLowerCase()) + '"><dt>' + esc(d[0]) + '</dt><dd>' + esc(d[1]) + '</dd></div>'; }).join('') + '</dl></div>'
        : '<span class="nc-lx-avatar" aria-hidden="true">' + ic('pessoa') + '</span><div class="nc-lx-pac-nome"><h1>Escolha o paciente</h1><p class="nc-lx-fraco">Empresa e matrícula, em "Trocar paciente".</p></div>';
    }
    pac.innerHTML = '<div class="nc-lx-pac-id"></div><div class="nc-lx-pac-acoes"></div>';
    var pacAcoes = pac.querySelector('.nc-lx-pac-acoes');
    var bTrocar = el('button', 'nc-lx-bt', ic('trocar') + '<span>Trocar paciente</span>'); bTrocar.type = 'button';
    bTrocar.setAttribute('aria-expanded', 'false');
    pacAcoes.appendChild(bTrocar);
    if (regPesq) [].forEach.call(regPesq.querySelectorAll('.t-Region-buttons button.t-Button, .t-Region-headerItems--buttons button.t-Button'), function (b) {
      b.classList.add('nc-lx-bt', 'nc-lx-bt--leve'); pacAcoes.appendChild(b);
    });
    var abrirTroca = function (sim) {
      document.body.classList.toggle('nc-lx-trocando', sim);
      bTrocar.setAttribute('aria-expanded', sim ? 'true' : 'false');
      if (sim) { var e = $id('P11_MATRICULA'); if (e) setTimeout(function () { e.focus(); }, 50); }
    };
    bTrocar.addEventListener('click', function () { abrirTroca(!document.body.classList.contains('nc-lx-trocando')); });
    if (regPesq) app.appendChild(regPesq);
    desenharPaciente(); lugarPaciente();
    if (estreito && estreito.addEventListener) estreito.addEventListener('change', lugarPaciente);
    if (!texto('P11_MATRICULA')) abrirTroca(true);

    /* ═══ [X5] LER O GRID (OS EXAMES) ═════════════════════════════════════════════════════
       Cada registro do grid vira um exame: { rec, id, exame{v,d}, data, resultado, proximo… }.
       ════════════════════════════════════════════════════════════════════════════════════ */
    function val(rec, col) {
      var m = vista().model; if (!m.getFieldKey || m.getFieldKey(col) === undefined) return { v: '', d: '' };
      var x = m.getValue(rec, col);
      if (x && typeof x === 'object') return { v: x.v == null ? '' : String(x.v), d: x.d == null ? String(x.v || '') : String(x.d) };
      return { v: x == null ? '' : String(x), d: x == null ? '' : String(x) };
    }
    function exames() {
      var v = vista(), m = v.model, out = [];
      m.forEach(function (rec, i, id) {
        var meta = m.getRecordMetadata(id) || {};
        if (meta.deleted || meta.agg) return;
        var ex = val(rec, 'COD_EXAME');
        var e = {
          rec: rec, id: id, novo: !!meta.inserted, mudou: !!(meta.updated || meta.inserted),
          exame: ex, data: dataBR(val(rec, 'DT_EXAME').v), dataTxt: val(rec, 'DT_EXAME').v,
          resultado: val(rec, 'COD_RESULTADO'), proximo: dataBR(val(rec, 'DT_PROX_EXAME_PERIOD').v),
          tipo: val(rec, 'TIPO_EXAME'), ocup: val(rec, 'OCUPACIONAL'), medico: val(rec, 'COD_PREST_SERV'),
          proc: val(rec, 'COD_PROCEDIMENTO'), entidade: val(rec, 'COD_ENTIDADE_LOV'), audio: val(rec, 'AUDIOMETRIA')
        };
        e.nomeExame = String(ex.d || ex.v || 'Exame').replace(/^\s*(\S+)\s+-\s+/, function (m0, c) { e.codExame = c; return ''; });
        if (!e.codExame) e.codExame = ex.v;
        out.push(e);
      });
      out.sort(function (a, b) { return (b.data || 0) - (a.data || 0); });
      return out;
    }
    function rotuloResultado(r) { return String(r.d || r.v || '').replace(/\s*-\s*eSocial:.*$/i, ''); }
    function linkAudio(rec) {
      /* a coluna Audiometria é um link do grid (abre a página 95): o mesmo href, do próprio grid */
      var v = vista(), id = v.model.getRecordId(rec), tr = v.view$ && v.view$[0].querySelector('tr[data-id="' + (window.CSS && CSS.escape ? CSS.escape(id) : id) + '"]');
      var col = v.modelColumns.AUDIOMETRIA, a = null;
      if (tr) [].forEach.call(tr.querySelectorAll('a[href]'), function (x) { if (/:95:/.test(x.getAttribute('href'))) a = x; });
      return a ? a.getAttribute('href') : (col ? null : null);
    }

    /* ═══ [X6] A SITUAÇÃO DE CADA EXAME ═══════════════════════════════════════════════════
       O exame mais recente de cada código, com o próximo: vencido, vence em breve (PERTO
       dias) ou em dia. Um toque em "Lançar de novo" abre a ficha já com o anterior.
       ════════════════════════════════════════════════════════════════════════════════════ */
    function situacao(e) {
      if (!e.proximo) return { tom: 'neutro', txt: 'Sem próximo exame' };
      var n = dias(hoje(), e.proximo);
      if (n < 0) return { tom: 'vencido', txt: 'Venceu há ' + quanto(n), quando: dd(e.proximo) };
      if (n === 0) return { tom: 'perto', txt: 'Vence hoje', quando: dd(e.proximo) };
      if (n <= PERTO) return { tom: 'perto', txt: 'Vence em ' + quanto(n), quando: dd(e.proximo) };
      return { tom: 'emdia', txt: 'Em dia', quando: dd(e.proximo) };
    }

    /* ═══ [X7] O HISTÓRICO ════════════════════════════════════════════════════════════════ */
    var FILTRO = '', BUSCA = '';
    var cab = el('div', 'nc-lx-cab');
    cab.innerHTML = '<div class="nc-lx-cab-tit"><h2>Exames</h2><span class="nc-lx-total"></span></div>' +
      '<label class="nc-lx-busca">' + ic('busca') + '<span class="nc-lx-so-leitor">Buscar no histórico</span><input type="search" placeholder="Buscar exame, médico, procedimento" autocomplete="off"></label>' +
      '<button type="button" class="nc-lx-bt nc-lx-bt--primario" data-novo>' + ic('mais') + '<span>Lançar exame</span></button>';
    app.appendChild(cab);
    var sit = el('section', 'nc-lx-situacao'); sit.setAttribute('aria-label', 'Situação de cada exame'); app.appendChild(sit);
    var filtros = el('div', 'nc-lx-filtros'); filtros.setAttribute('role', 'toolbar'); filtros.setAttribute('aria-label', 'Filtrar por exame'); app.appendChild(filtros);
    var lista = el('ol', 'nc-lx-lista'); lista.setAttribute('aria-label', 'Histórico de exames'); app.appendChild(lista);
    var toast = el('div', 'nc-lx-aviso'); toast.setAttribute('role', 'status'); toast.setAttribute('aria-live', 'polite'); document.body.appendChild(toast);

    function desenhar() {
      var todos = exames();
      cab.querySelector('.nc-lx-total').textContent = todos.length ? todos.length + (todos.length === 1 ? ' exame' : ' exames') : '';

      /* a situação: o último de cada exame */
      var ult = {}, ordem = [];
      todos.forEach(function (e) { if (!e.codExame || e.novo) return; if (!ult[e.codExame]) { ult[e.codExame] = e; ordem.push(e.codExame); } });
      var peso = { vencido: 0, perto: 1, emdia: 2, neutro: 3 };
      ordem.sort(function (a, b) { return peso[situacao(ult[a]).tom] - peso[situacao(ult[b]).tom]; });
      sit.innerHTML = ordem.length ? '<h3 class="nc-lx-sit-tit">Situação</h3><ul class="nc-lx-sit-lista">' + ordem.map(function (c) {
        var e = ult[c], s = situacao(e);
        return '<li class="nc-lx-sit" data-tom="' + s.tom + '"><div class="nc-lx-sit-txt"><b>' + esc(e.nomeExame) + '</b><span class="nc-lx-sit-estado">' + esc(s.txt) + '</span>' + (s.quando ? '<span class="nc-lx-sit-quando">próximo ' + esc(s.quando) + '</span>' : '') + '</div>' +
          '<button type="button" class="nc-lx-bt nc-lx-bt--mini" data-repetir="' + esc(e.id) + '" title="Lançar ' + esc(e.nomeExame) + ' de novo, com os dados do último">' + ic('repetir') + '<span>Lançar de novo</span></button></li>';
      }).join('') + '</ul>' : '';
      sit.hidden = !ordem.length;

      /* os filtros: um por exame (com quantos), além de Todos */
      var conta = {};
      todos.forEach(function (e) { if (e.codExame) conta[e.codExame] = (conta[e.codExame] || 0) + 1; });
      var cods = Object.keys(conta);
      if (FILTRO && !conta[FILTRO]) FILTRO = '';
      filtros.innerHTML = cods.length > 1 ? '<button type="button" class="nc-lx-chip" data-filtro="" aria-pressed="' + (!FILTRO) + '">Todos <span>' + todos.length + '</span></button>' +
        cods.map(function (c) { var e = ult[c] || todos.filter(function (x) { return x.codExame === c; })[0]; return '<button type="button" class="nc-lx-chip" data-filtro="' + esc(c) + '" aria-pressed="' + (FILTRO === c) + '">' + esc(c) + ' <span>' + conta[c] + '</span></button>'; }).join('') : '';
      filtros.hidden = cods.length < 2;

      /* o histórico */
      var b = BUSCA.toLowerCase();
      var vis = todos.filter(function (e) {
        if (FILTRO && e.codExame !== FILTRO) return false;
        if (!b) return true;
        return [e.exame.d, e.medico.d, e.proc.d, e.resultado.d, e.tipo.d, e.entidade.d, e.dataTxt].join(' ').toLowerCase().indexOf(b) >= 0;
      });
      if (!todos.length) {
        lista.innerHTML = '<li class="nc-lx-vazio"><p><b>Nenhum exame lançado para este paciente.</b></p><p>Use "Lançar exame" para o primeiro.</p></li>';
        return;
      }
      if (!vis.length) { lista.innerHTML = '<li class="nc-lx-vazio"><p>Nada encontrado para "' + esc(BUSCA) + '".</p></li>'; return; }
      lista.innerHTML = vis.map(function (e) {
        var r = rotuloResultado(e.resultado), ehUlt = ult[e.codExame] === e, s = ehUlt ? situacao(e) : null;
        return '<li class="nc-lx-item' + (e.mudou ? ' is-pendente' : '') + '">' +
          '<button type="button" class="nc-lx-linha" data-editar="' + esc(e.id) + '" aria-label="Editar ' + esc(e.nomeExame) + (e.data ? ' de ' + dd(e.data) : '') + '">' +
            '<span class="nc-lx-data">' + (e.data ? '<b>' + ('0' + e.data.getDate()).slice(-2) + '</b><span>' + MESES[e.data.getMonth()] + ' ' + e.data.getFullYear() + '</span>' : '<span>sem data</span>') + '</span>' +
            '<span class="nc-lx-principal">' +
              '<span class="nc-lx-exame"><span class="nc-lx-codex">' + esc(e.codExame) + '</span>' + esc(e.nomeExame) + '</span>' +
              '<span class="nc-lx-tags">' +
                (e.tipo.d ? '<span class="nc-lx-tag">' + esc(e.tipo.d) + '</span>' : '') +
                (e.ocup.v === 'S' ? '<span class="nc-lx-tag">Ocupacional</span>' : '') +
                (e.proc.d ? '<span class="nc-lx-proc">' + esc(e.proc.d) + '</span>' : '') +
              '</span>' +
            '</span>' +
            '<span class="nc-lx-res" data-tom="' + (r ? TOM(r) : 'vazio') + '">' + (r ? esc(r) : 'Sem resultado') + '</span>' +
            '<span class="nc-lx-prox">' + (e.proximo ? '<span class="nc-lx-rot">Próximo</span><b>' + dd(e.proximo) + '</b>' + (s && s.tom !== 'emdia' && s.tom !== 'neutro' ? '<span class="nc-lx-venc" data-tom="' + s.tom + '">' + esc(s.txt) + '</span>' : '') : '<span class="nc-lx-rot">Sem próximo</span>') + '</span>' +
            '<span class="nc-lx-med">' + (e.medico.d ? '<span class="nc-lx-rot">Médico</span>' + esc(codDesc(e.medico.d)) : '') + '</span>' +
            (e.mudou ? '<span class="nc-lx-pend">Não salvo</span>' : '') +
          '</button>' +
          '<span class="nc-lx-item-acoes">' +
            (e.audio.v || linkAudio(e.rec) ? '<a class="nc-lx-bt nc-lx-bt--icone" href="' + esc(linkAudio(e.rec) || '#') + '" title="Audiometria deste exame">' + ic('ouvido') + '<span class="nc-lx-so-leitor">Audiometria</span></a>' : '') +
            '<button type="button" class="nc-lx-bt nc-lx-bt--icone" data-repetir="' + esc(e.id) + '" title="Lançar de novo, com os dados deste">' + ic('repetir') + '<span class="nc-lx-so-leitor">Lançar de novo</span></button>' +
          '</span>' +
        '</li>';
      }).join('');
    }
    var tDesenho = null;
    function redesenhar() { clearTimeout(tDesenho); tDesenho = setTimeout(desenhar, 30); }

    app.addEventListener('click', function (ev) {
      var t = ev.target.closest('[data-editar],[data-repetir],[data-novo],[data-filtro]');
      if (!t || OCUPADO || EDITANDO) return;
      if (t.hasAttribute('data-filtro')) { FILTRO = t.getAttribute('data-filtro'); return desenhar(); }
      if (t.hasAttribute('data-novo')) return novo(null);
      var e = acharExame(t.getAttribute('data-editar') || t.getAttribute('data-repetir'));
      if (!e) return;
      if (t.hasAttribute('data-repetir')) return novo(e);
      abrirResumo(e);
    });
    cab.querySelector('input[type="search"]').addEventListener('input', function (ev) { BUSCA = ev.target.value.trim(); desenhar(); });
    function acharExame(id) { return exames().filter(function (e) { return String(e.id) === String(id); })[0]; }

    /* ═══ [X8] O RESUMO E A FICHA ═════════════════════════════════════════════════════════
       Tocar num exame abre o RESUMO (só leitura, desenhado daqui, sem passar pelo grid) com
       Editar · Lançar de novo · Excluir. Editar, Lançar exame e Lançar de novo abrem a FICHA:
       a "vista de um registro" do próprio grid (as listas, os calendários, as validações e a
       ação SET CGC são os de sempre), numa gaveta, em quatro partes (PARTES).
       CUIDADO  Como a ficha é posta no exame certo (testado 15 de 15; o outro jeito errava):
                • a vista de um registro é aberta UMA vez e nunca fechada (fechar e reabrir a
                  deixava presa num registro, mostrando outro exame);
                • para trocar de exame: sai da edição → recordOffset = a posição do exame →
                  entra na edição;
                • e CONFERE (o registro e a data no campo); sem bater, a ficha não abre.
       ════════════════════════════════════════════════════════════════════════════════════ */
    var gaveta = null, resumo = null, EDITANDO = null, VENDO = null, OCUPADO = false, SRV = false;
    var fundo = el('div', 'nc-lx-fundo'); document.body.appendChild(fundo);
    fundo.addEventListener('click', function () { if (EDITANDO) fechar(true); else fecharResumo(); });
    function cid(col) { var c = vista().modelColumns[col]; return c && c.elementId; }
    function ordemDoGrid() { var v = vista(), ids = []; v.model.forEach(function (r, i, id) { var md = v.model.getRecordMetadata(id) || {}; if (!md.deleted) ids.push(String(id)); }); return ids; }

    /* — o resumo — */
    function abrirResumo(e) {
      if (!resumo) {
        resumo = el('aside', 'nc-lx-resumo'); resumo.setAttribute('role', 'dialog'); resumo.setAttribute('aria-modal', 'true');
        document.body.appendChild(resumo);
        resumo.addEventListener('click', function (ev) {
          var t = ev.target.closest('[data-r]'); if (!t || !VENDO || OCUPADO) return;
          var a = t.getAttribute('data-r'), x = acharExame(VENDO);
          if (a === 'fechar') return fecharResumo();
          if (!x) return fecharResumo();
          if (a === 'editar') { fecharResumo(); return abrir(x, false); }
          if (a === 'repetir') { fecharResumo(); return novo(x); }
          if (a === 'excluir') return pintarResumo(x, true);
          if (a === 'manter') return pintarResumo(x, false);
          if (a === 'sim') return excluir(x);
        });
      }
      VENDO = e.id;
      pintarResumo(e, false);
      document.body.classList.add('nc-lx-vendo');
      setTimeout(function () { var b = resumo.querySelector('[data-r="editar"]'); if (b) b.focus(); }, 60);
    }
    function pintarResumo(e, confirmando) {
      var r = rotuloResultado(e.resultado), ult = exames().filter(function (x) { return x.codExame === e.codExame && !x.novo; })[0] === e, s = ult ? situacao(e) : null;
      var partes = PARTES.map(function (p) {
        var linhas = p[1].map(function (c) {
          if (!vista().modelColumns[c[0]]) return '';
          var x = val(e.rec, c[0]), t = c[0] === 'COD_RESULTADO' ? rotuloResultado(x) : (x.d || x.v);
          /* nomes de pessoas e entidades se arrumam ("019 - Maria…"); exame, resultado e procedimento ficam como vêm (EPF, ASO) */
          if (/^(COD_PREST_SERV|COD_PREST_SERV_ORIGEM|COD_ENTIDADE_LOV)$/.test(c[0]) && t) t = codDesc(t);
          return t ? '<div><dt>' + esc(c[1]) + '</dt><dd>' + esc(t) + '</dd></div>' : '';
        }).join('');
        return linhas ? '<section><h3>' + esc(p[0]) + '</h3><dl>' + linhas + '</dl></section>' : '';
      }).join('');
      resumo.innerHTML =
        '<header class="nc-lx-rcab"><div><p class="nc-lx-gtitulo"><span class="nc-lx-codex">' + esc(e.codExame) + '</span>' + esc(e.nomeExame) + '</p>' +
          '<p class="nc-lx-gsub">' + (e.data ? 'Exame de ' + dd(e.data) : 'Sem data') + '</p></div>' +
          '<button type="button" class="nc-lx-bt nc-lx-bt--icone" data-r="fechar" aria-label="Fechar">' + ic('fechar') + '</button></header>' +
        '<div class="nc-lx-rcorpo">' +
          '<div class="nc-lx-rdestaque"><span class="nc-lx-res" data-tom="' + (r ? TOM(r) : 'vazio') + '">' + (r ? esc(r) : 'Sem resultado') + '</span>' +
            (e.proximo ? '<span class="nc-lx-rprox">Próximo exame <b>' + dd(e.proximo) + '</b>' + (s && (s.tom === 'vencido' || s.tom === 'perto') ? ' <span class="nc-lx-venc" data-tom="' + s.tom + '">' + esc(s.txt) + '</span>' : '') + '</span>' : '') + '</div>' +
          partes +
        '</div>' +
        '<footer class="nc-lx-rpe">' + (confirmando ?
          '<p class="nc-lx-gconf">Excluir este exame do histórico? Não dá para desfazer.</p><button type="button" class="nc-lx-bt nc-lx-bt--perigo" data-r="sim">' + ic('lixo') + '<span>Excluir</span></button><button type="button" class="nc-lx-bt" data-r="manter">Manter</button>' :
          '<button type="button" class="nc-lx-bt nc-lx-bt--primario nc-lx-bt--largo" data-r="editar">' + ic('lapis') + '<span>Editar</span></button>' +
          '<button type="button" class="nc-lx-bt" data-r="repetir">' + ic('repetir') + '<span>Lançar de novo</span></button>' +
          '<button type="button" class="nc-lx-bt nc-lx-bt--icone nc-lx-bt--excluir" data-r="excluir" title="Excluir este exame">' + ic('lixo') + '<span class="nc-lx-so-leitor">Excluir</span></button>') +
        '</footer>';
      if (confirmando) { var b = resumo.querySelector('[data-r="sim"]'); if (b) b.focus(); }
    }
    function fecharResumo() { VENDO = null; document.body.classList.remove('nc-lx-vendo'); }

    /* — a ficha — */
    function montarGaveta() {
      if (gaveta) return;
      gaveta = { cab: el('div', 'nc-lx-gcab'), pe: el('div', 'nc-lx-gpe') };
      regIG.insertBefore(gaveta.cab, regIG.firstChild);
      regIG.appendChild(gaveta.pe);
      gaveta.cab.addEventListener('click', function (ev) { if (ev.target.closest('[data-gfechar]')) fechar(true); });
      gaveta.pe.addEventListener('click', function (ev) {
        if (ev.target.closest('[data-gsalvar]')) salvar();
        if (ev.target.closest('[data-gcancelar]')) fechar(true);
      });
    }
    document.addEventListener('keydown', function (ev) {
      if (!EDITANDO && !VENDO) return;
      /* Esc fecha — menos quando a lista de busca ou o calendário estão abertos (o Esc é deles) */
      var aberto = [].some.call(document.querySelectorAll('.ui-dialog-popuplov, #ui-datepicker-div, .ui-datepicker'), function (x) { return x.offsetParent !== null && getComputedStyle(x).display !== 'none'; });
      if (ev.key === 'Escape' && !aberto) { ev.preventDefault(); ev.stopPropagation(); if (EDITANDO) fechar(true); else fecharResumo(); }
      if (EDITANDO && (ev.ctrlKey || ev.metaKey) && (ev.key === 's' || ev.key === 'S')) { ev.preventDefault(); ev.stopPropagation(); salvar(); }
    }, true);   /* na captura: o grid "engole" o Esc (sai do modo de edição) antes de chegar ao documento */
    function pe() {
      gaveta.pe.innerHTML = '<button type="button" class="nc-lx-bt nc-lx-bt--primario nc-lx-bt--largo" data-gsalvar>' + ic('check') + '<span>Salvar exame</span></button><button type="button" class="nc-lx-bt" data-gcancelar>Cancelar</button>';
    }
    /* põe a ficha no exame (ver o CUIDADO acima) e chama cb(true/false) */
    function irPara(e, cb0) {
      var feito = false;
      var cb = function (ok) { if (feito) return; feito = true; cb0(ok); };
      setTimeout(function () { cb(false); }, 4000);   /* nunca fica presa: sem resposta em 4 s, não abre */
      var passo = function (f, ms) { setTimeout(function () { try { f(); } catch (x) { cb(false); } }, ms); };
      var v = vista();
      if (!SRV || !v.singleRowMode) { try { acoes.invoke('single-row-view'); SRV = true; } catch (x) { return cb(false); } }
      var rv = v.singleRowView$; if (!rv) return cb(false);
      try { acoes.set('edit', false); } catch (x) { /* ok */ }
      passo(function () {
        var k = ordemDoGrid().indexOf(String(e.id));
        if (k < 0) return cb(false);
        rv.recordView('option', 'recordOffset', k);
        passo(function () {
          try { acoes.set('edit', true); } catch (x) { /* ok */ }
          passo(function () { cb(confere(e)); }, 220);
        }, 60);
      }, 40);
    }
    function confere(e) {
      var v = vista(), rv = v.singleRowView$, r = rv && rv.recordView('getRecord');
      if (!r || String(v.model.getRecordId(r)) !== String(e.id)) return false;
      var inp = $id(cid('DT_EXAME'));
      return !inp || inp.value === (val(e.rec, 'DT_EXAME').v || '');
    }
    /* as quatro partes: põe os campos na ordem, com o título de cada parte e o rótulo novo */
    function arrumarFicha() {
      var form = regIG.querySelector('.a-RV .u-Form'); if (!form) return;
      [].forEach.call(form.querySelectorAll('.nc-lx-parte'), function (h) { h.remove(); });
      var usados = {};
      PARTES.forEach(function (p) {
        var h = el('h3', 'nc-lx-parte', esc(p[0])); form.appendChild(h);
        p[1].forEach(function (c) {
          var id = cid(c[0]), cont = id && $id(id + '_CONTAINER'); if (!cont) return;
          usados[cont.id] = true;
          cont.setAttribute('data-col', c[0]);
          var l = cont.querySelector('.u-Form-label, label'); if (l) l.textContent = c[1];
          form.appendChild(cont);
        });
      });
      /* algum campo que o desenho não conhece vai para o fim, visível (a Audiometria, link, some) */
      var idAudio = cid('AUDIOMETRIA');
      [].forEach.call(form.querySelectorAll('.u-Form-fieldContainer'), function (c) { if (idAudio && c.id === idAudio + '_CONTAINER') c.setAttribute('data-col', 'AUDIOMETRIA'); if (!usados[c.id]) form.appendChild(c); });
      /* atalhos do próximo exame */
      var cp = $id(cid('DT_PROX_EXAME_PERIOD') + '_CONTAINER');
      if (cp && !cp.querySelector('.nc-lx-prazos')) {
        var pz = el('div', 'nc-lx-prazos', '<span>A partir da data do exame:</span>' + PRAZOS.map(function (x) { return '<button type="button" class="nc-lx-chip" data-meses="' + x[0] + '">' + esc(x[1]) + '</button>'; }).join(''));
        cp.appendChild(pz);
        pz.addEventListener('click', function (ev) {
          var b = ev.target.closest('[data-meses]'); if (!b || !EDITANDO) return;
          var e = acharExame(EDITANDO.id); if (!e) return;
          var d = dataBR(val(e.rec, 'DT_EXAME').v);
          if (!d) { avisar('Preencha a data do exame primeiro.', true); return; }
          var novaData = dd(maisMeses(d, +b.getAttribute('data-meses')));
          vista().model.setValue(e.rec, 'DT_PROX_EXAME_PERIOD', novaData);
          /* 04/10: o campo da ficha mostra o mesmo valor (o salvar copia a ficha para o registro) */
          try { apex.item(cid('DT_PROX_EXAME_PERIOD')).setValue(novaData, null, true); } catch (x) { /* ok */ }
          avisosFicha();
        });
      }
      avisosFicha();
    }
    /* o aviso do Toxicológico (a validação da página exige o código do laboratório) */
    function avisosFicha() {
      if (!EDITANDO) return;
      var e = acharExame(EDITANDO.id); if (!e) return;
      var c = $id(cid('COD_EXAME_LAB') + '_CONTAINER'); if (!c) return;
      var n = c.querySelector('.nc-lx-nota');
      var exige = val(e.rec, 'COD_EXAME').v === TOXICO;
      c.classList.toggle('nc-lx-exigido', exige);
      if (exige && !n) { n = el('p', 'nc-lx-nota', 'Obrigatório no exame Toxicológico.'); c.appendChild(n); }
      if (!exige && n) n.remove();
    }
    function abrir(e, novoReg) {
      if (OCUPADO) return;
      montarGaveta();
      EDITANDO = { id: e.id, novo: !!novoReg };
      gaveta.cab.innerHTML = '<div><p class="nc-lx-gtitulo">' + (novoReg ? 'Lançar exame' : esc(e.nomeExame || 'Editar exame')) + '</p>' +
        '<p class="nc-lx-gsub">' + (novoReg ? 'Os campos com * são obrigatórios.' : (e.data ? 'Exame de ' + dd(e.data) : 'Editar exame')) + '</p></div>' +
        '<button type="button" class="nc-lx-bt nc-lx-bt--icone" data-gfechar aria-label="Fechar">' + ic('fechar') + '</button>';
      pe();
      OCUPADO = true;
      document.body.classList.add('nc-lx-editando', 'nc-lx-abrindo');
      var tentativa = 0;
      var depois = function (ok) {
        /* não bateu: uma segunda tentativa (uma resposta da ação SET CGC chegando no meio atrapalha) */
        if (!ok && tentativa++ < 1) return setTimeout(function () { irPara(e, depois); }, 350);
        OCUPADO = false;
        document.body.classList.remove('nc-lx-abrindo');
        if (!ok) {
          try { acoes.set('edit', false); } catch (x) { /* ok */ }
          document.body.classList.remove('nc-lx-editando');
          if (novoReg) { try { vista().model.deleteRecords([e.rec]); } catch (x) { /* ok */ } }
          else if (e.rec) { try { vista().model.revertRecords([e.rec]); } catch (x) { /* ok */ } }
          EDITANDO = null;
          desenhar();
          avisar('Não foi possível abrir este exame. Feche a janela e abra de novo.', true);
          return;
        }
        arrumarFicha();
        var alvo = $id(cid(novoReg && !val(e.rec, 'COD_EXAME').v ? 'COD_EXAME' : 'COD_RESULTADO'));
        if (alvo && alvo.focus) alvo.focus();
      };
      irPara(e, depois);
    }
    /* "Lançar exame" (vazio, sem data) ou "Lançar de novo" (com os dados do anterior) */
    function novo(base) {
      if (OCUPADO) return;
      var m = vista().model;
      var id = m.insertNewRecord();
      var rec = m.getRecord(id);
      if (!rec) { avisar('Não foi possível abrir um exame novo.', true); return; }
      if (base) COPIAR.forEach(function (c) {
        if (!vista().modelColumns[c]) return;
        var x = m.getValue(base.rec, c);
        if (x !== undefined && x !== null && x !== '' && !(typeof x === 'object' && !x.v)) m.setValue(rec, c, typeof x === 'object' ? { v: x.v, d: x.d } : x);
      });
      /* 04/10 (cliente): a data do exame fica em branco — quem informa é a pessoa */
      redesenhar();
      abrir({ id: m.getRecordId(rec), rec: rec, nomeExame: base ? base.nomeExame : '' }, true);
    }
    function fechar(desfazer) {
      if (!EDITANDO || OCUPADO) return;
      var e = acharExame(EDITANDO.id), m = vista().model;
      if (desfazer && e) {
        try {
          if (EDITANDO.novo) m.deleteRecords([e.rec]);    /* o novo que não foi salvo some */
          else m.revertRecords([e.rec]);
        } catch (x) { /* ok */ }
      }
      try { acoes.set('edit', false); } catch (x) { /* ok: a ficha fica aberta, fora da vista */ }
      document.body.classList.remove('nc-lx-editando');
      EDITANDO = null;
      desenhar();
    }

    /* ═══ [X9] SALVAR E EXCLUIR (PELO GRID) ═══════════════════════════════════════════════
       CUIDADO  Toda gravação passa pelo "salvar" do grid — é ele que roda os processos da
                página (Set ENTIDADE, Atualiza Tipo Prest Serv) e a validação do Toxicológico.
                Antes de salvar, qualquer OUTRO registro alterado sem o médico pedir (a ação
                SET CGC reescreve o CNPJ quando um registro entra em edição) volta ao que era:
                só vai para o banco o exame da ficha. Com erro, a ficha fica aberta.
       ════════════════════════════════════════════════════════════════════════════════════ */
    var PENDENTE = null;
    function soEste(id) {
      var m = vista().model, outros = [], novos = [];
      m.forEach(function (r, i, rid) {
        if (String(rid) === String(id)) return;
        var md = m.getRecordMetadata(rid) || {};
        if (md.inserted) novos.push(r); else if (md.updated) outros.push(r);
      });
      try { if (outros.length) m.revertRecords(outros); if (novos.length) m.deleteRecords(novos); } catch (x) { /* ok */ }
    }
    /* 04/10: a ficha do grid só passa o valor de um campo para a grade quando o foco vai para
       OUTRO campo dela (Tab); "Salvar exame" fica fora da ficha e o último campo digitado ficava
       de fora (e, se era o único, nada era salvo). Antes de salvar, cada campo da ficha é copiado
       do formulário para o registro (o mesmo de Natcorp_ManutencaoAtestados). Campo desligado
       pela página (CNPJ e dígito, ação SET CGC) fica como está. */
    function numeroF(t) { t = String(t == null ? '' : t).trim(); if (!t) return NaN; if (t.indexOf(',') > -1) t = t.replace(/\./g, '').replace(',', '.'); return Number(t); }
    function sincronizarFicha(id) {
      var v = vista(), m = v.model, rv = v.singleRowView$, r = null;
      try { r = rv && rv.recordView('getRecord'); } catch (x) { r = null; }
      if (!r || String(m.getRecordId(r)) !== String(id)) return;
      PARTES.forEach(function (p) {
        p[1].forEach(function (c) {
          var col = c[0], mc = v.modelColumns[col], it; if (!mc) return;
          try { it = apex.item(mc.elementId); } catch (x) { return; }
          if (!it || !it.node || it.node.disabled) return;
          var nv = it.getValue(); if (Array.isArray(nv)) nv = nv.join(':'); nv = nv == null ? '' : String(nv);
          var atual = m.getValue(r, col), obj = !!atual && typeof atual === 'object', av = obj ? String(atual.v == null ? '' : atual.v) : String(atual == null ? '' : atual);
          if (nv === av) return;
          if (!obj && nv && av && numeroF(nv) === numeroF(av)) return;
          if (obj) { var dsp = ''; try { dsp = it.displayValueFor ? it.displayValueFor(nv) : ''; } catch (x) { /* ok */ } m.setValue(r, col, { v: nv, d: dsp || nv }); }
          else m.setValue(r, col, nv);
        });
      });
    }
    function salvar() {
      if (OCUPADO || !EDITANDO) return;
      if (document.activeElement && document.activeElement.blur) document.activeElement.blur();
      var m = vista().model;
      sincronizarFicha(EDITANDO.id);
      soEste(EDITANDO.id);
      if (!m.isChanged()) { fechar(false); return; }
      OCUPADO = true;
      PENDENTE = { texto: EDITANDO.novo ? 'Exame lançado' : 'Exame salvo' };
      ocupado(true);
      setTimeout(function () {
        try { acoes.invoke('save'); } catch (x) { OCUPADO = false; PENDENTE = null; ocupado(false); avisar('Não foi possível salvar. Tente de novo.', true); }
      }, 60);
    }
    function excluir(e) {
      if (OCUPADO) return;
      OCUPADO = true;
      PENDENTE = { texto: 'Exame excluído', excluiu: true };
      try { soEste(e.id); vista().model.deleteRecords([e.rec]); acoes.invoke('save'); } catch (x) { OCUPADO = false; PENDENTE = null; avisar('Não foi possível excluir. Tente de novo.', true); }
    }
    function ocupado(s) { if (!gaveta) return; [].forEach.call(gaveta.pe.querySelectorAll('button'), function (b) { b.disabled = s; }); gaveta.pe.classList.toggle('is-ocupado', s); }
    $(regIG).on('interactivegridsave', function (ev, data) {
      var ok = !data || data.status === undefined || data.status === 'success';
      var p = PENDENTE; PENDENTE = null; OCUPADO = false;
      ocupado(false);
      var comErro = false;
      try { vista().model.forEach(function (r, i, id) { var md = vista().model.getRecordMetadata(id); if (md && md.error) comErro = true; }); } catch (x) { /* ok */ }
      if (p) {
        if (ok && !comErro) {
          avisar(p.texto);
          if (p.excluiu) fecharResumo();
          else if (EDITANDO) { EDITANDO.novo = false; fechar(false); }
        } else avisar(p.excluiu ? 'Não foi possível excluir: confira a mensagem do sistema.' : 'Não salvou: confira o campo marcado na ficha.', true);
      }
      redesenhar();
    });
    $(document).on('apexerror', function () { if (OCUPADO && PENDENTE) { OCUPADO = false; PENDENTE = null; ocupado(false); } });
    var tAviso = null;
    function avisar(t, erro) {
      toast.innerHTML = (erro ? '' : ic('check')) + '<span>' + esc(t) + '</span>';
      toast.classList.toggle('is-erro', !!erro);
      toast.classList.add('is-visivel');
      clearTimeout(tAviso);
      tAviso = setTimeout(function () { toast.classList.remove('is-visivel'); }, 3400);
    }

    /* ═══ [X10] O MAESTRO ═════════════════════════════════════════════════════════════════
       Desenha agora e sempre que o grid muda (busca do servidor, salvar, um valor na ficha).
       ════════════════════════════════════════════════════════════════════════════════════ */
    var inscrito = null;
    function ouvir() {
      var m = vista().model;
      if (inscrito && inscrito.m === m) return;
      inscrito = { m: m, id: m.subscribe({ onChange: function (tipo) { redesenhar(); if (EDITANDO && tipo === 'set') avisosFicha(); } }) };
    }
    ouvir();
    /* o grid se refez (busca do servidor): a ficha precisa ser aberta de novo na próxima vez */
    $(regIG).on('apexafterrefresh', function () { SRV = false; ouvir(); redesenhar(); });
    desenhar();
  }

  /* começa no que vier primeiro: o fim do "ready" do APEX ou a página já pronta */
  $(window).on('apexreadyend', function () { setTimeout(iniciar, 0); });
  if (document.readyState === 'complete') setTimeout(iniciar, 300);
  else window.addEventListener('load', function () { setTimeout(iniciar, 300); });
})();
