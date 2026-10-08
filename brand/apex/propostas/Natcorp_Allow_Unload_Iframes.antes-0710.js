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
   A PARTIR DAQUI: Natcorp Theme Picker (embutido nesse arquivo
   porque ele já é referenciado em todas as aplicações)
   ============================================================= */

/* =====================================================================
   Natcorp Skin — Seletor de Tema (Oracle APEX 19.x, Universal Theme)
   Sem dependências além do jQuery embarcado no APEX (apex.jQuery).

   O que faz:
   - Insere um ícone de paleta no menu superior (.t-NavigationBar), logo
     antes do item "Blog" (posição fixa por conteúdo, não por índice).
   - Ao clicar, abre uma janela com os layouts de cor disponíveis, em
     formato de cards (amostras de cor + nome + descrição).
   - Aplica o tema escolhido via classe no <html> (ex.: nc-theme-oceano)
     — como o CSS já usa variáveis (--nc-primary etc.), a troca de cor
     vale pra aplicação inteira automaticamente.
   - Guarda a escolha no localStorage (por navegador/dispositivo, por
     enquanto — ainda não persiste por usuário no banco).

   IMPORTANTE: precisa ser referenciado na(s) aplicação(ões) onde o
   menu superior existe (ex.: a aplicação "casca", não necessariamente
   nas aplicações de conteúdo que carregam dentro de iframe).

   ATENÇÃO (histórico): a inserção do ícone espera o menu já estar
   montado (retry com setTimeout + apexreadyend), porque o Navigation
   Bar do APEX é construído via JS de forma assíncrona — inserir cedo
   demais já fez itens nativos (ex.: "Pesquisa", "Manual") não serem
   renderizados.
   ===================================================================== */
