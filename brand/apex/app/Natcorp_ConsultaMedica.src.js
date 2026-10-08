/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CONSULTA MÉDICA  —  o "arrumador" da tela (JavaScript)                        ║
   ║  App 2937 (Medicina Ocupacional) · Página 40 · Consulta Médica (modal)                   ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia desta página: CONSULTAMEDICA-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   É onde o médico REGISTRA a consulta (aberta pela Agenda Médica). As 12 abas viram UMA ficha,
   na ordem do atendimento, com um trilho à esquerda para ir direto a cada parte:
     • no alto, fixo, QUEM é o paciente (código - nome, idade, empresa), o tipo de consulta, o
       dia e a hora de entrada — e os botões Dados do funcionário / Atestado de Saúde
       Ocupacional / Imprimir;
     • o trilho: Consulta · Ouvir (relato, anamnese, antecedentes, gestação) · Examinar ·
       Concluir (diagnóstico, conduta) · Prescrever e orientar (receituário, posologia,
       encaminhamento) · Trabalho (atividades, recomendação). Cada parte mostra se já tem algo
       escrito e acende quando está na tela (e fica vermelha se o servidor apontar erro nela);
     • os antecedentes (as 18 perguntas "Aparelho circulatório?", "Alergia?"…) viram botões de
       marcar; "Outras doenças" e "Uso de medicamentos" abrem o campo de descrever só quando
       marcados;
     • os textos crescem com o que se escreve e mostram quanto falta do limite;
     • no rodapé, fixo: Voltar e Finalizar consulta, com o que falta (a hora de saída, que o
       servidor grava no Finalizar — processo "Set Values" da página);
     • sair sem finalizar (Voltar, Dados do funcionário, ASO) com algo escrito pede confirmação
       — a consulta só é gravada ao Finalizar.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Nenhum campo é criado, trocado ou gravado por conta própria: as REGIÕES do APEX são mudadas
     de lugar (das abas para a ficha), com os campos, os relatórios (receituário, doenças,
     atividades) e os botões Adicionar dentro. Continuam valendo: o Finalizar (com a pergunta
     de sempre), as validações, os processos, as ações dinâmicas (idade, tipo de exame, dias
     da recomendação, gestante, "outras doenças"…) e a trava do PRÉ-ATENDIMENTO (as regiões
     TAB1…TAB10 desligadas até "Iniciar Atendimento" — o desenho mostra o aviso com o botão).
     Tirou as URLs deste arquivo: a página volta a ser a de abas.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 40 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_ConsultaMedica.js
     Página 40 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_ConsultaMedica.css

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
     • a região de abas com as regiões TAB1…TAB10 (Static ID) e as de Anamnese, Antecedentes e
       Gestante (achadas pelos campos P40_TEXTO_ANAMNESE, P40_ALERGIA e P40_IND_GESTANTE);
     • os itens P40_MATRICULA, P40_DSP_IDADE e os da consulta (os que faltarem só não aparecem).

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [K1]  Como a página é reconhecida                                      CUIDADO
     [K2]  As partes da ficha e os textos                                   PODE MEXER
     [K3]  Ferramentas
     [K4]  Quem é o paciente (o alto)
     [K5]  A ficha: as partes na ordem do atendimento                       CUIDADO
     [K6]  O trilho (ir para cada parte, o que já tem escrito)
     [K7]  Antecedentes, textos, horários
     [K8]  O rodapé: o que falta, Finalizar, sair sem finalizar             CUIDADO
     [K9]  Pré-atendimento (a trava)
     [K10] O maestro                                                        CUIDADO

   ── LEGENDA ───────────────────────────────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, cores.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
