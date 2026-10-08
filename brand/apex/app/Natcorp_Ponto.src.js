/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · TRATATIVA DE ABONO (PONTO)  —  o "arrumador" da tela (JavaScript)              ║
   ║  App 9503 · Página 203 · o gestor trata o ponto eletrônico do colaborador                ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns. Guia desta página: PONTO-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Na página 203 o gestor confere os dias do mês, corrige ou inclui marcações (a janela de
   ajuste abre no toque do horário), vê a apuração do dia e do período e trava. A reclamação
   de quem usa era: "confuso e difícil". A ideia do desenho: fechar o mês é "achar o dia com
   problema e resolver". Então, quando a página abre, este arquivo REORGANIZA a tela:
     1. FILTROS COM CONTAGEM em cima da lista: Com problema (vermelho na grade) · Conferir
        (amarelo) · Certos · Folgas · Sem marcação · Todos — e "Próximo problema", que rola até
        o próximo dia a resolver. Logo abaixo, "Marcações" (a lista da página) e os menus
        "Lançar" (incluir dia, hora extra, atestado) e "Mais opções".
     2. UMA LINHA POR DIA no lugar da grade de 13 colunas cortada, separada por semanas: a
        data, a situação em palavra ("Com problema", "Certo", "Folga"), as marcações com nome
        (Entrada / Saída…) e "ajustada" quando o horário veio de um abono. As vagas vazias que
        importam aparecem com "+"; as outras ficam atrás de "Incluir". "Ver horas" escolhe o
        dia na lista "Data" da própria página (a página recarrega, como sempre fez).
     3. A FAIXA DO COLABORADOR com o período ("‹ mês anterior / próximo mês ›") e um menu
        "Consultas e relatórios" no lugar das duas faixas de botões.
     4. FECHAR O MÊS EM 4 PASSOS: corrigir os dias → apurar → conferir o resumo → travar.
     5. A COLUNA DA DIREITA: o resumo do período em palavras (o que somou e o que descontou) e
        as horas do dia, cada evento numa linha com "Pedir ajuste" e "Justificar".
     6. OS PEDIDOS DO PERÍODO em abas (Abono · Hora extra · Apuração), cada pedido num cartão
        com uma frase do que foi pedido ("Trocar a 1ª entrada: 08:00 → 09:00").
     "Ver como tabela" devolve a grade original para quem prefere.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não grava nada. A grade de marcações, as janelas, a apuração e as travas são do APEX.
     • O toque num horário da linha é o MESMO clique no botão da grade. Os botões do desenho
       são "por procuração": clicam no botão original da página (veja [J5]).
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 203 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Ponto.js
     Página 203 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Ponto.css
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Ponto.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Esta página NÃO usa classes postas no APEX. O arquivo acha as coisas assim:
     • a grade de marcações: a região com Static ID  marcacao  (um relatório interativo);
     • a página certa: um item terminado em _DIVERGENTE e outro terminado em _DT_INI_A. Sem os
       dois, o arquivo não faz nada. O começo do nome dos itens (P203_) é descoberto sozinho a
       partir do _DIVERGENTE: se a página mudar de número, nada precisa mudar aqui;
     • itens lidos pelo nome (sem o P203_): DIVERGENTE, OPCAO, DATA, DT_INI, DT_FIM, MATRICULA,
       SITUACAO, DT_ADMISSAO, FOTO, ESCALA, JORNADA;
     • regiões achadas pelo TÍTULO: "Colaborador", "Consultas", "Relatórios", "Período",
       "Diário", e as que começam com "Requisições de …" (os pedidos);
     • a coluna da direita: a região com Static ID  rgnSticky;
     • botões achados pelo TEXTO: "Selecionar colaborador", "Regras…", "Realizar Apuração",
       "Trava Apuração Período", "Trava Apuração Di…", e os da barra da grade (Adic. data,
       Req. HE, Req. Atestado, Calendário, Inversão, Pesquisa/Atualizar);
     • colunas dos relatórios lidas pelo nome: DESCRICAO, QTD_HORAS, TIPO, TIPO_EVENTO,
       BH_APURADO_DESC, COD_ITEM.
   Renomear um desses títulos, textos ou colunas no APEX faz a parte correspondente sumir.

   O significado das cores vem da própria grade: t-Button--hot (roxo) = marcação ok; --danger
   (vermelho) = divergência; --warning (amarelo) = conferir; --primary com "+" = vaga vazia.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Ferramentas e nomes das situações ...... "Com problema", "Certo"…          PODE MEXER
     [J2]  A leitura da grade ...................... cores dos botões → situação do dia  CUIDADO
     [J3]  A barra da lista ........................ filtros, Próximo problema, Lançar   PODE MEXER
     [J4]  A lista dos dias ........................ uma linha por dia, semanas          PODE MEXER
     [J5]  Peças do painel: botões por procuração .. como o desenho clica no APEX       CUIDADO
     [J6]  A faixa do colaborador e o período ...... foto, nome, mês, Consultas
     [J7]  Fechar o mês em 4 passos ................ títulos e frases dos passos         PODE MEXER
     [J8]  A coluna da direita ..................... resumo do período e horas do dia    PODE MEXER
     [J9]  Os pedidos do período ................... abas e cartões com frase            PODE MEXER
     [J10] Rótulos da barra da grade ............... "Req. HE" → "Pedir hora extra"     PODE MEXER
     [J11] O maestro ............................... decide QUANDO cada parte é montada  CUIDADO
     [J12] A mesa de trabalho .................. lista e dia lado a lado, abas, saldo  PODE MEXER
     [J14] Ajustar em sequência ................ a fila de ajustes, uma janela atrás da outra PODE MEXER

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Próximo problema'  →  'Ir ao próximo problema'
     Renomeei um botão da barra da grade (ex.: "Req. HE") e ele sumiu do menu "Lançar"
       → [J3]: o botão é achado pelo texto; ajuste o padrão de busca da linha dele.
     Mudei o título de uma região ("Diário", "Período"…) e a coluna da direita perdeu a parte
       → [J8]: a região é achada pelo título; ajuste o padrão de busca (ou volte o título).
     Quero que um evento novo do resumo apareça com um nome amigável  → [J8], lista NOMES.
     Um tipo de pedido novo apareceu ("Requisições de …") e a frase do cartão ficou genérica
       → [J9], função fraseDe: é ali que cada tipo vira frase.
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp ponto].
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
     P + 'DATA'             junta os textos: vira 'P203_DATA', o nome do item no APEX.
     /palavra/i             um "padrão de busca": acha 'palavra' num texto, sem ligar para
                            maiúsculas. É assim que botões e regiões são achados pelo nome.
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: estas linhas impedem que o arquivo rode duas vezes e reconhecem a página: precisa
     haver um item terminado em _DIVERGENTE, outro em _DT_INI_A e a região de Static ID marcacao.
     Sem isso, o arquivo para aqui e a página fica com o visual padrão do APEX. Não apague. */
  if (window.__ncPonto || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_DIVERGENTE_CONTAINER"]');
  var REG = document.getElementById('marcacao');
  if (!achado || !REG || !document.querySelector('[id$="_DT_INI_A_CONTAINER"]')) return;
  window.__ncPonto = true;

  var $ = apex.jQuery;
  /* o começo do nome dos itens (ex.: 'P203_'), descoberto a partir do item _DIVERGENTE */
  var P = achado.id.replace(/DIVERGENTE_CONTAINER$/, '');
  /* ═══ [J1] FERRAMENTAS E NOMES DAS SITUAÇÕES ══════════════════════════════════════════════
     O QUE É    Listas de textos e funções pequenas, usadas pelo arquivo todo.
     PODE MEXER • SITS: os filtros em cima da lista, na ordem em que aparecem.
                    rot  → o texto do filtro        dica → a explicação ao parar o mouse
                • ROT_SIT: a palavra da situação em cada linha do dia.
                CUIDADO: não mude os "id" ('problema', 'conferir'…): o visual usa esses nomes.
     AS MAIS USADAS:
       texto(pedaço)        o texto escrito num pedaço da tela, sem espaços sobrando
       guardar / lembrar    guardam uma escolha (filtro, aba, tabela) enquanto a aba do
                            navegador estiver aberta, para ela voltar igual depois de recarregar
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  /* PODE MEXER: os filtros da lista (rot = texto; dica = explicação) */
  var SITS = [
    { id: 'problema', rot: 'Com problema', dica: 'Dias em vermelho na grade: falta marcação ou o horário não bate com a jornada.' },
    { id: 'conferir', rot: 'Conferir', dica: 'Dias em amarelo na grade.' },
    { id: 'certo', rot: 'Certos', dica: '' },
    { id: 'folga', rot: 'Folgas', dica: '' },
    { id: 'vazio', rot: 'Sem marcação', dica: '' }
  ];
  /* PODE MEXER: a palavra da situação em cada linha */
  var ROT_SIT = { problema: 'Com problema', conferir: 'Conferir', certo: 'Certo', folga: 'Folga', vazio: 'Sem marcação' };
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    alerta: '<path d="M12 3.5l9.5 16.5h-19z"/><path d="M12 10v4.5M12 17.2v.1"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    olho: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="3"/>',
    lua: '<path d="M20 14.5A8 8 0 1 1 9.5 4a6.5 6.5 0 0 0 10.5 10.5z"/>',
    seta: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    play: '<path d="M8 5.5v13l10-6.5z"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    tabela: '<rect x="3" y="4.5" width="18" height="15" rx="2"/><path d="M3 9.5h18M9 9.5v10"/>',
    cartoes: '<rect x="3.5" y="4" width="17" height="6.5" rx="2"/><rect x="3.5" y="13.5" width="17" height="6.5" rx="2"/>',
    mais: '<path d="M12 5v14M5 12h14"/>'
  };

  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d) { return '<svg class="nc-po-ic" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function texto(e) { return e ? e.textContent.replace(/\s+/g, ' ').trim() : ''; }
  function guardar(k, v) { try { sessionStorage.setItem('nc-po-' + k, v); } catch (e) {} }
  function lembrar(k) { try { return sessionStorage.getItem('nc-po-' + k); } catch (e) { return null; } }
  function alturaFixa() {
    var h = 0;
    [].forEach.call(document.querySelectorAll('.t-Header, .t-Body-title'), function (x) { if (/fixed|sticky/.test(getComputedStyle(x).position)) h = Math.max(h, x.getBoundingClientRect().bottom); });
    return Math.min(h, window.innerHeight / 2);
  }

  /* ═══ [J2] A LEITURA DA GRADE ═════════════════════════════════════════════════════════════
     O QUE FAZ  Lê cada linha da grade de marcações (região marcacao): coluna 1 = tipo, 2 = data,
                3 = dia da semana, e da 4ª em diante, um botão por marcação. A COR do botão diz a
                situação: vermelho (--danger) = problema, amarelo (--warning) = conferir, roxo
                (--hot) = ok, sem cor (--primary) = vaga vazia. Dia de folga, DSR ou feriado é
                reconhecido pelo texto da coluna "dia".
     CUIDADO    Se a ordem das colunas da grade mudar no APEX, a leitura erra. A grade precisa
                manter: tipo, data, dia, e depois as marcações.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- ler a grade ---------- */
  function estado(a) {
    var m = /t-Button--(hot|danger|warning|primary)/.exec(a.className);
    return m ? m[1] : 'primary';
  }
  /* o nº da requisição de abono vem no link de cada marcação. Hoje o código o lê dentro do
     valor de P714_OPCAO_PLANTAO: a lista separada por vírgulas, 9º valor (posição [8]).
     (Comentário antigo dizia "P714_COD_REQ, 7º valor da lista de valores".) Com esse número,
     a marcação aparece como "ajustada". */
  function comAbono(a) {
    var h = (a.getAttribute('href') || '').replace(/\\u0025/g, '%');
    var m = /P714_OPCAO_PLANTAO:([^&'\\]*)/.exec(h);
    var v = m ? m[1].split(',') : [];
    return !!(v[8] && /^\d+$/.test(v[8]));
  }
  function lerDias() {
    var linhas = [].filter.call(REG.querySelectorAll('tr'), function (r) { return r.querySelector('td a.t-Button'); });
    return linhas.map(function (tr) {
      var tds = [].slice.call(tr.querySelectorAll('td'));
      var tipo = texto(tds[0]), data = texto(tds[1]), dia = texto(tds[2]);
      var slots = tds.slice(3).map(function (td) { return td.querySelector('a.t-Button'); }).filter(Boolean);
      var marcas = slots.map(function (a) { var t = texto(a); return { a: a, st: estado(a), hora: /^\d{1,2}:\d{2}$/.test(t) ? t : '', abono: comAbono(a) }; });
      var folga = /folga|dsr|feriado/i.test(dia);
      var sit = marcas.some(function (m) { return m.st === 'danger'; }) ? 'problema'
        : marcas.some(function (m) { return m.st === 'warning'; }) ? 'conferir'
        : marcas.some(function (m) { return m.hora; }) ? 'certo'
        : folga ? 'folga' : 'vazio';
      return { tr: tr, tipo: tipo, data: data, dia: dia.replace(/\s*-\s*.*$/, ''), extra: (/-\s*(.+)$/.exec(dia) || [])[1] || '', marcas: marcas, sit: sit };
    });
  }

  /* ═══ [J3] A BARRA DA LISTA ════════════════════════════════════════════════════════════════
     O QUE FAZ  Monta, logo antes da grade, uma barra em duas linhas:
                  em cima  — os filtros com contagem e "Próximo problema" (o que se faz sempre);
                  embaixo  — "Marcações" (a lista P203_OPCAO da página, com as ações dela) e os
                             menus "Lançar" e "Mais opções" (o que se faz às vezes).
                08/10: "Ajustar vários dias" (botão novo da grade → janela 715) fica no menu Lançar
                e à vista na linha de cima.
                Os sete botões soltos da grade saem da frente (estão nos menus); a lista "Dias"
                vem para a barra (04/10); se ficou em "só divergentes", aparece um aviso com "Mostrar todos".
                Também transforma as regiões "Consultas" e "Relatórios" em discretas.
     PODE MEXER os textos dos menus: em cada linha  { orig: …, rot: 'Texto', dica: 'Explicação' }
                troque só rot e dica. E 'Próximo problema', a legenda, 'Mostrar todos os dias'.
     CUIDADO    orig: botaoGrade(/padrão/i) acha o botão da barra da grade pelo texto. Se o botão
                for renomeado no APEX, ajuste o padrão — senão o item some do menu.
     VISUAL     Natcorp_Ponto.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- montagem ---------- */
  var BOX, FILTRO = lembrar('filtro') || 'todos', TABELA = lembrar('tabela') === '1';
  function marcarCabecalho() {
    /* o cabeçalho fixo da grade sai da região quando "gruda" no alto: a marca vai junto com ele */
    [].forEach.call(REG.querySelectorAll('.t-fht-thead, .js-stickyTableHeader'), function (h) { h.classList.add('nc-po-thead'); });
    /* e o clone do cabeçalho que o Natcorp_Allow_Unload_Iframes.js pendura no body (guardado nos
       dados jQuery da região: "ncStickyClone") */
    var c = $(REG).data('ncStickyClone');
    if (c && c[0] && !c[0].classList.contains('nc-po-thead')) c[0].classList.add('nc-po-thead');
  }
  function montar() {
    REG.classList.add('nc-po-reg');
    marcarCabecalho();
    BOX = el('div', 'nc-po');
    /* a barra em duas linhas: em cima o que se faz o tempo todo (filtrar, ir ao próximo problema);
       embaixo o que se faz às vezes — quais marcações ver, LANÇAR algo novo e as outras visões.
       Os sete botões soltos da grade (Inversão, Calendário, Incluir data, Req. HE, Req. Atestado,
       atualizar, maximizar) saem da frente; "Marcações" e "Dias" (itens da página) vêm para a barra. */
    BOX.innerHTML =
      '<div class="nc-po-cab">' +
        '<div class="nc-po-cab-l1"><div class="nc-po-filtros" role="tablist" aria-label="Mostrar dias"></div>' +
          '<button type="button" class="nc-po-prox">' + svg(IC.seta) + '<span>Próximo problema</span></button>' +
          '<button type="button" class="nc-po-seq" hidden>' + svg(IC.play) + '<span>Ajustar em sequência</span></button></div>' +
        '<div class="nc-po-fila" hidden aria-live="polite"></div>' +
        '<div class="nc-po-cab-l2"><div class="nc-po-ver"></div><div class="nc-po-cab-menus"></div></div>' +
        '<p class="nc-po-diverg" hidden>' + svg(IC.alerta) + '<span>A lista está mostrando <b>só os dias divergentes</b>.</span><button type="button" class="nc-po-link" data-todos>Mostrar todos os dias</button></p>' +
      '</div>' +
      '<p class="nc-po-legenda">' + svg(IC.olho) + '<span><b>Toque no horário</b> para corrigir. <b>Toque em +</b> para incluir a marcação que faltou.</span></p>' +
      '<div class="nc-po-dias"></div>';
    /* entra antes da grade */
    var tabela = REG.querySelector('.a-IRR-tableContainer') || REG.querySelector('.a-IRR-table');
    var alvo = tabela; while (alvo && alvo.parentElement && !alvo.parentElement.classList.contains('a-IRR-content') && alvo.parentElement !== REG) alvo = alvo.parentElement;
    (alvo && alvo.parentNode ? alvo.parentNode : REG).insertBefore(BOX, alvo || null);
    montarBarra();

    BOX.querySelector('.nc-po-filtros').addEventListener('click', function (e) {
      var b = e.target.closest('[data-f]'); if (!b) return;
      FILTRO = b.getAttribute('data-f'); guardar('filtro', FILTRO); desenhar();
    });
    BOX.querySelector('.nc-po-prox').addEventListener('click', proximo);
    BOX.querySelector('.nc-po-seq').addEventListener('click', filaComecar);
    BOX.querySelector('.nc-po-fila').addEventListener('click', function (e) {
      var b = e.target.closest('[data-fila]'); if (!b) return;
      var q = b.getAttribute('data-fila');
      if (q === 'continuar') { var f = filaLer(); if (f) { f.ativo = true; f.pausada = false; filaGravar(f); } filaProximo(); }
      else { filaGravar(null); desenharFila(); }
    });
    BOX.querySelector('[data-todos]').addEventListener('click', function () { apex.item(P + 'DIVERGENTE').setValue('N'); });
    BOX.querySelector('.nc-po-dias').addEventListener('click', function (e) {
      var m = e.target.closest('[data-slot]');
      if (m) { var d = DIAS[+m.getAttribute('data-dia')]; var s = d && d.marcas[+m.getAttribute('data-slot')]; if (s && s.a) s.a.click(); return; }
      var mais = e.target.closest('[data-mais]');
      if (mais) { var dd = DIAS[+mais.getAttribute('data-dia')]; dd.aberto = true; desenhar(); return; }
      var h = e.target.closest('[data-horas]');
      if (h) horasDoDia(h.getAttribute('data-horas'));
      if (e.target.closest('[data-ir-dia]') && DIARIO) {
        if (emMesa()) { abrirLado('dia'); irParaMesa(true); }
        else window.scrollTo({ top: DIARIO.reg.getBoundingClientRect().top + window.pageYOffset - alturaFixa() - 12, behavior: 'smooth' });
      }
    });
    [].forEach.call(document.querySelectorAll('.t-Region'), function (r) {
      var t = texto(r.querySelector(':scope > .t-Region-header .t-Region-title'));
      if (/^(consultas|relat[oó]rios)$/i.test(t)) r.classList.add('nc-po-consultas');
    });
  }

  /* ---------- a barra da lista: "Marcações", "Lançar" e "Mais opções" ---------- */
  function botaoGrade(re) {
    return [].filter.call(REG.querySelectorAll('.a-IRR-buttons .t-Button, .a-IRR-toolbar .t-Button'), function (b) { return re.test(texto(b) || b.title || ''); })[0] || null;
  }
  /* um menu que abre para baixo; os itens são botões da página por procuração (ou uma função) */
  function menu(rot, ic, itens, cls) {
    var w = el('div', 'nc-po-mn ' + (cls || ''));
    w.innerHTML = '<button type="button" class="nc-po-mn-bt" aria-expanded="false">' + svg(IC[ic]) + '<span>' + esc(rot) + '</span>' + svg(IC.baixo) + '</button><div class="nc-po-mn-painel" role="menu" hidden></div>';
    var painel = w.querySelector('.nc-po-mn-painel'), bt = w.querySelector('.nc-po-mn-bt');
    itens.forEach(function (x) {
      if (!x.orig && !x.fn) return;
      var b = x.orig ? proxy(x.orig, x.rot, 'nc-po-mn-item', x.ic) : el('button', 'nc-po-px nc-po-mn-item', svg(IC[x.ic]) + '<span>' + esc(x.rot) + '</span>');
      if (!x.orig) { b.type = 'button'; b.addEventListener('click', function () { x.fn(b); fecharMenus(); }); }
      b.setAttribute('role', 'menuitem');
      if (x.dica) { var sp = b.querySelector('span'); sp.innerHTML = '<b>' + esc(x.rot) + '</b><small>' + esc(x.dica) + '</small>'; }
      if (x.id) b.setAttribute('data-item', x.id);
      painel.appendChild(b);
    });
    if (!painel.children.length) return null;
    bt.addEventListener('click', function (e) { e.stopPropagation(); var abre = painel.hidden; fecharMenus(); painel.hidden = !abre; bt.setAttribute('aria-expanded', String(abre)); });
    return w;
  }
  function fecharMenus() {
    [].forEach.call(document.querySelectorAll('.nc-po-mn-painel'), function (p) { if (!p.hidden) { p.hidden = true; var b = p.parentNode.querySelector('.nc-po-mn-bt'); if (b) b.setAttribute('aria-expanded', 'false'); } });
  }
  function montarBarra() {
    var ver = BOX.querySelector('.nc-po-ver'), menus = BOX.querySelector('.nc-po-cab-menus');
    /* "Marcações" (Final, Original, Abonado…): a lista da página vem para a barra, com as ações dela */
    var op = document.getElementById(P + 'OPCAO_CONTAINER');
    if (op) { var rowOp = op.closest('.row'); ver.appendChild(op); if (rowOp) esvaziou(rowOp); }
    /* "Dias" (Apenas divergentes / Todos): 04/10: é item da página (envia a página ao mudar e a
       ação "Seta Divergente" o reescreve), então não some mais — vai para a barra, ao lado de "Marcações" */
    var dv = document.getElementById(P + 'DIVERGENTE_CONTAINER');
    if (dv) { var rowDv = dv.closest('.row'); ver.appendChild(dv); if (rowDv) esvaziou(rowDv); }
    var lancar = menu('Lançar', 'mais', [
      { orig: botaoGrade(/ajustar v[aá]rios/i), rot: 'Ajustar vários dias', dica: 'Mudar muitos horários e salvar tudo de uma vez', ic: 'relogio' },
      { orig: botaoGrade(/^adic|incluir data/i), rot: 'Incluir um dia', dica: 'Um dia que não aparece na lista', ic: 'cal' },
      { orig: botaoGrade(/req\.?\s*he|hora extra/i), rot: 'Pedir hora extra', dica: 'Pedido de horas a mais', ic: 'relogio' },
      { orig: botaoGrade(/atestado/i), rot: 'Lançar atestado', dica: 'Falta justificada por atestado', ic: 'doc' }
    ], 'nc-po-mn--forte');
    var mais = menu('Mais opções', 'lista', [
      { orig: botaoGrade(/calend/i), rot: 'Calendário', dica: 'O mês em forma de calendário', ic: 'cal' },
      { orig: botaoGrade(/invers/i), rot: 'Inversão', ic: 'troca' },
      { fn: function () { TABELA = !TABELA; guardar('tabela', TABELA ? '1' : ''); desenhar(); }, rot: 'Ver como tabela', ic: 'tabela', id: 'vista' },
      { orig: botaoGrade(/pesquisa|atualiz|refresh/i), rot: 'Atualizar a lista', ic: 'atualiza' }
    ]);
    if (lancar) menus.appendChild(lancar);
    /* 08/10: "Ajustar vários dias" (janela 715) também à vista, ao lado de "Próximo problema": é o
       caminho do operador que tem dezenas de ajustes no mesmo colaborador (clica no botão do APEX) */
    var lote = botaoGrade(/ajustar v[aá]rios/i);
    if (lote) {
      var bl = proxy(lote, 'Ajustar vários dias', 'nc-po-lote', 'relogio', 'Mudar muitos horários do período e salvar tudo de uma vez');
      BOX.querySelector('.nc-po-cab-l1').appendChild(bl);
    }
    if (mais) menus.appendChild(mais);
    document.addEventListener('click', function (e) { if (!e.target.closest('.nc-po-mn')) fecharMenus(); });
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') fecharMenus(); });
  }
  /* a linha da grade do APEX que ficou sem nada à vista sai */
  function esvaziou(row) {
    if (![].some.call(row.querySelectorAll(':scope > .col > *'), function (x) { return !x.classList.contains('nc-po-recolhida') && x.getBoundingClientRect().height > 0; })) row.classList.add('nc-po-recolhida');
  }

  /* o dia: a lista "Data" da página mostra a apuração daquele dia (a página recarrega, como sempre) */
  function horasDoDia(data) {
    var s = document.getElementById(P + 'DATA');
    if (!s || !s.options) return;
    var tem = [].some.call(s.options, function (o) { return o.value === data || o.text.trim() === data; });
    if (!tem) return;
    guardar('rolar', data);
    guardar('lado', 'dia');   /* quem pede as horas de um dia quer ver o dia, não o resumo */
    guardarLista();
    apex.item(P + 'DATA').setValue(data);
  }
  /* a grade mora numa caixa com rolagem própria (altura fixa da região) no computador; no
     celular a página inteira rola. Rolar até um cartão respeita os dois casos. */
  function caixa() { var s = getComputedStyle(REG); return /auto|scroll/.test(s.overflowY) && REG.scrollHeight > REG.clientHeight + 4 ? REG : null; }
  function rolarAte(c, suave) {
    var cx = caixa(), cab = BOX.querySelector('.nc-po-cab'), folga = (cab ? cab.getBoundingClientRect().height : 0) + 12;
    if (cx) cx.scrollTo({ top: c.getBoundingClientRect().top - cx.getBoundingClientRect().top + cx.scrollTop - folga, behavior: suave ? 'smooth' : 'auto' });
    else window.scrollTo({ top: c.getBoundingClientRect().top + window.pageYOffset - alturaFixa() - folga, behavior: suave ? 'smooth' : 'auto' });
    c.classList.remove('nc-po-pisca'); void c.offsetWidth; c.classList.add('nc-po-pisca');
  }
  function proximo() {
    var cards = [].slice.call(BOX.querySelectorAll('.nc-po-dia.is-problema, .nc-po-dia.is-conferir'));
    if (!cards.length) return;
    var cx = caixa(), cab = BOX.querySelector('.nc-po-cab');
    var linha = (cx ? cx.getBoundingClientRect().top : alturaFixa()) + (cab ? cab.getBoundingClientRect().height : 0) + 20;
    var prox = cards.filter(function (c) { return c.getBoundingClientRect().top > linha; })[0] || cards[0];
    rolarAte(prox, true);
  }

  /* ═══ [J4] A LISTA DOS DIAS ════════════════════════════════════════════════════════════════
     O QUE FAZ  Desenha uma LINHA por dia (data · situação · marcações · "Ver horas"), com um
                título de semana ("Semana de 02/03 a 08/03") separando. Mostra só os dias do
                filtro escolhido. Cada marcação é um botão: tocar nele = clicar no botão da grade
                (abre a janela de ajuste). Cada marcação mostra a sua posição: Posição 1, Posição 2…
     PODE MEXER os textos: 'Posição ', 'ajustada', 'Incluir', 'Ver horas', 'Horas ao lado',
                'Semana de ', 'Nenhum dia nesta lista.', e DIAS_SEM (os dias da semana).
     VISUAL     Natcorp_Ponto.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- desenho ---------- */
  var DIAS = [];
  /* PODE MEXER: os dias da semana abreviados */
  var DIAS_SEM = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
  function dataAtual() { var s = document.getElementById(P + 'DATA'); return s ? s.value : ''; }
  /* uma LINHA por dia, não um cartão: data · situação · marcações · "Ver horas". O mês inteiro
     cabia em 3.400 px; assim cabe em pouco mais de 1.500 e se lê de cima a baixo. */
  function cartao(d, i) {
    var p = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(d.data);
    var ult = -1; d.marcas.forEach(function (m, k) { if (m.hora || m.st !== 'primary') ult = k; });
    /* vagas que importam: até a última usada/marcada (no mínimo 2, 1 na folga sem nada) + a próxima vazia */
    /* à vista: as marcações feitas e as vagas que a grade pinta (vermelho/amarelo = o que falta);
       as outras vagas vazias ficam atrás de "+ Incluir" — eram ruído em todas as linhas, e na
       folga sobra só o "Incluir" */
    var ver = d.aberto ? d.marcas.length : Math.max(ult + 1, 0);
    var pills = d.marcas.slice(0, ver).map(function (m, k) {
      /* a marcação é chamada pela POSIÇÃO (1, 2, 3…), como a empresa fala — não "entrada/saída" */
      var nome = 'Posição ' + (k + 1);
      var cls = m.st === 'danger' ? 'problema' : m.st === 'warning' ? 'conferir' : m.hora ? 'ok' : 'vazia';
      return '<button type="button" class="nc-po-marca nc-po-marca--' + cls + (m.abono && m.hora ? ' is-ajustada' : '') + '" data-dia="' + i + '" data-slot="' + k + '" aria-label="' + nome + ' ' + (m.hora || 'sem marcação, incluir') + ', ' + d.data + (m.abono && m.hora ? ', ajustada por pedido' : '') + '">' +
        '<small>' + nome + '</small><b>' + (m.hora ? esc(m.hora) : svg(IC.mais)) + '</b>' + (m.abono && m.hora ? '<i>ajustada</i>' : '') + '</button>';
    }).join('');
    var sobra = d.marcas.length - ver;
    var temData = !!document.getElementById(P + 'DATA');
    var atual = p && d.data === dataAtual();
    var sem = p ? DIAS_SEM[new Date(+p[3], +p[2] - 1, +p[1]).getDay()] : d.dia;
    return '<div class="nc-po-dia is-' + d.sit + (atual ? ' is-atual' : '') + '" data-i="' + i + '">' +
      '<div class="nc-po-data"><b>' + (p ? p[1] : esc(d.data)) + '</b><span>' + esc(sem) + '</span></div>' +
      '<div class="nc-po-sit-col"><span class="nc-po-sit">' + (d.sit === 'problema' ? svg(IC.alerta) : d.sit === 'certo' ? svg(IC.ok) : d.sit === 'folga' ? svg(IC.lua) : d.sit === 'conferir' ? svg(IC.olho) : '') + esc(ROT_SIT[d.sit]) + '</span>' +
        (d.extra && d.sit !== 'folga' ? '<span class="nc-po-extra">' + esc(d.extra) + '</span>' : '') +
        (d.tipo && !/^final$/i.test(d.tipo) ? '<span class="nc-po-tipo">' + esc(d.tipo) + '</span>' : '') +
        (PED_DIA[d.data] ? '<span class="nc-po-dped-n">' + svg(IC.doc) + PED_DIA[d.data] + (PED_DIA[d.data] === 1 ? ' pedido' : ' pedidos') + '</span>' : '') + '</div>' +
      '<div class="nc-po-marcas">' + pills + (sobra > 0 ? '<button type="button" class="nc-po-marca nc-po-marca--mais" data-mais="1" data-dia="' + i + '" aria-label="Incluir uma marcação em ' + esc(d.data) + '">' + svg(IC.mais) + '<span>Incluir</span></button>' : '') + '</div>' +
      (atual ? '<button type="button" class="nc-po-aberto" data-ir-dia title="As horas deste dia estão abertas ao lado" aria-label="Ver as horas de ' + esc(d.data) + ', abertas no painel">' + svg(IC.relogio) + '<span>Horas ao lado</span></button>'
        : temData && p ? '<button type="button" class="nc-po-horas" data-horas="' + esc(d.data) + '" title="Ver as horas deste dia" aria-label="Ver as horas de ' + esc(d.data) + '">' + svg(IC.relogio) + '<span>Ver horas</span></button>' : '') +
      '</div>';
  }
  /* as semanas separam a lista: "Semana de 02/03 a 08/03" — fica fácil achar um dia */
  function semanaDe(t) {
    var p = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(t); if (!p) return '';
    var d = new Date(+p[3], +p[2] - 1, +p[1]), ini = new Date(d), fim;
    ini.setDate(d.getDate() - d.getDay()); fim = new Date(ini); fim.setDate(ini.getDate() + 6);
    function dm(x) { return (x.getDate() < 10 ? '0' : '') + x.getDate() + '/' + (x.getMonth() < 9 ? '0' : '') + (x.getMonth() + 1); }
    return 'Semana de ' + dm(ini) + ' a ' + dm(fim);
  }
  function desenhar() {
    var abertos = {}; DIAS.forEach(function (d) { if (d.aberto) abertos[d.data + d.tipo] = 1; });
    DIAS = lerDias();
    DIAS.forEach(function (d) { if (abertos[d.data + d.tipo]) d.aberto = true; });
    var n = {}; SITS.forEach(function (s) { n[s.id] = 0; }); DIAS.forEach(function (d) { n[d.sit]++; });
    if (FILTRO !== 'todos' && !n[FILTRO]) FILTRO = 'todos';
    html(BOX.querySelector('.nc-po-filtros'), SITS.filter(function (s) { return n[s.id]; }).map(function (s) {
      return '<button type="button" role="tab" class="nc-po-f nc-po-f--' + s.id + (FILTRO === s.id ? ' is-on' : '') + '" data-f="' + s.id + '" aria-selected="' + (FILTRO === s.id) + '"' + (s.dica ? ' title="' + esc(s.dica) + '"' : '') + '><b>' + n[s.id] + '</b> ' + esc(s.rot) + '</button>';
    }).join('') + '<button type="button" role="tab" class="nc-po-f' + (FILTRO === 'todos' ? ' is-on' : '') + '" data-f="todos" aria-selected="' + (FILTRO === 'todos') + '"><b>' + DIAS.length + '</b> Todos</button>');
    var prox = BOX.querySelector('.nc-po-prox');
    prox.hidden = !(n.problema || n.conferir);
    desenharFila();
    var vista = BOX.querySelector('[data-item="vista"] span');
    if (vista) html(vista, TABELA ? '<b>Ver como lista</b><small>Um dia por linha</small>' : '<b>Ver como tabela</b><small>A grade de sempre</small>');
    var dvs = document.getElementById(P + 'DIVERGENTE');
    BOX.querySelector('.nc-po-diverg').hidden = !(dvs && dvs.value === 'S');
    classe(REG, 'nc-po-tabela', TABELA);
    classe(document.body, 'nc-po-tabela-on', TABELA);
    marcarCabecalho();
    PED_DIA = mapaPedidosDia();
    var sem = '', lista = DIAS.map(function (d, i) {
      if (!(FILTRO === 'todos' || d.sit === FILTRO)) return '';
      var w = semanaDe(d.data), cab = w && w !== sem ? '<p class="nc-po-semana">' + esc(w) + '</p>' : '';
      if (w) sem = w;
      return cab + cartao(d, i);
    }).join('');
    html(BOX.querySelector('.nc-po-dias'), lista || '<p class="nc-po-nada">Nenhum dia nesta lista.</p>');
    if (document.body.classList.contains('nc-po-painel')) atualizarPainel(n);
  }


  /* ═══ [J5] PEÇAS DO PAINEL: BOTÕES POR PROCURAÇÃO ═════════════════════════════════════════
     O QUE É    As ferramentas do painel (as partes [J6] a [J9]). A mais importante é proxy():
                "por procuração" quer dizer que o botão bonito do desenho, ao ser tocado, CLICA
                no botão original da página. O original continua lá (escondido), com as ações
                dinâmicas dele; se a página o esconde ou o desativa, o botão do desenho some ou
                fica desativado junto (sincronizar).
       regiaoPorTitulo(/…/)  acha uma região pelo título
       botao(/…/)            acha um botão pelo texto
       recolher(x)           esconde uma peça do APEX que o desenho substituiu
     CUIDADO    Nunca apague os botões originais no APEX achando que "sobram": o desenho depende
                deles. Para tirar um botão da tela, use a condição do próprio APEX.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* =====================================================================
     A PÁGINA INTEIRA — o painel do fechamento do mês
     ---------------------------------------------------------------------
     · FAIXA DO COLABORADOR: foto, nome, situação e admissão; "Trocar colaborador", "Ver
       colaborador", "Regras do sindicato" (os botões da página, por procuração). O PERÍODO com
       "‹ mês anterior / próximo mês ›" (as datas da página; mudar a data recarrega, como sempre)
       e um MENU "Consultas e relatórios" no lugar das duas faixas de 16 botões.
     · FECHAR O MÊS EM 4 PASSOS: corrigir os dias (conta sozinho) → apurar → conferir o resumo →
       travar. Os botões são os da página (Realizar Apuração, Trava Apuração Período).
     · COLUNA DA DIREITA que acompanha a rolagem: o RESUMO DO PERÍODO em palavras (o que somou e o
       que descontou; o toque abre os dias do evento — a lupa da página) e as HORAS DO DIA com
       "‹ dia anterior / próximo dia ›" (a lista "Data" da página).
     · PEDIDOS DO PERÍODO em abas (Abono · Hora extra · Apuração) com a contagem de cada.
     Por procuração = o botão do desenho chama .click() no botão da página, que continua no DOM
     (escondido) com as suas ações dinâmicas; ele acende/apaga/some junto com o original.
     ===================================================================== */
  IC.lista = '<path d="M8 6.5h12M8 12h12M8 17.5h12"/><circle cx="4" cy="6.5" r="1"/><circle cx="4" cy="12" r="1"/><circle cx="4" cy="17.5" r="1"/>';
  IC.baixo = '<path d="M6 9l6 6 6-6"/>';
  IC.esq = '<path d="M15 6l-6 6 6 6"/>';
  IC.dir = '<path d="M9 6l6 6-6 6"/>';
  IC.troca = '<path d="M4 8h13l-3.5-3.5M20 16H7l3.5 3.5"/>';
  IC.pessoa = '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>';
  IC.livro = '<path d="M4 5.5A2.5 2.5 0 0 1 6.5 3H20v15H6.5A2.5 2.5 0 0 0 4 20.5z"/><path d="M4 20.5A2.5 2.5 0 0 0 6.5 23H20"/>';
  IC.calc = '<rect x="5" y="3" width="14" height="18" rx="2.5"/><path d="M8 7h8M8.5 11.5h1M11.5 11.5h1M14.5 11.5h1M8.5 15h1M11.5 15h1M14.5 15h1"/>';
  IC.cadeado = '<rect x="5" y="10.5" width="14" height="10" rx="2"/><path d="M8 10.5V7.5a4 4 0 0 1 8 0v3"/>';
  IC.cal = '<rect x="3.5" y="5" width="17" height="15.5" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/>';
  IC.doc = '<path d="M6.5 3h8l4 4v14h-12z"/><path d="M14.5 3v4h4M9.5 12.5h5M9.5 16h5"/>';
  IC.atualiza = '<path d="M20 11a8 8 0 0 0-14.5-4.5L4 8M4 4v4h4M4 13a8 8 0 0 0 14.5 4.5L20 16M20 20v-4h-4"/>';
  IC.abrir = '<path d="M14 4h6v6M20 4l-8.5 8.5M18 14v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h5"/>';
  IC.balao = '<path d="M4 5.5h16v10H9l-5 4z"/><path d="M8 9.5h8M8 12.5h5"/>';
  IC.lupa = '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>';
  IC.ajuste = '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>';

  function regiaoPorTitulo(re) {
    return [].filter.call(document.querySelectorAll('.t-Region'), function (r) {
      return re.test(texto(r.querySelector(':scope > .t-Region-header .t-Region-title')));
    })[0] || null;
  }
  function botao(re, dentro) { return [].filter.call((dentro || document).querySelectorAll('.t-Button'), function (b) { return re.test(texto(b) || b.title || ''); })[0] || null; }
  function recolher(e) {
    if (!e) return;
    e.classList.add('nc-po-recolhida');
    /* a linha da grade do APEX que ficou sem nada à vista também sai */
    var row = e.closest('.row');
    if (row && ![].some.call(row.querySelectorAll(':scope > .col > :is(.t-Region, .t-IRR-region, .t-Form-fieldContainer, .t-ButtonRegion)'), function (x) { return !x.classList.contains('nc-po-recolhida'); })) row.classList.add('nc-po-recolhida');
  }
  /* o botão da página está à vista? (só conta o que as ações da página escondem: style inline) */
  function aVista(b) {
    if (!b) return false;
    for (var e = b; e && e !== document.body; e = e.parentElement) if (e.style && e.style.display === 'none') return false;
    return true;
  }
  var PROX = [];
  function proxy(orig, rot, cls, ic, dica) {
    var b = el('button', 'nc-po-px ' + (cls || ''), (ic ? svg(IC[ic]) : '') + '<span>' + esc(rot) + '</span>');
    b.type = 'button';
    if (dica) b.title = dica;
    b.addEventListener('click', function () { if (orig && !orig.disabled) orig.click(); fecharMenu(); fecharMenus(); });
    PROX.push({ b: b, o: orig });
    return b;
  }
  function sincronizar() {
    PROX.forEach(function (x) {
      var v = aVista(x.o), d = !!(x.o && x.o.disabled);
      if (x.b.hidden !== !v) x.b.hidden = !v;
      if (x.b.disabled !== d) x.b.disabled = d;
    });
  }
  function valorDe(n) { var e = document.getElementById(P + n); return e ? String(e.value || e.textContent || '').trim() : ''; }
  function bonito(t) {
    t = String(t || '').trim();
    if (t === t.toUpperCase()) t = t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); });
    return t.replace(/(\s)(De|Da|Do|Das|Dos|E)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); });
  }

  /* ═══ [J6] A FAIXA DO COLABORADOR E O PERÍODO ══════════════════════════════════════════════
     O QUE FAZ  No alto: foto, nome, matrícula, situação ("Ativo desde …"), admissão; os botões
                "Trocar colaborador", "Ver colaborador" e "Regras do sindicato" (por procuração,
                os da região "Colaborador"); o período com setas de mês anterior/próximo (as
                datas P203_DT_INI e P203_DT_FIM vão para dentro da faixa); e o menu "Consultas e
                relatórios" com os botões das regiões "Consultas" e "Relatórios".
     COMO MUDA O MÊS  Põe a data inicial sem disparar nada e a final disparando a ação da página
                (PL/SQL + envio), que manda as duas ao servidor — como quem digita.
     PODE MEXER os textos: 'Trocar colaborador', 'Período', 'Consultas e relatórios'…
     VISUAL     Natcorp_Ponto.css › [C7] e [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- a faixa do colaborador e o período ---------- */
  var TOPO, MENU, PASSOS, RESUMO, ABAS;
  function montarTopo() {
    var colab = regiaoPorTitulo(/^colaborador$/i), cons = regiaoPorTitulo(/^consultas$/i), rel = regiaoPorTitulo(/^relat[oó]rios$/i);
    var ancora = cons || colab;
    if (!ancora) return;
    TOPO = el('section', 'nc-po-topo');
    TOPO.innerHTML =
      '<div class="nc-po-pessoa"><span class="nc-po-foto"></span><div class="nc-po-pessoa-txt"><h2 class="nc-po-nome"></h2><p class="nc-po-sub"></p></div></div>' +
      '<div class="nc-po-pessoa-acoes"></div>' +
      '<div class="nc-po-periodo"><span class="nc-po-rot">Período</span><div class="nc-po-nav">' +
        '<button type="button" class="nc-po-seta" data-mes="-1" aria-label="Mês anterior">' + svg(IC.esq) + '</button>' +
        '<button type="button" class="nc-po-periodo-v" aria-expanded="false"></button>' +
        '<button type="button" class="nc-po-seta" data-mes="1" aria-label="Próximo mês">' + svg(IC.dir) + '</button></div>' +
        '<div class="nc-po-datas" hidden></div></div>' +
      '<div class="nc-po-menu"><button type="button" class="nc-po-menu-bt" aria-expanded="false">' + svg(IC.lista) + '<span>Consultas e relatórios</span>' + svg(IC.baixo) + '</button>' +
        '<div class="nc-po-menu-painel" hidden></div></div>';
    var linha = ancora.closest('.row');
    (linha || ancora).parentNode.insertBefore(TOPO, linha || ancora);

    /* pessoa: os botões do cartão "Colaborador", por procuração */
    var ac = TOPO.querySelector('.nc-po-pessoa-acoes');
    if (colab) {
      var sel = botao(/selecionar colaborador/i, colab), reg = botao(/regras/i, colab);
      var ver = [].filter.call(colab.querySelectorAll('.t-Button'), function (b) { return b !== sel && b !== reg; })[0];
      if (sel) ac.appendChild(proxy(sel, 'Trocar colaborador', 'nc-po-px--forte', 'troca'));
      if (ver) ac.appendChild(proxy(ver, 'Ver colaborador', '', 'pessoa'));
      if (reg) ac.appendChild(proxy(reg, 'Regras do sindicato', '', 'livro'));
      recolher(colab);
    }
    /* as datas do período (as da página) vão para dentro da faixa, abertas por "escolher datas" */
    var datas = TOPO.querySelector('.nc-po-datas');
    ['DT_INI', 'DT_FIM'].forEach(function (n) { var c = document.getElementById(P + n + '_CONTAINER'); if (c) datas.appendChild(c); });
    TOPO.querySelector('.nc-po-periodo-v').addEventListener('click', function () {
      datas.hidden = !datas.hidden; this.setAttribute('aria-expanded', String(!datas.hidden));
    });
    TOPO.querySelector('.nc-po-nav').addEventListener('click', function (e) { var s = e.target.closest('[data-mes]'); if (s) mudarMes(+s.getAttribute('data-mes')); });

    /* o menu: os botões de "Consultas" e "Relatórios", agrupados */
    var painel = TOPO.querySelector('.nc-po-menu-painel');
    MENU = TOPO.querySelector('.nc-po-menu-bt');
    [[cons, 'Consultas'], [rel, 'Relatórios']].forEach(function (g) {
      if (!g[0]) return;
      var bs = [].slice.call(g[0].querySelectorAll('.t-Button'));
      if (!bs.length) return;
      var grupo = el('div', 'nc-po-menu-grupo', '<p>' + g[1] + '</p>');
      bs.forEach(function (b) { grupo.appendChild(proxy(b, texto(b) || b.title, 'nc-po-menu-item')); });
      painel.appendChild(grupo);
      recolher(g[0]);
    });
    MENU.addEventListener('click', function (e) { e.stopPropagation(); var abre = painel.hidden; painel.hidden = !abre; MENU.setAttribute('aria-expanded', String(abre)); });
    document.addEventListener('click', function (e) { if (!painel.hidden && !e.target.closest('.nc-po-menu')) fecharMenu(); });
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') fecharMenu(); });
  }
  function fecharMenu() { var p = TOPO && TOPO.querySelector('.nc-po-menu-painel'); if (p && !p.hidden) { p.hidden = true; MENU.setAttribute('aria-expanded', 'false'); } }
  function dataDe(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function fmt(d) { function z(n) { return (n < 10 ? '0' : '') + n; } return z(d.getDate()) + '/' + z(d.getMonth() + 1) + '/' + d.getFullYear(); }
  /* mês anterior/próximo: a data inicial entra sem disparar nada; a final dispara a ação da
     página (PL/SQL + envio), que manda as duas datas ao servidor — como quem digita */
  function mudarMes(delta) {
    var ini = dataDe(valorDe('DT_INI')) || new Date();
    var a = new Date(ini.getFullYear(), ini.getMonth() + delta, 1), b = new Date(a.getFullYear(), a.getMonth() + 1, 0);
    apex.item(P + 'DT_INI').setValue(fmt(a), null, true);
    /* 04/10: a ação "Valida Datas" (que não roda, para não enviar a página duas vezes) faz
       P203_DT_INI_PERIODO := P203_DT_INI; sem isso o resumo do período ficava com o início antigo */
    if (document.getElementById(P + 'DT_INI_PERIODO')) apex.item(P + 'DT_INI_PERIODO').setValue(apex.item(P + 'DT_INI').getValue(), null, true);
    apex.item(P + 'DT_FIM').setValue(fmt(b));
  }
  function atualizarTopo() {
    if (!TOPO) return;
    var mat = valorDe('MATRICULA'), m = /^\s*(\d+)\s*-\s*(.+)$/.exec(mat);
    var sit = valorDe('SITUACAO'), ms = /^\s*\d+\s*-\s*([^-]+?)\s*-\s*(\d{2}\/\d{2}\/\d{4})/.exec(sit);
    var foto = document.getElementById(P + 'FOTO');
    var fotoH = foto && foto.tagName === 'IMG' && foto.getAttribute('src') ? '<img src="' + esc(foto.getAttribute('src')) + '" alt="">' : svg(IC.pessoa);
    html(TOPO.querySelector('.nc-po-foto'), fotoH);
    html(TOPO.querySelector('.nc-po-nome'), esc(m ? bonito(m[2]) : bonito(mat) || 'Colaborador'));
    var sub = [];
    if (m) sub.push('Matrícula ' + esc(m[1]));
    /* 04/10: a empresa (P203_COD_EMPRESA) estava no cartão "Colaborador", que o desenho esconde */
    if (valorDe('COD_EMPRESA')) sub.push('Empresa ' + esc(bonito(valorDe('COD_EMPRESA'))));
    if (ms) sub.push('<span class="nc-po-chip ' + (/ativ/i.test(ms[1]) && !/inativ/i.test(ms[1]) ? 'nc-po-chip--ok' : 'nc-po-chip--aviso') + '">' + esc(bonito(ms[1])) + ' desde ' + esc(ms[2]) + '</span>');
    else if (sit) sub.push(esc(sit));
    if (valorDe('DT_ADMISSAO')) sub.push('Admissão ' + esc(valorDe('DT_ADMISSAO')));
    html(TOPO.querySelector('.nc-po-sub'), sub.join('<span class="nc-po-sep"></span>'));
    var ini = valorDe('DT_INI'), fim = valorDe('DT_FIM');
    html(TOPO.querySelector('.nc-po-periodo-v'), svg(IC.cal) + '<span>' + esc(ini) + ' a ' + esc(fim) + '</span>');
  }

  /* ═══ [J7] FECHAR O MÊS EM 4 PASSOS ═══════════════════════════════════════════════════════
     O QUE FAZ  Logo abaixo da faixa: 1 Corrigir os dias (conta sozinho quantos têm problema) →
                2 Apurar (o botão "Realizar Apuração" da página) → 3 Conferir o resumo →
                4 Travar o período (o botão "Trava Apuração Período" da página).
     PODE MEXER os títulos (<b>…</b>) e as frases de cada passo, e os textos dos botões.
     VISUAL     Natcorp_Ponto.css › [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- fechar o mês em 4 passos ---------- */
  function montarPassos() {
    if (!TOPO) return;
    var apurar = botao(/realizar apura/i), travar = botao(/trava apura[cç][aã]o per/i);
    PASSOS = el('section', 'nc-po-passos');
    PASSOS.setAttribute('aria-label', 'Fechar o mês');
    PASSOS.innerHTML = '<h3 class="nc-po-passos-tit">Fechar o mês</h3><ol class="nc-po-passos-lista">' +
      '<li class="nc-po-passo" data-p="1"><span class="nc-po-passo-n">1</span><div><b>Corrigir os dias</b><p class="nc-po-passo-txt"></p><div class="nc-po-passo-acao"></div></div></li>' +
      '<li class="nc-po-passo" data-p="2"><span class="nc-po-passo-n">2</span><div><b>Apurar</b><p>Calcula as horas do período com as correções.</p><div class="nc-po-passo-acao"></div></div></li>' +
      '<li class="nc-po-passo" data-p="3"><span class="nc-po-passo-n">3</span><div><b>Conferir o resumo</b><p>Trabalhadas, extras, faltas e atrasos do período.</p><div class="nc-po-passo-acao"></div></div></li>' +
      '<li class="nc-po-passo" data-p="4"><span class="nc-po-passo-n">4</span><div><b>Travar o período</b><p>Trava a apuração do período.</p><div class="nc-po-passo-acao"></div></div></li></ol>';
    TOPO.parentNode.insertBefore(PASSOS, TOPO.nextSibling);
    var ver = el('button', 'nc-po-px nc-po-px--linha', svg(IC.seta) + '<span>Ver os dias com problema</span>');
    ver.type = 'button';
    ver.addEventListener('click', function () {
      FILTRO = 'problema'; guardar('filtro', FILTRO); desenhar();
      if (emMesa()) { irParaMesa(true); REG.scrollTop = 0; } else BOX.scrollIntoView({ behavior: 'smooth', block: 'start' });
    });
    PASSOS.querySelector('[data-p="1"] .nc-po-passo-acao').appendChild(ver);
    if (apurar) { PASSOS.querySelector('[data-p="2"] .nc-po-passo-acao').appendChild(proxy(apurar, 'Realizar apuração', 'nc-po-px--forte', 'calc')); recolher(apurar); }
    var conf = el('button', 'nc-po-px nc-po-px--linha', svg(IC.seta) + '<span>Ver o resumo</span>');
    conf.type = 'button';
    conf.addEventListener('click', function () {
      abrirLado('resumo');
      if (emMesa()) irParaMesa(true); else if (RESUMO) RESUMO.scrollIntoView({ behavior: 'smooth', block: 'center' });
    });
    PASSOS.querySelector('[data-p="3"] .nc-po-passo-acao').appendChild(conf);
    if (travar) { PASSOS.querySelector('[data-p="4"] .nc-po-passo-acao').appendChild(proxy(travar, 'Travar o período', 'nc-po-px--forte', 'cadeado')); recolher(travar); }
  }
  function atualizarPassos(n) {
    if (!PASSOS) return;
    var p1 = PASSOS.querySelector('[data-p="1"]'), prob = (n.problema || 0) + (n.conferir || 0);
    classe(p1, 'is-feito', !prob);
    classe(p1, 'is-agora', !!prob);
    html(p1.querySelector('.nc-po-passo-txt'), prob ? '<b class="nc-po-conta">' + prob + '</b> ' + (prob > 1 ? 'dias precisam' : 'dia precisa') + ' de correção.' : 'Nenhum dia com problema.');
    html(p1.querySelector('.nc-po-passo-n'), prob ? '1' : svg(IC.ok));
    p1.querySelector('.nc-po-passo-acao').hidden = !prob;
  }

  /* ═══ [J8] A COLUNA DA DIREITA: RESUMO DO PERÍODO E HORAS DO DIA ═══════════════════════════
     O QUE FAZ  Na coluna rgnSticky (título vira "Apuração"):
                • região "Período" → "Resumo do período": o que SOMOU e o que DESCONTOU, em
                  palavras. Tocar num item = a lupa da página (mostra os dias do evento);
                • região "Diário" → "Horas do dia": setas de dia anterior/próximo (a lista
                  P203_DATA), a escala e a jornada numa frase, e cada evento numa linha com
                  "Pedir ajuste" (a janela 181, Requisição de Apuração — trocar o evento) e
                  "Justificar" (a janela 10, Apuração - Justificativa — justificar sem trocar).
     PODE MEXER a lista NOMES: cada linha é  [/padrão no texto do APEX/, 'Nome amigável', 'tom'].
                O tom é 'bom' (soma, verde), 'ruim' (desconta, vermelho) ou 'neutro'. Para um
                evento novo, copie uma linha inteira e troque o padrão e o nome.
     VISUAL     Natcorp_Ponto.css › [C9]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- a coluna da direita: resumo do período e horas do dia ---------- */
  /* PODE MEXER: os nomes amigáveis dos eventos do resumo */
  var NOMES = [
    [/HORAS TRABALHADAS/i, 'Horas trabalhadas', 'neutro'],
    [/DSR/i, 'DSR descontado', 'ruim'],
    [/FALTA/i, 'Faltas', 'ruim'],
    [/ATRASO|SA[IÍ]DAS? ANTECIP/i, 'Atrasos e saídas antes da hora', 'ruim'],
    [/\bHE\b|HORA[S]? EXTRA/i, 'Hora extra', 'bom'],
    [/BANCO/i, 'Banco de horas', 'bom'],
    [/NOTURNO/i, 'Adicional noturno', 'bom']
  ];
  function montarDireita() {
    var col = document.getElementById('rgnSticky');
    if (col) {
      col.classList.add('nc-po-lado');
      var t = col.querySelector(':scope > .t-Region-header .t-Region-title'); if (t) t.textContent = 'Apuração';
    }
    var per = regiaoPorTitulo(/^per[ií]odo$/i), dia = regiaoPorTitulo(/^di[aá]rio$/i);
    if (per) {
      var tp = per.querySelector(':scope > .t-Region-header .t-Region-title'); if (tp) tp.textContent = 'Resumo do período';
      RESUMO = el('div', 'nc-po-resumo');
      var corpo = per.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
      corpo.insertBefore(RESUMO, corpo.firstChild);
      per.classList.add('nc-po-per');
      RESUMO.addEventListener('click', function (e) { var b = e.target.closest('[data-ev]'); if (b && b.__a) b.__a.click(); });
    }
    if (dia) {
      var td = dia.querySelector(':scope > .t-Region-header .t-Region-title'); if (td) td.textContent = 'Horas do dia';
      dia.classList.add('nc-po-diario');
      var trd = botao(/trava apura[cç][aã]o di/i, dia);
      if (trd) { var ld = trd.querySelector('.t-Button-label'); if (ld) ld.textContent = 'Travar este dia'; trd.classList.add('nc-po-travadia'); }
      var dc = document.getElementById(P + 'DATA_CONTAINER');
      if (dc) {
        var nav = el('div', 'nc-po-dianav');
        nav.innerHTML = '<button type="button" class="nc-po-seta" data-d="-1" aria-label="Dia anterior">' + svg(IC.esq) + '</button><div class="nc-po-dianav-meio"></div><button type="button" class="nc-po-seta" data-d="1" aria-label="Próximo dia">' + svg(IC.dir) + '</button>';
        /* a navegação do dia é a primeira coisa das "Horas do dia" (antes do "Travar este dia") */
        var corpoDia = dia.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
        if (corpoDia) corpoDia.insertBefore(nav, corpoDia.firstChild);
        else { var linhaData = dc.closest('.row'); (linhaData || dc).parentNode.insertBefore(nav, linhaData || dc); }
        nav.querySelector('.nc-po-dianav-meio').appendChild(dc);
        nav.addEventListener('click', function (e) {
          var b = e.target.closest('[data-d]'); if (!b) return;
          var s = document.getElementById(P + 'DATA'); if (!s || !s.options) return;
          var i = s.selectedIndex + +b.getAttribute('data-d');
          if (i >= 0 && i < s.options.length) { guardar('rolar', s.options[i].value); guardar('lado', 'dia'); guardarLista(); apex.item(P + 'DATA').setValue(s.options[i].value); }
        });
        nav.querySelector('.nc-po-dianav-meio').appendChild(el('p', 'nc-po-dianav-sem'));
      }
      montarDiario(dia, corpoDia);
    }
  }

  /* ---------- horas do dia: a escala numa frase, cada evento numa linha ----------
     A tabela do Diário (Cod Item · C/D · Horas · Tipo · Apuração · Descricao, com uma lupa e um
     balão sem nome) vira uma lista: "3 - Falta · 06:00 · desconta", com "Pedir ajuste" (a lupa:
     a janela 181, Requisição de Apuração — trocar o evento) e "Justificar" (o balão: a janela 10,
     Apuração - Justificativa — justificar sem trocar).
     Escala e Jornada com uma opção só eram listas que não se escolhe: viram uma frase. */
  var DIARIO;
  function montarDiario(dia, corpo) {
    DIARIO = { reg: dia, jornada: el('p', 'nc-po-jornada'), lista: el('div', 'nc-po-eventos'), pe: el('div', 'nc-po-diario-pe') };
    var rel = dia.querySelector('.t-Report') || dia.querySelector('[class*="report_"]');
    var antes = rel ? (rel.closest('[class*="report_"]') || rel) : null;
    var base = corpo || dia;
    if (antes && antes.parentNode) { antes.parentNode.insertBefore(DIARIO.jornada, antes); antes.parentNode.insertBefore(DIARIO.lista, antes); }
    else { base.appendChild(DIARIO.jornada); base.appendChild(DIARIO.lista); }
    base.appendChild(DIARIO.pe);
    var trd = dia.querySelector('.nc-po-travadia');
    if (trd) { var rowT = trd.closest('.row'); DIARIO.pe.appendChild(trd); if (rowT) rowT.classList.add('nc-po-recolhida'); }
    dia.classList.add('nc-po-diario-lista');
    DIARIO.lista.addEventListener('click', function (e) {
      var b = e.target.closest('[data-ev-i]'); if (!b) return;
      var x = (DIARIO.itens || [])[+b.getAttribute('data-ev-i')];
      var a = x && (b.getAttribute('data-ev-a') === 'det' ? x.det : x.ajuste);
      if (a) a.click();
    });
  }
  function horario(t) {
    /* "237 - Das 06:30 Às 12:30" → "237 - Das 06:30 às 12:30" (código - descrição, como no resto) */
    return String(t || '').replace(/\s+/g, ' ').trim().replace(/(^|\s)(Às|As)(?=\s)/g, '$1às').replace(/(^|\s)Das(?=\s)/g, '$1das').replace(/(\s)E(?=\s+\d)/g, '$1e').replace(/^(\d+\s*-\s*)d/, '$1D');
  }
  function atualizarDiario() {
    if (!DIARIO) return;
    var dt = dataAtual(), p = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(dt);
    var nomes = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'];
    var semEl = DIARIO.reg.querySelector('.nc-po-dianav-sem');
    if (semEl) html(semEl, p ? esc(nomes[new Date(+p[3], +p[2] - 1, +p[1]).getDay()]) : '');
    /* escala e jornada: frase quando há uma opção só (a lista continua lá quando há escolha) */
    var partes = [];
    ['ESCALA', 'JORNADA'].forEach(function (n) {
      var s = document.getElementById(P + n), c = document.getElementById(P + n + '_CONTAINER');
      if (!s || !c) return;
      var unica = s.options ? s.options.length <= 1 : true;
      var row = c.closest('.row');
      classe(c, 'nc-po-recolhida', unica);
      if (row) { if (unica) esvaziou(row); else row.classList.remove('nc-po-recolhida'); }
      var t = s.options && s.selectedIndex >= 0 ? s.options[s.selectedIndex].text : s.value;
      if (unica && t) partes.push({ n: n === 'ESCALA' ? 'Escala' : 'Jornada', t: horario(t) });
    });
    var mesma = partes.length === 2 && partes[0].t === partes[1].t;
    html(DIARIO.jornada, !partes.length ? '' : mesma
      ? svg(IC.relogio) + '<span>Escala e jornada: <b>' + esc(partes[0].t) + '</b></span>'
      : svg(IC.relogio) + '<span>' + partes.map(function (x) { return x.n + ': <b>' + esc(x.t) + '</b>'; }).join('<br>') + '</span>');
    DIARIO.jornada.hidden = !partes.length;
    /* os eventos do dia */
    var linhas = [].filter.call(DIARIO.reg.querySelectorAll('tbody tr'), function (tr) { return tr.querySelector('td[headers="DESCRICAO"]'); });
    DIARIO.itens = linhas.map(function (tr) {
      function td(h) { return texto(tr.querySelector('td[headers="' + h + '"]')); }
      var cd = td('TIPO');
      return {
        desc: bonito(td('DESCRICAO')).replace(/^(\d+)\s*-\s*/, '$1 - '), h: td('QTD_HORAS'), cd: cd,
        tom: /d[eé]bito/i.test(cd) ? 'ruim' : /cr[eé]dito/i.test(cd) ? 'bom' : 'neutro',
        tipo: bonito(td('TIPO_EVENTO')), ap: bonito(td('BH_APURADO_DESC')),
        /* 04/10: a lupa é DERIVED$02 (janela 181) com P203_USE_REQ = S e DERIVED$01 (janela 214) com N —
           a página mostra uma ou outra; sem a segunda, quem não usa requisição perdia a lupa */
        det: tr.querySelector('td[headers="DERIVED$02"] a') || tr.querySelector('td[headers="DERIVED$01"] a'), ajuste: tr.querySelector('td[headers="COD_ITEM"] a')
      };
    });
    html(DIARIO.lista, !DIARIO.itens.length ? '<p class="nc-po-eventos-vazio">Nenhuma hora apurada neste dia.</p>' :
      '<p class="nc-po-eventos-tit">O que o dia gerou</p>' + DIARIO.itens.map(function (x, i) {
        return '<div class="nc-po-evd nc-po-evd--' + x.tom + '">' +
          '<div class="nc-po-evd-txt"><b>' + esc(x.desc) + '</b><span>' + (x.tom === 'ruim' ? 'Desconta' : x.tom === 'bom' ? 'Soma' : esc(x.cd)) + (x.tipo ? ' · ' + esc(x.tipo) : '') + (x.ap ? ' · ' + esc(x.ap) : '') + '</span></div>' +
          '<strong class="nc-po-evd-h">' + esc(x.h) + '</strong>' +
          '<div class="nc-po-evd-acoes">' +
            (x.det ? '<button type="button" class="nc-po-mini" data-ev-i="' + i + '" data-ev-a="det" title="Pedir para trocar este evento por outro (Requisição de Apuração)">' + svg(IC.ajuste) + '<span>Pedir ajuste</span></button>' : '') +
            (x.ajuste ? '<button type="button" class="nc-po-mini" data-ev-i="' + i + '" data-ev-a="ajuste" title="Justificar este evento, sem trocar">' + svg(IC.balao) + '<span>Justificar</span></button>' : '') +
          '</div></div>';
      }).join(''));
  }
  function atualizarResumo() {
    if (!RESUMO) return;
    var per = RESUMO.closest('.t-Region');
    var linhas = [].filter.call(per.querySelectorAll('tbody tr'), function (tr) { return tr.querySelector('td[headers="DESCRICAO"]'); });
    var itens = linhas.map(function (tr, i) {
      var desc = texto(tr.querySelector('td[headers="DESCRICAO"]')), h = texto(tr.querySelector('td[headers="QTD_HORAS"]'));
      var n = NOMES.filter(function (x) { return x[0].test(desc); })[0];
      var pc = (/(\d+\s*%)/.exec(desc) || [])[1];
      var nome = n ? n[1] + (pc && n[2] === 'bom' ? ' ' + pc.replace(/\s/g, '') : '') : bonito(desc.replace(/^\s*\d+\s*-\s*/, ''));
      /* 04/10: a linha tem até 3 lupas (DERIVED$01 janela 215 com P203_USE_REQ, $02 janela 183 com
         P203_USE_REQ_PERIODO, $03 janela 11 sempre). O toque abre a 11 (os dias do evento); as outras
         que a página mostrar viram botões ao lado — antes só a 1ª da linha era alcançável */
      var as = [].slice.call(tr.querySelectorAll('a[href*="dialog"]'));
      var pri = as.filter(function (a) { return janelaDe(a) === '11'; })[0] || as[0];
      return { i: i, nome: nome, h: h, tom: n ? n[2] : 'neutro', a: pri, mais: as.filter(function (a) { return a !== pri; }) };
    });
    if (!itens.length) { html(RESUMO, '<p class="nc-po-resumo-vazio">Sem horas apuradas no período. Faça a apuração (passo 2).</p>'); return; }
    function bloco(tit, lista, cls) {
      if (!lista.length) return '';
      return '<div class="nc-po-resumo-bloco nc-po-resumo-bloco--' + cls + '"><p class="nc-po-resumo-tit">' + tit + '</p>' + lista.map(function (x) {
        var bt = '<button type="button" class="nc-po-ev nc-po-ev--' + x.tom + '" data-ev="' + x.i + '"' + (x.a ? '' : ' disabled') + '><span>' + esc(x.nome) + '</span><b>' + esc(x.h) + '</b></button>';
        return !x.mais.length ? bt : '<div class="nc-po-evl">' + bt + x.mais.map(function (a, k) {
          return '<button type="button" class="nc-po-ev-mais" data-ev="' + x.i + '" data-mais="' + k + '">' + esc(rotuloJanela(a)) + '</button>';
        }).join('') + '</div>';
      }).join('') + '</div>';
    }
    html(RESUMO, bloco('Somou', itens.filter(function (x) { return x.tom !== 'ruim'; }), 'soma') + bloco('Descontou', itens.filter(function (x) { return x.tom === 'ruim'; }), 'desc') +
      '<p class="nc-po-resumo-dica">Toque num item para ver em que dias ele aconteceu.</p>');
    [].forEach.call(RESUMO.querySelectorAll('[data-ev]'), function (b) {
      var x = itens[+b.getAttribute('data-ev')], k = b.getAttribute('data-mais');
      b.__a = x && (k === null ? x.a : x.mais[+k]);
    });
  }
  /* o número da janela e o título que a própria página dá a ela (apex.navigation.dialog(..., {title: …})) */
  function janelaDe(a) { var m = /f\?p=[^:]*:(\d+)/.exec(decodeURIComponent(a.getAttribute('href') || '')); return m ? m[1] : ''; }
  function rotuloJanela(a) {
    var h = a.getAttribute('href') || '', m = /title\s*:\s*(['"])(.*?)\1/.exec(h);
    var t = m ? m[2].replace(/\\u([0-9a-fA-F]{4})/g, function (_, c) { return String.fromCharCode(parseInt(c, 16)); }) : '';
    if (t) { var d = document.createElement('textarea'); d.innerHTML = t; t = d.value.trim(); }
    return t || 'Abrir';
  }

  /* ═══ [J9] OS PEDIDOS DO PERÍODO ═══════════════════════════════════════════════════════════
     O QUE FAZ  As regiões cujo título começa com "Requisições de …" viram ABAS (Abono · Hora
                extra · Apuração) com a contagem. Dentro de cada aba, cada pedido vira um cartão
                com uma FRASE do que foi pedido (fraseDe), a situação em cor e palavra, quem pediu
                e quando, e "Abrir" (o lápis da linha). "Ver tabela completa" devolve a grade.
     LÊ DE      as colunas do relatório pelo CABEÇALHO (em minúsculas): 'posição', 'posicao envio',
                'hora original', 'hora abono', 'apagar marcacao', 'evento original', 'evento
                solicitado', 'horas originais', 'horas solicitadas', 'situação', 'requisição',
                'data ponto', 'data de abertura', 'solicitante', 'comentarios', 'dt cancelamento',
                'usuario cancelamento', 'plantão', e a coluna LINK.
     CUIDADO    Se um cabeçalho de coluna for renomeado no relatório, a frase perde aquela parte.
     PODE MEXER as frases em fraseDe ('Trocar a ', 'Incluir a ', 'Apagar a '…) e ROT_PED.
     VISUAL     Natcorp_Ponto.css › [C10]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- pedidos do período em abas ---------- */
  var ABA = lembrar('aba');
  function montarAbas() {
    var regs = [].filter.call(document.querySelectorAll('.t-Region'), function (r) { return /^requisi[cç][oõ]es de /i.test(texto(r.querySelector(':scope > .t-Region-header .t-Region-title'))); });
    if (regs.length < 2) return;
    ABAS = { regs: regs, bar: el('section', 'nc-po-pedidos') };
    ABAS.bar.innerHTML = '<h3 class="nc-po-pedidos-tit">Pedidos do período</h3><div class="nc-po-pedidos-abas" role="tablist"></div>';
    var linha = regs[0].closest('.row');
    (linha || regs[0]).parentNode.insertBefore(ABAS.bar, linha || regs[0]);
    regs.forEach(function (r) { r.classList.add('nc-po-pedido'); try { montarPedido(r); } catch (e) { if (window.console) console.warn('[Natcorp ponto · pedido]', e); } });
    ABAS.bar.addEventListener('click', function (e) { var b = e.target.closest('[data-aba]'); if (!b) return; ABA = b.getAttribute('data-aba'); guardar('aba', ABA); atualizarAbas(); });
  }
  function contaPedidos(r) {
    if (r.querySelector('.nodatafound, .a-IRR-noDataMsg')) return 0;
    var l = texto(r.querySelector('.a-IRR-pagination-label'));
    var m = /(\d+)\s*$/.exec(l);
    return m ? +m[1] : r.querySelectorAll('.a-IRR-table tbody tr td').length ? 1 : 0;
  }
  function atualizarAbas() {
    if (!ABAS) return;
    var nomes = ABAS.regs.map(function (r) { return texto(r.querySelector(':scope > .t-Region-header .t-Region-title')).replace(/^requisi[cç][oõ]es de /i, ''); });
    if (ABA === null || !nomes.some(function (n, i) { return String(i) === ABA; })) {
      var primeira = ABAS.regs.map(contaPedidos).map(function (n, i) { return n ? i : -1; }).filter(function (i) { return i >= 0; })[0];
      ABA = String(primeira !== undefined ? primeira : 0);
    }
    html(ABAS.bar.querySelector('.nc-po-pedidos-abas'), nomes.map(function (n, i) {
      var c = contaPedidos(ABAS.regs[i]), on = String(i) === ABA;
      return '<button type="button" role="tab" class="nc-po-aba' + (on ? ' is-on' : '') + '" aria-selected="' + on + '" data-aba="' + i + '">' + esc(n.charAt(0).toUpperCase() + n.slice(1)) + ' <b>' + c + '</b></button>';
    }).join(''));
    ABAS.regs.forEach(function (r, i) {
      var fora = String(i) !== ABA;
      classe(r, 'nc-po-recolhida', fora);
      var row = r.closest('.row'); if (row) classe(row, 'nc-po-recolhida', fora);
    });
  }

  /* ---------- cada pedido num cartão que diz o que foi pedido ----------
     A tabela de 15 a 17 colunas (Empresa, Matrícula e Solicitante iguais em todas as linhas;
     Posição "1", Posicao Envio "-", Hora Original "-") vira uma frase: "Trocar a 1ª entrada:
     08:00 → 09:00", "Incluir a 1ª saída: 12:30", "Trocar 3 - Falta (07:20) por 11 - Banco de
     Débito 11 (01:23)". Situação em cor e palavra, quem pediu e quando; "Abrir" é o lápis da
     linha. Filtro por situação; "Ver tabela completa" devolve a grade (filtros, Ações, baixar).
     As datas de cada região, iguais às do período, ficam atrás de "Mudar datas". */
  var PED_TAB = lembrar('ped-tabela') === '1';
  function montarPedido(r) {
    var corpo = r.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || r;
    var tipo = /apura/i.test(texto(r.querySelector(':scope > .t-Region-header .t-Region-title'))) ? 'apuracao'
      : /hora extra/i.test(texto(r.querySelector(':scope > .t-Region-header .t-Region-title'))) ? 'he' : 'abono';
    var w = el('div', 'nc-po-peds');
    w.innerHTML = '<div class="nc-po-peds-cab"><p class="nc-po-peds-per"></p><div class="nc-po-peds-filtros" role="tablist" aria-label="Situação do pedido"></div>' +
      '<div class="nc-po-peds-acoes"><button type="button" class="nc-po-mini" data-ped-tab>' + svg(IC.tabela) + '<span>Ver tabela completa</span></button></div></div>' +
      '<div class="nc-po-peds-datas" hidden></div><div class="nc-po-peds-lista"></div>';
    corpo.insertBefore(w, corpo.firstChild);
    var datas = w.querySelector('.nc-po-peds-datas');
    [].forEach.call(r.querySelectorAll('.t-Form-fieldContainer'), function (c) {
      if (!/_DT_(INI|FIM)/.test(c.id)) return;
      var row = c.closest('.row'); datas.appendChild(c); if (row) esvaziou(row);
    });
    var at = [].filter.call(r.querySelectorAll('.t-Button'), function (b) { return /atualiza/i.test(texto(b) || b.title || ''); })[0];
    if (at) {
      var px = proxy(at, 'Atualizar', 'nc-po-mini', 'atualiza');
      w.querySelector('.nc-po-peds-acoes').insertBefore(px, w.querySelector('[data-ped-tab]'));
      var rowA = at.closest('.row'); at.classList.add('nc-po-recolhida'); if (rowA) esvaziou(rowA);
    }
    r.__ped = { w: w, tipo: tipo, filtro: 'todos' };
    w.addEventListener('click', function (e) {
      var f = e.target.closest('[data-pf]'); if (f) { r.__ped.filtro = f.getAttribute('data-pf'); desenharPedidos(r); return; }
      if (e.target.closest('[data-ped-datas]')) { datas.hidden = !datas.hidden; return; }
      if (e.target.closest('[data-ped-tab]')) { PED_TAB = !PED_TAB; guardar('ped-tabela', PED_TAB ? '1' : ''); atualizarPedidos(); return; }
      var ab = e.target.closest('[data-ped-abrir]');
      if (ab) { var x = (r.__ped.itens || [])[+ab.getAttribute('data-ped-abrir')]; if (x && x.link) x.link.click(); }
    });
  }
  function vazio(v) { return !v || /^-+$/.test(v); }
  function ordinal(n) {
    n = parseInt(n, 10); if (!n) return '';
    return 'posição ' + n;   /* como a empresa fala: posição 1, 2, 3… (não "1ª entrada") */
  }
  function lerPedidos(r) {
    var mapa = {};
    [].forEach.call(r.querySelectorAll('.a-IRR-table th[id]'), function (th) { mapa[th.id] = texto(th); });
    var rows = [].filter.call(r.querySelectorAll('.a-IRR-table tbody tr'), function (tr) { return tr.querySelector('td[headers]'); });
    return rows.map(function (tr) {
      var v = {}, link = null;
      [].forEach.call(tr.querySelectorAll('td[headers]'), function (td) {
        var h = td.getAttribute('headers').split(' ')[0], nome = mapa[h] || h;
        if (/^link$/i.test(nome) || h === 'LINK') { link = td.querySelector('a'); return; }
        v[nome.toLowerCase()] = texto(td);
      });
      return { v: v, link: link };
    });
  }
  function situacaoDe(t) { return /conclu|aprovad|efetivad/i.test(t) ? 'ok' : /cancel|reprov|recus|negad/i.test(t) ? 'nao' : 'anda'; }
  /* PODE MEXER: os nomes dos filtros de situação dos pedidos */
  var ROT_PED = { todos: 'Todos', anda: 'Em andamento', ok: 'Concluídos', nao: 'Cancelados' };
  function fraseDe(tipo, v) {
    function g(k) { var x = v[k]; return vazio(x) ? '' : x; }
    if (tipo === 'abono') {
      var pos = ordinal(g('posição') || g('posicao')), env = ordinal(g('posicao envio')), orig = g('hora original'), nova = g('hora abono');
      var apagar = /^(s|sim)$/i.test(g('apagar marcacao'));
      if (apagar) return 'Apagar a ' + pos + (orig ? ' (' + esc(orig) + ')' : '');
      if (env && env !== pos) return 'Mover ' + (orig ? '<b>' + esc(orig) + '</b> ' : '') + 'da ' + pos + ' para a ' + env;
      if (!orig && nova) return 'Incluir na ' + pos + ': <b>' + esc(nova) + '</b>';
      if (orig && nova) return 'Trocar a ' + pos + ': <s>' + esc(orig) + '</s> → <b>' + esc(nova) + '</b>';
      return pos ? 'Marcação da ' + pos : 'Pedido de abono';
    }
    if (tipo === 'apuracao') {
      var eo = g('evento original'), es = g('evento solicitado'), ho = g('horas originais'), hs = g('horas solicitadas');
      if (eo && es) return 'Trocar <s>' + esc(bonito(eo)) + (ho ? ' (' + esc(ho) + ')' : '') + '</s> por <b>' + esc(bonito(es)) + (hs ? ' (' + esc(hs) + ')' : '') + '</b>';
      return es ? 'Lançar <b>' + esc(bonito(es)) + '</b>' + (hs ? ' (' + esc(hs) + ')' : '') : 'Pedido de ajuste da apuração';
    }
    /* hora extra (e o que vier): as horas e o motivo, se houver */
    var horas = Object.keys(v).filter(function (k) { return /hora|horas|qtd/.test(k) && !vazio(v[k]) && !/data|abertura/.test(k); }).map(function (k) { return '<b>' + esc(v[k]) + '</b>'; });
    return 'Hora extra' + (horas.length ? ': ' + horas.join(' a ') : '');
  }
  function desenharPedidos(r) {
    var R = r.__ped; if (!R) return;
    var tab = PED_TAB;
    classe(r, 'nc-po-ped-tabela', tab);
    var bt = R.w.querySelector('[data-ped-tab] span'); if (bt) html(bt, tab ? 'Ver como lista' : 'Ver tabela completa');
    /* as datas desta lista */
    var ds = [].map.call(R.w.querySelectorAll('.nc-po-peds-datas input'), function (i) { return i.value; }).filter(Boolean);
    html(R.w.querySelector('.nc-po-peds-per'), ds.length === 2 ? 'De <b>' + esc(ds[0]) + '</b> a <b>' + esc(ds[1]) + '</b> <button type="button" class="nc-po-link" data-ped-datas>Mudar datas</button>' : '');
    var itens = R.itens = lerPedidos(r);
    var n = { todos: itens.length, anda: 0, ok: 0, nao: 0 };
    itens.forEach(function (x) { x.st = situacaoDe(x.v['situação'] || x.v.situacao || ''); n[x.st]++; });
    if (R.filtro !== 'todos' && !n[R.filtro]) R.filtro = 'todos';
    var fs = ['todos', 'anda', 'ok', 'nao'].filter(function (k) { return k === 'todos' || n[k]; });
    html(R.w.querySelector('.nc-po-peds-filtros'), itens.length && fs.length > 2 ? fs.map(function (k) {
      return '<button type="button" role="tab" class="nc-po-pf nc-po-pf--' + k + (R.filtro === k ? ' is-on' : '') + '" aria-selected="' + (R.filtro === k) + '" data-pf="' + k + '"><b>' + n[k] + '</b> ' + ROT_PED[k] + '</button>';
    }).join('') : '');
    if (tab) return;
    var nomeTipo = R.tipo === 'apuracao' ? 'ajuste da apuração' : R.tipo === 'he' ? 'hora extra' : 'abono';
    html(R.w.querySelector('.nc-po-peds-lista'), !itens.length ? '<p class="nc-po-nada">Nenhum pedido de ' + nomeTipo + ' neste período.</p>' : itens.map(function (x, i) {
      if (R.filtro !== 'todos' && x.st !== R.filtro) return '';
      var v = x.v, dp = v['data ponto'] || '', m = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(dp);
      var sit = v['situação'] || v.situacao || '';
      var quem = vazio(v.solicitante) ? '' : ' por ' + esc(v.solicitante);
      var meta = 'Pedido ' + esc(v['requisição'] || v.requisicao || '') + (vazio(v['data de abertura']) ? '' : ' · aberto em ' + esc(v['data de abertura'])) + quem;
      var canc = vazio(v['dt cancelamento']) ? '' : '<p class="nc-po-ped-meta">Cancelado em ' + esc(v['dt cancelamento']) + (vazio(v['usuario cancelamento']) ? '' : ' (' + esc(v['usuario cancelamento'].replace(/[A-Za-z_].*$/, '').trim() || v['usuario cancelamento']) + ')') + '</p>';
      var com = vazio(v.comentarios) ? '' : '<p class="nc-po-ped-com">“' + esc(v.comentarios) + '”</p>';
      var plantao = /^(s|sim)$/i.test(v['plantão'] || '') ? '<span class="nc-po-tipo">Plantão</span>' : '';
      return '<article class="nc-po-ped is-' + x.st + '">' +
        '<div class="nc-po-ped-dia">' + (m ? '<b>' + m[1] + '/' + m[2] + '</b><span>' + DIAS_SEM[new Date(+m[3], +m[2] - 1, +m[1]).getDay()] + '</span>' : '<b>' + esc(dp || '—') + '</b>') + '</div>' +
        '<div class="nc-po-ped-meio"><p class="nc-po-ped-o">' + fraseDe(R.tipo, v) + plantao + '</p><p class="nc-po-ped-meta">' + meta + '</p>' + canc + com + '</div>' +
        '<span class="nc-po-ped-sit">' + esc(sit || 'Sem situação') + '</span>' +
        (x.link ? '<button type="button" class="nc-po-mini nc-po-ped-abrir" data-ped-abrir="' + i + '" aria-label="Abrir o pedido ' + esc(v['requisição'] || '') + '">' + svg(IC.abrir) + '<span>Abrir</span></button>' : '') +
        '</article>';
    }).join('') || '<p class="nc-po-nada">Nenhum pedido nesta situação.</p>');
  }
  function atualizarPedidos() {
    if (!ABAS) return;
    ABAS.regs.forEach(function (r) { if (r.__ped) desenharPedidos(r); });
  }

  /* ═══ [J10] RÓTULOS DA BARRA DA GRADE ══════════════════════════════════════════════════════
     O QUE FAZ  Troca os textos abreviados dos botões da grade ("Req. HE" → "Pedir hora extra")
                e os rótulos das listas P203_OPCAO ("Marcações") e P203_DIVERGENTE ("Dias").
     PODE MEXER em cada par  [/texto do APEX/, 'texto novo']  troque só o texto novo.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function rotulosBarra() {
    var mapa = [[/^adic\.?\s*data$/i, 'Incluir data'], [/^req\.?\s*he$/i, 'Pedir hora extra'], [/^req\.?\s*atestado$/i, 'Lançar atestado']];
    [].forEach.call(REG.querySelectorAll('.a-IRR-toolbar .t-Button .t-Button-label, .a-IRR-buttons .t-Button .t-Button-label'), function (l) {
      var t = texto(l); mapa.forEach(function (m) { if (m[0].test(t)) l.textContent = m[1]; });
    });
    [['OPCAO', 'Marcações'], ['DIVERGENTE', 'Dias']].forEach(function (x) {
      var l = document.getElementById(P + x[0] + '_LABEL');
      if (l && !l.getAttribute('data-nc-po')) { var tn = [].filter.call(l.childNodes, function (n) { return n.nodeType === 3 && n.textContent.trim(); })[0]; if (tn) { tn.textContent = x[1] + ' '; l.setAttribute('data-nc-po', '1'); } }
    });
  }

  /* ═══ [J12] A MESA DE TRABALHO: A LISTA E O DIA LADO A LADO ═══════════════════════════════
     O QUE FAZ  No computador (tela com mais de 1100 px de largura e 600 de altura), a lista dos
                dias (à esquerda) e o painel do dia (à direita) viram duas "janelas" da altura da
                tela, como num programa de e-mail: cada uma rola sozinha. A regra da rolagem:
                  1. a página leva até a mesa e ENCAIXA (girar a roda do mouse sobre a mesa
                     primeiro encaixa a mesa no alto, depois rola a coluna);
                  2. encaixada, cada coluna rola sozinha;
                  3. no fim de uma coluna, a página continua (para os pedidos lá embaixo).
                Escolher um dia ("Ver horas" ou as setas) recarrega a página — é o APEX que faz
                isso (ação "Data - Refresh") —, e ao voltar a mesa encaixa e a lista fica
                EXATAMENTE onde estava.
                À direita, duas abas: "o dia" (as horas do dia e os PEDIDOS DAQUELE DIA) e
                "Resumo do período" (o resumo e o SALDO DO BANCO DE HORAS, como uma conta).
                Cada linha da lista diz quantos pedidos aquele dia tem.
     ONDE MUDA  O tamanho mínimo da tela está no CSS (Natcorp_Ponto.css › [C12], o @media).
                Em telas menores, nada disso liga: a página rola inteira, como antes.
     LÊ DOS ITENS  P203_DATA (o dia aberto), P203_SALDO_BH_ANTERIOR, _PERIODO, _REMANESCENTE e
                P203_SALDO_ATUAL (o saldo), e os relatórios "Requisições de …" (os pedidos).
     PODE MEXER os textos: 'Resumo do período', 'Pedidos deste dia', 'Saldo anterior',
                'Do período', 'Saldo atual', 'Saldo remanescente'.
     VISUAL     Natcorp_Ponto.css › [C12]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MESA = null, LADO = lembrar('lado') || 'dia', PED_DIA = {}, SALDO = null;
  /* a mesa está ligada quando o CSS deu rolagem própria à lista (depende do tamanho da tela) */
  function emMesa() { return !!MESA && /auto|scroll/.test(getComputedStyle(REG).overflowY); }
  function alturaEncaixe() { return alturaFixa() + 12; }
  function irParaMesa(suave) {
    if (!MESA) return;
    window.scrollTo({ top: MESA.row.getBoundingClientRect().top + window.pageYOffset - alturaEncaixe(), behavior: suave ? 'smooth' : 'auto' });
  }
  function guardarLista() { if (emMesa()) guardar('lista-topo', String(Math.round(REG.scrollTop))); }
  function montarMesa() {
    var lado = document.getElementById('rgnSticky');
    var row = lado && lado.closest('.row');
    if (!row || !row.contains(REG)) return;
    row.classList.add('nc-po-mesa');
    MESA = { row: row, lado: lado };
    document.body.classList.add('nc-po-mesa-on');
    montarAbasLado();
    montarSaldo();
    /* 1. a página primeiro: enquanto a mesa não está encaixada no alto, a roda do mouse
       sobre ela move a PÁGINA (até encaixar), não a coluna */
    [REG, lado].forEach(function (col) {
      col.addEventListener('wheel', function (e) {
        if (!emMesa() || e.ctrlKey || !e.deltaY) return;
        var falta = MESA.row.getBoundingClientRect().top - alturaEncaixe();
        if (Math.abs(falta) <= 1 || (e.deltaY > 0) !== (falta > 0)) return;
        /* a página já chegou ao fim (ou ao começo) e não tem como encaixar: a coluna rola */
        var sh = document.documentElement.scrollHeight;
        if (e.deltaY > 0 ? window.pageYOffset + window.innerHeight >= sh - 1 : window.pageYOffset <= 0) return;
        e.preventDefault();
        var passo = e.deltaMode === 1 ? e.deltaY * 16 : e.deltaY;
        window.scrollBy(0, falta > 0 ? Math.min(passo, falta) : Math.max(passo, falta));
      }, { passive: false });
    });
  }

  /* ---------- as abas da direita: o dia | o resumo do período ---------- */
  function montarAbasLado() {
    var per = document.querySelector('.nc-po-per'), dia = DIARIO && DIARIO.reg;
    if (!per || !dia || !MESA.lado.contains(per) || !MESA.lado.contains(dia)) return;
    var corpo = MESA.lado.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || MESA.lado;
    var bar = el('div', 'nc-po-lado-abas');
    bar.setAttribute('role', 'tablist');
    bar.setAttribute('aria-label', 'O que ver ao lado');
    bar.innerHTML = '<button type="button" role="tab" class="nc-po-lado-aba" data-lado="dia"></button>' +
      '<button type="button" role="tab" class="nc-po-lado-aba" data-lado="resumo">' + svg(IC.calc) + '<span>Resumo do período</span></button>';
    corpo.insertBefore(bar, corpo.firstChild);
    bar.addEventListener('click', function (e) { var b = e.target.closest('[data-lado]'); if (b) abrirLado(b.getAttribute('data-lado')); });
    dia.setAttribute('data-lado-p', 'dia');
    per.setAttribute('data-lado-p', 'resumo');
    MESA.abas = bar;
    MESA.lado.classList.add('nc-po-com-abas');
  }
  function abrirLado(q) {
    LADO = q; guardar('lado', q);
    atualizarAbasLado();
    if (MESA) MESA.lado.scrollTop = 0;
  }
  function atualizarAbasLado() {
    if (!MESA || !MESA.abas) return;
    var p = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(dataAtual());
    var rot = p ? DIAS_SEM[new Date(+p[3], +p[2] - 1, +p[1]).getDay()] + ', ' + p[1] + '/' + p[2] : 'Este dia';
    html(MESA.abas.querySelector('[data-lado="dia"]'), svg(IC.relogio) + '<span>' + esc(rot) + '</span>');
    [].forEach.call(MESA.abas.querySelectorAll('[data-lado]'), function (b) {
      var on = b.getAttribute('data-lado') === LADO;
      classe(b, 'is-on', on); b.setAttribute('aria-selected', String(on));
    });
    [].forEach.call(MESA.lado.querySelectorAll('[data-lado-p]'), function (r) { classe(r, 'nc-po-lado-fora', r.getAttribute('data-lado-p') !== LADO); });
  }

  /* ---------- os pedidos de cada dia (na linha e no painel do dia) ---------- */
  function pedidosDe(data) {
    var out = [];
    if (!ABAS) return out;
    ABAS.regs.forEach(function (r) {
      if (!r.__ped) return;
      lerPedidos(r).forEach(function (x) {
        if ((x.v['data ponto'] || '') !== data && data) return;
        x.tipo = r.__ped.tipo; x.st = situacaoDe(x.v['situação'] || x.v.situacao || '');
        out.push(x);
      });
    });
    return out;
  }
  /* A janela "Marcação - Abono" (p714) pergunta como foi um dia, para mostrar as batidas dele numa
     linha do tempo (Natcorp_Abono.js › [J3]). Só leitura: devolve o que a lista já leu da grade. */
  window.ncPontoDia = function (data) {
    var d = DIAS.filter(function (x) { return x.data === data; })[0];
    return d ? { sit: d.sit, marcas: d.marcas.map(function (m) { return { hora: m.hora, st: m.st, abono: m.abono }; }) } : null;
  };
  function mapaPedidosDia() {
    var m = {};
    pedidosDe('').forEach(function (x) { var d = x.v['data ponto']; if (d) m[d] = (m[d] || 0) + 1; });
    return m;
  }
  /* PODE MEXER: o nome de cada tipo de pedido no painel do dia */
  var NOME_PED = { abono: 'Abono', he: 'Hora extra', apuracao: 'Apuração' };
  function atualizarPedidosDia() {
    if (!DIARIO || !ABAS) return;
    if (!DIARIO.peds) {
      DIARIO.peds = el('div', 'nc-po-dped');
      DIARIO.pe.parentNode.insertBefore(DIARIO.peds, DIARIO.pe);
      DIARIO.peds.addEventListener('click', function (e) {
        var b = e.target.closest('[data-dped]'); if (!b) return;
        var x = (DIARIO.pedItens || [])[+b.getAttribute('data-dped')];
        if (x && x.link) x.link.click();
      });
    }
    var itens = DIARIO.pedItens = pedidosDe(dataAtual());
    html(DIARIO.peds, !itens.length ? '' : '<p class="nc-po-eventos-tit">Pedidos deste dia</p>' + itens.map(function (x, i) {
      var sit = x.v['situação'] || x.v.situacao || '';
      return '<div class="nc-po-dped-i is-' + x.st + '"><div class="nc-po-dped-txt"><small>' + esc(NOME_PED[x.tipo] || 'Pedido') +
        (vazio(x.v['requisição'] || x.v.requisicao) ? '' : ' · nº ' + esc(x.v['requisição'] || x.v.requisicao)) + '</small><p>' + fraseDe(x.tipo, x.v) + '</p></div>' +
        '<span class="nc-po-ped-sit">' + esc(sit || 'Sem situação') + '</span>' +
        (x.link ? '<button type="button" class="nc-po-mini" data-dped="' + i + '" aria-label="Abrir o pedido">' + svg(IC.abrir) + '<span>Abrir</span></button>' : '') + '</div>';
    }).join(''));
  }

  /* ---------- o saldo do banco de horas, como uma conta ----------
     A região "Saldo de Banco de Horas" (nova em 02/10) vai para a aba "Resumo do período". Os
     quatro campos continuam na página (as ações dinâmicas preenchem os quatro); o desenho mostra
     "Saldo anterior + Do período = Saldo atual" — a conta só aparece com os sinais quando fecha
     (anterior + período = atual); senão, os três lado a lado. O remanescente vem embaixo. */
  function montarSaldo() {
    var reg = regiaoPorTitulo(/saldo de banco de horas/i), per = document.querySelector('.nc-po-per');
    if (!reg) return;
    reg.classList.add('nc-po-saldo');
    if (per && MESA.abas) {
      var rowS = reg.closest('.row');
      per.parentNode.insertBefore(reg, per.nextSibling);
      reg.setAttribute('data-lado-p', 'resumo');
      if (rowS) esvaziou(rowS);
    }
    var t = reg.querySelector(':scope > .t-Region-header .t-Region-title'); if (t) t.textContent = 'Banco de horas';
    var bt = reg.querySelector(':scope > .t-Region-header .t-Button');
    if (bt) { bt.setAttribute('title', 'Atualizar os saldos'); bt.setAttribute('aria-label', 'Atualizar os saldos'); }
    var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
    var w = el('div', 'nc-po-sd-box');
    corpo.appendChild(w);
    ['SALDO_BH_ANTERIOR', 'SALDO_BH_PERIODO', 'SALDO_ATUAL', 'SALDO_BH_REMANESCENTE'].forEach(function (n) {
      var c = document.getElementById(P + n + '_CONTAINER');
      if (c) { c.classList.add('nc-po-recolhida'); var row = c.closest('.row'); if (row) setTimeout(function () { esvaziou(row); }, 0); }
    });
    SALDO = { reg: reg, w: w };
    atualizarSaldo();
  }
  function minutos(t) { var m = /^\s*(-?)(\d+):(\d{2})\s*$/.exec(t || ''); return m ? (m[1] ? -1 : 1) * (+m[2] * 60 + +m[3]) : null; }
  function atualizarSaldo() {
    if (!SALDO) return;
    function v(n) { var e = document.getElementById(P + n); return e ? String(e.value || '').trim() : ''; }
    var ant = v('SALDO_BH_ANTERIOR'), per = v('SALDO_BH_PERIODO'), atu = v('SALDO_ATUAL'), rem = v('SALDO_BH_REMANESCENTE');
    var a = minutos(ant), p = minutos(per), t = minutos(atu);
    var conta = a !== null && p !== null && t !== null && a + p === t;
    function cel(rot, val, cls) { var n = minutos(val); return '<div class="nc-po-sd ' + (cls || '') + (n !== null && n < 0 ? ' is-neg' : '') + '"><span>' + rot + '</span><b>' + esc(val || '—') + '</b></div>'; }
    html(SALDO.w, (ant || per || atu) ? '<div class="nc-po-sd-conta' + (conta ? ' is-conta' : '') + '">' +
      cel('Saldo anterior', ant) + (conta ? '<i aria-hidden="true">+</i>' : '') +
      cel('Do período', per) + (conta ? '<i aria-hidden="true">=</i>' : '') +
      cel('Saldo atual', atu, 'is-total') + '</div>' +
      (rem ? '<p class="nc-po-sd-rem">Saldo remanescente: <b>' + esc(rem) + '</b></p>' : '')
      : '<p class="nc-po-nada">Escolha as datas para ver o saldo.</p>');
  }

  /* ═══ [J14] AJUSTAR EM SEQUÊNCIA ══════════════════════════════════════════════════════════
     O QUE FAZ  O gestor faz centenas de ajustes: "Ajustar em sequência" abre a janela de ajuste
                (Marcação - Abono, 9503:714) na primeira posição com problema/conferir e, a cada
                "Enviar pedido", abre sozinha a próxima, em ordem de data e de posição. A janela
                mostra "Ajuste em sequência · 4 de 23" com "Pular este" e "Parar" e SUGERE o
                motivo e a observação do ajuste anterior (um toque confirma; nada vem escolhido).
                Cada ajuste é um pedido normal: passa por todas as validações da janela.
     COMO       O estado da fila fica na memória da aba (sessionStorage "nc-po-fila"), que a janela
                também lê e escreve (mesma origem). O recado do envio: a janela anota
                acao = 'enviando' ao tocar em "Enviar pedido"; se a página volta com erro, ela
                apaga o recado. Quando a janela FECHA:
                  'enviando' (sucesso) → a posição conta como feita e abre a próxima;
                  'pular'              → conta como pulada e abre a próxima;
                  'parar'              → a fila acaba;
                  nada (✕ ou Voltar)   → a fila PAUSA ("Continuar" / "Parar" na lista).
                As posições feitas ou puladas não voltam para a fila (mesmo que a grade ainda as
                mostre em vermelho enquanto o pedido espera aprovação).
     PODE MEXER os textos da barra ('Ajustando em sequência', 'Continuar', 'Parar'…).
     VISUAL     Natcorp_Ponto.css › [C14]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FILA_K = 'nc-po-fila';
  function filaLer() { try { return JSON.parse(sessionStorage.getItem(FILA_K) || 'null'); } catch (e) { return null; } }
  function filaGravar(f) { try { if (f) sessionStorage.setItem(FILA_K, JSON.stringify(f)); else sessionStorage.removeItem(FILA_K); } catch (e) { /* sem memória */ } }
  /* as posições ainda por ajustar, em ordem: dias com problema/conferir, posições vermelhas/amarelas */
  function filaPendentes(f) {
    var feitos = (f && f.feitos) || [], pul = (f && f.pulados) || [], out = [];
    DIAS.forEach(function (d) {
      if (d.sit !== 'problema' && d.sit !== 'conferir') return;
      d.marcas.forEach(function (m, k) {
        var c = d.data + '#' + k;
        if ((m.st === 'danger' || m.st === 'warning') && m.a && feitos.indexOf(c) < 0 && pul.indexOf(c) < 0) out.push({ d: d, k: k, c: c });
      });
    });
    return out;
  }
  function filaComecar() {
    filaGravar({ ativo: true, feitos: [], pulados: [], motivo: '', comentario: '' });
    filaProximo();
  }
  function filaProximo() {
    var f = filaLer(); if (!f || !f.ativo) return;
    var p = filaPendentes(f);
    if (!p.length) { f.ativo = false; f.fim = true; f.atual = null; filaGravar(f); desenharFila(); return; }
    var x = p[0];
    f.atual = x.c; f.acao = null; f.pausada = false;
    f.total = f.feitos.length + f.pulados.length + p.length; f.n = f.feitos.length + f.pulados.length + 1;
    filaGravar(f);
    desenharFila();
    var linha = BOX.querySelector('.nc-po-dia[data-i="' + DIAS.indexOf(x.d) + '"]');
    if (linha) rolarAte(linha, true);
    x.d.marcas[x.k].a.click();
  }
  /* depois de um envio a grade é atualizada: espera ela voltar (ou 2,5 s) antes de abrir a próxima */
  function filaEsperarGrade(fn) {
    var feito = false;
    var vai = function () { if (feito) return; feito = true; setTimeout(function () { try { desenhar(); } catch (e) { /* segue */ } fn(); }, 150); };
    $(REG).one('apexafterrefresh', vai);
    setTimeout(vai, 2500);
  }
  function filaAoFecharJanela() {
    setTimeout(function () {
      var f = filaLer(); if (!f || !f.ativo || !f.atual) return;
      var acao = f.acao; f.acao = null;
      if (acao === 'parar') { filaGravar(null); desenharFila(); return; }
      if (acao === 'enviando') f.feitos.push(f.atual);
      else if (acao === 'pular') f.pulados.push(f.atual);
      else { f.pausada = true; f.atual = null; filaGravar(f); desenharFila(); return; }
      f.atual = null; filaGravar(f); desenharFila();
      if (acao === 'enviando') filaEsperarGrade(filaProximo); else filaProximo();
    }, 350);
  }
  /* a janela pode nascer nesta página (aberta sozinha) ou na de cima (dentro do Painel): escuta as duas */
  function filaEscutar() {
    var ws = [window];
    try { if (window.top !== window && window.top.apex && window.top.apex.jQuery) ws.push(window.top); } catch (e) { /* outra origem */ }
    ws.forEach(function (w) { w.apex.jQuery(w.document).on('dialogclose', function (e) { if ($(e.target).is('.ui-dialog-content, .ui-dialog') || e.target.closest) filaAoFecharJanela(); }); });
  }
  function desenharFila() {
    if (!BOX) return;
    var f = filaLer(), bt = BOX.querySelector('.nc-po-seq'), bar = BOX.querySelector('.nc-po-fila');
    var pend = filaPendentes(f && !f.fim ? f : null).length;
    bt.hidden = !pend || !!(f && (f.ativo || f.pausada));
    html(bt.querySelector('span'), 'Ajustar em sequência <b>' + pend + '</b>');
    if (!f) { bar.hidden = true; return; }
    bar.hidden = false;
    var feitos = f.feitos.length, pul = f.pulados.length;
    classe(bar, 'is-pausada', !!f.pausada);
    classe(bar, 'is-fim', !!f.fim);
    html(bar, f.fim ? svg(IC.ok) + '<span><b>Sequência concluída:</b> ' + feitos + (feitos === 1 ? ' ajuste enviado' : ' ajustes enviados') + (pul ? ', ' + pul + (pul === 1 ? ' pulado' : ' pulados') : '') + '.</span><button type="button" class="nc-po-link" data-fila="fechar">Fechar</button>'
      : f.pausada ? svg(IC.relogio) + '<span><b>Sequência pausada</b> · ' + feitos + (feitos === 1 ? ' enviado' : ' enviados') + (pend === 1 ? ', falta 1' : ', faltam ' + pend) + '.</span><button type="button" class="nc-po-mini" data-fila="continuar">' + svg(IC.play) + '<span>Continuar</span></button><button type="button" class="nc-po-link" data-fila="parar">Parar</button>'
      : svg(IC.play) + '<span><b>Ajustando em sequência</b> · ' + (f.n || feitos + pul + 1) + ' de ' + (f.total || feitos + pul + pend) + '</span><button type="button" class="nc-po-link" data-fila="parar">Parar</button>');
  }

  /* ═══ [J11] O MAESTRO: QUANDO CADA PARTE É MONTADA ═════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a página abre: monta a barra e a lista ([J3],
                [J4]), marca a página com nc-po-ativo (liga o CSS da lista) e monta o painel
                ([J6] a [J10]), que marca nc-po-painel. Depois, redesenha quando a grade é
                atualizada (ao fechar a janela de ajuste) e quando a página mostra, esconde ou
                desativa um botão usado por procuração. Depois do "Ver horas" a página recarrega:
                ao voltar, rola até a linha daquele dia.
     CUIDADO    Cada parte do painel roda protegida: se uma falhar, as outras continuam.
     SE DER ERRO  Aparece no Console (F12 › Console) como [Natcorp ponto] ou
                [Natcorp ponto · parte] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* o cabeçalho do APEX é fixo: o que "gruda" fica logo abaixo dele */
  function medirTopo() {
    var h = Math.round(alturaFixa());
    if (document.body.__ncTopo !== h) { document.body.__ncTopo = h; document.body.style.setProperty('--nc-po-topo', h + 'px'); }
  }
  function montarPainel() {
    medirTopo();
    window.addEventListener('resize', medirTopo);
    try { montarTopo(); } catch (e) { if (window.console) console.warn('[Natcorp ponto · topo]', e); }
    try { montarPassos(); } catch (e) { if (window.console) console.warn('[Natcorp ponto · passos]', e); }
    try { montarDireita(); } catch (e) { if (window.console) console.warn('[Natcorp ponto · direita]', e); }
    try { montarAbas(); } catch (e) { if (window.console) console.warn('[Natcorp ponto · pedidos]', e); }
    try { rotulosBarra(); } catch (e) {}
    try { montarMesa(); } catch (e) { if (window.console) console.warn('[Natcorp ponto · mesa]', e); }
    document.body.classList.add('nc-po-painel');
  }
  function atualizarPainel(n) {
    atualizarTopo();
    atualizarPassos(n || {});
    atualizarResumo();
    try { atualizarDiario(); } catch (e) { if (window.console) console.warn('[Natcorp ponto · dia]', e); }
    atualizarAbas();
    try { atualizarPedidos(); } catch (e) { if (window.console) console.warn('[Natcorp ponto · pedidos]', e); }
    try { atualizarPedidosDia(); atualizarAbasLado(); atualizarSaldo(); } catch (e) { if (window.console) console.warn('[Natcorp ponto · mesa]', e); }
    sincronizar();
  }

  var agendado = false;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () {
      agendado = false;
      try { desenhar(); } catch (e) { if (window.console) console.warn('[Natcorp ponto]', e); }
    });
  }
  function iniciar() {
    montar();
    document.body.classList.add('nc-po-ativo');
    montarPainel();
    desenhar();
    /* as ações da página mostram/escondem/apagam os botões que o desenho usa por procuração */
    if (window.MutationObserver) {
      var alvos = PROX.map(function (x) { return x.o; }).filter(Boolean);
      var mo = new MutationObserver(function () { sincronizar(); });
      alvos.forEach(function (o) { var r = o.isConnected && (o.closest('.t-Region') || o.parentElement); if (r && r.nodeType === 1) mo.observe(r, { attributes: true, subtree: true, attributeFilter: ['style', 'disabled'] }); });
    }
    $(document).on('apexafterrefresh', function () { setTimeout(agendar, 60); });
    filaEscutar();
    var fl = filaLer(); if (fl && fl.ativo && !fl.atual) { fl.pausada = true; filaGravar(fl); }
    if (fl && fl.ativo && fl.atual) { fl.pausada = true; fl.atual = null; filaGravar(fl); }
    desenharFila();
    /* a grade é atualizada pela página ao fechar a janela de ajuste (refresh da região) */
    $(REG).on('apexafterrefresh', function () { setTimeout(agendar, 30); });
    /* o clone do cabeçalho nasce ao rolar a página */
    var marcando = false;
    window.addEventListener('scroll', function () { if (marcando) return; marcando = true; requestAnimationFrame(function () { marcando = false; marcarCabecalho(); }); }, { passive: true });
    $(document).on('apexafterrefresh', function (e) { if (e.target === REG || REG.contains(e.target)) setTimeout(agendar, 30); });
    /* depois do "Horas do dia" a página recarrega: volta ao cartão daquele dia */
    var r = lembrar('rolar');
    if (r) {
      guardar('rolar', '');
      setTimeout(function () {
        var d = DIAS.map(function (x, i) { return x.data === r ? i : -1; }).filter(function (i) { return i >= 0; })[0];
        var c = d !== undefined && BOX.querySelector('.nc-po-dia[data-i="' + d + '"]');
        if (emMesa()) {
          irParaMesa(false);
          var topo = parseInt(lembrar('lista-topo'), 10);
          if (!isNaN(topo)) REG.scrollTop = topo;
          guardar('lista-topo', '');
          /* o dia escolhido pelas setas pode estar fora da parte à vista: aí ele vem ao meio */
          if (c) { var rc = c.getBoundingClientRect(), rr = REG.getBoundingClientRect(), cab = BOX.querySelector('.nc-po-cab');
            if (rc.top < rr.top + (cab ? cab.offsetHeight : 0) || rc.bottom > rr.bottom) rolarAte(c, false); }
        } else if (c) { c.scrollIntoView({ block: 'nearest' }); rolarAte(c, false); }
      }, 300);
    }
    /* o saldo do banco de horas volta do servidor (ação dinâmica) sem redesenhar a página */
    $(document).on('change', '[id^="' + P + 'SALDO"]', function () { setTimeout(atualizarSaldo, 30); });
    $(document).ajaxComplete(function () { setTimeout(atualizarSaldo, 60); });
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