(function (root) {
  "use strict";

  var $ = root.apex && root.apex.jQuery ? root.apex.jQuery : root.jQuery;
  if (!$) return;

  // ---------- Seletor de tema de cor (botão flutuante + janela) ----------
  // Guardado por enquanto no localStorage (por navegador/dispositivo).
  // Se depois quisermos por usuário de verdade (entre dispositivos
  // diferentes), trocamos aqui por uma chamada Ajax que salva no banco.
  var NC_THEMES = [
    {
      id: "standard",
      name: "Standard Natcorp",
      desc: "Paleta oficial da marca, em azul-arroxeado escuro com detalhes em roxo.",
      swatches: ["#2c1a63", "#5b2a86", "#ffffff", "#1a1a1a"]
    },
    {
      id: "purple",
      name: "Ametista Natcorp",
      desc: "Uma variação mais vibrante da marca, em violeta profundo com detalhes em ametista.",
      swatches: ["#5b2a86", "#8e4fb8", "#efe9f5", "#4a4a52"]
    },
    {
      id: "lavanda",
      name: "Lavanda Serena",
      desc: "Azul-claro e violeta suave para um ambiente leve, moderno e acolhedor.",
      swatches: ["#6e3c91", "#be6de2", "#e6effd", "#4e5263"]
    },
    {
      id: "iris",
      name: "Íris Corporativa",
      desc: "Roxo da marca em destaque, equilibrado pelo azul profundo e pelo rosa suave.",
      swatches: ["#511c76", "#c95788", "#2c1a63", "#f3eef7"]
    },
    {
      id: "orquidea",
      name: "Orquídea & Petróleo",
      desc: "Violeta e rosa da marca com verde-petróleo discreto para uma leitura descansada.",
      swatches: ["#643a7a", "#c95788", "#1f6b69", "#eef5f4"]
    },
    {
      id: "safira",
      name: "Safira Rosé",
      desc: "Azul da marca dominante, com rosa nos detalhes e violeta como cor de apoio.",
      swatches: ["#2c1a63", "#c95788", "#67418a", "#eef0f8"]
    },
    {
      id: "ameixa",
      name: "Ameixa & Ciano",
      desc: "Ameixa sóbria com ciano moderado e rosa para contrastes claros e funcionais.",
      swatches: ["#5a214f", "#2a8fa3", "#c95788", "#f5eef4"]
    },
    {
      id: "violeta",
      name: "Violeta & Sálvia",
      desc: "Violeta institucional com verde-sálvia suave, confortável para jornadas extensas.",
      swatches: ["#511c76", "#779a87", "#c95788", "#f1f5f1"]
    },
    {
      id: "magenta",
      name: "Magenta Executivo",
      desc: "Rosa profundo em evidência, estruturado pelos tons roxo e azul da marca.",
      swatches: ["#a43e6b", "#511c76", "#2c1a63", "#f8eff3"]
    },
    {
      id: "berinjela",
      name: "Berinjela & Coral",
      desc: "Base berinjela com coral controlado e azul profundo para um visual acolhedor.",
      swatches: ["#4a2348", "#d56f67", "#2c1a63", "#f7f0f1"]
    },
    {
      id: "indigo",
      name: "Índigo & Turquesa",
      desc: "Índigo tecnológico, turquesa equilibrado e rosa aplicado em detalhes pontuais.",
      swatches: ["#39307a", "#258e91", "#c95788", "#eef4f5"]
    },
    {
      id: "aurora",
      name: "Aurora Neutra",
      desc: "Cinza-claro sereno com roxo, rosa e azul da marca usados como pontos de atenção.",
      swatches: ["#511c76", "#c95788", "#2c1a63", "#f2f3f6"]
    },
    {
      id: "oceano",
      name: "Oceano Corporativo",
      desc: "Azuis sóbrios, com boa leitura em ambientes claros e uso prolongado.",
      swatches: ["#1e3a5f", "#2c6fa8", "#e5eef7", "#3f4a57"]
    },
    {
      id: "bordo",
      name: "Bordô Executivo",
      desc: "Bordô elegante com rosa queimado e neutros claros para um visual distinto.",
      swatches: ["#772d3b", "#b85c70", "#f5ebee", "#51464a"]
    }
  ];
  var NC_THEME_STORAGE_KEY = "nc_theme_choice";

  function ncGetSavedTheme() {
    try {
      return root.localStorage.getItem(NC_THEME_STORAGE_KEY) || "purple";
    } catch (e) {
      return "purple";
    }
  }

  function ncSaveTheme(id) {
    try {
      root.localStorage.setItem(NC_THEME_STORAGE_KEY, id);
    } catch (e) {
      // localStorage indisponível (modo privado, etc.) — só não persiste
      // entre sessões, mas continua funcionando na sessão atual.
    }
  }

  function ncApplyTheme(id) {
    NC_THEMES.forEach(function (t) {
      document.documentElement.classList.remove("nc-theme-" + t.id);
    });
    if (id && id !== "purple") {
      document.documentElement.classList.add("nc-theme-" + id);
    }
    ncApplyThemeToIframes(id);
  }

  // Propaga a classe do tema pra dentro de qualquer <iframe> da mesma
  // origem (mesmo domínio) presente na página — é assim que o
  // conteúdo das telas (carregado dentro de um iframe na página
  // "casca") passa a respeitar o tema escolhido, mesmo que a
  // aplicação de dentro do iframe não tenha esse JS referenciado
  // nela mesma. Só funciona se o CSS (Natcorp_Style_Min.css) também
  // estiver carregado lá dentro — sem ele, a classe não tem efeito
  // visual nenhum.
  function ncApplyThemeToIframes(id) {
    ncApplyThemeToIframesIn(document, id, 0);
  }

  // Propaga a classe de PREVIEW (celular/tablet) pra dentro de
  // iframes REGULARES da mesma origem (ex.: uma região que embute
  // outra aplicação inteira, tipo APP_REGION) — mas NÃO entra em
  // iframes de Modal Dialog de verdade (identificados pelo elemento
  // pai .ui-dialog), que já têm seu próprio tratamento nativo e não
  // devem receber a "moldura" nem os ajustes de layout do preview.
  function ncApplyPreviewToIframes(mode) {
    ncApplyPreviewToIframesIn(document, mode, 0);
  }
  function ncApplyPreviewToIframesIn(doc, mode, depth) {
    if (depth > 5) return;
    var iframes;
    try {
      iframes = doc.querySelectorAll("iframe");
    } catch (e) {
      return;
    }
    Array.prototype.forEach.call(iframes, function (iframeEl) {
      var innerDoc;
      try {
        innerDoc = iframeEl.contentDocument || (iframeEl.contentWindow && iframeEl.contentWindow.document);
        if (!innerDoc || !innerDoc.documentElement) return;
        innerDoc.documentElement.classList.remove("nc-preview-mobile", "nc-preview-tablet");
        if (mode !== "desktop") {
          innerDoc.documentElement.classList.add("nc-preview-" + mode);
        }
        ncApplyPreviewToIframesIn(innerDoc, mode, depth + 1);
      } catch (e) {
        // Iframe de outra origem (cross-origin) — ignora.
      }
    });
  }

  // Percorre os iframes de um documento, aplica o tema no <html> de
  // cada um, e entra RECURSIVAMENTE dentro deles — porque Modal
  // Dialogs do APEX costumam carregar dentro de um iframe aninhado
  // dentro do iframe de conteúdo (iframe dentro de iframe), e um
  // "$('iframe')" simples só alcançaria o primeiro nível. Um limite
  // de profundidade (5) evita loop infinito em qualquer cenário
  // anormal.
  function ncApplyThemeToIframesIn(doc, id, depth) {
    if (depth > 5) return;
    var iframes;
    try {
      iframes = doc.querySelectorAll("iframe");
    } catch (e) {
      return;
    }
    Array.prototype.forEach.call(iframes, function (iframeEl) {
      var innerDoc;
      try {
        innerDoc = iframeEl.contentDocument || (iframeEl.contentWindow && iframeEl.contentWindow.document);
        if (!innerDoc || !innerDoc.documentElement) return;
        NC_THEMES.forEach(function (t) {
          innerDoc.documentElement.classList.remove("nc-theme-" + t.id);
        });
        if (id && id !== "purple") {
          innerDoc.documentElement.classList.add("nc-theme-" + id);
        }
        ncApplyThemeToIframesIn(innerDoc, id, depth + 1);
      } catch (e) {
        // Iframe de outra origem (cross-origin) — navegador bloqueia
        // o acesso por segurança, nada a fazer aqui, ignora e segue.
      }
    });
  }

  // Reaplica o tema sempre que um iframe existente terminar de
  // carregar uma página nova (troca de tela dentro do mesmo iframe) e
  // observa a criação de iframes novos — cobrindo os casos de
  // navegação comuns dentro da aplicação "casca".
  function ncWatchIframes() {
    ncAttachLoadListeners(document, 0);
    ncWatchIframesRecursive(document, 0);
  }

  // O evento "load" de um <iframe> NÃO se propaga (bubble) pela
  // página — por isso um handler delegado tipo $(document).on("load",
  // "iframe", fn) nunca dispara de verdade. Aqui a gente anexa o
  // listener DIRETO em cada iframe encontrado, individualmente.
  function ncAttachLoadListeners(doc, depth) {
    if (depth > 5) return;
    var iframes;
    try {
      iframes = doc.querySelectorAll("iframe");
    } catch (e) {
      return;
    }
    Array.prototype.forEach.call(iframes, function (iframeEl) {
      if (iframeEl.hasAttribute("data-nc-load-listener")) return;
      iframeEl.setAttribute("data-nc-load-listener", "1");
      iframeEl.addEventListener("load", function () {
        ncApplyThemeToIframes(ncGetSavedTheme());
        ncApplyPreviewToIframes(ncGetSavedPreviewMode());
        try {
          var innerDoc = iframeEl.contentDocument || (iframeEl.contentWindow && iframeEl.contentWindow.document);
          if (innerDoc) ncAttachLoadListeners(innerDoc, depth + 1);
        } catch (e) {
          // Cross-origin, ignora.
        }
      });
    });
  }

  // Observa a criação de novos iframes dentro de um documento e, ao
  // achar um, também entra nele (se for da mesma origem) pra observar
  // POR DENTRO — cobrindo o caso de Modal Dialogs, que criam um
  // iframe novo aninhado dentro de outro iframe já existente.
  function ncWatchIframesRecursive(doc, depth) {
    if (depth > 5 || !root.MutationObserver) return;
    var debounceTimer = null;
    var observer = new root.MutationObserver(function () {
      root.clearTimeout(debounceTimer);
      debounceTimer = root.setTimeout(function () {
        ncApplyThemeToIframes(ncGetSavedTheme());
        ncApplyPreviewToIframes(ncGetSavedPreviewMode());
        try {
          var iframes = doc.querySelectorAll("iframe");
          Array.prototype.forEach.call(iframes, function (iframeEl) {
            try {
              var innerDoc = iframeEl.contentDocument || (iframeEl.contentWindow && iframeEl.contentWindow.document);
              if (!iframeEl.hasAttribute("data-nc-load-listener")) {
                iframeEl.setAttribute("data-nc-load-listener", "1");
                iframeEl.addEventListener("load", function () {
                  ncApplyThemeToIframes(ncGetSavedTheme());
        ncApplyPreviewToIframes(ncGetSavedPreviewMode());
                  try {
                    var loadedDoc = iframeEl.contentDocument || (iframeEl.contentWindow && iframeEl.contentWindow.document);
                    if (loadedDoc) ncAttachLoadListeners(loadedDoc, depth + 1);
                  } catch (e) {
                    // Cross-origin, ignora.
                  }
                });
              }
              if (innerDoc && !iframeEl.hasAttribute("data-nc-watched")) {
                iframeEl.setAttribute("data-nc-watched", "1");
                ncWatchIframesRecursive(innerDoc, depth + 1);
              }
            } catch (e) {
              // Cross-origin, ignora.
            }
          });
        } catch (e) {
          // Documento inacessível, ignora.
        }
      }, 150);
    });
    try {
      observer.observe(doc.documentElement, { childList: true, subtree: true });
    } catch (e) {
      // Documento ainda não pronto ou inacessível, ignora.
    }
  }

  function ncCloseThemeModal() {
    var $overlay = $(".nc-theme-modal-overlay");
    if ($overlay.length) $overlay.remove();
  }

  function ncOpenThemeModal() {
    if ($(".nc-theme-modal-overlay").length) return;
    var current = ncGetSavedTheme();
    var $overlay = $('<div class="nc-theme-modal-overlay"></div>');
    var $modal = $(
      '<div class="nc-theme-modal">' +
        "<h3>Escolha o layout de cores</h3>" +
        "<p>Selecione a combinação de cores em que você prefere trabalhar.</p>" +
        '<div class="nc-theme-grid"></div>' +
        '<button type="button" class="nc-theme-modal-close">' +
        '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' +
        '<path d="M12 22a1 1 0 0 1 0-20 10 9 0 0 1 10 9 5 5 0 0 1-5 5h-2.25a1.75 1.75 0 0 0-1.4 2.8l.3.4a1.75 1.75 0 0 1-1.4 2.8z"></path>' +
        '<circle cx="13.5" cy="6.5" r=".5" fill="currentColor"></circle>' +
        '<circle cx="17.5" cy="10.5" r=".5" fill="currentColor"></circle>' +
        '<circle cx="6.5" cy="12.5" r=".5" fill="currentColor"></circle>' +
        '<circle cx="8.5" cy="7.5" r=".5" fill="currentColor"></circle>' +
        "</svg>" +
        " Salvar" +
        "</button>" +
        '<div style="clear:both"></div>' +
        "</div>"
    );
    var $grid = $modal.find(".nc-theme-grid");
    NC_THEMES.forEach(function (t) {
      var swatchesHtml = t.swatches
        .map(function (c) {
          return '<span class="nc-theme-card-swatch" style="background:' + c + '"></span>';
        })
        .join("");
      var $card = $(
        '<button type="button" class="nc-theme-card' +
          (t.id === current ? " is-selected" : "") +
          '">' +
          '<div class="nc-theme-card-top">' +
          '<div class="nc-theme-card-swatches">' +
          swatchesHtml +
          "</div>" +
          '<svg class="nc-theme-card-check" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M20 6 9 17l-5-5"></path></svg>' +
          "</div>" +
          '<p class="nc-theme-card-name">' + t.name + "</p>" +
          '<p class="nc-theme-card-desc">' + t.desc + "</p>" +
          "</button>"
      );
      $card.on("click", function () {
        ncApplyTheme(t.id);
        ncSaveTheme(t.id);
        $grid.find(".nc-theme-card").removeClass("is-selected");
        $card.addClass("is-selected");
      });
      $grid.append($card);
    });
    $modal.find(".nc-theme-modal-close").on("click", function () {
      root.location.reload();
    });
    $overlay.on("click", function (e) {
      if (e.target === this) ncCloseThemeModal();
    });
    $overlay.append($modal);
    $("body").append($overlay);
  }

  function ncInsertThemeIcon() {
    if ($(".nc-theme-navitem").length) return true;
    // Mira só o menu de navegação que fica DENTRO do cabeçalho
    // (.t-Header-navBar) — evita inserir por engano em outros menus
    // parecidos que existam dentro do conteúdo da página (ex.: menus
    // de abas tipo "Requisições / Dados Cadastrais / ..." que também
    // usam a classe .t-NavigationBar).
    var $navBar = $(".t-Header-navBar .t-NavigationBar").first();
    // Só insere quando a barra já tiver itens de verdade renderizados —
    // o menu do APEX é montado via JS de forma assíncrona, e inserir
    // cedo demais atrapalha esse processo (fazia itens como "Pesquisa"
    // e "Manual" nunca chegarem a ser adicionados).
    if (!$navBar.length || !$navBar.find("> li").length) return false;

    var $li = $(
      '<li class="t-NavigationBar-item nc-theme-navitem">' +
        '<button type="button" class="t-Button t-Button--icon t-Button--header t-Button--navBar" aria-label="Trocar layout de cores" title="Trocar layout de cores">' +
        '<span class="t-Icon nc-theme-icon">' +
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' +
        '<path d="M12 22a1 1 0 0 1 0-20 10 9 0 0 1 10 9 5 5 0 0 1-5 5h-2.25a1.75 1.75 0 0 0-1.4 2.8l.3.4a1.75 1.75 0 0 1-1.4 2.8z"></path>' +
        '<circle cx="13.5" cy="6.5" r=".5" fill="currentColor"></circle>' +
        '<circle cx="17.5" cy="10.5" r=".5" fill="currentColor"></circle>' +
        '<circle cx="6.5" cy="12.5" r=".5" fill="currentColor"></circle>' +
        '<circle cx="8.5" cy="7.5" r=".5" fill="currentColor"></circle>' +
        "</svg>" +
        "</span>" +
        "</button>" +
        "</li>"
    );
    $li.find("button").on("click", ncOpenThemeModal);

    // Insere logo antes do item "Blog" (pelo texto do link), pra ficar
    // na posição: Pesquisa -> Manual -> [tema] -> Blog -> ... Nem
    // toda aplicação tem "Blog" visível (depende de um parâmetro do
    // banco) — se não achar, tenta ficar antes do "Sair" (logout),
    // que costuma ser o último item real do menu. Só se não achar
    // nenhum dos dois é que cai no último recurso: coloca por último.
    var $navItems = $navBar.find("> li");
    var $blogItem = $navItems.filter(function () {
      return $(this).find("a, button").text().trim().indexOf("Blog") === 0;
    }).first();

    if ($blogItem.length) {
      $li.insertBefore($blogItem);
    } else {
      var $sairItem = $navItems.filter(function () {
        return $(this).find("a, button").text().trim().indexOf("Sair") === 0;
      }).first();
      if ($sairItem.length) {
        $li.insertBefore($sairItem);
      } else {
        $navBar.append($li);
      }
    }
    ncInsertPreviewButtons($li);
    return true;
  }

  // ---------- Botões de preview de dispositivo (teste) ----------
  // Insere 3 botões (Celular / Tablet / Desktop) logo à DIREITA do
  // ícone de paleta, que encolhem e centralizam a página inteira
  // pra simular a largura daquele dispositivo, tipo uma "moldura".
  var NC_PREVIEW_CLASSES = ["nc-preview-mobile", "nc-preview-tablet"];
  var NC_PREVIEW_STORAGE_KEY = "nc_preview_mode";

  function ncGetSavedPreviewMode() {
    try {
      return root.localStorage.getItem(NC_PREVIEW_STORAGE_KEY) || "desktop";
    } catch (e) {
      return "desktop";
    }
  }

  function ncSavePreviewMode(mode) {
    try {
      root.localStorage.setItem(NC_PREVIEW_STORAGE_KEY, mode);
    } catch (e) {}
  }

  function ncApplyPreviewClass(mode) {
    $("html").removeClass(NC_PREVIEW_CLASSES.join(" "));
    if (mode !== "desktop") {
      $("html").addClass("nc-preview-" + mode);
    }
    ncApplyPreviewToIframes(mode);
    ncAdjustCollapsedNavGap(mode);
    ncAdjustNativeSidebarMargin(mode);
  }

  // A pedido: zera o espaço reservado à esquerda quando o menu está
  // recolhido — o usuário prefere aproveitar o espaço todo, mesmo
  // aceitando o risco de uma leve sobreposição com os ícones.
  function ncAdjustCollapsedNavGap(mode) {
    $(".t-Body-main").css("padding-left", "");
  }

  // [Desfeito a pedido do usuário — voltou a causar um espaço
  // indesejado ao expandir o menu. Sem tratamento especial por
  // enquanto; aceita o comportamento nativo do tema.]
  function ncAdjustNativeSidebarMargin(mode) {
    $(".t-Body-content").css("margin-left", "");
  }

  function ncSetPreviewMode(mode, skipSave) {
    ncApplyPreviewClass(mode);
    $(".nc-preview-navitem button").attr("aria-pressed", "false").removeClass("is-active");
    $(".nc-preview-navitem button[data-nc-preview='" + mode + "']").attr("aria-pressed", "true").addClass("is-active");
    if (!skipSave) ncSavePreviewMode(mode);
    $(".a-IRR, .a-IG, .t-Region-body, .js-stickyTableHeader").scrollLeft(0);
    setTimeout(function () {
      $(root).trigger("resize");
      if (root.apex && root.apex.jQuery) {
        root.apex.jQuery(root).trigger("apexwindowresized");
      }
    }, 50);
  }

  function ncInsertPreviewButtons($afterLi) {
    if ($(".nc-preview-navitem").length) return;
    // Não insere esses botões quando a página está rodando DENTRO de
    // um iframe (inclusive o nosso próprio preview) — evita abrir
    // uma nova camada de preview por cima da anterior sem fechar.
    if (window.self !== window.top) return;
    // Permite que UMA aplicação específica desative esse recurso
    // inteiro, sem precisar mexer neste arquivo compartilhado — basta
    // declarar `var NC_DISABLE_PREVIEW = true;` no Shared Components
    // dessa aplicação (Application > Definition > JavaScript >
    // Function and Global Variable Declaration, ou equivalente).
    if (root.NC_DISABLE_PREVIEW === true) return;
    var icons = {
      mobile:
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect width="14" height="20" x="5" y="2" rx="2" ry="2"></rect><path d="M12 18h.01"></path></svg>',
      tablet:
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect width="16" height="20" x="4" y="2" rx="2" ry="2"></rect><line x1="12" x2="12.01" y1="18" y2="18"></line></svg>',
      desktop:
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect width="20" height="14" x="2" y="3" rx="2"></rect><line x1="8" x2="16" y1="21" y2="21"></line><line x1="12" x2="12" y1="17" y2="21"></line></svg>'
    };
    var labels = { mobile: "Visualizar em Celular", tablet: "Visualizar em Tablet", desktop: "Visualizar em Desktop" };
    var $items = $();
    ["mobile", "tablet", "desktop"].forEach(function (mode) {
      var $li = $(
        '<li class="t-NavigationBar-item nc-preview-navitem">' +
          '<button type="button" class="t-Button t-Button--icon t-Button--header t-Button--navBar' + (mode === "desktop" ? " is-active" : "") + '" data-nc-preview="' + mode + '" aria-label="' + labels[mode] + '" title="' + labels[mode] + '" aria-pressed="' + (mode === "desktop" ? "true" : "false") + '">' +
          '<span class="t-Icon nc-preview-icon">' + icons[mode] + "</span>" +
          "</button>" +
          "</li>"
      );
      $li.find("button").on("click", function () {
        ncSetPreviewMode($(this).attr("data-nc-preview"));
      });
      $items = $items.add($li);
    });
    $items.insertAfter($afterLi);
    ncSetPreviewMode(ncGetSavedPreviewMode(), true);
  }

  function ncBuildThemeButton() {
    if (ncInsertThemeIcon()) return;
    // Rede de segurança: tenta de novo em alguns instantes, caso o
    // menu ainda não tivesse sido montado na primeira tentativa.
    root.setTimeout(ncInsertThemeIcon, 400);
    root.setTimeout(ncInsertThemeIcon, 1200);
    root.setTimeout(ncInsertThemeIcon, 2500);
    $(document).on("apexreadyend", ncInsertThemeIcon);
  }

  function ncRunAfterAllReady() {
    ncFixLoginIconPadding();
    ncFixFloatingPopupLov();
    ncBindNavToggle();
    ncRefreshAfterFontLoad();
    ncInsertLoginSubtitle();
    ncShrinkOverflowingText();
    ncHideEmptyImageRegions();
  }

  // Item "Display Image" configurado como "Hidden" (esconder quando
  // vazio) no Template Options — quando não há foto, o
  // .t-Form-itemWrapper fica sem nenhum <img> dentro. O CSS puro (via
  // :has() encadeado) não estava pegando todo caso de forma confiável,
  // então aqui garante via JavaScript: acha o campo vazio, esconde o
  // campo, e sobe pela árvore escondendo a região (.t-Region) e a
  // coluna de grade (.col-X) que existem só pra abrigar ele — sem
  // deixar nenhum espaço vazio, moldura ou linha sobrando.
  function ncHideEmptyImageRegions() {
    $(".apex-item-wrapper--display-image").each(function () {
      var $wrapper = $(this);
      var temImagem = $wrapper.find(".t-Form-inputContainer .t-Form-itemWrapper img").length > 0;
      if (temImagem) return;

      $wrapper.hide();

      // Sobe até achar a .t-Region mais próxima e esconde ela também.
      var $regiao = $wrapper.closest(".t-Region");
      if ($regiao.length) {
        $regiao.hide();
        // A coluna de grade (col-X) que envolve a região também
        // precisa sumir, senão sobra o espaço lateral reservado.
        var $coluna = $regiao.parent().filter('[class*="col-"]');
        if ($coluna.length) {
          $coluna.hide();
        }
      }
    });
  }

  // A pedido: removida toda a tentativa de mexer no redimensionamento
  // do textarea (altura mínima, alcinha própria, etc.) — algo na
  // aplicação estava bloqueando o resize nativo de um jeito que não
  // conseguimos contornar via CSS/JS, então voltamos a deixar
  // textarea 100% no comportamento padrão do APEX, sem nenhuma
  // interferência nossa.

  // Região "Filtros" (Left Side Column, .t-Body-side) — mede cada
  // label/título/texto de botão individualmente e SÓ diminui a
  // fonte (via classe .nc-text-shrunk) do item que realmente está
  // cortando (scrollWidth > clientWidth), sem tocar em nenhum outro
  // texto que já cabe normalmente no tamanho padrão.
  function ncShrinkOverflowingText() {
    var $targets = $(".t-Body-side .t-Form-label, .t-Body-side .t-Region-title, .t-Body-side .t-Button-label");
    $targets.each(function () {
      var $el = $(this);
      $el.removeClass("nc-text-shrunk");
      // Precisa medir SEM a redução (por isso removeClass acima)
      // antes de decidir se precisa aplicar de novo.
      if (this.scrollWidth > this.clientWidth + 1) {
        $el.addClass("nc-text-shrunk");
      }
    });
  }

  // Recalcula quando a coluna de Filtros muda de tamanho (expandir/
  // recolher menu, redimensionar janela, trocar de modo de preview),
  // já que a largura disponível muda nesses casos.
  $(root).on("resize", function () {
    root.clearTimeout(root._ncShrinkTimer);
    root._ncShrinkTimer = root.setTimeout(ncShrinkOverflowingText, 200);
  });
  $(document).on("click", "[id^='OPEN_'], [id^='CLOSE_']", function () {
    root.setTimeout(ncShrinkOverflowingText, 150);
  });

  // Insere o subtítulo da tela de login logo abaixo da foto do
  // cabeçalho, com o texto se adaptando automaticamente conforme
  // quais campos existem (Empresa e/ou Matrícula, além de Usuário/
  // Senha) — o APEX não tem esse parágrafo nativamente, então
  // criamos ele via JS em vez de pedir pra mexer na página.
  function ncInsertLoginSubtitle() {
    if (!$("body").is(".t-PageBody--login")) return;
    if ($(".t-Login-subtitle").length) return; // já inserido
    var temEmpresa = $("#P900_EMPRESA").length > 0;
    var temMatricula = $("#P900_MATRICULA").length > 0;
    var texto;
    if (temEmpresa && temMatricula) {
      texto = "Entre com sua empresa, matrícula, usuário e senha para acessar o sistema.";
    } else if (temEmpresa) {
      texto = "Entre com sua empresa, usuário e senha para acessar o sistema.";
    } else if (temMatricula) {
      texto = "Entre com sua matrícula, usuário e senha para acessar o sistema.";
    } else {
      texto = "Entre com seu usuário e senha para acessar o sistema.";
    }
    $('<p class="t-Login-subtitle"></p>').text(texto).prependTo(".t-Login-body");
  }

  // A fonte do Google Fonts (Plus Jakarta Sans) carrega de forma
  // assíncrona (display:swap) — o navegador mostra uma fonte
  // substituta primeiro, depois troca pela de verdade quando ela
  // termina de carregar. Se o Interactive Grid (que calcula alturas
  // e posições via JavaScript, incluindo a técnica de "colunas
  // congeladas") já tiver feito esses cálculos ANTES dessa troca,
  // o texto muda de tamanho depois mas os cálculos internos não são
  // refeitos — causando desalinhamento entre a coluna de checkbox e
  // a de dados. Isso avisa a página pra recalcular assim que a fonte
  // realmente terminar de carregar.
  function ncRefreshAfterFontLoad() {
    if (!document.fonts || !document.fonts.ready) return;
    document.fonts.ready.then(function () {
      setTimeout(function () {
        $(root).trigger("resize");
        if (root.apex && root.apex.jQuery) {
          root.apex.jQuery(root).trigger("apexwindowresized");
        }
        // Sticky Widget do APEX (cabeçalhos fixos/colunas congeladas)
        // escuta esse evento especificamente pra recalcular medidas.
        $(document).trigger("theme42layoutchanged");
      }, 50);
    });
  }

  var ncNavToggleBound = false;
  function ncBindNavToggle() {
    if (ncNavToggleBound) return;
    ncNavToggleBound = true;
    // Recalcula o respiro à esquerda quando o usuário expande/recolhe
    // o menu lateral (a largura muda entre "só ícones" e "com texto").
    $(document).on("click", "#t_Button_navControl", function () {
      setTimeout(function () {
        ncAdjustCollapsedNavGap(ncGetSavedPreviewMode());
        ncAdjustNativeSidebarMargin(ncGetSavedPreviewMode());
        ncShrinkOverflowingText();
      }, 350);
    });
  }

  $(function () {
    ncApplyTheme(ncGetSavedTheme());
    if (root.NC_DISABLE_PREVIEW !== true) {
      ncApplyPreviewClass(ncGetSavedPreviewMode());
    }
    ncBuildThemeButton();
    ncWatchIframes();
    ncRunAfterAllReady();
  });
  // "apexreadyend" é o evento nativo do APEX que dispara depois que
  // TUDO termina de inicializar — inclusive widgets nativos como o
  // do login (apex.theme42.initializePage.appLogin()) e o do Popup
  // LOV (apex.widget.popupLov(...)), que são os que estavam
  // desfazendo nossas mudanças de CSS depois que a página carregava.
  // Rodar nosso ajuste DEPOIS desse evento garante a ordem certa,
  // sem precisar adivinhar tempos com setTimeout.
  $(document).on("apexreadyend", ncRunAfterAllReady);
  $(root).on("load", ncRunAfterAllReady);
  root.setTimeout(ncRunAfterAllReady, 1500);

  function ncFixLoginIconPadding() {
    ["P900_USUARIO", "P900_SENHA", "P900_EMPRESA", "P900_MATRICULA", "P900_EMAIL"].forEach(function (id) {
      var el = document.getElementById(id);
      if (el) el.style.setProperty("padding-left", "38px", "important");
    });
  }

  // Mesma causa raiz do login: o widget nativo do Popup LOV
  // (apex.widget.popupLov) também mexe no campo depois que a página
  // carrega, desfazendo o padding do Floating Label via CSS puro.
  // Aplica via JS, com !important, do mesmo jeito que resolveu o
  // problema do login.
  function ncFixFloatingPopupLov() {
    $(".t-Form-fieldContainer--floatingLabel input.apex-item-popup-lov").each(function () {
      this.style.setProperty("height", "44px", "important");
      this.style.setProperty("min-height", "44px", "important");
      this.style.setProperty("padding", "20px 12px 0", "important");
      this.style.setProperty("line-height", "1", "important");
    });
  }
})(window);


