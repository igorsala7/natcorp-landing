/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · MARCAÇÃO - ABONO  —  o "arrumador" da tela (JavaScript)                        ║
   ║  App 9503 (FREQ_LANC_NATCORP) · Página 714 · a janela do ajuste de UMA marcação de ponto  ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   É a janela que abre no toque de um horário da Tratativa de Abono (página 203). O gestor pede
   o ajuste de UMA marcação de ponto do colaborador: corrigir o horário, apagar, mover para
   outra posição ou incluir a que faltou. Reclamação de quem usa: "confuso e difícil". A janela
   tinha 13 campos técnicos lado a lado (Posição "3", "Apagar Marcação Realizada ?", "Enviar
   p/Qual Posição a Marcação Realizada ?", relógio de ponteiros, justificativas com
   "| Evento Apurado: 3 (Ponto) | Evento Abonado: 12").
   Este arquivo transforma isso numa conversa, numa coluna só:
     • QUAL MARCAÇÃO — o dia por extenso, a marcação em palavras ("2ª entrada", não
       "Posição 3") e o que o relógio registrou ("Previsto 09:00 · Bateu 09:00" ou "Não bateu");
     • O QUE ACONTECEU — cartões: "O horário está errado" (corrigir), "Essa marcação não devia
       existir" (apagar), "Bateu no lugar errado" (mover). Sem marcação, a pergunta não
       aparece: é incluir;
     • QUAL O HORÁRIO CERTO — o seletor de hora do aparelho (o do despertador), com "Usar o
       previsto"; para mover, as posições em botões;
     • POR QUÊ — as justificativas em botões ("7 - Atestado Médico"), começos de frase para o
       comentário e o comprovante "se tiver";
     • no pé, a frase do que vai ser pedido, o que falta e "Enviar pedido" (é o Criar).
   Num pedido já feito (P714_COD_REQ preenchido): um resumo em frase no alto, com a situação.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não grava nada: o APEX continua dono de tudo. Os campos substituídos CONTINUAM na página
       (escondidos, dentro das mesmas regiões — as ações que desabilitam as regiões MARC e JUST
       continuam valendo, e os botões do desenho ficam desabilitados junto).
     • Cada escolha só usa apex.item().setValue, que dispara as ações dinâmicas da página como
       se a pessoa tivesse digitado.
     • A ordem das ações é a da página: "Enviar p/ outra posição" só se habilita com "Apagar"
       marcado (veja [J6]).
     • Se este arquivo for retirado da página, a janela volta ao visual padrão do APEX e
       continua funcionando normalmente.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 714 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Abono.js
     ATENÇÃO: esta página não tem exportação no projeto — a URL é posta À MÃO no Page Designer
     (e a do CSS também: #WORKSPACE_IMAGES#Natcorp_Abono.css).
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Abono.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Esta página NÃO usa classes no APEX. O arquivo reconhece a janela pelos itens
   …_HORA_BATIDA_ABONO + …_POSICAO + …_COD_JUSTIFICATIVA (sem eles, não faz nada) e usa:
     • as regiões com Static ID  MARC  (a marcação) e  JUST  (a justificativa) — sem esses IDs,
       ele procura a região onde estão os itens POSICAO e COD_JUSTIFICATIVA;
     • os itens pelo nome: DATA, POSICAO, JORNADA, HORA_BATIDA, PLANTAO, VIRA_DIA(_DSP),
       APAGAR_MARCACAO, ENVIAR_MARCACAO, POSICAO_ENV, HORA_BATIDA_ABONO, COD_JUSTIFICATIVA,
       COMENTARIOS, ARQUIVO_JUST, NUM_DIAS_JUST, DT_INI_VAL_JUST, DT_FIM_VAL_JUST;
       e, no pedido já feito, COD_REQ, COD_SIT_REQ, SOLICITANTE, DT_REQ;
     • os botões "Criar" e "Mapa" pelo texto.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Dias, meses e ícones ................ como a data aparece escrita          PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  A montagem .......................... as perguntas e os 3 cartões          PODE MEXER
     [J4]  O motivo ............................ motivos em botões, começos de frase  PODE MEXER
     [J5]  O pé ................................ a frase do pedido e "Enviar pedido"
     [J6]  Escolher o que fazer ................ a ordem das ações da página          CUIDADO
     [J7]  O relógio do aparelho ............... troca o relógio de ponteiros         CUIDADO
     [J8]  O desenho ........................... redesenha tudo a cada mudança        PODE MEXER
     [J9]  O pedido já feito ................... o resumo em frase e a situação       PODE MEXER
     [J10] O maestro ........................... decide QUANDO redesenhar             CUIDADO
     [J11] A linha do tempo do dia e a sugestão  as batidas com horário, "Levar 18:01…" PODE MEXER
     [J12] Um passo por vez no celular ......... 4 passos, Voltar/Continuar embaixo   PODE MEXER
     [J13] A aba Aprovadores ................. o caminho da aprovação, de cima para baixo CUIDADO
     [J15] Ajuste em sequência (a janela) ..... "4 de 23", Pular, Parar, motivo sugerido  PODE MEXER

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'O horário está errado'  →  'O horário saiu errado'
     Quero mudar os começos de frase do comentário   → [J4], lista COMECOS
     Quero mudar o nome de um campo (ex.: "Vale até") → [J4], as linhas rotulo('ITEM', '…')
     Um motivo novo apareceu na lista
       → nada a fazer: os botões vêm da lista "Justificativa" do APEX, sozinhos. O que vem
         depois de "|" no nome da opção não aparece no botão (fica só ao parar o mouse).
     Quero mudar a cor de uma situação no pedido já feito → [J9], lista SITU
     A janela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp abono].
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
     P + 'POSICAO'        junta os textos: vira 'P714_POSICAO', o nome do item no APEX.
                            (Aqui o P é descoberto sozinho: veja o começo do código.)
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: esta linha impede que o arquivo rode duas vezes (se a URL estiver repetida na
     página, por exemplo) e que rode fora do APEX. Não apague. */
  if (window.__ncAbono || !window.apex || !window.apex.jQuery) return;
  /* O começo do nome dos itens (P) é DESCOBERTO sozinho, a partir do item …_HORA_BATIDA_ABONO:
     se a página for copiada para outro número, não é preciso mudar nada aqui. Sem esse item,
     o …_POSICAO e o …_COD_JUSTIFICATIVA, o arquivo entende que não está na página certa e para. */
  var ach = document.querySelector('[id$="_HORA_BATIDA_ABONO_CONTAINER"]');
  if (!ach) return;
  var P = ach.id.replace(/HORA_BATIDA_ABONO_CONTAINER$/, '');
  if (!document.getElementById(P + 'POSICAO') || !document.getElementById(P + 'COD_JUSTIFICATIVA')) return;
  window.__ncAbono = true;

  var $ = apex.jQuery;
  /* ═══ [J1] DIAS, MESES E ÍCONES ═══════════════════════════════════════════════════════════
     O QUE É    Como os dias da semana e os meses aparecem escritos ("terça-feira, 4 de março
                de 2025") e os ícones (desenhos pequenos, formato SVG; não precisa mexer).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: os nomes dos dias da semana (começando no domingo) e dos meses */
  var SEM = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'];
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  var IC = {
    cal: '<rect x="3.5" y="5" width="17" height="15.5" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    lixo: '<path d="M4.5 7h15M9.5 7V4.5h5V7M6.5 7l1 13h9l1-13M10 11v5.5M14 11v5.5"/>',
    seta: '<path d="M4 12h15M14 6.5l5.5 5.5-5.5 5.5"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    lupa: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    alerta: '<path d="M12 3.5l9.5 16.5h-19z"/><path d="M12 10v4.5M12 17.2v.1"/>',
    pino: '<path d="M12 21s-6.5-6-6.5-11a6.5 6.5 0 0 1 13 0c0 5-6.5 11-6.5 11z"/><circle cx="12" cy="10" r="2.3"/>',
    lua: '<path d="M20 14.5A8 8 0 1 1 9.5 4a6.5 6.5 0 0 0 10.5 10.5z"/>',
    x: '<path d="M7 7l10 10M17 7L7 17"/>',
    balao: '<path d="M4.5 5.5h15v10h-8l-4.5 3.5v-3.5h-2.5z"/>',
    clipe: '<path d="M16.5 7.5l-7 7a2 2 0 0 0 2.8 2.8l7.4-7.4a4 4 0 0 0-5.7-5.7L6.6 11.6a6 6 0 0 0 8.5 8.5l5.4-5.4"/>',
    esq: '<path d="M14.5 6l-6 6 6 6"/>',
    dir: '<path d="M9.5 6l6 6-6 6"/>',
    ideia: '<path d="M9 18h6M10 21h4M12 3a6 6 0 0 0-3.5 10.9c.6.4 1 1.1 1 1.8V16h5v-.3c0-.7.4-1.4 1-1.8A6 6 0 0 0 12 3z"/>'
  };

  /* ═══ [J2] FERRAMENTAS ════════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('ITEM')       o valor do item (campo, lista, caixa de marcar ou "só exibição")
       marcado('ITEM')   diz se a caixa de marcar está com "S"
       textoOpcao('ITEM') o texto da opção escolhida numa lista
       esconder('ITEM')  esconde o bloco do campo (ele continua na página, funcionando)
       ordinal(3)        "2ª entrada": posição ímpar = entrada, par = saída
       nomeJust(texto)   "7 - Atestado Médico | Evento…" → "7 - Atestado Médico"
       depois(fn)        espera as idas ao servidor que estão a caminho e só então roda fn
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d) { return '<svg class="nc-ab-ic" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function texto(e) { return e ? e.textContent.replace(/\s+/g, ' ').trim() : ''; }
  function item(n) { return document.getElementById(P + n); }
  function cont(n) { return document.getElementById(P + n + '_CONTAINER'); }
  /* valor de um item: campo, lista, caixa de marcar ou "só exibição" */
  function val(n) {
    var e = item(n); if (!e) return '';
    if (e.tagName === 'SPAN' || e.tagName === 'DIV') return texto(e);
    if (e.tagName === 'FIELDSET' || e.classList.contains('checkbox_group')) return apex.item(e.id).getValue() || '';
    return String(e.value || '').trim();
  }
  function marcado(n) { var v = apex.item(P + n).getValue(); return Array.isArray(v) ? v.indexOf('S') >= 0 : v === 'S'; }
  function textoOpcao(n) { var s = item(n); return s && s.options && s.selectedIndex >= 0 && s.value ? s.options[s.selectedIndex].text : ''; }
  function esconder(n) { var c = cont(n); if (c) c.classList.add('nc-ab-oculto'); }
  /* As marcações do dia são chamadas pela POSIÇÃO (1, 2, 3, 4…), como a empresa fala — não por
     "entrada/saída". ordinal() é usada no meio das frases ("Corrigir a posição 2"); posicao(), nos
     rótulos dos botões ("Posição 2"). PODE MEXER: a palavra 'posição'. */
  function ordinal(n) { n = parseInt(n, 10); return n ? 'posição ' + n : ''; }
  function posicao(n) { n = parseInt(n, 10); return n ? 'Posição ' + n : ''; }
  function dataDe(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function porExtenso(d) { return SEM[d.getDay()] + ', ' + d.getDate() + ' de ' + MESES[d.getMonth()] + ' de ' + d.getFullYear(); }
  function hora(t) { var m = /(\d{1,2}):(\d{2})/.exec(t || ''); return m ? (m[1].length < 2 ? '0' : '') + m[1] + ':' + m[2] : ''; }
  /* "7 - Atestado Médico | Evento Apurado: 3 (Ponto) | Evento Abonado: 17 (Ponto)" → "7 - Atestado Médico" */
  function nomeJust(t) { return String(t || '').split('|')[0].replace(/\s+/g, ' ').trim().replace(/(\s)(De|Da|Do|Das|Dos|E|Em|No|Na|Para|Por|Ou)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); }); }
  /* espera as ações da página que estão a caminho (cada setValue pode disparar uma ida ao servidor) */
  function depois(fn) { if ($.active) $(document).one('ajaxStop', function () { setTimeout(fn, 0); }); else fn(); }

  var CONSULTA = !!val('COD_REQ');
  var ACAO = null; /* corrigir | apagar | mover | incluir */
  var B = {};

  /* ═══ [J3] A MONTAGEM: AS PERGUNTAS DA JANELA ═════════════════════════════════════════════
     O QUE FAZ  montar() roda uma vez, quando a janela abre:
                  • renomeia as regiões ("A marcação", "Por quê?" / "O motivo");
                  • põe no alto o dia por extenso com "Mudar o dia" (abre o campo Data da página)
                    e "Qual marcação?" em botões;
                  • esconde os campos técnicos (Posição, Jornada, Apagar, Enviar…) — eles
                    continuam na página, funcionando;
                  • cria os cartões "O que aconteceu?", o bloco do horário, o de mover e o de
                    apagar; chama o motivo ([J4]) e o pé ([J5]).
                Num pedido já feito, monta só o resumo ([J9]).
     PODE MEXER os textos dos 3 cartões — nas linhas cartao('id', 'ícone', 'Título', 'Frase'),
                troque só os dois últimos textos. Não troque o 'id' (corrigir, apagar, mover).
     VISUAL     Natcorp_Abono.css › [C3] (cabeçalho) e [C4] (perguntas e cartões)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montar() {
    document.body.classList.add('nc-ab-ativo');
    classe(document.body, 'nc-ab-consulta', CONSULTA);
    var marc = document.getElementById('MARC') || (cont('POSICAO') && cont('POSICAO').closest('.t-Region'));
    var just = document.getElementById('JUST') || (cont('COD_JUSTIFICATIVA') && cont('COD_JUSTIFICATIVA').closest('.t-Region'));
    if (!marc || !just) return false;
    B.marc = marc; B.just = just;
    marc.classList.add('nc-ab-reg'); just.classList.add('nc-ab-reg');
    titulo(marc, 'A marcação');
    titulo(just, CONSULTA ? 'O motivo' : 'Por quê?');
    var corpoM = corpo(marc), corpoJ = corpo(just);

    /* o cabeçalho: o dia por extenso e o que o relógio registrou */
    B.cab = el('div', 'nc-ab-cab');
    corpoM.insertBefore(B.cab, corpoM.firstChild);

    var mapa = [].filter.call(document.querySelectorAll('.t-Button'), function (b) { return /^mapa$/i.test(texto(b) || b.title || ''); })[0];
    if (mapa && !mapa.querySelector('.nc-ab-mapa-rot')) { mapa.classList.add('nc-ab-mapa'); mapa.insertAdjacentHTML('beforeend', '<span class="nc-ab-mapa-rot">Ver no mapa</span>'); mapa.title = 'Ver no mapa onde a marcação foi feita'; }
    if (CONSULTA) { montarConsulta(); return true; }

    /* ABERTA PELA LISTA: o dia e a posição já chegam preenchidos (parâmetros do link da grade).
       Então eles só são MOSTRADOS: a linha do tempo não deixa trocar a posição, "Mudar o dia" e o
       "Trocar" somem e, no celular, o passo "Qual posição?" sai (ficam 3 passos). Aberta sem
       eles, a pessoa escolhe o dia e a posição, como antes. Medido uma vez, ao abrir. */
    B.fixo = !!val('DATA') && !!val('POSICAO');
    classe(document.body, 'nc-ab-fixo', B.fixo);
    /* a data da página entra no cabeçalho, atrás de "Mudar o dia" (mudar a data refaz tudo no servidor) */
    B.dia = el('div', 'nc-ab-dia', '<div class="nc-ab-dia-txt"></div><button type="button" class="nc-ab-link" data-mudar-dia>Mudar o dia</button>');
    B.cab.appendChild(B.dia);
    B.dataBox = el('div', 'nc-ab-databox'); B.dataBox.hidden = true;
    B.cab.appendChild(B.dataBox);
    if (cont('DATA')) B.dataBox.appendChild(cont('DATA'));
    if (B.fixo) B.dia.querySelector('[data-mudar-dia]').hidden = true;
    B.dia.querySelector('[data-mudar-dia]').addEventListener('click', function () { B.dataBox.hidden = !B.dataBox.hidden; if (!B.dataBox.hidden) { var d = item('DATA'); if (d) d.focus(); } });

    /* a posição: botões com o nome da marcação (a lista "1 / 3" fica escondida) */
    B.pos = el('div', 'nc-ab-bloco', '<p class="nc-ab-perg nc-ab-perg--passo">Qual posição?</p><p class="nc-ab-sub nc-ab-perg--passo">Toque na posição que você quer arrumar.</p><div class="nc-ab-pos" role="radiogroup" aria-label="Qual posição"></div>');
    B.cab.appendChild(B.pos);
    B.pos.addEventListener('click', function (e) {
      var b = e.target.closest('[data-pos]'); if (!b || b.disabled || B.fixo) return;
      if (val('POSICAO') !== b.getAttribute('data-pos')) { ACAO = null; apex.item(P + 'POSICAO').setValue(b.getAttribute('data-pos')); }
    });
    B.fato = el('div', 'nc-ab-fato');
    B.cab.appendChild(B.fato);
    ['POSICAO', 'JORNADA', 'HORA_BATIDA', 'PLANTAO', 'VIRA_DIA_DSP', 'APAGAR_MARCACAO', 'ENVIAR_MARCACAO', 'POSICAO_ENV'].forEach(esconder);

    /* o que aconteceu: três cartões (só quando há marcação feita) */
    B.acao = el('div', 'nc-ab-bloco nc-ab-acao', '<p class="nc-ab-perg nc-ab-perg--passo">O que aconteceu?</p><div class="nc-ab-cartoes" role="radiogroup" aria-label="O que aconteceu">' +
      cartao('corrigir', 'lapis', 'O horário está errado', 'Corrigir para o horário certo') +
      cartao('apagar', 'lixo', 'Essa marcação não devia existir', 'Apagar esta marcação') +
      cartao('mover', 'seta', 'Bateu na posição errada', 'Levar para outra posição do dia') +
      '</div>');
    corpoM.appendChild(B.acao);
    B.dica = el('div', 'nc-ab-dica'); B.dica.hidden = true;
    B.acao.insertBefore(B.dica, B.acao.querySelector('.nc-ab-cartoes'));
    B.acao.addEventListener('click', function (e) {
      var s = e.target.closest('[data-sugere]');
      if (s) { levarPara(s.getAttribute('data-sugere')); return; }
      var b = e.target.closest('[data-acao]'); if (!b || b.disabled) return;
      if (b.getAttribute('data-acao') === 'mover' && B.sugAlvo && acaoAtual() !== 'mover') { levarPara(B.sugAlvo); return; }
      escolher(b.getAttribute('data-acao'));
    });

    /* o horário certo: o campo da página, com o seletor do aparelho e "Usar o previsto" */
    B.hora = el('div', 'nc-ab-bloco nc-ab-hora', '<p class="nc-ab-perg"></p><div class="nc-ab-hora-linha"></div><div class="nc-ab-hora-atalhos"></div>');
    corpoM.appendChild(B.hora);
    B.hora.querySelector('.nc-ab-hora-linha').appendChild(cont('HORA_BATIDA_ABONO'));
    relogioDoAparelho();
    B.hora.querySelector('.nc-ab-hora-atalhos').addEventListener('click', function (e) { var b = e.target.closest('[data-h]'); if (b) definirHora(b.getAttribute('data-h')); });

    /* mover: as outras posições em botões */
    B.mover = el('div', 'nc-ab-bloco nc-ab-mover', '<p class="nc-ab-perg">Para qual posição ela vai?</p><div class="nc-ab-pos nc-ab-pos--env" role="radiogroup" aria-label="Para qual posição"></div><p class="nc-ab-nota"></p>');
    corpoM.appendChild(B.mover);
    B.mover.addEventListener('click', function (e) {
      if (e.target.closest('[data-env-todos]')) { B.envTodos = true; desenhar(); return; }
      var b = e.target.closest('[data-env]'); if (!b || b.disabled) return;
      apex.item(P + 'POSICAO_ENV').setValue(b.getAttribute('data-env'));
    });

    /* apagar: a confirmação em palavras */
    B.apagar = el('p', 'nc-ab-bloco nc-ab-confirma');
    corpoM.appendChild(B.apagar);

    montarMotivo(corpoJ);
    montarPe();
    montarPassos();
    montarFila();
    return true;
  }
  function titulo(r, t) { var h = r.querySelector(':scope > .t-Region-header .t-Region-title'); if (h) h.textContent = t; }
  function corpo(r) { return r.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || r; }
  function cartao(id, ic, tit, sub) {
    return '<button type="button" class="nc-ab-cartao" role="radio" aria-checked="false" data-acao="' + id + '">' + svg(IC[ic]) +
      '<span><b>' + esc(tit) + '</b><small>' + esc(sub) + '</small></span></button>';
  }

  /* ═══ [J4] O MOTIVO ═══════════════════════════════════════════════════════════════════════
     O QUE FAZ  • a lista "Justificativa" do APEX vira botões ("7 - Atestado Médico"), numa caixa
                  com altura e com busca quando há mais de 10 motivos; escolhido o motivo, a
                  caixa recolhe e fica "Trocar o motivo";
                • o comentário ganha os começos de frase (lista COMECOS): tocar escreve na caixa;
                • os campos de validade e o comprovante ganham nomes claros.
     PODE MEXER a lista COMECOS, o exemplo dentro do comentário ('Ex.: estava em reunião…') e
                os nomes em rotulo('ITEM', 'Nome').
     VISUAL     Natcorp_Abono.css › [C5] e [C9]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: os motivos que aparecem primeiro, procurados pelo NOME (não pelo código, que muda
     de base para base), nesta ordem. Os outros ficam atrás de "Ver todos os motivos". */
  var COMUNS = [/esquec/i, /atestado/i, /sa[ií]da antecipada almo/i, /sa[ií]da antecipada/i, /compensa/i, /outros motivos/i];
  /* PODE MEXER: os começos de frase que, tocados, escrevem no comentário */
  var COMECOS = ['Esqueceu de bater o ponto', 'O relógio de ponto não funcionou', 'Estava em serviço fora da empresa', 'Saída autorizada pelo gestor', 'Entrada autorizada pelo gestor'];
  function montarMotivo(corpoJ) {
    /* a lista de motivos (31 na base de teste) mora numa caixa com altura e busca; escolhido o
       motivo, ela recolhe: fica o escolhido e "Trocar o motivo" */
    B.lista = el('div', 'nc-ab-bloco', '<p class="nc-ab-perg">Escolha o motivo</p><div class="nc-ab-escolhido" hidden></div>' +
      '<div class="nc-ab-escolha"><div class="nc-ab-busca" hidden>' + svg(IC.lupa) + '<input type="search" placeholder="Procurar o motivo" aria-label="Procurar o motivo"></div><div class="nc-ab-motivos" role="radiogroup" aria-label="Motivo"></div></div>');
    B.trocar = false;
    var cj = cont('COD_JUSTIFICATIVA');
    cj.parentNode.insertBefore(B.lista, cj);
    esconder('COD_JUSTIFICATIVA');
    B.lista.addEventListener('click', function (e) {
      if (e.target.closest('[data-todos]')) { B.todos = true; desenhar(); var bt = B.lista.querySelector('.nc-ab-busca input'); if (bt) bt.focus(); return; }
      if (e.target.closest('[data-trocar]')) { B.trocar = true; desenhar(); var bi = B.lista.querySelector('.nc-ab-busca input'); if (bi && !B.lista.querySelector('.nc-ab-busca').hidden) bi.focus(); return; }
      var b = e.target.closest('[data-j]'); if (!b || b.disabled) return;
      B.trocar = false;
      apex.item(P + 'COD_JUSTIFICATIVA').setValue(b.getAttribute('data-j'));
      desenhar();
    });
    B.lista.querySelector('input').addEventListener('input', function () { desenhar(); });
    /* comentário: começos de frase que escrevem na caixa */
    var cc = cont('COMENTARIOS');
    if (cc) {
      rotulo('COMENTARIOS', 'Quer explicar melhor? (se quiser)');
      var t = item('COMENTARIOS');
      if (t && !t.getAttribute('placeholder')) t.setAttribute('placeholder', 'Ex.: estava em reunião no cliente e não passou pelo relógio.');
      var at = el('div', 'nc-ab-comecos', COMECOS.map(function (m) { return '<button type="button" class="nc-ab-chip" data-m="' + esc(m) + '">' + esc(m) + '</button>'; }).join(''));
      at.setAttribute('role', 'group'); at.setAttribute('aria-label', 'Começar o comentário');
      var ic = cc.querySelector('.t-Form-inputContainer') || cc;
      ic.insertBefore(at, ic.firstChild);
      at.addEventListener('click', function (e) {
        var b = e.target.closest('[data-m]'); if (!b || !t || t.disabled || t.readOnly) return;
        var atual = t.value.trim(), m = b.getAttribute('data-m');
        if (atual.indexOf(m) < 0) apex.item(t.id).setValue(atual ? atual.replace(/[.\s]*$/, '') + '. ' + m : m);
        t.focus(); t.setSelectionRange(t.value.length, t.value.length);
      });
    }
    rotulo('ARQUIVO_JUST', 'Comprovante (se tiver)');
    /* a validade do motivo (a página mostra os três campos para alguns motivos): no caso comum, um
       dia só e o próprio dia, vira uma frase — "Vale só para este dia (05/03/2025) · Mudar" */
    var cv = cont('NUM_DIAS_JUST');
    if (cv) {
      B.validade = el('p', 'nc-ab-validade'); B.validade.hidden = true;
      var av = cv.closest('.row') || cv;
      av.parentNode.insertBefore(B.validade, av);
      B.validade.addEventListener('click', function (e) { if (e.target.closest('[data-validade]')) { B.abreVal = true; desenhar(); } });
    }
    /* a observação e o comprovante são opcionais: ficam atrás de um toque, e abrem sozinhos quando
       já têm conteúdo, quando a página os exige (is-required) ou quando há erro na tela */
    var ca = cont('ARQUIVO_JUST'), primeiro = cc || ca, ultimo = ca || cc;
    if (primeiro) {
      B.extras = el('div', 'nc-ab-extras', (cc ? '<button type="button" class="nc-ab-extra" data-extra="obs">' + svg(IC.lapis) + '<span>Escrever uma observação <small>(se quiser)</small></span></button>' : '') +
        (ca ? '<button type="button" class="nc-ab-extra" data-extra="arq">' + svg(IC.clipe) + '<span>Anexar comprovante <small>(se tiver)</small></span></button>' : ''));
      /* depois dos dois campos: o que a pessoa abre aparece logo acima do que ainda está fechado */
      var ancora = ultimo.closest('.row') || ultimo;
      ancora.parentNode.insertBefore(B.extras, ancora.nextSibling);
      B.extras.addEventListener('click', function (e) {
        var b = e.target.closest('[data-extra]'); if (!b) return;
        if (b.getAttribute('data-extra') === 'rep') { var F2 = fila(); if (F2 && F2.comentario) apex.item(P + 'COMENTARIOS').setValue(F2.comentario); B.abreObs = true; desenhar(); return; }
        if (b.getAttribute('data-extra') === 'obs') { B.abreObs = true; desenhar(); var tt = item('COMENTARIOS'); if (tt) tt.focus(); }
        else { B.abreArq = true; desenhar(); }
      });
    }
    rotulo('NUM_DIAS_JUST', 'Por quantos dias vale');
    rotulo('DT_INI_VAL_JUST', 'Vale a partir de');
    rotulo('DT_FIM_VAL_JUST', 'Vale até');
  }
  function rotulo(n, t) {
    var l = document.getElementById(P + n + '_LABEL'); if (!l || l.getAttribute('data-nc-ab')) return;
    var tn = [].filter.call(l.childNodes, function (x) { return x.nodeType === 3 && x.textContent.trim(); })[0];
    if (tn) { tn.textContent = t + ' '; l.setAttribute('data-nc-ab', '1'); }
  }

  /* ═══ [J5] O PÉ: A FRASE DO PEDIDO, O QUE FALTA E "ENVIAR PEDIDO" ═════════════════════════
     O QUE FAZ  O botão "Criar" do APEX passa a dizer "Enviar pedido" (é o mesmo botão, com a
                mesma ação). Acima dele, um espaço para a frase do pedido e o "Falta: …" — quem
                escreve neles é desenharPe, em [J8]. Tocar num item do "Falta" leva à pergunta.
     CUIDADO    O botão é achado pelo texto "Criar". Se o rótulo mudar no APEX, mude também o
                /^criar$/i  abaixo (um "padrão de busca" que procura a palavra Criar).
     VISUAL     Natcorp_Abono.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarPe() {
    var criar = [].filter.call(document.querySelectorAll('.t-Button'), function (b) { return /^criar$/i.test(texto(b)); })[0];
    if (!criar) return;
    B.criar = criar;
    /* na sequência: ao enviar, guarda o recado (e o motivo/observação para sugerir no próximo) */
    criar.addEventListener('click', function () {
      var f = fila(); if (!f) return;
      f.acao = 'enviando'; f.motivo = val('COD_JUSTIFICATIVA') || f.motivo || ''; f.comentario = val('COMENTARIOS') || '';
      filaGuardar(f);
    }, true);
    var l = criar.querySelector('.t-Button-label'); if (l) l.textContent = 'Enviar pedido';
    criar.classList.add('nc-ab-enviar');
    var area = criar.closest('.t-ButtonRegion, .t-Region, .t-Dialog-footer') || criar.parentNode;
    B.pe = el('div', 'nc-ab-pe', '<div class="nc-ab-frase"></div><p class="nc-ab-falta"></p>');
    area.parentNode.insertBefore(B.pe, area);
    B.pe.addEventListener('click', function (e) {
      var b = e.target.closest('[data-ir]'); if (!b) return;
      var alvo = { acao: B.acao, hora: B.hora, mover: B.mover, motivo: B.lista }[b.getAttribute('data-ir')];
      if (alvo) { alvo.scrollIntoView({ behavior: 'smooth', block: 'center' }); alvo.classList.remove('nc-ab-pisca'); void alvo.offsetWidth; alvo.classList.add('nc-ab-pisca'); }
    });
  }

  /* ═══ [J6] ESCOLHER O QUE FAZER (CORRIGIR, APAGAR, MOVER, INCLUIR) ════════════════════════
     O QUE FAZ  Quando a pessoa toca num cartão, marca as caixas escondidas da página na ORDEM
                que as ações dinâmicas dela exigem:
                  corrigir → Apagar e Enviar desmarcados, e o horário certo
                  apagar   → APAGAR_MARCACAO = S
                  mover    → APAGAR_MARCACAO = S e, DEPOIS (quando a página terminar de
                             responder), ENVIAR_MARCACAO = S e a posição de destino
                  incluir  → quando não há marcação feita (não há cartão: é automático)
     CUIDADO    Não inverta a ordem: a ação da página só habilita o "Enviar" com o "Apagar"
                marcado. É por isso que existe o depois(…).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- escolher o que fazer: põe as caixas da página na ordem que as ações dela pedem ---------- */
  function escolher(a) {
    ACAO = a;
    var apagar = a === 'apagar' || a === 'mover', enviar = a === 'mover';
    if (marcado('APAGAR_MARCACAO') !== apagar) apex.item(P + 'APAGAR_MARCACAO').setValue(apagar ? 'S' : '');
    depois(function () {
      /* "Enviar p/ outra posição" só se habilita depois do "Apagar" (ação da página) */
      if (marcado('ENVIAR_MARCACAO') !== enviar) apex.item(P + 'ENVIAR_MARCACAO').setValue(enviar ? 'S' : '');
      if (a !== 'corrigir' && a !== 'incluir' && val('HORA_BATIDA_ABONO')) apex.item(P + 'HORA_BATIDA_ABONO').setValue('');
      if (a !== 'mover' && val('POSICAO_ENV')) apex.item(P + 'POSICAO_ENV').setValue('');
      desenhar();
      var alvo = a === 'mover' ? B.mover : a === 'apagar' ? B.apagar : B.hora;
      if (alvo) setTimeout(function () { alvo.scrollIntoView({ behavior: 'smooth', block: 'nearest' }); }, 60);
    });
    desenhar();
  }
  /* o que já está marcado na página diz qual é a ação (ao voltar com erro, por exemplo) */
  function acaoAtual() {
    if (!val('HORA_BATIDA')) return 'incluir';
    if (marcado('ENVIAR_MARCACAO')) return 'mover';
    if (marcado('APAGAR_MARCACAO')) return 'apagar';
    if (ACAO) return ACAO;
    return val('HORA_BATIDA_ABONO') ? 'corrigir' : null;
  }

  /* ═══ [J7] O RELÓGIO DO APARELHO ══════════════════════════════════════════════════════════
     O QUE FAZ  Troca o relógio de ponteiros da página (clockpicker) pelo seletor de hora do
                próprio celular ou computador (type="time"). O valor continua "HH:MM".
                definirHora() é o atalho "Usar o previsto": escreve o horário como se a pessoa
                digitasse e saísse do campo (a ação da página confere o horário ao sair).
     CUIDADO    É o mesmo caminho da Hora Extra (p716). Não volte o type para "text": o
                relógio de ponteiros não volta sozinho.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* o relógio de ponteiros da página dá lugar ao seletor de hora do aparelho (o do despertador);
     o valor continua "HH:MM". Tocar no campo ainda traz o horário previsto (ação da página). */
  function relogioDoAparelho() {
    var i = item('HORA_BATIDA_ABONO');
    if (!i || i.disabled || i.readOnly || i.type === 'time') return;
    try { if ($(i).data('clockpicker')) $(i).clockpicker('remove'); } catch (x) { /* sem relógio */ }
    var v = i.value;
    try { i.type = 'time'; } catch (x) { return; }
    i.step = 60;
    if (v) i.value = hora(v);
    i.classList.add('nc-ab-relogio');
    i.addEventListener('input', desenhar);
    i.addEventListener('change', desenhar);
    rotulo('HORA_BATIDA_ABONO', 'Horário certo');
  }
  /* como se a pessoa digitasse e saísse do campo (a ação da página confere o horário ao sair) */
  function definirHora(v) {
    var i = item('HORA_BATIDA_ABONO'); if (!i || i.disabled || i.readOnly) return;   /* 04/10: não escreve em campo travado pela página */
    depois(function () { apex.item(i.id).setValue(v); $(i).trigger('focusout'); desenhar(); });
  }

  /* ═══ [J8] O DESENHO: REDESENHA A JANELA A CADA MUDANÇA ═══════════════════════════════════
     O QUE FAZ  desenhar() roda a cada mudança e escreve: o dia, os botões das marcações, o que
                o relógio registrou ("Previsto", "Bateu", "Não bateu"), qual cartão está
                escolhido, a pergunta do horário com o atalho "Usar o previsto", os botões de
                destino (mover), a confirmação (apagar) e a lista de motivos com a busca.
                desenharPe() escreve a frase do pedido no pé ("Corrigir a 1ª entrada: 09:00 →
                08:12") e o "Falta: …" ou "Tudo pronto. Confira e envie.".
     LÊ DOS ITENS  DATA, POSICAO, HORA_BATIDA, JORNADA (o previsto), VIRA_DIA_DSP, PLANTAO,
                HORA_BATIDA_ABONO, POSICAO_ENV, COD_JUSTIFICATIVA
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_Abono.css › [C3], [C4], [C5] e [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function botoesDe(sel, attr, atual, rot, filtro) {
    var s = item(sel); if (!s || !s.options) return '';
    var dis = s.disabled;
    return [].filter.call(s.options, function (o) { return o.value && (!filtro || filtro(o) || o.value === atual); }).map(function (o) {
      var on = o.value === atual;
      return '<button type="button" role="radio" aria-checked="' + on + '" class="nc-ab-opc' + (on ? ' is-on' : '') + '" ' + attr + '="' + esc(o.value) + '"' + (dis ? ' disabled' : '') + '>' + rot(o) + '</button>';
    }).join('');
  }
  function desenhar() {
    if (CONSULTA) { desenharConsulta(); return; }
    var d = dataDe(val('DATA')), pos = val('POSICAO'), feito = hora(val('HORA_BATIDA')), prev = hora(val('JORNADA'));
    var vira = val('VIRA_DIA_DSP') || val('VIRA_DIA'), plantao = val('PLANTAO');
    html(B.dia.querySelector('.nc-ab-dia-txt'), svg(IC.cal) + '<b>' + esc(d ? porExtenso(d) : val('DATA') || 'Escolha o dia') + '</b>');
    var grade = diaDaGrade();
    classe(B.pos.querySelector('.nc-ab-pos'), 'nc-ab-pos--dia', !!grade);
    classe(B.pos.querySelector('.nc-ab-pos'), 'nc-ab-pos--fixo', !!B.fixo);
    if (B.fixo) {
      html(B.pos.querySelector('.nc-ab-perg'), 'A posição');
      html(B.pos.querySelector('.nc-ab-sub'), 'A ' + esc(ordinal(pos)) + ', escolhida na lista. As outras aparecem só para você ver o dia.');
    }
    html(B.pos.querySelector('.nc-ab-pos'), botoesDe('POSICAO', 'data-pos', pos, function (o) {
      var m = grade && grade.marcas[+o.value - 1];
      if (!grade) return '<b>' + esc(posicao(o.value) || o.text) + '</b>';
      var h = m && m.hora, st = !m ? 'vazia' : m.st === 'danger' ? 'problema' : m.st === 'warning' ? 'conferir' : h ? 'ok' : 'vazia';
      return '<small>' + esc(posicao(o.value) || o.text) + '</small><b class="nc-ab-pos-h nc-ab-pos-h--' + st + '">' +
        (h ? esc(h) : st === 'problema' ? 'faltou' : '—') + '</b>' + (m && m.abono && h ? '<i>ajustada</i>' : '');
    }));
    var fatos = [];
    if (prev) fatos.push('<span class="nc-ab-tag">' + svg(IC.relogio) + 'Previsto <b>' + esc(prev) + '</b></span>');
    fatos.push(feito ? '<span class="nc-ab-tag nc-ab-tag--feito">' + svg(IC.ok) + 'Bateu <b>' + esc(feito) + '</b></span>' : '<span class="nc-ab-tag nc-ab-tag--falta">' + svg(IC.alerta) + '<b>Não bateu</b> nesta marcação</span>');
    if (vira) fatos.push('<span class="nc-ab-tag">' + svg(IC.lua) + 'Vira o dia: <b>' + esc(vira) + '</b></span>');
    if (plantao && !/^n[aã]o$/i.test(plantao)) fatos.push('<span class="nc-ab-tag">Plantão: <b>' + esc(plantao) + '</b></span>');
    html(B.fato, pos ? fatos.join('') : '');

    var a = acaoAtual();
    var temFeito = !!feito;
    B.acao.hidden = !pos || !temFeito;
    var hAb = item('HORA_BATIDA_ABONO');
    [].forEach.call(B.acao.querySelectorAll('[data-acao]'), function (b) {
      var on = b.getAttribute('data-acao') === a, k = b.getAttribute('data-acao');
      classe(b, 'is-on', on); b.setAttribute('aria-checked', on);
      /* 04/10: "corrigir" segue o campo do horário (desabilitado pela página → cartão desabilitado) */
      b.disabled = k === 'corrigir' ? !!(hAb && hAb.disabled) : !!(item('APAGAR_MARCACAO_0') && item('APAGAR_MARCACAO_0').disabled);
      /* 04/10: "mover" só existe se a página desenhou ENVIAR_MARCACAO (condição de servidor: perfil
         com pe_perfil_abono_geral.bloqueia = 'S' não recebe o item e não pode mover) */
      if (k === 'mover') b.hidden = !item('ENVIAR_MARCACAO');
    });
    var nome = ordinal(pos) || 'marcação';
    /* o horário certo */
    var mostraHora = !!pos && (a === 'incluir' || a === 'corrigir');
    B.hora.hidden = !mostraHora;
    if (mostraHora) {
      html(B.hora.querySelector('.nc-ab-perg'), a === 'incluir' ? 'Qual o horário da ' + esc(nome) + '?' : 'Qual o horário certo da ' + esc(nome) + '?');
      var at = [];
      if (prev && prev !== hora(val('HORA_BATIDA_ABONO')) && !(hAb && (hAb.disabled || hAb.readOnly))) at.push('<button type="button" class="nc-ab-chip" data-h="' + esc(prev) + '">' + svg(IC.relogio) + 'Usar o previsto (' + esc(prev) + ')</button>');
      if (a === 'corrigir' && feito && hora(val('HORA_BATIDA_ABONO')) === feito) at.push('<p class="nc-ab-aviso">' + svg(IC.alerta) + '<span>É o mesmo horário que bateu (' + esc(feito) + '). Escolha o horário certo.</span></p>');
      html(B.hora.querySelector('.nc-ab-hora-atalhos'), at.join(''));
    }
    /* mover */
    B.mover.hidden = a !== 'mover';
    if (a === 'mover') {
      var env = item('POSICAO_ENV');
      /* primeiro só as batidas desta jornada (a lista "Qual batida?"); as outras (5ª, 6ª…) atrás de um toque */
      var sp = item('POSICAO'), daJornada = sp && sp.options ? [].map.call(sp.options, function (o) { return o.value; }).filter(Boolean) : [];
      var filtro = B.envTodos || !daJornada.length ? null : function (o) { return daJornada.indexOf(o.value) >= 0; };
      var sobra = filtro && env && env.options && [].some.call(env.options, function (o) { return o.value && daJornada.indexOf(o.value) < 0; });
      html(B.mover.querySelector('.nc-ab-pos'), env && !env.disabled ? botoesDe('POSICAO_ENV', 'data-env', val('POSICAO_ENV'), function (o) { return '<b>' + esc(posicao(o.value) || o.text) + '</b>'; }, filtro) +
        (sobra ? '<button type="button" class="nc-ab-link nc-ab-env-todos" data-env-todos>Outra posição (5, 6…)</button>' : '') : '<p class="nc-ab-nota">Um momento…</p>');
      html(B.mover.querySelector('.nc-ab-nota'), feito ? 'A marcação das <b>' + esc(feito) + '</b> sai da ' + esc(nome) + ' e vai para a que você escolher.' : '');
    }
    /* apagar */
    B.apagar.hidden = a !== 'apagar';
    if (a === 'apagar') html(B.apagar, svg(IC.lixo) + '<span>A marcação das <b>' + esc(feito) + '</b> (' + esc(nome) + ') vai ser <b>apagada</b> do ponto deste dia.</span>');

    /* o motivo */
    var q = (B.lista.querySelector('input').value || '').trim().toLowerCase();
    var sj = item('COD_JUSTIFICATIVA'), cod = val('COD_JUSTIFICATIVA');
    var opcs = sj && sj.options ? [].filter.call(sj.options, function (o) { return o.value; }) : [];
    /* os mais usados no ajuste do ponto primeiro (COMUNS); "Ver todos" ou a busca abrem a lista inteira */
    var todos = B.todos || !!q, com = [];
    if (!todos) {
      COMUNS.forEach(function (re) { var o = opcs.filter(function (x) { return re.test(nomeJust(x.text)) && com.indexOf(x) < 0; })[0]; if (o) com.push(o); });
      var sel = opcs.filter(function (o) { return o.value === cod; })[0];
      if (sel && com.indexOf(sel) < 0) com.unshift(sel);
      if (com.length < 3) todos = true;
    }
    var mostra = todos ? opcs : com;
    var FS = fila(), sug = FS && FS.motivo && !cod ? opcs.filter(function (o) { return o.value === FS.motivo; })[0] : null;
    if (sug) { mostra = [sug].concat(mostra.filter(function (o) { return o !== sug; })); }
    B.lista.querySelector('.nc-ab-busca').hidden = !todos || opcs.length <= 10;
    var recolhe = !!cod && !B.trocar;
    B.lista.querySelector('.nc-ab-escolha').hidden = recolhe;
    B.lista.querySelector('.nc-ab-escolhido').hidden = !recolhe;
    html(B.lista.querySelector('.nc-ab-perg'), recolhe ? 'O motivo' : todos && opcs.length > 10 ? 'Qual o motivo? <small>(procure pelo nome)</small>' : 'Qual o motivo?');
    html(B.lista.querySelector('.nc-ab-escolhido'), recolhe ? '<span class="nc-ab-motivo is-on">' + '<span>' + esc(nomeJust(textoOpcao('COD_JUSTIFICATIVA'))) + '</span></span>' + (sj.disabled ? '' : '<button type="button" class="nc-ab-link" data-trocar>Trocar o motivo</button>') : '');
    html(B.lista.querySelector('.nc-ab-motivos'), mostra.filter(function (o) { return !q || o.value === cod || o.text.toLowerCase().indexOf(q) >= 0; }).map(function (o) {
      var on = o.value === cod;
      var ehSug = sug && o === sug;
      return '<button type="button" role="radio" aria-checked="' + on + '" class="nc-ab-motivo' + (on ? ' is-on' : '') + (ehSug ? ' is-sugerido' : '') + '" data-j="' + esc(o.value) + '" title="' + esc(o.text) + '"' + (sj.disabled ? ' disabled' : '') + '><span>' + esc(nomeJust(o.text)) + '</span>' + (ehSug ? '<small class="nc-ab-selo">Usado no anterior</small>' : '') + '</button>';
    }).join('') + (todos ? '' : '<button type="button" class="nc-ab-todos" data-todos>' + svg(IC.lupa) + '<span>Outro motivo <small>(procurar entre os ' + opcs.length + ')</small></span></button>') || '<p class="nc-ab-nota">Nenhum motivo com esse nome.</p>');

    desenharExtras();
    desenharPe(a, nome, feito);
    desenharDica(a, pos, feito, prev);
    desenharPassos(a, pos, feito);
  }
  function desenharValidade() {
    if (!B.validade) return;
    var cs = ['NUM_DIAS_JUST', 'DT_INI_VAL_JUST', 'DT_FIM_VAL_JUST'].map(cont).filter(Boolean);
    var aVista = cs.some(function (c) { return !c.classList.contains('nc-ab-recolhido') ? c.offsetParent !== null : c.style.display !== 'none' && !c.closest('[style*="none"]'); });
    var dia = val('DATA'), ini = val('DT_INI_VAL_JUST'), fim = val('DT_FIM_VAL_JUST'), n = val('NUM_DIAS_JUST');
    var simples = !B.abreVal && !document.body.classList.contains('nc-ab-erro') && aVista && n === '1' && ini === dia && fim === dia &&
      !cs.some(function (c) { return c.querySelector('.t-Form-error:not(:empty)'); });
    cs.forEach(function (c) { classe(c, 'nc-ab-recolhido', simples); });
    B.validade.hidden = !simples;
    if (simples) html(B.validade, svg(IC.cal) + '<span>Vale só para este dia (<b>' + esc(dia) + '</b>)</span><button type="button" class="nc-ab-link" data-validade>Mudar</button>');
  }
  function desenharExtras() {
    desenharValidade();
    if (!B.extras) return;
    var cO = cont('COMENTARIOS'), cA = cont('ARQUIVO_JUST'), arq = item('ARQUIVO_JUST'), erro = document.body.classList.contains('nc-ab-erro');
    var exige = function (c) { return !!c && (c.classList.contains('is-required') || !!c.querySelector('.t-Form-error:not(:empty)')); };
    var abreO = !cO || erro || B.abreObs || !!val('COMENTARIOS') || exige(cO);
    var abreA = !cA || erro || B.abreArq || !!(arq && arq.value) || exige(cA);
    if (cO) classe(cO, 'nc-ab-recolhido', !abreO);
    if (cA) classe(cA, 'nc-ab-recolhido', !abreA);
    var bo = B.extras.querySelector('[data-extra="obs"]'), ba = B.extras.querySelector('[data-extra="arq"]');
    if (bo) bo.hidden = abreO;
    if (ba) ba.hidden = abreA;
    /* na sequência: a observação do ajuste anterior vira um atalho (um toque escreve e abre a caixa) */
    var FX = fila(), rep = B.extras.querySelector('[data-extra="rep"]');
    var mostraRep = !!(FX && FX.comentario && !val('COMENTARIOS') && cO);
    if (mostraRep && !rep) {
      rep = el('button', 'nc-ab-extra nc-ab-extra--rep'); rep.type = 'button'; rep.setAttribute('data-extra', 'rep');
      B.extras.insertBefore(rep, B.extras.firstChild);
    }
    if (rep) { rep.hidden = !mostraRep; if (mostraRep) html(rep, svg(IC.lapis) + '<span>Repetir a observação anterior <small>“' + esc(FX.comentario.slice(0, 60)) + (FX.comentario.length > 60 ? '…' : '') + '”</small></span>'); }
    B.extras.hidden = abreO && abreA && !mostraRep;
  }
  function desenharPe(a, nome, feito) {
    if (!B.pe) return;
    var d = dataDe(val('DATA')), h = hora(val('HORA_BATIDA_ABONO')), env = val('POSICAO_ENV'), j = nomeJust(textoOpcao('COD_JUSTIFICATIVA'));
    var dia = d ? SEM[d.getDay()] + ', ' + val('DATA') : val('DATA');
    var o = '';
    if (!val('POSICAO')) o = '';
    else if (a === 'incluir') o = 'Incluir na <b>' + esc(nome) + '</b>' + (h ? ' às <b>' + esc(h) + '</b>' : '');
    else if (a === 'corrigir') o = 'Corrigir a <b>' + esc(nome) + '</b>: <s>' + esc(feito) + '</s> → <b>' + esc(h || '?') + '</b>';
    else if (a === 'apagar') o = 'Apagar a <b>' + esc(nome) + '</b> (' + esc(feito) + ')';
    else if (a === 'mover') o = 'Levar <b>' + esc(feito) + '</b> da ' + esc(nome) + ' para a <b>' + esc(ordinal(env) || '?') + '</b>';
    var falta = [];
    if (!val('POSICAO')) falta.push(['acao', 'qual posição']);
    else if (!a) falta.push(['acao', 'o que aconteceu']);
    else if ((a === 'incluir' || a === 'corrigir') && !h) falta.push(['hora', 'o horário']);
    else if (a === 'corrigir' && h === feito) falta.push(['hora', 'um horário diferente do que bateu']);
    else if (a === 'mover' && !env) falta.push(['mover', 'para qual posição']);
    if (!val('COD_JUSTIFICATIVA')) falta.push(['motivo', 'o motivo']);
    html(B.pe.querySelector('.nc-ab-frase'), o ? '<p class="nc-ab-frase-o">' + o + '</p><p class="nc-ab-frase-sub">' + esc(dia) + (j ? ' · ' + esc(j) : '') + '</p>' : '');
    html(B.pe.querySelector('.nc-ab-falta'), falta.length ? svg(IC.alerta) + '<span>Falta: ' + falta.map(function (f) { return '<button type="button" class="nc-ab-link" data-ir="' + f[0] + '">' + esc(f[1]) + '</button>'; }).join(', ') + '</span>' : svg(IC.ok) + '<span>Tudo pronto. Confira e envie.</span>');
    classe(B.pe.querySelector('.nc-ab-falta'), 'is-pronto', !falta.length);
  }

  /* ═══ [J11] A LINHA DO TEMPO DO DIA E A SUGESTÃO ═══════════════════════════════════════════
     O QUE FAZ  Quando a janela é aberta pela Tratativa de Abono (9503:203), pergunta a ela como
                foi o dia (window.ncPontoDia, do Natcorp_Ponto.js) e mostra em "Qual batida?" o
                horário de cada batida: 09:00, 18:01, "faltou"… Aberta de outro lugar, os botões
                mostram só o nome da batida, como antes.
                A SUGESTÃO: se o relógio registrou um horário 2 horas ou mais longe do previsto
                (ex.: 18:01 na 1ª saída, prevista 13:00) e há mais adiante (ou antes) uma batida
                do mesmo tipo vazia, a tela diz isso em uma frase e oferece "Levar 18:01 para a
                2ª saída" — que faz o mesmo que escolher "Bateu no lugar errado" e o destino.
     PODE MEXER o limite LONGE (em minutos) e as frases da sugestão.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: a partir de quantos minutos longe do previsto a tela sugere outra batida */
  var LONGE = 120;
  function diaDaGrade() {
    var data = val('DATA'); if (!data) return null;
    var alvos = [];
    try { alvos.push(window.parent); var fs = window.parent.frames; for (var i = 0; i < fs.length; i++) alvos.push(fs[i]); } catch (e) { /* outra origem */ }
    for (var k = 0; k < alvos.length; k++) {
      try { if (alvos[k] && alvos[k] !== window && typeof alvos[k].ncPontoDia === 'function') { var r = alvos[k].ncPontoDia(data); if (r && r.marcas) return r; } } catch (e) { /* sem acesso */ }
    }
    return null;
  }
  function minutos(h) { var m = /^(\d{2}):(\d{2})$/.exec(h || ''); return m ? +m[1] * 60 + +m[2] : null; }
  function sugestao(pos, feito, prev) {
    var f = minutos(feito), p = minutos(prev);
    if (f === null || p === null || Math.abs(f - p) < LONGE) return null;
    var grade = diaDaGrade(), env = item('POSICAO_ENV'), sp = item('POSICAO'), depoisDele = f > p, par = +pos % 2, alvo = null;
    if (!grade || !env || !env.options || !sp || !sp.options) return { longe: true };
    /* só as batidas que esta jornada tem (a lista "Qual batida?"): a grade tem casas a mais */
    function existe(sel, q) { return [].some.call(sel.options, function (o) { return o.value === String(q); }); }
    grade.marcas.forEach(function (m, i) {
      var q = i + 1;
      if (q === +pos || q % 2 !== par || m.hora || (depoisDele ? q < +pos : q > +pos)) return;
      if (!existe(env, q) || !existe(sp, q)) return;
      if (alvo === null || (depoisDele ? q > alvo : q < alvo)) alvo = q;
    });
    return { longe: true, alvo: alvo };
  }
  /* Em vez de uma caixa de explicação, cada cartão de "O que aconteceu?" diz o EFEITO da escolha
     com o horário de verdade ("Apagar 18:01"). A sugestão entra no próprio cartão "Bateu na
     posição errada": selo "Sugestão" e "Levar 18:01 para a posição 4, que está vazia"; o toque
     nele já escolhe mover e a posição 4 (dá para trocar o destino depois). */
  function desenharDica(a, pos, feito, prev) {
    if (B.dica) B.dica.hidden = true;
    var s = pos && feito && a !== 'mover' ? sugestao(pos, feito, prev) : null;
    B.sugAlvo = s && s.alvo ? s.alvo : null;
    var h = feito ? '<b>' + esc(feito) + '</b>' : 'a marcação';
    var sub = function (k, t) { var e = B.acao.querySelector('[data-acao="' + k + '"] small'); if (e) html(e, t); };
    sub('corrigir', 'Trocar ' + h + ' pelo horário certo');
    sub('apagar', 'Apagar ' + h);
    sub('mover', B.sugAlvo ? 'Levar ' + h + ' para a <b>' + esc(ordinal(B.sugAlvo)) + '</b>, que está vazia' : 'Levar ' + h + ' para outra posição');
    var mv = B.acao.querySelector('[data-acao="mover"]');
    if (mv) {
      classe(mv, 'is-sugerido', !!B.sugAlvo);
      var selo = mv.querySelector('.nc-ab-selo');
      if (B.sugAlvo && !selo) { selo = el('span', 'nc-ab-selo', 'Sugestão'); mv.appendChild(selo); }
      if (selo) selo.hidden = !B.sugAlvo;
    }
  }
  /* "Levar para": as mesmas caixas de "Bateu no lugar errado", e o destino quando a página o liberar */
  function levarPara(q) {
    escolher('mover');
    var n = 0;
    (function tenta() {
      var env = item('POSICAO_ENV');
      if (env && !env.disabled && [].some.call(env.options, function (o) { return o.value === String(q); }) && !$.active) { apex.item(P + 'POSICAO_ENV').setValue(String(q)); desenhar(); return; }
      if (++n < 30) setTimeout(tenta, 150);
    })();
  }

  /* ═══ [J12] UM PASSO POR VEZ NO CELULAR ════════════════════════════════════════════════════
     O QUE FAZ  No celular (tela até 640 px), a janela vira 4 passos, um por tela:
                  1 Qual batida?   2 O que aconteceu? (ou "Que horas foi?")   3 Por quê?
                  4 Confira e envie
                Embaixo, sempre à mão: "Voltar" e "Continuar" (no último, o "Enviar pedido" da
                página). "Continuar" sempre avança (04/10): quem exige é a página. No computador,
                tudo aparece numa tela só.
                Se a página mostrar um ERRO (validação do APEX), os passos se desligam e tudo
                aparece de uma vez, para o erro nunca ficar escondido num passo.
                Aberta já com a batida escolhida (o caso de sempre: tocar no horário da lista), a
                janela começa no passo 2.
     PODE MEXER os títulos dos passos em TITULOS e as frases de faltaNoPasso.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PASSO = 1;
  /* PODE MEXER: o título de cada passo (o 2 vira "Que horas foi?" quando não há batida) */
  var TITULOS = ['Qual posição você quer arrumar?', 'O que aconteceu?', 'Por quê?', 'Confira e envie'];
  var MQ = window.matchMedia ? window.matchMedia('(max-width: 640px)') : null;
  /* PODE MEXER: avisos da própria página (ações dinâmicas) reescritos em palavras simples — o
     MESMO sentido, outras palavras. [padrão do aviso original, texto novo] */
  var AVISOS = [
    [/posi[cç][oõ]es\s+subsequentes\s+ser[aã]o\s+avan[cç]adas/i, 'As marcações das <b>posições seguintes</b> vão ser <b>empurradas para a frente</b>.']
  ];
  function traduzirAvisos() {
    [].forEach.call(document.querySelectorAll('.alertify-message'), function (p) {
      if (p.getAttribute('data-nc-ab')) return;
      AVISOS.forEach(function (x) { if (x[0].test(p.textContent)) { p.innerHTML = x[1]; p.setAttribute('data-nc-ab', '1'); var ok = p.parentNode.querySelector('.alertify-button-ok'); if (ok && /^ok$/i.test(texto(ok))) ok.textContent = 'Entendi'; } });
    });
  }
  function erroNaPagina() {
    return !!document.querySelector('.t-Form-error:not(:empty), .a-Form-error:not(:empty), .t-Alert--danger:not([style*="none"]), #t_Alert_Notification .a-Notification-item');
  }
  function emPassos() { return !!(MQ && MQ.matches) && !document.body.classList.contains('nc-ab-erro'); }
  function montarPassos() {
    if (erroNaPagina()) document.body.classList.add('nc-ab-erro');
    B.cab.setAttribute('data-passo', '1');
    [B.acao, B.hora, B.mover, B.apagar].forEach(function (x) { if (x) x.setAttribute('data-passo', '2'); });
    B.just.setAttribute('data-passo', '3');
    if (B.pe) B.pe.setAttribute('data-passo', '4');
    var mapa = document.querySelector('.nc-ab-mapa'); if (mapa) mapa.setAttribute('data-passo', '1');
    /* o alto: "Passo 2 de 4", o título e o resumo da batida escolhida */
    B.passos = el('div', 'nc-ab-passos', '<div class="nc-ab-passos-barra" aria-hidden="true"><i></i><i></i><i></i><i></i></div>' +
      '<p class="nc-ab-passos-n"></p><h2 class="nc-ab-passos-tit"></h2><div class="nc-ab-passos-ctx"></div>');
    var raiz = document.getElementById('MARCACAO') || B.marc;
    raiz.parentNode.insertBefore(B.passos, raiz);
    B.passos.addEventListener('click', function (e) { if (e.target.closest('[data-trocar-batida]')) irPasso(1); });
    /* embaixo: Voltar e Continuar, junto dos botões da página */
    if (B.criar) {
      B.nav = el('div', 'nc-ab-nav', '<p class="nc-ab-nav-falta" hidden></p><div class="nc-ab-nav-bts">' +
        '<button type="button" class="nc-ab-nav-volta">' + svg(IC.esq) + '<span>Voltar</span></button>' +
        '<button type="button" class="nc-ab-nav-segue"><span>Continuar</span>' + svg(IC.dir) + '</button></div>');
      var area = B.criar.closest('.t-ButtonRegion, .t-Dialog-footer') || B.criar.parentNode;
      area.insertBefore(B.nav, area.firstChild);
      B.voltarApex = [].filter.call(area.querySelectorAll('.t-Button'), function (b) { return /^voltar$/i.test(texto(b)); })[0] || null;
      B.nav.querySelector('.nc-ab-nav-volta').addEventListener('click', function () { irPasso(PASSO - 1); });
      B.nav.querySelector('.nc-ab-nav-segue').addEventListener('click', seguir);
    }
    PASSO = val('POSICAO') ? 2 : 1;   /* aberta pela lista (B.fixo): o passo 1 nem existe */
    if (MQ) { var muda = function () { desenhar(); }; if (MQ.addEventListener) MQ.addEventListener('change', muda); else if (MQ.addListener) MQ.addListener(muda); }
    /* erro mostrado pela própria página depois do "Enviar" (validação no navegador) */
    if (window.MutationObserver) {
      new MutationObserver(function () { traduzirAvisos(); if (erroNaPagina() && !document.body.classList.contains('nc-ab-erro')) { document.body.classList.add('nc-ab-erro'); desenhar(); } })
        .observe(document.body, { childList: true, subtree: true, attributes: true, attributeFilter: ['class', 'style'] });
    }
  }
  /* o que ainda falta em cada passo; nada = pode seguir */
  function faltaNoPasso(n) {
    var a = acaoAtual(), feito = hora(val('HORA_BATIDA')), h = hora(val('HORA_BATIDA_ABONO'));
    if (n === 1 && !val('POSICAO')) return ['pos', 'Toque na posição que você quer arrumar.'];
    if (n === 2) {
      if (!a) return ['acao', 'Escolha o que aconteceu.'];
      if ((a === 'incluir' || a === 'corrigir') && !h) return ['hora', 'Escolha o horário certo.'];
      if (a === 'corrigir' && h === feito) return ['hora', 'O horário certo não pode ser igual ao que bateu (' + feito + ').'];
      if (a === 'mover' && !val('POSICAO_ENV')) return ['mover', 'Escolha para qual posição ela vai.'];
    }
    if (n === 3 && !val('COD_JUSTIFICATIVA')) return ['motivo', 'Escolha o motivo.'];
    return null;
  }
  function seguir() {
    /* 04/10 (cliente): "não pode ser obrigatório, tem que seguir a regra que está na aplicação de
       forma original". O "Continuar" NÃO barra mais (horário, motivo, horário igual ao batido…):
       quem exige é a página, nas validações do "Enviar pedido" — igual no computador. */
    return irPasso(PASSO + 1);
    var f = faltaNoPasso(PASSO);
    var aviso = B.nav.querySelector('.nc-ab-nav-falta');
    if (f) {
      html(aviso, svg(IC.alerta) + '<span>' + esc(f[1]) + '</span>'); aviso.hidden = false;
      var alvo = { pos: B.pos, acao: B.acao, hora: B.hora, mover: B.mover, motivo: B.lista }[f[0]];
      if (alvo) { alvo.scrollIntoView({ behavior: 'smooth', block: 'center' }); alvo.classList.remove('nc-ab-pisca'); void alvo.offsetWidth; alvo.classList.add('nc-ab-pisca'); }
      return;
    }
    irPasso(PASSO + 1);
  }
  function irPasso(n) {
    PASSO = Math.max(B.fixo ? 2 : 1, Math.min(4, n));
    if (B.nav) B.nav.querySelector('.nc-ab-nav-falta').hidden = true;
    desenhar();
    var rola = document.querySelector('.t-Dialog-bodyWrapperIn');
    if (rola) rola.scrollTop = 0; else window.scrollTo(0, 0);
  }
  function desenharPassos(a, pos, feito) {
    if (!B.passos) return;
    var on = emPassos();
    classe(document.body, 'nc-ab-passos-on', on);
    document.body.setAttribute('data-nc-passo', String(PASSO));
    classe(B.marc, 'nc-ab-fora', on && PASSO > 2);
    classe(B.just, 'nc-ab-fora', on && PASSO !== 3);
    if (B.voltarApex) classe(B.voltarApex, 'nc-ab-fora', on && PASSO > 1);
    if (B.criar) classe(B.criar, 'nc-ab-fora', on && PASSO < 4);
    if (B.nav) {
      B.nav.hidden = !on;
      B.nav.querySelector('.nc-ab-nav-volta').hidden = PASSO === (B.fixo ? 2 : 1);
      B.nav.querySelector('.nc-ab-nav-segue').hidden = PASSO === 4;
      if (!faltaNoPasso(PASSO)) B.nav.querySelector('.nc-ab-nav-falta').hidden = true;
    }
    if (!on) return;
    var tit = PASSO === 2 && (a === 'incluir' || !feito) ? 'Que horas foi?' : TITULOS[PASSO - 1];
    var desc = B.fixo ? 1 : 0;   /* fixo: os passos 2, 3 e 4 aparecem como 1, 2 e 3 de 3 */
    html(B.passos.querySelector('.nc-ab-passos-n'), 'Passo ' + (PASSO - desc) + ' de ' + (4 - desc));
    html(B.passos.querySelector('.nc-ab-passos-tit'), esc(tit));
    [].forEach.call(B.passos.querySelectorAll('.nc-ab-passos-barra i'), function (x, i) { x.hidden = desc && i === 3; classe(x, 'is-on', i < PASSO - desc); });
    var d = dataDe(val('DATA'));
    html(B.passos.querySelector('.nc-ab-passos-ctx'), PASSO > 1 && pos ? '<span>' + svg(IC.cal) + esc(d ? SEM[d.getDay()].replace('-feira', '') + ', ' + val('DATA').slice(0, 5) : val('DATA')) +
      ' · <b>' + esc(ordinal(pos)) + '</b>' + (feito ? ' · bateu ' + esc(feito) : ' · sem marcação') + (hora(val('JORNADA')) && feito && hora(val('JORNADA')) !== feito ? ' · previsto ' + esc(hora(val('JORNADA'))) : '') + '</span>' + (B.fixo ? '' : '<button type="button" class="nc-ab-link" data-trocar-batida>Trocar</button>') : '');
  }

  /* ═══ [J15] AJUSTE EM SEQUÊNCIA (A JANELA) ════════════════════════════════════════════════
     O QUE FAZ  Quando a Tratativa de Abono abre esta janela pela "Ajustar em sequência"
                (Natcorp_Ponto.js › [J14]), aparece no alto "Ajuste em sequência · 4 de 23" com
                "Pular este" e "Parar". O motivo e a observação do ajuste anterior são SUGERIDOS
                (o motivo vem primeiro, marcado "Usado no anterior"; a observação vira um atalho)
                — nada vem escolhido: um toque confirma.
     COMO       A fila mora na memória da aba (sessionStorage "nc-po-fila"), a mesma da lista.
                Ao tocar em "Enviar pedido", a janela anota acao = 'enviando'; se a página volta
                com erro (validação), esta janela apaga o recado ao abrir de novo — assim a lista
                só avança quando o pedido foi criado de verdade.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function fila() {
    if (CONSULTA) return null;
    try { var f = JSON.parse(sessionStorage.getItem('nc-po-fila') || 'null'); return f && f.ativo && f.atual ? f : null; } catch (e) { return null; }
  }
  function filaGuardar(f) { try { sessionStorage.setItem('nc-po-fila', JSON.stringify(f)); } catch (e) { /* sem memória */ } }
  function montarFila() {
    var f = fila(); if (!f) return;
    /* voltou com erro depois do "Enviar": o recado do envio é apagado (a fila não avança) */
    if (f.acao === 'enviando') { f.acao = null; filaGuardar(f); }
    B.fila = el('div', 'nc-ab-fila', svg(IC.seta) + '<span><b>Ajuste em sequência</b> · ' + (f.n || 1) + ' de ' + (f.total || '?') + '</span>' +
      '<button type="button" class="nc-ab-link" data-fila="pular">Pular este</button><button type="button" class="nc-ab-link" data-fila="parar">Parar</button>');
    var raiz = B.passos || document.getElementById('MARCACAO') || B.marc;
    raiz.parentNode.insertBefore(B.fila, raiz);
    B.fila.addEventListener('click', function (e) {
      var b = e.target.closest('[data-fila]'); if (!b) return;
      var F = fila(); if (!F) return;
      F.acao = b.getAttribute('data-fila'); filaGuardar(F);
      try { apex.navigation.dialog.cancel(true); } catch (x) { /* fora de uma janela */ }
    });
  }

  /* ═══ [J9] O PEDIDO JÁ FEITO: O RESUMO EM FRASE ═══════════════════════════════════════════
     O QUE FAZ  Com P714_COD_REQ preenchido, o alto mostra "Pedido 57658 · Concluída", o que foi
                pedido em frase, o dia, o motivo, o comentário e quem pediu. Os campos só de
                leitura (que repetem o resumo) ficam atrás de "Ver todos os campos do pedido";
                a caixa "O motivo" só aparece com eles abertos ou com comprovante; os campos
                vazios somem.
     PODE MEXER a lista SITU: o código da situação (COD_SIT_REQ) → a cor do selo:
                'anda' = em andamento · 'ok' = verde · 'nao' = vermelho.
     VISUAL     Natcorp_Abono.css › [C7] e [C9]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarConsulta() {
    B.resumo = el('div', 'nc-ab-resumo');
    B.cab.appendChild(B.resumo);
    /* a faixa da aprovação e "Ver quem aprovou" (abre a aba Aprovadores) */
    B.resumo.addEventListener('click', function (e) { if (e.target.closest('[data-ver-aprov]')) abrirAba('APRV'); });
    /* os campos só de leitura repetem o resumo: ficam atrás de um toque */
    var ver = el('button', 'nc-ab-link nc-ab-vertodos', 'Ver todos os campos do pedido');
    ver.type = 'button';
    /* "Ver todos os campos" e "Ver no mapa" na mesma linha, logo abaixo do resumo */
    B.links = el('div', 'nc-ab-links');
    B.cab.appendChild(B.links);
    B.links.appendChild(ver);
    var mapaC = document.querySelector('.nc-ab-mapa'); if (mapaC) B.links.appendChild(mapaC);
    ver.addEventListener('click', function () { var on = document.body.classList.toggle('nc-ab-campos'); ver.textContent = on ? 'Esconder os campos do pedido' : 'Ver todos os campos do pedido'; desenhar(); });
    /* a ficha dos campos (aberta pelo link acima) ganha um título; os campos viram linhas de leitura */
    var grade = corpo(B.marc).querySelector(':scope > .container');
    if (grade) { B.camposTit = el('p', 'nc-ab-campos-tit', 'Campos do pedido'); grade.parentNode.insertBefore(B.camposTit, grade); grade.classList.add('nc-ab-ficha'); }
    montarAprovadores();
  }
  /* PODE MEXER: a cor de cada situação do pedido (código da lista "Situação" → ok, anda, nao) */
  var SITU = { 1: 'anda', 2: 'ok', 3: 'nao', 4: 'nao', 5: 'ok', 6: 'anda' };
  /* PODE MEXER: como cada situação aparece escrita (o texto da página às vezes vem sem acento) */
  var NOME_SIT = { 1: 'Em andamento', 2: 'Concluída', 3: 'Cancelada', 4: 'Reprovada', 5: 'Aprovada', 6: 'Suspensa' };
  /* "700 - Natcorp Do Brasil / 365785 - Fernando Mattos Torres" → empresa e pessoa, código - descrição */
  function partesSolicitante(t) {
    var p = String(t || '').replace(/^\s*-\s*\/\s*-\s*$/, '').split(/\s*\/\s*/);
    return { empresa: nomeJust(p[0] || ''), pessoa: nomeJust(p[1] || p[0] || '') };
  }
  function desenharConsulta() {
    var d = dataDe(val('DATA')), pos = val('POSICAO'), nome = ordinal(pos) || 'marcação';
    var orig = hora(val('HORA_BATIDA')), novo = hora(val('HORA_BATIDA_ABONO_DSP') || val('HORA_BATIDA_ABONO'));
    var env = val('POSICAO_ENVIO') || val('POSICAO_ENV'), apagar = marcado('APAGAR_MARCACAO');
    var s = item('COD_SIT_REQ'), st = s ? s.value : '', tom = SITU[st] || 'anda';
    var sit = NOME_SIT[st] || textoOpcao('COD_SIT_REQ') || val('COD_SIT_REQ_DSP');
    /* a mudança, em "antes → depois" */
    var o, antes, depois;
    if (env && apagar) {
      o = 'Levar <b>' + esc(orig) + '</b> da ' + esc(nome) + ' para a <b>' + esc(ordinal(env)) + '</b>';
      antes = '<small>' + esc(posicao(pos)) + '</small><b>' + esc(orig || '—') + '</b>';
      depois = '<small>' + esc(posicao(env)) + '</small><b>' + esc(orig || '—') + '</b>';
    } else if (apagar) {
      o = 'Apagar a <b>' + esc(nome) + '</b>' + (orig ? ' (' + esc(orig) + ')' : '');
      antes = '<small>' + esc(posicao(pos)) + '</small><b><s>' + esc(orig || '—') + '</s></b>';
      depois = '<small>' + esc(posicao(pos)) + '</small><b class="nc-ab-mud-apag">apagada</b>';
    } else if (novo) {
      o = orig ? 'Corrigir a <b>' + esc(nome) + '</b>: <s>' + esc(orig) + '</s> → <b>' + esc(novo) + '</b>' : 'Incluir na <b>' + esc(nome) + '</b> às <b>' + esc(novo) + '</b>';
      antes = '<small>' + esc(posicao(pos)) + '</small>' + (orig ? '<b><s>' + esc(orig) + '</s></b>' : '<b class="nc-ab-mud-vazio">sem marcação</b>');
      depois = '<small>' + esc(posicao(pos)) + '</small><b>' + esc(novo) + '</b>';
    } else o = 'Ajuste da <b>' + esc(nome) + '</b>';
    var sol = partesSolicitante(val('SOLICITANTE'));
    var just = nomeJust(textoOpcao('COD_JUSTIFICATIVA'));
    var fato = function (rot, v) { return v ? '<div class="nc-ab-fato2"><dt>' + rot + '</dt><dd>' + v + '</dd></div>' : ''; };
    var ap = lerAprovadores(), apTxt = '';
    /* sem a aba "Aprovadores" (os aprovadores já aparecem logo abaixo), a faixa não tem o link */
    var abaAp = document.querySelector('a[href="#APRV"]'), temAba = !!abaAp && abaAp.offsetParent !== null;
    if (ap.length) {
      var ok = ap.filter(function (x) { return x.estado === 'ok'; }).length, nao = ap.filter(function (x) { return x.estado === 'nao'; })[0], vez = ap.filter(function (x) { return x.estado === 'pend'; })[0];
      var apTom = nao ? 'nao' : vez ? 'anda' : 'ok';
      apTxt = '<div class="nc-ab-apfaixa nc-ab-apfaixa--' + apTom + '">' + svg(nao ? IC.x : vez ? IC.relogio : IC.ok) +
        '<span>' + (nao ? '<b>Reprovado</b> por ' + esc(nao.nome) : vez ? '<b>' + ok + ' de ' + ap.length + '</b> aprovaram · aguardando <b>' + esc(vez.nome) + '</b>' : '<b>Aprovado por todos</b> · ' + ok + ' de ' + ap.length) + '</span>' +
        (temAba ? '<button type="button" class="nc-ab-link" data-ver-aprov>Ver quem aprovou</button>' : '') + '</div>';
    }
    html(B.resumo,
      '<div class="nc-ab-resumo-topo"><span class="nc-ab-sit nc-ab-sit--' + tom + '">' + svg(tom === 'ok' ? IC.ok : tom === 'nao' ? IC.x : IC.relogio) + esc(sit || 'Sem situação') + '</span>' +
        '<span class="nc-ab-resumo-n">Pedido nº <b>' + esc(val('COD_REQ')) + '</b>' + (val('DT_REQ') ? ' · aberto em ' + esc(val('DT_REQ')) : '') + '</span></div>' +
      '<p class="nc-ab-resumo-dia">' + svg(IC.cal) + esc(d ? porExtenso(d) : val('DATA')) + '</p>' +
      (antes ? '<div class="nc-ab-mud" aria-hidden="true"><div class="nc-ab-mud-antes">' + antes + '</div>' + svg(IC.seta) + '<div class="nc-ab-mud-depois">' + depois + '</div></div>' : '') +
      '<p class="nc-ab-frase-o">' + o + '</p>' +
      (just ? '<div class="nc-ab-motivo-dest">' + svg(IC.balao || IC.lapis) + '<div><p class="nc-ab-motivo-rot">Motivo</p><p class="nc-ab-motivo-v">' + esc(just) + '</p>' +
        (val('COMENTARIOS') ? '<p class="nc-ab-motivo-com">“' + esc(val('COMENTARIOS')) + '”</p>' : '') + '</div></div>' : '') +
      '<dl class="nc-ab-fatos2">' +
        fato('Pedido por', esc(sol.pessoa)) +
        fato('Empresa', esc(sol.empresa)) +
        fato(tom === 'anda' ? 'Situação desde' : sit ? esc(sit) + ' em' : 'Situação em', esc(val('DT_SIT_REQ'))) +
      '</dl>' +
      (val('COMENTARIOS') && !just ? '<p class="nc-ab-coment">“' + esc(val('COMENTARIOS')) + '”</p>' : '') + apTxt);
    desenharAprovadores(ap);
    /* "O motivo" já está no resumo: a caixa só aparece com os campos abertos ou com comprovante */
    var comp = cont('ARQUIVO_JUST');
    classe(B.just, 'nc-ab-oculto', !document.body.classList.contains('nc-ab-campos') && !(comp && comp.offsetParent !== null && !comp.classList.contains('nc-ab-vazio')));
    /* os campos vazios da consulta saem (Vira Dia, Horário Previsto, Plantão "Não"…) */
    [].forEach.call(document.querySelectorAll('.nc-ab-reg .t-Form-fieldContainer'), function (c) {
      var i = c.querySelector('input:not([type=hidden]), select, textarea, .display_only');
      var v = i ? (i.tagName === 'SELECT' ? (i.value ? 'x' : '') : String(i.value || i.textContent || '').trim()) : 'x';
      if (i && i.type === 'checkbox') v = i.checked ? 'x' : '';
      classe(c, 'nc-ab-vazio', !v);
      /* caixa de marcar ("Apagar Marcação Realizada ?") numa leitura: Sim ou Não, por escrito */
      var cx = c.querySelector('input[type="checkbox"]');
      if (cx) {
        var sn = c.querySelector('.nc-ab-sn');
        if (!sn) { sn = el('span', 'nc-ab-sn'); (c.querySelector('.t-Form-inputContainer') || c).appendChild(sn); }
        sn.textContent = [].some.call(c.querySelectorAll('input[type="checkbox"]'), function (x) { return x.checked; }) ? 'Sim' : 'Não';
        classe(c, 'nc-ab-vazio', false);
      }
    });
    /* o comprovante só aparece quando há arquivo (um link para baixar) */
    if (comp) classe(comp, 'nc-ab-vazio', !comp.querySelector('a[href]:not([href="#"]):not([href^="javascript"])'));
  }

  /* ═══ [J13] A ABA APROVADORES: O CAMINHO DA APROVAÇÃO ═══════════════════════════════════════
     O QUE FAZ  O relatório "Aprovadores" (região APRV: Aprovador · Data · Status · Seq Aprov ·
                Justificativa) vira um caminho de cima para baixo: cada aprovador com o seu sinal
                (✓ aprovou, ✕ reprovou, ⏱ aguardando), o nome, "Empresa 700 · matrícula 365785",
                a situação, a data e a justificativa. No alto, o resumo ("2 de 2 aprovaram"). A
                aba ganha a contagem ("Aprovadores 2/2"). O relatório original continua na
                página, escondido.
     LÊ DE      as colunas do relatório pelo nome: APROVADOR, DATA, STATUS, JUSTIFICATIVA.
     CUIDADO    Se uma coluna for renomeada no relatório, ajuste o nome em lerAprovadores.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function abrirAba(id) {
    var a = document.querySelector('a[href="#' + id + '"]');
    if (a) a.click();
  }
  function lerAprovadores() {
    var reg = document.getElementById('APRV'); if (!reg) return [];
    return [].filter.call(reg.querySelectorAll('tbody tr'), function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); var t = td ? td.textContent.replace(/\s+/g, ' ').trim() : ''; return /^-+$/.test(t) ? '' : t; }
      var q = c('APROVADOR'), m = /^\s*(\d+)\s*-\s*(\d+)\s*-\s*(.+)$/.exec(q), st = c('STATUS');
      return {
        nome: m ? nomeJust(m[3]) : q, meta: m ? 'Empresa ' + m[1] + ' · matrícula ' + m[2] : '', data: c('DATA'), status: st, just: c('JUSTIFICATIVA'),
        estado: /reprov|recus|negad|cancel/i.test(st) ? 'nao' : /aprov|conclu/i.test(st) ? 'ok' : 'pend'
      };
    });
  }
  function montarAprovadores() {
    var reg = document.getElementById('APRV'); if (!reg) return;
    reg.classList.add('nc-ab-aprv');
    var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
    B.caminho = el('div', 'nc-ab-caminho');
    corpo.insertBefore(B.caminho, corpo.firstChild);
  }
  function desenharAprovadores(ap) {
    if (!B.caminho) return;
    var aba = document.querySelector('a[href="#APRV"]');
    if (aba) {
      var b = aba.querySelector('.nc-ab-aba-n'); if (!b) { b = el('span', 'nc-ab-aba-n'); aba.appendChild(b); }
      var ok = ap.filter(function (x) { return x.estado === 'ok'; }).length;
      html(b, ap.length ? ok + '/' + ap.length : '');
      b.hidden = !ap.length;
    }
    var vez = -1; ap.some(function (x, i) { if (x.estado === 'pend') { vez = i; return true; } return false; });
    var nao = ap.filter(function (x) { return x.estado === 'nao'; })[0];
    var okN = ap.filter(function (x) { return x.estado === 'ok'; }).length;
    html(B.caminho, !ap.length ? '<p class="nc-ab-nota">Este pedido ainda não tem aprovadores.</p>' :
      '<p class="nc-ab-caminho-tit">Aprovação</p><p class="nc-ab-caminho-res">' + (nao ? '<b>Reprovado</b> por ' + esc(nao.nome) : vez >= 0 ? '<b>' + okN + ' de ' + ap.length + '</b> aprovaram · aguardando <b>' + esc(ap[vez].nome) + '</b>' : '<b>Aprovado por todos</b> · ' + okN + ' de ' + ap.length) + '</p>' +
      '<ol class="nc-ab-caminho-lista">' + ap.map(function (x, i) {
        var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === vez ? 'is-vez' : 'is-fila';
        var rot = x.estado === 'ok' ? (x.status || 'Aprovou') : x.estado === 'nao' ? (x.status || 'Reprovou') : i === vez ? 'Aguardando' : 'Na fila';
        return '<li class="nc-ab-ap ' + cls + '"><span class="nc-ab-ap-marca" aria-hidden="true">' + svg(x.estado === 'ok' ? IC.ok : x.estado === 'nao' ? IC.x : IC.relogio) + '</span>' +
          '<div class="nc-ab-ap-txt"><p class="nc-ab-ap-nome">' + esc(x.nome) + '</p>' + (x.meta ? '<p class="nc-ab-ap-meta">' + esc(x.meta) + '</p>' : '') +
          (x.just ? '<p class="nc-ab-ap-just">“' + esc(x.just) + '”</p>' : '') + '</div>' +
          '<div class="nc-ab-ap-fim"><span class="nc-ab-ap-st">' + esc(rot) + '</span>' + (x.data ? '<small>' + esc(x.data) + '</small>' : '') + '</div></li>';
      }).join('') + '</ol>');
  }

  /* ═══ [J10] O MAESTRO: QUANDO REDESENHAR ══════════════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a janela abre: monta e desenha. Depois, redesenha
                sempre que algo muda: um item é alterado, a página termina uma ida ao servidor,
                um relatório é atualizado, as regiões MARC/JUST são travadas ou destravadas.
     SE DER ERRO  O erro não derruba a janela: aparece no Console (F12 › Console) como
                [Natcorp abono] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var agendado = false;
  function agendar() { if (agendado) return; agendado = true; setTimeout(function () { agendado = false; try { desenhar(); } catch (e) { if (window.console) console.warn('[Natcorp abono]', e); } }, 40); }
  function iniciar() {
    try { if (!montar()) return; } catch (e) { if (window.console) console.warn('[Natcorp abono · montar]', e); return; }
    desenhar();
    /* as ações da página trocam valores, mostram/escondem e habilitam campos: redesenha depois delas */
    $(document).on('change', '[id^="' + P + '"]', agendar);
    $(document).ajaxStop(agendar);
    $(document).on('apexafterrefresh', agendar);
    if (window.MutationObserver) {
      var mo = new MutationObserver(agendar);
      [B.marc, B.just].forEach(function (r) { if (r) mo.observe(r, { attributes: true, subtree: true, attributeFilter: ['disabled', 'style'] }); });
    }
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
