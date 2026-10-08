/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · PRÉ-ATENDIMENTO (TRIAGEM)  —  o "arrumador" da janela (JavaScript)            ║
   ║  App 2937 (Medicina Ocupacional) · Página 74 · Registro do Pré-Atendimento (modal)       ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: PREATENDIMENTO-MANUTENCAO.md. Irmã: Natcorp_ExameMedico (página 19).

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   A janela em que a ENFERMAGEM faz a triagem antes da consulta (aberta pela Agenda Médica).
   Os mesmos campos, na mesma ordem, como uma ficha:
     • no alto, QUEM é o paciente: no registro já feito, um cartão de leitura (nome e código,
       funcionário/candidato, empresa, tipo do atendimento, data e hora, quem atendeu); no
       registro novo, os 6 campos de sempre em duas linhas, com Funcionário/Candidato em dois
       botões (o tipo do atendimento quem escolhe é a pessoa, mesmo com uma opção só);
     • SINAIS VITAIS em cartões, cada um com a unidade dentro do campo: a pressão é UM campo
       "120 / 80 mmHg" (os dois originais lado a lado), saturação, frequência, temperatura,
       altura, peso e o IMC calculado na hora, com a classificação; um aviso discreto quando um
       valor sai da referência (nada é bloqueado);
     • os TEXTOS (alergias, atendimento de enfermagem, relato do paciente) com a orientação de
       preenchimento à vista e o "Nega alergias" num toque;
     • embaixo, os botões ORIGINAIS (Voltar, Criar ou Salvar) com o que falta para criar.
   Para quem digita: Enter passa para o próximo campo, Ctrl+S (⌘S) salva, "170" vira "1,70",
   "365" vira "36,5" e "12080" na pressão vira 120 e 80.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Nenhum campo é criado: os campos do APEX são MUDADOS DE LUGAR dentro das mesmas regiões.
     Continuam valendo o Criar/Salvar e os processos (o status "SALA DE ESPERA" na chamada), a
     validação da data, a ação que esconde/mostra as regiões (registro novo × já feito) e o
     IMC do banco. Tirou as URLs: volta o de antes.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 74 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_PreAtendimento.js
     Página 74 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_PreAtendimento.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [P1] Como a página é reconhecida                                     CUIDADO
     [P2] Textos, unidades, dicas e referências                           PODE MEXER
     [P3] Ferramentas
     [P4] Quem é o paciente (o alto)
     [P5] Sinais vitais (e o IMC na hora)
     [P6] Os textos
     [P7] O rodapé (o que falta, alterações não salvas)
     [P8] Teclado: Enter, Ctrl+S e o jeito rápido de digitar           CUIDADO
     [P9] O maestro