/* =============================================================
   A PARTIR DAQUI: Natcorp Stepper (comportamento de etapas/
   página única — opt-in via classe nc-stepper-host na região)
   ============================================================= */

/* =====================================================================
   Natcorp Skin — comportamento (Oracle APEX 19.x, Universal Theme)
   Sem dependências além do jQuery embarcado no APEX (apex.jQuery).

   O que faz, sem alterar nenhuma página:
   - Detecta as sub-regiões de 1º nível dentro da região do formulário e
     as trata como "etapas" (usa o título de cada região como rótulo).
   - Injeta um stepper responsivo no topo e um alternador
     "Etapas / Página única".
   - No modo Etapas exibe uma seção por vez; no modo Página única exibe
     todas empilhadas com cabeçalho numerado destacado.
   - Guarda a preferência do usuário em localStorage por página.

   Opt-in por página: adicione a classe `nc-stepper-host` na região
   container (Region > Appearance > CSS Classes). Se nenhuma região tiver
   essa classe, o script tenta a primeira região com 2+ sub-regiões.
   ===================================================================== */
(function (root) {
  "use strict";

  var $ = root.apex && root.apex.jQuery ? root.apex.jQuery : root.jQuery;
  if (!$) return;

  var STORE_KEY = "nc.viewMode." + (root.location.pathname + root.location.search).slice(-120);

  function readMode() {
    // Sempre abre em "Página única" por padrão, toda vez que a página
    // carrega — não guarda mais a última escolha entre uma visita e
    // outra.
    return "unica";
  }

  function saveMode(mode) {
    try { root.localStorage.setItem(STORE_KEY, mode); } catch (e) {}
  }

  function findHost() {
    // Só ativa quando a região TEM a classe nc-stepper-host, marcada
    // manualmente no Page Designer. Sem essa classe, a página nunca
    // ganha stepper nem os botões de Etapas/Página única — esse é o
    // padrão. (nc-no-stepper na página continua funcionando como
    // reforço extra, caso precise desligar mesmo com a classe presente.)
    if ($("body").hasClass("nc-no-stepper")) return $();
    return $(".nc-stepper-host").first();
  }

  function sectionsOf($host) {
    return $host.find(".t-Region").filter(function () {
      return $(this).parents(".t-Region").first().is($host);
    });
  }

  function stepLabelOf($section, index) {
    return titleAndSubtitleOf($section, index).stepLabel;
  }

  // Lê o Título da região e separa em título/subtítulo pelo caractere "|".
  // Basta escrever no campo Title do Page Designer, ex.:
  //   Requisição de Pessoal|Numeração, situação e datas de controle
  // Sem "|" no título, a região simplesmente não exibe subtítulo.
  // Lê o Título da região e separa pelo caractere "|". Dois formatos:
  //   Título|Subtítulo                    (aba do stepper = Título)
  //   Etapa|Título|Subtítulo              (aba do stepper = Etapa, card mostra Título)
  // Ex.: Identificação|Requisição de Pessoal|Numeração, situação e datas de controle
  function titleAndSubtitleOf($section, index) {
    var raw = $section.find("> .t-Region-header .t-Region-title").first().text();
    raw = (raw || "").trim();
    if (!raw) return { stepLabel: "Etapa " + (index + 1), title: "Etapa " + (index + 1), subtitle: "" };
    var parts = raw.split("|");
    if (parts.length >= 3) {
      return {
        stepLabel: (parts[0] || "").trim(),
        title: (parts[1] || "").trim(),
        subtitle: (parts[2] || "").trim(),
      };
    }
    var title = (parts[0] || "").trim();
    return {
      stepLabel: title,
      title: title,
      subtitle: (parts[1] || "").trim(),
    };
  }

  function updatePendencies($sections, $stepper) {
    $sections.each(function (i) {
      var $s = $(this);
      var errors = $s.find(".apex-page-item-error, .has-error").filter(":visible").length;
      // :visible checa o elemento E todos os pais — um campo dentro
      // de um container com display:none (comum quando o campo só
      // aparece depois de uma Dynamic Action, dependendo de outra
      // escolha do usuário) não deve contar como pendência, já que a
      // pessoa nem tem como preenchê-lo enquanto estiver escondido.
      var emptyRequired = $s.find(".is-required").find("input, select, textarea").filter(":visible").filter(function () {
        return !$(this).val() || $(this).val() === "";
      }).length;

      var $item = $stepper.find('.nc-stepper__item[data-index="' + i + '"]');
      var $status = $item.find(".nc-stepper__status");

      if (!$status.length) {
        $status = $('<span class="nc-stepper__status"></span>').appendTo($item.find(".nc-stepper__text"));
      }

      $item.removeClass("is-error is-pending is-ok");
      if (errors > 0) {
        $status.text(errors + " erro(s)");
        $item.addClass("is-error");
      } else if (emptyRequired > 0) {
        $status.text(emptyRequired + " pendência(s)");
        $item.addClass("is-pending");
      } else {
        $status.text("✓ OK");
        $item.addClass("is-ok");
      }
    });
  }

  function decorate($sections) {
    $sections.each(function (i) {
      var $s = $(this);
      if ($s.data("ncDecorated")) return;
      $s.data("ncDecorated", true);
      $s.addClass("nc-section");
      // O nome da etapa (ex.: "Identificação", "Vaga e Local") aparece
      // só na aba de navegação do stepper — de propósito, não criamos
      // nenhum cartão de cabeçalho pra ela aqui. As sub-regiões reais
      // dentro dela (ex.: "Requisição de Pessoal") mantêm seus próprios
      // cabeçalhos nativos normalmente, via decorateNativeHeaders().
    });
  }

  function build($host) {
    var $sections = sectionsOf($host);
    if ($sections.length < 1) return;

    decorate($sections);

    var mode = readMode();
    var active = 0;

    var $toggle = $(
      '<div class="nc-viewtoggle" role="group" aria-label="Modo de visualização">' +
        '<button type="button" data-mode="unica">' +
          '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">' +
            '<rect x="3" y="3" width="18" height="18" rx="2"/><line x1="3" y1="9" x2="21" y2="9"/>' +
            '<line x1="3" y1="15" x2="21" y2="15"/><line x1="9" y1="9" x2="9" y2="21"/>' +
          "</svg>" +
          "<span>Página única</span>" +
        "</button>" +
        '<button type="button" data-mode="etapas">' +
          '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">' +
            '<line x1="8" y1="6" x2="21" y2="6"/><line x1="8" y1="12" x2="21" y2="12"/><line x1="8" y1="18" x2="21" y2="18"/>' +
            '<line x1="3" y1="6" x2="3.01" y2="6"/><line x1="3" y1="12" x2="3.01" y2="12"/><line x1="3" y1="18" x2="3.01" y2="18"/>' +
          "</svg>" +
          "<span>Etapas</span>" +
        "</button>" +
      "</div>"
    );

    var $stepper = $('<div class="nc-stepper" role="tablist"></div>');
    $sections.each(function (i) {
      var $s = $(this);
      var info = titleAndSubtitleOf($s, i);
      $(
        '<button type="button" class="nc-stepper__item" role="tab">' +
          '<span class="nc-stepper__num">' + (i + 1) + "</span>" +
          '<span class="nc-stepper__text">' +
            '<span class="nc-stepper__label"></span>' +
            '<span class="nc-stepper__status"></span>' +
          "</span>" +
        "</button>"
      )
        .find(".nc-stepper__label").text(info.stepLabel).end()
        .attr("data-index", i)
        .appendTo($stepper);

      // Cartão de destaque (bolinha + título + subtítulo) no topo do
      // conteúdo da seção — só aparece no modo "Página única" (ver CSS
      // .nc-mode-unica), pra identificar de qual etapa é cada bloco
      // quando todas ficam visíveis ao mesmo tempo, empilhadas.
      var $heading = $(
        '<div class="nc-section-heading">' +
          '<span class="nc-section-heading__num">' + (i + 1) + "</span>" +
          '<span class="nc-section-heading__text">' +
            '<span class="nc-section-heading__row">' +
              '<h3 class="nc-section-heading__title"></h3>' +
            "</span>" +
            '<p class="nc-section-heading__subtitle"></p>' +
          "</span>" +
        "</div>"
      );
      $heading.find(".nc-section-heading__title").text(info.title);
      if (info.subtitle) {
        $heading.find(".nc-section-heading__subtitle").text(info.subtitle);
      } else {
        $heading.find(".nc-section-heading__subtitle").remove();
      }
      var $body = $s.find("> .t-Region-bodyWrap > .t-Region-body").first();
      if ($body.length) $body.prepend($heading);
    });

    $host.before($toggle, $stepper);

    // Verifica se UMA seção específica tem algum conteúdo genuinamente
    // visível dentro (região, campo, tabela, etc.) — checando o
    // display do próprio elemento, não afetado pelo ancestral já
    // escondido pela troca de aba do stepper (senão uma etapa INATIVA
    // com conteúdo de verdade seria incorretamente considerada vazia).
    function sectionHasContent($s) {
      // Reativa temporariamente só o display da PRÓPRIA seção (que pode
      // estar "none" por causa da nossa troca de abas), sem mexer em
      // nenhum ancestral/descendente — assim, :visible reflete de
      // verdade qualquer outra coisa escondida no meio do caminho
      // (como uma região escondida por Dynamic Action).
      var el = $s[0];
      var prevDisplay = el.style.display;
      el.style.display = "";

      var found =
        $s
          .find(".t-Region, .t-Form-fieldContainer, .t-ButtonRegion, table, .a-IRR-region, .apex-item-group")
          .filter(":visible").length > 0;

      el.style.display = prevDisplay;

      return found;
    }

    function render() {
      $host.toggleClass("nc-mode-unica", mode === "unica");
      // $stepper (a lista de botões das etapas) é IRMÃ de $host no
      // DOM, não filha — por isso o controle de mostrar/esconder tem
      // que ser feito aqui via JS diretamente na referência, não por
      // CSS (um seletor `.nc-stepper-host .nc-stepper` nunca bateria).
      $stepper.toggle(mode !== "unica");
      // Esconde o botão de cada etapa que não tem nenhum conteúdo
      // visível (ex.: a única região dentro dela foi escondida por
      // uma Dynamic Action nativa do APEX) — e também o cartão de
      // destaque dela no modo Página única, já que não faria sentido
      // mostrar o cartão de uma etapa vazia.
      var anyHasContent = false;
      $sections.each(function (i) {
        var $s = $(this);
        var has = sectionHasContent($s);
        if (has) anyHasContent = true;
        $stepper.find('.nc-stepper__item[data-index="' + i + '"]').toggle(has);
        $s.toggleClass("nc-section-empty", !has);
      });
      // Renumera as bolinhas visíveis em sequência (1, 2, 3...) — se a
      // etapa 1 sumir, a que era "2" tem que virar "1", e assim por
      // diante. O data-index (usado pro clique saber qual seção abrir)
      // continua apontando pra seção real, só o número mostrado muda.
      // O número do CARTÃO da própria seção (nc-section-heading__num)
      // é renumerado junto, pra ficar sempre igual ao do botão.
      var visibleCount = 0;
      $stepper.find(".nc-stepper__item").each(function () {
        var $item = $(this);
        if ($item.css("display") !== "none") {
          visibleCount += 1;
          $item.find(".nc-stepper__num").text(visibleCount);
          var idx = $item.attr("data-index");
          $sections.eq(Number(idx)).find("> .t-Region-bodyWrap > .t-Region-body > .nc-section-heading .nc-section-heading__num").text(visibleCount);
        }
      });
      // Se a etapa ativa no momento ficou sem conteúdo, pula pra
      // primeira etapa que tenha algo.
      if (!sectionHasContent($sections.eq(active))) {
        $sections.each(function (i) {
          if (sectionHasContent($(this))) {
            active = i;
            return false;
          }
        });
      }

      $toggle.toggle(anyHasContent);

      $toggle.find("button").each(function () {
        $(this).toggleClass("is-active", $(this).data("mode") === mode);
      });
      $stepper.toggle(anyHasContent && mode === "etapas");

      $sections.each(function (i) {
        var $s = $(this);
        var visible = mode === "unica" || i === active;
        $s.toggle(visible);
      });

      $stepper.find(".nc-stepper__item").each(function () {
        $(this).toggleClass("is-active", Number($(this).attr("data-index")) === active);
      });

      updatePendencies($sections, $stepper);
    }

    $toggle.on("click", "button", function () {
      mode = String($(this).data("mode"));
      saveMode(mode);
      render();
    });

    $stepper.on("click", ".nc-stepper__item", function () {
      active = Number($(this).attr("data-index")) || 0;
      render();
    });

    $(document).on("change keyup input apexafterrefresh apex-page-error", function () {
      updatePendencies($sections, $stepper);
    });

    render();
    // Dynamic Actions nativas de "Page Load" (ex.: esconder uma região)
    // rodam DEPOIS do nosso script, dentro da inicialização do APEX.
    // "apexreadyend" é o evento que o próprio APEX dispara quando TODAS
    // as ações de carregamento da página já terminaram — o jeito certo
    // de reavaliar, em vez de apostar num tempo fixo de espera.
    $(document).on("apexreadyend", render);
    // Mantém o setTimeout como rede de segurança extra, caso algum
    // ambiente não dispare "apexreadyend" a tempo.
    root.setTimeout(render, 300);
    root.setTimeout(render, 1000);
  }

  // Alguns templates do APEX ("stacked") colocam o botão de ajuda dentro
  // do .t-Form-labelContainer (junto com o label), em vez de junto ao
  // campo. Isso faz o "?" aparecer em cima do item. Move o botão pra
  // dentro do .t-Form-itemWrapper do próprio campo, onde ele realmente
  // deveria estar — depois disso, o CSS que já alinha o botão à direita
  // do item passa a funcionar normalmente.

  $(function () {
    var $host = findHost();
    if ($host.length) build($host);
  });
})(window);

