/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · AVALIAÇÃO MÉDICA  —  o "arrumador" das telas (JavaScript)                     ║
   ║  App 2937 (Medicina Ocupacional) · Página 105 (Avaliação Médica) e 102 (Respostas)       ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia destas páginas: AVALIACAOMEDICA-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   O médico aplica um questionário (histórico de saúde etc.) e chega ao diagnóstico.
   Antes: uma lista de perguntas; cada pergunta abria uma janela (102), um "Próximo" por vez,
   e a lista recarregava a página inteira ao fechar.

   PÁGINA 105 — o questionário inteiro na tela:
     • no alto, QUEM é avaliado, a avaliação, o questionário, a data e o avaliador, com o
       Relatório da avaliação;
     • a barra de progresso ("12 de 17 respondidas"), "Todas | Faltam N" e "Ir para a próxima
       sem resposta";
     • cada pergunta com a resposta ali mesmo: alternativas em botões (um toque SALVA e vai para
       a próxima pergunta) ou texto (salva sozinho ao parar de digitar e ao sair do campo);
       subperguntas (03.01) recuadas sob a pergunta-mãe; "Salvo às 10:42" em cada uma;
     • teclado: 1 a 9 escolhem a alternativa da pergunta em foco, ↓/↑ andam entre perguntas.
     Para salvar, ele usa dois processos da página (Ajax Callback) que o
     aplicar-avaliacaomedica-pagina105.py põe: NC_AVAL_PERGUNTAS (lê) e NC_AVAL_SALVAR (grava a
     resposta com a MESMA regra da janela 102). Sem eles, a lista original continua, com a
     janela de sempre (e a janela já vem com o desenho novo).

   PÁGINA 102 — a janela de uma pergunta (quando aberta pela lista):
     • a pergunta grande, as alternativas em botões (escrevem na lista original — a ação
       dinâmica "SALVAR ALTERNATIVA" de sempre grava) e, gravado, vai sozinho para a próxima;
     • Anterior / Próximo / Finalizar no rodapé; ← → no teclado; 1 a 9 escolhem;
     • antes de mudar de pergunta, espera a gravação terminar (a de texto acontece ao sair do
       campo — antes, o "Próximo" podia sair no meio dela).

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Páginas 105 e 102 › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_AvaliacaoMedica.js
     Páginas 105 e 102 › CSS › File URLs:         #WORKSPACE_IMAGES#Natcorp_AvaliacaoMedica.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [V1]  Textos e ajustes                                                 PODE MEXER
     [V2]  Ferramentas
     [V3]  Página 105: quem, progresso, perguntas
     [V4]  Página 105: salvar uma resposta                                  CUIDADO
     [V5]  Página 105: teclado
     [V6]  Página 102: a janela de uma pergunta                             CUIDADO
     [V7]  O maestro (qual página é)
