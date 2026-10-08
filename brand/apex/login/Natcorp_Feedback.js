/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · FEEDBACKS DO COLABORADOR  —  o "arrumador" da página (JavaScript)             ║
   ║  App 9118 (Avaliações - Processos) · Página 150 · Feedback: Colaborador                  ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: FEEDBACK-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   No Portal do Colaborador (P_PAINEL = PC) a pessoa LÊ os feedbacks que recebeu — quase
   sempre no celular e muitas vezes com pouca leitura. Os feedbacks são escritos pelos
   líderes (nada fixo aqui). Então:
     • no alto, uma frase do que é a página e um resumo: quantos feedbacks e, quando todos
       estão na tela, a média das estrelas;
     • os feedbacks em cartões, AGRUPADOS POR ANO (o mais novo primeiro): quem deu (com as
       iniciais), a data por extenso ("23 de janeiro de 2026", "Hoje", "Ontem"), "Novo" nos
       últimos 30 dias, o título grande, o texto com as quebras de linha, as estrelas
       grandes com "4 de 5" (sem nota, as estrelas não aparecem) e "Ouvir";
     • no painel do gestor (fora do Portal): o filtro vira três botões (as opções da lista
       original), aparece "Para: <quem recebeu>" e o botão "Editar" nos que a pessoa escreveu.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada e não muda o que aparece: a consulta (público, "colaborador visualiza",
     painel), a paginação, o filtro (que envia a página, como antes), o botão Feedback e as
     ações que recarregam a lista ao fechar a janela são os da página. "Editar" é o LINK
     ORIGINAL. Tirou as URLs: volta o de antes.
     O cargo que a consulta põe embaixo do autor é o de quem RECEBEU (i.cargo): por isso o
     cartão não o mostra (veja o guia).

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 150 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Feedback.js
     Página 150 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Feedback.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [F1] Como a página é reconhecida                                      CUIDADO
     [F2] Os textos                                                        PODE MEXER
     [F3] Ferramentas (nomes, datas, ícones, estrelas)
     [F4] Lê os feedbacks (o modelo Comments)                              CUIDADO
     [F5] O alto e o resumo
     [F6] Os cartões
     [F7] O filtro (só fora do Portal)
     [F8] Ouvir
     [F9] O maestro