/* =============================================================
   A PARTIR DAQUI: Simulação do botão "Maximizar" em Interactive
   Report (TESTE, a pedido do usuário — sabendo que NÃO é cópia fiel
   do recurso nativo do Oracle, só um comportamento parecido).

   PRA REMOVER esse recurso inteiro depois: apaga este bloco (daqui
   até o comentário "FIM da simulação do botão Maximizar" logo
   abaixo) e o bloco correspondente marcado no Natcorp_Style_Min.css
   ("Simulação de Maximizar no Interactive Report (TESTE)"). Nada
   aqui interfere em mais nada do arquivo nem do CSS.
   ============================================================= */

/* =====================================================================
   Natcorp Skin — Botão "Maximizar" simulado (Oracle APEX 19.x)
   Sem dependências além do jQuery embarcado no APEX (apex.jQuery).

   O que faz:
   - Em toda região de Interactive Report (.t-IRR-region) que NÃO
     tenha a classe nativa "js-showMaximizeButton" (ou seja, sem o
     botão real do Oracle habilitado no Page Designer), insere um
     botão visualmente parecido (mesmo ícone/estilo) na barra de
     ferramentas do relatório (.a-IRR-buttons).
   - Nunca mexe nem duplica nada nas regiões que JÁ têm o botão
     nativo — essas continuam 100% no comportamento original do
     Oracle, sem nenhuma interferência nossa.
   - Ao clicar, "maximiza" a região: ela passa a flutuar por cima do
     resto da página, ocupando quase a tela toda, com fundo escurecido
     atrás. Clicar de novo, clicar fora, ou apertar Esc fecha e
     devolve a região pro lugar original.
   ===================================================================== */
(function (root) {
  "use strict";

  var $ = root.apex && root.apex.jQuery ? root.apex.jQuery : root.jQuery;
  if (!$) return;

  var ATTR_PROCESSADO = "data-nc-fake-maximize";

  function inserirBotoes() {
    $(".t-IRR-region").each(function () {
      var $regiao = $(this);

      // Já tem o botão NATIVO do Oracle — não mexe, não duplica.
      if ($regiao.hasClass("js-showMaximizeButton")) return;

      // Já processamos essa região antes (evita duplicar nosso
      // próprio botão se a função rodar de novo).
      if ($regiao.attr(ATTR_PROCESSADO)) return;

      var $barraBotoes = $regiao.find(".a-IRR-buttons").first();

      // Região sem o container de botões da toolbar — cria um (só
      // se for mesmo um Interactive Report, identificado pela
      // presença da toolbar padrão).
      if (!$barraBotoes.length) {
        var $toolbar = $regiao.find(".a-IRR-toolbar").first();
        if (!$toolbar.length) return;
        $barraBotoes = $('<div class="a-IRR-buttons"></div>');
        $toolbar.append($barraBotoes);
      }

      $regiao.attr(ATTR_PROCESSADO, "1");

      var $botao = $(
        '<button type="button" class="t-Button t-Button--noLabel t-Button--icon t-Button--iconOnly t-Button--noUI nc-fake-maximize-btn" ' +
        'aria-expanded="false" title="Maximizar" aria-label="Maximizar">' +
        '<span class="t-Icon a-Icon icon-maximize" aria-hidden="true"></span>' +
        "</button>"
      );

      $botao.on("click", function () {
        alternarMaximizado($regiao, $botao);
      });

      // Insere depois de qualquer botão de ação da página que já
      // exista ali (ex.: "Criar Requisição") — a pedido, sempre no
      // final, rente à direita.
      $barraBotoes.append($botao);
    });
  }

  // HISTÓRICO: chegamos a ter aqui um bloco que desligava o cabeçalho
  // "grudento" (sticky) do relatório enquanto maximizado. Removido a
  // pedido — o comportamento correto, confirmado comparando com o
  // relatório nativo (sem maximizar), é o cabeçalho continuar FIXO no
  // topo acompanhando a rolagem, igual já acontece nativamente. Ou
  // seja: a gente não deve interferir nesse mecanismo de jeito nenhum,
  // nem maximizado — só deixar o widget nativo do Oracle funcionar.

  function alternarMaximizado($regiao, $botao) {
    if ($regiao.hasClass("nc-fake-maximized")) {
      fecharMaximizado($regiao, $botao);
    } else {
      abrirMaximizado($regiao, $botao);
    }
  }

  // Em página COM iframe (a "casca"), "position: fixed" só cobre a
  // JANELA DO IFRAME, nunca a janela real do navegador — é uma regra
  // do próprio CSS, não tem como forçar de outro jeito enquanto o
  // elemento continuar dentro do iframe (confirmado: numa tela de
  // 1920px de largura com iframe de 1679px, a região maximizada
  // cobria só os 1679px, deixando o menu lateral de fora sempre
  // visível). A solução é mover a região pra virar filha direta do
  // <body> da página DE CIMA (a "casca"), não do body do iframe — aí
  // o "fixed" passa a valer pra janela real, sem sobrar nada. Só dá
  // pra fazer isso quando a página de cima é da MESMA ORIGEM (senão o
  // navegador bloqueia o acesso por segurança) — nesse caso (ou numa
  // página sem iframe nenhum), cai de volta pro <body> local mesmo.
  function contextoTelaCheia() {
    try {
      if (root.self !== root.top && root.top && root.top.document && root.top.document.body) {
        return { body: root.top.document.body, doc: root.top.document, win: root.top };
      }
    } catch (e) {
      // Iframe de origem diferente — sem acesso, sem alternativa,
      // segue com o body local mesmo (mesma limitação de sempre).
    }
    return { body: document.body, doc: document, win: root };
  }

  function abrirMaximizado($regiao, $botao) {
    // Só uma região maximizada por vez — fecha qualquer outra antes.
    $(".t-IRR-region.nc-fake-maximized").each(function () {
      fecharMaximizado($(this), $(this).find(".nc-fake-maximize-btn"));
    });

    var alvo = contextoTelaCheia();
    $regiao.data("ncMaximizeAlvo", alvo);

    // "position: fixed" só cobre a tela INTEIRA se nenhum ancestral
    // tiver "transform" (o tema usa isso em algum ponto, provavelmente
    // ligado à animação do menu lateral) — quando tem, o fixed fica
    // preso na área desse ancestral em vez da tela toda (foi
    // exatamente o que você viu: ficou preso na coluna central, sem
    // cobrir o menu/coluna lateral). Pra escapar disso de vez, movemos
    // a região de verdade no HTML pra virar filha direta do <body>
    // certo (o de cima, quando dá — ver contextoTelaCheia) enquanto
    // maximizada — daí o "fixed" passa a valer pra tela inteira mesmo.
    // Guardamos uma "marca" (comentário HTML invisível) no lugar de
    // origem, pra devolver a região exatamente ali quando fechar.
    if (!$regiao.data("ncOrigMarker")) {
      var marcador = document.createComment("nc-fake-maximize-origem");
      $regiao[0].parentNode.insertBefore(marcador, $regiao[0]);
      $regiao.data("ncOrigMarker", marcador);
    }
    alvo.body.appendChild($regiao[0]);

    // HISTÓRICO: chegamos a mover aqui também a barra de rolagem
    // horizontal flutuante (outra funcionalidade, mais abaixo no
    // arquivo) pro mesmo <body>, junto com a região. Não precisa mais:
    // agora ela já nasce direto no <body> certo (o da página de cima,
    // quando dá) desde o início, então já vale pra tela real o tempo
    // todo — maximizado ou não — sem precisar mover nada durante o
    // maximizar/restaurar.

    // A pedido: sem fundo escurecido/modal — a região ocupa a tela
    // inteira, "de ponta a ponta", parecido com o comportamento
    // nativo do Oracle, em vez de um diálogo flutuante por cima.
    $regiao.addClass("nc-fake-maximized");
    $(alvo.body).addClass("nc-fake-maximize-open");
    $botao
      .attr("aria-expanded", "true")
      .attr("title", "Restaurar")
      .attr("aria-label", "Restaurar");

    // O ESC precisa ser ouvido no documento onde o foco/teclado vai
    // realmente estar depois da região se mudar pra lá (o da página de
    // cima, quando escapamos do iframe) — não adianta ouvir só no
    // documento local se a região não está mais nele.
    var aoTeclar = function (e) {
      if (e.key === "Escape" || e.keyCode === 27) {
        fecharMaximizado($regiao, $botao);
      }
    };
    alvo.doc.addEventListener("keydown", aoTeclar);
    $regiao.data("ncMaximizeEscHandler", aoTeclar);

    // Dá um tempo pro layout se ajustar e dispara resize +
    // "theme42layoutchanged" (evento nativo que o cabeçalho "sticky"
    // do relatório escuta pra recalcular sua largura/posição), pra
    // ele não ficar com medidas antigas depois da gente reorganizar
    // o layout com flexbox. Isso dispara no documento LOCAL (onde o
    // widget do Oracle foi de fato inicializado), mesmo que a região
    // tenha ido visualmente pra página de cima.
    setTimeout(function () {
      $(root).trigger("resize");
      $(document).trigger("theme42layoutchanged");

      // HISTÓRICO: chegamos a ter aqui uma chamada a
      // "apex.region(id).refresh()" nesse ponto, numa tentativa de
      // corrigir o cabeçalho "grudento" ficando preso no meio da tela
      // (ele guarda um valor de posição vertical calculado enquanto a
      // região ainda estava no tamanho normal, e não atualiza sozinho
      // depois de virar tela cheia). Essa tentativa NÃO resolveu o
      // problema (confirmado em teste) e, pior, reconstrói a tabela
      // inteira do zero pouco depois de maximizar — o que atrapalha
      // outras coisas que dependem da estrutura interna do relatório
      // logo após maximizar (ex.: a barra de rolagem horizontal
      // flutuante). Removida por não ajudar e ainda atrapalhar.
    }, 50);
  }

  function fecharMaximizado($regiao, $botao) {
    $regiao.removeClass("nc-fake-maximized");

    var alvo = $regiao.data("ncMaximizeAlvo");
    if (alvo) {
      $(alvo.body).removeClass("nc-fake-maximize-open");
      var aoTeclar = $regiao.data("ncMaximizeEscHandler");
      if (aoTeclar) {
        alvo.doc.removeEventListener("keydown", aoTeclar);
      }
      $regiao.removeData("ncMaximizeAlvo");
      $regiao.removeData("ncMaximizeEscHandler");
    } else {
      // Plano B (não deveria acontecer): sem registro de onde foi
      // parar, limpa do jeito antigo mesmo, só no local.
      $("body").removeClass("nc-fake-maximize-open");
      $(document).off("keydown.ncFakeMaximize");
    }

    // Devolve a região pro lugar exato de origem (marcado quando
    // abriu), desfazendo o "empréstimo" que fizemos pra ela virar
    // filha direta do <body> (local ou da página de cima).
    var marcador = $regiao.data("ncOrigMarker");
    if (marcador && marcador.parentNode) {
      marcador.parentNode.insertBefore($regiao[0], marcador);
      marcador.parentNode.removeChild(marcador);
      $regiao.removeData("ncOrigMarker");
    }

    // A barra de rolagem horizontal flutuante não precisa mais voltar
    // pra lugar nenhum — ela já mora permanentemente no <body> certo
    // (ver a outra funcionalidade, mais abaixo no arquivo).

    if ($botao && $botao.length) {
      $botao
        .attr("aria-expanded", "false")
        .attr("title", "Maximizar")
        .attr("aria-label", "Maximizar");
    }
    setTimeout(function () {
      $(root).trigger("resize");
      $(document).trigger("theme42layoutchanged");
    }, 50);
  }

  $(function () {
    inserirBotoes();
  });
  // Reaplica depois que o APEX termina de montar tudo, e depois de
  // qualquer atualização de região via Ajax (pesquisa, paginação
  // etc.) — o Interactive Report costuma recriar sua toolbar inteira
  // nesses casos, o que apagaria nosso botão e o atributo de
  // controle, então precisa reinserir.
  $(document).on("apexreadyend apexafterrefresh", function () {
    inserirBotoes();
  });
  root.setTimeout(inserirBotoes, 1500);
})(window);
/* ================= FIM da simulação do botão "Maximizar" (TESTE) ================= */

