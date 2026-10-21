/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · VER A SENHA  —  o olho dentro do campo de senha (JavaScript)                   ║
   ║  App 200: login (900) e Alterar Minha Senha (901)                                         ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia: SENHA-MANUTENCAO.md. A aparência está no Natcorp_Login.src.css (dentro do Style_Min),
   bloco "Ver a senha".

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Em todo campo de senha da página, põe um botão com um olho, à direita, dentro do campo:
     · um toque MOSTRA o que foi digitado (o olho fica riscado); outro toque ESCONDE de novo;
     · o cursor continua onde estava: dá para mostrar, conferir e seguir digitando;
     · quem usa leitor de tela ouve "Mostrar senha" / "Esconder senha" e o estado (pressionado).
   Cada campo tem o seu olho (na 901 são três: atual, nova e confirmar).

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não muda o valor, a validação, o "Enter envia" nem o que é gravado. Antes de a página ser
     enviada, todo campo volta a ser de senha (o navegador não guarda a senha como texto comum).

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 900 e página 901 › JavaScript › File URLs: #WORKSPACE_IMAGES#Natcorp_Senha.js
     (o aplicar-senha-paginas.py escreve a linha nas exportações). Sobe no Workspace Images.
     Para desligar: tire a linha do File URLs. Nada mais foi alterado.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [S1] Os textos                                             PODE MEXER
     [S2] Montar o olho num campo
     [S3] A ação "foco no Entrar" da página 900                 CUIDADO
     [S4] Antes de enviar, esconder tudo
     [S5] Achar os campos
*/
(function () {
  'use strict';
  if (window.__ncSenha) return;
  window.__ncSenha = true;

  /* ═══ [S1] OS TEXTOS ═════════════════════════════════════════════════════════════════════
     PODE MEXER  o que o leitor de tela fala e o balão do mouse mostra.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var TEXTO = { mostrar: 'Mostrar senha', esconder: 'Esconder senha' };

  /* ═══ [S2] MONTAR O OLHO NUM CAMPO ═══════════════════════════════════════════════════════
     O botão entra no .t-Form-itemWrapper do item, ao lado do ícone da chave. Os ícones são da
     Font APEX (fa-eye / fa-eye-slash), os mesmos do resto da tela.
     O mousedown sem efeito é o que segura o foco no campo: sem ele, o toque no olho tiraria o
     foco do campo (no celular, o teclado fecharia) e o cursor iria para o fim.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montar(campo) {
    if (campo.__ncSenha || !campo.id) return;
    campo.__ncSenha = true;
    var caixa = campo.parentNode;
    caixa.classList.add('nc-senha');

    /* aberto, o campo vira texto: sem isto o teclado do celular põe maiúscula na primeira letra
       e "corrige" a senha */
    campo.setAttribute('autocapitalize', 'off');
    campo.setAttribute('autocorrect', 'off');
    campo.setAttribute('spellcheck', 'false');

    var olho = document.createElement('button');
    olho.type = 'button';
    olho.className = 'nc-senha-ver';
    olho.setAttribute('aria-controls', campo.id);
    var icone = document.createElement('span');
    icone.setAttribute('aria-hidden', 'true');
    olho.appendChild(icone);

    function mostrar(sim) {
      campo.type = sim ? 'text' : 'password';
      olho.setAttribute('aria-pressed', sim ? 'true' : 'false');
      olho.setAttribute('aria-label', sim ? TEXTO.esconder : TEXTO.mostrar);
      olho.title = sim ? TEXTO.esconder : TEXTO.mostrar;
      icone.className = 'fa ' + (sim ? 'fa-eye-slash' : 'fa-eye');
    }
    campo.__ncSenhaMostrar = mostrar;
    mostrar(false);

    /* o olho fica na borda direita do CAMPO, não da caixa: na 901 o botão de ajuda do APEX
       ("Texto da Ajuda") divide a caixa com o campo. A distância vai na variável --nc-senha-dir,
       que o CSS lê; é medida de novo quando o campo muda de largura. */
    function medir() {
      var d = caixa.getBoundingClientRect().right - campo.getBoundingClientRect().right;
      caixa.style.setProperty('--nc-senha-dir', Math.max(0, Math.round(d)) + 'px');
    }
    if (window.ResizeObserver) new ResizeObserver(medir).observe(campo);
    window.addEventListener('resize', medir);

    olho.addEventListener('mousedown', function (e) { e.preventDefault(); });
    olho.addEventListener('click', function () {
      var focado = document.activeElement === campo;
      var ini = campo.selectionStart, fim = campo.selectionEnd;
      mostrar(campo.type === 'password');
      if (focado) {
        try { campo.setSelectionRange(ini, fim); } catch (e) {}
      }
    });
    caixa.appendChild(olho);
    medir();
  }

  /* ═══ [S3] A AÇÃO "FOCO NO ENTRAR" DA PÁGINA 900 ═════════════════════════════════════════
     CUIDADO  a ação dinâmica key-next-item da 900 leva o foco ao botão Entrar quando o campo
              de senha perde o foco. Com o olho logo depois do campo, o Tab nunca chegaria nele.
              Aqui, só quando o foco vai do campo para o PRÓPRIO olho, o evento não chega à
              ação; em qualquer outro caso ela continua igual (fluxo original da página).
              O jQuery do APEX não ouve o focusout de verdade: ele o SIMULA a partir de um blur
              capturado no document. Por isso o filtro fica na window (captura), que recebe o
              blur antes do document — e pega os dois eventos.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function praOlho(e) {
    var vai = e.relatedTarget;
    if (vai && vai.classList && vai.classList.contains('nc-senha-ver') && vai.getAttribute('aria-controls') === e.target.id) {
      e.stopPropagation();
    }
  }
  window.addEventListener('blur', praOlho, true);
  window.addEventListener('focusout', praOlho, true);

  /* ═══ [S4] ANTES DE ENVIAR, ESCONDER TUDO ════════════════════════════════════════════════
     O apex.submit avisa com apexbeforepagesubmit; o submit comum do formulário, com submit.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function esconderTodos() {
    [].forEach.call(document.querySelectorAll('.nc-senha input'), function (c) {
      if (c.__ncSenhaMostrar) c.__ncSenhaMostrar(false);
    });
  }
  if (window.apex && apex.jQuery) apex.jQuery(document).on('apexbeforepagesubmit', esconderTodos);
  document.addEventListener('submit', esconderTodos, true);

  /* ═══ [S5] ACHAR OS CAMPOS ═══════════════════════════════════════════════════════════════
     Todo input de senha do APEX (classe password, tipo password). O arquivo só é carregado nas
     páginas que o pedem, então "todo" quer dizer os campos da 900 e da 901.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function achar() {
    [].forEach.call(document.querySelectorAll('input[type="password"].apex-item-text'), montar);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', achar);
  else achar();
})();