*/
(function () {
  'use strict';
  if (window.__ncFeedback || !window.apex || !window.apex.jQuery) return;

  /* ═══ [F1] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════════
     CUIDADO  pela região do relatório no modelo Comments (ul.t-Comments, data-region-id) ou,
              sem feedback, pelo relatório com "Nenhum Feedback". O modo GESTOR é quando a
              região Parametros (P150_TIPO_FEEDBACK) está na página — ela só aparece fora do
              Portal (P_PAINEL diferente de PC).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  function regiaoDaLista() {
    var ul = document.querySelector('ul.t-Comments[data-region-id]');
    if (ul) return $id(ul.getAttribute('data-region-id'));
    var nd = [].filter.call(document.querySelectorAll('[id$="_catch"] .nodatafound, .t-Region .nodatafound'), function (x) { return /feedback/i.test(x.textContent); })[0];
    return nd ? nd.closest('.t-Region') : null;
  }
  if (!regiaoDaLista()) return;
  window.__ncFeedback = true;
  var $ = window.apex.jQuery;
  var GESTOR = !!$id('P150_TIPO_FEEDBACK');

  /* ═══ [F2] OS TEXTOS ═════════════════════════════════════════════════════════════════════
     PODE MEXER  tudo daqui. Frases curtas, palavras do dia a dia.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T = {
    explica: GESTOR ? 'Os feedbacks que você recebeu e os que você deu.' : 'Aqui ficam os retornos que seus líderes deram sobre o seu trabalho.',
    quantos: function (n) { return n === 1 ? '1 feedback' : n + ' feedbacks'; },
    media: 'Média das estrelas',
    de: 'De', para: 'Para',
    novo: 'Novo',
    hoje: 'Hoje', ontem: 'Ontem',
    nota: function (n) { return n + ' de 5'; },
    ouvir: 'Ouvir', parar: 'Parar',
    editar: 'Editar',
    vazioTit: GESTOR ? 'Nenhum feedback encontrado' : 'Você ainda não recebeu feedback',
    vazioTxt: GESTOR ? 'Troque o filtro acima para ver outros feedbacks.' : 'Quando seu líder registrar um feedback para você, ele aparece aqui.'
  };
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];

  /* ═══ [F3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/[ \t ]+/g, ' ').replace(/\s*\n\s*/g, '\n').trim(); }
  var MIUDAS = /^(da|de|do|das|dos|e|em|na|no)$/;
  function bonito(t) {
    t = limpo(t); if (!t || t !== t.toUpperCase()) return t;
    return t.toLowerCase().replace(/[^\s\-\/().]+/g, function (w, i) {
      if (i > 0 && MIUDAS.test(w)) return w;
      if (!/[aeiouáéíóúâêôãõà]/.test(w)) return w.toUpperCase();
      return w.charAt(0).toUpperCase() + w.slice(1);
    });
  }
  function iniciais(nome) { var p = limpo(nome).split(' ').filter(function (w) { return w && !MIUDAS.test(w.toLowerCase()); }); return ((p[0] || '?').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  var CORES = [['#EFE6F7', '#511C76'], ['#FBE7EF', '#8E2F5C'], ['#E2EFF3', '#1F5A6B'], ['#E6F3EC', '#1F6B45'], ['#FFF0DA', '#7A4B00'], ['#ECEAF8', '#3E3A8C']];
  function corDe(nome) { var h = 0, s = String(nome).toLowerCase(); for (var i = 0; i < s.length; i++) h = (h * 31 + s.charCodeAt(i)) >>> 0; return CORES[h % CORES.length]; }
  /* "23/01/2026 15:30" → Date */
  function data(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})(?:\s+(\d{2}):(\d{2}))?/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1], +(m[4] || 0), +(m[5] || 0)) : null; }
  function diasAtras(d) { var h = new Date(); h.setHours(0, 0, 0, 0); var x = new Date(d); x.setHours(0, 0, 0, 0); return Math.round((h - x) / 864e5); }
  function quando(d) {
    if (!d) return '';
    var n = diasAtras(d);
    if (n === 0) return T.hoje;
    if (n === 1) return T.ontem;
    return d.getDate() + ' de ' + MESES[d.getMonth()] + ' de ' + d.getFullYear();
  }
  var IC = {
    som: '<path d="M4.5 9.5h3l4.5-4v13l-4.5-4h-3z"/><path d="M15.5 9a4.2 4.2 0 0 1 0 6M18 6.5a7.8 7.8 0 0 1 0 11"/>',
    parar: '<rect x="7" y="7" width="10" height="10" rx="1.5"/>',
    editar: '<path d="M4.5 19.5l1-4.5L15.5 5a2.1 2.1 0 0 1 3 3l-10 10z"/><path d="M13.5 7l3 3"/>',
    balao: '<path d="M5 5.5h14a1.5 1.5 0 0 1 1.5 1.5v8.5A1.5 1.5 0 0 1 19 17h-7l-4.5 3.5V17H5a1.5 1.5 0 0 1-1.5-1.5V7A1.5 1.5 0 0 1 5 5.5z"/><path d="M8 10h8M8 13h5"/>',
    seta: '<path d="M5 12h13M13 6.5l5.5 5.5-5.5 5.5"/>'
  };
  function ic(n, cls) { return '<svg class="nc-fb-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  var ESTRELA = '<path d="M12 3.2l2.7 5.6 6.1.8-4.5 4.2 1.1 6.1L12 17l-5.4 2.9 1.1-6.1-4.5-4.2 6.1-.8z"/>';
  function estrelas(n, cls) {
    var h = '';
    for (var i = 1; i <= 5; i++) h += '<svg class="nc-fb-estrela' + (i <= Math.round(n) ? ' is-cheia' : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + ESTRELA + '</svg>';
    return '<span class="nc-fb-estrelas' + (cls ? ' ' + cls : '') + '" role="img" aria-label="' + esc('Nota ' + String(n).replace('.', ',') + ' de 5') + '">' + h + '</span>';
  }

  /* ═══ [F4] LÊ OS FEEDBACKS ═══════════════════════════════════════════════════════════════
     CUIDADO  o modelo Comments escreve, por feedback (li.t-Comments-item):
                .t-Comments-userIcon (backgroundColorPink = quem escreveu é a própria pessoa)
                .t-Comments-info  "Autor: NOME<br><small>CARGO</small>" + .t-Comments-date
                                  + .t-Comments-actions a (o "Editar"; vazio quando não pode)
                .t-Comments-comment  [NOME DE QUEM RECEBEU<br><small>…</small><br>] (só no
                                  painel do gestor) <b>TÍTULO</b><br>TEXTO + .a-StarRating
                                  (input PONTUACAO = a nota; 0 = sem nota)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function textoComQuebras(nos) {
    var box = document.createElement('div');
    nos.forEach(function (n) { box.appendChild(n.cloneNode(true)); });
    [].forEach.call(box.querySelectorAll('br'), function (b) { b.replaceWith('\n'); });
    [].forEach.call(box.querySelectorAll('p, div, li'), function (b) { b.append('\n'); });
    return limpo(box.textContent);
  }
  function lerFeedbacks(reg) {
    return [].map.call(reg.querySelectorAll('li.t-Comments-item'), function (li) {
      var info = li.querySelector('.t-Comments-info'), com = li.querySelector('.t-Comments-comment');
      var f = { li: li };
      if (info) {
        var c = info.cloneNode(true);
        [].forEach.call(c.querySelectorAll('small, .t-Comments-date, .t-Comments-actions'), function (x) { x.remove(); });
        f.autor = bonito(limpo(c.textContent).replace(/^autor:\s*/i, '').replace(/[·•\s]+$/, ''));
        f.dataTxt = limpo((info.querySelector('.t-Comments-date') || {}).textContent || '');
        var a = info.querySelector('.t-Comments-actions a');
        f.editar = a && limpo(a.textContent) ? a : null;
      }
      f.meu = !!li.querySelector('.t-Comments-userIcon.backgroundColorPink');
      if (com) {
        var nota = com.querySelector('input[name="PONTUACAO"]');
        f.nota = nota ? parseInt(nota.value, 10) || 0 : 0;
        var nos = [].filter.call(com.childNodes, function (n) { return !(n.nodeType === 1 && n.classList.contains('a-StarRating')); });
        var bi = -1;
        nos.forEach(function (n, i) { if (bi < 0 && n.nodeType === 1 && n.tagName === 'B') bi = i; });
        if (bi >= 0) {
          f.titulo = limpo(nos[bi].textContent);
          var antes = textoComQuebras(nos.slice(0, bi));
          if (antes) f.para = bonito(antes.split('\n')[0]);
          f.texto = textoComQuebras(nos.slice(bi + 1));
        } else {
          f.titulo = ''; f.texto = textoComQuebras(nos);
        }
      }
      f.data = data(f.dataTxt);
      return f;
    });
  }

  /* ═══ [F5] O ALTO E O RESUMO ═════════════════════════════════════════════════════════════
     O resumo conta o que está na tela. A média das estrelas só aparece quando TODOS os
     feedbacks estão na tela (a paginação diz "1 - N de N") e há ao menos 2 com nota.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function vestirAlto() {
    var hero = document.querySelector('.t-HeroRegion .t-HeroRegion-col--content');
    if (hero && !hero.querySelector('.nc-fb-explica')) hero.appendChild(el('p', 'nc-fb-explica', esc(T.explica)));
  }
  function totalDaPaginacao(reg) {
    var t = (reg.querySelector('.t-Report-paginationText') || {}).textContent || '';
    var m = /(\d+)\s*-\s*(\d+)\s*de\s*(\d+)/i.exec(t);
    return m ? { de: +m[1], ate: +m[2], total: +m[3] } : null;
  }
  function resumo(lista, reg) {
    var pg = totalDaPaginacao(reg), total = pg ? pg.total : lista.length;
    var comNota = lista.filter(function (f) { return f.nota >= 1 && f.nota <= 5; });
    var todos = !pg || (pg.de === 1 && pg.ate === pg.total);
    var media = todos && comNota.length >= 2 ? comNota.reduce(function (s, f) { return s + f.nota; }, 0) / comNota.length : null;
    return '<div class="nc-fb-resumo">' +
      '<span class="nc-fb-resumo-n">' + ic('balao') + '<b>' + esc(T.quantos(total)) + '</b></span>' +
      (media != null ? '<span class="nc-fb-resumo-media"><span>' + esc(T.media) + '</span>' + estrelas(media, 'nc-fb-estrelas--p') + '<b>' + esc(media.toFixed(1).replace('.', ',')) + '</b></span>' : '') +
      '</div>';
  }

  /* ═══ [F6] OS CARTÕES ════════════════════════════════════════════════════════════════════ */
  var REG, CAIXA, LISTA = [];
  function cartao(f, i) {
    var cor = corDe(f.autor || '?'), novo = f.data && diasAtras(f.data) <= 30;
    return '<article class="nc-fb-cartao' + (f.meu ? ' nc-fb-cartao--meu' : '') + '" data-i="' + i + '" aria-labelledby="nc-fb-t' + i + '">' +
      '<header class="nc-fb-cab">' +
        '<span class="nc-fb-avatar" style="--av-bg:' + cor[0] + ';--av-tx:' + cor[1] + '" aria-hidden="true">' + esc(iniciais(f.autor || '?')) + '</span>' +
        '<span class="nc-fb-quem"><span class="nc-fb-de">' + esc(T.de) + '</span> <b>' + esc(f.autor || '') + '</b>' +
          (GESTOR && f.para ? '<span class="nc-fb-para">' + esc(T.para) + ': ' + esc(f.para) + '</span>' : '') +
          (f.data ? '<time class="nc-fb-data" datetime="' + f.data.toISOString() + '" title="' + esc(f.dataTxt) + '">' + esc(quando(f.data)) + '</time>' : '') +
        '</span>' +
        (novo ? '<span class="nc-fb-novo">' + esc(T.novo) + '</span>' : '') +
      '</header>' +
      (f.titulo ? '<h3 class="nc-fb-tit" id="nc-fb-t' + i + '">' + esc(f.titulo) + '</h3>' : '') +
      (f.texto ? '<p class="nc-fb-texto">' + esc(f.texto) + '</p>' : '') +
      '<footer class="nc-fb-pe">' +
        (f.nota >= 1 && f.nota <= 5 ? '<span class="nc-fb-nota">' + estrelas(f.nota) + '<b>' + esc(T.nota(f.nota)) + '</b></span>' : '<span></span>') +
        '<span class="nc-fb-acoes">' + botaoOuvir() +
          (f.editar ? '<button type="button" class="nc-fb-bt" data-editar="' + i + '">' + ic('editar') + '<span>' + esc(T.editar) + '</span></button>' : '') +
        '</span>' +
      '</footer>' +
    '</article>';
  }
  function desenhar() {
    REG = regiaoDaLista(); if (!REG) return;
    LISTA = lerFeedbacks(REG);
    var ul = REG.querySelector('ul.t-Comments'), vazio = REG.querySelector('.nodatafound');
    if (ul) ul.classList.add('nc-fb-guardado');
    if (vazio) vazio.classList.add('nc-fb-guardado');
    var pg = totalDaPaginacao(REG);
    REG.classList.toggle('nc-fb-pagina-unica', !pg || (pg.de === 1 && pg.ate === pg.total));
    if (CAIXA) CAIXA.remove();
    CAIXA = el('div', 'nc-fb');
    if (!LISTA.length) {
      CAIXA.innerHTML = '<div class="nc-fb-vazio">' + ic('balao') + '<b>' + esc(T.vazioTit) + '</b><span>' + esc(T.vazioTxt) + '</span></div>';
    } else {
      var h = resumo(LISTA, REG), ano = null;
      LISTA.forEach(function (f, i) {
        var a = f.data ? f.data.getFullYear() : '';
        if (a !== ano) { if (ano !== null) h += '</div></section>'; ano = a; h += '<section class="nc-fb-ano"><h2 class="nc-fb-ano-tit">' + esc(a || '') + '</h2><div class="nc-fb-lista">'; }
        h += cartao(f, i);
      });
      h += '</div></section>';
      CAIXA.innerHTML = h;
    }
    var corpo = (ul || vazio || REG.querySelector('.t-Region-body')).closest('.t-Region-body') || REG;
    corpo.insertBefore(CAIXA, corpo.firstChild);
  }

  /* ═══ [F7] O FILTRO (só fora do Portal) ══════════════════════════════════════════════════
     A lista "Feedbacks" (Todos / Meus Feedbacks / Feedbacks Criados por Mim) vira três botões
     com os textos da própria lista. O toque escreve na lista original (setValue) — ela envia
     a página, como antes. O botão "Feedback" (novo) é o original, só com outra roupa.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarFiltro() {
    var sel = $id('P150_TIPO_FEEDBACK'); if (!sel || sel.tagName !== 'SELECT') return;
    var c = sel.closest('.t-Form-fieldContainer'); if (!c) return;
    var g = el('div', 'nc-fb-filtro'); g.setAttribute('role', 'radiogroup'); g.setAttribute('aria-labelledby', 'P150_TIPO_FEEDBACK_LABEL');
    g.innerHTML = [].map.call(sel.options, function (o) {
      return '<button type="button" role="radio" data-v="' + esc(o.value) + '" aria-checked="' + (o.value === sel.value) + '">' + esc(limpo(o.text)) + '</button>';
    }).join('');
    g.addEventListener('click', function (e) {
      var b = e.target.closest('[data-v]'); if (!b || b.getAttribute('data-v') === sel.value) return;
      [].forEach.call(g.children, function (x) { x.setAttribute('aria-checked', String(x === b)); });
      apex.item('P150_TIPO_FEEDBACK').setValue(b.getAttribute('data-v'));
    });
    sel.classList.add('nc-fb-so-leitor');
    (c.querySelector('.t-Form-itemWrapper') || c).appendChild(g);
  }

  /* ═══ [F8] OUVIR ═════════════════════════════════════════════════════════════════════════
     A voz do aparelho lê: de quem é, a data, o título, o texto e a nota. Sem voz, o botão
     não aparece. Tocar de novo (ou sair da página) para.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FALA = window.speechSynthesis || null, FALANDO = null;
  function botaoOuvir() { return FALA ? '<button type="button" class="nc-fb-bt nc-fb-ouvir" aria-pressed="false">' + ic('som') + '<span>' + esc(T.ouvir) + '</span></button>' : ''; }
  function marca(b, on) { if (!b) return; b.setAttribute('aria-pressed', String(on)); b.innerHTML = ic(on ? 'parar' : 'som') + '<span>' + esc(on ? T.parar : T.ouvir) + '</span>'; }
  function parar() { if (FALA) FALA.cancel(); marca(FALANDO, false); FALANDO = null; }
  function ouvir(b) {
    if (!FALA) return;
    var era = FALANDO === b; parar(); if (era) return;
    var f = LISTA[+b.closest('.nc-fb-cartao').getAttribute('data-i')]; if (!f) return;
    var txt = [f.autor ? 'Feedback de ' + f.autor : '', f.data ? quando(f.data) : '', f.titulo, f.texto, f.nota ? 'Nota: ' + f.nota + ' de 5 estrelas' : '']
      .filter(Boolean).join('. ').replace(/\n+/g, '. ');
    var pedacos = txt.match(/[^.!?;]+[.!?;]*/g) || [txt];
    var voz = FALA.getVoices().filter(function (v) { return /^pt(-|_)?br/i.test(v.lang); })[0];
    FALANDO = b; marca(b, true);
    pedacos.map(limpo).filter(Boolean).forEach(function (t, i, arr) {
      var u = new SpeechSynthesisUtterance(t); u.lang = 'pt-BR'; u.rate = 0.92; if (voz) u.voice = voz;
      if (i === arr.length - 1) u.onend = function () { if (FALANDO === b) { marca(b, false); FALANDO = null; } };
      u.onerror = function () { if (FALANDO === b) { marca(b, false); FALANDO = null; } };
      FALA.speak(u);
    });
  }

  /* ═══ [F9] O MAESTRO ═════════════════════════════════════════════════════════════════════
     Monta depois das ações de abertura (apexreadyend), com reserva de 3 s. A lista se
     redesenha quando a região recarrega (paginação, fechar a janela do feedback).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var montado = false;
  function iniciar() {
    if (montado) return;
    montado = true;
    try {
      document.body.classList.add('nc-fb-ativo');
      if (GESTOR) document.body.classList.add('nc-fb-gestor');
      vestirAlto();
      montarFiltro();
      desenhar();
      $(REG).on('apexafterrefresh', function () { parar(); desenhar(); });
      REG.addEventListener('click', function (e) {
        var o = e.target.closest('.nc-fb-ouvir'); if (o) { ouvir(o); return; }
        var ed = e.target.closest('[data-editar]'); if (ed) { var f = LISTA[+ed.getAttribute('data-editar')]; if (f && f.editar) f.editar.click(); }
      });
      window.addEventListener('pagehide', parar);
    } catch (e) { if (window.console) console.error('Natcorp_Feedback', e); }
  }
  $(window).one('apexreadyend', iniciar);
  $(function () { setTimeout(iniciar, 3000); });
})();
