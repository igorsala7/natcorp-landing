/**
 * apex-iframe-breakout.js
 * -----------------------------------------------------------------------------
 * Quando a aplicação APEX roda dentro de um <iframe>, força a navegação de
 * páginas (f?p=) a acontecer na janela principal (window.top).
 *
 * Uso sugerido:
 *   - Static Application File -> User Interface > JavaScript > File URLs:
 *       #APP_FILES#apex-iframe-breakout#MIN#.js
 *   - Ou colar o conteúdo em Page 0 / "Function and Global Variable Declaration".
 * -----------------------------------------------------------------------------
 */
(function () {
    "use strict";

    // -------------------------------------------------------------------------
    // Configuração
    // -------------------------------------------------------------------------
    var CONFIG = {
        // Links que devem sair do iframe.
        // Para Friendly URLs, acrescente: ', a[href*="/r/"]'
        linkSelector: 'a[href*="f?p="]',

        // Links que NUNCA devem ser interceptados.
        // 'javascript:' é essencial: é assim que o APEX abre modais.
        ignoreSelector: [
            '[href^="javascript:"]',
            '[href^="#"]',
            '[target="_blank"]',
            '[target="_top"]',
            '[data-no-breakout]',
            '.js-dialog',
            '[data-dialog]'
        ].join(","),

        // Interceptar também apex.navigation.redirect (Dynamic Action "Navigate to URL").
        patchRedirect: true,

        debug: false
    };

    // Fora de iframe: nada a fazer.
    if (window.self === window.top) {
        return;
    }

    function log() {
        if (CONFIG.debug && window.console) {
            console.log.apply(console, ["[iframe-breakout]"].concat([].slice.call(arguments)));
        }
    }

    // -------------------------------------------------------------------------
    // Helpers
    // -------------------------------------------------------------------------

    /**
     * Converte para URL absoluta usando a URL corrente completa como base
     * (preserva o contexto do ORDS, ex.: /ords/f).
     * Retorna null se a URL for inválida ou de esquema não navegável.
     */
    function toAbsoluteUrl(url) {
        var abs;
        if (typeof url !== "string" || url === "") {
            return null;
        }
        try {
            abs = new URL(url, window.location.href).href;
        } catch (e) {
            log("URL inválida:", url, e);
            return null;
        }
        // Bloqueia javascript:, mailto:, data:, tel: etc.
        return /^https?:/i.test(abs) ? abs : null;
    }

    /**
     * Navega a janela de topo. Retorna true se assumiu a navegação.
     * Em iframe cross-origin, escrever em window.top.location lança SecurityError.
     */
    function navigateTop(url) {
        var abs = toAbsoluteUrl(url);

        if (!abs) {
            return false;
        }

        try {
            window.top.location.href = abs;
            log("top ->", abs);
            return true;
        } catch (e) {
            log("window.top bloqueado (cross-origin), tentando window.open", e);
            try {
                // Costuma funcionar quando há user activation (clique).
                if (window.open(abs, "_top")) {
                    return true;
                }
            } catch (e2) {
                log("window.open falhou", e2);
            }
            // Degradação segura: navega dentro do próprio frame.
            window.location.href = abs;
            return true;
        }
    }

    // -------------------------------------------------------------------------
    // 1) Interceptação de cliques (delegação: pega conteúdo criado via AJAX)
    // -------------------------------------------------------------------------
    document.addEventListener("click", function (event) {
        var link;

        // Respeita botão do meio, Ctrl/Cmd/Shift/Alt (abrir em nova aba etc.).
        if (event.button !== 0 || event.ctrlKey || event.metaKey || event.shiftKey || event.altKey) {
            return;
        }

        link = event.target.closest(CONFIG.linkSelector);

        if (!link || link.matches(CONFIG.ignoreSelector)) {
            return;
        }

        if (navigateTop(link.getAttribute("href"))) {
            event.preventDefault();
            event.stopPropagation();
        }
    }, true); // CAPTURA: roda antes dos handlers do Interactive Grid

    // -------------------------------------------------------------------------
    // 2) apex.navigation.dialog.close( pIsModal, pAction )
    // -------------------------------------------------------------------------
    function patchDialogClose() {
        var original;

        if (!window.apex || !apex.navigation || !apex.navigation.dialog) {
            return false;
        }

        original = apex.navigation.dialog.close;

        if (typeof original !== "function") {
            return false;
        }

        // Evita empilhar wrappers se o script rodar mais de uma vez.
        if (original.__breakoutPatched) {
            return true;
        }

        function patched(pIsModal, pAction) {
            if (typeof pAction === "string" && pAction.indexOf("f?p=") !== -1) {
                if (navigateTop(pAction)) {
                    return;
                }
            }
            // Função, objeto, ou URL não navegável -> comportamento padrão.
            return original.apply(this, arguments);
        }

        patched.__breakoutPatched = true;
        apex.navigation.dialog.close = patched;
        log("apex.navigation.dialog.close interceptado");
        return true;
    }

    // -------------------------------------------------------------------------
    // 3) apex.navigation.redirect( pWhere )  [opcional]
    // -------------------------------------------------------------------------
    function patchRedirect() {
        var original;

        if (!CONFIG.patchRedirect || !window.apex || !apex.navigation) {
            return false;
        }

        original = apex.navigation.redirect;

        if (typeof original !== "function") {
            return false;
        }

        if (original.__breakoutPatched) {
            return true;
        }

        function patched(pWhere) {
            if (typeof pWhere === "string" && pWhere.indexOf("f?p=") !== -1) {
                if (navigateTop(pWhere)) {
                    return;
                }
            }
            return original.apply(this, arguments);
        }

        patched.__breakoutPatched = true;
        apex.navigation.redirect = patched;
        log("apex.navigation.redirect interceptado");
        return true;
    }

    // -------------------------------------------------------------------------
    // Bootstrap: tenta agora; se apex ainda não existir, tenta no DOM ready.
    // -------------------------------------------------------------------------
    function applyPatches() {
        patchDialogClose();
        patchRedirect();
    }

    applyPatches();

    if (!window.apex || !apex.navigation) {
        document.addEventListener("DOMContentLoaded", applyPatches);
    }
}());


/* Natcorp — troca o alert() do navegador pela caixa do APEX (apex.message.alert), que o
   Natcorp_Login.css desenha com a identidade da marca.

   Vale para a página E PARA TUDO O QUE ELA ABRE EM IFRAME no mesmo domínio (as outras
   aplicações do painel, as modais): basta carregar este arquivo na aplicação principal.
   A caixa abre sempre na janela DE CIMA — centrada na tela inteira e com o CSS da marca,
   mesmo quando a aplicação de dentro não tem o APEX ou a folha Natcorp.

   Duas camadas:
   1. Na janela onde o arquivo carrega, a troca é imediata — vale inclusive para o alert()
      chamado ao abrir a página.
   2. Nos iframes que NÃO carregam o arquivo, uma varredura a cada 25 ms troca o alert de
      cada página nova. Pega todo alert disparado por clique/ação; um alert disparado no
      instante em que a página do iframe abre pode escapar (a página às vezes termina de
      carregar antes da varredura passar). Para esse caso, o arquivo precisa carregar
      também dentro do iframe — por isso ele pode ir colado no fim do iframe_handling.js,
      que as aplicações de dentro já carregam.

   Diferença para o nativo: a página NÃO para esperando o OK. */
(function () {
  'use strict';

  var MARCA = '__ncAlert';

  /* A janela mais alta que a gente consegue tocar e que tem o apex.message.
     Iframe de outro domínio lança erro ao ser tocado: aí fica a própria janela. */
  function janelaDaCaixa(w) {
    var melhor = null;
    try {
      for (var atual = w; atual; atual = atual === atual.parent ? null : atual.parent) {
        if (atual.apex && atual.apex.message && atual.apex.message.alert) melhor = atual;
      }
    } catch (e) { /* subiu até um pai de outro domínio */ }
    return melhor;
  }

  /* a marca vai no DOCUMENTO: a janela de um iframe pode ser reaproveitada na navegação,
     o documento nunca */
  function trocar(w) {
    try {
      if (!w || w.document[MARCA]) return;
      var nativo = w.alert;
      w.alert = function (mensagem) {
        var alvo = janelaDaCaixa(w);
        if (!alvo) return nativo.call(w, mensagem); // nenhum APEX à vista: o de sempre
        alvo.apex.message.alert(String(mensagem == null ? '' : mensagem), function () {});
      };
      w.document[MARCA] = true;
    } catch (e) { /* iframe de outro domínio: não é nosso */ }
  }

  /* Percorre os iframes (e os iframes dos iframes). Cada navegação traz um documento novo,
     sem a marca, e a varredura seguinte o troca (camada 2, acima). */
  function varrer(w) {
    trocar(w);
    var quadros;
    try { quadros = w.frames; } catch (e) { return; }
    for (var i = 0; i < quadros.length; i++) varrer(quadros[i]);
  }

  varrer(window);
  setInterval(function () { if (window.frames.length) varrer(window); }, 25);
})();



