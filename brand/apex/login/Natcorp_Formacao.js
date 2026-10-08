/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CURSOS E FORMAÇÕES  —  o "arrumador" da tela (JavaScript)                      ║
   ║  App 600 · Página 5 · portal Conhecendo Você: o colaborador ou o candidato conta o que     ║
   ║  estudou, os cursos que fez, as línguas que fala e o que faz bem                          ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── QUEM USA ──────────────────────────────────────────────────────────────────────────────
   Quase todos pelo celular, muitos com pouca leitura. Por isso os textos são curtos e em
   palavras de todo dia.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
     1. O ALTO: uma frase do que é esta etapa ("não precisa ter tudo") e os quatro assuntos
        com quantos itens cada um já tem — um toque leva a ele.
     2. CADA LISTA ganha nome de gente ("Escola e faculdade", "O que você faz bem") e uma dica
        com exemplos. Cada item vira um cartão legível: nome, nível (MBA, 40 horas,
        Intermediário), onde, a situação (Concluído em verde, Não concluído em amarelo), o
        nível do idioma em quatro pontos e a palavra "Editar" (o cartão inteiro é o toque).
     3. O "Adicionar" da página vai para o fim da lista, grande, dizendo o quê ("Adicionar
        curso"). Se a página o esconde (quem só consulta), continua escondido.
     4. Lista vazia diz o que fazer. O "Mais informações" vazio fica recolhido atrás de
        "Escrever mais sobre isso" (e some quando a página o traz travado e vazio).
     5. O botão "Prosseguir" passa a dizer "Continuar".

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda valor nenhum e não grava nada. O APEX continua dono de tudo: as quatro listas,
       as janelas de incluir/editar (páginas 6, 8, 10 e 12) e o "Prosseguir" que grava.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 5 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Formacao.js
     Página 5 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Formacao.css
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Formacao.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Esta página NÃO usa classes postas no APEX. O arquivo se reconhece sozinho pelos itens
   "Mais informações" de cada assunto:
     …_FORMACAO_ESCOLAR_OBS   …_CURSO_OBS   …_IDIOMA_OBS   …_HABILIDADE_OBS
   (os três primeiros precisam existir; sem eles o arquivo não faz nada).
     • Cada item …_OBS mora numa sub-região "Observações", DENTRO da região da lista: é assim
       que o arquivo acha a região de cada assunto.
     • Cada lista é um relatório do tipo Media List.
     • O botão de incluir de cada lista se chama exatamente "Adicionar".
     • O botão de gravar se chama exatamente "Prosseguir".

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Configuração ........................ nomes, dicas e frases dos assuntos  PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  Montar (uma vez) .................... títulos, "Adicionar", o alto        PODE MEXER
     [J4]  Os cartões dos itens ................ cada linha da lista vira um cartão
     [J5]  Atualizar (sempre) .................. contadores, lista vazia, "Mais informações"
     [J6]  O maestro ........................... decide QUANDO cada parte roda        CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Escola e faculdade'  →  'Estudos'
     Quero mudar o nome, a dica ou a frase de "lista vazia" de um assunto → [J1], lista ASSUNTOS.
     Um rótulo dos detalhes do cartão ficou estranho (ex.: "Entidade")    → [J1], lista DET.
     Criei um novo nível de idioma e ele não aparece nos 4 pontos         → [J1], lista NIVEIS.
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp formação].
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
     P + 'CURSO_OBS'        junta os textos: vira 'P5_CURSO_OBS', o nome do item no APEX.
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: estas linhas impedem que o arquivo rode duas vezes ou fora do APEX, e o fazem
     desistir em silêncio se a página não tiver os itens …_FORMACAO_ESCOLAR_OBS, …_CURSO_OBS
     e …_IDIOMA_OBS. Não apague. */
  if (window.__ncFormacao || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_FORMACAO_ESCOLAR_OBS_CONTAINER"]');
  if (!achado || !document.querySelector('[id$="_CURSO_OBS_CONTAINER"]') || !document.querySelector('[id$="_IDIOMA_OBS_CONTAINER"]')) return;
  window.__ncFormacao = true;

  var $ = apex.jQuery;
  /* O começo do nome dos itens ('P5_'), descoberto sozinho a partir do item
     FORMACAO_ESCOLAR_OBS. Se a página for copiada para outro número, NADA muda aqui. */
  var P = achado.id.replace(/FORMACAO_ESCOLAR_OBS_CONTAINER$/, '');

  /* ═══ [J1] CONFIGURAÇÃO ═══════════════════════════════════════════════════════════════════
     O QUE É    As listas que dizem O QUE a tela escreve. É a parte mais fácil de mexer.
       ASSUNTOS os quatro assuntos, na ordem do alto. Cada linha tem:
                  obs    → o item "Mais informações" do assunto, sem o P5_ (NÃO mude)
                  id     → o nome interno (NÃO mude: o visual usa)
                  titulo → o título da lista            curto → o nome no atalho do alto
                  dica   → a frase de exemplo sob o título
                  icone  → um dos nomes da lista IC     um    → "Adicionar ___" (ex.: 'curso')
                  vazio  → a frase quando a lista ainda não tem nada
       NIVEIS   como achar o nível do idioma no texto: [/pedaço do texto/i, número de 1 a 4]
       DET      rótulos dos detalhes do cartão: 'rótulo do APEX em minúsculas': 'como aparece'
     PODE MEXER os textos entre aspas das três listas.
     CUIDADO    Cada linha termina em vírgula, menos a última da lista.
     VISUAL     Natcorp_Formacao.css › [C2] (alto), [C3] (listas) e [C4] (cartões)
     ════════════════════════════════════════════════════════════════════════════════════════ */

  /* PODE MEXER: os quatro assuntos, achados pelo "Mais informações" de cada um */
  var ASSUNTOS = [
    { id: 'escola', obs: 'FORMACAO_ESCOLAR_OBS', titulo: 'Escola e faculdade', curto: 'Escola', dica: 'Até onde você estudou: ensino fundamental, médio, técnico ou faculdade.', icone: 'capelo', um: 'formação', vazio: 'Você ainda não colocou onde estudou.' },
    { id: 'cursos', obs: 'CURSO_OBS', titulo: 'Cursos', curto: 'Cursos', dica: 'Cursos que você fez: informática, segurança, atendimento, máquinas…', icone: 'certificado', um: 'curso', vazio: 'Nenhum curso por enquanto.' },
    { id: 'idiomas', obs: 'IDIOMA_OBS', titulo: 'Idiomas', curto: 'Idiomas', dica: 'Línguas que você fala ou entende, além do português.', icone: 'balao', um: 'idioma', vazio: 'Nenhum idioma por enquanto. Só português? Pode deixar assim.' },
    { id: 'habilidades', obs: 'HABILIDADE_OBS', titulo: 'O que você faz bem', curto: 'Habilidades', dica: 'Por exemplo: trabalhar em equipe, falar com clientes, ser organizado.', icone: 'estrela', um: 'habilidade', vazio: 'Nenhuma habilidade por enquanto.' }
  ];
  /* PODE MEXER: o nível do idioma, em quatro pontos (1 = básico … 4 = fluente) */
  var NIVEIS = [[/b[aá]sico|iniciante/i, 1], [/intermedi/i, 2], [/avan[cç]/i, 3], [/fluente|nativ/i, 4]];
  /* PODE MEXER: os rótulos da descrição, em palavras de todo dia */
  var DET = { 'entidade': 'Onde estudou', 'instituição': 'Onde estudou', 'local': 'Onde fez', 'período': 'Dias',
    'turno': 'Turno', 'início': 'Datas', 'data de conclusão': 'Terminou em', 'conclusão': 'Terminou em' };
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    capelo: '<path d="M2.5 9.5L12 5l9.5 4.5L12 14z"/><path d="M6.5 11.5v4c1.5 1.6 3.3 2.4 5.5 2.4s4-.8 5.5-2.4v-4M21.5 9.5v5"/>',
    certificado: '<rect x="3" y="4" width="18" height="13" rx="2"/><path d="M7 8.5h10M7 12h6"/><circle cx="16.5" cy="16.5" r="2.5"/><path d="M15.2 18.6l-.7 3 2-1 2 1-.7-3"/>',
    balao: '<path d="M4 5.5h11a2 2 0 0 1 2 2V13a2 2 0 0 1-2 2H9l-4 3.5V15H4a2 2 0 0 1-2-2V7.5a2 2 0 0 1 2-2z"/><path d="M19 9h1a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-1v2.5L16 18h-3"/>',
    estrela: '<path d="M12 3.5l2.6 5.3 5.9.8-4.3 4.1 1 5.8L12 16.8l-5.2 2.7 1-5.8-4.3-4.1 5.9-.8z"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    texto: '<path d="M4 6h16M4 10.5h16M4 15h10"/>'
  };

  /* ═══ [J2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS:
       texto(e)          o texto de um pedaço da tela, sem espaços sobrando
       miudas(t)         "Curso De Informática" → "Curso de Informática"
       oculto(e)         diz se o APEX escondeu aquele pedaço
       renomear(item, t) troca o rótulo do item na tela
       alturaFixa()      a altura da barra do alto, para a rolagem não parar embaixo dela
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-fo-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function texto(e) { return e ? e.textContent.replace(/\s+/g, ' ').trim() : ''; }
  /* o relatório vem em "Iniciais Maiúsculas": as palavras pequenas voltam a ser minúsculas */
  function miudas(t) { return String(t || '').replace(/(\s)(De|Da|Do|Das|Dos|E|Em|No|Na|Para|Com)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); }); }
  function oculto(e) { return !e || e.style.display === 'none' || getComputedStyle(e).display === 'none'; }
  function alturaFixa() {
    var h = 0;
    [].forEach.call(document.querySelectorAll('.t-Header, .t-Body-title'), function (x) {
      if (/fixed|sticky/.test(getComputedStyle(x).position)) h = Math.max(h, x.getBoundingClientRect().bottom);
    });
    return Math.min(h, window.innerHeight / 2);
  }
  function renomear(n, t) {
    var l = document.getElementById(P + n + '_LABEL');
    if (!l || l.getAttribute('data-nc-fo')) return;
    for (var i = 0; i < l.childNodes.length; i++) {
      var x = l.childNodes[i];
      if (x.nodeType === 3 && x.textContent.trim()) { x.textContent = t + ' '; l.setAttribute('data-nc-fo', '1'); return; }
    }
  }

  /* ═══ [J3] MONTAR (roda uma vez, quando a página abre) ═══════════════════════════════════
     O QUE FAZ  Para cada assunto de ASSUNTOS:
                • acha a região da lista (a região "de cima" da sub-região do …_OBS);
                • troca o título e põe a dica embaixo;
                • leva o botão "Adicionar" para o fim da lista, como "Adicionar curso" etc.;
                • prepara a frase de lista vazia;
                • troca o rótulo do …_OBS para "Quer contar mais alguma coisa?" e cria o link
                  "Escrever mais sobre isso", que abre a caixa.
                Depois monta o alto (montarTopo) e troca "Prosseguir" por "Continuar".
     CUIDADO    O botão de incluir precisa se chamar exatamente "Adicionar", e o de gravar,
                "Prosseguir". Se forem renomeados no APEX, troque também aqui.
     PODE MEXER os textos 'Quer contar mais alguma coisa?', 'Escrever mais sobre isso',
                'Continuar', e o título e a frase do alto em montarTopo.
     VISUAL     Natcorp_Formacao.css › [C2] (alto), [C3] (listas), [C5] (Adicionar e
                "Mais informações")
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var LISTA = [], TOPO = null;
  function regiaoDe(obs) {
    /* o "Mais informações" mora numa sub-região "Observações"; a lista é a região de cima */
    var c = document.getElementById(P + obs + '_CONTAINER'), r = c && c.closest('.t-Region');
    var pai = r && r.parentElement && r.parentElement.closest('.t-Region');
    return pai && !pai.classList.contains('t-Region--noUI') ? { reg: pai, sub: r, cont: c } : null;
  }
  function montar() {
    ASSUNTOS.forEach(function (a) {
      var x = regiaoDe(a.obs);
      if (!x) return;
      var reg = x.reg;
      reg.classList.add('nc-fo-reg', 'nc-fo-reg--' + a.id);
      x.sub.classList.add('nc-fo-obs-reg');
      /* título e dica */
      var h = reg.querySelector(':scope > .t-Region-header');
      var t = h && h.querySelector('.t-Region-title');
      if (t && !t.getAttribute('data-nc-fo')) { t.textContent = a.titulo; t.setAttribute('data-nc-fo', '1'); }
      var tt = h && h.querySelector('.t-Region-headerItems--title');
      if (tt && !tt.querySelector('.nc-fo-dica')) tt.appendChild(el('span', 'nc-fo-dica', esc(a.dica)));
      /* o "Adicionar" da página: vai para o fim da lista, dizendo o quê */
      var add = [].filter.call(reg.querySelectorAll('.t-Button'), function (b) { return /^adicionar$/i.test(texto(b)) && !b.closest('.nc-fo-obs-reg'); })[0];
      var vaga = el('div', 'nc-fo-add');
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
      /* a sub-região Observações mora dentro da grade (container › row › col): a vaga entra
         antes do pedaço dela que é filho direto do corpo */
      var antes = x.sub;
      while (antes && antes.parentNode !== corpo) antes = antes.parentNode;
      if (!corpo || !antes) return;
      corpo.insertBefore(vaga, antes);
      if (add) {
        var l = add.querySelector('.t-Button-label') || add;
        l.textContent = 'Adicionar ' + a.um;
        add.classList.add('nc-fo-add-bt');
        if (!add.querySelector('.nc-fo-ic')) add.insertAdjacentHTML('afterbegin', svg(IC.mais));
        var velho = add.closest('.container');
        vaga.appendChild(add);
        /* a linha de onde ele saiu fica só com os espaçadores da grade: sai da vista */
        if (velho && !velho.querySelector('.t-Button, .t-Form-fieldContainer, .t-Region, a, input, select, textarea')) velho.classList.add('nc-fo-oculto');
      }
      var vazio = el('div', 'nc-fo-vazio');
      vazio.hidden = true;
      vazio.innerHTML = '<span class="nc-fo-vazio-ic">' + svg(IC[a.icone]) + '</span><p>' + esc(a.vazio) + '</p>';
      corpo.insertBefore(vazio, vaga);
      /* a lista da página vem antes dos dois (senão o vazio aparece em cima dela) */
      var lista = corpo.querySelector('.t-MediaList, .t-Report, table');
      var bl = lista; while (bl && bl.parentNode !== corpo) bl = bl.parentNode;
      if (bl && (bl.compareDocumentPosition(vazio) & Node.DOCUMENT_POSITION_PRECEDING)) corpo.insertBefore(bl, vazio);
      /* "Mais informações": rótulo que diz o que é; vazio, recolhido atrás de um link */
      renomear(a.obs, 'Quer contar mais alguma coisa?');
      var tx = document.getElementById(P + a.obs);
      if (tx) { tx.setAttribute('rows', '3'); tx.style.removeProperty('resize'); tx.addEventListener('input', function () { crescer(tx); }); }
      var abre = el('button', 'nc-fo-abre', svg(IC.texto) + '<span>Escrever mais sobre isso</span>');
      abre.type = 'button';
      x.sub.parentNode.insertBefore(abre, x.sub);
      var item = { a: a, reg: reg, sub: x.sub, cont: x.cont, tx: tx, add: add, vaga: vaga, vazio: vazio, abre: abre, aberto: false };
      abre.addEventListener('click', function () { item.aberto = true; atualizar(); if (tx) setTimeout(function () { tx.focus(); }, 30); });
      LISTA.push(item);
    });
    if (!LISTA.length) return;
    montarTopo();
    [].forEach.call(document.querySelectorAll('.t-Button'), function (b) {
      var l = b.querySelector('.t-Button-label');
      if (l && /^\s*prosseguir\s*$/i.test(l.textContent)) { l.textContent = 'Continuar'; b.classList.add('nc-fo-seguir'); }
    });
  }
  function montarTopo() {
    TOPO = el('div', 'nc-fo-topo');
    TOPO.innerHTML = '<h2 class="nc-fo-topo-tit">O que você estudou e o que sabe fazer</h2>' +
      '<p class="nc-fo-topo-txt">Coloque o que tiver. <b>Não precisa ter tudo</b>: o que não serve para você, deixe em branco.</p>' +
      '<nav class="nc-fo-atalhos" aria-label="Assuntos desta etapa"></nav>';
    var nav = TOPO.querySelector('.nc-fo-atalhos');
    LISTA.forEach(function (it) {
      var b = el('a', 'nc-fo-atalho');
      b.href = '#' + it.reg.id;
      b.innerHTML = '<span class="nc-fo-atalho-ic">' + svg(IC[it.a.icone]) + '</span><span class="nc-fo-atalho-txt"><span class="nc-fo-atalho-nome">' + esc(it.a.curto) + '</span><span class="nc-fo-atalho-n"></span></span>';
      b.addEventListener('click', function (e) {
        e.preventDefault();
        var y = it.reg.getBoundingClientRect().top + window.pageYOffset - alturaFixa() - 12;
        window.scrollTo({ top: Math.max(y, 0), behavior: 'smooth' });
      });
      it.atalho = b;
      nav.appendChild(b);
    });
    LISTA[0].reg.parentNode.insertBefore(TOPO, LISTA[0].reg);
  }
  function crescer(tx) {
    tx.style.setProperty('--nc-fo-h', '0px');
    tx.style.setProperty('--nc-fo-h', Math.min(Math.max(tx.scrollHeight + 2, 96), 320) + 'px');
  }

  /* ═══ [J4] OS CARTÕES DOS ITENS (refeitos a cada atualização da região) ══════════════════
     O QUE FAZ  Cada linha da Media List vira um cartão: ícone, nome, nível, detalhes,
                situação colorida e "Editar". O link original da linha continua sendo o toque
                (abre a janela de editar da página).
     COMO LÊ    título da linha   "<b>Nome</b> | nível"  → nome e nível
                descrição         pares "Rótulo: valor" separados por quebra de linha
                selo (badge)      a situação. Selo que vem como "#LIST_BADGE#" (não ligado no
                                  relatório) é ignorado.
     CUIDADO    Se o SQL da lista mudar esse formato (o "|" do título, o "Rótulo:" da
                descrição), o cartão mostra o texto inteiro sem separar.
     PODE MEXER a palavra 'Editar'. As cores da situação vêm das palavras: "não concluído/
                trancado/interrompido/incompleto" → amarelo; "cursando/andamento" → em curso;
                "concluído" → verde.
     VISUAL     Natcorp_Formacao.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function nivel(t) { for (var i = 0; i < NIVEIS.length; i++) if (NIVEIS[i][0].test(t)) return NIVEIS[i][1]; return 0; }
  function situacao(t) {
    if (!t) return '';
    var c = /n[aã]o\s+conclu|tranc|interromp|incomplet/i.test(t) ? 'meio' : /cursando|andamento/i.test(t) ? 'andando' : /conclu/i.test(t) ? 'ok' : 'neutro';
    return '<span class="nc-fo-sit nc-fo-sit--' + c + '">' + esc(t) + '</span>';
  }
  function prepararItem(li, it) {
    if (li.getAttribute('data-nc-fo')) return;
    var a = li.querySelector('.t-MediaList-itemWrap'); if (!a) return;
    li.setAttribute('data-nc-fo', '1');
    var h = li.querySelector('.t-MediaList-title'), d = li.querySelector('.t-MediaList-desc'), bd = li.querySelector('.t-MediaList-badge');
    /* o título vem "<b>Nome</b> | nível" */
    var nome = miudas(texto(h && h.querySelector('b')) || texto(h)), resto = '';
    if (h) { var m = /\|\s*(.+)$/.exec(texto(h)); if (m) resto = m[1].trim(); }
    /* a descrição vem em pares "Rótulo: <b>valor</b>" separados por <br> */
    var pares = [];
    if (d && !/#LIST_TEXT#/.test(d.textContent)) {
      d.innerHTML.split(/<br\s*\/?>/i).forEach(function (p) {
        var k = document.createElement('div'); k.innerHTML = p;
        var s = texto(k); if (!s) return;
        var mm = /^([^:]{1,40}):\s*(.*)$/.exec(s);
        pares.push(mm ? { r: DET[mm[1].trim().toLowerCase()] || mm[1], v: mm[2] } : { r: '', v: s });
      });
    }
    var nv = it.a.id === 'idiomas' ? nivel(resto) : 0;
    /* selo que o relatório não preencheu ("#LIST_BADGE#") não é situação */
    var sit = texto(bd); if (/^#.*#$/.test(sit)) sit = '';
    var novo = el('span', 'nc-fo-item');
    novo.innerHTML = '<span class="nc-fo-item-ic">' + svg(IC[it.a.icone]) + '</span>' +
      '<span class="nc-fo-item-txt"><span class="nc-fo-item-nome">' + esc(nome) + '</span>' +
      (resto ? '<span class="nc-fo-item-nivel">' + esc(resto) +
        (nv ? '<span class="nc-fo-pontos" aria-hidden="true">' + [1, 2, 3, 4].map(function (i) { return '<i' + (i <= nv ? ' class="is-on"' : '') + '></i>'; }).join('') + '</span>' : '') + '</span>' : '') +
      (pares.length ? '<span class="nc-fo-item-det">' + pares.map(function (p) { return '<span>' + (p.r ? '<span class="nc-fo-rot">' + esc(p.r) + '</span> ' : '') + esc(p.v) + '</span>'; }).join('') + '</span>' : '') +
      '</span>' +
      '<span class="nc-fo-item-lado">' + situacao(sit) + '<span class="nc-fo-editar">' + svg(IC.lapis) + 'Editar</span></span>';
    a.classList.add('nc-fo-item-a');
    a.setAttribute('aria-label', 'Editar ' + nome + (resto ? ', ' + resto : '') + (sit ? ', ' + sit : ''));
    a.appendChild(novo);
  }

  /* ═══ [J5] ATUALIZAR (roda de novo a cada mudança) ═══════════════════════════════════════
     O QUE FAZ  • transforma os itens novos em cartões ([J4]);
                • mostra ou esconde a vaga do "Adicionar" (se a página o esconde, a vaga some);
                • troca a mensagem de lista vazia da página pela nossa;
                • mostra o "Mais informações" se tiver texto ou se a pessoa pediu para
                  escrever; travado e vazio, some;
                • atualiza os contadores do alto ("4 itens", "nada ainda").
     PODE MEXER os textos 'Toque em “Adicionar …”', ' itens', ' item', 'nada ainda'.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function atualizar() {
    LISTA.forEach(function (it) {
      var itens = [].slice.call(it.reg.querySelectorAll('.t-MediaList-item'));
      itens.forEach(function (li) { prepararItem(li, it); });
      var n = itens.length;
      var podeAdd = !!(it.add && !oculto(it.add));
      classe(it.vaga, 'nc-fo-add--fora', !podeAdd);
      /* lista vazia: a mensagem da página dá lugar à nossa (que diz o que fazer) */
      [].forEach.call(it.reg.querySelectorAll('.t-Report-noDataMsg, .nodatafound, .a-IRR-noDataMsg, .t-MediaList-empty'), function (m) { m.classList.add('nc-fo-velho'); });
      it.vazio.hidden = n > 0;
      html(it.vazio.querySelector('p'), esc(it.a.vazio) + (podeAdd ? ' <b>Toque em “Adicionar ' + esc(it.a.um) + '”.</b>' : ''));
      /* "Mais informações" */
      var tx = it.tx, tem = !!(tx && tx.value.trim()), trav = !!(tx && tx.disabled);
      /* 04/10: obrigatório (o "Pintar Campos" da página põe is-required; "Valida Formacao_Obs/
         Curso_Obs" barram o Prosseguir) ou com erro de validação: a caixa fica à vista, nunca
         recolhida atrás do link — senão a pessoa não acha o campo que a página cobra */
      var cobra = !!(it.cont && (it.cont.classList.contains('is-required') || it.cont.classList.contains('is-error') ||
        it.cont.querySelector('.apex-page-item-error, [aria-invalid="true"]')));
      var mostra = tem || (cobra && !trav) || (it.aberto && !trav);
      classe(it.sub, 'nc-fo-oculto', !mostra);
      it.abre.hidden = mostra || trav;
      if (tx && mostra) crescer(tx);
      if (it.atalho) html(it.atalho.querySelector('.nc-fo-atalho-n'), n ? n + (n > 1 ? ' itens' : ' item') : 'nada ainda');
      if (it.atalho) classe(it.atalho, 'is-vazio', !n);
    });
  }

  /* ═══ [J6] O MAESTRO: QUANDO CADA PARTE RODA ═════════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a página abre: monta ([J3]), põe a marca nc-fo na
                página (é ela que liga o CSS) e atualiza ([J5]). Depois, atualiza de novo
                quando uma lista é recarregada, quando uma ação dinâmica traz dados do
                servidor e quando a página mostra/esconde/trava algo nas listas.
     CUIDADO    Não mude a ordem montar → nc-fo → atualizar.
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp formação] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var agendado = false, MO = null;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () {
      agendado = false;
      try { atualizar(); } catch (e) { if (window.console) console.warn('[Natcorp formação]', e); }
      if (MO) MO.takeRecords();
    });
  }
  function iniciar() {
    montar();
    if (!LISTA.length) return;
    document.body.classList.add('nc-fo');
    atualizar();
    $(document).on('apexafterrefresh', agendar);
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    if (window.MutationObserver) {
      /* as ações da página mostram/escondem o Adicionar e travam o "Mais informações" */
      MO = new MutationObserver(agendar);
      LISTA.forEach(function (it) { MO.observe(it.reg, { attributes: true, subtree: true, childList: true, attributeFilter: ['style', 'disabled'] }); });
    }
    setTimeout(agendar, 700);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