*/
(function () {
  'use strict';
  if (window.__ncConsultaMedica || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [K2] AS PARTES DA FICHA E OS TEXTOS ════════════════════════════════════════════════
     GRUPOS   a ordem da ficha e do trilho. Cada parte: [chave, título, como achar a região].
              Como achar: '#TAB3' (Static ID) ou 'campo:P40_X' (a região de mais fora que tem
              o campo, dentro das abas). A parte que não existir na página só não aparece.
     ROTULOS  o nome que aparece em cima de alguns campos (o do APEX fica para as mensagens).
     PODE MEXER a ordem, os títulos, os rótulos.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var GRUPOS = [
    ['', [['consulta', 'Dados da consulta', '#TAB1']]],
    ['Ouvir', [['relato', 'Relato do paciente', '#TAB2'], ['anamnese', 'Anamnese', 'campo:P40_TEXTO_ANAMNESE'], ['antecedentes', 'Antecedentes e vida pregressa', 'campo:P40_ALERGIA'], ['gestacao', 'Gestação', 'campo:P40_IND_GESTANTE']]],
    ['Examinar', [['exame', 'Exame físico', '#TAB3']]],
    ['Concluir', [['diagnostico', 'Diagnóstico', '#TAB6'], ['conduta', 'Conduta', '#TAB8']]],
    ['Prescrever e orientar', [['receita', 'Receituário', '#TAB4'], ['posologia', 'Posologia', '#TAB5'], ['encaminhamento', 'Encaminhamento', '#TAB7']]],
    ['Trabalho', [['atividades', 'Descrição de atividades', '#TAB9'], ['recomendacao', 'Recomendação de trabalho compatível', '#TAB10']]]
  ];
  var ROTULOS = {
    P40_DSP_RELATO_PACIENTE: 'O que o paciente relata', P40_TEXTO_ANAMNESE: 'Registro da entrevista',
    P40_DSP_EXAME_FISICO: 'Achados do exame físico', P40_DSP_DIAGNOSTICO: 'Diagnóstico', P40_DSP_POSOLOGIA: 'Posologia',
    P40_DSP_ENCAMINHAMENTO: 'Encaminhamento', P40_DSP_CONDUTA: 'Conduta', P40_DSP_IDADE: 'Idade',
    P40_COD_TIPO_CONSULTA: 'Tipo de consulta', P40_DT_CONSULTA: 'Data', P40_DT_CONSULTA_HH: 'Entrada', P40_DT_CONSULTA_HH_FIM: 'Saída',
    P40_DESC_OUTRAS_DOENCAS: 'Quais outras doenças', P40_DESC_USO_MEDICAMENTOS: 'Quais medicamentos',
    P40_ANTEC_PESSOAIS: 'Pessoais', P40_ANTEC_FAMILIARES: 'Familiares', P40_ANTEC_OCUPACIONAIS: 'Ocupacionais', P40_OBSERVACOES: 'Observações',
    P40_HIGIDO: 'Hígido', P40_QTDE_DIAS: 'Dias', P40_DESCRICAO_RESTRICAO: 'Não deverá realizar as atividades abaixo'
  };
  /* os campos de horário: [hora, minuto] de entrada e de saída */
  var ENTRADA = ['P40_DT_CONSULTA_HH', 'P40_DT_CONSULTA_MM'], SAIDA = ['P40_DT_CONSULTA_HH_FIM', 'P40_DT_CONSULTA_MM_FIM'];
  /* os botões que levam para fora da consulta (sem gravar) — com algo escrito, pedem confirmação */
  var SAI = /^(voltar|dados do funcion[aá]rio|atestado de sa[uú]de ocupacional)$/i;

  /* ═══ [K3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function nome(t) {
    return String(t || '').toLowerCase().replace(/(^|[\s'(/-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); })
      .replace(/\s(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  function codDesc(t) {
    t = String(t || '').trim(); if (!t) return '';
    var m = /^(\S+)\s+-\s+(.+)$/.exec(t);
    if (!m) return /[a-zà-ú]/.test(t) ? t : nome(t);
    return m[1] + ' - ' + (/[a-zà-ú]/.test(m[2]) ? m[2] : nome(m[2]));
  }
  function texto(id) { var e = $id(id + '_DISPLAY') || $id(id); if (!e) return ''; return String(/^(INPUT|SELECT|TEXTAREA)$/.test(e.tagName) ? e.value : e.textContent).trim(); }
  function dois(n) { return ('0' + n).slice(-2); }
  var IC = {
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>', relogio: '<circle cx="12" cy="12" r="8"/><path d="M12 7.5V12l3 2"/>',
    play: '<path d="M8 5.5v13l10.5-6.5z"/>', calendario: '<rect x="4" y="5.5" width="16" height="14" rx="2.5"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4"/>',
    alerta: '<path d="M12 4l9 16H3z"/><path d="M12 10v4M12 17h.01"/>', finalizar: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>',
    pessoa: '<circle cx="12" cy="8.5" r="3.5"/><path d="M5 20a7 7 0 0 1 14 0"/>', documento: '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4M9.5 12.5h6M9.5 16h6"/>',
    imprimir: '<path d="M7 9V4.5h10V9M7 16.5H5.5A1.5 1.5 0 0 1 4 15v-4.5A1.5 1.5 0 0 1 5.5 9h13a1.5 1.5 0 0 1 1.5 1.5V15a1.5 1.5 0 0 1-1.5 1.5H17"/><path d="M7 13.5h10v6H7z"/>'
  };
  function ic(n) { return '<svg class="nc-cm-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }

  function iniciar() {
    if (window.__ncConsultaMedica) return;
    /* ═══ [K1] COMO A PÁGINA É RECONHECIDA ════════════════════════════════════════════════
       Pela região de abas com a TAB1 e pelo item da matrícula — nunca pelo número do app.
       ════════════════════════════════════════════════════════════════════════════════════ */
    var abas = document.querySelector('.t-TabsRegion');
    if (!abas || !$id('TAB1') || !$id('P40_MATRICULA')) return;
    window.__ncConsultaMedica = true;
    document.body.classList.add('nc-cm-ativo');
    var cabDlg = document.querySelector('.t-Dialog-header'), peDlg = document.querySelector('.t-Dialog-footer');
    var rolador = document.querySelector('.t-Dialog-bodyWrapperIn') || document.scrollingElement;
    var foraDlg = document.querySelector('.t-Dialog-bodyWrapperOut');
    var corpo = document.querySelector('.t-Dialog-body') || abas.parentNode;
    var NOVA = !texto('P40_ROWID');
    var app = el('section', 'nc-cm'); app.setAttribute('aria-label', 'Registro da consulta');
    abas.parentNode.insertBefore(app, abas);

    /* ═══ [K4] QUEM É O PACIENTE ══════════════════════════════════════════════════════════
       Lido dos itens da região do formulário (empresa, matrícula, idade) e da consulta. Com o
       paciente já escolhido (vindo da Agenda), a região de empresa/matrícula sai da vista;
       sem paciente, ela fica, para escolher.
       ════════════════════════════════════════════════════════════════════════════════════ */
    /* a região do formulário (empresa, matrícula, idade) não tem moldura de região: é a de id R… */
    var regForm = $id('P40_MATRICULA_CONTAINER') && $id('P40_MATRICULA_CONTAINER').closest('.t-Region, [id^="R"]');
    var pac = el('header', 'nc-cm-paciente');
    pac.innerHTML = '<div class="nc-cm-pac-id"></div><div class="nc-cm-pac-acoes"></div>';
    var acoesPac = pac.querySelector('.nc-cm-pac-acoes');
    function desenharPaciente() {
      var quem = texto('P40_MATRICULA'), m = /^\s*(\S+)\s+-\s+(.+)$/.exec(quem);
      var cod = m ? m[1] : '', nm = m ? m[2] : quem;
      if (nm && !/[a-zà-ú]/.test(nm)) nm = nome(nm);
      var ini = String(nm || '?').split(/\s+/).filter(function (p) { return p.length > 2; });
      ini = ((ini[0] || '?').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '')).toUpperCase();
      var idade = texto('P40_DSP_IDADE'), tipo = codDesc(texto('P40_COD_TIPO_CONSULTA'));
      var hh = texto(ENTRADA[0]), mm = texto(ENTRADA[1]);
      var dados = [
        ['Idade', idade ? idade + (/ano/.test(idade) ? '' : ' anos') : ''],
        ['Empresa', codDesc(texto('P40_COD_EMPRESA'))],
        ['Médico', codDesc(texto('P40_COD_PREST_SERV'))],
        ['Especialidade', codDesc(texto('P40_COD_ESPECIALIDADE'))]
      ].filter(function (d) { return d[1]; });
      pac.querySelector('.nc-cm-pac-id').innerHTML = quem ?
        '<span class="nc-cm-avatar" aria-hidden="true">' + esc(ini) + '</span>' +
        '<div class="nc-cm-pac-nome"><h1>' + (cod ? '<span class="nc-cm-cod">' + esc(cod) + ' - </span>' : '') + esc(nm) + '</h1>' +
        '<dl class="nc-cm-pac-dados">' + dados.map(function (d) { return '<div data-k="' + esc(d[0].toLowerCase()) + '"><dt>' + esc(d[0]) + '</dt><dd>' + esc(d[1]) + '</dd></div>'; }).join('') + '</dl></div>' +
        '<div class="nc-cm-pac-consulta">' + (tipo ? '<span class="nc-cm-tipo">' + esc(tipo) + '</span>' : '') +
          '<span class="nc-cm-quando">' + ic('calendario') + esc(texto('P40_DT_CONSULTA')) + (hh ? ' · entrada ' + esc(dois(hh) + ':' + dois(mm || 0)) : '') + '</span></div>'
        : '<span class="nc-cm-avatar" aria-hidden="true">' + ic('pessoa') + '</span><div class="nc-cm-pac-nome"><h1>Escolha o paciente</h1><p class="nc-cm-fraco">Empresa e matrícula, logo abaixo.</p></div>';
      if (regForm) regForm.classList.toggle('nc-cm-guardada', !!quem);
    }
    var estreito = window.matchMedia && window.matchMedia('(max-width: 760px)');
    function lugares() {
      var cel = estreito && estreito.matches;
      if (cel || !cabDlg) app.insertBefore(pac, app.firstChild); else cabDlg.appendChild(pac);
      document.body.classList.toggle('nc-cm-cab-fixo', pac.parentNode === cabDlg);
      if (trilho) { if (cel || !foraDlg) { if (cabDlg && cel) cabDlg.appendChild(trilho); else app.insertBefore(trilho, app.firstChild.nextSibling); } else foraDlg.insertBefore(trilho, foraDlg.firstChild); document.body.classList.toggle('nc-cm-trilho-lado', trilho.parentNode === foraDlg); }
    }

    /* ═══ [K5] A FICHA: AS PARTES NA ORDEM DO ATENDIMENTO ═════════════════════════════════
       CUIDADO  As regiões são MOVIDAS (não copiadas) das abas para cá, inteiras: a trava do
                pré-atendimento (#TAB1…#TAB10), os relatórios e os botões Adicionar seguem
                dentro delas. A região de abas fica vazia e sai da vista.
       ════════════════════════════════════════════════════════════════════════════════════ */
    function achar(como) {
      if (como.charAt(0) === '#') return $id(como.slice(1));
      var c = $id(como.replace('campo:', '')); if (!c) return null;
      /* a região de mais fora que tem o campo, ainda dentro das abas */
      var r = c.closest('.t-Region'), cima;
      while (r && (cima = r.parentElement && r.parentElement.closest('.t-Region, .t-IRR-region')) && abas.contains(cima) && cima !== abas) r = cima;
      return r && abas.contains(r) ? r : null;
    }
    var PARTES = [];
    var ficha = el('div', 'nc-cm-ficha'); app.appendChild(ficha);
    GRUPOS.forEach(function (g) {
      g[1].forEach(function (p) {
        var reg = achar(p[2]); if (!reg) return;
        var sec = el('section', 'nc-cm-sec'); sec.id = 'nc-cm-' + p[0]; sec.setAttribute('aria-labelledby', sec.id + '-tit');
        sec.innerHTML = '<header class="nc-cm-sec-cab"><h2 id="' + sec.id + '-tit">' + esc(p[1]) + '</h2><span class="nc-cm-sec-estado"></span></header>';
        sec.appendChild(reg);
        reg.classList.add('nc-cm-regiao');
        ficha.appendChild(sec);
        PARTES.push({ chave: p[0], titulo: p[1], grupo: g[0], sec: sec, reg: reg });
      });
    });
    abas.classList.add('nc-cm-guardada');
    PARTES.forEach(function (p) {
      [].forEach.call(p.reg.querySelectorAll('.t-Region'), function (sub) {
        if (sub === p.reg) return;
        sub.classList.add('nc-cm-sub');
        var t = sub.querySelector(':scope > .t-Region-header .t-Region-title');
        var tit = t ? t.textContent.trim() : '';
        var body = sub.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || sub.querySelector('.t-Region-body');
        /* o título repete o da parte (Anamnese dentro de Anamnese)? não aparece */
        if (tit && body && tit.toLowerCase() !== p.titulo.toLowerCase() && !sub.classList.contains('t-Region--removeHeader')) {
          body.insertBefore(el('h3', 'nc-cm-subtit', esc(tit)), body.firstChild);
          /* o campo único com o mesmo nome do título (Pessoais > "Pessoais"): o rótulo fica só para o leitor de tela */
          var cs = sub.querySelectorAll('.t-Form-fieldContainer');
          if (cs.length === 1) { var l = cs[0].querySelector('.t-Form-label'); if (l && l.textContent.trim().toLowerCase() === tit.toLowerCase()) cs[0].querySelector('.t-Form-labelContainer').classList.add('nc-cm-so-leitor'); }
        }
      });
    });
    /* rótulos novos */
    Object.keys(ROTULOS).forEach(function (id) { var l = $id(id + '_LABEL'); if (l) l.textContent = ROTULOS[id]; });
    /* 04/10: o "TIPO EXAME" fica à vista. A ação dinâmica o preenche pelo tipo de consulta, mas é
       um campo de texto EDITÁVEL da página (e decide se o botão ASO aparece); escondê-lo tirava
       do médico um campo que a página deixa mudar. */
    /* botões do cabeçalho das regiões (Dados do funcionário, ASO, Imprimir…) vão para o alto */
    var t1 = $id('TAB1');
    if (t1) [].forEach.call(t1.querySelectorAll('.t-Region-header button.t-Button, .t-Region-headerItems--buttons button.t-Button'), function (b) {
      var tx = b.textContent.trim();
      b.classList.add('nc-cm-bt', 'nc-cm-bt--leve');
      b.insertAdjacentHTML('afterbegin', ic(/imprimir/i.test(tx) ? 'imprimir' : /funcion/i.test(tx) ? 'pessoa' : 'documento'));
      acoesPac.appendChild(b);
    });

    /* ═══ [K6] O TRILHO ═══════════════════════════════════════════════════════════════════
       Fica fora da rolagem (à esquerda no computador; no celular, uma faixa no alto). Tocar
       numa parte rola até ela. A parte na tela acende; a que já tem algo escrito ganha o ✓;
       a que tem erro do servidor fica vermelha.
       ════════════════════════════════════════════════════════════════════════════════════ */
    var trilho = el('nav', 'nc-cm-trilho'); trilho.setAttribute('aria-label', 'Partes da consulta');
    var gAtual = null, html = '';
    PARTES.forEach(function (p) {
      if (p.grupo !== gAtual) { if (gAtual !== null) html += '</ol>'; html += (p.grupo ? '<p class="nc-cm-tr-grupo">' + esc(p.grupo) + '</p>' : '') + '<ol>'; gAtual = p.grupo; }
      html += '<li><a href="#' + p.sec.id + '" data-parte="' + p.chave + '"><span class="nc-cm-tr-marca" aria-hidden="true"></span><span>' + esc(p.titulo) + '</span></a></li>';
    });
    trilho.innerHTML = html + '</ol>';
    trilho.addEventListener('click', function (ev) {
      var a = ev.target.closest('a[data-parte]'); if (!a) return;
      ev.preventDefault();
      var p = PARTES.filter(function (x) { return x.chave === a.getAttribute('data-parte'); })[0]; if (!p) return;
      var topo = p.sec.getBoundingClientRect().top - rolador.getBoundingClientRect().top + rolador.scrollTop - 12;
      rolador.scrollTo({ top: topo, behavior: matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth' });
      var alvo = p.sec.querySelector('textarea:not([disabled]), input:not([type=hidden]):not([readonly]):not([disabled])');
      if (alvo) setTimeout(function () { try { alvo.focus({ preventScroll: true }); } catch (x) { alvo.focus(); } }, 350);
    });
    function preenchida(p) {
      if ([].some.call(p.reg.querySelectorAll('textarea'), function (t) { return t.value.trim(); })) return true;
      if (p.reg.querySelector('.apex-item-checkbox input:checked, .apex-item-radio input:checked')) return true;
      /* relatório conta só onde o médico lança (receituário, doenças do diagnóstico); a descrição
         de atividades vem pronta do cadastro da função */
      if (/^(receita|diagnostico)$/.test(p.chave) && [].some.call(p.reg.querySelectorAll('.a-IRR-table'), function (t) { return t.querySelectorAll('tr').length > 1; })) return true;
      return false;
    }
    function estados() {
      PARTES.forEach(function (p) {
        var a = trilho.querySelector('[data-parte="' + p.chave + '"]');
        var cheia = p.chave !== 'consulta' && preenchida(p), erro = !!p.reg.querySelector('.is-error, .a-Form-error:not(:empty), .t-Form-error:not(:empty)');
        a.setAttribute('data-estado', erro ? 'erro' : cheia ? 'cheia' : 'vazia');
        a.title = erro ? 'Há um erro nesta parte' : cheia ? 'Já tem registro' : 'Ainda sem registro';
        var s = p.sec.querySelector('.nc-cm-sec-estado');
        s.textContent = erro ? 'Confira esta parte' : cheia ? 'Registrado' : '';
        s.setAttribute('data-estado', erro ? 'erro' : cheia ? 'cheia' : 'vazia');
      });
    }
    if (window.IntersectionObserver) {
      var vis = {};
      var io = new IntersectionObserver(function (ents) {
        ents.forEach(function (e) { vis[e.target.id] = e.isIntersecting ? e.intersectionRatio : 0; });
        var melhor = null, mv = 0;
        PARTES.forEach(function (p) { var v = vis[p.sec.id] || 0; if (v > mv) { mv = v; melhor = p; } });
        [].forEach.call(trilho.querySelectorAll('a'), function (a) { a.removeAttribute('aria-current'); });
        if (melhor) { var a = trilho.querySelector('[data-parte="' + melhor.chave + '"]'); a.setAttribute('aria-current', 'true'); if (estreito && estreito.matches && a.scrollIntoView) a.scrollIntoView({ block: 'nearest', inline: 'center' }); }
      }, { root: rolador === document.scrollingElement ? null : rolador, threshold: [0, 0.15, 0.4, 0.7, 1] });
      PARTES.forEach(function (p) { io.observe(p.sec); });
    }

    /* ═══ [K7] ANTECEDENTES, TEXTOS, HORÁRIOS ═════════════════════════════════════════════ */
    /* as perguntas do questionário (uma caixinha por campo) viram botões de marcar */
    var q = $id('P40_ALERGIA') && $id('P40_ALERGIA').closest('.t-Region');
    if (q) {
      q.classList.add('nc-cm-questionario');
      var grade = el('div', 'nc-cm-perguntas'), corpoQ = q.querySelector('.t-Region-body');
      [].forEach.call(q.querySelectorAll('.apex-item-wrapper--checkbox'), function (c) { grade.appendChild(c); });
      if (corpoQ) corpoQ.appendChild(grade);
      var velho = corpoQ && corpoQ.querySelector(':scope > .container'); if (velho) velho.classList.add('nc-cm-guardada');
    }
    /* "Outras doenças" e "Uso de medicamentos": o campo de descrever aparece quando marcado
       (a ação dinâmica da página liga/desliga a região; vazio e desligado, some) */
    var descr = ['RG_DOENCAS', 'RG_USO_MED'].map($id).filter(Boolean);
    function verDescr() { descr.forEach(function (r) { var vazio = ![].some.call(r.querySelectorAll('textarea'), function (t) { return t.value.trim(); }); r.classList.toggle('nc-cm-recolhida', r.classList.contains('apex_disabled') && vazio); }); }
    if (window.MutationObserver) descr.forEach(function (r) { new MutationObserver(verDescr).observe(r, { attributes: true, attributeFilter: ['class'] }); });
    verDescr();
    /* textos: crescem com o que se escreve; "120 de 4000" embaixo */
    function crescer(t) { t.style.setProperty('--nc-cm-alt', 'auto'); var h = Math.min(Math.max(t.scrollHeight + 2, 96), Math.round(window.innerHeight * 0.6)); t.style.setProperty('--nc-cm-alt', h + 'px'); }
    [].forEach.call(app.querySelectorAll('textarea'), function (t) {
      t.classList.add('nc-cm-texto');
      var c = t.closest('.t-Form-fieldContainer');
      if (c && t.maxLength > 0 && !c.querySelector('.nc-cm-limite')) {
        var s = el('span', 'nc-cm-limite'); (c.querySelector('.t-Form-inputContainer') || c).appendChild(s);
        var f = function () { s.textContent = t.value.length + ' de ' + t.maxLength; s.setAttribute('data-perto', t.value.length > t.maxLength * 0.9 ? 'sim' : 'nao'); };
        f(); t.addEventListener('input', f);
      }
      crescer(t);
      t.addEventListener('input', function () { crescer(t); });
    });
    /* horários: "02 : 41" como um campo só; Saída com "Agora" */
    function grupoHora(par, rot, comAgora) {
      var ch = $id(par[0] + '_CONTAINER'), cm = $id(par[1] + '_CONTAINER'); if (!ch || !cm) return;
      var g = el('div', 'nc-cm-hora'); g.setAttribute('role', 'group'); g.setAttribute('aria-label', rot);
      ch.parentNode.insertBefore(g, ch); g.appendChild(ch); g.appendChild(el('span', 'nc-cm-dois', ':')); g.appendChild(cm);
      [par[0], par[1]].forEach(function (id, i) { var e = $id(id); if (e) { e.setAttribute('aria-label', rot + (i ? ', minutos' : ', hora')); e.setAttribute('inputmode', 'numeric'); e.placeholder = i ? 'mm' : 'hh'; } });
      if (comAgora) {
        var b = el('button', 'nc-cm-chip', ic('relogio') + 'Agora'); b.type = 'button';
        b.addEventListener('click', function () { agora(par); sujo(true); faltando(); });
        g.appendChild(b);
      }
    }
    function agora(par) { var n = new Date(); apex.item(par[0]).setValue(dois(n.getHours())); apex.item(par[1]).setValue(dois(n.getMinutes())); }
    grupoHora(ENTRADA, 'Entrada', false);
    /* 04/10: sem o "Agora" na saída — a ação "Disable Horarios" da página trava os quatro campos
       de hora (ninguém digita); quem preenche a saída é o processo "Set Values", no Finalizar */
    grupoHora(SAIDA, 'Saída', false);
    /* os dados da consulta numa grade de duas colunas, e os horários numa linha embaixo */
    var t1b = t1 && t1.querySelector('.t-Region-body');
    if (t1b) {
      var gd = el('div', 'nc-cm-grade');
      ['P40_COD_TIPO_CONSULTA', 'P40_DT_CONSULTA', 'P40_COD_PREST_SERV', 'P40_COD_ESPECIALIDADE', 'P40_COD_ENTIDADE'].forEach(function (id) { var c = $id(id + '_CONTAINER'); if (c) gd.appendChild(c); });
      var hs = el('div', 'nc-cm-horas');
      [].forEach.call(t1.querySelectorAll('.nc-cm-hora'), function (h) { hs.appendChild(h); });
      t1b.insertBefore(hs, t1b.firstChild); t1b.insertBefore(gd, t1b.firstChild);
      /* o que sobrou no grid antigo (algum campo novo) continua lá, embaixo */
    }

    /* ═══ [K8] O RODAPÉ: O QUE FALTA, FINALIZAR, SAIR SEM FINALIZAR ═══════════════════════
       CUIDADO  O Finalizar é o botão original (CREATE): a pergunta "Deseja finalizar…" e a
                gravação são as da página. Antes dele, sem a hora de saída, ela é preenchida
                com a hora de agora. Sair (Voltar, Dados do funcionário, ASO) com algo escrito
                numa consulta NOVA pede confirmação: nada fica gravado sem Finalizar.
       ════════════════════════════════════════════════════════════════════════════════════ */
    var SUJO = false, LIBERA = null;
    var meio = el('div', 'nc-cm-rodape-meio');
    var falta = el('p', 'nc-cm-falta'), estado = el('p', 'nc-cm-estado'); estado.setAttribute('aria-live', 'polite');
    meio.appendChild(falta); meio.appendChild(estado);
    var bFinal = [].filter.call(document.querySelectorAll('button.t-Button'), function (b) { return /^\s*finalizar consulta\s*$/i.test(b.textContent); })[0];
    var bSalvar = [].filter.call(document.querySelectorAll('button.t-Button'), function (b) { return /^\s*salvar\s*$/i.test(b.textContent) && b.offsetParent !== null; })[0];
    var pe = el('div', 'nc-cm-pe'), peEsq = el('div', 'nc-cm-pe-esq'), peDir = el('div', 'nc-cm-pe-dir');
    pe.appendChild(peEsq); pe.appendChild(meio); pe.appendChild(peDir);
    if (peDlg) {
      peDlg.classList.add('nc-cm-rodape');
      /* os botões ORIGINAIS da região do rodapé vão para o rodapé do desenho: os de sair à
         esquerda, Finalizar/Salvar à direita (mesmo id, mesmas ações) */
      [].forEach.call(peDlg.querySelectorAll('button.t-Button'), function (b) {
        b.classList.add('nc-cm-bt');
        (b === bFinal || b === bSalvar ? peDir : peEsq).appendChild(b);
      });
      var regBt = peDlg.querySelector('.t-ButtonRegion'); if (regBt) regBt.classList.add('nc-cm-guardada');
      peDlg.appendChild(pe);
    } else app.appendChild(pe);
    [bFinal, bSalvar].forEach(function (b) { if (!b) return; if (!peDir.contains(b)) peDir.appendChild(b); b.classList.add('nc-cm-bt', 'nc-cm-bt--primario'); b.insertAdjacentHTML('afterbegin', ic('finalizar')); });
    function faltando() {
      var f = [];
      if (!texto(SAIDA[0]) || !texto(SAIDA[1])) f.push('a hora de saída (preenchida com a de agora ao finalizar)');
      falta.textContent = f.length && NOVA ? 'Falta ' + f.join(' e ') : '';
    }
    function sujo(s) {
      SUJO = s;
      estado.innerHTML = s && NOVA ? '<span class="nc-cm-ponto" aria-hidden="true"></span>Consulta em andamento<span class="nc-cm-dica"> · grava ao finalizar</span>' : '';
    }
    /* 04/10: o Finalizar não escreve mais a saída antes: os campos de hora são travados pela página
       ("Disable Horarios") e o processo "Set Values" grava a hora de saída do servidor no submit */
    /* sair sem finalizar: a confirmação no rodapé (captura: chega antes das ações do botão) */
    var conf = el('div', 'nc-cm-conf'); conf.hidden = true; conf.setAttribute('role', 'alertdialog'); conf.setAttribute('aria-live', 'assertive');
    (peDlg || app).insertBefore(conf, (peDlg || app).firstChild);
    document.addEventListener('click', function (ev) {
      var b = ev.target.closest && ev.target.closest('button.t-Button, a.t-Button');
      if (!b || !SAI.test(b.textContent.trim()) || !NOVA || !SUJO) return;
      if (LIBERA === b) { LIBERA = null; return; }
      ev.preventDefault(); ev.stopImmediatePropagation();
      conf.innerHTML = '<p><b>Sair sem finalizar?</b> O que foi escrito nesta consulta será perdido.</p>' +
        '<button type="button" class="nc-cm-bt nc-cm-bt--perigo" data-c="sair">Sair mesmo assim</button><button type="button" class="nc-cm-bt" data-c="ficar">Continuar a consulta</button>';
      conf.hidden = false;
      conf.querySelector('[data-c="ficar"]').focus();
      conf.onclick = function (e2) {
        var c = e2.target.closest('[data-c]'); if (!c) return;
        conf.hidden = true;
        if (c.getAttribute('data-c') === 'sair') { LIBERA = b; b.click(); }
      };
    }, true);

    var toast = el('div', 'nc-cm-aviso'); toast.setAttribute('role', 'status'); toast.setAttribute('aria-live', 'polite'); document.body.appendChild(toast);
    var tAviso = null;
    function avisar(t) { toast.innerHTML = ic('check') + '<span>' + esc(t) + '</span>'; toast.classList.add('is-visivel'); clearTimeout(tAviso); tAviso = setTimeout(function () { toast.classList.remove('is-visivel'); }, 3200); }

    /* ═══ [K9] PRÉ-ATENDIMENTO (A TRAVA) ══════════════════════════════════════════════════
       Com o paciente no pré-atendimento, a ação "Disable Tabs" desliga TAB1…TAB10 até o
       "Iniciar Atendimento" (o botão ORIGINAL vai para o aviso, grande). O aviso some junto
       com a trava.
       ════════════════════════════════════════════════════════════════════════════════════ */
    var aviso = el('div', 'nc-cm-trava'); aviso.hidden = true; aviso.setAttribute('role', 'status');
    aviso.innerHTML = ic('relogio') + '<div class="nc-cm-trava-txt"><p><b>Paciente no pré-atendimento.</b></p><p>Inicie o atendimento para liberar a ficha.</p></div>';
    var bIniciar = [].filter.call(document.querySelectorAll('button.t-Button'), function (b) { return /iniciar\s+atendimento/i.test(b.textContent); })[0];
    if (bIniciar) { bIniciar.classList.add('nc-cm-bt', 'nc-cm-bt--primario'); bIniciar.insertAdjacentHTML('afterbegin', ic('play')); aviso.appendChild(bIniciar); }
    app.insertBefore(aviso, ficha);
    var travas = ['TAB1', 'TAB2', 'TAB3', 'TAB6'].map($id).filter(Boolean);
    function verTrava() { var t = travas.some(function (r) { return r.classList.contains('apex_disabled'); }); aviso.hidden = !t; document.body.classList.toggle('nc-cm-travada', t); }
    if (window.MutationObserver) travas.forEach(function (r) { new MutationObserver(verTrava).observe(r, { attributes: true, attributeFilter: ['class'] }); });
    verTrava();

    /* ═══ [K10] O MAESTRO ═════════════════════════════════════════════════════════════════
       CUIDADO  Roda depois das ações "ready" (idade, trava, tipo de exame). O que o médico
                escreve (isTrusted) deixa a consulta "em andamento"; o resto só redesenha.
       ════════════════════════════════════════════════════════════════════════════════════ */
    desenharPaciente(); lugares();
    if (estreito && estreito.addEventListener) estreito.addEventListener('change', lugares);
    var tudo = function () { estados(); faltando(); verDescr(); };
    tudo(); sujo(false);
    app.addEventListener('input', function (ev) { if (ev.isTrusted) sujo(true); });
    app.addEventListener('change', function (ev) { if (ev.isTrusted) sujo(true); setTimeout(tudo, 0); });
    app.addEventListener('focusout', function () { setTimeout(tudo, 0); });
    $(document).on('apexafterrefresh', function () { setTimeout(tudo, 0); });
    $(document).one('ajaxStop', function () { desenharPaciente(); tudo(); });
    /* voltou do servidor com erro (validação): vai direto para a primeira parte com erro */
    setTimeout(function () {
      var p = PARTES.filter(function (x) { return x.reg.querySelector('.is-error, .a-Form-error:not(:empty)'); })[0];
      if (p) p.sec.scrollIntoView({ block: 'start' });
    }, 300);
  }

  $(window).on('apexreadyend', function () { setTimeout(iniciar, 0); });
  if (document.readyState === 'complete') setTimeout(iniciar, 300);
  else window.addEventListener('load', function () { setTimeout(iniciar, 300); });
})();