/* Natcorp — realce da área de soltar dos campos de arquivo (File Browse).
   O arrastar-e-soltar em si é do navegador (o Natcorp_Login.css estica o campo sobre a área);
   isto só liga as classes que o CSS usa:
     .is-dragover  — enquanto um arquivo passa por cima da área
     .tem-arquivo  — depois que um arquivo foi escolhido (por clique ou por soltar)
   Pode ir colado no fim do iframe_handling.js, como o Natcorp_Alert.js. */
(function () {
  'use strict';

  function area(e) {
    var t = e.target;
    return t && t.closest ? t.closest('.apex-item-group--file') : null;
  }

  ['dragenter', 'dragover'].forEach(function (tipo) {
    document.addEventListener(tipo, function (e) {
      var a = area(e);
      if (a) a.classList.add('is-dragover');
    }, true);
  });

  ['dragleave', 'drop'].forEach(function (tipo) {
    document.addEventListener(tipo, function (e) {
      var a = area(e);
      /* dragleave dispara ao passar para um filho: só apaga ao sair da área de verdade */
      if (a && (tipo === 'drop' || !a.contains(e.relatedTarget))) a.classList.remove('is-dragover');
    }, true);
  });

  document.addEventListener('change', function (e) {
    var i = e.target;
    if (!i || i.type !== 'file') return;
    var a = i.closest('.apex-item-group--file');
    if (a) a.classList.toggle('tem-arquivo', !!(i.files && i.files.length));
  }, true);
})();



/* Natcorp — o nome da página na barra de título, em TODAS as páginas.

   A barra de título (.t-Body-title) mostra o breadcrumb; página sem breadcrumb chegava com
   a barra vazia, e o nome dela só existia no <title> da aba. O caminho de modelo —
   <h1 class="nc-TituloPagina">#TITLE#</h1> no HTML de cada modelo de página — exige editar
   todos os modelos de todas as aplicações. Este script faz o mesmo em qualquer página:
   se a barra existe e não tem o título, ele cria o título com o nome da página (o
   atributo "Título" dela, que é o que vai para o <title>).

   Quem decide se o título APARECE continua sendo o Natcorp_Style_Min.css:
     · breadcrumb com itens na barra, ou qualquer outra região nela → some;
     · página com a classe nc-sem-titulo (Page › CSS Classes) → some;
     · página cujo conteúdo é um iframe → a barra fica fechada.
   Modelo que já tem a linha do <h1> não ganha um segundo.

   Roda na hora em que o arquivo carrega (o APEX põe os arquivos no fim da página, com a
   barra já montada): o tema mede a altura da barra DEPOIS, no carregamento, e o conteúdo
   já começa abaixo do título. Vai colado no iframe_handling.js. */
(function () {
  'use strict';

  if (window.__ncTitulo) return;
  window.__ncTitulo = true;

  function nomeDaPagina() {
    var t = (document.title || '').replace(/\s+/g, ' ').trim();
    /* "NATCORP - Cursos e Formações": a marca já está no cabeçalho */
    return t.replace(/^natcorp\s*[-–—|:]\s*/i, '');
  }

  function colocar() {
    var barra = document.getElementById('t_Body_title') || document.querySelector('.t-Body-title');
    if (!barra || barra.querySelector('.nc-TituloPagina')) return false;
    var nome = nomeDaPagina();
    if (!nome) return false;
    var h1 = document.createElement('h1');
    h1.className = 'nc-TituloPagina';
    h1.textContent = nome;
    barra.insertBefore(h1, barra.firstChild);
    return true;
  }

  if (colocar()) {
    /* se o tema já tinha medido a barra (arquivo carregado tarde), mede de novo */
    if (document.readyState === 'complete' && window.apex && apex.jQuery) {
      apex.jQuery(window).trigger('apexwindowresized');
    }
  } else if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', colocar);
  }
})();



/* Natcorp — contador entre colchetes nos itens da barra do topo.

   Aplicações que mostram uma contagem no nome do item da barra de navegação escrevem o
   rótulo como "[&P0_QTD_ALERTAS.] Alertas". Com o item vazio, chegava "[] Alertas" na
   tela (Chamados); com número, "[3] Alertas" — os colchetes crus.
   Aqui: colchete vazio (ou zero) some; número vira uma etiqueta depois do nome, que é o
   jeito que a contagem se lê em qualquer outro sistema. O texto para leitor de tela fica
   "Alertas, 3". Vai colado no iframe_handling.js. */
(function () {
  'use strict';

  if (window.__ncBarra) return;
  window.__ncBarra = true;

  var PADRAO = /^\s*\[\s*(\d*)\s*\]\s*/;

  function arrumar() {
    var rotulos = document.querySelectorAll('.t-NavigationBar .t-Button-label, .t-NavigationBar-item .t-Button-label');
    for (var i = 0; i < rotulos.length; i++) {
      var el = rotulos[i];
      if (el.__nc) continue;
      var m = (el.textContent || '').match(PADRAO);
      if (!m) continue;
      el.__nc = true;
      var nome = el.textContent.replace(PADRAO, '');
      var n = parseInt(m[1], 10);
      el.textContent = nome;
      if (n > 0) {
        var selo = document.createElement('span');
        selo.className = 'nc-contador';
        selo.textContent = n > 99 ? '99+' : String(n);
        selo.setAttribute('aria-label', ', ' + n);
        el.appendChild(selo);
      }
    }
  }

  /* Menu no topo: dentro do Painel (iframe) a barra é clara — o roxo do painel já está em
     cima dela. Numa JANELA PRÓPRIA (Chamados) ela é o cabeçalho da aplicação e fica no roxo
     do Painel do Operador. O CSS não sabe se a página está num iframe; esta marca diz. */
  function marcarJanela() {
    var propria = true;
    try { propria = window.self === window.top; } catch (e) { propria = false; }
    if (propria && document.body) document.body.classList.add('nc-janela-propria');
  }

  marcarJanela();
  arrumar();
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { marcarJanela(); arrumar(); });
})();



/* Natcorp — os títulos das colunas acompanham a rolagem em TODO relatório interativo.

   1. CABEÇALHO FIXO POR PADRÃO. No APEX isso é uma opção de cada relatório (Atributos ›
      Cabeçalho Fixo em: Página / Região / Nenhum). Aqui, o relatório que está em
      "Nenhum" passa a se comportar como "Página": ao descer a lista, a linha com os nomes
      das colunas fica presa embaixo da barra de título. "Região" continua como está.
      Para manter um relatório sem cabeçalho fixo: Região › Aparência › Classes CSS →
      nc-sem-cabecalho-fixo.

   2. SEM FAIXA TRANSPARENTE EM CIMA DOS TÍTULOS. O tema calcula onde o cabeçalho para
      (apex.theme.defaultStickyTop) somando 12 px sempre que a página tem um seletor de
      abas ("Region Display Selector"), para abrir espaço à faixa das abas. Em páginas com
      o seletor SEM NENHUMA ABA (Férias e outras consultas) não há faixa nenhuma: sobravam
      12 px transparentes entre a barra de título e os nomes das colunas, com as linhas
      passando por trás. Sem abas, os 12 px saem.

   Precisa carregar antes de a página montar os relatórios — o APEX põe os arquivos da
   aplicação antes do código de inicialização, então basta estar no iframe_handling.js. */
