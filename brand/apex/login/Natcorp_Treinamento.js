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
  var ILU = {"aula": "data:image/png;base64,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"};

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
