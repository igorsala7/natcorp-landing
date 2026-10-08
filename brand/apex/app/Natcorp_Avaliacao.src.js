/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · AVALIAÇÃO DE DESEMPENHO  —  o "arrumador" das telas (JavaScript)               ║
   ║  App 9118 · Página 140 (a avaliação) e Página 144 (a janela de uma pergunta)             ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quem responde é, na maior parte, o COLABORADOR, pelo celular (9 em 10 acessos) — e também
   o gestor, o par, o comitê. O arquivo reorganiza a leitura e põe rótulos onde havia só ícone.

   Página 140 — a JORNADA da avaliação:
     • o alto diz o que falta ("Faltam 5 de 23 perguntas"), com a trilha (um traço por
       pergunta, agrupado por competência), o botão que continua de onde parou e as etapas
       (Perguntas, Plano de desenvolvimento, Feedback, Comentário, Conclusão) — só as que o
       APEX mostra, com o andamento de cada uma;
     • os dados da avaliação (tipo, ciclo, data, avaliador), que chegam travados, viram
       "fatos" no alto; os botões de impressão (Ficha de Registro, Comitê de Carreira,
       Avaliação) também vão para o alto;
     • as perguntas em cartões por competência, com a resposta à vista (no celular a tabela
       de 9 colunas escondia a pergunta e a resposta); tocar no cartão abre a pergunta (o link
       "Editar" do relatório). Para quem valida, um RESUMO: média por competência e como as
       respostas se distribuem;
     • o avaliado como um perfil (foto, função, tempo de casa, faltas, formação);
     • o plano de desenvolvimento como um PDI, o comentário como uma conversa;
     • "Salvar" numa barra fixa que avisa quando há texto ainda não salvo (as respostas das
       perguntas gravam na hora; os textos da página só com Salvar); "Deletar" vai para o fim
       da página como "Excluir esta avaliação";
     • numa avaliação NOVA (sem avaliado ainda), o alto vira "Nova avaliação" em 3 passos.
   Página 144 — UMA pergunta por vez:
     • barra de progresso, a competência, a pergunta em letra grande e a descrição;
     • as respostas em cartões de toque (no celular a faixa cortava "Insatisfatório" e
       "Fraco"), com a escala em pontos;
     • resposta escrita com "Salvando…" / "Resposta salva"; "Anterior" / "Próxima" com rótulo;
     • quando a resposta pede um plano de ação, um aviso diz o que fazer antes de seguir.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: itens, relatórios, botões e ações
       dinâmicas continuam os do APEX. Quem grava a resposta é a própria página 144.
     • Os cartões e botões novos só CLICAM nos originais do APEX (ex.: o cartão da pergunta
       clica no link "Editar" do relatório).
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Páginas 140 e 144 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Avaliacao.js
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Avaliacao.css
     (as mesmas duas páginas › CSS › File URLs).

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Classes postas nas regiões (Page Designer › clique na região › Appearance › CSS Classes;
   aplicadas pelo aplicar-avaliacao.py):
     Página 140
       nc-av-acoes        região "Botões"                  → Salvar vai para a barra fixa
       nc-av-dados        região "Avaliação"               → vira os fatos do alto
       nc-av-relatorios   região "Relatórios"              → os botões de imprimir vão para o alto
       nc-av-resultado    região "Resultado"               → os três números lado a lado
       nc-av-questoes     região "Questões"                → vira os cartões das perguntas
       nc-av-plano        região "Plano de Desenvolvimento" → vira o PDI
       nc-av-feedback     região "Feedback"                → vira uma etapa do alto
       nc-av-comentario   região "Comentário"              → vira a conversa
       nc-av-conclusao    região "Conclusão"               → vira uma etapa do alto
     Página 144
       nc-av-pergunta     região "&P144_TITULO."            → a pergunta
       nc-av-respostas    região "Respostas"               → as opções em cartões
   Esta página usa os nomes COMPLETOS dos itens (P140_…, P144_…): se a página for copiada com
   outro número, os nomes precisam ser trocados no arquivo todo.
   Itens e botões que o arquivo procura pelo nome: P140_COD_AVALIACAO e P144_ORDEM_COUNT (para
   saber qual página é), a região de id COLABORADOR (o avaliado), e na 144 os botões
   BTN_PREV_RECORD, BTN_NEXT_RECORD, BTN_PREV_ALERTA, BTN_NEXT_ALERTA e P144_ACAO.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Qual página é ...................... 140 ou 144, pelos itens             CUIDADO
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
   PÁGINA 140
     [J3]  Tipos de avaliação e a montagem ..... a ordem em que tudo é montado      PODE MEXER
     [J4]  O alto .............................. fatos, impressão, ir até uma parte
     [J5]  As perguntas em cartões ............. cartões, resumo, "Ver como tabela" PODE MEXER
     [J6]  O avaliado .......................... o perfil de quem é avaliado        PODE MEXER
     [J7]  O resultado ......................... o número principal e o recurso
     [J8]  O plano de desenvolvimento (PDI) .... grupos e dicas dos campos          PODE MEXER
     [J9]  O comentário como conversa .......... avaliador, avaliado, examinador    PODE MEXER
     [J10] O texto do alto e a criação ......... "Faltam 5 de 23", "Nova avaliação"  PODE MEXER
     [J11] As etapas ........................... Perguntas, Plano, Feedback…        PODE MEXER
     [J12] Os textos crescem ................... caixas de texto que acompanham o texto
     [J13] A barra de Salvar e o Excluir ....... "Há texto ainda não salvo"         PODE MEXER
   PÁGINA 144
     [J14] A pergunta .......................... progresso, opções, resposta escrita PODE MEXER
     [J15] Os botões da janela ................. Anterior, Próxima, Voltar, Indicar ação

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Vamos começar: '  →  'Bora começar: '
     Quero mudar as dicas que aparecem dentro das caixas de texto do plano/comentário
                                                                   → [J8], lista DICAS
     Quero mudar o nome de um grupo do PDI ou que campos ficam nele → [J8], lista PDI
     Apareceu um tipo de avaliação novo e o nome está estranho     → [J3], lista TIPOS
     Um campo novo de texto no Plano não aparece num grupo do PDI
       → ele continua na região, depois dos grupos. Para pô-lo num grupo, acrescente o nome
         completo do item (ex.: 'P140_NOVO_ITEM') na lista "itens" do grupo, em [J8].
     A tela ficou "crua" (sem o desenho)
       → confira se P140_COD_AVALIACAO (ou P144_ORDEM_COUNT) existe e se as classes do
         "combinado" estão nas regiões. Depois abra o Console (F12 › Console). Manual, parte 5.

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
     'P140_FUNCAO'          o nome de um item do APEX, entre aspas.
     valorItem(…)           lê o que a pessoa vê num item do APEX (veja [J2]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* ═══ [J1] QUAL PÁGINA É: 140 OU 144 ═══════════════════════════════════════════════════════
     O QUE FAZ  O mesmo arquivo serve às duas páginas. Ele descobre qual é pelos itens:
                P140_COD_AVALIACAO só existe na 140; P144_ORDEM_COUNT só existe na 144. Se não
                achar nenhum dos dois, para aqui e a página fica como o APEX desenhou.
                A primeira linha impede que o arquivo rode duas vezes e que rode fora do APEX.
     CUIDADO    Se um desses dois itens for renomeado no APEX, o desenho daquela página some.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncAvaliacao || !window.apex || !window.apex.jQuery) return;
  /* o mesmo arquivo serve às duas páginas: qual é qual, pelos itens de cada uma */
  var P140 = !!document.getElementById('P140_COD_AVALIACAO');
  var P144 = !!document.getElementById('P144_ORDEM_COUNT');
  if (!P140 && !P144) return;
  window.__ncAvaliacao = true;

  var $ = apex.jQuery;

  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    seta: '<path d="M9 6l6 6-6 6"/>',
    voltar: '<path d="M15 6l-6 6 6 6"/>',
    lapis: '<path d="M4 20h4L19 9a2.8 2.8 0 0 0-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    olho: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="3"/>',
    calendario: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/>',
    ciclo: '<path d="M20 12a8 8 0 0 1-14.3 4.9M4 12a8 8 0 0 1 14.3-4.9"/><path d="M18.5 3v4.2h-4.2M5.5 21v-4.2h4.2"/>',
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    pessoas: '<circle cx="9" cy="8" r="3.2"/><circle cx="16.5" cy="9.5" r="2.6"/><path d="M3 19.5a6 6 0 0 1 12 0M14.5 19.5a4.5 4.5 0 0 1 7-3.8"/>',
    impressora: '<path d="M7 9V4h10v5"/><rect x="3.5" y="9" width="17" height="8" rx="2"/><path d="M7 14h10v6H7z"/>',
    tabela: '<rect x="3.5" y="4.5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M3.5 14.5h17M9.5 9.5v10"/>',
    cadeado: '<rect x="5" y="10.5" width="14" height="10" rx="2"/><path d="M8 10.5V8a4 4 0 0 1 8 0v2.5"/>',
    alerta: '<path d="M12 3.5l9 16H3z"/><path d="M12 10v4M12 17v.01"/>',
    lixeira: '<path d="M4.5 7h15M9.5 7V4.5h5V7M6.5 7l1 13h9l1-13"/>',
    salvar: '<path d="M5 4h11l3 3v13H5z"/><path d="M8 4v5h7V4M8 20v-6h8v6"/>',
    lista: '<path d="M9 6.5h11M9 12h11M9 17.5h11"/><circle cx="4.5" cy="6.5" r="1"/><circle cx="4.5" cy="12" r="1"/><circle cx="4.5" cy="17.5" r="1"/>',
    alvo: '<circle cx="12" cy="12" r="8.5"/><circle cx="12" cy="12" r="4"/><circle cx="12" cy="12" r=".6"/>',
    balao: '<path d="M4 5.5h16v10.5H9.5L5 20v-4H4z"/>',
    selo: '<circle cx="12" cy="9.5" r="5.5"/><path d="M9 14l-1.5 6.5L12 18l4.5 2.5L15 14"/>',
    perguntas: '<circle cx="12" cy="12" r="8.5"/><path d="M9.6 9.4a2.5 2.5 0 1 1 3.4 2.3c-.6.3-1 .8-1 1.5v.6M12 16.8v.01"/>'
  };

  /* ═══ [J2] FERRAMENTAS ═════════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
       valorItem('P140_X')  o que a PESSOA VÊ no item (o texto da opção, o texto exibido)
       valorApex('P140_X')  o que o APEX GUARDA no item (o código) — fica em [J10]
       reg('nc-av-plano')   a região que tem essa classe no APEX
       visivel(e)           o pedaço está à mostra na tela?
       plural(3, 'falta', 'faltas')  → "3 faltas"
       guardar(…)           lembra uma coisa entre um recarregar e outro da página (usado
                            para mostrar "Resposta salva" na 144). Só nesta aba do navegador.
     QUANDO RODA  As duas linhas logo depois das ferramentas mandam montar a página certa:
                montar140() [J3] ou montar144() [J14], um instante depois de a página abrir.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-av-svg') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function vazio(t) { return !t || /^\s*(-\s*selecione\s*-|-|—|null)\s*$/i.test(t); }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim(); }
  function limpo(t) { return String(t || '').replace(/ /g, ' ').replace(/\s+/g, ' ').trim(); }
  function plural(n, um, varios) { return n + ' ' + (n === 1 ? um : varios); }
  function reg(cls) { return document.querySelector('.t-Region.' + cls); }
  function visivel(e) { return !!(e && e.offsetParent); }
  function valorItem(nome) {
    var e = document.getElementById(nome);
    if (!e) return '';
    if (e.tagName === 'SELECT') { var o = e.options[e.selectedIndex]; return o && o.value ? limpo(o.text) : ''; }
    var d = document.getElementById(nome + '_DISPLAY');
    return limpo(d ? d.textContent : e.value);
  }
  function guardar(k, v) { try { if (v === undefined) return sessionStorage.getItem(k); if (v === null) sessionStorage.removeItem(k); else sessionStorage.setItem(k, v); } catch (x) { /* ok */ } return null; }

  if (P140) $(function () { setTimeout(montar140, 60); });
  if (P144) $(function () { setTimeout(montar144, 30); });

  /* ██████████████████████████████████████████████████████████████████████████████████████
     PÁGINA 140 — a avaliação                                             partes [J3] a [J13]
     ██████████████████████████████████████████████████████████████████████████████████████ */
  var AV = null;

  /* ═══ [J3] TIPOS DE AVALIAÇÃO E A MONTAGEM DA 140 ══════════════════════════════════════════
     TIPOS      Como o tipo da avaliação (item P140_TIPO_AVALIACAO) aparece escrito no alto.
                À esquerda, o nome como vem do APEX, SEM acento e em minúsculas; à direita, o
                texto que aparece. Tipo que não estiver na lista aparece como vem do APEX.
     montar140  Roda uma vez: põe a marca nc-av na página (é ela que liga o visual do CSS) e
                monta cada parte, nesta ordem. Depois, sempre que as ações dinâmicas mostram ou
                escondem regiões (conforme o tipo da avaliação), as etapas do alto se refazem.
     PODE MEXER os textos da direita em TIPOS, e acrescentar tipos no mesmo formato:
                'nome-sem-acento': 'Como aparece',
     CUIDADO    Não mude a ordem das chamadas em montar140().
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: os nomes dos tipos de avaliação (veja acima) */
  var TIPOS = { 'auto-avaliacao': 'Autoavaliação', 'autoavaliacao': 'Autoavaliação', 'gestor': 'Avaliação do gestor', 'pares': 'Avaliação de pares',
    'consenso': 'Consenso', 'fornecedor': 'Avaliação de fornecedor' };
  function tipoAvaliacao() {
    var t = valorItem('P140_TIPO_AVALIACAO');
    var k = t.normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase().trim();
    return TIPOS[k] || t;
  }

  function montar140() {
    document.body.classList.add('nc-av');
    var questoes = reg('nc-av-questoes');
    AV = { questoes: questoes, sujo: false };

    montarHero();
    montarAvaliado();
    montarResultado();
    montarQuestoes();
    dicas();
    montarPlano();
    montarComentario();
    montarTextos();
    montarBarra();

    /* as ações dinâmicas mostram e escondem regiões conforme o tipo da avaliação: as etapas
       acompanham o que o APEX mostra */
    var t = 0;
    new MutationObserver(function () { clearTimeout(t); t = setTimeout(atualizarEtapas, 120); })
      .observe(document.querySelector('.t-Body-content') || document.body, { attributes: true, attributeFilter: ['style', 'class'], subtree: true });
    atualizarEtapas();
  }

  /* ═══ [J4] O ALTO DA 140: O QUADRO DO ANDAMENTO, OS FATOS E A IMPRESSÃO ════════════════════
     O QUE FAZ  montarHero() cria o quadro do alto (o texto e o botão são escritos em [J10],
                as etapas em [J11]) logo antes da região "Avaliação". Também:
                  • a região "Avaliação" (nc-av-dados) sai da vista SÓ se tudo nela vier
                    travado (é o normal: uma ação dinâmica trava ao abrir); se algum campo
                    vier editável, ela continua lá;
                  • os botões da região "Relatórios" vão para o alto, em "Imprimir", com o
                    mesmo clique; a região sai da vista.
                montarFatos() escreve os fatos: tipo, ciclo, data e "Avaliador: …" (com o botão
                do perfil dele). Avaliação anônima (o APEX esconde o avaliador): o fato some.
                Como o avaliador e o avaliado chegam DEPOIS, por ação dinâmica (PL/SQL), os
                fatos são refeitos quando essas chamadas terminam.
                irPara() rola a tela até uma parte, descontando a barra do alto que fica presa.
     LÊ DOS ITENS  P140_TIPO_AVALIACAO, P140_COD_CICLO, P140_DATA_AVALIACAO, P140_AVALIADOR,
                e o botão p140_btn_solicitante (o perfil do avaliador).
     PODE MEXER 'Imprimir', 'Ciclo ', 'Avaliador: '.
     VISUAL     Natcorp_Avaliacao.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarHero() {
    var dados = reg('nc-av-dados');
    var ancora = dados || reg('nc-av-acoes') || AV.questoes;
    if (!ancora) return;
    var hero = el('section', 'nc-av-hero');
    hero.setAttribute('aria-label', 'Andamento da avaliação');
    hero.innerHTML =
      '<div class="nc-av-hero-topo">' +
        '<div class="nc-av-hero-txt">' +
          '<h2 class="nc-av-hero-titulo" data-slot="titulo"></h2>' +
          '<p class="nc-av-hero-sub" data-slot="sub"></p>' +
        '</div>' +
        '<div class="nc-av-hero-cta" data-slot="cta"></div>' +
      '</div>' +
      '<div class="nc-av-trilha" data-slot="trilha" role="img"></div>' +
      '<ol class="nc-av-passos" data-slot="passos" hidden></ol>' +
      '<ul class="nc-av-fatos" data-slot="fatos"></ul>' +
      '<nav class="nc-av-etapas" aria-label="Etapas da avaliação"><ol data-slot="etapas"></ol></nav>' +
      '<div class="nc-av-docs" data-slot="docs" hidden><span>' + svg(IC.impressora) + 'Imprimir</span></div>';
    var alvo = ancora.closest('.row') || ancora;
    alvo.parentNode.insertBefore(hero, alvo);
    AV.hero = hero;

    montarFatos();
    /* o avaliador e o avaliado chegam depois, por ação dinâmica (PL/SQL): os fatos e o texto
       do alto são refeitos quando as chamadas terminam */
    var tf = 0;
    $(document).ajaxComplete(function () { clearTimeout(tf); tf = setTimeout(function () { montarFatos(); desenharAvaliado(); desenharHero(); }, 150); });

    /* o formulário "Avaliação" só sai da vista se tudo nele vier travado (é o normal: uma ação
       dinâmica trava ao abrir); se algo for editável, ele continua lá */
    if (dados) {
      var editavel = [].some.call(dados.querySelectorAll('input:not([type=hidden]), select, textarea'), function (i) { return !i.disabled && !i.readOnly && visivel(i); });
      if (!editavel) dados.classList.add('nc-av-fora');
    }
    /* impressões */
    var rel = reg('nc-av-relatorios');
    var docs = hero.querySelector('[data-slot="docs"]');
    if (rel) {
      var bts = [].slice.call(rel.querySelectorAll('.t-Button')).filter(function (b) { return b.style.display !== 'none'; });
      bts.forEach(function (b) { b.classList.add('nc-av-doc-bt'); docs.appendChild(b); });
      if (bts.length) { docs.hidden = false; rel.classList.add('nc-av-fora'); }
    }
    hero.addEventListener('click', function (e) {
      if (e.target.closest('[data-escolher]')) {
        irPara('COLABORADOR');
        setTimeout(function () { var i = document.getElementById(valorApex('P140_COD_EMP_AVALIADO') ? 'P140_COD_MAT_AVALIADO' : 'P140_COD_EMP_AVALIADO'); if (i) i.focus(); }, 450);
        return;
      }
      var a = e.target.closest('[data-ir]');
      if (a) { e.preventDefault(); irPara(a.getAttribute('data-ir')); return; }
      var q = e.target.closest('[data-abrir]');
      if (q) { abrirPergunta(+q.getAttribute('data-abrir')); }
    });
  }

  /* os fatos: o que o formulário "Avaliação" traz travado */
  function montarFatos() {
    var hero = AV.hero; if (!hero) return;
    var fatos = [];
    var tipo = tipoAvaliacao();
    if (tipo) fatos.push([IC.selo, tipo]);
    var ciclo = valorItem('P140_COD_CICLO');
    if (ciclo) fatos.push([IC.ciclo, 'Ciclo ' + semCodigo(ciclo)]);
    var dataAv = valorItem('P140_DATA_AVALIACAO');
    if (dataAv) fatos.push([IC.calendario, dataAv]);
    var cAval = document.getElementById('P140_AVALIADOR_CONTAINER');
    var iAval = document.getElementById('P140_AVALIADOR');
    var avaliador = valorItem('P140_AVALIADOR');
    if (avaliador && cAval && cAval.style.display !== 'none' && (!iAval || iAval.style.display !== 'none')) {
      var nomeAval = avaliador.split(/\s+-\s+/).pop();
      fatos.push([IC.pessoa, 'Avaliador: ' + nomeAval, 'avaliador']);
    }
    hero.querySelector('[data-slot="fatos"]').innerHTML = fatos.map(function (f) {
      return '<li' + (f[2] ? ' data-fato="' + f[2] + '"' : '') + '>' + svg(f[0]) + '<span>' + esc(f[1]) + '</span></li>';
    }).join('');
    /* o botão do perfil do avaliador vai junto do nome dele */
    var perfil = document.getElementById('p140_btn_solicitante');
    var li = hero.querySelector('[data-fato="avaliador"]');
    if (perfil && li && perfil.style.display !== 'none') { perfil.classList.add('nc-av-perfil'); perfil.setAttribute('title', 'Ver o perfil do avaliador'); li.appendChild(perfil); }
    else if (perfil && perfil.classList.contains('nc-av-perfil') && !li) {
      /* o APEX escondeu o avaliador (avaliação anônima): o botão volta para o lugar dele, fora da vista */
      var cAv = document.getElementById('P140_AVALIADOR_CONTAINER'); if (cAv) cAv.appendChild(perfil);
    }
  }

  /* o título da página fica preso no alto ao rolar: a rolagem desconta a altura dele */
  function topoFixo() {
    var b = 0;
    [document.querySelector('.t-Body-title'), document.querySelector('.t-Header')].forEach(function (x) {
      if (!x) return; var ps = getComputedStyle(x).position;
      if (ps === 'fixed' || ps === 'sticky') b = Math.max(b, x.getBoundingClientRect().bottom);
    });
    return Math.max(0, Math.round(b));
  }
  function irPara(id) {
    var r = document.getElementById(id); if (!r) return;
    var y = r.getBoundingClientRect().top + window.pageYOffset - topoFixo() - 12;
    window.scrollTo({ top: y, behavior: 'smooth' });
    var h = r.querySelector('.t-Region-title, h2, h3'); if (h) { h.setAttribute('tabindex', '-1'); setTimeout(function () { h.focus({ preventScroll: true }); }, 400); }
  }

  /* ═══ [J5] AS PERGUNTAS EM CARTÕES (140) ═══════════════════════════════════════════════════
     O QUE FAZ  Lê o relatório "Questões" linha a linha, pelas COLUNAS dele (ORDEM_ITEM,
                GRUPO_COMPETENCIA, COMPETENCIA, DESCRICAO, ESPECIFICACAO, OBSERVACAO, RESPOSTA,
                NOTA) e desenha:
                  • um RESUMO (só com alguma pergunta respondida): a média de cada competência
                    numa barra e a distribuição das respostas, com a média geral;
                  • os CARTÕES, agrupados por competência: número, pergunta, resposta, pontos
                    da escala e nota. Tocar no cartão clica no link "Editar" da linha (abre a
                    janela 144). A próxima sem resposta fica em destaque.
                "Ver como tabela" volta ao relatório original. Se o relatório vier paginado,
                o arquivo pede todas as linhas de uma vez. Quando a janela da pergunta fecha, o
                APEX recarrega o relatório e os cartões são refeitos.
     ESCALA     A maior nota que aparece, e no mínimo 5 (o questionário padrão vai de 1 a 5).
     CUIDADO    Se uma coluna do relatório "Questões" for renomeada no APEX, o cartão perde
                aquela informação. Renomeie também aqui (procure  headers=  e a função
                linhasQuestoes). P140_DESABILITA_QUESTOES_AUX = 'S' deixa tudo só para consulta.
     PODE MEXER os textos 'Ver como tabela', 'Ver em cartões', 'Sem resposta', 'Responder',
                'média', 'Média por competência', 'Respostas', 'média geral'.
                TONS são as 5 cores da barra de distribuição (da maior nota para a menor).
     VISUAL     Natcorp_Avaliacao.css › [C4] (cartões) e [C5] (resumo)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function linhasQuestoes() {
    if (!AV.questoes) return [];
    return [].slice.call(AV.questoes.querySelectorAll('table.t-Report-report tbody tr')).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; }
      var link = tr.querySelector('td a[href]');
      if (!link && !c('ORDEM_ITEM')) return null;
      return {
        ordem: c('ORDEM_ITEM'), grupo: c('GRUPO_COMPETENCIA'), comp: c('COMPETENCIA'),
        pergunta: c('DESCRICAO'), sobre: c('ESPECIFICACAO'), obs: c('OBSERVACAO'),
        resposta: c('RESPOSTA'), nota: c('NOTA'), link: link
      };
    }).filter(Boolean);
  }
  function respondida(q) { return !vazio(q.resposta); }

  function montarQuestoes() {
    var r = AV.questoes;
    if (!r) return;
    var corpo = r.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || r;
    var caixa = el('div', 'nc-av-qs'); caixa.setAttribute('aria-live', 'polite');
    corpo.insertBefore(caixa, corpo.firstChild);
    var bt = el('button', 'nc-av-link nc-av-tabela-bt'); bt.type = 'button';
    bt.innerHTML = svg(IC.tabela) + '<span>Ver como tabela</span>';
    corpo.appendChild(bt);
    r.classList.add('nc-av-em-cartoes');
    bt.addEventListener('click', function () {
      var tabela = r.classList.toggle('nc-av-em-cartoes') === false;
      bt.querySelector('span').textContent = tabela ? 'Ver em cartões' : 'Ver como tabela';
    });
    caixa.addEventListener('click', function (e) {
      var g = e.target.closest('[data-grupo]');
      if (g) { irPara('nc-av-g' + g.getAttribute('data-grupo')); return; }
      var c = e.target.closest('[data-abrir]');
      if (c) abrirPergunta(+c.getAttribute('data-abrir'));
    });
    AV.caixa = caixa;
    /* a janela da pergunta fechou → o APEX recarrega o relatório (ação dinâmica): os cartões
       e o alto são refeitos */
    $(r).on('apexafterrefresh', function () { setTimeout(function () { desenharQuestoes(); carregarTodas(); }, 30); });
    desenharQuestoes();
    carregarTodas();
  }

  /* o relatório pode vir paginado: pede todas as linhas de uma vez */
  var TODAS = false;
  function carregarTodas() {
    if (TODAS || !AV.questoes) return;
    var a = AV.questoes.querySelector('.t-Report-pagination a[href*="paginate"], .t-Report-pagination [onclick*="paginate"], select[onchange*="paginate"]');
    if (!a) return;
    var js = a.getAttribute('href') || a.getAttribute('onclick') || a.getAttribute('onchange') || '';
    var m = js.match(/paginate\('([^']+)',\s*'([^']+)'/);
    if (!m || !apex.widget || !apex.widget.report || !apex.widget.report.paginate) return;
    TODAS = true;
    apex.widget.report.paginate(m[1], m[2], { min: 1, max: 1000, fetched: 1000 });
  }

  function abrirPergunta(i) {
    var q = AV.lista && AV.lista[i];
    if (q && q.link) q.link.click();
  }

  function somenteLeitura() {
    var d = document.getElementById('P140_DESABILITA_QUESTOES_AUX');
    return !!(d && d.value === 'S');
  }

  /* números no jeito do Brasil: 4,3 */
  function num(v, casas) { return isFinite(v) ? v.toFixed(casas === undefined ? 1 : casas).replace('.', ',') : ''; }
  function nota(q) { var n = parseFloat(String(q.nota || '').replace(',', '.')); return isFinite(n) ? n : NaN; }

  function desenharQuestoes() {
    var lista = AV.lista = linhasQuestoes();
    var feitas = lista.filter(respondida).length, total = lista.length;
    var prox = -1;
    lista.some(function (q, i) { if (!respondida(q)) { prox = i; return true; } return false; });
    AV.feitas = feitas; AV.total = total; AV.prox = prox;
    /* a escala das notas: a maior nota que aparece, e no mínimo 5 (o questionário padrão vai de 1 a 5) */
    var notas = lista.map(nota).filter(isFinite);
    AV.escala = Math.max(5, notas.length ? Math.max.apply(null, notas) : 0);

    /* grupos de competência, na ordem em que aparecem */
    var grupos = [], g = null;
    lista.forEach(function (q, i) {
      var nome = q.comp || q.grupo || 'Perguntas';
      if (!g || g.nome !== nome) { g = { nome: nome, sobre: q.sobre, itens: [] }; grupos.push(g); }
      g.itens.push(i);
    });
    grupos.forEach(function (gr) {
      var ns = gr.itens.map(function (i) { return nota(lista[i]); }).filter(isFinite);
      gr.media = ns.length ? ns.reduce(function (a, b) { return a + b; }, 0) / ns.length : NaN;
      gr.ok = gr.itens.filter(function (i) { return respondida(lista[i]); }).length;
    });
    AV.grupos = grupos;

    if (AV.caixa) {
      AV.caixa.innerHTML = !total ? '<p class="nc-av-vazio">Nenhuma pergunta nesta avaliação.</p>' :
        resumoQuestoes(lista, grupos) +
        grupos.map(function (gr, gi) {
          return '<section class="nc-av-grupo' + (gr.ok === gr.itens.length ? ' is-completo' : '') + '" id="nc-av-g' + gi + '">' +
            '<header class="nc-av-grupo-cab"><h3>' + esc(gr.nome) + '</h3>' +
              '<span class="nc-av-grupo-info">' +
                (isFinite(gr.media) ? '<span class="nc-av-grupo-media" title="Média das notas desta competência">média <b>' + num(gr.media) + '</b></span>' : '') +
                '<span class="nc-av-grupo-conta">' + (gr.ok === gr.itens.length ? svg(IC.ok) : '') + gr.ok + ' de ' + gr.itens.length + '</span>' +
              '</span></header>' +
            (gr.sobre ? '<p class="nc-av-grupo-sobre">' + esc(gr.sobre) + '</p>' : '') +
            '<ol class="nc-av-q-lista">' + gr.itens.map(function (i) { return cartao(lista[i], i, i === prox); }).join('') + '</ol>' +
          '</section>';
        }).join('');
    }
    desenharHero();
  }

  /* o RESUMO que o avaliador lê primeiro: a média de cada competência e como as respostas se
     distribuem. Só aparece com alguma pergunta respondida. */
  /* PODE MEXER (com cuidado): as cores da barra de distribuição, em código de cor (#RRGGBB) */
  var TONS = ['#3B1257', '#6A2C8C', '#9A6BBF', '#C3A6DC', '#E3D5EF'];
  function resumoQuestoes(lista, grupos) {
    var feitas = lista.filter(respondida);
    if (!feitas.length) return '';
    var esc_ = AV.escala;
    var comp = grupos.map(function (gr, gi) {
      var pct = isFinite(gr.media) ? Math.max(4, Math.round(gr.media / esc_ * 100)) : 0;
      return '<li><button type="button" class="nc-av-rc" data-grupo="' + gi + '">' +
        '<span class="nc-av-rc-nome">' + esc(gr.nome) + '</span>' +
        '<span class="nc-av-rc-barra" aria-hidden="true"><i style="width:' + pct + '%"></i></span>' +
        '<b class="nc-av-rc-media">' + (isFinite(gr.media) ? num(gr.media) : '—') + '</b>' +
        '<span class="nc-av-rc-conta">' + gr.ok + '/' + gr.itens.length + '</span>' +
      '</button></li>';
    }).join('');
    /* a distribuição: cada resposta, da maior nota para a menor */
    var mapa = {}, ordem = [];
    feitas.forEach(function (q) {
      var k = q.resposta;
      if (!mapa[k]) { mapa[k] = { nome: k, n: 0, soma: 0, cont: 0 }; ordem.push(k); }
      mapa[k].n++;
      var v = nota(q); if (isFinite(v)) { mapa[k].soma += v; mapa[k].cont++; }
    });
    var itens = ordem.map(function (k) { var x = mapa[k]; x.media = x.cont ? x.soma / x.cont : -1; return x; })
      .sort(function (a, b) { return b.media - a.media; });
    var todas = lista.map(nota).filter(isFinite);
    var geral = todas.length ? todas.reduce(function (a, b) { return a + b; }, 0) / todas.length : NaN;
    var dist = '<div class="nc-av-dist-barra" role="img" aria-label="' + esc(itens.map(function (x) { return x.nome + ': ' + x.n; }).join(', ')) + '">' +
      itens.map(function (x, i) { return '<i style="flex-grow:' + x.n + ';background:' + TONS[Math.min(i, TONS.length - 1)] + '" title="' + esc(x.nome) + ': ' + x.n + '"></i>'; }).join('') + '</div>' +
      '<ul class="nc-av-dist-leg">' + itens.map(function (x, i) {
        return '<li><i style="background:' + TONS[Math.min(i, TONS.length - 1)] + '"></i><span>' + esc(x.nome) + '</span><b>' + x.n + '</b></li>';
      }).join('') + '</ul>';
    return '<div class="nc-av-resumo">' +
      '<section class="nc-av-resumo-comp" aria-label="Média por competência">' +
        '<header><h3>Média por competência</h3><span>escala de 1 a ' + esc_ + '</span></header>' +
        '<ol>' + comp + '</ol></section>' +
      '<section class="nc-av-resumo-dist" aria-label="Distribuição das respostas">' +
        '<header><h3>Respostas</h3>' + (isFinite(geral) ? '<span>média geral <b>' + num(geral) + '</b></span>' : '') + '</header>' +
        dist + '</section>' +
    '</div>';
  }

  function pontos(v) {
    var e = AV.escala || 5; if (!isFinite(v) || e > 10) return '';
    var h = ''; for (var k = 1; k <= e; k++) h += '<i' + (k <= v ? ' class="is-on"' : '') + '></i>';
    return '<span class="nc-av-q-pontos" aria-hidden="true">' + h + '</span>';
  }

  function cartao(q, i, eProx) {
    var ok = respondida(q);
    var ro = somenteLeitura();
    var acao = ro ? 'Ver' : ok ? 'Alterar' : 'Responder';
    var v = nota(q);
    return '<li><button type="button" class="nc-av-q' + (ok ? ' is-ok' : '') + (eProx ? ' is-prox' : '') + '" data-abrir="' + i + '"' +
      ' aria-label="Pergunta ' + esc(q.ordem) + ': ' + esc(q.pergunta) + (ok ? '. Resposta: ' + esc(q.resposta) + (isFinite(v) ? ', nota ' + esc(q.nota) : '') : '. Sem resposta') + '. ' + acao + '">' +
      '<span class="nc-av-q-n" aria-hidden="true">' + (ok ? svg(IC.ok) : esc(q.ordem)) + '</span>' +
      '<span class="nc-av-q-txt">' +
        '<span class="nc-av-q-perg">' + esc(q.pergunta || q.obs || 'Pergunta ' + q.ordem) + '</span>' +
        (q.obs && q.pergunta ? '<span class="nc-av-q-obs">' + esc(q.obs) + '</span>' : '') +
      '</span>' +
      '<span class="nc-av-q-res">' + (ok
        ? '<b class="nc-av-q-resp">' + esc(q.resposta) + '</b>' + pontos(v) + (isFinite(v) ? '<em class="nc-av-q-nota">' + esc(q.nota) + '</em>' : '')
        : '<span class="nc-av-q-falta">Sem resposta</span>') + '</span>' +
      '<span class="nc-av-q-acao" aria-hidden="true">' + (ok || ro ? '' : '<b>Responder</b>') + svg(IC.seta) + '</span>' +
    '</button></li>';
  }

  /* ═══ [J6] O AVALIADO: O PERFIL DE QUEM ESTÁ SENDO AVALIADO (140) ══════════════════════════
     O QUE FAZ  Na região de id COLABORADOR, cria um cartão: foto (ou iniciais), nome,
                função, matrícula, situação ("Ativo · desde …") e, em "Ver dados": tempo de casa
                (da admissão), faltas no período ("Nenhuma falta" em verde), formação/instrução
                e empresa/filial. acertar() arruma textos sem acento ("Nao Possui Formacao" →
                "Não possui formação").
     CUIDADO    (já custou um bug, 29/09) Só o bloco das sub-regiões Colab Foto / Colab Info sai
                da vista. Empresa e Matrícula do avaliado continuam com o APEX: aparecem na
                criação e em "Alterar Colaborador", e as ações dinâmicas escondem depois.
                Esconder a região inteira impedia escolher o avaliado.
     LÊ DOS ITENS  P140_MATRICULA_DISPLAY, P140_COD_MAT_AVALIADO, P140_FUNCAO, P140_SITUACAO_COLAB,
                P140_DT_ADMISSAO, P140_FALTAS_PERIODO_COLAB, P140_FORMACAO, P140_INSTRUCAO,
                P140_COD_EMPRESA_DISPLAY, P140_FILIAL_DISPLAY, P140_FOTO_COLAB.
     PODE MEXER os rótulos 'Tempo de casa', 'Faltas no período', 'Formação', 'Empresa',
                'Ver dados', 'Esconder dados' e a dica de escolha do avaliado.
     VISUAL     Natcorp_Avaliacao.css › [C10]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* "Nao Possui Formacao" → "Não possui formação"; "Ensino Médio Completo." → "Ensino médio completo" */
  function acertar(t) {
    t = String(t || '').trim().replace(/\.\s*$/, '')
      .replace(/\bnao\b/gi, 'não').replace(/\bformacao\b/gi, 'formação').replace(/\bgraduacao\b/gi, 'graduação').replace(/\bmedio\b/gi, 'médio');
    if (!t) return '';
    t = t.toLowerCase().replace(/\b(mba|ti|rh)\b/g, function (m) { return m.toUpperCase(); });
    return t.charAt(0).toUpperCase() + t.slice(1);
  }
  function montarAvaliado() {
    var r = document.getElementById('COLABORADOR');
    if (!r) return;
    var corpo = r.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    if (!corpo) return;
    r.classList.add('nc-av-avaliado');
    var card = el('div', 'nc-av-pessoa');
    corpo.insertBefore(card, corpo.firstChild);
    /* sai da vista só o bloco das sub-regiões Colab Foto / Colab Info (o cartão as substitui);
       Empresa e Matrícula do avaliado continuam com o APEX: aparecem na criação e em "Alterar
       Colaborador", e as ações dinâmicas escondem depois de escolher */
    [].forEach.call(corpo.children, function (c) { if (c !== card && c.querySelector('.t-Region')) c.classList.add('nc-av-fora'); });
    var dica = el('p', 'nc-av-escolha-dica', svg(IC.pessoa) + '<span>Escolha a <b>empresa</b> e a <b>matrícula</b> de quem será avaliado. Os dados da pessoa aparecem aqui e as perguntas se abrem.</span>');
    var campos = document.getElementById('P140_COD_EMP_AVALIADO_CONTAINER');
    var blocoCampos = campos && campos.closest('.container');
    if (blocoCampos) blocoCampos.parentNode.insertBefore(dica, blocoCampos);
    AV.dica = dica;
    /* a escolha do avaliado muda o alto e a dica */
    ['P140_COD_EMP_AVALIADO', 'P140_COD_MAT_AVALIADO', 'P140_COD_AVALIACAO', 'P140_DATA_AVALIACAO'].forEach(function (id) {
      $('#' + id).on('change', function () { setTimeout(function () { desenharAvaliado(); desenharHero(); }, 60); });
    });
    card.addEventListener('click', function (e) {
      var b = e.target.closest('[data-mais]');
      if (!b) return;
      var aberto = card.classList.toggle('is-aberto');
      b.setAttribute('aria-expanded', String(aberto));
      b.querySelector('span').textContent = aberto ? 'Esconder dados' : 'Ver dados';
    });
    AV.pessoa = card;
    desenharAvaliado();
  }
  function desenharAvaliado() {
    var card = AV.pessoa; if (!card) return;
    var cheio = valorItem('P140_MATRICULA_DISPLAY');
    var nome = semCodigo(cheio), mat = (cheio.match(/^\s*(\d+)\s+-/) || [])[1];
    var escolhido = !!valorApex('P140_COD_MAT_AVALIADO');
    var campos = document.getElementById('P140_COD_MAT_AVALIADO_CONTAINER');
    if (AV.dica) AV.dica.hidden = !(campos && campos.style.display !== 'none' && visivel(campos));
    if (!nome) {
      card.hidden = !escolhido;
      card.innerHTML = escolhido ? '<p class="nc-av-pessoa-carregando">Carregando os dados…</p>' : '';
      return;
    }
    card.hidden = false;
    var funcao = semCodigo(valorItem('P140_FUNCAO'));
    var sit = valorItem('P140_SITUACAO_COLAB');
    var sitData = (sit.match(/(\d{2}\/\d{2}\/\d{4})\s*$/) || [])[1] || '';
    var sitNome = semCodigo(sit).replace(/\s*-\s*\d{2}\/\d{2}\/\d{4}\s*$/, '');
    var ativo = /ativ/i.test(sitNome) && !/inativ/i.test(sitNome);
    var adm = valorItem('P140_DT_ADMISSAO');
    var faltas = valorItem('P140_FALTAS_PERIODO_COLAB');
    var nF = parseInt(faltas, 10), perF = (faltas.match(/\((\d{2}\/\d{2}\/\d{4}[^)]*)\)/) || [])[1] || '';
    var formacao = acertar(valorItem('P140_FORMACAO')), instrucao = acertar(valorItem('P140_INSTRUCAO'));
    var empresa = semCodigo(valorItem('P140_COD_EMPRESA_DISPLAY')), filial = semCodigo(valorItem('P140_FILIAL_DISPLAY'));
    var img = document.querySelector('#P140_FOTO_COLAB_CONTAINER img');
    var foto = img && img.getAttribute('src') ? '<img alt="" src="' + esc(img.getAttribute('src')) + '">' : '<span>' + esc(nome.split(/\s+/).filter(function (w) { return w.length > 2; }).map(function (w) { return w.charAt(0); }).slice(0, 2).join('')) + '</span>';
    var casa = '';
    var d = (adm.match(/(\d{2})\/(\d{2})\/(\d{4})/));
    if (d) {
      var ini = new Date(+d[3], +d[2] - 1, +d[1]), hoje = new Date();
      var meses = (hoje.getFullYear() - ini.getFullYear()) * 12 + hoje.getMonth() - ini.getMonth() - (hoje.getDate() < ini.getDate() ? 1 : 0);
      casa = meses >= 12 ? plural(Math.floor(meses / 12), 'ano', 'anos') : meses > 0 ? plural(meses, 'mês', 'meses') : 'menos de 1 mês';
    }
    function fato(rot, val, sub, cls) {
      if (vazio(val)) return '';
      return '<div class="nc-av-pf' + (cls ? ' ' + cls : '') + '"><dt>' + esc(rot) + '</dt><dd>' + esc(val) + (sub ? '<small>' + esc(sub) + '</small>' : '') + '</dd></div>';
    }
    var fatos =
      fato('Tempo de casa', casa, adm ? 'admissão em ' + adm : '') +
      (faltas ? fato('Faltas no período', isFinite(nF) ? (nF === 0 ? 'Nenhuma falta' : plural(nF, 'falta', 'faltas')) : faltas, perF ? perF.replace(/\s+-\s+/, ' a ') : '', isFinite(nF) ? (nF === 0 ? 'is-bom' : 'is-atencao') : '') : '') +
      fato('Formação', formacao || instrucao, formacao && instrucao ? instrucao : '') +
      fato('Empresa', empresa, filial ? 'Filial ' + filial : '');
    var aberto = card.classList.contains('is-aberto');
    card.innerHTML =
      '<div class="nc-av-pessoa-topo">' +
        '<span class="nc-av-pessoa-foto" aria-hidden="true">' + foto + '</span>' +
        '<div class="nc-av-pessoa-id">' +
          '<h3>' + esc(nome) + '</h3>' +
          '<p>' + esc([funcao, mat ? 'matrícula ' + mat : ''].filter(Boolean).join(' · ')) + '</p>' +
          (sitNome ? '<p class="nc-av-pessoa-sit' + (ativo ? ' is-ativo' : '') + '"><i aria-hidden="true"></i>' + esc(sitNome) + (sitData ? '<span> · desde ' + esc(sitData) + '</span>' : '') + '</p>' : '') +
        '</div>' +
        (fatos ? '<button type="button" class="nc-av-pessoa-mais" data-mais aria-expanded="' + aberto + '" aria-controls="nc-av-pessoa-fatos">' + svg(IC.seta) + '<span>' + (aberto ? 'Esconder dados' : 'Ver dados') + '</span></button>' : '') +
      '</div>' +
      (fatos ? '<dl class="nc-av-pessoa-fatos" id="nc-av-pessoa-fatos">' + fatos + '</dl>' : '');
  }

  /* ═══ [J7] O RESULTADO (140) ═══════════════════════════════════════════════════════════════
     O QUE FAZ  Marca o P140_RESULTADO_AVALIACAO como o número principal (em destaque) e os
                botões da região "Resultado" (o Pedido de Recurso) como ação secundária.
     VISUAL     Natcorp_Avaliacao.css › [C3] e [C11]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarResultado() {
    var c = document.getElementById('P140_RESULTADO_AVALIACAO_CONTAINER');
    if (c) c.classList.add('is-principal');
    var r = reg('nc-av-resultado');
    if (r) [].forEach.call(r.querySelectorAll('.t-Button'), function (b) { b.classList.add('nc-av-recurso'); });
  }

  /* ═══ [J8] O PLANO DE DESENVOLVIMENTO COMO UM PDI (140) ════════════════════════════════════
     O QUE FAZ  Agrupa os campos de texto da região "Plano de Desenvolvimento" em três blocos:
                  O que favoreceu (verde) · O que desenvolver (âmbar) · Próximos passos (roxo).
                Campo que não estiver em nenhum grupo continua na região, depois dos grupos.
                dicas() põe uma frase-guia dentro de cada caixa de texto EDITÁVEL vazia (some ao
                digitar). Vale também para os comentários e a conclusão.
     PODE MEXER PDI:   nome (título do bloco), dica (frase embaixo do título), itens (os campos do
                       bloco, pelo nome completo). tom e ic: veja o CUIDADO.
                DICAS: NOME_DO_ITEM: 'frase-guia',
     CUIDADO    tom só aceita 'verde', 'ambar' ou 'roxo' (as cores estão no CSS [C12]); ic é
                um nome da lista IC de [J2].
     VISUAL     Natcorp_Avaliacao.css › [C12]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: os três blocos do PDI */
  var PDI = [
    { nome: 'O que favoreceu', dica: 'Forças e o que ajudou no resultado do período', tom: 'verde', ic: 'selo',
      itens: ['P140_ASPECTOS_FACILITADORES', 'P140_PONTOS_FORTES'] },
    { nome: 'O que desenvolver', dica: 'Pontos de melhoria e o que atrapalhou', tom: 'ambar', ic: 'alvo',
      itens: ['P140_ASPECTOS_DIFICULTADORES', 'P140_PONTOS_FRACOS', 'P140_FATORES_EXTERNOS'] },
    { nome: 'Próximos passos', dica: 'O que foi combinado e para onde encaminhar', tom: 'roxo', ic: 'seta',
      itens: ['P140_PLANO_ACAO', 'P140_OBSERVACOES'] }
  ];
  /* PODE MEXER: as frases-guia das caixas de texto */
  var DICAS = {
    P140_ASPECTOS_FACILITADORES: 'O que ajudou a ter bons resultados',
    P140_PONTOS_FORTES: 'O que a pessoa faz muito bem',
    P140_ASPECTOS_DIFICULTADORES: 'O que atrapalhou no período',
    P140_PONTOS_FRACOS: 'O que precisa melhorar',
    P140_FATORES_EXTERNOS: 'Situações fora do controle da pessoa: equipe, ferramentas, ambiente',
    P140_PLANO_ACAO: 'O que vai ser feito, por quem e até quando',
    P140_OBSERVACOES: 'Para onde encaminhar: treinamento, RH, liderança…',
    P140_COMENTARIO_AVALIADOR: 'Comentário do avaliador sobre a avaliação',
    P140_COMENTARIO_AVALIADO: 'Escreva o que você pensa sobre esta avaliação',
    P140_COMENTARIO_EXAMINADOR: 'Comentário do examinador',
    P140_CONCLUSAO_FINAL: 'A conclusão final da avaliação'
  };
  function dicas() {
    Object.keys(DICAS).forEach(function (id) {
      var t = document.getElementById(id);
      if (t && t.tagName === 'TEXTAREA' && !t.disabled && !t.readOnly && !t.getAttribute('placeholder')) t.setAttribute('placeholder', DICAS[id]);
    });
  }
  function montarPlano() {
    var r = reg('nc-av-plano'); if (!r) return;
    var corpo = r.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body'); if (!corpo) return;
    var usados = 0;
    PDI.slice().reverse().forEach(function (g) {
      var cs = g.itens.map(function (id) { return document.getElementById(id + '_CONTAINER'); }).filter(Boolean);
      if (!cs.length) return;
      var sec = el('section', 'nc-av-pdi nc-av-pdi--' + g.tom);
      sec.innerHTML = '<header class="nc-av-pdi-cab"><span class="nc-av-pdi-ic" aria-hidden="true">' + svg(IC[g.ic]) + '</span>' +
        '<div><h3>' + esc(g.nome) + '</h3><p>' + esc(g.dica) + '</p></div></header><div class="nc-av-pdi-campos"></div>';
      var box = sec.querySelector('.nc-av-pdi-campos');
      cs.forEach(function (c) { box.appendChild(c); usados++; });
      corpo.insertBefore(sec, corpo.firstChild);
    });
    if (!usados) return;
    /* o que sobrou do grid do APEX, sem campo nenhum, sai da vista */
    [].forEach.call(corpo.children, function (c) { if (!c.classList.contains('nc-av-pdi') && !c.querySelector('.t-Form-fieldContainer')) c.classList.add('nc-av-fora'); });
  }

  /* ═══ [J9] O COMENTÁRIO COMO CONVERSA (140) ════════════════════════════════════════════════
     O QUE FAZ  Os três comentários (Avaliador, Avaliado, Examinador) ganham um ícone cada. Se
                só um deles for editável, ele ganha a etiqueta "seu comentário". Os travados e
                vazios dizem "Ainda sem comentário". A região "Conclusão" ganha a caixa de fecho.
     PODE MEXER na lista VOZES, só o 3º texto de cada linha (o nome que aparece); e os textos
                'seu comentário', 'Ainda sem comentário'.
     CUIDADO    Na lista VOZES, o 1º texto é o nome do item no APEX e o 2º é usado pelo CSS:
                não mude esses dois.
     VISUAL     Natcorp_Avaliacao.css › [C13]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var VOZES = [['P140_COMENTARIO_AVALIADOR', 'avaliador', 'Avaliador'], ['P140_COMENTARIO_AVALIADO', 'avaliado', 'Avaliado'], ['P140_COMENTARIO_EXAMINADOR', 'examinador', 'Examinador']];
  function montarComentario() {
    var r = reg('nc-av-comentario'); if (!r) return;
    var editaveis = VOZES.filter(function (v) { var t = document.getElementById(v[0]); return t && !t.disabled && !t.readOnly; });
    VOZES.forEach(function (v) {
      var c = document.getElementById(v[0] + '_CONTAINER'); if (!c) return;
      var t = document.getElementById(v[0]);
      c.classList.add('nc-av-voz', 'nc-av-voz--' + v[1]);
      var lc = c.querySelector('.t-Form-labelContainer');
      if (lc && !lc.querySelector('.nc-av-voz-ic')) {
        lc.insertAdjacentHTML('afterbegin', '<span class="nc-av-voz-ic" aria-hidden="true">' + svg(v[1] === 'avaliado' ? IC.pessoa : v[1] === 'avaliador' ? IC.pessoas : IC.selo) + '</span>');
        if (editaveis.length === 1 && editaveis[0] === v) { c.classList.add('is-seu'); lc.insertAdjacentHTML('beforeend', '<em class="nc-av-voz-tag">seu comentário</em>'); }
      }
      if (t && (t.disabled || t.readOnly) && !t.value.trim()) t.setAttribute('placeholder', 'Ainda sem comentário');
    });
    /* o ícone alinha com a borda do texto (o grid do APEX tem margem negativa, e a região corta) */
    setTimeout(function () {
      [].forEach.call(r.querySelectorAll('.nc-av-voz'), function (c) {
        var ic = c.querySelector('.nc-av-voz-ic'), t = c.querySelector('textarea');
        if (ic && t) { var dx = t.getBoundingClientRect().left - ic.getBoundingClientRect().left; if (dx > 0 && dx < 40) c.style.setProperty('--nc-av-voz-x', dx + 'px'); }
      });
    }, 50);
    var co = reg('nc-av-conclusao'); if (co) co.classList.add('nc-av-conclusao-box');
  }

  /* ═══ [J10] O TEXTO DO ALTO E A CRIAÇÃO (140) ══════════════════════════════════════════════
     O QUE FAZ  desenharHero() escreve o título, a frase e o botão do alto conforme o andamento:
                  "Vamos começar: 23 perguntas" · "Faltam 5 de 23 perguntas" · "Todas as 23
                  perguntas respondidas" · "As perguntas estão fechadas" (só consulta);
                e a trilha (um traço por pergunta). O botão abre a próxima pergunta sem
                resposta ("Começar" / "Responder a pergunta 7"), ou "Revisar respostas".
                Numa avaliação NOVA (ainda sem avaliado: P140_COD_MAT_AVALIADO vazio e nenhuma
                pergunta), desenharCriacao() troca tudo por "Nova avaliação" em 3 passos:
                  1 a avaliação e a data → 2 quem será avaliado → 3 as perguntas.
                O "Aviso" (avaliação anônima) fica fora da vista enquanto não tem texto.
     PODE MEXER todos os textos entre aspas destas funções.
     VISUAL     Natcorp_Avaliacao.css › [C2] (o alto) e [C9] (criação)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function valorApex(id) { try { return String(apex.item(id).getValue() || '').trim(); } catch (x) { var e = document.getElementById(id); return e ? e.value.trim() : ''; } }
  /* CRIAÇÃO: ainda não há avaliado (a página abre sem P140_COD_MAT_AVALIADO) */
  function emCriacao() { return !valorApex('P140_COD_MAT_AVALIADO') && !(AV.total > 0); }

  function desenharCriacao(h) {
    var aval = semCodigo(valorItem('P140_COD_AVALIACAO')), dataAv = valorItem('P140_DATA_AVALIACAO');
    var p1 = !!(valorApex('P140_COD_AVALIACAO') && dataAv);
    var passos = [
      { n: 1, nome: 'A avaliação e a data', txt: p1 ? [aval, dataAv].filter(Boolean).join(' · ') : 'Escolha qual avaliação e a data', ok: p1, alvo: 'nc-av-dados' },
      { n: 2, nome: 'Quem será avaliado', txt: 'Escolha a empresa e a matrícula', ok: false, alvo: 'COLABORADOR' },
      { n: 3, nome: 'As perguntas', txt: 'Abrem depois de escolher quem é avaliado', ok: false }
    ];
    var atual = p1 ? 2 : 1;
    h.classList.add('is-criacao');
    h.querySelector('[data-slot="titulo"]').textContent = 'Nova avaliação';
    h.querySelector('[data-slot="sub"]').textContent = 'Três passos: a avaliação, quem será avaliado e as perguntas.';
    h.querySelector('[data-slot="cta"]').innerHTML = atual === 2
      ? '<button type="button" class="nc-av-cta" data-escolher>' + svg(IC.pessoa) + 'Escolher quem será avaliado</button>' : '';
    h.querySelector('[data-slot="trilha"]').hidden = true;
    var ol = h.querySelector('[data-slot="passos"]');
    ol.hidden = false;
    ol.innerHTML = passos.map(function (x) {
      var cls = x.ok ? 'is-ok' : x.n === atual ? 'is-atual' : 'is-depois';
      var alvo = x.alvo === 'nc-av-dados' ? (reg('nc-av-dados') || {}).id : x.alvo;
      var tag = alvo && x.n <= atual ? 'a href="#' + esc(alvo) + '" data-ir="' + esc(alvo) + '"' : 'div';
      return '<li class="nc-av-passo ' + cls + '"' + (x.n === atual ? ' aria-current="step"' : '') + '><' + tag + ' class="nc-av-passo-in">' +
        '<span class="nc-av-passo-n" aria-hidden="true">' + (x.ok ? svg(IC.ok) : x.n) + '</span>' +
        '<span class="nc-av-passo-txt"><b>' + esc(x.nome) + '</b><span>' + esc(x.txt) + '</span></span></' + tag.split(' ')[0] + '></li>';
    }).join('');
    h.querySelector('[data-slot="fatos"]').hidden = true;
  }

  function desenharHero() {
    var h = AV.hero; if (!h) return;
    /* o "Aviso" (avaliação anônima) aparece vazio na criação: fica fora da vista enquanto não tem texto */
    var aviso = document.getElementById('AVISO');
    if (aviso) aviso.classList.toggle('nc-av-aviso-vazio', !valorApex('P140_AVISO'));
    if (emCriacao()) { desenharCriacao(h); return; }
    h.classList.remove('is-criacao');
    h.querySelector('[data-slot="passos"]').hidden = true;
    h.querySelector('[data-slot="fatos"]').hidden = false;
    var total = AV.total || 0, feitas = AV.feitas || 0, falta = total - feitas;
    var ro = somenteLeitura();
    var titulo, sub;
    if (!total) { titulo = 'Avaliação'; sub = ''; }
    else if (ro) { titulo = falta ? 'As perguntas estão fechadas' : 'Perguntas respondidas'; sub = feitas + ' de ' + total + ' respondidas. As respostas não aceitam mais mudança.'; }
    else if (!feitas) { titulo = 'Vamos começar: ' + plural(total, 'pergunta', 'perguntas'); sub = 'Uma de cada vez. Cada resposta fica gravada assim que você toca nela.'; }
    else if (falta) { titulo = 'Faltam ' + falta + ' de ' + total + ' perguntas'; sub = plural(feitas, 'já respondida', 'já respondidas') + '. Continue de onde parou.'; }
    else { titulo = 'Todas as ' + total + ' perguntas respondidas'; sub = 'Confira as outras etapas abaixo e toque em Salvar para gravar os textos.'; }
    var avaliado = semCodigo(valorItem('P140_MATRICULA_DISPLAY'));
    var colab = document.getElementById('COLABORADOR');
    if (avaliado && visivel(colab)) sub = 'Sobre ' + avaliado + (sub ? ' · ' + sub : '');
    h.querySelector('[data-slot="titulo"]').textContent = titulo;
    h.querySelector('[data-slot="sub"]').textContent = sub;
    h.classList.toggle('is-completa', !!total && !falta);

    var cta = '';
    if (total && !ro && AV.prox >= 0) cta = '<button type="button" class="nc-av-cta" data-abrir="' + AV.prox + '">' + (feitas ? 'Responder a pergunta ' + esc(AV.lista[AV.prox].ordem) : 'Começar') + svg(IC.seta) + '</button>';
    else if (total) cta = '<button type="button" class="nc-av-cta nc-av-cta--calmo" data-abrir="0">' + (ro ? svg(IC.olho) + 'Ver as respostas' : svg(IC.lapis) + 'Revisar respostas') + '</button>';
    h.querySelector('[data-slot="cta"]').innerHTML = cta;

    /* a trilha: um traço por pergunta, agrupado por competência */
    var tr = h.querySelector('[data-slot="trilha"]');
    tr.hidden = !total;
    tr.setAttribute('aria-label', feitas + ' de ' + total + ' perguntas respondidas');
    tr.innerHTML = (AV.grupos || []).map(function (g) {
      return '<span class="nc-av-trilha-g" title="' + esc(g.nome) + '" style="flex-grow:' + g.itens.length + '">' + g.itens.map(function (i) {
        return '<i class="' + (respondida(AV.lista[i]) ? 'is-ok' : i === AV.prox ? 'is-prox' : '') + '"></i>';
      }).join('') + '</span>';
    }).join('');
    atualizarEtapas();
  }

  /* ═══ [J11] AS ETAPAS DO ALTO (140) ════════════════════════════════════════════════════════
     O QUE FAZ  Uma "pílula" por região que o APEX está mostrando (só aparecem se houver pelo
                menos 2), com o andamento: Perguntas "5 de 23"; Feedback "2 registros"; as
                outras, "1 de 3 campos" (ou "Só leitura"). Tocar rola a tela até a região.
     PODE MEXER na lista ETAPAS, o "nome" (o texto da pílula) e a ORDEM das linhas.
     CUIDADO    "cls" é a classe da região no APEX (o "combinado"); "ic" é um nome da lista IC.
     VISUAL     Natcorp_Avaliacao.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: os nomes das etapas e a ordem */
  var ETAPAS = [
    { cls: 'nc-av-questoes', nome: 'Perguntas', ic: 'perguntas' },
    { cls: 'nc-av-plano', nome: 'Plano de desenvolvimento', ic: 'alvo' },
    { cls: 'nc-av-feedback', nome: 'Feedback', ic: 'balao' },
    { cls: 'nc-av-comentario', nome: 'Comentário', ic: 'balao' },
    { cls: 'nc-av-conclusao', nome: 'Conclusão', ic: 'selo' }
  ];
  function camposTexto(r) {
    return [].slice.call(r.querySelectorAll('textarea, input[type=text]')).filter(function (t) {
      var c = t.closest('.t-Form-fieldContainer'); return c && c.style.display !== 'none' && t.type !== 'hidden';
    });
  }
  function atualizarEtapas() {
    if (!AV || !AV.hero) return;
    var ol = AV.hero.querySelector('[data-slot="etapas"]');
    var itens = ETAPAS.map(function (e) {
      var r = reg(e.cls);
      if (!r || !visivel(r) || r.classList.contains('nc-av-fora')) return '';
      if (!r.id) r.id = 'nc-av-' + e.cls;
      var estado = '', txt = '';
      if (e.cls === 'nc-av-questoes') {
        var t = AV.total || 0, f = AV.feitas || 0;
        estado = !t ? '' : f === t ? 'ok' : f ? 'meio' : '';
        txt = t ? f + ' de ' + t : '';
      } else if (e.cls === 'nc-av-feedback') {
        var linhas = r.querySelectorAll('table.t-Report-report tbody tr, .a-IRR-table tbody tr').length;
        estado = linhas ? 'ok' : ''; txt = linhas ? plural(linhas, 'registro', 'registros') : 'Nenhum ainda';
      } else {
        var cs = camposTexto(r);
        var edit = cs.filter(function (t) { return !t.disabled && !t.readOnly; });
        var cheios = edit.filter(function (t) { return t.value.trim(); }).length;
        if (!edit.length) { txt = cs.some(function (t) { return t.value.trim(); }) ? 'Para ler' : 'Só leitura'; estado = 'leitura'; }
        else { txt = cheios + ' de ' + edit.length + (edit.length === 1 ? ' campo' : ' campos'); estado = cheios === edit.length ? 'ok' : cheios ? 'meio' : ''; }
      }
      return '<li class="nc-av-etapa' + (estado ? ' is-' + estado : '') + '"><a href="#' + esc(r.id) + '" data-ir="' + esc(r.id) + '">' +
        '<span class="nc-av-etapa-ic" aria-hidden="true">' + svg(estado === 'ok' ? IC.ok : IC[e.ic]) + '</span>' +
        '<span class="nc-av-etapa-nome">' + esc(e.nome) + '</span>' +
        (txt ? '<span class="nc-av-etapa-txt">' + esc(txt) + '</span>' : '') + '</a></li>';
    }).filter(Boolean);
    ol.innerHTML = itens.join('');
    ol.parentNode.hidden = itens.length < 2;
  }

  /* ═══ [J12] OS TEXTOS CRESCEM (140) ════════════════════════════════════════════════════════
     O QUE FAZ  Nas regiões Plano, Comentário e Conclusão, cada caixa de texto acompanha o
                tamanho do texto (até 520px). Travada e vazia, fica numa linha só, com "Ainda sem
                texto". Ao digitar, a barra de Salvar passa a avisar "Há texto ainda não salvo".
     PODE MEXER 'Ainda sem texto', 'Escreva aqui'.
     VISUAL     Natcorp_Avaliacao.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function crescer(t) {
    if (!t) return;
    if (t.disabled || t.readOnly) {
      if (!t.value.trim()) { t.rows = 1; if (!t.getAttribute('placeholder')) t.setAttribute('placeholder', 'Ainda sem texto'); t.style.removeProperty('--nc-av-h'); return; }
    }
    /* a Skin põe height:auto !important nas textareas: a altura vai por variável, que a regra
       .nc-av-textos textarea aplica */
    t.style.setProperty('--nc-av-h', '0px');
    t.style.setProperty('--nc-av-h', Math.min(Math.max(t.scrollHeight + 2, t.disabled ? 0 : 92), 520) + 'px');
  }
  function montarTextos() {
    ['nc-av-plano', 'nc-av-comentario', 'nc-av-conclusao'].forEach(function (cls) {
      var r = reg(cls); if (!r) return;
      r.classList.add('nc-av-textos');
      camposTexto(r).forEach(function (t) {
        if (t.tagName !== 'TEXTAREA') return;
        if (!t.getAttribute('placeholder') && !t.disabled && !t.readOnly) t.setAttribute('placeholder', 'Escreva aqui');
        crescer(t);
        t.addEventListener('input', function () { crescer(t); marcarSujo(); });
      });
      [].forEach.call(r.querySelectorAll('input[type=text]'), function (t) { t.addEventListener('input', marcarSujo); });
    });
  }

  /* ═══ [J13] A BARRA DE SALVAR E O EXCLUIR (140) ════════════════════════════════════════════
     O QUE FAZ  O botão "Salvar" da região "Botões" vai para uma barra presa no pé da tela, com
                uma frase: "As perguntas gravam sozinhas. Os textos, ao tocar em Salvar." ou,
                depois de digitar, "Há texto ainda não salvo". O "Deletar" vai para o FIM da
                página como "Excluir esta avaliação" (longe do polegar).
                A barra e o Excluir acompanham o botão original: se o APEX o esconde (por
                exemplo, na criação, antes da hora), eles somem também.
     PODE MEXER os textos entre aspas.
     CUIDADO    /^salvar$/i e /^(deletar|excluir)$/i são os textos PROCURADOS nos botões do APEX.
                Se forem renomeados no APEX, mude aqui também.
     VISUAL     Natcorp_Avaliacao.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarBarra() {
    var acoes = reg('nc-av-acoes');
    if (!acoes) return;
    var bts = [].slice.call(acoes.querySelectorAll('.t-Button'));
    var salvar = bts.filter(function (b) { return /^salvar$/i.test(limpo(b.textContent)); })[0];
    var deletar = bts.filter(function (b) { return /^(deletar|excluir)$/i.test(limpo(b.textContent)); })[0];
    if (!salvar && !deletar) return;
    if (salvar) {
      var barra = el('div', 'nc-av-barra');
      barra.setAttribute('role', 'region'); barra.setAttribute('aria-label', 'Salvar a avaliação');
      barra.innerHTML = '<p class="nc-av-barra-txt" data-slot="estado" aria-live="polite"></p>';
      salvar.classList.add('nc-av-salvar');
      var rot = salvar.querySelector('.t-Button-label'); if (rot) rot.textContent = 'Salvar';
      salvar.insertAdjacentHTML('afterbegin', svg(IC.salvar));
      barra.appendChild(salvar);
      document.body.appendChild(barra);
      AV.barra = barra;
      estadoBarra();
      /* na criação o APEX mostra o Salvar só depois: a barra acompanha o botão */
      seguirVisivel(salvar, function (vis) { barra.hidden = !vis; document.body.classList.toggle('nc-av-com-barra', vis); });
    }
    if (deletar) {
      var fim = el('div', 'nc-av-fim');
      fim.innerHTML = '<p>Excluir apaga esta avaliação e as respostas dela.</p>';
      deletar.classList.add('nc-av-deletar');
      var rd = deletar.querySelector('.t-Button-label'); if (rd) rd.textContent = 'Excluir esta avaliação';
      fim.appendChild(deletar);
      var ultimo = [].slice.call(document.querySelectorAll('.t-Body-contentInner > .container > .row, .t-Body-contentInner > .row')).pop();
      (ultimo ? ultimo.parentNode : document.querySelector('.t-Body-contentInner') || document.body).appendChild(fim);
      seguirVisivel(deletar, function (vis) { fim.hidden = !vis; });
    }
    /* o que sobra no "Botões" (as requisições) continua lá, com as regras do APEX; a região some
       da vista só enquanto nenhum botão dela estiver à mostra (é o CSS que decide) */
    window.addEventListener('beforeunload', function () { /* o submit do Salvar limpa o aviso */ });
    $(document).on('apexbeforepagesubmit', function () { AV.sujo = false; });
  }
  /* o APEX mostra/esconde o botão com style="display:none": quem depende dele acompanha */
  function seguirVisivel(b, fn) {
    function olhar() { fn(b.style.display !== 'none'); }
    new MutationObserver(olhar).observe(b, { attributes: true, attributeFilter: ['style'] });
    olhar();
  }
  function marcarSujo() { if (!AV.sujo) { AV.sujo = true; estadoBarra(); } }
  function estadoBarra() {
    if (!AV.barra) return;
    var p = AV.barra.querySelector('[data-slot="estado"]');
    AV.barra.classList.toggle('is-sujo', AV.sujo);
    p.innerHTML = AV.sujo ? svg(IC.alerta) + '<span>Há texto ainda não salvo</span>'
      : svg(IC.ok) + '<span>As perguntas gravam sozinhas. Os textos, ao tocar em Salvar.</span>';
  }

  /* ██████████████████████████████████████████████████████████████████████████████████████
     PÁGINA 144 — a pergunta                                             partes [J14] e [J15]
     ██████████████████████████████████████████████████████████████████████████████████████ */
  /* ═══ [J14] A PERGUNTA (144) ═══════════════════════════════════════════════════════════════
     O QUE FAZ  Roda uma vez: põe a marca nc-avq na página (liga o visual do CSS) e monta:
                  • o topo: "Pergunta 3 de 23" com a barra de progresso, a competência, a
                    pergunta em letra grande e a descrição (os campos originais saem da vista);
                  • as opções do P144_RADIO_GROUP em cartões de toque, com os pontos da escala;
                  • a resposta escrita (perguntas do tipo "D", dissertativas): campo grande e
                    "Salvando…" / "Resposta salva" ao sair do campo;
                  • avaliação fechada: o aviso "fechada para respostas";
                  • depois que a página grava a escolha e se recarrega (é da página), aparece
                    "Resposta salva: Regular".
     LÊ DOS ITENS  P144_ORDEM_ITEM, P144_ORDEM_COUNT, P144_DESC_COMP, P144_NOME_ITEM_AVALIACAO,
                P144_DESCRICAO, P144_CARACTERISTICA, P144_RADIO_GROUP, P144_RESPOSTA_DISSERTATIVA,
                P144_NOTA_ITEM, P144_ROWID.
     PODE MEXER os textos entre aspas ('Pergunta', 'Escreva sua resposta…', 'Salvando…',
                'Resposta salva', a frase de avaliação fechada).
     VISUAL     Natcorp_Avaliacao.css › [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montar144() {
    document.body.classList.add('nc-avq');
    var perg = reg('nc-av-pergunta') || (document.getElementById('P144_NOME_ITEM_AVALIACAO_CONTAINER') || {}).closest && document.getElementById('P144_NOME_ITEM_AVALIACAO_CONTAINER').closest('.t-Region');
    var resp = reg('nc-av-respostas') || (document.getElementById('P144_RADIO_GROUP_CONTAINER') && document.getElementById('P144_RADIO_GROUP_CONTAINER').closest('.t-Region'));
    if (!perg) return;
    perg.classList.add('nc-av-pergunta');
    if (resp) resp.classList.add('nc-av-respostas');

    var ordem = +document.getElementById('P144_ORDEM_ITEM').value || 0;
    var total = +document.getElementById('P144_ORDEM_COUNT').value || 0;
    var comp = valorItem('P144_DESC_COMP');
    var texto = valorItem('P144_NOME_ITEM_AVALIACAO');
    var sobre = valorItem('P144_DESCRICAO');
    var disser = (document.getElementById('P144_CARACTERISTICA') || {}).value === 'D';

    var corpo = perg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || perg;
    var topo = el('div', 'nc-avq-topo');
    topo.innerHTML =
      (total ? '<div class="nc-avq-progresso"><div class="nc-avq-prog-txt"><b>Pergunta ' + ordem + '</b><span>de ' + total + '</span></div>' +
        '<div class="nc-avq-prog-barra" role="progressbar" aria-valuemin="0" aria-valuemax="' + total + '" aria-valuenow="' + ordem + '" aria-label="Pergunta ' + ordem + ' de ' + total + '"><i style="width:' + Math.round(ordem / total * 100) + '%"></i></div></div>' : '') +
      (comp ? '<p class="nc-avq-comp">' + esc(comp) + '</p>' : '') +
      '<h2 class="nc-avq-texto">' + esc(texto || 'Pergunta ' + ordem) + '</h2>' +
      (sobre ? '<p class="nc-avq-sobre">' + esc(sobre) + '</p>' : '');
    corpo.insertBefore(topo, corpo.firstChild);
    ['P144_DESC_COMP', 'P144_NOME_ITEM_AVALIACAO', 'P144_DESCRICAO'].forEach(function (n) {
      var c = document.getElementById(n + '_CONTAINER'); if (c) c.classList.add('nc-av-fora');
    });

    /* as respostas */
    var grupo = document.getElementById('P144_RADIO_GROUP');
    var radios = grupo ? [].slice.call(grupo.querySelectorAll('input[type=radio]')) : [];
    var ro = radios.length ? radios.every(function (r) { return r.disabled; }) : false;
    var dis = document.getElementById('P144_RESPOSTA_DISSERTATIVA');
    if (disser) ro = !dis || dis.disabled || dis.readOnly || dis.type === 'hidden';
    if (radios.length) {
      var max = Math.max.apply(null, radios.map(function (r) { return +r.value || 0; }));
      radios.forEach(function (r) {
        var op = r.closest('.apex-item-option'); if (!op) return;
        var lb = op.querySelector('label');
        var v = +r.value || 0;
        if (lb && max > 1 && v > 0 && !lb.querySelector('.nc-avq-escala')) {
          var pts = ''; for (var k = 1; k <= max; k++) pts += '<i' + (k <= v ? ' class="is-on"' : '') + '></i>';
          lb.insertAdjacentHTML('beforeend', '<span class="nc-avq-escala" aria-hidden="true">' + pts + '</span>');
        }
        lb && lb.insertAdjacentHTML('afterbegin', '<span class="nc-avq-marca" aria-hidden="true">' + svg(IC.ok) + '</span>');
      });
      var cRadio = document.getElementById('P144_RADIO_GROUP_CONTAINER');
      if (cRadio) cRadio.classList.add('nc-avq-opcoes');
      /* marca para mostrar "Resposta salva" depois do envio que a própria página faz */
      $(grupo).on('change', 'input[type=radio]', function () { guardar('nc-avq-salvo', document.getElementById('P144_ROWID').value); });
    }
    if (dis && dis.tagName === 'TEXTAREA') {
      var cDis = document.getElementById('P144_RESPOSTA_DISSERTATIVA_CONTAINER');
      if (cDis) cDis.classList.add('nc-avq-escrita');
      if (!dis.getAttribute('placeholder')) dis.setAttribute('placeholder', 'Escreva sua resposta com as suas palavras');
      var aviso = el('p', 'nc-avq-salvo-txt'); aviso.setAttribute('aria-live', 'polite');
      dis.parentNode.appendChild(aviso);
      var esperando = false;
      dis.addEventListener('input', function () { aviso.textContent = 'Salva quando você sair do campo'; aviso.className = 'nc-avq-salvo-txt is-pendente'; });
      dis.addEventListener('focusout', function () { if (dis.value.trim()) { esperando = true; aviso.textContent = 'Salvando…'; aviso.className = 'nc-avq-salvo-txt is-pendente'; } });
      $(document).ajaxComplete(function (ev, xhr) {
        if (!esperando) return;
        esperando = false;
        var ok = xhr && xhr.status >= 200 && xhr.status < 300;
        aviso.innerHTML = ok ? svg(IC.ok) + 'Resposta salva' : 'Não foi possível salvar. Tente de novo.';
        aviso.className = 'nc-avq-salvo-txt ' + (ok ? 'is-ok' : 'is-erro');
      });
    }
    /* a resposta escrita só existe nas perguntas dissertativas (a ação dinâmica esconde o campo e
       o rótulo, mas o contêiner vazio ficava); nas outras, a lista de opções */
    var cDiss = document.getElementById('P144_RESPOSTA_DISSERTATIVA_CONTAINER');
    if (cDiss && !disser) cDiss.classList.add('nc-av-fora');
    /* a nota só aparece quando existe */
    var nota = valorItem('P144_NOTA_ITEM');
    var cNota = document.getElementById('P144_NOTA_ITEM_CONTAINER');
    if (cNota) cNota.classList.toggle('nc-av-fora', vazio(nota));
    if (ro) {
      document.body.classList.add('nc-avq-leitura');
      var ler = el('p', 'nc-avq-ler', svg(IC.cadeado) + '<span>Esta avaliação está fechada para respostas. Você pode consultar e passar pelas perguntas.</span>');
      (resp || perg).querySelector('.t-Region-body').insertBefore(ler, (resp || perg).querySelector('.t-Region-body').firstChild);
    }

    /* "Resposta salva": a página se recarrega depois de gravar a escolha */
    var rowid = document.getElementById('P144_ROWID').value;
    if (guardar('nc-avq-salvo') === rowid) {
      guardar('nc-avq-salvo', null);
      var marcado = radios.filter(function (r) { return r.checked; })[0];
      if (marcado) {
        var t = el('p', 'nc-avq-toast', svg(IC.ok) + '<span>Resposta salva: <b>' + esc(limpo((marcado.closest('.apex-item-option').querySelector('label') || {}).textContent)) + '</b></span>');
        t.setAttribute('role', 'status');
        (resp || perg).querySelector('.t-Region-body').appendChild(t);
        document.body.classList.add('nc-avq-acabou-de-salvar');
      }
    }

    montarBotoes144(ordem, total);
  }

  /* ═══ [J15] OS BOTÕES DA JANELA (144) ══════════════════════════════════════════════════════
     O QUE FAZ  Os botões de seta ganham rótulo: "Anterior" e "Próxima". "Voltar" vira "Voltar
                à lista" (na última pergunta, "Concluir"). O botão "Ações" vira "Indicar ação".
                Quando a resposta pede um plano de ação (as ações dinâmicas trocam a Próxima
                pela versão de "alerta"), aparece o aviso "Toque em Indicar ação antes de ir
                para outra pergunta". Logo depois de salvar, a "Próxima" fica em destaque.
     PODE MEXER os textos 'Anterior', 'Próxima', 'Voltar à lista', 'Concluir', 'Indicar ação' e
                a frase do aviso.
     CUIDADO    Os botões são achados pelo id fixo: BTN_PREV_RECORD, BTN_NEXT_RECORD,
                BTN_PREV_ALERTA, BTN_NEXT_ALERTA e P144_ACAO (Static ID no APEX). Não renomeie.
     VISUAL     Natcorp_Avaliacao.css › [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarBotoes144(ordem, total) {
    function rotular(id, txt, depois) {
      var b = document.getElementById(id); if (!b) return null;
      b.classList.add('nc-avq-nav');
      b.classList.remove('t-Button--noLabel');
      if (!b.querySelector('.t-Button-label')) {
        var s = el('span', 't-Button-label', txt);
        if (depois) b.appendChild(s); else b.insertBefore(s, b.firstChild);
      }
      b.setAttribute('aria-label', txt); b.setAttribute('title', txt);
      return b;
    }
    rotular('BTN_PREV_RECORD', 'Anterior', true);
    rotular('BTN_PREV_ALERTA', 'Anterior', true);
    var prox = rotular('BTN_NEXT_RECORD', 'Próxima');
    rotular('BTN_NEXT_ALERTA', 'Próxima');
    [].forEach.call(document.querySelectorAll('#BTN_PREV_RECORD, #BTN_PREV_ALERTA'), function (b) { b.classList.add('nc-avq-ant'); });
    /* primeira pergunta: sem "Anterior", a "Próxima" ocupa a linha no celular */
    document.body.classList.toggle('nc-avq-sem-ant', !document.getElementById('BTN_PREV_RECORD') && !document.getElementById('BTN_PREV_ALERTA'));
    var voltar = [].slice.call(document.querySelectorAll('.t-Button')).filter(function (b) { return /^voltar$/i.test(limpo(b.textContent)); })[0];
    var ultima = total && ordem >= total || !prox;
    if (voltar) {
      voltar.classList.add('nc-avq-voltar');
      var lv = voltar.querySelector('.t-Button-label');
      if (lv) lv.textContent = ultima ? 'Concluir' : 'Voltar à lista';
      voltar.insertAdjacentHTML('afterbegin', svg(ultima ? IC.ok : IC.lista));
      if (ultima) voltar.classList.add('is-final');
    }
    /* o botão da ação (quando a resposta pede um plano) */
    var acao = document.getElementById('P144_ACAO');
    if (acao) {
      acao.classList.add('nc-avq-acao');
      var la = acao.querySelector('.t-Button-label'); if (la && /^a[çc][õo]es$/i.test(limpo(la.textContent))) la.textContent = 'Indicar ação';
    }
    var alerta = el('p', 'nc-avq-alerta', svg(IC.alerta) + '<span>Esta resposta pede um plano de ação. Toque em <b>Indicar ação</b> antes de ir para outra pergunta.</span>');
    alerta.setAttribute('role', 'status'); alerta.hidden = true;
    var resp = reg('nc-av-respostas') || reg('nc-av-pergunta');
    if (resp) resp.querySelector('.t-Region-body').appendChild(alerta);
    /* as ações dinâmicas trocam Próxima ↔ Próxima (alerta) depois de validar: o aviso acompanha */
    function olhar() {
      var na = document.getElementById('BTN_NEXT_ALERTA'), pa = document.getElementById('BTN_PREV_ALERTA');
      var pede = [na, pa].some(function (b) { return b && b.style.display !== 'none' && getComputedStyle(b).display !== 'none'; });
      alerta.hidden = !pede;
      document.body.classList.toggle('nc-avq-pede-acao', pede);
    }
    var mo = new MutationObserver(olhar);
    ['BTN_NEXT_ALERTA', 'BTN_PREV_ALERTA', 'P144_ACAO'].forEach(function (id) { var b = document.getElementById(id); if (b) mo.observe(b, { attributes: true, attributeFilter: ['style'] }); });
    olhar();
    /* depois de salvar a escolha, o próximo passo natural é a próxima pergunta */
    if (document.body.classList.contains('nc-avq-acabou-de-salvar') && prox && prox.style.display !== 'none') {
      prox.classList.add('is-destaque');
      setTimeout(function () { try { prox.focus({ preventScroll: true }); } catch (x) { /* ok */ } }, 80);
    }
  }
})();
