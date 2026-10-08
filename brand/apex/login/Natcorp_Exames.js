/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE EXAMES  —  o "arrumador" da tela (JavaScript)                    ║
   ║  App 2937 · Página 61 · Medicina Ocupacional                                              ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   É a página aberta pela aba "Requisição de Exames" do Painel: o gestor pede o exame médico de
   um candidato (admissional) ou de um colaborador (periódico, mudança de função, retorno ao
   trabalho, demissional, perícia…) e escolhe o dia e o horário na agenda. Quem avalia é o
   Médico do Trabalho; aprovado, o compromisso já fica na agenda médica.
   (Mesmo app do Atestado, p91 — outra página.)

     PEDIDO NOVO
       1. Abertura com o caminho: você pede e escolhe o horário → o Médico do Trabalho aprova
          → o exame fica na agenda médica.
       2. Passos numerados: "Quem vai fazer o exame?" (Candidato / Colaborador em cartões) ·
          "Que exame?" (os tipos da lista em cartões, com uma frase simples) · "Quando?" (o
          CARTÃO DA CONSULTA: dia, horário e médico; "Escolher dia e horário") ·
          "Alguma observação?".
       3. Barra no pé: "Exame demissional para Tony em 01/10", o que falta e "Enviar pedido"
          (que clica o botão "Criar" da página).
     PEDIDO GRAVADO
       4. Cabeçalho: nº, situação, o exame, quem faz (código - nome), empresa e filial, o
          cartão da consulta, a observação e quem pediu.
       5. Linha de ações logo abaixo: a Situação (a lista continua editável), Salvar,
          "Cancelar este pedido" e Voltar — trazidos da coluna lateral e do rodapé.
       6. A aprovação logo abaixo, na largura toda (o caminho das outras requisições).

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: isso continua sendo do APEX
       (itens, listas, ações dinâmicas, a janela da agenda, validações e processos).
     • Os cartões preenchem os itens de verdade com apex.item().setValue: as ações da página
       rodam (o tipo de exame mostra/esconde campos e preenche o grupo de exames).
       "Escolher dia e horário" só clica o botão da agenda da própria página.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 61 › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_Exames.js  (no FIM da lista)
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Exames.css.
     A exportação da página já traz as duas URLs (script aplicar-exames.py).

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Esta página NÃO usa classes postas no APEX. O arquivo reconhece a página sozinho, pelos
   itens …_TIPO_PACIENTE, …_COD_TIPO_CONSULTA e …_COD_PACIENTE. Sem eles, não faz nada.
   O começo dos nomes (P61_) é descoberto sozinho, pelo próprio item: se a página for copiada
   para outro número, o arquivo continua funcionando sem mudar nada.
   Outros itens lidos pelo nome (sem o P61_): COD_REQ, ROWID, COD_EMP_PACIENTE, COD_EXAME,
   GRUPO_EXAME_CARGO, DT_DESLIGAMENTO, CARGO_PROPOSTO, FUNCAO_PROPOSTA, LOCAL_PRETENDIDO,
   MEDICO_DSP, DATA_AGENDA_DSP, HORA_INIC_PREVISTO_DSP, HORA_FIM_PREVISTO_DSP, OBSERVACAO,
   COD_SIT_REQ, FILIAL_AUX, MAT_SOLICITANTE, DT_REQ, GRUPO_EXAME_CARGO_DSP.
   Renomear um desses itens no APEX tira aquele pedaço do desenho até o nome ser trocado aqui.
   Os campos, botões e ações dinâmicas continuam os do APEX: aqui eles só MUDAM DE LUGAR.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Os tipos de exame ................... nome, frase e ícone de cada cartão      PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  A abertura e os passos .............. "Pedir um exame médico", 1 2 3 4         PODE MEXER
     [J4]  Passo 1: quem vai fazer o exame ..... Candidato / Colaborador em cartões      PODE MEXER
     [J5]  Passo 2: que exame .................. os tipos da lista em cartões            PODE MEXER
     [J6]  Passo 3: o cartão da consulta ....... dia, horário, médico; e o passo 4       PODE MEXER
     [J7]  A barra do pé ....................... "Falta: …" e "Enviar pedido"            PODE MEXER
     [J8]  O pedido gravado .................... cabeçalho e linha de ações            PODE MEXER
     [J9]  O caminho da aprovação .............. a faixa com os aprovadores
     [J10] O maestro ........................... decide QUANDO cada parte é montada  CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Que exame?'  →  'Qual exame?'
     Apareceu um tipo de exame novo na lista e o cartão dele ficou sem frase nem ícone
       → [J1]: acrescente uma linha na lista TIPOS (a receita está lá).
     Quero mudar a frase de um tipo de exame ("O exame de rotina…")  → [J1], lista TIPOS
     O botão "Escolher dia e horário" não abre a agenda
       → [J6]: o arquivo procura o botão da agenda pelo id dele no APEX e, se não achar, por um
         botão com "agenda" no texto. Se a página mudou de base, confira o id (receita em [J6]).
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
     P + 'COD_PACIENTE'     junta os textos: vira 'P61_COD_PACIENTE', o nome do item no APEX.
     val('X') / txt('X')    leem o que está num item do APEX (veja [J2]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: estas linhas impedem que o arquivo rode duas vezes (URL repetida na página, por
     exemplo), que rode fora do APEX e que rode em outra página. Elas procuram os itens do
     "combinado" e descobrem sozinhas o começo dos nomes (P61_). Não apague. */
  if (window.__ncEX || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_TIPO_PACIENTE_CONTAINER"]');
  if (!achado) return;
  var P = achado.id.replace(/TIPO_PACIENTE_CONTAINER$/, '');
  if (!document.getElementById(P + 'COD_TIPO_CONSULTA') || !document.getElementById(P + 'COD_PACIENTE')) return;
  window.__ncEX = true;

  var $ = apex.jQuery;
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    medico: '<path d="M6 3.5v5a4 4 0 0 0 8 0v-5"/><path d="M10 12.5v2.5a4.5 4.5 0 0 0 9 0v-2"/><circle cx="19" cy="11" r="2"/>',
    cal: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/>',
    calOk: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/><path d="M9 14.5l2 2 4-4"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    pessoaNova: '<circle cx="10" cy="8" r="3.6"/><path d="M3 20c.9-3.9 3.6-6 7-6 1.4 0 2.7.4 3.8 1"/><path d="M18 14v6M15 17h6"/>',
    cracha: '<rect x="5" y="3.5" width="14" height="17" rx="2"/><circle cx="12" cy="10" r="2.6"/><path d="M8.5 16.5c.7-1.7 2-2.5 3.5-2.5s2.8.8 3.5 2.5M10 3.5v2h4v-2"/>',
    entrada: '<path d="M14 4h5v16h-5"/><path d="M4 12h10M10 8l4 4-4 4"/>',
    saida: '<path d="M10 4H5v16h5"/><path d="M10 12h10M16 8l4 4-4 4"/>',
    ciclo: '<path d="M20 12a8 8 0 1 1-2.3-5.6"/><path d="M20 4.5v4h-4"/>',
    troca: '<path d="M4 8h13l-3-3M20 16H7l3 3"/>',
    volta: '<path d="M9 14l-5-5 5-5"/><path d="M4 9h10a6 6 0 0 1 0 12h-3"/>',
    lupa: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    seta: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    predio: '<path d="M4 20V6l7-2v16M11 9h7v11M4 20h16"/><path d="M7 8h1M7 11h1M7 14h1M14 12h1M14 15h1"/>',
    fala: '<path d="M4.5 5.5h15v10h-8l-4.5 3.5v-3.5h-2.5z"/>',
    pessoa: '<circle cx="12" cy="8" r="3.6"/><path d="M4.5 20c.9-3.9 3.9-6 7.5-6s6.6 2.1 7.5 6"/>',
    selo: '<path d="M12 3l2.4 1.8 3-.2.9 2.9 2.4 1.8-1 2.8 1 2.8-2.4 1.8-.9 2.9-3-.2L12 21l-2.4-1.8-3 .2-.9-2.9L3.3 14.7l1-2.8-1-2.8 2.4-1.8.9-2.9 3 .2z"/><path d="M8.8 12.2l2.2 2.2 4.2-4.4"/>'
  };
  /* ═══ [J1] OS TIPOS DE EXAME ════════════════════════════════════════════════════════════
     O QUE É    A "ficha" de cada tipo de exame, usada nos cartões do passo 2, na barra do pé e no
                cabeçalho do pedido gravado.
     COMO       O tipo é reconhecido pelo NOME que a lista do APEX traz, não pelo código (o código
                muda de base para base). Cada linha da lista TIPOS tem 4 partes:
                  [ /pedaço do nome/i , 'Nome no cartão' , 'Frase simples' , IC.ícone ]
                A primeira é um "padrão de busca": /demiss/i acha "Demissional", "DEMISSIONAL"…
                Um tipo da lista do APEX que não case com nenhuma linha vira um cartão só com o
                texto da lista (sem frase, com o ícone do médico).
     PODE MEXER • o nome e a frase de cada tipo (segunda e terceira partes, entre aspas).
                • RECEITA — tipo novo: copie uma linha inteira, troque o pedaço do nome (entre as
                  barras, sem acento se a lista às vezes vem sem acento), o nome e a frase. O ícone
                  pode ser qualquer um da lista IC acima (IC.medico, IC.lupa, IC.cal…).
     CUIDADO    Mantenha as vírgulas entre as linhas e o ]; no fim da lista.
                Os nomes dos dias e meses logo abaixo também PODEM ser mudados.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: [ /pedaço do nome na lista/i, 'Nome', 'Frase', ícone ] — os tipos de exame */
  var TIPOS = [
    [/admiss/i, 'Admissional', 'Antes de a pessoa começar a trabalhar.', IC.entrada],
    [/peri[oó]dic/i, 'Periódico', 'O exame de rotina, feito de tempos em tempos.', IC.ciclo],
    [/mudan|fun[cç][aã]o/i, 'Mudança de função', 'Quando a pessoa vai trocar de função ou de cargo.', IC.troca],
    [/retorno/i, 'Retorno ao trabalho', 'Na volta de um afastamento (doença, acidente, licença).', IC.volta],
    [/demiss/i, 'Demissional', 'Quando a pessoa vai sair da empresa.', IC.saida],
    [/per[ií]cia/i, 'Perícia', 'Uma avaliação específica do Médico do Trabalho.', IC.lupa]
  ];
  var DIAS = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'];
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];

  /* ═══ [J2] FERRAMENTAS ══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo: ler um item do APEX, achar um botão
                pelo texto, trocar um rótulo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('ITEM')        o que o APEX GUARDA no item (o código da opção)
       txt('ITEM')        o que a PESSOA VÊ no item (o texto da opção escolhida numa lista)
       cont('ITEM')       o bloco inteiro do campo na tela (rótulo + campo)
       renomear('ITEM', 'Texto')   troca o rótulo do campo na tela
       partes('700 - Natcorp Do Brasil')  separa código e nome; comCodigo() junta de novo como
                          "700 - Natcorp do Brasil" (na tela, sempre código - descrição)
       Em todas, 'ITEM' é o nome SEM o P61_ (o arquivo junta o começo sozinho).
     QUANDO MEXER  Quase nunca.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-ex-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
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
    t = t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em|Ao)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); });
    return t.replace(/\b(Concluid|Suspensao|Periodico|Pericia)(\w*)/g, function (m, r, f) { return ({ Concluid: 'Concluíd', Suspensao: 'Suspensão', Periodico: 'Periódico', Pericia: 'Perícia' })[r] + f; });
  }
  /* "700 - Natcorp Do Brasil" → { cod: '700', nome: 'Natcorp do Brasil' } */
  function partes(t) {
    t = limpo(t);
    var m = /^\s*([\w.]+)\s+-\s+(.+)$/.exec(t); if (m) return { cod: m[1], nome: bonito(m[2]) };
    m = /^(.+?)\s*\(([\w.]+)\)\s*$/.exec(t); if (m) return { cod: m[2], nome: bonito(m[1]) };
    return { cod: '', nome: bonito(t) };
  }
  /* código - descrição, sempre (o usuário reconhece pelo código) */
  function comCodigo(p) { return p.cod ? p.cod + ' - ' + p.nome : p.nome; }
  function aVista(e) { return !!(e && (e.offsetParent || e.getClientRects().length)); }
  function botaoPorTexto(re) {
    return [].filter.call(document.querySelectorAll('button.t-Button, a.t-Button'), function (b) {
      return re.test(b.getAttribute('data-nc-ex-orig') || b.textContent.replace(/\s+/g, ' ').trim());
    });
  }
  function rotuloBotao(b, t) {
    if (!b) return;
    if (!b.getAttribute('data-nc-ex-orig')) b.setAttribute('data-nc-ex-orig', b.textContent.replace(/\s+/g, ' ').trim());
    var l = b.querySelector('.t-Button-label');
    if (l && l.textContent !== t) l.textContent = t;
  }
  function renomear(n, t) {
    var l = document.getElementById(P + n + '_LABEL');
    if (!l || l.getAttribute('data-nc-ex') === t) return;
    for (var i = 0; i < l.childNodes.length; i++) {
      var x = l.childNodes[i];
      if (x.nodeType === 3 && x.textContent.trim()) { x.textContent = t + ' '; l.setAttribute('data-nc-ex', t); return; }
    }
  }
  function tipoDe(texto) { for (var i = 0; i < TIPOS.length; i++) if (TIPOS[i][0].test(texto || '')) return TIPOS[i]; return null; }
  function dataDe(t) { var m = /^(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function hora(t) { var m = /(\d{1,2}):(\d{2})/.exec(t || ''); return m ? ('0' + m[1]).slice(-2) + ':' + m[2] : ''; }

  var PEDIDO = !!(val('COD_REQ') || val('ROWID'));
  var CRIAR, LEITURA, PASSO_REG = {};

  /* ═══ [J3] A ABERTURA E OS PASSOS ═══════════════════════════════════════════════════════
     O QUE FAZ  No pedido novo, põe no alto a abertura "Pedir um exame médico" com o caminho em
                3 etapas. passo() e poePasso() desenham o número e o título de cada passo
                (1 Quem · 2 Que exame · 3 Quando · 4 Observação) no começo da região do APEX.
     PODE MEXER os textos entre aspas da abertura. Os títulos dos passos estão em [J4], [J5] e [J6].
     VISUAL     Natcorp_Exames.css › [C2] (abertura) e [C3] (passos)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarAbertura() {
    if (PEDIDO) return;
    var alvo = cont('TIPO_PACIENTE').closest('.t-Region'), menu = alvo && alvo.parentElement.closest('.t-Region');
    while (menu && menu.parentElement.closest('.t-Region')) menu = menu.parentElement.closest('.t-Region');
    alvo = menu || alvo; if (!alvo) return;
    var a = el('section', 'nc-ex-abertura');
    a.innerHTML = '<h1 class="nc-ex-abertura-tit">Pedir um exame médico</h1>' +
      '<p>Para um candidato que vai ser contratado ou para um colaborador. Você escolhe o exame e o horário na agenda.</p>' +
      '<ol class="nc-ex-caminho">' +
        '<li><span class="nc-ex-cp-ic">' + svg(IC.lapis) + '</span><span><b>Você pede</b>e escolhe o dia e o horário</span></li>' +
        '<li><span class="nc-ex-cp-ic">' + svg(IC.medico) + '</span><span><b>O Médico do Trabalho</b>avalia e aprova</span></li>' +
        '<li><span class="nc-ex-cp-ic">' + svg(IC.calOk) + '</span><span><b>O exame</b>fica na agenda médica</span></li>' +
      '</ol>';
    alvo.parentNode.insertBefore(a, alvo);
  }
  function passo(n, t, sub) {
    var h = el('div', 'nc-ex-passo');
    h.innerHTML = '<span class="nc-ex-passo-n">' + n + '</span><span class="nc-ex-passo-txt"><span class="nc-ex-passo-t">' + esc(t) + '</span>' + (sub ? '<span class="nc-ex-passo-sub">' + esc(sub) + '</span>' : '') + '</span>';
    return h;
  }
  function poePasso(reg, n, t, sub) {
    if (!reg || reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body > .nc-ex-passo')) return;
    reg.classList.add('nc-ex-passo-reg');
    var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
    corpo.insertBefore(passo(n, t, sub), corpo.firstChild);
  }

  /* ═══ [J4] PASSO 1: QUEM VAI FAZER O EXAME ══════════════════════════════════════════════
     O QUE FAZ  Transforma o rádio TIPO_PACIENTE em dois cartões: "Candidato — Vai ser contratado"
                e "Colaborador — Já trabalha na empresa". Renomeia os campos ("É um", "Quem").
                Clicar na caixa do paciente (COD_PACIENTE) abre a lista dele.
     PODE MEXER os textos entre aspas: o título e a explicação do passo 1, as frases dos cartões
                ('Vai ser contratado', 'Já trabalha na empresa') e os rótulos.
     VISUAL     Natcorp_Exames.css › [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarQuem() {
    var reg = cont('TIPO_PACIENTE').closest('.t-Region');
    PASSO_REG.quem = reg;
    reg.classList.add('nc-ex-reg');
    if (!PEDIDO) poePasso(reg, 1, 'Quem vai fazer o exame?', 'Um candidato que vai ser contratado ou alguém que já trabalha na empresa.');
    var c = cont('TIPO_PACIENTE'); c.classList.add('nc-ex-tipo-pessoa');
    renomear('TIPO_PACIENTE', 'É um');
    [].forEach.call(c.querySelectorAll('input[type=radio]'), function (i) {
      var l = c.querySelector('label[for="' + i.id + '"]'); if (!l || l.querySelector('.nc-ex-op')) return;
      var cand = /candid/i.test(l.textContent);
      l.innerHTML = '<span class="nc-ex-op">' + svg(cand ? IC.pessoaNova : IC.cracha) + '<span class="nc-ex-op-txt"><b>' + esc(limpo(l.textContent)) + '</b><span>' +
        (cand ? 'Vai ser contratado' : 'Já trabalha na empresa') + '</span></span></span>';
    });
    renomear('COD_PACIENTE', 'Quem');
    var i = document.getElementById(P + 'COD_PACIENTE'), b = document.getElementById(P + 'COD_PACIENTE_lov_btn');
    if (i && b && !i.__ncEX) { i.__ncEX = true; i.addEventListener('click', function () { if (!b.disabled) b.click(); }); }
  }

  /* ═══ [J5] PASSO 2: QUE EXAME ═══════════════════════════════════════════════════════════
     O QUE FAZ  Mostra as opções da lista COD_TIPO_CONSULTA como cartões (nome, frase e ícone vêm
                de [J1]). Tocar num cartão escolhe a opção NA LISTA DO APEX (setValue), e as ações
                da página rodam: data de desligamento, cargo/função/local propostos, grupo de exames.
                A lista depende de Tipo de Paciente, Empresa e Paciente: vazia, o cartão diz
                "Escolha a empresa e quem vai fazer o exame (passo 1)". O campo "Exame" (sempre ASO)
                só aparece depois de escolher o tipo, com uma explicação curta.
     PODE MEXER os textos entre aspas (título do passo, rótulos, mensagens de lista vazia, a
                explicação do ASO).
     VISUAL     Natcorp_Exames.css › [C4] e [C9]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var CARTOES;
  function montarExame() {
    var c = cont('COD_TIPO_CONSULTA'), reg = c.closest('.t-Region');
    PASSO_REG.exame = reg;
    reg.classList.add('nc-ex-reg');
    if (!PEDIDO) poePasso(reg, 2, 'Que exame?', 'Toque no exame. Na dúvida, fale com o RH ou com o Médico do Trabalho.');
    renomear('COD_TIPO_CONSULTA', 'Tipo de exame');
    renomear('GRUPO_EXAME_CARGO', 'Grupo de exames');
    renomear('DT_DESLIGAMENTO', 'Data do desligamento');
    var sel = document.getElementById(P + 'COD_TIPO_CONSULTA');
    if (!sel || sel.tagName !== 'SELECT') return;
    c.classList.add('nc-ex-tipo-exame');
    CARTOES = el('div', 'nc-ex-cartoes');
    CARTOES.setAttribute('role', 'radiogroup');
    CARTOES.setAttribute('aria-label', 'Tipo de exame');
    (c.querySelector('.t-Form-inputContainer') || c).appendChild(CARTOES);
    CARTOES.addEventListener('click', function (e) {
      var b = e.target.closest('[data-v]'); if (!b || sel.disabled) return;
      if (sel.value !== b.getAttribute('data-v')) apex.item(sel.id).setValue(b.getAttribute('data-v'));
      agendar();
    });
  }
  function desenharExame() {
    if (!CARTOES) return;
    var sel = document.getElementById(P + 'COD_TIPO_CONSULTA');
    var ops = [].filter.call(sel.options, function (o) { return o.value; });
    var atual = sel.value;
    html(CARTOES, ops.length ? ops.map(function (o) {
      var t = tipoDe(o.text), on = o.value === atual;
      return '<button type="button" class="nc-ex-cartao' + (on ? ' is-on' : '') + '" role="radio" aria-checked="' + on + '" data-v="' + esc(o.value) + '">' +
        '<span class="nc-ex-cartao-ic">' + svg(t ? t[3] : IC.medico) + '</span>' +
        '<span class="nc-ex-cartao-txt"><span class="nc-ex-cartao-nome">' + esc(t ? t[1] : bonito(o.text)) + '</span>' + (t ? '<span class="nc-ex-cartao-para">' + esc(t[2]) + '</span>' : '') + '</span>' +
        '<span class="nc-ex-cartao-marca" aria-hidden="true">' + svg(IC.ok) + '</span></button>';
    }).join('') : '<p class="nc-ex-vazio">' + (val('COD_EMP_PACIENTE') && val('COD_PACIENTE') ? 'Nenhum exame disponível para esta pessoa. Fale com o RH.' : 'Escolha a empresa e quem vai fazer o exame (passo 1) para ver os exames.') + '</p>');
    /* o "Exame" é sempre ASO: fica como informação curta
       04/10: e fica à vista como na página (antes só aparecia depois de escolher o tipo — um
       mostrar/esconder que a página não tem) */
    var ex = cont('COD_EXAME');
    if (ex && !ex.querySelector('.nc-ex-aso')) {
      var ic = ex.querySelector('.t-Form-inputContainer');
      if (ic) ic.appendChild(el('span', 'nc-ex-aso', 'Atestado de Saúde Ocupacional: o documento do exame do trabalho.'));
    }
  }

  /* ═══ [J6] PASSO 3: O CARTÃO DA CONSULTA (e o passo 4, observação) ══════════════════════
     O QUE FAZ  Esconde os campos de exibição da agenda (MEDICO_DSP, DATA_AGENDA_DSP,
                HORA_INIC_PREVISTO_DSP, HORA_FIM_PREVISTO_DSP) e mostra no lugar um cartão:
                  sem horário ... "Ainda sem dia e horário" + botão "Escolher dia e horário"
                  com horário ... o dia em destaque, o dia da semana, "08:00 às 08:30", o médico e
                                  "Trocar horário"
                Os botões do cartão CLICAM o botão "Agenda - Datas e Horários" da página (que fica
                fora de vista). A agenda é a janela 2937:75.
                Também põe o passo 4 ("Alguma observação?") antes do campo OBSERVACAO.
     CUIDADO    O botão da agenda é achado pelo id 'B149281259269045406700' e, se não existir, pelo
                primeiro botão com "agenda" no texto. Se a página for exportada para outra base e
                o id mudar, o segundo jeito costuma funcionar; se não, troque o id aqui pelo novo
                (Page Designer › botão › Static ID ou o id que aparece no HTML).
     PODE MEXER os textos entre aspas do cartão e do passo 4.
     VISUAL     Natcorp_Exames.css › [C10] (a cor final: [C15])
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var CONSULTA, BT_AGENDA;
  function montarQuando() {
    BT_AGENDA = document.getElementById('B149281259269045406700') || botaoPorTexto(/agenda/i)[0];
    var base = cont('DATA_AGENDA_DSP'), reg = base && base.closest('.t-Region');
    if (!reg) return;
    PASSO_REG.quando = reg;
    reg.classList.add('nc-ex-reg', 'nc-ex-quando');
    if (!PEDIDO) poePasso(reg, 3, 'Quando?', 'Escolha o dia e o horário na agenda do Médico do Trabalho.');
    ['MEDICO_DSP', 'DATA_AGENDA_DSP', 'HORA_INIC_PREVISTO_DSP', 'HORA_FIM_PREVISTO_DSP'].forEach(function (n) { var c = cont(n); if (c) c.closest('.row').classList.add('nc-ex-fora'); });
    CONSULTA = el('div', 'nc-ex-consulta');
    var passo3 = reg.querySelector('.nc-ex-passo');
    var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    if (passo3) passo3.after(CONSULTA); else corpo.insertBefore(CONSULTA, corpo.firstChild);
    if (BT_AGENDA) BT_AGENDA.classList.add('nc-ex-fora');
    CONSULTA.addEventListener('click', function (e) { if (e.target.closest('[data-agenda]') && BT_AGENDA) BT_AGENDA.click(); });
    /* 4. a observação */
    var co = cont('OBSERVACAO'), lo = co && co.closest('.row');
    if (lo && !PEDIDO) {
      lo.parentNode.insertBefore(passo(4, 'Alguma observação?', 'Não é obrigatório. Ex.: o candidato só pode de manhã.'), lo);
      renomear('OBSERVACAO', 'Observação para o Médico do Trabalho');
      var t = document.getElementById(P + 'OBSERVACAO');
      if (t && !t.getAttribute('placeholder')) t.setAttribute('placeholder', 'Ex.: vai trabalhar em altura; precisa de exame de visão.');
    }
  }
  function consultaHTML(grande) {
    var d = dataDe(txt('DATA_AGENDA_DSP')), ini = hora(txt('HORA_INIC_PREVISTO_DSP')), fim = hora(txt('HORA_FIM_PREVISTO_DSP'));
    var med = txt('MEDICO_DSP');
    /* 04/10: no pedido gravado a página ainda deixa escolher o horário enquanto não há agenda (a
       região Agendamento só fica "só leitura" com agenda ou na situação 2/3/4 — a mesma que tira
       o Salvar); antes, o botão sumia em todo pedido gravado */
    var pode = BT_AGENDA && !BT_AGENDA.disabled && BT_AGENDA.style.display !== 'none' && (!PEDIDO || (!d && !!botaoPorTexto(/^salvar$/i)[0]));
    if (!d) {
      return '<div class="nc-ex-consulta-vazia">' + svg(IC.cal) + '<div><p class="nc-ex-consulta-tit">Ainda sem dia e horário</p>' +
        '<p class="nc-ex-consulta-sub">' + (pode ? 'Abra a agenda e escolha um horário livre.' : 'O horário não foi escolhido.') + '</p></div>' +
        (pode ? '<button type="button" class="nc-ex-bt nc-ex-bt--forte" data-agenda="1">' + svg(IC.cal) + '<span>Escolher dia e horário</span></button>' : '') + '</div>';
    }
    return '<div class="nc-ex-bilhete' + (grande ? ' nc-ex-bilhete--hero' : '') + '"><div class="nc-ex-bilhete-dia"><span class="nc-ex-bilhete-mes">' + esc(MESES[d.getMonth()].slice(0, 3)) + '</span><span class="nc-ex-bilhete-n">' + d.getDate() + '</span><span class="nc-ex-bilhete-ano">' + d.getFullYear() + '</span></div>' +
      '<div class="nc-ex-bilhete-txt"><p class="nc-ex-bilhete-sem">' + esc(DIAS[d.getDay()].replace(/^./, function (c) { return c.toUpperCase(); })) + ', ' + d.getDate() + ' de ' + MESES[d.getMonth()] + '</p>' +
      (ini ? '<p class="nc-ex-bilhete-hora">' + svg(IC.relogio) + '<span><b>' + ini + (fim ? ' às ' + fim : '') + '</b></span></p>' : '') +
      (med ? '<p class="nc-ex-bilhete-med">' + svg(IC.medico) + '<span>' + esc(comCodigo(partes(med))) + '</span></p>' : '') + '</div>' +
      (pode ? '<button type="button" class="nc-ex-bt nc-ex-bt--claro" data-agenda="1">' + svg(IC.cal) + '<span>Trocar horário</span></button>' : '') + '</div>';
  }
  function desenharQuando() { if (CONSULTA) html(CONSULTA, consultaHTML(false)); }

  /* ═══ [J7] A BARRA DO PÉ ════════════════════════════════════════════════════════════════
     O QUE FAZ  Só no pedido novo: uma barra fixa no pé da tela com a frase do pedido ("Exame
                demissional para Tony em 01/10"), "Falta: …" (tocar leva ao campo, abre a lista ou
                a agenda) e "Enviar pedido", que clica o botão "Criar" da página.
     COMO SABE O QUE FALTA  Pela lista fixa em desenharBarra(): empresa, quem vai fazer, tipo de
                exame, data do desligamento (quando aparece), cargo/função/local propostos (quando
                aparecem e são obrigatórios no APEX) e o dia e horário.
     PODE MEXER os nomes do "Falta" (o segundo texto de cada f.push([..., 'Nome'])), a frase e
                'Tudo certo. Pode enviar.'
     IMPORTANTE Isso só AVISA. Quem impede o envio sem um campo é a validação do APEX.
     VISUAL     Natcorp_Exames.css › [C13]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var BARRA;
  function montarBarra() {
    CRIAR = botaoPorTexto(/^criar$/i)[0];
    rotuloBotao(CRIAR, 'Enviar pedido');
    if (!CRIAR || PEDIDO) return;
    BARRA = el('div', 'nc-ex-barra');
    BARRA.setAttribute('role', 'region');
    BARRA.setAttribute('aria-label', 'Resumo do pedido');
    BARRA.innerHTML = '<div class="nc-ex-barra-txt" aria-live="polite"></div><button type="button" class="nc-ex-bt nc-ex-bt--forte" data-acao="enviar">' + svg(IC.seta) + '<span>Enviar pedido</span></button>';
    document.body.appendChild(BARRA);
    document.body.classList.add('nc-ex-com-barra');
    BARRA.addEventListener('click', function (e) {
      if (e.target.closest('[data-acao="enviar"]')) { CRIAR.click(); return; }
      var ir = e.target.closest('[data-ir]'); if (!ir) return;
      var n = ir.getAttribute('data-ir');
      if (n === 'AGENDA') { if (BT_AGENDA) BT_AGENDA.click(); return; }
      var c = cont(n); if (!c) return;
      c.scrollIntoView({ behavior: 'smooth', block: 'center' });
      var b = c.querySelector('.a-Button--popupLOV'), f = c.querySelector('select:not([hidden]), input:not([type=hidden]):not([readonly])');
      setTimeout(function () { if (b) b.click(); else if (f) f.focus(); }, 400);
    });
  }
  function desenharBarra() {
    if (!BARRA) return;
    var f = [];
    if (!val('COD_EMP_PACIENTE')) f.push(['COD_EMP_PACIENTE', 'Empresa']);
    if (!val('COD_PACIENTE')) f.push(['COD_PACIENTE', 'Quem vai fazer']);
    if (!val('COD_TIPO_CONSULTA')) f.push(['COD_TIPO_CONSULTA', 'Tipo de exame']);
    var dd = cont('DT_DESLIGAMENTO'); if (dd && aVista(dd) && !val('DT_DESLIGAMENTO')) f.push(['DT_DESLIGAMENTO', 'Data do desligamento']);
    ['CARGO_PROPOSTO', 'FUNCAO_PROPOSTA', 'LOCAL_PRETENDIDO'].forEach(function (n) { var c = cont(n); if (c && aVista(c) && c.classList.contains('is-required') && !val(n)) f.push([n, limpo((document.getElementById(P + n + '_LABEL') || {}).textContent)]); });
    if (!txt('DATA_AGENDA_DSP')) f.push(['AGENDA', 'Dia e horário']);
    var t = tipoDe(txt('COD_TIPO_CONSULTA')), quem = partes(txt('COD_PACIENTE')).nome.split(' ')[0];
    var frase = t && quem ? '<p class="nc-ex-frase">Exame <b>' + esc(t[1].toLowerCase()) + '</b> para <b>' + esc(quem) + '</b>' + (txt('DATA_AGENDA_DSP') ? ' em <b>' + esc(txt('DATA_AGENDA_DSP').slice(0, 5)) + '</b>' : '') + '</p>' : '';
    html(BARRA.querySelector('.nc-ex-barra-txt'), frase + (f.length ? '<div class="nc-ex-falta-lista"><span class="nc-ex-barra-rot">Falta:</span>' + f.map(function (x) { return '<button type="button" class="nc-ex-falta" data-ir="' + x[0] + '">' + esc(x[1]) + '</button>'; }).join('') + '</div>'
      : '<span class="nc-ex-barra-ok">' + svg(IC.ok) + 'Tudo certo. Pode enviar.</span>'));
  }

  /* ═══ [J8] O PEDIDO GRAVADO: CABEÇALHO E LINHA DE AÇÕES ═════════════════════════════════
     O QUE FAZ  • Cabeçalho: "Pedido nº …", a situação em etiqueta colorida, "Exame periódico ·
                  ASO", "Para 633339 - Alves · colaborador", empresa e filial com código, os dados
                  extras quando houver (desligamento, cargo/função/local propostos, grupo de exames),
                  o cartão da consulta, a observação e "Pedido em … por …".
                • Linha de ações logo abaixo: a lista Situação (continua editável, com a ação da
                  página), Salvar, "Cancelar este pedido" e Voltar, trazidos da coluna lateral e do
                  rodapé. O "Voltar" repetido sai de vista. A coluna lateral (só leitura) some e o
                  conteúdo ocupa a largura toda.
     PODE MEXER os textos entre aspas; a lista "extra" (cada par é ['ITEM', 'Rótulo']: para mostrar
                mais um dado no cabeçalho, copie um par e troque o item e o rótulo).
     VISUAL     Natcorp_Exames.css › [C5] e [C11] (a cor final: [C15])
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var HERO, ACOES, LATERAL;
  function montarPedido() {
    if (!PEDIDO) return;
    LATERAL = cont('COD_REQ') && cont('COD_REQ').closest('.t-Region');
    while (LATERAL && LATERAL.parentElement.closest('.t-Region')) LATERAL = LATERAL.parentElement.closest('.t-Region');
    var menu = cont('TIPO_PACIENTE').closest('.t-Region');
    while (menu && menu.parentElement.closest('.t-Region')) menu = menu.parentElement.closest('.t-Region');
    if (!menu) return;
    HERO = el('section', 'nc-ex-hero');
    menu.parentNode.insertBefore(HERO, menu);
    /* 04/10: o "Escolher dia e horário" do cartão do cabeçalho clica o botão da agenda da página */
    HERO.addEventListener('click', function (e) { if (e.target.closest('[data-agenda]') && BT_AGENDA) BT_AGENDA.click(); });
    /* os botões da coluna lateral (Cancelar, Voltar…) numa linha de ações logo abaixo do cabeçalho */
    ACOES = el('div', 'nc-ex-acoes');
    HERO.after(ACOES);
    if (LATERAL && LATERAL !== menu) {
      [].forEach.call(LATERAL.querySelectorAll('button.t-Button, a.t-Button'), function (b) {
        if (b.id === 't_Button_navControl') return;
        if (/cancelar/i.test(b.textContent)) { b.classList.add('nc-ex-cancelar'); rotuloBotao(b, 'Cancelar este pedido'); }
        ACOES.appendChild(b);
      });
      var colL = LATERAL.closest('.col'), colM = HERO.closest('.col');
      LATERAL.classList.add('nc-ex-lateral');
      if (colL && colL !== colM) colL.classList.add('nc-ex-col-vazia');
      if (colM) colM.classList.add('nc-ex-col-cheia');
      /* a Situação é uma lista que ainda muda (com ação da página): vem para a linha de ações,
         com o Salvar; o resto da coluna lateral é só leitura e o cabeçalho já diz */
      var sit = document.getElementById(P + 'COD_SIT_REQ'), cs = cont('COD_SIT_REQ');
      if (sit && cs && sit.tagName === 'SELECT' && !sit.disabled) {
        cs.classList.add('nc-ex-acao-sit');
        renomear('COD_SIT_REQ', 'Situação');
        ACOES.insertBefore(cs, ACOES.firstChild);
      }
      var salvar = botaoPorTexto(/^salvar$/i)[0];
      if (salvar) {
        var regB = salvar.closest('.t-ButtonRegion, .t-Region');
        ACOES.insertBefore(salvar, cs && ACOES.contains(cs) ? cs.nextSibling : ACOES.firstChild);
        /* o outro "Voltar", repetido embaixo, sai de vista; a região vazia também */
        if (regB) {
          [].forEach.call(regB.querySelectorAll('button.t-Button, a.t-Button'), function (b) { if (/^voltar$/i.test(b.textContent.trim())) b.classList.add('nc-ex-fora'); });
          if (![].some.call(regB.querySelectorAll('button.t-Button, a.t-Button'), function (b) { return !b.classList.contains('nc-ex-fora') && b.style.display !== 'none'; })) regB.classList.add('nc-ex-fora');
        }
      }
      /* a coluna do lado esquerdo da página ficou vazia: o conteúdo ocupa a largura toda */
      if (LATERAL.closest('.t-Body-side')) document.body.classList.add('nc-ex-sem-lateral');
    }
  }
  function desenharPedido() {
    if (!HERO) return;
    var sit = txt('COD_SIT_REQ');
    var tom = /aprov|conclu/i.test(sit) ? 'bom' : /reprov/i.test(sit) ? 'ruim' : /cancel|suspens/i.test(sit) ? 'neutro' : 'espera';
    var t = tipoDe(txt('COD_TIPO_CONSULTA')), quem = partes(txt('COD_PACIENTE'));
    var tipoPessoa = (document.querySelector('#' + P + 'TIPO_PACIENTE input:checked') || {}).value;
    var tp = tipoPessoa ? (/candid/i.test(((document.querySelector('label[for="' + document.querySelector('#' + P + 'TIPO_PACIENTE input:checked').id + '"]') || {}).textContent) || '') ? 'Candidato' : 'Colaborador') : '';
    var emp = comCodigo(partes(txt('COD_EMP_PACIENTE'))), fil = comCodigo(partes(txt('FILIAL_AUX')));
    var sol = comCodigo(partes(txt('MAT_SOLICITANTE')));
    var extra = [['DT_DESLIGAMENTO', 'Desligamento'], ['CARGO_PROPOSTO', 'Cargo proposto'], ['FUNCAO_PROPOSTA', 'Função proposta'], ['LOCAL_PRETENDIDO', 'Local pretendido'], ['GRUPO_EXAME_CARGO_DSP', 'Grupo de exames']]
      .map(function (x) { var v = txt(x[0]); return v ? '<li><span>' + esc(x[1]) + '</span><b>' + esc(/\s-\s|\(/.test(v) ? comCodigo(partes(v)) : v) + '</b></li>' : ''; }).join('');   /* código puro (SRO) fica como veio */
    html(HERO, '<div class="nc-ex-hero-topo"><p class="nc-ex-hero-n">Pedido nº <b>' + esc(val('COD_REQ')) + '</b></p>' +
      (sit ? '<span class="nc-ex-sit nc-ex-sit--' + tom + '">' + esc(bonito(sit)) + '</span>' : '') + '</div>' +
      '<h2 class="nc-ex-hero-tit">' + svg(t ? t[3] : IC.medico) + '<span>Exame ' + esc(t ? t[1].toLowerCase() : bonito(txt('COD_TIPO_CONSULTA')).toLowerCase()) + (val('COD_EXAME') ? ' <small>· ' + esc(val('COD_EXAME')) + '</small>' : '') + '</span></h2>' +
      '<p class="nc-ex-hero-para">' + svg(IC.pessoa) + '<span>Para <b>' + esc(comCodigo(quem) || '—') + '</b>' + (tp ? ' · ' + tp.toLowerCase() : '') + '</span></p>' +
      ((emp || fil) ? '<p class="nc-ex-hero-emp">' + svg(IC.predio) + '<span>' + (emp ? 'Empresa <b>' + esc(emp) + '</b>' : '') + (fil ? (emp ? ' · ' : '') + 'Filial <b>' + esc(fil) + '</b>' : '') + '</span></p>' : '') +
      (extra ? '<ul class="nc-ex-hero-extra">' + extra + '</ul>' : '') +
      '<div class="nc-ex-hero-consulta">' + consultaHTML(true) + '</div>' +
      (txt('OBSERVACAO') ? '<blockquote class="nc-ex-hero-motivo">' + svg(IC.fala) + '<span>' + esc(txt('OBSERVACAO')) + '</span></blockquote>' : '') +
      '<p class="nc-ex-hero-quem">Pedido em <b>' + esc(val('DT_REQ')) + '</b>' + (sol ? ' por <b>' + esc(sol) + '</b>' : '') + '</p>');
  }

  /* ═══ [J9] O CAMINHO DA APROVAÇÃO (o mesmo das outras requisições) ══════════════════════
     O QUE FAZ  A região dos aprovadores sobe para logo abaixo da linha de ações e vira uma faixa:
                "1 de 2 · aguardando Fulano", os aprovadores em linha (aprovou / reprovou / é a vez
                / na fila) e o que cada um escreveu. Para quem aprova, com uma etapa pendente, os
                botões Aprovar/Reprovar do APEX vêm para dentro da faixa ("é a sua vez").
     LÊ DE      as colunas do relatório de aprovadores: APROVADOR, STATUS, DATA, JUSTIFICATIVA.
     CUIDADO    Se essas colunas forem renomeadas no relatório do APEX, a faixa não acha os dados.
     PODE MEXER os textos entre aspas: 'Aprovação', 'Ver o caminho', 'Sua vez', 'Na fila',
                'Confira o exame e o horário e decida.'…
     VISUAL     Natcorp_Exames.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var AP = null, AP_ABERTO = false, AP_ASSIN = '';
  function nomeAprovador(t) { var m = /^\s*\d+\s*-\s*\d+\s*-\s*(.+)$/.exec(t || ''); return bonito(m ? m[1] : t); }
  function montarAprovacao() {
    if (!PEDIDO) return;
    if (!AP) {
      var th = document.querySelector('table.t-Report-report th#APROVADOR, td[headers="APROVADOR"]');
      var reg = th && th.closest('.t-Region'); if (!reg) return;
      AP = { reg: reg, botoes: [].slice.call(document.querySelectorAll('button.t-Button, a.t-Button')).filter(function (b) { return /^(aprovar|reprovar)$/i.test(b.textContent.trim()); }) };
      reg.classList.add('nc-ex-aprov');
      if (ACOES) ACOES.after(reg); else if (HERO) HERO.after(reg);
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
      AP.box = el('div', 'nc-ex-ap');
      corpo.insertBefore(AP.box, corpo.firstChild);
      AP.box.addEventListener('click', function (e) { if (e.target.closest('.nc-ex-ap-ver')) { AP_ABERTO = !AP_ABERTO; AP_ASSIN = ''; agendar(); } });
    }
    var passos = [].slice.call(AP.reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; }
      var st = c('STATUS');
      return { nome: nomeAprovador(c('APROVADOR')), data: c('DATA'), just: c('JUSTIFICATIVA'), estado: /^r$|reprov|recus/i.test(st) ? 'nao' : /^a$|aprov/i.test(st) ? 'ok' : 'pend' };
    }).filter(function (x) { return x.nome; });
    var n = passos.length;
    classe(AP.reg, 'nc-ex-aprov--vazio', !n);
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; }), atual = -1;
    if (!reprovado) for (var i = 0; i < n; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var aprovados = passos.filter(function (x) { return x.estado === 'ok'; }).length;
    var cancelado = /cancel|suspens/i.test(txt('COD_SIT_REQ'));
    var bts = AP.botoes.filter(function (b) { return b.style.display !== 'none'; });
    var vez = bts.length > 0 && !cancelado && atual >= 0;   /* só há o que decidir com uma etapa pendente */
    var assin = JSON.stringify([passos, atual, bts.length, cancelado, AP_ABERTO]);
    if (assin === AP_ASSIN) return;
    AP_ASSIN = assin;
    if (!n) { AP.box.innerHTML = ''; return; }
    var quemNao = passos.filter(function (x) { return x.estado === 'nao'; })[0];
    var estado = reprovado ? 'nao' : cancelado ? 'neutro' : atual < 0 ? 'ok' : vez ? 'vez' : 'pend';
    var resumo = reprovado ? '<b>Reprovado</b> por ' + esc(quemNao.nome) : cancelado ? '<b>Pedido cancelado</b> · ' + aprovados + ' de ' + n + ' aprovaram'
      : atual < 0 ? '<b>Aprovado</b> por ' + (n === 1 ? esc(passos[0].nome) : 'todos') : vez ? '<b>' + aprovados + ' de ' + n + '</b> · <b>é a sua vez</b>'
      : '<b>' + aprovados + ' de ' + n + '</b> · aguardando <b>' + esc(passos[atual].nome) + '</b>';
    classe(AP.reg, 'nc-ex-ap-aberto', AP_ABERTO);
    AP.box.className = 'nc-ex-ap nc-ex-ap--' + estado;
    AP.box.innerHTML = '<p class="nc-ex-ap-rot">Aprovação</p><div class="nc-ex-ap-cab"><p class="nc-ex-ap-resumo">' + resumo + '</p>' +
        '<button type="button" class="nc-ex-ap-ver" aria-expanded="' + AP_ABERTO + '">' + (AP_ABERTO ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
      '<ol class="nc-ex-ap-passos">' + passos.map(function (x, k) {
        var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : k === atual && !cancelado ? 'is-vez' : 'is-fila';
        var dia = x.data.replace(/\s.*$/, '');
        var st = x.estado === 'ok' ? (dia || 'Aprovou') : x.estado === 'nao' ? 'Reprovou' + (dia ? ' · ' + dia : '') : cls === 'is-vez' ? (vez ? 'Sua vez' : 'Aguardando') : 'Na fila';
        var ic = x.estado === 'ok' ? '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>' : x.estado === 'nao' ? '<path d="M8 8l8 8M16 8l-8 8"/>' : cls === 'is-vez' ? '<path d="M12 8v4l2.5 1.5"/>' : '';
        return '<li class="nc-ex-ap-p ' + cls + '" title="' + esc(x.nome + (x.just ? ': "' + x.just + '"' : '')) + '"><span class="nc-ex-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
          '<span class="nc-ex-ap-texto"><span class="nc-ex-ap-nome">' + esc(x.nome) + '</span><span class="nc-ex-ap-estado">' + esc(st) + '</span></span></li>';
      }).join('') + '</ol>' +
      (vez ? '<div class="nc-ex-decisao"><p class="nc-ex-decisao-txt">Confira o exame e o horário e decida.</p><div class="nc-ex-decisao-botoes"></div></div>' : '') +
      (passos.some(function (x) { return x.just; }) ? '<div class="nc-ex-ap-justs">' + passos.filter(function (x) { return x.just; }).map(function (x) {
        return '<blockquote class="nc-ex-ap-just' + (x.estado === 'nao' ? ' is-nao' : '') + '"><b>' + esc(x.nome) + ':</b> ' + esc(x.just) + '</blockquote>'; }).join('') + '</div>' : '');
    var dest = AP.box.querySelector('.nc-ex-decisao-botoes');
    if (dest) bts.slice().sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) { b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-ex-reprovar' : 'nc-ex-aprovar'); dest.appendChild(b); });
  }

  /* ═══ [J10] O MAESTRO: QUANDO CADA PARTE É MONTADA ══════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez, quando a página abre: monta a abertura, o pedido gravado,
                os passos e a barra. atualizar() redesenha o que depende dos valores (cartões,
                consulta, barra, cabeçalho, aprovação) sempre que algo muda: um campo é alterado,
                uma região é atualizada, a janela da agenda fecha, uma ação dinâmica traz valores
                do servidor. Em leitura, o painel "Informações" que ficou vazio sai.
     CUIDADO    Não mude a ordem das chamadas em iniciar(): umas partes dependem das anteriores
                (a linha de ações precisa existir antes de a aprovação ir para baixo dela).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T;
  function agendar() { clearTimeout(T); T = setTimeout(atualizar, 60); }
  function temEditavel(reg) {
    return !!reg && [].some.call(reg.querySelectorAll('textarea, select, input:not([type=hidden])'), function (e) {
      return !e.readOnly && !e.disabled && !e.closest('.apex_disabled, [style*="none"], .nc-ex-fora');
    });
  }
  function atualizar() {
    var sel = document.getElementById(P + 'COD_TIPO_CONSULTA');
    LEITURA = PEDIDO && !(sel && sel.tagName === 'SELECT' && !sel.disabled);
    classe(document.body, 'nc-ex-leitura', LEITURA);
    /* 04/10: no pedido gravado, a região que ainda tem campo editável pela página (observação e
       horário sem agenda; data do desligamento no demissional) não sai da vista — só com o
       Salvar na página (situação 2/3/4 não tem Salvar). CSS [C1]. */
    var podeSalvar = PEDIDO && !!botaoPorTexto(/^salvar$/i)[0];
    Object.keys(PASSO_REG).forEach(function (k) { classe(PASSO_REG[k], 'nc-ex-edita', podeSalvar && temEditavel(PASSO_REG[k])); });
    /* em leitura, o painel "Informações" fica sem nada à vista (os blocos estão no cabeçalho e os
       botões na linha de ações): a moldura vazia sai */
    var painel = cont('TIPO_PACIENTE').closest('.a-Tabs-panel, .apex-rds-element');
    if (painel) {
      classe(painel, 'nc-ex-fora', false);
      classe(painel, 'nc-ex-fora', LEITURA && ![].some.call(painel.querySelectorAll('.t-Region:not(.nc-ex-reg), .t-Button'), function (e) { return aVista(e) && !e.classList.contains('nc-ex-fora') && !e.closest('.nc-ex-fora'); }) && ![].some.call(painel.querySelectorAll('.nc-ex-reg'), aVista));
    }
    desenharExame();
    desenharQuando();
    desenharBarra();
    desenharPedido();
    montarAprovacao();
  }
  function iniciar() {
    document.body.classList.add('nc-ex', PEDIDO ? 'nc-ex-modo-pedido' : 'nc-ex-modo-novo');
    montarAbertura();
    montarPedido();
    montarQuem();
    montarExame();
    montarQuando();
    montarBarra();
    atualizar();
    $(document).on('change', 'input, select, textarea', agendar);
    $(document).on('apexafterrefresh apexafterclosedialog', agendar);
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    setTimeout(atualizar, 700);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
