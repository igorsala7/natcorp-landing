/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CORES DO SISTEMA (TEMAS)  —  a janela de cores e o simulador de aparelho (JS)  ║
   ║  Vale para o SISTEMA TODO (não é de uma página só)                                        ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). A parte 3 explica as cores da marca.

   ── O QUE É UM "TEMA" ─────────────────────────────────────────────────────────────────────
   Um tema é um jogo de cores para o sistema inteiro: menu superior, menu lateral (com o
   painel animado e o logo), botões, o ícone do topo das regiões e a linha sob o título delas.
   O Padrão Natcorp é o roxo de sempre. Os outros 14 conversam com a marca: dois usam as
   próprias cores dela em outra ordem (Ameixa Natcorp, Noite Natcorp), um é neutro (Grafite &
   Rosa), e os demais giram as cores da marca para outro lugar do círculo cromático, mantendo
   a mesma claridade.
   Cada pessoa escolhe o seu em: menu do usuário › Cores. A escolha fica guardada NO
   NAVEGADOR da pessoa (não no banco): em outro computador, ela volta ao Padrão.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
     • Abre a janela "Cores do sistema", com uma miniatura do sistema em cada cor.
     • Aplica o tema escolhido na hora (no sistema e nas telas abertas dentro dele), sem
       recarregar a página, e recolore o painel animado do menu lateral.
     • Põe no menu do usuário (o do "365785") os itens Cores · Desktop · Tablet · Smartphone,
       entre "Meus Contatos" e "Sair".
     • Smartphone / Tablet: mostra a página dentro de uma moldura com o tamanho de um aparelho
       de verdade, para ver como ela fica no celular.
     • Zera escolhas dos temas ANTIGOS (lavanda, oceano…), que não existem mais.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não grava nada no banco.
     • Não define as cores: as cores de cada tema estão no CSS (Natcorp_Temas.src.css, dentro
       do Natcorp_Style_Min.css), gerado pelo gerar-temas.py.
     • Usa a mesma chave do navegador (localStorage "nc_theme_choice") e o mesmo formato de
       classe (nc-theme-<id> no <html>) que o arquivo do time usava. Desde 07/10 ele mesmo
       repassa o tema a cada página aberta numa moldura e põe os itens no menu do usuário sem
       precisar do ícone de paleta do time: funciona com ou sem aquele arquivo.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
   NÃO é por página. Entra UMA vez, na aplicação "casca" (a do menu superior, app 200):
     App 200 › Shared Components › User Interface Attributes › Desktop › JavaScript ›
     File URLs:   #WORKSPACE_IMAGES#Natcorp_Temas.js
   As aplicações de conteúdo (9503 etc.) NÃO precisam dele: o arquivo do time, que elas já
   carregam, aplica o tema salvo.

   ── CUIDADO: ESTE ARQUIVO É A FONTE, NÃO O QUE SOBE ───────────────────────────────────────
   O arquivo que sobe para o Workspace Images (../login/Natcorp_Temas.js) é GERADO a partir
   deste pelo gerar-temas.py, que escreve a lista de temas na linha  var TEMAS = …  e o
   desenho do painel na linha  var PAINEL = …  (veja [J1] e [J2]). Nessas duas linhas há uma
   MARCA (um comentário com o nome em maiúsculas, colado no [] vazio): não apague nem mude.
   PARA CRIAR OU MUDAR UM TEMA (nome, descrição, cores): NÃO é aqui nem à mão no CSS.
     1. edite a lista TEMAS no gerar-temas.py;
     2. rode  python3 gerar-temas.py  e depois  node gerar-app.mjs;
     3. suba o Natcorp_Style_Min.css e o Natcorp_Temas.js.
   O passo a passo e a tabela de cores estão no TEMAS-MANUTENCAO.md.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J0]  As peças do sistema todo ............ traz o Registros e a Trilha       PODE MEXER
     [J1]  Os temas e a escolha guardada ....... a lista (gerada) e a chave no navegador
     [J2]  Aplicar o tema ...................... a classe no <html> e o painel recolorido
     [J3]  A janela "Cores do sistema" ......... os cartões, o teclado, abrir e fechar PODE MEXER
     [J4]  Os itens no menu do usuário ......... Cores, Desktop, Tablet, Smartphone   PODE MEXER
     [J5]  O simulador de aparelho ............. a página numa moldura de celular/tablet

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto da janela ("Cores do sistema", "Pronto"…)
       → Ctrl+F por um pedaço do texto, em [J3]. Troque SÓ o que está entre as aspas '…'.
     Quero criar um tema novo ou mudar as cores de um       → gerar-temas.py (veja acima).
     Quero mudar o nome dos itens do menu ("Cores", "Smartphone"…) → [J4], lista DISP e o
                                                             label 'Cores'.
     Os itens não aparecem no menu do usuário
       → o menu precisa ter um item chamado "Sair" (é assim que ele é reconhecido). Veja [J4].
     Mudei este arquivo e nada aconteceu no sistema
       → rode  python3 gerar-temas.py  e suba o ../login/Natcorp_Temas.js (não este).

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
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';
  /* CUIDADO: impede que o arquivo rode duas vezes. Não apague. */
  if (window.__ncTemas) return;
  window.__ncTemas = true;

  /* ═══ [J0] AS PEÇAS DO SISTEMA TODO ══════════════════════════════════════════════════════
     Este arquivo está na aplicação casca (200), em todas as páginas. Por isso é ele quem traz
     as outras peças que valem para o sistema inteiro, da MESMA pasta de onde ele veio
     (#WORKSPACE_IMAGES#) — assim ninguém precisa pôr URL de arquivo em cada página:
       Natcorp_Registros.js  Tabela · Cartões em todo relatório (e se repassa aos iframes das
                             outras aplicações). Guia: REGISTROS-MANUTENCAO.md.
       Natcorp_Trilha.js     a faixa "Voltar · caminho" (as últimas páginas visitadas) logo abaixo
                             do menu superior. Guia: TRILHA-MANUTENCAO.md.
       Natcorp_Editor.js     o editor de texto rico (CKEditor) em todo o sistema: letra confortável
                             ao escrever e "Mais ferramentas" para os botões raros; se repassa aos
                             iframes. Guia: EDITOR-MANUTENCAO.md.
       Natcorp_Lov.js        a janela do Popup LOV com várias colunas vira uma lista de cartões
                             (busca marcada, teclado, Cartões | Tabela). Guia: LOV-MANUTENCAO.md.
       Natcorp_Colab.js      a região Colaborador vira um cartão curto (some quando vem vazia) e
                             os filtros de escolha múltipla ganham rótulo em cima e "Filtrar".
                             Guia: COLAB-MANUTENCAO.md.
       Natcorp_Grade.js      todo Interactive Grid vira lista com cabeçalho de colunas (ordenar,
                             filtrar, congelar, mover, larguras) + gaveta para ver/editar o
                             registro; Lista | Tabela. Página de desenho próprio fica de fora; se
                             repassa aos iframes. Guia: GRADE-MANUTENCAO.md.
     PODE MEXER a lista PECAS (o nome do arquivo, como subiu no Workspace Images).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PECAS = ['Natcorp_Registros.js', 'Natcorp_Trilha.js', 'Natcorp_Editor.js', 'Natcorp_Lov.js', 'Natcorp_Colab.js', 'Natcorp_Grade.js'];
  (function () {
    var eu = (document.currentScript && document.currentScript.src) || '';
    var pasta = eu.replace(/[^\/?#]*([?#].*)?$/, '');
    if (!pasta) return;
    PECAS.forEach(function (nome) {
      if (document.querySelector('script[src*="' + nome + '"]')) return;   /* a página já trouxe */
      var s = document.createElement('script');
      s.src = pasta + nome;
      (document.head || document.documentElement).appendChild(s);
    });
  })();

  /* ═══ [J1] OS TEMAS E A ESCOLHA GUARDADA ═════════════════════════════════════════════════
     O QUE É    TEMAS   a lista de temas (nome, descrição, cores). No arquivo-fonte (.src.js)
                        ela aparece vazia; o gerar-temas.py a escreve no lugar da marca ao gerar
                        o arquivo que sobe (onde ela já vem preenchida).
                CHAVE   o nome da anotação no navegador onde a escolha fica guardada — a MESMA
                        do arquivo do time ('nc_theme_choice'). NÃO mude.
                PADRAO  'purple' = Padrão Natcorp, que no <html> é "sem classe nenhuma".
     CUIDADO    Não mude a linha  var TEMAS = …  abaixo: a marca dela é o lugar da lista.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var TEMAS = /*TEMAS*/[];
  var CHAVE = 'nc_theme_choice', PADRAO = 'purple';
  var IDS = TEMAS.map(function (t) { return t.id; });

  function lido() { try { return localStorage.getItem(CHAVE) || PADRAO; } catch (e) { return PADRAO; } }
  function guardar(id) { try { localStorage.setItem(CHAVE, id); } catch (e) { /* modo privado: vale só nesta visita */ } }
  function tema(id) { for (var i = 0; i < TEMAS.length; i++) if (TEMAS[i].id === id) return TEMAS[i]; return TEMAS[0]; }

  /* ═══ [J2] APLICAR O TEMA ════════════════════════════════════════════════════════════════
     O QUE FAZ  aplicarEm  troca a classe nc-theme-<id> no <html> desta tela e de toda tela
                           aberta dentro dela (iframes, janelas);
                painel     recolore o painel animado do menu lateral: troca as cinco cores
                           desenhadas no SVG pelas do tema e entrega o resultado ao CSS em
                           --nc-t-painel (e --nc-t-painel-parado, para quem pediu menos
                           movimento). No Padrão, tira as duas e vale o painel original;
                aplicar    faz as duas coisas.
                Ao carregar: escolha de tema que não existe mais volta ao Padrão; e o tema é
                aplicado três vezes (agora, quando a página termina de montar e quando tudo
                termina de carregar), para nenhuma tela ficar sem.
     CUIDADO    Não mude a linha  var PAINEL = …  (a marca dela é onde o gerar-temas.py põe o
                SVG do painel).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* a classe no <html> deste documento e de todo iframe da mesma origem (janelas dentro de
     iframes inclusive) — o time faz o mesmo a cada navegação, lendo a mesma chave */
  function aplicarEm(doc, id, prof) {
    if (prof > 6) return;
    try {
      var h = doc.documentElement;
      [].slice.call(h.classList).forEach(function (c) { if (/^nc-theme-/.test(c)) h.classList.remove(c); });
      if (id !== PADRAO) h.classList.add('nc-theme-' + id);
      [].forEach.call(doc.querySelectorAll('iframe'), function (f) {
        try { var d = f.contentDocument; if (d && d.documentElement) aplicarEm(d, id, prof + 1); } catch (e) { /* outra origem */ }
      });
    } catch (e) { /* documento indisponível */ }
  }
  /* o painel animado do menu lateral (o mesmo SVG do Padrão, gerado pelo painel-natcorp.mjs)
     nas cores do tema: as cinco cores desenhadas dentro dele trocadas pelas do tema e entregues
     ao CSS em --nc-t-painel (e --nc-t-painel-parado, para quem pediu menos movimento). O
     menu lateral mora neste documento (a casca), por isso só aqui. */
  var PAINEL = /*PAINEL*/[];
  function uri(svg) { return 'url("data:image/svg+xml,' + svg.replace(/%/g, '%25').replace(/#/g, '%23').replace(/"/g, "'").replace(/</g, '%3C').replace(/>/g, '%3E') + '")'; }
  function recolorir(svg, mapa) { Object.keys(mapa).forEach(function (de) { svg = svg.split(de).join(mapa[de]); }); return svg; }
  function painel(id) {
    var h = document.documentElement.style;
    if (id === PADRAO || !PAINEL.length) { h.removeProperty('--nc-t-painel'); h.removeProperty('--nc-t-painel-parado'); return; }
    var mapa = tema(id).painel;
    h.setProperty('--nc-t-painel', uri(recolorir(PAINEL[0], mapa)));
    h.setProperty('--nc-t-painel-parado', uri(recolorir(PAINEL[1], mapa)));
  }
  function aplicar(id) { aplicarEm(document, id, 0); painel(id); }

  /* escolha de um tema que não existe mais (os 14 antigos) volta ao Padrão — antes que o
     código do time a aplique */
  var atual = lido();
  if (IDS.indexOf(atual) < 0) { atual = PADRAO; guardar(PADRAO); }
  aplicar(atual);
  document.addEventListener('DOMContentLoaded', function () { aplicar(lido()); });
  window.addEventListener('load', function () { aplicar(lido()); });
  /* 07/10: a cada página que abre numa moldura (o "load" do iframe não sobe: escuta na descida),
     o tema vai para ela também — antes isso dependia do arquivo do time */
  document.addEventListener('load', function (e) {
    if (e.target && e.target.tagName === 'IFRAME') aplicarEm(document, lido(), 0);
  }, true);

  /* ═══ [J3] A JANELA "CORES DO SISTEMA" ═══════════════════════════════════════════════════
     O QUE FAZ  cartao    cada opção: uma miniatura do sistema (topo, menu lateral, região,
                          botão) pintada nas cores do tema, o nome, a descrição e as 4 cores;
                desenhar  marca o tema atual e escreve "Agora: … Vale neste navegador.";
                escolher  guarda, aplica e redesenha (a escolha vale na hora);
                teclas    Esc fecha; setas andam entre os cartões; o Tab não sai da janela;
                abrir     cria a janela. Ela abre pelo ícone de paleta do time (o clique é pego
                          ANTES do botão do time, e a janela antiga nem chega a abrir) e pelo
                          item Cores do menu do usuário.
     PODE MEXER os textos entre aspas: 'Cores do sistema', 'Toque numa opção…', 'Voltar ao
                Padrão Natcorp', 'Pronto', 'Agora:', 'Vale neste navegador.', 'marca'.
                Os NOMES e DESCRIÇÕES dos temas ficam no gerar-temas.py, não aqui.
     VISUAL     Natcorp_Temas.janela.css › [C1] a [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  var X = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" aria-hidden="true"><path d="M6 6l12 12M18 6L6 18"/></svg>';
  var aberta = null, voltarPara = null;

  function cartao(t, on) {
    var c = t.cores;
    return '<button type="button" role="radio" aria-checked="' + on + '" class="nc-tm-cartao' + (on ? ' is-on' : '') + '" data-tema="' + esc(t.id) + '" ' +
      'style="--a:' + c.azul + ';--r:' + c.roxo + ';--m:' + c.ameixa + ';--s:' + c.rosa + '" aria-label="' + esc(t.nome + '. ' + t.desc) + '">' +
      '<span class="nc-tm-mini" aria-hidden="true"><span class="nc-tm-mini-topo"></span><span class="nc-tm-mini-lado"></span>' +
        '<span class="nc-tm-mini-area"><span class="nc-tm-mini-reg"><span class="nc-tm-mini-reg-cab"><span class="nc-tm-mini-ic"></span><span class="nc-tm-mini-tit"></span></span><span class="nc-tm-mini-bt"></span></span></span></span>' +
      '<span class="nc-tm-nome">' + esc(t.nome) + (t.id === PADRAO ? ' <small>marca</small>' : '') + '</span>' +
      '<span class="nc-tm-desc">' + esc(t.desc) + '</span>' +
      '<span class="nc-tm-cores" aria-hidden="true"><i style="background:' + c.azul + '"></i><i style="background:' + c.roxo + '"></i><i style="background:' + c.ameixa + '"></i><i style="background:' + c.rosa + '"></i></span>' +
      '</button>';
  }
  function desenhar() {
    if (!aberta) return;
    var id = lido();
    aberta.querySelector('.nc-tm-grade').innerHTML = TEMAS.map(function (t) { return cartao(t, t.id === id); }).join('');
    aberta.querySelector('.nc-tm-pe p').innerHTML = 'Agora: <b>' + esc(tema(id).nome) + '</b>. Vale neste navegador.';
    aberta.querySelector('.nc-tm-padrao').hidden = id === PADRAO;
  }
  function escolher(id) {
    guardar(id);
    aplicar(id);
    desenhar();
    var b = aberta && aberta.querySelector('[data-tema="' + id + '"]');
    if (b) b.focus();
  }
  function fechar() {
    if (!aberta) return;
    aberta.remove();
    aberta = null;
    document.removeEventListener('keydown', teclas, true);
    if (voltarPara && voltarPara.focus) voltarPara.focus();
  }
  function teclas(e) {
    if (!aberta) return;
    if (e.key === 'Escape') { e.preventDefault(); fechar(); return; }
    /* setas andam entre os cartões (grupo de rádio) */
    if (/^Arrow/.test(e.key) && e.target.closest && e.target.closest('.nc-tm-cartao')) {
      var lista = [].slice.call(aberta.querySelectorAll('.nc-tm-cartao')), i = lista.indexOf(e.target);
      var n = /Right|Down/.test(e.key) ? i + 1 : i - 1;
      if (n >= 0 && n < lista.length) { e.preventDefault(); lista[n].focus(); }
    }
    /* o foco não sai da janela */
    if (e.key === 'Tab') {
      var f = [].slice.call(aberta.querySelectorAll('button:not([hidden])'));
      if (!f.length) return;
      if (e.shiftKey && document.activeElement === f[0]) { e.preventDefault(); f[f.length - 1].focus(); }
      else if (!e.shiftKey && document.activeElement === f[f.length - 1]) { e.preventDefault(); f[0].focus(); }
    }
  }
  function abrir(origem) {
    if (aberta) return;
    voltarPara = origem || document.activeElement;
    aberta = document.createElement('div');
    aberta.className = 'nc-tm-fundo';
    aberta.innerHTML =
      '<div class="nc-tm" role="dialog" aria-modal="true" aria-labelledby="nc-tm-tit">' +
        '<div class="nc-tm-cab"><div><h2 id="nc-tm-tit">Cores do sistema</h2><p>Toque numa opção: o sistema muda na hora. O menu, os botões e o topo das regiões passam a usar as cores escolhidas.</p></div>' +
          '<button type="button" class="nc-tm-x" aria-label="Fechar">' + X + '</button></div>' +
        '<div class="nc-tm-grade" role="radiogroup" aria-label="Cores do sistema"></div>' +
        '<div class="nc-tm-pe"><p></p><div class="nc-tm-pe-acoes"><button type="button" class="nc-tm-padrao">Voltar ao Padrão Natcorp</button><button type="button" class="nc-tm-pronto">Pronto</button></div></div>' +
      '</div>';
    document.body.appendChild(aberta);
    desenhar();
    aberta.addEventListener('click', function (e) {
      if (e.target === aberta) { fechar(); return; }
      var c = e.target.closest('[data-tema]');
      if (c) { escolher(c.getAttribute('data-tema')); return; }
      if (e.target.closest('.nc-tm-padrao')) { escolher(PADRAO); return; }
      if (e.target.closest('.nc-tm-pronto, .nc-tm-x')) fechar();
    });
    document.addEventListener('keydown', teclas, true);
    var sel = aberta.querySelector('.nc-tm-cartao.is-on') || aberta.querySelector('.nc-tm-cartao');
    if (sel) sel.focus();
  }

  /* o clique no ícone de paleta (posto pelo código do time) abre ESTA janela: pego na fase de
     captura, antes do jQuery do botão, e a janela antiga nem chega a abrir */
  document.addEventListener('click', function (e) {
    var b = e.target.closest && e.target.closest('.nc-theme-navitem button, .nc-theme-navitem .t-Button');
    if (!b) return;
    e.preventDefault();
    e.stopImmediatePropagation();
    abrir(b);
  }, true);

  window.ncAbrirCoresDoSistema = abrir;

  /* ═══ [J4] OS ITENS NO MENU DO USUÁRIO ════════════════════════════════════════════════════
     O QUE FAZ  Põe no menu do usuário: um separador, "Cores", outro separador e o grupo
                Desktop · Tablet · Smartphone (a bolinha mostra o modo atual). O grupo só
                aparece na página de cima (não dentro da moldura do simulador) e em telas com
                900px ou mais de largura.
     COMO       O menu é o widget de menu do APEX; os itens entram pela API dele. O menu do
                usuário é reconhecido por ter um item "Sair" (a barra pode ter outros menus).
                Os itens entram logo depois de "Meus Contatos" (ou antes de "Sair").
     PODE MEXER os nomes: a lista DISP (o segundo texto de cada par) e o label 'Cores'.
     CUIDADO    Não mude o primeiro texto de cada par de DISP ('desktop', 'tablet',
                'mobile'): são os nomes que o botão do time e o simulador usam.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- Cores e os dispositivos no menu do usuário (pedido de 01/10) ----------
     O código do time põe na barra de cima o ícone de cores e três botões de visualização
     (celular, tablet, computador). Eles passam para o menu do usuário (o "365785"), entre
     "Meus Contatos" e "Sair": Cores · Desktop · Tablet · Smartphone. O menu é o widget de menu
     do APEX: os itens entram pela própria API dele (options.items). Os botões do time continuam
     na página, escondidos: Desktop/Tablet/Smartphone são o clique neles (o time guarda e
     aplica a escolha como sempre). Só some da barra quando o menu já recebeu os itens. */
  /* PODE MEXER: o nome de cada aparelho no menu — ['nome interno', 'Texto do menu'] */
  var DISP = [['desktop', 'Desktop'], ['tablet', 'Tablet'], ['mobile', 'Smartphone']];
  function botaoDisp(v) { return document.querySelector('.nc-preview-navitem [data-nc-preview="' + v + '"]'); }

  /* ═══ [J5] O SIMULADOR DE APARELHO (Smartphone / Tablet) ═════════════════════════════════
     O QUE FAZ  Abre por cima da página uma moldura com uma tela do tamanho do aparelho
                (celular 390 × 844, tablet 820 × 1180), reduzida para caber na tela, com a
                MESMA página carregada dentro. Lá dentro tudo responde como no aparelho.
                "Voltar ao Desktop" ou Esc fecham.
     PODE MEXER os tamanhos em APARELHO (w = largura, h = altura, em pixels) e os textos
                'Smartphone', 'Tablet', 'Voltar ao Desktop'.
     VISUAL     Natcorp_Temas.janela.css › [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- Smartphone / Tablet: a página dentro de um aparelho de verdade ----------
     A visualização do time encolhe a página com classes (nc-preview-mobile) — mas o tema APEX e
     as páginas desenhadas respondem à LARGURA REAL da tela (@media max-width), que continuava
     1440: a página ficava estreita com o desenho de computador ("a tela não está responsiva").
     Aqui a página abre numa moldura com uma tela de verdade — um iframe de 390 × 844 (celular)
     ou 820 × 1180 (tablet), reduzido para caber, sem mudar a largura de dentro. Lá dentro tudo
     responde como no aparelho; navegar funciona; a página de trás não recarrega. Desktop fecha.
     A visualização do time fica em "desktop" (o botão dele, clicado) para as duas não somarem. */
  var APARELHO = { mobile: { w: 390, h: 844, nome: 'Smartphone' }, tablet: { w: 820, h: 1180, nome: 'Tablet' } };
  var SIM = null, SIM_MODO = 'desktop';
  function dispAtual() { return SIM_MODO; }
  function escalaSim() {
    if (!SIM) return;
    var a = APARELHO[SIM_MODO], tela = SIM.querySelector('.nc-sim-aparelho');
    var dispW = window.innerWidth - 48, dispH = window.innerHeight - 120;
    var esc = Math.min(1, dispW / (a.w + 28), dispH / (a.h + 28));
    tela.style.width = (a.w + 28) + 'px';
    tela.style.height = (a.h + 28) + 'px';
    tela.style.transform = 'scale(' + esc.toFixed(3) + ')';
    SIM.querySelector('.nc-sim-palco').style.height = Math.ceil((a.h + 28) * esc) + 'px';
    SIM.querySelector('.nc-sim-palco').style.width = Math.ceil((a.w + 28) * esc) + 'px';
    SIM.querySelector('.nc-sim-medida').textContent = a.w + ' × ' + a.h + (esc < 1 ? ' · mostrado a ' + Math.round(esc * 100) + '%' : '');
    [].forEach.call(SIM.querySelectorAll('[data-sim]'), function (b) { var on = b.getAttribute('data-sim') === SIM_MODO; b.classList.toggle('is-on', on); b.setAttribute('aria-pressed', on); });
  }
  function simular(modo) {
    /* a visualização antiga (encolher por classes) desligada pelo próprio botão do time */
    var bd = botaoDisp('desktop');
    if (bd && bd.getAttribute('aria-pressed') !== 'true') bd.click();
    if (modo === 'desktop' || !APARELHO[modo]) { fecharSim(); return; }
    SIM_MODO = modo;
    if (!SIM) {
      SIM = document.createElement('div');
      SIM.className = 'nc-sim';
      SIM.setAttribute('role', 'dialog');
      SIM.setAttribute('aria-label', 'Visualização em aparelho');
      SIM.innerHTML =
        '<div class="nc-sim-barra"><div class="nc-sim-modos" role="group" aria-label="Aparelho">' +
          '<button type="button" data-sim="mobile">Smartphone</button><button type="button" data-sim="tablet">Tablet</button></div>' +
          '<span class="nc-sim-medida"></span>' +
          '<button type="button" class="nc-sim-sair" data-sim="desktop">Voltar ao Desktop</button></div>' +
        '<div class="nc-sim-palco"><div class="nc-sim-aparelho"><iframe class="nc-sim-tela" title="A página como aparece no aparelho"></iframe></div></div>';
      document.body.appendChild(SIM);
      SIM.querySelector('iframe').src = location.href;
      SIM.addEventListener('click', function (e) { var b = e.target.closest('[data-sim]'); if (b) simular(b.getAttribute('data-sim')); });
      window.addEventListener('resize', escalaSim);
      document.addEventListener('keydown', teclaSim, true);
      document.body.classList.add('nc-sim-aberto');
    }
    SIM.setAttribute('data-modo', modo);
    escalaSim();
  }
  function teclaSim(e) { if (e.key === 'Escape' && SIM && !document.querySelector('.nc-tm-fundo')) { e.preventDefault(); fecharSim(); } }
  function fecharSim() {
    SIM_MODO = 'desktop';
    if (!SIM) return;
    SIM.remove(); SIM = null;
    window.removeEventListener('resize', escalaSim);
    document.removeEventListener('keydown', teclaSim, true);
    document.body.classList.remove('nc-sim-aberto');
  }
  window.ncSimularAparelho = simular;
  /* [J4] (continuação) noMenu: põe os itens no menu do usuário */
  function noMenu() {
    var $ = window.apex && apex.jQuery;
    if (!$) return false;   /* 07/10: não depende mais do ícone de paleta do time (versão limpa) */
    /* o menu do USUÁRIO é o que tem "Sair": a barra pode ter outros menus antes dele (o de
       Notificações ganha um submenu de alertas) — pegar o primeiro pôs os itens no lugar errado */
    var bt = null, $m = null, itens = null;
    [].some.call(document.querySelectorAll('.t-Header-navBar .js-menuButton[data-menu]'), function (b) {
      try {
        var $x = $('#' + b.getAttribute('data-menu')), it = $x.menu('option', 'items');
        if (it && it.some(function (i) { return /^sair$/i.test(i.label || ''); })) { bt = b; $m = $x; itens = it; return true; }
      } catch (e) { /* menu ainda não montado */ }
      return false;
    });
    if (!bt || !itens) return false;
    if (itens.some(function (i) { return i.ncTemas; })) return true;
    var sair = -1, contatos = -1;
    itens.forEach(function (i, k) { if (/^sair$/i.test(i.label || '')) sair = k; if (/meus contatos/i.test(i.label || '')) contatos = k; });
    var pos = contatos >= 0 ? contatos + 1 : sair >= 0 ? sair : itens.length;
    var novos = [{ type: 'separator', ncTemas: true },
      { type: 'action', label: 'Cores', icon: 'fa-paint-brush', iconType: 'fa', ncTemas: true, action: function () { setTimeout(function () { abrir(bt); }, 0); } }];
    /* os aparelhos: só na página de cima (não dentro da própria moldura) e numa tela grande o
       bastante para ter o que simular */
    if (window.self === window.top && window.innerWidth >= 900) {
      novos.push({ type: 'separator', ncTemas: true });
      novos.push({ type: 'radioGroup', ncTemas: true, get: dispAtual,
        set: function (v) { setTimeout(function () { simular(v); }, 0); },
        choices: DISP.map(function (d) { return { label: d[1], value: d[0] }; }) });
    }
    /* quem tinha escolhido a visualização antiga (encolher por classes) volta ao normal */
    var bd = botaoDisp('desktop');
    if (bd && bd.getAttribute('aria-pressed') !== 'true') bd.click();
    if (sair >= 0) novos.push({ type: 'separator', ncTemas: true });
    itens.splice.apply(itens, [pos, 0].concat(novos));
    $m.menu('option', 'items', itens);
    document.body.classList.add('nc-tm-no-menu');
    return true;
  }
  /* o menu e os botões do time nascem depois da página (o time espera o menu estar montado):
     tenta por alguns segundos */
  var tentativas = 0;
  (function tentar() { if (noMenu() || ++tentativas > 40) return; setTimeout(tentar, 250); })();
})();
