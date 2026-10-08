/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE ESCALA PARA COLABORADOR  —  o "arrumador" da tela (JavaScript)  ║
   ║  App 9503 · Página 179 · a janela "Criar/Editar" do pedido de escala ou de plantão         ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quem pede é o gestor ou o próprio colaborador — muita gente com pouca prática com sistemas,
   muitas vezes pelo celular. Quando a janela abre, este arquivo REORGANIZA o que o APEX já
   desenhou em 5 passos numerados (o mesmo desenho do Desligamento):
     1. Quem vai mudar de escala?  (no plantão: "Quem vai fazer o plantão?") — Empresa, Colaborador
     2. O que você precisa?  — o item "Plantão?" vira dois cartões: "Mudar a escala" (N) ou
        "Fazer plantão" (S). "Onde vai ser o plantão?" (o C.Custo Plantão) fica sempre à vista;
        a página só o libera no plantão (04/10)
     3. Qual vai ser a nova escala?  (plantão: "Como vai ser o plantão?") — Local, Jornada, Escala
     4. Por quanto tempo?  — o item "Exceção" vira dois cartões: "Definitiva" (N) ou "Só por um
        tempo" (S), mais as datas e um resumo do período ("De 01/10 a 15/10 · 15 dias")
     5. Por que você está pedindo?  — Motivo e Justificativa
   Cada passo diz "Pronto" ou "Falta N campos"; o rodapé lista o que falta, e o botão "Criar"
   aparece como "Enviar pedido". Num pedido já gravado, o alto mostra o número, a data e a
   situação, e a aprovação vira uma lista no fim do formulário.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: isso continua sendo do APEX.
     • As ações dinâmicas da página (validação do plantão e da escala, a "Exceção" forçada pela
       empresa, as listas em cascata) continuam as mesmas e continuam ligadas aos mesmos itens.
     • Se este arquivo for retirado da página, a janela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 179 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Escala.js
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Escala.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Esta página NÃO usa classes no APEX. O arquivo acha tudo pelos NOMES DOS ITENS (P179_…):
     • se o item P179_COD_ESCALA não existir na página, o arquivo não faz nada (é o sinal de
       que não está na página certa);
     • os itens de cada passo estão na lista PASSOS, em [J1];
     • a aprovação é achada pelo relatório que tem a coluna APROVADOR.
   Se um item for RENOMEADO no APEX, renomeie também aqui (sem o "P179_"), senão o campo fica
   fora dos passos.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Configuração ........................ passos, nomes, ajudas e cartões     PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  A montagem .......................... monta a abertura e os 5 passos quando abre
     [J4]  Rótulos, cartões e abas ............. nomes dos campos, "Não/Sim" em cartões
     [J5]  O pedido gravado .................... número, data e situação no alto
     [J6]  A aprovação ......................... quem analisou e o que decidiu      PODE MEXER
     [J7]  O rodapé ............................ "Enviar pedido" e o que falta
     [J8]  O que muda enquanto se preenche ..... "Falta"/"Pronto", período, jornada  CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Explique o pedido'  →  'Conte o motivo'
     Quero mudar o título ou a explicação de um passo            → [J1], lista PASSOS
     Quero mudar o nome ou a frase de ajuda de um campo          → [J1], lista ROTULOS
     Criei um campo novo e ele apareceu solto, fora dos passos
       → [J1], lista PASSOS: acrescente o nome do item (sem o "P179_", entre aspas) na lista
         "itens" do passo certo. A ordem da lista é a ordem na tela. Acrescente também o nome
         curto dele em CURTOS (é o nome que aparece no "Falta" do rodapé).
     Quero mudar o texto dos cartões "Mudar a escala" / "Definitiva"   → [J1], lista OPCOES
     A janela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e veja se há erro em vermelho.
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
     P + 'JUSTIFICATIVA'  junta os textos: vira 'P179_JUSTIFICATIVA', o nome do item no APEX.
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: esta linha impede que o arquivo rode duas vezes (se a URL estiver repetida na
     página, por exemplo) e que rode fora do APEX. Não apague. */
  if (window.__ncEscala || !window.apex || !window.apex.jQuery) return;
  /* O começo do nome de todos os itens desta página. Se a página for copiada para outro
     número (ex.: 279), troque aqui para 'P279_' — e mais nada no arquivo. */
  var P = 'P179_';
  /* Sem o item da Escala na página, o arquivo entende que não está na página certa e para aqui.
     É por isso que ele não precisa de teste de app ou de página. */
  if (!document.getElementById(P + 'COD_ESCALA_CONTAINER')) return;   /* sem os itens, nada a desenhar */
  window.__ncEscala = true;

  var $ = apex.jQuery;

  /* ═══ [J1] CONFIGURAÇÃO: PASSOS, NOMES, AJUDAS E CARTÕES ════════════════════════════════════
     O QUE É    As listas que dizem COMO a janela fica organizada. Quase tudo o que se quer
                mudar nesta página se muda AQUI, sem mexer no resto do arquivo.
       IC        os ícones (desenhos pequenos, no formato SVG). Não precisa mexer.
       PASSOS    os 5 passos: título, explicação e os itens de cada um, na ordem da tela.
       ROTULOS   o nome que aparece em cima de cada campo e uma frase de ajuda embaixo.
       CURTOS    o nome curto de cada campo na lista "Falta" do rodapé.
       OPCOES    o texto dos cartões que substituem os "Não/Sim".
     IMPORTANTE Trocar um rótulo aqui muda SÓ o texto na tela. O item, o valor gravado e as
                ações dinâmicas continuam os mesmos.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* Os ícones usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    troca: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/><path d="M9 13.5h6l-2-2M15 16.5H9l2 2"/>',
    plantao: '<path d="M12 21s-6.5-5.6-6.5-11a6.5 6.5 0 0 1 13 0c0 5.4-6.5 11-6.5 11z"/><circle cx="12" cy="10" r="2.4"/>',
    escala: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4M7.5 13h2M11 13h2M14.5 13h2M7.5 16.5h2M11 16.5h2"/>',
    sempre: '<path d="M12 3.5l7.5 3v5.5c0 4.4-3.1 7.9-7.5 9.5-4.4-1.6-7.5-5.1-7.5-9.5V6.5z"/><path d="M8.8 12.2l2.2 2.2 4.3-4.6"/>',
    tempo: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    porque: '<path d="M4 5.5h16v10.5H9.5L5 20v-4H4z"/><path d="M8.5 9.5h7M8.5 12.5h4.5"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    marca: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5M12 8v.01"/>',
    alerta: '<path d="M12 3.5l9 16H3z"/><path d="M12 10v4M12 17v.01"/>',
    enviar: '<path d="M4 12l16-8-6 16-3-7z"/><path d="M11 13l9-9"/>',
    aprovacao: '<circle cx="9" cy="8" r="3.2"/><path d="M3 19.5a6 6 0 0 1 11.2-3"/><path d="M14.5 16.5l2.2 2.2 4.3-4.6"/>',
    x: '<path d="M7 7l10 10M17 7L7 17"/>',
    espera: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>'
  };

  /* PODE MEXER: os passos, na ordem em que a pessoa pensa (a página tem os itens em outra ordem).
       titulo         o título do passo           tituloPlantao  o título quando é plantão
       sub            a frase de explicação        itens          os itens do passo, SEM o "P179_"
       ic             o ícone (um nome da lista IC)
     CUIDADO: não mude o "id" ('quem', 'tipo'…): o visual (CSS) e outras partes usam esse nome. */
  var PASSOS = [
    { id: 'quem', ic: 'pessoa', titulo: 'Quem vai mudar de escala?', tituloPlantao: 'Quem vai fazer o plantão?',
      sub: 'A empresa e o colaborador.', itens: ['COD_EMPRESA', 'MATRICULA'] },
    { id: 'tipo', ic: 'escala', titulo: 'O que você precisa?', sub: 'Escolha uma das duas opções.',
      itens: ['ESCALA_PLANTAO', 'CCUSTO_PLANTAO'] },
    { id: 'escala', ic: 'escala', titulo: 'Qual vai ser a nova escala?', tituloPlantao: 'Como vai ser o plantão?',
      sub: 'Onde a pessoa vai trabalhar e em quais dias e horários.', itens: ['COD_LOCAL_TRAB', 'COD_JORNADA', 'COD_ESCALA'] },
    { id: 'tempo', ic: 'tempo', titulo: 'Por quanto tempo?', sub: 'Se é de vez ou só por um período, e as datas.',
      itens: ['EXCECAO', 'INICIO', 'FIM'] },
    { id: 'porque', ic: 'porque', titulo: 'Por que você está pedindo?', sub: 'Isso ajuda quem aprova a entender o pedido.',
      itens: ['MOT_ALT', 'JUSTIFICATIVA'] }
  ];
  /* PODE MEXER: nomes na tela (só o texto do rótulo; o item continua o mesmo) e uma linha de ajuda.
     Formato:  ITEM: ['Nome do campo', 'Frase de ajuda embaixo']   — '' = sem ajuda. */
  var ROTULOS = {
    COD_LOCAL_TRAB: ['Local de trabalho', 'Onde a pessoa vai trabalhar.'],
    CCUSTO_PLANTAO: ['Onde vai ser o plantão?', 'O local (centro de custo) do plantão.'],
    COD_JORNADA: ['Jornada', 'Quantas horas a pessoa trabalha.'],
    COD_ESCALA: ['Escala', 'Os dias e os horários de trabalho.'],
    INICIO: ['Começa em', ''],
    FIM: ['Termina em', ''],
    MOT_ALT: ['Motivo', ''],
    JUSTIFICATIVA: ['Explique o pedido', '']
  };
  /* PODE MEXER: o nome curto de cada campo na lista "Falta" do rodapé */
  var CURTOS = { COD_EMPRESA: 'Empresa', MATRICULA: 'Colaborador', CCUSTO_PLANTAO: 'Local do plantão', COD_LOCAL_TRAB: 'Local de trabalho',
    COD_JORNADA: 'Jornada', COD_ESCALA: 'Escala', INICIO: 'Começa em', FIM: 'Termina em', MOT_ALT: 'Motivo', JUSTIFICATIVA: 'Explicação' };
  /* PODE MEXER: as opções que eram "Não/Sim". Cada opção:  VALOR: ['ícone', 'Título', 'Explicação'].
     CUIDADO: N e S são os VALORES gravados pelo APEX: não troque essas letras, só os textos. */
  var OPCOES = {
    ESCALA_PLANTAO: {
      N: ['troca', 'Mudar a escala', 'Trocar os dias ou os horários de trabalho da pessoa.'],
      S: ['plantao', 'Fazer plantão', 'Trabalhar em plantão num local da empresa.']
    },
    EXCECAO: {
      N: ['sempre', 'Definitiva', 'A nova escala passa a valer de vez.'],
      S: ['tempo', 'Só por um tempo', 'É uma exceção: no fim do período volta a escala de hoje.']
    }
  };

  /* ═══ [J2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('ITEM')     o que o APEX GUARDA no item (o código, ex.: 'S' ou 'N')
       cont('ITEM')    o bloco inteiro do campo na tela (rótulo + campo)
       vazio(texto)    diz se está vazio (ou se é só "- Selecione -")
       data('31/12/2026')  transforma o texto numa data
       plantao()       diz se a pessoa escolheu "Fazer plantão"
     QUANDO MEXER  Quase nunca.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-esc-svg') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function cont(n) { return document.getElementById(P + n + '_CONTAINER'); }
  function val(n) { try { return String(apex.item(P + n).getValue() || '').trim(); } catch (e) { var i = document.getElementById(P + n); return i ? i.value.trim() : ''; } }
  function vazio(v) { return !v || /^\s*(-\s*selecione\s*-|-|—)\s*$/i.test(v); }
  function escondido(c) { for (var e = c; e && e !== document.body; e = e.parentElement) if (e.style && e.style.display === 'none') return true; return false; }
  function data(t) { var m = String(t || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function plural(n, a, b) { return n + ' ' + (n === 1 ? a : b); }
  function plantao() { return val('ESCALA_PLANTAO') === 'S'; }
  /* só escreve quando muda: o observador olha "class" dentro do formulário (senão vira laço) */
  function classe(e, v) { if (e.className !== v) e.className = v; }
  function html(e, v) { if (e.innerHTML !== v) e.innerHTML = v; }

  /* ═══ [J3] A MONTAGEM: O QUE ACONTECE QUANDO A JANELA ABRE ═════════════════════════════════
     O QUE FAZ  montar() roda uma vez, logo depois que a janela abre:
                  • põe a abertura no alto ("Novo pedido de escala · Em 5 passos…"), ou, num
                    pedido gravado, o cabeçalho com número e situação ([J5]);
                  • cria os 5 passos e LEVA para dentro deles os campos do APEX (lista PASSOS);
                  • esconde o que sobrou da grade do APEX sem nenhum campo dentro;
                  • chama as outras partes: rótulos, cartões, abas, aprovação e rodapé.
                Depois, sempre que algo muda (a pessoa escolhe uma opção, uma ação dinâmica
                devolve valores, um campo é escondido ou travado), a parte [J8] atualiza a tela.
     PODE MEXER os textos da abertura: 'Novo pedido de escala', 'Em 5 passos…'.
     VISUAL     Natcorp_Escala.css › [C2] (abertura) e [C5] (passos)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  $(function () { setTimeout(montar, 40); });

  var FORM = null, SECS = [], AVISO_EXC = null, FALTA = null, pediuDefinitiva = 0;

  function montar() {
    document.body.classList.add('nc-esc');
    var c0 = cont('COD_EMPRESA');
    FORM = c0.closest('.t-Region, .a-Tabs-panel') || c0.parentNode;
    var corpo = c0.closest('.container').parentNode;

    /* a abertura: pedido novo ganha a apresentação dos passos; pedido gravado, o cabeçalho com
       número, datas e situação (no lugar da região "Requisição") */
    var nova = !val('COD_REQ');
    if (!nova) montarPedido();
    var topo = el('div', 'nc-esc-topo');
    topo.innerHTML = '<span class="nc-esc-topo-ic" aria-hidden="true">' + svg(IC.escala) + '</span><div>' +
      '<h2>' + (nova ? 'Novo pedido de escala' : 'Pedido de escala' + (val('COD_REQ') ? ' nº ' + esc(val('COD_REQ')) : '')) + '</h2>' +
      '<p>' + (nova ? 'Em 5 passos. Os campos com <b class="nc-esc-ast">*</b> são obrigatórios.' : 'Confira os dados do pedido.') + '</p></div>';

    var caixa = el('div', 'nc-esc-passos');
    PASSOS.forEach(function (p, i) {
      var sec = el('section', 'nc-esc-passo nc-esc-passo--' + p.id);
      sec.setAttribute('aria-labelledby', 'nc-esc-t-' + p.id);
      sec.innerHTML = '<header class="nc-esc-passo-cab"><span class="nc-esc-num" aria-hidden="true">' + (i + 1) + '</span>' +
        '<div class="nc-esc-passo-tit"><h3 id="nc-esc-t-' + p.id + '">' + esc(p.titulo) + '</h3><p>' + esc(p.sub) + '</p></div>' +
        '<span class="nc-esc-passo-estado" aria-live="polite"></span></header><div class="nc-esc-campos"></div>';
      var campos = sec.querySelector('.nc-esc-campos');
      p.itens.forEach(function (n) { var c = cont(n); if (c) { c.classList.add('nc-esc-campo', 'nc-esc-campo--' + n.toLowerCase()); campos.appendChild(c); } });
      if (p.id === 'tempo') {
        campos.appendChild(el('p', 'nc-esc-periodo', ''));
        AVISO_EXC = el('p', 'nc-esc-aviso', svg(IC.info) + '<span>Nesta empresa a troca definitiva não é feita por aqui: o pedido fica como <b>Só por um tempo</b>.</span>');
        AVISO_EXC.hidden = true;
        campos.appendChild(AVISO_EXC);
      }
      caixa.appendChild(sec);
      SECS.push({ p: p, sec: sec });
    });
    corpo.insertBefore(caixa, corpo.firstChild);
    if (nova) corpo.insertBefore(topo, caixa);
    montarAprovacao(caixa);
    /* o que sobrou do grid do APEX, sem campo à vista, sai */
    [].forEach.call(corpo.querySelectorAll(':scope > .container'), function (k) { if (!k.querySelector('.t-Form-fieldContainer')) k.classList.add('nc-esc-fora'); });

    rotulos();
    opcoes('ESCALA_PLANTAO');
    opcoes('EXCECAO');
    abas();
    rodape();

    /* tudo que muda o que se vê: o que a pessoa escolhe, e o que as ações dinâmicas devolvem */
    $(document).on('change', '[id^="' + P + '"]', agendar);
    $(document).on('input', '#' + P + 'JUSTIFICATIVA', agendar);
    $(document).ajaxComplete(agendar);
    $('#' + P + 'EXCECAO').on('change', function () { if (val('EXCECAO') === 'N') pediuDefinitiva = Date.now(); });
    new MutationObserver(agendar).observe(FORM, { attributes: true, attributeFilter: ['style', 'disabled', 'class'], subtree: true });
    atualizar();
  }

  /* ═══ [J4] RÓTULOS, CARTÕES E ABAS ═══════════════════════════════════════════════════════
     O QUE FAZ  • rotulos(): troca o texto do rótulo dos campos e põe a frase de ajuda embaixo
                  (ambos vêm da lista ROTULOS, em [J1]); põe também o exemplo dentro da caixa
                  de justificativa ('Em poucas palavras…').
                • opcoes(): transforma os "Não/Sim" de Plantão? e Exceção em dois cartões
                  grandes (textos da lista OPCOES, em [J1]).
                • abas(): com uma aba só ("Escala"), a barra de abas não ajuda e é escondida;
                  volta quando o pedido gravado tem a aba Aprovadores.
     IMPORTANTE Os botões de rádio do APEX continuam lá, dentro dos cartões: clicar no cartão é
                clicar no rádio, e as ações dinâmicas disparam como sempre.
     VISUAL     Natcorp_Escala.css › [C5] (campos) e [C6] (cartões)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: o exemplo escrito dentro da caixa de justificativa fica no fim desta função */
  function rotulos() {
    Object.keys(ROTULOS).forEach(function (n) {
      var c = cont(n); if (!c) return;
      var l = c.querySelector('.t-Form-label');
      var r = ROTULOS[n];
      if (l && l.firstChild && l.firstChild.nodeType === 3) l.firstChild.nodeValue = r[0] + ' ';
      if (r[1] && !c.querySelector('.nc-esc-ajuda')) {
        var ic = c.querySelector('.t-Form-inputContainer');
        if (ic) ic.appendChild(el('span', 'nc-esc-ajuda', esc(r[1])));
      }
    });
    var j = document.getElementById(P + 'JUSTIFICATIVA');
    if (j && !j.getAttribute('placeholder')) j.setAttribute('placeholder', 'Em poucas palavras: por que a pessoa precisa desta escala?');
  }

  /* "Não/Sim" viram duas escolhas grandes; os rádios do APEX continuam (e disparam o change) */
  function opcoes(n) {
    var c = cont(n); if (!c) return;
    c.classList.add('nc-esc-escolha');
    [].forEach.call(c.querySelectorAll('.apex-item-option'), function (op) {
      var r = op.querySelector('input[type=radio]'), lb = op.querySelector('label');
      var o = OPCOES[n][r && r.value];
      if (!r || !lb || !o || lb.querySelector('.nc-esc-op-tit')) return;
      lb.innerHTML = '<span class="nc-esc-op-ic" aria-hidden="true">' + svg(IC[o[0]]) + '</span>' +
        '<span class="nc-esc-op-txt"><b class="nc-esc-op-tit">' + esc(o[1]) + '</b><small>' + esc(o[2]) + '</small></span>' +
        '<span class="nc-esc-op-marca" aria-hidden="true">' + svg(IC.marca) + '</span>';
    });
  }

  /* com uma aba só ("Escala"), a barra de abas não ajuda: sai (volta quando há Aprovadores) */
  function abas() {
    var rds = document.querySelector('.apex-rds-container');
    if (!rds) return;
    var vis = [].filter.call(rds.querySelectorAll('.apex-rds li, li.apex-rds-item'), function (li) { return li.style.display !== 'none' && getComputedStyle(li).display !== 'none'; });
    /* uma aba só, ou a aprovação já desenhada no fim do formulário: a barra não ajuda.
       04/10: menos quando a aba Aprovadores traz botões da página (Aprovar, Reprovar, Aprovar
       termo): sem a barra, eles ficariam presos na aba escondida */
    var sai = vis.length <= 1 || (!!APROV && !APROV.reg.querySelector('button.t-Button, a.t-Button'));
    if (rds.classList.contains('nc-esc-fora') !== sai) rds.classList.toggle('nc-esc-fora', sai);
    if (sai && FORM && FORM.style.display === 'none') {
      var a = rds.querySelector('a[href="#' + FORM.id + '"]'); if (a) a.click();
    }
  }

  /* ═══ [J5] O PEDIDO GRAVADO: NÚMERO, DATA E SITUAÇÃO ════════════════════════════════════════
     O QUE FAZ  Num pedido já gravado, a região "Requisição" é escondida e, no lugar dela,
                aparece um cabeçalho: "Pedido de escala nº …", "Aberto em …" e a situação num
                selo colorido (verde = aprovado, vermelho = recusado/cancelado, âmbar =
                suspenso, lilás = em andamento) com "desde …".
     LÊ DOS ITENS  P179_COD_REQ, P179_DT_REQ, P179_COD_SIT_REQ, P179_DT_SIT_REQ
     COMO       Se o item Situação estiver liberado para quem abriu, o PRÓPRIO campo do APEX vai
                para dentro do cabeçalho (é o mesmo campo, só mudou de lugar).
     CUIDADO    A cor do selo é escolhida pelo NOME da situação (tomSituacao): procura pedaços
                como "aprovad", "cancelad". Uma situação nova com outro nome fica lilás.
     VISUAL     Natcorp_Escala.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var SITUACAO = null;
  function tomSituacao(t) {
    var s = String(t || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase();
    if (/aprovad|conclu|disponibiliz/.test(s)) return 'bom';
    if (/cancelad|reprovad/.test(s)) return 'ruim';
    if (/suspens/.test(s)) return 'atencao';
    return 'meio';
  }
  function montarPedido() {
    var c = cont('COD_REQ'); if (!c) return;
    var reg = c.closest('.t-Region'); if (!reg || reg.style.display === 'none') return;
    var cab = el('section', 'nc-esc-pedido');
    cab.setAttribute('aria-label', 'Dados do pedido');
    cab.innerHTML = '<span class="nc-esc-topo-ic" aria-hidden="true">' + svg(IC.escala) + '</span>' +
      '<div class="nc-esc-pedido-txt"><h2>Pedido de escala nº ' + esc(val('COD_REQ')) + '</h2>' +
      '<p>' + (val('DT_REQ') ? 'Aberto em <b>' + esc(val('DT_REQ')) + '</b>' : '') + '</p></div>' +
      '<div class="nc-esc-pedido-sit" data-slot="sit"></div>';
    reg.parentNode.insertBefore(cab, reg);
    /* a Situação é editável (quem administra o pedido muda por aqui): o próprio item vem junto */
    var cs = cont('COD_SIT_REQ'), sel = document.getElementById(P + 'COD_SIT_REQ');
    if (cs && sel && !sel.disabled) {
      var ctl = el('div', 'nc-esc-pedido-ctl');
      ctl.appendChild(cs);
      cab.appendChild(ctl);
      $(sel).on('change', desenharSituacao);
    }
    reg.classList.add('nc-esc-fora');
    SITUACAO = cab;
    desenharSituacao();
  }
  function desenharSituacao() {
    if (!SITUACAO) return;
    var sel = document.getElementById(P + 'COD_SIT_REQ');
    var nome = sel && sel.options[sel.selectedIndex] && sel.value ? sel.options[sel.selectedIndex].text : '';
    var desde = val('DT_SIT_REQ');
    html(SITUACAO.querySelector('[data-slot="sit"]'), nome ? '<span class="nc-esc-sit nc-esc-sit--' + tomSituacao(nome) + '"><i aria-hidden="true"></i>' + esc(nome) + '</span>' +
      (desde ? '<span class="nc-esc-sit-desde">desde ' + esc(desde) + '</span>' : '') : '');
  }

  /* ═══ [J6] A APROVAÇÃO: SAI DA ABA E VIRA O FIM DO FORMULÁRIO ═══════════════════════════════
     O QUE FAZ  Lê o relatório da aba Aprovadores e mostra, no fim do formulário, uma lista:
                quem analisou, o que decidiu, quando e a justificativa. Redesenha a cada
                atualização do relatório.
     LÊ DE      o relatório que tem a coluna APROVADOR, pelas colunas APROVADOR, DATA, STATUS e
                JUSTIFICATIVA.
     CUIDADO    Se uma dessas colunas for renomeada no relatório do APEX, a lista não acha os
                dados. Renomeie também aqui (procure  headers="  e  th#APROVADOR  abaixo).
     PODE MEXER os textos 'Aprovação', 'Quem analisou o pedido…', 'Ainda não há aprovação…'.
     VISUAL     Natcorp_Escala.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var APROV = null;
  function montarAprovacao(caixa) {
    var reg = document.querySelector('.a-Tabs-panel .t-Report-report th#APROVADOR, .t-Report-report th#APROVADOR');
    reg = reg && reg.closest('.t-Region');
    if (!reg || !val('COD_REQ')) return;
    var sec = el('section', 'nc-esc-aprov');
    sec.setAttribute('aria-labelledby', 'nc-esc-t-aprov');
    sec.innerHTML = '<header class="nc-esc-aprov-cab"><span class="nc-esc-aprov-ic" aria-hidden="true">' + svg(IC.aprovacao) + '</span>' +
      '<div><h3 id="nc-esc-t-aprov">Aprovação</h3><p>Quem analisou o pedido e o que decidiu.</p></div></header><ol class="nc-esc-aprov-lista" data-slot="lista"></ol>';
    caixa.appendChild(sec);
    APROV = { reg: reg, sec: sec };
    $(reg).on('apexafterrefresh', function () { setTimeout(desenharAprovacao, 30); });
    desenharAprovacao();
  }
  function tomAprov(t) {
    var s = String(t || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase();
    if (/aprovad/.test(s)) return ['bom', IC.ok];
    if (/reprovad|recusad|negad/.test(s)) return ['ruim', IC.x];
    return ['atencao', IC.espera];
  }
  function desenharAprovacao() {
    if (!APROV) return;
    var linhas = [].slice.call(APROV.reg.querySelectorAll('table.t-Report-report tbody tr')).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? td.textContent.replace(/\s+/g, ' ').trim() : ''; }
      return { quem: c('APROVADOR'), data: c('DATA'), status: c('STATUS'), just: c('JUSTIFICATIVA') };
    }).filter(function (l) { return l.quem || l.status; });
    var ol = APROV.sec.querySelector('[data-slot="lista"]');
    html(ol, !linhas.length ? '<li class="nc-esc-aprov-vazio">Ainda não há aprovação registrada.</li>' : linhas.map(function (l) {
      var t = tomAprov(l.status);
      return '<li class="nc-esc-aprov-item nc-esc-aprov-item--' + t[0] + '"><span class="nc-esc-aprov-marca" aria-hidden="true">' + svg(t[1]) + '</span>' +
        '<div class="nc-esc-aprov-txt"><b>' + esc(l.quem || 'Aprovador') + '</b>' +
          '<span><span class="nc-esc-aprov-status">' + esc(l.status || 'Aguardando') + '</span>' + (l.data && !vazio(l.data) ? ' · ' + esc(l.data) : '') + '</span>' +
          (l.just && !vazio(l.just) ? '<q>' + esc(l.just) + '</q>' : '') + '</div></li>';
    }).join(''));
  }

  /* ═══ [J7] O RODAPÉ: "ENVIAR PEDIDO" E O QUE FALTA ═════════════════════════════════════════
     O QUE FAZ  O botão "Criar" do APEX passa a dizer "Enviar pedido" (é o mesmo botão, só o
                texto muda) e, ao lado, aparece a lista do que falta preencher. Tocar num nome
                da lista leva até o campo.
     CUIDADO    O botão é achado pelo texto "Criar". Se o rótulo do botão mudar no APEX, mude
                também o  /^criar$/i  abaixo (é um "padrão de busca": procura a palavra Criar).
     PODE MEXER o texto 'Enviar pedido' (aparece duas vezes abaixo: troque as duas).
     VISUAL     Natcorp_Escala.css › [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function rodape() {
    var criar = [].slice.call(document.querySelectorAll('.t-Dialog-footer .t-Button, .t-ButtonRegion .t-Button')).filter(function (b) { return /^criar$/i.test(b.textContent.trim()); })[0];
    if (criar) {
      criar.setAttribute('data-nc-envia', '1');
      criar.classList.add('nc-esc-enviar');
      var l = criar.querySelector('.t-Button-label');
      if (l) l.textContent = 'Enviar pedido'; else criar.textContent = 'Enviar pedido';
    }
    var meio = document.querySelector('.t-Dialog-footer .t-ButtonRegion-col--content') || (criar && criar.parentNode);
    FALTA = el('div', 'nc-esc-falta');
    FALTA.setAttribute('aria-live', 'polite');
    if (meio) meio.appendChild(FALTA);
    FALTA.addEventListener('click', function (e) {
      var b = e.target.closest('[data-ir]'); if (!b) return;
      var c = cont(b.getAttribute('data-ir')); if (!c) return;
      c.scrollIntoView({ behavior: 'smooth', block: 'center' });
      var i = c.querySelector('input:not([type=hidden]), textarea, select'); if (i) setTimeout(function () { try { i.focus({ preventScroll: true }); } catch (x) { i.focus(); } }, 350);
    });
  }

  /* ═══ [J8] O QUE MUDA ENQUANTO SE PREENCHE ═════════════════════════════════════════════════
     O QUE FAZ  atualizar() roda de novo a cada mudança (com um pequeno atraso, para não rodar
                várias vezes seguidas) e:
                  • troca os títulos dos passos quando é plantão;
                  • conta os campos OBRIGATÓRIOS vazios de cada passo ("Falta N" / "Pronto");
                  • monta a lista "Falta" do rodapé, ou "Tudo preenchido. Pode enviar.";
                  • encurta o texto da Jornada (textoJornada), escreve o resumo do período
                    (periodo) e explica a "Exceção" forçada pela empresa (excecaoForcada).
     COMO SABE O QUE É OBRIGATÓRIO  Pelo próprio APEX: campo com "Value Required" ligado.
                Campo escondido ou travado pelo APEX não conta.
     PODE MEXER os textos entre aspas ('Falta', 'Pronto', 'Tudo preenchido. Pode enviar.',
                o aviso das datas trocadas, o resumo do período).
     CUIDADO    textoJornada só muda o TEXTO MOSTRADO; o valor enviado nunca é tocado.
                Leia o comentário dela antes de mexer.
     VISUAL     Natcorp_Escala.css › [C5] (estado dos passos), [C7] (período e avisos), [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var tAg = 0;
  function agendar() { clearTimeout(tAg); tAg = setTimeout(atualizar, 60); }

  function obrigatorio(c) { return c.classList.contains('is-required'); }
  function preenchido(n) { return !vazio(val(n)); }

  /* a Jornada aparece como "Empresa = 700 - Cód.Jornada = 117- Descrição = DAS 08:00 AS 13:00…":
     na tela fica "117 · DAS 08:00 AS 13:00…". SÓ o que é texto de exibição muda:
       · pedido gravado: o <span …_DISPLAY> (o valor está no item oculto);
       · lista editável: o campo de texto só se ele NÃO tem name e o valor está no …_HIDDENVALUE.
     O campo que é enviado nunca é tocado (conferido: no pedido gravado, P179_COD_JORNADA = "117") */
  var RE_JORNADA = /C[óo]d\.?\s*Jornada\s*=\s*([^\s-]+)\s*-?\s*Descri[çc][ãa]o\s*=\s*(.+)$/i;
  function textoJornada() {
    var d = document.getElementById(P + 'COD_JORNADA_DISPLAY');
    if (d) { var m = d.textContent.match(RE_JORNADA); if (m) d.textContent = m[1] + ' · ' + m[2].trim(); }
    var i = document.getElementById(P + 'COD_JORNADA');
    if (i && i.type === 'text' && !i.getAttribute('name') && document.getElementById(P + 'COD_JORNADA_HIDDENVALUE')) {
      var n = String(i.value || '').match(RE_JORNADA);
      if (n) { var novo = n[1] + ' · ' + n[2].trim(); if (i.value !== novo) { i.value = novo; i.title = novo; } }
    }
  }

  function atualizar() {
    textoJornada();
    var pl = plantao();
    document.body.classList.toggle('nc-esc-plantao', pl);
    /* 04/10: o local do plantão NÃO some fora do plantão: a página só o desabilita e limpa
       ("Desabilita C.Custo Plantão"); quem esconde item é a página */

    var faltam = [];
    SECS.forEach(function (s) {
      var h = s.sec.querySelector('h3'), t = pl && s.p.tituloPlantao ? s.p.tituloPlantao : s.p.titulo;
      if (h.textContent !== t) h.textContent = t;
      var req = s.p.itens.filter(function (n) {
        var c = cont(n);
        if (!c || escondido(c) || c.classList.contains('nc-esc-oculto')) return false;
        var i = document.getElementById(P + n);
        if (i && i.disabled) return false;
        return obrigatorio(c) || (n === 'CCUSTO_PLANTAO' && pl);
      });
      var f = req.filter(function (n) { return !preenchido(n); });
      f.forEach(function (n) { faltam.push(n); });
      var est = s.sec.querySelector('.nc-esc-passo-estado');
      classe(est, 'nc-esc-passo-estado' + (!req.length ? '' : f.length ? ' is-falta' : ' is-ok'));
      html(est, !req.length ? '' : f.length ? 'Falta ' + plural(f.length, 'campo', 'campos') : svg(IC.ok) + 'Pronto');
    });

    periodo();
    excecaoForcada();
    abas();

    if (FALTA) {
      var criar = document.querySelector('[data-nc-envia]');
      var podeEnviar = criar && criar.style.display !== 'none';
      FALTA.innerHTML = faltam.length
        ? '<span class="nc-esc-falta-rot">Falta</span>' + faltam.map(function (n) { return '<button type="button" class="nc-esc-falta-item" data-ir="' + n + '">' + esc(CURTOS[n] || n) + '</button>'; }).join('') +
          (faltam.length > 3 ? '<span class="nc-esc-falta-mais" aria-hidden="true">+' + (faltam.length - 3) + '</span>' : '')
        : podeEnviar ? '<span class="nc-esc-pronto">' + svg(IC.ok) + 'Tudo preenchido. Pode enviar.</span>' : '';
    }
  }

  function periodo() {
    var box = document.querySelector('.nc-esc-periodo'); if (!box) return;
    var ini = data(val('INICIO')), fim = data(val('FIM'));
    var temp = val('EXCECAO') === 'S';
    if (!ini && !fim) { box.hidden = true; return; }
    box.hidden = false;
    if (ini && fim && fim < ini) {
      classe(box, 'nc-esc-periodo is-erro');
      html(box, svg(IC.alerta) + '<span>A data de <b>Termina em</b> está antes de <b>Começa em</b>.</span>');
      return;
    }
    classe(box, 'nc-esc-periodo');
    var txt;
    if (ini && fim) {
      var dias = Math.round((fim - ini) / 864e5) + 1;
      txt = 'De <b>' + esc(val('INICIO')) + '</b> a <b>' + esc(val('FIM')) + '</b> · ' + plural(dias, 'dia', 'dias') + '.' + (temp ? ' Depois volta a escala de hoje.' : '');
    } else if (ini) txt = 'A partir de <b>' + esc(val('INICIO')) + '</b>.';
    else txt = 'Até <b>' + esc(val('FIM')) + '</b>.';
    html(box, svg(IC.tempo) + '<span>' + txt + '</span>');
  }

  /* PODE MEXER: o texto do aviso ("Nesta empresa a troca definitiva…") está em [J3], na montagem. */
  /* a página, conforme a empresa, só aceita exceção: esconde o Criar e põe Exceção = Sim. Quando a
     pessoa escolheu "Definitiva" e voltou sozinho para "Só por um tempo", a tela explica */
  function excecaoForcada() {
    if (!AVISO_EXC) return;
    var voltou = pediuDefinitiva && val('EXCECAO') === 'S' && Date.now() - pediuDefinitiva < 8000;
    if (voltou) AVISO_EXC.hidden = false;
    if (val('EXCECAO') === 'N') AVISO_EXC.hidden = true;
  }
})();
