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
