/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE PPP / LAUDO  —  o "arrumador" da tela (JavaScript)               ║
   ║  App 2943 · Página 61 · a janela aberta pela aba "Requisição de PPP" do Painel            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Nesta janela o gestor pede um documento de saúde e segurança do trabalho para um
   colaborador — PPP, LTCAT, laudo ou perícia. Depois, o Médico do Trabalho e o Técnico de
   Segurança do Trabalho analisam e registram o andamento ("Desdobramentos").
   Quando a janela abre, este arquivo REORGANIZA o que o APEX já desenhou:
     PEDIDO NOVO
       • uma abertura que diz o que é e o caminho do pedido (você pede → o Médico e o Técnico
         analisam → o documento fica pronto aqui);
       • três passos: "Para quem é?" (empresa e colaborador) · "O que você precisa?" (a lista
         "Objeto da Solicitação" vira CARTÕES com o nome por extenso e para que serve — PPP,
         LTCAT, LI, Perícia) · "Conte mais e anexe" (opcional);
       • o rodapé diz o que falta; "Criar" aparece como "Enviar pedido".
     PEDIDO GRAVADO
       • um cabeçalho com nº, situação em cor, para quem, o que foi pedido, quem pediu e quando
         — no lugar dos sete campos soltos do alto;
       • as abas (Detalhes · Aprovadores · Desdobramentos) viram uma página só, na ordem de
         leitura: o que foi pedido, a aprovação e o ACOMPANHAMENTO do Médico e do Técnico.
     O título da janela troca "Criar/Editar: Requisição de PPP / Laudo" por "Pedir PPP ou
     laudo" / "Pedido nº …".

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: o APEX continua dono de tudo
       (itens, abas, botões, ações e processos).
     • Quando um cartão é tocado, ele só escolhe a opção na lista VERDADEIRA do APEX
       (apex.item().setValue): as ações dinâmicas da página rodam como sempre.
     • Se este arquivo for retirado da página, a janela volta ao visual padrão do APEX e
       continua funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 61 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_PPP.js   (no FIM da lista)
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_PPP.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Esta página NÃO usa classes no APEX. O arquivo reconhece a página pelos itens
   …_TIPO_SOLICITACAO e …_MATRICULA_SOLICITADO (sem eles, não faz nada) e acha o resto:
     • os itens pelos nomes (COD_REQ, COD_EMP_SOLICITADO, OBSERVACAO, ARQUIVO, COD_SIT_REQ…);
     • as regiões "Desdobramentos" e "Aprovadores" pelo TÍTULO da região;
     • a aprovação pelo relatório com a coluna APROVADOR;
     • os botões pelo nome estático (CREATE, SAVE) ou pelo texto (Criar, Salvar, Cancelar).
   Se um desses nomes ou títulos mudar no APEX, mude também aqui (veja [J3]).

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Configuração ........................ ícones e os cartões dos documentos  PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  A página ............................ as regiões que o arquivo procura    CUIDADO
     [J4]  A abertura (pedido novo) ............ "Pedir PPP ou laudo" e o caminho    PODE MEXER
     [J5]  Os passos e os cartões .............. "Para quem é?", "O que você precisa?" PODE MEXER
     [J6]  Uma página só e o acompanhamento .... as abas somem; Desdobramentos       PODE MEXER
     [J7]  O cabeçalho do pedido gravado ....... nº, situação, para quem, quem pediu
     [J8]  A aprovação ......................... o caminho de quem aprova           PODE MEXER
     [J9]  O rodapé ............................ "Enviar pedido" e o que falta       PODE MEXER
     [J10] Só leitura .......................... some o que está vazio
     [J11] O título da janela .................. "Pedir PPP ou laudo" / "Pedido nº…"  PODE MEXER
     [J12] O maestro ........................... decide QUANDO cada parte é montada  CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Conte mais e anexe'  →  'Detalhes e anexo'
     Quero mudar a explicação de um documento (PPP, LTCAT, LI, Perícia)  → [J1], lista OBJETOS
     Criei um tipo de documento novo na lista "Objeto da Solicitação"
       → ele já aparece sozinho como cartão, só com o texto da lista. Para ganhar nome por
         extenso, ícone e explicação, copie um bloco da lista OBJETOS em [J1] e troque o código
         (o VALOR da opção na lista do APEX) e os textos.
     Quero mudar o nome de um campo na tela (ex.: "Documento")      → [J5], as linhas renomear(…)
     Renomeei a região "Desdobramentos" ou "Aprovadores" no APEX
       → [J3]: troque o título entre aspas em regPorTitulo('…'), senão a parte some do desenho.
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
     P + 'OBSERVACAO'     junta os textos: vira 'P61_OBSERVACAO', o nome do item no APEX.
                            (Aqui o P é descoberto sozinho: veja o começo do código.)
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: esta linha impede que o arquivo rode duas vezes (se a URL estiver repetida na
     página, por exemplo) e que rode fora do APEX. Não apague. */
  if (window.__ncPPP || !window.apex || !window.apex.jQuery) return;
  /* O começo do nome dos itens (P) é DESCOBERTO sozinho, a partir do item …_TIPO_SOLICITACAO:
     se a página for copiada para outro número, não é preciso mudar nada aqui. Sem esse item
     e sem o …_MATRICULA_SOLICITADO, o arquivo entende que não está na página certa e para. */
  var achado = document.querySelector('[id$="_TIPO_SOLICITACAO_CONTAINER"]');
  if (!achado) return;
  var P = achado.id.replace(/TIPO_SOLICITACAO_CONTAINER$/, '');
  if (!document.getElementById(P + 'MATRICULA_SOLICITADO_CONTAINER')) return;
  window.__ncPPP = true;

  var $ = apex.jQuery;
  /* ═══ [J1] CONFIGURAÇÃO: ÍCONES E OS CARTÕES DOS DOCUMENTOS ═══════════════════════════════
     O QUE É    IC são os ícones (desenhos pequenos, no formato SVG; não precisa mexer).
                OBJETOS diz como cada documento da lista "Objeto da Solicitação" aparece no
                cartão: nome curto, nome por extenso, ícone e "para que serve".
     IMPORTANTE Muda SÓ o que aparece no cartão. O valor gravado continua o código da lista.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var IC = {
    pessoa: '<circle cx="12" cy="8" r="3.6"/><path d="M4.5 20c.9-3.9 3.9-6 7.5-6s6.6 2.1 7.5 6"/>',
    doc: '<path d="M6.5 3h7.5l4.5 4.5V19a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2z"/><path d="M13.5 3v5h5"/><path d="M8.5 13.5h7M8.5 17h5"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    seta: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    medico: '<path d="M6 3.5v5a4 4 0 0 0 8 0v-5"/><path d="M10 12.5v2.5a4.5 4.5 0 0 0 9 0v-2"/><circle cx="19" cy="11" r="2"/>',
    capacete: '<path d="M4 16.5h16"/><path d="M5.5 16.5a6.5 6.5 0 0 1 13 0"/><path d="M12 6v4M9 7.5v3M15 7.5v3"/><path d="M3.5 19.5h17"/>',
    historia: '<path d="M4 5h16v14H4z"/><path d="M8 9h8M8 12.5h8M8 16h5"/>',
    fabrica: '<path d="M3.5 20V10l5 3V10l5 3V6l6 3v11z"/><path d="M8 17h2M12.5 17h2"/>',
    termometro: '<path d="M10 4a2 2 0 0 1 4 0v10a4 4 0 1 1-4 0z"/><path d="M12 9v7"/>',
    balanca: '<path d="M12 4v16M6 20h12M5 8h14"/><path d="M5 8l-2.5 6a3 3 0 0 0 5 0zM19 8l-2.5 6a3 3 0 0 0 5 0z"/>'
  };
  /* PODE MEXER: o que cada documento é, com palavras simples (código da lista → cartão).
       CÓDIGO: { nome: 'curto', longo: 'por extenso', ic: IC.um-ícone, para: 'para que serve' }
     CUIDADO: o CÓDIGO (PPP, LTCAT, LI, PRCA) é o VALOR da opção na lista do APEX: não troque,
     só os textos. Código que não estiver aqui vira cartão só com o texto da lista. */
  var OBJETOS = {
    PPP: { nome: 'PPP', longo: 'Perfil Profissiográfico Previdenciário', ic: IC.historia,
      para: 'A história da pessoa no trabalho: onde trabalhou, o que fazia e a que riscos ficou exposta. Pedido para o INSS, em geral quando a pessoa sai da empresa ou vai se aposentar.' },
    LTCAT: { nome: 'LTCAT', longo: 'Laudo Técnico das Condições do Ambiente de Trabalho', ic: IC.fabrica,
      para: 'O laudo do LOCAL de trabalho: barulho, calor, poeira, produtos químicos. É a base que o PPP usa.' },
    LI: { nome: 'LI', longo: 'Laudo de Insalubridade', ic: IC.termometro,
      para: 'Diz se a atividade faz mal à saúde e se dá direito ao adicional de insalubridade.' },
    PRCA: { nome: 'Perícia', longo: 'Perícia técnica', ic: IC.balanca,
      para: 'Uma avaliação feita pelo especialista no local de trabalho, em geral para um processo ou uma dúvida específica.' }
  };

  /* ═══ [J2] FERRAMENTAS ════════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('ITEM')      o que o APEX GUARDA no item (o código da opção)
       txt('ITEM')      o que a PESSOA VÊ no item (o nome da opção escolhida numa lista)
       cont('ITEM')     o bloco inteiro do campo na tela (rótulo + campo)
       renomear('ITEM', 'Novo nome')   troca só o TEXTO do rótulo do campo na tela
       bonito(texto)    arruma maiúsculas e põe os acentos que o banco não tem
                        ("Concluida" → "Concluída")
     PODE MEXER a lista de palavras acentuadas dentro de bonito(), se aparecer outra sem acento.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-ppp-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function cont(n) { return document.getElementById(P + n + '_CONTAINER'); }
  function limpo(t) { t = String(t || '').replace(/\s+/g, ' ').trim(); return /^[-–—]?$/.test(t) ? '' : t; }
  function val(n) { if (!document.getElementById(P + n)) return ''; try { return limpo(apex.item(P + n).getValue()); } catch (x) { return ''; } }
  function txt(n) {
    var e = document.getElementById(P + n); if (!e) return '';
    if (e.tagName === 'SELECT') return e.selectedIndex >= 0 && e.value ? limpo(e.options[e.selectedIndex].text) : '';
    if (/^(INPUT|TEXTAREA)$/.test(e.tagName) && e.type !== 'hidden') return limpo(e.value);
    var d = document.getElementById(P + n + '_DISPLAY'); if (d) return limpo(d.textContent);
    var c = cont(n), s = c && c.querySelector('.display_only');
    return s ? limpo(s.textContent) : limpo(e.value || e.textContent);
  }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim(); }
  function bonito(t) {
    t = String(t || '').trim();
    if (t && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t)) t = t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); });
    t = t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); });
    /* a lista de situações vem sem acento do banco */
    return t.replace(/\b(Concluid|Em Analis|Em analis|Aprovaca|Requisica|Solicitaca|Pericia|Tecnic|Medic)(\w*)/g, function (m, r, f) {
      return ({ Concluid: 'Concluíd', 'Em Analis': 'Em anális', 'Em analis': 'Em anális', Aprovaca: 'Aprovaçã', Requisica: 'Requisiçã', Solicitaca: 'Solicitaçã', Pericia: 'Perícia', Tecnic: 'Técnic', Medic: 'Médic' })[r] + f;
    });
  }
  function iniciais(n) { var p = String(n || '').split(/\s+/).filter(Boolean); return ((p[0] || '').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  function renomear(n, t) {
    var l = document.getElementById(P + n + '_LABEL');
    if (!l || l.getAttribute('data-nc-ppp') === t) return;
    for (var i = 0; i < l.childNodes.length; i++) {
      var x = l.childNodes[i];
      if (x.nodeType === 3 && x.textContent.trim()) { x.textContent = t + ' '; l.setAttribute('data-nc-ppp', t); return; }
    }
  }
  function botaoPorTexto(re) {
    return [].filter.call(document.querySelectorAll('button.t-Button, a.t-Button'), function (b) {
      return re.test(b.getAttribute('data-nc-ppp-orig') || b.textContent.replace(/\s+/g, ' ').trim());
    })[0];
  }
  function rotuloBotao(b, t) {
    if (!b) return;
    if (!b.getAttribute('data-nc-ppp-orig')) b.setAttribute('data-nc-ppp-orig', b.textContent.replace(/\s+/g, ' ').trim());
    var l = b.querySelector('.t-Button-label');
    if (l && l.textContent !== t) l.textContent = t;
  }
  function aVista(e) { return !!(e && (e.offsetParent || e.getClientRects().length)); }

  /* ═══ [J3] A PÁGINA: AS REGIÕES QUE O ARQUIVO PROCURA ═════════════════════════════════════
     O QUE FAZ  Descobre, uma vez, as peças da página:
       PEDIDO   é um pedido já gravado? (tem P…_COD_REQ preenchido)
       TOPO     os campos do alto (empresa, colaborador…)
       DET      a região "Detalhes" (a do item …_TIPO_SOLICITACAO)
       DESD     a região cujo TÍTULO é "Desdobramentos"
       APREG    a região cujo TÍTULO é "Aprovadores"
       MENU     a barra de abas
     CUIDADO    As regiões são achadas pelo título EXATO. Se o título mudar no APEX, troque o
                texto entre aspas em regPorTitulo('…') abaixo.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PEDIDO = !!val('COD_REQ');
  /* os campos do alto: o .container dos itens (a mesma região também guarda, num segundo .container, as abas) */
  var TOPO = cont('COD_EMP_SOLICITADO') ? cont('COD_EMP_SOLICITADO').closest('.container') : null;
  var DET = achado.closest('.t-Region');
  function regPorTitulo(t) { return [].filter.call(document.querySelectorAll('.t-Region'), function (r) { var h = r.querySelector(':scope > .t-Region-header .t-Region-title'); return h && h.textContent.trim() === t; })[0]; }
  var DESD = regPorTitulo('Desdobramentos');
  var APREG = regPorTitulo('Aprovadores');
  var MENU = document.querySelector('.apex-tabs-region');
  var CRIAR, SALVAR, LEITURA;

  /* ═══ [J4] A ABERTURA (PEDIDO NOVO) ═══════════════════════════════════════════════════════
     O QUE FAZ  Num pedido novo, põe no alto "Pedir PPP ou laudo", uma frase e o caminho do
                pedido em 3 etapas. passo() desenha o título numerado de cada passo.
     PODE MEXER todos os textos entre aspas.
     VISUAL     Natcorp_PPP.css › [C2] (abertura) e [C3] (passos)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarAbertura() {
    if (PEDIDO || !TOPO) return;
    var a = el('section', 'nc-ppp-abertura');
    a.innerHTML = '<h1 class="nc-ppp-abertura-tit">Pedir PPP ou laudo</h1>' +
      '<p>Peça um documento de saúde e segurança do trabalho para um colaborador.</p>' +
      '<ol class="nc-ppp-caminho-pedido">' +
        '<li><span class="nc-ppp-cp-ic">' + svg(IC.lapis) + '</span><span><b>Você pede</b>aqui, em 3 passos</span></li>' +
        '<li><span class="nc-ppp-cp-ic">' + svg(IC.medico) + '</span><span><b>O Médico e o Técnico</b>de Segurança do Trabalho analisam</span></li>' +
        '<li><span class="nc-ppp-cp-ic">' + svg(IC.doc) + '</span><span><b>O documento</b>fica pronto neste pedido</span></li>' +
      '</ol>';
    TOPO.parentNode.insertBefore(a, TOPO);
  }
  function passo(n, t, sub) {
    var h = el('div', 'nc-ppp-passo');
    h.innerHTML = '<span class="nc-ppp-passo-n">' + n + '</span><span class="nc-ppp-passo-txt"><span class="nc-ppp-passo-t">' + esc(t) + '</span>' + (sub ? '<span class="nc-ppp-passo-sub">' + esc(sub) + '</span>' : '') + '</span>';
    return h;
  }

  /* ═══ [J5] OS PASSOS E OS CARTÕES DO DOCUMENTO ════════════════════════════════════════════
     O QUE FAZ  • montarQuem: passo 1, "Para quem é?" (Empresa e Colaborador).
                • montarObjeto: passos 2 e 3, os nomes dos campos e o exemplo dentro da caixa
                  de observação.
                • desenharObjeto: a lista "Objeto da Solicitação" vira cartões (textos da lista
                  OBJETOS, em [J1]). Tocar num cartão escolhe a opção na lista verdadeira.
                  Num pedido só para leitura, mostra só o documento pedido.
     LÊ DOS ITENS  …_COD_EMP_SOLICITADO, …_MATRICULA_SOLICITADO, …_TIPO_SOLICITACAO,
                …_OBSERVACAO, …_ARQUIVO
     PODE MEXER os títulos dos passos, os nomes em renomear('ITEM', 'Nome') e o exemplo
                ('Ex.: o colaborador vai sair…').
     VISUAL     Natcorp_PPP.css › [C3] (passos) e [C4] (cartões)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarQuem() {
    if (!TOPO || PEDIDO) return;
    TOPO.classList.add('nc-ppp-quem');
    TOPO.insertBefore(passo(1, 'Para quem é?', 'A empresa e o colaborador que vai receber o documento.'), TOPO.firstChild);
    renomear('COD_EMP_SOLICITADO', 'Empresa');
    renomear('MATRICULA_SOLICITADO', 'Colaborador');
  }

  /* ---------- 2. o que precisa: os cartões ---------- */
  var CARTOES;
  function montarObjeto() {
    if (!DET) return;
    DET.classList.add('nc-ppp-det');
    var linhaTipo = achado.closest('.row');
    var obs = cont('OBSERVACAO'), linhaObs = obs && obs.closest('.row');
    if (!PEDIDO && linhaTipo) linhaTipo.parentNode.insertBefore(passo(2, 'O que você precisa?', 'Toque no documento. Na dúvida, fale com o RH.'), linhaTipo);
    if (!PEDIDO && linhaObs) linhaObs.parentNode.insertBefore(passo(3, 'Conte mais e anexe', 'Não é obrigatório, mas ajuda o Médico e o Técnico a fazer mais rápido.'), linhaObs);
    renomear('TIPO_SOLICITACAO', 'Documento');
    renomear('OBSERVACAO', 'O que o Médico e o Técnico precisam saber?');
    renomear('ARQUIVO', 'Anexar um documento');
    var o = document.getElementById(P + 'OBSERVACAO');
    if (o && !PEDIDO && !o.getAttribute('placeholder')) o.setAttribute('placeholder', 'Ex.: o colaborador vai sair da empresa e pediu o PPP. Trabalhou na pintura de 2019 a 2024.');
    var sel = document.getElementById(P + 'TIPO_SOLICITACAO');
    var ic = achado.querySelector('.t-Form-inputContainer') || achado;
    CARTOES = el('div', 'nc-ppp-cartoes');
    CARTOES.setAttribute('role', 'radiogroup');
    ic.appendChild(CARTOES);
    achado.classList.add('nc-ppp-objeto');
    CARTOES.addEventListener('click', function (e) {
      var b = e.target.closest('[data-v]'); if (!b || !sel || sel.tagName !== 'SELECT' || sel.disabled) return;
      if (sel.value !== b.getAttribute('data-v')) apex.item(sel.id).setValue(b.getAttribute('data-v'));
      agendar();
    });
  }
  function desenharObjeto() {
    if (!CARTOES) return;
    var sel = document.getElementById(P + 'TIPO_SOLICITACAO');
    var escolhivel = sel && sel.tagName === 'SELECT' && !sel.disabled;
    classe(achado, 'nc-ppp-objeto--leitura', !escolhivel);
    var atual = val('TIPO_SOLICITACAO');
    var ops = escolhivel ? [].filter.call(sel.options, function (x) { return x.value; }).map(function (x) { return { v: x.value, t: x.text }; }) : (atual ? [{ v: atual, t: txt('TIPO_SOLICITACAO') }] : []);
    html(CARTOES, ops.map(function (x) {
      var d = OBJETOS[x.v] || { nome: x.t, longo: '', para: '', ic: IC.doc };
      var on = x.v === atual;
      return '<button type="button" class="nc-ppp-cartao' + (on ? ' is-on' : '') + '" role="radio" aria-checked="' + on + '" data-v="' + esc(x.v) + '"' + (escolhivel ? '' : ' tabindex="-1"') + '>' +
        '<span class="nc-ppp-cartao-ic">' + svg(d.ic) + '</span>' +
        '<span class="nc-ppp-cartao-txt"><span class="nc-ppp-cartao-nome">' + esc(d.nome) + '</span>' + (d.longo ? '<span class="nc-ppp-cartao-longo">' + esc(d.longo) + '</span>' : '') +
        (d.para ? '<span class="nc-ppp-cartao-para">' + esc(d.para) + '</span>' : '') + '</span>' +
        '<span class="nc-ppp-cartao-marca" aria-hidden="true">' + svg(IC.ok) + '</span></button>';
    }).join(''));
  }

  /* ═══ [J6] AS ABAS VIRAM UMA PÁGINA SÓ, E O ACOMPANHAMENTO ════════════════════════════════
     O QUE FAZ  • montarPagina: esconde a barra de abas (as regiões ficam uma embaixo da outra),
                  muda o título "Desdobramentos" para "Acompanhamento" e "Detalhes" para "O que
                  foi pedido".
                • consertarComentarios: na lista de desdobramentos, o ícone do usuário aparece
                  como texto quebrado (defeito da consulta da região, coluna user_icon — veja o
                  PPP-MANUTENCAO.md); aqui ele vira as iniciais de quem escreveu. Antes de o
                  pedido existir, o Acompanhamento não aparece.
     CUIDADO    O botão "Adicionar desdobramento" é achado pelo ID B72086954749258609180 ou,
                se ele mudar, pelo texto. Se o botão for recriado no APEX, o texto ainda acha.
     PODE MEXER os textos 'Acompanhamento', 'O que foi pedido', 'O Médico e o Técnico ainda
                não registraram nada…'.
     VISUAL     Natcorp_PPP.css › [C1] (as abas) e [C6] (acompanhamento)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarPagina() {
    if (MENU) MENU.classList.add('nc-ppp-sem-abas');
    if (DESD) {
      DESD.classList.add('nc-ppp-acomp');
      var t = DESD.querySelector(':scope > .t-Region-header .t-Region-title'); if (t) t.textContent = 'Acompanhamento';
      var corpo = DESD.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
      if (corpo && !corpo.querySelector('.nc-ppp-acomp-sub')) corpo.insertBefore(el('p', 'nc-ppp-acomp-sub', 'O que o Médico do Trabalho e o Técnico de Segurança registraram neste pedido.'), corpo.firstChild);
    }
    if (DET) { var td = DET.querySelector(':scope > .t-Region-header .t-Region-title'); if (td && PEDIDO) td.textContent = 'O que foi pedido'; }
  }
  /* a lista de desdobramentos mostra o HTML do ícone como texto: vira as iniciais de quem escreveu */
  function consertarComentarios() {
    if (!DESD) return;
    [].forEach.call(DESD.querySelectorAll('.t-Comments-item'), function (li) {
      var ic = li.querySelector('.t-Comments-userIcon'), info = li.querySelector('.t-Comments-info');
      if (!ic || ic.getAttribute('data-nc-ppp')) return;
      var nome = info ? limpo(info.childNodes[0] && info.childNodes[0].textContent) : '';
      if (/<|&lt;|aria-hidden/i.test(ic.textContent) || !limpo(ic.textContent)) ic.textContent = iniciais(nome) || '·';
      ic.setAttribute('data-nc-ppp', '1');
      var ac = li.querySelector('.t-Comments-actions'); if (ac && !limpo(ac.textContent)) ac.classList.add('nc-ppp-fora');
    });
    /* antes de o pedido existir não há o que acompanhar; depois, a lista vazia diz o que vai aparecer ali */
    classe(DESD, 'nc-ppp-acomp--vazio', !PEDIDO);
    var nd = DESD.querySelector('.nodatafound');
    if (nd && !nd.getAttribute('data-nc-ppp')) { nd.setAttribute('data-nc-ppp', '1'); nd.textContent = 'O Médico e o Técnico ainda não registraram nada. Quando registrarem, aparece aqui.'; }
    var b = document.getElementById('B72086954749258609180') || botaoPorTexto(/adicionar desdobramento/i);
    if (b) rotuloBotao(b, 'Adicionar desdobramento');
  }

  /* ═══ [J7] O CABEÇALHO DO PEDIDO GRAVADO ══════════════════════════════════════════════════
     O QUE FAZ  Num pedido gravado, põe no alto: "Pedido nº …", a situação num selo colorido,
                o documento, para quem (nome e matrícula), quando foi pedido e por quem.
                Cores do selo: aprovada/concluída = verde · reprovada = vermelho ·
                cancelada/suspensa = neutro · o resto = amarelo (esperando).
     LÊ DOS ITENS  …_COD_REQ, …_COD_SIT_REQ, …_TIPO_SOLICITACAO, …_MATRICULA_SOLICITADO,
                …_SOLICITANTE, …_DT_REQ, …_DT_SIT_REQ
     CUIDADO    A cor do selo é escolhida pelo NOME da situação (procura "aprov", "reprov"…).
     VISUAL     Natcorp_PPP.css › [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var HERO;
  function montarPedido() {
    if (!PEDIDO || !TOPO) return;
    HERO = el('section', 'nc-ppp-hero');
    TOPO.parentNode.insertBefore(HERO, TOPO);
  }
  function desenharPedido() {
    if (!HERO) return;
    var sit = txt('COD_SIT_REQ');
    var tom = /aprov|conclu/i.test(sit) ? 'bom' : /reprov/i.test(sit) ? 'ruim' : /cancel|suspens/i.test(sit) ? 'neutro' : 'espera';
    var obj = OBJETOS[val('TIPO_SOLICITACAO')] || { nome: txt('TIPO_SOLICITACAO'), longo: '' };
    var col = bonito(semCodigo(txt('MATRICULA_SOLICITADO'))), mat = (txt('MATRICULA_SOLICITADO').match(/^\s*(\d+)/) || [])[1] || val('MATRICULA_SOLICITADO');
    var sol = txt('SOLICITANTE').split(/\s*\/\s*/);
    var quem = bonito(semCodigo(sol[1] || sol[0] || ''));
    html(HERO, '<div class="nc-ppp-hero-topo"><p class="nc-ppp-hero-n">Pedido nº <b>' + esc(val('COD_REQ')) + '</b></p>' +
      (sit ? '<span class="nc-ppp-sit nc-ppp-sit--' + tom + '">' + esc(bonito(sit)) + '</span>' : '') + '</div>' +
      '<h2 class="nc-ppp-hero-tit">' + esc(obj.nome || 'PPP / laudo') + (obj.longo ? ' <span>· ' + esc(obj.longo) + '</span>' : '') + '</h2>' +
      (col ? '<p class="nc-ppp-hero-para">' + svg(IC.pessoa) + '<span>Para <b>' + esc(col) + '</b>' + (mat ? ' · matrícula ' + esc(mat) : '') + '</span></p>' : '') +
      '<p class="nc-ppp-hero-quem">Pedido em <b>' + esc(txt('DT_REQ') || val('DT_REQ')) + '</b>' + (quem ? ' por <b>' + esc(quem) + '</b>' : '') +
        (txt('DT_SIT_REQ') && txt('DT_SIT_REQ') !== txt('DT_REQ') ? ' · situação desde ' + esc(txt('DT_SIT_REQ')) : '') + '</p>');
  }

  /* ═══ [J8] A APROVAÇÃO: O CAMINHO (O MESMO DAS OUTRAS REQUISIÇÕES) ════════════════════════
     O QUE FAZ  Transforma o relatório "Aprovadores" numa faixa: cada aprovador com um sinal
                (aprovou, reprovou, sua vez/aguardando, na fila) e um resumo do tipo
                "1 de 2 · aguardando Maria". Para quem aprova, os botões Aprovar/Reprovar do
                APEX vêm para dentro da faixa ("Confira o pedido e decida.").
     LÊ DE      as colunas do relatório: APROVADOR, DATA, STATUS e JUSTIFICATIVA.
     CUIDADO    Se uma dessas colunas for renomeada no relatório do APEX, a faixa não acha os
                dados. Os botões são achados pelo texto exato "Aprovar" / "Reprovar".
     PODE MEXER os textos 'Aprovação', 'Ver o caminho', 'Sua vez', 'Na fila'…
     VISUAL     Natcorp_PPP.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var AP = null, AP_ABERTO = false, AP_ASSIN = '';
  function nomeAprovador(t) { var m = /^\s*\d+\s*-\s*\d+\s*-\s*(.+)$/.exec(t || ''); return bonito(m ? m[1] : t).replace(/(^|\s)(\S)/g, function (x, a, b) { return a + b.toUpperCase(); }).replace(/\s(De|Da|Do|Das|Dos|E)(?=\s)/g, function (x) { return x.toLowerCase(); }); }
  function montarAprovacao() {
    if (!AP) {
      var th = document.querySelector('table.t-Report-report th#APROVADOR, td[headers="APROVADOR"]');
      var reg = th && th.closest('.t-Region');
      if (!reg) return;
      AP = { reg: reg, botoes: [].slice.call(document.querySelectorAll('button.t-Button, a.t-Button')).filter(function (b) { return /^(aprovar|reprovar)$/i.test(b.textContent.trim()); }) };
      reg.classList.add('nc-ppp-aprov');
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
      AP.box = el('div', 'nc-ppp-ap');
      corpo.insertBefore(AP.box, corpo.firstChild);
      AP.box.addEventListener('click', function (e) { if (e.target.closest('.nc-ppp-ap-ver')) { AP_ABERTO = !AP_ABERTO; AP_ASSIN = ''; agendar(); } });
    }
    var passos = [].slice.call(AP.reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; }
      var st = c('STATUS');
      return { nome: nomeAprovador(c('APROVADOR')), data: c('DATA'), just: c('JUSTIFICATIVA'), estado: /^r$|reprov|recus/i.test(st) ? 'nao' : /^a$|aprov/i.test(st) ? 'ok' : 'pend' };
    }).filter(function (x) { return x.nome; });
    var n = passos.length;
    classe(AP.reg, 'nc-ppp-aprov--vazio', !n);
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
    classe(AP.reg, 'nc-ppp-ap-aberto', AP_ABERTO);
    AP.box.className = 'nc-ppp-ap nc-ppp-ap--' + estado;
    AP.box.innerHTML = '<p class="nc-ppp-ap-rot">Aprovação</p><div class="nc-ppp-ap-cab"><p class="nc-ppp-ap-resumo">' + resumo + '</p>' +
        '<button type="button" class="nc-ppp-ap-ver" aria-expanded="' + AP_ABERTO + '">' + (AP_ABERTO ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
      '<ol class="nc-ppp-ap-passos">' + passos.map(function (x, i) {
        var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === atual && !cancelado ? 'is-vez' : 'is-fila';
        var dia = x.data.replace(/\s.*$/, '');
        var st = x.estado === 'ok' ? (dia || 'Aprovou') : x.estado === 'nao' ? 'Reprovou' + (dia ? ' · ' + dia : '') : cls === 'is-vez' ? (vez ? 'Sua vez' : 'Aguardando') : 'Na fila';
        var ic = x.estado === 'ok' ? '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>' : x.estado === 'nao' ? '<path d="M8 8l8 8M16 8l-8 8"/>' : cls === 'is-vez' ? '<path d="M12 8v4l2.5 1.5"/>' : '';
        return '<li class="nc-ppp-ap-p ' + cls + '" title="' + esc(x.nome + (x.just ? ': "' + x.just + '"' : '')) + '"><span class="nc-ppp-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
          '<span class="nc-ppp-ap-texto"><span class="nc-ppp-ap-nome">' + esc(x.nome) + '</span><span class="nc-ppp-ap-estado">' + esc(st) + '</span></span></li>';
      }).join('') + '</ol>' +
      (vez ? '<div class="nc-ppp-decisao"><p class="nc-ppp-decisao-txt">Confira o pedido e decida.</p><div class="nc-ppp-decisao-botoes"></div></div>' : '') +
      (passos.some(function (x) { return x.just; }) ? '<div class="nc-ppp-ap-justs">' + passos.filter(function (x) { return x.just; }).map(function (x) {
        return '<blockquote class="nc-ppp-ap-just' + (x.estado === 'nao' ? ' is-nao' : '') + '"><b>' + esc(x.nome) + ':</b> ' + esc(x.just) + '</blockquote>'; }).join('') + '</div>' : '');
    var dest = AP.box.querySelector('.nc-ppp-decisao-botoes');
    if (dest) bts.slice().sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) { b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-ppp-reprovar' : 'nc-ppp-aprovar'); dest.appendChild(b); });
  }

  /* ═══ [J9] O RODAPÉ: O QUE FALTA E "ENVIAR PEDIDO" ════════════════════════════════════════
     O QUE FAZ  Troca o texto dos botões ("Criar" → "Enviar pedido", "Salvar" → "Salvar
                alterações", "Cancelar" → "Cancelar este pedido" — são os mesmos botões) e, acima
                deles, mostra o que falta: Empresa, Colaborador, O documento. Tocar leva ao campo.
                Sem nada faltando: "Tudo certo. Pode enviar."
     CUIDADO    A lista do que falta é FIXA (os três campos em desenharRodape). Se outro campo
                virar obrigatório no APEX, acrescente uma linha igual às de lá.
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_PPP.css › [C9]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FALTA;
  function montarRodape() {
    CRIAR = document.getElementById('CREATE') || botaoPorTexto(/^criar$/i);
    SALVAR = document.getElementById('SAVE') || botaoPorTexto(/^salvar$/i);
    rotuloBotao(CRIAR, 'Enviar pedido');
    rotuloBotao(SALVAR, 'Salvar alterações');
    rotuloBotao(botaoPorTexto(/^cancelar$/i), 'Cancelar este pedido');
    if (!CRIAR) return;
    /* os botões ficam no pé da região Detalhes (ou, em outra versão da página, no rodapé da janela) */
    var rb = CRIAR.closest('.t-Region-buttons'), col = CRIAR.closest('.t-ButtonRegion');
    col = col && col.querySelector('.t-ButtonRegion-col--content');
    if (!rb && !col) return;
    FALTA = el('div', 'nc-ppp-falta');
    FALTA.setAttribute('aria-live', 'polite');
    if (rb) rb.parentNode.insertBefore(FALTA, rb); else col.appendChild(FALTA);
    FALTA.addEventListener('click', function (e) {
      var b = e.target.closest('[data-ir]'); if (!b) return;
      var c = cont(b.getAttribute('data-ir')); if (!c) return;
      c.scrollIntoView({ behavior: 'smooth', block: 'center' });
      var bt = c.querySelector('.a-Button--popupLOV, button.nc-ppp-cartao');
      if (bt) setTimeout(function () { bt.click(); }, 350);
    });
  }
  function desenharRodape() {
    if (!FALTA) return;
    var f = [];
    if (!val('COD_EMP_SOLICITADO')) f.push(['COD_EMP_SOLICITADO', 'Empresa']);
    if (!val('MATRICULA_SOLICITADO')) f.push(['MATRICULA_SOLICITADO', 'Colaborador']);
    if (!val('TIPO_SOLICITACAO')) f.push(['TIPO_SOLICITACAO', 'O documento']);
    html(FALTA, f.length ? '<span class="nc-ppp-falta-rot">Falta:</span>' + f.map(function (x) { return '<button type="button" class="nc-ppp-falta-item" data-ir="' + x[0] + '">' + esc(x[1]) + '</button>'; }).join('')
      : '<span class="nc-ppp-falta-ok">' + svg(IC.ok) + 'Tudo certo. Pode enviar.</span>');
  }

  /* ═══ [J10] SÓ LEITURA ════════════════════════════════════════════════════════════════════
     O QUE FAZ  Num pedido aberto só para consulta (sem o botão Salvar à vista), somem as caixas
                vazias (observação, observação do aprovador) e a área de arrastar arquivo; o
                link do anexo vira "Baixar o anexo (85KB)".
     VISUAL     Natcorp_PPP.css › [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function desenharLeitura() {
    /* 04/10: a observação do aprovador que a PÁGINA deixa escrever (aprovador com etapa pendente)
       não some, mesmo vazia — só sai a caixa vazia que é só leitura */
    var editavel = function (c) { return !!c.querySelector('textarea:not([readonly]):not([disabled])'); };
    ['OBSERVACAO', 'OBS_APROVADOR'].forEach(function (n) { var c = cont(n); if (c) classe(c, 'nc-ppp-fora', LEITURA && !val(n) && !(n === 'OBS_APROVADOR' && editavel(c))); });
    var arq = cont('ARQUIVO'); if (!arq) return;
    var baixar = [].filter.call(document.querySelectorAll('a'), function (a) { return /fazer download|baixar o anexo/i.test(a.textContent) && arq.closest('.t-Region').contains(a); })[0];
    classe(arq, 'nc-ppp-arq-leitura', LEITURA);
    renomear('ARQUIVO', LEITURA ? 'Anexo' : 'Anexar um documento');
    classe(arq, 'nc-ppp-fora', LEITURA && !baixar);
    if (baixar && !baixar.getAttribute('data-nc-ppp')) {
      var kb = (/(\d+\s*[KM]B)/i.exec(baixar.getAttribute('title') || '') || [])[1];
      baixar.setAttribute('data-nc-ppp', '1');
      baixar.textContent = 'Baixar o anexo' + (kb ? ' (' + kb + ')' : '');
    }
  }

  /* ═══ [J11] O TÍTULO DA JANELA ════════════════════════════════════════════════════════════
     O QUE FAZ  Troca o título da janela por "Pedir PPP ou laudo" ou "Pedido nº … · PPP / laudo".
     PODE MEXER os dois textos entre aspas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tituloJanela() {
    try {
      var fora = window.parent && window.parent !== window && window.parent.document;
      if (!fora) return;
      var fr = [].slice.call(fora.querySelectorAll('iframe')).filter(function (i) { return i.contentWindow === window; })[0];
      var t = fr && fr.closest('.ui-dialog') && fr.closest('.ui-dialog').querySelector('.ui-dialog-title');
      var novo = PEDIDO ? 'Pedido nº ' + val('COD_REQ') + ' · PPP / laudo' : 'Pedir PPP ou laudo';
      if (t && t.textContent !== novo) t.textContent = novo;
    } catch (x) { /* outro domínio */ }
  }

  /* ═══ [J12] O MAESTRO: QUANDO CADA PARTE É MONTADA ════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a janela abre e monta as partes. atualizar()
                redesenha o que muda e roda de novo sempre que algo muda: um campo é alterado,
                um relatório é atualizado, uma janela fecha, uma ação dinâmica traz valores.
     CUIDADO    Não mude a ordem das chamadas: umas partes dependem das anteriores.
     SE DER ERRO  Abra o Console (F12 › Console). Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T;
  function agendar() { clearTimeout(T); T = setTimeout(atualizar, 60); }
  function atualizar() {
    LEITURA = PEDIDO && !(SALVAR && aVista(SALVAR));
    classe(document.body, 'nc-ppp-leitura', LEITURA);
    desenharObjeto();
    consertarComentarios();
    desenharPedido();
    montarAprovacao();
    desenharRodape();
    desenharLeitura();
  }
  function iniciar() {
    document.body.classList.add('nc-ppp', PEDIDO ? 'nc-ppp-modo-pedido' : 'nc-ppp-modo-novo');
    if (TOPO) TOPO.classList.add('nc-ppp-topo');
    montarAbertura();
    montarQuem();
    montarObjeto();
    montarPagina();
    montarPedido();
    montarRodape();
    tituloJanela();
    atualizar();
    $(document).on('change', 'input, select, textarea', agendar);
    $(document).on('apexafterrefresh apexafterclosedialog', agendar);
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    setTimeout(atualizar, 700);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
