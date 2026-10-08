/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · QUESTIONÁRIO DO TREINAMENTO  —  o "arrumador" da tela (JavaScript)            ║
   ║  App 9104 (Treinamento - Processos) · Página 2 ("Respostas de Questionário")              ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: QUESTTREINAMENTO-MANUTENCAO.md.

   ── PARA QUEM ─────────────────────────────────────────────────────────────────────────────
   O colaborador que acabou de fazer um treinamento e responde a avaliação dele (70% no
   celular, 90% com pouca instrução escolar) e quem opera a página para outras pessoas.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
     • OS PARÂMETROS PRIMEIRO, COMO SEMPRE (pedido de 04/10): os 5 campos ORIGINAIS da página
       — empresa, curso, turma, matrícula, questionário — todos à vista, com a roupa nova
       (rótulos em letra normal, campos grandes; uma coluna no celular, duas no computador) e
       o botão Começar (o Pesquisar original). Faltou algum: diz qual, ali mesmo;
     • DEPOIS, AS PERGUNTAS UMA POR TELA: "Pergunta 3 de 14", a pergunta grande, as respostas
       em botões grandes (Ótimo/Bom/Regular com carinhas; Sim/Não com sinal); um toque GRAVA e
       passa para a próxima. Pergunta escrita: caixa de texto (dá para usar o microfone do
       teclado). "Qual?" logo depois de um Sim/Não aparece junto, só se a resposta for Sim;
     • OUVIR: lê a pergunta e as respostas em voz alta (voz do próprio celular);
     • FIM: "Obrigado!" com a lista de todas as respostas para conferir e mudar. "Trocar"
       (o Filtrar original) volta aos parâmetros.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Os campos são os ORIGINAIS (a região é só MUDADA DE LUGAR, para dentro do cartão novo):
     listas em cascata, janelas de busca e ações da página funcionam como sempre. As perguntas
     são lidas e gravadas pelos processos NC_QUEST_PERGUNTAS e NC_QUEST_SALVAR (Ajax Callback
     da página 2, mesma regra da janela 3). Sem eles, a lista original volta, com a janela de
     sempre.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 2 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_QuestTreinamento.js
     Página 2 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_QuestTreinamento.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [Q1]  Ferramentas
     [Q2]  Os textos (rótulos dos campos, mensagens)                   PODE MEXER
     [Q3]  Ler a página (itens, botões, regiões)                       CUIDADO
     [Q4]  Os parâmetros (os campos originais, com roupa nova)         CUIDADO
     [Q5]  Começar: o Pesquisar original e a leitura das perguntas
     [Q6]  Uma pergunta por tela
     [Q7]  Gravar uma resposta
     [Q8]  Ouvir a pergunta
     [Q9]  O fim (obrigado + conferir)
     [Q10] O maestro