*/
(function () {
  'use strict';
  if (window.__ncAvaliacaoMedica || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [V1] TEXTOS E AJUSTES ══════════════════════════════════════════════════════════════
     AVANCAR     depois de escolher uma alternativa, vai para a próxima pergunta (105 e 102).
     ESPERA_TXT  milissegundos depois de parar de digitar para salvar o texto (105).
     ALT_TEXTO   alternativa que pede texto ("Descreva", "Especifique"): ao escolhê-la, abre a caixa
                 para escrever e NÃO passa para a próxima. Mesma regra da condição do item
                 P102_RESP_DISSERTATIVA na exportação da 102 (DESCREV / ESPECIFI) — mudou aqui,
                 mude lá (aplicar-avaliacaomedica-pagina102.py).
     PODE MEXER
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var AVANCAR = true;
  var ESPERA_TXT = 1200;
  var ALT_TEXTO = /descrev|especifi/i;
  var PROC_LER = 'NC_AVAL_PERGUNTAS', PROC_SALVAR = 'NC_AVAL_SALVAR';

  /* ═══ [V2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
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
  /* a pergunta em MAIÚSCULAS vira frase ("VOCÊ ESTA SEDENTÁRIO?" → "Você esta sedentário?") */
  function frase(t) { t = String(t || '').trim(); if (/[a-zà-ú]/.test(t)) return t; t = t.toLowerCase(); return t.charAt(0).toUpperCase() + t.slice(1); }
  function texto(id) { var e = $id(id + '_DISPLAY') || $id(id); if (!e) return ''; if (e.tagName === 'SELECT') return e.selectedIndex >= 0 && e.value ? e.options[e.selectedIndex].text.trim() : ''; return String(/^(INPUT|TEXTAREA)$/.test(e.tagName) ? e.value : e.textContent).trim(); }
  /* "0301" → "03.01" (a numeração do questionário, de 2 em 2) */
  function numero(o) { o = String(o || ''); if (o.length <= 2) return ('0' + o).slice(-2); return o.match(/.{1,2}/g).join('.'); }
  function hora() { var n = new Date(); return ('0' + n.getHours()).slice(-2) + ':' + ('0' + n.getMinutes()).slice(-2); }
  var IC = {
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>', seta: '<path d="M9.5 6l6 6-6 6"/>', voltar: '<path d="M14.5 6l-6 6 6 6"/>',
    documento: '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4M9.5 12.5h6M9.5 16h6"/>', alvo: '<circle cx="12" cy="12" r="7.5"/><circle cx="12" cy="12" r="3"/>',
    alerta: '<path d="M12 4l9 16H3z"/><path d="M12 10v4M12 17h.01"/>', lixo: '<path d="M5 7h14M10 7V5h4v2M7 7l1 12h8l1-12"/>'
  };
  function ic(n) { return '<svg class="nc-am-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }
  function digitando(e) { return e && (/^(TEXTAREA|SELECT)$/.test(e.tagName) || (e.tagName === 'INPUT' && !/^(button|checkbox|radio)$/i.test(e.type)) || e.isContentEditable); }

  /* ═══ [V3] PÁGINA 105: QUEM, PROGRESSO, PERGUNTAS ════════════════════════════════════════ */
  function pagina105() {
    var regLista = document.querySelector('.a-ListView') && document.querySelector('.a-ListView').closest('.t-Region');
    var regQuest = regLista && regLista.parentElement.closest('.t-Region');   /* "Questionário" */
    var regForm = $id('P105_MATRICULA_CONTAINER') && $id('P105_MATRICULA_CONTAINER').closest('.t-Region');
    if (!regForm) return;
    document.body.classList.add('nc-am-ativo', 'nc-am-105');
    var temAval = !!texto('P105_ROWID');
    var app = el('section', 'nc-am'); app.setAttribute('aria-label', 'Avaliação médica');
    regForm.parentNode.insertBefore(app, regForm);

    /* — o alto: quem é avaliado e a avaliação (só quando a avaliação já existe; criando, fica o formulário) — */
    if (!temAval) { app.remove(); document.body.classList.add('nc-am-criando'); return; }
    var quem = texto('P105_MATRICULA'), m = /^\s*(\S+)\s+-\s+(.+)$/.exec(quem), cod = m ? m[1] : '', nm = m ? m[2] : quem;
    if (nm && !/[a-zà-ú]/.test(nm)) nm = nome(nm);
    var ini = String(nm || '?').split(/\s+/).filter(function (p) { return p.length > 2; });
    ini = ((ini[0] || '?').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '')).toUpperCase();
    var cab = el('header', 'nc-am-cab');
    var dados = [['Avaliação', codDesc(texto('P105_COD_FORMACAO'))], ['Questionário', codDesc(texto('P105_QUESTIONARIO_DISPLAY'))], ['Data', texto('P105_DATA_AVALIACAO')], ['Avaliador', codDesc(texto('P105_COD_PREST_SERV'))], ['Tipo', texto('P105_TIPO_AVALIADO')], ['Empresa', codDesc(texto('P105_COD_EMPRESA'))]].filter(function (d) { return d[1]; });
    cab.innerHTML = '<span class="nc-am-avatar" aria-hidden="true">' + esc(ini) + '</span>' +
      '<div class="nc-am-cab-txt"><h1>' + (cod ? '<span class="nc-am-cod">' + esc(cod) + ' - </span>' : '') + esc(nm || 'Avaliado') + '</h1>' +
      '<dl>' + dados.map(function (d) { return '<div><dt>' + esc(d[0]) + '</dt><dd>' + esc(d[1]) + '</dd></div>'; }).join('') + '</dl></div>' +
      '<div class="nc-am-cab-acoes"></div>';
    app.appendChild(cab);
    /* os botões originais do formulário: Relatório no alto; Voltar e Deletar embaixo */
    var acoesCab = cab.querySelector('.nc-am-cab-acoes'), pe = el('div', 'nc-am-pe');
    [].forEach.call(regForm.querySelectorAll('button.t-Button, a.t-Button'), function (b) {
      var t = b.textContent.trim();
      b.classList.add('nc-am-bt');
      if (/relat/i.test(t)) { b.classList.add('nc-am-bt--primario'); b.insertAdjacentHTML('afterbegin', ic('documento')); acoesCab.appendChild(b); }
      else if (/deletar|excluir/i.test(t)) { b.classList.add('nc-am-bt--leve', 'nc-am-bt--perigo'); var l = b.querySelector('.t-Button-label'); if (l) l.textContent = 'Excluir avaliação'; b.insertAdjacentHTML('afterbegin', ic('lixo')); pe.appendChild(b); }
      else pe.insertBefore(b, pe.firstChild);
    });
    regForm.classList.add('nc-am-guardada');

    if (!regQuest) { app.appendChild(pe); return; }
    /* — o questionário: tenta o processo NC_AVAL_PERGUNTAS; sem ele, a lista original (com a janela) — */
    var corpo = el('div', 'nc-am-corpo'); app.appendChild(corpo); app.appendChild(pe);
    corpo.innerHTML = '<p class="nc-am-carregando">Carregando as perguntas…</p>';
    apex.server.process(PROC_LER, {}, { dataType: 'json', error: function () {} })   /* error próprio: sem o aviso vermelho do APEX quando o processo ainda não foi importado */.done(function (d) {
      if (!d || !d.perguntas) return semProcesso();
      regQuest.classList.add('nc-am-guardada');
      montar(d.perguntas);
    }).fail(semProcesso);

    function semProcesso() {
      /* o processo ainda não foi importado: a lista original fica, só com roupa nova */
      corpo.innerHTML = '';
      regQuest.classList.add('nc-am-lista-original');
      corpo.appendChild(regQuest);
    }

    var PERG = [], FILTRO = '';
    function montar(lista) {
      PERG = lista.map(function (p, i) {
        return { i: i, ordem: String(p.ordem || ''), questao: String(p.questao), texto: frase(p.texto), livre: p.livre === 'S',
          resp: p.resposta == null ? '' : String(p.resposta), txt: p.texto_resp || '', opcoes: (p.opcoes || []).map(function (o) { return { c: String(o.c), d: frase(o.d), t: ALT_TEXTO.test(o.d) }; }) };
      });
      corpo.innerHTML =
        '<div class="nc-am-progresso"><div class="nc-am-prog-txt"><b class="nc-am-feitas"></b><span class="nc-am-falta"></span></div>' +
          '<div class="nc-am-barra" role="progressbar" aria-valuemin="0" aria-valuemax="' + PERG.length + '"><span></span></div>' +
          '<div class="nc-am-prog-acoes"><div class="nc-am-filtro" role="group" aria-label="Mostrar"><button type="button" data-f="" aria-pressed="true">Todas</button><button type="button" data-f="faltam" aria-pressed="false">Faltam</button></div>' +
          '<button type="button" class="nc-am-bt" data-proxima>' + ic('alvo') + 'Próxima sem resposta</button></div></div>' +
        '<ol class="nc-am-perguntas"></ol>';
      var ol = corpo.querySelector('.nc-am-perguntas');
      var pilha = [];   /* a mãe de cada pergunta: a última de nível menor (03 → 03.01, 03.02) */
      PERG.forEach(function (p) {
        var nivel = Math.max(0, Math.ceil(p.ordem.length / 2) - 1);
        var li = el('li', 'nc-am-perg'); li.setAttribute('data-i', p.i); li.setAttribute('data-nivel', nivel); li.tabIndex = -1;
        var idT = 'nc-am-t-' + p.i;
        li.innerHTML = '<div class="nc-am-perg-cab"><span class="nc-am-num">' + numHtml(p.ordem) + '</span><p class="nc-am-texto" id="' + idT + '">' + esc(p.texto) + '</p><span class="nc-am-estado" aria-live="polite"></span></div>' +
          '<p class="nc-am-ctx"></p>' +
          (p.livre ?
            '<div class="nc-am-livre"><textarea rows="2" maxlength="2500" aria-labelledby="' + idT + '" placeholder="Escreva a resposta"></textarea></div>' :
            (p.opcoes.length ? '<div class="nc-am-opcoes" role="radiogroup" aria-labelledby="' + idT + '">' + p.opcoes.map(function (o, k) {
              return '<button type="button" role="radio" class="nc-am-op" data-c="' + esc(o.c) + '" aria-checked="false">' + (k < 9 ? '<kbd>' + (k + 1) + '</kbd>' : '') + '<span>' + esc(o.d) + '</span></button>';
            }).join('') + '</div>' +
              (p.opcoes.some(function (o) { return o.t; }) ? '<div class="nc-am-livre nc-am-descreva" hidden><textarea rows="2" maxlength="2500" aria-label="Descreva: ' + esc(p.texto) + '" placeholder="Descreva aqui"></textarea></div>' : '')
              : '<p class="nc-am-sem">Esta pergunta não tem alternativas cadastradas.</p>'));
        /* subpergunta: entra DENTRO do cartão da mãe, numa lista ligada a ela pelo fio ([C5] do CSS) */
        while (pilha.length && pilha[pilha.length - 1].nivel >= nivel) pilha.pop();
        if (pilha.length) {
          var mae = pilha[pilha.length - 1], filhos = mae.li.querySelector(':scope > .nc-am-filhos');
          if (!filhos) { filhos = el('ol', 'nc-am-filhos'); filhos.setAttribute('aria-label', 'Perguntas ligadas à ' + numero(mae.p.ordem)); mae.li.appendChild(filhos); mae.li.classList.add('tem-filhos'); }
          filhos.appendChild(li); li.classList.add('is-filha'); p.mae = mae.p;
        } else ol.appendChild(li);
        pilha.push({ nivel: nivel, li: li, p: p });
        p.li = li;
        /* a caixa de texto: a da pergunta dissertativa ou a do "Descreva" (grava junto com a alternativa) */
        var ta = li.querySelector(':scope > .nc-am-livre textarea');
        if (ta) {
          ta.value = p.txt; p.ta = ta;
          var t = null;
          /* 04/10 (cliente: "mantém as ações que o programa original faz"): como a ação "Salvar
             Dissertativa" da janela 102 — grava ao SAIR da caixa e só com texto (não a cada tecla) */
          ta.addEventListener('input', function () { crescer(ta); estado(p, 'digitando'); clearTimeout(t); });
          ta.addEventListener('blur', function () { clearTimeout(t); if (ta.value.trim() && ta.value !== p.txt) salvar(p, p.livre ? '' : p.resp, ta.value); });
        }
        pintar(p);
        if (ta && !ta.parentNode.hidden) crescer(ta);
      });
      progresso();
      corpo.addEventListener('click', function (ev) {
        var op = ev.target.closest('.nc-am-op');
        if (op) { var p = PERG[+op.closest('.nc-am-perg').getAttribute('data-i')]; escolher(p, op.getAttribute('data-c')); return; }
        var f = ev.target.closest('[data-f]');
        if (f) { FILTRO = f.getAttribute('data-f'); [].forEach.call(corpo.querySelectorAll('[data-f]'), function (b) { b.setAttribute('aria-pressed', b === f ? 'true' : 'false'); }); filtrar(); return; }
        if (ev.target.closest('[data-proxima]')) irPara(proximaSem(-1));
        var li = ev.target.closest('.nc-am-perg'); if (li) ativa(li);
      });
      teclado105();
      var primeira = proximaSem(-1); if (primeira) ativa(primeira.li);
      /* o fio acompanha a altura de tudo (resposta que abre caixa, filtro, largura da tela) */
      var quadro = 0, refazer = function () { cancelAnimationFrame(quadro); quadro = requestAnimationFrame(fios); };
      if (window.ResizeObserver) new ResizeObserver(refazer).observe(ol);
      window.addEventListener('resize', refazer);
      refazer();
    }
    function crescer(ta) { ta.style.setProperty('--nc-am-alt', 'auto'); ta.style.setProperty('--nc-am-alt', Math.min(Math.max(ta.scrollHeight + 2, 64), 320) + 'px'); }
    /* a alternativa escolhida pede texto? ("Descreva") — aí só conta como respondida com o texto */
    function pedeTexto(p) { return !p.livre && p.opcoes.some(function (o) { return o.t && o.c === p.resp; }); }
    function respondida(p) { return p.livre ? !!String(p.txt).trim() : !!p.resp && (!pedeTexto(p) || !!String(p.txt).trim()); }
    /* "03.01" → "03." apagado + "01" em destaque: a mãe fica no número, a filha é o que muda */
    function numHtml(o) { var n = numero(o), k = n.lastIndexOf('.'); return k > 0 ? '<i>' + esc(n.slice(0, k + 1)) + '</i>' + esc(n.slice(k + 1)) : esc(n); }
    /* CUIDADO: com as filhas dentro do cartão da mãe, toda busca é ":scope > …" (só a própria pergunta) */
    function pintar(p) {
      p.li.classList.toggle('is-respondida', respondida(p));
      var ops = p.li.querySelectorAll(':scope > .nc-am-opcoes .nc-am-op');
      [].forEach.call(ops, function (b) { var s = b.getAttribute('data-c') === p.resp; b.setAttribute('aria-checked', s ? 'true' : 'false'); b.tabIndex = s || (!p.resp && b === ops[0]) ? 0 : -1; });
      var d = p.li.querySelector(':scope > .nc-am-descreva'); if (d) d.hidden = !pedeTexto(p);
      /* a linha "Respondida: …" — aparece quando a mãe fica só como contexto das filhas (filtro Faltam) */
      var ctx = p.li.querySelector(':scope > .nc-am-ctx'), o = p.opcoes.filter(function (x) { return x.c === p.resp; })[0];
      if (ctx) ctx.innerHTML = respondida(p) ? ic('check') + '<span>Respondida: <b>' + esc(p.livre ? p.txt : (o ? o.d : '') + (pedeTexto(p) && p.txt ? ' — ' + p.txt : '')) + '</b></span>' : '';
    }
    function estado(p, s, extra) {
      var e = p.li.querySelector(':scope > .nc-am-perg-cab .nc-am-estado');
      e.setAttribute('data-s', s);
      e.innerHTML = s === 'salvando' ? 'Salvando…' : s === 'salvo' ? ic('check') + 'Salvo às ' + extra : s === 'erro' ? ic('alerta') + 'Não salvou. <button type="button" class="nc-am-link" data-tentar>Tentar de novo</button>' : s === 'digitando' ? 'Editando…' : '';
      var b = e.querySelector('[data-tentar]'); if (b) b.onclick = function () { salvar(p, p.livre ? '' : (p.ultimo || p.resp), p.ta ? p.ta.value : ''); };
    }
    function progresso() {
      var n = PERG.filter(respondida).length, tot = PERG.length;
      corpo.querySelector('.nc-am-feitas').textContent = n + ' de ' + tot + ' respondidas';
      corpo.querySelector('.nc-am-falta').textContent = n === tot ? 'Questionário completo' : 'Faltam ' + (tot - n);
      corpo.querySelector('.nc-am-falta').setAttribute('data-ok', n === tot ? 'sim' : 'nao');
      var bar = corpo.querySelector('.nc-am-barra'); bar.setAttribute('aria-valuenow', n); bar.querySelector('span').style.setProperty('--nc-am-p', (tot ? n / tot * 100 : 0) + '%');
      corpo.querySelector('[data-f="faltam"]').textContent = 'Faltam ' + (tot - n);
      corpo.querySelector('[data-proxima]').hidden = n === tot;
    }
    /* Faltam: a mãe respondida com filha pendente NÃO some — fica recolhida ("Respondida: Ex-tabagista"),
       para a filha nunca aparecer sem a pergunta de que depende */
    function pendenteAbaixo(p) { return PERG.some(function (q) { return q !== p && p.li.contains(q.li) && !respondida(q); }); }
    function filtrar() {
      PERG.forEach(function (p) {
        var r = FILTRO === 'faltam' && respondida(p), at = p.li.classList.contains('is-ativa'), ctx = r && !at && pendenteAbaixo(p);
        p.li.hidden = r && !at && !ctx;
        p.li.classList.toggle('is-contexto', ctx);
      });
      fios();
    }
    /* o fio: do número da mãe até a curva da última filha à vista. A curva de cada filha é CSS; o
       comprimento do fio depende da altura das respostas, por isso é medido aqui (variáveis CSS) */
    function fios() {
      [].forEach.call(corpo.querySelectorAll('.nc-am-perg.tem-filhos'), function (li) {
        var num = li.querySelector(':scope > .nc-am-perg-cab .nc-am-num'), f = li.querySelector(':scope > .nc-am-filhos');
        var vis = f ? [].filter.call(f.children, function (c) { return !c.hidden; }) : [];
        if (li.hidden || !num || !vis.length || !li.offsetParent) { li.style.setProperty('--nc-am-fio-h', '0px'); return; }
        var r = li.getBoundingClientRect(), b = num.getBoundingClientRect(), u = vis[vis.length - 1].getBoundingClientRect();
        /* no celular as respostas ocupam a largura toda: o fio corre no recuo da borda do cartão */
        var x = window.matchMedia('(max-width: 720px)').matches ? r.left + parseFloat(getComputedStyle(li).paddingLeft) / 2 : b.left + b.width / 2;
        var ini = b.bottom - r.top + 6;
        li.style.setProperty('--nc-am-fio-x', (x - r.left) + 'px');
        li.style.setProperty('--nc-am-fio-ini', ini + 'px');
        li.style.setProperty('--nc-am-fio-h', Math.max(0, u.top - r.top - ini) + 'px');
        f.style.setProperty('--nc-am-cot', Math.max(8, f.getBoundingClientRect().left - x) + 'px');
      });
    }
    function proximaSem(depois) { for (var k = depois + 1; k < PERG.length; k++) if (!respondida(PERG[k])) return PERG[k]; for (k = 0; k <= depois && k < PERG.length; k++) if (!respondida(PERG[k])) return PERG[k]; return null; }
    function ativa(li) { [].forEach.call(corpo.querySelectorAll('.nc-am-perg.is-ativa'), function (x) { if (x !== li) x.classList.remove('is-ativa'); }); li.classList.add('is-ativa'); }
    function irPara(p) {
      if (!p) return;
      p.li.hidden = false; ativa(p.li);
      p.li.scrollIntoView({ block: 'center', behavior: matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth' });
      var foco = p.li.querySelector(':scope > .nc-am-livre textarea, :scope > .nc-am-opcoes .nc-am-op[tabindex="0"], :scope > .nc-am-opcoes .nc-am-op');
      setTimeout(function () { try { (foco || p.li).focus({ preventScroll: true }); } catch (x) { (foco || p.li).focus(); } }, 250);
    }
    function escolher(p, c) {
      var o = p.opcoes.filter(function (x) { return x.c === c; })[0] || {};
      if (p.resp === c) { if (o.t && p.ta) p.ta.focus(); return; }
      p.ultimo = c;
      /* "Descreva": grava a alternativa com o texto que já houver e abre a caixa — fica na pergunta.
         Outra alternativa: o texto do "Descreva" deixa de valer (vai vazio) e passa à próxima. */
      if (!o.t && p.ta) p.ta.value = '';
      salvar(p, c, o.t && p.ta ? p.ta.value : '', function () {
        if (AVANCAR && !o.t) { var prox = PERG[p.i + 1]; if (prox) irPara(prox); }
      });
      p.resp = c; pintar(p); progresso();
      if (o.t && p.ta) { crescer(p.ta); p.ta.focus(); }
    }

    /* ═══ [V4] PÁGINA 105: SALVAR UMA RESPOSTA ════════════════════════════════════════════
       CUIDADO  NC_AVAL_SALVAR grava com a regra da janela 102: atualiza a resposta da pergunta
                (alternativa E texto — o texto só vai junto na dissertativa e no "Descreva") e, se a linha ainda não
                existe, cria. x01 = código da questão, x02 = alternativa, x03 = texto,
                x04 = número de ordem. As gravações vão em fila (uma por vez, na ordem).
       ════════════════════════════════════════════════════════════════════════════════════ */
    var fila = $.Deferred().resolve().promise();
    function salvar(p, alt, txt, depois) {
      estado(p, 'salvando');
      fila = fila.then(function () {
        return apex.server.process(PROC_SALVAR, { x01: p.questao, x02: alt || '', x03: txt || '' }, { dataType: 'json', error: function () {} }).then(function (r) {
          if (r && r.ok) {
            if (!p.livre) p.resp = alt;
            p.txt = txt;
            pintar(p); progresso(); estado(p, 'salvo', hora());
            if (FILTRO === 'faltam') setTimeout(filtrar, 900);
            if (depois) depois();
          } else {
            estado(p, 'erro');
            /* o erro do banco aparece como na janela 102 (mensagem do APEX), não só no console */
            if (r && r.erro) { try { apex.message.clearErrors(); apex.message.showErrors([{ type: 'error', location: 'page', message: r.erro, unsafe: false }]); } catch (x) {} }
          }
        }, function () { estado(p, 'erro'); return $.Deferred().resolve().promise(); });
      });
    }

    /* ═══ [V5] PÁGINA 105: TECLADO ════════════════════════════════════════════════════════
       1 a 9: a alternativa da pergunta ativa. ↓/↑ (fora do texto): próxima / anterior.
       ════════════════════════════════════════════════════════════════════════════════════ */
    function teclado105() {
      document.addEventListener('keydown', function (ev) {
        if (ev.ctrlKey || ev.metaKey || ev.altKey || digitando(ev.target)) return;
        var li = corpo.querySelector('.nc-am-perg.is-ativa'); if (!li) return;
        var p = PERG[+li.getAttribute('data-i')];
        if (/^[1-9]$/.test(ev.key) && !p.livre) { var o = p.opcoes[+ev.key - 1]; if (o) { ev.preventDefault(); escolher(p, o.c); } return; }
        if (ev.key === 'ArrowDown' || ev.key === 'ArrowUp') {
          var k = p.i + (ev.key === 'ArrowDown' ? 1 : -1);
          while (PERG[k] && PERG[k].li.hidden) k += ev.key === 'ArrowDown' ? 1 : -1;
          if (PERG[k]) { ev.preventDefault(); irPara(PERG[k]); }
        }
      });
      corpo.addEventListener('focusin', function (ev) { var li = ev.target.closest && ev.target.closest('.nc-am-perg'); if (li) ativa(li); });
    }
  }

  /* ═══ [V6] PÁGINA 102: A JANELA DE UMA PERGUNTA ════════════════════════════════════════
     CUIDADO  As alternativas escrevem na lista original (P102_RESP_ALTERNATIVA) e disparam o
              "change": é a ação dinâmica "SALVAR ALTERNATIVA" da página que grava. Gravado
              (sem chamadas pendentes), vai para a próxima (o botão Próximo original).
              O texto grava ao sair do campo (ação "Salvar Dissertativa"): antes de Anterior /
              Próximo / Finalizar, o desenho sai do campo e espera a gravação.
     ════════════════════════════════════════════════════════════════════════════════════ */
  function pagina102() {
    var perg = $id('P102_TXT_QUESTAO'); if (!perg) return;
    document.body.classList.add('nc-am-ativo', 'nc-am-102');
    var sel = $id('P102_RESP_ALTERNATIVA'), ta = $id('P102_RESP_DISSERTATIVA');
    var bAnt = $id('ANTERIOR'), bProx = $id('PROXIMO');
    var bFim = [].filter.call(document.querySelectorAll('button.t-Button'), function (b) { return /finalizar/i.test(b.textContent); })[0];
    var bFechar = [].filter.call(document.querySelectorAll('button.t-Button'), function (b) { return /^\s*fechar\s*$/i.test(b.textContent); })[0];
    var corpo = (perg.closest('.t-Region') || perg.parentNode);
    var app = el('section', 'nc-am-janela');
    corpo.parentNode.insertBefore(app, corpo);
    var m = /^\s*(\d+)\s*-\s*([\s\S]*)$/.exec(perg.value || '');
    app.innerHTML = '<p class="nc-am-j-num">Pergunta ' + esc(m ? numero(m[1]) : '') + '</p><h1 class="nc-am-j-texto">' + esc(frase(m ? m[2] : perg.value)) + '</h1><div class="nc-am-j-resp"></div><p class="nc-am-j-estado" aria-live="polite"></p>';
    var resp = app.querySelector('.nc-am-j-resp'), est = app.querySelector('.nc-am-j-estado');
    var cPerg = $id('P102_TXT_QUESTAO_CONTAINER'); if (cPerg) cPerg.classList.add('nc-am-guardada');
    var navegar = function (b) {
      if (document.activeElement && document.activeElement.blur) document.activeElement.blur();   /* o texto grava ao sair do campo */
      est.textContent = 'Salvando…';
      var t0 = Date.now();
      (function esperar() { if ($.active > 0 && Date.now() - t0 < 6000) return setTimeout(esperar, 80); b.__ncLibera = true; b.click(); })();
    };
    if (sel) {
      var opcoes = [].filter.call(sel.options, function (o) { return o.value !== ''; });
      var g = el('div', 'nc-am-opcoes nc-am-opcoes--janela'); g.setAttribute('role', 'radiogroup'); g.setAttribute('aria-label', 'Resposta');
      var pedeT = function (c) { return opcoes.some(function (o) { return o.value === c && ALT_TEXTO.test(o.text); }); };
      opcoes.forEach(function (o, k) { var b = el('button', 'nc-am-op', (k < 9 ? '<kbd>' + (k + 1) + '</kbd>' : '') + '<span>' + esc(frase(o.text)) + '</span>'); b.type = 'button'; b.setAttribute('role', 'radio'); b.setAttribute('data-c', o.value); g.appendChild(b); });
      resp.appendChild(g);
      var cSel = $id('P102_RESP_ALTERNATIVA_CONTAINER'); if (cSel) cSel.classList.add('nc-am-guardada');
      /* a caixa do "Descreva" (o item P102_RESP_DISSERTATIVA, que a exportação põe nessas perguntas) */
      var marcar = function () {
        [].forEach.call(g.children, function (b) { b.setAttribute('aria-checked', b.getAttribute('data-c') === sel.value ? 'true' : 'false'); });
        var cT = $id('P102_RESP_DISSERTATIVA_CONTAINER'); if (cT) cT.classList.toggle('nc-am-guardada', !pedeT(sel.value));
      };
      var escolher = function (c) {
        var t = pedeT(c);
        if (sel.value === c && t && ta) { ta.focus(); return; }
        if (!t && ta) ta.value = '';                      /* o texto do "Descreva" deixa de valer: grava vazio */
        apex.item('P102_RESP_ALTERNATIVA').setValue(c);   /* dispara o change: a ação da página grava (alternativa + texto) */
        marcar(); est.textContent = 'Salvando…';
        if (t && ta) setTimeout(function () { ta.focus(); }, 50);
        var t0 = Date.now();
        (function esperar() {
          if ($.active > 0 && Date.now() - t0 < 6000) return setTimeout(esperar, 80);
          est.innerHTML = ic('check') + 'Salvo às ' + hora();
          if (AVANCAR && !t && bProx && bProx.offsetParent !== null) setTimeout(function () { bProx.__ncLibera = true; bProx.click(); }, 350);
        })();
      };
      g.addEventListener('click', function (ev) { var b = ev.target.closest('.nc-am-op'); if (b) escolher(b.getAttribute('data-c')); });
      document.addEventListener('keydown', function (ev) {
        if (ev.ctrlKey || ev.metaKey || ev.altKey || digitando(ev.target)) return;
        if (/^[1-9]$/.test(ev.key) && opcoes[+ev.key - 1]) { ev.preventDefault(); escolher(opcoes[+ev.key - 1].value); }
      });
      setTimeout(function () { var b = g.querySelector('[aria-checked="true"]') || g.firstChild; if (b) b.focus(); }, 100);
    }
    var soTexto = ta && !sel;   /* pergunta dissertativa; com alternativas, a caixa é a do "Descreva" */
    if (ta) {
      var cTa = $id('P102_RESP_DISSERTATIVA_CONTAINER'); if (cTa) { cTa.classList.add('nc-am-campo-texto'); resp.appendChild(cTa); }
      var lab = $id('P102_RESP_DISSERTATIVA_LABEL'); if (lab) lab.textContent = soTexto ? 'Resposta' : 'Descreva';
      ta.placeholder = soTexto ? 'Escreva a resposta — salva ao sair do campo' : 'Descreva aqui — salva ao sair do campo';
      if (soTexto) setTimeout(function () { ta.focus(); }, 100);
      ta.addEventListener('focusout', function () { if (ta.value.trim()) { est.textContent = 'Salvando…'; setTimeout(function w() { if ($.active > 0) return setTimeout(w, 80); est.innerHTML = ic('check') + 'Salvo às ' + hora(); }, 50); } });
    }
    if (sel) {
      marcar();
      /* já marcada como "Descreva" e sem texto: o cursor vai direto para a caixa */
      if (ta && pedeT(sel.value) && !ta.value.trim()) setTimeout(function () { ta.focus(); }, 150);
    }
    /* Anterior / Próximo / Finalizar: esperam a gravação (captura: antes da ação do botão) */
    [bAnt, bProx, bFim].forEach(function (b) {
      if (!b) return;
      b.classList.add('nc-am-bt'); if (b === bProx || b === bFim) b.classList.add('nc-am-bt--primario');
      b.addEventListener('click', function (ev) { if (b.__ncLibera) { b.__ncLibera = false; return; } if ($.active > 0 || (ta && document.activeElement === ta)) { ev.preventDefault(); ev.stopImmediatePropagation(); navegar(b); } }, true);
    });
    if (bFechar) bFechar.classList.add('nc-am-bt');
    /* Anterior / Próxima: o ícone sozinho vira ícone + nome (o médico lê, não adivinha) */
    [[bAnt, 'Anterior', true], [bProx, 'Próxima', false]].forEach(function (x) {
      var b = x[0]; if (!b || b.querySelector('.t-Button-label')) return;
      b.classList.remove('t-Button--noLabel', 't-Button--icon');
      var lab = el('span', 't-Button-label', x[1]);
      if (x[2]) b.appendChild(lab); else b.insertBefore(lab, b.firstChild);
    });
    /* ← → no teclado (fora do texto) */
    document.addEventListener('keydown', function (ev) {
      if (ev.ctrlKey || ev.metaKey || ev.altKey || digitando(ev.target)) return;
      if (ev.key === 'ArrowRight' && bProx && bProx.offsetParent !== null) { ev.preventDefault(); navegar(bProx); }
      if (ev.key === 'ArrowLeft' && bAnt && bAnt.offsetParent !== null) { ev.preventDefault(); navegar(bAnt); }
    });
    /* os botões de navegação (região do alto) vão para o rodapé, junto do Finalizar */
    /* Fechar fica à esquerda (coluna original); Anterior · Próxima / Finalizar à direita */
    var pe = document.querySelector('.t-Dialog-footer .t-ButtonRegion-col--right .t-ButtonRegion-buttons');
    if (pe) { if (bAnt) pe.insertBefore(bAnt, pe.firstChild); if (bProx) pe.appendChild(bProx); }
    /* a região original fica só com os itens ocultos: sai da tela (a caixa vazia sob as alternativas) */
    if (corpo.classList && corpo.classList.contains('t-Region') && !corpo.contains(app)) corpo.classList.add('nc-am-guardada');
    [].forEach.call(document.querySelectorAll('.t-ButtonRegion'), function (r) { if (!r.closest('.t-Dialog-footer') && !r.querySelector('button.t-Button')) r.classList.add('nc-am-guardada'); });
  }

  /* ═══ [V7] O MAESTRO ══════════════════════════════════════════════════════════════════ */
  function iniciar() {
    if (window.__ncAvaliacaoMedica) return;
    if ($id('P105_MATRICULA')) { window.__ncAvaliacaoMedica = true; pagina105(); }
    else if ($id('P102_TXT_QUESTAO')) { window.__ncAvaliacaoMedica = true; pagina102(); }
  }
  $(window).on('apexreadyend', function () { setTimeout(iniciar, 0); });
  if (document.readyState === 'complete') setTimeout(iniciar, 300);
  else window.addEventListener('load', function () { setTimeout(iniciar, 300); });
})();
