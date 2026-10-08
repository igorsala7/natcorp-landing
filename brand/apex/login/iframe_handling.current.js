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