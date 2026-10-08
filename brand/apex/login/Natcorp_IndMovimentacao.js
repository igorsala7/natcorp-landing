/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE INDICAÇÃO DE MOVIMENTAÇÃO  —  o "arrumador" da tela (JavaScript) ║
   ║  App 2280 · Página 184 · o gestor indica que um colaborador mude de lugar ou de cargo     ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   É a página aberta pela aba "Requisição de Indicação de Movimentação" do Painel: o gestor
   indica que um colaborador mude de filial, cargo, função ou local de trabalho; quem aprova
   autoriza. (Não confundir com a Alteração Funcional, 200:116, que é o Natcorp_Movimentacao.)
     1. Abertura: o que é o pedido e o caminho (você indica → quem aprova autoriza → a mudança
        é feita no cadastro).
     2. Passos numerados: 1 Quem vai mudar? · 2 O que muda? · 3 Por que mudar?
     3. O quadro "HOJE → VAI PARA": cada aspecto (Filial, Cargo, Função, Local de trabalho)
        numa linha, com o que é hoje, a seta e a escolha; o selo diz Muda / Continua igual /
        Falta escolher.
     4. "Continua igual" em cada linha e "Deixar igual o que não muda" para todas as vazias —
        na ordem das listas em cascata (Filial antes do Local, Cargo antes da Função).
     5. "Por que mudar?": começos de motivo que escrevem na Observação.
     6. Barra no pé: a frase da mudança ("Tony muda de cargo"), o que falta e "Enviar pedido"
        (que clica o botão "Criar" da página).
     7. Pedido gravado: cabeçalho com nº, situação, quem muda e o que muda (de → para); a
        aprovação vira o caminho das outras requisições, logo abaixo, na largura toda.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: isso continua sendo do APEX
       (itens, listas em cascata, ações dinâmicas, validações e processos).
     • "Continua igual" preenche a lista com apex.item().setValue, usando o código que a
       própria página trouxe (…_COD_*_ATUAL) — o mesmo que a pessoa escolheria na lista.
     • NÃO mexe no seletor "Página única / Etapas": ele é do time, no arquivo
       Natcorp_Allow_Unload_Iframes.js, que NÃO deve ser alterado.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 184 › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_IndMovimentacao.js  (no FIM)
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_IndMovimentacao.css.
     A exportação da página já traz as duas URLs (script aplicar-indmovimentacao.py).

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Esta página NÃO usa classes postas no APEX. O arquivo reconhece a página sozinho, pelos
   itens …_COD_FILIAL_PROP, …_COD_CARGO_PROP e …_COD_FILIAL_ATUAL. Sem eles, não faz nada.
   O começo dos nomes (P184_) é descoberto sozinho, pelo próprio item: se a página for copiada
   para outro número, o arquivo continua funcionando sem mudar nada.
   Para cada aspecto X da lista ASPECTOS ([J1]) a página precisa ter TRÊS itens:
     X_ATUAL_DSP      o que é hoje, para ler        (ex.: P184_CARGO_ATUAL_DSP)
     COD_X_ATUAL      o código de hoje (escondido)  (ex.: P184_COD_CARGO_ATUAL)
     COD_X_PROP       a lista "Vai para"            (ex.: P184_COD_CARGO_PROP)
   e o "hoje" e o "vai para" na MESMA linha do layout do APEX.
   Outros itens lidos pelo nome: COD_EMP_SOLICITADO, COD_MAT_SOLICITADO, OBSERVACAO, ROWID,
   COD_REQUISICAO, COD_SIT_REQ, SOLICITANTE, DT_REQUISICAO.
   Os campos, botões e ações dinâmicas continuam os do APEX: aqui eles só MUDAM DE LUGAR.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Os aspectos e os motivos ............ Filial, Cargo, Função, Local; os motivos PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  O estado de cada aspecto ............ muda, continua igual ou falta escolher
     [J4]  A abertura .......................... "Indicar a mudança de um colaborador"  PODE MEXER
     [J5]  Os passos ........................... 1 Quem · 2 O que muda · 3 Por que      PODE MEXER
     [J6]  O quadro Hoje → Vai para ............ cartões, "Continua igual", cascata     PODE MEXER
     [J7]  A barra do pé ....................... a frase, "Falta: …", "Enviar pedido"   PODE MEXER
     [J8]  O pedido gravado .................... o cabeçalho com de → para              PODE MEXER
     [J9]  O caminho da aprovação .............. a faixa com os aprovadores
     [J10] Regiões vazias ...................... recolhe as que não têm nada à vista
     [J11] O maestro ........................... decide QUANDO cada parte é montada  CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'O que muda?'  →  'O que vai mudar?'
     Quero outros botões de motivo ("Promoção", "Troca de setor"…)   → [J1], lista MOTIVOS
     Criei um aspecto novo na página (ex.: Centro de custo)
       → crie no APEX os três itens (X_ATUAL_DSP, COD_X_ATUAL, COD_X_PROP) na mesma linha e
         acrescente uma linha na lista ASPECTOS, em [J1] (a receita está lá).
     O "Continua igual" não aparece numa linha
       → ele só aparece quando a página trouxe o código de hoje (COD_X_ATUAL) e a lista está
         liberada. Se o pai (Cargo/Filial) muda, o filho (Função/Local) vem da lista nova.
     A tela ficou "crua" (sem o desenho)
       → confira se os itens do "combinado" acima existem; depois abra o Console do navegador
         (F12 › Console). O manual, parte 5, explica o que fazer com uma mensagem de erro.

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
     P + 'OBSERVACAO'       junta os textos: vira 'P184_OBSERVACAO', o nome do item no APEX.
     val('X') / txt('X')    leem o que está num item do APEX (veja [J2]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: estas linhas impedem que o arquivo rode duas vezes (URL repetida na página, por
     exemplo), que rode fora do APEX e que rode em outra página. Elas procuram os itens do
     "combinado" e descobrem sozinhas o começo dos nomes (P184_). Não apague. */
  if (window.__ncIM || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_COD_FILIAL_PROP_CONTAINER"]');
  if (!achado) return;
  var P = achado.id.replace(/COD_FILIAL_PROP_CONTAINER$/, '');
  if (!document.getElementById(P + 'COD_CARGO_PROP') || !document.getElementById(P + 'COD_FILIAL_ATUAL')) return;
  window.__ncIM = true;

  var $ = apex.jQuery;
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    predio: '<path d="M4 20V6l7-2v16M11 9h7v11M4 20h16"/><path d="M7 8h1M7 11h1M7 14h1M14 12h1M14 15h1"/>',
    cracha: '<rect x="5" y="3.5" width="14" height="17" rx="2"/><circle cx="12" cy="10" r="2.6"/><path d="M8.5 16.5c.7-1.7 2-2.5 3.5-2.5s2.8.8 3.5 2.5M10 3.5v2h4v-2"/>',
    ferramenta: '<path d="M14.5 5.5a4 4 0 0 0-5 5L4 16l4 4 5.5-5.5a4 4 0 0 0 5-5l-2.5 2.5-2.5-.5-.5-2.5z"/>',
    pino: '<path d="M12 21s-6-5.5-6-10.5a6 6 0 1 1 12 0C18 15.5 12 21 12 21z"/><circle cx="12" cy="10.5" r="2.2"/>',
    seta: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    igual: '<path d="M6 9.5h12M6 14.5h12"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    pessoa: '<circle cx="12" cy="8" r="3.6"/><path d="M4.5 20c.9-3.9 3.9-6 7.5-6s6.6 2.1 7.5 6"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    selo: '<path d="M12 3l2.4 1.8 3-.2.9 2.9 2.4 1.8-1 2.8 1 2.8-2.4 1.8-.9 2.9-3-.2L12 21l-2.4-1.8-3 .2-.9-2.9L3.3 14.7l1-2.8-1-2.8 2.4-1.8.9-2.9 3 .2z"/><path d="M8.8 12.2l2.2 2.2 4.2-4.4"/>',
    troca: '<path d="M4 8h13l-3-3M20 16H7l3 3"/>',
    fala: '<path d="M4.5 5.5h15v10h-8l-4.5 3.5v-3.5h-2.5z"/>'
  };
  /* ═══ [J1] OS ASPECTOS E OS MOTIVOS ═════════════════════════════════════════════════════
     ASPECTOS   O que pode mudar, na ordem da página. Cada linha tem:
                  n   → o nome-base do aspecto (X), usado para achar os três itens do "combinado"
                  rot → o nome que aparece na tela        ic → o desenho (da lista IC acima)
                  pai → a lista de que esta depende (cascata do APEX): Função depende do Cargo;
                        Local de trabalho depende da Filial. Mudar o pai LIMPA o filho.
                  formato: 'nome (cod)' → a lista da Função mostra "Nome (624)"; o texto copiado
                        pelo "Continua igual" segue esse formato.
                RECEITA — aspecto novo: copie uma linha, troque n, rot e ic; ponha "pai" só se a
                lista nova depender de outra. Os três itens precisam existir no APEX.
     MOTIVOS    Os botões de "Por que mudar?": cada um escreve o seu texto na caixa do motivo.
                Para acrescentar um, ponha uma vírgula e o novo texto entre aspas.
     PODE MEXER rot, ic e a lista MOTIVOS.
     CUIDADO    Não mude o "n" nem o "pai" de um aspecto que já existe: eles são os nomes dos
                itens no APEX e a ordem certa da cascata.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: os aspectos, na ordem da página; "pai" = a lista de que ela depende (cascata do APEX) */
  var ASPECTOS = [
    { n: 'FILIAL', rot: 'Filial', ic: IC.predio },
    { n: 'CARGO', rot: 'Cargo', ic: IC.cracha },
    { n: 'FUNCAO', rot: 'Função', ic: IC.ferramenta, pai: 'CARGO', formato: 'nome (cod)' },
    { n: 'LOCAL_TRAB', rot: 'Local de trabalho', ic: IC.pino, pai: 'FILIAL' }
  ];
  /* PODE MEXER: os começos de motivo de "Por que mudar?" */
  var MOTIVOS = ['Promoção', 'Troca de setor', 'Mudança de loja ou filial', 'A pedido do colaborador', 'Reorganização da equipe', 'Cobrir uma vaga'];

  /* ═══ [J2] FERRAMENTAS ══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo: ler um item do APEX, achar um botão
                pelo texto, trocar um rótulo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('ITEM')        o que o APEX GUARDA no item (o código da opção)
       txt('ITEM')        o que a PESSOA VÊ no item (o texto da opção escolhida numa lista)
       cont('ITEM')       o bloco inteiro do campo na tela (rótulo + campo)
       renomear('ITEM', 'Texto')   troca o rótulo do campo na tela
       partes('624 - Supervisor De Setor')  separa código e nome; comCodigo() junta de novo
                          como "624 - Supervisor de Setor" (na tela, sempre código - descrição)
       esperarPagina(fn)  espera a página terminar de falar com o servidor antes de seguir
       Em todas, 'ITEM' é o nome SEM o P184_ (o arquivo junta o começo sozinho).
     PODE MEXER a lista de palavras que ganham acento em bonito() ('Gerencia' → 'Gerência'…):
                cada par é Sem_acento: 'Com acento' — e o nome sem acento também tem que entrar
                na lista entre parênteses logo antes. Só mexa se souber.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-im-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function cont(n) { return document.getElementById(P + n + '_CONTAINER'); }
  function limpo(t) { t = String(t || '').replace(/\s+/g, ' ').trim(); return /^[-–—]?$/.test(t) || /^- ?selecione ?-$/i.test(t) ? '' : t; }
  function val(n) { if (!document.getElementById(P + n)) return ''; try { return limpo(apex.item(P + n).getValue()); } catch (x) { return ''; } }
  function txt(n) {
    var e = document.getElementById(P + n); if (!e) return '';
    if (e.tagName === 'SELECT') return e.selectedIndex >= 0 && e.value ? limpo(e.options[e.selectedIndex].text) : '';
    if (/^(INPUT|TEXTAREA)$/.test(e.tagName) && e.type !== 'hidden') return limpo(e.value);
    var d = document.getElementById(P + n + '_DISPLAY'); if (d) return limpo(d.textContent);
    var c = cont(n), s = c && c.querySelector('.display_only, .apex-item-display-only');
    return s ? limpo(s.textContent) : limpo(e.value || e.textContent);
  }
  function bonito(t) {
    t = String(t || '').trim();
    if (t && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t)) t = t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); });
    t = t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); });
    return t.replace(/\b(Concluid|Suspensao|Gerencia|Supervisao)(\w*)/g, function (m, r, f) { return ({ Concluid: 'Concluíd', Suspensao: 'Suspensão', Gerencia: 'Gerência', Supervisao: 'Supervisão' })[r] + f; });
  }
  /* "624 - Supervisor De Setor" ou "Supervisor De Setor (624)" → { cod: '624', nome: 'Supervisor de Setor' } */
  function partes(t) {
    t = limpo(t);
    var m = /^\s*([\w.]+)\s+-\s+(.+)$/.exec(t); if (m) return { cod: m[1], nome: bonito(m[2]) };
    m = /^(.+?)\s*\(([\w.]+)\)\s*$/.exec(t); if (m) return { cod: m[2], nome: bonito(m[1]) };
    return { cod: '', nome: bonito(t) };
  }
  /* código - descrição, no formato da página ("700 - Natcorp do Brasil"; a Função vem da lista como
     "Nome (624)" e fica "624 - Nome", igual às outras) */
  function comCodigo(p) { return p.cod ? p.cod + ' - ' + p.nome : p.nome; }
  function aVista(e) { return !!(e && (e.offsetParent || e.getClientRects().length)); }
  function botaoPorTexto(re) {
    return [].filter.call(document.querySelectorAll('button.t-Button, a.t-Button'), function (b) {
      return re.test(b.getAttribute('data-nc-im-orig') || b.textContent.replace(/\s+/g, ' ').trim());
    })[0];
  }
  function rotuloBotao(b, t) {
    if (!b) return;
    if (!b.getAttribute('data-nc-im-orig')) b.setAttribute('data-nc-im-orig', b.textContent.replace(/\s+/g, ' ').trim());
    var l = b.querySelector('.t-Button-label');
    if (l && l.textContent !== t) l.textContent = t;
  }
  function renomear(n, t) {
    var l = document.getElementById(P + n + '_LABEL');
    if (!l || l.getAttribute('data-nc-im') === t) return;
    for (var i = 0; i < l.childNodes.length; i++) {
      var x = l.childNodes[i];
      if (x.nodeType === 3 && x.textContent.trim()) { x.textContent = t + ' '; l.setAttribute('data-nc-im', t); return; }
    }
  }
  function esperarPagina(fn) { if ($.active) $(document).one('ajaxStop', function () { setTimeout(fn, 30); }); else setTimeout(fn, 30); }

  var PEDIDO = !!(val('ROWID') || val('COD_REQUISICAO'));
  var CRIAR, LEITURA;

  /* ═══ [J3] O ESTADO DE CADA ASPECTO ═════════════════════════════════════════════════════
     O QUE FAZ  estado(aspecto) compara o código de hoje (COD_X_ATUAL) com o escolhido (COD_X_PROP):
                  'falta' → nada escolhido ainda   'igual' → escolheu o mesmo de hoje
                  'muda'  → escolheu outro
                editavel(X) diz se a lista "Vai para" está liberada (não travada pelo APEX).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* o estado de um aspecto: o que é hoje, o que foi escolhido e se muda */
  function estado(a) {
    var hoje = partes(txt(a.n + '_ATUAL_DSP')), codHoje = val('COD_' + a.n + '_ATUAL') || hoje.cod;
    var codVai = val('COD_' + a.n + '_PROP'), vai = partes(txt('COD_' + a.n + '_PROP'));
    if (!vai.cod) vai.cod = codVai;
    return { a: a, hoje: hoje, codHoje: codHoje, codVai: codVai, vai: vai,
      situacao: !codVai ? 'falta' : codHoje && String(codVai) === String(codHoje) ? 'igual' : 'muda' };
  }
  function editavel(n) {
    var i = document.getElementById(P + 'COD_' + n + '_PROP');
    return !!(i && i.type !== 'hidden' && !i.disabled && document.getElementById(P + 'COD_' + n + '_PROP_lov_btn'));
  }

  /* ═══ [J4] A ABERTURA ═══════════════════════════════════════════════════════════════════
     O QUE FAZ  No pedido novo, põe no alto "Indicar a mudança de um colaborador" e o caminho
                em 3 etapas.
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_IndMovimentacao.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarAbertura() {
    if (PEDIDO) return;
    var host = document.querySelector('.nc-stepper-host') || cont('COD_EMP_SOLICITADO').closest('.t-Region');
    if (!host) return;
    var a = el('section', 'nc-im-abertura');
    a.innerHTML = '<h1 class="nc-im-abertura-tit">Indicar a mudança de um colaborador</h1>' +
      '<p>Escolha a pessoa e diga o que muda: filial, cargo, função ou local de trabalho. O que não muda, deixe igual com um toque.</p>' +
      '<ol class="nc-im-caminho">' +
        '<li><span class="nc-im-cp-ic">' + svg(IC.lapis) + '</span><span><b>Você indica</b>quem muda e para onde</span></li>' +
        '<li><span class="nc-im-cp-ic">' + svg(IC.selo) + '</span><span><b>Quem aprova</b>autoriza o pedido</span></li>' +
        '<li><span class="nc-im-cp-ic">' + svg(IC.troca) + '</span><span><b>A mudança</b>é feita no cadastro</span></li>' +
      '</ol>';
    host.parentNode.insertBefore(a, host);
  }

  /* ═══ [J5] OS PASSOS (como nas outras requisições) ══════════════════════════════════════
     O QUE FAZ  No pedido novo, põe o número, o título e a explicação no começo de cada passo:
                1 Quem vai mudar? (a região da empresa e do colaborador) · 2 O que muda? (o
                quadro) · 3 Por que mudar? (antes do campo OBSERVACAO, que passa a se chamar
                "Motivo"). O título original da região some; o passo diz o que é.
     PODE MEXER os títulos e as explicações entre aspas.
     VISUAL     Natcorp_IndMovimentacao.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function passo(n, t, sub) {
    var h = el('div', 'nc-im-passo');
    h.innerHTML = '<span class="nc-im-passo-n">' + n + '</span><span class="nc-im-passo-txt"><span class="nc-im-passo-t">' + esc(t) + '</span>' + (sub ? '<span class="nc-im-passo-sub">' + esc(sub) + '</span>' : '') + '</span>';
    return h;
  }
  function montarPassos() {
    if (PEDIDO) return;
    var rc = cont('COD_EMP_SOLICITADO') && cont('COD_EMP_SOLICITADO').closest('.t-Region'), rq = document.querySelector('.nc-im-quadro');
    [[rc, 1, 'Quem vai mudar?', 'A empresa e o colaborador.'], [rq, 2, 'O que muda?', 'Em cada item, escolha para onde vai ou toque em "Continua igual".']].forEach(function (x) {
      var r = x[0]; if (!r || r.querySelector('.nc-im-passo')) return;
      r.classList.add('nc-im-passo-reg');
      var corpo = r.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || r;
      corpo.insertBefore(passo(x[1], x[2], x[3]), corpo.firstChild);
    });
    var lo = cont('OBSERVACAO') && cont('OBSERVACAO').closest('.row');
    if (lo && !lo.previousElementSibling.classList.contains('nc-im-passo')) {
      lo.parentNode.insertBefore(passo(3, 'Por que mudar?', 'Quem aprova decide mais rápido quando entende o motivo.'), lo);
      renomear('OBSERVACAO', 'Motivo');
    }
  }

  /* ═══ [J6] O QUADRO HOJE → VAI PARA ═════════════════════════════════════════════════════
     O QUE FAZ  montarQuadro() (uma vez):
                  • "Matrícula" vira "Colaborador"; tocar na caixa de uma lista abre a lista;
                  • cada linha do APEX com X_ATUAL_DSP e COD_X_PROP vira um cartão: ícone e nome do
                    aspecto, o selo, o botão "Continua igual", "Hoje" → seta → "Vai para";
                  • depois da última linha, o botão "Deixar igual o que não muda";
                  • em OBSERVACAO, os botões de motivo (lista MOTIVOS) e um exemplo na caixa.
                manterIgual() copia o de hoje para "Vai para", NA ORDEM DA CASCATA: o pai antes do
                filho (mudar o pai limpa o filho), esperando a página terminar entre um e outro; e
                o filho só quando o pai continua o mesmo — a lista do filho depende do pai.
                desenharQuadro() (a cada mudança): o selo (Muda / Continua igual / Falta escolher),
                o botão vira "Voltar ao de hoje" quando muda, e a nota "Como o cargo muda, escolha
                a função do novo cargo."
     PODE MEXER os textos entre aspas.
     CUIDADO    A ordem e a espera de manterIgual() existem por causa da cascata do APEX. Não
                encurte: sem a espera, o filho era preenchido e logo apagado pela página.
     VISUAL     Natcorp_IndMovimentacao.css › [C3] e [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var LINHAS = [], IGUALAR;
  function montarQuadro() {
    renomear('COD_MAT_SOLICITADO', 'Colaborador');
    ['COD_EMP_SOLICITADO', 'COD_MAT_SOLICITADO'].forEach(function (n) {
      var i = document.getElementById(P + n), b = document.getElementById(P + n + '_lov_btn');
      if (i && b && !i.__ncIM) { i.__ncIM = true; i.addEventListener('click', function () { if (!b.disabled) b.click(); }); }
    });
    var reg = null;
    ASPECTOS.forEach(function (a) {
      var ch = cont(a.n + '_ATUAL_DSP'), cv = cont('COD_' + a.n + '_PROP');
      if (!ch || !cv) return;
      var row = ch.closest('.row');
      if (!row || !row.contains(cv)) return;
      reg = reg || row.closest('.t-Region');
      row.classList.add('nc-im-linha');
      ch.closest('.col').classList.add('nc-im-hoje');
      cv.closest('.col').classList.add('nc-im-vai');
      renomear(a.n + '_ATUAL_DSP', 'Hoje');
      renomear('COD_' + a.n + '_PROP', 'Vai para');
      var cab = el('div', 'nc-im-cab');
      cab.innerHTML = '<span class="nc-im-cab-ic">' + svg(a.ic) + '</span><span class="nc-im-cab-nome">' + esc(a.rot) + '</span>' +
        '<span class="nc-im-selo" aria-live="polite"></span>' +
        '<button type="button" class="nc-im-igual" data-igual="' + a.n + '">' + svg(IC.igual) + '<span>Continua igual</span></button>';
      row.insertBefore(cab, row.firstChild);
      var seta = el('div', 'nc-im-seta', svg(IC.seta));
      ch.closest('.col').after(seta);
      /* a nota ocupa a linha toda, embaixo das duas caixas (dentro de uma coluna, desalinharia) */
      var nota = el('p', 'nc-im-nota'); row.appendChild(nota);
      LINHAS.push({ a: a, row: row, cab: cab, nota: nota });
      /* a caixa da lista abre a lista */
      var i = document.getElementById(P + 'COD_' + a.n + '_PROP'), b = document.getElementById(P + 'COD_' + a.n + '_PROP_lov_btn');
      if (i && b && !i.__ncIM) { i.__ncIM = true; i.addEventListener('click', function () { if (!b.disabled) b.click(); }); }
    });
    if (!reg || !LINHAS.length) return;
    reg.classList.add('nc-im-quadro');
    /* "Deixar igual o que não muda": depois da última linha */
    var ult = LINHAS[LINHAS.length - 1].row;
    IGUALAR = el('div', 'nc-im-igualar');
    IGUALAR.innerHTML = '<button type="button" class="nc-im-bt nc-im-bt--claro" data-igualar="1">' + svg(IC.igual) + '<span>Deixar igual o que não muda</span></button><span class="nc-im-igualar-txt"></span>';
    ult.after(IGUALAR);
    reg.addEventListener('click', function (e) {
      var b = e.target.closest('[data-igual]');
      if (b) {
        /* num pai (Filial, Cargo), o filho vazio também volta ao de hoje: a cascata o limpa */
        var n = b.getAttribute('data-igual');
        manterIgual([n].concat(ASPECTOS.filter(function (x) { return x.pai === n && estado(x).situacao !== 'muda'; }).map(function (x) { return x.n; })));
        return;
      }
      if (e.target.closest('[data-igualar]')) manterIgual(LINHAS.filter(function (l) { return estado(l.a).situacao === 'falta'; }).map(function (l) { return l.a.n; }));
    });
    /* 4. o motivo */
    var co = cont('OBSERVACAO');
    if (co) {
      var ic = co.querySelector('.t-Form-inputContainer');
      var mot = el('div', 'nc-im-motivos');
      mot.setAttribute('role', 'group');
      mot.setAttribute('aria-label', 'Começar o motivo');
      mot.innerHTML = MOTIVOS.map(function (m) { return '<button type="button" class="nc-im-atalho" data-m="' + esc(m) + '">' + esc(m) + '</button>'; }).join('');
      if (ic) ic.insertBefore(mot, ic.firstChild);
      mot.addEventListener('click', function (e) {
        var b = e.target.closest('[data-m]'); if (!b) return;
        var t = document.getElementById(P + 'OBSERVACAO'); if (!t || t.readOnly || t.disabled) return;
        var atual = t.value.trim(), m = b.getAttribute('data-m');
        if (atual.indexOf(m) < 0) apex.item(t.id).setValue(atual ? atual.replace(/[.\s]*$/, '') + '. ' + m : m);
        t.focus(); t.setSelectionRange(t.value.length, t.value.length);
        agendar();
      });
      var t = document.getElementById(P + 'OBSERVACAO');
      if (t && !t.getAttribute('placeholder')) t.setAttribute('placeholder', 'Ex.: vai assumir a supervisão da loja 20 a partir de novembro.');
    }
  }
  /* copia o de hoje para "vai para", na ordem da cascata: o pai antes do filho (mudar o pai limpa o
     filho), e o filho só quando o pai continua o mesmo — a lista do filho depende do pai */
  function manterIgual(nomes) {
    var fila = [];
    ASPECTOS.forEach(function (a) {
      if (nomes.indexOf(a.n) < 0) return;
      if (a.pai) {
        var ep = estado(ASPECTOS.filter(function (x) { return x.n === a.pai; })[0]);
        if (ep.situacao === 'muda' && nomes.indexOf(a.pai) < 0) return;   /* pai mudou (e fica): o filho vem da lista nova */
        if ((ep.situacao === 'falta' || nomes.indexOf(a.pai) >= 0) && fila.indexOf(a.pai) < 0) fila.push(a.pai);
      }
      if (fila.indexOf(a.n) < 0) fila.push(a.n);
    });
    /* pais primeiro */
    fila.sort(function (x, y) { var px = ASPECTOS.filter(function (a) { return a.n === x; })[0].pai ? 1 : 0, py = ASPECTOS.filter(function (a) { return a.n === y; })[0].pai ? 1 : 0; return px - py; });
    (function proximo() {
      var n = fila.shift(); if (!n) { agendar(); return; }
      var a = ASPECTOS.filter(function (x) { return x.n === n; })[0], e = estado(a);
      if (!e.codHoje || !editavel(n)) { proximo(); return; }
      var mostra = a.formato === 'nome (cod)' ? e.hoje.nome + ' (' + e.codHoje + ')' : txt(n + '_ATUAL_DSP');
      apex.item(P + 'COD_' + n + '_PROP').setValue(e.codHoje, mostra);
      esperarPagina(proximo);
    })();
  }
  function desenharQuadro() {
    var pessoa = !!val('COD_MAT_SOLICITADO');
    LINHAS.forEach(function (l) {
      var e = estado(l.a), pode = editavel(l.a.n) && !LEITURA;
      classe(l.row, 'is-muda', e.situacao === 'muda');
      classe(l.row, 'is-igual', e.situacao === 'igual');
      classe(l.row, 'is-falta', e.situacao === 'falta');
      html(l.cab.querySelector('.nc-im-selo'), e.situacao === 'muda' ? svg(IC.troca) + 'Muda' : e.situacao === 'igual' ? svg(IC.igual) + 'Continua igual' : pessoa ? 'Falta escolher' : '');
      var b = l.cab.querySelector('.nc-im-igual');
      var pai = l.a.pai && estado(ASPECTOS.filter(function (x) { return x.n === l.a.pai; })[0]);
      b.hidden = !pode || !pessoa || !e.codHoje || e.situacao === 'igual' || (pai && pai.situacao === 'muda');
      html(b.querySelector('span'), e.situacao === 'muda' ? 'Voltar ao de hoje' : 'Continua igual');
      html(l.nota, pode && pai && pai.situacao === 'muda' && e.situacao !== 'muda'
        ? 'Como o ' + (l.a.pai === 'CARGO' ? 'cargo' : 'a filial') + ' muda, escolha ' + (l.a.pai === 'CARGO' ? 'a função do novo cargo.' : 'o local da nova filial.') : '');
      var hojeC = cont(l.a.n + '_ATUAL_DSP'), vazio = hojeC && !txt(l.a.n + '_ATUAL_DSP');
      classe(hojeC, 'nc-im-sem-hoje', vazio);
    });
    if (IGUALAR) {
      /* só conta o que o botão preenche: o filho de um pai que muda vem da lista nova */
      var faltam = LINHAS.filter(function (l) {
        if (estado(l.a).situacao !== 'falta' || !editavel(l.a.n) || !estado(l.a).codHoje) return false;
        var pai = l.a.pai && estado(ASPECTOS.filter(function (x) { return x.n === l.a.pai; })[0]);
        return !(pai && pai.situacao === 'muda');
      }).length;
      IGUALAR.hidden = LEITURA || !pessoa || !faltam;
      html(IGUALAR.querySelector('.nc-im-igualar-txt'), faltam ? 'Preenche ' + (faltam === 1 ? 'a linha vazia' : 'as ' + faltam + ' linhas vazias') + ' com o que é hoje.' : '');
    }
    var q = document.querySelector('.nc-im-quadro');
    classe(q, 'nc-im-sem-pessoa', !pessoa);
  }

  /* ═══ [J7] A BARRA DO PÉ ════════════════════════════════════════════════════════════════
     O QUE FAZ  Uma barra fixa no pé da tela: a frase ("Tony muda de cargo e função"), "Falta: …"
                (tocar leva ao campo e abre a lista — também no modo Etapas, onde ela muda para a
                etapa certa antes) e "Enviar pedido", que clica o botão "Criar" da página. Se nada
                muda: "Nada muda: tudo está igual a hoje."
     COMO SABE O QUE FALTA  Empresa, colaborador e cada aspecto ainda em 'falta' ([J3]).
     PODE MEXER os textos entre aspas.
     IMPORTANTE Isso só AVISA. Quem impede o envio sem um campo é a validação do APEX.
     VISUAL     Natcorp_IndMovimentacao.css › [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var BARRA;
  function frase() {
    var nome = partes(txt('COD_MAT_SOLICITADO')).nome;
    var mud = LINHAS.map(function (l) { return estado(l.a); }).filter(function (e) { return e.situacao === 'muda'; });
    if (!nome) return '';
    if (!mud.length) return '<b>' + esc(nome.split(' ')[0]) + '</b>: escolha o que muda';
    return '<b>' + esc(nome.split(' ')[0]) + '</b> muda de ' + mud.map(function (e) { return '<b>' + esc(e.a.rot.toLowerCase()) + '</b>'; }).join(', ').replace(/, ([^,]*)$/, ' e $1');
  }
  function montarBarra() {
    CRIAR = botaoPorTexto(/^criar$/i);
    rotuloBotao(CRIAR, 'Enviar pedido');
    if (!CRIAR) return;
    BARRA = el('div', 'nc-im-barra');
    BARRA.setAttribute('role', 'region');
    BARRA.setAttribute('aria-label', 'Resumo do pedido');
    BARRA.innerHTML = '<div class="nc-im-barra-txt" aria-live="polite"></div><button type="button" class="nc-im-bt nc-im-bt--forte" data-acao="enviar">' + svg(IC.seta) + '<span>Enviar pedido</span></button>';
    document.body.appendChild(BARRA);
    document.body.classList.add('nc-im-com-barra');
    BARRA.addEventListener('click', function (e) {
      if (e.target.closest('[data-acao="enviar"]')) { CRIAR.click(); return; }
      var ir = e.target.closest('[data-ir]'); if (!ir) return;
      var c = cont(ir.getAttribute('data-ir')); if (!c) return;
      irPara(c);
    });
  }
  function irPara(c) {
    if (!aVista(c)) {
      var sec = c.closest('.nc-section'), host = document.querySelector('.nc-stepper-host');
      var secs = host ? [].slice.call(host.querySelectorAll('.nc-section')).filter(function (s) { return !s.parentElement.closest('.nc-section'); }) : [];
      var i = secs.indexOf(sec), item = i >= 0 && document.querySelector('.nc-stepper__item[data-index="' + i + '"]');
      if (item) item.click();
    }
    setTimeout(function () {
      c.scrollIntoView({ behavior: 'smooth', block: 'center' });
      var b = c.querySelector('.a-Button--popupLOV'), f = c.querySelector('select, textarea');
      setTimeout(function () { if (b) b.click(); else if (f) f.focus(); }, 400);
    }, 60);
  }
  function desenharBarra() {
    if (!BARRA) return;
    var f = [];
    if (!val('COD_EMP_SOLICITADO')) f.push(['COD_EMP_SOLICITADO', 'Empresa']);
    if (!val('COD_MAT_SOLICITADO')) f.push(['COD_MAT_SOLICITADO', 'Colaborador']);
    else LINHAS.forEach(function (l) { if (estado(l.a).situacao === 'falta') f.push(['COD_' + l.a.n + '_PROP', l.a.rot]); });
    var nada = val('COD_MAT_SOLICITADO') && !LINHAS.some(function (l) { return estado(l.a).situacao === 'muda'; }) && !f.length;
    html(BARRA.querySelector('.nc-im-barra-txt'), (frase() && !nada ? '<p class="nc-im-frase">' + frase() + '</p>' : '') +
      (f.length ? '<div class="nc-im-falta-lista"><span class="nc-im-barra-rot">Falta:</span>' + f.map(function (x) { return '<button type="button" class="nc-im-falta" data-ir="' + x[0] + '">' + esc(x[1]) + '</button>'; }).join('') + '</div>'
        : nada ? '<p class="nc-im-aviso">Nada muda: tudo está igual a hoje.</p>' : '<span class="nc-im-barra-ok">' + svg(IC.ok) + 'Tudo certo. Pode enviar.</span>'));
  }

  /* ═══ [J8] O PEDIDO GRAVADO ═════════════════════════════════════════════════════════════
     O QUE FAZ  No pedido já gravado, monta o cabeçalho no alto: "Pedido nº …", a situação em
                etiqueta colorida, o colaborador (código - nome), a empresa, cada mudança
                de → para (o de hoje riscado), o que continua igual, o motivo e "Pedido em … por …".
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_IndMovimentacao.css › [C6] e [C8] (a cor final: [C12])
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var HERO;
  function montarPedido() {
    if (!PEDIDO) return;
    var host = document.querySelector('.nc-stepper-host') || cont('COD_EMP_SOLICITADO').closest('.t-Region');
    if (!host) return;
    HERO = el('section', 'nc-im-hero');
    host.parentNode.insertBefore(HERO, host);
  }
  function desenharPedido() {
    if (!HERO) return;
    var sit = txt('COD_SIT_REQ');
    var tom = /aprov|conclu/i.test(sit) ? 'bom' : /reprov/i.test(sit) ? 'ruim' : /cancel|suspens/i.test(sit) ? 'neutro' : 'espera';
    var pessoa = partes(txt('COD_MAT_SOLICITADO'));
    var es = LINHAS.map(function (l) { return estado(l.a); });
    var mud = es.filter(function (e) { return e.situacao === 'muda'; }), igual = es.filter(function (e) { return e.situacao === 'igual'; });
    var sol = txt('SOLICITANTE').split(/\s*\/\s*/), quem = sol[1] ? comCodigo(partes(sol[1])) : '', cargoQuem = sol[2] ? comCodigo(partes(sol[2])) : '';
    var empresa = comCodigo(partes(txt('COD_EMP_SOLICITADO')));
    html(HERO, '<div class="nc-im-hero-topo"><p class="nc-im-hero-n">Pedido nº <b>' + esc(val('COD_REQUISICAO')) + '</b></p>' +
      (sit ? '<span class="nc-im-sit nc-im-sit--' + tom + '">' + esc(bonito(sit)) + '</span>' : '') + '</div>' +
      '<h2 class="nc-im-hero-tit">' + svg(IC.pessoa) + '<span>' + esc(comCodigo(pessoa) || 'Colaborador') + '</span></h2>' +
      (empresa ? '<p class="nc-im-hero-emp">' + svg(IC.predio) + '<span>Empresa <b>' + esc(empresa) + '</b></span></p>' : '') +
      (mud.length ? '<ul class="nc-im-hero-mudas">' + mud.map(function (e) {
        return '<li><span class="nc-im-hero-rot">' + svg(e.a.ic) + esc(e.a.rot) + '</span><span class="nc-im-hero-de">' + esc(comCodigo(e.hoje) || '—') + '</span>' + svg(IC.seta, 'nc-im-ic nc-im-hero-seta') + '<span class="nc-im-hero-para">' + esc(comCodigo(e.vai) || '—') + '</span></li>';
      }).join('') + '</ul>' : '<p class="nc-im-hero-linha">Nenhuma mudança: tudo continua igual a hoje.</p>') +
      (igual.length ? '<p class="nc-im-hero-igual">Continua igual: ' + igual.map(function (e) { return esc(e.a.rot) + ' <b>' + esc(comCodigo(e.hoje)) + '</b>'; }).join(' · ') + '</p>' : '') +
      (txt('OBSERVACAO') ? '<blockquote class="nc-im-hero-motivo">' + svg(IC.fala) + '<span>' + esc(txt('OBSERVACAO')) + '</span></blockquote>' : '') +
      '<p class="nc-im-hero-quem">Pedido em <b>' + esc(val('DT_REQUISICAO')) + '</b>' + (quem ? ' por <b>' + esc(quem) + '</b>' + (cargoQuem ? ' · ' + esc(cargoQuem) : '') : '') + '</p>');
  }

  /* ═══ [J9] O CAMINHO DA APROVAÇÃO (o mesmo das outras requisições) ══════════════════════
     O QUE FAZ  A região dos aprovadores sai da coluna estreita da direita e vai para logo abaixo
                do cabeçalho, na largura toda (a coluna vazia some). Vira uma faixa: "1 de 2 ·
                aguardando Fulano", os aprovadores em linha (aprovou / reprovou / é a vez / na fila)
                e o que cada um escreveu. Para quem aprova, com uma etapa pendente, os botões
                Aprovar/Reprovar do APEX vêm para dentro da faixa ("é a sua vez").
     LÊ DE      as colunas do relatório de aprovadores: APROVADOR, STATUS, DATA, JUSTIFICATIVA.
     CUIDADO    Se essas colunas forem renomeadas no relatório do APEX, a faixa não acha os dados.
     PODE MEXER os textos entre aspas: 'Aprovação', 'Ver o caminho', 'Sua vez', 'Na fila',
                'Confira a mudança e decida.'…
     VISUAL     Natcorp_IndMovimentacao.css › [C9]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var AP = null, AP_ABERTO = false, AP_ASSIN = '';
  function nomeAprovador(t) { var m = /^\s*\d+\s*-\s*\d+\s*-\s*(.+)$/.exec(t || ''); return bonito(m ? m[1] : t).replace(/(^|\s)(\S)/g, function (x, a, b) { return a + b.toUpperCase(); }).replace(/\s(De|Da|Do|Das|Dos|E)(?=\s)/g, function (x) { return x.toLowerCase(); }); }
  function montarAprovacao() {
    if (!PEDIDO) return;
    if (!AP) {
      var th = document.querySelector('table.t-Report-report th#APROVADOR, td[headers="APROVADOR"]');
      var reg = th && th.closest('.t-Region');
      if (!reg) return;
      AP = { reg: reg, botoes: [].slice.call(document.querySelectorAll('button.t-Button, a.t-Button')).filter(function (b) { return /^(aprovar|reprovar)$/i.test(b.textContent.trim()); }) };
      reg.classList.add('nc-im-aprov');
      /* como nas outras requisições: a aprovação logo abaixo do cabeçalho, na largura toda
         (a página a põe numa coluna estreita à direita) */
      if (HERO) {
        var colV = reg.closest('.col'), colH = HERO.closest('.col');
        HERO.after(reg);
        if (colH) colH.classList.add('nc-im-col-cheia');
        if (colV && colV !== colH && !colV.querySelector('.t-Region')) colV.classList.add('nc-im-col-vazia');
      }
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
      AP.box = el('div', 'nc-im-ap');
      corpo.insertBefore(AP.box, corpo.firstChild);
      AP.box.addEventListener('click', function (e) { if (e.target.closest('.nc-im-ap-ver')) { AP_ABERTO = !AP_ABERTO; AP_ASSIN = ''; agendar(); } });
    }
    var passos = [].slice.call(AP.reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; }
      var st = c('STATUS');
      return { nome: nomeAprovador(c('APROVADOR')), data: c('DATA'), just: c('JUSTIFICATIVA'), estado: /^r$|reprov|recus/i.test(st) ? 'nao' : /^a$|aprov/i.test(st) ? 'ok' : 'pend' };
    }).filter(function (x) { return x.nome; });
    var n = passos.length;
    classe(AP.reg, 'nc-im-aprov--vazio', !n);
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; }), atual = -1;
    if (!reprovado) for (var i = 0; i < n; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var aprovados = passos.filter(function (x) { return x.estado === 'ok'; }).length;
    var cancelado = /cancel|suspens/i.test(txt('COD_SIT_REQ'));
    var bts = AP.botoes.filter(function (b) { return b.style.display !== 'none'; }), vez = bts.length > 0 && !cancelado && atual >= 0;   /* só há o que decidir com uma etapa pendente */
    var assin = JSON.stringify([passos, atual, bts.length, cancelado, AP_ABERTO]);
    if (assin === AP_ASSIN) return;
    AP_ASSIN = assin;
    if (!n) { AP.box.innerHTML = ''; return; }
    var quemNao = passos.filter(function (x) { return x.estado === 'nao'; })[0];
    var estado = reprovado ? 'nao' : cancelado ? 'neutro' : atual < 0 ? 'ok' : vez ? 'vez' : 'pend';
    var resumo = reprovado ? '<b>Reprovado</b> por ' + esc(quemNao.nome) : cancelado ? '<b>Pedido cancelado</b> · ' + aprovados + ' de ' + n + ' aprovaram'
      : atual < 0 ? '<b>Aprovado</b> por ' + (n === 1 ? esc(passos[0].nome) : 'todos') : vez ? '<b>' + aprovados + ' de ' + n + '</b> · <b>é a sua vez</b>'
      : '<b>' + aprovados + ' de ' + n + '</b> · aguardando <b>' + esc(passos[atual].nome) + '</b>';
    classe(AP.reg, 'nc-im-ap-aberto', AP_ABERTO);
    AP.box.className = 'nc-im-ap nc-im-ap--' + estado;
    AP.box.innerHTML = '<p class="nc-im-ap-rot">Aprovação</p><div class="nc-im-ap-cab"><p class="nc-im-ap-resumo">' + resumo + '</p>' +
        '<button type="button" class="nc-im-ap-ver" aria-expanded="' + AP_ABERTO + '">' + (AP_ABERTO ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
      '<ol class="nc-im-ap-passos">' + passos.map(function (x, i) {
        var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === atual && !cancelado ? 'is-vez' : 'is-fila';
        var dia = x.data.replace(/\s.*$/, '');
        var st = x.estado === 'ok' ? (dia || 'Aprovou') : x.estado === 'nao' ? 'Reprovou' + (dia ? ' · ' + dia : '') : cls === 'is-vez' ? (vez ? 'Sua vez' : 'Aguardando') : 'Na fila';
        var ic = x.estado === 'ok' ? '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>' : x.estado === 'nao' ? '<path d="M8 8l8 8M16 8l-8 8"/>' : cls === 'is-vez' ? '<path d="M12 8v4l2.5 1.5"/>' : '';
        return '<li class="nc-im-ap-p ' + cls + '" title="' + esc(x.nome + (x.just ? ': "' + x.just + '"' : '')) + '"><span class="nc-im-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
          '<span class="nc-im-ap-texto"><span class="nc-im-ap-nome">' + esc(x.nome) + '</span><span class="nc-im-ap-estado">' + esc(st) + '</span></span></li>';
      }).join('') + '</ol>' +
      (vez ? '<div class="nc-im-decisao"><p class="nc-im-decisao-txt">Confira a mudança e decida.</p><div class="nc-im-decisao-botoes"></div></div>' : '') +
      (passos.some(function (x) { return x.just; }) ? '<div class="nc-im-ap-justs">' + passos.filter(function (x) { return x.just; }).map(function (x) {
        return '<blockquote class="nc-im-ap-just' + (x.estado === 'nao' ? ' is-nao' : '') + '"><b>' + esc(x.nome) + ':</b> ' + esc(x.just) + '</blockquote>'; }).join('') + '</div>' : '');
    var dest = AP.box.querySelector('.nc-im-decisao-botoes');
    if (dest) bts.slice().sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) { b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-im-reprovar' : 'nc-im-aprovar'); dest.appendChild(b); });
  }


  /* ═══ [J10] REGIÕES VAZIAS ══════════════════════════════════════════════════════════════
     O QUE FAZ  Dentro do seletor "Página única / Etapas", recolhe a região que não tem nada à
                vista, para não deixar um vão. Volta sozinha se uma ação dinâmica mostrar algo
                dentro dela.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* uma região que só guarda outra que a página esconde (Identificação, no pedido novo) deixava um
     vão: recolhida enquanto não tem nada à vista (volta sozinha se uma ação mostrar o de dentro) */
  function recolherVazias() {
    var host = document.querySelector('.nc-stepper-host'); if (!host) return;
    /* duas passadas: primeiro tudo à vista (uma recolhida esconderia as de dentro), depois recolhe */
    var regs = [].filter.call(host.querySelectorAll('.t-Region'), function (r) { return !r.classList.contains('nc-im-quadro') && !r.classList.contains('nc-im-passo-reg'); });
    regs.forEach(function (r) { classe(r, 'nc-im-recolhida', false); });
    regs.map(function (r) {
      var dentro = r.querySelectorAll('.t-Region, .t-Form-fieldContainer');
      return [r, dentro.length > 0 && ![].some.call(dentro, aVista)];
    }).forEach(function (x) { classe(x[0], 'nc-im-recolhida', x[1]); });
  }

  /* ═══ [J11] O MAESTRO: QUANDO CADA PARTE É MONTADA ══════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez, quando a página abre: monta a abertura, o pedido gravado,
                o quadro, os passos e a barra. atualizar() redesenha o que depende dos valores
                (quadro, regiões vazias, barra, cabeçalho, aprovação) sempre que algo muda: um
                campo é alterado, uma região é atualizada, uma janela fecha, a pessoa troca de
                etapa ou de modo (Página única / Etapas), uma ação dinâmica traz valores do servidor.
     CUIDADO    Não mude a ordem das chamadas em iniciar(): os passos procuram o quadro, que
                precisa existir antes.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T;
  function agendar() { clearTimeout(T); T = setTimeout(atualizar, 60); }
  function atualizar() {
    LEITURA = PEDIDO && !LINHAS.some(function (l) { return editavel(l.a.n); });
    classe(document.body, 'nc-im-leitura', LEITURA);
    desenharQuadro();
    recolherVazias();
    desenharBarra();
    desenharPedido();
    montarAprovacao();
  }
  function iniciar() {
    document.body.classList.add('nc-im', PEDIDO ? 'nc-im-modo-pedido' : 'nc-im-modo-novo');
    montarAbertura();
    montarPedido();
    montarQuadro();
    montarPassos();
    montarBarra();
    atualizar();
    $(document).on('change', 'input, select, textarea', agendar);
    $(document).on('apexafterrefresh apexafterclosedialog', agendar);
    $(document).on('click', '.nc-stepper__item, .nc-viewtoggle button', function () { setTimeout(agendar, 50); });
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    setTimeout(atualizar, 700);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
