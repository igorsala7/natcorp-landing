/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · AGENDA MÉDICA  —  o "arrumador" da tela (JavaScript)                          ║
   ║  App 2937 (Medicina Ocupacional) · Página 10 · Controle de Agendas Médicas              ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia desta página: AGENDAMEDICA-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Troca a planilha (o Interactive Grid "Horários" + 11 botões) por uma AGENDA DO DIA feita para
   o médico — 70% no computador, o resto no celular:
     • no alto, o dia por extenso ("Segunda-feira, 5 de outubro · Hoje") com ‹ Hoje ›, quem é o
       profissional, a sala e a empresa (Alterar abre os filtros de sempre), o resumo do dia —
       agendados, na clínica, atendidos, livres — que também filtra a lista, e "atualizado às".
     • a lista do dia: um horário por linha, em Manhã / Tarde / Noite, com o paciente, se é
       colaborador ou candidato, o tipo de consulta, a senha, o pré-atendimento e UM botão com o
       próximo passo (Agendar → Marcar chegada → Concluir atendimento). Horários bloqueados em
       sequência viram uma linha só. No dia de hoje, a linha "agora".
     • tocar num horário abre o painel (ao lado no computador, de baixo para cima no celular):
       Agendado → Chegou → Atendido, o próximo passo e SÓ as ações que valem para aquele horário
       (Atendimento · Paciente · Agenda) — as que não valem nem aparecem.
     • Agendar/Editar abre, numa gaveta, a ficha do horário com só o que importa (tipo de
       paciente, paciente, tipo de consulta, observação).
     • a agenda se atualiza sozinha a cada minuto (quando não há nada sendo editado).

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     O Interactive Grid continua sendo o MOTOR: os dados, a lista de pacientes (que depende do
     tipo), o salvar (com o processo que bloqueia o horário nas outras empresas) e as regras da
     página (regra_negocio) são os de sempre. Este arquivo só:
       • escolhe o horário no grid (como o clique na linha) — as regras liberam os botões;
       • aperta os botões originais (Avaliação médica, ASO, Remarcar…), que fazem o que sempre
         fizeram (salvam antes, se preciso, e abrem a tela);
       • marca Chegou / Realizado / Bloqueado no grid e salva pelo próprio grid.
     Nada é gravado sem o médico pedir. Tirou as URLs deste arquivo: a página volta a ser o grid.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 10 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_AgendaMedica.js
     Página 10 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_AgendaMedica.css

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
     • o Interactive Grid com Static ID "horarios" e as colunas HORA_INIC_PREVISTO,
       HORA_FIM_PREVISTO, BLOQUEADO, COMPARECEU, REALIZOU, TIPO_PACIENTE, COD_PACIENTE,
       COD_TIPO_CONSULTA (as outras são opcionais: OBSERVACAO, SENHA, PRE_ATENDIMENTO…);
     • os botões com os nomes de sempre (AVALIACAO_MEDICA, ASO, TRANSFERIR, DESMARCAR…) — os
       que faltarem só não aparecem;
     • os itens P10_DATA_AGENDA, P10_COD_PRESTR_SERV, P10_SALA, P10_COD_EMPRESA.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [A1]  Como a página é reconhecida                                      CUIDADO
     [A2]  Textos, estados, tipos de consulta e ações                      PODE MEXER
     [A3]  Ferramentas
     [A4]  Ler o grid (os horários do dia)
     [A5]  O alto: o dia, quem, o resumo
     [A6]  A lista do dia
     [A7]  O painel do horário e as ações
     [A8]  Agendar / editar (a ficha do grid numa gaveta)
     [A9]  Marcar e salvar (pelo grid)                                     CUIDADO
     [A10] Atualizar sozinho
     [A11] O maestro                                                       CUIDADO

   ── LEGENDA ───────────────────────────────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, cores.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