(function () {
  'use strict';

  if (window.__ncCabecalhoRelatorio || !window.jQuery || !window.apex) return;
  window.__ncCabecalhoRelatorio = true;

  var $ = window.jQuery;

  function rdsSemAbas() {
    return !!document.querySelector('.apex-rds-container') &&
      !document.querySelector('.apex-rds-container .apex-rds > li');
  }

  /* ---------- 2. o topo do cabeçalho preso ---------- */
  function corrigirTopo() {
    if (!apex.theme || typeof apex.theme.defaultStickyTop !== 'function' || apex.theme.defaultStickyTop.__nc) return;
    var original = apex.theme.defaultStickyTop;
    var corrigido = function () {
      var h = original.apply(this, arguments);
      return rdsSemAbas() ? h - 12 : h;
    };
    corrigido.__nc = true;
    apex.theme.defaultStickyTop = corrigido;
  }

  /* ---------- 1. cabeçalho fixo por padrão ---------- */
  function semFixoPorEscolha(el) {
    var reg = el && el.closest && el.closest('.t-IRR-region, .t-Region');
    return !!(reg && reg.classList.contains('nc-sem-cabecalho-fixo'));
  }

  function fixarPorPadrao() {
    var W = $.apex && $.apex.interactiveReport;
    if (!W || !W.prototype || typeof W.prototype._initFixedHeader !== 'function' || W.prototype._initFixedHeader.__nc) return false;
    var original = W.prototype._initFixedHeader;
    var novo = function () {
      if (this.options && this.options.fixedHeader === 'NONE' && !semFixoPorEscolha(this.element && this.element[0])) {
        this.options.fixedHeader = 'PAGE';
      }
      return original.apply(this, arguments);
    };
    novo.__nc = true;
    W.prototype._initFixedHeader = novo;
    return true;
  }

  /* relatórios que já montaram antes deste arquivo (carregado tarde): aplica agora */
  function aplicarNosMontados() {
    $('.a-IRR-container').each(function () {
      var inst = $(this).data('apexInteractiveReport');
      if (!inst || inst.options.fixedHeader !== 'NONE' || semFixoPorEscolha(this)) return;
      if (this.querySelector('.t-fht-wrapper')) return;
      try { inst._initFixedHeader(true); } catch (e) { /* versão sem esse método */ }
    });
    /* e os cabeçalhos já presos recalculam o topo */
    $('.js-stickyWidget-toggle').each(function () {
      var w = $(this).data('apexStickyWidget');
      if (w && typeof w.refresh === 'function') { try { w.refresh(); } catch (e) {} }
    });
  }

  corrigirTopo();
  fixarPorPadrao();
  $(function () {
    corrigirTopo();
    fixarPorPadrao();
    setTimeout(aplicarNosMontados, 0);
  });
})();



/* Natcorp — tela de "carregando" ao trocar de página.

   Mostra o símbolo da Natcorp animado sobre um véu claro e desfocado quando a página vai
   ser trocada, para o usuário saber que o clique funcionou:
     · clique em link que troca de página (menu, breadcrumb, cartões, botões-link);
     · envio da página (apex.submit — botões "Salvar", "Criar"…);
     · "Navegar para URL" das ações dinâmicas (apex.navigation.redirect).
   E SUBSTITUI o "Processando" do próprio APEX (a rodinha cinza sobre o véu escuro que o
   apex.page.submit mostra quando o botão tem "Show Processing"): no lugar dele entra este.
   NÃO aparece no que não troca de página: modais, âncoras "#", "javascript:", links que
   abrem em outra aba (target=_blank, Ctrl/Cmd/Shift + clique) e downloads.

   Proteções: o véu só aparece depois de 150 ms (troca rápida não pisca); se a página não
   trocar (um envio que só baixa um arquivo, por exemplo), ele some sozinho — 10 s num
   link, 2 min num envio de página, 60 s num iframe — ou com um clique depois de 1,5 s;
   volta ao normal ao retornar pelo "voltar" do navegador.
   O desenho está no Natcorp_Style_Min.css (#nc-carregando). Onde essa folha não está
   carregada (a tela de login, uma aplicação sem a Skin), o véu não é montado e o APEX
   continua com a rodinha dele — nunca fica uma tela sem aviso nenhum.

   Pode ir colado no fim do iframe_handling.js, como o Natcorp_Alert.js. Vale em cada janela
   que o carrega — a página do painel e as aplicações dentro do iframe (o véu cobre só a
   área que está trocando). */
