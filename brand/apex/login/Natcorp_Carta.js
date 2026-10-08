/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CARTA DE APRESENTAÇÃO  —  o "arrumador" da tela (JavaScript)                   ║
   ║  App 600 (portal Conhecendo Você) · Página 14                                            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   A carta é um texto só (até 2000 letras) em que o colaborador ou o candidato se apresenta.
   Para quem escreve pouco, uma caixa em branco é a parte mais difícil do cadastro inteiro.
   Por isso, ao abrir a página 14, este arquivo acrescenta ajudas em volta da caixa:
     1. No alto, "Conte um pouco sobre você": o que é a carta, em uma frase, e que pode ser
        escrita do jeito da pessoa.
     2. COMEÇOS DE FRASE (botões): "Quem eu sou", "Onde já trabalhei", "O que sei fazer",
        "Como eu sou", "Por que quero trabalhar aqui". Um toque põe "Meu nome é …" no fim do
        texto, com o cursor pronto para continuar. O começo já usado fica marcado.
     3. Embaixo da caixa: a DICA DO MICROFONE (no celular, falar em vez de digitar) e UM
        EXEMPLO curto para imitar (recolhido em "Ver um exemplo de carta").
     4. A CAIXA fica grande (letra de 17px), cresce com o texto, e embaixo dela aparece quantas
        letras já tem e se já está bom ("Está ótimo" a partir de umas 4 frases).
     5. O botão "Prosseguir" passa a se chamar "Continuar" (é ele que salva o texto).
     6. Caixa travada (quem só consulta): a carta aparece como leitura, sem as ajudas.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não grava nada no banco: quem grava é o botão "Prosseguir"/"Continuar" do APEX.
     • A ÚNICA coisa que ele escreve na caixa é o começo de frase que a pessoa tocou (e isso só
       vai para o banco quando ela clicar em Continuar). O exemplo nunca entra na caixa.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 14 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Carta.js
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Carta.css
     (Página 14 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Carta.css).

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
     Esta página NÃO precisa de classe nenhuma no APEX. O arquivo reconhece a página sozinho,
     procurando a caixa de texto cujo nome termina em  _DESC_QUALIFIC_FUNC  (por exemplo,
     P14_DESC_QUALIFIC_FUNC). Se essa caixa não existir na página, o arquivo não faz nada.
     CUIDADO: se esse item for renomeado no APEX, as ajudas deixam de aparecer.
     O botão de salvar precisa ter o texto "Prosseguir" para virar "Continuar".

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Como a página é reconhecida ........ acha a caixa da carta              CUIDADO
     [J2]  Textos e configuração .............. começos de frase, exemplo, metas  PODE MEXER
     [J3]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J4]  Montar as ajudas .................... intro, começos, microfone, exemplo PODE MEXER
     [J5]  Crescer e atualizar ................. tamanho da caixa e "quanto já tem" PODE MEXER
     [J6]  O maestro ........................... decide QUANDO tudo é montado      CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Conte um pouco sobre você'  →  'Fale de você'
     Quero acrescentar, tirar ou mudar um começo de frase   → [J2], lista COMECOS
     Quero trocar o exemplo de carta                         → [J2], texto EXEMPLO
     Quero mudar quando aparece "Está ótimo"                 → [J2], o número BOM (em letras)
     O limite de letras está errado
       → nada a mudar aqui: o limite vem do APEX (Maximum Length do item). Só se o APEX não
         tiver limite é que vale o 2000 escrito em [J2].
     A tela ficou "crua" (sem as ajudas)
       → confira se o item ..._DESC_QUALIFIC_FUNC existe e é uma caixa de texto (Textarea).
         Depois abra o Console do navegador (F12 › Console). O manual, parte 5, ajuda.

   ── LEGENDA DAS MARCAS NOS COMENTÁRIOS ────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, títulos.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
     (sem marca)  funciona sozinho; só mexa se souber o que está fazendo.

   ── COMO LER UM ARQUIVO JS EM 30 SEGUNDOS ─────────────────────────────────────────────────
     comentário             tudo entre barra-asterisco e asterisco-barra, e o resto da linha
                            depois de duas barras. O navegador ignora: é só para pessoas.
     function nome() { … }  uma "receita" com nome. Ela só roda quando alguém a chama: nome().
     var x = …;             guarda um valor com um nome, para usar depois.
     'texto'  ou  "texto"   um texto. Muitas vezes, é o que aparece na tela.
     TX                     aqui, é a caixa de texto da carta (o item ..._DESC_QUALIFIC_FUNC).
     apex.item(ID).setValue(…)  põe um valor no item do APEX, como se a pessoa tivesse digitado.
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* ═══ [J1] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════════
     O QUE FAZ  Procura na página a caixa cujo nome termina em _DESC_QUALIFIC_FUNC. Se não
                achar (ou se não for uma caixa de texto grande), o arquivo para aqui e a página
                fica como o APEX desenhou. Assim o arquivo não depende do número do app nem da
                página: ele só age onde a caixa da carta existe.
     CUIDADO    A primeira linha impede que o arquivo rode duas vezes (URL repetida na página,
                por exemplo) e que rode fora do APEX. Não apague.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncCarta || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_DESC_QUALIFIC_FUNC_CONTAINER"]');
  var TX = achado && document.getElementById(achado.id.replace(/_CONTAINER$/, ''));
  if (!TX || TX.tagName !== 'TEXTAREA') return;
  window.__ncCarta = true;

  /* ═══ [J2] TEXTOS E CONFIGURAÇÃO ═════════════════════════════════════════════════════════
     ID   o nome do item da caixa (achado sozinho em [J1]).
     MAX  o limite de letras: vem do APEX (Maximum Length do item); 2000 só se o APEX não
          tiver limite.
     BOM  a partir de quantas letras a tela diz "Está ótimo" (180 ≈ umas 4 frases curtas).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var $ = apex.jQuery;
  var ID = TX.id;
  var MAX = +TX.getAttribute('maxlength') || 2000;
  /* PODE MEXER: o número abaixo (em letras) */
  var BOM = 180;      /* umas 4 frases curtas */

  /* PODE MEXER: os começos de frase. Cada linha é um botão:
       rot  o texto do botão          txt  o que o toque escreve no fim da carta
     Para acrescentar um, copie uma linha inteira { rot: '…', txt: '…' }, cole embaixo e troque
     os textos. Entre uma linha e outra vai uma vírgula; depois da ÚLTIMA linha, não. */
  var COMECOS = [
    { rot: 'Quem eu sou', txt: 'Meu nome é ' },
    { rot: 'Onde já trabalhei', txt: 'Já trabalhei com ' },
    { rot: 'O que sei fazer', txt: 'Sei fazer ' },
    { rot: 'Como eu sou', txt: 'Sou uma pessoa ' },
    { rot: 'Por que quero trabalhar aqui', txt: 'Quero trabalhar aqui porque ' }
  ];
  /* PODE MEXER: o exemplo de carta (aparece em "Ver um exemplo de carta"). As partes entre
     aspas são unidas pelos sinais de + ; troque só o texto de dentro das aspas. */
  var EXEMPLO = 'Meu nome é Ana, tenho 32 anos e moro em Guarulhos. Já trabalhei 5 anos com limpeza em ' +
    'hospital e 2 anos como auxiliar de cozinha. Sei organizar o trabalho e cuidar bem dos materiais. ' +
    'Sou uma pessoa pontual, gosto de trabalhar em equipe e aprendo rápido. Quero trabalhar aqui ' +
    'porque quero crescer e aprender coisas novas.';
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    carta: '<rect x="3" y="5" width="18" height="14" rx="2.5"/><path d="M3.5 6.5l8.5 6.5 8.5-6.5"/>',
    mic: '<rect x="9" y="3" width="6" height="11" rx="3"/><path d="M5.5 11a6.5 6.5 0 0 0 13 0M12 17.5V21M8.5 21h7"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    olho: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="3"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>'
  };

  /* ═══ [J3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
       el(…)        cria um pedaço novo de tela          esc(…)   protege um texto antes de mostrar
       svg(…)       desenha um ícone                     html(…)  troca o conteúdo só se mudou
       classe(…)    liga/desliga uma etiqueta (classe)   renomear('…')  troca o rótulo da caixa
     QUANDO MEXER  Quase nunca.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d) { return '<svg class="nc-ca-ic" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function renomear(t) {
    var l = document.getElementById(ID + '_LABEL');
    if (!l || l.getAttribute('data-nc-ca')) return;
    for (var i = 0; i < l.childNodes.length; i++) {
      var x = l.childNodes[i];
      if (x.nodeType === 3 && x.textContent.trim()) { x.textContent = t + ' '; l.setAttribute('data-nc-ca', '1'); return; }
    }
  }

  /* ═══ [J4] MONTAR AS AJUDAS ══════════════════════════════════════════════════════════════
     O QUE FAZ  Roda uma vez. Na região da caixa (que ganha a etiqueta nc-ca-reg):
                  • troca o rótulo para "Sua carta" e põe uma frase-guia em cinza dentro da caixa
                    vazia ("Escreva aqui, do seu jeito…" — some quando a pessoa começa a digitar);
                  • cria, ANTES da caixa: a intro (INTRO), os começos de frase (AJUDA) e o espaço
                    da leitura para quem só consulta (LEITURA);
                  • cria, DEPOIS da caixa: a linha "quanto já tem" (CONTA), a dica do microfone e
                    o exemplo (DEPOIS);
                  • troca o texto do botão "Prosseguir" por "Continuar".
                Ao tocar num começo de frase, o texto dele vai para o fim da carta (com um ponto
                antes, se faltar), e o cursor fica pronto. Se passar do limite, nada acontece.
     PODE MEXER os textos entre aspas: 'Sua carta', a frase do placeholder, o título e a
                explicação da intro, 'Não sabe como começar? Toque num destes:', a dica do
                microfone, 'Ver um exemplo de carta' e 'Continuar'.
     CUIDADO    'Prosseguir' (em  /^\s*prosseguir\s*$/i ) é o texto que o arquivo PROCURA no
                botão do APEX. Se o botão for renomeado no APEX, mude aqui também.
     VISUAL     Natcorp_Carta.css › [C2] (intro) e [C3] (começos, microfone, exemplo)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var REG, INTRO, AJUDA, DEPOIS, CONTA, LEITURA;
  function montar() {
    REG = achado.closest('.t-Region');
    if (!REG) return false;
    REG.classList.add('nc-ca-reg');
    renomear('Sua carta');
    TX.setAttribute('placeholder', 'Escreva aqui, do seu jeito. Pode usar os botões de cima para começar.');
    TX.setAttribute('rows', '8');
    TX.style.removeProperty('resize');
    TX.setAttribute('autocapitalize', 'sentences');
    TX.setAttribute('spellcheck', 'true');

    INTRO = el('div', 'nc-ca-intro');
    INTRO.innerHTML = '<span class="nc-ca-intro-ic">' + svg(IC.carta) + '</span><div><h2 class="nc-ca-tit">Conte um pouco sobre você</h2>' +
      '<p>É um recado seu para a empresa: <b>quem você é, o que já fez e por que quer trabalhar aqui</b>. ' +
      'Pode escrever do seu jeito, com palavras simples. Não precisa ser perfeito.</p></div>';

    AJUDA = el('div', 'nc-ca-ajuda');
    AJUDA.innerHTML = '<p class="nc-ca-ajuda-tit">Não sabe como começar? Toque num destes:</p>' +
      '<div class="nc-ca-comecos">' + COMECOS.map(function (c, i) {
        return '<button type="button" class="nc-ca-comeco" data-i="' + i + '">' + svg(IC.mais) + '<span>' + esc(c.rot) + '</span></button>';
      }).join('') + '</div>';
    /* a dica do microfone e o exemplo ficam DEPOIS da caixa: no celular a caixa precisa estar perto */
    DEPOIS = el('div', 'nc-ca-depois');
    DEPOIS.innerHTML = '<p class="nc-ca-mic">' + svg(IC.mic) + '<span><b>Dica:</b> no celular, toque no <b>microfone do teclado</b> e fale. O celular escreve para você.</span></p>' +
      '<details class="nc-ca-exemplo"><summary>' + svg(IC.olho) + '<span>Ver um exemplo de carta</span></summary><p>' + esc(EXEMPLO) + '</p></details>';

    CONTA = el('div', 'nc-ca-conta');
    CONTA.setAttribute('aria-live', 'polite');

    LEITURA = el('div', 'nc-ca-leitura');
    LEITURA.hidden = true;

    var corpo = REG.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    var antes = achado; while (antes && antes.parentNode !== corpo) antes = antes.parentNode;
    if (!antes) return false;
    corpo.insertBefore(INTRO, antes);
    corpo.insertBefore(AJUDA, antes);
    corpo.insertBefore(LEITURA, antes);
    achado.parentNode.insertBefore(CONTA, achado.nextSibling);
    CONTA.parentNode.insertBefore(DEPOIS, CONTA.nextSibling);

    AJUDA.addEventListener('click', function (e) {
      var b = e.target.closest('.nc-ca-comeco'); if (!b || TX.disabled) return;
      var c = COMECOS[+b.getAttribute('data-i')];
      var v = TX.value.replace(/\s+$/, '');
      var novo = (v ? v + (/[.!?]$/.test(v) ? ' ' : '. ') : '') + c.txt;
      if (novo.length > MAX) return;
      apex.item(ID).setValue(novo);
      TX.focus();
      try { TX.setSelectionRange(novo.length, novo.length); } catch (x) {}
      crescer();
      atualizar();
    });

    [].forEach.call(document.querySelectorAll('.t-Button .t-Button-label'), function (l) {
      if (/^\s*prosseguir\s*$/i.test(l.textContent)) l.textContent = 'Continuar';
    });
    return true;
  }
  /* ═══ [J5] CRESCER E ATUALIZAR ═══════════════════════════════════════════════════════════
     crescer()    A caixa acompanha o tamanho do texto: no mínimo 220px de altura, no máximo
                  560px (depois disso aparece a barra de rolagem).
     atualizar()  Roda a cada letra digitada. Marca os começos já usados, escreve a frase de
                  incentivo e "N de 2000 letras" (em destaque quando faltam menos de 100), e
                  enche a linha de progresso até BOM. Com a caixa travada (disabled/readonly
                  no APEX), esconde as ajudas e mostra a carta como texto de leitura.
     PODE MEXER as frases 'Nada escrito ainda.', 'É um bom começo…', 'Está ótimo…',
                'Ainda não tem carta de apresentação.' e a palavra 'letras'.
     VISUAL     Natcorp_Carta.css › [C4] (caixa e "quanto já tem") e [C5] (leitura)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function crescer() {
    TX.style.setProperty('--nc-ca-h', '0px');
    TX.style.setProperty('--nc-ca-h', Math.min(Math.max(TX.scrollHeight + 2, 220), 560) + 'px');
  }
  function atualizar() {
    var trav = TX.disabled || TX.readOnly;
    var v = TX.value, n = v.trim().length;
    classe(document.body, 'nc-ca-travada', trav);
    AJUDA.hidden = trav;
    DEPOIS.hidden = trav;
    LEITURA.hidden = !trav;
    if (trav) html(LEITURA, n ? '<p>' + esc(v).replace(/\n/g, '<br>') + '</p>' : '<p class="nc-ca-leitura-vazia">' + svg(IC.lapis) + 'Ainda não tem carta de apresentação.</p>');
    [].forEach.call(AJUDA.querySelectorAll('.nc-ca-comeco'), function (b) {
      var c = COMECOS[+b.getAttribute('data-i')];
      classe(b, 'is-usado', v.toLowerCase().indexOf(c.txt.trim().toLowerCase()) >= 0);
    });
    var falta = MAX - v.length;
    var msg = !n ? '<span>Nada escrito ainda.</span>'
      : n < BOM ? '<span class="nc-ca-quase">É um bom começo. Escreva mais umas frases.</span>'
      : '<span class="nc-ca-bom">' + svg(IC.ok) + 'Está ótimo. Toque em <b>Continuar</b> para salvar.</span>';
    html(CONTA, trav ? '' : msg + '<span class="nc-ca-n' + (falta < 100 ? ' is-perto' : '') + '">' + v.length + ' de ' + MAX + ' letras</span>');
    CONTA.hidden = trav;
    CONTA.style.setProperty('--nc-ca-p', Math.min(100, Math.round(n / BOM * 100)) + '%');
  }
  /* ═══ [J6] O MAESTRO: QUANDO TUDO ACONTECE ═══════════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a página abre: monta as ajudas, põe a marca nc-ca
                na página (é ela que liga o visual do CSS) e depois atualiza a tela sempre que a
                pessoa digita, quando o valor muda por ação dinâmica, e quando o APEX trava ou
                destrava a caixa. Uma última atualização roda 0,6 segundo depois de abrir, para
                pegar o que o APEX ajusta por último.
     CUIDADO    Não mude a ordem: montar() precisa vir antes de crescer() e atualizar().
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function iniciar() {
    if (!montar()) return;
    document.body.classList.add('nc-ca');
    crescer();
    atualizar();
    TX.addEventListener('input', function () { crescer(); atualizar(); });
    $(document).on('change', '#' + ID, atualizar);
    if (window.MutationObserver) new MutationObserver(atualizar).observe(TX, { attributes: true, attributeFilter: ['disabled', 'readonly'] });
    setTimeout(function () { crescer(); atualizar(); }, 600);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
