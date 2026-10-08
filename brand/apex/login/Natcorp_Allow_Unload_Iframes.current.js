(function () {
    "use strict";

    var DEBUG = true;
    var MARCA = "data-natcorp-unload-enabled";

    function log() {
        if (!DEBUG || !window.console) {
            return;
        }

        console.log.apply(
            console,
            ["[NATCORP iframe/unload]"].concat(
                Array.prototype.slice.call(arguments)
            )
        );
    }

    /**
     * Adiciona "unload" ao atributo allow sem apagar
     * outras permissões que já existam.
     */
    function adicionarAllowUnload(iframe) {

        if (!iframe || iframe.tagName !== "IFRAME") {
            return false;
        }

        var allowAtual = iframe.getAttribute("allow") || "";

        /*
         * Já contém unload.
         */
        if (
            /(^|;)\s*unload(\s|;|$)/i.test(allowAtual)
        ) {
            return false;
        }

        var novoAllow;

        if (allowAtual.trim()) {
            novoAllow =
                allowAtual.replace(/\s*;\s*$/, "") +
                "; unload";
        } else {
            novoAllow = "unload";
        }

        iframe.setAttribute("allow", novoAllow);

        log(
            "allow=\"unload\" aplicado:",
            iframe,
            "allow=",
            novoAllow
        );

        return true;
    }


    /**
     * Habilita unload em um iframe.
     *
     * Se o iframe já estava carregado antes de receber
     * o atributo allow, ele precisa navegar novamente
     * para a nova policy valer para o documento filho.
     */
    function tratarIframe(iframe) {

        if (!iframe || iframe.tagName !== "IFRAME") {
            return;
        }

        var alterado = adicionarAllowUnload(iframe);

        /*
         * Não recarregar novamente este mesmo elemento.
         */
        if (iframe.hasAttribute(MARCA)) {
            return;
        }

        iframe.setAttribute(MARCA, "1");

        /*
         * Se houve alteração e já existe src, fazemos
         * uma única nova navegação para que o documento
         * seja criado com a Permissions Policy correta.
         */
        if (alterado) {

            var src = iframe.getAttribute("src");

            if (src && src !== "about:blank") {

                log(
                    "Recarregando iframe uma única vez:",
                    src
                );

                /*
                 * Espera o JS atual terminar.
                 */
                setTimeout(function () {

                    /*
                     * O atributo MARCA fica no elemento do pai,
                     * portanto não cria loop.
                     */
                    iframe.src = src;

                }, 0);
            }
        }
    }


    /**
     * Trata todos os iframes já existentes.
     */
    function tratarExistentes() {

        var iframes =
            document.querySelectorAll("iframe");

        log(
            "Iframes encontrados:",
            iframes.length
        );

        Array.prototype.forEach.call(
            iframes,
            tratarIframe
        );
    }


    /**
     * Monitora iframes que forem criados posteriormente
     * por APEX, JavaScript, Dynamic Actions etc.
     */
    function iniciarObserver() {

        var observer = new MutationObserver(
            function (mutations) {

                mutations.forEach(function (mutation) {

                    Array.prototype.forEach.call(
                        mutation.addedNodes,
                        function (node) {

                            if (!node || node.nodeType !== 1) {
                                return;
                            }

                            /*
                             * O próprio elemento inserido é iframe.
                             */
                            if (node.tagName === "IFRAME") {
                                tratarIframe(node);
                            }

                            /*
                             * O elemento inserido contém iframes.
                             */
                            if (node.querySelectorAll) {

                                var internos =
                                    node.querySelectorAll("iframe");

                                Array.prototype.forEach.call(
                                    internos,
                                    tratarIframe
                                );
                            }
                        }
                    );
                });
            }
        );

        observer.observe(
            document.documentElement,
            {
                childList: true,
                subtree: true
            }
        );

        log("MutationObserver iniciado.");
    }


    function validarPolicy() {

        try {

            if (
                document.featurePolicy &&
                typeof document.featurePolicy.allowsFeature ===
                    "function"
            ) {

                log(
                    "TOP permite unload:",
                    document.featurePolicy.allowsFeature(
                        "unload"
                    )
                );
            }

        } catch (e) {
            log("Não foi possível consultar featurePolicy:", e);
        }
    }


    function init() {

        log("Inicializando.");

        validarPolicy();

        /*
         * Primeiro inicia o observer para não perder
         * novos iframes durante a inicialização.
         */
        iniciarObserver();

        /*
         * Depois trata os que já existem.
         */
        tratarExistentes();
    }


    if (document.readyState === "loading") {

        document.addEventListener(
            "DOMContentLoaded",
            init,
            { once: true }
        );

    } else {

        init();
    }

})();