/* =============================================================
   A PARTIR DAQUI: Barra de rolagem horizontal FLUTUANTE nos
   Interactive Reports (a pedido do usuário).

   Problema que resolve: com a rolagem horizontal sempre ativa (ver
   ".t-IRR-region { overflow-x: auto }" no Natcorp_Style_Min.css), a
   barra de rolagem nativa do navegador fica grudada na borda de baixo
   da região — se o relatório tem muitas linhas, é preciso descer até
   o fim da região pra conseguir rolar pros lados.

   O que faz: cria uma barra flutuante, fixada perto do rodapé da
   TELA (não da região), que aparece sempre que: (1) a região realmente
   tem conteúdo cortado na horizontal, e (2) a região está (pelo menos
   em parte) visível na tela — acompanhando o usuário conforme ele
   desce a página, sem sumir mesmo que a barra nativa (lá embaixo da
   região) já esteja alcançável. As duas ficam sincronizadas: arrastar
   uma rola a outra.
   ============================================================= */
(function (root) {
  "use strict";

  var $ = root.apex && root.apex.jQuery ? root.apex.jQuery : root.jQuery;
  if (!$) return;

  var MARCA = "data-nc-hscroll-init";
  var evitandoLoop = false;

  // Em página COM iframe, "position: fixed" só cobre a janela DO
  // IFRAME, nunca a janela real do navegador — e o iframe pode estar
  // deslocado dentro da página de cima (atrás de um cabeçalho/menu),
  // então mesmo a parte "de baixo" da janela do iframe pode cair FORA
  // da área realmente visível da tela (confirmado: barra desenhada
  // certinha, no topo da pilha, e mesmo assim invisível, porque o
  // iframe começava 48px abaixo do topo da janela real). Por isso a
  // barra sempre nasce no <body> da página de CIMA (mesma origem),
  // não no body do iframe — daí ela vale pra tela real inteira, tanto
  // maximizado quanto não. Sem acesso (cross-origin) ou sem iframe
  // nenhum, cai de volta pro body local mesmo.
  var CONTEXTO_TELA = (function () {
    try {
      if (root.self !== root.top && root.top && root.top.document && root.top.document.body) {
        return { body: root.top.document.body, win: root.top, remoto: true };
      }
    } catch (e) {
      // Iframe de origem diferente — sem acesso, sem alternativa.
    }
    return { body: document.body, win: root, remoto: false };
  })();

  // Como a barra passa a viver na página de CIMA mas a região continua
  // (fora do modo maximizado) dentro do iframe, a posição/tamanho da
  // região precisa ser traduzida das coordenadas do iframe pras
  // coordenadas da página de cima — soma o deslocamento do próprio
  // elemento <iframe> (visto de dentro, via "frameElement") à posição
  // medida dentro dele. Só vale um nível de iframe (o caso real do
  // sistema); sem "remoto", devolve a coordenada local sem alteração.
  function retanguloNaTela(el) {
    var rect = el.getBoundingClientRect();
    if (!CONTEXTO_TELA.remoto) return rect;
    // Se o elemento já não está mais no documento LOCAL (ex.: a região
    // enquanto maximizada, que outra funcionalidade deste arquivo move
    // pro <body> da página de cima), o rect dele já é relativo à tela
    // real — não soma o deslocamento do iframe de novo, senão conta
    // duas vezes.
    if (el.ownerDocument !== document) return rect;
    try {
      var rectIframe = root.frameElement && root.frameElement.getBoundingClientRect();
      if (!rectIframe) return rect;
      return {
        left: rect.left + rectIframe.left,
        right: rect.right + rectIframe.left,
        top: rect.top + rectIframe.top,
        bottom: rect.bottom + rectIframe.top,
        width: rect.width,
        height: rect.height,
      };
    } catch (e) {
      return rect;
    }
  }

  // Não basta o elemento "aparentar" ter conteúdo cortado
  // (scrollWidth > clientWidth) — isso continua acontecendo mesmo em
  // elementos com "overflow: visible" (ex.: o ".t-fht-tbody" enquanto
  // maximizado, que a gente neutraliza de propósito pro cabeçalho
  // "grudento" funcionar). Um elemento só rola de VERDADE (aceita
  // scrollLeft) se o overflow-x dele não for "visible". Checando os
  // dois, evita escolher um elemento "cego" que nunca vai responder
  // ao arrastar da barra flutuante.
  function podeRolarHorizontal(el) {
    if (!el) return false;
    // Quando o próprio elemento tem rolagem VERTICAL (barra de rolagem
    // nativa do navegador ocupando espaço horizontal), "clientWidth"
    // fica menor só por causa dessa barrinha vertical — sem sobrar
    // espaço nenhum de conteúdo de verdade rolando pro lado. Isso
    // criava uma "rolagem horizontal falsa" de uns 12-17px (exatamente
    // a largura da barra de rolagem vertical) em relatórios que nem
    // precisavam da nossa barra flutuante. "offsetWidth - clientWidth"
    // mede exatamente quanto essa barra vertical está "roubando" de
    // largura, e descontamos essa margem antes de decidir se há
    // overflow horizontal de verdade.
    var margemBarraVertical = Math.max(0, el.offsetWidth - el.clientWidth);
    if (el.scrollWidth <= el.clientWidth + margemBarraVertical + 1) return false;
    return getComputedStyle(el).overflowX !== "visible";
  }

  // Qual elemento REALMENTE rola na horizontal varia conforme o
  // estado do relatório:
  //  - No Interactive Report normal, é o ".t-fht-tbody" de dentro da
  //    região (onde o Oracle desenha a tabela de verdade — a região
  //    só cria uma segunda "moldura" por fora, redundante).
  //  - No modo "Maximizar" (nc-fake-maximize), a região passa a ter
  //    overflow próprio (pra cobrir a tela toda) e o ".t-fht-tbody"
  //    fica com "overflow: visible" (neutralizado no CSS, pro
  //    cabeçalho "grudento" funcionar) — deixa de conseguir rolar
  //    por conta própria, mesmo ainda "aparentando" ter conteúdo
  //    cortado.
  // Em vez de fixar um dos dois, checa a cada chamada qual dos dois
  // consegue rolar de verdade agora e usa esse.
  function elementoQueRola($regiao) {
    var $tbody = $regiao.find(".t-fht-tbody").first();
    var elTbody = $tbody.length ? $tbody[0] : null;
    // Relatórios sem o widget nativo do Oracle (".t-fht-tbody" nem
    // existe neles) rolam de verdade no ".a-IRR-tableContainer" — ele
    // mantém o overflow-x nativo dele mesmo no modo normal (só é
    // neutralizado enquanto maximizado, ver o CSS). Confirmado num
    // relatório real: 21087px de conteúdo contra 1391px visíveis.
    var $tableContainer = $regiao.find(".a-IRR-tableContainer").first();
    var elTableContainer = $tableContainer.length ? $tableContainer[0] : null;
    var elRegiao = $regiao[0];

    if (podeRolarHorizontal(elTbody)) return $tbody;
    if (podeRolarHorizontal(elTableContainer)) return $tableContainer;
    if (podeRolarHorizontal(elRegiao)) return $regiao;

    // Nenhum dos três rola de verdade agora — devolve o de sempre
    // (t-fht-tbody, com plano B pro tableContainer e depois pra
    // região) só pra manter uma referência válida; a barra fica
    // escondida de qualquer jeito (sem overflow real, sem por que
    // aparecer).
    if (elTbody) return $tbody;
    if (elTableContainer) return $tableContainer;
    return $regiao;
  }

  function criarBarraFlutuante($regiao) {
    var $barra = $(
      '<div class="nc-hscroll-float" role="presentation">' +
      '<div class="nc-hscroll-float__spacer"></div>' +
      "</div>"
    );
    CONTEXTO_TELA.body.appendChild($barra[0]);
    $regiao.data("ncHscrollBar", $barra);

    // A barra flutuante ouve a SI MESMA de forma fixa (isso nunca
    // muda). Quem muda é o "alvo" (o elemento que rola de verdade) —
    // isso é tratado à parte em garantirAlvoAtual(), porque o Oracle
    // recria esse elemento dinamicamente e o listener precisa ser
    // reatado no elemento novo quando isso acontece.
    $barra.on("scroll.ncHscroll", function () {
      if (evitandoLoop) return;
      var $alvo = $regiao.data("ncHscrollAlvo");
      if (!$alvo || !$alvo.length) return;
      evitandoLoop = true;
      $alvo[0].scrollLeft = this.scrollLeft;
      evitandoLoop = false;
    });

    return $barra;
  }

  // O Oracle recria o ".t-fht-tbody" (e possivelmente outros trechos
  // do DOM da região) de forma assíncrona depois da carga inicial —
  // então o elemento guardado em cache no início pode deixar de ser o
  // mesmo que está de fato na tela (fica "órfão", sem rolagem real
  // nenhuma, e por isso a barra flutuante parece travada/escondida).
  // Aqui a gente reconsulta o elemento atual a cada atualização e,
  // se ele mudou, tira o listener do antigo e recoloca no novo.
  function garantirAlvoAtual($regiao, $barra) {
    var $alvoAtual = elementoQueRola($regiao);
    var elAtual = $alvoAtual[0];
    var elGuardado = $regiao.data("ncHscrollAlvoEl");

    if (elAtual !== elGuardado) {
      var $alvoAntigo = $regiao.data("ncHscrollAlvo");
      if ($alvoAntigo && $alvoAntigo.length) {
        $alvoAntigo.off("scroll.ncHscroll");
      }

      $alvoAtual.on("scroll.ncHscroll", function () {
        if (evitandoLoop) return;
        evitandoLoop = true;
        $barra.scrollLeft(this.scrollLeft);
        evitandoLoop = false;
      });

      $regiao.data("ncHscrollAlvo", $alvoAtual);
      $regiao.data("ncHscrollAlvoEl", elAtual);
    }

    return $alvoAtual;
  }

  // Mede a largura real de conteúdo (scrollWidth) do elemento que
  // rola de verdade e replica no "espaçador" de dentro da barra
  // flutuante — é esse espaçador que dá à barra flutuante a MESMA
  // proporção de rolagem horizontal que o elemento de verdade tem.
  function atualizarLargura($alvo, $barra) {
    var el = $alvo[0];
    $barra.find(".nc-hscroll-float__spacer").width(el.scrollWidth);
    if (Math.abs($barra[0].scrollLeft - el.scrollLeft) > 1) {
      evitandoLoop = true;
      $barra[0].scrollLeft = el.scrollLeft;
      evitandoLoop = false;
    }
  }

  // Decide se a barra flutuante deve aparecer: só precisa ter
  // conteúdo cortado na horizontal (medido no elemento que rola de
  // verdade) e a REGIÃO (a moldura visível inteira) estar pelo menos
  // em parte visível na tela — a pedido, fica sempre visível nesse
  // caso, acompanhando o usuário conforme ele desce, independente de
  // a barra nativa (lá embaixo da região) já estar alcançável ou não.
  // Enquanto maximizada (ver a outra funcionalidade, "Maximizar", mais
  // acima no arquivo), a região — e a barra flutuante junto com ela —
  // pode ter sido movida pra o <body> da página DE CIMA (escapando do
  // iframe, quando possível, senão o "position: fixed" fica preso na
  // caixinha do iframe). Nesse caso, a "janela" certa pra medir
  // largura/altura de tela não é mais a "root" (janela do iframe) que
  // esse arquivo roda por padrão — é a janela de onde o elemento está
  // sendo desenhado DE VERDADE agora. Descobre isso pelo documento
  // dono do próprio elemento, que já reflete onde ele está no momento.
  function atualizarVisibilidade($regiao, $alvo, $barra) {
    var elAlvo = $alvo[0];
    var temOverflow = elAlvo.scrollWidth > elAlvo.clientWidth + 1;
    if (!temOverflow) {
      $barra.removeClass("is-visible");
      // Se o elemento tinha sido rolado pro lado antes (ex.: modal que
      // reduziu o número de colunas exibidas, ou conteúdo que mudou de
      // tamanho) e agora não precisa mais de rolagem nenhuma, mas
      // ainda está com "scrollLeft" diferente de zero, o conteúdo fica
      // "preso" deslocado pro lado — pra fora da área visível da
      // região/modal, mesmo sem overflow nenhum de verdade. Reseta a
      // posição de rolagem nesse caso, senão o deslocamento antigo
      // continua empurrando o conteúdo (confirmado num relatório
      // dentro de modal: ficou com scrollLeft:55 depois que o
      // conteúdo passou a caber, "vazando" a tabela pra fora da borda
      // da modal pela esquerda).
      if (elAlvo.scrollLeft !== 0) {
        elAlvo.scrollLeft = 0;
      }
      return;
    }

    var elRegiao = $regiao[0];
    // Usa o retângulo já traduzido pra coordenada da tela real (soma o
    // deslocamento do iframe, se for o caso — ver retanguloNaTela) e a
    // janela onde a barra realmente vive (CONTEXTO_TELA), não a do
    // elemento em si (que pode estar dentro do iframe).
    var rect = retanguloNaTela(elRegiao);
    var alturaJanela = CONTEXTO_TELA.win.innerHeight || document.documentElement.clientHeight;
    var larguraJanela = CONTEXTO_TELA.win.innerWidth || document.documentElement.clientWidth;

    var regiaoVisivel = rect.bottom > 0 && rect.top < alturaJanela && rect.right > 0 && rect.left < larguraJanela;

    if (!regiaoVisivel) {
      $barra.removeClass("is-visible");
      return;
    }

    // A barra flutuante só existe pra "substituir" a barra de rolagem
    // nativa do elemento enquanto ela está fora da tela (rolada pra
    // baixo, fora da área visível). Se o próprio rodapé do elemento
    // que rola (onde o navegador desenha a barra de rolagem nativa
    // dele) já está visível na janela, mostrar as duas juntas é
    // redundante — e como as duas ficam bem perto uma da outra nesse
    // momento, dá a impressão de "colarem" e virarem uma só. Nesse
    // caso escondemos a flutuante e deixamos só a nativa.
    var rectAlvo = retanguloNaTela(elAlvo);
    var alvoTemRodapeVisivel = rectAlvo.bottom > 0 && rectAlvo.bottom <= alturaJanela;
    if (alvoTemRodapeVisivel) {
      $barra.removeClass("is-visible");
      return;
    }

    var esquerda = Math.max(rect.left, 0);
    var direita = Math.min(rect.right, larguraJanela);
    $barra.css({
      left: esquerda + "px",
      width: Math.max(0, direita - esquerda) + "px",
    });
    $barra.addClass("is-visible");
  }

  // A barra flutuante foi pensada pra Interactive Report ocupando a
  // LARGURA TOTAL da página (span 12) — quando a região divide a
  // linha com outra ao lado (ex.: span 6, duas colunas lado a lado),
  // a barra flutuante quebra: ela é desenhada ocupando a largura da
  // TELA inteira (não só a da região, mais estreita), e não sincroniza
  // certo com a rolagem nativa dessa região menor. Nesses casos, só a
  // rolagem NATIVA do Oracle deve funcionar — a gente nem cria a barra
  // flutuante. Detecta comparando a largura da região com a da linha
  // (".row") que ela pertence: se a região não ocupa quase toda a
  // largura da linha, não é "span 12".
  function ocupaLarguraTotal($regiao) {
    var $row = $regiao.closest(".row");
    if (!$row.length || !$row[0]) return true;
    var larguraRegiao = $regiao[0].getBoundingClientRect().width;
    var larguraRow = $row[0].getBoundingClientRect().width;
    if (!larguraRow) return true;
    return larguraRegiao >= larguraRow * 0.95;
  }

  function inicializarRegiao($regiao) {
    if ($regiao.attr(MARCA)) return;
    // Não marca como processada de propósito — assim, se o layout
    // mudar depois (ex.: responsivo, célula ao lado sumir), a próxima
    // varredura tenta de novo e pode criar a barra nesse momento.
    if (!ocupaLarguraTotal($regiao)) return;
    $regiao.attr(MARCA, "1");
    var $barra = criarBarraFlutuante($regiao);
    var $alvo = garantirAlvoAtual($regiao, $barra);
    atualizarLargura($alvo, $barra);
    atualizarVisibilidade($regiao, $alvo, $barra);
  }

  // Normalmente a região marcada está no documento LOCAL (dentro do
  // iframe). Mas enquanto maximizada (ver "Maximizar" mais acima no
  // arquivo), ela é movida pro documento da página DE CIMA — se só
  // procurar no documento local, ela "some" da busca assim que
  // maximiza, e a barra para de atualizar. Por isso procura nos dois
  // documentos (quando "remoto") e junta o resultado.
  function regioesMarcadas() {
    var $resultado = $(".t-IRR-region[" + MARCA + "]", document);
    if (CONTEXTO_TELA.remoto) {
      try {
        var $doTopo = $(".t-IRR-region[" + MARCA + "]", CONTEXTO_TELA.win.document);
        $resultado = $resultado.add($doTopo);
      } catch (e) {
        // Sem acesso — segue só com o resultado local mesmo.
      }
    }
    return $resultado;
  }

  function atualizarTudo() {
    regioesMarcadas().each(function () {
      var $regiao = $(this);
      var $barra = $regiao.data("ncHscrollBar");
      if (!$barra || !$barra.length) return;
      var $alvo = garantirAlvoAtual($regiao, $barra);
      if (!$alvo || !$alvo.length || !$alvo[0].isConnected) return;
      atualizarLargura($alvo, $barra);
      atualizarVisibilidade($regiao, $alvo, $barra);
    });
  }

  function escanearRegioes() {
    $(".t-IRR-region").each(function () {
      inicializarRegiao($(this));
    });
    atualizarTudo();
  }

  var debounce = null;
  function atualizarComDebounce() {
    root.clearTimeout(debounce);
    debounce = root.setTimeout(atualizarTudo, 16);
  }

  // "scroll" com capture:true no document pega TAMBÉM a rolagem de
  // qualquer elemento aninhado (não só a janela) — importante pro
  // caso da região maximizada, que rola dentro dela mesma, não a
  // página inteira.
  document.addEventListener("scroll", atualizarComDebounce, true);
  $(root).on("resize", atualizarComDebounce);

  // Quando a região maximizada escapa do iframe (ver "Maximizar" mais
  // acima no arquivo) e passa a viver no <body> da página DE CIMA, a
  // rolagem/redimensionamento que acontece lá não passa pelo
  // "document" local (são documentos diferentes) — sem isso, a barra
  // só se atualizaria de 1 em 1 segundo (a rede de segurança do
  // "setInterval" mais abaixo), em vez de na hora. Só tenta quando dá
  // (mesma origem); em página sem iframe ou de origem diferente, não
  // faz nada extra (já está coberto pelos listeners locais acima).
  try {
    if (root.self !== root.top && root.top && root.top.document) {
      root.top.document.addEventListener("scroll", atualizarComDebounce, true);
      root.top.addEventListener("resize", atualizarComDebounce);
    }
  } catch (e) {
    // Iframe de origem diferente — sem acesso, segue só com os
    // listeners locais mesmo.
  }
  $(document).on("apexreadyend apexafterrefresh theme42layoutchanged", escanearRegioes);
  $(function () {
    escanearRegioes();
  });
  root.setTimeout(escanearRegioes, 1000);
  // Rede de segurança: recalcula periodicamente, pra pegar qualquer
  // mudança de largura que nenhum dos eventos acima tenha avisado
  // (ex.: coluna redimensionada manualmente pelo usuário).
  root.setInterval(atualizarTudo, 1000);
})(window);
/* ================= FIM da barra de rolagem horizontal flutuante ================= */

