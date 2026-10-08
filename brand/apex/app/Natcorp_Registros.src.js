/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REGISTROS EM CARTÕES  —  o "arrumador" dos relatórios (JavaScript)            ║
   ║  Vale para o SISTEMA TODO: todo Interactive Report e todo Classic Report de tabela       ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia: REGISTROS-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   No alto de cada relatório (Interactive Report ou Classic Report em tabela) põe dois jeitos de
   ver os mesmos registros:
     Tabela    o relatório do APEX, como sempre (bom no computador);
     Cartões   um cartão por registro (bom no celular), NA ORDEM DAS COLUNAS DO RELATÓRIO: a
               primeira coluna é o título ("Requisição 4512"), a situação vira uma etiqueta
               colorida, as quatro colunas seguintes ficam à vista e o resto em "Mais N dados".
               Lista de pessoas (coluna "Colaborador"…): a foto, o nome e o cargo no alto.
               Tocar no cartão faz o mesmo que o link da linha (abre a ficha, o pedido…).
   No celular os relatórios SEMPRE abrem em Cartões (quem passa para Tabela, vale até fechar o
   navegador); no computador abrem em Tabela e a escolha fica guardada.
   E, em todo relatório e grade com barra de rolagem (e no Gantt da Linha do Tempo): clicar e
   arrastar com o mouse move o conteúdo, sem precisar da barra ([R9]).

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não busca nada no banco: lê as linhas que o relatório JÁ desenhou. A pesquisa, os filtros,
       a ordem, as colunas escolhidas em Ações e a paginação continuam sendo os do APEX — e os
       cartões mudam junto quando o relatório é atualizado.
     • Não grava nada, não muda o relatório e não copia campos: relatório com campo de digitar
       ou escolher nas linhas (formulário tabular) fica como está, sem o seletor.
     • Não mexe nas páginas que já têm desenho próprio (as que carregam um Natcorp_<Página>.js,
       como Férias, Ponto, Linha do Tempo): lá o relatório já foi pensado para elas.
     • Relatório pequeno (até 3 colunas de dados, cabendo na largura) fica sem o seletor.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Ninguém precisa pôr nada nas páginas:
       • o CSS está dentro do Natcorp_Style_Min.css (a folha que todas as páginas carregam);
       • este arquivo é carregado pelo Natcorp_Temas.js (que está na aplicação casca, a 200) e
         ele mesmo se repassa para as janelas e os iframes das outras aplicações ([R7]).
     Aplicação aberta FORA da casca (endereço direto)? Ponha este arquivo nas URLs de arquivo
     da aplicação: Componentes Compartilhados › Atributos da Interface do Usuário › JavaScript ›
     URLs de Arquivo:  #WORKSPACE_IMAGES#Natcorp_Registros.js

   ── O "COMBINADO" COM O APEX ──────────────────────────────────────────────────────────────
   Nada precisa de classe. Os papéis das colunas são reconhecidos pelo NOME da coluna (o
   cabeçalho), em PAPEIS ([R2]). A coluna com a foto e a coluna do link (a lupa) são achadas
   pelo conteúdo.
     • classe nc-reg-nao numa região: aquele relatório fica de fora;
     • classe nc-reg-sim numa região: entra mesmo numa página de desenho próprio, ou pequeno.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [R1]  Quais relatórios ganham os cartões                              CUIDADO
     [R2]  Os papéis das colunas (título, subtítulo, selo, destaques)       PODE MEXER
     [R3]  Ferramentas
     [R4]  Ler a tabela que o APEX desenhou
     [R5]  Montar os cartões
     [R6]  O seletor Tabela / Cartões                                      CUIDADO
     [R6b] O relatório salvo "Cartões" (Interactive Report)                PODE MEXER
     [R7]  Espalhar para as janelas e iframes das outras aplicações        CUIDADO
     [R8]  O começo
     [R9]  Arrastar para rolar (IR, CR, IG e o Gantt da Linha do Tempo)    PODE MEXER

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero outro dado no alto do cartão     → mude a ORDEM das colunas do relatório (o cartão segue).
     Quero mais (ou menos) dados em destaque → [R2], MAX_DESTAQUES (hoje 4).
     Quero mais (ou menos) dados em "Mais N dados" → [R2], MAX_MAIS (hoje 20).
     Quero escolher EXATAMENTE os campos do cartão → no Interactive Report, Ações › Colunas e
       salve como relatório "Cartões" (alternativo ou público). [R6b]
     Uma lista de pessoas não pôs a pessoa no título → [R2], o teste de 'pessoa'.
     Uma situação nova ficou sem cor                         → [R2], lista TONS.
     Um relatório não deve ter cartões                       → classe nc-reg-nao na região.
     Uma página de desenho próprio deve ter                  → classe nc-reg-sim na região.
     Um Natcorp_X.js novo vale para o sistema todo (não é de página) → [R1], lista GLOBAIS.

   ── LEGENDA ───────────────────────────────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