*/
(function () {
  'use strict';
  if (window.__ncQuestTreinamento || !window.apex || !window.apex.jQuery) return;
  var $ = window.apex.jQuery;

  /* ═══ [Q1] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function sem(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase().trim(); }
  function $id(id) { return document.getElementById(id); }
  function valor(id) { try { return apex.item(id).getValue() || ''; } catch (e) { return ''; } }
  /* "00001 - Atendimento Ao Cliente" → "Atendimento ao Cliente" (o código sai da frente; as
     palavrinhas voltam a minúsculas; "NATCORP DO BRASIL" → "Natcorp do Brasil") */
  var MIUDAS = /^(a|o|as|os|ao|aos|de|da|do|das|dos|e|em|na|no|nas|nos|para|com|por|pela|pelo|sem|sob|um|uma)$/i;
  function nome(t) {
    t = String(t || '').replace(/^\s*\d+\s*-\s*/, '').trim();
    if (!/[a-zà-ú]/.test(t)) t = t.toLowerCase().replace(/(^|\s)(\S)/g, function (m, a, c) { return a + c.toUpperCase(); });
    return t.split(/(\s+)/).map(function (w, i) { return i > 0 && MIUDAS.test(w) ? w.toLowerCase() : w; }).join('');
  }
  /* a turma: "TURMA 000001 13/12/2022 - 31/12/2022 | Em Andamento" → "13/12/2022 a 31/12/2022" */
  function turma(t) {
    var m = /turma\s+0*(\d+)\s+(\S+)\s*-\s*(\S+)\s*\|?\s*(.*)$/i.exec(t || '');
    return m ? { titulo: m[2] === m[3] ? m[2] : m[2] + ' a ' + m[3], sub: 'Turma ' + m[1], selo: nome(m[4]) } : { titulo: nome(t), sub: '', selo: '' };
  }
  function codigo(t) { var m = /^\s*(\d+)\s*-/.exec(t || ''); return m ? String(+m[1]) : ''; }
  var IC = {
    voltar: '<path d="M14.5 5.5L8 12l6.5 6.5"/>',
    avancar: '<path d="M9.5 5.5L16 12l-6.5 6.5"/>',
    som: '<path d="M4.5 9.5h3.2L12 5.8v12.4l-4.3-3.7H4.5z"/><path d="M15.5 9a4 4 0 0 1 0 6M18 6.5a7.5 7.5 0 0 1 0 11"/>',
    parar: '<rect x="6.5" y="6.5" width="11" height="11" rx="2"/>',
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>',
    x: '<path d="M7 7l10 10M17 7L7 17"/>',
    lista: '<path d="M9 7h10.5M9 12h10.5M9 17h10.5"/><circle cx="5" cy="7" r="1.2"/><circle cx="5" cy="12" r="1.2"/><circle cx="5" cy="17" r="1.2"/>',
    lupa: '<circle cx="11" cy="11" r="6"/><path d="M15.5 15.5L20 20"/>',
    mic: '<rect x="9" y="3.5" width="6" height="11" rx="3"/><path d="M5.5 11.5a6.5 6.5 0 0 0 13 0M12 18v2.5"/>',
    trocar: '<path d="M4.5 8.5h13l-3.5-3.5M19.5 15.5h-13l3.5 3.5"/>',
    curso: '<path d="M3 9.5L12 5l9 4.5-9 4.5z"/><path d="M7 11.7v4.3c1.3 1.3 3 2 5 2s3.7-.7 5-2v-4.3"/>',
    predio: '<path d="M5 20.5V5.5a1 1 0 0 1 1-1h8a1 1 0 0 1 1 1v15M15 9.5h3a1 1 0 0 1 1 1v10M3.5 20.5h17M8.5 8.5h3M8.5 12h3M8.5 15.5h3"/>',
    calendario: '<rect x="4" y="5.5" width="16" height="14.5" rx="2"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4"/>',
    pessoa: '<circle cx="12" cy="8.5" r="3.7"/><path d="M5 20c.9-3.6 3.6-5.6 7-5.6s6.1 2 7 5.6"/>',
    prancheta: '<rect x="5" y="4.5" width="14" height="16" rx="2.2"/><path d="M9 3.5h6v2.5H9zM9 11h6M9 14.5h6M9 18h3.5"/>',
    festa: '<path d="M4 20l4.5-12.5 8 8z"/><path d="M14 4.5c.5 1.5 0 2.5-1 3M18 8c1.4-.6 2.6-.2 3 .8M17.5 3.5l.5 1.5M20.5 12.5l1.5.5"/>'
  };
  function ic(n, cls) { return '<svg class="nc-tq-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  /* carinhas da escala (Ótimo / Bom / Regular / Ruim / Péssimo): a boca muda; o resto é igual */
  var BOCAS = {
    otimo: '<path d="M7.5 13.2c1 2.6 2.6 3.9 4.5 3.9s3.5-1.3 4.5-3.9z" class="nc-tq-cheio"/>',
    bom: '<path d="M8 14c1 1.6 2.4 2.4 4 2.4s3-.8 4-2.4"/>',
    regular: '<path d="M8.3 15.2h7.4"/>',
    ruim: '<path d="M8 16.6c1-1.5 2.4-2.2 4-2.2s3 .7 4 2.2"/>',
    pessimo: '<path d="M7.8 17.3c1-2.3 2.5-3.4 4.2-3.4s3.2 1.1 4.2 3.4"/><path d="M7.5 8.4l2 1M16.5 8.4l-2 1"/>'
  };
  function carinha(tom) {
    return '<svg class="nc-tq-cara" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><circle cx="12" cy="12" r="9"/>' +
      '<circle cx="9" cy="10.2" r="1.1" class="nc-tq-olho"/><circle cx="15" cy="10.2" r="1.1" class="nc-tq-olho"/>' + BOCAS[tom] + '</svg>';
  }
  /* a escala de cada resposta (só ganha carinha se TODAS as respostas da pergunta forem da escala) */
  var ESCALA = [['otimo', /^(otimo|otima|excelente|muito bom|muito boa|muito satisfeito)/], ['bom', /^(bom|boa|satisfeito)/],
    ['regular', /^(regular|razoavel|medio|media|neutro)/], ['ruim', /^(ruim|insatisfeito)/], ['pessimo', /^(pessimo|pessima|muito ruim|muito insatisfeito)/]];
  function tomDe(d) { var s = sem(d); for (var k = 0; k < ESCALA.length; k++) if (ESCALA[k][1].test(s)) return ESCALA[k][0]; return ''; }
  function ehSim(d) { return /^sim\b/.test(sem(d)); }
  function ehNao(d) { return /^nao\b/.test(sem(d)); }

  /* ═══ [Q2] OS TEXTOS ═════════════════════════════════════════════════════════════════════
     PODE MEXER  os rótulos dos campos (ROTULOS — o mesmo nome do original, em letra normal) e
                 as mensagens (MSG). Frases curtas, sem sigla: quem lê aqui lê pouco.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ROTULOS = { P2_EMPRESA: 'Empresa', P2_CURSO: 'Curso', P2_TURMA: 'Turma', P2_MATRICULA: 'Matrícula', P2_QUESTIONARIO: 'Questionário', P2_DT_RESPOSTA: 'Data da resposta' };
  var MSG = {
    titulo: 'Avaliação do treinamento',
    formTit: 'Escolha o treinamento',
    formDica: 'Preencha os campos e toque em Começar.',
    falta: function (l) { return 'Falta escolher: ' + l.join(', ') + '.'; },
    comecar: 'Começar',
    carregando: 'Carregando…',
    salvo: 'Resposta guardada',
    erroSalvar: 'Não conseguimos guardar a resposta. Confira a internet e toque de novo.',
    escrita: 'Escreva com as suas palavras.',
    mic: 'Se preferir, toque no microfone do teclado e fale.',
    naoParticipa: 'Não encontramos esta matrícula nesta turma. Toque em Trocar e confira os campos.',
    obrigado: 'Obrigado!',
    tudo: 'Você respondeu todas as perguntas.',
    faltam: function (n) { return n === 1 ? 'Falta 1 pergunta.' : 'Faltam ' + n + ' perguntas.'; }
  };

  /* ═══ [Q3] LER A PÁGINA ══════════════════════════════════════════════════════════════════
     CUIDADO  Os botões são achados pelo TÍTULO (Pesquisar, Filtrar, Voltar), não pelo id: os
              ids mudam de uma base para outra. A lista de perguntas é a região "Perguntas do
              questionário" (lista do jQuery Mobile, com o link da janela 3 em cada linha).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function botao(rx) { return [].filter.call(document.querySelectorAll('button[id^="B"]'), function (b) { return rx.test(sem(b.title || b.getAttribute('aria-label') || b.textContent)); })[0] || null; }
  function regiaoLista() { return [].filter.call(document.querySelectorAll('.t-Region'), function (r) { var t = r.querySelector('.t-Region-title'); return t && /^perguntas do questionario/.test(sem(t.textContent)); })[0] || null; }
  function opcoes(id) {
    var s = $id(id); if (!s || !s.options) return [];
    return [].filter.call(s.options, function (o) { return o.value !== ''; }).map(function (o) { return { v: o.value, t: o.text }; });
  }
  function textoDe(id) {
    var s = $id(id);
    if (s && s.options) { var o = s.options[s.selectedIndex]; return o && o.value ? o.text : ''; }
    var d = $id(id + '_DISPLAY') || (s && s.parentNode.querySelector('input[type=text]'));
    return d ? d.value : valor(id);
  }

  /* ═══ [Q4] OS PARÂMETROS ═════════════════════════════════════════════════════════════════
     A região dos campos ("Parâmetros") é MUDADA para dentro do cartão novo — os itens, as
     listas em cascata, as janelas de busca e as ações da página continuam os mesmos. Os
     rótulos ganham letra normal (ROTULOS). Começar confere o que falta antes do Pesquisar.
     CUIDADO  Nada de innerHTML no cartão do formulário (levaria os campos junto): as telas
              das perguntas são desenhadas em TELA, ao lado. E o cartão entra na página ANTES
              de mexer nos rótulos e ligar os avisos (fora dela, getElementById não acha).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FORM, TELA, ITENS = ['P2_EMPRESA', 'P2_CURSO', 'P2_TURMA', 'P2_MATRICULA', 'P2_QUESTIONARIO'];
  function montarFormulario() {
    var item = $id('P2_EMPRESA');
    var reg = item.closest('.t-Form--stretchInputs') || item.closest('[id^="R"]');
    FORM = el('section', 'nc-tq-form');
    FORM.setAttribute('aria-labelledby', 'nc-tq-form-tit');
    FORM.innerHTML = '<h2 id="nc-tq-form-tit" class="nc-tq-pergunta nc-tq-form-tit" tabindex="-1">' + esc(MSG.formTit) + '</h2>' +
      '<p class="nc-tq-ajuda">' + esc(MSG.formDica) + '</p>';
    FORM.appendChild(reg);
    APP.appendChild(FORM);   /* já na página: os ids abaixo só são achados com o cartão dentro dela */
    FORM.insertAdjacentHTML('beforeend', '<p class="nc-tq-status is-erro" data-form-erro role="alert"></p>' +
      '<button type="button" class="nc-tq-bt nc-tq-bt--largo" data-comecar>' + esc(MSG.comecar) + ic('avancar') + '</button>');
    Object.keys(ROTULOS).forEach(function (id) {
      var l = $id(id + '_LABEL'); if (!l) return;
      var vh = l.querySelector('.u-VisuallyHidden');
      l.textContent = ROTULOS[id]; if (vh) l.appendChild(vh);
    });
    /* escolheu: a marca de "falta" daquele campo sai */
    ITENS.forEach(function (id) {
      $('#' + id).on('change', function () {
        var c = $id(id + '_CONTAINER'); if (c && valor(id)) c.classList.remove('nc-tq-falta');
        /* a frase acompanha: lista só o que ainda falta (ou some) */
        var e = FORM.querySelector('[data-form-erro]'); if (!e || !e.textContent) return;
        var falta = ITENS.filter(function (x) { return !valor(x); });
        e.textContent = falta.length ? MSG.falta(falta.map(function (x) { return ROTULOS[x].toLowerCase(); })) : '';
      });
    });
  }
  function conferir() {
    var falta = ITENS.filter(function (id) { return !valor(id); });
    ITENS.forEach(function (id) { var c = $id(id + '_CONTAINER'); if (c) c.classList.toggle('nc-tq-falta', falta.indexOf(id) >= 0); });
    var e = FORM.querySelector('[data-form-erro]');
    e.textContent = falta.length ? MSG.falta(falta.map(function (id) { return ROTULOS[id].toLowerCase(); })) : '';
    if (falta.length) { var x = $id(falta[0]); if (x) x.focus(); }
    return !falta.length;
  }
  function mostrarFormulario() {
    PARANDO();
    document.body.classList.remove('nc-tq-lista-original');
    PERG = [];
    TELA.innerHTML = cabecalho(MSG.titulo, '');
    FORM.hidden = false;
    window.scrollTo(0, 0);
  }

  /* ═══ [Q5] COMEÇAR ═══════════════════════════════════════════════════════════════════════
     O Pesquisar ORIGINAL valida e recarrega a lista (e trava os campos, como sempre). Depois,
     as perguntas vêm do processo NC_QUEST_PERGUNTAS; se ele não existir, a lista original
     volta à vista (com a janela de cada pergunta).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PERG = [], I = 0;
  function comecar() {
    if (!conferir()) return;
    FORM.hidden = true;
    TELA.innerHTML = cabecalho(MSG.titulo, '') + resumoFixo() + '<p class="nc-tq-carregando" role="status">' + esc(MSG.carregando) + '</p>';
    var bt = botao(/^pesquisar$/);
    if (bt && getComputedStyle(bt).display !== 'none') bt.click();
    apex.server.process('NC_QUEST_PERGUNTAS', { pageItems: ITENS.map(function (x) { return '#' + x; }) }, { dataType: 'json' })
      .done(function (r) {
        if (r && r.erro === 'participante') { TELA.innerHTML = cabecalho(MSG.titulo, '') + resumoFixo() + '<p class="nc-tq-aviso">' + esc(MSG.naoParticipa) + '</p>'; return; }
        if (!r || !r.perguntas) { semProcesso(); return; }
        PERG = montarPerguntas(r.perguntas);
        if (!PERG.length) { TELA.innerHTML = cabecalho(MSG.titulo, '') + resumoFixo() + '<p class="nc-tq-aviso">Este questionário ainda não tem perguntas.</p>'; return; }
        var falta = PERG.filter(function (q) { return !respondida(q); })[0];
        if (falta) { I = PERG.indexOf(falta); desenharPergunta(); } else desenharFim(true);
      })
      .fail(semProcesso);
  }
  function semProcesso() {
    document.body.classList.add('nc-tq-lista-original');
    TELA.innerHTML = cabecalho(MSG.titulo, '') + resumoFixo() + '<p class="nc-tq-ajuda nc-tq-ajuda--lista">Toque numa pergunta para responder.</p>';
  }
  /* "Qual?" logo depois de um Sim/Não vira parte da pergunta anterior (só aparece se for Sim) */
  function montarPerguntas(lista) {
    var out = [];
    lista.forEach(function (q) {
      var p = { cod: String(q.cod), texto: frase(q.texto), tipo: q.tipo === 'D' ? 'D' : 'M', alt: q.alt != null ? String(q.alt) : '', dis: q.dis || '',
        opcoes: (q.opcoes || []).map(function (o) { return { c: String(o.c), d: frase(o.d) }; }) };
      var ant = out[out.length - 1];
      if (p.tipo === 'D' && ant && ant.tipo === 'M' && !ant.extra && ant.opcoes.some(function (o) { return ehSim(o.d); }) && p.texto.length <= 30) { ant.extra = p; return; }
      out.push(p);
    });
    out.forEach(function (p) {
      var toms = p.opcoes.map(function (o) { return tomDe(o.d); });
      p.caras = p.opcoes.length > 1 && toms.every(Boolean);
      p.simnao = p.opcoes.length === 2 && p.opcoes.some(function (o) { return ehSim(o.d); }) && p.opcoes.some(function (o) { return ehNao(o.d); });
    });
    return out;
  }
  function frase(t) { t = String(t || '').replace(/^\s*\d+\s*-\s*/, '').trim(); return /[a-zà-ú]/.test(t) ? t.charAt(0).toUpperCase() + t.slice(1) : t.charAt(0) + t.slice(1).toLowerCase(); }
  function respondida(q) { return q.tipo === 'D' ? !!q.dis.trim() : !!q.alt; }
  function escolhida(q) { return q.opcoes.filter(function (o) { return o.c === q.alt; })[0] || null; }
  function resumoFixo() {
    var c = nome(textoDe('P2_CURSO')), t = turma(textoDe('P2_TURMA')), pes = nome(textoDe('P2_MATRICULA'));
    if (!c) return '';
    return '<div class="nc-tq-cartao">' + ic('curso') + '<div><b>' + esc(c) + '</b><small>' + esc([t.titulo, pes].filter(Boolean).join(' · ')) + '</small></div>' +
      '<button type="button" class="nc-tq-link" data-trocar>' + ic('trocar') + 'Trocar</button></div>';
  }

  /* ═══ [Q6] UMA PERGUNTA POR TELA ═════════════════════════════════════════════════════════ */
  function feitas() { return PERG.filter(respondida).length; }
  function desenharPergunta() {
    PARANDO();
    var q = PERG[I], n = PERG.length;
    var barra = '<div class="nc-tq-progresso"><div class="nc-tq-progresso-txt"><b>Pergunta ' + (I + 1) + ' de ' + n + '</b>' +
      '<button type="button" class="nc-tq-link" data-todas>' + ic('lista') + 'Ver todas</button></div>' +
      '<div class="nc-tq-trilho" role="progressbar" aria-label="Perguntas respondidas" aria-valuemin="0" aria-valuemax="' + n + '" aria-valuenow="' + feitas() + '">' +
      PERG.map(function (x, k) { return '<i class="' + (respondida(x) ? 'is-feita' : '') + (k === I ? ' is-atual' : '') + '"></i>'; }).join('') + '</div></div>';
    var corpo = q.tipo === 'D' ? escrita(q, '') : alternativas(q);
    var extra = q.extra && q.alt && !ehNao((escolhida(q) || {}).d || '') ? '<div class="nc-tq-extra">' + escrita(q.extra, 'extra') + '</div>' : '';
    TELA.innerHTML = cabecalho(MSG.titulo, '') + barra +
      '<section class="nc-tq-passo nc-tq-q" aria-labelledby="nc-tq-perg">' +
        '<div class="nc-tq-q-cab"><h2 id="nc-tq-perg" class="nc-tq-pergunta" tabindex="-1">' + esc(q.texto) + '</h2>' + botaoOuvir() + '</div>' +
        corpo + extra + '<p class="nc-tq-status" role="status" aria-live="polite"></p>' +
      '</section>' +
      '<nav class="nc-tq-nav" aria-label="Navegar entre as perguntas">' +
        '<button type="button" class="nc-tq-bt nc-tq-bt--sec" data-ir="-1"' + (I === 0 ? ' disabled' : '') + '>' + ic('voltar') + 'Anterior</button>' +
        '<button type="button" class="nc-tq-bt" data-ir="1">' + (I === n - 1 ? 'Terminar' : 'Próxima') + ic('avancar') + '</button>' +
      '</nav>';
    focar();
  }
  function alternativas(q) {
    return '<div class="nc-tq-opcoes' + (q.caras ? ' nc-tq-opcoes--caras' : '') + '" role="radiogroup" aria-labelledby="nc-tq-perg">' + q.opcoes.map(function (o, k) {
      var on = q.alt === o.c, tom = q.caras ? tomDe(o.d) : '';
      var sinal = q.simnao ? '<span class="nc-tq-sinal" data-sinal="' + (ehSim(o.d) ? 'sim' : 'nao') + '" aria-hidden="true">' + ic(ehSim(o.d) ? 'check' : 'x') + '</span>' : '';
      return '<button type="button" class="nc-tq-op" role="radio" aria-checked="' + on + '" data-resp="' + esc(o.c) + '"' + (tom ? ' data-tom="' + tom + '"' : '') + '>' +
        (tom ? carinha(tom) : sinal) + '<span class="nc-tq-op-txt"><b>' + esc(o.d) + '</b></span>' +
        '<span class="nc-tq-marca" aria-hidden="true">' + ic('check') + '</span></button>';
    }).join('') + '</div>';
  }
  function escrita(q, papel) {
    var id = 'nc-tq-texto' + (papel ? '-' + papel : '');
    return (papel ? '<label class="nc-tq-pergunta nc-tq-pergunta--extra" for="' + id + '">' + esc(q.texto) + '</label>' : '<label class="u-VisuallyHidden" for="' + id + '">' + esc(q.texto) + '</label>') +
      '<p class="nc-tq-ajuda">' + esc(MSG.escrita) + ' <span class="nc-tq-mic">' + ic('mic') + esc(MSG.mic) + '</span></p>' +
      '<textarea id="' + id + '" class="nc-tq-texto" rows="4" maxlength="1000" data-escrita="' + esc(q.cod) + '">' + esc(q.dis) + '</textarea>';
  }
  function ir(passo) {
    var t = APP.querySelector('textarea[data-escrita]');
    var segue = function () {
      if (passo > 0 && I === PERG.length - 1) { desenharFim(false); return; }
      I = Math.max(0, Math.min(PERG.length - 1, I + passo)); desenharPergunta();
    };
    var pend = [].map.call(APP.querySelectorAll('textarea[data-escrita]'), function (x) { return x; }).filter(function (x) { var q = acharQ(x.getAttribute('data-escrita')); return q && x.value.trim() !== q.dis.trim(); });
    if (!pend.length || !t) { segue(); return; }
    salvarTextos(pend).then(segue, function () { /* a mensagem de erro já está na tela */ });
  }
  function acharQ(cod) { for (var k = 0; k < PERG.length; k++) { if (PERG[k].cod === cod) return PERG[k]; if (PERG[k].extra && PERG[k].extra.cod === cod) return PERG[k].extra; } return null; }

  /* ═══ [Q7] GRAVAR UMA RESPOSTA ═══════════════════════════════════════════════════════════
     NC_QUEST_SALVAR: x01 = pergunta, x02 = resposta (alternativa), x03 = texto (escrita).
     A nota da resposta e a data saem no servidor (mesma regra da janela 3).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var OCUPADO = false;
  function salvar(q, alt, dis) {
    return new Promise(function (ok, falha) {
      apex.server.process('NC_QUEST_SALVAR', { x01: q.cod, x02: alt || '', x03: dis || '', pageItems: ITENS.map(function (x) { return '#' + x; }) }, { dataType: 'json' })
        .done(function (r) {
          if (!r || r.ok === false) { falha(r && r.erro); return; }
          q.alt = alt || ''; q.dis = dis || '';
          if (r.data) { try { apex.item('P2_DT_RESPOSTA').setValue(r.data, null, true); } catch (e) { /* ok */ } }
          ok(r);
        }).fail(function () { falha(); });
    });
  }
  function status(t, erro) { var s = APP.querySelector('.nc-tq-status'); if (s) { s.textContent = t; s.classList.toggle('is-erro', !!erro); } }
  function responder(b) {
    if (OCUPADO) return;
    var q = PERG[I], c = b.getAttribute('data-resp'), anterior = q.alt;
    [].forEach.call(APP.querySelectorAll('[data-resp]'), function (x) { x.setAttribute('aria-checked', String(x === b)); });
    OCUPADO = true; b.classList.add('is-gravando');
    salvar(q, c, '').then(function () {
      OCUPADO = false; b.classList.remove('is-gravando'); status(MSG.salvo);
      var o = escolhida(q);
      /* com "Qual?" ligado e resposta Sim: abre a caixa ali mesmo, sem pular */
      if (q.extra && o && !ehNao(o.d)) { desenharPergunta(); var t = APP.querySelector('textarea[data-escrita]'); if (t) t.focus(); return; }
      setTimeout(function () { if (PERG[I] === q) ir(1); }, 420);
    }, function () {
      OCUPADO = false; b.classList.remove('is-gravando'); q.alt = anterior;
      [].forEach.call(APP.querySelectorAll('[data-resp]'), function (x) { x.setAttribute('aria-checked', String(x.getAttribute('data-resp') === anterior)); });
      status(MSG.erroSalvar, true);
    });
  }
  function salvarTextos(campos) {
    status('Guardando…');
    return campos.reduce(function (p, x) {
      return p.then(function () { var q = acharQ(x.getAttribute('data-escrita')); return salvar(q, '', x.value.trim()); });
    }, Promise.resolve()).then(function () { status(MSG.salvo); }, function (e) { status(MSG.erroSalvar, true); throw e; });
  }

  /* ═══ [Q8] OUVIR A PERGUNTA ══════════════════════════════════════════════════════════════
     A voz do próprio celular (speechSynthesis, em português). Sem voz no aparelho, o botão
     não aparece.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FALA = window.speechSynthesis || null;
  function botaoOuvir() { return FALA ? '<button type="button" class="nc-tq-ouvir" data-ouvir aria-pressed="false">' + ic('som') + '<span>Ouvir</span></button>' : ''; }
  function PARANDO() { if (FALA && FALA.speaking) FALA.cancel(); }
  function ouvir(b) {
    if (!FALA) return;
    if (FALA.speaking) { FALA.cancel(); return; }
    var q = PERG[I]; if (!q) return;
    var txt = q.texto + '. ' + (q.tipo === 'D' ? 'Escreva a sua resposta.' : 'Responda: ' + q.opcoes.map(function (o) { return o.d; }).join(', ou ') + '.');
    var u = new SpeechSynthesisUtterance(txt);
    u.lang = 'pt-BR'; u.rate = 0.92;
    var voz = FALA.getVoices().filter(function (v) { return /^pt(-|_)?br/i.test(v.lang); })[0]; if (voz) u.voice = voz;
    var marca = function (on) { b.setAttribute('aria-pressed', String(on)); b.querySelector('span').textContent = on ? 'Parar' : 'Ouvir'; };
    u.onend = u.onerror = function () { marca(false); };
    marca(true); FALA.speak(u);
  }

  /* ═══ [Q9] O FIM ═════════════════════════════════════════════════════════════════════════ */
  function desenharFim(jaEstava) {
    PARANDO();
    var falta = PERG.length - feitas();
    var dt = valor('P2_DT_RESPOSTA');
    TELA.innerHTML = cabecalho(MSG.titulo, '') + resumoFixo() +
      '<section class="nc-tq-fim" aria-labelledby="nc-tq-perg">' +
        '<span class="nc-tq-fim-ic" aria-hidden="true">' + ic(falta ? 'prancheta' : 'festa') + '</span>' +
        '<h2 id="nc-tq-perg" class="nc-tq-pergunta" tabindex="-1">' + (falta ? 'Quase lá' : MSG.obrigado) + '</h2>' +
        '<p class="nc-tq-fim-txt">' + esc(falta ? MSG.faltam(falta) : MSG.tudo) + (jaEstava && dt && !falta ? ' Última resposta em ' + esc(dt) + '.' : '') + '</p>' +
        (falta ? '<button type="button" class="nc-tq-bt nc-tq-bt--largo" data-falta>Responder o que falta' + ic('avancar') + '</button>' : '') +
        '<button type="button" class="nc-tq-bt ' + (falta ? 'nc-tq-bt--sec ' : '') + 'nc-tq-bt--largo" data-sair>' + ic('voltar') + 'Sair</button>' +
      '</section>' + listaTodas();
    focar();
  }
  function listaTodas() {
    return '<section class="nc-tq-todas" aria-labelledby="nc-tq-todas-tit"><h3 id="nc-tq-todas-tit">Suas respostas</h3><p class="nc-tq-ajuda">Toque numa pergunta para mudar a resposta.</p><ol>' +
      PERG.map(function (q, k) {
        var o = escolhida(q), r = q.tipo === 'D' ? q.dis : o ? o.d : '';
        var ex = q.extra && q.extra.dis ? ' — ' + q.extra.dis : '';
        return '<li><button type="button" data-vai="' + k + '"' + (respondida(q) ? '' : ' class="is-falta"') + '><span class="nc-tq-n">' + (k + 1) + '</span>' +
          '<span class="nc-tq-todas-txt"><b>' + esc(q.texto) + '</b><small>' + (r ? esc(r + ex) : 'Sem resposta') + '</small></span>' + ic('avancar', 'nc-tq-seta') + '</button></li>';
      }).join('') + '</ol></section>';
  }

  /* ═══ [Q10] O MAESTRO ════════════════════════════════════════════════════════════════════ */
  function cabecalho(t, sub) {
    return '<header class="nc-tq-topo"><button type="button" class="nc-tq-sair" data-sair aria-label="Sair">' + ic('voltar') + '</button>' +
      '<div><h1>' + esc(t) + '</h1>' + (sub ? '<p>' + esc(sub) + '</p>' : '') + '</div></header>';
  }
  /* a tela nova começa do alto, e o leitor de tela lê a pergunta */
  function focar() { var h = TELA.querySelector('#nc-tq-perg'); if (h) h.focus({ preventScroll: true }); window.scrollTo(0, 0); }
  function aoClicar(ev) {
    var t = ev.target.closest('button'); if (!t || !APP.contains(t)) return;
    if (t.hasAttribute('data-comecar')) { comecar(); return; }
    if (t.hasAttribute('data-resp')) { responder(t); return; }
    if (t.hasAttribute('data-ir')) { ir(+t.getAttribute('data-ir')); return; }
    if (t.hasAttribute('data-ouvir')) { ouvir(t); return; }
    if (t.hasAttribute('data-todas')) { ir0(function () { desenharFim(false); }); return; }
    if (t.hasAttribute('data-vai')) { I = +t.getAttribute('data-vai'); desenharPergunta(); return; }
    if (t.hasAttribute('data-falta')) { var f = PERG.filter(function (q) { return !respondida(q); })[0]; if (f) { I = PERG.indexOf(f); desenharPergunta(); } return; }
    if (t.hasAttribute('data-trocar')) { trocar(); return; }
    if (t.hasAttribute('data-sair')) { var v = botao(/^voltar$/); if (v) v.click(); return; }
  }
  /* ir para outra tela guardando antes o texto escrito */
  function ir0(depois) {
    var pend = [].filter.call(TELA.querySelectorAll('textarea[data-escrita]'), function (x) { var q = acharQ(x.getAttribute('data-escrita')); return q && x.value.trim() !== q.dis.trim(); });
    if (!pend.length) { depois(); return; }
    salvarTextos(pend).then(depois, function () {});
  }
  /* Trocar = o Filtrar original (destrava os campos e limpa o questionário) e volta aos parâmetros */
  function trocar() {
    var f = botao(/^filtrar$/);
    if (f && getComputedStyle(f).display !== 'none') f.click();
    mostrarFormulario();
    var q = $id('P2_QUESTIONARIO'); if (q) q.focus({ preventScroll: true });
  }
  function iniciar() {
    if (!$id('P2_QUESTIONARIO') || !$id('P2_MATRICULA') || !regiaoLista()) return;
    window.__ncQuestTreinamento = true;
    document.body.classList.add('nc-tq-ativo');
    regiaoLista().classList.add('nc-tq-lista');
    APP = el('div', 'nc-tq');
    APP.setAttribute('role', 'main');
    TELA = el('div', 'nc-tq-tela');
    APP.appendChild(TELA);
    var antes = document.querySelector('.t-Body-contentInner') || document.body;
    antes.insertBefore(APP, antes.firstChild);
    montarFormulario();
    APP.addEventListener('click', aoClicar);
    APP.addEventListener('keydown', function (ev) {
      if (ev.altKey || ev.ctrlKey || ev.metaKey || /TEXTAREA|INPUT|SELECT/.test(ev.target.tagName)) return;
      var n = +ev.key; if (!n) return;
      var bs = TELA.querySelectorAll('[data-resp]'); if (bs[n - 1]) { ev.preventDefault(); bs[n - 1].click(); }
    });
    mostrarFormulario();
  }
  var APP;
  var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp questionário]', e); } }, 0); };
  if (document.readyState === 'complete') vai();
  else { if (window.apex.gPageContext$) $(apex.gPageContext$).one('apexreadyend', vai); window.addEventListener('load', vai); }
})();