/* =============================================================
   A PARTIR DAQUI: Cabeçalho "grudento" via JavaScript, para
   Interactive Reports que NÃO têm o widget nativo do Oracle
   (".js-stickyTableHeader") habilitado, no modo NORMAL (não
   maximizado).

   Por que existe: o modo maximizado já resolve isso com
   "position: sticky" puro no CSS (funciona bem lá, porque a região
   maximizada tem rolagem vertical DE VERDADE). No modo normal, quem
   rola é a PÁGINA inteira, não a região — e "position: sticky" só
   funciona se nenhum ancestral entre o cabeçalho e a página tiver
   "overflow" diferente de "visible". A própria região PRECISA manter
   "overflow-x: auto" (funcionalidade da barra sempre visível), e isso
   sozinho já quebra o sticky nesse cenário (confirmado testando).  Sem
   solução só de CSS.

   O que faz: pros relatórios SEM o widget nativo do Oracle (que já
   resolve isso sozinho, com um mecanismo parecido, nos relatórios que
   O TÊM), cria um CLONE só da linha de cabeçalho (mantendo a largura
   de cada coluna sincronizada com a tabela de verdade) e, quando a
   região está parcialmente visível mas o topo dela já passou por
   baixo do cabeçalho fixo da aplicação, mostra esse clone fixo na
   tela — dando a mesma sensação de "cabeçalho grudento", sem depender
   de "position: sticky".
   ============================================================= */
