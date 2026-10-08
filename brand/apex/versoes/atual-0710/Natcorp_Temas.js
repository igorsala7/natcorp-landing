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
     • O ícone de paleta e a PROPAGAÇÃO do tema pelas telas são do arquivo do time
       Natcorp_Allow_Unload_Iframes.js (NÃO ALTERAR aquele arquivo). Ele grava a escolha no
       navegador (localStorage "nc_theme_choice"), põe nc-theme-<id> no <html> e repassa a
       classe a todo iframe e janela, a cada navegação. Este arquivo usa a MESMA chave e o
       MESMO formato de classe — a propagação do time continua valendo.

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
       → o menu precisa ter um item chamado "Sair" (é assim que ele é reconhecido) e a página
         precisa ter o ícone de paleta do time (.nc-theme-navitem). Veja [J4].
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
     PODE MEXER a lista PECAS (o nome do arquivo, como subiu no Workspace Images).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PECAS = ['Natcorp_Registros.js', 'Natcorp_Trilha.js', 'Natcorp_Editor.js', 'Natcorp_Lov.js', 'Natcorp_Colab.js'];
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
  var TEMAS = [
  {
    "id": "purple",
    "nome": "Padrão Natcorp",
    "desc": "As cores da marca: azul profundo, roxo e rosa.",
    "cores": {
      "azul": "#2C1A63",
      "roxo": "#511C76",
      "ameixa": "#9A408A",
      "rosa": "#C95788",
      "claro": "#E4A9C4"
    },
    "painel": {
      "#C95788": "#C95788",
      "#E4A9C4": "#E4A9C4",
      "#F3C9DA": "#F3C9DA",
      "#511C76": "#511C76",
      "rgba(228,169,196,.75)": "rgba(228,169,196,.75)"
    }
  },
  {
    "id": "nc2-ameixa",
    "nome": "Ameixa Natcorp",
    "desc": "A marca com a ameixa na frente, mais quente.",
    "cores": {
      "azul": "#511C76",
      "roxo": "#742B7F",
      "ameixa": "#9A408A",
      "rosa": "#C95788",
      "claro": "#E4A9C4"
    },
    "painel": {
      "#C95788": "#C95788",
      "#E4A9C4": "#E4A9C4",
      "#F3C9DA": "#F3C9DA",
      "#511C76": "#742B7F",
      "rgba(228,169,196,.75)": "rgba(228,169,196,.75)"
    }
  },
  {
    "id": "nc2-noite",
    "nome": "Noite Natcorp",
    "desc": "A marca com o azul profundo na frente, mais sóbria.",
    "cores": {
      "azul": "#1E1049",
      "roxo": "#2C1A63",
      "ameixa": "#511C76",
      "rosa": "#C95788",
      "claro": "#E4A9C4"
    },
    "painel": {
      "#C95788": "#C95788",
      "#E4A9C4": "#E4A9C4",
      "#F3C9DA": "#F3C9DA",
      "#511C76": "#2C1A63",
      "rgba(228,169,196,.75)": "rgba(228,169,196,.75)"
    }
  },
  {
    "id": "nc2-fucsia",
    "nome": "Fúcsia",
    "desc": "Magenta e framboesa, com coral nos detalhes.",
    "cores": {
      "azul": "#480A4B",
      "roxo": "#6C064D",
      "ameixa": "#AD3950",
      "rosa": "#D05B43",
      "claro": "#EBAAA2"
    },
    "painel": {
      "#C95788": "#D05B43",
      "#E4A9C4": "#EBAAA2",
      "#F3C9DA": "#F7CAC3",
      "#511C76": "#6C064D",
      "rgba(228,169,196,.75)": "rgba(235,170,162,.75)"
    }
  },
  {
    "id": "nc2-rubi",
    "nome": "Rubi",
    "desc": "Vermelho-vinho, com dourado nos detalhes.",
    "cores": {
      "azul": "#55002E",
      "roxo": "#750023",
      "ameixa": "#AC4208",
      "rosa": "#BE6F00",
      "claro": "#E4B18C"
    },
    "painel": {
      "#C95788": "#BE6F00",
      "#E4A9C4": "#E4B18C",
      "#F3C9DA": "#F1CFB5",
      "#511C76": "#750023",
      "rgba(228,169,196,.75)": "rgba(228,177,140,.75)"
    }
  },
  {
    "id": "nc2-vermelho",
    "nome": "Vermelho",
    "desc": "Vermelho puro nos detalhes, vinho profundo no menu e nos botões.",
    "cores": {
      "azul": "#59000E",
      "roxo": "#770007",
      "ameixa": "#C11911",
      "rosa": "#FF0000",
      "claro": "#EBAAA4"
    },
    "painel": {
      "#C95788": "#FF0000",
      "#E4A9C4": "#EBAAA4",
      "#F3C9DA": "#F7C7C2",
      "#511C76": "#770007",
      "rgba(228,169,196,.75)": "rgba(235,170,164,.75)"
    }
  },
  {
    "id": "nc2-terracota",
    "nome": "Terracota",
    "desc": "Telha e ferrugem, com mostarda nos detalhes.",
    "cores": {
      "azul": "#59000C",
      "roxo": "#692200",
      "ameixa": "#915A00",
      "rosa": "#A18000",
      "claro": "#D4BA83"
    },
    "painel": {
      "#C95788": "#A18000",
      "#E4A9C4": "#D4BA83",
      "#F3C9DA": "#E5D5B0",
      "#511C76": "#692200",
      "rgba(228,169,196,.75)": "rgba(212,186,131,.75)"
    }
  },
  {
    "id": "nc2-ambar",
    "nome": "Âmbar",
    "desc": "Mel queimado e ouro velho, com oliva nos detalhes.",
    "cores": {
      "azul": "#481E00",
      "roxo": "#553400",
      "ameixa": "#776900",
      "rosa": "#799000",
      "claro": "#BBC38A"
    },
    "painel": {
      "#C95788": "#799000",
      "#E4A9C4": "#BBC38A",
      "#F3C9DA": "#D4DBB5",
      "#511C76": "#553400",
      "rgba(228,169,196,.75)": "rgba(187,195,138,.75)"
    }
  },
  {
    "id": "nc2-oliva",
    "nome": "Oliva",
    "desc": "Verde-oliva e musgo, com verde-água nos detalhes.",
    "cores": {
      "azul": "#372A00",
      "roxo": "#3E4000",
      "ameixa": "#307C19",
      "rosa": "#009D68",
      "claro": "#96CCA7"
    },
    "painel": {
      "#C95788": "#009D68",
      "#E4A9C4": "#96CCA7",
      "#F3C9DA": "#BBE1C9",
      "#511C76": "#3E4000",
      "rgba(228,169,196,.75)": "rgba(150,204,167,.75)"
    }
  },
  {
    "id": "nc2-esmeralda",
    "nome": "Esmeralda",
    "desc": "Verde profundo, com turquesa nos detalhes.",
    "cores": {
      "azul": "#1D3300",
      "roxo": "#004A1D",
      "ameixa": "#007A68",
      "rosa": "#00979C",
      "claro": "#7FCDCA"
    },
    "painel": {
      "#C95788": "#00979C",
      "#E4A9C4": "#7FCDCA",
      "#F3C9DA": "#AFE2E1",
      "#511C76": "#004A1D",
      "rgba(228,169,196,.75)": "rgba(127,205,202,.75)"
    }
  },
  {
    "id": "nc2-turquesa",
    "nome": "Turquesa",
    "desc": "Verde-água escuro, com azul-céu nos detalhes.",
    "cores": {
      "azul": "#003522",
      "roxo": "#00473F",
      "ameixa": "#007684",
      "rosa": "#0091C0",
      "claro": "#85C8E2"
    },
    "painel": {
      "#C95788": "#0091C0",
      "#E4A9C4": "#85C8E2",
      "#F3C9DA": "#B3DEF1",
      "#511C76": "#00473F",
      "rgba(228,169,196,.75)": "rgba(133,200,226,.75)"
    }
  },
  {
    "id": "nc2-petroleo",
    "nome": "Petróleo",
    "desc": "Azul-petróleo, com azul vivo nos detalhes.",
    "cores": {
      "azul": "#003431",
      "roxo": "#00454D",
      "ameixa": "#00719F",
      "rosa": "#4084DF",
      "claro": "#98C1EE"
    },
    "painel": {
      "#C95788": "#4084DF",
      "#E4A9C4": "#98C1EE",
      "#F3C9DA": "#BFD9F9",
      "#511C76": "#00454D",
      "rgba(228,169,196,.75)": "rgba(152,193,238,.75)"
    }
  },
  {
    "id": "nc2-oceano",
    "nome": "Oceano",
    "desc": "Azul-marinho, com lavanda nos detalhes.",
    "cores": {
      "azul": "#00323D",
      "roxo": "#00425F",
      "ameixa": "#3963BE",
      "rosa": "#7C74DC",
      "claro": "#B1B9EF"
    },
    "painel": {
      "#C95788": "#7C74DC",
      "#E4A9C4": "#B1B9EF",
      "#F3C9DA": "#CFD3F9",
      "#511C76": "#00425F",
      "rgba(228,169,196,.75)": "rgba(177,185,239,.75)"
    }
  },
  {
    "id": "nc2-anil",
    "nome": "Anil",
    "desc": "Azul-violeta, com orquídea nos detalhes.",
    "cores": {
      "azul": "#002E50",
      "roxo": "#183287",
      "ameixa": "#6F52B5",
      "rosa": "#A664C4",
      "claro": "#CBB0E3"
    },
    "painel": {
      "#C95788": "#A664C4",
      "#E4A9C4": "#CBB0E3",
      "#F3C9DA": "#E1CDF1",
      "#511C76": "#183287",
      "rgba(228,169,196,.75)": "rgba(203,176,227,.75)"
    }
  },
  {
    "id": "nc2-grafite",
    "nome": "Grafite & Rosa",
    "desc": "Cinza-grafite neutro, com o rosa da marca nos detalhes.",
    "cores": {
      "azul": "#2B2B34",
      "roxo": "#3F3946",
      "ameixa": "#74626F",
      "rosa": "#C95788",
      "claro": "#E4A9C4"
    },
    "painel": {
      "#C95788": "#C95788",
      "#E4A9C4": "#E4A9C4",
      "#F3C9DA": "#F3C9DA",
      "#511C76": "#3F3946",
      "rgba(228,169,196,.75)": "rgba(228,169,196,.75)"
    }
  }
];
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
  var PAINEL = ["<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 300 1000\" preserveAspectRatio=\"xMidYMid slice\"><style>.draw{stroke-dasharray:1 1;stroke-dashoffset:1;opacity:0;animation:draw 2.2s cubic-bezier(.22,1,.36,1) .2s forwards}.d2{animation-duration:2.6s;animation-delay:.7s}.fl{animation-duration:1.8s}@keyframes draw{to{stroke-dashoffset:0;opacity:1}}.run{stroke-dasharray:.07 1;opacity:0;animation:run 14s linear infinite,in 1.2s ease 2.4s forwards}.run.w{stroke-dasharray:.055 1}@keyframes run{from{stroke-dashoffset:0}to{stroke-dashoffset:-2}}.pk{stroke-dasharray:.08 1;stroke-dashoffset:1;opacity:0;animation:pk linear infinite,in 1s ease forwards}@keyframes pk{from{stroke-dashoffset:1}to{stroke-dashoffset:-1}}@keyframes in{to{opacity:var(--o,1)}}.small{opacity:0;transform-box:fill-box;transform-origin:center;animation:in 1.2s cubic-bezier(.22,1,.36,1) 1.2s forwards,breathe 6s ease-in-out 2.4s infinite}@keyframes breathe{50%{transform:scale(1.05)}}.glow{animation:drift 12s ease-in-out infinite}@keyframes drift{0%,100%{transform:translate(0,0);opacity:.5}50%{transform:translate(60px,90px);opacity:.9}}.net{animation:slide 150s linear infinite}@keyframes slide{to{transform:translateX(-300px)}}</style><defs><radialGradient id=\"g\" cx=\".5\" cy=\".5\" r=\".5\"><stop offset=\"0\" stop-color=\"#C95788\" stop-opacity=\".3\"/><stop offset=\".45\" stop-color=\"#C95788\" stop-opacity=\".1\"/><stop offset=\"1\" stop-color=\"#C95788\" stop-opacity=\"0\"/></radialGradient><pattern id=\"grid\" width=\"56\" height=\"56\" patternUnits=\"userSpaceOnUse\"><path d=\"M56 0H0V56\" fill=\"none\" stroke=\"#fff\" stroke-opacity=\".06\"/></pattern><radialGradient id=\"gm\" cx=\"0.7166666666666667\" cy=\"0.905\" r=\".62\"><stop offset=\"0\" stop-color=\"#fff\"/><stop offset=\".75\" stop-color=\"#fff\" stop-opacity=\"0\"/></radialGradient><mask id=\"mg\"><rect width=\"300\" height=\"1000\" fill=\"url(#gm)\"/></mask><linearGradient id=\"nm\" x1=\"0\" x2=\"0\" y1=\"0\" y2=\"1\"><stop offset=\"0\" stop-color=\"#fff\" stop-opacity=\".5\"/><stop offset=\"1\" stop-color=\"#fff\" stop-opacity=\".8\"/></linearGradient><mask id=\"mn\"><rect width=\"300\" height=\"1000\" fill=\"url(#nm)\"/></mask><linearGradient id=\"edge\" x1=\"0\" y1=\"0\" x2=\"1\" y2=\"1\"><stop offset=\"0\" stop-color=\"#F3C9DA\" stop-opacity=\".95\"/><stop offset=\".5\" stop-color=\"#E4A9C4\" stop-opacity=\".75\"/><stop offset=\"1\" stop-color=\"#C95788\" stop-opacity=\".4\"/></linearGradient><linearGradient id=\"edge2\" x1=\"0\" y1=\"0\" x2=\"1\" y2=\"1\"><stop offset=\"0\" stop-color=\"#E4A9C4\" stop-opacity=\".9\"/><stop offset=\".5\" stop-color=\"#C95788\" stop-opacity=\".75\"/><stop offset=\"1\" stop-color=\"#C95788\" stop-opacity=\".45\"/></linearGradient><linearGradient id=\"glass\" x1=\"0\" y1=\"0\" x2=\"1\" y2=\"1\"><stop offset=\"0\" stop-color=\"#F3C9DA\" stop-opacity=\".3\"/><stop offset=\".55\" stop-color=\"#C95788\" stop-opacity=\".16\"/><stop offset=\"1\" stop-color=\"#511C76\" stop-opacity=\".1\"/></linearGradient></defs><rect width=\"300\" height=\"1000\" fill=\"url(#grid)\" mask=\"url(#mg)\"/><g mask=\"url(#mn)\" opacity=\"0.55\"><g class=\"net\"><g id=\"t\"><g stroke=\"#E4A9C4\" stroke-width=\"1\"><line x1=\"0.0\" y1=\"920.8\" x2=\"-126.8\" y2=\"912.0\" stroke-opacity=\"0.043\"/><line x1=\"63.2\" y1=\"729.4\" x2=\"98.8\" y2=\"752.1\" stroke-opacity=\"0.201\"/><line x1=\"63.2\" y1=\"729.4\" x2=\"162.9\" y2=\"684.5\" stroke-opacity=\"0.076\"/><line x1=\"63.2\" y1=\"729.4\" x2=\"-23.0\" y2=\"688.5\" stroke-opacity=\"0.102\"/><line x1=\"63.2\" y1=\"729.4\" x2=\"167.2\" y2=\"729.3\" stroke-opacity=\"0.086\"/><line x1=\"98.8\" y1=\"752.1\" x2=\"162.9\" y2=\"684.5\" stroke-opacity=\"0.106\"/><line x1=\"98.8\" y1=\"752.1\" x2=\"212.4\" y2=\"698.0\" stroke-opacity=\"0.045\"/><line x1=\"98.8\" y1=\"752.1\" x2=\"-23.0\" y2=\"688.5\" stroke-opacity=\"0.023\"/><line x1=\"98.8\" y1=\"752.1\" x2=\"167.2\" y2=\"729.3\" stroke-opacity=\"0.145\"/><line x1=\"162.9\" y1=\"684.5\" x2=\"212.4\" y2=\"698.0\" stroke-opacity=\"0.184\"/><line x1=\"162.9\" y1=\"684.5\" x2=\"277.0\" y2=\"688.5\" stroke-opacity=\"0.067\"/><line x1=\"162.9\" y1=\"684.5\" x2=\"167.2\" y2=\"729.3\" stroke-opacity=\"0.196\"/><line x1=\"245.0\" y1=\"242.0\" x2=\"242.2\" y2=\"122.8\" stroke-opacity=\"0.057\"/><line x1=\"245.0\" y1=\"242.0\" x2=\"128.5\" y2=\"294.9\" stroke-opacity=\"0.041\"/><line x1=\"212.4\" y1=\"698.0\" x2=\"277.0\" y2=\"688.5\" stroke-opacity=\"0.158\"/><line x1=\"212.4\" y1=\"698.0\" x2=\"167.2\" y2=\"729.3\" stroke-opacity=\"0.178\"/><line x1=\"242.2\" y1=\"122.8\" x2=\"99.7\" y2=\"152.6\" stroke-opacity=\"0.008\"/><line x1=\"277.0\" y1=\"688.5\" x2=\"167.2\" y2=\"729.3\" stroke-opacity=\"0.061\"/><line x1=\"111.7\" y1=\"335.4\" x2=\"128.5\" y2=\"294.9\" stroke-opacity=\"0.198\"/><line x1=\"99.7\" y1=\"152.6\" x2=\"128.5\" y2=\"294.9\" stroke-opacity=\"0.009\"/></g><g fill=\"rgba(228,169,196,.75)\"><circle cx=\"0.0\" cy=\"920.8\" r=\"1.85\"/><circle cx=\"63.2\" cy=\"729.4\" r=\"2.31\"/><circle cx=\"98.8\" cy=\"752.1\" r=\"2.73\"/><circle cx=\"162.9\" cy=\"684.5\" r=\"2.51\"/><circle cx=\"245.0\" cy=\"242.0\" r=\"2.01\"/><circle cx=\"212.4\" cy=\"698.0\" r=\"1.40\"/><circle cx=\"205.2\" cy=\"467.9\" r=\"3.05\"/><circle cx=\"242.2\" cy=\"122.8\" r=\"2.27\"/><circle cx=\"277.0\" cy=\"688.5\" r=\"2.52\"/><circle cx=\"173.2\" cy=\"912.0\" r=\"3.03\"/><circle cx=\"111.7\" cy=\"335.4\" r=\"2.89\"/><circle cx=\"99.7\" cy=\"152.6\" r=\"1.87\"/><circle cx=\"128.5\" cy=\"294.9\" r=\"3.08\"/><circle cx=\"167.2\" cy=\"729.3\" r=\"2.97\"/></g></g><use href=\"#t\" x=\"300\"/></g></g><ellipse class=\"glow\" cx=\"60\" cy=\"170\" rx=\"170\" ry=\"380\" fill=\"url(#g)\"/><g transform=\"translate(215 905) scale(0.21) translate(-1412 -425)\" fill=\"none\" stroke-linecap=\"round\"><path class=\"draw fl\" d=\"M-128 945 C 412 905, 712 725, 992 645 S 1492 425, 2352 365\" pathLength=\"1\" stroke=\"#F3C9DA\" stroke-width=\"1.6\" stroke-opacity=\".3\"/><path class=\"draw fl\" d=\"M-128 989 C 412 949, 712 751, 992 671 S 1492 455, 2352 395\" pathLength=\"1\" stroke=\"#F3C9DA\" stroke-width=\"1.6\" stroke-opacity=\".3\"/><path class=\"draw fl\" d=\"M-128 1033 C 412 993, 712 777, 992 697 S 1492 485, 2352 425\" pathLength=\"1\" stroke=\"#F3C9DA\" stroke-width=\"1.6\" stroke-opacity=\".3\"/><path class=\"draw fl\" d=\"M-128 1077 C 412 1037, 712 803, 992 723 S 1492 515, 2352 455\" pathLength=\"1\" stroke=\"#F3C9DA\" stroke-width=\"1.6\" stroke-opacity=\".3\"/><path class=\"draw fl\" d=\"M-128 1121 C 412 1081, 712 829, 992 749 S 1492 545, 2352 485\" pathLength=\"1\" stroke=\"#F3C9DA\" stroke-width=\"1.6\" stroke-opacity=\".3\"/><g transform=\"translate(1300 500) rotate(12) scale(1.12) translate(-1412 -425)\"><path class=\"draw d2\" d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"#C95788\" stroke-width=\"8\" stroke-opacity=\".16\"/><path class=\"draw d2\" d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"url(#edge2)\" stroke-width=\"2.4\"/></g><path class=\"draw\" d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"#E4A9C4\" stroke-width=\"30\" stroke-opacity=\".1\"/><path class=\"draw\" d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"#E4A9C4\" stroke-width=\"12\" stroke-opacity=\".2\"/><path class=\"draw\" d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"url(#edge)\" stroke-width=\"3.5\"/><path class=\"pk\" d=\"M-128 945 C 412 905, 712 725, 992 645 S 1492 425, 2352 365\" pathLength=\"1\" stroke=\"#fff\" stroke-width=\"2.2\" stroke-opacity=\".9\" style=\"animation-duration:7s,1s;animation-delay:0s,0s\"/><path class=\"pk\" d=\"M-128 989 C 412 949, 712 751, 992 671 S 1492 455, 2352 395\" pathLength=\"1\" stroke=\"#fff\" stroke-width=\"2.2\" stroke-opacity=\".9\" style=\"animation-duration:7.8s,1s;animation-delay:0.6s,0.6s\"/><path class=\"pk\" d=\"M-128 1033 C 412 993, 712 777, 992 697 S 1492 485, 2352 425\" pathLength=\"1\" stroke=\"#fff\" stroke-width=\"2.2\" stroke-opacity=\".9\" style=\"animation-duration:8.6s,1s;animation-delay:1.2s,1.2s\"/><path class=\"pk\" d=\"M-128 1077 C 412 1037, 712 803, 992 723 S 1492 515, 2352 455\" pathLength=\"1\" stroke=\"#fff\" stroke-width=\"2.2\" stroke-opacity=\".9\" style=\"animation-duration:9.4s,1s;animation-delay:1.7999999999999998s,1.7999999999999998s\"/><path class=\"pk\" d=\"M-128 1121 C 412 1081, 712 829, 992 749 S 1492 545, 2352 485\" pathLength=\"1\" stroke=\"#fff\" stroke-width=\"2.2\" stroke-opacity=\".9\" style=\"animation-duration:10.2s,1s;animation-delay:2.4s,2.4s\"/><path class=\"run\" d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"#F3C9DA\" stroke-width=\"14\" style=\"--o:.45\"/><path class=\"run w\" d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"#fff\" stroke-width=\"5\"/><g class=\"small\"><g transform=\"translate(942 855) scale(0.26) translate(-1412 -425)\"><path d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" fill=\"url(#glass)\" stroke=\"#F3C9DA\" stroke-width=\"5\" stroke-opacity=\".8\"/><path d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" stroke=\"#fff\" stroke-width=\"2.5\" stroke-opacity=\".5\" transform=\"translate(-16 -16)\"/></g></g></g></svg>", "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 300 1000\" preserveAspectRatio=\"xMidYMid slice\"><style>.pk,.run{display:none}.glow{opacity:.6}</style><defs><radialGradient id=\"g\" cx=\".5\" cy=\".5\" r=\".5\"><stop offset=\"0\" stop-color=\"#C95788\" stop-opacity=\".3\"/><stop offset=\".45\" stop-color=\"#C95788\" stop-opacity=\".1\"/><stop offset=\"1\" stop-color=\"#C95788\" stop-opacity=\"0\"/></radialGradient><pattern id=\"grid\" width=\"56\" height=\"56\" patternUnits=\"userSpaceOnUse\"><path d=\"M56 0H0V56\" fill=\"none\" stroke=\"#fff\" stroke-opacity=\".06\"/></pattern><radialGradient id=\"gm\" cx=\"0.7166666666666667\" cy=\"0.905\" r=\".62\"><stop offset=\"0\" stop-color=\"#fff\"/><stop offset=\".75\" stop-color=\"#fff\" stop-opacity=\"0\"/></radialGradient><mask id=\"mg\"><rect width=\"300\" height=\"1000\" fill=\"url(#gm)\"/></mask><linearGradient id=\"nm\" x1=\"0\" x2=\"0\" y1=\"0\" y2=\"1\"><stop offset=\"0\" stop-color=\"#fff\" stop-opacity=\".5\"/><stop offset=\"1\" stop-color=\"#fff\" stop-opacity=\".8\"/></linearGradient><mask id=\"mn\"><rect width=\"300\" height=\"1000\" fill=\"url(#nm)\"/></mask><linearGradient id=\"edge\" x1=\"0\" y1=\"0\" x2=\"1\" y2=\"1\"><stop offset=\"0\" stop-color=\"#F3C9DA\" stop-opacity=\".95\"/><stop offset=\".5\" stop-color=\"#E4A9C4\" stop-opacity=\".75\"/><stop offset=\"1\" stop-color=\"#C95788\" stop-opacity=\".4\"/></linearGradient><linearGradient id=\"edge2\" x1=\"0\" y1=\"0\" x2=\"1\" y2=\"1\"><stop offset=\"0\" stop-color=\"#E4A9C4\" stop-opacity=\".9\"/><stop offset=\".5\" stop-color=\"#C95788\" stop-opacity=\".75\"/><stop offset=\"1\" stop-color=\"#C95788\" stop-opacity=\".45\"/></linearGradient><linearGradient id=\"glass\" x1=\"0\" y1=\"0\" x2=\"1\" y2=\"1\"><stop offset=\"0\" stop-color=\"#F3C9DA\" stop-opacity=\".3\"/><stop offset=\".55\" stop-color=\"#C95788\" stop-opacity=\".16\"/><stop offset=\"1\" stop-color=\"#511C76\" stop-opacity=\".1\"/></linearGradient></defs><rect width=\"300\" height=\"1000\" fill=\"url(#grid)\" mask=\"url(#mg)\"/><g mask=\"url(#mn)\" opacity=\"0.55\"><g class=\"net\"><g id=\"t\"><g stroke=\"#E4A9C4\" stroke-width=\"1\"><line x1=\"0.0\" y1=\"920.8\" x2=\"-126.8\" y2=\"912.0\" stroke-opacity=\"0.043\"/><line x1=\"63.2\" y1=\"729.4\" x2=\"98.8\" y2=\"752.1\" stroke-opacity=\"0.201\"/><line x1=\"63.2\" y1=\"729.4\" x2=\"162.9\" y2=\"684.5\" stroke-opacity=\"0.076\"/><line x1=\"63.2\" y1=\"729.4\" x2=\"-23.0\" y2=\"688.5\" stroke-opacity=\"0.102\"/><line x1=\"63.2\" y1=\"729.4\" x2=\"167.2\" y2=\"729.3\" stroke-opacity=\"0.086\"/><line x1=\"98.8\" y1=\"752.1\" x2=\"162.9\" y2=\"684.5\" stroke-opacity=\"0.106\"/><line x1=\"98.8\" y1=\"752.1\" x2=\"212.4\" y2=\"698.0\" stroke-opacity=\"0.045\"/><line x1=\"98.8\" y1=\"752.1\" x2=\"-23.0\" y2=\"688.5\" stroke-opacity=\"0.023\"/><line x1=\"98.8\" y1=\"752.1\" x2=\"167.2\" y2=\"729.3\" stroke-opacity=\"0.145\"/><line x1=\"162.9\" y1=\"684.5\" x2=\"212.4\" y2=\"698.0\" stroke-opacity=\"0.184\"/><line x1=\"162.9\" y1=\"684.5\" x2=\"277.0\" y2=\"688.5\" stroke-opacity=\"0.067\"/><line x1=\"162.9\" y1=\"684.5\" x2=\"167.2\" y2=\"729.3\" stroke-opacity=\"0.196\"/><line x1=\"245.0\" y1=\"242.0\" x2=\"242.2\" y2=\"122.8\" stroke-opacity=\"0.057\"/><line x1=\"245.0\" y1=\"242.0\" x2=\"128.5\" y2=\"294.9\" stroke-opacity=\"0.041\"/><line x1=\"212.4\" y1=\"698.0\" x2=\"277.0\" y2=\"688.5\" stroke-opacity=\"0.158\"/><line x1=\"212.4\" y1=\"698.0\" x2=\"167.2\" y2=\"729.3\" stroke-opacity=\"0.178\"/><line x1=\"242.2\" y1=\"122.8\" x2=\"99.7\" y2=\"152.6\" stroke-opacity=\"0.008\"/><line x1=\"277.0\" y1=\"688.5\" x2=\"167.2\" y2=\"729.3\" stroke-opacity=\"0.061\"/><line x1=\"111.7\" y1=\"335.4\" x2=\"128.5\" y2=\"294.9\" stroke-opacity=\"0.198\"/><line x1=\"99.7\" y1=\"152.6\" x2=\"128.5\" y2=\"294.9\" stroke-opacity=\"0.009\"/></g><g fill=\"rgba(228,169,196,.75)\"><circle cx=\"0.0\" cy=\"920.8\" r=\"1.85\"/><circle cx=\"63.2\" cy=\"729.4\" r=\"2.31\"/><circle cx=\"98.8\" cy=\"752.1\" r=\"2.73\"/><circle cx=\"162.9\" cy=\"684.5\" r=\"2.51\"/><circle cx=\"245.0\" cy=\"242.0\" r=\"2.01\"/><circle cx=\"212.4\" cy=\"698.0\" r=\"1.40\"/><circle cx=\"205.2\" cy=\"467.9\" r=\"3.05\"/><circle cx=\"242.2\" cy=\"122.8\" r=\"2.27\"/><circle cx=\"277.0\" cy=\"688.5\" r=\"2.52\"/><circle cx=\"173.2\" cy=\"912.0\" r=\"3.03\"/><circle cx=\"111.7\" cy=\"335.4\" r=\"2.89\"/><circle cx=\"99.7\" cy=\"152.6\" r=\"1.87\"/><circle cx=\"128.5\" cy=\"294.9\" r=\"3.08\"/><circle cx=\"167.2\" cy=\"729.3\" r=\"2.97\"/></g></g><use href=\"#t\" x=\"300\"/></g></g><ellipse class=\"glow\" cx=\"60\" cy=\"170\" rx=\"170\" ry=\"380\" fill=\"url(#g)\"/><g transform=\"translate(215 905) scale(0.21) translate(-1412 -425)\" fill=\"none\" stroke-linecap=\"round\"><path  d=\"M-128 945 C 412 905, 712 725, 992 645 S 1492 425, 2352 365\" pathLength=\"1\" stroke=\"#F3C9DA\" stroke-width=\"1.6\" stroke-opacity=\".3\"/><path  d=\"M-128 989 C 412 949, 712 751, 992 671 S 1492 455, 2352 395\" pathLength=\"1\" stroke=\"#F3C9DA\" stroke-width=\"1.6\" stroke-opacity=\".3\"/><path  d=\"M-128 1033 C 412 993, 712 777, 992 697 S 1492 485, 2352 425\" pathLength=\"1\" stroke=\"#F3C9DA\" stroke-width=\"1.6\" stroke-opacity=\".3\"/><path  d=\"M-128 1077 C 412 1037, 712 803, 992 723 S 1492 515, 2352 455\" pathLength=\"1\" stroke=\"#F3C9DA\" stroke-width=\"1.6\" stroke-opacity=\".3\"/><path  d=\"M-128 1121 C 412 1081, 712 829, 992 749 S 1492 545, 2352 485\" pathLength=\"1\" stroke=\"#F3C9DA\" stroke-width=\"1.6\" stroke-opacity=\".3\"/><g transform=\"translate(1300 500) rotate(12) scale(1.12) translate(-1412 -425)\"><path  d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"#C95788\" stroke-width=\"8\" stroke-opacity=\".16\"/><path  d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"url(#edge2)\" stroke-width=\"2.4\"/></g><path  d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"#E4A9C4\" stroke-width=\"30\" stroke-opacity=\".1\"/><path  d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"#E4A9C4\" stroke-width=\"12\" stroke-opacity=\".2\"/><path  d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"url(#edge)\" stroke-width=\"3.5\"/><path class=\"pk\" d=\"M-128 945 C 412 905, 712 725, 992 645 S 1492 425, 2352 365\" pathLength=\"1\" stroke=\"#fff\" stroke-width=\"2.2\" stroke-opacity=\".9\" style=\"animation-duration:7s,1s;animation-delay:0s,0s\"/><path class=\"pk\" d=\"M-128 989 C 412 949, 712 751, 992 671 S 1492 455, 2352 395\" pathLength=\"1\" stroke=\"#fff\" stroke-width=\"2.2\" stroke-opacity=\".9\" style=\"animation-duration:7.8s,1s;animation-delay:0.6s,0.6s\"/><path class=\"pk\" d=\"M-128 1033 C 412 993, 712 777, 992 697 S 1492 485, 2352 425\" pathLength=\"1\" stroke=\"#fff\" stroke-width=\"2.2\" stroke-opacity=\".9\" style=\"animation-duration:8.6s,1s;animation-delay:1.2s,1.2s\"/><path class=\"pk\" d=\"M-128 1077 C 412 1037, 712 803, 992 723 S 1492 515, 2352 455\" pathLength=\"1\" stroke=\"#fff\" stroke-width=\"2.2\" stroke-opacity=\".9\" style=\"animation-duration:9.4s,1s;animation-delay:1.7999999999999998s,1.7999999999999998s\"/><path class=\"pk\" d=\"M-128 1121 C 412 1081, 712 829, 992 749 S 1492 545, 2352 485\" pathLength=\"1\" stroke=\"#fff\" stroke-width=\"2.2\" stroke-opacity=\".9\" style=\"animation-duration:10.2s,1s;animation-delay:2.4s,2.4s\"/><path class=\"run\" d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"#F3C9DA\" stroke-width=\"14\" style=\"--o:.45\"/><path class=\"run w\" d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" pathLength=\"1\" stroke=\"#fff\" stroke-width=\"5\"/><g ><g transform=\"translate(942 855) scale(0.26) translate(-1412 -425)\"><path d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" fill=\"url(#glass)\" stroke=\"#F3C9DA\" stroke-width=\"5\" stroke-opacity=\".8\"/><path d=\"M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z\" stroke=\"#fff\" stroke-width=\"2.5\" stroke-opacity=\".5\" transform=\"translate(-16 -16)\"/></g></g></g></svg>"];
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
    if (!$ || !document.querySelector('.nc-theme-navitem')) return false;
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