*/
(function () {
  'use strict';
  if (window.__ncPreAtendimento || !window.apex || !window.apex.jQuery) return;
  var $ = window.apex.jQuery;

  /* ═══ [P1] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════════
     CUIDADO  pelos ITENS (P74_PA_SISTOLICA e P74_COD_PACIENTE), não pelo número da página.
              As regiões pelo conteúdo: a dos sinais (tem P74_PA_SISTOLICA), a dos campos do
              registro novo (tem P74_COD_PACIENTE) e a de leitura (tem P74_COD_PACIENTE_TXT).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  function regiaoDe(id) { var e = $id(id); return e ? e.closest('.t-Region') : null; }

  /* ═══ [P2] TEXTOS, UNIDADES, DICAS E REFERÊNCIAS ═════════════════════════════════════════
     PODE MEXER  tudo daqui. As DICAS são as ajudas que a página já tinha (o "?"), à vista.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ROTULOS = {
    P74_DATA_AGENDA: 'Data', P74_COD_TIPO_ATENDIMENTO: 'Tipo do atendimento', P74_COD_PREST_SERV: 'Atendente',
    P74_DT_HORARIO_REALIZADO: 'Realizado às', P74_COD_EMPRESA: 'Empresa', P74_TIPO_PACIENTE: 'Tipo de paciente', P74_COD_PACIENTE: 'Paciente',
    P74_SATURACAO: 'Saturação', P74_FREQUENCIA_CARDIACA: 'Frequência cardíaca', P74_TEMPERATURA: 'Temperatura',
    P74_ALTURA: 'Altura', P74_PESO: 'Peso', P74_IMC: 'IMC',
    P74_ALERGIAS: 'Alergias', P74_OBSERVACOES: 'Atendimento de enfermagem', P74_RELATO_PACIENTE: 'Relato do paciente'
  };
  var UNIDADES = { P74_SATURACAO: '% SpO₂', P74_FREQUENCIA_CARDIACA: 'bpm', P74_TEMPERATURA: '°C', P74_ALTURA: 'm', P74_PESO: 'kg', P74_IMC: 'kg/m²' };
  var EXEMPLOS = { P74_PA_SISTOLICA: '120', P74_PA_DIASTOLICA: '80', P74_SATURACAO: '98', P74_FREQUENCIA_CARDIACA: '72', P74_TEMPERATURA: '36,5', P74_ALTURA: '1,70', P74_PESO: '72,5' };
  var DICAS = {
    P74_ALERGIAS: 'Reação alérgica a algum componente ou medicamento.',
    P74_OBSERVACOES: 'Cirurgias já feitas, doenças crônicas, doenças hereditárias na família…',
    P74_RELATO_PACIENTE: 'Os sintomas que o colaborador ou candidato relata.'
  };
  var NEGA_ALERGIAS = 'Nega alergias.';
  /* as referências: só AVISAM (nada é bloqueado) — as mesmas do Exame Médico (página 19) */
  function refPA(s, d) {
    if (s == null && d == null) return null;
    if (s == null || d == null) return { tom: 'aviso', txt: 'Falta a ' + (s == null ? 'máxima' : 'mínima') };
    if (s >= 140 || d >= 90) return { tom: 'atencao', txt: 'Acima de 140/90' };
    if (s < 90 || d < 60) return { tom: 'atencao', txt: 'Abaixo de 90/60' };
    if (d >= s) return { tom: 'aviso', txt: 'A mínima está maior que a máxima' };
    return null;
  }
  function refSat(n) { if (n == null) return null; if (n > 100) return { tom: 'aviso', txt: 'Em %, até 100' }; if (n < 95) return { tom: 'atencao', txt: 'Abaixo de 95%' }; return null; }
  function refFC(n) { if (n == null) return null; if (n > 100) return { tom: 'atencao', txt: 'Acima de 100 bpm' }; if (n < 60) return { tom: 'atencao', txt: 'Abaixo de 60 bpm' }; return null; }
  function refTemp(n) { if (n == null) return null; if (n >= 37.8) return { tom: 'atencao', txt: 'Febre (37,8 °C ou mais)' }; if (n < 35) return { tom: 'atencao', txt: 'Abaixo de 35 °C' }; return null; }
  function classeIMC(n) {
    if (n == null || !(n > 0)) return null;
    if (n < 18.5) return { tom: 'atencao', txt: 'Abaixo do peso' };
    if (n < 25) return { tom: 'bom', txt: 'Peso adequado' };
    if (n < 30) return { tom: 'atencao', txt: 'Sobrepeso' };
    if (n < 35) return { tom: 'atencao', txt: 'Obesidade grau I' };
    if (n < 40) return { tom: 'atencao', txt: 'Obesidade grau II' };
    return { tom: 'atencao', txt: 'Obesidade grau III' };
  }

  /* ═══ [P3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function cx(id) { return $id(id + '_CONTAINER'); }
  function texto(id) { var e = $id(id); if (!e) return ''; return (e.value != null ? e.value : e.textContent || '').trim(); }
  function num(t) { t = String(t == null ? '' : t).trim().replace(/\s/g, ''); if (!t) return null; if (/,/.test(t)) t = t.replace(/\./g, '').replace(',', '.'); var n = parseFloat(t); return isNaN(n) ? null : n; }
  function br(n, casas) { return n == null ? '' : n.toFixed(casas).replace('.', ','); }
  var IC = {
    pessoa: '<circle cx="12" cy="8.5" r="3.7"/><path d="M5 20c.9-3.6 3.6-5.6 7-5.6s6.1 2 7 5.6"/>',
    coracao: '<path d="M12 20s-7-4.4-7-10a4 4 0 0 1 7-2.6A4 4 0 0 1 19 10c0 5.6-7 10-7 10z"/><path d="M8 12h2l1-2 2 4 1-2h2"/>',
    texto: '<rect x="5" y="4.5" width="14" height="16" rx="2.2"/><path d="M9 3.5h6v2.5H9zM9 11h6M9 14.5h6M9 18h3.5"/>',
    aviso: '<path d="M12 4l9 16H3z"/><path d="M12 10v4M12 17v.5"/>',
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    predio: '<path d="M5 20.5V5.5a1 1 0 0 1 1-1h8a1 1 0 0 1 1 1v15M15 9.5h3a1 1 0 0 1 1 1v10M3.5 20.5h17M8.5 8.5h3M8.5 12h3M8.5 15.5h3"/>',
    estetoscopio: '<path d="M6 3.5v5a4 4 0 0 0 8 0v-5"/><path d="M10 12.5v2.5a4.5 4.5 0 0 0 9 0v-2"/><circle cx="19" cy="11" r="2"/>'
  };
  function ic(n, cls) { return '<svg class="nc-pa-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  /* muda um campo do APEX (contêiner inteiro: rótulo, campo, lugar do erro) para outro lugar */
  function mover(id, destino, cls) {
    var c = cx(id); if (!c || !destino) return null;
    destino.appendChild(c); c.classList.add('nc-pa-campo'); if (cls) c.classList.add(cls);
    return c;
  }
  function rotular(id) {
    var l = $id(id + '_LABEL'); if (!l || !ROTULOS[id]) return;
    var vh = l.querySelector('.u-VisuallyHidden'); l.textContent = ROTULOS[id]; if (vh) l.appendChild(vh);
  }
  /* unidade dentro do campo, à direita; o exemplo cinza; o texto solto do APEX ("bpm", "Exemplo: 1,70") sai */
  function vestir(id) {
    var c = cx(id), e = $id(id); if (!c || !e) return;
    rotular(id);
    [].forEach.call(c.querySelectorAll('.t-Form-itemText, .t-Form-itemText--post'), function (x) { x.classList.add('nc-pa-oculto'); });
    if (EXEMPLOS[id] && !e.placeholder) e.placeholder = EXEMPLOS[id];
    e.setAttribute('inputmode', 'decimal'); e.setAttribute('autocomplete', 'off'); e.style.textAlign = '';
    var w = c.querySelector('.t-Form-itemWrapper');
    if (UNIDADES[id] && w && !w.querySelector('.nc-pa-un')) { w.classList.add('nc-pa-com-un'); w.appendChild(el('span', 'nc-pa-un', esc(UNIDADES[id]))); }
  }
  /* o aviso de referência embaixo do cartão */
  function nota(alvo, r) {
    if (!alvo) return;
    var n = alvo.querySelector(':scope > .nc-pa-nota');
    if (!r) { if (n) n.remove(); alvo.removeAttribute('data-tom'); return; }
    if (!n) { n = el('p', 'nc-pa-nota'); alvo.appendChild(n); }
    n.innerHTML = (r.tom === 'bom' ? ic('check') : ic('aviso')) + esc(r.txt);
    alvo.setAttribute('data-tom', r.tom);
  }
  function secao(titulo, icone, sub) {
    var s = el('section', 'nc-pa-sec');
    s.innerHTML = '<header class="nc-pa-sec-cab">' + ic(icone) + '<h2>' + esc(titulo) + '</h2>' + (sub ? '<p>' + esc(sub) + '</p>' : '') + '</header>';
    return s;
  }

  /* ═══ [P4] QUEM É O PACIENTE ═════════════════════════════════════════════════════════════
     Registro já feito (P74_ROWID): a região de leitura (…_TXT) vira um cartão. Registro novo:
     a região dos campos vira "Atendimento", em duas linhas — data, tipo, atendente, hora (só
     leitura); empresa, funcionário/candidato, paciente (a lista do paciente depende das
     outras, por isso fica por último, como no original).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function partes(t) { var m = /^\s*(\d+)\s*-\s*(.*)$/.exec(t || ''); return m ? { cod: m[1], nome: m[2] } : { cod: '', nome: (t || '').trim() }; }
  function nomeBonito(t) { t = String(t || '').trim(); if (!/[a-zà-ú]/.test(t)) t = t.toLowerCase().replace(/(^|\s)(\S)/g, function (m, a, c) { return a + c.toUpperCase(); }); return t.replace(/\s(De|Da|Do|Das|Dos|E)\s/g, function (m) { return m.toLowerCase(); }); }
  function cartaoLeitura(reg) {
    var p = partes(texto('P74_COD_PACIENTE_TXT')), emp = partes(texto('P74_COD_EMPRESA_TXT')), tipo = partes(texto('P74_COD_TIPO_ATENDIMENTO_TXT')), at = partes(texto('P74_COD_PREST_SERV_TXT').replace(/^(\d+)-/, '$1 - '));
    var quando = texto('P74_DT_HORARIO_REALIZADO_TXT'), m = /^(\d{2}\/\d{2}\/\d{4})\s+(\d{2}:\d{2})/.exec(quando);
    var alergia = texto('P74_ALERGIAS'); if (/^\s*(nega|nenhuma|n[aã]o\s+(possui|tem|h[aá]))/i.test(alergia)) alergia = '';
    if (alergia.length > 90) alergia = alergia.slice(0, 88) + '…';
    var c = el('section', 'nc-pa-quem');
    c.setAttribute('aria-label', 'O paciente');
    c.innerHTML = '<span class="nc-pa-avatar" aria-hidden="true">' + ic('pessoa') + '</span>' +
      '<div class="nc-pa-quem-txt"><p class="nc-pa-nome">' + esc(nomeBonito(p.nome) || 'Paciente') + (p.cod ? ' <span class="nc-pa-cod">' + esc(p.cod) + '</span>' : '') + '</p>' +
        '<p class="nc-pa-meta">' + [texto('P74_TIPO_PACIENTE_TXT'), nomeBonito(emp.nome)].filter(Boolean).map(esc).join(' <span aria-hidden="true">·</span> ') + '</p>' +
        /* alergia registrada (que não seja "nega"): à vista, no cartão — ninguém pode deixar passar */
        (alergia ? '<p class="nc-pa-alergia">' + ic('aviso') + '<b>Alergia:</b> ' + esc(alergia) + '</p>' : '') + '</div>' +
      '<dl class="nc-pa-fatos">' +
        (tipo.nome ? '<div><dt>Atendimento</dt><dd>' + esc(nomeBonito(tipo.nome)) + '</dd></div>' : '') +
        '<div><dt>Data</dt><dd>' + esc(m ? m[1] : texto('P74_DATA_AGENDA_TXT')) + (m ? ' <span class="nc-pa-fraco">às ' + esc(m[2]) + '</span>' : '') + '</dd></div>' +
        (at.nome ? '<div><dt>Atendente</dt><dd>' + esc(nomeBonito(at.nome)) + '</dd></div>' : '') +
      '</dl>';
    reg.parentNode.insertBefore(c, reg);
    reg.classList.add('nc-pa-guardado');
  }
  function montarNovo(reg) {
    reg.classList.add('nc-pa-sec', 'nc-pa-novo');
    var corpo = reg.querySelector('.t-Region-body');
    var cab = el('header', 'nc-pa-sec-cab', ic('pessoa') + '<h2>Atendimento</h2><p>Quem está sendo atendido agora.</p>');
    reg.querySelector('.t-Region-bodyWrap').insertBefore(cab, reg.querySelector('.t-Region-bodyWrap').firstChild);
    var l1 = el('div', 'nc-pa-grade nc-pa-grade--4'), l2 = el('div', 'nc-pa-grade nc-pa-grade--novo2');
    corpo.appendChild(l1); corpo.appendChild(l2);
    ['P74_DATA_AGENDA', 'P74_COD_TIPO_ATENDIMENTO', 'P74_COD_PREST_SERV', 'P74_DT_HORARIO_REALIZADO'].forEach(function (id) { mover(id, l1); rotular(id); });
    ['P74_COD_EMPRESA', 'P74_TIPO_PACIENTE', 'P74_COD_PACIENTE'].forEach(function (id) { mover(id, l2); rotular(id); });
    var hr = cx('P74_DT_HORARIO_REALIZADO'); if (hr && !texto('P74_DT_HORARIO_REALIZADO')) hr.classList.add('nc-pa-oculto');   /* no novo, a hora sai ao salvar */
    esvaziar(reg);
    /* Funcionário / Candidato em dois botões (escrevem na lista original: a do paciente recarrega) */
    var sel = $id('P74_TIPO_PACIENTE'), c = cx('P74_TIPO_PACIENTE');
    if (sel && c) {
      var g = el('div', 'nc-pa-seg'); g.setAttribute('role', 'radiogroup'); g.setAttribute('aria-labelledby', 'P74_TIPO_PACIENTE_LABEL');
      [].forEach.call(sel.options, function (o) {
        if (!o.value) return;
        var b = el('button', '', esc(o.text)); b.type = 'button'; b.setAttribute('role', 'radio'); b.setAttribute('data-tipo', o.value);
        g.appendChild(b);
      });
      var marca = function () { [].forEach.call(g.children, function (b) { b.setAttribute('aria-checked', String(b.getAttribute('data-tipo') === sel.value)); }); };
      g.addEventListener('click', function (ev) { var b = ev.target.closest('[data-tipo]'); if (b) { apex.item('P74_TIPO_PACIENTE').setValue(b.getAttribute('data-tipo')); marca(); } });
      $(sel).on('change', marca); marca();
      c.querySelector('.t-Form-itemWrapper').appendChild(g);
      sel.classList.add('nc-pa-so-leitor');
    }
    /* 04/10 (cliente): o tipo do atendimento NÃO é escolhido sozinho, nem com uma opção só */
  }
  /* o grid antigo da região (as linhas e colunas do APEX) fica vazio: some */
  function esvaziar(reg) { [].forEach.call(reg.querySelectorAll('.t-Region-body > .container'), function (c) { c.classList.add('nc-pa-vazio'); }); }

  /* ═══ [P5] SINAIS VITAIS ═════════════════════════════════════════════════════════════════
     A pressão é UM cartão com os dois campos originais lado a lado ("120 / 80 mmHg"). O IMC
     é calculado na hora (peso ÷ altura²) e escrito no campo P74_IMC, que é só de ver (não é
     gravado — a ação do banco continua lá, quando muda o peso).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var CARTOES = {};
  function cartao(grade, chave, titulo) {
    var k = el('div', 'nc-pa-vital'); k.setAttribute('data-vital', chave);
    if (titulo) k.appendChild(el('p', 'nc-pa-vital-tit', esc(titulo)));
    grade.appendChild(k); CARTOES[chave] = k; return k;
  }
  function montarVitais(reg) {
    reg.classList.add('nc-pa-sec', 'nc-pa-vitais');
    var wrap = reg.querySelector('.t-Region-bodyWrap'), corpo = reg.querySelector('.t-Region-body');
    var h = reg.querySelector('.t-Region-header'); if (h) h.classList.add('nc-pa-oculto');
    wrap.insertBefore(el('header', 'nc-pa-sec-cab', ic('coracao') + '<h2>Sinais vitais</h2><p>Os valores fora da referência ganham um aviso; nada é bloqueado.</p>'), wrap.firstChild);
    var g = el('div', 'nc-pa-grade nc-pa-grade--vitais'); corpo.appendChild(g);
    /* pressão: os dois campos num cartão só */
    var kp = cartao(g, 'pa', 'Pressão arterial'), linha = el('div', 'nc-pa-pa'); kp.appendChild(linha);
    mover('P74_PA_SISTOLICA', linha, 'nc-pa-campo--pa'); linha.appendChild(el('span', 'nc-pa-barra', '/'));
    mover('P74_PA_DIASTOLICA', linha, 'nc-pa-campo--pa'); linha.appendChild(el('span', 'nc-pa-un nc-pa-un--solta', 'mmHg'));
    [['P74_PA_SISTOLICA', 'Máxima (sistólica)'], ['P74_PA_DIASTOLICA', 'Mínima (diastólica)']].forEach(function (x) {
      var l = $id(x[0] + '_LABEL'); if (l) { l.textContent = x[1]; l.parentNode.classList.add('nc-pa-so-leitor'); }
      var e = $id(x[0]); if (e) { e.placeholder = EXEMPLOS[x[0]]; e.setAttribute('inputmode', 'numeric'); e.setAttribute('autocomplete', 'off'); e.style.textAlign = ''; }
      [].forEach.call((cx(x[0]) || document).querySelectorAll('.t-Form-itemText'), function (t) { t.classList.add('nc-pa-oculto'); });
    });
    ['P74_SATURACAO', 'P74_FREQUENCIA_CARDIACA', 'P74_TEMPERATURA', 'P74_ALTURA', 'P74_PESO', 'P74_IMC'].forEach(function (id) {
      var k = cartao(g, id); mover(id, k); vestir(id);
    });
    var imc = $id('P74_IMC'); if (imc) { imc.readOnly = true; imc.tabIndex = -1; imc.placeholder = '—'; CARTOES.P74_IMC.classList.add('nc-pa-vital--imc'); }
    var e = function (id) { return $id(id); };
    ['P74_PA_SISTOLICA', 'P74_PA_DIASTOLICA', 'P74_SATURACAO', 'P74_FREQUENCIA_CARDIACA', 'P74_TEMPERATURA', 'P74_ALTURA', 'P74_PESO'].forEach(function (id) {
      var x = e(id); if (x) { x.addEventListener('input', referencias); x.addEventListener('change', referencias); }
    });
    esvaziar(reg);
    return g;
  }
  function calcularIMC() {
    var p = num(texto('P74_PESO')), a = num(texto('P74_ALTURA'));
    if (a != null && a > 3) a = a / 100;   /* "170" ainda sem a vírgula */
    var v = p && a ? p / (a * a) : null;
    if (v != null && (v < 5 || v > 120)) v = null;
    var imc = $id('P74_IMC'); if (imc) imc.value = v == null ? (imc.value && !p ? '' : imc.value) : br(v, 1);
    return v != null ? v : num(imc && imc.value);
  }
  function referencias() {
    nota(CARTOES.pa, refPA(num(texto('P74_PA_SISTOLICA')), num(texto('P74_PA_DIASTOLICA'))));
    nota(CARTOES.P74_SATURACAO, refSat(num(texto('P74_SATURACAO'))));
    nota(CARTOES.P74_FREQUENCIA_CARDIACA, refFC(num(texto('P74_FREQUENCIA_CARDIACA'))));
    nota(CARTOES.P74_TEMPERATURA, refTemp(num(texto('P74_TEMPERATURA'))));
    var alt = num(texto('P74_ALTURA'));
    nota(CARTOES.P74_ALTURA, alt != null && (alt < 0.5 || alt > 2.5) && !(alt >= 50 && alt <= 250) ? { tom: 'aviso', txt: 'Em metros, como 1,70' } : null);
    nota(CARTOES.P74_IMC, classeIMC(calcularIMC()));
  }

  /* ═══ [P6] OS TEXTOS ═════════════════════════════════════════════════════════════════════ */
  function montarTextos(reg) {
    var s = el('div', 'nc-pa-textos'); reg.querySelector('.t-Region-body').appendChild(s);
    s.appendChild(el('header', 'nc-pa-sec-cab nc-pa-sec-cab--meio', ic('texto') + '<h2>Anotações</h2>'));
    ['P74_ALERGIAS', 'P74_OBSERVACOES', 'P74_RELATO_PACIENTE'].forEach(function (id) {
      var c = mover(id, s, 'nc-pa-campo--texto'); if (!c) return;
      rotular(id);
      var help = c.querySelector('.t-Form-helpButton'); if (help) help.closest('.t-Form-itemAssistance, .t-Form-inputContainer > *') && help.classList.add('nc-pa-oculto');
      if (DICAS[id]) c.querySelector('.t-Form-labelContainer').appendChild(el('span', 'nc-pa-dica', esc(DICAS[id])));
      contador(id);
    });
    /* "Nega alergias" num toque (só com o campo vazio) */
    var a = $id('P74_ALERGIAS'), ca = cx('P74_ALERGIAS');
    if (a && ca && !a.readOnly && !a.disabled) {
      var b = el('button', 'nc-pa-chip', ic('check') + esc(NEGA_ALERGIAS)); b.type = 'button';
      var ver = function () { b.hidden = !!a.value.trim(); };
      b.addEventListener('click', function () { apex.item('P74_ALERGIAS').setValue(NEGA_ALERGIAS); ver(); a.focus(); });
      a.addEventListener('input', ver); ver();
      ca.querySelector('.t-Form-labelContainer').appendChild(b);
    }
  }
  function contador(id) {
    var e = $id(id); if (!e || !(e.maxLength > 0)) return;
    var c = cx(id), s = el('span', 'nc-pa-limite'); c.querySelector('.t-Form-inputContainer').appendChild(s);
    var f = function () { s.textContent = (e.value || '').length + ' de ' + e.maxLength; s.setAttribute('data-perto', (e.value || '').length > e.maxLength * 0.9 ? 'sim' : 'nao'); };
    f(); e.addEventListener('input', f);
  }

  /* ═══ [P7] O RODAPÉ ══════════════════════════════════════════════════════════════════════
     Os botões ORIGINAIS ficam no rodapé da janela. Ao lado, o estado: no registro novo, o que
     ainda falta para criar; depois de mexer, "alterações não salvas".
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var OBRIG = ['P74_DATA_AGENDA', 'P74_COD_TIPO_ATENDIMENTO', 'P74_COD_PREST_SERV', 'P74_COD_EMPRESA', 'P74_TIPO_PACIENTE', 'P74_COD_PACIENTE'];
  var ESTADO, NOVO, SUJO = false, B_SALVAR;
  function botaoPor(rx) { return [].filter.call(document.querySelectorAll('.t-Dialog-footer button, .t-ButtonRegion button'), function (b) { return rx.test(b.textContent.trim()); })[0] || null; }
  function montarRodape() {
    B_SALVAR = botaoPor(/^(salvar|criar)$/i);
    var col = document.querySelector('.t-Dialog-footer .t-ButtonRegion-col--content') || document.querySelector('.t-Dialog-footer .t-ButtonRegion-wrap');
    ESTADO = el('p', 'nc-pa-estado'); ESTADO.setAttribute('role', 'status');
    if (col) col.appendChild(ESTADO);
    var f = document.querySelector('.t-Dialog-footer'); if (f) f.classList.add('nc-pa-rodape');
    estado();
  }
  function estado() {
    if (!ESTADO) return;
    /* o VALOR do item (a busca do paciente mostra "- Selecione -" no texto quando está vazia) */
    var falta = NOVO ? OBRIG.filter(function (id) { var v = ''; try { v = apex.item(id).getValue(); } catch (e) { v = texto(id); } return $id(id) && !String(v || '').trim(); }).map(function (id) { return (ROTULOS[id] || id).toLowerCase(); }) : [];
    ESTADO.setAttribute('data-tom', falta.length ? 'falta' : SUJO ? 'sujo' : '');
    ESTADO.innerHTML = falta.length ? ic('aviso') + 'Para criar, falta: ' + esc(falta.join(', ')) : SUJO ? '<span class="nc-pa-ponto" aria-hidden="true"></span>Alterações não salvas' : '';
  }

  /* ═══ [P8] TECLADO ═══════════════════════════════════════════════════════════════════════
     • Enter num campo vai para o próximo (no texto livre, Enter continua pulando linha).
     • Ctrl+S / ⌘S aperta o Criar ou o Salvar (depois de terminar as chamadas ao banco).
     • ARRUMAR roda ANTES das ações dinâmicas (captura do "change"): o banco recebe "1,70"
       mesmo que digitem "170" — o IMC do banco sai certo.
     CUIDADO  o banco espera vírgula decimal ("70,5"); "70.5" com ponto dá erro no IMC do banco.
              Nunca disparar "change" à mão antes (pularia o ARRUMAR).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ARRUMAR = {
    P74_ALTURA: function (t) { t = t.replace(/\s/g, '').replace('.', ','); if (/^\d{3}$/.test(t) && +t >= 50 && +t <= 250) return t.charAt(0) + ',' + t.slice(1); return t; },
    P74_PESO: function (t) { return t.replace(/\s/g, '').replace('.', ','); },
    P74_TEMPERATURA: function (t) { t = t.replace(/\s/g, '').replace('.', ','); if (/^\d{3}$/.test(t) && +t >= 340 && +t <= 429) return t.slice(0, 2) + ',' + t.charAt(2); return t; },
    P74_SATURACAO: function (t) { return t.replace(/\s/g, '').replace('%', '').replace('.', ','); },
    P74_FREQUENCIA_CARDIACA: function (t) { return t.replace(/\D/g, ''); },
    P74_PA_DIASTOLICA: function (t) { return t.replace(/\D/g, ''); },
    /* "12080" (ou "120/80", "120x80") na máxima: 120 fica, 80 vai para a mínima */
    P74_PA_SISTOLICA: function (t) {
      t = t.replace(/\s/g, '');
      var m = /^(\d{2,3})\D+(\d{2,3})$/.exec(t) || (/^\d{4,6}$/.test(t) ? [t, t.slice(0, t.length === 4 ? 2 : 3), t.slice(t.length === 4 ? 2 : 3)] : null);
      if (m) { var d = $id('P74_PA_DIASTOLICA'); if (d) { d.value = m[2]; d.dispatchEvent(new Event('change', { bubbles: true })); } return m[1]; }
      return t.replace(/\D/g, '');
    }
  };
  function teclado(raiz) {
    document.addEventListener('change', function (ev) {
      var f = ev.target && ARRUMAR[ev.target.id]; if (!f) return;
      var novo = f(ev.target.value || ''); if (novo !== ev.target.value) ev.target.value = novo;
    }, true);
    document.addEventListener('input', function (ev) { if (raiz.contains(ev.target) && !SUJO) { SUJO = true; estado(); } });
    document.addEventListener('change', function () { estado(); });
    raiz.addEventListener('keydown', function (ev) {
      if (ev.key !== 'Enter' || ev.shiftKey || ev.altKey || ev.ctrlKey || ev.metaKey) return;
      var t = ev.target;
      if (!t || t.tagName !== 'INPUT' || !/^(text|number|tel)$/i.test(t.type) || t.classList.contains('apex-item-popup-lov') || t.classList.contains('hasDatepicker')) return;
      ev.preventDefault();
      var todos = [].filter.call(raiz.querySelectorAll('input.apex-item-text, select.apex-item-select, textarea'), function (e) { return e.offsetParent && !e.readOnly && !e.disabled && !e.closest('.apex_disabled'); });
      var i = todos.indexOf(t);
      if (i >= 0 && todos[i + 1]) { todos[i + 1].focus(); if (todos[i + 1].select && todos[i + 1].tagName === 'INPUT') todos[i + 1].select(); }
    });
    document.addEventListener('keydown', function (ev) {
      if ((ev.ctrlKey || ev.metaKey) && !ev.altKey && (ev.key === 's' || ev.key === 'S')) {
        ev.preventDefault();
        if (!B_SALVAR || B_SALVAR.disabled) return;
        if (document.activeElement && document.activeElement.blur) document.activeElement.blur();
        var t0 = Date.now();
        (function esperar() { if ($.active > 0 && Date.now() - t0 < 3000) return setTimeout(esperar, 80); B_SALVAR.click(); })();
      }
    });
  }

  /* ═══ [P9] O MAESTRO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() {
    if (!$id('P74_PA_SISTOLICA') || !$id('P74_COD_PACIENTE')) return;
    window.__ncPreAtendimento = true;
    document.body.classList.add('nc-pa-ativo');
    NOVO = !texto('P74_ROWID');
    var raiz = document.querySelector('.t-Dialog-body') || document.body;
    var regVit = regiaoDe('P74_PA_SISTOLICA'), regNovo = regiaoDe('P74_COD_PACIENTE'), regLer = regiaoDe('P74_COD_PACIENTE_TXT');
    if (NOVO) { if (regNovo) montarNovo(regNovo); if (regLer) regLer.classList.add('nc-pa-guardado'); }
    else { if (regLer) cartaoLeitura(regLer); if (regNovo) regNovo.classList.add('nc-pa-guardado'); }
    if (regVit) { montarVitais(regVit); montarTextos(regVit); }
    montarRodape();
    teclado(raiz);
    referencias();
    /* o IMC do banco chega depois (ação dinâmica): a classificação acompanha */
    $(document).on('apexafterrefresh', referencias);
    $('#P74_IMC').on('change', function () { nota(CARTOES.P74_IMC, classeIMC(num(texto('P74_IMC')))); });
    setTimeout(referencias, 1200);
  }
  var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp pré-atendimento]', e); } }, 0); };
  if (document.readyState === 'complete') vai();
  else { if (window.apex.gPageContext$) $(apex.gPageContext$).one('apexreadyend', vai); window.addEventListener('load', vai); }
})();