(function (root) {
  "use strict";

  var $ = root.apex && root.apex.jQuery ? root.apex.jQuery : root.jQuery;
  if (!$) return;

  var MARCA = "data-nc-sticky-init";
  // Altura do cabeçalho FIXO da aplicação (".t-Header") — confirmado
  // em teste: 48px, "z-index: 800". O clone gruda logo abaixo dele.
  var ALTURA_CABECALHO_APP = 48;

  // Mesmo mecanismo de escapar do iframe usado nas outras duas
  // funcionalidades deste arquivo (Maximizar e barra flutuante) — o
  // "position: fixed" do clone só cobre a tela real se ele morar no
  // <body> da página de CIMA (quando dá, mesma origem).
  var CONTEXTO_TELA = (function () {
    try {
      if (root.self !== root.top && root.top && root.top.document && root.top.document.body) {
        return { body: root.top.document.body, win: root.top, remoto: true };
      }
    } catch (e) {
      // Iframe de origem diferente — sem acesso, sem alternativa.
    }
    return { body: document.body, win: root, remoto: false };
  })();

  function retanguloNaTela(el) {
    var rect = el.getBoundingClientRect();
    if (!CONTEXTO_TELA.remoto) return rect;
    if (el.ownerDocument !== document) return rect;
    try {
      var rectIframe = root.frameElement && root.frameElement.getBoundingClientRect();
      if (!rectIframe) return rect;
      return {
        left: rect.left + rectIframe.left,
        right: rect.right + rectIframe.left,
        top: rect.top + rectIframe.top,
        bottom: rect.bottom + rectIframe.top,
        width: rect.width,
        height: rect.height,
      };
    } catch (e) {
      return rect;
    }
  }

  // Só entra em ação em relatórios SEM o widget nativo — os que já
  // têm continuam com o mecanismo deles, sem a gente interferir. E
  // nunca enquanto maximizado — nem no nosso maximizar "fake"
  // ("nc-fake-maximized") nem no maximizar NATIVO do Oracle
  // ("is-maximized", usado nos relatórios que já têm o botão nativo de
  // maximizar) — porque nos dois casos quem cuida do cabeçalho lá é o
  // CSS "position: sticky".
  // Com "Quebra de Controle" (Control Break) ativada no Interactive
  // Report, o Oracle insere uma linha de "rótulo do grupo" ANTES de
  // cada cabeçalho repetido — ela também começa com um "<th>", mas é
  // uma coisa diferente do cabeçalho de verdade: tem UM "th" só (com
  // "colspan" cobrindo a linha toda) e classe "a-IRR-header--group",
  // enquanto o cabeçalho de verdade tem um "th.a-IRR-header" (sem
  // "--group") PRA CADA coluna. Sem diferenciar isso, a gente pegava
  // sempre a primeira linha da tabela — que nesse modo podia ser esse
  // rótulo de grupo em vez do cabeçalho — e o cabeçalho flutuante
  // mostrava o texto errado (ou nem aparecia). Acha a linha certa
  // procurando por essa marca específica.
  // Linha "EXTRA" no topo do cabeçalho — existe em dois casos:
  // 1) Quebra de controle: linha do RÓTULO do grupo (ex.: "Empresa
  //    (Solicitante): Dpc"), com "th.a-IRR-header--group".
  // 2) Relatório Pivot: linha com os VALORES pivotados como coluna
  //    (ex.: nome de cada analista), com "th.a-IRR-header--pivotColumn".
  // Nos dois casos, essa linha vem ANTES da linha de cabeçalho de
  // colunas "de verdade" — sem ela (relatório comum, sem quebra de
  // controle nem Pivot), não existe linha extra nenhuma.
  function linhaExtraNoTopo($table) {
    return $table
      .find("> tbody > tr")
      .filter(function () {
        return (
          $(this).find("> th.a-IRR-header--group").length > 0 ||
          $(this).find("> th.a-IRR-header--pivotColumn").length > 0
        );
      })
      .first();
  }

  function linhaCabecalhoReal($table) {
    var $linhas = $table.find("> tbody > tr");
    var $extra = linhaExtraNoTopo($table);
    // Sem linha extra (nem quebra de controle, nem Pivot): a 1ª linha
    // da tabela já É o cabeçalho de colunas de verdade, exatamente
    // como funcionava antes, sem mexer em nada.
    if (!$extra.length) {
      return $linhas.first();
    }
    // Com linha extra: o cabeçalho de colunas de verdade é sempre a
    // linha logo ABAIXO dela.
    return $extra.next();
  }

  // Linha do RÓTULO do grupo da quebra de controle (ex.: "Empresa
  // (Solicitante): Dpc") — a que tem "th.a-IRR-header--group". Só
  // existe quando a quebra de controle está ativa. (Diferente da
  // linha "extra" de um Pivot, essa se repete — uma pra cada grupo —
  // por isso precisa ser reavaliada a cada rolagem; ver
  // "atualizarGrupoNoClone".)
  function linhaGrupoAtual($table) {
    return $table
      .find("> tbody > tr")
      .filter(function () {
        return $(this).find("> th.a-IRR-header--group").length > 0;
      })
      .first();
  }

  // Linhas que devem ficar no cabeçalho flutuante: só o cabeçalho de
  // colunas quando não tem linha extra (como sempre foi); com quebra
  // de controle OU Pivot, a linha extra TAMBÉM entra, empilhada logo
  // acima do cabeçalho de colunas — a pedido, pra sempre dar pra ver
  // em qual grupo/coluna pivotada você está enquanto rola a tela
  // (mesmo comportamento que já existe no modo maximizado, via CSS).
  function linhasCabecalhoClone($table) {
    var $header = linhaCabecalhoReal($table);
    var $extra = linhaExtraNoTopo($table);
    if ($extra.length && (!$header.length || $extra[0] !== $header[0])) {
      return $extra.add($header);
    }
    return $header;
  }

  function elegivel($regiao) {
    if ($regiao.hasClass("nc-fake-maximized")) return false;
    if ($regiao.hasClass("is-maximized")) return false;
    if ($regiao.find(".js-stickyTableHeader").length) return false;
    var $table = $regiao.find(".a-IRR-table").first();
    if (!$table.length) return false;
    var $header = linhaCabecalhoReal($table);
    return $header.length > 0;
  }

  function criarClone($regiao) {
    var $table = $regiao.find(".a-IRR-table").first();
    var $headerReal = linhaCabecalhoReal($table);

    // Clona a tabela inteira (sem os manipuladores de evento — o
    // clone é só visual, não interativo) e descarta todas as linhas
    // menos as do cabeçalho flutuante (cabeçalho de colunas sozinho,
    // ou rótulo do grupo + cabeçalho de colunas quando tem quebra de
    // controle — ver "linhasCabecalhoClone"). Clonar a tabela real
    // (não só a(s) linha(s)) garante que o clone herda a mesma
    // estrutura/CSS de colunas.
    var $tableClone = $table.clone(false);
    var $linhasClone = linhasCabecalhoClone($tableClone);
    $tableClone.find("> tbody > tr").not($linhasClone).remove();
    // Remove ids duplicados (evita dois elementos com o mesmo "id" na
    // página, o que quebra seletores por id em outros lugares).
    $tableClone.removeAttr("id");
    $tableClone.find("[id]").removeAttr("id");

    var $wrapper = $('<div class="nc-sticky-header-clone" aria-hidden="true"></div>');
    var $inner = $('<div class="nc-sticky-header-clone__inner"></div>');
    $inner.append($tableClone);
    $wrapper.append($inner);
    CONTEXTO_TELA.body.appendChild($wrapper[0]);
    $wrapper.css("visibility", "hidden");

    $regiao.data("ncStickyClone", $wrapper);
    $regiao.data("ncStickyCloneInner", $inner);
    $regiao.data("ncStickyCloneTable", $tableClone);
    $regiao.data("ncStickyHeaderReal", $headerReal);
    $regiao.data("ncStickyTableReal", $table);
    // Guarda o "th" do rótulo de grupo DENTRO DO CLONE (se existir) —
    // é nele que a gente vai trocar o texto conforme o usuário rola
    // por cima de grupos diferentes (ver "atualizarGrupoNoClone").
    var $grupoClone = $tableClone.find("> tbody > tr > th.a-IRR-header--group").first();
    $regiao.data("ncStickyCloneGrupoTh", $grupoClone.length ? $grupoClone : null);
  }

  // Quando tem quebra de controle, o relatório repete um rótulo de
  // grupo diferente (ex.: "Empresa: Dpc", "Empresa: Outra") pra cada
  // grupo de linhas. O clone é criado UMA vez com o rótulo do
  // primeiro grupo — sem isso, ele ficaria sempre mostrando o mesmo
  // rótulo, mesmo depois do usuário já ter rolado pra outros grupos.
  // Aqui a gente troca o texto do rótulo no clone pelo do grupo que
  // estiver "por cima" no momento (o último rótulo, de cima pra
  // baixo, que já passou do ponto onde o cabeçalho flutuante gruda),
  // igual uma lista com cabeçalho de seção (agenda de contatos por
  // letra, por exemplo).
  function atualizarGrupoNoClone($regiao) {
    var $grupoClone = $regiao.data("ncStickyCloneGrupoTh");
    if (!$grupoClone || !$grupoClone.length) return;
    var $table = $regiao.data("ncStickyTableReal");
    if (!$table || !$table.length) return;
    var $gruposReais = $table.find("> tbody > tr > th.a-IRR-header--group");
    if (!$gruposReais.length) return;

    var $ativo = $gruposReais[0];
    $gruposReais.each(function () {
      var top = retanguloNaTela(this).top;
      if (top <= ALTURA_CABECALHO_APP + 1) {
        $ativo = this;
      }
    });

    if ($grupoClone[0].innerHTML !== $ativo.innerHTML) {
      $grupoClone[0].innerHTML = $ativo.innerHTML;
    }
  }

  // As colunas do clone precisam ter EXATAMENTE a mesma largura das
  // colunas de verdade (a tabela sozinha, sem as outras linhas de
  // dados, calcularia larguras diferentes pelo algoritmo automático de
  // tabela do navegador).
  function sincronizarLargurasColunas($regiao) {
    var $headerReal = $regiao.data("ncStickyHeaderReal");
    var $tableClone = $regiao.data("ncStickyCloneTable");
    if (!$headerReal || !$headerReal.length || !$tableClone || !$tableClone.length) return;
    var thsReais = $headerReal.children().toArray();
    // Busca especificamente a linha de COLUNAS dentro do clone (não
    // ".first()" — com quebra de controle, a primeira linha do clone
    // agora pode ser o rótulo do grupo, que tem só 1 "th" com
    // colspan, e não bate com as colunas reais).
    var linhaClone = linhaCabecalhoReal($tableClone);
    var thsClone = linhaClone.length ? linhaClone.children().toArray() : [];
    for (var i = 0; i < thsReais.length && i < thsClone.length; i++) {
      var largura = thsReais[i].getBoundingClientRect().width;
      thsClone[i].style.width = largura + "px";
      thsClone[i].style.minWidth = largura + "px";
      thsClone[i].style.maxWidth = largura + "px";
    }
  }

  // Reaproveita a detecção já feita pela barra de rolagem horizontal
  // flutuante (outra funcionalidade deste arquivo) de qual elemento
  // realmente rola na horizontal — os dois guardam/leem dados no
  // mesmo objeto jQuery da região, então um enxerga o que o outro já
  // calculou.
  function scrollLeftAtual($regiao) {
    var $alvo = $regiao.data("ncHscrollAlvo");
    if ($alvo && $alvo.length) return $alvo[0].scrollLeft || 0;
    return $regiao[0].scrollLeft || 0;
  }

  function atualizarPosicao($regiao) {
    var $wrapper = $regiao.data("ncStickyClone");
    var $inner = $regiao.data("ncStickyCloneInner");
    var $headerReal = $regiao.data("ncStickyHeaderReal");
    var $tableClone = $regiao.data("ncStickyCloneTable");
    if (!$wrapper || !$wrapper.length || !$headerReal || !$headerReal.length) return;

    // Enquanto maximizada (fake ou nativa do Oracle), quem cuida do
    // cabeçalho é o CSS "position: sticky" — nosso clone fica
    // escondido.
    if ($regiao.hasClass("nc-fake-maximized") || $regiao.hasClass("is-maximized")) {
      $wrapper.css("visibility", "hidden");
      return;
    }

    // Antes de medir/posicionar, garante que o rótulo do grupo (se
    // tiver) está mostrando o grupo certo pra rolagem atual.
    atualizarGrupoNoClone($regiao);

    var rectRegiao = retanguloNaTela($regiao[0]);
    // Altura do cabeçalho flutuante: usa a altura do CLONE inteiro (não
    // só da linha de colunas), porque com quebra de controle o clone
    // agora pode ter 2 linhas empilhadas (rótulo do grupo + colunas) —
    // assim o cálculo já cobre as duas automaticamente, sem precisar
    // somar cada uma na mão.
    var alturaHeader =
      $tableClone && $tableClone.length
        ? $tableClone[0].getBoundingClientRect().height
        : $headerReal[0].getBoundingClientRect().height;

    // O "gatilho" de quando começar a grudar usa a posição do
    // CABEÇALHO DE VERDADE, não do topo da região inteira — com
    // filtro aplicado, o Oracle mostra um painel de "Configurações do
    // Relatório"/lista de filtros ACIMA da tabela, dentro da mesma
    // região. Usando o topo da região, o cabeçalho flutuante nascia
    // cedo demais (assim que o painel de filtros passava da marca),
    // enquanto o cabeçalho de colunas de verdade ainda estava visível
    // mais embaixo — os dois apareciam ao mesmo tempo, parecendo
    // duplicado. Com o topo do cabeçalho de verdade, só gruda no
    // exato momento em que ELE (não o resto da região) passaria da
    // marca. Continua usando o rodapé da REGIÃO pra saber quando
    // esconder — senão o cabeçalho ficaria "flutuando sozinho" depois
    // que o relatório inteiro já rolou pra fora da tela (mesma lógica
    // do widget nativo do Oracle).
    var rectHeaderReal = retanguloNaTela($headerReal[0]);
    var deveGrudar =
      rectHeaderReal.top < ALTURA_CABECALHO_APP && rectRegiao.bottom > ALTURA_CABECALHO_APP + alturaHeader;

    if (!deveGrudar) {
      $wrapper.css("visibility", "hidden");
      return;
    }

    $wrapper.css({
      visibility: "visible",
      top: ALTURA_CABECALHO_APP + "px",
      left: Math.max(rectRegiao.left, 0) + "px",
      width: rectRegiao.width + "px",
      height: alturaHeader + "px",
    });

    // Desloca o conteúdo interno do clone pra acompanhar a rolagem
    // horizontal de verdade (a mesma quantidade de pixels que a
    // tabela real rolou pros lados).
    $inner.css("transform", "translateX(" + -scrollLeftAtual($regiao) + "px)");
  }

  function inicializarRegiao($regiao) {
    if ($regiao.attr(MARCA)) return;
    if (!elegivel($regiao)) return;
    $regiao.attr(MARCA, "1");
    criarClone($regiao);
    sincronizarLargurasColunas($regiao);
    atualizarPosicao($regiao);
  }

  // Cabeçalhos flutuantes "órfãos": quando o Oracle recria a REGIÃO
  // INTEIRA (não só o conteúdo de dentro dela — ex.: o botãozinho de
  // "Atualizar" da própria toolbar do Interactive Report, ou qualquer
  // outro refresh via AJAX que troque o elemento da região), o
  // elemento antigo (que tinha nossa marca e o cabeçalho flutuante
  // dele grudado) some da busca abaixo, porque ela só olha pra
  // regiões que EXISTEM na página agora — o elemento antigo fica
  // "pendurado" fora do documento. O cabeçalho flutuante dele, que
  // vive separado (grudado direto no body da tela, não dentro da
  // região), fica pra trás sem ninguém mais responsável por
  // escondê-lo: se estava visível no momento da troca, trava visível
  // na tela pra sempre, mesmo rolando a página pra longe da região.
  // Aqui a gente lista os cabeçalhos flutuantes que ainda têm uma
  // região viva dona deles e remove do body qualquer um que sobrar
  // sem dono.
  function limparCabecalhosFlutuantesOrfaos() {
    var vivos = [];
    $(".t-IRR-region[" + MARCA + "]").each(function () {
      var $wrapper = $(this).data("ncStickyClone");
      if ($wrapper && $wrapper.length) vivos.push($wrapper[0]);
    });
    var todos = CONTEXTO_TELA.body.querySelectorAll(".nc-sticky-header-clone");
    Array.prototype.forEach.call(todos, function (elemento) {
      if (vivos.indexOf(elemento) === -1 && elemento.parentNode) {
        elemento.parentNode.removeChild(elemento);
      }
    });
  }

  function atualizarTudo() {
    limparCabecalhosFlutuantesOrfaos();
    $(".t-IRR-region[" + MARCA + "]").each(function () {
      var $regiao = $(this);
      var $headerReal = $regiao.data("ncStickyHeaderReal");

      // O Oracle recria a tabela de forma assíncrona (mesmo motivo já
      // visto nas outras funcionalidades) — se o cabeçalho real que a
      // gente guardou não existe mais no documento, o clone ficou
      // desatualizado: descarta e recria do zero.
      if (!$headerReal || !$headerReal.length || !$headerReal[0].isConnected) {
        var $wrapperAntigo = $regiao.data("ncStickyClone");
        if ($wrapperAntigo && $wrapperAntigo.length) {
          $wrapperAntigo.remove();
        }
        $regiao.removeAttr(MARCA);
        inicializarRegiao($regiao);
        return;
      }

      sincronizarLargurasColunas($regiao);
      atualizarPosicao($regiao);
    });
    sincronizarAlturaGrupoMaximizado();
  }

  // Relatório MAXIMIZADO (fake ou nativo do Oracle) com "Quebra de
  // Controle" ativa OU relatório Pivot: o CSS (Natcorp_Style_Min.css)
  // deixa a linha "extra" do topo (rótulo do grupo, ex.: "Empresa
  // (Solicitante): Dpc" — ou, no Pivot, a linha com os valores
  // pivotados) grudada no topo, e o cabeçalho de colunas de verdade
  // grudado logo ABAIXO dela — pra isso, o cabeçalho de colunas
  // precisa saber a altura exata dessa linha extra (varia conforme o
  // texto/tamanho da tela, podendo até quebrar linha). Mede essa
  // altura aqui e guarda numa variável CSS
  // ("--nc-group-header-height") na própria tabela, que o CSS já está
  // pronto pra usar como posição do "top" do cabeçalho de colunas.
  // Na quebra de controle, TODAS as linhas de grupo ficam grudentas
  // (o CSS deixa o navegador trocar sozinho qual delas está "colada"
  // conforme a rolagem — ver Natcorp_Style_Min.css), então usa a
  // altura da linha que estiver REALMENTE colada no momento (não
  // sempre a 1ª), porque cada grupo pode ter um texto de tamanho
  // diferente. No Pivot só existe uma linha extra pra tabela inteira
  // (não se repete por grupo), então a lógica abaixo já lida com isso
  // naturalmente (só vai ter uma opção pra escolher).
  function sincronizarAlturaGrupoMaximizado() {
    $(".t-IRR-region.is-maximized .a-IRR-table, .t-IRR-region.nc-fake-maximized .a-IRR-table").each(
      function () {
        var $table = $(this);
        // Uma linha (tr) por vez, não um "th" por vez — no Pivot uma
        // única linha pode ter dezenas de "th.a-IRR-header--pivotColumn"
        // (um por coluna pivotada), e todos têm o mesmo "top" por
        // estarem na mesma linha.
        var $linhasGrupo = $table.find("> tbody > tr").filter(function () {
          return (
            $(this).find("> th.a-IRR-header--group").length > 0 ||
            $(this).find("> th.a-IRR-header--pivotColumn").length > 0
          );
        });
        if (!$linhasGrupo.length) {
          $table[0].style.removeProperty("--nc-group-header-height");
          return;
        }
        var $regiao = $table.closest(".t-IRR-region");
        var topoRegiao = $regiao.length ? $regiao[0].getBoundingClientRect().top : 0;
        // A linha "colada" no momento é a que está mais perto do topo
        // da região por baixo (ou bem próxima dele) — as que ainda não
        // chegaram lá têm "top" bem maior; as que já foram empurradas
        // pra fora pela próxima ficam com "top" menor (escondidas). No
        // Pivot só existe 1 linha extra pra tabela inteira, então essa
        // busca já resolve sozinha (só tem 1 opção).
        var $ativa = $linhasGrupo.first();
        var melhorTop = -Infinity;
        $linhasGrupo.each(function () {
          var top = this.getBoundingClientRect().top;
          if (top <= topoRegiao + 1 && top > melhorTop) {
            melhorTop = top;
            $ativa = $(this);
          }
        });
        var altura = $ativa[0].getBoundingClientRect().height;
        if (altura > 0) {
          $table[0].style.setProperty("--nc-group-header-height", altura + "px");
        }
      }
    );
  }

  function escanearRegioes() {
    $(".t-IRR-region").each(function () {
      inicializarRegiao($(this));
    });
    atualizarTudo();
  }

  var debounce = null;
  function atualizarComDebounce() {
    root.clearTimeout(debounce);
    debounce = root.setTimeout(atualizarTudo, 16);
  }

  document.addEventListener("scroll", atualizarComDebounce, true);
  $(root).on("resize", atualizarComDebounce);
  try {
    if (root.self !== root.top && root.top && root.top.document) {
      root.top.document.addEventListener("scroll", atualizarComDebounce, true);
      root.top.addEventListener("resize", atualizarComDebounce);
    }
  } catch (e) {
    // Iframe de origem diferente — sem acesso, segue só com os
    // listeners locais mesmo.
  }
  $(document).on("apexreadyend apexafterrefresh theme42layoutchanged", escanearRegioes);
  $(function () {
    escanearRegioes();
  });
  root.setTimeout(escanearRegioes, 1000);
  // Rede de segurança: recalcula periodicamente, pra pegar qualquer
  // mudança de largura/dados que nenhum dos eventos acima tenha
  // avisado.
  root.setInterval(atualizarTudo, 1000);
})(window);
/* ================= FIM do cabeçalho grudento via JavaScript ================= */
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
/* =============================================================
   Radio Group (estilo toggle/pílula, ex.: Sim/Não) sem Default
   configurado no Apex — seleciona de verdade a primeira opção

   Problema: quando o item Radio Group não tem "Default" definido no
   Apex, a tela abre com o campo realmente vazio/nulo. O nosso CSS já
   mostra a primeira opção com o fundo roxo e uma bolinha branca, só
   de aparência, pra indicar "isso aqui é um padrão, não é uma escolha
   real do usuário" — mas o valor do campo continua vazio de verdade,
   o que confunde o usuário (parece selecionado, mas não está).

   Solução: ao carregar a página, e sempre que conteúdo novo aparecer
   (modal aberta, região atualizada via AJAX), se o Radio Group não
   tiver nenhuma opção realmente marcada, marca de verdade a primeira
   opção (input.checked = true) — sem disparar o evento "change", do
   mesmo jeito que um valor Default nativo do Apex se comporta (o
   campo já nasce com valor, mas não dispara Dynamic Action de "on
   change" só por causa do default).

   Escopo: exatamente o mesmo tipo de Radio Group que já recebe o
   destaque roxo/bolinha falsos no CSS (.apex-item-group--rc
   .apex-item-radio / .apex-item-grid-row) — não mexe em nenhum outro
   tipo de campo.
   ============================================================= */
