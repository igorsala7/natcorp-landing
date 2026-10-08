/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE HORA EXTRA  —  o "arrumador" da tela (JavaScript)             ║
   ║  App 9503 · Página 716 (a janela) · pedir autorização para fazer hora extra            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ──────────────────────────────────────────────────────────────────
   A janela é aberta pela aba "Requisição de Hora Extra" do Painel (app de Frequência). O gestor
   ou o próprio colaborador pede autorização para fazer hora extra num dia e horário. Quem aprova
   autoriza; depois as horas entram no ponto. Este arquivo organiza a janela assim:
     PEDIDO NOVO
       1. Uma abertura com o caminho do pedido (você pede → quem aprova autoriza → você faz as horas).
       2. Quatro passos: "Quem vai fazer?" · "Em que dia?" (Hoje / Amanhã / Sábado e o dia escrito
          por extenso) · "Em que horário?" (o relógio de ponteiros dá lugar ao seletor de hora do
          próprio celular; atalhos de 1 a 4 horas; a RÉGUA DO DIA mostra o bloco e quantas horas são)
          · "Por que precisa?" (começos de motivo que escrevem na caixa).
       3. O rodapé resume o pedido numa frase e diz o que falta; "Criar" aparece como "Enviar pedido".
     PEDIDO GRAVADO
       4. Cabeçalho: nº, situação em cor, de quem, o dia, o horário na régua, o motivo, quem pediu.
       5. As abas (Hora Extra · Aprovadores) viram uma página só; a aprovação é o caminho das outras
          requisições, com Aprovar/Reprovar dentro para quem aprova.

   ── O QUE ELE NÃO FAZ ───────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: itens, botões, ações e processos
       continuam sendo do APEX.
     • Os atalhos (dia, duração, motivo) preenchem os campos com apex.item().setValue: as ações
       dinâmicas da página rodam como se a pessoa tivesse digitado.
     • Se este arquivo for retirado da página, a janela volta ao visual padrão (com o relógio de
       ponteiros) e continua funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ──────────────────────────────────────────────────────────────────
     App 9503 › Página 716 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_HoraExtra.js
     (no FIM da lista). Atenção: é a página 716 (a janela), não a lista 138.
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_HoraExtra.css.
     Este é o arquivo-FONTE (.src.js). O arquivo que sobe (o .js de mesmo nome, em brand/apex/login)
     é gerado a partir dele pelo gerar-*.py da página: edite ESTE arquivo (manual, parte 2).

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ────────────────────────────────────
   Esta página NÃO usa classes próprias nas regiões. O arquivo se reconhece sozinho:
     • só liga se a página tiver os itens …_HORA_INICIAL, …_HORA_FINAL e …_DATA_PONTO (não testa
       o número do app nem da página);
     • os itens usados pelo nome (sem o prefixo P716_): COD_EMPRESA, MATRICULA, DATA_PONTO,
       HORA_INICIAL, HORA_FINAL, COMENTARIOS, COD_REQ, COD_SIT_REQ, SOLICITANTE, DT_REQ,
       DT_SIT_REQ, OBS_APROVADOR, ROWID;
     • os botões "Criar", "Salvar", "Aprovar" e "Reprovar" são achados pelo TEXTO;
     • a aprovação é o relatório que tem a coluna APROVADOR.
   Os campos, botões e ações dinâmicas continuam os do APEX: aqui eles só MUDAM DE LUGAR.

   ── ÍNDICE: as partes deste arquivo ─────────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Textos e listas ..................... começos de motivo, dias, meses        PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  Horas, datas e a régua do dia ....... contas de horário; a régua 0h–24h
     [J4]  As peças da página e a abertura ..... "Pedir hora extra" e o caminho do pedido  PODE MEXER
     [J5]  Passo 1: quem vai fazer ............. Empresa e "Quem vai fazer"                PODE MEXER
     [J6]  Passos 2, 3 e 4: dia, horário, motivo  atalhos, seletor de hora, régua           PODE MEXER
     [J7]  As abas viram uma página só
     [J8]  Pedido gravado: o cabeçalho
     [J9]  O caminho da aprovação .............. Aprovar/Reprovar dentro da faixa          PODE MEXER
     [J10] O rodapé ............................ a frase do pedido, o que falta, Enviar    PODE MEXER
     [J11] Acabamentos ......................... só leitura, linhas vazias, título da janela
     [J12] O maestro ........................... decide QUANDO cada parte é montada       CUIDADO

   ── RECEITAS RÁPIDAS ────────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Em que dia?'  →  'Qual dia?'
     Quero mudar os botões de motivo ("Inventário", "Fechamento do mês"…) → [J1], lista MOTIVOS
     Quero mudar os atalhos de duração (1 a 4 horas)  → [J6], procure  [1, 2, 3, 4]
     Quero mudar o aviso de "muitas horas seguidas" (hoje, mais de 10 horas) → [J6], procure 600
       (600 minutos = 10 horas)
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e veja se há erro. O manual, parte 5,
         explica o que fazer com a mensagem.

   ── LEGENDA DAS MARCAS NOS COMENTÁRIOS ──────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, títulos.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
     (sem marca)  funciona sozinho; só mexa se souber o que está fazendo.

   ── COMO LER UM ARQUIVO JS EM 30 SEGUNDOS ───────────────────────────────────────────────────
     comentário             tudo entre barra-asterisco e asterisco-barra, e o resto da linha
                            depois de duas barras. O navegador ignora: é só para pessoas.
     function nome() { … }  uma "receita" com nome. Ela só roda quando alguém a chama: nome().
     var x = …;             guarda um valor com um nome, para usar depois.
     'texto'  ou  "texto"   um texto. Muitas vezes, é o que aparece na tela.
     P + 'HORA_INICIAL'     junta os textos: vira 'P716_HORA_INICIAL', o nome do item no APEX.
     val(…) / txt(…)        leem o que está num item do APEX (veja [J2]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: estas linhas decidem SE o arquivo roda. Ele roda uma vez só, só dentro do APEX e só
     numa página que tenha os itens …_HORA_INICIAL, …_HORA_FINAL e …_DATA_PONTO. Não apague. */
  if (window.__ncHE || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_HORA_INICIAL_CONTAINER"]');
  if (!achado) return;
  /* P = o começo do nome dos itens desta página (ex.: 'P716_'). Ele é DESCOBERTO sozinho a partir
     do item HORA_INICIAL: se a página for copiada para outro número, nada muda aqui. */
  var P = achado.id.replace(/HORA_INICIAL_CONTAINER$/, '');
  if (!document.getElementById(P + 'HORA_FINAL') || !document.getElementById(P + 'DATA_PONTO')) return;
  window.__ncHE = true;

  var $ = apex.jQuery;
  /* ═══ [J1] TEXTOS E LISTAS ═════════════════════════════════════════════════════════════════
     O QUE É    IC são os ícones (desenhos pequenos, formato SVG): não precisa mexer.
                MOTIVOS são os botões de começo de motivo do passo 4: tocar num deles escreve o texto
                na caixa Motivo. DIAS e MESES são os nomes usados para escrever a data por extenso.
     PODE MEXER os textos de MOTIVOS: troque, apague ou acrescente (entre aspas, separados por
                vírgula). Os nomes dos dias e meses também, se quiser outra forma de escrever.
     CUIDADO    DIAS começa no domingo e MESES em janeiro: não mude a ordem nem a quantidade.
     VISUAL     Natcorp_HoraExtra.css › [C8] (os botões de atalho)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    pessoa: '<circle cx="12" cy="8" r="3.6"/><path d="M4.5 20c.9-3.9 3.9-6 7.5-6s6.6 2.1 7.5 6"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    selo: '<path d="M12 3l2.4 1.8 3-.2.9 2.9 2.4 1.8-1 2.8 1 2.8-2.4 1.8-.9 2.9-3-.2L12 21l-2.4-1.8-3 .2-.9-2.9L3.3 14.7l1-2.8-1-2.8 2.4-1.8.9-2.9 3 .2z"/><path d="M8.8 12.2l2.2 2.2 4.2-4.4"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    cal: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/>',
    fala: '<path d="M4.5 5.5h15v10h-8l-4.5 3.5v-3.5h-2.5z"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    lua: '<path d="M19 14.5A7.5 7.5 0 0 1 9.5 5a7.5 7.5 0 1 0 9.5 9.5z"/>'
  };
  /* PODE MEXER: os começos de motivo do passo 4 — 'Texto', 'Texto', … */
  var MOTIVOS = ['Entrega com prazo curto', 'Cobrir a falta de um colega', 'Muito movimento', 'Inventário', 'Fechamento do mês', 'Manutenção fora do horário'];
  var DIAS = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'];
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];

  /* ═══ [J2] FERRAMENTAS ═════════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('ITEM')         o que o APEX GUARDA no item (o código, a data '31/12/2026', a hora '18:00')
       txt('ITEM')         o que a PESSOA VÊ no item (o nome da opção escolhida numa lista)
       cont('ITEM')        o bloco inteiro do campo na tela (rótulo + campo)
       renomear('ITEM', 'Novo nome')  troca o NOME do campo só na tela (no APEX continua o mesmo)
       botaoPorTexto(…)    acha um botão do APEX pelo texto dele
       bonito(…)           arruma maiúsculas e põe acento nas situações que o banco grava sem acento
     QUANDO MEXER  Quase nunca.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-he-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
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
    return limpo(e.value || e.textContent);
  }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim(); }
  function bonito(t) {
    t = String(t || '').trim();
    if (t && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t)) t = t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); });
    t = t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); });
    /* a lista de situações vem sem acento do banco */
    return t.replace(/\b(Concluid|Suspensao|Aprovaca|Requisica|Solicitaca)(\w*)/g, function (m, r, f) {
      return ({ Concluid: 'Concluíd', Suspensao: 'Suspensão', Aprovaca: 'Aprovaçã', Requisica: 'Requisiçã', Solicitaca: 'Solicitaçã' })[r] + f;
    });
  }
  function renomear(n, t) {
    var l = document.getElementById(P + n + '_LABEL');
    if (!l || l.getAttribute('data-nc-he') === t) return;
    for (var i = 0; i < l.childNodes.length; i++) {
      var x = l.childNodes[i];
      if (x.nodeType === 3 && x.textContent.trim()) { x.textContent = t + ' '; l.setAttribute('data-nc-he', t); return; }
    }
  }
  function botaoPorTexto(re) {
    return [].filter.call(document.querySelectorAll('button.t-Button, a.t-Button'), function (b) {
      return re.test(b.getAttribute('data-nc-he-orig') || b.textContent.replace(/\s+/g, ' ').trim());
    })[0];
  }
  function rotuloBotao(b, t) {
    if (!b) return;
    if (!b.getAttribute('data-nc-he-orig')) b.setAttribute('data-nc-he-orig', b.textContent.replace(/\s+/g, ' ').trim());
    var l = b.querySelector('.t-Button-label');
    if (l && l.textContent !== t) l.textContent = t;
  }
  function aVista(e) { return !!(e && (e.offsetParent || e.getClientRects().length)); }

  /* ═══ [J3] HORAS, DATAS E A RÉGUA DO DIA ═══════════════════════════════════════════════════
     O QUE FAZ  As contas de horário: quantos minutos tem "18:30", quanto dura o pedido, se ele passa
                da meia-noite ("termina no dia seguinte"), e a data por extenso ("amanhã, quinta-feira,
                1 de outubro"). Também desenha a RÉGUA DO DIA: uma faixa de 0h a 24h com a madrugada e
                a noite mais escuras e o bloco pedido em cor (em dois pedaços se passar da meia-noite).
     QUANDO MEXER  Quase nunca: são contas. Os textos 'hora', 'horas', 'minutos', 'hoje', 'amanhã',
                'ontem' podem ser trocados.
     VISUAL     Natcorp_HoraExtra.css › [C9] (a régua)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function minutos(h) { var m = /^(\d{1,2}):(\d{2})/.exec(h || ''); return m && +m[1] < 24 && +m[2] < 60 ? +m[1] * 60 + +m[2] : null; }
  function hhmm(m) { m = ((m % 1440) + 1440) % 1440; return ('0' + Math.floor(m / 60)).slice(-2) + ':' + ('0' + m % 60).slice(-2); }
  function duracao(m) {
    var h = Math.floor(m / 60), r = m % 60;
    return (h ? h + (h === 1 ? ' hora' : ' horas') : '') + (h && r ? ' e ' : '') + (r ? r + ' minutos' : '') || '0 minuto';
  }
  function dataDe(t) { var m = /^(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function ddmmaaaa(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear(); }
  function hoje() { var d = new Date(); d.setHours(0, 0, 0, 0); return d; }
  function maisDias(d, n) { var x = new Date(d); x.setDate(x.getDate() + n); return x; }
  function porExtenso(d, comAno) {
    if (!d) return '';
    var h = hoje(), dif = Math.round((d - h) / 864e5);
    var nome = DIAS[d.getDay()] + ', ' + d.getDate() + ' de ' + MESES[d.getMonth()] + (comAno || d.getFullYear() !== h.getFullYear() ? ' de ' + d.getFullYear() : '');
    return (dif === 0 ? 'hoje, ' : dif === 1 ? 'amanhã, ' : dif === -1 ? 'ontem, ' : '') + nome;
  }
  /* o horário pedido: começo, fim, duração e se vira o dia */
  function horario() {
    var a = minutos(val('HORA_INICIAL')), b = minutos(val('HORA_FINAL'));
    if (a === null || b === null) return { a: a, b: b };
    var d = b - a, vira = d < 0;
    if (vira) d += 1440;
    return { a: a, b: b, d: d, vira: vira };
  }
  /* a régua do dia: 0h a 24h, com o bloco pedido (em dois pedaços quando passa da meia-noite) */
  function regua(h, pequena) {
    var blocos = '';
    if (h.d) {
      var pedacos = h.vira ? [[h.a, 1440], [0, h.b]] : [[h.a, h.b]];
      blocos = pedacos.filter(function (p) { return p[1] > p[0]; }).map(function (p) {
        return '<span class="nc-he-regua-bloco" style="left:' + (p[0] / 14.4).toFixed(2) + '%;width:' + ((p[1] - p[0]) / 14.4).toFixed(2) + '%"></span>';
      }).join('');
    }
    var marcas = [0, 6, 12, 18, 24].map(function (x) { return '<span class="nc-he-regua-marca" style="left:' + (x / 24 * 100) + '%">' + x + 'h</span>'; }).join('');
    return '<div class="nc-he-regua' + (pequena ? ' nc-he-regua--pequena' : '') + '" aria-hidden="true"><div class="nc-he-regua-faixa">' +
      '<span class="nc-he-regua-noite" style="left:0;width:25%"></span><span class="nc-he-regua-noite" style="left:91.67%;width:8.33%"></span>' +
      blocos + '</div><div class="nc-he-regua-marcas">' + marcas + '</div></div>';
  }

  /* ═══ [J4] AS PEÇAS DA PÁGINA E A ABERTURA ═════════════════════════════════════════════════
     O QUE FAZ  Primeiro, guarda as peças da página que as outras partes usam:
                  PEDIDO  o pedido já foi gravado (tem ROWID ou COD_REQ)?
                  TOPO    o bloco dos campos do alto (empresa, colaborador, dados do pedido)
                  HE      a região do dia, das horas e do comentário
                  MENU    a região das abas (Hora Extra · Aprovadores)
                Depois, num pedido NOVO, põe a abertura "Pedir hora extra" com o caminho em 3 passos.
     PODE MEXER os textos entre aspas da abertura ('Pedir hora extra', 'Peça antes de fazer…', e os
                três passos 'Você pede', 'Quem aprova', 'Você faz as horas').
     VISUAL     Natcorp_HoraExtra.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PEDIDO = !!(val('ROWID') || val('COD_REQ'));
  /* empresa, colaborador e os dados do pedido: o .container dos itens (a mesma região guarda, mais
     abaixo, as abas com a Hora Extra e os Aprovadores — esconder a região esconderia tudo) */
  var TOPO = cont('COD_EMPRESA') ? cont('COD_EMPRESA').closest('.container') : null;
  var HE = achado.closest('.t-Region');                                               /* dia, horas e comentário */
  var RDS = document.querySelector('.apex-rds-container');
  var MENU = RDS ? RDS.closest('.t-Region') : null;
  var CRIAR, SALVAR, LEITURA;

  /* ---------- a abertura (pedido novo) ---------- */
  function montarAbertura() {
    if (PEDIDO || !TOPO) return;
    var a = el('section', 'nc-he-abertura');
    a.innerHTML = '<h1 class="nc-he-abertura-tit">Pedir hora extra</h1>' +
      '<p>Peça antes de fazer: a hora extra só vale depois de autorizada.</p>' +
      '<ol class="nc-he-caminho-pedido">' +
        '<li><span class="nc-he-cp-ic">' + svg(IC.lapis) + '</span><span><b>Você pede</b>o dia e o horário</span></li>' +
        '<li><span class="nc-he-cp-ic">' + svg(IC.selo) + '</span><span><b>Quem aprova</b>autoriza o pedido</span></li>' +
        '<li><span class="nc-he-cp-ic">' + svg(IC.relogio) + '</span><span><b>Você faz as horas</b>e elas entram no ponto</span></li>' +
      '</ol>';
    TOPO.parentNode.insertBefore(a, TOPO);
  }
  function passo(n, t, sub) {
    var h = el('div', 'nc-he-passo');
    h.innerHTML = '<span class="nc-he-passo-n">' + n + '</span><span class="nc-he-passo-txt"><span class="nc-he-passo-t">' + esc(t) + '</span>' + (sub ? '<span class="nc-he-passo-sub">' + esc(sub) + '</span>' : '') + '</span>';
    return h;
  }
  function linha(n) { var c = cont(n); return c && c.closest('.row'); }

  /* ═══ [J5] PASSO 1: QUEM VAI FAZER ═════════════════════════════════════════════════════════
     O QUE FAZ  Num pedido novo: o título do passo 1, os nomes "Empresa" e "Quem vai fazer" para os
                campos COD_EMPRESA e MATRICULA, e tocar na caixa da lista já abre a lista (antes só o
                botãozinho do lado abria).
     PODE MEXER o título, a explicação do passo e os nomes dos campos (os textos entre aspas).
     VISUAL     Natcorp_HoraExtra.css › [C3] e [C7] (os passos)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarQuem() {
    if (!TOPO) return;
    TOPO.classList.add('nc-he-topo');
    if (PEDIDO) return;
    TOPO.classList.add('nc-he-quem');
    TOPO.insertBefore(passo(1, 'Quem vai fazer a hora extra?', 'A empresa e a pessoa que vai trabalhar a mais.'), TOPO.firstChild);
    renomear('COD_EMPRESA', 'Empresa');
    renomear('MATRICULA', 'Quem vai fazer');
    /* a caixa da lista abre a lista: não é preciso achar o botãozinho do lado */
    ['COD_EMPRESA', 'MATRICULA'].forEach(function (n) {
      var i = document.getElementById(P + n), b = document.getElementById(P + n + '_lov_btn');
      if (i && b && !i.__ncHE) { i.__ncHE = true; i.addEventListener('click', function () { if (!b.disabled) b.click(); }); }
    });
  }

  /* ═══ [J6] PASSOS 2, 3 E 4: DIA, HORÁRIO E MOTIVO ══════════════════════════════════════════
     O QUE FAZ  2. Em que dia?    atalhos Hoje / Amanhã / Sábado e o dia por extenso embaixo.
                3. Em que horário?  "Começa às" e "Termina às" lado a lado; atalhos de 1 a 4 horas que
                                   preenchem o fim a partir do começo; a régua do dia com o total
                                   ("4 horas de hora extra, das 22:00 às 02:00") e avisos (fim igual ao
                                   começo; mais de 10 horas seguidas).
                4. Por que precisa? os botões de MOTIVOS ([J1]) escrevem o começo do motivo na caixa.
                O relógio de ponteiros da página (clockpicker) é trocado pelo seletor de hora do próprio
                aparelho (o mesmo do despertador do celular). O valor continua "HH:MM", o formato que a
                página já grava.
     PODE MEXER títulos e explicações dos passos, os nomes 'Dia', 'Começa às', 'Termina às', 'Motivo',
                o exemplo da caixa Motivo, e os avisos da régua.
     CUIDADO    • Os atalhos esperam a resposta do servidor ($.active / ajaxStop) antes de preencher: a
                  ação dinâmica da página devolve OS DOIS horários, e uma resposta atrasada apagaria o
                  fim recém-posto. Não tire essa espera.
                • i.step = 300 faz o seletor andar de 5 em 5 minutos (300 segundos).
     VISUAL     Natcorp_HoraExtra.css › [C3], [C7], [C8] e [C9]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var DIA_EXT, DIA_ATALHOS, HORAS, RESUMO_H;
  function montarPedidoNovo() {
    if (PEDIDO || !HE) return;
    HE.classList.add('nc-he-he', 'nc-he-cartao-passo');
    /* 2. o dia */
    var lDia = linha('DATA_PONTO');
    if (lDia) {
      lDia.parentNode.insertBefore(passo(2, 'Em que dia?', 'O dia em que a hora extra vai ser feita.'), lDia);
      DIA_ATALHOS = el('div', 'nc-he-atalhos');
      DIA_ATALHOS.setAttribute('role', 'group');
      DIA_ATALHOS.setAttribute('aria-label', 'Escolher o dia');
      var h = hoje(), sab = maisDias(h, ((6 - h.getDay()) + 7) % 7 || 7);
      [['Hoje', h], ['Amanhã', maisDias(h, 1)], [h.getDay() === 5 ? 'Amanhã é sábado' : 'Sábado', sab]].forEach(function (x, i) {
        if (i === 2 && ddmmaaaa(x[1]) === ddmmaaaa(maisDias(h, 1))) return;
        var b = el('button', 'nc-he-atalho', esc(x[0]) + ' <span>' + x[1].getDate() + '/' + (x[1].getMonth() + 1) + '</span>');
        b.type = 'button'; b.setAttribute('data-dia', ddmmaaaa(x[1]));
        DIA_ATALHOS.appendChild(b);
      });
      var cd = cont('DATA_PONTO'), ic = cd.querySelector('.t-Form-inputContainer') || cd;
      ic.insertBefore(DIA_ATALHOS, ic.firstChild);
      DIA_EXT = el('p', 'nc-he-dia-ext');
      ic.appendChild(DIA_EXT);
      DIA_ATALHOS.addEventListener('click', function (e) {
        var b = e.target.closest('[data-dia]'); if (!b) return;
        if (val('DATA_PONTO') !== b.getAttribute('data-dia')) apex.item(P + 'DATA_PONTO').setValue(b.getAttribute('data-dia'));
        agendar();
      });
    }
    renomear('DATA_PONTO', 'Dia');
    var dp = document.getElementById(P + 'DATA_PONTO'); if (dp) dp.setAttribute('placeholder', 'dd/mm/aaaa');

    /* 3. o horário: os dois campos lado a lado, os atalhos de duração e a régua */
    var lA = linha('HORA_INICIAL'), lB = linha('HORA_FINAL');
    if (lA && lB) {
      lA.parentNode.insertBefore(passo(3, 'Em que horário?', 'A hora em que começa e a hora em que termina a hora extra.'), lA);
      HORAS = el('div', 'nc-he-horas');
      lA.parentNode.insertBefore(HORAS, lA);
      var par = el('div', 'nc-he-par');
      HORAS.appendChild(par);
      par.appendChild(lA); par.appendChild(lB);
      var dur = el('div', 'nc-he-atalhos nc-he-dur');
      dur.setAttribute('role', 'group');
      dur.setAttribute('aria-label', 'Quanto tempo');
      dur.innerHTML = '<span class="nc-he-dur-rot">Quanto tempo?</span>' + [1, 2, 3, 4].map(function (n) { return '<button type="button" class="nc-he-atalho" data-h="' + n + '">' + n + (n === 1 ? ' hora' : ' horas') + '</button>'; }).join('');
      HORAS.appendChild(dur);
      RESUMO_H = el('div', 'nc-he-resumo-h');
      RESUMO_H.setAttribute('aria-live', 'polite');
      HORAS.appendChild(RESUMO_H);
      dur.addEventListener('click', function (e) {
        var b = e.target.closest('[data-h]'); if (!b) return;
        var n = +b.getAttribute('data-h');
        function aplicar() {
          var a = minutos(val('HORA_INICIAL'));
          if (a === null) { var i = document.getElementById(P + 'HORA_INICIAL'); i.focus(); if (i.showPicker) try { i.showPicker(); } catch (x) { /* sem seletor */ } return; }
          definirHora('HORA_FINAL', hhmm(a + 60 * n));
        }
        /* enquanto a página confere as horas no servidor, o começo pode aparecer vazio: espera */
        if ($.active) $(document).one('ajaxStop', function () { setTimeout(aplicar, 0); }); else aplicar();
      });
    }
    renomear('HORA_INICIAL', 'Começa às');
    renomear('HORA_FINAL', 'Termina às');
    relogioDoCelular();

    /* 4. o motivo */
    var lM = linha('COMENTARIOS');
    if (lM) {
      lM.parentNode.insertBefore(passo(4, 'Por que precisa?', 'Quem aprova decide mais rápido quando entende o motivo.'), lM);
      var cm = cont('COMENTARIOS'), icm = cm.querySelector('.t-Form-inputContainer') || cm;
      var mot = el('div', 'nc-he-atalhos nc-he-motivos');
      mot.setAttribute('role', 'group');
      mot.setAttribute('aria-label', 'Começar o motivo');
      mot.innerHTML = MOTIVOS.map(function (m) { return '<button type="button" class="nc-he-atalho" data-m="' + esc(m) + '">' + esc(m) + '</button>'; }).join('');
      icm.insertBefore(mot, icm.firstChild);
      mot.addEventListener('click', function (e) {
        var b = e.target.closest('[data-m]'); if (!b) return;
        var t = document.getElementById(P + 'COMENTARIOS'), atual = t.value.trim(), m = b.getAttribute('data-m');
        if (atual.indexOf(m) >= 0) { t.focus(); return; }
        apex.item(t.id).setValue(atual ? atual.replace(/[.\s]*$/, '') + '. ' + m : m);
        t.focus(); t.setSelectionRange(t.value.length, t.value.length);
        agendar();
      });
    }
    renomear('COMENTARIOS', 'Motivo');
    var tc = document.getElementById(P + 'COMENTARIOS');
    if (tc && !tc.getAttribute('placeholder')) tc.setAttribute('placeholder', 'Ex.: o caminhão chega às 18h e precisa ser descarregado no mesmo dia.');
  }
  /* o relógio de ponteiros da página dá lugar ao seletor de hora do próprio aparelho (o mesmo do
     despertador); o valor continua "HH:MM", o formato que a página já grava */
  function relogioDoCelular() {
    ['HORA_INICIAL', 'HORA_FINAL'].forEach(function (n) {
      var i = document.getElementById(P + n);
      if (!i || i.disabled || i.readOnly || i.type === 'time') return;
      try { if ($(i).data('clockpicker')) $(i).clockpicker('remove'); } catch (x) { /* sem relógio */ }
      var v = i.value;
      try { i.type = 'time'; } catch (x) { return; }
      i.step = 300;
      i.classList.add('text_field', 'apex-item-text');
      if (v && minutos(v) !== null) i.value = hhmm(minutos(v));
      i.classList.add('nc-he-hora');
      i.addEventListener('input', agendar);
    });
  }
  /* muda como se a pessoa tivesse digitado e saído do campo (a ação da página confere as horas) */
  function definirHora(n, v) {
    var i = document.getElementById(P + n); if (!i) return;
    function vai() {
      apex.item(i.id).setValue(v);
      $(i).trigger('focusout');
      agendar();
    }
    /* a ação da página devolve OS DOIS horários: uma resposta ainda a caminho (do campo anterior)
       apagaria o fim recém-posto — espera ela chegar */
    if ($.active) $(document).one('ajaxStop', function () { setTimeout(vai, 0); }); else vai();
  }
  function desenharPedidoNovo() {
    if (DIA_EXT) {
      var d = dataDe(val('DATA_PONTO'));
      html(DIA_EXT, d ? svg(IC.cal) + '<span>' + esc(porExtenso(d)) + '</span>' : '');
      [].forEach.call(DIA_ATALHOS.children, function (b) { var on = b.getAttribute('data-dia') === val('DATA_PONTO'); classe(b, 'is-on', on); b.setAttribute('aria-pressed', on); });
    }
    if (!RESUMO_H) return;
    var h = horario();
    [].forEach.call(HORAS.querySelectorAll('[data-h]'), function (b) { var on = h.d === 60 * +b.getAttribute('data-h'); classe(b, 'is-on', on); b.setAttribute('aria-pressed', on); });
    var aviso = '';
    if (h.a !== null && h.b !== null && !h.d) aviso = 'O fim é igual ao começo. Mude a hora em que termina.';
    else if (h.d > 600) aviso = 'São ' + duracao(h.d) + ' seguidas. Confira se é isso mesmo.';
    html(RESUMO_H, regua(h) +
      (h.d ? '<p class="nc-he-total"><b>' + esc(duracao(h.d)) + '</b> de hora extra, das ' + hhmm(h.a) + ' às ' + hhmm(h.b) +
        (h.vira ? ' <span class="nc-he-vira">' + svg(IC.lua) + 'termina no dia seguinte</span>' : '') + '</p>'
        : '<p class="nc-he-total nc-he-total--vazio">' + (h.a === null ? 'Escolha a hora em que começa.' : 'Escolha a hora em que termina, ou toque em quanto tempo.') + '</p>') +
      (aviso ? '<p class="nc-he-aviso">' + esc(aviso) + '</p>' : ''));
  }

  /* ═══ [J7] AS ABAS VIRAM UMA PÁGINA SÓ ═════════════════════════════════════════════════════
     O QUE FAZ  As abas "Hora Extra" e "Aprovadores" deixam de ser abas: tudo aparece numa página só.
                Num pedido gravado, a região de cima passa a se chamar "O que foi pedido".
     PODE MEXER o texto 'O que foi pedido'.
     VISUAL     Natcorp_HoraExtra.css › [C1]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarPagina() {
    if (MENU) MENU.classList.add('nc-he-sem-abas');
    if (HE) HE.classList.add('nc-he-he');
    if (HE && PEDIDO) { var t = HE.querySelector(':scope > .t-Region-header .t-Region-title'); if (t) t.textContent = 'O que foi pedido'; }
  }

  /* ═══ [J8] PEDIDO GRAVADO: O CABEÇALHO ═════════════════════════════════════════════════════
     O QUE FAZ  Quando o pedido já tem número: "Pedido nº …", a situação com cor (verde aprovado,
                vermelho reprovado, cinza cancelado/suspenso, amarelo em andamento), "Hora extra de
                Fulano · matrícula …", o dia por extenso, o horário com a régua pequena, o motivo e
                quem pediu e quando.
     LÊ DOS ITENS  COD_REQ, COD_SIT_REQ, MATRICULA, SOLICITANTE, DATA_PONTO, HORA_INICIAL, HORA_FINAL,
                COMENTARIOS, DT_REQ, DT_SIT_REQ.
     VISUAL     Natcorp_HoraExtra.css › [C4] e [C10]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var HERO;
  function montarPedido() {
    if (!PEDIDO || !TOPO) return;
    HERO = el('section', 'nc-he-hero');
    TOPO.parentNode.insertBefore(HERO, TOPO);
  }
  function desenharPedido() {
    if (!HERO) return;
    var sit = txt('COD_SIT_REQ');
    var tom = /aprov|conclu/i.test(sit) ? 'bom' : /reprov/i.test(sit) ? 'ruim' : /cancel|suspens/i.test(sit) ? 'neutro' : 'espera';
    var pessoa = txt('MATRICULA'), nome = bonito(semCodigo(pessoa)), mat = (pessoa.match(/^\s*(\d+)/) || [])[1] || val('MATRICULA');
    var sol = txt('SOLICITANTE').split(/\s*\/\s*/), quem = bonito(semCodigo(sol[1] || sol[0] || ''));
    var h = horario(), d = dataDe(val('DATA_PONTO')), motivo = txt('COMENTARIOS');
    html(HERO, '<div class="nc-he-hero-topo"><p class="nc-he-hero-n">Pedido nº <b>' + esc(val('COD_REQ')) + '</b></p>' +
      (sit ? '<span class="nc-he-sit nc-he-sit--' + tom + '">' + esc(bonito(sit)) + '</span>' : '') + '</div>' +
      '<h2 class="nc-he-hero-tit">Hora extra' + (nome ? ' de ' + esc(nome) : '') + (mat && nome ? ' <span>· matrícula ' + esc(mat) + '</span>' : '') + '</h2>' +
      '<div class="nc-he-hero-quando">' +
        (d ? '<p class="nc-he-hero-dia">' + svg(IC.cal) + '<span>' + esc(porExtenso(d, true).replace(/^./, function (c) { return c.toUpperCase(); })) + '</span></p>' : '') +
        (h.d ? '<p class="nc-he-hero-hora">' + svg(IC.relogio) + '<span><b>' + hhmm(h.a) + ' às ' + hhmm(h.b) + '</b> · ' + esc(duracao(h.d)) + (h.vira ? ' · termina no dia seguinte' : '') + '</span></p>' : '') +
        (h.d ? regua(h, true) : '') +
      '</div>' +
      (motivo ? '<blockquote class="nc-he-hero-motivo">' + svg(IC.fala) + '<span>' + esc(motivo) + '</span></blockquote>' : '') +
      '<p class="nc-he-hero-quem">Pedido em <b>' + esc(val('DT_REQ')) + '</b>' + (quem ? ' por <b>' + esc(quem) + '</b>' : '') +
        (val('DT_SIT_REQ') && val('DT_SIT_REQ') !== val('DT_REQ') ? ' · situação desde ' + esc(val('DT_SIT_REQ')) : '') + '</p>');
  }

  /* ═══ [J9] O CAMINHO DA APROVAÇÃO ══════════════════════════════════════════════════════════
     O QUE FAZ  O relatório de aprovadores (o que tem a coluna APROVADOR) vira uma faixa: o resumo
                ("2 de 3 · aguardando Maria", "Autorizado por todos"…), "Ver o caminho" com cada
                aprovador e o estado dele, e as justificativas. Quando é a vez de quem está vendo, os
                botões Aprovar/Reprovar do APEX vêm para dentro da faixa; fora disso, ficam no lugar
                original (quem decide se aparecem é a condição do botão na página).
     LÊ DE      as colunas do relatório: APROVADOR, DATA, STATUS, JUSTIFICATIVA.
     PODE MEXER os textos entre aspas: 'Aprovação', 'Ver o caminho', 'Autorizado', 'Sua vez',
                'Confira o dia e o horário e decida.'…
     CUIDADO    Se uma dessas colunas for renomeada no relatório do APEX, a faixa não acha os dados.
     VISUAL     Natcorp_HoraExtra.css › [C5]
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
      /* 04/10: o lugar original de cada botão, para devolvê-lo quando não for "a sua vez" */
      AP.casa = AP.botoes.map(function (b) { return [b, b.parentNode, b.nextSibling]; });
      reg.classList.add('nc-he-aprov');
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
      AP.box = el('div', 'nc-he-ap');
      corpo.insertBefore(AP.box, corpo.firstChild);
      AP.box.addEventListener('click', function (e) { if (e.target.closest('.nc-he-ap-ver')) { AP_ABERTO = !AP_ABERTO; AP_ASSIN = ''; agendar(); } });
    }
    var passos = [].slice.call(AP.reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; }
      var st = c('STATUS');
      return { nome: nomeAprovador(c('APROVADOR')), data: c('DATA'), just: c('JUSTIFICATIVA'), estado: /^r$|reprov|recus/i.test(st) ? 'nao' : /^a$|aprov/i.test(st) ? 'ok' : 'pend' };
    }).filter(function (x) { return x.nome; });
    var n = passos.length;
    /* 04/10: a região só sai de vista sem aprovadores E sem Aprovar/Reprovar nem observação editável
       (ela guarda os botões e o campo OBS_APROVADOR da página) */
    classe(AP.reg, 'nc-he-aprov--vazio', !n && !AP.botoes.length && !obsEditavel());
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; }), atual = -1;
    if (!reprovado) for (var i = 0; i < n; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var aprovados = passos.filter(function (x) { return x.estado === 'ok'; }).length;
    var cancelado = /cancel|suspens/i.test(txt('COD_SIT_REQ'));
    var bts = AP.botoes.filter(function (b) { return b.style.display !== 'none' && (aVista(b) || b.closest('.nc-he-decisao-botoes')); }), vez = bts.length > 0 && !cancelado && atual >= 0;   /* só há o que decidir com uma etapa pendente */
    var assin = JSON.stringify([passos, atual, bts.length, cancelado, AP_ABERTO]);
    if (assin === AP_ASSIN) return;
    AP_ASSIN = assin;
    if (!n) { AP.box.innerHTML = ''; return; }
    var quemNao = passos.filter(function (x) { return x.estado === 'nao'; })[0];
    var estado = reprovado ? 'nao' : cancelado ? 'neutro' : atual < 0 ? 'ok' : vez ? 'vez' : 'pend';
    var resumo = reprovado ? '<b>Reprovado</b> por ' + esc(quemNao.nome) : cancelado ? '<b>Pedido cancelado</b> · ' + aprovados + ' de ' + n + ' aprovaram'
      : atual < 0 ? '<b>Autorizado</b> por ' + (n === 1 ? esc(passos[0].nome) : 'todos') : vez ? '<b>' + aprovados + ' de ' + n + '</b> · <b>é a sua vez</b>'
      : '<b>' + aprovados + ' de ' + n + '</b> · aguardando <b>' + esc(passos[atual].nome) + '</b>';
    classe(AP.reg, 'nc-he-ap-aberto', AP_ABERTO);
    AP.box.className = 'nc-he-ap nc-he-ap--' + estado;
    AP.box.innerHTML = '<p class="nc-he-ap-rot">Aprovação</p><div class="nc-he-ap-cab"><p class="nc-he-ap-resumo">' + resumo + '</p>' +
        '<button type="button" class="nc-he-ap-ver" aria-expanded="' + AP_ABERTO + '">' + (AP_ABERTO ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
      '<ol class="nc-he-ap-passos">' + passos.map(function (x, i) {
        var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === atual && !cancelado ? 'is-vez' : 'is-fila';
        var dia = x.data.replace(/\s.*$/, '');
        var st = x.estado === 'ok' ? (dia || 'Aprovou') : x.estado === 'nao' ? 'Reprovou' + (dia ? ' · ' + dia : '') : cls === 'is-vez' ? (vez ? 'Sua vez' : 'Aguardando') : 'Na fila';
        var ic = x.estado === 'ok' ? '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>' : x.estado === 'nao' ? '<path d="M8 8l8 8M16 8l-8 8"/>' : cls === 'is-vez' ? '<path d="M12 8v4l2.5 1.5"/>' : '';
        return '<li class="nc-he-ap-p ' + cls + '" title="' + esc(x.nome + (x.just ? ': "' + x.just + '"' : '')) + '"><span class="nc-he-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
          '<span class="nc-he-ap-texto"><span class="nc-he-ap-nome">' + esc(x.nome) + '</span><span class="nc-he-ap-estado">' + esc(st) + '</span></span></li>';
      }).join('') + '</ol>' +
      (vez ? '<div class="nc-he-decisao"><p class="nc-he-decisao-txt">Confira o dia e o horário e decida.</p><div class="nc-he-decisao-botoes"></div></div>' : '') +
      (passos.some(function (x) { return x.just; }) ? '<div class="nc-he-ap-justs">' + passos.filter(function (x) { return x.just; }).map(function (x) {
        return '<blockquote class="nc-he-ap-just' + (x.estado === 'nao' ? ' is-nao' : '') + '"><b>' + esc(x.nome) + ':</b> ' + esc(x.just) + '</blockquote>'; }).join('') + '</div>' : '');
    /* 04/10: Aprovar/Reprovar não saem mais de vista: quem decide se aparecem é a condição do botão
       na página (Valida_Sequencia). Fora da "sua vez", voltam ao lugar original. */
    var dest = AP.box.querySelector('.nc-he-decisao-botoes');
    if (!dest) AP.casa.forEach(function (c) { if (c[0].parentNode !== c[1]) c[1].insertBefore(c[0], c[2] && c[2].parentNode === c[1] ? c[2] : null); });
    if (dest) bts.slice().sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) { b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-he-reprovar' : 'nc-he-aprovar'); dest.appendChild(b); });
  }

  /* ═══ [J10] O RODAPÉ ═══════════════════════════════════════════════════════════════════════
     O QUE FAZ  Ao lado do botão "Criar" (que passa a se chamar "Enviar pedido"): a frase do pedido
                ("2 horas · hoje, sexta-feira, 2 de outubro · 18:00 às 20:00") e o que falta; tocar
                num item leva ao campo. Sem nada faltando: "Tudo certo. Pode enviar."
     COMO SABE O QUE FALTA  Pela lista fixa em desenharRodape: empresa, quem vai fazer, dia, hora em
                que começa e hora em que termina (e fim depois do começo).
     PODE MEXER os nomes que aparecem no "Falta:" (o 2º texto de cada f.push) e as frases.
     VISUAL     Natcorp_HoraExtra.css › [C6] e [C11]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FALTA;
  function montarRodape() {
    CRIAR = botaoPorTexto(/^criar$/i);
    SALVAR = botaoPorTexto(/^(salvar|aplicar altera)/i);
    rotuloBotao(CRIAR, 'Enviar pedido');
    if (!CRIAR) return;
    var col = CRIAR.closest('.t-ButtonRegion'), alvo = col && col.querySelector('.t-ButtonRegion-col--content');
    var rb = CRIAR.closest('.t-Region-buttons');
    FALTA = el('div', 'nc-he-falta');
    FALTA.setAttribute('aria-live', 'polite');
    if (alvo) alvo.appendChild(FALTA);
    else if (rb) rb.parentNode.insertBefore(FALTA, rb);
    else if (col) col.parentNode.insertBefore(FALTA, col);
    else { FALTA = null; return; }
    FALTA.addEventListener('click', function (e) {
      var b = e.target.closest('[data-ir]'); if (!b) return;
      var c = cont(b.getAttribute('data-ir')); if (!c) return;
      c.scrollIntoView({ behavior: 'smooth', block: 'center' });
      var bt = c.querySelector('.a-Button--popupLOV, input:not([type=hidden]), textarea');
      if (bt) setTimeout(function () { if (/lov/i.test(bt.className)) bt.click(); else bt.focus(); }, 350);
    });
  }
  function desenharRodape() {
    if (!FALTA) return;
    var f = [], h = horario();
    if (!val('COD_EMPRESA')) f.push(['COD_EMPRESA', 'Empresa']);
    if (!val('MATRICULA')) f.push(['MATRICULA', 'Quem vai fazer']);
    if (!val('DATA_PONTO')) f.push(['DATA_PONTO', 'Dia']);
    if (h.a === null) f.push(['HORA_INICIAL', 'Hora em que começa']);
    if (h.b === null) f.push(['HORA_FINAL', 'Hora em que termina']);
    else if (h.a !== null && !h.d) f.push(['HORA_FINAL', 'Fim depois do começo']);
    var d = dataDe(val('DATA_PONTO'));
    /* "2 horas · hoje, sexta-feira, 2 de outubro · 18:00 às 20:00" */
    var frase = h.d ? '<p class="nc-he-frase"><b>' + esc(duracao(h.d)) + '</b>' + (d ? ' · ' + esc(porExtenso(d)) : '') + ' · ' + hhmm(h.a) + ' às ' + hhmm(h.b) + '</p>' : '';
    html(FALTA, frase + (f.length ? '<div class="nc-he-falta-lista"><span class="nc-he-falta-rot">Falta:</span>' + f.map(function (x) { return '<button type="button" class="nc-he-falta-item" data-ir="' + x[0] + '">' + esc(x[1]) + '</button>'; }).join('') + '</div>'
      : '<span class="nc-he-falta-ok">' + svg(IC.ok) + 'Tudo certo. Pode enviar.</span>'));
  }

  /* ═══ [J11] ACABAMENTOS ════════════════════════════════════════════════════════════════════
     O QUE FAZ  • Só leitura (pedido sem botão Salvar): a caixa vazia de observação do aprovador some.
                • As linhas dos campos que a página esconde (nº, situação, solicitante…) não deixam vão.
                • O título da janela vira "Pedir hora extra" ou "Pedido nº … · hora extra".
     PODE MEXER os títulos da janela (em tituloJanela).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* 04/10: a observação do aprovador é editável para o aprovador pendente (condição da página) */
  function obsEditavel() { var o = document.getElementById(P + 'OBS_APROVADOR'); return !!(o && o.tagName === 'TEXTAREA' && !o.readOnly && !o.disabled); }
  function desenharLeitura() {
    /* 04/10: só some a caixa VAZIA e SÓ LEITURA; editável, fica à vista */
    var c = cont('OBS_APROVADOR'); if (c) classe(c, 'nc-he-fora', LEITURA && !txt('OBS_APROVADOR') && !obsEditavel());
  }

  /* as linhas dos campos que a página esconde (nº, situação, solicitante…) deixam um vão no cartão */
  function linhasVazias() {
    if (PEDIDO || !TOPO) return;
    [].forEach.call(TOPO.querySelectorAll('.row'), function (r) {
      var cs = r.querySelectorAll('.t-Form-fieldContainer');
      classe(r, 'nc-he-fora', cs.length > 0 && ![].some.call(cs, aVista));
    });
  }

  /* ---------- o título da janela ---------- */
  function tituloJanela() {
    try {
      var fora = window.parent && window.parent !== window && window.parent.document;
      if (!fora) return;
      var fr = [].slice.call(fora.querySelectorAll('iframe')).filter(function (i) { return i.contentWindow === window; })[0];
      var t = fr && fr.closest('.ui-dialog') && fr.closest('.ui-dialog').querySelector('.ui-dialog-title');
      var novo = PEDIDO ? 'Pedido nº ' + val('COD_REQ') + ' · hora extra' : 'Pedir hora extra';
      if (t && t.textContent !== novo) t.textContent = novo;
    } catch (x) { /* outro domínio */ }
  }

  /* ═══ [J12] O MAESTRO: QUANDO CADA PARTE É MONTADA ═════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a janela abre: põe a marca nc-he no corpo da página (é
                dela que o visual depende) e monta cada parte. atualizar() redesenha o que muda
                (régua, cabeçalho, aprovação, rodapé) sempre que um campo é alterado, uma ação
                dinâmica traz valores ou uma janela fecha. 700 milésimos depois de abrir, confere de
                novo o relógio, porque o relógio de ponteiros é ligado pelo código da própria página.
     CUIDADO    Não mude a ordem das chamadas em iniciar(): umas partes dependem das anteriores.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T;
  function agendar() { clearTimeout(T); T = setTimeout(atualizar, 60); }
  function atualizar() {
    LEITURA = PEDIDO && !(SALVAR && aVista(SALVAR));
    classe(document.body, 'nc-he-leitura', LEITURA);
    desenharPedidoNovo();
    desenharPedido();
    montarAprovacao();
    desenharRodape();
    desenharLeitura();
  }
  function iniciar() {
    document.body.classList.add('nc-he', PEDIDO ? 'nc-he-modo-pedido' : 'nc-he-modo-novo');
    montarAbertura();
    montarQuem();
    montarPedidoNovo();
    montarPagina();
    montarPedido();
    montarRodape();
    tituloJanela();
    atualizar();
    $(document).on('change', 'input, select, textarea', agendar);
    $(document).on('apexafterrefresh apexafterclosedialog', agendar);
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    /* o relógio de ponteiros é ligado pelo código da própria página: confere de novo depois dele */
    setTimeout(function () { relogioDoCelular(); linhasVazias(); atualizar(); }, 700);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
