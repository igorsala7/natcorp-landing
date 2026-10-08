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
