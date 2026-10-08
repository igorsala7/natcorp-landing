/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · AGENDA DO EXAME  —  o "arrumador" da tela (JavaScript)                         ║
   ║  App 2937 (Medicina Ocupacional) · Página 75 · a janela "Pesquisar Horário para           ║
   ║  Encaminhamento", aberta pelo botão "Agenda - Datas e Horários" da Requisição de Exames   ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Nesta janela o gestor escolhe o médico, o dia e a faixa de horário e vê os horários livres;
   tocar num horário devolve dia, horas e a vaga para a requisição. O arquivo deixa isso
   simples:
     1. Cabeçalho da janela: "Escolher dia e horário do exame" e o que fazer, em uma frase.
     2. Médico (com um aviso quando a lista vem vazia), Dia (atalhos Hoje / Amanhã / próximos
        dias úteis e o dia por extenso) e Horário ("A partir de" / "Até" com o seletor de hora
        do próprio aparelho no lugar do relógio do plugin; atalhos Manhã / Tarde / Qualquer
        hora).
     3. O botão "Pesquisar" passa a dizer "Ver horários livres".
     4. O relatório vira a LISTA DE HORÁRIOS LIVRES: agrupada por dia, cada horário um botão
        com a hora e o médico; a barra de busca do relatório sai de vista. Antes de pesquisar,
        a lista diz o que fazer; sem horário, sugere outro dia ou deixar as horas em branco.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não grava nada. O APEX continua dono de tudo: os itens, a pesquisa (o submit do
       "Pesquisar"), o relatório e o "fechar a janela devolvendo" do horário.
     • Os atalhos só PREENCHEM os itens (com apex.item().setValue, como se a pessoa digitasse);
       "Ver horários livres" CLICA o Pesquisar da página; "Escolher" CLICA o link da linha
       do relatório. Ou seja: as ações continuam sendo as da página.
     • Se este arquivo for retirado da página, a janela volta ao visual padrão do APEX e
       continua funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     App 2937 › Página 75 › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_Agenda.js
                                                     (no FIM da lista)
     App 2937 › Página 75 › CSS › File URLs:         #WORKSPACE_IMAGES#Natcorp_Agenda.css
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Agenda.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Esta página NÃO usa classes postas no APEX. O arquivo se reconhece sozinho pelos itens
   …_PRESTADOR_MEDICINA, …_DATA e …_HORA_INICIO (sem eles, não faz nada). Usa também:
     …_HORA_FIM          o "Até"
     …_COD_EMPRESA_AUX   a empresa do pedido (vazia = os horários não vão aparecer)
     o botão "Pesquisar" (achado pelo texto) e o relatório interativo dos horários.
   As colunas do relatório são achadas pelo NOME do cabeçalho, não pela posição:
     Data/Dia · Hora Início/Inicial · Hora Término/Final/Fim · Médico/Prestador/Profissional.
   Outra coluna qualquer aparece no cartão como "rótulo: valor".

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Configuração ........................ ícones, dias, meses, faixas de hora PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  O cabeçalho e os campos ............. médico, dia, horário, botão          PODE MEXER
     [J4]  A lista de horários livres .......... o relatório vira botões por dia      PODE MEXER
     [J5]  O título da janela .................. "Escolher dia e horário"            PODE MEXER
     [J6]  O maestro ........................... decide QUANDO cada parte roda        CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Ver horários livres'  →  'Buscar horários'
     Quero mudar o horário da "Manhã" ou da "Tarde"         → [J1], lista FAIXAS.
     Renomeei uma coluna do relatório e a lista ficou estranha
       → [J4], função colunas(): ela procura pedaços do nome do cabeçalho. Acrescente o nome
         novo ao lado dos que já estão lá (separando por | ).
     Os horários não aparecem mesmo pesquisando
       → veja se …_COD_EMPRESA_AUX chegou preenchido à janela (o aviso em [J3] avisa disso).
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console). O manual, parte 5, explica o que fazer.

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
     P + 'DATA'             junta os textos: vira 'P75_DATA', o nome do item no APEX.
     val(…)                 lê o que está num item do APEX (veja [J2]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: estas linhas impedem que o arquivo rode duas vezes ou fora do APEX, e o fazem
     desistir em silêncio se a página não tiver …_PRESTADOR_MEDICINA, …_DATA e …_HORA_INICIO.
     A linha do  var P  descobre sozinha o começo do nome dos itens ('P75_'): se a página for
     copiada para outro número, NADA muda aqui. Não apague. */
  if (window.__ncAG || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_PRESTADOR_MEDICINA_CONTAINER"]');
  if (!achado) return;
  var P = achado.id.replace(/PRESTADOR_MEDICINA_CONTAINER$/, '');
  if (!document.getElementById(P + 'DATA') || !document.getElementById(P + 'HORA_INICIO')) return;
  window.__ncAG = true;

  var $ = apex.jQuery;
  /* ═══ [J1] CONFIGURAÇÃO ═══════════════════════════════════════════════════════════════════
     O QUE É    Ícones, nomes de dias e meses e as faixas de horário dos atalhos.
       IC       os ícones (desenhos pequenos), no formato SVG. Não precisa mexer.
       DIAS / CURTOS / MESES   como os dias e meses aparecem escritos.
       FAIXAS   os atalhos de horário. Cada um: ['nome interno', 'Texto do botão',
                'hora inicial', 'hora final', ícone]. Hora em branco ('') = sem limite.
     PODE MEXER os textos e as horas de FAIXAS (formato 'hh:mm', ex.: '07:00').
     CUIDADO    Não mude o primeiro texto de cada faixa ('manha', 'tarde', 'qualquer'): é o
                nome interno que liga o botão à faixa.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var IC = {
    cal: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    medico: '<path d="M6 3.5v5a4 4 0 0 0 8 0v-5"/><path d="M10 12.5v2.5a4.5 4.5 0 0 0 9 0v-2"/><circle cx="19" cy="11" r="2"/>',
    lupa: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5M12 8h.01"/>',
    seta: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    sol: '<circle cx="12" cy="12" r="4"/><path d="M12 3v2M12 19v2M3 12h2M19 12h2M5.6 5.6l1.4 1.4M17 17l1.4 1.4M5.6 18.4L7 17M17 7l1.4-1.4"/>',
    tarde: '<path d="M4 18h16M7 18a5 5 0 0 1 10 0"/><path d="M12 6v3M5.6 9.6l1.8 1.3M18.4 9.6l-1.8 1.3"/>'
  };
  var DIAS = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'];
  var CURTOS = ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sáb'];
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  /* PODE MEXER: os atalhos de horário — ['nome interno', 'Texto', 'de', 'até', ícone] */
  var FAIXAS = [['manha', 'Manhã', '07:00', '12:00', IC.sol], ['tarde', 'Tarde', '12:00', '18:00', IC.tarde], ['qualquer', 'Qualquer hora', '', '', IC.relogio]];

  /* ═══ [J2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS:
       val('ITEM')        o valor do item P75_ITEM ('-' ou vazio contam como vazio)
       cont('ITEM')       o bloco inteiro do campo na tela (rótulo + campo)
       renomear(item, t)  troca o rótulo do item na tela
       dataDe('31/12/2026') transforma o texto numa data;  porExtenso(data) →
                          "amanhã, quinta-feira, 31 de dezembro"
       hora('8:05')       → '08:05'
       bonito(t)          "DRA MARIA DA SILVA" → "Dra Maria da Silva"
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-ag-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function cont(n) { return document.getElementById(P + n + '_CONTAINER'); }
  function limpo(t) { t = String(t || '').replace(/\s+/g, ' ').trim(); return /^[-–—]?$/.test(t) ? '' : t; }
  function val(n) { var e = document.getElementById(P + n); if (!e) return ''; try { return limpo(apex.item(P + n).getValue()); } catch (x) { return limpo(e.value); } }
  function bonito(t) {
    t = String(t || '').trim();
    if (t && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t)) t = t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); });
    return t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); });
  }
  function renomear(n, t) {
    var l = document.getElementById(P + n + '_LABEL');
    if (!l || l.getAttribute('data-nc-ag') === t) return;
    for (var i = 0; i < l.childNodes.length; i++) {
      var x = l.childNodes[i];
      if (x.nodeType === 3 && x.textContent.trim()) { x.textContent = t + ' '; l.setAttribute('data-nc-ag', t); return; }
    }
  }
  function dataDe(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function ddmmaaaa(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear(); }
  function hoje() { var d = new Date(); d.setHours(0, 0, 0, 0); return d; }
  function maisDias(d, n) { var x = new Date(d); x.setDate(x.getDate() + n); return x; }
  function porExtenso(d) {
    var dif = Math.round((d - hoje()) / 864e5);
    return (dif === 0 ? 'hoje, ' : dif === 1 ? 'amanhã, ' : '') + DIAS[d.getDay()] + ', ' + d.getDate() + ' de ' + MESES[d.getMonth()];
  }
  function hora(t) { var m = /(\d{1,2}):(\d{2})/.exec(t || ''); return m ? ('0' + m[1]).slice(-2) + ':' + m[2] : ''; }

  /* o botão "Pesquisar" da página, achado pelo texto (CUIDADO: se for renomeado no APEX,
     troque /pesquisar/ aqui pelo nome novo) */
  var PESQUISAR = null;
  [].forEach.call(document.querySelectorAll('button.t-Button, a.t-Button'), function (b) { if (/pesquisar/i.test(b.textContent)) PESQUISAR = b; });

  /* ═══ [J3] O CABEÇALHO E OS CAMPOS ═══════════════════════════════════════════════════════
     O QUE FAZ  montarFiltros (uma vez):
                • põe no alto o título "Escolher dia e horário do exame" e a frase do que fazer,
                  e esconde o título repetido da página;
                • troca os rótulos: Médico, Dia, A partir de, Até;
                • cria os atalhos de dia (os próximos 5 dias úteis: Hoje, Amanhã, Seg…) e a
                  linha com o dia por extenso;
                • põe "A partir de" e "Até" lado a lado e cria os atalhos de faixa (FAIXAS);
                • troca o relógio do plugin pelo seletor de hora do aparelho (horaDoAparelho);
                • renomeia "Pesquisar" para "Ver horários livres" e o leva para baixo dos filtros.
                desenharFiltros (sempre): os avisos do médico, o dia por extenso e qual atalho
                está aceso.
     LÊ DOS ITENS  PRESTADOR_MEDICINA, DATA, HORA_INICIO, HORA_FIM, COD_EMPRESA_AUX
     PODE MEXER os textos entre aspas: título, frase, rótulos, 'Ver horários livres', os dois
                avisos ('Nenhum médico com horário livre…', 'A empresa do pedido não chegou…').
     VISUAL     Natcorp_Agenda.css › [C2] (alto) e [C3] (campos e atalhos)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var DIA_ATALHOS, DIA_EXT, FAIXA, AVISO_MED;
  function montarFiltros() {
    var reg = achado.closest('.t-Region') || achado.parentElement;
    var alvo = document.querySelector('.t-Body-contentInner') || document.body;
    var topo = el('div', 'nc-ag-topo');
    topo.innerHTML = '<h1 class="nc-ag-tit">Escolher dia e horário do exame</h1><p>Escolha o médico e o dia e toque em <b>Ver horários livres</b>. Depois, toque no horário que for melhor.</p>';
    var primeiro = achado.closest('.row, .container') || achado;
    primeiro.parentNode.insertBefore(topo, primeiro);
    /* o título que a página repete no alto sai (o da janela e o nosso já dizem) */
    [].forEach.call(document.querySelectorAll('.t-Body-title, .t-BreadcrumbRegion, h1:not(.nc-ag-tit)'), function (h) { if (/pesquisar hor/i.test(h.textContent)) h.classList.add('nc-ag-fora'); });

    document.body.classList.add('nc-ag-form');
    renomear('PRESTADOR_MEDICINA', 'Médico');
    renomear('DATA', 'Dia');
    renomear('HORA_INICIO', 'A partir de');
    renomear('HORA_FIM', 'Até');
    AVISO_MED = el('p', 'nc-ag-aviso');
    (cont('PRESTADOR_MEDICINA').querySelector('.t-Form-inputContainer') || cont('PRESTADOR_MEDICINA')).appendChild(AVISO_MED);

    /* o dia: atalhos e o dia por extenso */
    var cd = cont('DATA'), icd = cd.querySelector('.t-Form-inputContainer') || cd;
    DIA_ATALHOS = el('div', 'nc-ag-atalhos');
    DIA_ATALHOS.setAttribute('role', 'group');
    DIA_ATALHOS.setAttribute('aria-label', 'Escolher o dia');
    var d = hoje(), n = 0, dias = [];
    while (dias.length < 5 && n < 12) { var x = maisDias(d, n++); if (x.getDay() !== 0 && x.getDay() !== 6) dias.push(x); }
    DIA_ATALHOS.innerHTML = dias.map(function (x) {
      var dif = Math.round((x - hoje()) / 864e5), rot = dif === 0 ? 'Hoje' : dif === 1 ? 'Amanhã' : CURTOS[x.getDay()].replace(/^./, function (c) { return c.toUpperCase(); });
      return '<button type="button" class="nc-ag-atalho" data-dia="' + ddmmaaaa(x) + '">' + esc(rot) + ' <span>' + x.getDate() + '/' + (x.getMonth() + 1) + '</span></button>';
    }).join('');
    icd.insertBefore(DIA_ATALHOS, icd.firstChild);
    DIA_EXT = el('p', 'nc-ag-dia-ext');
    icd.appendChild(DIA_EXT);
    DIA_ATALHOS.addEventListener('click', function (e) {
      var b = e.target.closest('[data-dia]'); if (!b) return;
      apex.item(P + 'DATA').setValue(b.getAttribute('data-dia'));
      agendar();
    });
    var di = document.getElementById(P + 'DATA'); if (di) { di.setAttribute('placeholder', 'dd/mm/aaaa'); di.classList.add('text_field', 'apex-item-text', 'nc-ag-data'); }

    /* o horário: os dois campos lado a lado, atalhos de faixa */
    var la = cont('HORA_INICIO'), lb = cont('HORA_FIM');
    var par = el('div', 'nc-ag-par');
    var rowA = la.closest('.row') || la;
    rowA.parentNode.insertBefore(par, rowA);
    var colA = el('div', 'nc-ag-col'), colB = el('div', 'nc-ag-col');
    colA.appendChild(la); if (lb) colB.appendChild(lb);
    par.appendChild(colA); par.appendChild(colB);
    if (!rowA.querySelector('.t-Form-fieldContainer')) rowA.classList.add('nc-ag-fora');
    FAIXA = el('div', 'nc-ag-atalhos nc-ag-faixas');
    FAIXA.setAttribute('role', 'group');
    FAIXA.setAttribute('aria-label', 'Faixa de horário');
    FAIXA.innerHTML = '<span class="nc-ag-rot">Horário:</span>' + FAIXAS.map(function (f) { return '<button type="button" class="nc-ag-atalho" data-faixa="' + f[0] + '">' + svg(f[4]) + esc(f[1]) + '</button>'; }).join('');
    par.after(FAIXA);
    FAIXA.addEventListener('click', function (e) {
      var b = e.target.closest('[data-faixa]'); if (!b) return;
      var f = FAIXAS.filter(function (x) { return x[0] === b.getAttribute('data-faixa'); })[0];
      apex.item(P + 'HORA_INICIO').setValue(f[2]);
      if (document.getElementById(P + 'HORA_FIM')) apex.item(P + 'HORA_FIM').setValue(f[3]);
      agendar();
    });
    horaDoAparelho();

    /* Pesquisar = Ver horários livres */
    if (PESQUISAR) {
      var l = PESQUISAR.querySelector('.t-Button-label');
      if (l) l.textContent = 'Ver horários livres';
      PESQUISAR.classList.add('nc-ag-pesquisar');
      /* o botão vem para baixo dos filtros, na largura toda (o clique continua o do APEX) */
      var casa = el('div', 'nc-ag-acao');
      FAIXA.after(casa);
      var velho = PESQUISAR.closest('.row, .t-ButtonRegion');
      casa.appendChild(PESQUISAR);
      if (velho && !velho.querySelector('.t-Form-fieldContainer, button, a.t-Button')) velho.classList.add('nc-ag-fora');
    }
    reg && reg.classList.add('nc-ag-reg');
  }
  /* CUIDADO: a hora continua sendo gravada como "hh:mm", o formato que a página já usa.
     as horas: o seletor de hora do aparelho (o mesmo do despertador) no lugar do relógio do plugin;
     o valor continua "hh:mm", o formato que a página usa */
  function horaDoAparelho() {
    ['HORA_INICIO', 'HORA_FIM'].forEach(function (n) {
      var i = document.getElementById(P + n); if (!i || i.type === 'time') return;
      var v = i.value;
      try { i.type = 'time'; } catch (x) { return; }
      i.step = 300;
      if (hora(v)) i.value = hora(v);
      i.classList.add('text_field', 'apex-item-text', 'nc-ag-hora');
      var c = cont(n), t = c && c.querySelector('.dyndatepicker-trigger'); if (t) t.classList.add('nc-ag-fora');
      i.addEventListener('input', agendar);
    });
  }
  function desenharFiltros() {
    var med = document.getElementById(P + 'PRESTADOR_MEDICINA');
    var semMedico = med && med.tagName === 'SELECT' && ![].some.call(med.options, function (o) { return o.value; });
    var semEmpresa = !val('COD_EMPRESA_AUX');
    /* a lista de médicos traz quem tem algum horário livre na agenda (de qualquer empresa); a
       pesquisa dos horários é que filtra pela empresa do pedido (P75_COD_EMPRESA_AUX) */
    html(AVISO_MED, semMedico ? svg(IC.info) + '<span>Nenhum médico com horário livre na agenda. Fale com o RH ou com o Médico do Trabalho.</span>'
      : semEmpresa ? svg(IC.info) + '<span>A empresa do pedido não chegou a esta janela, e os horários não vão aparecer. Feche a janela e fale com o RH.</span>' : '');
    classe(cont('PRESTADOR_MEDICINA'), 'nc-ag-sem-medico', semMedico);
    var d = dataDe(val('DATA'));
    html(DIA_EXT, d ? svg(IC.cal) + '<span>' + esc(porExtenso(d)) + '</span>' : '');
    [].forEach.call(DIA_ATALHOS.children, function (b) { var on = b.getAttribute('data-dia') === val('DATA'); classe(b, 'is-on', on); b.setAttribute('aria-pressed', on); });
    var a = hora(val('HORA_INICIO')), z = hora(val('HORA_FIM'));
    [].forEach.call(FAIXA.querySelectorAll('[data-faixa]'), function (b) {
      var f = FAIXAS.filter(function (x) { return x[0] === b.getAttribute('data-faixa'); })[0], on = a === f[2] && z === f[3];
      classe(b, 'is-on', on); b.setAttribute('aria-pressed', on);
    });
  }

  /* ═══ [J4] A LISTA DE HORÁRIOS LIVRES ════════════════════════════════════════════════════
     O QUE FAZ  Esconde a tabela do relatório interativo e desenha, no lugar, os horários
                agrupados por dia, cada um um botão "08:00 às 08:30 · médico · Escolher".
                Tocar no botão CLICA o link da linha do relatório: quem fecha a janela e
                devolve os dados é a própria página.
     COMO       colunas() descobre qual coluna é qual pelo NOME do cabeçalho.
     CUIDADO    Se uma coluna for renomeada no relatório para um nome que não contém nenhum
                dos pedaços procurados em colunas(), ela vira "rótulo: valor" no cartão.
     PODE MEXER os textos: 'Os horários livres aparecem aqui', 'Nenhum horário livre com esse
                filtro', 'horários livres', 'toque no que for melhor', 'Escolher'…
     VISUAL     Natcorp_Agenda.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var LISTA, IR;
  function montarLista() {
    IR = document.querySelector('.a-IRR-container, .t-IRR-region');
    if (!IR) return;
    IR.classList.add('nc-ag-ir');
    LISTA = el('div', 'nc-ag-lista');
    LISTA.setAttribute('aria-live', 'polite');
    IR.parentNode.insertBefore(LISTA, IR);
    LISTA.addEventListener('click', function (e) {
      var b = e.target.closest('[data-linha]'); if (!b) return;
      var tr = linhas()[+b.getAttribute('data-linha')]; if (!tr) return;
      var a = tr.querySelector('a[href], button');
      if (a) a.click();
    });
  }
  function linhas() {
    return [].slice.call(document.querySelectorAll('.a-IRR-table tbody tr, .a-IRR-table tr')).filter(function (tr) { return tr.querySelector('td'); });
  }
  /* as colunas pelo nome do cabeçalho (os ids mudam de relatório para relatório) */
  function colunas() {
    var ths = [].slice.call(document.querySelectorAll('.a-IRR-table th'));
    var mapa = {};
    ths.forEach(function (th, k) {
      var t = limpo(th.textContent).toLowerCase(), id = th.id;
      if (!t && !mapa.link) mapa.link = { k: k, id: id };
      else if (/in[ií]cio|inicial|hora ini/.test(t) && !mapa.ini) mapa.ini = { k: k, id: id };
      else if (/t[ée]rmino|final|fim|hora fim|hora ter/.test(t) && !mapa.fim) mapa.fim = { k: k, id: id };
      else if (/^hora|hor[aá]rio/.test(t) && !mapa.ini) mapa.ini = { k: k, id: id };
      else if (/data|dia/.test(t) && !mapa.data) mapa.data = { k: k, id: id };
      else if (/m[ée]dico|prestador|profissional/.test(t) && !mapa.med) mapa.med = { k: k, id: id };
      else if (/^empresa$|^selecionar$/.test(t)) { /* a empresa é a do pedido; "Selecionar" é o link */ }
      else (mapa.outras = mapa.outras || []).push({ k: k, id: id, rot: limpo(th.textContent) });
    });
    return mapa;
  }
  function celula(tr, c) {
    if (!c) return '';
    var td = c.id ? tr.querySelector('td[headers~="' + c.id + '"]') : null;
    if (!td) td = tr.cells[c.k];
    return td ? limpo(td.textContent) : '';
  }
  function desenharLista() {
    if (!LISTA) return;
    var rs = linhas(), pesquisou = !!(val('DATA') || val('HORA_INICIO') || val('HORA_FIM') || val('PRESTADOR_MEDICINA'));
    classe(IR, 'nc-ag-ir--lista', rs.length > 0);
    if (!rs.length) {
      html(LISTA, '<div class="nc-ag-vazio">' + svg(pesquisou ? IC.lupa : IC.cal) + '<div><p class="nc-ag-vazio-tit">' + (pesquisou ? 'Nenhum horário livre com esse filtro' : 'Os horários livres aparecem aqui') + '</p><p class="nc-ag-vazio-sub">' +
        (pesquisou ? 'Tente outro dia, ou deixe "A partir de" e "Até" em branco para ver o dia todo.' : 'Escolha o médico e o dia e toque em "Ver horários livres".') + '</p></div></div>');
      return;
    }
    var c = colunas(), grupos = [], porDia = {};
    rs.forEach(function (tr, k) {
      var dt = celula(tr, c.data), d = dataDe(dt), chave = d ? ddmmaaaa(d) : (dt || '—');
      if (!porDia[chave]) { porDia[chave] = { d: d, rot: dt, itens: [] }; grupos.push(porDia[chave]); }
      porDia[chave].itens.push({ k: k, ini: hora(celula(tr, c.ini)) || celula(tr, c.ini), fim: hora(celula(tr, c.fim)) || celula(tr, c.fim), med: bonito(celula(tr, c.med)), extra: (c.outras || []).map(function (o) { var v = celula(tr, o); return v ? o.rot + ': ' + v : ''; }).filter(Boolean).join(' · '), link: !!tr.querySelector('a[href], button') });
    });
    html(LISTA, '<p class="nc-ag-conta"><b>' + rs.length + (rs.length === 1 ? ' horário livre' : ' horários livres') + '</b> · toque no que for melhor</p>' + grupos.map(function (g) {
      return '<section class="nc-ag-dia"><h2 class="nc-ag-dia-tit">' + svg(IC.cal) + esc(g.d ? porExtenso(g.d).replace(/^./, function (x) { return x.toUpperCase(); }) : g.rot) + '</h2><div class="nc-ag-horas">' +
        g.itens.map(function (it) {
          return '<button type="button" class="nc-ag-hora-bt" data-linha="' + it.k + '"' + (it.link ? '' : ' disabled') + '><span class="nc-ag-hora-h">' + esc(it.ini || '—') + (it.fim ? ' <small>às ' + esc(it.fim) + '</small>' : '') + '</span>' +
            (it.med ? '<span class="nc-ag-hora-med">' + svg(IC.medico) + esc(it.med) + '</span>' : '') + (it.extra ? '<span class="nc-ag-hora-extra">' + esc(it.extra) + '</span>' : '') +
            '<span class="nc-ag-hora-esc">Escolher' + svg(IC.seta) + '</span></button>';
        }).join('') + '</div></section>';
    }).join(''));
  }

  /* ═══ [J5] O TÍTULO DA JANELA ═════════════════════════════════════════════════════════════
     O QUE FAZ  Troca o título da janela (a barra de cima, que é da página que abriu esta)
                para "Escolher dia e horário".
     PODE MEXER o texto 'Escolher dia e horário' (está duas vezes na linha: troque os dois).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tituloJanela() {
    try {
      var fora = window.parent && window.parent !== window && window.parent.document; if (!fora) return;
      var fr = [].slice.call(fora.querySelectorAll('iframe')).filter(function (i) { return i.contentWindow === window; })[0];
      var t = fr && fr.closest('.ui-dialog') && fr.closest('.ui-dialog').querySelector('.ui-dialog-title');
      if (t && t.textContent !== 'Escolher dia e horário') t.textContent = 'Escolher dia e horário';
    } catch (x) { /* outro domínio */ }
  }

  /* ═══ [J6] O MAESTRO: QUANDO CADA PARTE RODA ═════════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a janela abre: põe a marca nc-ag na página (é ela
                que liga o CSS), monta os campos ([J3]) e a lista ([J4]), troca o título ([J5])
                e atualiza. Depois atualiza de novo a cada campo mudado e a cada recarga do
                relatório, e uma vez mais 0,7 s depois (o plugin de hora demora a aparecer).
     CUIDADO    Não mude a ordem das chamadas em iniciar().
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T;
  function agendar() { clearTimeout(T); T = setTimeout(atualizar, 60); }
  function atualizar() { desenharFiltros(); desenharLista(); }
  function iniciar() {
    document.body.classList.add('nc-ag');
    montarFiltros();
    montarLista();
    tituloJanela();
    atualizar();
    $(document).on('change', 'input, select', agendar);
    $(document).on('apexafterrefresh', agendar);
    setTimeout(function () { horaDoAparelho(); atualizar(); }, 700);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