(function () {
  'use strict';

  if (window.__ncCarregando) return;
  window.__ncCarregando = true;

  var MODULOS = [
    'M4.322 0.322L5.573 1.573A0.456 0.456 0 0 1 5.573 2.218L4.322 3.469A0.456 0.456 0 0 1 3.678 3.469L2.427 2.218A0.456 0.456 0 0 1 2.427 1.573L3.678 0.322A0.456 0.456 0 0 1 4.322 0.322Z',
    'M6.427 2.427L7.678 3.678A0.456 0.456 0 0 1 7.678 4.322L6.427 5.573A0.456 0.456 0 0 1 5.782 5.573L4.531 4.322A0.456 0.456 0 0 1 4.531 3.678L5.782 2.427A0.456 0.456 0 0 1 6.427 2.427Z',
    'M4.322 4.531L5.573 5.782A0.456 0.456 0 0 1 5.573 6.427L4.322 7.678A0.456 0.456 0 0 1 3.678 7.678L2.427 6.427A0.456 0.456 0 0 1 2.427 5.782L3.678 4.531A0.456 0.456 0 0 1 4.322 4.531Z',
    'M2.218 2.427L3.469 3.678A0.456 0.456 0 0 1 3.469 4.322L2.218 5.573A0.456 0.456 0 0 1 1.573 5.573L0.322 4.322A0.456 0.456 0 0 1 0.322 3.678L1.573 2.427A0.456 0.456 0 0 1 2.218 2.427Z'
  ];

  var veu = null, prazo = null, desde = 0, fimPrazo = 0;

  /* envio de página: o servidor pode levar bem mais que 10 s (um cálculo, um relatório), e
     a rodinha do APEX ficava até a página trocar — o nosso fica até 2 min */
  var LIMITE_ENVIO = 120000;

  function montar() {
    if (veu || !document.body) return veu;
    var paths = MODULOS.map(function (d, i) { return '<path class="nc-carregando-m nc-carregando-m' + (i + 1) + '" d="' + d + '"/>'; }).join('');
    veu = document.createElement('div');
    veu.id = 'nc-carregando';
    veu.setAttribute('role', 'status');
    veu.setAttribute('aria-live', 'polite');
    veu.innerHTML =
      '<div class="nc-carregando-marca">' +
      '<svg viewBox="0 0 8 8" aria-hidden="true" focusable="false">' +
      /* o gradiente REAL do logo (src/components/brand/Logo.tsx): um só, sobre o símbolo
         inteiro, 135° — Ameixa → Roxo Natcorp → Azul Profundo */
      '<defs><linearGradient id="nc-carregando-g" gradientUnits="userSpaceOnUse" x1="0" y1="0" x2="8" y2="8">' +
      '<stop offset="0" stop-color="#9A408A"/><stop offset=".5" stop-color="#511C76"/><stop offset="1" stop-color="#2C1A63"/>' +
      '</linearGradient></defs>' + paths + '</svg></div>' +
      '<span class="nc-carregando-texto">Carregando…</span>';
    veu.addEventListener('click', function () {
      if (Date.now() - desde > 1500) esconder();
    });
    document.body.appendChild(veu);
    /* sem o CSS da Natcorp nesta página o véu seria só um texto solto no fim dela */
    if (window.getComputedStyle(veu).position !== 'fixed') {
      veu.parentNode.removeChild(veu);
      veu = null;
    }
    return veu;
  }

  /* limite: some sozinho depois de "ms" (10 s por padrão) — se a troca não acontecer */
  /* devolve false quando não deu para mostrar (página sem o CSS) */
  /* alvo (07/10): a troca é DENTRO de um iframe — o véu cobre só o retângulo dele, com o símbolo no
     mesmo lugar em que a página nova vai abrir coberta (CSS [C14b]): a passagem de um para o outro
     não pula */
  function mostrar(ms, alvo) {
    var novo = !veu;
    if (!montar()) return false;
    var r = alvo && alvo.getBoundingClientRect ? alvo.getBoundingClientRect() : null;
    /* 'important': o CSS do véu tem inset: 0 !important (o gerador põe em tudo) */
    var lugar = function (k, v) { if (v) veu.style.setProperty(k, v, 'important'); else veu.style.removeProperty(k); };
    if (r && r.width > 0 && r.height > 0) {
      lugar('inset', 'auto'); lugar('top', r.top + 'px'); lugar('left', r.left + 'px');
      lugar('width', r.width + 'px'); lugar('height', r.height + 'px');
    } else if (!veu.classList.contains('is-ativo')) {
      ['inset', 'top', 'left', 'width', 'height'].forEach(function (k) { lugar(k, ''); });
    }
    /* recém-criado: o navegador precisa "ver" o estado apagado antes, senão não há
       transição e o véu entra de uma vez */
    if (novo) void veu.offsetWidth;
    var agora = Date.now();
    var fim = agora + (typeof ms === 'number' ? ms : 10000);
    var ativo = veu.classList.contains('is-ativo');
    if (!ativo) desde = agora;
    veu.classList.add('is-ativo');
    /* dois avisos para a mesma troca (o envio e o clique no botão, por exemplo): vale o
       prazo MAIS LONGO — o de 10 s não encurta o de 2 min do envio */
    if (ativo && fimPrazo > fim) return true;
    fimPrazo = fim;
    clearTimeout(prazo);
    prazo = setTimeout(esconder, fim - agora);
    return true;
  }

  function esconder() {
    clearTimeout(prazo);
    fimPrazo = 0;
    if (veu) veu.classList.remove('is-ativo');
  }

  /* este link troca a página NESTA aba? */
  function trocaPagina(a, e) {
    if (e.button !== 0 || e.ctrlKey || e.metaKey || e.shiftKey || e.altKey) return false;
    var alvo = (a.getAttribute('target') || '').toLowerCase();
    if (alvo && alvo !== '_self' && alvo !== '_top' && alvo !== '_parent') return false;
    if (a.hasAttribute('download')) return false;
    var bruto = (a.getAttribute('href') || '').trim();
    if (!bruto || bruto.charAt(0) === '#') return false;
    if (/^(javascript|mailto|tel|sms|data|blob):/i.test(bruto)) return false;
    if (/p_content_disposition=attachment|apex_util\.get_blob|get_blob_file/i.test(bruto)) return false;
    var url;
    try { url = new URL(a.href, location.href); } catch (err) { return false; }
    /* só muda o "#": não troca de página */
    if (url.origin === location.origin && url.pathname === location.pathname && url.search === location.search && url.hash) return false;
    return true;
  }

  /* depois que o APEX e os scripts da página trataram o clique: se alguém cancelou
     (abriu uma modal, tratou por JS), não é troca de página */
  document.addEventListener('click', function (e) {
    var a = e.target && e.target.closest ? e.target.closest('a[href]') : null;
    if (!a) return;
    setTimeout(function () {
      if (!e.defaultPrevented && trocaPagina(a, e)) mostrar();
    }, 0);
  }, false);

  /* envio da página: o APEX dispara "apexpagesubmit" já validado, logo antes de enviar */
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).on('apexpagesubmit', function () {
      /* numa modal, o envio fecha a própria modal: o véu fica só nela até ela fechar */
      mostrar(LIMITE_ENVIO);
    });
  }

  /* O "PROCESSANDO" DO APEX, TROCADO PELO NOSSO. Dois pontos de entrada, os dois no
     namespace público (o APEX os chama por lá, então trocar a função basta):
       · apex.widget.waitPopup() — o que o apex.page.submit chama com "Show Processing":
         põe um véu cinza (#apex_wait_overlay) e, 10 ms depois, a rodinha;
       · apex.util.showSpinner() SEM região — a rodinha no meio da PÁGINA, que ações
         dinâmicas e códigos da aplicação também chamam.
     A rodinha DE UMA REGIÃO (um relatório atualizando, a grade salvando) fica como está:
     ela diz QUAL parte está trabalhando, e o véu sobre a tela inteira diria que é tudo.
     Quem chamou recebe o que esperava (um objeto com .remove()); o remove apaga o véu. */
  function trocarProcessando() {
    if (!window.apex) return;

    var w = apex.widget;
    if (w && typeof w.waitPopup === 'function' && !w.waitPopup.__nc) {
      var esperaApex = w.waitPopup;
      var espera = function (conteudo) {
        /* com HTML próprio (o desenvolvedor escreveu a mensagem): é dele, fica o do APEX */
        if (conteudo || !mostrar(LIMITE_ENVIO)) return esperaApex.apply(this, arguments);
        return { remove: esconder };
      };
      espera.__nc = true;
      w.waitPopup = espera;
    }

    var u = apex.util;
    if (u && typeof u.showSpinner === 'function' && !u.showSpinner.__nc) {
      var rodinhaApex = u.showSpinner;
      var rodinha = function (onde) {
        var el = onde && (onde.jquery ? onde[0] : onde);
        var daPagina = !el || el === document.body || el === document || el === document.documentElement;
        var $r = rodinhaApex.apply(this, arguments);
        if (!daPagina || !$r || !mostrar(LIMITE_ENVIO)) return $r;
        /* a rodinha continua existindo (quem chamou pode medir, mover, remover), só não
           aparece; quando ela sai, o véu sai junto */
        $r.addClass('nc-processando-trocado');
        var tirar = $r.remove;
        $r.remove = function () { esconder(); return tirar.apply(this, arguments); };
        return $r;
      };
      rodinha.__nc = true;
      u.showSpinner = rodinha;
    }
  }

  trocarProcessando();
  /* se este arquivo carregou antes das bibliotecas do APEX */
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', trocarProcessando);

  /* "Navegar para URL" das ações dinâmicas */
  if (window.apex && apex.navigation && typeof apex.navigation.redirect === 'function' && !apex.navigation.redirect.__nc) {
    var redirecionar = apex.navigation.redirect;
    var envolvido = function (url) {
      if (typeof url === 'string' && !/^javascript:/i.test(url) && url.charAt(0) !== '#') mostrar();
      return redirecionar.apply(this, arguments);
    };
    envolvido.__nc = true;
    apex.navigation.redirect = envolvido;
  }

  /* a página vai ser trocada por um caminho que o clique acima não vê: o bloco
     "apex-iframe-breakout" do iframe_handling.js pega o link DENTRO do painel, cancela o
     clique e manda a janela DE CIMA navegar; window.location; formulário nativo. O
     beforeunload avisa todos. Se outro código pediu confirmação ("há alterações não
     salvas"), a pessoa pode decidir ficar — aí o véu não aparece. */
  window.addEventListener('beforeunload', function (e) {
    setTimeout(function () {
      var pediuConfirmacao = e.defaultPrevented || e.returnValue === false ||
        (typeof e.returnValue === 'string' && e.returnValue !== '');
      if (!pediuConfirmacao) mostrar();
    }, 0);
  });

  /* PÁGINA COM OUTRA APLICAÇÃO NUM IFRAME (o painel abre "Abono de Marcações", "PPP"… de
     outras aplicações dentro da área de conteúdo): a troca de página acontece DENTRO do
     iframe, a janela de cima não troca — e o véu dela não aparecia. Um vigia em cada
     iframe da página (fora das modais, que têm o próprio ciclo):
       · enquanto o iframe ainda está em branco carregando a 1.ª vez → véu;
       · quando a página de dentro vai trocar (beforeunload dela) → véu;
       · quando a página de dentro termina de carregar (load do iframe) → some.
     Se a aplicação de dentro já carrega este arquivo, ela tem o próprio véu (sobre a área
     do iframe): o vigia não duplica. Iframe de outro domínio não é tocado. */
  function vigiarQuadro(el) {
    if (el.__ncVigiado || (el.closest && el.closest('.ui-dialog'))) return;
    el.__ncVigiado = true;

    function ligarJanela() {
      try {
        var w = el.contentWindow;
        if (!w || w.__ncCarregando || w.__ncVigiada) return;
        w.__ncVigiada = true;
        /* o fim é certo (o load do iframe): espera até 60 s — a aplicação de dentro pode
           demorar, e sem o véu ficava só a área em branco */
        w.addEventListener('beforeunload', function () { mostrar(60000, el); });
      } catch (err) { /* outro domínio */ }
    }

    el.addEventListener('load', function () { esconder(); ligarJanela(); });
    ligarJanela();

    /* ainda carregando a primeira vez: tem endereço, mas o documento é o em branco */
    try {
      var src = el.getAttribute('src') || '';
      if (src && src !== 'about:blank' && el.contentWindow && el.contentWindow.location.href === 'about:blank') mostrar(60000, el);
    } catch (err) { /* outro domínio: já navegou */ }
  }

  function vigiarQuadros() {
    var q = document.getElementsByTagName('iframe');
    for (var i = 0; i < q.length; i++) vigiarQuadro(q[i]);
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', vigiarQuadros);
  else vigiarQuadros();
  /* iframes criados depois (região carregada por ação dinâmica) */
  setInterval(vigiarQuadros, 700);

  /* voltou pelo "voltar" do navegador (a página vem do cache, com o véu ainda ligado) */
  window.addEventListener('pageshow', esconder);
})();



/* Natcorp — a região que atualiza mostra que está atualizando, e o conteúdo novo chega.

   Quando uma região recarrega sem trocar a página (o relatório depois de um filtro, uma
   ordenação, a paginação; uma região atualizada por ação dinâmica), o APEX avisa com os
   eventos "apexbeforerefresh" e "apexafterrefresh". Aqui:
     · antes: a região ganha nc-atualizando — o conteúdo recua (fica esmaecido) enquanto o
       carregando da Natcorp gira no meio dela;
     · depois: nc-atualizando sai e entra nc-atualizou por um instante — o conteúdo novo
       chega com um leve assentar.
   O desenho está no Natcorp_Style_Min.css (seção "MOVIMENTO"). A chegada das regiões ao
   abrir a página é só CSS e não depende deste arquivo. Vai colado no iframe_handling.js. */
