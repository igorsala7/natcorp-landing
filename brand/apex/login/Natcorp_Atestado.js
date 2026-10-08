/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE ATESTADOS E AFASTAMENTOS  —  o "arrumador" da tela (JavaScript)  ║
   ║  App 2937 · Página 91 (janela) · Medicina Ocupacional                                     ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   É a janela aberta pela lista de atestados: registra um atestado médico, uma licença
   (casamento, falecimento, doação de sangue, paternidade…) ou um afastamento pelo INSS.
   NÃO é o abono de marcações do ponto (esse é o Natcorp_Ponto, app 9503).
   Três públicos usam a mesma janela: o operador do RH/medicina (escolhe empresa e
   colaborador), o gestor (registra o da equipe) e o próprio colaborador pelo Painel do
   Colaborador (a página esconde empresa e colaborador). Depois, quem aprova abre o mesmo pedido.

     PEDIDO NOVO
       1. Uma abertura: o que é e o que ter em mãos (as datas e o atestado para fotografar).
       2. A região "Dados do Atestado" dividida em partes, na ordem de quem tem o papel na mão:
          Quem · Que afastamento é · Quando · Quem atendeu · O atestado · INSS e acidente
          (esta última recolhida: só abre sozinha se já tiver algo). Parte sem campo à vista some.
       3. QUANDO: botões "Hoje"/"Ontem" no primeiro dia, "Quantos dias" em botões (1, 2, 3, 5,
          7, 15), "Mesmo dia" no último dia; as horas só aparecem quando o tipo conta em horas;
          e uma frase que confere o período ("3 dias: de qua, 30/09 a sex, 02/10").
       4. O ATESTADO: um cartão "Tire uma foto ou escolha o arquivo", com a prévia da foto (ou
          o ícone do PDF) e o aviso de 10 MB antes do envio.
       5. O rodapé diz o que falta (tocar leva ao campo) e "Criar" aparece como "Enviar pedido".
     PEDIDO GRAVADO
       6. Cabeçalho: nº, situação em cor, período, quem pediu e quando — no lugar das regiões
          "Requisição" e "Log" (que continuam na página, escondidas).
       7. Em leitura, campos vazios saem; "Cancelar" vira "Cancelar este pedido" (e não se
          confunde com "Voltar"); "Salvar" vira "Salvar alterações".
       8. O CAMINHO DA APROVAÇÃO (o mesmo das páginas de requisição): a faixa logo abaixo do
          cabeçalho com "1 de 2 · aguardando Fulano", os aprovadores em linha e, para quem
          aprova, os botões Aprovar/Reprovar dentro dela ("é a sua vez").
     O título da janela troca "Criar/Editar: Requisição de Atestados e Afastamentos" por
     "Novo atestado ou afastamento" / "Atestado nº …".

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: isso continua sendo do APEX
       (itens, ações dinâmicas, validações e botões são todos da página).
     • Quando um atalho preenche um campo, usa apex.item().setValue com o "change": as ações
       dinâmicas da página rodam como se a pessoa tivesse digitado. Exemplos: a página é que
       preenche motivo e justificativa, o tipo "dias/horas" e o último dia a partir de
       "quantos dias".
     • Se este arquivo for retirado da página, a janela volta ao visual padrão do APEX e
       continua funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 91 › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_Atestado.js
       (no FIM da lista: depois de maskedinput, forms-functions e maskMoney)
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Atestado.css.
     A exportação da página já traz as duas URLs (script aplicar-atestado.py).

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Esta página NÃO usa classes postas no APEX. O arquivo reconhece a janela sozinho, pelos itens:
     …_COD_ATESTADO_MEDICO  e  …_DT_INICIO_AFASTAMENTO  (ou o …_DT_INICIO_AFASTAMENTO_DSP da
     consulta), e precisa do …_ROWID. Sem eles, o arquivo não faz nada.
   O começo dos nomes (P91_) é descoberto sozinho, pelo próprio item: se a página for copiada
   para outro número, o arquivo continua funcionando sem mudar nada.
   Os itens são lidos e movidos PELO NOME (sem o P91_): as listas estão em [J3], [J4] e [J8].
   Renomear um item no APEX tira ele do desenho até o nome ser trocado também aqui.
   Os campos, botões e ações dinâmicas continuam os do APEX: aqui eles só MUDAM DE LUGAR.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J2]  Datas e a frase do período .......... "3 dias: de qua, 30/09 a sex, 02/10"  PODE MEXER
     [J3]  Nomes dos campos ..................... rótulos que qualquer um entende        PODE MEXER
     [J4]  As partes do formulário .............. Quem · Que afastamento · Quando…       PODE MEXER
     [J5]  A abertura (pedido novo) ............. "Novo atestado ou afastamento"        PODE MEXER
     [J6]  Atalhos de data, dias e horas ........ Hoje, Ontem, 1 2 3 5 7 15, Mesmo dia   PODE MEXER
     [J7]  O atestado: foto ou arquivo .......... o cartão grande e o aviso de 10 MB     PODE MEXER
     [J8]  O rodapé ............................. "Falta: …" e "Enviar pedido"          PODE MEXER
     [J9]  O cabeçalho do pedido gravado ........ nº, situação em cor, quem pediu       PODE MEXER
     [J10] O caminho da aprovação ............... a faixa com os aprovadores
     [J11] O redesenho a cada mudança ........... o que é recalculado sempre           CUIDADO
     [J12] O título da janela ................... "Novo atestado…" / "Atestado nº …"   PODE MEXER
     [J13] O maestro ............................ decide QUANDO cada parte é montada  CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Quem atendeu'  →  'Atendimento'
     Quero mudar o rótulo de um campo (ex.: "Primeiro dia")         → [J3], lista NOMES
     Criei um campo novo na região "Dados do Atestado" e ele foi para o lugar errado
       → um campo que não está em nenhuma parte fica no fim da região. Para pô-lo numa parte,
         acrescente o nome dele (sem o P91_) na lista "itens" da parte, em [J4].
     Quero outros botões em "Quantos dias" (ex.: 10)                → [J6], a lista [['1', '1'], …]
     Mudou o limite de tamanho do arquivo na ação "FileSize"        → mude LIMITE, no começo do
                                                                     código (logo antes de [J1])
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
     P + 'COD_MOTIVO'       junta os textos: vira 'P91_COD_MOTIVO', o nome do item no APEX.
     val('X') / txt('X')    leem o que está num item do APEX (veja [J1]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: estas linhas impedem que o arquivo rode duas vezes (URL repetida na página, por
     exemplo), que rode fora do APEX e que rode em outra página. Elas procuram os itens do
     "combinado" e descobrem sozinhas o começo dos nomes (P91_). Não apague. */
  if (window.__ncAtestado || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_COD_ATESTADO_MEDICO_CONTAINER"]');
  if (!achado) return;
  var P = achado.id.replace(/COD_ATESTADO_MEDICO_CONTAINER$/, '');
  if (!document.getElementById(P + 'DT_INICIO_AFASTAMENTO_CONTAINER') && !document.getElementById(P + 'DT_INICIO_AFASTAMENTO_DSP_CONTAINER')) return;
  if (!document.getElementById(P + 'ROWID')) return;
  window.__ncAtestado = true;

  var $ = apex.jQuery;
  var NOVO = !(document.getElementById(P + 'ROWID').value || '').trim();
  /* PODE MEXER: o limite de tamanho do arquivo do atestado, em bytes (10000000 = 10 MB).
     Tem que ser o MESMO da ação dinâmica "FileSize" da página: mude os dois juntos. */
  var LIMITE = 10000000;      /* o mesmo da ação "FileSize" da página */

  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    pessoa: '<circle cx="12" cy="8" r="3.6"/><path d="M4.5 20c.9-3.9 3.9-6 7.5-6s6.6 2.1 7.5 6"/>',
    tipo: '<rect x="4" y="3.5" width="16" height="17" rx="2.5"/><path d="M8 8.5h8M8 12h8M8 15.5h5"/>',
    cal: '<rect x="3.5" y="5" width="17" height="15.5" rx="2.5"/><path d="M3.5 10h17M8 3v4M16 3v4"/>',
    medico: '<path d="M6 3.5v5a4 4 0 0 0 8 0v-5"/><path d="M10 12.5v2.5a4.5 4.5 0 0 0 9 0v-2"/><circle cx="19" cy="11" r="2"/>',
    doc: '<path d="M6.5 3h7.5l4.5 4.5V19a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2z"/><path d="M13.5 3v5h5"/><path d="M8.5 13.5h7M8.5 17h5"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    seta: '<path d="M8.5 10l3.5 3.5 3.5-3.5"/>',
    camera: '<path d="M4 8.5A2 2 0 0 1 6 6.5h2l1.5-2h5l1.5 2h2a2 2 0 0 1 2 2V17a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2z"/><circle cx="12" cy="12.5" r="3.5"/>',
    pdf: '<path d="M6.5 3h7.5l4.5 4.5V19a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2z"/><path d="M13.5 3v5h5"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    alerta: '<path d="M12 4l9 16H3z"/><path d="M12 10v4.5M12 17.2v.1"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    x: '<path d="M7 7l10 10M17 7L7 17"/>',
    aguarda: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
  };

  /* ═══ [J1] FERRAMENTAS ══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo: ler um item do APEX, achar um botão
                pelo texto, trocar um rótulo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('ITEM')        o que o APEX GUARDA no item (o código da opção, ex.: '1')
       txt('ITEM')        o que a PESSOA VÊ no item (o texto da opção escolhida numa lista)
       cont('ITEM')       o bloco inteiro do campo na tela (rótulo + campo)
       item('ITEM')       o próprio campo (a caixa onde se digita)
       renomear('ITEM', 'Texto')   troca o rótulo do campo na tela
       oculto(x, true)    esconde um pedaço da tela (põe a classe nc-at-oculto)
       Em todas, 'ITEM' é o nome SEM o P91_ (o arquivo junta o começo sozinho).
     QUANDO MEXER  Quase nunca.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d) { return '<svg class="nc-at-ic" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function cont(n) { return document.getElementById(P + n + '_CONTAINER'); }
  function item(n) { return document.getElementById(P + n); }
  function val(n) {
    if (!item(n) && !document.getElementById(P + n + '_HIDDENVALUE')) return '';
    try { var v = apex.item(P + n).getValue(); return v == null ? '' : String(v).trim(); } catch (x) { return ''; }
  }
  function limpo(t) { t = String(t || '').replace(/\s+/g, ' ').trim(); return /^[-–—]?$/.test(t) ? '' : t; }
  /* o que a pessoa VÊ no campo (texto da lista, não o código) */
  function txt(n) {
    var c = cont(n); if (!c) return '';
    var d = c.querySelector('.display_only');
    if (d) return limpo(d.textContent);
    var s = c.querySelector('select');
    if (s) return s.selectedIndex >= 0 && s.value ? limpo(s.options[s.selectedIndex].text) : '';
    var i = c.querySelector('input:not([type=hidden]):not([type=file]), textarea');
    return i ? limpo(i.value) : '';
  }
  function semCodigo(t) { return String(t || '').replace(/\s*\[C[óo]digo [^\]]*\]\s*$/i, '').trim(); }
  function oculto(e, on) { classe(e, 'nc-at-oculto', on); }
  function renomear(n, t) {
    var l = document.getElementById(P + n + '_LABEL');
    if (!l || l.getAttribute('data-nc-at') === t) return;
    for (var i = 0; i < l.childNodes.length; i++) {
      var x = l.childNodes[i];
      if (x.nodeType === 3 && x.textContent.trim()) { x.textContent = t + ' '; l.setAttribute('data-nc-at', t); return; }
    }
  }
  /* visível até a parte (as partes escondidas não contam) */
  function aVista(e, ate) {
    for (var x = e; x && x !== ate; x = x.parentElement) {
      if (x.hidden || x.classList.contains('nc-at-oculto')) return false;
      if (x.style && x.style.display === 'none') return false;
      if (x !== e && x.classList.contains('row')) continue;
      if (getComputedStyle(x).display === 'none') return false;
    }
    return true;
  }
  function botaoPorTexto(re) {
    return [].slice.call(document.querySelectorAll('button.t-Button, a.t-Button')).filter(function (b) { return re.test(b.textContent.replace(/\s+/g, ' ').trim()); })[0];
  }
  function rotuloBotao(b, t) {
    if (!b) return;
    var l = b.querySelector('.t-Button-label');
    if (l) { if (l.textContent !== t) l.textContent = t; } else if (b.textContent !== t) b.textContent = t;
  }

  /* ═══ [J2] DATAS E A FRASE DO PERÍODO ═══════════════════════════════════════════════════
     O QUE FAZ  Lê as datas e horas do afastamento e escreve a frase que confere o período,
                embaixo da parte "Quando" e no cabeçalho do pedido gravado:
                  "3 dias: de qua, 30/09 a sex, 02/10"
                  "3 horas e 45 min: qua, 30/09, das 08:30 às 12:15"
                Fica vermelha se o último dia estiver antes do primeiro, ou a hora de fim antes
                da de início.
     LÊ DOS ITENS  DT_INICIO_AFASTAMENTO, DT_TERMINO_AFASTAMENTO, HORA_INICIO_AFASTAMENTO,
                HORA_TERMINO_AFASTAMENTO (ou os _DSP, na consulta) e TIPO_ATESTADO ("DIAS"/"HORAS",
                posto pela ação dinâmica "Dia ou Hora" da página).
     PODE MEXER os dias da semana abreviados (lista DIAS) e as frases entre aspas de frasePeriodo.
     IMPORTANTE A frase só CONFERE o que foi digitado. Quem calcula os dias é a página.
     VISUAL     Natcorp_Atestado.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: como os dias da semana aparecem na frase do período */
  var DIAS = ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sáb'];
  function lerData(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function fmt(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear(); }
  function curta(d) { return DIAS[d.getDay()] + ', ' + ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + (d.getFullYear() !== new Date().getFullYear() ? '/' + d.getFullYear() : ''); }
  function hoje(delta) { var h = new Date(); return new Date(h.getFullYear(), h.getMonth(), h.getDate() + (delta || 0)); }
  function lerHora(t) { var m = /^(\d{1,2}):(\d{2})$/.exec(String(t || '').trim()); return m && +m[1] < 24 && +m[2] < 60 ? +m[1] * 60 + +m[2] : null; }
  function plural(n, um, varios) { return n + ' ' + (n === 1 ? um : varios); }
  /* o valor vale do item editável; na consulta, do _DSP que a página mostra no lugar */
  function periodo() {
    function um(n) { var v = val(n); if (!v || !aVista(cont(n) || document.body, document.body)) { var d = txt(n + '_DSP'); if (d) v = d; } return v || val(n); }
    return {
      ini: lerData(um('DT_INICIO_AFASTAMENTO')), fim: lerData(um('DT_TERMINO_AFASTAMENTO')),
      hi: um('HORA_INICIO_AFASTAMENTO'), hf: um('HORA_TERMINO_AFASTAMENTO'),
      tipo: (val('TIPO_ATESTADO') || txt('TIPO_ATESTADO')).toUpperCase()
    };
  }
  function frasePeriodo(p) {
    if (!p.ini) return null;
    var mi = lerHora(p.hi), mf = lerHora(p.hf), horas = p.tipo === 'HORAS' || (mi !== null && mf !== null && (mi || mf) && p.tipo !== 'DIAS');
    if (p.fim && p.fim < p.ini) return { ruim: true, t: 'O último dia (' + curta(p.fim) + ') está antes do primeiro (' + curta(p.ini) + '). Confira as datas.' };
    if (horas && mi !== null && mf !== null && (mi || mf)) {
      var mesmo = !p.fim || +p.fim === +p.ini;
      var min = mesmo ? mf - mi : null;
      if (mesmo && min <= 0) return { ruim: true, t: 'A hora de fim (' + p.hf + ') não está depois da hora de início (' + p.hi + ').' };
      var dur = min === null ? '' : (Math.floor(min / 60) ? plural(Math.floor(min / 60), 'hora', 'horas') : '') + (min % 60 ? (Math.floor(min / 60) ? ' e ' : '') + min % 60 + ' min' : '');
      return { t: (dur ? '<b>' + dur + '</b>: ' : '') + curta(p.ini) + ', das ' + esc(p.hi) + (mesmo ? '' : ' de ' + curta(p.ini)) + ' às ' + esc(p.hf) + (mesmo ? '' : ' de ' + curta(p.fim)) };
    }
    if (!p.fim) return { t: 'Começa ' + (+p.ini === +hoje() ? 'hoje, ' : +p.ini === +hoje(-1) ? 'ontem, ' : '') + curta(p.ini) + '. Falta o último dia.' , falta: true };
    var n = Math.round((p.fim - p.ini) / 864e5) + 1;
    return { t: '<b>' + plural(n, 'dia', 'dias') + '</b>: ' + (n === 1 ? curta(p.ini) : 'de ' + curta(p.ini) + ' a ' + curta(p.fim)) };
  }

  /* ═══ [J3] NOMES DOS CAMPOS ═════════════════════════════════════════════════════════════
     O QUE FAZ  Troca, só na tela, os rótulos técnicos do APEX por nomes que qualquer pessoa
                entende ("Dt Inicio Afastamento" vira "Primeiro dia").
     PODE MEXER • a lista NOMES: à esquerda o item (sem o P91_), à direita o rótulo que aparece.
                  Para renomear outro campo, copie uma linha e troque os dois lados.
                • a lista CURTO: o nome curto usado no "Falta:" do rodapé ([J8]).
     IMPORTANTE O rótulo no APEX não muda. Se preferir, mude no Page Designer e apague a linha
                daqui: o que está aqui vence o que está no APEX.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: item (sem o P91_) : rótulo que aparece na tela */
  var NOMES = {
    COD_EMPRESA: 'Empresa', MATRICULA: 'Colaborador',
    DT_ATESTADO_MEDICO: 'Data do atestado', COD_ATESTADO_MEDICO: 'Tipo de afastamento', TIPO_ATESTADO: 'Conta em',
    COD_MOTIVO: 'Motivo', COD_JUSTIFICATIVA: 'Justificativa no ponto',
    DT_INICIO_AFASTAMENTO: 'Primeiro dia', HORA_INICIO_AFASTAMENTO: 'Das (hora)',
    QTDE_DIAS_AFASTAMENTO: 'Quantos dias', DT_TERMINO_AFASTAMENTO: 'Último dia', HORA_TERMINO_AFASTAMENTO: 'Até (hora)',
    DT_INICIO_AFASTAMENTO_DSP: 'Primeiro dia', HORA_INICIO_AFASTAMENTO_DSP: 'Das (hora)',
    QTDE_DIAS_AFASTAMENTO_DSP: 'Quantos dias', DT_TERMINO_AFASTAMENTO_DSP: 'Último dia', HORA_TERMINO_AFASTAMENTO_DSP: 'Até (hora)',
    COD_ENTIDADE_DSP: 'Hospital, clínica ou posto', ENTIDADE_LOV: 'Hospital, clínica ou posto',
    COD_PREST_SERV: 'Médico', COD_DOENCA: 'CID (código da doença)',
    ARQ_1_ANEXO: 'Foto ou arquivo do atestado', OBSERVACAO: 'Observação',
    TIPO_ACIDENTE_ES: 'Tipo de acidente', DT_ALT_PROG: 'Alta programada', DT_PERICIA: 'Data da perícia no INSS'
  };
  /* PODE MEXER: o nome curto de cada campo no "Falta:" do rodapé */
  var CURTO = {   /* no "falta" do rodapé */
    COD_EMPRESA: 'Empresa', MATRICULA: 'Colaborador', COD_ATESTADO_MEDICO: 'Tipo de afastamento', COD_MOTIVO: 'Motivo',
    DT_INICIO_AFASTAMENTO: 'Primeiro dia', DT_TERMINO_AFASTAMENTO: 'Último dia',
    HORA_INICIO_AFASTAMENTO: 'Hora de início', HORA_TERMINO_AFASTAMENTO: 'Hora de fim'
  };

  /* ═══ [J4] AS PARTES DO FORMULÁRIO ══════════════════════════════════════════════════════
     O QUE FAZ  Divide a região "Dados do Atestado" em partes com ícone, título e explicação:
                  Quem se afastou · Que afastamento é · Quando · Quem atendeu · O atestado ·
                  INSS e acidente (esta recolhida: abre num clique, ou sozinha se já tiver algo).
     COMO       Cada parte tem uma lista "itens": as LINHAS do APEX que contêm esses campos são
                levadas para dentro dela, na ordem da lista. Os campos continuam os mesmos.
                Um item também pode ser um botão, achado pelo texto: /cadastrar m[ée]dico/i
                acha o botão "Cadastrar médico". Parte sem nenhum campo à vista some sozinha
                (ex.: "Quem" no Painel do Colaborador, onde a página esconde empresa e colaborador).
     PODE MEXER na lista PARTES abaixo:
                  t     → o título da parte          sub → a frase de explicação embaixo
                  itens → os campos da parte (o nome do item SEM o P91_), na ordem desejada
     CUIDADO    Não mude o "k" ('quem', 'qual', 'quando'…): o visual e outras partes usam esse
                nome. Um campo novo na região que não esteja em nenhuma lista fica no fim dela.
     VISUAL     Natcorp_Atestado.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: títulos, explicações e campos de cada parte */
  var PARTES = [
    { k: 'quem', ic: IC.pessoa, t: 'Quem se afastou', itens: ['COD_EMPRESA', 'MATRICULA'] },
    { k: 'qual', ic: IC.tipo, t: 'Que afastamento é', sub: 'Escolha o tipo. O motivo e a justificativa costumam vir sozinhos depois.',
      itens: ['COD_ATESTADO_MEDICO', 'TIPO_ATESTADO', 'DT_ATESTADO_MEDICO', 'COD_MOTIVO', 'COD_JUSTIFICATIVA'] },
    { k: 'quando', ic: IC.cal, t: 'Quando', itens: ['DT_INICIO_AFASTAMENTO', 'HORA_INICIO_AFASTAMENTO', 'QTDE_DIAS_AFASTAMENTO', 'DT_TERMINO_AFASTAMENTO', 'HORA_TERMINO_AFASTAMENTO',
      'DT_INICIO_AFASTAMENTO_DSP', 'HORA_INICIO_AFASTAMENTO_DSP', 'QTDE_DIAS_AFASTAMENTO_DSP', 'DT_TERMINO_AFASTAMENTO_DSP', 'HORA_TERMINO_AFASTAMENTO_DSP'] },
    { k: 'atend', ic: IC.medico, t: 'Quem atendeu', sub: 'Está escrito no atestado. Se não souber, pode deixar em branco.',
      itens: ['COD_ENTIDADE_DSP', 'ENTIDADE_LOV', /cadastrar entidade/i, 'COD_PREST_SERV', /cadastrar m[ée]dico/i, 'COD_DOENCA'] },
    { k: 'doc', ic: IC.doc, t: 'O atestado', itens: ['ARQ_1_ANEXO', 'ARQ_IMG', 'OBSERVACAO'] },
    { k: 'mais', ic: IC.mais, t: 'INSS e acidente', sub: 'Só para afastamento pelo INSS ou por acidente.', recolhe: true,
      itens: ['TIPO_ACIDENTE_ES', 'DT_ALT_PROG', 'DT_PERICIA'] }
  ];
  var DADOS, CAIXA, SECS = {}, RESUMO, INTRO, CARTAO, FALTA, HERO;

  function montarPartes() {
    DADOS = achado.closest('.t-Region');
    CAIXA = DADOS && DADOS.querySelector('.t-Region-body > .container');
    if (!CAIXA) return false;
    DADOS.classList.add('nc-at-dados');
    /* as partes entram antes de um marcador fixo: as linhas vão saindo do lugar enquanto se monta */
    var primeira = el('div', 'nc-at-marca');
    CAIXA.insertBefore(primeira, CAIXA.firstChild);
    PARTES.forEach(function (pt) {
      var s = el('section', 'nc-at-parte nc-at-parte--' + pt.k);
      s.setAttribute('data-parte', pt.k);
      var cab = pt.recolhe
        ? '<button type="button" class="nc-at-parte-cab nc-at-parte-cab--botao" aria-expanded="false">'
        : '<div class="nc-at-parte-cab">';
      cab += '<span class="nc-at-parte-ic">' + svg(pt.ic) + '</span><span class="nc-at-parte-txt"><span class="nc-at-parte-tit">' + esc(pt.t) + '</span>' +
        '<span class="nc-at-parte-sub" data-sub>' + esc(pt.sub || '') + '</span></span>' +
        (pt.recolhe ? '<span class="nc-at-parte-seta">' + svg(IC.seta) + '</span></button>' : '</div>');
      s.innerHTML = cab + '<div class="nc-at-parte-corpo"></div>';
      CAIXA.insertBefore(s, primeira);
      var corpo = s.querySelector('.nc-at-parte-corpo');
      pt.itens.forEach(function (n) {
        var alvo = typeof n === 'string' ? cont(n) : botaoPorTexto(n);
        var row = alvo && alvo.closest('.row');
        if (row && row.parentNode !== corpo && CAIXA.contains(row)) corpo.appendChild(row);
      });
      if (pt.recolhe) {
        corpo.hidden = true;
        s.querySelector('.nc-at-parte-cab').addEventListener('click', function () { abrirMais(corpo.hidden); });
      }
      SECS[pt.k] = s;
    });
    return true;
  }
  function abrirMais(on) {
    var s = SECS.mais; if (!s) return;
    s.querySelector('.nc-at-parte-corpo').hidden = !on;
    s.querySelector('.nc-at-parte-cab').setAttribute('aria-expanded', on ? 'true' : 'false');
    s.__aberta = true;
  }

  function nomes() {
    Object.keys(NOMES).forEach(function (n) { renomear(n, NOMES[n]); });
    rotuloBotao(botaoPorTexto(/cadastrar entidade/i), '+ Cadastrar hospital ou clínica');
    rotuloBotao(botaoPorTexto(/cadastrar m[ée]dico/i), '+ Cadastrar médico');
    var obs = item('OBSERVACAO');
    if (obs && !obs.getAttribute('placeholder')) obs.setAttribute('placeholder', 'Algo que o RH precise saber (opcional)');
    ['HORA_INICIO_AFASTAMENTO', 'HORA_TERMINO_AFASTAMENTO'].forEach(function (n) {
      var i = item(n); if (!i) return;
      i.setAttribute('inputmode', 'numeric');
      i.setAttribute('autocomplete', 'off');
    });
    var q = item('QTDE_DIAS_AFASTAMENTO'); if (q) q.setAttribute('inputmode', 'numeric');
    oculto(cont('TIPO_ATESTADO'), true);     /* vira a indicação "conta em dias/horas" */
    var lb = DADOS && DADOS.querySelector('.t-Region-title');
    if (lb && !NOVO) lb.textContent = 'Dados do atestado';
  }

  /* ═══ [J5] A ABERTURA (PEDIDO NOVO) ═════════════════════════════════════════════════════
     O QUE FAZ  No alto do pedido novo: "Novo atestado ou afastamento" e o que ter em mãos.
                Quando a parte "Quem" está escondida (é o próprio colaborador), o texto fala com
                ele: "Mande o seu atestado para o RH." — esse segundo texto está em [J11].
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_Atestado.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function abertura() {
    INTRO = el('div', 'nc-at-intro');
    INTRO.innerHTML = '<span class="nc-at-intro-ic">' + svg(IC.doc) + '</span><div><h2 class="nc-at-intro-tit">Novo atestado ou afastamento</h2>' +
      '<p data-intro>Tenha o atestado em mãos: você vai usar <b>as datas</b> e tirar <b>uma foto</b> dele. O que tem <span class="nc-at-req">*</span> é obrigatório.</p></div>';
    CAIXA.insertBefore(INTRO, CAIXA.firstChild);
  }

  /* ═══ [J6] ATALHOS DE DATA, "QUANTOS DIAS" E HORAS ══════════════════════════════════════
     O QUE FAZ  Põe botões ao lado dos campos da parte "Quando":
                  Primeiro dia ... "Hoje" e "Ontem"
                  Quantos dias ... 1, 2, 3, 5, 7, 15 (somem quando o tipo conta em horas)
                  Último dia ..... "Mesmo dia"
                Nas horas, "0830" vira "08:30" enquanto a pessoa digita.
     COMO       O botão preenche o campo com apex.item().setValue: as ações dinâmicas da página
                rodam como se a pessoa tivesse digitado. Quem calcula o último dia a partir de
                "Quantos dias" é a ação "Set DT_TERMINO_AGASTAMENTO"; quem calcula os dias a partir
                do último dia é a ação "New_1".
     PODE MEXER • os botões: cada par é ['valor', 'texto do botão']. Para acrescentar 10 dias em
                  "Quantos dias", acrescente ['10', '10'] na lista.
                • as mensagens de avisar(…) ('Primeiro diga o primeiro dia.').
     VISUAL     Natcorp_Atestado.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function atalhos(n, botoes, cls) {
    var c = cont(n), ic = c && c.querySelector('.t-Form-inputContainer'); if (!ic) return null;
    var box = el('div', 'nc-at-atalhos' + (cls ? ' ' + cls : ''));
    box.setAttribute('data-de', n);
    box.setAttribute('role', 'group');
    box.innerHTML = botoes.map(function (b) { return '<button type="button" class="nc-at-atalho" data-v="' + esc(b[0]) + '">' + esc(b[1]) + '</button>'; }).join('');
    ic.appendChild(box);
    return box;
  }
  function montarQuando() {
    var bi = atalhos('DT_INICIO_AFASTAMENTO', [['hoje', 'Hoje'], ['ontem', 'Ontem']]);
    if (bi) bi.addEventListener('click', function (e) {
      var b = e.target.closest('[data-v]'); if (!b || item('DT_INICIO_AFASTAMENTO').disabled || item('DT_INICIO_AFASTAMENTO').type === 'hidden') return;
      apex.item(P + 'DT_INICIO_AFASTAMENTO').setValue(fmt(hoje(b.getAttribute('data-v') === 'ontem' ? -1 : 0)));
      agendar();
    });
    var bq = atalhos('QTDE_DIAS_AFASTAMENTO', [['1', '1'], ['2', '2'], ['3', '3'], ['5', '5'], ['7', '7'], ['15', '15']], 'nc-at-atalhos--dias');
    if (bq) bq.addEventListener('click', function (e) {
      var b = e.target.closest('[data-v]'); if (!b || item('QTDE_DIAS_AFASTAMENTO').disabled || item('QTDE_DIAS_AFASTAMENTO').type === 'hidden') return;
      if (!val('DT_INICIO_AFASTAMENTO')) { avisar('Primeiro diga o primeiro dia.'); focar('DT_INICIO_AFASTAMENTO'); return; }
      apex.item(P + 'QTDE_DIAS_AFASTAMENTO').setValue(b.getAttribute('data-v'));   /* a página calcula o último dia */
      agendar();
    });
    var bf = atalhos('DT_TERMINO_AFASTAMENTO', [['igual', 'Mesmo dia']]);
    if (bf) bf.addEventListener('click', function (e) {
      var b = e.target.closest('[data-v]'); if (!b || item('DT_TERMINO_AFASTAMENTO').disabled || item('DT_TERMINO_AFASTAMENTO').type === 'hidden') return;
      var ini = val('DT_INICIO_AFASTAMENTO');
      if (!ini) { avisar('Primeiro diga o primeiro dia.'); focar('DT_INICIO_AFASTAMENTO'); return; }
      apex.item(P + 'DT_TERMINO_AFASTAMENTO').setValue(ini);                           /* a página calcula os dias */
      agendar();
    });
    /* hora: "0830" vira "08:30" enquanto digita (a ação da página ainda arruma no change) */
    ['HORA_INICIO_AFASTAMENTO', 'HORA_TERMINO_AFASTAMENTO'].forEach(function (n) {
      var i = item(n); if (!i) return;
      i.addEventListener('input', function () {
        var d = i.value.replace(/\D/g, '').slice(0, 4);
        var v = d.length > 2 ? d.slice(0, 2) + ':' + d.slice(2) : d;
        if (v !== i.value) i.value = v;
        agendar();
      });
    });
    var sec = SECS.quando && SECS.quando.querySelector('.nc-at-parte-corpo');
    if (sec) {
      RESUMO = el('p', 'nc-at-resumo');
      RESUMO.setAttribute('aria-live', 'polite');
      RESUMO.hidden = true;
      sec.appendChild(RESUMO);
    }
  }
  var AVISO_T;
  function avisar(t) {
    if (!RESUMO) return;
    RESUMO.__aviso = t;
    clearTimeout(AVISO_T);
    AVISO_T = setTimeout(function () { RESUMO.__aviso = ''; agendar(); }, 3500);
    agendar();
  }
  function focar(n) {
    var c = cont(n); if (!c) return;
    var s = c.closest('.nc-at-parte');
    if (s && s.getAttribute('data-parte') === 'mais') abrirMais(true);
    c.scrollIntoView({ behavior: 'smooth', block: 'center' });
    var i = c.querySelector('input:not([type=hidden]):not([disabled]), select, textarea, button.a-Button--popupLOV');
    if (i) setTimeout(function () {
      try { i.focus({ preventScroll: true }); } catch (x) { i.focus(); }
      if (i.classList.contains('apex-item-popup-lov') || i.classList.contains('a-Button--popupLOV')) { var b = c.querySelector('.a-Button--popupLOV'); if (b) b.click(); }
    }, 380);
  }

  /* ═══ [J7] O ATESTADO: FOTO OU ARQUIVO ══════════════════════════════════════════════════
     O QUE FAZ  Troca o campo de arquivo (ARQ_1_ANEXO) por um cartão grande "Tire uma foto do
                atestado ou escolha o arquivo". Depois de escolher, mostra a prévia da foto (ou o
                ícone do PDF), o nome e o tamanho; acima do LIMITE fica vermelho e diz o que fazer.
     COMO       O campo de arquivo do APEX continua na página, escondido, e é ELE que vai no envio:
                o cartão só abre o seletor de arquivos dele.
     IMPORTANTE Quem bloqueia o envio de arquivo grande é a ação "FileSize" da página (alerta e
                esconde o Criar). Aqui só se avisa antes.
     PODE MEXER os textos do cartão (eles aparecem duas vezes: em montarArquivo e em
                desenharArquivo — mude nos dois lugares).
     VISUAL     Natcorp_Atestado.css › [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarArquivo() {
    var c = cont('ARQ_1_ANEXO'), f = item('ARQ_1_ANEXO');
    if (!c || !f || f.type !== 'file') return;
    c.classList.add('nc-at-arq');
    CARTAO = el('div', 'nc-at-cartao');
    CARTAO.innerHTML = '<span class="nc-at-cartao-ic" data-ic>' + svg(IC.camera) + '</span>' +
      '<span class="nc-at-cartao-txt"><b data-tit>Tire uma foto do atestado ou escolha o arquivo</b>' +
      '<span data-sub>Foto ou PDF, até 10 MB. A foto precisa mostrar o atestado inteiro e dar para ler.</span></span>' +
      '<span class="nc-at-cartao-acao" data-acao>Escolher</span>';
    var grupo = c.querySelector('.apex-item-group--file') || f.parentNode;
    grupo.parentNode.insertBefore(CARTAO, grupo);
    CARTAO.addEventListener('click', function () { if (!f.disabled) f.click(); });
    CARTAO.setAttribute('role', 'button');
    CARTAO.tabIndex = 0;
    CARTAO.addEventListener('keydown', function (e) { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); f.click(); } });
    f.addEventListener('change', desenharArquivo);
  }
  var URL_PREVIA;
  function desenharArquivo() {
    var f = item('ARQ_1_ANEXO'); if (!CARTAO || !f) return;
    var a = f.files && f.files[0];
    var tit = CARTAO.querySelector('[data-tit]'), sub = CARTAO.querySelector('[data-sub]'), ic = CARTAO.querySelector('[data-ic]'), ac = CARTAO.querySelector('[data-acao]');
    if (URL_PREVIA) { URL.revokeObjectURL(URL_PREVIA); URL_PREVIA = null; }
    classe(CARTAO, 'is-cheio', !!a);
    classe(CARTAO, 'is-grande', !!a && a.size > LIMITE);
    if (!a) {
      html(ic, svg(IC.camera));
      tit.textContent = 'Tire uma foto do atestado ou escolha o arquivo';
      sub.textContent = 'Foto ou PDF, até 10 MB. A foto precisa mostrar o atestado inteiro e dar para ler.';
      ac.textContent = 'Escolher';
      return;
    }
    var mb = (a.size / 1048576).toFixed(a.size < 1048576 ? 2 : 1).replace('.', ',') + ' MB';
    if (/^image\//.test(a.type) && window.URL) {
      URL_PREVIA = URL.createObjectURL(a);
      html(ic, '<img alt="" src="' + URL_PREVIA + '">');
    } else html(ic, svg(IC.pdf));
    tit.textContent = a.name;
    sub.textContent = a.size > LIMITE ? 'Tem ' + mb + ': passa de 10 MB e não vai. Tire outra foto com menos qualidade ou escolha outro arquivo.' : mb + ' · pronto para enviar junto';
    ac.textContent = 'Trocar';
  }

  /* ═══ [J8] O RODAPÉ: O QUE FALTA + "ENVIAR PEDIDO" ══════════════════════════════════════
     O QUE FAZ  • Renomeia os botões: Criar → "Enviar pedido", Salvar → "Salvar alterações",
                  Cancelar → "Cancelar este pedido".
                • Mostra ao lado dos botões "Falta: Empresa · Tipo de afastamento · …" (tocar leva
                  ao campo e, se for uma lista em janela, abre a lista). No celular, os dois primeiros e "+N".
                  Tudo preenchido: "Tudo preenchido. Pode enviar."
     COMO SABE O QUE FALTA  Pela lista fixa em faltando() (logo abaixo): empresa, colaborador,
                tipo, motivo, primeiro e último dia, e as horas só quando o tipo conta em horas.
                Campo escondido pela página não conta.
     PODE MEXER • os nomes dos botões, entre aspas, em rotuloBotao(…, 'Enviar pedido').
                • a lista de faltando(): acrescente ou tire um item (sem o P91_). O nome que aparece
                  no rodapé vem da lista CURTO, em [J3].
     IMPORTANTE Isso só AVISA. Quem impede o envio sem um campo é a validação do APEX.
     VISUAL     Natcorp_Atestado.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var CRIAR, SALVAR;
  function montarRodape() {
    CRIAR = document.getElementById('CREATE') || botaoPorTexto(/^criar$/i);
    SALVAR = document.getElementById('SAVE') || botaoPorTexto(/^salvar$/i);
    rotuloBotao(CRIAR, 'Enviar pedido');
    rotuloBotao(SALVAR, 'Salvar alterações');
    rotuloBotao(botaoPorTexto(/^cancelar$/i), 'Cancelar este pedido');
    if (!CRIAR) return;
    var col = CRIAR.closest('.t-ButtonRegion');
    col = col && col.querySelector('.t-ButtonRegion-col--content');
    if (!col) return;
    FALTA = el('div', 'nc-at-falta');
    FALTA.setAttribute('aria-live', 'polite');
    col.appendChild(FALTA);
    FALTA.addEventListener('click', function (e) { var b = e.target.closest('[data-ir]'); if (b) focar(b.getAttribute('data-ir')); });
  }
  function faltando() {
    var f = [];
    ['COD_EMPRESA', 'MATRICULA', 'COD_ATESTADO_MEDICO', 'COD_MOTIVO', 'DT_INICIO_AFASTAMENTO', 'DT_TERMINO_AFASTAMENTO', 'HORA_INICIO_AFASTAMENTO', 'HORA_TERMINO_AFASTAMENTO'].forEach(function (n) {
      var c = cont(n), i = item(n); if (!c || !i) return;
      if (/^HORA_/.test(n) && (periodo().tipo !== 'HORAS' || i.disabled)) return;
      if (!aVista(c, document.body)) return;
      var v = val(n);
      if (!v || (/^HORA_/.test(n) && !lerHora(v))) f.push(n);
    });
    return f;
  }

  /* ═══ [J9] O CABEÇALHO DO PEDIDO GRAVADO ════════════════════════════════════════════════
     O QUE FAZ  No pedido já gravado, monta no alto: "Atestado nº 57462", a situação em cor, o
                tipo e a pessoa, a frase do período ([J2]), "Pedido em … por …", "Situação desde"
                e "Última alteração" (só quando diferem da data do pedido).
                As regiões "Requisição" e "Log" ficam escondidas (continuam na página).
                O desenho do cabeçalho está em desenharCabecalho(), no fim de [J10].
     LÊ DOS ITENS  COD_REQ, COD_SIT_REQ, MATRICULA, MAT_SOLICITANTE, COD_ATESTADO_MEDICO, DT_REQ,
                DT_SIT_REQ, DT_ATUALIZACAO, USUARIO.
     PODE MEXER a lista SIT abaixo: para cada código de situação, ['cor', 'Texto', ícone].
                  cor: 'espera' (amarelo) · 'bom' (verde) · 'ruim' (vermelho) · 'neutro' (cinza)
                Situação 1 com TODOS os aprovadores de acordo aparece como "Em aberto".
     VISUAL     Natcorp_Atestado.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: código da situação → ['cor', 'Texto do selo', ícone] */
  var SIT = {
    '1': ['espera', 'Esperando aprovação', IC.aguarda], '2': ['bom', 'Concluída', IC.ok], '3': ['neutro', 'Cancelada', IC.x],
    '4': ['ruim', 'Reprovada', IC.x], '5': ['bom', 'Aprovada', IC.ok], '6': ['neutro', 'Suspensa', IC.relogio]
  };
  function montarCabecalho() {
    var req = cont('COD_REQ'), topo = req && req.closest('.t-Region');
    var pai = DADOS.parentElement && DADOS.parentElement.closest('.t-Region, .t-ContentBlock');
    var alvo = pai && pai.querySelector('.t-Region-body, .t-ContentBlock-body');
    HERO = el('div', 'nc-at-hero');
    (alvo || DADOS.parentNode).insertBefore(HERO, (alvo ? alvo.firstChild : DADOS));
    if (topo) topo.classList.add('nc-at-oculto');
    var log = cont('DT_ATUALIZACAO'); log = log && log.closest('.t-Region');
    if (log && log !== DADOS) log.classList.add('nc-at-oculto');
    montarAprovacao();
  }

  /* ═══ [J10] O CAMINHO DA APROVAÇÃO ══════════════════════════════════════════════════════
     (O mesmo desenho da Requisição, do Desligamento e do Treinamento.)
     LÊ DE      a região "Aprovadores" (uma timeline do APEX): o nome, a situação, a data e a
                justificativa de cada aprovador. Se a região virar um relatório comum, lê as
                colunas APROVADOR, STATUS, DATA e JUSTIFICATIVA.
     CUIDADO    Se essas colunas forem renomeadas no APEX, a faixa não acha os dados.
     PODE MEXER os textos entre aspas: 'Aprovação', 'Ver o caminho', 'Sua vez', 'Na fila',
                'Confira o atestado e decida.'…
     VISUAL     Natcorp_Atestado.css › [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* O caminho, em detalhe:
     A região "Aprovadores" do APEX (uma timeline) sobe para logo abaixo do cabeçalho e vira uma
     faixa: o resumo ("1 de 2 · aguardando Fulano"), os aprovadores em linha ligados por um fio
     (aprovou / reprovou / é a vez / na fila) e as justificativas escritas. Os botões Aprovar e
     Reprovar (quando o APEX os mostra, só para quem aprova) vão para dentro da faixa — os mesmos
     botões, com os mesmos cliques e ações. A timeline e a sub-região "Justificativa" continuam na
     página, escondidas: a faixa se refaz a cada refresh da região. */
  var APROV, CAMINHO, AP_ABERTO = false, AP_ASSIN = '';
  function bonito(t) {
    t = String(t || '').replace(/\s+/g, ' ').trim();
    if (!t || t !== t.toUpperCase()) return t;
    return t.toLowerCase().replace(/(^|\s)(\S)/g, function (m, a, b) { return a + b.toUpperCase(); })
      .replace(/\s(De|Da|Do|Das|Dos|E)(?=\s)/g, function (m) { return m.toLowerCase(); });
  }
  function montarAprovacao() {
    var tl = document.querySelector('.t-Timeline');
    APROV = tl && tl.closest('.t-Region');
    if (!APROV) {
      var th = document.querySelector('td[headers="APROVADOR"]');
      APROV = th && th.closest('.t-Region');
    }
    if (!APROV) return;
    APROV.classList.add('nc-at-aprov');
    /* sobe para logo abaixo do cabeçalho; a coluna de onde saiu fica vazia */
    if (HERO && APROV.previousElementSibling !== HERO) HERO.parentNode.insertBefore(APROV, HERO.nextSibling);
    var corpo = APROV.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    CAMINHO = el('div', 'nc-at-caminho');
    (corpo || APROV).insertBefore(CAMINHO, (corpo || APROV).firstChild);
    CAMINHO.addEventListener('click', function (e) {
      if (e.target.closest('.nc-at-caminho-ver')) { AP_ABERTO = !AP_ABERTO; AP_ASSIN = ''; agendar(); }
    });
    /* os botões de decisão: guardados uma vez (depois de movidos, continuam os mesmos) */
    APROV._ncBotoes = [botaoPorTexto(/^aprovar$/i), botaoPorTexto(/^reprovar$/i)].filter(Boolean);
  }
  function lerAprovacao() {
    function limpo2(e) { return e ? limpo(e.textContent) : ''; }
    var passos = [].slice.call(APROV.querySelectorAll('.t-Timeline-item')).map(function (li) {
      var tipo = li.querySelector('.t-Timeline-type');
      var st = limpo2(li.querySelector('.t-Timeline-typename'));
      var data = [limpo2(li.querySelector('.t-Timeline-desc')), limpo2(li.querySelector('.t-Timeline-date'))].filter(function (x) { return /\d{2}\/\d{2}\/\d{4}/.test(x); })[0] || '';
      return { nome: bonito(limpo2(li.querySelector('.t-Timeline-username'))), status: st, data: data,
        just: limpo2(li.querySelector('.t-Timeline-title')),
        estado: /reprov|recus/i.test(st) || (tipo && tipo.classList.contains('is-removed')) ? 'nao'
          : /aprov/i.test(st) || (tipo && tipo.classList.contains('is-new')) ? 'ok' : 'pend' };
    });
    /* se o modelo da região mudar para relatório comum, as colunas são as mesmas da consulta */
    if (!passos.length) passos = [].slice.call(APROV.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; }
      var st = c('STATUS');
      return { nome: bonito(c('APROVADOR').replace(/^\s*\d+\s*-\s*\d+\s*-\s*/, '')), status: st, data: c('DATA'), just: c('JUSTIFICATIVA'),
        estado: /reprov|recus/i.test(st) ? 'nao' : /aprov/i.test(st) ? 'ok' : 'pend' };
    });
    passos = passos.filter(function (x) { return x.nome || x.status; });
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; });
    var atual = -1;
    if (!reprovado) for (var i = 0; i < passos.length; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var bts = (APROV._ncBotoes || []).filter(function (b) { return b.style.display !== 'none' && !b.classList.contains('u-hidden'); });
    return { passos: passos, atual: atual, reprovado: reprovado, aprovados: passos.filter(function (x) { return x.estado === 'ok'; }).length, botoes: bts };
  }
  function desenharAprovacao() {
    if (!APROV || !CAMINHO) return;
    var ap = lerAprovacao(), n = ap.passos.length;
    oculto(APROV, !n);
    var sit = val('COD_SIT_REQ');
    var assin = JSON.stringify([ap.passos, ap.atual, ap.botoes.length, sit, AP_ABERTO]);
    if (assin === AP_ASSIN) return;          /* nada mudou: não refaz (o observador veria a própria escrita) */
    AP_ASSIN = assin;
    if (!n) { CAMINHO.innerHTML = ''; return; }
    var quemNao = ap.passos.filter(function (x) { return x.estado === 'nao'; })[0];
    var cancelado = sit === '3' || sit === '6';
    var vez = ap.botoes.length > 0 && !cancelado;
    var estado = ap.reprovado ? 'nao' : cancelado ? 'neutro' : ap.atual < 0 ? 'ok' : vez ? 'vez' : 'pend';
    var resumo = ap.reprovado ? '<b>Reprovado</b> por ' + esc(quemNao.nome)
      : cancelado ? '<b>' + (sit === '3' ? 'Pedido cancelado' : 'Pedido suspenso') + '</b> · ' + ap.aprovados + ' de ' + n + ' aprovaram'
      : ap.atual < 0 ? '<b>Aprovado</b> por ' + (n === 1 ? esc(ap.passos[0].nome) : 'todos')
      : vez ? '<b>' + ap.aprovados + ' de ' + n + '</b> · <b>é a sua vez</b>'
      : '<b>' + ap.aprovados + ' de ' + n + '</b> · aguardando <b>' + esc(ap.passos[ap.atual].nome) + '</b>';
    var justs = ap.passos.filter(function (x) { return x.just; });
    APROV.classList.toggle('nc-at-ap-aberto', AP_ABERTO);
    CAMINHO.className = 'nc-at-caminho nc-at-caminho--' + estado;
    CAMINHO.innerHTML =
      '<p class="nc-at-caminho-rot">Aprovação</p><div class="nc-at-caminho-cab"><p class="nc-at-caminho-resumo">' + resumo + '</p>' +
        '<button type="button" class="nc-at-caminho-ver" aria-expanded="' + AP_ABERTO + '">' + (AP_ABERTO ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
      '<ol class="nc-at-passos-ap">' + ap.passos.map(function (x, i) {
        var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === ap.atual && !cancelado ? 'is-vez' : 'is-fila';
        var st = x.estado === 'ok' ? (x.data ? x.data.replace(/\s.*$/, '') : 'Aprovou') : x.estado === 'nao' ? 'Reprovou' + (x.data ? ' · ' + x.data.replace(/\s.*$/, '') : '')
          : cls === 'is-vez' ? (vez ? 'Sua vez' : 'Aguardando') : 'Na fila';
        var ic = x.estado === 'ok' ? '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>' : x.estado === 'nao' ? '<path d="M8 8l8 8M16 8l-8 8"/>' : cls === 'is-vez' ? '<path d="M12 8v4l2.5 1.5"/>' : '';
        var dica = x.nome + ' — ' + (x.estado === 'ok' ? 'aprovou' + (x.data ? ' em ' + x.data : '') : x.estado === 'nao' ? 'reprovou' + (x.data ? ' em ' + x.data : '')
          : cls === 'is-vez' ? 'aguardando a aprovação' : 'na fila') + (x.just ? ': "' + x.just + '"' : '');
        return '<li class="nc-at-ap ' + cls + '" title="' + esc(dica) + '"><span class="nc-at-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
          '<span class="nc-at-ap-texto"><span class="nc-at-ap-nome">' + esc(x.nome || 'Aprovador') + '</span><span class="nc-at-ap-estado">' + esc(st) + '</span></span></li>';
      }).join('') + '</ol>' +
      (vez ? '<div class="nc-at-decisao"><p class="nc-at-decisao-txt">Confira o atestado e decida.</p><div class="nc-at-decisao-botoes" aria-label="Sua decisão"></div></div>' : '') +
      (justs.length ? '<div class="nc-at-ap-justs">' + justs.map(function (x) {
        return '<blockquote class="nc-at-ap-just' + (x.estado === 'nao' ? ' is-nao' : '') + '"><b>' + esc(x.nome) + (x.estado === 'nao' ? ' reprovou' : x.estado === 'ok' ? ' aprovou' : '') + ':</b> ' + esc(x.just) + '</blockquote>';
      }).join('') + '</div>' : '');
    var dest = CAMINHO.querySelector('.nc-at-decisao-botoes');
    if (dest) ap.botoes.slice().sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) {
      b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-at-reprovar' : 'nc-at-aprovar');
      dest.appendChild(b);
    });
  }
  function desenharCabecalho() {
    if (!HERO) return;
    var sit = SIT[val('COD_SIT_REQ')] || ['neutro', txt('COD_SIT_REQ') || 'Situação', IC.relogio];
    /* em aberto com todos os aprovadores já de acordo: não está mais "esperando aprovação" */
    if (val('COD_SIT_REQ') === '1' && APROV) {
      var ap = lerAprovacao();
      if (ap.passos.length && ap.aprovados === ap.passos.length) sit = ['espera', 'Em aberto', IC.aguarda];
    }
    var pessoa = semCodigo(txt('MATRICULA')).replace(/^\d+\s*-\s*/, '');
    var quem = semCodigo(txt('MAT_SOLICITANTE')).replace(/^\d+\s*-\s*/, '');
    var tipo = semCodigo(txt('COD_ATESTADO_MEDICO'));
    var fr = frasePeriodo(periodo());
    var abertura = txt('DT_REQ'), situacao = txt('DT_SIT_REQ');
    var alt = txt('DT_ATUALIZACAO'), usu = txt('USUARIO');
    function cap(t) { return t ? t.toLowerCase().replace(/(^|\s)(\S)/g, function (m, a, b) { return a + b.toUpperCase(); }).replace(/\b(De|Da|Do|Das|Dos|E)\b/g, function (m) { return m.toLowerCase(); }) : ''; }
    html(HERO,
      '<div class="nc-at-hero-topo"><span class="nc-at-hero-n">Atestado nº ' + esc(val('COD_REQ') || txt('COD_REQ')) + '</span>' +
        '<span class="nc-at-sit nc-at-sit--' + sit[0] + '">' + svg(sit[2]) + esc(sit[1]) + '</span></div>' +
      '<h2 class="nc-at-hero-tit">' + esc(cap(tipo) || 'Atestado') + (pessoa ? ' <span>· ' + esc(cap(pessoa)) + '</span>' : '') + '</h2>' +
      (fr ? '<p class="nc-at-hero-per' + (fr.ruim ? ' is-ruim' : '') + '">' + svg(IC.cal) + '<span>' + fr.t + '</span></p>' : '') +
      '<dl class="nc-at-hero-dl">' +
        (abertura ? '<div><dt>Pedido em</dt><dd>' + esc(abertura) + (quem ? ' por ' + esc(cap(quem)) : '') + '</dd></div>' : '') +
        (situacao && situacao !== abertura ? '<div><dt>Situação desde</dt><dd>' + esc(situacao) + '</dd></div>' : '') +
        (alt && alt !== abertura ? '<div><dt>Última alteração</dt><dd>' + esc(alt) + (usu ? ' · ' + esc(usu) : '') + '</dd></div>' : '') +
      '</dl>');
    desenharAprovacao();
  }

  /* ═══ [J11] O REDESENHO A CADA MUDANÇA ══════════════════════════════════════════════════
     O QUE FAZ  atualizar() refaz tudo o que depende dos valores, sempre que algo muda:
                  • esconde as horas quando o tipo não conta em horas (TIPO_ATESTADO);
                  • em leitura, tira as frases de ajuda, o "[Código 010]" e os campos vazios, e
                    troca o anexo por "Baixar o atestado (17 KB)";
                  • escreve a pílula "Conta em dias/horas" embaixo do tipo e a explicação da parte
                    "Quando";
                  • marca o atalho que bate com o valor; atualiza a frase do período;
                  • abre "INSS e acidente" se já tiver algo; some com parte vazia;
                  • muda o texto da abertura para o colaborador; atualiza o "Falta:" do rodapé.
     PODE MEXER os textos entre aspas (explicação da parte "Quando", texto da abertura).
     CUIDADO    É chamada muitas vezes por segundo quando a página muda: não ponha aqui nada que
                abra janela ou mostre alerta.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T;
  function agendar() { clearTimeout(T); T = setTimeout(atualizar, 60); }
  function atualizar() {
    var p = periodo();
    classe(document.body, 'nc-at-horas', p.tipo === 'HORAS');
    classe(document.body, 'nc-at-dias', p.tipo === 'DIAS');

    /* horas: só quando o tipo conta em horas (ou já têm valor que não é 00:00) */
    ['HORA_INICIO_AFASTAMENTO', 'HORA_TERMINO_AFASTAMENTO', 'HORA_INICIO_AFASTAMENTO_DSP', 'HORA_TERMINO_AFASTAMENTO_DSP'].forEach(function (n) {
      var c = cont(n); if (!c) return;
      var v = /_DSP$/.test(n) ? txt(n) : val(n);
      /* lerHora('00:00') é 0: "00:00" conta como vazio, como na validação da página.
         04/10: só esconde com o tipo já em DIAS (como a ação "Seta parametro"); tipo vazio — pedido
         gravado, que não carrega TIPO_ATESTADO — deixa as horas como a página mostra. */
      oculto(c.parentElement && c.parentElement.classList.contains('col') ? c.parentElement : c, !!p.tipo && p.tipo !== 'HORAS' && !lerHora(v));
    });
    /* coluna que ficou sozinha na linha ocupa a linha inteira (o tipo "dias/horas" saiu de perto
       do tipo; a hora sai de perto da data) */
    function cheia(n, on) { var c = cont(n), col = c && c.parentElement; if (col && col.classList.contains('col')) classe(col, 'nc-at-cheia', on); }
    function horaFora(n) { var c = cont(n), col = c && c.parentElement; return !c || (col && col.classList.contains('nc-at-oculto')) || !aVista(c, document.body); }
    cheia('COD_ATESTADO_MEDICO', true);
    cheia('DT_ATESTADO_MEDICO', true);
    cheia('QTDE_DIAS_AFASTAMENTO', true);

    /* leitura (quem só consulta): sem as frases de ajuda e sem o "[Código 010]" no texto */
    var leitura = !!(achado.querySelector('.display_only') && !achado.querySelector('input:not([type=hidden])'));
    classe(document.body, 'nc-at-leitura', leitura);
    if (leitura) [].forEach.call(DADOS.querySelectorAll('.display_only'), function (d) {
      var t = d.textContent, s = semCodigo(t);
      if (s !== t.trim() && s) d.textContent = s;
    });
    /* o atestado já gravado, em leitura: só o link de baixar (a folha geral o desenha como área
       de "arraste outro", que aqui não existe) */
    var arq = cont('ARQ_1_ANEXO'), baixar = arq && !item('ARQ_1_ANEXO') && arq.querySelector('a[href*="get_blob"]');
    classe(arq, 'nc-at-arq-salvo', !!baixar);
    if (baixar && !baixar.getAttribute('data-nc-at')) {
      var kb = /(\d+\s*[KMG]B)/i.exec(baixar.getAttribute('title') || '');
      baixar.setAttribute('data-nc-at', '1');
      baixar.innerHTML = '<span>Baixar o atestado' + (kb ? ' (' + esc(kb[1].replace(/(\d)([KMG])/i, '$1 $2')) + ')' : '') + '</span>';
    }
    cheia('DT_INICIO_AFASTAMENTO', horaFora('HORA_INICIO_AFASTAMENTO'));
    cheia('DT_TERMINO_AFASTAMENTO', horaFora('HORA_TERMINO_AFASTAMENTO'));
    cheia('DT_INICIO_AFASTAMENTO_DSP', horaFora('HORA_INICIO_AFASTAMENTO_DSP'));
    cheia('DT_TERMINO_AFASTAMENTO_DSP', horaFora('HORA_TERMINO_AFASTAMENTO_DSP'));

    /* em leitura, campo vazio não ocupa lugar */
    [].forEach.call(DADOS.querySelectorAll('.t-Form-fieldContainer'), function (c) {
      if (c.id === P + 'TIPO_ATESTADO_CONTAINER') return;
      var so = c.querySelector('.display_only') && !c.querySelector('input:not([type=hidden]), select, textarea');
      if (!so) return;
      var n = c.id.replace(P, '').replace(/_CONTAINER$/, '');
      var vazio = !txt(n) || (/^HORA_/.test(n) && txt(n) === '00:00');
      classe(c, 'nc-at-vazio', vazio);
    });

    /* a indicação "conta em dias/horas" */
    var sub = SECS.quando && SECS.quando.querySelector('[data-sub]');
    var editavel = item('DT_INICIO_AFASTAMENTO') && aVista(cont('DT_INICIO_AFASTAMENTO'), document.body) && !item('DT_INICIO_AFASTAMENTO').disabled;
    if (sub) sub.textContent = !editavel ? '' : p.tipo === 'HORAS' ? 'Este tipo conta em horas: diga o dia e o horário de início e de fim.'
      : p.tipo === 'DIAS' ? 'Este tipo conta em dias: diga o primeiro dia e quantos dias (ou o último dia).'
      : 'Diga o primeiro dia e quantos dias ficou fora.';
    var pt = cont('COD_ATESTADO_MEDICO'), pill = pt && pt.querySelector('.nc-at-pilula');
    if (pt && !pill) { pill = el('span', 'nc-at-pilula'); (pt.querySelector('.t-Form-inputContainer') || pt).appendChild(pill); }
    if (pill) { pill.hidden = !p.tipo; html(pill, p.tipo ? svg(p.tipo === 'HORAS' ? IC.relogio : IC.cal) + 'Conta em ' + (p.tipo === 'HORAS' ? 'horas' : 'dias') : ''); }

    /* atalhos: marcados quando batem com o valor; "quantos dias" some quando conta em horas */
    [].forEach.call(document.querySelectorAll('.nc-at-atalhos'), function (box) {
      var n = box.getAttribute('data-de'), v = val(n), i = item(n);
      /* 04/10: campo só leitura (região travada pela página) vem como input hidden: sem atalhos */
      box.hidden = !i || i.disabled || i.readOnly || i.type === 'hidden' || !aVista(cont(n), document.body) || (n === 'QTDE_DIAS_AFASTAMENTO' && p.tipo === 'HORAS');
      [].forEach.call(box.querySelectorAll('[data-v]'), function (b) {
        var k = b.getAttribute('data-v');
        var alvo = k === 'hoje' ? fmt(hoje()) : k === 'ontem' ? fmt(hoje(-1)) : k === 'igual' ? val('DT_INICIO_AFASTAMENTO') : k;
        b.setAttribute('aria-pressed', v && v === alvo ? 'true' : 'false');
      });
    });

    /* a frase do período */
    if (RESUMO) {
      var fr = frasePeriodo(p);
      var aviso = RESUMO.__aviso;
      RESUMO.hidden = !aviso && !fr;
      classe(RESUMO, 'is-ruim', !!(fr && fr.ruim) && !aviso);
      classe(RESUMO, 'is-aviso', !!aviso);
      html(RESUMO, aviso ? svg(IC.alerta) + '<span>' + esc(aviso) + '</span>'
        : fr ? svg(fr.ruim ? IC.alerta : IC.cal) + '<span>' + fr.t + '</span>' : '');
    }

    /* "INSS e acidente": abre sozinha se já tem algo */
    if (SECS.mais && !SECS.mais.__aberta) {
      var tem = ['TIPO_ACIDENTE_ES', 'DT_ALT_PROG', 'DT_PERICIA'].some(function (n) { return !!(val(n) || txt(n)); });
      if (tem || !NOVO) abrirMais(true);
    }

    /* parte sem nada à vista some */
    PARTES.forEach(function (pt) {
      var s = SECS[pt.k]; if (!s) return;
      var corpo = s.querySelector('.nc-at-parte-corpo'), hid = corpo.hidden;
      corpo.hidden = false;
      var algo = [].some.call(corpo.querySelectorAll('.t-Form-fieldContainer, .t-Button, img'), function (e) {
        return !e.classList.contains('nc-at-vazio') && aVista(e, corpo);
      });
      corpo.hidden = hid;
      oculto(s, !algo);
    });

    /* abertura: para o colaborador (sem "quem"), fala com ele */
    if (INTRO) {
      var pi = INTRO.querySelector('[data-intro]');
      var ehEle = SECS.quem && SECS.quem.classList.contains('nc-at-oculto');
      var t = ehEle ? 'Mande o seu atestado para o RH. Tenha ele em mãos: você vai usar <b>as datas</b> e tirar <b>uma foto</b> dele. O que tem <span class="nc-at-req">*</span> é obrigatório.'
        : 'Tenha o atestado em mãos: você vai usar <b>as datas</b> e tirar <b>uma foto</b> dele. O que tem <span class="nc-at-req">*</span> é obrigatório.';
      html(pi, t);
    }

    /* o que falta para enviar */
    if (FALTA) {
      var f = faltando();
      var pode = CRIAR && CRIAR.style.display !== 'none' && !CRIAR.disabled;
      /* no celular o rodapé é curto: os dois primeiros e "+N" (o toque leva ao primeiro) */
      var mostra = window.innerWidth < 640 && f.length > 3 ? f.slice(0, 2) : f;
      html(FALTA, f.length
        ? '<span class="nc-at-falta-rot">Falta:</span>' + mostra.map(function (n) { return '<button type="button" class="nc-at-falta-item" data-ir="' + n + '">' + esc(CURTO[n] || n) + '</button>'; }).join('') +
          (mostra.length < f.length ? '<button type="button" class="nc-at-falta-item nc-at-falta-mais" data-ir="' + f[mostra.length] + '">+' + (f.length - mostra.length) + '</button>' : '')
        : pode ? '<span class="nc-at-falta-ok">' + svg(IC.ok) + 'Tudo preenchido. Pode enviar.</span>' : '');
      classe(CRIAR, 'is-pronto', !f.length);
    }

    desenharCabecalho();
  }

  /* ═══ [J12] O TÍTULO DA JANELA ══════════════════════════════════════════════════════════
     O QUE FAZ  Troca o título da janela (lá na página de fora, que abriu esta) por
                "Novo atestado ou afastamento" ou "Atestado nº …".
     PODE MEXER os dois textos entre aspas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tituloJanela() {
    try {
      var fora = window.parent && window.parent !== window && window.parent.document;
      if (!fora) return;
      var fr = [].slice.call(fora.querySelectorAll('iframe')).filter(function (i) { return i.contentWindow === window; })[0];
      var dlg = fr && fr.closest('.ui-dialog');
      var t = dlg && dlg.querySelector('.ui-dialog-title');
      var novo = NOVO ? 'Novo atestado ou afastamento' : 'Atestado nº ' + (val('COD_REQ') || txt('COD_REQ'));
      if (t && t.textContent !== novo) t.textContent = novo;
    } catch (x) { /* outro domínio: fica o título do APEX */ }
  }

  /* ═══ [J13] O MAESTRO: QUANDO CADA PARTE É MONTADA ══════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez, quando a janela abre: monta as partes, os nomes, a
                abertura ou o cabeçalho, os atalhos, o cartão do atestado e o rodapé. Depois manda
                redesenhar ([J11]) sempre que algo muda: um campo é alterado, uma região é
                atualizada, a tela muda de tamanho, ou uma ação dinâmica mostra/esconde/trava um
                campo.
     CUIDADO    Não mude a ordem das chamadas: umas partes dependem das anteriores (as partes
                precisam existir antes de os atalhos entrarem nelas).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function iniciar() {
    if (!montarPartes()) return;
    document.body.classList.add('nc-at', NOVO ? 'nc-at-novo' : 'nc-at-pedido');
    nomes();
    if (NOVO) abertura(); else montarCabecalho();
    montarQuando();
    montarArquivo();
    montarRodape();
    tituloJanela();
    atualizar();
    $(document).on('change', 'input, select, textarea', agendar);
    $(document).on('apexafterrefresh', agendar);
    window.addEventListener('resize', agendar);
    /* as ações da página mostram/escondem campos (style inline) e ligam/desligam as horas */
    if (window.MutationObserver) new MutationObserver(function (ms) {
      for (var i = 0; i < ms.length; i++) { var t = ms[i].target; if (!(t.closest && t.closest('.nc-at-resumo, .nc-at-falta, .nc-at-hero, .nc-at-pilula, .nc-at-caminho'))) { agendar(); return; } }
    }).observe(document.body, { subtree: true, attributes: true, attributeFilter: ['style', 'disabled', 'class'], childList: true });
    setTimeout(atualizar, 700);
    setTimeout(atualizar, 2000);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