(function (root) {
  "use strict";

  var $ = root.apex && root.apex.jQuery ? root.apex.jQuery : root.jQuery;
  if (!$) return;

  var SELETOR_GRUPO = ".apex-item-group--rc.apex-item-radio, .apex-item-grid-row";

  function selecionarPrimeiraOpcaoSemDefault($escopo) {
    var $base = $escopo && $escopo.length ? $escopo : $(document);
    var $grupos = $base.find(SELETOR_GRUPO);
    if ($base.is(SELETOR_GRUPO)) {
      $grupos = $grupos.add($base);
    }
    $grupos.each(function () {
      var $grupo = $(this);
      if ($grupo.find('input[type="radio"]:checked').length) return;
      var $primeiroInput = $grupo
        .find(".apex-item-option")
        .first()
        .find('input[type="radio"]')
        .first();
      if ($primeiroInput.length) {
        $primeiroInput.prop("checked", true);
      }
    });
  }

  function iniciar() {
    selecionarPrimeiraOpcaoSemDefault();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", iniciar);
  } else {
    iniciar();
  }

  // Modal aberta ou região atualizada via AJAX — pode trazer Radio
  // Group novo pra tela que ainda não passou por essa checagem.
  $(document).on("apexafteropendialog apexafterrefresh", function (e) {
    root.setTimeout(function () {
      selecionarPrimeiraOpcaoSemDefault($(e.target));
    }, 0);
  });

  // Rede de segurança pra qualquer outro conteúdo inserido
  // dinamicamente que não dispare os eventos acima.
  if (root.MutationObserver) {
    var aguardando = false;
    var observer = new MutationObserver(function () {
      if (aguardando) return;
      aguardando = true;
      root.setTimeout(function () {
        selecionarPrimeiraOpcaoSemDefault();
        aguardando = false;
      }, 200);
    });
    observer.observe(document.documentElement, {
      childList: true,
      subtree: true,
    });
  }
})(window);
/* ============== FIM da seleção default do Radio Group ============== */
/* =============================================================
   Correção do cabeçalho flutuante NATIVO do Oracle (widget "Fixed
   Header Table" / classe ".js-stickyTableHeader") que fica preso
   visível na tela mesmo depois da tabela de verdade já ter rolado
   inteira pra fora da área visível — confirmado numa região "meia
   tela" (lado a lado com outra região na mesma linha).

   Importante: isso é DIFERENTE do nosso cabeçalho flutuante via
   JavaScript (funcionalidade "cabeçalho grudento", mais acima nesse
   arquivo) — aquele só atua em relatórios SEM o widget nativo. Aqui
   é o widget NATIVO do próprio Oracle que não está escondendo
   sozinho quando deveria.

   A gente não desliga nem substitui esse widget nativo — ele
   continua 100% responsável por MOSTRAR o cabeçalho flutuante
   (isso já funciona certo). A gente só força ele a ESCONDER nos
   casos em que ele deveria ter escondido e não escondeu, usando
   como referência a posição real da TABELA (que tem <tbody> — a
   tabela clonada do próprio widget, sem dados, não tem) em vez da
   REGIÃO inteira (que pode estar esticada em altura por causa do
   layout lado a lado com outra região maior).

   Usa "setProperty(..., 'important')" direto no style do elemento,
   em vez de mexer no CSS: isso aplica um "!important" só nosso, sem
   precisar de nenhuma regra nova no arquivo CSS, e "removeProperty"
   tira exatamente essa marca nossa de volta (sem apagar nada que o
   próprio Oracle tenha colocado ali), devolvendo o controle pro
   widget nativo assim que a tabela voltar a aparecer na tela.
   ============================================================= */
(function (root) {
  "use strict";

  var $ = root.apex && root.apex.jQuery ? root.apex.jQuery : root.jQuery;
  if (!$) return;

  var ALTURA_CABECALHO_APP = 48;

  // A classe "js-stickyTableHeader" do widget nativo NÃO fica na
  // região (.t-IRR-region) — fica num <div class="t-fht-thead"> (o
  // próprio cabeçalho flutuante clonado) DENTRO dela, junto com um
  // <div class="t-fht-wrapper"> por perto. Por isso a gente acha o
  // widget primeiro (".t-fht-wrapper") e sobe até a região mais
  // próxima (".closest(...)"), em vez de tentar achar a combinação
  // direto na região.
  function corrigirCabecalhoNativo($fht) {
    var $regiao = $fht.closest(".t-IRR-region");
    if (!$regiao.length) return;

    // Enquanto maximizada, quem cuida do cabeçalho é o CSS
    // "position: sticky" (ver Natcorp_Style_Min.css) — não mexe.
    if ($regiao.hasClass("nc-fake-maximized") || $regiao.hasClass("is-maximized")) return;

    // ATENÇÃO: o ".t-fht-wrapper" NÃO é só o cabeçalho clonado — ele
    // também contém, como filho, o ".t-fht-tbody" com as LINHAS DE
    // DADOS DE VERDADE da tabela (confirmado via inspeção: filhos
    // diretos são ".t-fht-thead" + ".js-stickyWidget-placeholder" +
    // ".t-fht-tbody"). Esconder o wrapper inteiro esconde o
    // relatório inteiro junto — por isso a gente mexe só no
    // ".t-fht-thead" (o cabeçalho flutuante propriamente dito), que
    // é o único pedaço que deve sumir.
    var $theadFlutuante = $fht.find(".t-fht-thead").first();
    if (!$theadFlutuante.length) return;

    // O ".t-fht-thead" não é usado só quando está flutuando — ele é
    // o cabeçalho da tabela o tempo todo (o próprio Oracle acrescenta
    // a classe "is-stuck" quando decide colocá-lo em position:fixed
    // por cima da tela; sem essa classe, ele está posicionado
    // normalmente, no lugar de sempre). Só mexemos nele quando o
    // Oracle já marcou como "grudado" — do contrário (recém-carregada
    // a página, ainda sem rolar, por exemplo) ele deve continuar
    // aparecendo do jeito normal, sem nenhuma interferência nossa.
    if (!$theadFlutuante.hasClass("is-stuck")) {
      $theadFlutuante[0].style.removeProperty("visibility");
      return;
    }

    // A tabela de VERDADE tem <tbody> (com as linhas de dados); a
    // tabela clonada pelo próprio widget nativo, usada só pra exibir
    // o cabeçalho flutuante, não tem — só um <tr> solto com os <th>.
    // Usada aqui só pra confirmar que existe mesmo um relatório de
    // verdade nessa região (não pra medir a posição — ver abaixo).
    var $tabelaReal = $regiao
      .find(".a-IRR-table")
      .filter(function () {
        return $(this).find("> tbody").length > 0;
      })
      .first();
    if (!$tabelaReal.length) return;

    // Importante: NÃO usar o rect da <table> em si. Quando a região
    // tem rolagem própria (overflow:auto — comum em regiões "meia
    // tela" com muitas linhas), a tabela continua "alta" no DOM
    // mesmo com a região inteira já fora da tela, porque o recorte
    // visual é feito pelo contêiner, não pela tabela. O rect da
    // REGIÃO já reflete corretamente o espaço realmente ocupado na
    // página (mesmo padrão usado no mecanismo próprio de cabeçalho
    // flutuante, mais acima neste arquivo).
    var rect = $regiao[0].getBoundingClientRect();

    // O cabeçalho flutuante nativo só faz sentido aparecer enquanto
    // a região está "atravessando" a faixa de grude: o topo dela já
    // passou por baixo do cabeçalho do app (rect.top < 48), mas o
    // fim dela ainda não saiu de vista (rect.bottom > 48). Fora
    // dessa faixa — seja porque a região ainda nem chegou lá em
    // cima (rect.top >= 48, mesmo que o widget tenha "grudado"
    // sozinho por causa da rolagem PRÓPRIA/interna da região), seja
    // porque ela já passou inteira (rect.bottom <= 48) — o cabeçalho
    // nativo é forçado a ficar escondido, não importa o que o
    // widget decidiu internamente.
    var deveAparecer = rect.top < ALTURA_CABECALHO_APP && rect.bottom > ALTURA_CABECALHO_APP;

    if (deveAparecer) {
      $theadFlutuante[0].style.removeProperty("visibility");
    } else {
      $theadFlutuante[0].style.setProperty("visibility", "hidden", "important");
    }
  }

  function corrigirTodos() {
    $(".t-fht-wrapper").each(function () {
      corrigirCabecalhoNativo($(this));
    });
  }

  // Só liga o monitor (setInterval) em páginas que realmente têm
  // alguma região com o cabeçalho flutuante NATIVO do Oracle — a
  // maioria das telas não tem, e não faz sentido ficar checando de
  // 0,3 em 0,3 segundo à toa nelas. Reavalia sempre que um conteúdo
  // novo pode ter chegado (modal aberta, região atualizada via
  // AJAX) e, como rede de segurança, também num MutationObserver —
  // se aparecer uma região elegível depois (ex.: dentro de uma
  // modal), o monitor liga sozinho; se a última região elegível
  // sumir da página, ele desliga sozinho.
  var idIntervalo = null;

  function existeRegiaoElegivel() {
    return $(".t-fht-wrapper").length > 0;
  }

  function garantirMonitor() {
    var precisaRodar = existeRegiaoElegivel();
    if (precisaRodar && idIntervalo === null) {
      idIntervalo = root.setInterval(corrigirTodos, 300);
    } else if (!precisaRodar && idIntervalo !== null) {
      root.clearInterval(idIntervalo);
      idIntervalo = null;
    }
  }

  garantirMonitor();

  $(document).on("apexafteropendialog apexafterrefresh apexafterclosedialog", function () {
    root.setTimeout(garantirMonitor, 0);
  });

  if (root.MutationObserver) {
    var aguardandoObserver = false;
    var observer = new MutationObserver(function () {
      if (aguardandoObserver) return;
      aguardandoObserver = true;
      root.setTimeout(function () {
        garantirMonitor();
        aguardandoObserver = false;
      }, 500);
    });
    observer.observe(document.documentElement, {
      childList: true,
      subtree: true,
    });
  }
})(window);
/* ======== FIM da correção do cabeçalho flutuante nativo (fora de vista) ======== */