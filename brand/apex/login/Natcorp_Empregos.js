/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · EMPREGOS ANTERIORES  —  o "arrumador" da tela (JavaScript)                     ║
   ║  App 600 (portal Conhecendo Você) · Página 17 · onde a pessoa já trabalhou                ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quem usa: colaborador e candidato, quase todos pelo celular, muitos com pouca leitura.
   Quando a página 17 abre, ele REORGANIZA o que o APEX já desenhou:
     1. O ALTO: diz o que é esta etapa e, se já há empregos, o tempo de trabalho somado
        ("Ao todo: 1 ano e 3 meses de trabalho em 2 empregos").
     2. A LISTA VIRA UMA LINHA DO TEMPO, do mais recente para o mais antigo: empresa, cargo,
        "abr/2023 até fev/2024" com quanto tempo durou ("10 meses"), salário "por mês", cidade
        e "Editar". O cartão inteiro continua sendo o toque que abre a janela da página (p18).
        Sem data de saída, o cartão diz "Emprego atual".
     3. O botão "Adicionar" da página vai para o fim, grande: "Adicionar emprego". Se a página
        o esconde (quem só consulta), ele continua escondido.
     4. Lista vazia diz o que fazer. O botão "Prosseguir" passa a se chamar "Continuar".

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda valor nenhum e não grava nada: a lista, a janela de incluir/editar (página 18)
       e o "Prosseguir" continuam sendo do APEX.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 17 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Empregos.js
     Página 17 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Empregos.css
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Empregos.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
     • A região da lista com Static ID  EMPREGOS_ANTERIORES  (Page Designer › região ›
       Advanced › Static ID). É só por ela que este arquivo acha a lista: a página não tem
       itens de formulário. Se o Static ID mudar, o desenho inteiro deixa de aparecer.
     • A lista é do tipo Media List (cartões com título e descrição).
     • Cada cartão escreve, na descrição, uma linha por informação no formato
       "Rótulo: valor" — "Data de Início: …", "Data de Término: …", "Salário: … - Mensal",
       "Local: …". O arquivo reconhece as linhas pelo rótulo (veja [J3]).
     • O título do cartão é "<b>Empresa</b> | Cargo" (empresa em negrito, cargo depois da barra).
     • Um botão com o texto exato "Adicionar" dentro da região.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Ferramentas ........................ meses, período do salário, funções pequenas  PODE MEXER
     [J2]  O alto e o botão Adicionar ......... títulos e textos do alto                    PODE MEXER
     [J3]  A leitura de cada emprego .......... reconhece "Data de Início:", "Salário:"…   CUIDADO
     [J4]  O cartão de cada emprego ........... "Emprego atual", "Editar", as linhas        PODE MEXER
     [J5]  A linha do tempo, a soma e o vazio . ordem, "Ao todo…", "Nenhum emprego…"        PODE MEXER
     [J6]  O maestro .......................... decide QUANDO cada parte é montada          CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Onde você já trabalhou'  →  'Seus empregos'
     Mudei o rótulo de uma linha da descrição do cartão no APEX (ex.: "Data de Início" virou
     "Admissão") e o cartão perdeu a data
       → [J3]: confira se a palavra nova ainda é reconhecida pelo padrão de busca da linha.
     Acrescentei uma informação nova na descrição do cartão
       → nada a fazer: uma linha com rótulo desconhecido aparece no cartão do jeito que veio.
     O salário aparece com um período estranho ("Mensalista" em vez de "por mês")
       → [J1], lista PERIODO: acrescente o par 'mensalista': 'por mês'.
     A tela ficou "crua" (sem o desenho)
       → confira o Static ID EMPREGOS_ANTERIORES da região e abra o Console do navegador
         (F12 › Console) procurando [Natcorp empregos]. O manual, parte 5, explica o resto.

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
     esc(…) / texto(…)      esc protege um texto antes de pôr na tela; texto lê o que está
                            escrito num pedaço da página (veja [J1]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: esta linha impede que o arquivo rode duas vezes (se a URL estiver repetida na
     página, por exemplo) e que rode fora do APEX. Não apague. */
  if (window.__ncEmpregos || !window.apex || !window.apex.jQuery) return;
  /* CUIDADO: aqui o arquivo acha a região da lista pelo Static ID EMPREGOS_ANTERIORES. Esse id
     aparece duas vezes na página (no título grande e na região da lista): vale o que é REGIÃO.
     Sem essa região, o arquivo para aqui e a página fica com o visual padrão do APEX. */
  var REG = [].filter.call(document.querySelectorAll('[id="EMPREGOS_ANTERIORES"]'), function (r) { return r.classList.contains('t-Region'); })[0];
  if (!REG) return;
  window.__ncEmpregos = true;

  var $ = apex.jQuery;
  /* ═══ [J1] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Listas e funções pequenas usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       texto(pedaço)      o texto que está escrito num pedaço da tela, sem espaços sobrando
       bonito('ACME LTDA') "Acme Ltda" — tira as MAIÚSCULAS e deixa "de", "da", "e" minúsculos
       data('31/12/2026') transforma o texto numa data;  mesAno(data) → "dez/2026"
       duracao(15)        "1 ano e 3 meses" (recebe um número de meses)
     PODE MEXER • MESES: como os meses aparecem escritos ("jan", "fev"…).
                • PERIODO: como o período do salário aparece. À esquerda, o que vem do APEX
                  (em minúsculas); à direita, o que a pessoa lê. Para acrescentar um, copie
                  um par inteiro, por exemplo   mensalista: 'por mês',
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: os meses e os períodos do salário */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  var PERIODO = { mensal: 'por mês', horista: 'por hora', 'por hora': 'por hora', semanal: 'por semana', quinzenal: 'por quinzena', 'diário': 'por dia', diario: 'por dia', diarista: 'por dia', tarefa: 'por tarefa' };
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    maleta: '<rect x="3" y="7" width="18" height="13" rx="2.5"/><path d="M8.5 7V5.5A1.5 1.5 0 0 1 10 4h4a1.5 1.5 0 0 1 1.5 1.5V7M3 12.5h18"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    local: '<path d="M12 21s-6.5-5.6-6.5-11a6.5 6.5 0 0 1 13 0c0 5.4-6.5 11-6.5 11z"/><circle cx="12" cy="10" r="2.5"/>',
    dinheiro: '<rect x="2.5" y="6" width="19" height="12" rx="2"/><circle cx="12" cy="12" r="2.6"/><path d="M6 9.5v5M18 9.5v5"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>'
  };

  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d) { return '<svg class="nc-em-ic" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function texto(e) { return e ? e.textContent.replace(/\s+/g, ' ').trim() : ''; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function oculto(e) { return !e || e.style.display === 'none' || getComputedStyle(e).display === 'none'; }
  /* "ORGANIZAÇÕES ACME" → "Organizações Acme"; "SÃO PAULO/SP" → "São Paulo/SP" */
  function bonito(t) {
    t = String(t || '').trim();
    if (t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t)) t = t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); });
    return t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); })
      .replace(/\/([a-zà-ý]{2})$/i, function (m, uf) { return '/' + uf.toUpperCase(); });
  }
  function data(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function mesAno(d) { return MESES[d.getMonth()] + '/' + d.getFullYear(); }
  function meses(a, b) { var n = (b.getFullYear() - a.getFullYear()) * 12 + (b.getMonth() - a.getMonth()); if (b.getDate() < a.getDate()) n--; return Math.max(n, 0); }
  function duracao(n) {
    if (n < 1) return 'menos de 1 mês';
    var a = Math.floor(n / 12), m = n % 12;
    return (a ? a + (a > 1 ? ' anos' : ' ano') : '') + (a && m ? ' e ' : '') + (m ? m + (m > 1 ? ' meses' : ' mês') : '');
  }

  /* ═══ [J2] O ALTO E O BOTÃO ADICIONAR ════════════════════════════════════════════════════
     O QUE FAZ  Roda uma vez, quando a página abre:
                • cria o bloco do alto ("Onde você já trabalhou" + explicação), logo acima da região;
                • leva o botão "Adicionar" da página para o fim da lista, com o texto
                  "Adicionar emprego" e um sinal de +. É o MESMO botão do APEX: a ação dele
                  (abrir a janela da página 18) não muda;
                • troca o texto do botão "Prosseguir" para "Continuar".
     CUIDADO    O botão é achado pelo texto exato "Adicionar". Se o rótulo dele mudar no APEX,
                troque também a palavra entre barras em  /^adicionar$/i  logo abaixo.
     PODE MEXER os textos entre aspas: o título, a explicação, 'Adicionar emprego', 'Continuar'.
     VISUAL     Natcorp_Empregos.css › [C2] (o alto) e [C5] (o botão Adicionar)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var TOPO, VAGA, ADD, VAZIO, LISTA_UL;
  function montar() {
    REG.classList.add('nc-em-reg');
    var corpo = REG.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    if (!corpo) return false;
    TOPO = el('div', 'nc-em-topo');
    TOPO.innerHTML = '<span class="nc-em-topo-ic">' + svg(IC.maleta) + '</span><div><h2 class="nc-em-tit">Onde você já trabalhou</h2>' +
      '<p class="nc-em-txt">Coloque os lugares onde você já trabalhou, com o cargo e as datas. Se ainda não trabalhou, é só tocar em <b>Continuar</b>.</p>' +
      '<p class="nc-em-soma" hidden></p></div>';
    REG.parentNode.insertBefore(TOPO, REG);

    ADD = [].filter.call(REG.querySelectorAll('.t-Button'), function (b) { return /^adicionar$/i.test(texto(b)); })[0];
    VAGA = el('div', 'nc-em-add');
    VAZIO = el('div', 'nc-em-vazio');
    VAZIO.hidden = true;
    var lista = corpo.querySelector('.t-MediaList, .nodatafound, .t-Report-noDataMsg');
    var bl = lista; while (bl && bl.parentNode !== corpo) bl = bl.parentNode;
    corpo.insertBefore(VAZIO, bl ? bl.nextSibling : null);
    corpo.insertBefore(VAGA, VAZIO.nextSibling);
    if (ADD) {
      var velho = ADD.closest('.container');
      var l = ADD.querySelector('.t-Button-label') || ADD;
      l.textContent = 'Adicionar emprego';
      ADD.classList.add('nc-em-add-bt');
      if (!ADD.querySelector('.nc-em-ic')) ADD.insertAdjacentHTML('afterbegin', svg(IC.mais));
      VAGA.appendChild(ADD);
      if (velho && !velho.querySelector('.t-Button, .t-Form-fieldContainer, .t-Region, a, input, select, textarea')) velho.classList.add('nc-em-oculto');
    }
    [].forEach.call(document.querySelectorAll('.t-Button .t-Button-label'), function (x) {
      if (/^\s*prosseguir\s*$/i.test(x.textContent)) x.textContent = 'Continuar';
    });
    return true;
  }

  /* ═══ [J3] A LEITURA DE CADA EMPREGO ═════════════════════════════════════════════════════
     O QUE FAZ  Lê o cartão que o APEX desenhou e separa as informações:
                  título    "<b>Empresa</b> | Cargo"  → empresa (o negrito) e cargo (depois da |)
                  descrição uma linha por informação, "Rótulo: valor"
     COMO RECONHECE CADA LINHA (pelo rótulo, sem diferença entre maiúsculas e minúsculas):
                  início    rótulo com "início" ou "admiss"                → data de entrada
                  término   rótulo com "término", "saída", "desliga", "fim" → data de saída
                  salário   rótulo com "salário"; o que vem depois de " - " é o período
                            ("1.500,00 - Mensal" → "1.500,00 por mês", pela lista PERIODO)
                  local     rótulo com "local" ou "cidade"
                  outra     qualquer outro rótulo: aparece no cartão do jeito que veio
     CUIDADO    Os trechos entre barras, como /sal[aá]rio/, são "padrões de busca" (expressões
                regulares). [aá] quer dizer "a ou á"; | quer dizer "ou". Para reconhecer um
                rótulo novo, acrescente  |palavra  dentro do padrão certo — e só isso.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* cada emprego: lido do cartão da página ("<b>Empresa</b> | Cargo" e "Rótulo: valor" por linha) */
  function ler(li) {
    var h = li.querySelector('.t-MediaList-title'), d = li.querySelector('.t-MediaList-desc');
    var o = { empresa: bonito(texto(h && h.querySelector('b')) || texto(h)), cargo: '', ini: null, fim: null, salario: '', local: '', outros: [] };
    var m = /\|\s*(.+)$/.exec(texto(h)); if (m) o.cargo = bonito(m[1]);
    if (d) d.innerHTML.split(/<br\s*\/?>/i).forEach(function (p) {
      var k = document.createElement('div'); k.innerHTML = p;
      var s = texto(k); if (!s) return;
      var mm = /^([^:]{1,40}):\s*(.*)$/.exec(s), r = mm ? mm[1].toLowerCase() : '', v = mm ? mm[2].trim() : s;
      if (/in[ií]cio|admiss/.test(r)) o.ini = data(v);
      else if (/t[eé]rmino|sa[ií]da|desliga|fim/.test(r)) o.fim = data(v);
      else if (/sal[aá]rio/.test(r)) {
        var sp = v.split(/\s+-\s+/);
        o.salario = sp[0] + (sp[1] ? ' ' + (PERIODO[sp[1].trim().toLowerCase()] || sp[1].toLowerCase()) : '');
      }
      else if (/local|cidade/.test(r)) o.local = bonito(v);
      else o.outros.push(mm ? mm[1] + ': ' + v : v);
    });
    return o;
  }
  /* ═══ [J4] O CARTÃO DE CADA EMPREGO ══════════════════════════════════════════════════════
     O QUE FAZ  Monta o cartão novo DENTRO do link do APEX (o toque continua abrindo a janela
                de edição, página 18): selo "Emprego atual" (quando não há data de saída),
                empresa, cargo, período com a duração, salário, cidade, as outras linhas e
                "Editar". Cada cartão é montado uma vez só.
     PODE MEXER os textos entre aspas: 'Emprego atual', ' até ', ' até hoje', 'Editar'.
     VISUAL     Natcorp_Empregos.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function preparar(li) {
    if (li.__nc) return li.__nc;
    var a = li.querySelector('.t-MediaList-itemWrap'); if (!a) return null;
    var o = ler(li);
    var hoje = new Date(), fim = o.fim || hoje, n = o.ini ? meses(o.ini, fim) : null;
    var quando = o.ini ? mesAno(o.ini) + (o.fim ? ' até ' + mesAno(o.fim) : ' até hoje') : (o.fim ? 'até ' + mesAno(o.fim) : '');
    var novo = el('span', 'nc-em-item');
    novo.innerHTML = '<span class="nc-em-item-txt">' +
      (!o.fim && o.ini ? '<span class="nc-em-atual">Emprego atual</span>' : '') +
      '<span class="nc-em-empresa">' + esc(o.empresa) + '</span>' +
      (o.cargo ? '<span class="nc-em-cargo">' + esc(o.cargo) + '</span>' : '') +
      (quando ? '<span class="nc-em-linha">' + svg(IC.relogio) + '<span>' + esc(quando) + (n !== null ? ' <b class="nc-em-dura">' + esc(duracao(n)) + '</b>' : '') + '</span></span>' : '') +
      (o.salario ? '<span class="nc-em-linha">' + svg(IC.dinheiro) + '<span>' + esc(o.salario) + '</span></span>' : '') +
      (o.local ? '<span class="nc-em-linha">' + svg(IC.local) + '<span>' + esc(o.local) + '</span></span>' : '') +
      o.outros.map(function (x) { return '<span class="nc-em-linha nc-em-outro"><span>' + esc(x) + '</span></span>'; }).join('') +
      '</span><span class="nc-em-editar">' + svg(IC.lapis) + 'Editar</span>';
    a.classList.add('nc-em-item-a');
    a.setAttribute('aria-label', 'Editar ' + o.empresa + (o.cargo ? ', ' + o.cargo : '') + (quando ? ', ' + quando : ''));
    a.appendChild(novo);
    li.classList.add('nc-em-li');
    classe(li, 'nc-em-li--atual', !o.fim && !!o.ini);
    li.__nc = { ini: o.ini, n: n };
    return li.__nc;
  }

  /* ═══ [J5] A LINHA DO TEMPO, A SOMA E O VAZIO ════════════════════════════════════════════
     O QUE FAZ  Roda de novo sempre que a lista muda:
                • põe os cartões do mais recente para o mais antigo (pela data de início). Só
                  muda a ORDEM na tela; os links são os mesmos;
                • soma as durações e escreve "Ao todo: … de trabalho em N empregos" no alto;
                • mostra "Adicionar emprego" só se o botão do APEX estiver visível;
                • lista vazia: esconde a mensagem do APEX e mostra "Nenhum emprego por enquanto".
     PODE MEXER os textos entre aspas: 'Ao todo: ', ' de trabalho em ', 'Nenhum emprego por
                enquanto.', 'Toque em “Adicionar emprego”'…
     VISUAL     Natcorp_Empregos.css › [C2] (a soma), [C3] (a linha do tempo), [C4] (o vazio)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function atualizar() {
    var ul = REG.querySelector('.t-MediaList');
    var lis = ul ? [].slice.call(ul.querySelectorAll(':scope > .t-MediaList-item')) : [];
    var info = lis.map(function (li) { return { li: li, d: preparar(li) }; }).filter(function (x) { return x.d; });
    /* do mais recente para o mais antigo (só reordena os cartões; os links são os mesmos) */
    if (ul && ul !== LISTA_UL) {
      LISTA_UL = ul;
      ul.classList.add('nc-em-tempo');
      info.slice().sort(function (a, b) { return (b.d.ini || 0) - (a.d.ini || 0); }).forEach(function (x) { ul.appendChild(x.li); });
    }
    var total = info.reduce(function (s, x) { return s + (x.d.n || 0); }, 0);
    var soma = TOPO.querySelector('.nc-em-soma');
    soma.hidden = !info.length;
    html(soma, info.length ? svg(IC.relogio) + '<span>Ao todo: <b>' + esc(duracao(total)) + '</b> de trabalho em ' + info.length + (info.length > 1 ? ' empregos' : ' emprego') + '.</span>' : '');
    var podeAdd = !!(ADD && !oculto(ADD));
    classe(VAGA, 'nc-em-oculto', !podeAdd);
    [].forEach.call(REG.querySelectorAll('.nodatafound, .t-Report-noDataMsg, .t-MediaList-empty'), function (m) { m.classList.add('nc-em-oculto'); });
    VAZIO.hidden = info.length > 0;
    html(VAZIO, '<span class="nc-em-vazio-ic">' + svg(IC.maleta) + '</span><p>Nenhum emprego por enquanto.' + (podeAdd ? ' <b>Toque em “Adicionar emprego”</b> para colocar o primeiro.' : '') + '</p>');
  }

  /* ═══ [J6] O MAESTRO: QUANDO CADA PARTE É MONTADA ══════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a página abre: monta o alto e o botão ([J2]),
                marca a página com a classe nc-em (é ela que liga todo o CSS) e monta a lista
                ([J5]). Depois, monta de novo quando a lista é recarregada (apexafterrefresh),
                quando a página esconde ou mostra algo dentro da região, e uma vez 0,7 s depois
                de abrir (para pegar o que o APEX termina de desenhar por último).
     CUIDADO    Não mude a ordem dentro de iniciar(): o alto precisa existir antes da lista.
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp empregos] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var agendado = false, MO = null;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () {
      agendado = false;
      try { atualizar(); } catch (e) { if (window.console) console.warn('[Natcorp empregos]', e); }
      if (MO) MO.takeRecords();
    });
  }
  function iniciar() {
    if (!montar()) return;
    document.body.classList.add('nc-em');
    atualizar();
    $(document).on('apexafterrefresh', function () { LISTA_UL = null; agendar(); });
    if (window.MutationObserver) {
      /* a ação da página esconde o Adicionar para quem só consulta */
      MO = new MutationObserver(agendar);
      MO.observe(REG, { attributes: true, subtree: true, attributeFilter: ['style'] });
    }
    setTimeout(agendar, 700);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