*/
(function () {
  'use strict';
  if (window.__ncRegistros) return;
  window.__ncRegistros = true;
  /* o endereço deste arquivo (para se repassar aos iframes, [R7]) */
  var EU = (document.currentScript && document.currentScript.src) || window.__ncRegistrosSrc || '';
  if (EU) window.__ncRegistrosSrc = EU;

  /* ═══ [R2] O CARTÃO SEGUE A ORDEM DAS COLUNAS DO RELATÓRIO ═══════════════════════════════
     O que o relatório mostra primeiro, o cartão mostra primeiro — e quem muda a ordem das
     colunas (Ações › Colunas, no Interactive Report) muda o cartão junto:
       título     a PRIMEIRA coluna de dados. Valor curto com número ("4512") ganha o nome da
                  coluna: "Requisição 4512";
       selo       a coluna de situação, onde estiver (a etiqueta colorida; cor em TONS);
       destaques  as próximas MAX_DESTAQUES colunas, na ordem do relatório;
       o resto    em "Mais N dados", na ordem do relatório. Valor vazio ("-") não aparece.
     EXCEÇÃO — lista de PESSOAS: se o relatório tem uma coluna que é a pessoa (PESSOA), ela é o
     título (com a foto) e o cargo (CARGO) vai embaixo do nome. "Solicitante", "Requisitante",
     "Aprovador", "Gestor" NÃO são pessoa-assunto: numa requisição, o assunto é a requisição.
       TEMPO      colunas de data que ganham "há N anos" (tempo de casa).
     PODE MEXER as listas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PAPEIS = {
    pessoa: /^(colaborador|nome|funcionario|empregado|candidato|pessoa|nome do colaborador)$/,
    sub: /^(cargo|funcao|cargo atual)$/,
    selo: /^(situacao|status|situacao atual|situacao da requisicao|etapa)$/
  };
  var MAX_DESTAQUES = 4;
  /* "Mais N dados" mostra no máximo isto (relatório com 100 colunas não vira um cartão sem fim);
     o resto fica avisado no fim ("+ 80 dados na Tabela") */
  var MAX_MAIS = 20;
  /* com o relatório "Cartões" ([R6b]) os campos foram escolhidos a dedo: vão todos à vista, até
     este tanto (o resto, em "Mais N dados") */
  var MAX_DESTAQUES_CARTAO = 12;
  var TEMPO = /admissao/;
  /* a cor do selo pelo texto: fim (cinza), atencao (âmbar), nao (vermelho), bom (verde) */
  var TONS = [
    ['fim', /demit|deslig|rescis|aposentad|falec|transferid|encerrad|inativ|cancelad/],
    ['nao', /reprovad|recusad|negad|rejeitad|indeferid/],
    ['atencao', /afast|ferias|licen|auxilio|suspen|aviso|maternidade|doenca|acidente|pendente|aguard|andamento|analise/],
    ['bom', /ativo|normal|trabalhando|aprovad|concluid|finalizad|deferid/]
  ];
  /* 04/10 — OS 7 STATUS PADRÃO DAS REQUISIÇÕES, cada um com a sua cor (a mesma em todo o
     sistema: Natcorp_Paginas › STATUS DAS REQUISIÇÕES). Sem diferença de maiúscula, acento ou
     masculino/feminino ("Em Aberto", "ABERTA", "aberto"…). A ordem importa: "reprovado" e
     "desaprovado" antes de "aprovado". Fora da lista = sem cor de status (vale o TONS acima).
     window.ncStatus(texto) devolve a chave — as páginas de desenho próprio usam a mesma. */
  var STATUS = [
    ['cancelado', /cancel/],
    ['reprovado', /reprov|desaprov|recusad|negad|rejeit|indefer/],
    ['suspenso', /suspens/],
    ['concluido', /conclu|finaliz/],
    ['aprovado', /aprovad|deferid/],
    ['andamento', /andamento|em analise/],
    ['aberto', /^(em )?abert[oa]s?$|em aberto/]
  ];
  function statusDe(t) {
    var s = String(t || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase().replace(/\s+/g, ' ').trim();
    if (!s || s.length > 40) return '';
    var x = STATUS.filter(function (p) { return p[1].test(s); })[0];
    return x ? x[0] : '';
  }
  if (!window.ncStatus) window.ncStatus = statusDe;
  /* na TABELA também: a célula da coluna de situação (só texto) vira o selo colorido */
  function marcarStatus(T, k) {
    T.reg.forEach(function (r) {
      var td = r.cel[k];
      if (!td || td.querySelector('.nc-status, a, input, select, textarea, button, img')) return;
      var t = texto(td), st = statusDe(t);
      if (!st) return;
      td.innerHTML = '<span class="nc-status" data-nc-status="' + st + '">' + esc(t) + '</span>';
    });
  }
  /* relatório com até tantas colunas de dados (e cabendo na largura) fica sem o seletor */
  var MIN_COLUNAS = 4;

  /* ═══ [R3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function sem(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase().replace(/\s+/g, ' ').trim(); }
  function vazio(t) { return /^[\s\-–—.]*$/.test(t || ''); }
  /* "Natcorp Do Brasil" → "Natcorp do Brasil" (só nos textos simples) */
  function bonito(t) { return String(t || '').replace(/\s+/g, ' ').trim().replace(/\s(De|Da|Do|Das|Dos|E|Em|No|Na)(?=\s)/g, function (x) { return x.toLowerCase(); }); }
  function tempoDeCasa(t) {
    var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || '');
    if (!m) return '';
    var d = new Date(+m[3], +m[2] - 1, +m[1]), h = new Date();
    var meses = (h.getFullYear() - d.getFullYear()) * 12 + h.getMonth() - d.getMonth() - (h.getDate() < d.getDate() ? 1 : 0);
    if (meses < 0) return '';
    if (meses < 1) return 'há menos de 1 mês';
    var a = Math.floor(meses / 12), r = meses % 12;
    return 'há ' + (a ? a + (a === 1 ? ' ano' : ' anos') + (r && a < 3 ? ' e ' + r + (r === 1 ? ' mês' : ' meses') : '') : r + (r === 1 ? ' mês' : ' meses'));
  }
  /* a largura que conta para "é celular?": a desta página — menos quando ela é uma janela
     modal do APEX (um iframe dentro de .ui-dialog): aí vale a da página que a abriu (uma janela
     de 720px no computador não é celular). O "Smartphone" do menu do usuário (a página numa
     moldura de 390px) conta como celular, como deve. */
  function larguraDaTela() {
    var w = window;
    try { while (w.frameElement && w.frameElement.closest('.ui-dialog') && w.parent !== w) w = w.parent; } catch (e) { /* outro endereço */ }
    return w.innerWidth || window.innerWidth;
  }
  var IC = {
    tabela: '<rect x="3.5" y="4.5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M3.5 14.5h17M9.5 9.5v10"/>',
    cartoes: '<rect x="3.5" y="4" width="17" height="7" rx="2"/><rect x="3.5" y="13" width="17" height="7" rx="2"/>',
    seta: '<path d="M6.5 9.5l5.5 5.5 5.5-5.5"/>'
  };
  function svg(d) { return '<svg class="nc-reg-ic" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  var CAMPO = 'input:not([type="hidden"]), select, textarea';

  /* ═══ [R4] LER A TABELA QUE O APEX DESENHOU ══════════════════════════════════════════════
     O cabeçalho é a primeira linha só de <th>; cada linha com 2+ <td> é um registro; linha de
     quebra (Control Break do Interactive Report) vira um título de grupo.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function lerTabela(tb) {
    if (!tb) return null;
    var cab = null, linhas = [];
    [].forEach.call(tb.rows, function (tr) {
      var tds = tr.querySelectorAll('td');
      if (!cab && !tds.length && tr.querySelector('th')) {
        cab = [].map.call(tr.cells, function (c) { return { nome: c.textContent.replace(/\s+/g, ' ').trim(), chave: sem(c.textContent) }; });
        return;
      }
      if (!cab) return;
      if (!tds.length) { var g = tr.textContent.replace(/\s+/g, ' ').trim(); if (g) linhas.push({ grupo: g }); return; }
      if (tds.length < 2) return;
      linhas.push({ cel: [].slice.call(tr.cells) });
    });
    return cab ? { cab: cab, linhas: linhas, reg: linhas.filter(function (l) { return l.cel; }) } : null;
  }
  function texto(td) { return td ? td.textContent.replace(/\s+/g, ' ').trim() : ''; }
  /* a célula só tem ícone (img, svg, fonte de ícone, texto escondido para leitor de tela)? */
  var SEQ = 0;   /* numera os links originais ligados aos cartões */
  function soIcone(td) {
    var c = td.cloneNode(true);
    [].forEach.call(c.querySelectorAll('.u-VisuallyHidden, .u-vh, .visually-hidden, [aria-hidden="true"], img, svg, i, .fa, .t-Icon, .a-Icon'), function (x) { x.remove(); });
    return vazio(texto(c));
  }
  /* os papéis de cada coluna (por nome e, para a foto e o link, pelo conteúdo) */
  function papeis(T, maxDest) {
    maxDest = maxDest || MAX_DESTAQUES;
    var P = { foto: -1, link: -1, titulo: -1, sub: -1, selo: -1, destaques: [] };
    var prim = T.reg[0] ? T.reg[0].cel : [];
    /* a coluna da AÇÃO DA LINHA (a lupa): link sem texto à vista — só imagem/ícone (o texto só
       para leitor de tela não conta). Procurada nas primeiras linhas, não só na 1ª: a 1ª linha
       pode vir sem link. */
    var amostra = T.reg.slice(0, 12);
    var colLink = -1;
    T.cab.some(function (c, k) {
      var achou = amostra.some(function (r) { var td = r.cel[k]; return td && td.querySelector('a[href], a[onclick]') && soIcone(td); });
      if (achou) colLink = k;
      return achou;
    });
    T.cab.forEach(function (c, k) {
      var td = prim[k];
      /* a lupa da coluna "Link" é uma imagem DENTRO do link: o link é visto antes, e a foto é
         uma imagem fora de link */
      if (k === colLink) { P.link = k; return; }
      if (P.foto < 0 && td && td.querySelector('img:not(a img)') && vazio(texto(td))) { P.foto = k; return; }
      if (P.selo < 0 && PAPEIS.selo.test(c.chave)) P.selo = k;
      else if (P.titulo < 0 && PAPEIS.pessoa.test(c.chave)) { P.titulo = k; P.pessoa = true; }
    });
    /* lista de pessoas: o cargo vai embaixo do nome */
    if (P.pessoa) T.cab.some(function (c, k) { if (k !== P.titulo && k !== P.selo && PAPEIS.sub.test(c.chave)) { P.sub = k; return true; } return false; });
    var livre = function (k) { return [P.foto, P.link, P.titulo, P.sub, P.selo].indexOf(k) < 0 && P.destaques.indexOf(k) < 0; };
    /* o título: a primeira coluna de dados do relatório (a que tem valor na 1ª linha) */
    if (P.titulo < 0) prim.some(function (td, k) { if (livre(k) && T.cab[k].nome && !vazio(texto(td))) { P.titulo = k; return true; } return false; });
    /* os destaques: as próximas colunas, na ordem do relatório */
    T.cab.some(function (c, k) { if (livre(k) && c.nome) P.destaques.push(k); return P.destaques.length >= maxDest; });
    P.colunas = T.cab.filter(function (c, k) { return k !== P.foto && k !== P.link && c.nome; }).length;
    return P;
  }

  /* ═══ [R5] MONTAR OS CARTÕES ═════════════════════════════════════════════════════════════
     Cada cartão é um <article>. O título é o PRÓPRIO link da linha (copiado), por isso tocar
     faz exatamente o que a tabela faria; o link "estica" e cobre o cartão inteiro (CSS).
     Nada de campo nem de id vai para a cópia (não duplica o que a página envia).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function valor(td) {
    if (!td) return '';
    if (!td.querySelector('*')) return esc(bonito(texto(td)));
    /* 04/10: link/botão de DENTRO de uma célula (ex.: o nome abre a ficha) também aciona o
       ORIGINAL — a cópia sozinha perde o que a página prendeu nele (ação dinâmica, jQuery). A
       cópia fica sem onclick (senão rodaria duas vezes) e aponta o original por data-nc-reg-para. */
    [].forEach.call(td.querySelectorAll('a[href], a[onclick], button'), function (x) { if (!x.getAttribute('data-nc-reg-id')) x.setAttribute('data-nc-reg-id', String(++SEQ)); });
    var c = td.cloneNode(true);
    [].forEach.call(c.querySelectorAll('input, select, textarea, script'), function (x) { x.remove(); });
    [].forEach.call(c.querySelectorAll('[id]'), function (x) { x.removeAttribute('id'); });
    [].forEach.call(c.querySelectorAll('[data-nc-reg-id]'), function (x) { x.setAttribute('data-nc-reg-para', x.getAttribute('data-nc-reg-id')); x.removeAttribute('data-nc-reg-id'); x.removeAttribute('onclick'); });
    return c.innerHTML;
  }
  function tom(t) { var s = sem(t); for (var k = 0; k < TONS.length; k++) if (TONS[k][1].test(s)) return TONS[k][0]; return ''; }
  function cartao(T, P, cel) {
    var usados = [P.foto, P.link, P.titulo, P.sub, P.selo].concat(P.destaques);
    var tdT = cel[P.titulo], tdL = cel[P.link];
    /* o toque no cartão faz a AÇÃO DA LINHA — a coluna "Link" (a lupa) do relatório; o link de
       dentro de uma célula (ex.: o nome abre os dados do colaborador) é outra coisa e continua
       clicável no próprio dado. Sem coluna Link, vale o link da célula do título. */
    var a = (tdL && tdL.querySelector('a[href], a[onclick]')) || (tdT && tdT.querySelector('a[href]'));
    var titulo = bonito(texto(tdT)) || 'Abrir';
    /* "4512" sozinho não diz nada: vira "Requisição 4512" (valor curto, com número, sem " - ") */
    if (!P.pessoa && T.cab[P.titulo] && /\d/.test(titulo) && titulo.length <= 14 && titulo.indexOf(' - ') < 0) titulo = T.cab[P.titulo].nome + ' ' + titulo;
    /* o título é uma CÓPIA do link (endereço, para abrir em nova aba), ligada ao link ORIGINAL da
       tabela por data-nc-reg-para: o toque aciona o original ([R6]), que traz junto o que a
       página prendeu nele (ação dinâmica, jQuery, onclick) — a cópia sozinha não traz. */
    if (a && !a.getAttribute('data-nc-reg-id')) a.setAttribute('data-nc-reg-id', String(++SEQ));
    var tit = a ? '<a class="nc-reg-tit" href="' + esc(a.getAttribute('href') || '#') + '" data-nc-reg-para="' + esc(a.getAttribute('data-nc-reg-id')) + '"' + (a.getAttribute('target') ? ' target="' + esc(a.getAttribute('target')) + '"' : '') + '>' + esc(titulo) + '</a>'
      : '<span class="nc-reg-tit">' + esc(titulo) + '</span>';
    var img = P.foto >= 0 && cel[P.foto] ? cel[P.foto].querySelector('img:not(a img)') : null;
    var foto = img ? '<img class="nc-reg-foto" src="' + esc(img.getAttribute('src')) + '" alt="" loading="lazy">' : '';
    var sub = P.sub >= 0 && !vazio(texto(cel[P.sub])) ? '<p class="nc-reg-sub">' + esc(bonito(texto(cel[P.sub]))) + '</p>' : '';
    var st = P.selo >= 0 ? texto(cel[P.selo]) : '';
    var selo = st && !vazio(st) ? '<span class="nc-reg-selo" data-tom="' + tom(st) + '"' + (statusDe(st) ? ' data-nc-status="' + statusDe(st) + '"' : '') + '>' + esc(bonito(st)) + '</span>' : '';
    var linha = function (k) {
      var t = texto(cel[k]);
      if (vazio(t) && !(cel[k] && cel[k].querySelector('img, a'))) return '';
      var extra = TEMPO.test(T.cab[k].chave) ? tempoDeCasa(t) : '';
      return '<div' + (t.length > 30 ? ' class="is-longo"' : '') + '><dt>' + esc(T.cab[k].nome || '·') + '</dt><dd>' + valor(cel[k]) + (extra ? ' <small>' + esc(extra) + '</small>' : '') + '</dd></div>';
    };
    var dest = P.destaques.map(linha).join('');
    var resto = [], branco = 0;
    T.cab.forEach(function (c, k) { if (usados.indexOf(k) >= 0) return; var h = linha(k); if (h) resto.push(h); else branco++; });
    var sobra = Math.max(0, resto.length - MAX_MAIS);
    var mostra = resto.slice(0, MAX_MAIS);
    var mais = mostra.length ? '<details class="nc-reg-mais"><summary>' + svg(IC.seta) + 'Mais ' + mostra.length + (mostra.length === 1 ? ' dado' : ' dados') +
      (branco ? ' <small>· ' + branco + ' em branco</small>' : '') + '</summary><dl class="nc-reg-dados">' + mostra.join('') + '</dl>' +
      (sobra ? '<p class="nc-reg-sobra">+ ' + sobra + (sobra === 1 ? ' dado' : ' dados') + ' na Tabela</p>' : '') + '</details>' : '';
    return '<article class="nc-reg-cartao' + (foto ? ' tem-foto' : '') + (a ? ' tem-link' : '') + '">' + foto +
      '<div class="nc-reg-cab">' + tit + sub + selo + '</div>' +
      (dest ? '<dl class="nc-reg-dados nc-reg-destaques">' + dest + '</dl>' : '') + mais + '</article>';
  }
  function montar(T, P, caixa) {
    var html = '', aberto = false;
    T.linhas.forEach(function (l) {
      if (l.grupo) { if (aberto) html += '</div>'; html += '<h3 class="nc-reg-grupo">' + esc(bonito(l.grupo)) + '</h3><div class="nc-reg-grade">'; aberto = true; return; }
      if (!aberto) { html += '<div class="nc-reg-grade">'; aberto = true; }
      html += cartao(T, P, l.cel);
    });
    if (aberto) html += '</div>';
    caixa.innerHTML = html;
  }

  /* ═══ [R6] O SELETOR TABELA / CARTÕES ════════════════════════════════════════════════════
     Cada relatório é uma "fonte": a região (que fica), o lugar da tabela (que o APEX troca a
     cada atualização) e onde vai o seletor. Em Cartões, só o lugar da tabela sai da vista: a
     paginação do APEX continua embaixo.
     CUIDADO  ABRE_EM_CARTOES_ATE: até essa largura de TELA (px), abre em Cartões quando a
              pessoa ainda não escolheu. 0 = sempre abre em Tabela.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ABRE_EM_CARTOES_ATE = 768;
  var CHAVE = 'nc-reg-modo';
  var TODOS = [];
  /* No CELULAR sempre começa em Cartões: a escolha de Tabela vale só até fechar o navegador
     (sessionStorage) e não se mistura com a do computador. No COMPUTADOR começa em Tabela e a
     escolha fica guardada (localStorage). */
  function ehCelular() { return larguraDaTela() <= ABRE_EM_CARTOES_ATE; }
  function memoria() { try { return ehCelular() ? window.sessionStorage : window.localStorage; } catch (e) { return null; } }
  function chave() { return ehCelular() ? CHAVE + '-celular' : CHAVE; }
  function modoGuardado() {
    var m = null;
    try { m = memoria().getItem(chave()); } catch (e) { /* sem memória no navegador */ }
    if (m === 'tabela' || m === 'cartoes') return m;
    return ehCelular() ? 'cartoes' : 'tabela';
  }
  /* ═══ [R6b] O RELATÓRIO SALVO "CARTÕES" (Interactive Report) ═════════════════════════════
     O QUE FAZ  Quem monta a página escolhe os campos do cartão no próprio APEX, sem código: no
                Interactive Report, Ações › Colunas (quais e em que ordem) e salvar como um
                relatório chamado "Cartões" — o mesmo nome do botão — (relatório alternativo do
                desenvolvedor, ou público).
                • Cartões → o seletor escolhe o relatório "Cartões" na lista de relatórios do
                  próprio Interactive Report (o APEX redesenha com as colunas dele) e os cartões
                  saem dessas colunas, NA ORDEM DELAS: a 1ª é o título, a Situação vira o selo, e
                  todas as outras ficam à vista (até MAX_DESTAQUES_CARTAO).
                • Tabela → volta para o relatório que estava aberto antes; se a página já abriu no
                  "Cartões" (o APEX lembra o último usado na sessão), volta para o padrão (o
                  primeiro da lista, o Primário).
                • Sem relatório "Cartões": tudo como antes (as colunas do relatório aberto).
                O nome vale sem acento, sem maiúscula e sem o número da lista: "3. Cartões",
                "Cartoes", "CARTÕES" (o singular "Cartão" também é aceito).
     CUIDADO    Relatório PRIVADO só aparece para quem o salvou. Para todos, salve como
                alternativo (no Page Designer, ou Ações › Relatório › Salvar como desenvolvedor) ou
                como público.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var NOME_CARTAO = /^cart(oes|ao)$/;   /* "Cartões" (como o botão); "Cartão" também vale */
  function nomeDoRelatorio(o) { return sem(o.text).replace(/^\d+\.\s*/, ''); }
  /* a lista de relatórios salvos do Interactive Report (o select da barra dele) */
  function listaDeRelatorios(R) {
    return [].filter.call(R.querySelectorAll('select'), function (s) {
      return /_saved_reports$/.test(s.id || '') || (s.closest('.a-IRR-toolbar') && [].some.call(s.options, function (o) { return /^\s*\d+\.\s/.test(o.text); }));
    })[0] || null;
  }
  function opcaoCartao(sel) { return [].filter.call(sel.options, function (o) { return NOME_CARTAO.test(nomeDoRelatorio(o)); })[0] || null; }
  function opcaoPadrao(sel, cartao) {
    var ops = [].filter.call(sel.options, function (o) { return o !== cartao && o.value; });
    var doPadrao = ops.filter(function (o) { return o.parentNode && o.parentNode.tagName === 'OPTGROUP' && /padr|default|primar/.test(sem(o.parentNode.label)); })[0];
    return doPadrao || ops[0] || null;
  }
  function trocarRelatorio(sel, valor) {
    sel.value = valor;
    window.apex.jQuery(sel).trigger('change');   /* o próprio Interactive Report troca e redesenha */
  }

  function preparar(F) {
    var R = F.regiao;
    if (R.__ncReg) return;
    R.__ncReg = true;
    var barra = el('div', 'nc-reg-modos');
    barra.setAttribute('role', 'group');
    barra.setAttribute('aria-label', 'Como ver os registros');
    barra.innerHTML = '<button type="button" data-reg="tabela">' + svg(IC.tabela) + '<span>Tabela</span></button>' +
      '<button type="button" data-reg="cartoes">' + svg(IC.cartoes) + '<span>Cartões</span></button>';
    var caixa = el('div', 'nc-reg-cartoes');
    function aplicar() {
      var modo = modoGuardado();
      /* o relatório salvo "Cartões": entra em Cartões, sai em Tabela ([R6b]) */
      var sel = F.ir ? listaDeRelatorios(R) : null, oc = sel ? opcaoCartao(sel) : null, noCartao = false;
      if (oc) {
        noCartao = sel.value === oc.value;
        var quer = null;
        if (modo === 'cartoes' && !noCartao) { F.antes = sel.value; quer = oc.value; }
        else if (modo === 'tabela' && noCartao) { var volta = F.antes && F.antes !== oc.value ? F.antes : (opcaoPadrao(sel, oc) || {}).value; quer = volta || null; }
        /* troca uma vez por pedido (se o APEX não trocar, segue com o que está aberto) */
        if (quer && F.pediu !== quer + '|' + modo) {
          F.pediu = quer + '|' + modo;
          if (modo === 'cartoes') { var lug0 = F.lugar(); if (lug0) { lug0.classList.add('nc-reg-oculto'); if (caixa.nextSibling !== lug0) lug0.parentNode.insertBefore(caixa, lug0); } caixa.hidden = false; caixa.innerHTML = '<p class="nc-reg-abrindo">Abrindo os cartões…</p>'; }
          trocarRelatorio(sel, quer);
          return;   /* o APEX redesenha e avisa (apexafterrefresh): aí os cartões são montados */
        }
        if (!quer) F.pediu = null;
      }
      var lugar = F.lugar(), tb = F.tabela(), T = lerTabela(tb);
      var P = T && T.reg.length ? papeis(T, noCartao ? MAX_DESTAQUES_CARTAO : MAX_DESTAQUES) : null;
      if (P && P.selo >= 0) marcarStatus(T, P.selo);
      /* vale a pena? 4+ colunas de dados, ou a tabela não cabe; e nenhum campo nas linhas.
         Com o relatório "Cartões" sempre vale (quem o criou quer os cartões, e o seletor precisa
         ficar para voltar à Tabela). */
      var largo = tb && lugar ? tb.scrollWidth > lugar.clientWidth + 8 : false;
      var ok = !!(lugar && P && !tb.querySelector('td ' + CAMPO) && (oc || P.colunas >= MIN_COLUNAS || largo || R.classList.contains('nc-reg-sim')));
      if (!ok) {
        barra.hidden = true; caixa.hidden = true;
        if (lugar) lugar.classList.remove('nc-reg-oculto');
        return;
      }
      if (!barra.isConnected) F.porBarra(barra);
      if (caixa.nextSibling !== lugar) lugar.parentNode.insertBefore(caixa, lugar);
      barra.hidden = false;
      [].forEach.call(barra.querySelectorAll('[data-reg]'), function (b) { b.setAttribute('aria-pressed', String(b.getAttribute('data-reg') === modo)); });
      var cartoes = modo === 'cartoes';
      lugar.classList.toggle('nc-reg-oculto', cartoes);
      caixa.hidden = !cartoes;
      if (cartoes) montar(T, P, caixa);
      document.body.classList.toggle('nc-reg-fora-da-tabela', !!document.querySelector('.nc-reg-oculto'));
    }
    F.aplicar = function () { try { aplicar(); } catch (e) { if (window.console) console.warn('[Natcorp registros]', e); } };
    barra.addEventListener('click', function (ev) {
      var b = ev.target.closest('[data-reg]');
      if (!b) return;
      try { memoria().setItem(chave(), b.getAttribute('data-reg')); } catch (e) { /* ok */ }
      TODOS.forEach(function (f) { f.aplicar(); });   /* a escolha vale para todos os relatórios da página */
    });
    /* tocar no cartão (ou no título) = clicar no link ORIGINAL da linha, na tabela escondida —
       exatamente o que a lupa faz no modo Tabela. "Mais N dados" e os links de dentro não
       disparam; Ctrl/Cmd/Shift/botão do meio seguem a cópia (nova aba). */
    caixa.addEventListener('click', function (ev) {
      /* 04/10: link/botão de dentro de um dado = clicar no ORIGINAL daquela célula ([R5] valor) */
      var dentro = ev.target.closest('.nc-reg-dados [data-nc-reg-para]');
      if (dentro) {
        if (ev.ctrlKey || ev.metaKey || ev.shiftKey || ev.altKey || ev.button) return;
        var o = document.querySelector('[data-nc-reg-id="' + dentro.getAttribute('data-nc-reg-para') + '"]');
        if (!o) return;
        ev.preventDefault(); ev.stopPropagation();
        o.click();
        return;
      }
      if (ev.target.closest('.nc-reg-mais, .nc-reg-dados a')) return;
      var c = ev.target.closest('.nc-reg-cartao.tem-link'); if (!c) return;
      var tit = c.querySelector('.nc-reg-tit'); if (!tit) return;
      if (ev.ctrlKey || ev.metaKey || ev.shiftKey || ev.altKey || ev.button) return;
      var orig = document.querySelector('[data-nc-reg-id="' + tit.getAttribute('data-nc-reg-para') + '"]');
      if (!orig) return;   /* sem o original (não deve acontecer): a cópia segue sozinha */
      ev.preventDefault();
      orig.click();
    });
    window.apex.jQuery(R).on('apexafterrefresh', F.aplicar);
    TODOS.push(F);
    F.aplicar();
  }

  /* ═══ [R1] QUAIS RELATÓRIOS GANHAM OS CARTÕES ════════════════════════════════════════════
     • todo Interactive Report (.t-IRR-region) e todo Classic Report de TABELA (.t-Report — o
       modelo padrão "Standard"; os de cartões, selos e listas do tema já são outra coisa);
     • menos as regiões com a classe nc-reg-nao;
     • numa página de desenho próprio (que carrega um Natcorp_<Página>.js fora de GLOBAIS), só
       as regiões com a classe nc-reg-sim.
     CUIDADO  GLOBAIS: os nossos .js que valem para o sistema todo (não são de uma página).
              Criou outro assim? Ponha o nome aqui, senão toda página vira "de desenho próprio".
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* = as PECAS do Natcorp_Temas.js + o Temas + o arquivo da equipe. Trilha/Editor/Lov ficaram de
     fora em 03/10 e toda página com eles virou "de desenho próprio" (sem Cartões) — corrigido 04/10. */
  var GLOBAIS = /^Natcorp_(Allow_Unload_Iframes|Temas|Registros|Trilha|Editor|Lov|Colab|Grade)\.js$/i;   /* Grade: 08/10 */
  function paginaPropria() {
    return [].some.call(document.scripts, function (s) {
      var n = (s.getAttribute('src') || '').split('?')[0].split('/').pop();
      return /^Natcorp_\w+\.js$/i.test(n) && !GLOBAIS.test(n);
    }) || !!window.__ncLinhaTempo || document.body.classList.contains('nc-lt');
  }
  function fontes() {
    var propria = paginaPropria(), lista = [];
    var vale = function (r) { return r && !r.classList.contains('nc-reg-nao') && (!propria || r.classList.contains('nc-reg-sim')); };
    [].forEach.call(document.querySelectorAll('.t-IRR-region'), function (r) {
      if (!vale(r)) return;
      lista.push({
        regiao: r,
        ir: true,
        lugar: function () { return r.querySelector('.a-IRR-tableContainer'); },
        tabela: function () { return [].slice.call(r.querySelectorAll('.a-IRR-tableContainer .a-IRR-table')).sort(function (a, b) { return b.rows.length - a.rows.length; })[0] || null; },
        porBarra: function (b) { var t = r.querySelector('.a-IRR-toolbar'); if (t && t.parentNode) t.parentNode.insertBefore(b, t.nextSibling); else r.insertBefore(b, r.firstChild); }
      });
    });
    [].forEach.call(document.querySelectorAll('.t-Report'), function (rep) {
      if (rep.closest('.t-IRR-region') || !rep.querySelector('table.t-Report-report')) return;
      var r = rep.closest('.t-Region') || rep.parentElement;
      if (!vale(r) || r.__ncRegCR) return;
      r.__ncRegCR = true;
      var atual = function () { return r.querySelector('.t-Report'); };
      lista.push({
        regiao: r,
        lugar: function () { var a = atual(); return a ? (a.querySelector('.t-Report-tableWrap') || a.querySelector('table.t-Report-report')) : null; },
        tabela: function () { var a = atual(); return a ? a.querySelector('table.t-Report-report') : null; },
        porBarra: function (b) { var a = atual(); if (a && a.parentNode) a.parentNode.insertBefore(b, a); }
      });
    });
    return lista;
  }
  function iniciar() {
    if (window.__ncRegistrosIniciou) return;
    window.__ncRegistrosIniciou = true;
    document.body.classList.add('nc-reg');
    fontes().forEach(function (F) { try { preparar(F); } catch (e) { if (window.console) console.warn('[Natcorp registros]', e); } });
    /* relatório que só aparece depois (aba, região que abre): procura de novo quando o APEX
       atualiza qualquer região */
    window.apex.jQuery(document).on('apexafterrefresh', function () { fontes().forEach(function (F) { if (!F.regiao.__ncReg) preparar(F); }); });
  }

  /* ═══ [R7] ESPALHAR PARA AS JANELAS E IFRAMES DAS OUTRAS APLICAÇÕES ══════════════════════
     As outras aplicações abrem dentro da casca, em iframes (e as janelas modais também são
     iframes). Este arquivo se põe em cada iframe do MESMO endereço que tenha APEX, quando ele
     carrega — e a cópia de lá faz o mesmo com os iframes dela. Iframe de outro endereço é
     ignorado (o navegador não deixa entrar, e está certo).
     CUIDADO  Não carrega duas vezes: cada janela guarda window.__ncRegistros.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function porNoIframe(f) {
    try {
      var w = f.contentWindow, d = f.contentDocument;
      if (!w || !d || w.__ncRegistros || !w.apex || !d.head || !EU) return;
      if (d.querySelector('script[src*="Natcorp_Registros.js"]')) return;
      var s = d.createElement('script');
      s.src = EU;
      d.head.appendChild(s);
    } catch (e) { /* iframe de outro endereço: não é nosso */ }
  }
  function vigiar(f) {
    if (f.__ncRegVigia) return;
    f.__ncRegVigia = true;
    f.addEventListener('load', function () { porNoIframe(f); });
    porNoIframe(f);
  }
  function espalhar() {
    [].forEach.call(document.querySelectorAll('iframe'), vigiar);
    if (window.MutationObserver) {
      new MutationObserver(function (ms) {
        ms.forEach(function (m) {
          [].forEach.call(m.addedNodes, function (n) {
            if (n.nodeType !== 1) return;
            if (n.tagName === 'IFRAME') vigiar(n); else if (n.querySelector) [].forEach.call(n.querySelectorAll('iframe'), vigiar);
          });
        });
      }).observe(document.documentElement, { childList: true, subtree: true });
    }
  }

  /* ═══ [R9] ARRASTAR PARA ROLAR ═════════════════════════════════════════════════════════
     O QUE FAZ  Em todo Interactive Report, Classic Report, Interactive Grid e no gráfico de
                Gantt da Linha do Tempo: quando a tabela (ou o gráfico) tem barra de rolagem,
                clicar e arrastar com o mouse move o conteúdo — como pegar uma folha e puxar.
                O cursor vira a "mãozinha" onde dá para arrastar.
                • só com o MOUSE (no celular e no tablet o dedo já rola sozinho);
                • só começa depois de 6px de movimento: um clique normal continua abrindo o
                  link, marcando a linha, tocando a barra do Gantt;
                • quem arrastou não "clica" ao soltar (soltar em cima de um link não o abre);
                • não começa em campo nem em botão (no Gantt, sim: as barras são o gráfico);
                • no Interactive Grid, enquanto arrasta, a grade não fica marcando células;
                • ao soltar, um pouco de embalo (sem embalo para quem pediu menos movimento).
                Vale também nas páginas de desenho próprio (não muda o desenho de nada).
     PODE MEXER ONDE (os lugares que podem ser arrastados), LIMIAR e EMBALO.
     CUIDADO    O que rola de verdade é achado subindo do ponto clicado: o primeiro elemento
                com rolagem (overflow auto/scroll) e conteúdo maior que ele.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ONDE = '.a-IRR-tableContainer, .t-Report-tableWrap, .t-Report-wrap, .a-GV, .nc-lt-gantt';
  var LIVRE_NO_GANTT = '.nc-lt-gantt';
  var NAO_COMECA = 'input, select, textarea, button, [contenteditable=""], [contenteditable="true"], .a-GV-cell.is-active input, .ui-resizable-handle, .a-IRR-header .a-IRR-headerLink, .a-GV-header';
  var LIMIAR = 6, EMBALO = 0.92;
  function rolavel(e, eixo) {
    var cs = getComputedStyle(e);
    var ov = eixo === 'x' ? cs.overflowX : cs.overflowY;
    if (ov !== 'auto' && ov !== 'scroll') return false;
    return eixo === 'x' ? e.scrollWidth > e.clientWidth + 1 : e.scrollHeight > e.clientHeight + 1;
  }
  /* o elemento que rola, subindo do ponto até a região (no máximo alguns níveis além dela) */
  function quemRola(alvo) {
    var lugar = alvo.closest && alvo.closest(ONDE);
    if (!lugar) return null;
    var limite = lugar.closest('.t-IRR-region, .a-IG, .t-Region, .nc-lt-painel') || document.body;
    for (var e = alvo; e && e !== limite.parentElement; e = e.parentElement) {
      if (e.nodeType === 1 && (rolavel(e, 'x') || (e !== document.body && rolavel(e, 'y') && e.closest(ONDE)))) return e;
    }
    return null;
  }
  function ativarArrasto() {
    if (window.__ncArrasto) return;
    window.__ncArrasto = true;
    var menos = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var A = null, embalo = 0;
    /* a mãozinha: marca o lugar quando o mouse passa e ele tem rolagem */
    document.addEventListener('pointerover', function (ev) {
      if (ev.pointerType !== 'mouse' || A) return;
      var r = quemRola(ev.target);
      if (r && !r.classList.contains('nc-arrastavel')) r.classList.add('nc-arrastavel');
    }, true);
    document.addEventListener('pointerdown', function (ev) {
      if (ev.pointerType !== 'mouse' || ev.button !== 0 || ev.ctrlKey || ev.metaKey || ev.shiftKey) return;
      var r = quemRola(ev.target);
      if (!r) return;
      if (ev.target.closest(NAO_COMECA) && !(ev.target.closest(LIVRE_NO_GANTT) && !ev.target.closest('input, select, textarea'))) return;
      cancelAnimationFrame(embalo);
      A = { r: r, x: ev.clientX, y: ev.clientY, l: r.scrollLeft, t: r.scrollTop, mexeu: false, vx: 0, vy: 0, tempo: ev.timeStamp, px: ev.clientX, py: ev.clientY, y2: rolavel(r, 'y') };
    }, true);
    /* enquanto arrasta, ninguém mais recebe o movimento (a grade não marca células) */
    document.addEventListener('pointermove', function (ev) {
      if (!A) return;
      var dx = ev.clientX - A.x, dy = ev.clientY - A.y;
      if (!A.mexeu) {
        if (Math.abs(dx) < LIMIAR && Math.abs(dy) < LIMIAR) return;
        A.mexeu = true;
        document.documentElement.classList.add('nc-arrastando');
        try { var sel = window.getSelection(); if (sel) sel.removeAllRanges(); } catch (e) { /* ok */ }
      }
      ev.preventDefault();
      ev.stopPropagation();
      A.r.scrollLeft = A.l - dx;
      if (A.y2) A.r.scrollTop = A.t - dy;
      var dt = Math.max(1, ev.timeStamp - A.tempo);
      A.vx = (ev.clientX - A.px) / dt; A.vy = (ev.clientY - A.py) / dt;
      A.px = ev.clientX; A.py = ev.clientY; A.tempo = ev.timeStamp;
    }, true);
    ['mousemove', 'dragstart', 'selectstart'].forEach(function (tipo) {
      document.addEventListener(tipo, function (ev) { if (A && A.mexeu) { ev.preventDefault(); ev.stopPropagation(); } }, true);
    });
    function soltar() {
      if (!A) return;
      var a = A;
      A = null;
      document.documentElement.classList.remove('nc-arrastando');
      if (!a.mexeu) return;
      /* o clique que viria ao soltar é engolido (uma vez só) */
      var engole = function (e) { e.preventDefault(); e.stopPropagation(); };
      window.addEventListener('click', engole, true);
      setTimeout(function () { window.removeEventListener('click', engole, true); }, 0);
      if (menos) return;
      var vx = a.vx * 16, vy = a.y2 ? a.vy * 16 : 0;
      (function passo() {
        if (Math.abs(vx) < 0.5 && Math.abs(vy) < 0.5) return;
        a.r.scrollLeft -= vx; a.r.scrollTop -= vy;
        vx *= EMBALO; vy *= EMBALO;
        embalo = requestAnimationFrame(passo);
      })();
    }
    document.addEventListener('pointerup', soltar, true);
    document.addEventListener('pointercancel', soltar, true);
    window.addEventListener('blur', soltar);
  }

  /* ═══ [R8] O COMEÇO ══════════════════════════════════════════════════════════════════════
     Pode chegar cedo (URL de arquivo da aplicação: roda antes de o APEX montar a página) ou
     tarde (posto pela casca num iframe já pronto). Por isso começa no PRIMEIRO destes: o aviso
     do APEX de página pronta (apexreadyend), o fim do carregamento, ou já — se a página já
     carregou. Fora do APEX (sem window.apex), só espalha.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function quandoPronto(fn) {
    var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(fn, 0); };
    if (document.readyState === 'complete') { vai(); return; }
    if (window.apex && window.apex.jQuery && window.apex.gPageContext$) window.apex.jQuery(window.apex.gPageContext$).one('apexreadyend', vai);
    window.addEventListener('load', vai);
  }
  quandoPronto(function () {
    try { espalhar(); } catch (e) { /* ok */ }
    try { ativarArrasto(); } catch (e) { /* ok */ }
    if (window.apex && window.apex.jQuery && document.body) { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp registros]', e); } }
  });
})();
