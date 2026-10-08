(function () {
    "use strict";

    var DEBUG = false;   // true só para investigar (o log manda os iframes ao console)
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

/* ===== NC-MARCAS: INÍCIO (gerado por brand/apex/app/gerar-app.mjs — não edite à mão) ===== */
/* O marcador dos seletores :has() CAROS do Natcorp_Style_Min.css. O gerador troca cada um por uma
   classe (.nc-h…) e este bloco põe a classe em quem casa a condição original — uma avaliação só
   (querySelectorAll), em vez de o navegador reavaliar a página inteira a cada mudança. Reavalia ao
   abrir, quando o APEX termina de montar, quando uma região atualiza e quando o DOM muda (no
   máximo a cada ~300 ms: páginas com scripts que mexem no DOM o tempo todo não o fazem rodar sem
   parar). window.__ncMarcasRodadas / __ncMarcasMs contam as rodadas e o tempo gasto. Medido 07/10 (2010:52, CPU 4×): estilo 31,8 s → 3,6 s. */
(function () {
  "use strict";
  var R = [["nc-h1oqplur","html:has(body.t-PageBody--login:not(#nc-p1):not(#nc-p2))"],["nc-hru1t1h","body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):has(.t-Body-contentInner .t-Region iframe[width=\"100%\"])"],["nc-h1x9eum5","body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):has(:is(.t-Body-fullContent, .t-Body-contentInner) .t-HeroRegion)"],["nc-h1vnizw8",".t-Body-title:has(.t-Breadcrumb-item)"],["nc-h117pigh",".t-Body-title:has(.t-ButtonRegion)"],["nc-hmfkwn5",".t-Body-title:has(.t-HeroRegion)"],["nc-h11c1cnr",".t-Region:has(.t-Breadcrumb)"],["nc-hevcny7",".t-Region:has(.t-Breadcrumb-item)"],["nc-h1t53h7j",".t-Region-headerItems--buttons:has(> .t-Button,  > button)"],["nc-hcs77sp",".t-Region-headerIcon:has(.t-Icon[class*=\"fa-\"])"],["nc-h1aj6emb",".t-Region-headerItems--title:has(> .t-Region-headerIcon)"],["nc-h9i6esv",".t-Body-contentInner:has(.t-Region iframe[width=\"100%\"])"],["nc-hz73kau",".row:has(.t-Region iframe[width=\"100%\"])"],["nc-h9njh0p",".t-Region:not(#nc-iframe):has(iframe[width=\"100%\"])"],["nc-h1d6an5q",".t-Region-buttons:has(*:not(:empty))"],["nc-h51siey",".t-Region:has(iframe[width=\"100%\"])"],["nc-hd775l5",".row:has(.t-Form-labelContainer:not(.col-0) .t-Form-label:not(:empty))"],["nc-h1af9ndu",".t-Form-fieldContainer:has(.apex-item-display-only:empty)"],["nc-h1gag0jz",".row:has(> .col > .t-Form-fieldContainer)"],["nc-hipek8",".row:has(textarea)"],["nc-h12o9bt9",".row:has(> .col > .t-Button)"],["nc-hibyvvu",".row:has(.t-Form-fieldContainer .t-Form-label:not(:empty))"],["nc-h1wbwmdn",".col:has(.t-Form-fieldContainer)"],["nc-h1nm95yl",".row:has(.a-Form-error.u-visible)"],["nc-h142ng7w",".t-Form-fieldContainer:has(.a-Form-error.u-visible)"],["nc-h1f9st97","body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):has(#FOTO_ID)"],["nc-hv4qqql",".row:has(#FOTO_ID)"],["nc-h1j7ovfd",".col:has(> #INFORMACOES)"],["nc-hazew2k",".row:has(> .col #LISTA_COLAB)"],["nc-h19kmlyy",".row:has(> .col > #LISTA_COLAB)"],["nc-h13x1l1y",".t-Region:is(.t-Region--noUI, .t-Region--noBorder):not(#nc-sem-borda):not(#nc-lat):has(.t-Form-fieldContainer)"],["nc-h1ao1gqb",".t-Region:has(.a-IG)"],["nc-h14s3c24",".t-Region:has(.t-Region .a-IG)"],["nc-h1bhn8ee",".t-Region:has(.t-Report--rowHighlightOff.t-Report--noBorders)"],["nc-hkpop0d","body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):has(#nc-carregando.is-ativo)"],["nc-h1v0b9n8",".t-Region-body:has(> .container .t-Region:not(.t-Region--noUI))"],["nc-hn549q9",".t-Region-body:has(.a-IRR,  .a-IG,  .t-Report-report)"],["nc-h10igjsy",".row:has(> .col > .t-Button--pillEnd:first-child)"],["nc-hegnn7k",".col:has(> .t-Button--pillEnd:first-child)"],["nc-h1xv0ham",".row:has(.t-Form-inputContainer.col :is(input.apex-item-text, select.selectlist))"],["nc-h1kxbazk",".row:has(.select2-container)"],["nc-h1w0yqq8","body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):has(#pFlowId[value=\"600\"])"],["nc-h12yruav",".t-Region:has(.apex-item-wrapper--display-image)"],["nc-hdgld0l",".col:has(> .t-Form-fieldContainer)"],["nc-hwld1n",".col:has(> .t-Form-fieldContainer:not([style*=\"display: none\"]))"],["nc-h19sdg2g",".row:has(> .col > .t-Form-fieldContainer[style*=\"display: none\"]:only-child)"],["nc-h122jg54",".col:has(> .apex-grid-nbsp:only-child)"],["nc-h1m4ppvu",".t-Region-header:has(> .t-Region-headerItems--buttons > .t-Button > .t-Icon.fa-paperclip)"],["nc-hasdu5t",".t-Region-headerItems--buttons:has(> .t-Button > .t-Icon.fa-paperclip)"],["nc-hux6t7i",".container:has(> .row > .col-2 + .col-8)"],["nc-h1qxecru","body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):has(.t-Body-content .container > .row > .col-3 + .col-6)"],["nc-hhp86in",".t-Region.t-Region--removeHeader:not(#nc-vazia):has(> .t-Region-bodyWrap > .t-Region-body > *)"],["nc-h1p0qn3j",".t-Region.t-Region--removeHeader:not(#nc-vazia):has(.t-Region-buttons :is(.t-Button, button, a))"],["nc-hquc6n9","body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):has(#pFlowId[value=\"300\"])"],["nc-h1bnjph3","body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):has(#P43_HORA_DSP)"],["nc-h1gelzbx",".col:has(> #P43_HORA_DSP_CONTAINER)"],["nc-h1hapmyv",".row:has(> .col > #P43_HORA_DSP_CONTAINER)"],["nc-hti0x91","#P43_MSG_CONTAINER:has(.apex-item-display-only:empty)"],["nc-h67fnuf","body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):has(#pFlowStepId[value=\"902\"])"],["nc-h3j5ur7",".container:has(> .row > .col > .t-Button--large)"],["nc-h12uf5cd",".col:has(> .t-Region--noUI .container > .row > .col > .t-Button--large)"],["nc-h1mgktx3",".row:has(> .col > .t-Region--noUI .container > .row > .col > .t-Button--large)"],["nc-h1rtm4nd",".t-Button.t-Button--noLabel:has(> .t-Icon.fa-paperclip)"],["nc-h9d5pii","body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):has(.nc-secoes-botao)"],["nc-h1aoqui1",".t-Region-body:has(.t-Region:not(.t-Region--noUI))"],["nc-h13atq40","body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):has(.nc-hscroll-float)"],["nc-hn7e9mz",".row:has(> .col > .t-Region > .t-Region-bodyWrap > .t-Region-body > .container > .row > .col > [id$=\"_FOTO_COLAB_CONTAINER\"])"],["nc-h1gyd285",".col:has(> .t-Region > .t-Region-bodyWrap > .t-Region-body > .container > .row > .col > [id$=\"_FOTO_COLAB_CONTAINER\"])"],["nc-h1nz0u36",".col:has(> [id$=\"_MATRICULA_DISPLAY_CONTAINER\"])"],["nc-h2qimqb",":is(.t-Form-itemWrapper, .apex-item-group--popup-lov):has(> :is(input, select):is([style*=\"yellow\" i], [style*=\"#ff0;\" i], [style*=\"#ffff00\" i], [style*=\"255, 255, 0\"]))"],["nc-h1h3ddow",".t-Form-fieldContainer:not(.t-Form-fieldContainer--floatingLabel):has(:is(input, select, textarea):is([style*=\"yellow\" i], [style*=\"#ff0;\" i], [style*=\"#ffff00\" i], [style*=\"255, 255, 0\"]))"],["nc-hfulwnf",".t-Form-fieldContainer--floatingLabel:has(:is(input, select, textarea):is([style*=\"yellow\" i], [style*=\"#ff0;\" i], [style*=\"#ffff00\" i], [style*=\"255, 255, 0\"]))"],["nc-hivlnd4",".t-Form-fieldContainer--floatingLabel:not(#nc-alt-a):not(#nc-alt-b):has(:is(input, select, textarea):is([style*=\"yellow\" i], [style*=\"#ff0;\" i], [style*=\"#ffff00\" i], [style*=\"255, 255, 0\"]))"]];
  var CLASSES = ["a-Form-error","a-IG","a-IRR","apex-grid-nbsp","apex-item-display-only","apex-item-group--popup-lov","apex-item-text","apex-item-wrapper--display-image","col","col-0","col-2","col-3","col-6","col-8","container","fa-paperclip","is-ativo","nc-hscroll-float","nc-secoes-botao","row","select2-container","selectlist","t-Body-content","t-Body-contentInner","t-Body-fullContent","t-Body-title","t-Breadcrumb","t-Breadcrumb-item","t-Button","t-Button--large","t-Button--noLabel","t-Button--pillEnd","t-ButtonRegion","t-Dialog-page","t-Form-fieldContainer","t-Form-fieldContainer--floatingLabel","t-Form-inputContainer","t-Form-itemWrapper","t-Form-label","t-Form-labelContainer","t-HeroRegion","t-Icon","t-PageBody","t-PageBody--login","t-Region","t-Region--noBorder","t-Region--noUI","t-Region--removeHeader","t-Region-body","t-Region-bodyWrap","t-Region-buttons","t-Region-header","t-Region-headerIcon","t-Region-headerItems--buttons","t-Region-headerItems--title","t-Report--noBorders","t-Report--rowHighlightOff","t-Report-report","u-visible"];
  var COM_ESTILO = "input, select, textarea, .t-Form-fieldContainer, iframe";
  /* a versão do CSS desta página (--nc-marcas) tem de ser a deste bloco; se não for, esta cópia não
     marca nada e deixa para a outra (o bloco vai no Allow_Unload e no Natcorp_Registros.js) */
  var VERSAO = "ebpmvq";
  try {
    var vc = getComputedStyle(document.documentElement).getPropertyValue("--nc-marcas").replace(/["'s]/g, "");
    if (vc && vc !== VERSAO) return;
  } catch (e) { /* segue */ }
  if (!R.length || !document.querySelectorAll || window.__ncMarcas) return;
  window.__ncMarcas = true;
  var obs = null, marcando = false, agendado = false, ultimo = 0;
  var INTERVALO = 300;
  window.__ncMarcasRodadas = 0; window.__ncMarcasMs = 0;
  function marcar() {
    agendado = false; ultimo = Date.now(); marcando = true;
    var t0 = (window.performance && performance.now) ? performance.now() : 0;
    for (var i = 0; i < R.length; i++) {
      var k = R[i][0], lista;
      try { lista = document.querySelectorAll(R[i][1]); } catch (e) { continue; }
      var sim = new Set();
      for (var j = 0; j < lista.length; j++) { sim.add(lista[j]); if (!lista[j].classList.contains(k)) lista[j].classList.add(k); }
      var tem = document.getElementsByClassName(k);
      for (var m = tem.length - 1; m >= 0; m--) { if (!sim.has(tem[m])) tem[m].classList.remove(k); }
    }
    if (obs) obs.takeRecords();   /* as mudanças que o próprio marcador fez não pedem outra rodada */
    marcando = false;
    window.__ncMarcasRodadas++;
    if (t0) window.__ncMarcasMs += performance.now() - t0;
  }
  function agendar() {
    if (agendado || marcando) return;
    agendado = true;
    var espera = Math.max(0, INTERVALO - (Date.now() - ultimo));
    setTimeout(function () { (window.requestAnimationFrame || setTimeout)(marcar); }, espera);
  }
  /* durante a montagem o DOM muda sem parar: só os marcos (agora, DOM pronto, carregado, APEX
     pronto); a vigilância das mudanças começa quando a página fica pronta */
  var RELEVANTE = {}; for (var c = 0; c < CLASSES.length; c++) RELEVANTE[CLASSES[c]] = 1;
  function tocaClasse(antes, depois) {
    var a = (antes || "").split(/s+/), d = (depois || "").split(/s+/), i;
    for (i = 0; i < a.length; i++) if (RELEVANTE[a[i]] && d.indexOf(a[i]) < 0) return true;
    for (i = 0; i < d.length; i++) if (RELEVANTE[d[i]] && a.indexOf(d[i]) < 0) return true;
    return false;
  }
  /* só o que pode mudar alguma condição: elemento entrando/saindo, classe citada entrando/saindo,
     style de campo/contêiner/moldura, e os demais atributos observados */
  function importa(lista) {
    for (var i = 0; i < lista.length; i++) {
      var r = lista[i], el = r.target;
      if (r.type === "childList") return true;
      if (r.attributeName === "class") { if (tocaClasse(r.oldValue, el.getAttribute("class"))) return true; continue; }
      if (r.attributeName === "style") { if (el.matches && el.matches(COM_ESTILO)) return true; continue; }
      return true;
    }
    return false;
  }
  function vigiar() {
    if (obs || !window.MutationObserver) return;
    obs = new MutationObserver(function (lista) { if (importa(lista)) agendar(); });
    obs.observe(document.documentElement, { subtree: true, childList: true, attributes: true, attributeOldValue: true,
      attributeFilter: ["class", "style", "id", "value", "disabled", "hidden", "width", "aria-hidden", "src"] });
  }
  function pronto() { marcar(); vigiar(); }
  marcar();
  document.addEventListener("DOMContentLoaded", marcar);
  window.addEventListener("load", function () { marcar(); setTimeout(vigiar, 3000); });
  /* 08/10: este bloco também vai no Natcorp_Registros.js, que em alguns apps carrega ANTES da
     biblioteca do APEX: sem o apex ainda, liga no fim do HTML (antes do apexreadyend acontecer) */
  function ligarApex() {
    if (!window.apex || !apex.jQuery) return false;
    apex.jQuery(window).on("apexreadyend", pronto);
    apex.jQuery(document).on("apexreadyend", pronto).on("apexafterrefresh", marcar);
    /* injetado DEPOIS de a página ficar pronta (há apps em que a casca põe o Registros na moldura
       depois do apexreadyend): o aviso já passou — começa agora */
    if (apex.jQuery.isReady) setTimeout(pronto, 0);
    return true;
  }
  if (!ligarApex()) {
    document.addEventListener("DOMContentLoaded", function () { if (!ligarApex()) setTimeout(vigiar, 3000); });
  }
  window.__ncMarcar = marcar;
})();

/* A PÁGINA PRONTA (07/10): o CSS (Natcorp_Style_Min.css [C14b]) abre toda página interna coberta pelo
   carregando; aqui ela é revelada (html.nc-pronto) quando ficou pronta de verdade:
     1. o APEX terminou de montar (apexreadyend; sem APEX, o load);
     2. não há Ajax pendente (as ações dinâmicas de abertura);
     3. a página passou 250 ms sem inserir/remover elementos (os desenhos montaram);
     4. as fontes carregaram.
   No máximo 8 s depois que a página começou — se ela nunca sossegar, abre assim mesmo (e o próprio CSS
   ainda tem a trava de 12 s). Volta pelo "voltar" do navegador: já revelada. */
(function () {
  "use strict";
  if (window.__ncPronto) return;
  window.__ncPronto = true;
  var html = document.documentElement, feito = false, comecou = false, LIMITE = 8000;
  function revelar() {
    if (feito) return;
    feito = true;
    try { if (window.__ncMarcar) window.__ncMarcar(); } catch (e) { /* segue */ }
    html.classList.add("nc-pronto");
  }
  var agora = (window.performance && performance.now) ? performance.now() : 0;
  setTimeout(revelar, Math.max(0, LIMITE - agora));
  window.addEventListener("pageshow", function (e) { if (e.persisted) revelar(); });
  function depoisDasFontes(cb) {
    var f = document.fonts && document.fonts.ready;
    if (f && typeof f.then === "function") f.then(cb, cb); else cb();
  }
  function aguardarQuieto() {
    if (comecou || feito) return;
    comecou = true;
    var t = null, mo = null;
    function checar() {
      var $ = window.apex && apex.jQuery;
      if ($ && $.active > 0) { t = setTimeout(checar, 120); return; }
      if (mo) mo.disconnect();
      depoisDasFontes(function () {
        var raf = window.requestAnimationFrame || function (f) { return setTimeout(f, 16); };
        raf(function () { raf(revelar); });
      });
    }
    function mexeu(lista) {
      for (var i = 0; i < lista.length; i++) {
        var r = lista[i], j;
        for (j = 0; j < r.addedNodes.length; j++) if (r.addedNodes[j].nodeType === 1) { clearTimeout(t); t = setTimeout(checar, 250); return; }
        for (j = 0; j < r.removedNodes.length; j++) if (r.removedNodes[j].nodeType === 1) { clearTimeout(t); t = setTimeout(checar, 250); return; }
      }
    }
    if (window.MutationObserver && document.body) {
      mo = new MutationObserver(mexeu);
      mo.observe(document.body, { childList: true, subtree: true });
    }
    t = setTimeout(checar, 250);
  }
  /* no document: um handler que devolve false ali não o impede. Sem o apex ainda (o bloco carregou antes
     da biblioteca), liga no fim do HTML — o APEX só avisa depois disso */
  function ligarPronto() {
    if (!window.apex || !apex.jQuery) return false;
    apex.jQuery(document).one("apexreadyend", aguardarQuieto);
    /* chegou depois de o APEX montar a página (arquivo injetado tarde): o aviso já passou, então
       espera a página sossegar a partir de agora (aguardarQuieto ainda espera Ajax e 250 ms quietos) */
    if (apex.jQuery.isReady) setTimeout(aguardarQuieto, 0);
    return true;
  }
  if (!ligarPronto()) {
    if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", ligarPronto);
    else setTimeout(aguardarQuieto, 0);
  }
  /* sem o aviso do APEX (página sem APEX, ou ele já passou): começa 1,5 s depois do load */
  window.addEventListener("load", function () { setTimeout(aguardarQuieto, 1500); });
  if (document.readyState === "complete") setTimeout(aguardarQuieto, 1500);
})();
/* ===== NC-MARCAS: FIM ===== */