(function () {
  'use strict';

  if (window.__ncAnimacao || !window.jQuery) return;
  window.__ncAnimacao = true;

  var $ = window.jQuery;

  function regiaoDe(el) {
    return el && el.closest ? el.closest('.t-IRR-region, .t-Region') : null;
  }

  $(document).on('apexbeforerefresh', function (e) {
    var r = regiaoDe(e.target);
    if (!r) return;
    r.classList.remove('nc-atualizou');
    r.classList.add('nc-atualizando');
    /* se o "depois" nunca vier (erro na atualização), a região não fica apagada */
    clearTimeout(r.__ncAtualizando);
    r.__ncAtualizando = setTimeout(function () { r.classList.remove('nc-atualizando'); }, 30000);   /* relatório pesado leva 12 s */
  });

  $(document).on('apexafterrefresh', function (e) {
    var r = regiaoDe(e.target);
    if (!r) return;
    clearTimeout(r.__ncAtualizando);
    r.classList.remove('nc-atualizando');
    r.classList.remove('nc-atualizou');
    void r.offsetWidth;                  /* recomeça a animação se vier outra em seguida */
    r.classList.add('nc-atualizou');
    clearTimeout(r.__ncAtualizou);
    r.__ncAtualizou = setTimeout(function () { r.classList.remove('nc-atualizou'); }, 400);
  });
})();



/* Natcorp — mostra o TIPO de cada anexo (PDF, DOCX, XLSX, CSV, PPTX, TXT…).

   Os links de anexo do Blog Corporativo (.publicacao .download a) apontam para um processo
   do APEX ("…APPLICATION_PROCESS=getBlogImg…"): a extensão só existe no NOME visível do
   arquivo, e o CSS não consegue ler texto. Este script lê a extensão do nome e marca o link:

     data-nc-ext     = "PDF"                 → escrito na folha do ícone
     data-nc-familia = "pdf" | "word" | …    → a cor da folha (no Natcorp_Style_Min.css)
     data-nc-tipo    = "Documento PDF"       → a segunda linha do cartão

   O desenho está no Natcorp_Style_Min.css (seção "BLOG CORPORATIVO"). Sem este script o
   cartão aparece igual, com um ícone de arquivo genérico no lugar do tipo.

   Onde colar: no fim do iframe_handling.js (como o Natcorp_Alert.js), SE a aplicação 300
   carrega esse arquivo — ou em Página 1500 › JavaScript › "Execute when Page Loads". */
(function () {
  'use strict';

  var TIPOS = {
    pdf: ['pdf', 'Documento PDF'],
    doc: ['word', 'Documento do Word'], docx: ['word', 'Documento do Word'], odt: ['word', 'Documento de texto'], rtf: ['word', 'Documento de texto'],
    xls: ['planilha', 'Planilha do Excel'], xlsx: ['planilha', 'Planilha do Excel'], xlsm: ['planilha', 'Planilha do Excel'], ods: ['planilha', 'Planilha'], csv: ['planilha', 'Planilha CSV'],
    ppt: ['apresentacao', 'Apresentação do PowerPoint'], pptx: ['apresentacao', 'Apresentação do PowerPoint'], pps: ['apresentacao', 'Apresentação do PowerPoint'], ppsx: ['apresentacao', 'Apresentação do PowerPoint'], odp: ['apresentacao', 'Apresentação'],
    txt: ['texto', 'Arquivo de texto'], log: ['texto', 'Arquivo de texto'], xml: ['texto', 'Arquivo XML'], json: ['texto', 'Arquivo JSON'],
    jpg: ['imagem', 'Imagem'], jpeg: ['imagem', 'Imagem'], png: ['imagem', 'Imagem'], gif: ['imagem', 'Imagem'], webp: ['imagem', 'Imagem'], bmp: ['imagem', 'Imagem'], svg: ['imagem', 'Imagem'],
    mp4: ['video', 'Vídeo'], mov: ['video', 'Vídeo'], avi: ['video', 'Vídeo'], wmv: ['video', 'Vídeo'], webm: ['video', 'Vídeo'],
    mp3: ['audio', 'Áudio'], wav: ['audio', 'Áudio'], ogg: ['audio', 'Áudio'], m4a: ['audio', 'Áudio'],
    zip: ['compactado', 'Arquivo compactado'], rar: ['compactado', 'Arquivo compactado'], '7z': ['compactado', 'Arquivo compactado']
  };

  function marcar(link) {
    if (link.hasAttribute('data-nc-ext')) return;
    var nomeEl = link.querySelector('.text_link') || link;
    var nome = (nomeEl.textContent || '').trim();
    var m = /\.([a-z0-9]{1,5})$/i.exec(nome);
    if (!m) return;                                   // sem extensão: fica o ícone genérico
    var ext = m[1].toLowerCase();
    var tipo = TIPOS[ext] || ['outro', 'Arquivo ' + ext.toUpperCase()];
    link.setAttribute('data-nc-ext', ext.toUpperCase().slice(0, 4));
    link.setAttribute('data-nc-familia', tipo[0]);
    link.setAttribute('data-nc-tipo', tipo[1]);
    /* a segunda linha é o ::after do NOME, e o attr() do CSS lê o atributo do próprio
       elemento: o tipo vai também no nome */
    if (nomeEl !== link) nomeEl.setAttribute('data-nc-tipo', tipo[1]);
    /* quem usa leitor de tela ouve o que o link faz, não só o nome */
    if (!link.getAttribute('aria-label')) {
      link.setAttribute('aria-label', 'Baixar ' + nome + ' (' + tipo[1] + ')' + (link.target === '_blank' ? ', abre em nova aba' : ''));
    }
    if (!link.title) link.title = nome;
  }

  function varrer(raiz) {
    var links = (raiz || document).querySelectorAll('.publicacao .download a');
    for (var i = 0; i < links.length; i++) marcar(links[i]);
  }

  function iniciar() {
    /* só a página do blog tem postagens: nas outras não fica nada vigiando o DOM (o
       arquivo vai colado no iframe_handling.js, que TODA página carrega) */
    if (!document.querySelector('.publicacao')) return;
    varrer(document);
    /* postagens recarregadas por ação dinâmica (refresh da região) chegam depois */
    if (window.MutationObserver) {
      new MutationObserver(function () { varrer(document); })
        .observe(document.body, { childList: true, subtree: true });
    }
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', iniciar);
  else iniciar();
})();



/* Natcorp — a cor do DESTAQUE do relatório interativo vale de verdade.

   O destaque (Ações › Formatar › Destacar: "marcar em amarelo as linhas em que…") o APEX
   aplica por classe: a linha ganha "rule_<id>" e a página recebe
   <style>.rule_<id> td { background-color: #FFF5CE !important; color: … !important }</style>.
   Esse seletor é fraco: as regras de célula da Skin (html body .a-IRR-table td { color:
   … !important }) vencem, e a cor de TEXTO escolhida no destaque não aparecia (o fundo o
   Natcorp_Style_Min.css já deixa passar). Este script copia cada regra de destaque com um
   seletor mais forte — a mesma cor, o mesmo alcance, agora acima de tudo.

   Vale para todo relatório interativo, na carga e a cada atualização (filtro, ordem,
   paginação: o APEX troca o <style> junto com o relatório). Vai colado no iframe_handling.js. */
(function () {
  'use strict';

  if (window.__ncDestaque) return;
  window.__ncDestaque = true;

  /* três ids: acima do prefixo do Natcorp_Style_Min.css (dois) */
  var FORTE = 'html body:not(#nc-d1):not(#nc-d2):not(#nc-d3) ';

  function reforcar() {
    var estilos = document.querySelectorAll('style:not([data-nc-destaque])');
    for (var i = 0; i < estilos.length; i++) {
      var st = estilos[i];
      if (st.__ncDestaque || !/\.rule_\d+/.test(st.textContent)) continue;
      st.__ncDestaque = true;
      var css = st.textContent.replace(/([^{}]+)\{([^{}]*)\}/g, function (bloco, seletores, corpo) {
        if (!/\.rule_\d+/.test(seletores)) return '';
        var fortes = seletores.split(',').map(function (x) { return FORTE + x.trim(); }).join(', ');
        return fortes + ' {' + corpo + '}';
      });
      if (!css.trim()) continue;
      var novo = document.createElement('style');
      novo.setAttribute('data-nc-destaque', '');
      novo.textContent = css;
      st.parentNode.insertBefore(novo, st.nextSibling);
    }
  }

  reforcar();
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', reforcar);
  if (window.apex && apex.jQuery) apex.jQuery(document).on('apexafterrefresh', function () { setTimeout(reforcar, 0); });
})();



/* Natcorp — rolar o relatório para os lados sem ir até o fim da página.

   Relatório largo (Férias, Colaboradores: 30 colunas, 3.800 px) rola para os lados dentro
   dele mesmo, e a barra de rolagem fica no FIM da tabela: com 50 linhas, lá embaixo. Com
   mouse, para ver a coluna da direita era preciso descer até o último registro, pegar a
   barra, arrastar e subir de novo.

   Aqui, enquanto a tabela está na tela e a barra dela não, uma CÓPIA da barra fica presa
   no rodapé da janela, na largura do relatório — arrastar uma move a outra. Some sozinha
   quando a barra verdadeira aparece (fim da tabela) ou quando a tabela sai da tela.

   Outras formas que continuam valendo: Shift + rodinha do mouse; o gesto de dois dedos
   no touchpad. Vale para todo relatório interativo, na carga e a cada atualização.
   Vai colado no iframe_handling.js. */
(function () {
  'use strict';

  if (window.__ncRolagem || !window.jQuery) return;
  window.__ncRolagem = true;

  var $ = window.jQuery;
  var ligados = [];                 /* { rolo, barra, trilho } */

  /* quem rola: com o cabeçalho fixo o APEX parte a tabela e o corpo é o .t-fht-tbody;
     sem ele, o próprio recipiente da tabela */
  function acharRolos() {
    var cands = document.querySelectorAll('.a-IRR .t-fht-tbody, .a-IRR .a-IRR-tableContainer');
    var out = [];
    for (var i = 0; i < cands.length; i++) {
      var el = cands[i];
      if (el.classList.contains('a-IRR-tableContainer') && el.querySelector('.t-fht-tbody')) continue;
      var ox = window.getComputedStyle(el).overflowX;
      if (ox === 'auto' || ox === 'scroll') out.push(el);
    }
    return out;
  }

  function ligar(rolo) {
    for (var i = 0; i < ligados.length; i++) if (ligados[i].rolo === rolo) return ligados[i];
    var barra = document.createElement('div');
    barra.className = 'nc-barra-lateral';
    barra.setAttribute('aria-hidden', 'true');
    var trilho = document.createElement('div');
    trilho.className = 'nc-barra-lateral-trilho';
    barra.appendChild(trilho);
    document.body.appendChild(barra);

    var item = { rolo: rolo, barra: barra, trilho: trilho, mexendo: null };
    barra.addEventListener('scroll', function () {
      if (item.mexendo === 'rolo') return;
      item.mexendo = 'barra';
      rolo.scrollLeft = barra.scrollLeft;
      requestAnimationFrame(function () { item.mexendo = null; });
    }, { passive: true });
    rolo.addEventListener('scroll', function () {
      if (item.mexendo === 'barra') return;
      item.mexendo = 'rolo';
      barra.scrollLeft = rolo.scrollLeft;
      requestAnimationFrame(function () { item.mexendo = null; });
    }, { passive: true });
    ligados.push(item);
    return item;
  }

  function posicionar(item) {
    var r = item.rolo;
    if (!document.body.contains(r)) {                         /* relatório redesenhado */
      item.barra.remove();
      return false;
    }
    var largo = r.scrollWidth > r.clientWidth + 2;
    var rect = r.getBoundingClientRect();
    var alto = window.innerHeight;
    /* a barra verdadeira fica no fim do rolo: a cópia só enquanto o fim está abaixo da
       janela e a tabela ainda aparece (ao menos 80 px dela) */
    var mostrar = largo && rect.bottom > alto && rect.top < alto - 80 && rect.width > 0;
    item.barra.classList.toggle('is-visivel', mostrar);
    if (mostrar) {
      item.barra.style.left = Math.max(0, rect.left) + 'px';
      item.barra.style.width = Math.min(rect.width, window.innerWidth - Math.max(0, rect.left)) + 'px';
      item.trilho.style.width = r.scrollWidth + 'px';
      if (Math.abs(item.barra.scrollLeft - r.scrollLeft) > 1) item.barra.scrollLeft = r.scrollLeft;
    }
    return true;
  }

  /* A aplicação que já traz o PRÓPRIO plugin de barra flutuante (Chamados, app 118:
     jquery.ba-floatingscrollbar + add-floating-scrollbar) ficava com duas barras presas no
     rodapé, uma sobre a outra — com a região maximizada e depois dela. Lá vale a da
     aplicação; esta sai. O plugin carrega DEPOIS deste arquivo, por isso a checagem é a
     cada atualização, e não na carga. */
  function outroPlugin() {
    return !!($.fn && $.fn.floatingScrollbar) || !!document.querySelector('.floating-scrollbar');
  }

  function atualizar() {
    if (outroPlugin()) {
      for (var i = 0; i < ligados.length; i++) ligados[i].barra.remove();
      ligados = [];
      return;
    }
    var rolos = acharRolos();
    for (var i = 0; i < rolos.length; i++) ligar(rolos[i]);
    ligados = ligados.filter(posicionar);
  }

  var agendado = false;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () { agendado = false; atualizar(); });
  }

  window.addEventListener('scroll', agendar, { passive: true });
  window.addEventListener('resize', agendar);
  $(document).on('apexafterrefresh apexwindowresized', function () { setTimeout(agendar, 50); });
  /* colapsar o menu lateral, abrir o painel de filtros… mudam a largura sem "resize" */
  if (window.ResizeObserver) {
    var ro = new ResizeObserver(agendar);
    $(function () { var b = document.querySelector('.t-Body-content'); if (b) ro.observe(b); });
  }
  $(function () { setTimeout(atualizar, 300); });
})();