/* =============================================================
   Limpeza de Popup LOV órfãos (APEX 19.2 + Chrome)

   Problema: o Popup LOV de uma página MODAL cria a janela de seleção
   na janela mais externa (apex.util.getTopApex). O APEX 19.2 usa o
   evento "unload" para apagá-la quando a modal fecha. O Chrome (146+)
   bloqueia o unload, então ela fica sobrando escondida e, na próxima
   abertura da modal, o APEX cria outra com o MESMO id e a LOV trava.

   Solução (mesma ideia do patch 39081083 da Oracle para 24.x): ao
   fechar a modal, remove as janelas de Popup LOV cujo item não existe
   mais em nenhuma página aberta. Popup LOVs da página de fora e da
   página que abriu a modal são preservados.
   ============================================================= */
(function (root) {
  "use strict";

  var $ = root.apex && root.apex.jQuery ? root.apex.jQuery : root.jQuery;
  if (!$ || !root.apex || !root.apex.util || !root.apex.util.getTopApex) return;

  var SELETOR = '[id^="PopupLov_"][id$="_dlg"]';

  // "PopupLov_27_P27_UNIDADE_dlg" -> "P27_UNIDADE"
  function itemDoDialogo(id) {
    return id.replace(/^PopupLov_/, "").replace(/_dlg$/, "").replace(/^\d+_/, "");
  }

  function itemExisteEm(doc, itemId) {
    try {
      return !!(doc && itemId && doc.getElementById(itemId));
    } catch (e) {
      return false;
    }
  }

  function limparPopupLovOrfaos() {
    var topApex;
    try {
      topApex = root.apex.util.getTopApex();
    } catch (e) {
      return;
    }
    if (!topApex || !topApex.jQuery) return;

    var topBody = topApex.jQuery("body")[0];
    var topDoc = topBody ? topBody.ownerDocument : null;

    topApex.jQuery(SELETOR).each(function (_, dlg) {
      var itemId = itemDoDialogo(dlg.id);

      // Item ainda existe na página de fora ou na página atual:
      // o Popup LOV está em uso, não mexe.
      if (itemExisteEm(topDoc, itemId) || itemExisteEm(document, itemId)) return;

      var dlg$ = topApex.jQuery(dlg);
      try {
        if (dlg$.data("uiDialog")) {
          dlg$.dialog("close").remove();
        } else if (dlg$.data("apexPopup")) {
          dlg$.popup("close").remove();
        } else {
          dlg$.remove();
        }
      } catch (e) {
        dlg$.remove();
      }
    });
  }

  // Fechamento da modal pelo Salvar (processo Close Dialog).
  $(document).on("apexafterclosedialog apexafterclosecanceldialog", function () {
    root.setTimeout(limparPopupLovOrfaos, 0);
  });

  // Fechamento pelo X / Cancelar: na janela de fora, qualquer diálogo
  // jQuery UI que contenha iframe (as modais do APEX) dispara a limpeza.
  if (root.self === root.top) {
    $(document).on("dialogclose", function (e) {
      if ($(e.target).find("iframe").length) {
        root.setTimeout(limparPopupLovOrfaos, 0);
      }
    });
  }
})(window);
/* ================= FIM da limpeza de Popup LOV órfãos ================= */