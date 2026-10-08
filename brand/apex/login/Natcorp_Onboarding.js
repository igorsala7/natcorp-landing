/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · ONBOARDING  —  o "arrumador" da página (JavaScript)                           ║
   ║  App 300 (Portal do Colaborador) · Página 2500 · OnBoarding                              ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: ONBOARDING-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quem lê é o colaborador NOVO, quase sempre no celular e muitas vezes com pouca leitura.
   As categorias e os conteúdos são da empresa (cadastrados por ela): nada aqui é texto fixo
   de conteúdo — o desenho só ORGANIZA o que vier. Então:
     • as categorias viram PARTES de um caminho: "Parte 1 de 5", uma barra com as partes, a
       lista de todas (ao lado no computador; atrás de "Ver todas as partes" no celular), com
       um visto nas que a pessoa já leu até o fim;
     • cada publicação vira uma leitura confortável: título e subtítulo separados, letra
       grande, espaço entre parágrafos, vídeo que cabe na tela, imagem inteira, tabela que rola;
     • PDF: no celular o navegador não mostra PDF dentro da página — vira um botão grande
       "Abrir o documento" (no computador continua dentro da página, com o mesmo botão);
     • arquivos para baixar viram cartões com o nome e "Baixar";
     • "Ouvir": a voz do próprio celular lê o conteúdo (para quem tem dificuldade de leitura);
     • a equipe (quando a publicação pede) vira cartões com foto, função, e-mail e telefone
       que LIGAM com um toque;
     • no fim, "Próxima parte" e "Parte anterior" — o caminho segue sem voltar ao menu.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada e não muda o que aparece: as consultas, os filtros por empresa/filial/
     setor/cargo/painel, a validade das publicações, a categoria escolhida e os arquivos
     (getBlogImg, RENDER_PDF) são os da página. Os links das partes são os MESMOS links da
     lista "Categorias" original. Tirou as URLs: volta o de antes.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 2500 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Onboarding.js
     Página 2500 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Onboarding.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [O1] Como a página é reconhecida                                      CUIDADO
     [O2] Os textos                                                        PODE MEXER
     [O3] Ferramentas e ícones
     [O4] As partes (lê a lista "Categorias")                              CUIDADO
     [O5] O caminho: cabeçalho, barra, lista e "próxima parte"
     [O6] Cada publicação (título, mídia, PDF, arquivos, texto)            CUIDADO
     [O7] Ouvir
     [O8] A equipe (região "Time")                                         CUIDADO
     [O9] O maestro