/* Natcorp — formulário longo no celular ("Conhecendo Você", app 600, e qualquer formulário APEX).

   Quem preenche o "Dados Pessoais" faz isso pelo celular (9 em cada 10), e a página tem
   dezessete blocos e cento e poucos campos numa rolagem de 10 mil pixels. Este arquivo
   cuida do que o CSS sozinho não alcança:

     1. TECLADO CERTO EM CADA CAMPO: número abre o teclado numérico, e-mail o de e-mail;
        CPF, CEP, PIS, conta, zona, seção… só números. O celular também passa a sugerir o
        que já sabe (nome, e-mail, telefone, CEP, endereço) — menos digitação.
     2. "IR" NO TECLADO LEVA AO PRÓXIMO CAMPO, em vez de tentar enviar a página.
     3. DATAS: digita-se só os números (as barras entram sozinhas, "27081960" vira
        27/08/1960) e o calendário ganha a escolha de MÊS e ANO — antes, para chegar a
        1960 eram mais de 700 toques na seta. Aberto pelo botão do calendário, o teclado
        não sobe por cima dele.
     4. LISTA DE BUSCA (Banco, Agência, Naturalidade): a janela diz o nome do campo
        ("Banco"), não "Caixa de Diálogo Pesquisar".
     5. "IR PARA SEÇÃO": no celular, um botão fixo embaixo mostra em que bloco a pessoa
        está ("Contato · 4 de 17") e abre a lista de todos os blocos — um toque leva a
        qualquer um. Some enquanto o teclado está aberto.

   O desenho está no Natcorp_Style_Min.css (seções "FORMULÁRIO NO CELULAR" e "IR PARA SEÇÃO").
   Não muda valor nenhum de campo nem dispara "change" — a gravação automática da página
   continua exatamente como era.

   Onde vai: Aplicação 600 › Componentes Compartilhados › Atributos da Interface do Usuário ›
   JavaScript › URLs de Arquivo:  #WORKSPACE_FILES#Natcorp_Formulario_Celular.js
   (também vai colado no fim do iframe_handling.js, para as outras aplicações). */
