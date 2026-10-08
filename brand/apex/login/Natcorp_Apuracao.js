/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE APURAÇÃO  —  o "arrumador" da tela (JavaScript)                  ║
   ║  App 9503 · Página 181 · trocar um evento que a apuração gerou num dia por outro          ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   É a janela que abre em "Pedir ajuste" (a lupa), na lista "O que o dia gerou" da Tratativa
   de Abono (página 203). O gestor pede para TROCAR um evento que a apuração gerou num dia (ex.:
   05:30 de "28 - HE 100%") por outro (ex.: banco de horas). Reclamação de quem usa: "confuso e
   difícil". Eram duas colunas técnicas: à esquerda 8 campos só de leitura (Tipo do Evento,
   Evento, Tipo, Qtde. Horas, Data, Apuração, Evento Conversão, Horas em Requisição), à direita
   listas sem explicação (Tipo do Evento Solicitado, Origem Atual/Remanescente, 43 eventos — com
   "(não utilizar)" e "TESTE" no meio) e "HH:MM".
   Este arquivo transforma isso numa conversa, numa coluna só:
     • O EVENTO DESTE DIA — "28 - HE 100%", "05:30 · soma · Ponto · quinta-feira, 13/03/2025 ·
       apuração fechada" e, se houver, "01:00 já estão em outro pedido";
     • VAI PARA ONDE? — cartões Banco de horas / Ponto (o Tipo do Evento Solicitado);
     • DE ONDE VÊM AS HORAS? — "Deste dia" / "Do saldo que sobrou" (Origem), com o saldo;
     • QUAL EVENTO? — os eventos em botões, com busca; os que a empresa marcou "(não utilizar)"
       e os de teste ficam atrás de "Mais eventos";
     • QUANTAS HORAS? — com os atalhos "Todas as horas (05:30)" e "Metade";
     • OBSERVAÇÃO — começos de frase;
     • no pé, a frase do pedido, o que falta e "Enviar pedido" (é o Criar Requisição).
   Num pedido já existente (quem aprova), mostra a frase do pedido no alto e a situação.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não grava nada: o APEX continua dono de tudo. As listas e campos substituídos ficam na
       página, escondidos nas mesmas regiões.
     • Cada escolha só usa apex.item().setValue, que dispara as ações dinâmicas da página como
       se a pessoa tivesse digitado. A ordem é a das ações da página: o tipo traz Origem e
       saldo; o evento traz o tipo (soma/desconta) e confere se é igual ao atual; as horas são
       conferidas COM o evento escolhido (algumas conferências da página fecham a janela — é
       comportamento da página, não do desenho).
     • Se este arquivo for retirado da página, a janela volta ao visual padrão do APEX e
       continua funcionando normalmente.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 181 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Apuracao.js
     ATENÇÃO: esta página não tem exportação no projeto — a URL é posta À MÃO no Page Designer
     (e a do CSS também: #WORKSPACE_IMAGES#Natcorp_Apuracao.css).
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Apuracao.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Esta página NÃO usa classes no APEX. O arquivo reconhece a janela pelos itens
   …_COD_EVENTO_NOVO + …_QTD_HORAS_NOVO + …_TIPO_EVENTO_NOVO (pedido novo) ou
   …_COD_EVENTO_NOVO_DSP (pedido existente); sem eles, não faz nada. E usa:
     • as regiões onde estão os itens EVENTO (o evento deste dia), COD_EVENTO_NOVO (trocar por)
       e OBSERVA (observação);
     • os itens pelo nome: MATRICULA, COD_EMPRESA, DATA, QTD_HORAS, TIPO, TIPO_EVENTO,
       BH_APURADO, EVENTO_CONVERSAO, HORAS_REQUISICAO, TIPO_EVENTO_NOVO, ORIGEM, SALDO_REMAN,
       COD_EVENTO_NOVO, TIPO_NOVO, TIPO_DISP_NOVO, QTD_HORAS_NOVO, DATA_PONTO; e os _DSP do
       pedido existente;
     • os botões pelo texto: "Criar Requisição" (ou "Enviar pedido"), "Apuração Justificativa"
       (ou "Só justificar"), "Aprovar", "Reprovar".

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Dias e ícones ....................... como o dia da semana aparece          PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  A montagem .......................... as perguntas e a observação          PODE MEXER
     [J4]  Botões e o campo das horas .......... "Enviar pedido", "Só justificar"      PODE MEXER
     [J5]  O pedido existente (quem aprova) .... a frase do pedido e a situação       PODE MEXER
     [J6]  Eventos pouco usados ................ o que vai para "Mais eventos"        CUIDADO
     [J7]  O desenho ........................... redesenha tudo a cada mudança        PODE MEXER
     [J8]  O maestro ........................... decide QUANDO redesenhar             CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Vai para onde?'  →  'Para onde vão as horas?'
     Quero mudar os começos de frase da observação    → [J3], a lista logo depois de
                                                        'nc-ap-comecos'
     Quero mudar a explicação de "Banco de horas" / "Ponto (folha)"   → [J7], lista DESC
     Um evento novo apareceu na lista
       → nada a fazer: os botões vêm da lista do APEX, sozinhos. Se o nome dele tiver
         "(não utilizar)" ou "teste", vai para "Mais eventos" (veja [J6]).
     A janela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp apuração].
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
     P + 'ORIGEM'         junta os textos: vira 'P181_ORIGEM', o nome do item no APEX.
                            (Aqui o P é descoberto sozinho: veja o começo do código.)
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: esta linha impede que o arquivo rode duas vezes (se a URL estiver repetida na
     página, por exemplo) e que rode fora do APEX. Não apague. */
  if (window.__ncApuracao || !window.apex || !window.apex.jQuery) return;
  /* O começo do nome dos itens (P) é DESCOBERTO sozinho, a partir do item …_COD_EVENTO_NOVO
     (ou …_COD_EVENTO_NOVO_DSP): se a página for copiada para outro número, não é preciso mudar
     nada aqui. EXISTENTE = é um pedido já feito (quem aprova está olhando). */
  /* pedido novo: a lista do evento solicitado; pedido existente (quem aprova): os campos _DSP */
  var ach = document.querySelector('[id$="_COD_EVENTO_NOVO_CONTAINER"]') || document.querySelector('[id$="_COD_EVENTO_NOVO_DSP_CONTAINER"]');
  if (!ach) return;
  var P = ach.id.replace(/COD_EVENTO_NOVO(_DSP)?_CONTAINER$/, '');
  var EXISTENTE = /_DSP_CONTAINER$/.test(ach.id);
  if (!EXISTENTE && (!document.getElementById(P + 'QTD_HORAS_NOVO') || !document.getElementById(P + 'TIPO_EVENTO_NOVO'))) return;
  window.__ncApuracao = true;

  var $ = apex.jQuery;
  /* ═══ [J1] DIAS E ÍCONES ══════════════════════════════════════════════════════════════════
     O QUE É    Como os dias da semana aparecem escritos e os ícones (desenhos pequenos, no
                formato SVG; não precisa mexer).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: os nomes dos dias da semana (começando no domingo) */
  var SEM = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'];
  var IC = {
    banco: '<path d="M3.5 9.5L12 4l8.5 5.5"/><path d="M5 10v8M9.5 10v8M14.5 10v8M19 10v8M3.5 20h17"/>',
    ponto: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    cal: '<rect x="3.5" y="5" width="17" height="15.5" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    lupa: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    alerta: '<path d="M12 3.5l9.5 16.5h-19z"/><path d="M12 10v4.5M12 17.2v.1"/>',
    cadeado: '<rect x="5" y="10.5" width="14" height="10" rx="2"/><path d="M8 10.5V7.5a4 4 0 0 1 8 0v3"/>',
    seta: '<path d="M4 12h15M14 6.5l5.5 5.5-5.5 5.5"/>',
    baixo: '<path d="M6 9l6 6 6-6"/>',
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>'
  };

  /* ═══ [J2] FERRAMENTAS ════════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('ITEM')       o valor do item
       mostra('ITEM')    o que está À VISTA num item "só exibição"
       textoOpcao('ITEM')  o texto da opção escolhida numa lista
       esconder('ITEM')  esconde o bloco do campo (ele continua na página, funcionando)
       hhmm('5:30')      → "05:30";   minutos('05:30') → 330
       bonito(texto)     "1 - HORAS TRABALHADAS" → "1 - Horas Trabalhadas" (código - descrição)
       sentido(texto)    "Crédito" → 'soma';  "Débito" → 'desconta'
       depois(fn)        espera as idas ao servidor que estão a caminho e só então roda fn
     PODE MEXER as siglas que bonito() mantém em maiúsculas (HE, DSR, CLT, BH).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d) { return '<svg class="nc-ap-ic" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function texto(e) { return e ? e.textContent.replace(/\s+/g, ' ').trim() : ''; }
  function item(n) { return document.getElementById(P + n); }
  function cont(n) { return document.getElementById(P + n + '_CONTAINER'); }
  function val(n) {
    var e = item(n); if (!e) return '';
    if (e.tagName === 'SPAN' || e.tagName === 'DIV') return texto(e);
    return String(e.value || '').trim();
  }
  /* o valor à vista de um item "só exibição" (o _DISPLAY quando existe) */
  function mostra(n) { var d = item(n + '_DISPLAY'); return d ? texto(d) : val(n); }
  function textoOpcao(n) { var s = item(n); return s && s.options && s.selectedIndex >= 0 && s.value ? s.options[s.selectedIndex].text : ''; }
  function esconder(n) { var c = cont(n); if (c) c.classList.add('nc-ap-oculto'); }
  function visivel(n) { var c = cont(n); return !!(c && c.offsetParent !== null && !c.classList.contains('nc-ap-oculto')); }
  function dataDe(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function hhmm(t) { var m = /(\d{1,3}):(\d{2})/.exec(t || ''); return m ? (m[1].length < 2 ? '0' : '') + m[1] + ':' + m[2] : ''; }
  function minutos(t) { var m = /(\d{1,3}):(\d{2})/.exec(t || ''); return m ? +m[1] * 60 + +m[2] : null; }
  /* "28 - HE 100%" / "1 - HORAS TRABALHADAS" → "28 - HE 100%" / "1 - Horas Trabalhadas" (código - descrição) */
  function bonito(t) {
    t = String(t || '').replace(/\s+/g, ' ').trim();
    var m = /^(\d+)\s*-\s*(.*)$/.exec(t), cod = m ? m[1] + ' - ' : '', d = m ? m[2] : t;
    if (d === d.toUpperCase()) d = d.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (x, a, b) { return a + b.toUpperCase(); }).replace(/\bHe\b/g, 'HE').replace(/\bDsr\b/g, 'DSR').replace(/\bClt\b/g, 'CLT').replace(/\bBh\b/g, 'BH');
    return cod + d.replace(/(\s)(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (x, a, w) { return a + w.toLowerCase(); });
  }
  /* soma / desconta, pelo "Crédito / Débito" da página */
  function sentido(t) { return /d[eé]bito/i.test(t) ? 'desconta' : /cr[eé]dito/i.test(t) ? 'soma' : ''; }
  function depois(fn) { if ($.active) $(document).one('ajaxStop', function () { setTimeout(fn, 0); }); else fn(); }

  var B = { mais: false, busca: '' };

  function regiaoPorTitulo(re) {
    return [].filter.call(document.querySelectorAll('.t-Region'), function (r) { return re.test(texto(r.querySelector(':scope > .t-Region-header .t-Region-title'))); })[0] || null;
  }
  function corpo(r) { return r.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || r; }
  function titulo(r, t) { var h = r && r.querySelector(':scope > .t-Region-header .t-Region-title'); if (h) h.textContent = t; }
  function rotulo(n, t) {
    var l = document.getElementById(P + n + '_LABEL'); if (!l || l.getAttribute('data-nc-ap')) return;
    var tn = [].filter.call(l.childNodes, function (x) { return x.nodeType === 3 && x.textContent.trim(); })[0];
    if (tn) { tn.textContent = t + ' '; l.setAttribute('data-nc-ap', '1'); }
  }

  /* ═══ [J3] A MONTAGEM: AS PERGUNTAS DA JANELA ═════════════════════════════════════════════
     O QUE FAZ  montar() roda uma vez, quando a janela abre:
                  • esconde a aba única "Eventos" (só o item da aba: o ul.apex-rds envolve as
                    regiões e não pode sumir);
                  • renomeia as regiões ("O evento deste dia", "Trocar por", "Quer explicar?");
                  • junta colaborador e empresa numa linha;
                  • põe o cartão do evento no lugar dos 8 campos só de leitura;
                  • cria as 4 perguntas e leva para dentro delas o campo das horas e o saldo;
                  • põe os começos de frase na observação e, no pé, a frase do pedido.
                Num pedido existente, monta o resumo ([J5]) em vez das perguntas.
     PODE MEXER os textos entre aspas, a lista de começos de frase da observação e o exemplo
                dentro da caixa ('Ex.: combinado com o colaborador…').
     VISUAL     Natcorp_Apuracao.css › [C2] (uma coluna), [C3] (cartão) e [C4] (perguntas)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montar() {
    var atual = cont('EVENTO') && cont('EVENTO').closest('.t-Region');
    var novo = cont(EXISTENTE ? 'COD_EVENTO_NOVO_DSP' : 'COD_EVENTO_NOVO').closest('.t-Region');
    var obs = cont('OBSERVA') && cont('OBSERVA').closest('.t-Region');
    if (!atual || !novo) return false;
    document.body.classList.add('nc-ap-ativo');
    B.atual = atual; B.novo = novo; B.obs = obs;
    [atual, novo, obs].forEach(function (r) { if (r) r.classList.add('nc-ap-reg'); });
    /* a aba única "Eventos" não diz nada (o ul.apex-rds envolve as regiões: só o item da aba sai) */
    [].forEach.call(document.querySelectorAll('ul.t-Tabs'), function (u) { if (u.querySelectorAll(':scope > li').length === 1) u.classList.add('nc-ap-oculto'); });
    titulo(atual, 'O evento deste dia');
    titulo(novo, EXISTENTE ? 'O pedido' : 'Trocar por');
    titulo(obs, EXISTENTE ? 'Observação' : 'Quer explicar? (se quiser)');

    /* quem: uma linha só (eram dois campos grandes) */
    var colab = cont('MATRICULA'), emp = cont('COD_EMPRESA');
    if (colab) {
      var quem = el('p', 'nc-ap-quem', svg(IC.pessoa) + '<span><b>' + esc(bonito(mostra('MATRICULA'))) + '</b>' + (mostra('COD_EMPRESA') ? ' · ' + esc(bonito(mostra('COD_EMPRESA'))) : '') + '</span>');
      colab.parentNode.insertBefore(quem, emp && emp.parentNode === colab.parentNode ? emp : colab);
      esconder('MATRICULA'); esconder('COD_EMPRESA');
    }

    /* o evento deste dia: um cartão no lugar dos 8 campos só de leitura */
    B.cartao = el('div', 'nc-ap-evento');
    corpo(atual).insertBefore(B.cartao, corpo(atual).firstChild);
    [].forEach.call(atual.querySelectorAll('.t-Form-fieldContainer'), function (c) { c.classList.add('nc-ap-oculto'); });

    botoes();
    if (EXISTENTE) { montarExistente(); return true; }

    /* trocar por: as perguntas */
    var cn = corpo(novo);
    B.perg = el('div', 'nc-ap-perguntas',
      '<div class="nc-ap-bloco" data-b="tipo"><p class="nc-ap-perg">Vai para onde?</p><div class="nc-ap-cartoes" role="radiogroup" aria-label="Vai para onde"></div></div>' +
      '<div class="nc-ap-bloco" data-b="origem"><p class="nc-ap-perg">De onde vêm as horas?</p><div class="nc-ap-opcs" role="radiogroup" aria-label="De onde vêm as horas"></div><div class="nc-ap-saldo"></div></div>' +
      '<div class="nc-ap-bloco" data-b="evento"><p class="nc-ap-perg">Qual evento?</p><div class="nc-ap-escolhido" hidden></div>' +
        '<div class="nc-ap-escolha"><div class="nc-ap-busca">' + svg(IC.lupa) + '<input type="search" placeholder="Procurar o evento pelo nome ou número" aria-label="Procurar o evento"></div><div class="nc-ap-eventos" role="radiogroup" aria-label="Qual evento"></div></div></div>' +
      '<div class="nc-ap-bloco" data-b="horas"><p class="nc-ap-perg">Quantas horas?</p><div class="nc-ap-horas-linha"></div><div class="nc-ap-atalhos"></div></div>');
    cn.insertBefore(B.perg, cn.firstChild);
    ['TIPO_EVENTO_NOVO', 'ORIGEM', 'COD_EVENTO_NOVO', 'TIPO_DISP_NOVO', 'DATA_PONTO'].forEach(esconder);
    var hc = cont('QTD_HORAS_NOVO');
    if (hc) B.perg.querySelector('.nc-ap-horas-linha').appendChild(hc);
    var sr = cont('SALDO_REMAN');
    if (sr) B.perg.querySelector('.nc-ap-saldo').appendChild(sr);
    rotulo('SALDO_REMAN', 'Saldo que sobrou');
    campoHoras();

    B.perg.addEventListener('click', function (e) {
      var t = e.target.closest('[data-tipo]'); if (t && !t.disabled) { if (val('TIPO_EVENTO_NOVO') !== t.getAttribute('data-tipo')) apex.item(P + 'TIPO_EVENTO_NOVO').setValue(t.getAttribute('data-tipo')); return; }
      var o = e.target.closest('[data-origem]'); if (o && !o.disabled) { if (val('ORIGEM') !== o.getAttribute('data-origem')) apex.item(P + 'ORIGEM').setValue(o.getAttribute('data-origem')); return; }
      var v = e.target.closest('[data-ev]'); if (v && !v.disabled) { B.trocar = false; apex.item(P + 'COD_EVENTO_NOVO').setValue(v.getAttribute('data-ev')); desenhar(); return; }
      if (e.target.closest('[data-trocar]')) { B.trocar = true; desenhar(); return; }
      if (e.target.closest('[data-mais]')) { B.mais = !B.mais; desenhar(); return; }
      var h = e.target.closest('[data-h]'); if (h) { definirHoras(h.getAttribute('data-h')); }
    });
    B.perg.querySelector('.nc-ap-busca input').addEventListener('input', function () { B.busca = this.value; desenhar(); });

    /* observação: começos de frase */
    var oc = cont('OBSERVA');
    if (oc) {
      var t = item('OBSERVA');
      rotulo('OBSERVA', 'Observação');
      if (t && !t.getAttribute('placeholder')) t.setAttribute('placeholder', 'Ex.: combinado com o colaborador levar as horas para o banco.');
      var at = el('div', 'nc-ap-comecos', ['Combinado com o colaborador', 'Horas vão para o banco de horas', 'Compensação já combinada', 'Lançado errado na apuração'].map(function (m) { return '<button type="button" class="nc-ap-chip" data-m="' + esc(m) + '">' + esc(m) + '</button>'; }).join(''));
      at.setAttribute('role', 'group'); at.setAttribute('aria-label', 'Começar a observação');
      var ic = oc.querySelector('.t-Form-inputContainer') || oc;
      ic.insertBefore(at, ic.firstChild);
      at.addEventListener('click', function (e) {
        var b = e.target.closest('[data-m]'); if (!b || !t || t.disabled || t.readOnly) return;
        var a = t.value.trim(), m = b.getAttribute('data-m');
        if (a.indexOf(m) < 0) apex.item(t.id).setValue(a ? a.replace(/[.\s]*$/, '') + '. ' + m : m);
        t.focus(); t.setSelectionRange(t.value.length, t.value.length);
      });
    }

    if (B.criar) {
      var area = B.criar.closest('.t-ButtonRegion, .t-Region') || B.criar.parentNode;
      B.pe = el('div', 'nc-ap-pe', '<div class="nc-ap-frase"></div><p class="nc-ap-falta"></p>');
      area.parentNode.insertBefore(B.pe, area);
      B.pe.addEventListener('click', function (e) {
        var b = e.target.closest('[data-ir]'); if (!b) return;
        var alvo = B.perg.querySelector('[data-b="' + b.getAttribute('data-ir') + '"]');
        if (alvo) { alvo.scrollIntoView({ behavior: 'smooth', block: 'center' }); alvo.classList.remove('nc-ap-pisca'); void alvo.offsetWidth; alvo.classList.add('nc-ap-pisca'); }
      });
    }
    return true;
  }

  /* ═══ [J4] OS BOTÕES E O CAMPO DAS HORAS ══════════════════════════════════════════════════
     O QUE FAZ  • botoes(): "Criar Requisição" passa a dizer "Enviar pedido"; "Apuração
                  Justificativa" passa a dizer "Só justificar, sem trocar"; Aprovar e Reprovar
                  ganham cor. São os mesmos botões, com as mesmas ações.
                • campoHoras(): o campo das horas fica grande, com teclado de números no celular.
                  A máscara (só números, "0530" → "05:30") é da PRÓPRIA página, não daqui.
     CUIDADO    Os botões são achados pelo texto. Se o rótulo mudar no APEX, mude também os
                padrões de busca (entre barras) em botoes().
     PODE MEXER os textos 'Enviar pedido' e 'Só justificar, sem trocar'.
     VISUAL     Natcorp_Apuracao.css › [C5] e [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* os botões: "Criar Requisição" vira "Enviar pedido"; "Apuração Justificativa" diz o que faz
     (a exportação ajustada já traz esses nomes; o desenho reconhece os dois) */
  function botoes() {
    [].forEach.call(document.querySelectorAll('.t-Button'), function (b) {
      var l = b.querySelector('.t-Button-label'), tx = texto(b);
      if (/^(criar requisi|enviar pedido)/i.test(tx)) { if (l) l.textContent = 'Enviar pedido'; b.classList.add('nc-ap-enviar'); if (!B.criar || b.offsetParent) B.criar = b; }
      else if (/^(apura[cç][aã]o justificativa|s[oó] justificar)/i.test(tx)) { if (l) l.textContent = 'Só justificar, sem trocar'; b.classList.add('nc-ap-secundario'); b.title = 'Abre a justificativa do evento, sem pedir a troca'; }
      else if (/^reprovar$/i.test(tx)) b.classList.add('nc-ap-reprovar');
      else if (/^aprovar$/i.test(tx)) b.classList.add('nc-ap-aprovar');
    });
  }
  /* horas: a máscara (só números, "0530" → "05:30") é da própria página; aqui, o tamanho e o teclado */
  function campoHoras() {
    var i = item('QTD_HORAS_NOVO'); if (!i) return;
    i.setAttribute('inputmode', 'numeric');
    i.setAttribute('autocomplete', 'off');
    i.classList.add('nc-ap-horas');
    rotulo('QTD_HORAS_NOVO', 'Horas');
    i.addEventListener('input', function () { setTimeout(desenhar, 0); });
  }

  /* ═══ [J5] O PEDIDO EXISTENTE (QUEM APROVA) ═══════════════════════════════════════════════
     O QUE FAZ  No pedido já feito, o alto mostra "Pedido … · situação", a frase "Trocar 05:30 de
                28 - HE 100% por …", para onde vai, o dia e quem pediu. Os campos do pedido
                (que repetem a frase) ficam atrás de "Ver todos os campos do pedido".
     PODE MEXER a lista SITU: o código da situação (COD_SIT_REQ) → a cor do selo:
                'anda' = em andamento · 'ok' = verde · 'nao' = vermelho. Situação fora da lista
                ganha a cor pelo nome (concluída/aprovada = verde; cancelada/reprovada = vermelho).
     VISUAL     Natcorp_Apuracao.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var SITU = { 1: 'anda', 2: 'ok', 3: 'nao', 4: 'nao', 5: 'ok', 6: 'anda' };
  function montarExistente() {
    B.resumo = el('div', 'nc-ap-resumo');
    corpo(B.atual).insertBefore(B.resumo, corpo(B.atual).firstChild);
    /* os campos do pedido repetem a frase: ficam atrás de um toque */
    B.camposPed = [].slice.call(B.novo.querySelectorAll('.t-Form-fieldContainer'));
    ['COD_REQ', 'DT_REQ', 'COD_SIT_REQ', 'DT_SIT_REQ', 'SOLICITANTE'].forEach(function (n) { if (cont(n)) B.camposPed.push(cont(n)); });
    B.camposPed.forEach(function (c) { c.classList.add('nc-ap-campo-ped'); });
    var ver = el('button', 'nc-ap-link nc-ap-vertodos', 'Ver todos os campos do pedido');
    ver.type = 'button';
    B.resumo.parentNode.insertBefore(ver, B.resumo.nextSibling);
    ver.addEventListener('click', function () { var on = document.body.classList.toggle('nc-ap-campos'); ver.textContent = on ? 'Esconder os campos do pedido' : 'Ver todos os campos do pedido'; desenhar(); });
    rotulo('OBS_APROVADOR', 'Comentário de quem aprova (se quiser)');
  }
  function desenharExistente() {
    var evAtual = bonito(mostra('EVENTO')), h = hhmm(mostra('QTD_HORAS'));
    var ev = bonito(mostra('COD_EVENTO_NOVO_DSP')), hn = hhmm(mostra('QTD_HORAS_NOVO_DSP'));
    var tipo = mostra('TIPO_EVENTO_NOVO_DSP'), sen = sentido(mostra('TIPO_DISP_NOVO_DSP'));
    var s = item('COD_SIT_REQ'), st = s ? s.value : '', sit = textoOpcao('COD_SIT_REQ') || mostra('COD_SIT_REQ');
    var sol = mostra('SOLICITANTE').replace(/^\s*-\s*\/\s*-\s*$/, '').replace(/^.*\/\s*/, '');
    var dt = dataDe(mostra('DATA_PONTO_DSP') || mostra('DATA'));
    html(B.resumo,
      '<div class="nc-ap-resumo-topo">' + (mostra('COD_REQ') ? '<span class="nc-ap-resumo-n">Pedido ' + esc(mostra('COD_REQ')) + '</span>' : '') + (sit ? '<span class="nc-ap-sit nc-ap-sit--' + (SITU[st] || (/conclu|aprov/i.test(sit) ? 'ok' : /cancel|reprov/i.test(sit) ? 'nao' : 'anda')) + '">' + esc(bonito(sit)) + '</span>' : '') + '</div>' +
      '<p class="nc-ap-frase-o">Trocar <b>' + esc(hn || h || '?') + '</b> de ' + esc(evAtual) + ' por <b>' + esc(ev || '?') + '</b>' + (sen ? ' <span class="nc-ap-sentido nc-ap--' + sen + '">' + (sen === 'soma' ? 'soma' : 'desconta') + '</span>' : '') + '</p>' +
      '<p class="nc-ap-frase-sub">' + (tipo ? 'Vai para o ' + esc(/banco/i.test(tipo) ? 'banco de horas' : 'ponto') : '') + (val('ORIGEM_DSP') === '2' ? ' · do saldo que sobrou' : '') + (dt ? ' · ' + esc(SEM[dt.getDay()] + ', ' + (mostra('DATA_PONTO_DSP') || mostra('DATA'))) : '') + '</p>' +
      (sol ? '<p class="nc-ap-frase-sub">Pedido por ' + esc(bonito(sol)) + (mostra('DT_REQ') ? ' em ' + esc(mostra('DT_REQ')) : '') + '</p>' : ''));
  }
  /* (usada em [J7]) o atalho "Todas as horas" / "Metade": escreve as horas depois que as idas
     ao servidor em andamento terminarem */
  function definirHoras(v) {
    var i = item('QTD_HORAS_NOVO'); if (!i || i.disabled || i.readOnly) return;   /* 04/10: não escreve em campo travado */
    depois(function () { apex.item(i.id).setValue(v); desenhar(); });
  }

  /* ═══ [J6] EVENTOS POUCO USADOS ═══════════════════════════════════════════════════════════
     O QUE FAZ  Decide quais eventos vão para trás de "Mais eventos": os que têm no nome
                "não utilizar" ou "teste".
     CUIDADO    O trecho entre barras é um "padrão de busca" (expressão regular). Para
                acrescentar outra palavra, peça ajuda a quem conhece: um erro aqui some com a
                lista toda.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function raro(t) { return /n[aã]o utilizar|\btestes?\d*\b/i.test(t); }

  /* ═══ [J7] O DESENHO: REDESENHA A JANELA A CADA MUDANÇA ═══════════════════════════════════
     O QUE FAZ  • linhasVazias(): esconde as linhas da grade que ficaram só com campos escondidos.
                • desenharCartao(): o cartão do evento deste dia (nome, horas em verde = soma ou
                  vermelho = desconta, tipo, dia, apuração aberta/fechada, conversão, horas já
                  em outro pedido).
                • desenharNovo(): os cartões "Vai para onde?" (lista DESC), "De onde vêm as
                  horas?" (lista ROT_OR), os eventos com busca, as horas com os atalhos e o aviso
                  quando passa das horas do evento.
                • desenharPe(): a frase do pedido e o "Falta: …" ou "Tudo pronto. Confira e envie."
     PODE MEXER os textos entre aspas, e as listas DESC e ROT_OR:
                  DESC    VALOR: ['ícone', 'Título', 'Explicação']   (BANCO, PONTO)
                  ROT_OR  VALOR: 'Texto'                             (1 = Atual, 2 = Remanescente)
                CUIDADO: não troque os VALORES (BANCO, PONTO, 1, 2): são os da lista do APEX.
     VISUAL     Natcorp_Apuracao.css › [C3], [C4] e [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* as linhas do tema que ficaram só com campos escondidos deixavam um vão: saem também */
  function linhasVazias() {
    [B.atual, B.novo].forEach(function (r) {
      if (!r) return;
      [].forEach.call(r.querySelectorAll('.row'), function (row) {
        if (row.querySelector('.nc-ap-perguntas, .nc-ap-evento')) return;
        var vis = [].some.call(row.querySelectorAll('.t-Form-fieldContainer'), function (c) { return !c.classList.contains('nc-ap-oculto') && getComputedStyle(c).display !== 'none'; });
        classe(row, 'nc-ap-oculto', !vis && !!row.querySelector('.t-Form-fieldContainer'));
      });
    });
  }
  function desenhar() {
    linhasVazias();
    if (EXISTENTE) { desenharCartao(); desenharExistente(); return; }
    desenharCartao();
    desenharNovo();
  }
  function desenharCartao() {
    var dt = dataDe(mostra('DATA') || val('DATA_PONTO'));
    var h = hhmm(mostra('QTD_HORAS')), sen = sentido(mostra('TIPO')), ap = mostra('BH_APURADO'), conv = mostra('EVENTO_CONVERSAO'), req = hhmm(mostra('HORAS_REQUISICAO'));
    var evAtual = bonito(mostra('EVENTO'));
    html(B.cartao,
      '<div class="nc-ap-evento-topo"><b class="nc-ap-evento-nome">' + esc(evAtual) + '</b><strong class="nc-ap-evento-h nc-ap--' + (sen || 'neutro') + '">' + esc(h) + '</strong></div>' +
      '<p class="nc-ap-evento-sub">' + (sen ? '<span class="nc-ap-sentido nc-ap--' + sen + '">' + (sen === 'soma' ? 'Soma' : 'Desconta') + '</span>' : '') +
        (mostra('TIPO_EVENTO') ? '<span>' + esc(bonito(mostra('TIPO_EVENTO'))) + '</span>' : '') +
        (dt ? '<span>' + svg(IC.cal) + esc(SEM[dt.getDay()] + ', ' + (mostra('DATA') || val('DATA_PONTO'))) + '</span>' : '') +
        (ap ? '<span>' + (/fech/i.test(ap) ? svg(IC.cadeado) : '') + 'Apuração ' + esc(/fech/i.test(ap) ? 'fechada' : /abert/i.test(ap) ? 'aberta' : ap.toLowerCase()) + '</span>' : '') + '</p>' +
      (conv && conv !== '-' ? '<p class="nc-ap-evento-nota">Convertido em ' + esc(bonito(conv)) + '</p>' : '') +
      (req && minutos(req) > 0 && !EXISTENTE ? '<p class="nc-ap-evento-nota nc-ap-evento-nota--aviso">' + svg(IC.alerta) + '<span><b>' + esc(req) + '</b> deste evento já estão em outro pedido.</span></p>' : ''));
  }
  function desenharNovo() {
    var h = hhmm(mostra('QTD_HORAS')), evAtual = bonito(mostra('EVENTO'));

    /* vai para onde */
    var tipo = val('TIPO_EVENTO_NOVO'), st = item('TIPO_EVENTO_NOVO');
    var DESC = { BANCO: ['banco', 'Banco de horas', 'As horas entram ou saem do banco do colaborador'], PONTO: ['ponto', 'Ponto (folha)', 'Vira outro evento do ponto, que vai para a folha'] };
    html(B.perg.querySelector('[data-b="tipo"] .nc-ap-cartoes'), st && st.options ? [].filter.call(st.options, function (o) { return o.value; }).map(function (o) {
      var d = DESC[o.value.toUpperCase()] || ['ponto', o.text, ''], on = o.value === tipo;
      return '<button type="button" role="radio" aria-checked="' + on + '" class="nc-ap-cartao' + (on ? ' is-on' : '') + '" data-tipo="' + esc(o.value) + '"' + (st.disabled ? ' disabled' : '') + '>' + svg(IC[d[0]]) + '<span><b>' + esc(d[1]) + '</b>' + (d[2] ? '<small>' + esc(d[2]) + '</small>' : '') + '</span></button>';
    }).join('') : '');

    /* de onde vêm as horas (Origem: Atual / Remanescente) — só depois do tipo */
    var so = item('ORIGEM'), orig = val('ORIGEM'), bo = B.perg.querySelector('[data-b="origem"]');
    var ROT_OR = { 1: 'Deste dia', 2: 'Do saldo que sobrou' };
    bo.hidden = !tipo || !so || !so.options || so.options.length < 2;
    html(bo.querySelector('.nc-ap-opcs'), so && so.options ? [].filter.call(so.options, function (o) { return o.value; }).map(function (o) {
      var on = o.value === orig;
      return '<button type="button" role="radio" aria-checked="' + on + '" class="nc-ap-opc' + (on ? ' is-on' : '') + '" data-origem="' + esc(o.value) + '"' + (so.disabled ? ' disabled' : '') + '>' + esc(ROT_OR[o.value] || o.text) + '</button>';
    }).join('') : '');

    /* qual evento */
    var se = item('COD_EVENTO_NOVO'), cod = val('COD_EVENTO_NOVO'), be = B.perg.querySelector('[data-b="evento"]');
    be.hidden = !tipo;
    var opcs = se && se.options ? [].filter.call(se.options, function (o) { return o.value; }) : [];
    var q = (B.busca || '').trim().toLowerCase();
    var recolhe = !!cod && !B.trocar;
    be.querySelector('.nc-ap-escolha').hidden = recolhe;
    be.querySelector('.nc-ap-escolhido').hidden = !recolhe;
    var sNovo = sentido(val('TIPO_NOVO') || mostra('TIPO_DISP_NOVO'));
    html(be.querySelector('.nc-ap-escolhido'), recolhe ? '<span class="nc-ap-ev is-on">' + svg(IC.ok) + '<span>' + esc(bonito(textoOpcao('COD_EVENTO_NOVO'))) + '</span>' + (sNovo ? '<em>' + (sNovo === 'soma' ? 'soma' : 'desconta') + '</em>' : '') + '</span>' + (se.disabled ? '' : '<button type="button" class="nc-ap-link" data-trocar>Trocar o evento</button>') : '');
    var comuns = opcs.filter(function (o) { return !raro(o.text); }), raros = opcs.filter(function (o) { return raro(o.text); });
    var lista = (q ? opcs : comuns.concat(B.mais ? raros : [])).filter(function (o) { return !q || o.text.toLowerCase().indexOf(q) >= 0 || o.value === q; });
    html(be.querySelector('.nc-ap-eventos'), (lista.map(function (o) {
      /* 04/10: a página só recusa o MESMO evento no MESMO tipo (COD_EVENTO e TIPO_EVENTO iguais) */
      var on = o.value === cod, igual = o.value === val('COD_EVENTO') && String(val('TIPO_EVENTO')).toUpperCase() === String(tipo).toUpperCase();
      return '<button type="button" role="radio" aria-checked="' + on + '" class="nc-ap-ev' + (on ? ' is-on' : '') + (raro(o.text) ? ' is-raro' : '') + '" data-ev="' + esc(o.value) + '"' + (se.disabled || igual ? ' disabled' : '') + (igual ? ' title="É o evento atual"' : '') + '>' + (on ? svg(IC.ok) : '') + '<span>' + esc(bonito(o.text)) + '</span>' + (igual ? '<em>atual</em>' : '') + '</button>';
    }).join('') || '<p class="nc-ap-nota">Nenhum evento com esse nome.</p>') +
      (!q && raros.length ? '<button type="button" class="nc-ap-link nc-ap-mais" data-mais>' + (B.mais ? 'Esconder os eventos pouco usados' : 'Mais eventos (' + raros.length + ' pouco usados ou de teste)') + '</button>' : ''));

    /* quantas horas */
    var bh = B.perg.querySelector('[data-b="horas"]'), hn = hhmm(val('QTD_HORAS_NOVO'));
    bh.hidden = !cod;
    var at = [], hi = item('QTD_HORAS_NOVO'), travada = !!(hi && (hi.disabled || hi.readOnly));   /* 04/10: campo travado pela página → sem atalhos */
    if (h && hn !== h && !travada) at.push('<button type="button" class="nc-ap-chip" data-h="' + esc(h) + '">' + svg(IC.relogio) + 'Todas as horas (' + esc(h) + ')</button>');
    var mt = minutos(h);
    if (mt && mt >= 60) { var md = Math.floor(mt / 2), hm = (md < 600 ? '0' : '') + Math.floor(md / 60) + ':' + ('0' + md % 60).slice(-2); if (hm !== hn && !travada) at.push('<button type="button" class="nc-ap-chip" data-h="' + hm + '">Metade (' + hm + ')</button>'); }
    if (hn && h && minutos(hn) > minutos(h)) at.push('<p class="nc-ap-aviso">' + svg(IC.alerta) + '<span>São mais horas do que o evento tem (' + esc(h) + ').</span></p>');
    html(bh.querySelector('.nc-ap-atalhos'), at.join(''));

    desenharPe(evAtual, h, hn, tipo);
  }
  function desenharPe(evAtual, h, hn, tipo) {
    if (!B.pe) return;
    var ev = textoOpcao('COD_EVENTO_NOVO');
    var falta = [];
    if (!tipo) falta.push(['tipo', 'para onde vai']);
    if (tipo && !val('COD_EVENTO_NOVO')) falta.push(['evento', 'qual evento']);
    if (val('COD_EVENTO_NOVO') && !hn) falta.push(['horas', 'quantas horas']);
    var dest = tipo ? (/banco/i.test(tipo) ? 'banco de horas' : 'ponto') : '';
    html(B.pe.querySelector('.nc-ap-frase'), tipo ? '<p class="nc-ap-frase-o">Trocar <b>' + esc(hn || '?') + '</b> de ' + esc(evAtual) + ' por <b>' + esc(ev ? bonito(ev) : '?') + '</b></p><p class="nc-ap-frase-sub">' + (dest ? 'Vai para o ' + esc(dest) : '') + (val('ORIGEM') && item('ORIGEM').options.length > 1 && tipo ? ' · ' + esc(val('ORIGEM') === '2' ? 'do saldo que sobrou' : 'deste dia') : '') + '</p>' : '');
    html(B.pe.querySelector('.nc-ap-falta'), falta.length ? svg(IC.alerta) + '<span>Falta: ' + falta.map(function (f) { return '<button type="button" class="nc-ap-link" data-ir="' + f[0] + '">' + esc(f[1]) + '</button>'; }).join(', ') + '</span>' : svg(IC.ok) + '<span>Tudo pronto. Confira e envie.</span>');
    classe(B.pe.querySelector('.nc-ap-falta'), 'is-pronto', !falta.length);
  }

  /* ═══ [J8] O MAESTRO: QUANDO REDESENHAR ═══════════════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a janela abre: monta e desenha. Depois, redesenha
                sempre que algo muda: um item é alterado, a página termina uma ida ao servidor,
                um relatório é atualizado, um campo é travado ou mostrado.
     SE DER ERRO  O erro não derruba a janela: aparece no Console (F12 › Console) como
                [Natcorp apuração] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var agendado = false;
  function agendar() { if (agendado) return; agendado = true; setTimeout(function () { agendado = false; try { desenhar(); } catch (e) { if (window.console) console.warn('[Natcorp apuração]', e); } }, 40); }
  function iniciar() {
    try { if (!montar()) return; } catch (e) { if (window.console) console.warn('[Natcorp apuração · montar]', e); return; }
    desenhar();
    $(document).on('change', '[id^="' + P + '"]', agendar);
    $(document).ajaxStop(agendar);
    $(document).on('apexafterrefresh', agendar);
    if (window.MutationObserver) {
      var mo = new MutationObserver(agendar);
      [B.novo, B.atual].forEach(function (r) { if (r) mo.observe(r, { attributes: true, subtree: true, attributeFilter: ['disabled', 'style'] }); });
    }
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