*/
(function () {
  'use strict';
  if (window.__ncOnboarding || !window.apex || !window.apex.jQuery) return;

  /* ═══ [O1] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════════
     CUIDADO  pelos itens P2500_COD_CATEGORIA e pela região PUBLICACOES (static id), não pelo
              número da página. A lista de partes: a região CATEGORIAS (static id).
              As publicações: os blocos .publicacao que a região PL/SQL escreve.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  if (!$id('P2500_COD_CATEGORIA') || !$id('PUBLICACOES')) return;
  window.__ncOnboarding = true;
  var $ = window.apex.jQuery;

  /* ═══ [O2] OS TEXTOS ═════════════════════════════════════════════════════════════════════
     PODE MEXER  tudo daqui. Frases curtas, palavras do dia a dia.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T = {
    titulo: 'Seus primeiros passos',
    parte: function (i, n) { return 'Parte ' + i + ' de ' + n; },
    vistas: function (v, n) { return v === n ? 'Você viu todas' : v + (v === 1 ? ' vista' : ' vistas'); },
    verTodas: 'Ver todas as partes',
    esconderTodas: 'Esconder as partes',
    partesTit: 'As partes',
    proxima: 'Próxima parte',
    anterior: 'Parte anterior',
    fimTit: 'Você chegou ao fim!',
    fimTxt: 'Você viu todas as partes. Pode voltar a qualquer uma quando quiser.',
    faltam: function (n) { return n === 1 ? 'Falta 1 parte para você ver.' : 'Faltam ' + n + ' partes para você ver.'; },
    irFalta: 'Ver o que falta',
    vazioTit: 'Ainda não há instruções para você',
    vazioTxt: 'Quando a empresa publicar as instruções do seu começo, elas aparecem aqui.',
    ouvir: 'Ouvir', parar: 'Parar',
    pdfTit: 'Documento em PDF',
    pdfAbrir: 'Abrir o documento',
    arquivosTit: 'Arquivos para baixar',
    baixar: 'Baixar',
    equipeTit: 'Sua equipe',
    equipeTxt: 'Estas são as pessoas que trabalham com você. Toque no telefone para ligar.',
    ligar: 'Ligar', escrever: 'Mandar e-mail'
  };

  /* ═══ [O3] FERRAMENTAS E ÍCONES ══════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/\s+/g, ' ').trim(); }
  var IC = {
    passos: '<path d="M5 19.5c1.5 0 2.5-1 2.5-2.5S6.5 14 5 14s-2 1.4-2 3 1 2.5 2 2.5zM10 12.5c1.4 0 2.3-1 2.3-2.3S11.4 7.5 10 7.5 8 8.8 8 10.2s.9 2.3 2 2.3z"/><path d="M14.5 20.5h6M17.5 17.5l3 3-3 3" transform="translate(0 -3)"/>',
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>',
    seta: '<path d="M5 12h13M13 6.5l5.5 5.5-5.5 5.5"/>',
    voltar: '<path d="M19 12H6M11 6.5L5.5 12l5.5 5.5"/>',
    baixo: '<path d="M6.5 9.5l5.5 5.5 5.5-5.5"/>',
    som: '<path d="M4.5 9.5h3l4.5-4v13l-4.5-4h-3z"/><path d="M15.5 9a4.2 4.2 0 0 1 0 6M18 6.5a7.8 7.8 0 0 1 0 11"/>',
    parar: '<rect x="7" y="7" width="10" height="10" rx="1.5"/>',
    pdf: '<path d="M7 3.5h7l4.5 4.5v12a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1v-15.5a1 1 0 0 1 1-1z"/><path d="M14 3.5V8h4.5M9 13h6M9 16.5h6"/>',
    arquivo: '<path d="M7 3.5h7l4.5 4.5v12a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1v-15.5a1 1 0 0 1 1-1z"/><path d="M14 3.5V8h4.5"/>',
    baixar: '<path d="M12 4.5v10.5M7.5 10.5L12 15l4.5-4.5M5 19.5h14"/>',
    abrir: '<path d="M14 4.5h5.5V10M19.5 4.5L11 13"/><path d="M18 14v4.5a1 1 0 0 1-1 1H6a1 1 0 0 1-1-1V7.5a1 1 0 0 1 1-1h4.5"/>',
    fone: '<path d="M6.5 4h3l1.5 4-2 1.3a10 10 0 0 0 5.7 5.7l1.3-2 4 1.5v3a1.5 1.5 0 0 1-1.6 1.5A15.5 15.5 0 0 1 5 5.6 1.5 1.5 0 0 1 6.5 4z"/>',
    email: '<rect x="3.5" y="5.5" width="17" height="13" rx="2"/><path d="M4 7l8 6 8-6"/>',
    estrela: '<path d="M12 4l2.4 5 5.4.6-4 3.7 1.1 5.4L12 16l-4.9 2.7 1.1-5.4-4-3.7 5.4-.6z"/>',
    caminho: '<circle cx="6" cy="18" r="2.2"/><circle cx="18" cy="6" r="2.2"/><path d="M8.2 18H15a3 3 0 0 0 0-6H9a3 3 0 0 1 0-6h6.8"/>',
    festa: '<path d="M4 20l4.5-12 7.5 7.5z"/><path d="M13 5.5c.8-.8 2-1 2.5-.5M17 9c1-.3 2.2 0 2.5.6M15.5 3.5v.5M20.5 6.5h-.5M19 12.5v.5"/>'
  };
  function ic(n, cls) { return '<svg class="nc-ob-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  function ler(k) { try { return JSON.parse(localStorage.getItem(k) || 'null'); } catch (e) { return null; } }
  function guardar(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); } catch (e) { /* sem armazenamento: segue sem vistos */ } }

  /* ═══ [O4] AS PARTES ═════════════════════════════════════════════════════════════════════
     CUIDADO  lidas da lista "Categorias" (região CATEGORIAS, List View): o texto do link e o
              código em "P2500_COD_CATEGORIA:<cod>". A consulta dela tem "distinct" com o seq
              da publicação: a MESMA categoria pode vir repetida — aqui fica uma vez só, na
              ordem em que aparece (a ordem da página: o.ordem).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PARTES = [], ATUAL = -1;
  function lerPartes() {
    var vistos = {};
    [].forEach.call(document.querySelectorAll('#CATEGORIAS a[href]'), function (a) {
      var href = a.getAttribute('href'), m = /P2500_COD_CATEGORIA:([^&:]+)/.exec(href);
      var cod = m ? decodeURIComponent(m[1]) : href;
      if (vistos[cod]) return;
      vistos[cod] = 1;
      PARTES.push({ cod: String(cod), nome: limpo(a.textContent), href: href });
    });
    var atual = String(apex.item('P2500_COD_CATEGORIA').getValue() || '');
    PARTES.forEach(function (p, i) { if (p.cod === atual) ATUAL = i; });
  }
  /* os vistos ficam no aparelho (por empresa, para quem usa o mesmo celular em vínculos diferentes) */
  var CHAVE_VISTAS = 'nc-ob-vistas:' + (apex.item('P2500_COD_EMPRESA').getValue() || '');
  function vistas() { return ler(CHAVE_VISTAS) || {}; }
  function marcarVista(cod) { var v = vistas(); if (v[cod]) return false; v[cod] = Date.now(); guardar(CHAVE_VISTAS, v); return true; }

  /* ═══ [O5] O CAMINHO ═════════════════════════════════════════════════════════════════════ */
  var RAIZ, LEITURA, LISTA, BT_TODAS;
  function montarCaminho() {
    var pub = $id('PUBLICACOES');
    RAIZ = el('div', 'nc-ob');
    pub.parentNode.insertBefore(RAIZ, pub);
    var n = PARTES.length, atual = PARTES[ATUAL];
    var nav = el('nav', 'nc-ob-partes');
    nav.setAttribute('aria-label', T.partesTit);
    nav.innerHTML = '<p class="nc-ob-partes-tit">' + ic('caminho') + esc(T.partesTit) + '</p><ol class="nc-ob-lista" id="nc-ob-lista"></ol>';
    LISTA = nav.querySelector('.nc-ob-lista');
    LEITURA = el('div', 'nc-ob-leitura');
    var cab = el('header', 'nc-ob-cab');
    cab.innerHTML =
      (atual ? '<span class="nc-ob-pilula">' + esc(T.parte(ATUAL + 1, n)) + '</span>' : '') +
      '<h2 class="nc-ob-parte-tit">' + esc(atual ? atual.nome : (apex.item('P2500_TITULO').getValue() || T.titulo)) + '</h2>' +
      (n > 1 ? '<div class="nc-ob-barra" aria-hidden="true">' + PARTES.map(function (p, i) { return '<span data-i="' + i + '"></span>'; }).join('') + '</div>' : '') +
      (n > 1 ? '<button type="button" class="nc-ob-bt-todas" aria-expanded="false" aria-controls="nc-ob-lista">' + ic('caminho') + '<span>' + esc(T.verTodas) + '</span><b class="nc-ob-conta"></b>' + ic('baixo', 'nc-ob-ic-gira') + '</button>' : '');
    LEITURA.appendChild(cab);
    if (n > 1) RAIZ.appendChild(nav);
    RAIZ.appendChild(LEITURA);
    RAIZ.classList.toggle('nc-ob--sem-partes', n < 2);
    BT_TODAS = cab.querySelector('.nc-ob-bt-todas');
    if (BT_TODAS) BT_TODAS.addEventListener('click', function () {
      var abre = BT_TODAS.getAttribute('aria-expanded') !== 'true';
      BT_TODAS.setAttribute('aria-expanded', String(abre));
      BT_TODAS.querySelector('span').textContent = abre ? T.esconderTodas : T.verTodas;
      RAIZ.classList.toggle('nc-ob--lista-aberta', abre);
    });
    desenharLista();
  }
  function desenharLista() {
    var v = vistas(), n = PARTES.length, quantas = PARTES.filter(function (p) { return v[p.cod]; }).length;
    LISTA.innerHTML = PARTES.map(function (p, i) {
      var cls = (i === ATUAL ? ' is-atual' : '') + (v[p.cod] ? ' is-vista' : '');
      return '<li><a class="nc-ob-item' + cls + '" href="' + esc(p.href) + '"' + (i === ATUAL ? ' aria-current="page"' : '') + '>' +
        '<span class="nc-ob-n" aria-hidden="true">' + (v[p.cod] && i !== ATUAL ? ic('check') : (i + 1)) + '</span>' +
        '<span class="nc-ob-item-nome">' + esc(p.nome) + (v[p.cod] ? '<span class="nc-ob-so-leitor"> (vista)</span>' : '') + '</span></a></li>';
    }).join('');
    [].forEach.call(RAIZ.querySelectorAll('.nc-ob-barra span'), function (s) {
      var i = +s.getAttribute('data-i');
      s.className = (i === ATUAL ? 'is-atual' : '') + (v[PARTES[i].cod] ? ' is-vista' : '');
    });
    var conta = RAIZ.querySelector('.nc-ob-conta'); if (conta) conta.textContent = T.vistas(quantas, n);
  }
  /* no fim da leitura: anterior / próxima (ou o fim do caminho) */
  function montarSeguir() {
    var n = PARTES.length; if (n < 2 || ATUAL < 0) return;
    var box = el('div', 'nc-ob-seguir');
    LEITURA.appendChild(box);
    desenharSeguir(box);
    /* chegou ao fim da leitura → a parte conta como vista */
    if ('IntersectionObserver' in window) {
      var io = new IntersectionObserver(function (es) {
        if (!es.some(function (e) { return e.isIntersecting; })) return;
        io.disconnect();
        if (marcarVista(PARTES[ATUAL].cod)) { desenharLista(); desenharSeguir(box); }
      }, { threshold: 0.6 });
      io.observe(box);
    } else { marcarVista(PARTES[ATUAL].cod); }
  }
  function desenharSeguir(box) {
    var n = PARTES.length, ant = PARTES[ATUAL - 1], prox = PARTES[ATUAL + 1], v = vistas();
    var faltam = PARTES.filter(function (p) { return !v[p.cod]; });
    var h = '';
    if (prox) {
      h += '<a class="nc-ob-bt nc-ob-bt--prox" href="' + esc(prox.href) + '"><span><small>' + esc(T.proxima) + '</small>' + esc(prox.nome) + '</span>' + ic('seta') + '</a>';
    } else if (!faltam.length) {
      h += '<div class="nc-ob-fim">' + ic('festa') + '<span><b>' + esc(T.fimTit) + '</b>' + esc(T.fimTxt) + '</span></div>';
    } else {
      var primeira = faltam.filter(function (p) { return p !== PARTES[ATUAL]; })[0];
      h += '<div class="nc-ob-fim nc-ob-fim--falta"><span><b>' + esc(T.faltam(faltam.length)) + '</b></span>' +
        (primeira ? '<a class="nc-ob-bt nc-ob-bt--prox" href="' + esc(primeira.href) + '"><span><small>' + esc(T.irFalta) + '</small>' + esc(primeira.nome) + '</span>' + ic('seta') + '</a>' : '') + '</div>';
    }
    if (ant) h += '<a class="nc-ob-bt nc-ob-bt--ant" href="' + esc(ant.href) + '">' + ic('voltar') + '<span><small>' + esc(T.anterior) + '</small>' + esc(ant.nome) + '</span></a>';
    box.innerHTML = h;
  }

  /* ═══ [O6] CADA PUBLICAÇÃO ═══════════════════════════════════════════════════════════════
     CUIDADO  o que a região PL/SQL "Publicações" escreve, por publicação:
                div.publicacao#publicacao_<seq>
                  .titulo > h2 (o título; o subtítulo vem depois, em <i> - <font>…</font></i>)
                  .video > video   |  .imagem > img   |  .imagem > iframe (PDF, RENDER_PDF)
                  <h8>Anexos:</h8> .download > a (outros arquivos)
                  .descricao (texto_html)  .descricao (descrição, com #NOME_COLAB etc. trocados)
              Se a região mudar essas classes, a publicação continua aparecendo como antes.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tituloDe(h2) {
    var c = h2.cloneNode(true), i = c.querySelector('i'), sub = '';
    if (i) { sub = limpo(i.textContent).replace(/^[-–—]\s*/, ''); i.remove(); }
    return { tit: limpo(c.textContent), sub: sub };
  }
  function nomeArquivo(a) { return limpo((a.querySelector('.text_link') || a).textContent) || 'Arquivo'; }
  function extensao(nome) { var m = /\.([a-z0-9]{2,5})$/i.exec(nome); return m ? m[1].toUpperCase() : ''; }
  function vestirPublicacao(pub, k, total) {
    pub.classList.add('nc-ob-pub');
    /* título e subtítulo */
    var tit = pub.querySelector('.titulo'), h2 = tit && tit.querySelector('h2');
    var t = h2 ? tituloDe(h2) : { tit: '', sub: '' };
    var cab = el('header', 'nc-ob-pub-cab');
    cab.innerHTML = (t.tit ? '<h3 class="nc-ob-pub-tit">' + esc(t.tit) + '</h3>' : '') +
      (t.sub ? '<p class="nc-ob-pub-sub">' + esc(t.sub) + '</p>' : '') + botaoOuvir();
    if (tit) { tit.classList.add('nc-ob-guardado'); tit.parentNode.insertBefore(cab, tit.nextSibling); }
    else pub.insertBefore(cab, pub.firstChild);
    /* vídeo enviado (video): proporção certa; nada de baixar com o botão direito (a página já faz) */
    [].forEach.call(pub.querySelectorAll('.video video'), function (v) { v.removeAttribute('height'); v.setAttribute('playsinline', ''); v.setAttribute('preload', 'metadata'); });
    /* PDF: o botão grande (no celular é o único jeito de ver) */
    [].forEach.call(pub.querySelectorAll('.imagem iframe'), function (f) {
      var src = f.getAttribute('src') || '';
      if (!/RENDER_PDF|application\/pdf|\.pdf/i.test(src + (f.getAttribute('type') || ''))) return;
      var box = f.parentNode; box.classList.add('nc-ob-pdf');
      var bt = el('a', 'nc-ob-pdf-bt', '<span class="nc-ob-pdf-ic">' + ic('pdf') + '</span><span class="nc-ob-pdf-txt"><b>' + esc(T.pdfTit) + '</b>' + esc(T.pdfAbrir) + '</span>' + ic('abrir', 'nc-ob-pdf-seta'));
      bt.href = src; bt.target = '_blank'; bt.rel = 'noopener';
      box.insertBefore(bt, f);
    });
    /* arquivos para baixar: um título só e um cartão por arquivo */
    var dls = pub.querySelectorAll('.download');
    [].forEach.call(pub.querySelectorAll('h8'), function (h) { h.classList.add('nc-ob-guardado'); });
    if (dls.length) {
      var tdl = el('p', 'nc-ob-arquivos-tit', esc(T.arquivosTit));
      dls[0].parentNode.insertBefore(tdl, dls[0]);
      [].forEach.call(dls, function (d) {
        var a = d.querySelector('a'); if (!a) return;
        var nome = nomeArquivo(a), ext = extensao(nome);
        d.classList.add('nc-ob-arquivo');
        a.innerHTML = '<span class="nc-ob-arquivo-ic">' + ic('arquivo') + (ext ? '<b>' + esc(ext) + '</b>' : '') + '</span>' +
          '<span class="nc-ob-arquivo-nome">' + esc(nome) + '</span><span class="nc-ob-arquivo-acao">' + ic('baixar') + esc(T.baixar) + '</span>';
      });
    }
    /* o texto: parágrafos vazios saem; vídeos de fora (YouTube…) e tabelas cabem na tela */
    [].forEach.call(pub.querySelectorAll('.descricao'), function (d) {
      d.classList.add('nc-ob-texto');
      [].forEach.call(d.querySelectorAll('p, div'), function (p) {
        if (!limpo(p.textContent.replace(/ /g, ' ')) && !p.querySelector('img, iframe, video, table, hr, br + br')) p.classList.add('nc-ob-vazio');
      });
      [].forEach.call(d.querySelectorAll('iframe'), function (f) {
        f.classList.add('nc-ob-embed'); f.removeAttribute('width'); f.removeAttribute('height');
        if (!f.getAttribute('title')) f.setAttribute('title', 'Vídeo');
      });
      [].forEach.call(d.querySelectorAll('table'), function (tb) {
        if (tb.parentNode.classList.contains('nc-ob-tabela')) return;
        var w = el('div', 'nc-ob-tabela'); tb.parentNode.insertBefore(w, tb); w.appendChild(tb);
      });
      [].forEach.call(d.querySelectorAll('a[href]'), function (a) { if (/^https?:/i.test(a.getAttribute('href')) && a.host !== location.host) { a.target = '_blank'; a.rel = 'noopener'; } });
    });
    /* a linha entre publicações (hr.style) sai: os cartões já separam */
    var hr = pub.nextElementSibling; if (hr && hr.tagName === 'HR') hr.classList.add('nc-ob-guardado');
  }

  /* ═══ [O7] OUVIR ═════════════════════════════════════════════════════════════════════════
     A voz do próprio aparelho (speechSynthesis, em português) lê o título e o texto. Lê em
     pedaços (frases): textos longos de uma vez só param no meio em alguns celulares.
     Sem voz no aparelho, o botão não aparece. Tocar de novo (ou sair da página) para.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FALA = window.speechSynthesis || null, FALANDO = null;
  function botaoOuvir() { return FALA ? '<button type="button" class="nc-ob-ouvir" aria-pressed="false">' + ic('som') + '<span>' + esc(T.ouvir) + '</span></button>' : ''; }
  function marca(b, on) { if (!b) return; b.setAttribute('aria-pressed', String(on)); b.innerHTML = ic(on ? 'parar' : 'som') + '<span>' + esc(on ? T.parar : T.ouvir) + '</span>'; }
  function parar() { if (FALA) FALA.cancel(); marca(FALANDO, false); FALANDO = null; }
  function textoParaOuvir(pub) {
    var partes = [];
    var cab = pub.querySelector('.nc-ob-pub-cab');
    if (cab) [].forEach.call(cab.querySelectorAll('.nc-ob-pub-tit, .nc-ob-pub-sub'), function (x) { partes.push(limpo(x.textContent)); });
    [].forEach.call(pub.querySelectorAll('.nc-ob-texto'), function (d) {
      var c = d.cloneNode(true);
      [].forEach.call(c.querySelectorAll('script, style, iframe, nav, .nc-ob-vazio'), function (x) { x.remove(); });
      [].forEach.call(c.querySelectorAll('p, li, h1, h2, h3, h4, h5, h6, div, br, tr'), function (x) { x.insertAdjacentText('afterend', '. '); });
      partes.push(limpo(c.textContent));
    });
    return partes.join('. ').replace(/(\.\s*){2,}/g, '. ').replace(/\s+\./g, '.');
  }
  function pedacos(txt) {
    var frases = txt.match(/[^.!?;:]+[.!?;:]*/g) || [txt], out = [], cur = '';
    frases.forEach(function (f) { if ((cur + f).length > 220 && cur) { out.push(cur); cur = f; } else cur += f; });
    if (limpo(cur)) out.push(cur);
    return out.map(limpo).filter(Boolean);
  }
  function ouvir(b) {
    if (!FALA) return;
    var era = FALANDO === b;
    parar();
    if (era) return;
    var lista = pedacos(textoParaOuvir(b.closest('.publicacao')));
    if (!lista.length) return;
    var voz = FALA.getVoices().filter(function (v) { return /^pt(-|_)?br/i.test(v.lang); })[0];
    FALANDO = b; marca(b, true);
    lista.forEach(function (t, i) {
      var u = new SpeechSynthesisUtterance(t);
      u.lang = 'pt-BR'; u.rate = 0.92; if (voz) u.voice = voz;
      if (i === lista.length - 1) u.onend = function () { if (FALANDO === b) { marca(b, false); FALANDO = null; } };
      u.onerror = function () { if (FALANDO === b) { marca(b, false); FALANDO = null; } };
      FALA.speak(u);
    });
  }

  /* ═══ [O8] A EQUIPE (região "Time") ══════════════════════════════════════════════════════
     CUIDADO  só aparece quando a página mostra (publicação com "mostrar time"). Cada pessoa
              é lida da coluna NOME_CARGO: <h4><strong>Nome</strong><small> | SUPERIOR </small>
              …</h4><b>CARGO</b> e linhas com ícone de e-mail e telefone ("(11) 99999-9999 -
              Celular"), e a foto da coluna FOTO (img.fotoColabSmall). Se não achar ninguém,
              a região fica como é.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function bonito(t) {
    t = limpo(t); if (!t || t !== t.toUpperCase()) return t;
    return t.toLowerCase().replace(/[^\s\-\/().]+/g, function (w, i) {
      if (i > 0 && /^(da|de|do|das|dos|e|em|na|no)$/.test(w)) return w;
      if (!/[aeiouáéíóúâêôãõà]/.test(w)) return w.toUpperCase();
      return w.charAt(0).toUpperCase() + w.slice(1);
    });
  }
  function lerPessoa(linha) {
    var h4 = linha.querySelector('h4'); if (!h4) return null;
    var nome = limpo((h4.querySelector('strong') || h4).textContent);
    var papel = limpo((h4.querySelector('small') || {}).textContent || '').replace(/^\|\s*/, '');
    var bloco = h4.closest('td, div, li') || linha;
    var cargo = limpo((bloco.querySelector('h4 ~ b, p ~ b, b') || {}).textContent || '');
    var html = bloco.innerHTML, email = '', fones = [];
    var me = /fa-envelope[^>]*><\/span>\s*([^<\s]+@[^<\s]+)/i.exec(html); if (me) email = me[1];
    var re = /fa-phone[^>]*><\/span>\s*([^<]+?)\s*(?:<br|$)/gi, m;
    while ((m = re.exec(html))) {
      var linhaF = limpo(m[1].replace(/&nbsp;/g, ' ')), num = (/^([()\d\s\-]+)/.exec(linhaF) || [])[1] || '';
      var rot = limpo(linhaF.slice(num.length).replace(/^[-–]\s*/, ''));
      var dig = num.replace(/\D/g, '');
      if (dig.length >= 8) fones.push({ txt: limpo(num).replace(/[\s\-]+$/, ''), rot: rot, tel: dig });
    }
    var img = linha.querySelector('img.fotoColabSmall');
    return { nome: nome, papel: bonito(papel), cargo: bonito(cargo), email: email, fones: fones, foto: img ? img.getAttribute('src') : '' };
  }
  function iniciais(nome) { var p = limpo(nome).split(' ').filter(function (w) { return w && !/^(da|de|do|das|dos|e)$/i.test(w); }); return ((p[0] || '?').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  function montarEquipe() {
    var regiao = [].filter.call(document.querySelectorAll('.t-Region'), function (r) { return r.querySelector('img.fotoColabSmall') && r.id !== 'PUBLICACOES'; })[0];
    if (!regiao) return;
    var vistos = [], pessoas = [];
    [].forEach.call(regiao.querySelectorAll('img.fotoColabSmall'), function (img) {
      var linha = img; while (linha && linha !== regiao && !linha.querySelector('h4')) linha = linha.parentNode;
      if (!linha || linha === regiao || vistos.indexOf(linha) >= 0) return;
      vistos.push(linha);
      var p = lerPessoa(linha); if (p && p.nome) pessoas.push(p);
    });
    if (!pessoas.length) return;
    var box = el('section', 'nc-ob-equipe');
    box.setAttribute('aria-labelledby', 'nc-ob-equipe-tit');
    box.innerHTML = '<h3 id="nc-ob-equipe-tit" class="nc-ob-equipe-tit">' + esc(T.equipeTit) + '</h3><p class="nc-ob-equipe-txt">' + esc(T.equipeTxt) + '</p>' +
      '<ul class="nc-ob-pessoas">' + pessoas.map(function (p) {
        var semFoto = !p.foto || /PROFILE\.jpg/i.test(p.foto);
        return '<li class="nc-ob-pessoa' + (p.papel ? ' nc-ob-pessoa--lider' : '') + '">' +
          '<div class="nc-ob-pessoa-cab">' +
            (semFoto ? '<span class="nc-ob-foto nc-ob-foto--ini" aria-hidden="true">' + esc(iniciais(p.nome)) + '</span>' : '<img class="nc-ob-foto" alt="" src="' + esc(p.foto) + '">') +
            '<div><b class="nc-ob-pessoa-nome">' + esc(bonito(p.nome)) + '</b>' +
            (p.papel ? '<span class="nc-ob-papel">' + ic('estrela') + esc(p.papel) + '</span>' : '') +
            (p.cargo ? '<span class="nc-ob-pessoa-cargo">' + esc(p.cargo) + '</span>' : '') + '</div></div>' +
          ((p.fones.length || p.email) ? '<div class="nc-ob-contatos">' +
            p.fones.map(function (f) { return '<a class="nc-ob-contato" href="tel:' + esc(f.tel) + '">' + ic('fone') + '<span><b>' + esc(f.txt) + '</b>' + esc(f.rot || T.ligar) + '</span></a>'; }).join('') +
            (p.email ? '<a class="nc-ob-contato" href="mailto:' + esc(p.email) + '">' + ic('email') + '<span><b>' + esc(p.email) + '</b>' + esc(T.escrever) + '</span></a>' : '') +
          '</div>' : '') + '</li>';
      }).join('') + '</ul>';
    regiao.classList.add('nc-ob-guardado');
    regiao.parentNode.insertBefore(box, regiao);
    return box;
  }

  /* ═══ [O9] O MAESTRO ═════════════════════════════════════════════════════════════════════
     A coluna da esquerda (a lista "Categorias") sai: as partes entram na própria leitura.
     A página passa a ser "sem coluna lateral" (as classes do tema), e o tema recalcula o
     recuo do conteúdo. Monta depois das ações de abertura (apexreadyend), com reserva de 3 s.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function semColunaLateral() {
    var b = document.body;
    var tira = function () { if (b.classList.contains('t-PageBody--showLeft')) { b.classList.remove('t-PageBody--showLeft'); b.classList.add('t-PageBody--hideLeft'); } };
    tira();
    /* o tema pode devolver a classe ao redimensionar: devolve-se o "sem coluna" */
    if ('MutationObserver' in window) new MutationObserver(tira).observe(b, { attributes: true, attributeFilter: ['class'] });
  }
  var montado = false;
  function iniciar() {
    if (montado) return;
    montado = true;
    try {
      document.body.classList.add('nc-ob-ativo');
      lerPartes();
      var heroTit = document.querySelector('.t-HeroRegion-title');
      if (heroTit) heroTit.textContent = T.titulo;
      montarCaminho();
      var pubReg = $id('PUBLICACOES');
      LEITURA.appendChild(pubReg);
      var pubs = pubReg.querySelectorAll('.publicacao');
      [].forEach.call(pubs, function (p, k) { vestirPublicacao(p, k, pubs.length); });
      if (!pubs.length) {
        var vazio = el('div', 'nc-ob-vazio-box', ic('caminho') + '<b>' + esc(T.vazioTit) + '</b><span>' + esc(T.vazioTxt) + '</span>');
        LEITURA.appendChild(vazio);
      }
      var eq = montarEquipe(); if (eq) LEITURA.appendChild(eq);
      montarSeguir();
      semColunaLateral();
      RAIZ.addEventListener('click', function (e) { var b = e.target.closest('.nc-ob-ouvir'); if (b) ouvir(b); });
      window.addEventListener('pagehide', parar);
      /* o tema mede a barra de título (o herói) para recuar o conteúdo */
      setTimeout(function () {
        window.dispatchEvent(new Event('resize')); $(window).trigger('apexwindowresized');
        /* a lista das partes (computador) gruda abaixo do menu e da barra de título */
        var topo = 0; [].forEach.call(document.querySelectorAll('.t-Header, .t-Body-title'), function (x) { if (getComputedStyle(x).position === 'fixed') topo += x.offsetHeight; });
        if (topo) RAIZ.style.setProperty('--nc-ob-topo', topo + 'px');
      }, 60);
    } catch (e) { if (window.console) console.error('Natcorp_Onboarding', e); }
  }
  $(window).one('apexreadyend', iniciar);
  $(function () { setTimeout(iniciar, 3000); });
})();