(function () {
  'use strict';

  if (window.__ncFormCelular || !window.apex || !window.jQuery) return;
  window.__ncFormCelular = true;

  var $ = window.jQuery;
  var TOQUE = window.matchMedia && window.matchMedia('(pointer: coarse)').matches;
  var ESTREITO = window.matchMedia ? window.matchMedia('(max-width: 767px)') : { matches: false };

  function texto(el) { return el ? (el.textContent || '').replace(/\s+/g, ' ').trim() : ''; }

  function rotulo(campo) {
    var l = campo.id && document.querySelector('label[for="' + campo.id + '"]');
    return texto(l);
  }

  function tituloDaRegiao(campo) {
    var r = campo.closest && campo.closest('.t-Region');
    return r ? texto(r.querySelector('.t-Region-title')) : '';
  }

  function por(el, nome, valor) {
    if (!el.hasAttribute(nome)) el.setAttribute(nome, valor);
  }

  /* ---------- 1. TECLADO CERTO ---------- */
  var SO_NUMERO = /^(n[º°o.]*\s*)?(de\s+|do\s+)?(cpf|cep|pis|pasep|nis|cnh|conta|ag[eê]ncia|zona|se[cç][aã]o|s[eé]rie|ramal|ano|anos|meses|registro)\b|n[uú]mero do pis|ano de chegada|habilita[cç][aã]o profissional/i;
  /* "Número" sozinho depende do documento: RG e passaporte têm letras */
  var NUMERO_SO_DIGITOS = /^(cpf|pis|t[ií]tulo de eleitor|carteira profissional|endere[cç]o|contribui[cç][aã]o inss)$/i;

  function ajustarTeclado(campo) {
    if (campo.__ncTeclado) return;
    campo.__ncTeclado = true;
    var tipo = (campo.getAttribute('type') || 'text').toLowerCase();
    if (!/^(text|tel|email|url|search|number)$/.test(tipo)) return;
    var r = rotulo(campo), reg = tituloDaRegiao(campo), id = campo.id || '';
    var cls = ' ' + campo.className + ' ';

    por(campo, 'enterkeyhint', 'next');

    if (/hasDatepicker|apex-item-datepicker/.test(cls)) {
      por(campo, 'inputmode', 'numeric');
      por(campo, 'autocomplete', 'off');
      return;
    }
    if (/e-?mail/i.test(r) || /E_?MAIL/i.test(id)) {
      por(campo, 'inputmode', 'email');
      por(campo, 'autocomplete', /funcional|corporativ|comercial/i.test(r) ? 'off' : 'email');
      por(campo, 'autocapitalize', 'none');
      por(campo, 'spellcheck', 'false');
      return;
    }
    if (tipo === 'url' || /linkedin|site|url/i.test(r)) {
      por(campo, 'inputmode', 'url');
      por(campo, 'autocapitalize', 'none');
      por(campo, 'spellcheck', 'false');
      return;
    }
    if (/altura|peso|metros|\(kg\)/i.test(r)) { por(campo, 'inputmode', 'decimal'); return; }
    if (tipo === 'tel' || /number_field/.test(cls) || SO_NUMERO.test(r) ||
        (/^n[uú]mero$/i.test(r) && NUMERO_SO_DIGITOS.test(reg))) {
      if (/popup_lov|popup-lov/.test(cls)) return;          /* Banco/Agência: busca por nome */
      por(campo, 'inputmode', tipo === 'tel' && /telefone|celular|recado|nextel/i.test(r) ? 'tel' : 'numeric');
      if (/cep/i.test(r)) por(campo, 'autocomplete', 'postal-code');
      else if (/celular/i.test(r)) por(campo, 'autocomplete', 'tel-national');
      else por(campo, 'autocomplete', 'off');
      return;
    }
    /* texto: o celular sugere o que já sabe da pessoa — só nos campos DELA */
    var sugestao =
      /^nome completo$|^nome$/i.test(r) ? 'name' :
      /^endere[cç]o$|logradouro/i.test(r) && !/select/i.test(campo.tagName) ? 'address-line1' :
      /^complemento$/i.test(r) ? 'address-line2' :
      /^cidade$/i.test(r) && /endere/i.test(reg) ? 'address-level2' :
      /^bairro$/i.test(r) ? 'address-level3' : '';
    if (sugestao) por(campo, 'autocomplete', sugestao);
    else if (/^nome|c[oô]njuge|m[aã]e|pai|contato/i.test(r)) por(campo, 'autocomplete', 'off');
    if (/nome|bairro|cidade|endere|emissor|complemento/i.test(r)) por(campo, 'autocapitalize', 'words');
    if (/d[ií]gito|categoria|sigla/i.test(r)) por(campo, 'autocapitalize', 'characters');
  }

  function ajustarTeclados(raiz) {
    var c = (raiz || document).querySelectorAll('.t-Form-inputContainer input');
    for (var i = 0; i < c.length; i++) ajustarTeclado(c[i]);
  }

  /* ---------- 2. "IR" LEVA AO PRÓXIMO CAMPO ---------- */
  function visivel(el) {
    return !!(el.offsetWidth || el.offsetHeight || el.getClientRects().length) &&
      window.getComputedStyle(el).visibility !== 'hidden';
  }

  function proximoCampo(atual) {
    var todos = document.querySelectorAll('.t-Body-content input:not([type=hidden]):not([type=radio]):not([type=checkbox]), .t-Body-content select, .t-Body-content textarea, .t-Dialog-body input:not([type=hidden]):not([type=radio]):not([type=checkbox]), .t-Dialog-body select, .t-Dialog-body textarea');
    var achou = false;
    for (var i = 0; i < todos.length; i++) {
      var c = todos[i];
      if (achou && !c.disabled && !c.readOnly && visivel(c)) return c;
      if (c === atual) achou = true;
    }
    return null;
  }

  if (TOQUE) {
    document.addEventListener('keydown', function (e) {
      var c = e.target;
      if (e.key !== 'Enter' || e.defaultPrevented || !c || c.tagName !== 'INPUT') return;
      if (!c.closest || !c.closest('.t-Form-inputContainer')) return;
      if (/^(button|submit|radio|checkbox)$/.test(c.type)) return;
      if (c.closest('.a-PopupLOV-searchBar')) return;       /* Enter na busca é "buscar" */
      e.preventDefault();
      e.stopPropagation();
      var p = proximoCampo(c);
      if (p) p.focus(); else c.blur();
    }, true);
  }

  /* ---------- 3. DATAS ---------- */
  function temMascara(campo) {
    var ev = $._data && $._data(campo, 'events');
    return !!(ev && ev.unmask);
  }

  /* dd/mm/aaaa enquanto digita: só números, as barras entram sozinhas; apagar funciona */
  function mascararData(campo) {
    if (campo.__ncData || temMascara(campo)) return;
    campo.__ncData = true;
    campo.addEventListener('input', function (e) {
      if (e.inputType && /^delete/.test(e.inputType)) return;
      var d = campo.value.replace(/\D/g, '').slice(0, 8);
      var v = d.length > 4 ? d.slice(0, 2) + '/' + d.slice(2, 4) + '/' + d.slice(4)
            : d.length > 2 ? d.slice(0, 2) + '/' + d.slice(2) : d;
      if (v !== campo.value) campo.value = v;
    });
  }

  function ajustarDatas(raiz) {
    $(raiz || document).find('input.hasDatepicker').each(function () {
      var fmt = $(this).datepicker('option', 'dateFormat') || '';
      if (!/^dd.mm.yy$/.test(fmt)) return;                   /* só o formato brasileiro */
      /* direto na configuração do calendário deste campo: o datepicker('option') do jQuery
         RECRIA o botão do calendário, e o novo vem sem as classes do APEX (ia para a
         esquerda, por cima do rótulo) */
      var inst = !this.__ncCalendario && $.data(this, 'datepicker');
      if (inst && inst.settings) {
        this.__ncCalendario = true;
        inst.settings.changeMonth = true;
        inst.settings.changeYear = true;
        inst.settings.yearRange = '-110:+20';
      }
      mascararData(this);
    });
  }

  /* aberto pelo botão do calendário, o jQuery põe o foco no campo — e o teclado subia por
     cima do calendário. Enquanto ele está aberto o campo pede "sem teclado"; ao fechar,
     volta ao numérico e o foco sai (senão o teclado subiria logo depois da escolha). */
  if (TOQUE) {
    document.addEventListener('pointerdown', function (e) {
      var b = e.target && e.target.closest && e.target.closest('.ui-datepicker-trigger');
      if (!b) return;
      var campo = b.previousElementSibling;
      if (!campo || campo.tagName !== 'INPUT') return;
      campo.setAttribute('inputmode', 'none');
      var cal = document.getElementById('ui-datepicker-div');
      var espera = setInterval(function () {
        cal = cal || document.getElementById('ui-datepicker-div');
        if (cal && window.getComputedStyle(cal).display !== 'none') return;
        clearInterval(espera);
        campo.setAttribute('inputmode', 'numeric');
        if (document.activeElement === campo) campo.blur();
      }, 250);
    }, true);
  }

  /* ---------- 4. LISTA DE BUSCA COM O NOME DO CAMPO ---------- */
  $(document).on('dialogopen', function (e) {
    var id = (e.target && e.target.id) || '';
    var m = /^PopupLov_\d+_(.+)_dlg$/.exec(id);
    if (!m) return;
    var campo = document.getElementById(m[1]);
    var nome = campo && rotulo(campo);
    if (!nome) return;
    var janela = e.target.closest('.ui-dialog');
    var t = janela && janela.querySelector('.ui-dialog-title');
    if (t) t.textContent = nome;
    var busca = e.target.querySelector('.a-PopupLOV-search');
    if (busca) {
      if (!busca.getAttribute('placeholder')) busca.setAttribute('placeholder', 'Digite para buscar');
      busca.setAttribute('enterkeyhint', 'search');
      busca.setAttribute('autocomplete', 'off');
    }
  });

  /* ---------- 5. IR PARA SEÇÃO ---------- */
  var ICONE_LISTA = '<svg viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M8 6h12M8 12h12M8 18h12"/><circle cx="4" cy="6" r="1.2"/><circle cx="4" cy="12" r="1.2"/><circle cx="4" cy="18" r="1.2"/></svg>';
  var ICONE_FECHAR = '<svg viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M6 6l12 12M18 6L6 18"/></svg>';

  var secoes = [], botao = null, painel = null, atual = -1, ultimoFoco = null, ouvintes = false;

  function coletarSecoes() {
    var lista = [];
    var rs = document.querySelectorAll('.t-Body-content .t-Region:not(.t-Region--removeHeader):not(.t-Region--noUI)');
    for (var i = 0; i < rs.length; i++) {
      var r = rs[i];
      if (r.parentElement && r.parentElement.closest('.t-Region:not(.t-Region--noUI)')) continue;   /* região dentro de região */
      var t = r.querySelector(':scope > .t-Region-header .t-Region-title');
      if (!t || !visivel(r) || !r.querySelector('.t-Form-fieldContainer')) continue;
      var ic = r.querySelector(':scope > .t-Region-header .t-Region-headerIcon .t-Icon');
      lista.push({ el: r, nome: texto(t), icone: ic ? ic.className : '' });
    }
    return lista;
  }

  function irPara(i) {
    var s = secoes[i];
    if (!s) return;
    var topo = s.el.getBoundingClientRect().top + window.pageYOffset;
    /* subindo, o cabeçalho do tema reaparece (150 px): o título não pode ficar debaixo dele */
    var folga = topo < window.pageYOffset ? 162 : 12;
    var reduzir = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    window.scrollTo({ top: Math.max(0, topo - folga), behavior: reduzir ? 'auto' : 'smooth' });
    var titulo = s.el.querySelector('.t-Region-title');
    if (titulo) {
      titulo.setAttribute('tabindex', '-1');
      titulo.focus({ preventScroll: true });
    }
  }

  function abrir() {
    if (!painel) return;
    ultimoFoco = document.activeElement;
    marcarAtual(true);
    painel.hidden = false;
    void painel.offsetWidth;
    painel.classList.add('is-aberto');
    botao.setAttribute('aria-expanded', 'true');
    document.documentElement.classList.add('nc-secoes-travado');
    var alvo = painel.querySelector('.nc-secoes-item.is-atual') || painel.querySelector('.nc-secoes-item');
    if (alvo) {
      alvo.focus({ preventScroll: true });
      alvo.scrollIntoView({ block: 'center' });
    }
  }

  function fechar(devolverFoco) {
    if (!painel || painel.hidden) return;
    painel.classList.remove('is-aberto');
    botao.setAttribute('aria-expanded', 'false');
    document.documentElement.classList.remove('nc-secoes-travado');
    setTimeout(function () { painel.hidden = true; }, 220);
    if (devolverFoco && ultimoFoco && ultimoFoco.focus) ultimoFoco.focus({ preventScroll: true });
  }

  function marcarAtual(forcar) {
    if (!secoes.length || !botao) return;
    var linha = Math.min(window.innerHeight * 0.3, 220), i = 0;
    for (var k = 0; k < secoes.length; k++) {
      if (secoes[k].el.getBoundingClientRect().top <= linha) i = k;
    }
    var primeira = secoes[0].el.getBoundingClientRect().top;
    /* aparece quando a pessoa começa a rolar — na abertura da página, a tela é do formulário */
    botao.classList.toggle('is-visivel', window.pageYOffset > 120 && primeira < window.innerHeight * 0.6);
    if (i === atual && !forcar) return;
    atual = i;
    botao.querySelector('.nc-secoes-atual').textContent = secoes[i].nome;
    botao.querySelector('.nc-secoes-conta').textContent = (i + 1) + ' de ' + secoes.length;
    var itens = painel.querySelectorAll('.nc-secoes-item');
    for (var j = 0; j < itens.length; j++) {
      itens[j].classList.toggle('is-atual', j === i);
      if (j === i) itens[j].setAttribute('aria-current', 'true'); else itens[j].removeAttribute('aria-current');
    }
  }

  function montarSecoes() {
    if (botao || !ESTREITO.matches) return;
    secoes = coletarSecoes();
    if (secoes.length < 5) return;                            /* formulário curto: não precisa */

    botao = document.createElement('button');
    botao.type = 'button';
    botao.className = 'nc-secoes-botao';
    botao.setAttribute('aria-haspopup', 'dialog');
    botao.setAttribute('aria-expanded', 'false');
    botao.innerHTML = ICONE_LISTA +
      '<span class="nc-secoes-textos"><span class="nc-secoes-rotulo">Ir para seção</span>' +
      '<span class="nc-secoes-atual"></span></span><span class="nc-secoes-conta"></span>';
    botao.addEventListener('click', abrir);

    painel = document.createElement('div');
    painel.className = 'nc-secoes';
    painel.hidden = true;
    var itens = secoes.map(function (s, i) {
      return '<li><button type="button" class="nc-secoes-item" data-i="' + i + '">' +
        '<span class="nc-secoes-ic" aria-hidden="true">' + (s.icone ? '<span class="' + s.icone.replace(/"/g, '') + '"></span>' : '') + '</span>' +
        '<span class="nc-secoes-nome"></span></button></li>';
    }).join('');
    painel.innerHTML =
      '<div class="nc-secoes-folha" role="dialog" aria-modal="true" aria-labelledby="nc-secoes-titulo">' +
      '<div class="nc-secoes-topo"><span class="nc-secoes-alca" aria-hidden="true"></span>' +
      '<h2 id="nc-secoes-titulo">Ir para seção</h2>' +
      '<button type="button" class="nc-secoes-fechar" aria-label="Fechar">' + ICONE_FECHAR + '</button></div>' +
      '<ol class="nc-secoes-lista">' + itens + '</ol></div>';
    /* o nome entra como texto (não como HTML): vem da página */
    var nomes = painel.querySelectorAll('.nc-secoes-nome');
    for (var n = 0; n < nomes.length; n++) nomes[n].textContent = secoes[n].nome;

    painel.addEventListener('click', function (e) {
      var item = e.target.closest('.nc-secoes-item');
      if (item) {
        var i = +item.getAttribute('data-i');
        fechar(false);
        setTimeout(function () { irPara(i); }, 60);
        return;
      }
      if (e.target.closest('.nc-secoes-fechar') || !e.target.closest('.nc-secoes-folha')) fechar(true);
    });
    painel.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') { e.preventDefault(); fechar(true); return; }
      if (e.key !== 'Tab') return;                           /* o foco fica dentro da folha */
      var f = painel.querySelectorAll('button');
      var ini = f[0], fim = f[f.length - 1];
      if (e.shiftKey && document.activeElement === ini) { e.preventDefault(); fim.focus(); }
      else if (!e.shiftKey && document.activeElement === fim) { e.preventDefault(); ini.focus(); }
    });

    document.body.appendChild(painel);
    document.body.appendChild(botao);

    marcarAtual(true);
    if (ouvintes) return;                                     /* remontado por recontar(): já ligados */
    ouvintes = true;

    var agendado = false;
    window.addEventListener('scroll', function () {
      if (agendado) return;
      agendado = true;
      window.requestAnimationFrame(function () { agendado = false; marcarAtual(false); });
    }, { passive: true });

    /* com o teclado aberto o botão flutuaria em cima do campo. "Teclado aberto" = um campo
       de digitação em foco E a área visível encolhida (o foco sozinho não basta: ao fechar
       a lista de busca o APEX devolve o foco ao campo, sem teclado nenhum) */
    var vv = window.visualViewport;
    function campoDeDigitacao(a) {
      return !!(a && a.matches && a.matches('input:not([type=radio]):not([type=checkbox]):not([type=button]), textarea'));
    }
    function avaliarTeclado() {
      if (!botao) return;
      var aberto = campoDeDigitacao(document.activeElement) &&
        (vv ? vv.height < window.innerHeight - 120 : true);
      botao.classList.toggle('is-digitando', aberto);
    }
    if (vv) vv.addEventListener('resize', avaliarTeclado);
    document.addEventListener('focusin', function () { setTimeout(avaliarTeclado, 300); });
    document.addEventListener('focusout', function () { setTimeout(avaliarTeclado, 120); });
  }

  /* blocos que aparecem/somem por ação dinâmica (Nacionalidade mostra "Estrangeiro"…) */
  function recontar() {
    if (!botao) return;
    var novas = coletarSecoes();
    if (novas.length === secoes.length) return;
    botao.remove(); painel.remove(); botao = painel = null; atual = -1;
    montarSecoes();
  }

  /* ---------- início ---------- */
  function iniciar() {
    ajustarTeclados();
    ajustarDatas();
    montarSecoes();
  }

  $(function () { setTimeout(iniciar, 0); });
  $(document).on('apexafterrefresh', function (e) {
    ajustarTeclados(e.target);
    ajustarDatas(e.target);
    setTimeout(recontar, 50);
  });
  if (ESTREITO.addEventListener) ESTREITO.addEventListener('change', function () { if (ESTREITO.matches) montarSecoes(); });
})();
