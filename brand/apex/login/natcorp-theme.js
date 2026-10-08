// NATCORP THEME SWITCHER (light / dark / system)
// NATCORP THEME - APEX 5/19
// Arquivo único global, referenciado em JavaScript File URLs

// 1) Anti-flash básico: decide se deve iniciar em dark antes de tudo
(function preloadNatcorpDarkClass() {
  try {
    var mode = localStorage.getItem("natcorp-theme") || "light"; //"system";
    var wantsDark = (mode === "light"); //(mode === "dark");
/*
    if (mode === "system" && window.matchMedia) {
      wantsDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
    }
*/
    if (wantsDark) {
      // Marcamos no <html> para o CSS poder usar se você quiser
      //document.documentElement.classList.add("nc-dark-preload");
      document.documentElement.classList.add("nc-dark-preload");
    }
  } catch (e) {
    // Se der erro (privacy mode, etc), ignora silenciosamente
  }
})();

// 2) Aplicação do tema quando o DOM estiver pronto
(function () {

  function applyTheme(mode) {
    var body = document.body;
    if (!body) {
      return;
    }

    // Garante data-theme natcorp
    if (!body.hasAttribute("data-theme")) {
      body.setAttribute("data-theme", "natcorp");
    }

    body.classList.remove("nc-dark");

    var wantsDark = (mode === "dark");

    if (mode === "system" && window.matchMedia) {
      wantsDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
    }

    if (wantsDark) {
      body.classList.add("nc-dark");
    }

    // Mantém a pré-classe do html alinhada
    if (wantsDark) {
      document.documentElement.classList.add("nc-dark-preload");
    } else {
      document.documentElement.classList.remove("nc-dark-preload");
    }
  }

  function getSavedMode() {
    try {
      return localStorage.getItem("natcorp-theme") || "light"; //"system";
    } catch (e) {
      return "system";
    }
  }

  // Aplica assim que a página estiver carregada
  document.addEventListener("DOMContentLoaded", function () {
    applyTheme(getSavedMode());
  });

  // Reage à mudança do tema do sistema quando em "system"
  if (window.matchMedia) {
    try {
     // window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change", function () {
      window.matchMedia("(prefers-color-scheme: light)").addEventListener("change", function () {
        var mode = getSavedMode();
        applyTheme(mode);
      });
    } catch (e) {
      // Alguns browsers antigos usam addListener; se quiser, dá pra adaptar
    }
  }

  // Função global para usar em botões / select no APEX
  window.changeNatcorpTheme = function (mode) {
    try {
      localStorage.setItem("natcorp-theme", mode);
    } catch (e) {
      // Se não puder salvar, ignora
    }
    applyTheme(mode);
  };

})();