*/
(function () {
  'use strict';
  if (window.__ncAgendaMedica || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [A2] TEXTOS, ESTADOS, TIPOS DE CONSULTA E AÇÕES ════════════════════════════════════
     ESTADOS    os cinco jeitos de um horário estar (a mesma lógica da regra_negocio da página).
     CONSULTAS  a cor de cada tipo de consulta, pelo código (o texto vem do APEX).
     ACOES      os botões originais da página, com o nome que o médico entende e a seção do
                painel onde aparecem. O botão é apertado de verdade (o APEX faz o de sempre).
     PODE MEXER os textos e as cores.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var IG_ID = 'horarios';
  var ESTADOS = {
    livre: { rot: 'Livre', passo: 'Agendar' },
    agendado: { rot: 'Agendado', passo: 'Marcar chegada' },
    chegou: { rot: 'Na clínica', passo: 'Concluir atendimento' },
    realizado: { rot: 'Atendido', passo: '' },
    bloqueado: { rot: 'Bloqueado', passo: '' }
  };
  /* tom de cada tipo de consulta (cód. → tom do CSS [C4]); o que não estiver aqui fica neutro */
  var CONSULTAS = { '04': 'admissional', '05': 'demissional', '01': 'periodico', '07': 'mudanca', '09': 'retorno', '11': 'retorno',
    '02': 'ocupacional', '03': 'pericia', '13': 'pericia', '06': 'abono', '08': 'avaliacao', '10': 'avaliacao', '12': 'pericia' };
  var ACOES = [
    { id: 'AVALIACAO_MEDICA', rot: 'Avaliação médica', secao: 'Atendimento', ic: 'estetoscopio' },
    { id: 'CONSULTA_MEDICA', rot: 'Consulta médica', secao: 'Atendimento', ic: 'prancheta' },
    { id: 'CMO', rot: 'Consulta ocupacional', secao: 'Atendimento', ic: 'prancheta' },
    { id: 'ASO', rot: 'ASO', secao: 'Atendimento', ic: 'documento' },
    { id: 'DADOS_FUNCIONARIO', rot: 'Dados do colaborador', secao: 'Paciente', ic: 'pessoa' },
    { id: 'DADOS_CANDIDATO', rot: 'Dados do candidato', secao: 'Paciente', ic: 'pessoa' },
    { id: 'CHAMAR_PACIENTE', rot: 'Chamar paciente', secao: 'Paciente', ic: 'chamar' },
    { id: 'TRANSFERIR', rot: 'Remarcar', secao: 'Agenda', ic: 'remarcar' }
  ];
  var DO_DIA = [
    { id: 'RELATORIO', rot: 'Relatório' },
    { id: 'CONSULTA_MATRICULA', rot: 'Consultar por matrícula' }
  ];
  var A_CADA = 60;   /* segundos entre uma atualização automática e outra */

  /* ═══ [A3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  var DIAS = ['Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado'];
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  /* "DIOGO THAFAREL DE ALMEIDA" → "Diogo Thafarel de Almeida" */
  function nome(t) {
    return String(t || '').toLowerCase().replace(/(^|[\s'-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); })
      .replace(/\s(De|Da|Do|Das|Dos|E)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  function frase(t) { t = String(t || '').toLowerCase(); return t.charAt(0).toUpperCase() + t.slice(1); }
  function dataBR(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function dd(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear(); }
  function iso(d) { return d.getFullYear() + '-' + ('0' + (d.getMonth() + 1)).slice(-2) + '-' + ('0' + d.getDate()).slice(-2); }
  function mesmoDia(a, b) { return a && b && a.getFullYear() === b.getFullYear() && a.getMonth() === b.getMonth() && a.getDate() === b.getDate(); }
  function hhmm(t) { var m = /(\d{1,2}):(\d{2})/.exec(t || ''); return m ? ('0' + m[1]).slice(-2) + ':' + m[2] : ''; }
  function minutos(t) { var m = /(\d{1,2}):(\d{2})/.exec(t || ''); return m ? +m[1] * 60 + +m[2] : null; }
  function agora() { var n = new Date(); return n.getHours() * 60 + n.getMinutes(); }
  var IC = {
    voltar: '<path d="M14.5 6l-6 6 6 6"/>', avancar: '<path d="M9.5 6l6 6-6 6"/>',
    calendario: '<rect x="4" y="5.5" width="16" height="14" rx="2.5"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4"/>',
    atualizar: '<path d="M19 12a7 7 0 1 1-2.05-4.95M19 4.5v4h-4"/>',
    fechar: '<path d="M7 7l10 10M17 7L7 17"/>',
    mais: '<path d="M12 5.5v13M5.5 12h13"/>',
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>',
    entrar: '<path d="M10 7l5 5-5 5M15 12H4M14 4.5h4.5A1.5 1.5 0 0 1 20 6v12a1.5 1.5 0 0 1-1.5 1.5H14"/>',
    cadeado: '<rect x="5.5" y="10.5" width="13" height="9" rx="2"/><path d="M8.5 10.5V8a3.5 3.5 0 0 1 7 0v2.5"/>',
    aberto: '<rect x="5.5" y="10.5" width="13" height="9" rx="2"/><path d="M8.5 10.5V8a3.5 3.5 0 0 1 6.8-1.2"/>',
    lapis: '<path d="M14.5 5.5l4 4L9 19H5v-4z"/>',
    remarcar: '<path d="M4 8h12.5M13 4.5L16.5 8 13 11.5M20 16H7.5M11 12.5L7.5 16l3.5 3.5"/>',
    lixo: '<path d="M5 7h14M10 7V5h4v2M7 7l1 12h8l1-12"/>',
    estetoscopio: '<path d="M6 4v5a4 4 0 0 0 8 0V4"/><path d="M10 13v2a4.5 4.5 0 0 0 9 0v-1.5"/><circle cx="19" cy="12" r="1.8"/>',
    prancheta: '<rect x="5.5" y="5" width="13" height="15.5" rx="2"/><path d="M9 5V3.5h6V5M8.5 10.5h7M8.5 14h7M8.5 17.5h4"/>',
    documento: '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4M9.5 12.5h6M9.5 16h6"/>',
    pessoa: '<circle cx="12" cy="8.5" r="3.5"/><path d="M5 20a7 7 0 0 1 14 0"/>',
    chamar: '<path d="M4 10v4h3.5l5 4V6l-5 4z"/><path d="M16 9a4 4 0 0 1 0 6M18.5 6.5a7.5 7.5 0 0 1 0 11"/>',
    relogio: '<circle cx="12" cy="12" r="8"/><path d="M12 7.5V12l3 2"/>'
  };
  function svg(d, cls) { return '<svg class="nc-ag-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }

  function iniciar() {
    if (window.__ncAgendaMedica) return;

    /* ═══ [A1] COMO A PÁGINA É RECONHECIDA ════════════════════════════════════════════════
       O Interactive Grid "horarios" com as colunas da agenda. Sem ele (ou sem as colunas), o
       arquivo para aqui e a página fica como o APEX desenhou.
       CUIDADO  Roda quando o APEX avisa que a página está pronta (o grid já existe).
       ════════════════════════════════════════════════════════════════════════════════════ */
    var regIG = document.getElementById(IG_ID);
    var ig = regIG && apex.region(IG_ID) && apex.region(IG_ID).widget ? apex.region(IG_ID).widget() : null;
    if (!ig || !ig.length || !ig.interactiveGrid) return;
    var vista = function () { return ig.interactiveGrid('getViews', 'grid'); };
    if (!vista() || !vista().model || !vista().modelColumns || !vista().modelColumns.HORA_INIC_PREVISTO || !vista().modelColumns.COD_PACIENTE) return;
    var acoes = ig.interactiveGrid('getActions');
    window.__ncAgendaMedica = true;
    var regMotor = regIG.parentElement.closest('.t-Region') || regIG;   /* a região "Horários" (o grid + os botões) */
    var itemData = document.getElementById('P10_DATA_AGENDA');
    var regFiltros = itemData ? itemData.closest('.t-Region') : null;   /* a região "Agenda" (empresa, profissional, data, sala) */
    document.body.classList.add('nc-ag-ativo');
    regMotor.classList.add('nc-ag-motor');
    /* dentro do motor, a região dos 11 botões (e o "Clique aqui para atualizar") nunca aparece —
       nem na gaveta; os botões continuam lá para serem apertados */
    var bAval = document.getElementById('AVALIACAO_MEDICA');
    if (bAval && bAval.closest('.t-Region') && bAval.closest('.t-Region') !== regMotor) bAval.closest('.t-Region').classList.add('nc-ag-botoes');
    if (regFiltros) regFiltros.classList.add('nc-ag-filtros');

    var app = el('section', 'nc-ag');
    app.setAttribute('aria-label', 'Agenda do dia');
    (regFiltros || regMotor).parentNode.insertBefore(app, (regFiltros || regMotor).nextSibling);

    var SEL = null;          /* o ROWID do horário escolhido */
    var FILTRO = 'todos';
    var ABERTOS = {};        /* grupos de bloqueados abertos */
    var OCUPADO = false;     /* salvando */
    var PENDENTE = null;     /* { texto } da mensagem depois de salvar */
    var CONFIRMA = null;     /* { tipo, id } da pergunta aberta no painel */
    var ULTIMA = new Date();

    /* ═══ [A4] LER O GRID (OS HORÁRIOS DO DIA) ════════════════════════════════════════════
       Cada registro do modelo do grid vira um horário. O valor de lista vem como { v, d }: v é
       o código e d o texto. O estado segue a regra da página (regra_negocio). */
    function bruto(m, rec, col) {
      if (!m.getFieldKey || m.getFieldKey(col) === undefined) return '';
      var x = m.getValue(rec, col);
      if (x && typeof x === 'object') return { v: String(x.v == null ? '' : x.v).replace(/t[0-9]{4}/g, ''), d: String(x.d == null ? x.v : x.d) };
      return String(x == null ? '' : x).replace(/t[0-9]{4}/g, '');
    }
    function cod(x) { return typeof x === 'object' ? x.v : x; }
    function txt(x) { return typeof x === 'object' ? x.d : x; }
    function horarios() {
      var m = vista().model, out = [];
      m.forEach(function (rec) {
        var g = function (c) { return bruto(m, rec, c); };
        var pac = g('COD_PACIENTE'), tp = g('TIPO_PACIENTE'), cons = g('COD_TIPO_CONSULTA');
        var pacTxt = txt(pac) || '', pacCod = cod(pac) || '';
        var partes = pacTxt.split(' - ');
        var h = {
          rec: rec, id: m.getRecordId(rec), rowid: cod(g('ROWID')) || m.getRecordId(rec),
          ini: hhmm(cod(g('HORA_INIC_PREVISTO'))), fim: hhmm(cod(g('HORA_FIM_PREVISTO'))),
          bloqueado: cod(g('BLOQUEADO')) === 'S', chegou: cod(g('COMPARECEU')) === 'S', realizou: cod(g('REALIZOU')) === 'S',
          tipo: cod(tp), tipoTxt: cod(tp) === '1' ? 'Colaborador' : cod(tp) === '2' ? 'Candidato' : txt(tp),
          pac: pacCod, pacNome: pacCod ? nome(partes.length > 1 ? partes.slice(1).join(' - ') : pacTxt) : '', pacNum: partes.length > 1 ? partes[0] : pacCod,
          cons: cod(cons), consTxt: frase((txt(cons) || '').replace(/^\d+\s*-\s*/, '')),
          obs: cod(g('OBSERVACAO')), senha: cod(g('SENHA')), pre: cod(g('PRE_ATENDIMENTO')), selecao: cod(g('ATENDE_AREA_SELECAO')) === 'S',
          mudou: !!(m.getRecordMetadata(m.getRecordId(rec)) || {}).updated
        };
        h.estado = h.bloqueado ? 'bloqueado' : !h.pac ? 'livre' : h.realizou ? 'realizado' : h.chegou ? 'chegou' : 'agendado';
        h.min = minutos(h.ini);
        out.push(h);
      });
      return out.sort(function (a, b) { return (a.min || 0) - (b.min || 0); });
    }
    function achar(id) { return horarios().filter(function (h) { return h.rowid === id; })[0] || null; }
    function dataDaAgenda() { return dataBR(apex.item('P10_DATA_AGENDA').getValue()); }
    function textoDoItem(id) { var e = document.getElementById(id); if (!e) return ''; var t = apex.item(id).displayValueFor ? apex.item(id).displayValueFor(apex.item(id).getValue()) : ''; return String(t || e.value || '').trim(); }

    /* ═══ [A5] O ALTO: O DIA, QUEM, O RESUMO ══════════════════════════════════════════════ */
    function cabecalho(lista) {
      var d = dataDaAgenda(), hoje = new Date(), amanha = new Date(hoje.getFullYear(), hoje.getMonth(), hoje.getDate() + 1), ontem = new Date(hoje.getFullYear(), hoje.getMonth(), hoje.getDate() - 1);
      var rel = !d ? '' : mesmoDia(d, hoje) ? 'Hoje' : mesmoDia(d, amanha) ? 'Amanhã' : mesmoDia(d, ontem) ? 'Ontem' : '';
      var prof = textoDoItem('P10_COD_PRESTR_SERV'), emp = textoDoItem('P10_COD_EMPRESA'), sala = apex.item('P10_SALA') ? apex.item('P10_SALA').getValue() : '';
      var n = { agendado: 0, chegou: 0, realizado: 0, livre: 0, bloqueado: 0 };
      lista.forEach(function (h) { n[h.estado]++; });
      var total = lista.length || 1;
      var barra = ['realizado', 'chegou', 'agendado', 'livre', 'bloqueado'].map(function (k) { return n[k] ? '<i data-estado="' + k + '" style="flex-grow:' + n[k] + '"></i>' : ''; }).join('');
      var filtros = [['todos', 'Todos', lista.length], ['agendado', 'Agendados', n.agendado], ['chegou', 'Na clínica', n.chegou], ['realizado', 'Atendidos', n.realizado], ['livre', 'Livres', n.livre]];
      var botoesDia = DO_DIA.filter(function (a) { var b = document.getElementById(a.id); return b && !b.disabled; })
        .map(function (a) { return '<button type="button" class="nc-ag-bt is-sutil" data-dia="' + a.id + '">' + esc(a.rot) + '</button>'; }).join('');
      return '<header class="nc-ag-cab">' +
        '<div class="nc-ag-dia">' +
          '<div class="nc-ag-nav" role="group" aria-label="Escolher o dia">' +
            '<button type="button" class="nc-ag-bt is-icone" data-ir="-1" aria-label="Dia anterior" title="Dia anterior">' + svg(IC.voltar) + '</button>' +
            '<button type="button" class="nc-ag-bt" data-ir="0"' + (rel === 'Hoje' ? ' aria-pressed="true"' : '') + '>Hoje</button>' +
            '<button type="button" class="nc-ag-bt is-icone" data-ir="1" aria-label="Próximo dia" title="Próximo dia">' + svg(IC.avancar) + '</button>' +
            '<label class="nc-ag-bt is-icone nc-ag-calendario" title="Escolher a data">' + svg(IC.calendario) + '<span class="u-VisuallyHidden">Escolher a data</span><input type="date" data-data value="' + (d ? iso(d) : '') + '"></label>' +
          '</div>' +
          '<div class="nc-ag-titulo">' +
            '<h2>' + (d ? esc(DIAS[d.getDay()] + ', ' + d.getDate() + ' de ' + MESES[d.getMonth()]) + (d.getFullYear() !== hoje.getFullYear() ? ' de ' + d.getFullYear() : '') : 'Escolha a data') + (rel ? ' <span class="nc-ag-rel">' + rel + '</span>' : '') + '</h2>' +
            '<p class="nc-ag-quem">' + (prof ? '<b>' + esc(nome(prof.replace(/^(\d+\s*-\s*)/, ''))) + '</b>' : '<b>Escolha o profissional</b>') +
              (sala ? ' <span>· Sala ' + esc(sala) + '</span>' : '') + (emp ? ' <span>· ' + esc(emp.replace(/^(\d+)\s*-\s*(.*)$/, function (x, a, b) { return a + ' - ' + nome(b); })) + '</span>' : '') +
              ' <button type="button" class="nc-ag-link" data-filtros aria-expanded="' + document.body.classList.contains('nc-ag-filtros-abertos') + '">Alterar</button></p>' +
          '</div>' +
          '<div class="nc-ag-dia-acoes">' + botoesDia + '</div>' +
        '</div>' +
        (lista.length ? '<div class="nc-ag-resumo">' +
          '<div class="nc-ag-barra" aria-hidden="true">' + barra + '</div>' +
          '<div class="nc-ag-filtro" role="group" aria-label="Mostrar">' + filtros.map(function (f) {
            return '<button type="button" data-filtro="' + f[0] + '" aria-pressed="' + (FILTRO === f[0]) + '"' + (f[0] !== 'todos' ? ' data-estado="' + f[0] + '"' : '') + '><span>' + f[1] + '</span> <b>' + f[2] + '</b></button>';
          }).join('') + '</div>' +
          '<p class="nc-ag-atual">' + svg(IC.relogio) + 'Atualizado às ' + ('0' + ULTIMA.getHours()).slice(-2) + ':' + ('0' + ULTIMA.getMinutes()).slice(-2) +
            ' <button type="button" class="nc-ag-link" data-atualizar>' + svg(IC.atualizar) + 'Atualizar</button></p>' +
        '</div>' : '') +
      '</header>';
    }

    /* ═══ [A6] A LISTA DO DIA ═════════════════════════════════════════════════════════════
       Uma linha por horário: a hora, o paciente e o próximo passo. Manhã (até 12h), Tarde (até
       18h), Noite. Três ou mais bloqueados seguidos viram uma linha só (abre ao tocar). */
    var TURNOS = [['Manhã', 0, 720], ['Tarde', 720, 1080], ['Noite', 1080, 1440]];
    function linha(h) {
      var e = ESTADOS[h.estado], sel = SEL === h.rowid;
      var corpo = h.pac ? '<span class="nc-ag-nome">' + esc(h.pacNome) + '</span>' +
          '<span class="nc-ag-meta"><span>' + esc(h.tipoTxt) + (h.pacNum ? ' · ' + esc(h.pacNum) : '') + '</span>' +
          (h.consTxt ? '<span class="nc-ag-consulta" data-tom="' + (CONSULTAS[h.cons] || '') + '">' + esc(h.consTxt) + '</span>' : '') + '</span>'
        : '<span class="nc-ag-nome is-vazio">' + (h.estado === 'bloqueado' ? 'Bloqueado' : 'Horário livre') + '</span>';
      var sinais = (h.senha ? '<span class="nc-ag-sinal" title="Senha do paciente">Senha <b>' + esc(h.senha) + '</b></span>' : '') +
        (h.pre ? '<span class="nc-ag-sinal is-pronto" title="Pré-atendimento feito">' + svg(IC.check) + 'Pré-atendimento</span>' : '') +
        (h.selecao ? '<span class="nc-ag-sinal">Seleção</span>' : '') + (h.mudou ? '<span class="nc-ag-sinal is-pendente">Não salvo</span>' : '');
      var rapida = h.estado === 'livre' ? ['agendar', 'Agendar', IC.mais] : h.estado === 'agendado' ? ['chegada', 'Marcar chegada', IC.entrar] : h.estado === 'chegou' ? ['concluir', 'Concluir', IC.check] : null;
      return '<li class="nc-ag-slot' + (sel ? ' is-sel' : '') + '" data-estado="' + h.estado + '">' +
        '<button type="button" class="nc-ag-alvo" data-slot="' + esc(h.rowid) + '" aria-pressed="' + sel + '" aria-label="' + esc(h.ini + ' a ' + h.fim + ', ' + e.rot + (h.pac ? ', ' + h.pacNome + ', ' + h.consTxt : '')) + '">' +
          '<span class="nc-ag-hora"><b>' + esc(h.ini) + '</b><small>' + esc(h.fim) + '</small></span>' +
          '<span class="nc-ag-estado"><i aria-hidden="true"></i>' + esc(e.rot) + '</span>' +
          '<span class="nc-ag-corpo">' + corpo + '</span>' +
          (sinais ? '<span class="nc-ag-sinais">' + sinais + '</span>' : '') +
        '</button>' +
        (rapida ? '<button type="button" class="nc-ag-bt nc-ag-rapida is-' + rapida[0] + '" data-rapida="' + rapida[0] + '" data-id="' + esc(h.rowid) + '"' + (OCUPADO ? ' disabled' : '') + '>' + svg(rapida[2]) + '<span>' + rapida[1] + '</span></button>' : '') +
      '</li>';
    }
    function lista(hs) {
      if (!hs.length) {
        var temFiltros = apex.item('P10_COD_PRESTR_SERV').getValue() && apex.item('P10_DATA_AGENDA').getValue() && apex.item('P10_SALA').getValue();
        return '<div class="nc-ag-vazio">' + svg(IC.calendario) + '<p><b>' + (temFiltros ? 'Não há agenda para este dia.' : 'Escolha o profissional, a data e a sala.') + '</b></p>' +
          (temFiltros ? '<p>A agenda do dia é criada na hora: é só confirmar.</p><button type="button" class="nc-ag-bt is-primario" data-criar>Criar a agenda do dia</button>'
            : '<button type="button" class="nc-ag-bt is-primario" data-filtros>Escolher</button>') + '</div>';
      }
      var mostra = hs.filter(function (h) { return FILTRO === 'todos' || h.estado === FILTRO; });
      if (!mostra.length) return '<div class="nc-ag-vazio is-filtro"><p><b>Nenhum horário ' + { agendado: 'agendado esperando', chegou: 'com paciente na clínica', realizado: 'atendido', livre: 'livre' }[FILTRO] + '.</b></p><button type="button" class="nc-ag-bt" data-filtro="todos">Ver o dia todo</button></div>';
      var hoje = mesmoDia(dataDaAgenda(), new Date()), ag = agora(), html = '';
      TURNOS.forEach(function (t) {
        var doTurno = mostra.filter(function (h) { return h.min !== null && h.min >= t[1] && h.min < t[2]; });
        if (!doTurno.length) return;
        var itens = '', i = 0, linhaAgora = false;
        while (i < doTurno.length) {
          var h = doTurno[i];
          if (hoje && !linhaAgora && FILTRO === 'todos' && h.min > ag && ag >= t[1] && ag < t[2]) { itens += '<li class="nc-ag-agora" aria-label="Agora"><span>agora · ' + ('0' + Math.floor(ag / 60)).slice(-2) + ':' + ('0' + (ag % 60)).slice(-2) + '</span></li>'; linhaAgora = true; }
          /* bloqueados em sequência */
          var j = i;
          while (j < doTurno.length && doTurno[j].estado === 'bloqueado') j++;
          if (j - i >= 3) {
            var chave = doTurno[i].rowid, aberto = ABERTOS[chave];
            itens += '<li class="nc-ag-grupo" data-estado="bloqueado"><button type="button" class="nc-ag-alvo" data-grupo="' + esc(chave) + '" aria-expanded="' + !!aberto + '">' +
              '<span class="nc-ag-hora"><b>' + esc(doTurno[i].ini) + '</b><small>' + esc(doTurno[j - 1].fim) + '</small></span>' +
              '<span class="nc-ag-estado"><i aria-hidden="true"></i>Bloqueado</span><span class="nc-ag-corpo"><span class="nc-ag-nome is-vazio">' + (j - i) + ' horários bloqueados</span></span>' +
              '<span class="nc-ag-sinais"><span class="nc-ag-sinal">' + (aberto ? 'Fechar' : 'Ver um a um') + '</span></span></button></li>';
            if (aberto) for (var k = i; k < j; k++) itens += linha(doTurno[k]);
            i = j;
            continue;
          }
          itens += linha(h);
          i++;
        }
        html += '<section class="nc-ag-turno"><h3>' + t[0] + ' <small>' + doTurno.length + (doTurno.length === 1 ? ' horário' : ' horários') + '</small></h3><ol class="nc-ag-slots">' + itens + '</ol></section>';
      });
      return html;
    }

    /* ═══ [A7] O PAINEL DO HORÁRIO E AS AÇÕES ═════════════════════════════════════════════
       Escolher um horário = escolher a linha no grid: a regra da página (regra_negocio) liga e
       desliga os botões. O painel mostra só os botões ligados, com o nome que o médico entende,
       e aperta o botão original. */
    function escolher(h) {
      SEL = h ? h.rowid : null;
      var v = vista();
      if (h && v.setSelectedRecords) v.setSelectedRecords([h.rec], true);
    }
    function ligado(id) { var b = document.getElementById(id); return b && !b.disabled && !b.classList.contains('apex_disabled') && b.offsetParent !== undefined; }
    function passos(h) {
      var ordem = ['agendado', 'chegou', 'realizado'], at = ordem.indexOf(h.estado);
      return '<ol class="nc-ag-passos" aria-label="Andamento">' + [['agendado', 'Agendado'], ['chegou', 'Chegou'], ['realizado', 'Atendido']].map(function (p, k) {
        return '<li class="' + (k < at ? 'is-feito' : k === at ? 'is-agora' : '') + '"><i aria-hidden="true">' + (k < at || (k === at && h.estado === 'realizado') ? svg(IC.check) : k + 1) + '</i>' + p[1] + '</li>';
      }).join('') + '</ol>';
    }
    function painel(h) {
      if (!h) return '<div class="nc-ag-painel-vazio">' + svg(IC.calendario) + '<p>Escolha um horário para ver o paciente e o que fazer.</p></div>';
      var e = ESTADOS[h.estado];
      var cab = '<div class="nc-ag-pcab"><span class="nc-ag-pquando">' + svg(IC.relogio) + esc(h.ini) + ' – ' + esc(h.fim) + '</span>' +
        '<span class="nc-ag-estado" data-estado="' + h.estado + '"><i aria-hidden="true"></i>' + esc(e.rot) + '</span>' +
        '<button type="button" class="nc-ag-bt is-icone nc-ag-pfechar" data-fechar aria-label="Fechar">' + svg(IC.fechar) + '</button></div>';
      if (CONFIRMA && CONFIRMA.id === h.rowid) {
        return cab + '<div class="nc-ag-pergunta" role="alertdialog" aria-labelledby="nc-ag-perg-t"><p id="nc-ag-perg-t"><b>Desmarcar a consulta de ' + esc(h.pacNome) + '?</b></p>' +
          '<p>O horário das ' + esc(h.ini) + ' fica livre de novo. O paciente precisa ser agendado outra vez.</p>' +
          '<div class="nc-ag-pbotoes"><button type="button" class="nc-ag-bt is-perigo" data-sim="desmarcar">' + svg(IC.lixo) + 'Desmarcar</button><button type="button" class="nc-ag-bt" data-nao>Voltar</button></div></div>';
      }
      if (h.estado === 'livre' || h.estado === 'bloqueado') {
        var livre = h.estado === 'livre';
        return cab + '<div class="nc-ag-pcorpo"><p class="nc-ag-pnome is-vazio">' + (livre ? 'Horário livre' : 'Horário bloqueado') + '</p>' +
          '<p class="nc-ag-ptexto">' + (livre ? 'Ninguém agendado. Agende um colaborador ou um candidato, ou bloqueie o horário.' : 'Ninguém pode ser agendado neste horário enquanto ele estiver bloqueado.') + '</p>' +
          '<div class="nc-ag-pbotoes">' + (livre ? '<button type="button" class="nc-ag-bt is-primario" data-rapida="agendar" data-id="' + esc(h.rowid) + '">' + svg(IC.mais) + 'Agendar paciente</button>' +
            '<button type="button" class="nc-ag-bt" data-rapida="bloquear" data-id="' + esc(h.rowid) + '">' + svg(IC.cadeado) + 'Bloquear horário</button>'
            : '<button type="button" class="nc-ag-bt is-primario" data-rapida="desbloquear" data-id="' + esc(h.rowid) + '">' + svg(IC.aberto) + 'Desbloquear horário</button>') + '</div></div>';
      }
      var principal = h.estado === 'agendado' ? ['chegada', 'Marcar chegada', IC.entrar] : h.estado === 'chegou' ? ['concluir', 'Concluir atendimento', IC.check] : null;
      var secoes = {};
      ACOES.forEach(function (a) { if (ligado(a.id)) (secoes[a.secao] = secoes[a.secao] || []).push('<button type="button" class="nc-ag-acao" data-botao="' + a.id + '">' + svg(IC[a.ic]) + '<span>' + esc(a.rot) + '</span></button>'); });
      /* o histórico de consultas DESTE paciente (a janela 26 já abre com ele — ver [A9] "historico") */
      if (h.pac && ligado('CONSULTA_MATRICULA')) (secoes.Paciente = secoes.Paciente || []).push('<button type="button" class="nc-ag-acao" data-rapida="historico" data-id="' + esc(h.rowid) + '">' + svg(IC.relogio) + '<span>Histórico de consultas</span></button>');
      /* o que é deste arquivo (editar, desmarcar, desfazer) entra na seção Agenda */
      var agenda = secoes.Agenda || [];
      if (h.estado === 'agendado') agenda.unshift('<button type="button" class="nc-ag-acao" data-rapida="editar" data-id="' + esc(h.rowid) + '">' + svg(IC.lapis) + '<span>Editar agendamento</span></button>');
      if (h.estado === 'agendado' && ligado('DESMARCAR')) agenda.push('<button type="button" class="nc-ag-acao is-perigo" data-rapida="desmarcar" data-id="' + esc(h.rowid) + '">' + svg(IC.lixo) + '<span>Desmarcar</span></button>');
      if (h.estado === 'chegou') agenda.push('<button type="button" class="nc-ag-acao" data-rapida="desfazer-chegada" data-id="' + esc(h.rowid) + '">' + svg(IC.voltar) + '<span>Desfazer chegada</span></button>');
      if (h.estado === 'realizado') agenda.push('<button type="button" class="nc-ag-acao" data-rapida="reabrir" data-id="' + esc(h.rowid) + '">' + svg(IC.voltar) + '<span>Reabrir atendimento</span></button>');
      if (agenda.length) secoes.Agenda = agenda;
      var dados = [h.obs ? ['Observação', h.obs] : null, h.senha ? ['Senha', h.senha] : null, h.pre ? ['Pré-atendimento', h.pre.replace(/^(\d{2}\/\d{2}\/\d{4})\s+(\d{2}:\d{2}).*$/, '$2 de $1')] : null, h.selecao ? ['Área de seleção', 'Sim'] : null].filter(Boolean);
      return cab + '<div class="nc-ag-pcorpo">' +
        '<p class="nc-ag-pnome">' + esc(h.pacNome) + '</p>' +
        '<p class="nc-ag-pmeta">' + esc(h.tipoTxt) + (h.pacNum ? ' · ' + esc(h.pacNum) : '') + '</p>' +
        (h.consTxt ? '<p><span class="nc-ag-consulta is-grande" data-tom="' + (CONSULTAS[h.cons] || '') + '">' + esc(h.consTxt) + '</span></p>' : '') +
        passos(h) +
        (principal ? '<button type="button" class="nc-ag-bt is-primario is-largo" data-rapida="' + principal[0] + '" data-id="' + esc(h.rowid) + '"' + (OCUPADO ? ' disabled' : '') + '>' + svg(principal[2]) + principal[1] + '</button>' : '') +
        (dados.length ? '<dl class="nc-ag-pdados">' + dados.map(function (x) { return '<div><dt>' + esc(x[0]) + '</dt><dd>' + esc(x[1]) + '</dd></div>'; }).join('') + '</dl>' : '') +
        ['Atendimento', 'Paciente', 'Agenda'].filter(function (s) { return secoes[s]; }).map(function (s) { return '<section class="nc-ag-psecao"><h4>' + s + '</h4><div class="nc-ag-acoes">' + secoes[s].join('') + '</div></section>'; }).join('') +
        '</div>';
    }

    /* ═══ [A8] AGENDAR / EDITAR (A FICHA DO GRID NUMA GAVETA) ═════════════════════════════
       A "vista de um registro" do próprio grid (Single Row View), com a lista de pacientes que
       depende do tipo e as validações de sempre — mostrada numa gaveta, só com tipo de paciente,
       paciente, tipo de consulta e observação. Salvar = o salvar do grid. */
    var gaveta = null, EDITANDO = null;
    function montarGaveta() {
      if (gaveta) return;
      gaveta = {
        fundo: el('div', 'nc-ag-fundo'),
        cab: el('div', 'nc-ag-gcab'),
        pe: el('div', 'nc-ag-gpe', '<button type="button" class="nc-ag-bt is-primario" data-gsalvar>' + svg(IC.check) + 'Salvar</button><button type="button" class="nc-ag-bt" data-gcancelar>Cancelar</button>')
      };
      document.body.appendChild(gaveta.fundo);
      regMotor.insertBefore(gaveta.cab, regMotor.firstChild);
      regMotor.appendChild(gaveta.pe);
      gaveta.fundo.addEventListener('click', function () { fecharEdicao(true); });
      gaveta.pe.addEventListener('click', function (ev) {
        if (ev.target.closest('[data-gsalvar]')) { sincronizarFicha(); salvar(EDITANDO && EDITANDO.novo ? 'Agendamento salvo' : 'Alterações salvas', function () { fecharEdicao(false); }); }
        if (ev.target.closest('[data-gcancelar]')) fecharEdicao(true);
      });
      gaveta.cab.addEventListener('click', function (ev) { if (ev.target.closest('[data-gcancelar]')) fecharEdicao(true); });
    }
    function abrirEdicao(h) {
      montarGaveta();
      escolher(h);
      EDITANDO = { id: h.rowid, novo: !h.pac };
      gaveta.cab.innerHTML = '<div><p class="nc-ag-gtitulo">' + (EDITANDO.novo ? 'Agendar paciente' : 'Editar agendamento') + '</p><p class="nc-ag-gsub">' + svg(IC.relogio) + esc(h.ini) + ' – ' + esc(h.fim) + ' · ' + esc(cabecalhoCurto()) + '</p></div>' +
        '<button type="button" class="nc-ag-bt is-icone" data-gcancelar aria-label="Fechar">' + svg(IC.fechar) + '</button>';
      document.body.classList.add('nc-ag-editando');
      try { acoes.set('edit', true); } catch (e) { /* já está em edição */ }
      /* a vista de um registro mostra o registro da célula ATIVA do grid (não só o escolhido):
         a célula vai para o horário certo antes; depois se confere e, se preciso, anda até ele */
      var v = vista();
      try { v.view$.grid('gotoCell', h.id, 'HORA_INIC_PREVISTO'); } catch (e) { /* ok */ }
      if (v.setSelectedRecords) v.setSelectedRecords([h.rec], true);
      acoes.invoke('single-row-view');
      try {
        var atual = function () { var r = v.singleRowView$ && v.singleRowView$.recordView('getRecord'); return r ? v.model.getRecordId(r) : null; };
        var lista = horarios().map(function (x) { return x.id; }), alvo = lista.indexOf(h.id);
        for (var passo = 0; passo < 40 && atual() !== h.id; passo++) {
          var aqui = lista.indexOf(atual());
          if (aqui < 0 || alvo < 0) break;
          acoes.invoke(aqui < alvo ? 'next-record' : 'previous-record');
        }
      } catch (e) { /* ok: segue com o que abriu */ }
      setTimeout(function () {
        var alvo = regMotor.querySelector('#TIPO_PACIENTE, #TIPO_PACIENTE_CONTAINER select');
        if (alvo && alvo.focus) alvo.focus();
      }, 120);
    }
    /* 04/10: a ficha do grid só passa o valor de um campo para a grade quando o foco vai para
       OUTRO campo dela (Tab); o Salvar da gaveta fica fora da ficha e o último campo digitado
       (a observação, o paciente) ficava de fora. Antes de salvar, os quatro campos da ficha são
       copiados do formulário para o registro (o mesmo de Natcorp_ManutencaoAtestados). */
    var FICHA = ['TIPO_PACIENTE', 'COD_PACIENTE', 'COD_TIPO_CONSULTA', 'OBSERVACAO'];
    function sincronizarFicha() {
      var v = vista(), m = v.model, r = null, h = EDITANDO && achar(EDITANDO.id);
      try { r = v.singleRowView$ && v.singleRowView$.recordView('getRecord'); } catch (e) { r = null; }
      if (!r || !h || m.getRecordId(r) !== h.id) return;
      FICHA.forEach(function (col) {
        var mc = v.modelColumns[col], it; if (!mc) return;
        try { it = apex.item(mc.elementId); } catch (e) { return; }
        if (!it || !it.node || it.node.disabled) return;
        var nv = it.getValue(); if (Array.isArray(nv)) nv = nv.join(':'); nv = nv == null ? '' : String(nv);
        var atual = m.getValue(r, col), obj = !!atual && typeof atual === 'object';
        var av = (obj ? String(atual.v == null ? '' : atual.v) : String(atual == null ? '' : atual)).replace(/t[0-9]{4}/g, '');
        if (nv === av) return;
        if (obj) { var d = ''; try { d = it.displayValueFor ? it.displayValueFor(nv) : ''; } catch (e) { /* ok */ } m.setValue(r, col, { v: nv, d: d || nv }); }
        else m.setValue(r, col, nv);
      });
    }
    function cabecalhoCurto() { var d = dataDaAgenda(); return d ? DIAS[d.getDay()].replace('-feira', '') + ', ' + d.getDate() + ' de ' + MESES[d.getMonth()] : ''; }
    function fecharEdicao(desfazer) {
      if (!EDITANDO) return;
      var h = achar(EDITANDO.id);
      if (desfazer && h && h.mudou) { try { escolher(h); acoes.invoke('revert-record'); } catch (e) { /* ok */ } }
      try { acoes.invoke('close-single-row-view'); } catch (e) { /* ok */ }
      document.body.classList.remove('nc-ag-editando');
      EDITANDO = null;
      desenhar();
    }

    /* ═══ [A9] MARCAR E SALVAR (PELO GRID) ════════════════════════════════════════════════
       CUIDADO  Toda gravação passa pelo "salvar" do grid — é ele que roda o processo que
                bloqueia o horário nas outras empresas. A variável buttonAction da página é
                zerada antes: ela é a "próxima tela" dos botões, e o salvar da página a chama.
       As regras seguem a regra_negocio: chegada só com paciente; atendido só depois da
       chegada; bloquear só horário livre. */
    function marcar(h, col, valor, msg) {
      var m = vista().model;
      m.setValue(h.rec, col, valor);
      regra(h);
      salvar(msg);
    }
    /* 04/10: quando BLOQUEADO/COMPARECEU/REALIZOU/paciente mudam, a página roda a regra_negocio
       (ação "Throw Checkbox Actions"), que liga/desliga os botões (Remarcar e Desmarcar somem
       depois da chegada). O setValue no modelo não dispara essa ação: roda aqui, igual. */
    function regra(h) {
      if (typeof window.regra_negocio !== 'function' || !h) return;
      try { window.regra_negocio({ selectedRecords: [h.rec], model: vista().model }); } catch (e) { /* ok */ }
    }
    function salvar(msg, depois) {
      if (OCUPADO) return;
      if (!vista().model.isChanged()) { if (depois) depois(); return; }
      OCUPADO = true;
      PENDENTE = { texto: msg, depois: depois };
      window.buttonAction = undefined;
      desenhar();
      try { acoes.invoke('save'); } catch (e) { OCUPADO = false; avisar('Não foi possível salvar. Tente de novo.', true); desenhar(); }
    }
    $(regIG).on('interactivegridsave', function (ev, data) {
      var ok = !data || data.status === undefined || data.status === 'success';
      OCUPADO = false;
      ULTIMA = new Date();
      if (PENDENTE) { var p = PENDENTE; PENDENTE = null; if (ok) { if (p.texto) avisar(p.texto); if (p.depois) p.depois(); } else avisar('Não foi possível salvar. Confira a mensagem do sistema.', true); }
      desenhar();
    });
    /* se o salvar falhar sem avisar, a tela não fica travada */
    $(document).on('apexerror', function () { if (OCUPADO) { OCUPADO = false; PENDENTE = null; desenhar(); } });

    var toast = el('div', 'nc-ag-aviso');
    toast.setAttribute('role', 'status');
    toast.setAttribute('aria-live', 'polite');
    document.body.appendChild(toast);
    var tAviso = null;
    function avisar(t, erro) {
      toast.innerHTML = (erro ? '' : svg(IC.check)) + '<span>' + esc(t) + '</span>';
      toast.classList.toggle('is-erro', !!erro);
      toast.classList.add('is-visivel');
      clearTimeout(tAviso);
      tAviso = setTimeout(function () { toast.classList.remove('is-visivel'); }, 3200);
    }
    function rapida(acao, h) {
      if (!h || OCUPADO) return;
      escolher(h);
      if (acao === 'agendar' || acao === 'editar') return abrirEdicao(h);
      /* Histórico de consultas: deixa o paciente para a janela 26 (Natcorp_HistoricoConsultas.js lê
         'nc-hc-abrir' e apaga) e aperta o botão original "Consulta por Matrícula" */
      if (acao === 'historico' && h.pac) {
        try {
          sessionStorage.setItem('nc-hc-abrir', JSON.stringify({ emp: apex.item('P10_COD_EMPRESA').getValue(), empTxt: textoDoItem('P10_COD_EMPRESA'),
            tipo: h.tipo, pac: h.pac, pacTxt: (h.pacNum ? h.pacNum + ' - ' : '') + h.pacNome, t: Date.now() }));
        } catch (x) { /* sem armazenamento: a janela abre com a pesquisa de sempre */ }
        var bh = document.getElementById('CONSULTA_MATRICULA'); if (bh) bh.click();
        return;
      }
      if (acao === 'chegada' && h.estado === 'agendado') return marcar(h, 'COMPARECEU', 'S', 'Chegada de ' + h.pacNome.split(' ')[0] + ' registrada');
      if (acao === 'concluir' && h.estado === 'chegou') return marcar(h, 'REALIZOU', 'S', 'Atendimento de ' + h.pacNome.split(' ')[0] + ' concluído');
      if (acao === 'desfazer-chegada' && h.estado === 'chegou') return marcar(h, 'COMPARECEU', 'N', 'Chegada desfeita');
      if (acao === 'reabrir' && h.estado === 'realizado') return marcar(h, 'REALIZOU', 'N', 'Atendimento reaberto');
      if (acao === 'bloquear' && h.estado === 'livre') return marcar(h, 'BLOQUEADO', 'S', 'Horário das ' + h.ini + ' bloqueado');
      if (acao === 'desbloquear' && h.estado === 'bloqueado') return marcar(h, 'BLOQUEADO', 'N', 'Horário das ' + h.ini + ' liberado');
      if (acao === 'desmarcar' && h.estado === 'agendado') { CONFIRMA = { id: h.rowid }; desenhar(); var b = app.querySelector('[data-sim]'); if (b) b.focus(); }
    }

    /* ═══ [A10] ATUALIZAR SOZINHO ═════════════════════════════════════════════════════════
       A cada A_CADA segundos, com a aba à vista e nada por salvar nem sendo editado, o grid é
       atualizado (a recepção marca chegadas em outro computador). O horário escolhido continua
       escolhido. Substitui o "Clique aqui para atualizar" da página. */
    function atualizar(manual) {
      if (!manual && (document.hidden || OCUPADO || EDITANDO || CONFIRMA || vista().model.isChanged())) return;
      if (manual && vista().model.isChanged()) { avisar('Há uma alteração não salva. Salve ou desfaça antes de atualizar.', true); return; }
      apex.region(IG_ID).refresh();
    }
    setInterval(function () { atualizar(false); }, A_CADA * 1000);
    $(regIG).on('apexafterrefresh', function () { ULTIMA = new Date(); setTimeout(function () { var h = SEL && achar(SEL); if (h) escolher(h); desenhar(); }, 0); });

    /* ═══ [A11] O MAESTRO ═════════════════════════════════════════════════════════════════
       Redesenha quando o modelo do grid muda (carregou, salvou, mudou um valor) — juntando as
       mudanças num só quadro. Os cliques da tela inteira passam por um só lugar.
       CUIDADO  A data muda pelo item P10_DATA_AGENDA (setValue): a ação dinâmica da página
                atualiza o grid e, se o dia não tem agenda, pergunta se pode criar. */
    var quadro = false;
    function desenhar() {
      if (quadro) return;
      quadro = true;
      requestAnimationFrame(function () {
        quadro = false;
        try {
          var hs = horarios(), h = SEL ? hs.filter(function (x) { return x.rowid === SEL; })[0] || null : null;
          if (SEL && !h) SEL = null;
          var rolagem = app.querySelector('.nc-ag-lista') ? app.querySelector('.nc-ag-lista').scrollTop : 0;
          app.innerHTML = cabecalho(hs) + '<div class="nc-ag-corpo-dia' + (h ? ' tem-painel' : '') + '"><div class="nc-ag-lista">' + lista(hs) + '</div>' +
            '<aside class="nc-ag-painel" aria-label="Horário escolhido"' + (h ? '' : ' data-vazio') + '>' + painel(h) + '</aside></div>';
          var l = app.querySelector('.nc-ag-lista'); if (l) l.scrollTop = rolagem;
          document.body.classList.toggle('nc-ag-com-painel', !!h);
          if (!desenhar.foi) { desenhar.foi = true; var ag = app.querySelector('.nc-ag-agora'); if (ag && ag.scrollIntoView) ag.scrollIntoView({ block: 'center' }); }
        } catch (e) { if (window.console) console.warn('[Natcorp agenda médica]', e); }
      });
    }
    /* o modelo avisa quando muda */
    var assinatura = null;
    function assinar() {
      var m = vista().model;
      if (assinatura && assinatura.m === m) return;
      if (assinatura) try { assinatura.m.unSubscribe(assinatura.id); } catch (e) { /* ok */ }
      assinatura = { m: m, id: m.subscribe({ onChange: function () { desenhar(); } }) };
    }
    assinar();
    $(regIG).on('interactivegridviewmodelcreate', function () { assinar(); desenhar(); });

    function irPara(n) {
      var d = dataDaAgenda() || new Date();
      var alvo = n === 0 ? new Date() : new Date(d.getFullYear(), d.getMonth(), d.getDate() + n);
      mudarData(alvo);
    }
    function mudarData(d) {
      if (vista().model.isChanged()) { avisar('Há uma alteração não salva. Salve ou desfaça antes de trocar o dia.', true); return; }
      SEL = null; CONFIRMA = null; desenhar.foi = false;
      apex.item('P10_DATA_AGENDA').setValue(dd(d));   /* a ação dinâmica da página faz o resto */
    }
    app.addEventListener('click', function (ev) {
      var t = ev.target, b;
      if ((b = t.closest('[data-ir]'))) return irPara(+b.getAttribute('data-ir'));
      if ((b = t.closest('[data-filtros]'))) { var ab = document.body.classList.toggle('nc-ag-filtros-abertos'); desenhar(); if (ab && regFiltros) { var p = regFiltros.querySelector('input:not([type=hidden]), select'); if (p) p.focus(); } return; }
      if ((b = t.closest('[data-atualizar]'))) return atualizar(true);
      if ((b = t.closest('[data-criar]'))) { apex.item('P10_POSSUI_AGENDA').setValue('N'); return; }
      if ((b = t.closest('[data-dia]'))) { var bt = document.getElementById(b.getAttribute('data-dia')); if (bt) bt.click(); return; }
      if ((b = t.closest('[data-filtro]'))) { FILTRO = b.getAttribute('data-filtro'); desenhar(); return; }
      if ((b = t.closest('[data-grupo]'))) { var k = b.getAttribute('data-grupo'); ABERTOS[k] = !ABERTOS[k]; desenhar(); return; }
      if ((b = t.closest('[data-rapida]'))) return rapida(b.getAttribute('data-rapida'), achar(b.getAttribute('data-id')));
      if ((b = t.closest('[data-slot]'))) { CONFIRMA = null; escolher(achar(b.getAttribute('data-slot'))); desenhar(); return; }
      if ((b = t.closest('[data-fechar]'))) { SEL = null; CONFIRMA = null; escolher(null); desenhar(); return; }
      if ((b = t.closest('[data-botao]'))) { var h2 = achar(SEL); if (h2) escolher(h2); var orig = document.getElementById(b.getAttribute('data-botao')); if (orig && !orig.disabled) orig.click(); return; }
      if ((b = t.closest('[data-sim]'))) { var h3 = achar(CONFIRMA && CONFIRMA.id); CONFIRMA = null; if (h3) { escolher(h3); if (typeof window.desmarcarConsulta === 'function') { window.desmarcarConsulta(); regra(h3); salvar('Consulta das ' + h3.ini + ' desmarcada'); } } desenhar(); return; }
      if ((b = t.closest('[data-nao]'))) { CONFIRMA = null; desenhar(); return; }
    });
    app.addEventListener('change', function (ev) {
      if (ev.target.matches('[data-data]') && ev.target.value) { var p = ev.target.value.split('-'); mudarData(new Date(+p[0], +p[1] - 1, +p[2])); }
    });
    /* teclado: ↑ ↓ andam pelos horários; Esc fecha o painel ou a gaveta */
    document.addEventListener('keydown', function (ev) {
      if (ev.key === 'Escape') { if (EDITANDO) { fecharEdicao(true); return; } if (CONFIRMA) { CONFIRMA = null; desenhar(); return; } if (SEL && window.matchMedia('(max-width: 1023px)').matches) { SEL = null; desenhar(); } return; }
      if ((ev.key === 'ArrowDown' || ev.key === 'ArrowUp') && ev.target.closest && ev.target.closest('.nc-ag-lista')) {
        var alvos = [].slice.call(app.querySelectorAll('.nc-ag-lista [data-slot]')), i = alvos.indexOf(ev.target.closest('[data-slot]'));
        var prox = alvos[i + (ev.key === 'ArrowDown' ? 1 : -1)];
        if (prox) { ev.preventDefault(); prox.focus(); }
      }
    });
    /* no celular, tocar no fundo escurecido fecha o painel */
    document.addEventListener('click', function (ev) { if (ev.target === document.body && SEL && window.matchMedia('(max-width: 1023px)').matches) { SEL = null; CONFIRMA = null; desenhar(); } });
    /* fechou os filtros? a agenda redesenha com a escolha nova */
    if (regFiltros) $(regFiltros).on('change', function () { desenhar(); });
    $(regMotor).on('interactivegridselectionchange', function () { if (!EDITANDO) desenhar(); });
    desenhar();
  }

  /* COMEÇO: quando o APEX termina de montar a página (o grid já existe). */
  var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp agenda médica]', e); } }, 0); };
  if (document.readyState === 'complete') vai();
  else { if (window.apex.gPageContext$) $(apex.gPageContext$).one('apexreadyend', vai); window.addEventListener('load', vai); }
})();
