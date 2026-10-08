/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · TREINAMENTO  —  o "arrumador" da tela (JavaScript)                             ║
   ║  App 200 · Página 118  Requisição de Treinamento (inscrever um colaborador numa turma)    ║
   ║  App 200 · Página 120  Requisição de Curso (pedir um curso novo)                          ║
   ║  App 200 · Página 126  Indicação de Curso (indicar um colaborador para um curso)          ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns. Guia: brand/apex/app/TREINAMENTO-MANUTENCAO.md

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quando a página abre, ele REORGANIZA o que o APEX já desenhou em UMA PERGUNTA POR VEZ, com
   números, para gestores com pouca familiaridade com sistemas (muitas vezes no celular):
     Página 118   ① Quem vai participar?   empresa, colaborador, origem do pedido
                  ② Qual treinamento?      curso e turma + o CARTÃO DA TURMA
                  ③ Recado para o RH       a Observação (opcional)
     Página 120   ① Qual curso você precisa?  nome + o tipo em botões grandes
                  ② Conte mais sobre o curso  a Observação (opcional)
                  "Quem está pedindo"         o próprio gestor, depois do curso, sem número
     Página 126   ① Quem você está indicando?
                  ② Para qual curso?        "Um curso que já existe" / "Um curso novo"
                  ③ Por que você está indicando?   ④ Quem oferece o curso (curso novo)
   Em todas: o alto com título, nº e situação; a faixa da aprovação; e a barra do rodapé com
   o que falta preencher ("Criar" aparece como "Enviar pedido" / "Enviar indicação").
   Pedido já gravado (tudo travado pela página): os campos viram um cartão de leitura.

   O que a página faz sozinha (e o desenho só MOSTRA): na 118, o gestor escolhe quem, o curso e
   a turma; a turma traz, do servidor, o tipo, quem dá o treinamento, as datas, o horário e o
   local — e esses campos ficam travados. Por isso eles saem da forma de "caixa para
   preencher" e viram o cartão da turma. Campo travado só sai da vista enquanto não tem erro:
   se o servidor reclamar dele, ele volta.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: isso continua sendo do APEX.
     • Não trava nem libera campos: quem trava é a página (ações "Disable Column").
     • Os botões e listas continuam os do APEX: os cartões e botões grandes só escolhem na
       lista de verdade (apex.item().setValue), e as ações dinâmicas disparam como sempre.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e
       continua funcionando normalmente.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Páginas 118, 120 e 126 › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_Treinamento.js
     Páginas 118, 120 e 126 › CSS › File URLs:         #WORKSPACE_IMAGES#Natcorp_Treinamento.css
     ATENÇÃO: o MESMO arquivo serve às três páginas. Ao mudar algo, confira as três.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Classes postas nas regiões (Page Designer › clique na região › Appearance › CSS Classes;
   aplicadas pelos aplicar-treinamento-pagina118/120/126.py):
     nc-tre-solicitacao  a região do título (nº, data, situação, solicitante)  → vai para o alto
     nc-tre-aprovadores  Aprovadores                    → a faixa do caminho da aprovação
     nc-tre-colaborador  118: Colaborador Solicitado (①) · 120: Solicitante ("Quem está pedindo")
                         · 126: Solicitado (①)
     nc-tre-turma        118: Turma (② e ③)
     nc-tre-curso        120: Curso (① e ②) · 126: Curso (② a ④)
     nc-tre-acoes        Botões (Voltar / Criar / Salvar) → a barra do rodapé
   Como o arquivo sabe em que página está: 120 pelo NÚMERO da página; 126 pelos ITENS
   (…_MOTIVO_INDICACAO e …_CURSO_EXISTENTE existem); o resto é tratado como 118.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J0]  Começo: qual página, qual prefixo ...... P118_, P120_ ou P126_           CUIDADO
     [J1]  Ícones ................................. os desenhos pequenos (não precisa mexer)
     [J2]  Ferramentas ............................ funções pequenas usadas no arquivo todo
     [J3]  Página 118: as perguntas ① ② ③ ......... títulos, rótulos e dicas        PODE MEXER
     [J4]  O alto ................................. título, nº, data, situação        PODE MEXER
     [J5]  Página 118: o cartão da turma .......... datas, horário, local           PODE MEXER
     [J6]  Página 120: o pedido de curso novo ..... nome, tipo em botões, cartão     PODE MEXER
     [J7]  Página 126: a indicação ................ curso existente ou novo, motivo  PODE MEXER
     [J8]  A faixa da aprovação ................... quem aprovou, quem falta, Aprovar/Reprovar
     [J9]  A barra do rodapé ...................... o que falta, "Enviar pedido"      PODE MEXER
     [J10] O maestro .............................. decide QUANDO cada parte é montada  CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela (título de pergunta, dica, rótulo)
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Qual treinamento?'  →  'Qual curso?'
     Quero que a barra do rodapé cobre mais um campo no "Falta"
       → ligue "Value Required" do item no APEX, ou acrescente o nome dele (sem o P118_) na
         lista PEDE de [J9].
     A turma passou a trazer mais um dado e ele não aparece no cartão
       → [J5]: acrescente o nome do item em DA_TURMA ([J0]) e uma linha em montarCartao.
     Quero mudar o texto "Enviar pedido" do botão Criar → [J9].
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp treinamento].
         O manual, parte 5, explica o que fazer com a mensagem.

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
     P + 'COD_TURMA'        junta os textos: vira 'P118_COD_TURMA', o nome do item no APEX.
     texto(…) / valor(…)    leem o que está num item do APEX (veja [J2]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* ═══ [J0] COMEÇO: QUAL PÁGINA, QUAL PREFIXO ═════════════════════════════════════════════
     O QUE FAZ  Descobre o número da página e monta o começo do nome dos itens: P = 'P118_',
                'P120_' ou 'P126_'. Por isso o número da página não está escrito no arquivo.
                CURSO = é a página 120 (pedido de curso novo).
                IND   = é a indicação (126), reconhecida pelos ITENS, não pelo número: assim
                        funciona também numa cópia da página com outro número.
     DA_TURMA   (logo abaixo) os itens que a TURMA preenche e a página trava na 118. Eles saem
                da vista e aparecem no cartão da turma ([J5]).
     CUIDADO    A primeira linha impede que o arquivo rode duas vezes e que rode fora do APEX.
                Não apague.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncTreinamento || !window.apex || !window.apex.jQuery) return;
  /* o número da página só dá o prefixo dos itens (P118_… ou P120_…) */
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  window.__ncTreinamento = true;

  var $ = apex.jQuery;
  var P = 'P' + pag + '_';
  /* a mesma folha serve às duas páginas do módulo: 118 inscreve alguém numa turma; 120 pede um
     curso novo (nome, tipo e descrição), com quem pede já preenchido (o próprio gestor) */
  var CURSO = pag === '120';
  /* a indicação (p126 nesta cópia): o gestor indica alguém para um curso */
  var IND = !!document.getElementById(P + 'MOTIVO_INDICACAO_CONTAINER') && !!document.getElementById(P + 'CURSO_EXISTENTE_CONTAINER');
  if (IND) CURSO = false;
  var ILU = /*@@ILUSTRACOES@@*/ {};

  /* CUIDADO: nomes dos itens SEM o "P118_". Item que entra aqui sai da vista quando travado. */
  /* os campos que a turma preenche (e a página trava): viram o cartão */
  var DA_TURMA = ['COD_TIPO', 'COD_ENTIDADE', 'DATA_INICIO', 'DATA_FIM', 'HORA_INICIO', 'HORA_FIM', 'LOCAL'];
  /* ═══ [J1] ÍCONES ════════════════════════════════════════════════════════════════════════
     Os desenhos pequenos da tela, no formato SVG. Não precisa mexer.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var IC = {
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    livro: '<path d="M4 5.5A1.5 1.5 0 0 1 5.5 4H11v15H5.5A1.5 1.5 0 0 0 4 20.5z"/><path d="M20 5.5A1.5 1.5 0 0 0 18.5 4H13v15h5.5a1.5 1.5 0 0 1 1.5 1.5z"/>',
    recado: '<path d="M4.5 5h15A1.5 1.5 0 0 1 21 6.5v9a1.5 1.5 0 0 1-1.5 1.5H9l-4.5 3.5V17h0A1.5 1.5 0 0 1 3 15.5v-9A1.5 1.5 0 0 1 4.5 5z"/><path d="M8 10h8M8 13h5"/>',
    calendario: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    etiqueta: '<path d="M3.5 12.5V4.5a1 1 0 0 1 1-1h8l8 8-9 9z"/><circle cx="8" cy="8" r="1.5"/>',
    escola: '<path d="M2.5 9L12 4.5 21.5 9 12 13.5z"/><path d="M6.5 11v4.5c1.5 1.3 3.5 2 5.5 2s4-.7 5.5-2V11"/>',
    local: '<path d="M12 21s-6.5-5.6-6.5-11a6.5 6.5 0 0 1 13 0c0 5.4-6.5 11-6.5 11z"/><circle cx="12" cy="10" r="2.5"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    cadeado: '<rect x="5" y="10.5" width="14" height="10" rx="2"/><path d="M8 10.5V8a4 4 0 0 1 8 0v2.5"/>'
  };

  /* ═══ [J2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       texto(P + 'ITEM')   o que a PESSOA VÊ no item (o nome da opção escolhida numa lista)
       valor(P + 'ITEM')   o que o APEX GUARDA no item (o código da opção)
       travado(P + 'ITEM') o APEX travou o item? (desabilitado ou só leitura)
       comErro(caixa)      o servidor marcou erro neste campo?
       porClasse('x')      as regiões que têm a classe x no APEX
       bonito('CURSO DE EXCEL') → "Curso de Excel"
     QUANDO MEXER  Quase nunca.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function vazio(t) { return !t || /^\s*(-\s*selecione\s*-|-)\s*$/i.test(t); }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim(); }
  function maiusculas(t) { return t.length > 3 && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t); }
  function capitalizar(t) { return String(t || '').toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); }); }
  function bonito(t) { t = String(t || '').trim(); if (maiusculas(t)) t = capitalizar(t); return t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em|Ao|Para)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); }); }
  function valor(id) { var it = apex.item(id); return it && it.node ? String(it.getValue() || '') : ''; }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-tre-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function porClasse(cls) { return [].slice.call(document.querySelectorAll('.t-Region.' + cls + ', .t-ButtonRegion.' + cls)); }
  function corpoDe(reg) { return reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg; }
  function escondido(e, ate) { for (; e && e !== ate && e !== document.body; e = e.parentElement) if (e.style && e.style.display === 'none' || e.hidden) return true; return false; }
  function texto(id) {
    var e = document.getElementById(id);
    if (!e) return '';
    if (e.tagName === 'SELECT') { var o = e.options[e.selectedIndex]; return o && o.value !== '' && !vazio(o.text) ? o.text.trim() : ''; }
    var v = String(e.value || '').trim();
    return vazio(v) ? '' : v;
  }
  function travado(id) {
    var c = document.getElementById(id + '_CONTAINER'), e = document.getElementById(id);
    if (!e) return true;
    if (c && c.classList.contains('apex-item-wrapper--popup-lov')) return !!(e.disabled || e.classList.contains('apex_disabled'));
    return !!(e.disabled || e.classList.contains('apex_disabled') || e.readOnly && e.tagName !== 'SELECT');
  }
  function comErro(c) { return !!(c && (c.classList.contains('is-error') || c.querySelector('.apex-page-item-error, .a-Form-error:not(:empty)'))); }
  function rotulo(c) { var l = c && c.querySelector('.t-Form-label'); if (!l) return ''; var k = l.cloneNode(true); [].forEach.call(k.querySelectorAll('.u-VisuallyHidden'), function (x) { x.remove(); }); return k.textContent.replace(/\s+/g, ' ').trim(); }
  function dataBR(t) { var m = String(t || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }

  /* ═══ [J3] PÁGINA 118: AS PERGUNTAS ① ② ③ (montagem, uma vez) ═══════════════════════════
     O QUE FAZ  montar() decide o que montar conforme a página (120 → [J6]; 126 → [J7]; o resto
                → a 118, aqui). Na 118:
                • criarTopo: cria o alto e traz para ele a Situação e o botão de ver quem pediu;
                  a região nc-tre-solicitacao sai da vista;
                • passo(): o título da região vira a pergunta, com o número na bolinha e uma
                  frase de explicação embaixo;
                • ① os campos Empresa, Colaborador e Origem ganham rótulo em cima, nome novo e
                  dica; ② o cartão da turma entra logo depois de Curso/Turma; ③ a Observação
                  ganha o bloco "Recado para o RH".
     PODE MEXER • os títulos e explicações das perguntas: passo(região, número, 'Título',
                  'Explicação') — troque só os dois textos;
                • a lista dos campos de ①: [item, largura, largura no meio, 'Rótulo novo',
                  'Dica embaixo'] — troque só os dois textos (rótulo e dica). A dica pode ficar
                  vazia: ''. As larguras são em doze avos (12 = linha toda).
                • os textos do "Recado para o RH".
     CUIDADO    renomear() troca só o texto VISÍVEL do rótulo; o rótulo do APEX continua o
                mesmo (e o "Valor Necessário" lido pelo leitor de tela fica).
     VISUAL     Natcorp_Treinamento.css › [C3], [C4] e [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var TOPO = null, COLAB = null, TURMA = null, CARTAO = null, RECADO = null, QUEM = null;
  /* troca só o texto visível do rótulo; o "(Valor Necessário)" do leitor de tela fica */
  function renomear(c, novo) {
    var l = c.querySelector('.t-Form-label'); if (!l || l.dataset.ncOriginal) return;
    l.dataset.ncOriginal = l.textContent;
    [].forEach.call(l.childNodes, function (n) { if (n.nodeType === 3 && n.textContent.trim()) n.textContent = novo + ' '; });
  }
  function montar() {
    if (TOPO) return;
    if (CURSO) return montarCurso();
    if (IND) return montarIndicacao();
    COLAB = porClasse('nc-tre-colaborador')[0];
    TURMA = porClasse('nc-tre-turma')[0];
    if (!COLAB || !TURMA) return;
    criarTopo(COLAB);
    montarTurma();
  }

  /* o alto: ilustração, o título, o nº do pedido e a situação (o item do APEX, trazido para cá) */
  function criarTopo(reserva) {
    var sol = porClasse('nc-tre-solicitacao')[0];
    var ancora = sol || reserva;
    var linha = ancora.closest('.row') || ancora;
    TOPO = el('section', 'nc-tre-topo'); TOPO.id = 'nc-tre-topo';
    TOPO.innerHTML = (ILU.aula ? '<img class="nc-tre-topo-ilu" alt="" src="' + ILU.aula + '">' : '') +
      '<div class="nc-tre-topo-txt" data-slot="txt"></div><div class="nc-tre-topo-sit" data-slot="sit"></div>';
    linha.parentNode.insertBefore(TOPO, linha);
    if (sol) {
      var cSit = document.getElementById(P + 'SITUACAO_CONTAINER');
      if (cSit) TOPO.querySelector('[data-slot="sit"]').appendChild(cSit);
      var bSol = sol.querySelector('.t-Form-fieldContainer .t-Button, .t-Form-itemWrapper .t-Button');
      if (bSol) { bSol.classList.add('nc-tre-ver-sol'); TOPO.dataset.temBotao = '1'; TOPO._ncBotao = bSol; }
      sol.classList.add('nc-tre-absorvida');
    }
  }

  function montarTurma() {
    /* os passos: o título da região vira a pergunta (o cabeçalho fica — tem o botão da ficha) */
    passo(COLAB, 1, 'Quem vai participar?', 'Escolha a empresa e o colaborador.');
    passo(TURMA, 2, 'Qual treinamento?', 'Escolha o curso e a turma. As datas, o horário e o local vêm da turma.');

    /* o cartão da turma, logo depois de Curso/Turma */
    var corpo = corpoDe(TURMA);
    CARTAO = el('div', 'nc-tre-cartao'); CARTAO.id = 'nc-tre-cartao'; CARTAO.setAttribute('aria-live', 'polite');
    var cTurma = document.getElementById(P + 'COD_TURMA_CONTAINER');
    var depois = cTurma && (cTurma.closest('.row') || cTurma);
    if (depois && depois.parentNode) depois.parentNode.insertBefore(CARTAO, depois.nextSibling);
    else corpo.appendChild(CARTAO);
    DA_TURMA.forEach(function (n) { var c = document.getElementById(P + n + '_CONTAINER'); if (c) c.classList.add('nc-tre-auto'); });

    /* ③ o recado: a Observação sai da grade e ganha o seu bloco */
    var cObs = document.getElementById(P + 'OBSERVACAO_CONTAINER');
    if (cObs) {
      RECADO = el('div', 'nc-tre-recado');
      RECADO.innerHTML = '<h3 class="nc-tre-recado-tit"><span class="nc-tre-passo" aria-hidden="true">3</span>Recado para o RH <span class="nc-tre-opc">(opcional)</span></h3>' +
        '<p class="nc-tre-recado-dica">Algo que o RH precisa saber sobre a inscrição.</p>';
      corpo.appendChild(RECADO);
      RECADO.appendChild(cObs);
    }
    /* ① a escolha da pessoa: rótulo em cima, cada campo com a largura do que cabe nele
       (o tema punha o rótulo ao lado e dividia cada coluna ao meio) */
    var corpoC = corpoDe(COLAB);
    QUEM = el('div', 'nc-tre-quem'); QUEM.id = 'nc-tre-quem';
    var sub = corpoC.querySelector(':scope > .nc-tre-sub');
    corpoC.insertBefore(QUEM, sub ? sub.nextSibling : corpoC.firstChild);
    /* PODE MEXER: [item, largura, largura média, 'Rótulo', 'Dica'] — troque só os textos */
    [['EMP_SOLICITADO', 5, 6, 'Empresa', ''],
      ['MAT_SOLICITADO', 7, 6, 'Colaborador', 'Toque no botão ao lado do campo para buscar pelo nome ou pela matrícula.'],
      ['TIPO_ORIGEM', 5, 6, 'Origem do pedido', 'De onde veio o pedido do treinamento.']].forEach(function (f) {
      var c = document.getElementById(P + f[0] + '_CONTAINER'); if (!c) return;
      renomear(c, f[3]);
      var w = el('div', 'nc-tre-celula'); w.style.setProperty('--nc-l', f[1]); w.style.setProperty('--nc-c', f[2]);
      w.setAttribute('data-item', f[0]);
      w.appendChild(c);
      if (f[4]) w.appendChild(el('p', 'nc-tre-dica', esc(f[4])));
      QUEM.appendChild(w);
    });
    [].forEach.call(corpoC.querySelectorAll('.row > .col'), function (k) { if (!k.closest('.t-Form-fieldContainer') && !k.querySelector('.t-Form-fieldContainer, .t-Region')) k.classList.add('nc-tre-col-auto'); });
    /* colunas que ficaram sem nada (os campos saíram) */
    /* só colunas da GRADE (.row > .col): no rótulo-à-esquerda o tema também põe "col col-3" nos
       contêineres de rótulo e de campo — marcá-los escondia o próprio campo */
    [].forEach.call(corpo.querySelectorAll('.row > .col'), function (k) { if (!k.closest('.t-Form-fieldContainer') && !k.querySelector('.t-Form-fieldContainer:not(.nc-tre-auto), .nc-tre-cartao, .t-Region')) k.classList.add('nc-tre-col-auto'); });
  }
  function passo(reg, n, titulo, sub) {
    var h = reg.querySelector(':scope > .t-Region-header .t-Region-title');
    if (h && !h.dataset.ncOriginal) { h.dataset.ncOriginal = h.textContent; h.innerHTML = (n ? '<span class="nc-tre-passo" aria-hidden="true">' + n + '</span>' : '') + esc(titulo); }
    reg.classList.add('nc-tre-etapa');
    var corpo = corpoDe(reg);
    if (sub && !corpo.querySelector(':scope > .nc-tre-sub')) { var p = el('p', 'nc-tre-sub', esc(sub)); p.setAttribute('data-slot', 'sub'); corpo.insertBefore(p, corpo.firstChild); }
  }

  /* ═══ [J4] O ALTO ════════════════════════════════════════════════════════════════════════
     O QUE FAZ  Escreve o título ("Inscrever em treinamento", "Pedir um curso novo", "Indicar
                para um curso"…), o nº, a data, quem pediu — ou, num pedido novo, uma frase do
                que fazer — e pinta a Situação (verde aprovada/concluída, vermelho
                reprovada/cancelada).
     LÊ DOS ITENS  118/120: P118_COD_REQUISICAO, P118_DATA_REQUISICAO · 126: P126_COD_INDICACAO,
                P126_DATA_INDICACAO, P126_ROWID · em todas: P…_SOLICITANTE, P…_SITUACAO.
     PODE MEXER os títulos e frases entre aspas.
     VISUAL     Natcorp_Treinamento.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarTopo() {
    /* na indicação o nº nasce antes de gravar (o foco no Criar já o busca): gravada = tem ROWID */
    var nReq = IND ? (valor(P + 'ROWID') ? valor(P + 'COD_INDICACAO') : '') : valor(P + 'COD_REQUISICAO');
    var dt = texto(P + (IND ? 'DATA_INDICACAO' : 'DATA_REQUISICAO'));
    var partes = texto(P + 'SOLICITANTE').split(/\s+\/\s+/);
    var quem = bonito(semCodigo(partes[1] || ''));
    var tit = IND ? (nReq ? 'Indicação para curso' : 'Indicar para um curso') : CURSO ? (nReq ? 'Pedido de curso novo' : 'Pedir um curso novo') : (nReq ? 'Inscrição em treinamento' : 'Inscrever em treinamento');
    var guia = IND ? 'Escolha quem você quer indicar e o curso. A indicação segue para aprovação.' : CURSO ? 'Conte qual curso a sua equipe precisa. O pedido segue para aprovação.' : 'Escolha quem vai participar e a turma. O pedido segue para aprovação.';
    var html = '<h1 class="nc-tre-topo-tit">' + tit + '</h1>' +
      (nReq ? '<p class="nc-tre-topo-req">' + (IND ? 'Indicação' : 'Pedido') + ' nº <b>' + esc(nReq) + '</b>' + (dt ? ' · feito em ' + esc(dt) : '') + (quem ? ' · por ' + esc(quem) : '') + '</p>' :
        '<p class="nc-tre-topo-req">' + guia + '</p>');
    var t = TOPO.querySelector('[data-slot="txt"]');
    if (t.getAttribute('data-html') !== html) {
      t.setAttribute('data-html', html);
      t.innerHTML = html;
      if (TOPO._ncBotao && nReq) { var r = t.querySelector('.nc-tre-topo-req'); TOPO._ncBotao.setAttribute('aria-label', 'Ver quem fez o pedido'); TOPO._ncBotao.title = 'Ver quem fez o pedido'; r.appendChild(TOPO._ncBotao); }
    }
    var cSit = document.getElementById(P + 'SITUACAO_CONTAINER');
    var sit = texto(P + 'SITUACAO');
    TOPO.dataset.sit = /aprov|conclu/i.test(sit) ? 'ok' : /reprov|cancel/i.test(sit) ? 'nao' : sit ? 'aberta' : '';
    TOPO.querySelector('[data-slot="sit"]').hidden = !cSit || escondido(cSit);
  }

  /* ═══ [J5] PÁGINA 118: O CARTÃO DA TURMA ═════════════════════════════════════════════════
     O QUE FAZ  Mostra o que a turma trouxe num cartão: curso, turma, "Quando" (09/06 a
                13/06/2025 · 5 dias), "Horário", "Quem dá o treinamento", "Tipo" e "Onde" (do
                Local, só as linhas com conteúdo). Sem turma: uma frase do que fazer. Sem
                nenhum curso na lista: "Nenhum curso disponível para inscrição agora".
                Os campos travados saem da vista (o cartão os mostra) — mas voltam se o
                servidor marcar erro neles.
     LÊ DOS ITENS  P118_COD_CURSO, P118_COD_TURMA, P118_DATA_INICIO, P118_DATA_FIM,
                P118_HORA_INICIO, P118_HORA_FIM, P118_COD_TIPO, P118_COD_ENTIDADE, P118_LOCAL,
                P118_OBSERVACAO, P118_TIPO_ORIGEM.
     COMO LÊ O LOCAL  Uma linha por informação, no formato "Nome: valor". Linha sem valor de
                verdade ("Endereço: , -") é pulada.
     PODE MEXER os rótulos do cartão — o 2º texto de cada  fatos.push(['ícone', 'Rótulo', …]):
                'Quando', 'Horário', 'Quem dá o treinamento', 'Tipo', 'Onde' — e as frases.
     VISUAL     Natcorp_Treinamento.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function linhasLocal(t) {
    return String(t || '').split(/\r?\n/).map(function (l) {
      var m = l.match(/^\s*([^:]+):\s*(.*)$/);
      if (!m) return null;
      var v = m[2].replace(/\s+/g, ' ').trim();
      if (!/[0-9A-Za-zÀ-ÿ]/.test(v)) return null;            /* "Endereço: , -" e "Telefone: ()" não dizem nada */
      return { k: m[1].trim(), v: v };
    }).filter(Boolean);
  }
  function periodo() {
    var a = texto(P + 'DATA_INICIO'), b = texto(P + 'DATA_FIM');
    if (!a && !b) return '';
    if (!b || a === b) return a || b;
    var da = dataBR(a), db = dataBR(b);
    var dias = da && db ? Math.round((db - da) / 864e5) + 1 : 0;
    var curto = da && db && da.getFullYear() === db.getFullYear() ? a.slice(0, 5) : a;
    return curto + ' a ' + b + (dias > 1 ? ' <span class="nc-tre-sutil">· ' + dias + ' dias</span>' : '');
  }
  function montarCartao() {
    if (!CARTAO) return;
    var curso = bonito(semCodigo(texto(P + 'COD_CURSO')));
    var turma = texto(P + 'COD_TURMA');
    var cursos = document.getElementById(P + 'COD_CURSO');
    var semCursos = cursos && !travado(P + 'COD_CURSO') && ![].some.call(cursos.options, function (o) { return o.value; });
    var html;
    if (!turma) {
      html = semCursos ?
        '<div class="nc-tre-cartao-vazio"><b>Nenhum curso disponível para inscrição agora.</b><br>Se precisar de um treinamento, fale com o RH.</div>' :
        '<div class="nc-tre-cartao-vazio">' + (curso ? 'Agora escolha a <b>turma</b> de ' + esc(curso) + '.' : 'Escolha o <b>curso</b> e a <b>turma</b>.') + '<br>As datas, o horário e o local aparecem aqui.</div>';
      CARTAO.className = 'nc-tre-cartao nc-tre-cartao--vazio';
    } else {
      var hi = texto(P + 'HORA_INICIO'), hf = texto(P + 'HORA_FIM');
      var tipo = bonito(semCodigo(texto(P + 'COD_TIPO')));
      var ent = bonito(semCodigo(texto(P + 'COD_ENTIDADE')));
      var loc = linhasLocal(valor(P + 'LOCAL')).filter(function (x) { return !/^entidade$/i.test(x.k); });
      var fatos = [];
      var per = periodo();
      if (per) fatos.push(['calendario', 'Quando', per]);
      if (hi || hf) fatos.push(['relogio', 'Horário', esc(hi && hf ? hi + ' às ' + hf : hi || hf)]);
      if (ent) fatos.push(['escola', 'Quem dá o treinamento', esc(ent)]);
      if (tipo) fatos.push(['etiqueta', 'Tipo', esc(tipo)]);
      fatos.push(['local', 'Onde', loc.length ? loc.map(function (x) { return (/^(endere[çc]o)$/i.test(x.k) ? '' : '<span class="nc-tre-sutil">' + esc(x.k) + ':</span> ') + esc(x.v); }).join('<br>') : '<span class="nc-tre-sutil">Local ainda não informado</span>']);
      var obs = travado(P + 'OBSERVACAO') ? texto(P + 'OBSERVACAO') : '';
      html = '<div class="nc-tre-cartao-cab"><span class="nc-tre-cartao-ic" aria-hidden="true">' + svg(IC.livro) + '</span><div>' +
          '<p class="nc-tre-cartao-curso">' + esc(curso || 'Curso') + '</p><p class="nc-tre-cartao-turma">Turma ' + esc(turma) + '</p></div></div>' +
        '<dl class="nc-tre-fatos">' + fatos.map(function (f) { return '<div class="nc-tre-fato"><dt>' + svg(IC[f[0]]) + esc(f[1]) + '</dt><dd>' + f[2] + '</dd></div>'; }).join('') + '</dl>' +
        (obs ? '<p class="nc-tre-cartao-obs"><b>Recado:</b> ' + esc(obs) + '</p>' : '');
      CARTAO.className = 'nc-tre-cartao';
    }
    if (CARTAO.getAttribute('data-html') !== html) { CARTAO.setAttribute('data-html', html); CARTAO.innerHTML = html; }

    /* travado sai da vista (o cartão mostra); com erro, volta */
    var tudoTravado = true;
    DA_TURMA.concat(['COD_CURSO', 'COD_TURMA', 'OBSERVACAO']).forEach(function (n) {
      var c = document.getElementById(P + n + '_CONTAINER'); if (!c) return;
      var some = travado(P + n) && !comErro(c) && (DA_TURMA.indexOf(n) >= 0 || !!turma);
      c.classList.toggle('nc-tre-some', some);
      if (!travado(P + n)) tudoTravado = false;
    });
    if (RECADO) RECADO.hidden = !!document.getElementById(P + 'OBSERVACAO_CONTAINER').classList.contains('nc-tre-some');
    TURMA.classList.toggle('nc-tre-so-leitura', tudoTravado);
    var sub = TURMA.querySelector('[data-slot="sub"]');
    if (sub) sub.textContent = tudoTravado ? 'A turma deste pedido. Depois de criado, o pedido não muda aqui.' : 'Escolha o curso e a turma. As datas, o horário e o local vêm da turma.';
    /* pedido gravado: a origem vira um dado da ficha (ao lado de empresa, situação e admissão) */
    var cOri = document.getElementById(P + 'TIPO_ORIGEM_CONTAINER');
    if (cOri) {
      var trava = travado(P + 'TIPO_ORIGEM') && !comErro(cOri);
      cOri.classList.toggle('nc-tre-travado', trava);
      var ficha = document.getElementById(P + 'MATRICULA_DISPLAY_CONTAINER');
      var grade = ficha && !escondido(ficha) && ficha.closest('.container');
      var celula = QUEM && QUEM.querySelector('[data-item="TIPO_ORIGEM"]');
      if (trava && grade) { if (cOri.parentNode !== grade) grade.appendChild(cOri); }
      else if (celula && cOri.parentNode !== celula) celula.insertBefore(cOri, celula.firstChild);
      if (QUEM) QUEM.hidden = ![].some.call(QUEM.querySelectorAll('.t-Form-fieldContainer'), function (k) { return !escondido(k); });
    }
    var subC = COLAB.querySelector('[data-slot="sub"]');
    if (subC) subC.hidden = travado(P + 'MAT_SOLICITADO') || escondido(document.getElementById(P + 'MAT_SOLICITADO_CONTAINER'));
  }

  /* ═══ [J6] PÁGINA 120: O PEDIDO DE CURSO NOVO ═══════════════════════════════════════════
     O QUE FAZ  ① "Qual curso você precisa?": Nome do curso (com exemplo) e Tipo do curso em
                BOTÕES GRANDES (os botões escolhem na lista P120_COD_TIPO, que continua na
                página, fora da vista). ② "Conte mais sobre o curso" (a Observação).
                "Quem está pedindo" (o próprio gestor) desce para depois do curso, sem número.
                Pedido gravado (tudo travado): o CARTÃO DO CURSO (nome, tipo, descrição).
     COMO       Os botões do tipo são feitos a partir das OPÇÕES da lista do APEX: para mudar
                um tipo, mude a lista (LOV) no APEX. As setas do teclado andam entre eles.
                (criarChips e desenharChips servem também à 126.)
     PODE MEXER os textos entre aspas: perguntas, exemplo do nome, explicação da descrição.
     VISUAL     Natcorp_Treinamento.css › [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var GRADE = null, CHIPS = null;
  function montarCurso() {
    COLAB = porClasse('nc-tre-colaborador')[0];
    TURMA = porClasse('nc-tre-curso')[0];                 /* a região do formulário (a barra usa) */
    if (!TURMA) return;
    criarTopo(TURMA);
    passo(TURMA, 1, 'Qual curso você precisa?', 'Dê um nome e escolha o tipo do curso.');
    /* quem pede é o próprio gestor, já preenchido: vai para depois do curso, sem número */
    if (COLAB) {
      passo(COLAB, 0, 'Quem está pedindo', '');
      var lt = TURMA.closest('.row') || TURMA, lc = COLAB.closest('.row') || COLAB;
      if (lt !== lc && lt.parentNode) lt.parentNode.insertBefore(lc, lt.nextSibling);
    }
    var corpo = corpoDe(TURMA);
    GRADE = el('div', 'nc-tre-quem'); GRADE.id = 'nc-tre-grade-curso';
    var sub = corpo.querySelector(':scope > .nc-tre-sub');
    corpo.insertBefore(GRADE, sub ? sub.nextSibling : corpo.firstChild);
    [['NOME_CURSO', 12, 6, 'Nome do curso', 'Ex.: Excel básico, Atendimento ao cliente, Direção defensiva.'],
      ['COD_TIPO', 12, 6, 'Tipo do curso', '']].forEach(function (f) {
      var c = document.getElementById(P + f[0] + '_CONTAINER'); if (!c) return;
      renomear(c, f[3]);
      var w = el('div', 'nc-tre-celula'); w.style.setProperty('--nc-l', f[1]); w.style.setProperty('--nc-c', f[2]);
      w.setAttribute('data-item', f[0]);
      w.appendChild(c);
      if (f[4]) w.appendChild(el('p', 'nc-tre-dica', esc(f[4])));
      GRADE.appendChild(w);
    });
    criarChips();
    /* ② a descrição */
    var cObs = document.getElementById(P + 'OBSERVACAO_CONTAINER');
    if (cObs) {
      RECADO = el('div', 'nc-tre-recado');
      RECADO.innerHTML = '<h3 class="nc-tre-recado-tit"><span class="nc-tre-passo" aria-hidden="true">2</span>Conte mais sobre o curso <span class="nc-tre-opc">(opcional)</span></h3>' +
        '<p class="nc-tre-recado-dica">O que as pessoas precisam aprender, para quem é e quantas pessoas devem participar.</p>';
      corpo.appendChild(RECADO);
      RECADO.appendChild(cObs);
    }
    /* pedido gravado (tudo travado): o cartão do curso */
    CARTAO = el('div', 'nc-tre-cartao'); CARTAO.id = 'nc-tre-cartao'; CARTAO.hidden = true;
    GRADE.parentNode.insertBefore(CARTAO, GRADE.nextSibling);
    [].forEach.call(corpo.querySelectorAll('.row > .col'), function (k) { if (!k.closest('.t-Form-fieldContainer') && !k.querySelector('.t-Form-fieldContainer, .t-Region')) k.classList.add('nc-tre-col-auto'); });
  }
  /* o tipo vira botões grandes (um toque); a lista do APEX continua lá, fora da vista */
  function criarChips() {
    var sel = document.getElementById(P + 'COD_TIPO');
    if (sel) {
      CHIPS = el('div', 'nc-tre-chips');
      CHIPS.setAttribute('role', 'radiogroup');
      var lab = document.getElementById(P + 'COD_TIPO_LABEL'); if (lab) CHIPS.setAttribute('aria-labelledby', lab.id);
      sel.classList.add('nc-tre-nativo');
      var ic = sel.closest('.t-Form-inputContainer') || sel.parentNode;
      ic.appendChild(CHIPS);
      CHIPS.addEventListener('click', function (e) {
        var b = e.target.closest('.nc-tre-chip'); if (!b || b.disabled) return;
        apex.item(P + 'COD_TIPO').setValue(b.getAttribute('data-v'));
        agendar();
      });
      CHIPS.addEventListener('keydown', function (e) {
        if (!/^(ArrowRight|ArrowDown|ArrowLeft|ArrowUp)$/.test(e.key)) return;
        var bs = [].slice.call(CHIPS.querySelectorAll('.nc-tre-chip')); var i = bs.indexOf(document.activeElement); if (i < 0) return;
        e.preventDefault(); bs[(i + (/Right|Down/.test(e.key) ? 1 : -1) + bs.length) % bs.length].focus();
      });
    }
  }
  var ASS_CHIPS = '';
  function desenharChips() {
    var sel = document.getElementById(P + 'COD_TIPO');
    if (CHIPS && sel) {
      var ops = [].filter.call(sel.options, function (o) { return o.value; });
      var atual = sel.value, bloq = travado(P + 'COD_TIPO');
      var ass = ops.map(function (o) { return o.value + '=' + o.text; }).join('|') + '#' + atual + '#' + bloq;
      if (ass !== ASS_CHIPS) {
        ASS_CHIPS = ass;
        var foco = document.activeElement && document.activeElement.classList.contains('nc-tre-chip');
        CHIPS.innerHTML = ops.map(function (o) {
          var on = o.value === atual;
          return '<button type="button" class="nc-tre-chip' + (on ? ' is-on' : '') + '" role="radio" aria-checked="' + on + '" tabindex="' + (on || !atual && o === ops[0] ? '0' : '-1') + '" data-v="' + esc(o.value) + '"' + (bloq ? ' disabled' : '') + '>' +
            '<span class="nc-tre-chip-marca" aria-hidden="true">' + svg(IC.ok) + '</span>' + esc(bonito(semCodigo(o.text))) + '</button>';
        }).join('');
        if (foco) { var f = CHIPS.querySelector('.is-on'); if (f) f.focus(); }
      }
    }
  }
  function atualizarCurso() {
    var trava = ['NOME_CURSO', 'COD_TIPO', 'OBSERVACAO'].every(function (n) { var e = document.getElementById(P + n); return !e || travado(P + n); });
    var erro = ['NOME_CURSO', 'COD_TIPO', 'OBSERVACAO'].some(function (n) { return comErro(document.getElementById(P + n + '_CONTAINER')); });
    desenharChips();
    var mostrarCartao = trava && !erro;
    GRADE.hidden = mostrarCartao;
    if (RECADO) RECADO.hidden = mostrarCartao;
    CARTAO.hidden = !mostrarCartao;
    TURMA.classList.toggle('nc-tre-so-leitura', trava);
    var sub = TURMA.querySelector('[data-slot="sub"]');
    if (sub) sub.textContent = trava ? 'O curso deste pedido. Depois de criado, o pedido não muda aqui.' : 'Dê um nome e escolha o tipo do curso.';
    if (mostrarCartao) {
      var nome = texto(P + 'NOME_CURSO'), tipo = bonito(semCodigo(texto(P + 'COD_TIPO'))), desc = texto(P + 'OBSERVACAO');
      var html = '<div class="nc-tre-cartao-cab"><span class="nc-tre-cartao-ic" aria-hidden="true">' + svg(IC.livro) + '</span><div>' +
          '<p class="nc-tre-cartao-curso">' + esc(nome || 'Curso sem nome') + '</p>' + (tipo ? '<p class="nc-tre-cartao-turma">' + esc(tipo) + '</p>' : '') + '</div></div>' +
        (desc ? '<p class="nc-tre-cartao-desc">' + esc(desc) + '</p>' : '<p class="nc-tre-cartao-desc nc-tre-sutil">Sem descrição.</p>');
      if (CARTAO.getAttribute('data-html') !== html) { CARTAO.setAttribute('data-html', html); CARTAO.innerHTML = html; }
    }
  }

  /* ═══ [J7] PÁGINA 126: A INDICAÇÃO PARA UM CURSO ════════════════════════════════════════
     O QUE FAZ  ① "Quem você está indicando?" (Empresa e Colaborador).
                ② "Para qual curso?": a lista "Curso existente?" vira dois cartões grandes
                ("Um curso que já existe" / "Um curso novo"). A lista do APEX continua lá,
                fora da vista, e é ela que dispara a ação que mostra Curso OU Nome do curso.
                O tipo em botões (os mesmos da 120).
                ③ "Por que você está indicando?" (Motivo) e ④ "Quem oferece o curso" (sempre à
                vista, como na página — 04/10).
                Indicação gravada (tudo travado): o cartão do curso (nome, da empresa/novo,
                tipo, motivo, contato).
     PODE MEXER • OPC_ORIGEM: os textos dos dois cartões, pelo VALOR da opção (S = Sim, já
                  existe; N = Não, curso novo): [ícone, 'Título', 'Explicação'] — troque só os
                  textos;
                • as perguntas, dicas e exemplos (placeholder) entre aspas.
     VISUAL     Natcorp_Treinamento.css › [C7] e [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ORIGEM = null, CONTATO = null, IC_IND = {
    existe: '<rect x="4" y="3.5" width="16" height="17" rx="2"/><path d="M8 8.5h8M8 12h8M8 15.5h5"/>',
    novo: '<path d="M12 5v14M5 12h14"/>',
    contato: '<path d="M5 4.5h3l1.5 4-2 1.3a10 10 0 0 0 6.7 6.7l1.3-2 4 1.5v3a1.5 1.5 0 0 1-1.6 1.5A16 16 0 0 1 3.5 6.1 1.5 1.5 0 0 1 5 4.5z"/>'
  };
  /* PODE MEXER: valor da opção: [ícone, 'Título do cartão', 'Explicação'] */
  var OPC_ORIGEM = { S: ['existe', 'Um curso que já existe', 'Escolha na lista de cursos da empresa.'], N: ['novo', 'Um curso novo', 'Diga o nome e o tipo. O RH procura quem oferece.'] };
  function montarIndicacao() {
    COLAB = porClasse('nc-tre-colaborador')[0];
    TURMA = porClasse('nc-tre-curso')[0];
    if (!TURMA) return;
    criarTopo(COLAB || TURMA);
    if (COLAB) {
      passo(COLAB, 1, 'Quem você está indicando?', 'Escolha a empresa e o colaborador.');
      var corpoC = corpoDe(COLAB);
      QUEM = el('div', 'nc-tre-quem'); QUEM.id = 'nc-tre-quem';
      var subC = corpoC.querySelector(':scope > .nc-tre-sub');
      corpoC.insertBefore(QUEM, subC ? subC.nextSibling : corpoC.firstChild);
      [['COD_EMPRESA', 5, 6, 'Empresa', ''],
        ['MATRICULA', 7, 6, 'Colaborador', 'Toque no botão ao lado do campo para buscar pelo nome ou pela matrícula.']].forEach(function (f) {
        var c = document.getElementById(P + f[0] + '_CONTAINER'); if (!c) return;
        renomear(c, f[3]);
        var w = el('div', 'nc-tre-celula'); w.style.setProperty('--nc-l', f[1]); w.style.setProperty('--nc-c', f[2]);
        w.setAttribute('data-item', f[0]);
        w.appendChild(c);
        if (f[4]) w.appendChild(el('p', 'nc-tre-dica', esc(f[4])));
        QUEM.appendChild(w);
      });
      [].forEach.call(corpoC.querySelectorAll('.row > .col'), function (k) { if (!k.closest('.t-Form-fieldContainer') && !k.querySelector('.t-Form-fieldContainer, .t-Region')) k.classList.add('nc-tre-col-auto'); });
    }
    passo(TURMA, 2, 'Para qual curso?', 'Um curso que a empresa já tem ou um curso novo.');
    var corpo = corpoDe(TURMA);
    /* "Curso existente?" (Sim/Não) vira duas escolhas grandes; a lista do APEX continua (e dispara
       a ação que mostra o Curso ou o Nome do curso) */
    var cOri = document.getElementById(P + 'CURSO_EXISTENTE_CONTAINER'), sOri = document.getElementById(P + 'CURSO_EXISTENTE');
    var sub = corpo.querySelector(':scope > .nc-tre-sub');
    if (cOri && sOri) {
      ORIGEM = el('div', 'nc-tre-origem');
      ORIGEM.setAttribute('role', 'radiogroup');
      ORIGEM.setAttribute('aria-label', 'O curso já existe?');
      corpo.insertBefore(ORIGEM, sub ? sub.nextSibling : corpo.firstChild);
      ['S', 'N'].forEach(function (v) {
        if (![].some.call(sOri.options, function (o) { return o.value === v; })) return;
        var o = OPC_ORIGEM[v];
        var b = el('button', 'nc-tre-origem-bt', '<span class="nc-tre-origem-ic" aria-hidden="true">' + svg(IC_IND[o[0]]) + '</span>' +
          '<span class="nc-tre-origem-txt"><b>' + esc(o[1]) + '</b><small>' + esc(o[2]) + '</small></span><span class="nc-tre-chip-marca" aria-hidden="true">' + svg(IC.ok) + '</span>');
        b.type = 'button'; b.setAttribute('role', 'radio'); b.setAttribute('data-v', v);
        ORIGEM.appendChild(b);
      });
      ORIGEM.addEventListener('click', function (e) {
        var b = e.target.closest('[data-v]'); if (!b || b.disabled) return;
        apex.item(P + 'CURSO_EXISTENTE').setValue(b.getAttribute('data-v'));
        agendar();
      });
      cOri.classList.add('nc-tre-some-sempre');
    }
    GRADE = el('div', 'nc-tre-quem'); GRADE.id = 'nc-tre-grade-curso';
    corpo.insertBefore(GRADE, ORIGEM ? ORIGEM.nextSibling : (sub ? sub.nextSibling : corpo.firstChild));
    [['COD_CURSO', 12, 6, 'Curso', 'Toque no botão ao lado do campo para buscar pelo nome do curso.'],
      ['NOME_CURSO', 12, 6, 'Nome do curso', 'Ex.: Excel básico, NR-35 trabalho em altura, Atendimento ao cliente.'],
      ['COD_TIPO', 12, 6, 'Tipo do curso', '']].forEach(function (f) {
      var c = document.getElementById(P + f[0] + '_CONTAINER'); if (!c) return;
      renomear(c, f[3]);
      var w = el('div', 'nc-tre-celula'); w.style.setProperty('--nc-l', f[1]); w.style.setProperty('--nc-c', f[2]);
      w.setAttribute('data-item', f[0]);
      w.appendChild(c);
      if (f[4]) w.appendChild(el('p', 'nc-tre-dica', esc(f[4])));
      GRADE.appendChild(w);
    });
    criarChips();
    /* ③ o motivo */
    var cMot = document.getElementById(P + 'MOTIVO_INDICACAO_CONTAINER');
    if (cMot) {
      RECADO = el('div', 'nc-tre-recado');
      RECADO.innerHTML = '<h3 class="nc-tre-recado-tit"><span class="nc-tre-passo" aria-hidden="true">3</span>Por que você está indicando?</h3>' +
        '<p class="nc-tre-recado-dica">Isso ajuda quem aprova a decidir: o que a pessoa vai fazer com o que aprender.</p>';
      corpo.appendChild(RECADO);
      RECADO.appendChild(cMot);
      renomear(cMot, 'Motivo');
      var t = document.getElementById(P + 'MOTIVO_INDICACAO');
      if (t && !t.readOnly && !t.disabled) t.setAttribute('placeholder', 'Ex.: vai operar a empilhadeira a partir de outubro e precisa do certificado NR-11.');
    }
    /* ④ quem oferece (curso novo) */
    var cCon = document.getElementById(P + 'INFORMACOES_CONTATO_CONTAINER');
    if (cCon) {
      CONTATO = el('div', 'nc-tre-recado nc-tre-contato');
      CONTATO.innerHTML = '<h3 class="nc-tre-recado-tit"><span class="nc-tre-passo" aria-hidden="true">4</span>Quem oferece o curso <span class="nc-tre-opc">(opcional)</span></h3>' +
        '<p class="nc-tre-recado-dica">Se souber: escola ou empresa, site, telefone ou e-mail.</p>';
      corpo.appendChild(CONTATO);
      CONTATO.appendChild(cCon);
      var tc = document.getElementById(P + 'INFORMACOES_CONTATO');
      if (tc && !tc.readOnly && !tc.disabled) tc.setAttribute('placeholder', 'Ex.: Senai Centro, (11) 3333-4444, cursos@senai.br');
    }
    CARTAO = el('div', 'nc-tre-cartao'); CARTAO.id = 'nc-tre-cartao'; CARTAO.hidden = true;
    GRADE.parentNode.insertBefore(CARTAO, GRADE.nextSibling);
    [].forEach.call(corpo.querySelectorAll('.row > .col'), function (k) { if (!k.closest('.t-Form-fieldContainer') && !k.querySelector('.t-Form-fieldContainer, .t-Region')) k.classList.add('nc-tre-col-auto'); });
  }
  function atualizarIndicacao() {
    var existe = valor(P + 'CURSO_EXISTENTE') === 'S';
    var sOri = document.getElementById(P + 'CURSO_EXISTENTE');
    if (ORIGEM && sOri) {
      var bloq = travado(P + 'CURSO_EXISTENTE');
      [].forEach.call(ORIGEM.querySelectorAll('[data-v]'), function (b) {
        var on = sOri.value === b.getAttribute('data-v');
        if (b.getAttribute('aria-checked') !== String(on)) b.setAttribute('aria-checked', String(on));
        b.classList.toggle('is-on', on);
        b.disabled = bloq;
      });
    }
    desenharChips();
    var campos = ['CURSO_EXISTENTE', 'COD_CURSO', 'NOME_CURSO', 'COD_TIPO', 'MOTIVO_INDICACAO', 'INFORMACOES_CONTATO'];
    var trava = campos.every(function (n) { var e = document.getElementById(P + n); return !e || travado(P + n); });
    var erro = campos.some(function (n) { return comErro(document.getElementById(P + n + '_CONTAINER')); });
    /* 04/10: "Quem oferece o curso" fica à vista também com curso existente — a página não
       esconde INFORMACOES_CONTATO (a DA "Curso Existente" só troca Curso ↔ Nome do curso) */
    var mostrarCartao = trava && !erro;
    if (ORIGEM) ORIGEM.hidden = mostrarCartao;
    GRADE.hidden = mostrarCartao;
    if (RECADO) RECADO.hidden = mostrarCartao;
    if (CONTATO) CONTATO.hidden = mostrarCartao;
    CARTAO.hidden = !mostrarCartao;
    TURMA.classList.toggle('nc-tre-so-leitura', trava);
    var sub = TURMA.querySelector('[data-slot="sub"]');
    if (sub) sub.textContent = trava ? 'O curso desta indicação. Depois de criada, a indicação não muda aqui.' : 'Um curso que a empresa já tem ou um curso novo.';
    if (mostrarCartao) {
      var nome = existe ? bonito(semCodigo(texto(P + 'COD_CURSO'))) || texto(P + 'NOME_CURSO') : texto(P + 'NOME_CURSO');
      var tipo = bonito(semCodigo(texto(P + 'COD_TIPO'))), mot = texto(P + 'MOTIVO_INDICACAO'), con = texto(P + 'INFORMACOES_CONTATO');
      var html = '<div class="nc-tre-cartao-cab"><span class="nc-tre-cartao-ic" aria-hidden="true">' + svg(IC.livro) + '</span><div>' +
          '<p class="nc-tre-cartao-curso">' + esc(nome || 'Curso sem nome') + '</p><p class="nc-tre-cartao-turma">' + esc([existe ? 'Curso da empresa' : 'Curso novo', tipo].filter(Boolean).join(' · ')) + '</p></div></div>' +
        '<p class="nc-tre-cartao-desc">' + (mot ? '<b>Motivo:</b> ' + esc(mot) : '<span class="nc-tre-sutil">Sem motivo informado.</span>') + '</p>' +
        (con ? '<p class="nc-tre-cartao-obs">' + svg(IC_IND.contato) + '<span><b>Quem oferece:</b> ' + esc(con) + '</span></p>' : '');
      if (CARTAO.getAttribute('data-html') !== html) { CARTAO.setAttribute('data-html', html); CARTAO.innerHTML = html; }
    }
    /* ① depois de escolhido (gravado), a ficha do colaborador mostra quem é: a dica sai */
    var subC = COLAB && COLAB.querySelector('[data-slot="sub"]');
    if (subC) subC.hidden = travado(P + 'MATRICULA') || escondido(document.getElementById(P + 'MATRICULA_CONTAINER'));
    if (QUEM) QUEM.hidden = ![].some.call(QUEM.querySelectorAll('.t-Form-fieldContainer'), function (k) { return !escondido(k); });
  }

  /* ═══ [J8] A FAIXA DA APROVAÇÃO ══════════════════════════════════════════════════════════
     O QUE FAZ  Transforma o relatório "Aprovadores" numa faixa horizontal logo abaixo do alto:
                resumo ("2 de 3 · aguardando Maria"), cada aprovador com um sinal (aprovou,
                reprovou, aguardando, na fila) e a justificativa de quem reprovou. Os botões
                Aprovar/Reprovar do APEX vão para dentro da faixa — os mesmos botões, com os
                mesmos cliques. Sem o caminho, mas com botões (acontece na 126, ver o guia),
                mostra só "Sua decisão" com os botões, sem inventar a lista.
     LÊ DAS COLUNAS  APROVADOR, DATA, STATUS, JUSTIFICATIVA (pelo nome da coluna).
     CUIDADO    Coluna renomeada no relatório = a faixa não acha os dados. Os botões são
                achados pelo TEXTO: precisam conter "Aprovar" e "Reprovar".
     PODE MEXER os textos entre aspas: 'Aprovação', 'Ver o caminho', 'Aguardando', 'Na fila'…
     VISUAL     Natcorp_Treinamento.css › [C10]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function situacaoReq() {
    var t = texto(P + 'SITUACAO');
    return { texto: t, tom: /aprov|conclu/i.test(t) ? 'ok' : /reprov|cancel/i.test(t) ? 'nao' : 'andamento' };
  }
  var IC_AP = { ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>', x: '<path d="M8 8l8 8M16 8l-8 8"/>' };
  function nomeAprovador(t) {
    var m = String(t || '').match(/^\s*(\d+)\s*-\s*(\d+)\s*-\s*(.+)$/);
    if (m) return { nome: bonito(capitalizar(m[3].trim())), meta: 'Empresa ' + m[1] + ' · matrícula ' + m[2], pessoa: true };
    var n = String(t || '').trim();
    return { nome: maiusculas(n) ? capitalizar(n) : n, meta: '', pessoa: false };
  }
  function lerAprovacao(reg) {
    var passos = [].slice.call(reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      var c = function (h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? td.textContent.replace(/\s+/g, ' ').trim() : ''; };
      var link = tr.querySelector('a[href*="dialog"], a[href^="javascript"]') || tr._ncLink || null;
      if (link) tr._ncLink = link;
      var st = c('STATUS');
      return { quem: nomeAprovador(c('APROVADOR')), data: c('DATA').replace(/^-$/, ''), status: st, just: c('JUSTIFICATIVA').replace(/^-$/, ''), link: link,
        estado: /reprov|recus|negad/i.test(st) ? 'nao' : /aprov/i.test(st) ? 'ok' : 'pend' };
    });
    var atual = -1;
    for (var i = 0; i < passos.length; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; });
    return { passos: passos, atual: reprovado ? -1 : atual, reprovado: reprovado, aprovados: passos.filter(function (x) { return x.estado === 'ok'; }).length,
      botoes: [].slice.call(reg.querySelectorAll('button, a.t-Button')).filter(function (b) { return /aprovar|reprovar/i.test(b.textContent) && !b.closest('.nc-tre-caminho'); }).concat(reg._ncBotoes || []) };
  }
  var apAberto = false;
  function montarAprovadores() {
    porClasse('nc-tre-aprovadores').forEach(function (reg) {
      if (TOPO && reg.previousElementSibling !== TOPO) TOPO.parentNode.insertBefore(reg, TOPO.nextSibling);
      var ap = lerAprovacao(reg);
      var corpo = corpoDe(reg);
      var btsSo = ap.botoes.filter(function (b) { return !escondido(b); });
      reg.hidden = !ap.passos.length && !btsSo.length;
      var box = corpo.querySelector(':scope > .nc-tre-caminho');
      if (!ap.passos.length && !btsSo.length) { if (box) box.remove(); return; }
      /* há decisão a tomar mas o caminho não veio (na 126 a consulta dos aprovadores olha a p118):
         só a decisão, sem inventar o caminho */
      if (!ap.passos.length) {
        if (!box) { box = el('div', 'nc-tre-caminho'); corpo.insertBefore(box, corpo.firstChild); }
        box.className = 'nc-tre-caminho nc-tre-caminho--vez';
        var h0 = '<p class="nc-tre-caminho-rot">Aprovação</p><div class="nc-tre-caminho-cab"><p class="nc-tre-caminho-resumo"><b>Sua decisão</b> sobre esta indicação</p></div><div class="nc-tre-decisao-botoes" aria-label="Sua decisão"></div>';
        if (box.getAttribute('data-html') !== h0) {
          box.setAttribute('data-html', h0); box.innerHTML = h0;
          var d0 = box.querySelector('.nc-tre-decisao-botoes');
          btsSo.sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) { b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-tre-reprovar' : 'nc-tre-aprovar'); d0.appendChild(b); });
        }
        reg._ncBotoes = btsSo;
        return;
      }
      if (!box) {
        box = el('div', 'nc-tre-caminho'); corpo.insertBefore(box, corpo.firstChild);
        box.addEventListener('click', function (e) { if (e.target.closest('.nc-tre-caminho-ver')) { apAberto = !apAberto; agendar(); } });
      }
      var bts = ap.botoes.filter(function (b, i, a) { return a.indexOf(b) === i; });
      reg._ncBotoes = bts;
      var total = ap.passos.length;
      var sitR = situacaoReq();
      if (sitR.tom === 'nao' && !ap.reprovado) ap.atual = -2;
      var quemNao = ap.passos.filter(function (x) { return x.estado === 'nao'; })[0];
      var resumoTxt = ap.reprovado ? '<b>Reprovada</b> por ' + esc(quemNao.quem.nome) : ap.atual === -2 ? '<b>Interrompida</b> · pedido ' + esc(sitR.texto.toLowerCase()) : ap.atual < 0 ? '<b>Aprovada</b> por todos' :
        '<b>' + ap.aprovados + ' de ' + total + '</b> · aguardando <b>' + esc(ap.passos[ap.atual].quem.nome) + '</b>';
      var estadoGeral = ap.reprovado ? 'nao' : ap.atual === -2 ? 'fim' : ap.atual < 0 ? 'ok' : bts.length ? 'vez' : 'pend';
      reg.classList.toggle('nc-tre-ap-aberto', !!apAberto);
      box.className = 'nc-tre-caminho nc-tre-caminho--' + estadoGeral;
      var html =
        '<p class="nc-tre-caminho-rot">Aprovação</p><div class="nc-tre-caminho-cab"><p class="nc-tre-caminho-resumo">' + resumoTxt + '</p>' +
          '<button type="button" class="nc-tre-caminho-ver" aria-expanded="' + apAberto + '">' + (apAberto ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
        '<ol class="nc-tre-passos-ap">' + ap.passos.map(function (x, i) {
          var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === ap.atual ? 'is-vez' : 'is-fila';
          var st = x.estado === 'ok' ? (x.data ? x.data.replace(/\s.*$/, '') : 'Aprovou') : x.estado === 'nao' ? 'Reprovou' : ap.atual === -2 ? 'Não chegou' : i === ap.atual ? 'Aguardando' : 'Na fila';
          var ic = x.estado === 'ok' ? IC_AP.ok : x.estado === 'nao' ? IC_AP.x : i === ap.atual ? '<path d="M12 8v4l2.5 1.5"/>' : '';
          var dica = x.quem.nome + (x.quem.meta ? ' (' + x.quem.meta + ')' : '') + ' — ' + (x.estado === 'ok' ? 'aprovou' + (x.data ? ' em ' + x.data : '') : x.estado === 'nao' ? 'reprovou' + (x.data ? ' em ' + x.data : '') : i === ap.atual ? 'aguardando a aprovação' : 'na fila') + (x.just ? ': "' + x.just + '"' : '');
          return '<li class="nc-tre-ap ' + cls + '" data-i="' + i + '" title="' + esc(dica) + '"><span class="nc-tre-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
            '<span class="nc-tre-ap-texto"><span class="nc-tre-ap-nome">' + esc(x.quem.nome) + '</span><span class="nc-tre-ap-estado">' + esc(st) + '</span></span></li>';
        }).join('') + '</ol>' +
        (bts.length ? '<div class="nc-tre-decisao-botoes" aria-label="Sua decisão"></div>' : '') +
        (quemNao && quemNao.just ? '<blockquote class="nc-tre-ap-just"><b>' + esc(quemNao.quem.nome) + ' reprovou:</b> ' + esc(quemNao.just) + '</blockquote>' : '');
      if (box.getAttribute('data-html') === html) return;
      box.setAttribute('data-html', html);
      box.innerHTML = html;
      ap.passos.forEach(function (x, i) {
        if (!x.link || !x.quem.pessoa) return;
        var li = box.querySelector('.nc-tre-ap[data-i="' + i + '"] .nc-tre-ap-texto');
        x.link.classList.add('nc-tre-ap-link'); x.link.setAttribute('title', 'Ver dados de ' + x.quem.nome); x.link.setAttribute('aria-label', 'Ver dados de ' + x.quem.nome);
        li.appendChild(x.link);
      });
      var dest = box.querySelector('.nc-tre-decisao-botoes');
      if (dest) bts.sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) { b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-tre-reprovar' : 'nc-tre-aprovar'); dest.appendChild(b); });
    });
  }

  /* ═══ [J9] A BARRA DO RODAPÉ ═════════════════════════════════════════════════════════════
     O QUE FAZ  A região nc-tre-acoes desce para depois do último bloco e vira a barra: Voltar,
                o que FALTA preencher (clicar leva ao campo; no celular, "N campos") e o botão
                de gravar. "Criar" passa a se chamar "Enviar pedido" (ou "Enviar indicação").
                Pedido travado: "A turma deste pedido já está definida." Sem Criar/Salvar
                à vista (só leitura): a barra fica só com o Voltar.
     COMO SABE O QUE FALTA  Os campos com "Value Required" no APEX MAIS os da lista PEDE
                (que contam mesmo sem asterisco: sem eles não há pedido). Campo travado ou
                escondido pela página não conta.
     PODE MEXER • PEDE: nomes dos itens SEM o prefixo (ex.: 'COD_TURMA'), uma lista por página;
                • 'Enviar pedido', 'Enviar indicação', 'Falta', 'Tudo pronto para enviar'.
     VISUAL     Natcorp_Treinamento.css › [C9]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* sem eles não há pedido, com ou sem asterisco */
  /* na indicação: o curso (da lista ou o nome, o que estiver à vista), o tipo e o motivo — o
     motivo não é obrigatório na página, mas sem ele quem aprova não tem como decidir */
  /* PODE MEXER: os campos que entram no "Falta" — 126 ? […] : 120 ? […] : 118 […] */
  var PEDE = IND ? ['COD_EMPRESA', 'MATRICULA', 'COD_CURSO', 'NOME_CURSO', 'COD_TIPO', 'MOTIVO_INDICACAO'] : CURSO ? ['NOME_CURSO', 'COD_TIPO'] : ['EMP_SOLICITADO', 'MAT_SOLICITADO', 'COD_CURSO', 'COD_TURMA'];
  function faltas() {
    var cs = [].slice.call(document.querySelectorAll('.nc-tre-etapa .t-Form-fieldContainer.is-required'));
    PEDE.forEach(function (n) { var c = document.getElementById(P + n + '_CONTAINER'); if (c && cs.indexOf(c) < 0) cs.push(c); });
    return cs.filter(function (c) {
      var id = c.id.replace(/_CONTAINER$/, '');
      return !escondido(c) && !travado(id) && vazio(valor(id)) && vazio(texto(id));
    });
  }
  function montarBarra() {
    var ac = porClasse('nc-tre-acoes')[0];
    if (!ac) return;
    [].forEach.call(ac.querySelectorAll('.t-Button'), function (b) { if (!b.dataset.ncGrava) b.dataset.ncGrava = /^\s*(criar|salvar)\s*$/i.test(b.textContent) ? '1' : '0'; });
    var gravar = [].some.call(ac.querySelectorAll('.t-Button'), function (b) { return b.dataset.ncGrava === '1' && !escondido(b); });
    ac.classList.toggle('nc-tre-acoes--leitura', !gravar);
    if (!ac.dataset.ncMovida) {
      ac.dataset.ncMovida = '1';
      /* depois do último bloco: na 120 o "Quem está pedindo" desceu para depois do curso */
      var ult = CURSO && COLAB ? COLAB : TURMA;
      var linha = ult.closest('.row') || ult;
      linha.parentNode.insertBefore(ac, linha.nextSibling);
      /* o Criar/Salvar mora numa tabela na coluna do meio: o aviso entra na linha da barra e o CSS
         põe cada um no lugar (computador e celular) — como na Alteração Cadastral */
      var alvo = ac.querySelector('.t-ButtonRegion-wrap') || ac;
      var s = el('div', 'nc-tre-status'); s.id = 'nc-tre-status'; s.setAttribute('aria-live', 'polite');
      alvo.appendChild(s);
      s.addEventListener('click', function (e) {
        var b = e.target.closest('[data-ir]'); if (!b) return;
        var c = document.getElementById(b.getAttribute('data-ir')); if (!c) return;
        c.scrollIntoView({ behavior: 'smooth', block: 'center' });
        var i = c.querySelector('input:not([type=hidden]), select, textarea'); if (i) setTimeout(function () { i.focus({ preventScroll: true }); }, 350);
      });
      /* a barra saiu do alto: o tema reserva o espaço que ela ocupava lá (medido ao carregar) —
         pedir para ele medir de novo tira a faixa vazia */
      setTimeout(function () { $(window).trigger('apexwindowresized'); }, 60);
      [].forEach.call(ac.querySelectorAll('.t-Button'), function (b) {
        if (/^\s*criar\s*$/i.test(b.textContent)) { var l = b.querySelector('.t-Button-label') || b; l.textContent = IND ? 'Enviar indicação' : 'Enviar pedido'; }
      });
    }
    if (!gravar) return;
    var f = faltas();
    var leitura = TURMA.classList.contains('nc-tre-so-leitura');
    var html = f.length ?
      '<span class="nc-tre-status-rot">Falta</span> ' + f.map(function (c) { return '<button type="button" class="nc-tre-falta nc-tre-so-largo" data-ir="' + c.id + '">' + esc(rotulo(c)) + '</button>'; }).join('') +
        '<button type="button" class="nc-tre-falta nc-tre-so-celular" data-ir="' + f[0].id + '">' + f.length + (f.length === 1 ? ' campo' : ' campos') + '</button>' :
      leitura ? '<span class="nc-tre-status-nada">' + svg(IC.cadeado) + (IND ? 'O curso desta indicação já está definido.' : CURSO ? 'O curso deste pedido já está definido.' : 'A turma deste pedido já está definida.') + '</span>' :
      '<span class="nc-tre-status-ok">' + svg(IC.ok) + 'Tudo pronto para enviar</span>';
    var st = document.getElementById('nc-tre-status');
    if (st.innerHTML !== html) st.innerHTML = html;
  }

  /* ═══ [J10] O MAESTRO: QUANDO CADA PARTE É MONTADA ═════════════════════════════════════
     O QUE FAZ  tudo() monta (uma vez) e depois atualiza o alto, o cartão (da página certa), a
                aprovação e a barra. iniciar() roda quando a página abre e manda atualizar tudo
                sempre que algo muda: um item muda de valor, uma ação dinâmica traz valores do
                servidor, uma janela fecha, a página trava/libera campos.
     CUIDADO    Não mude a ordem das chamadas em tudo(): a barra precisa saber se o pedido está
                travado, o que o cartão decide antes.
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp treinamento] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tudo() {
    montar();
    if (!TOPO) return;
    montarTopo();
    if (IND) atualizarIndicacao(); else if (CURSO) atualizarCurso(); else montarCartao();
    montarAprovadores();
    montarBarra();
  }
  var agendado = false, MO = null;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () {
      agendado = false;
      try { tudo(); } catch (e) { if (window.console) console.warn('[Natcorp treinamento]', e); }
      if (MO) MO.takeRecords();
    });
  }
  function iniciar() {
    document.body.classList.add('nc-tre');
    tudo();
    $(document).on('change', '[id^="' + P + '"]', agendar);
    $(document).on('input', '.nc-tre-etapa input, .nc-tre-etapa textarea', agendar);
    $(document).on('apexafterrefresh', agendar);
    /* valores trazidos do servidor por ação dinâmica (Executar PL/SQL, "itens a retornar")
       chegam SEM o evento change: sem isto a tela ficava com a leitura de antes da resposta */
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    $(document).on('apexafterclosedialog dialogclose', function () { setTimeout(agendar, 80); });
    if (window.MutationObserver && TURMA) {
      MO = new MutationObserver(agendar);
      MO.observe(TURMA, { attributes: true, subtree: true, attributeFilter: ['style', 'disabled', 'class'] });
    }
    setTimeout(agendar, 900);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
