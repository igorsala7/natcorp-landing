/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE SERVIÇO DE TERCEIROS  —  o "arrumador" da tela (JavaScript)   ║
   ║  App 2290 · Página 186 · o gestor pede a contratação de uma empresa terceirizada       ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ──────────────────────────────────────────────────────────────────
   A página é aberta pela aba "Requisição de Serviços de Terceiros" do Painel (app de Segurança
   do Trabalho). O gestor pede a contratação de uma empresa terceirizada e comprova, pergunta a
   pergunta, que os funcionários dela têm os documentos de segurança do trabalho (vínculo, ASO,
   certificados, EPI, APR, ART…). Este arquivo deixa isso mais fácil de entender e preencher:
     1. Abertura: o que é o pedido e a LISTA DE DOCUMENTOS para pedir à empresa contratada, em
        palavras simples, com "Copiar a lista" e "Mandar pelo WhatsApp".
     2. Cada pergunta de segurança ganha "Em outras palavras" (uma frase curta por cima do texto
        oficial, que continua na tela) e as siglas explicadas (ASO, NR35, EPI, FISPQ, APR, ART…).
     3. As respostas já vêm marcadas "Sim": cada pergunta mostra se a pessoa já conferiu, e cada
        bloco conta "3 de 5 conferidas". "Não" / "Não se aplica" ganham um aviso calmo.
     4. Produtos químicos = Não: as perguntas e o anexo que dependem disso ficam recolhidos.
     5. Anexos: cada um diz o que é; cada bloco conta "2 de 11 anexos".
     6. Barra no pé: o que falta (campos e anexos; o toque leva ao lugar) e "Enviar pedido"
        (que clica o botão "Criar" de verdade).
     7. Pedido gravado: cabeçalho com nº, situação, empresa contratada, prazo e quem pediu; a
        aprovação (se houver o relatório de aprovadores) vira o caminho das outras requisições.

   ── O QUE ELE NÃO FAZ ───────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: itens, validações, botões e
       processos continuam sendo do APEX. Os botões daqui só CLICAM os botões de verdade.
     • A marca "Conferido" de cada pergunta não é gravada: vale só enquanto a página está aberta.
     • O stepper "Página única / Etapas" é do time (Natcorp_Allow_Unload_Iframes.js) e NÃO é
       tocado: este arquivo só acrescenta coisas DENTRO das seções. Não altere aquele arquivo.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ──────────────────────────────────────────────────────────────────
     App 2290 › Página 186 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Terceiros.js
     (no FIM da lista: a página já carrega o jquery.mask antes dele)
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Terceiros.css.
     Este é o arquivo-FONTE (.src.js). O arquivo que sobe (o .js de mesmo nome, em brand/apex/login)
     é gerado a partir dele pelo gerar-*.py da página: edite ESTE arquivo (manual, parte 2).

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ────────────────────────────────────
   Esta página NÃO usa classes próprias nas regiões. O arquivo se reconhece sozinho:
     • só liga se a página tiver os itens …_IND_VINCULO_EMPREG e …_COD_TERCEIRO (não testa o
       número do app nem da página — por isso funciona numa cópia da página);
     • as perguntas são os itens de rádio cujo nome começa com IND_ ou ID_;
     • os anexos são os itens da lista DOCS em [J1] (ARQ_VINC_EMPREG, ARQ_ASO…);
     • a região do stepper do time é a que tem a classe nc-stepper-host;
     • o botão "Criar" é achado pelo texto (vira "Enviar pedido"), e o "Cadastrar Empresas
       Terceirizadas" também (vira "Cadastrar nova empresa").
   Os campos, botões e ações dinâmicas continuam os do APEX: aqui eles só MUDAM DE LUGAR.

   ── ÍNDICE: as partes deste arquivo ─────────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Textos e listas da página ........... perguntas simples, anexos, siglas, dicas  PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  A abertura e a lista de documentos .. "Copiar a lista", "Mandar pelo WhatsApp"  PODE MEXER
     [J4]  As perguntas de segurança ........... outras palavras, siglas, "Conferido"     PODE MEXER
     [J5]  Os anexos ........................... "Falta anexar" / "Anexado"
     [J6]  Dicas dos campos do começo .......... a frase entre o nome do campo e a caixa
     [J7]  O Prestador por assunto ............. "A empresa contratada" e "O contrato"     PODE MEXER
     [J8]  A barra do pé ....................... o que falta + "Enviar pedido"            PODE MEXER
     [J9]  Pedido gravado ...................... cabeçalho com nº, situação e prazo
     [J10] O caminho da aprovação .............. quem aprovou, quem falta
     [J11] O maestro ........................... decide QUANDO cada parte é montada       CUIDADO

   ── RECEITAS RÁPIDAS ────────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Contratar um serviço de terceiro'  →  'Novo serviço de terceiro'
     Quero mudar a frase simples de uma pergunta        → [J1], lista SIMPLES (pelo nome do item)
     Criei uma pergunta nova (rádio IND_…) no APEX
       → ela já ganha o cartão e o "Conferido" sozinha, com o texto oficial. Para ter a frase
         simples, acrescente uma linha em SIMPLES, em [J1].
     Criei um anexo novo no APEX
       → acrescente uma linha na lista DOCS, em [J1], com o nome do item (sem o prefixo) e o
         nome simples. Sem isso, ele não entra na lista de documentos nem no "N de 11 anexados".
     Quero mudar a dica de um campo do começo          → [J1], lista DICAS
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e veja se há erro. O manual, parte 5,
         explica o que fazer com a mensagem.

   ── LEGENDA DAS MARCAS NOS COMENTÁRIOS ──────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, títulos.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
     (sem marca)  funciona sozinho; só mexa se souber o que está fazendo.

   ── COMO LER UM ARQUIVO JS EM 30 SEGUNDOS ───────────────────────────────────────────────────
     comentário             tudo entre barra-asterisco e asterisco-barra, e o resto da linha
                            depois de duas barras. O navegador ignora: é só para pessoas.
     function nome() { … }  uma "receita" com nome. Ela só roda quando alguém a chama: nome().
     var x = …;             guarda um valor com um nome, para usar depois.
     'texto'  ou  "texto"   um texto. Muitas vezes, é o que aparece na tela.
     P + 'COD_TERCEIRO'     junta os textos: vira 'P186_COD_TERCEIRO', o nome do item no APEX.
     val(…) / txt(…)        leem o que está num item do APEX (veja [J2]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: estas linhas decidem SE o arquivo roda. Ele roda uma vez só, só dentro do APEX e só
     numa página que tenha os itens …_IND_VINCULO_EMPREG e …_COD_TERCEIRO. Não apague. */
  if (window.__ncTER || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_IND_VINCULO_EMPREG_CONTAINER"]');
  if (!achado) return;
  /* P = o começo do nome dos itens desta página (ex.: 'P186_'). Ele é DESCOBERTO sozinho a partir
     do item IND_VINCULO_EMPREG: se a página for copiada para outro número, nada muda aqui. */
  var P = achado.id.replace(/IND_VINCULO_EMPREG_CONTAINER$/, '');
  if (!document.getElementById(P + 'COD_TERCEIRO')) return;
  window.__ncTER = true;

  var $ = apex.jQuery;
  /* ═══ [J1] TEXTOS E LISTAS DA PÁGINA ═══════════════════════════════════════════════════════
     O QUE É    As listas que dizem o que aparece na tela. É a parte mais fácil de mudar.
                  IC       os ícones (desenhos pequenos, formato SVG). Não precisa mexer.
                  SIMPLES  a pergunta "em outras palavras": nome do item (SEM o prefixo P…_) e a frase.
                  DOCS     os anexos: [nome do item, nome simples, (opcional) item que dispensa o anexo
                           quando vale 'N']. A FISPQ some quando IND_PRODUTO_QUIMICO = Não.
                  SIGLAS   [padrão de busca, sigla, explicação]. Cada sigla é explicada uma vez por bloco.
                  DICAS    a dica de cada campo do começo, pelo nome do item.
     PODE MEXER Os textos entre aspas de SIMPLES, DOCS, SIGLAS e DICAS. Para acrescentar uma linha,
                copie uma linha inteira (com a vírgula do fim) e troque o nome do item e o texto.
     CUIDADO    • A ÚLTIMA linha de cada lista não tem vírgula no fim; as outras têm.
                • Em SIGLAS, o primeiro pedaço (entre barras, como /\bAPR\b/) é um "padrão de busca"
                  (expressão regular): procura a sigla no texto oficial. Só troque se souber.
                • A ORDEM de DOCS é a ordem da lista de documentos da abertura e da mensagem.
     VISUAL     Natcorp_Terceiros.css › [C2] (lista de documentos) e [C3] (perguntas)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    lista: '<path d="M9 5h10M9 12h10M9 19h10"/><path d="M4.5 5l1 1 2-2M4.5 12l1 1 2-2M4.5 19l1 1 2-2"/>',
    copiar: '<rect x="8.5" y="8.5" width="11" height="11" rx="2"/><path d="M15.5 8.5V6a1.5 1.5 0 0 0-1.5-1.5H6A1.5 1.5 0 0 0 4.5 6v8A1.5 1.5 0 0 0 6 15.5h2.5"/>',
    zap: '<path d="M4.5 19.5l1.2-3.6A8 8 0 1 1 8.4 18.6z"/><path d="M9 9.5c.3 2.2 2.3 4.4 5 5l1.2-1.3-1.8-1-1 .8a4 4 0 0 1-2-2l.8-1-1-1.8z"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    clipe: '<path d="M15.5 7.5l-6.8 6.8a2 2 0 0 0 2.8 2.8l7-7a4 4 0 0 0-5.6-5.6l-7 7a6 6 0 0 0 8.5 8.5l6.3-6.3"/>',
    predio: '<path d="M4 20V6l7-2v16M11 9h7v11M4 20h16"/><path d="M7 8h1M7 11h1M7 14h1M14 12h1M14 15h1"/>',
    escudo: '<path d="M12 3.5l7 3v5c0 4.5-3 7.8-7 9-4-1.2-7-4.5-7-9v-5z"/><path d="M9 12l2 2 4-4"/>',
    info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5M12 8h.01"/>',
    seta: '<path d="M5 12h14M13 6l6 6-6 6"/>'
  };
  /* PODE MEXER: a pergunta em outras palavras (o texto oficial continua na tela, embaixo).
     Formato:  NOME_DO_ITEM: 'Frase simples?',  */
  var SIMPLES = {
    IND_VINCULO_EMPREG: 'Os funcionários da empresa contratada são registrados?',
    IND_ORDEM_SERVICO: 'Cada funcionário recebeu a ordem de serviço assinada (o papel que diz o que ele vai fazer e os riscos)?',
    IND_CAPACITADO_SERVICO: 'Os funcionários sabem fazer o serviço que foi contratado?',
    IND_ASO: 'Todos têm o exame médico do trabalho (ASO) válido até o fim do serviço?',
    IND_ASO_VIGENTE: 'Quem faz atividade especial tem o exame médico (ASO) certo para ela?',
    IND_CERTIFIC_SERVICO: 'Quem trabalha em altura, em espaço fechado, com eletricidade ou com solda tem o certificado?',
    IND_CERT_SERV_VIGENTE: 'Esses certificados valem até o fim do serviço?',
    IND_TREINAMENTO_EPI: 'Todos foram treinados para usar o equipamento de proteção (EPI)?',
    IND_FICHA_EPI: 'Existe a ficha de entrega de EPI de cada funcionário?',
    IND_FICHA_EPI_ASSINADAS: 'As fichas de EPI estão assinadas pelos funcionários?',
    IND_FICHA_EPI_CA: 'As fichas de EPI têm o número C.A. de cada equipamento?',
    IND_PRODUTO_QUIMICO: 'Vão usar produto químico no serviço?',
    IND_PROD_FISPQ: 'Cada produto químico tem a ficha de segurança (FISPQ)?',
    IND_ALERTAS_MANUSEIO: 'Os funcionários foram avisados dos riscos dos produtos químicos?',
    IND_CERTIFIC_NR18: 'Se for obra, reforma, pintura, limpeza ou manutenção de prédio: todos têm o treinamento NR 18?',
    IND_VISITA_LOCAL: 'Alguém foi ao local antes, para ver os riscos do serviço?',
    IND_ANALISE_RISCO_APR: 'Foi feita a análise de riscos (APR) de todas as atividades no local?',
    IND_VALIDA_RISCO_APR: 'A APR mostra cada etapa do trabalho, os riscos e como se proteger?',
    ID_ASSINATURA_APR: 'A APR está assinada pelos funcionários e pelos responsáveis da empresa contratada?',
    IND_ART_VIGENTE: 'Andaime, balancim ou cadeira suspensa: os equipamentos têm ART válida?',
    IND_TRAB_ALTURA_VIGENTE: 'Trabalho em altura: os pontos onde o cinto é preso têm relatório e ART válidos?'
  };
  /* PODE MEXER: os anexos em palavras simples: é esta a lista que o gestor pede à empresa
     contratada. Formato:  ['NOME_DO_ITEM', 'Nome simples'],  */
  var DOCS = [
    ['ARQ_VINC_EMPREG', 'Registro de trabalho de todos os funcionários'],
    ['ARQ_ORDEM_SERVICO', 'Ordem de serviço assinada de cada funcionário'],
    ['ARQ_ASO', 'ASO (exame médico do trabalho) de todos, assinado'],
    ['ARQ_CERT_SERV_VIGENTE', 'Certificados das atividades especiais (NR35 altura, NR33 espaço confinado, NR10 eletricidade, solda)'],
    ['ARQ_TREINO_EPI', 'Certificado do treinamento de EPI de cada funcionário'],
    ['ARQ_FICHA_EPI', 'Fichas de entrega de EPI assinadas'],
    ['ARQ_FISPQ', 'FISPQ (ficha de segurança) de cada produto químico', 'IND_PRODUTO_QUIMICO'],
    ['ARQ_CERTIF_NR18', 'Treinamento NR 18 de todos os funcionários (obras e manutenção de prédio)'],
    ['ARQ_ASSINATURA_APR', 'APR (análise de riscos) do serviço, assinada'],
    ['ARQ_ART_VIGENTE', 'ART dos equipamentos de acesso (andaime, balancim, cadeira suspensa)'],
    ['ARQ_TRAB_ALTURA_VIGENTE', 'Relatório técnico e ART dos pontos de ancoragem (trabalho em altura)']
  ];
  /* PODE MEXER: as siglas, explicadas onde aparecem. Troque só o 2º e o 3º texto de cada linha. */
  var SIGLAS = [
    [/\bASO'?s?\b/, 'ASO', 'exame médico do trabalho: diz se a pessoa pode fazer o serviço'],
    [/\bNR\s?35\b/, 'NR35', 'regra do trabalho em altura'],
    [/\bNR\s?33\b/, 'NR33', 'regra do trabalho em espaço fechado (tanque, poço, galeria)'],
    [/\bNR\s?10\b/, 'NR10', 'regra do trabalho com eletricidade'],
    [/\bNR\s?18\b/, 'NR 18', 'regra de obras, reformas e manutenção de prédios'],
    [/\bEPI'?s?\b/, 'EPI', 'equipamento de proteção: capacete, luva, bota, óculos, cinto'],
    [/\bC\.A\./, 'C.A.', 'número de aprovação que vem gravado em cada EPI'],
    [/\bFISPQ'?s?\b/, 'FISPQ', 'ficha de segurança do produto químico'],
    [/\bAPR\b/, 'APR', 'análise dos riscos do serviço, feita antes de começar'],
    [/\bART\b/, 'ART', 'documento assinado pelo engenheiro responsável pelo equipamento']
  ];
  /* PODE MEXER: a dica que aparece entre o nome do campo e a caixa. Formato:  ITEM: 'Dica.',  */
  var DICAS = {
    TIPO_ATIVIDADE: 'O tipo de serviço: manutenção, obra, limpeza…',
    DESCRICAO_SERVICO: 'Ex.: pintura da fachada do prédio 2, com andaime, de 10 a 20 de outubro.',
    COD_TERCEIRO: 'A empresa que vai fazer o serviço. Não está na lista? Use "Cadastrar nova empresa".',
    COD_PREST_SERV: 'A pessoa da empresa contratada que cuida dos papéis.',
    NOME_RESP_CONTRATO: 'Quem comanda o serviço no local e assina a APR.',
    NUM_CONTRATO: 'O número que está no contrato com a empresa.'
  };

  /* ═══ [J2] FERRAMENTAS ═════════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo: ler um item do APEX, achar um botão
                pelo texto, saber se um anexo já tem arquivo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('ITEM')         o que o APEX GUARDA no item (o código, ex.: 'S', 'N', 'O')
       txt('ITEM')         o que a PESSOA VÊ no item (o nome da opção escolhida numa lista)
       cont('ITEM')        o bloco inteiro do campo na tela (rótulo + campo)
       temArquivo('ITEM')  se o anexo já tem arquivo escolhido (ou já gravado)
       botaoPorTexto(…)    acha um botão do APEX pelo texto dele
     QUANDO MEXER  Quase nunca.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-ter-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function cont(n) { return document.getElementById(P + n + '_CONTAINER'); }
  function limpo(t) { t = String(t || '').replace(/\s+/g, ' ').trim(); return /^[-–—]?$/.test(t) ? '' : t; }
  function val(n) { if (!document.getElementById(P + n)) return ''; try { return limpo(apex.item(P + n).getValue()); } catch (x) { return ''; } }
  function txt(n) {
    var e = document.getElementById(P + n); if (!e) return '';
    if (e.tagName === 'SELECT') return e.selectedIndex >= 0 && e.value ? limpo(e.options[e.selectedIndex].text) : '';
    if (/^(INPUT|TEXTAREA)$/.test(e.tagName) && e.type !== 'hidden') return limpo(e.value);
    var d = document.getElementById(P + n + '_DISPLAY'); if (d) return limpo(d.textContent);
    return limpo(e.value || e.textContent);
  }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim(); }
  function bonito(t) {
    t = String(t || '').trim();
    if (t && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t)) t = t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); });
    t = t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); });
    return t.replace(/\b(Concluid|Suspensao)(\w*)/g, function (m, r, f) { return ({ Concluid: 'Concluíd', Suspensao: 'Suspensão' })[r] + f; });
  }
  function aVista(e) { return !!(e && (e.offsetParent || e.getClientRects().length)); }
  function nomeDo(c) { return c.id.replace(P, '').replace(/_CONTAINER$/, ''); }
  function rotuloLimpo(c) {
    var l = c && c.querySelector('.t-Form-label'); if (!l) return '';
    var x = l.cloneNode(true); [].forEach.call(x.querySelectorAll('.u-VisuallyHidden, .t-Form-required'), function (s) { s.remove(); });
    return limpo(x.textContent).replace(/\(Valor Necessário\)/i, '').trim();
  }
  function botaoPorTexto(re) {
    return [].filter.call(document.querySelectorAll('button.t-Button, a.t-Button'), function (b) {
      return re.test(b.getAttribute('data-nc-ter-orig') || b.textContent.replace(/\s+/g, ' ').trim());
    })[0];
  }
  function rotuloBotao(b, t) {
    if (!b) return;
    if (!b.getAttribute('data-nc-ter-orig')) b.setAttribute('data-nc-ter-orig', b.textContent.replace(/\s+/g, ' ').trim());
    var l = b.querySelector('.t-Button-label');
    if (l && l.textContent !== t) l.textContent = t;
  }
  function temArquivo(n) {
    var i = document.getElementById(P + n), c = cont(n);
    if (!i || !c) return false;
    if (i.files && i.files.length) return true;
    return !!c.querySelector('.apex-item-group--file > a[href]');   /* já gravado: o link de baixar */
  }

  /* PEDIDO = a requisição já foi gravada (tem número). Muda o que aparece no alto. */
  var PEDIDO = !!(val('COD_REQUISICAO') || val('COD_REQUISICAO_DSP') || val('ROWID'));
  var CRIAR, SALVAR;

  /* ═══ [J3] A ABERTURA E A LISTA DE DOCUMENTOS ══════════════════════════════════════════════
     O QUE FAZ  Num pedido NOVO, acima do formulário: o título "Contratar um serviço de terceiro", uma
                explicação curta e a lista de documentos para pedir à empresa contratada, com os
                botões "Copiar a lista" e "Mandar pelo WhatsApp" (abre o WhatsApp com a mensagem
                escrita; a pessoa escolhe para quem). Cada documento ganha um ✓ quando o anexo entra.
     LÊ DE      a lista DOCS de [J1] e o nome da empresa (COD_TERCEIRO) para a saudação.
     PODE MEXER os textos entre aspas: o título, a explicação e a mensagem de textoDaLista
                ('Olá…', 'Obrigado!'). Para mudar os ITENS da lista, mude DOCS em [J1].
     VISUAL     Natcorp_Terceiros.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var LISTA_BOX;
  function textoDaLista() {
    var emp = semCodigo(txt('COD_TERCEIRO'));
    return 'Olá' + (emp ? ', ' + emp : '') + '! Para liberar o serviço, precisamos destes documentos de TODOS os funcionários que vão trabalhar:\n' +
      docsPedidos().map(function (d, i) { return (i + 1) + '. ' + d[1]; }).join('\n') +
      '\nObrigado!';
  }
  function docsPedidos() {
    return DOCS.filter(function (d) { return cont(d[0]) && !(d[2] && val(d[2]) === 'N'); });
  }
  function montarAbertura() {
    if (PEDIDO) return;
    var host = document.querySelector('.nc-stepper-host') || cont('COD_EMPRESA').closest('.t-Region');
    if (!host) return;
    var a = el('section', 'nc-ter-abertura');
    a.innerHTML = '<div class="nc-ter-abertura-txt"><h1 class="nc-ter-abertura-tit">Contratar um serviço de terceiro</h1>' +
      '<p>Você diz qual serviço, qual empresa vai fazer e comprova que os funcionários dela têm os documentos de segurança. Sem os documentos, o pedido não segue.</p></div>' +
      '<div class="nc-ter-docs"><div class="nc-ter-docs-cab">' + svg(IC.lista) + '<div><h2 class="nc-ter-docs-tit">Antes de começar, peça estes documentos à empresa contratada</h2>' +
      '<p class="nc-ter-docs-sub">Eles vão ser anexados na parte de Segurança.</p></div></div>' +
      '<ol class="nc-ter-docs-lista"></ol>' +
      '<div class="nc-ter-docs-acoes"><button type="button" class="nc-ter-bt nc-ter-bt--claro" data-acao="copiar">' + svg(IC.copiar) + '<span>Copiar a lista</span></button>' +
      '<a class="nc-ter-bt nc-ter-bt--zap" data-acao="zap" target="_blank" rel="noopener" href="#">' + svg(IC.zap) + '<span>Mandar pelo WhatsApp</span></a></div></div>';
    host.parentNode.insertBefore(a, host);
    LISTA_BOX = a;
    a.addEventListener('click', function (e) {
      var b = e.target.closest('[data-acao]'); if (!b) return;
      if (b.getAttribute('data-acao') === 'copiar') { copiar(textoDaLista(), b); return; }
      b.href = 'https://wa.me/?text=' + encodeURIComponent(textoDaLista());   /* abre o WhatsApp com a lista escrita; a pessoa escolhe para quem */
    });
  }
  function copiar(t, b) {
    function feito() { var s = b.querySelector('span'); s.textContent = 'Lista copiada'; b.classList.add('is-ok'); setTimeout(function () { s.textContent = 'Copiar a lista'; b.classList.remove('is-ok'); }, 2200); }
    function velho() { var x = el('textarea'); x.value = t; x.style.position = 'fixed'; x.style.opacity = '0'; document.body.appendChild(x); x.select(); try { document.execCommand('copy'); feito(); } catch (e) { /* sem cópia */ } x.remove(); }
    if (navigator.clipboard && navigator.clipboard.writeText) navigator.clipboard.writeText(t).then(feito, velho); else velho();
  }
  function desenharAbertura() {
    if (!LISTA_BOX) return;
    var ol = LISTA_BOX.querySelector('.nc-ter-docs-lista');
    html(ol, docsPedidos().map(function (d) {
      var ok = temArquivo(d[0]);
      return '<li class="' + (ok ? 'is-ok' : '') + '"><span class="nc-ter-docs-marca">' + (ok ? svg(IC.ok) : '') + '</span><span>' + esc(d[1]) + '</span></li>';
    }).join(''));
  }

  /* ═══ [J4] AS PERGUNTAS DE SEGURANÇA ═══════════════════════════════════════════════════════
     O QUE FAZ  Cada pergunta de rádio (itens IND_… e ID_…) vira um cartão com: o número, a frase
                simples de SIMPLES em negrito, o texto oficial embaixo (menor, sem mudar nada dele),
                as siglas explicadas e "Veio marcado · confira" → "Conferido" quando a pessoa toca
                na resposta. "Não" deixa o cartão amarelo com um aviso; "Não se aplica" explica.
                No cabeçalho de cada bloco: "3 de 5 conferidas" e "1 de 3 anexos".
                Produto químico = Não: as perguntas IND_PROD_FISPQ e IND_ALERTAS_MANUSEIO continuam à
                vista (a página exige "Não" nelas) e o anexo ARQ_FISPQ deixa de contar (04/10).
     PODE MEXER os textos entre aspas: 'Veio marcado · confira', 'Conferido', os avisos de Não e de
                Não se aplica, e a nota 'Sem produto químico: …'.
     CUIDADO    Os códigos das respostas são os do APEX: 'S' (Sim), 'N' (Não), 'O' (Não se aplica).
     VISUAL     Natcorp_Terceiros.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PERGUNTAS = [], CONFERIDAS = {};
  function siglasDe(t) {
    var vistas = {};
    return SIGLAS.filter(function (s) { if (!s[0].test(t) || vistas[s[1]]) return false; vistas[s[1]] = 1; return true; });
  }
  function montarPerguntas() {
    [].forEach.call(document.querySelectorAll('.t-Form-fieldContainer.apex-item-wrapper--radiogroup'), function (c) {
      var n = nomeDo(c);
      if (!/^I(N)?D_/.test(n)) return;
      c.classList.add('nc-ter-perg');
      var oficial = rotuloLimpo(c), num = (/^(\d+)\./.exec(oficial) || [])[1];
      var lc = c.querySelector('.t-Form-labelContainer');
      if (lc && !lc.querySelector('.nc-ter-simples')) {
        var s = el('div', 'nc-ter-simples');
        s.innerHTML = (num ? '<span class="nc-ter-num">' + num + '</span>' : '') +
          '<span class="nc-ter-simples-txt">' + esc(SIMPLES[n] || oficial.replace(/^\d+\.\s*/, '')) + '</span>' +
          '<span class="nc-ter-conf" aria-live="polite"></span>';
        lc.insertBefore(s, lc.firstChild);
        lc.classList.add('nc-ter-lc');
        /* cada sigla é explicada uma vez por bloco (na primeira pergunta em que aparece) */
        var bloco = c.closest('.t-Region'), vistas = bloco.__ncSiglas || (bloco.__ncSiglas = {});
        var sg = siglasDe(oficial).filter(function (x) { if (vistas[x[1]]) return false; vistas[x[1]] = 1; return true; });
        if (sg.length) {
          var g = el('p', 'nc-ter-siglas');
          g.innerHTML = svg(IC.info) + sg.map(function (x) { return '<span><b>' + esc(x[1]) + '</b> = ' + esc(x[2]) + '</span>'; }).join('');
          c.querySelector('.t-Form-inputContainer').appendChild(g);
        }
        var av = el('p', 'nc-ter-aviso');
        av.setAttribute('aria-live', 'polite');
        c.querySelector('.t-Form-inputContainer').appendChild(av);
      }
      PERGUNTAS.push({ n: n, c: c, reg: c.closest('.t-Region') });
      c.addEventListener('change', function () { CONFERIDAS[n] = true; agendar(); });
      c.addEventListener('click', function (e) { if (e.target.closest('label, input')) { CONFERIDAS[n] = true; agendar(); } });
    });
    /* o contador de cada bloco, no cabeçalho dele */
    var regs = [];
    PERGUNTAS.forEach(function (q) { if (q.reg && regs.indexOf(q.reg) < 0) regs.push(q.reg); });
    regs.forEach(function (r) {
      r.classList.add('nc-ter-bloco');
      var h = r.querySelector(':scope > .t-Region-header .t-Region-headerItems--title');
      if (h && !h.querySelector('.nc-ter-placar')) h.appendChild(el('span', 'nc-ter-placar'));
    });
  }
  function desenharPerguntas() {
    var quimico = val('IND_PRODUTO_QUIMICO');
    PERGUNTAS.forEach(function (q) {
      var v = val(q.n), conf = !!CONFERIDAS[q.n];
      classe(q.c, 'is-conferida', conf);
      html(q.c.querySelector('.nc-ter-conf'), conf ? svg(IC.ok) + 'Conferido' : 'Veio marcado · confira');
      var av = q.c.querySelector('.nc-ter-aviso');
      /* 04/10: sem produto químico, a página EXIGE "Não" nas perguntas 14 e 15 (validações
         "Valida P186_IND_PROD_FISPQ " e "…_ALERTAS_MANUSEIOS"): ali o "Não" é o certo, sem aviso */
      var dep = /^IND_(PROD_FISPQ|ALERTAS_MANUSEIO)$/.test(q.n) && quimico === 'N';
      html(av, v === 'N' && q.n !== 'IND_PRODUTO_QUIMICO' && !dep ? 'Você marcou <b>Não</b>. Quem aprova vai ver. Se puder, explique na Observação do pedido.'
        : v === 'O' ? 'Você marcou <b>Não se aplica</b>: este serviço não precisa disso.' : '');
      classe(q.c, 'is-nao', v === 'N' && q.n !== 'IND_PRODUTO_QUIMICO' && !dep);
      /* 04/10: as perguntas 14 e 15 e o anexo da FISPQ NÃO se recolhem mais: a página não os esconde
         e as validações cobram a resposta delas (escondidas, o erro caía num campo fora da vista).
         O anexo só deixa de contar no placar e na barra (classe sem visual nc-ter-dispensado). */
    });
    var fq = cont('ARQ_FISPQ'); if (fq) classe(fq, 'nc-ter-dispensado', quimico === 'N');
    var notaQ = document.getElementById('nc-ter-sem-quimico'), cq = cont('IND_PRODUTO_QUIMICO');
    if (cq && !notaQ) { notaQ = el('p', 'nc-ter-nota'); notaQ.id = 'nc-ter-sem-quimico'; notaQ.textContent = 'Sem produto químico: marque Não nas perguntas da ficha de segurança (FISPQ) e dos avisos sobre os produtos. O anexo da FISPQ não é necessário.'; cq.querySelector('.t-Form-inputContainer').appendChild(notaQ); }
    if (notaQ) notaQ.hidden = quimico !== 'N';
    /* o placar de cada bloco */
    [].forEach.call(document.querySelectorAll('.nc-ter-bloco'), function (r) {
      var qs = PERGUNTAS.filter(function (q) { return q.reg === r && !q.c.classList.contains('nc-ter-recolhida') && aVista(q.c); });
      var feitas = qs.filter(function (q) { return CONFERIDAS[q.n]; }).length;
      var anx = DOCS.filter(function (d) { var c = cont(d[0]); return c && r.contains(c) && !c.classList.contains('nc-ter-recolhida') && !c.classList.contains('nc-ter-dispensado'); });
      var com = anx.filter(function (d) { return temArquivo(d[0]); }).length;
      var pl = r.querySelector('.nc-ter-placar');
      html(pl, (qs.length ? '<span class="' + (feitas === qs.length ? 'is-ok' : '') + '">' + feitas + ' de ' + qs.length + ' conferidas</span>' : '') +
        (anx.length ? '<span class="' + (com === anx.length ? 'is-ok' : '') + '">' + svg(IC.clipe) + com + ' de ' + anx.length + (anx.length === 1 ? ' anexo' : ' anexos') + '</span>' : ''));
    });
  }

  /* ═══ [J5] OS ANEXOS ═══════════════════════════════════════════════════════════════════════
     O QUE FAZ  Cada anexo da lista DOCS ganha, em cima, o nome simples e o estado: "Falta anexar" ou
                "Anexado" (com o nome do arquivo escolhido, encurtado se for longo).
     VISUAL     Natcorp_Terceiros.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarAnexos() {
    DOCS.forEach(function (d) {
      var c = cont(d[0]); if (!c) return;
      c.classList.add('nc-ter-anexo');
      var lc = c.querySelector('.t-Form-labelContainer');
      if (lc && !lc.querySelector('.nc-ter-anexo-nome')) {
        var s = el('div', 'nc-ter-anexo-nome', svg(IC.clipe) + '<span>' + esc(d[1]) + '</span><span class="nc-ter-anexo-est"></span>');
        lc.insertBefore(s, lc.firstChild);
      }
    });
  }
  function desenharAnexos() {
    DOCS.forEach(function (d) {
      var c = cont(d[0]); if (!c) return;
      var ok = temArquivo(d[0]), i = document.getElementById(P + d[0]);
      classe(c, 'is-anexado', ok);
      var nome = i && i.files && i.files[0] ? i.files[0].name : '';
      html(c.querySelector('.nc-ter-anexo-est'), ok ? svg(IC.ok) + (nome ? esc(nome.length > 28 ? nome.slice(0, 25) + '…' : nome) : 'Anexado') : 'Falta anexar');
    });
  }

  /* ═══ [J6] DICAS DOS CAMPOS DO COMEÇO ══════════════════════════════════════════════════════
     O QUE FAZ  Põe a dica de DICAS ([J1]) entre o nome do campo e a caixa, e um texto de exemplo
                (placeholder) na Descrição do serviço.
     PODE MEXER o texto de exemplo 'O que vai ser feito, onde e quando.'
     VISUAL     Natcorp_Terceiros.css › [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* a dica fica ENTRE o nome do campo e a caixa (quem lê pouco lê a dica antes de preencher) — e,
     como as linhas desta página alinham os campos pela base, nada embaixo da caixa empurra o campo */
  function montarDicas() {
    Object.keys(DICAS).forEach(function (n) {
      var c = cont(n); if (!c || c.querySelector('.nc-ter-dica')) return;
      var lc = c.querySelector('.t-Form-labelContainer'); if (!lc) return;
      lc.appendChild(el('p', 'nc-ter-dica', esc(DICAS[n])));
    });
    var d = document.getElementById(P + 'DESCRICAO_SERVICO');
    if (d && !d.getAttribute('placeholder')) d.setAttribute('placeholder', 'O que vai ser feito, onde e quando.');
  }

  /* ═══ [J7] O PRESTADOR POR ASSUNTO ═════════════════════════════════════════════════════════
     O QUE FAZ  Reorganiza a região do Prestador em dois grupos com título: "A empresa contratada"
                (Empresa Contratada, CNPJ, botão Cadastrar nova empresa, E-mail, Representante
                Administrativo) e "O contrato" (Nº do Contrato, Previsão de Início e de Término).
                Também dá ao botão "Cadastrar nova empresa" a mesma altura e base das caixas, e põe
                os nomes dos campos de uma mesma linha na mesma altura.
     PODE MEXER a lista GRUPOS, dentro de montarPrestador:
                  ['Título do grupo', [['NOME_DO_ITEM', largura], …]]
                largura = quantas das 12 colunas da linha o campo ocupa (6 = meia linha, 4 = um terço).
                '6 nc-ter-m-12' = 6 colunas, mas a linha toda em telas médias.
     CUIDADO    '*CADASTRAR' não é um item: é o lugar do botão Cadastrar. Não renomeie.
     VISUAL     Natcorp_Terceiros.css › [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- o Prestador por assunto: a empresa contratada e o contrato ----------
     os campos (com os ids, os nomes e as ações da página) só mudam de lugar dentro da região */
  var CADASTRAR;
  function montarPrestador() {
    var c0 = cont('COD_TERCEIRO'); if (!c0) return;
    var reg = c0.closest('.t-Region'), corpo = reg && reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    if (!corpo || corpo.querySelector('.nc-ter-grupos')) return;
    CADASTRAR = botaoPorTexto(/cadastrar empresas? terceirizadas?/i);
    if (CADASTRAR && !reg.contains(CADASTRAR)) CADASTRAR = null;
    rotuloBotao(CADASTRAR, 'Cadastrar nova empresa');
    var GRUPOS = [
      ['A empresa contratada', [['COD_TERCEIRO', '6 nc-ter-m-12'], ['CNPJ_TERCEIRO', 3], ['*CADASTRAR', 3], ['EMAIL_TERCEIRO', 6], ['COD_PREST_SERV', 6]]],
      ['O contrato', [['NUM_CONTRATO', 4], ['DATA_INICIO_OBRA', 4], ['DATA_FIM_OBRA', 4]]]
    ];
    var box = el('div', 'nc-ter-grupos');
    GRUPOS.forEach(function (g) {
      var itens = g[1].filter(function (x) { return x[0] === '*CADASTRAR' ? CADASTRAR : cont(x[0]); });
      if (!itens.length) return;
      var sec = el('div', 'nc-ter-grupo', '<h3 class="nc-ter-grupo-tit">' + esc(g[0]) + '</h3>');
      var grade = el('div', 'nc-ter-grade');
      itens.forEach(function (x) {
        var cel = el('div', 'nc-ter-cel nc-ter-span-' + x[1]);   /* "6 nc-ter-m-12": 6 colunas, 12 na tela média */
        if (x[0] === '*CADASTRAR') { cel.classList.add('nc-ter-cel--botao'); cel.appendChild(CADASTRAR); } else cel.appendChild(cont(x[0]));
        grade.appendChild(cel);
      });
      sec.appendChild(grade);
      box.appendChild(sec);
    });
    corpo.insertBefore(box, corpo.firstChild);
    /* as linhas antigas ficaram vazias */
    [].forEach.call(corpo.querySelectorAll(':scope > .container .row'), function (r) { if (!r.querySelector('.t-Form-fieldContainer, button')) r.classList.add('nc-ter-recolhida'); });
    alinharBotoes();
    $(window).on('resize apexwindowresized', function () { clearTimeout(alinharBotoes.t); alinharBotoes.t = setTimeout(alinharBotoes, 120); });
  }
  /* o botão que divide a linha com campos fica com a altura da caixa e na mesma base dela
     (medido no vizinho: o que o campo tem embaixo da caixa vira a margem de baixo do botão) */
  function alinharBotoes() {
    igualarRotulos();
    [].forEach.call(document.querySelectorAll('.nc-ter-cel--botao'), function (cel) {
      var b = cel.querySelector('.t-Button'); if (!b) return;
      /* o vizinho é o campo da MESMA linha (a mesma base); sozinho na linha (celular), sem ajuste */
      var rb = cel.getBoundingClientRect();
      var viz = [].filter.call(cel.parentNode.querySelectorAll('.nc-ter-cel:not(.nc-ter-cel--botao) .t-Form-fieldContainer'), function (c) {
        return Math.abs(c.closest('.nc-ter-cel').getBoundingClientRect().bottom - rb.bottom) < 4;
      })[0];
      var i = viz && viz.querySelector('input:not([type=hidden]), select');
      if (!i) { b.style.removeProperty('height'); cel.style.removeProperty('padding-bottom'); return; }
      var caixa = i.closest('.t-Form-itemWrapper') || i, rc = caixa.getBoundingClientRect(), rv = viz.closest('.nc-ter-cel').getBoundingClientRect();
      if (!rc.height) return;
      /* com prioridade: a Skin fixa a altura do botão com !important */
      b.style.setProperty('height', Math.round(rc.height) + 'px', 'important');
      cel.style.setProperty('padding-bottom', Math.max(0, Math.round(rv.bottom - rc.bottom)) + 'px', 'important');
    });
  }
  /* numa linha em que só um campo tem dica, o nome dos outros desceria: a área do nome fica com a
     mesma altura em toda a linha (nomes na mesma altura, caixas na mesma base) */
  function igualarRotulos() {
    var lcs = [].filter.call(document.querySelectorAll('.nc-ter .t-Region:not(.nc-ter-bloco) .t-Form-fieldContainer:not(.nc-ter-perg):not(.nc-ter-anexo) > .t-Form-labelContainer'), aVista);
    lcs.forEach(function (l) { l.style.removeProperty('min-height'); });
    var linhas = [];
    /* a mesma linha = a mesma .row (ou grade) e colunas lado a lado: mesmo topo (colunas esticadas)
       ou mesma base (linhas alinhadas pela base); empilhadas no celular, cada uma fica sozinha */
    lcs.forEach(function (l) {
      var c = l.parentNode, dono = c.closest('.row, .nc-ter-grade'), col = (c.closest('.col, .nc-ter-cel') || c).getBoundingClientRect();
      var ln = linhas.filter(function (x) { return x.dono === dono && (Math.abs(x.topo - col.top) < 4 || Math.abs(x.fundo - col.bottom) < 4); })[0];
      if (!ln) linhas.push(ln = { dono: dono, topo: col.top, fundo: col.bottom, lcs: [] });
      ln.lcs.push(l);
    });
    linhas.forEach(function (ln) {
      if (ln.lcs.length < 2) return;
      var alto = Math.max.apply(null, ln.lcs.map(function (l) { return l.getBoundingClientRect().height; }));
      ln.lcs.forEach(function (l) { l.style.setProperty('min-height', Math.ceil(alto) + 'px', 'important'); });
      /* cada tipo de campo tem o seu espaço entre o nome e a caixa (a lista de seleção tem outro):
         quem ficou com o nome mais baixo ganha altura até os nomes ficarem na mesma linha */
      var topos = ln.lcs.map(function (l) { var r = l.querySelector('.t-Form-label'); return r ? r.getBoundingClientRect().top : 0; });
      var min = Math.min.apply(null, topos);
      ln.lcs.forEach(function (l, k) { var d = Math.round(topos[k] - min); if (d > 0 && d < 40) l.style.setProperty('min-height', Math.ceil(alto + d) + 'px', 'important'); });
    });
  }

  /* ═══ [J8] A BARRA DO PÉ ═══════════════════════════════════════════════════════════════════
     O QUE FAZ  Uma barra presa no pé da tela com o que falta: até 3 campos obrigatórios vazios
                ("+11 campos" quando há mais) e "0 de 11 anexados"; tocar num deles leva ao campo
                (no modo Etapas, abre a etapa certa antes). À direita, "Enviar pedido", que clica o
                botão "Criar" do APEX (que também passa a se chamar "Enviar pedido").
     COMO SABE O QUE É OBRIGATÓRIO  Pelo próprio APEX: campo com "Value Required" ligado.
     PODE MEXER os textos 'Falta:', 'Enviar pedido', 'Tudo preenchido e anexado. Pode enviar.'
     VISUAL     Natcorp_Terceiros.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var BARRA;
  function montarBarra() {
    CRIAR = botaoPorTexto(/^criar$/i);
    SALVAR = botaoPorTexto(/^(salvar|aplicar altera)/i);
    rotuloBotao(CRIAR, 'Enviar pedido');
    if (!CRIAR) return;
    BARRA = el('div', 'nc-ter-barra');
    BARRA.setAttribute('role', 'region');
    BARRA.setAttribute('aria-label', 'Resumo do pedido');
    BARRA.innerHTML = '<div class="nc-ter-barra-txt" aria-live="polite"></div><button type="button" class="nc-ter-bt nc-ter-bt--forte" data-acao="enviar">' + svg(IC.seta) + '<span>Enviar pedido</span></button>';
    document.body.appendChild(BARRA);
    document.body.classList.add('nc-ter-com-barra');
    BARRA.addEventListener('click', function (e) {
      var b = e.target.closest('[data-acao="enviar"]'); if (b) { CRIAR.click(); return; }
      var ir = e.target.closest('[data-ir]'); if (!ir) return;
      var c = cont(ir.getAttribute('data-ir')); if (!c) return;
      irPara(c);
    });
  }
  /* no modo Etapas do stepper do time, a seção de destino pode estar escondida: toca na etapa dela */
  function irPara(c) {
    if (!aVista(c)) {
      var sec = c.closest('.nc-section'), host = document.querySelector('.nc-stepper-host');
      var secs = host ? [].slice.call(host.querySelectorAll('.nc-section')).filter(function (s) { return !s.parentElement.closest('.nc-section'); }) : [];
      var i = secs.indexOf(sec), item = i >= 0 && document.querySelector('.nc-stepper__item[data-index="' + i + '"]');
      if (item) item.click();
    }
    setTimeout(function () {
      c.scrollIntoView({ behavior: 'smooth', block: 'center' });
      var f = c.querySelector('input:not([type=hidden]):not([readonly]), select, textarea, .a-Button--popupLOV');
      if (f) setTimeout(function () { try { f.focus({ preventScroll: true }); } catch (x) { f.focus(); } }, 400);
    }, 60);
  }
  function desenharBarra() {
    if (!BARRA) return;
    var campos = [].filter.call(document.querySelectorAll('.t-Form-fieldContainer.is-required'), function (c) {
      if (c.classList.contains('nc-ter-anexo') || c.classList.contains('nc-ter-recolhida')) return false;
      if (c.style.display === 'none' || c.closest('[style*="display: none"]:not(.nc-section)')) return false;
      var n = nomeDo(c);
      if (/^I(N)?D_/.test(n)) return !val(n);
      return !val(n);
    });
    var anexos = DOCS.filter(function (d) { var c = cont(d[0]); return c && c.classList.contains('is-required') && !c.classList.contains('nc-ter-recolhida') && !c.classList.contains('nc-ter-dispensado') && !temArquivo(d[0]); });
    var total = DOCS.filter(function (d) { var c = cont(d[0]); return c && !c.classList.contains('nc-ter-recolhida') && !c.classList.contains('nc-ter-dispensado'); }).length;
    var pend = campos.slice(0, 3).map(function (c) { return '<button type="button" class="nc-ter-falta" data-ir="' + nomeDo(c) + '">' + esc(rotuloLimpo(c).replace(/^\d+\.\s*/, '').slice(0, 34)) + '</button>'; }).join('');
    var feitos = DOCS.filter(function (d) { var c = cont(d[0]); return c && !c.classList.contains('nc-ter-recolhida') && !c.classList.contains('nc-ter-dispensado') && temArquivo(d[0]); }).length;
    var anx = anexos.length ? '<button type="button" class="nc-ter-falta nc-ter-falta--anexo" data-ir="' + anexos[0][0] + '">' + svg(IC.clipe) + feitos + ' de ' + total + ' anexados</button>' : '';
    /* no celular, uma linha só: o total (o toque leva ao primeiro que falta) */
    var primeiro = campos.length ? nomeDo(campos[0]) : anexos.length ? anexos[0][0] : '';
    var curto = '<button type="button" class="nc-ter-falta nc-ter-falta--total" data-ir="' + primeiro + '">' +
      (campos.length ? 'Faltam ' + campos.length + (campos.length === 1 ? ' campo' : ' campos') : '') + (campos.length && anexos.length ? ' · ' : '') +
      (anexos.length ? feitos + ' de ' + total + ' anexados' : '') + '</button>';
    html(BARRA.querySelector('.nc-ter-barra-txt'), (campos.length || anexos.length)
      ? '<span class="nc-ter-barra-rot">Falta:</span>' + pend + (campos.length > 3 ? '<span class="nc-ter-mais">+' + (campos.length - 3) + ' campos</span>' : '') + anx + curto
      : '<span class="nc-ter-barra-ok">' + svg(IC.ok) + 'Tudo preenchido e anexado. Pode enviar.</span>');
  }

  /* ═══ [J9] PEDIDO GRAVADO ══════════════════════════════════════════════════════════════════
     O QUE FAZ  Quando a requisição já tem número: um cabeçalho com "Pedido nº …", a situação (com
                cor: verde aprovado/concluído, vermelho reprovado, cinza cancelado/suspenso, amarelo
                em andamento), a empresa contratada, as datas, o local, a descrição e quem pediu.
     LÊ DOS ITENS  COD_SIT_REQ, COD_REQUISICAO(_DSP), COD_TERCEIRO, DATA_INICIO_OBRA, DATA_FIM_OBRA,
                COD_LOCAL_TRAB, DESCRICAO_SERVICO, DT_REQUISICAO_DSP, SOLICITANTE.
     VISUAL     Natcorp_Terceiros.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var HERO;
  function montarPedido() {
    if (!PEDIDO) return;
    var host = document.querySelector('.nc-stepper-host') || cont('COD_EMPRESA').closest('.t-Region');
    if (!host) return;
    HERO = el('section', 'nc-ter-hero');
    host.parentNode.insertBefore(HERO, host);
  }
  function desenharPedido() {
    if (!HERO) return;
    var sit = txt('COD_SIT_REQ');
    var tom = /aprov|conclu/i.test(sit) ? 'bom' : /reprov/i.test(sit) ? 'ruim' : /cancel|suspens/i.test(sit) ? 'neutro' : 'espera';
    var n = val('COD_REQUISICAO_DSP') || val('COD_REQUISICAO');
    var emp = bonito(semCodigo(txt('COD_TERCEIRO'))), ini = val('DATA_INICIO_OBRA'), fim = val('DATA_FIM_OBRA');
    var local = bonito(semCodigo(txt('COD_LOCAL_TRAB')));
    html(HERO, '<div class="nc-ter-hero-topo"><p class="nc-ter-hero-n">Pedido nº <b>' + esc(n) + '</b></p>' +
      (sit ? '<span class="nc-ter-sit nc-ter-sit--' + tom + '">' + esc(bonito(sit)) + '</span>' : '') + '</div>' +
      '<h2 class="nc-ter-hero-tit">' + svg(IC.predio) + '<span>' + esc(emp || 'Serviço de terceiro') + '</span></h2>' +
      '<p class="nc-ter-hero-linha">' + (ini ? 'De <b>' + esc(ini) + '</b>' + (fim ? ' a <b>' + esc(fim) + '</b>' : '') : '') + (local ? (ini ? ' · ' : '') + esc(local) : '') + '</p>' +
      (txt('DESCRICAO_SERVICO') ? '<p class="nc-ter-hero-desc">' + esc(txt('DESCRICAO_SERVICO').slice(0, 220)) + '</p>' : '') +
      '<p class="nc-ter-hero-quem">Pedido em <b>' + esc(val('DT_REQUISICAO_DSP')) + '</b>' + (txt('SOLICITANTE') ? ' por <b>' + esc(bonito(semCodigo(txt('SOLICITANTE').split(/\s*\/\s*/).pop()))) + '</b>' : '') + '</p>');
  }

  /* ═══ [J10] O CAMINHO DA APROVAÇÃO ═════════════════════════════════════════════════════════
     O QUE FAZ  Se a página tiver o relatório de aprovadores (coluna APROVADOR), ele vira uma faixa:
                cada aprovador com o estado (aprovou, reprovou, sua vez, aguardando, na fila) e um
                resumo "2 de 3 · aguardando Maria". Quando é a vez de quem está vendo, os botões
                Aprovar/Reprovar do APEX vêm para dentro da faixa.
     LÊ DE      as colunas do relatório: APROVADOR, DATA, STATUS, JUSTIFICATIVA.
     CUIDADO    Se uma dessas colunas for renomeada no relatório do APEX, a faixa não acha os dados.
     VISUAL     Natcorp_Terceiros.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* o caminho da aprovação, quando a página tem o relatório de aprovadores */
  var AP = null, AP_ASSIN = '';
  function nomeAprovador(t) { var m = /^\s*\d+\s*-\s*\d+\s*-\s*(.+)$/.exec(t || ''); return bonito(m ? m[1] : t); }
  function montarAprovacao() {
    if (!PEDIDO) return;
    if (!AP) {
      var th = document.querySelector('table.t-Report-report th#APROVADOR, td[headers="APROVADOR"]');
      var reg = th && th.closest('.t-Region'); if (!reg) return;
      AP = { reg: reg, botoes: [].slice.call(document.querySelectorAll('button.t-Button, a.t-Button')).filter(function (b) { return /^(aprovar|reprovar)$/i.test(b.textContent.trim()); }) };
      reg.classList.add('nc-ter-aprov');
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
      AP.box = el('div', 'nc-ter-ap');
      corpo.insertBefore(AP.box, corpo.firstChild);
    }
    var passos = [].slice.call(AP.reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; }
      var st = c('STATUS');
      return { nome: nomeAprovador(c('APROVADOR')), data: c('DATA'), just: c('JUSTIFICATIVA'), estado: /^r$|reprov|recus/i.test(st) ? 'nao' : /^a$|aprov/i.test(st) ? 'ok' : 'pend' };
    }).filter(function (x) { return x.nome; });
    var n = passos.length, reprovado = passos.some(function (x) { return x.estado === 'nao'; }), atual = -1;
    if (!reprovado) for (var i = 0; i < n; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var cancelado = /cancel|suspens/i.test(txt('COD_SIT_REQ'));
    var bts = AP.botoes.filter(function (b) { return b.style.display !== 'none'; });
    var vez = bts.length > 0 && !cancelado && atual >= 0;   /* só há o que decidir com uma etapa pendente */
    var assin = JSON.stringify([passos, atual, bts.length, cancelado]);
    if (assin === AP_ASSIN) return;
    AP_ASSIN = assin;
    if (!n) { AP.box.innerHTML = ''; return; }
    var ok = passos.filter(function (x) { return x.estado === 'ok'; }).length;
    var resumo = reprovado ? '<b>Reprovado</b>' : cancelado ? '<b>Pedido cancelado</b>' : atual < 0 ? '<b>Aprovado</b>' : vez ? '<b>' + ok + ' de ' + n + '</b> · <b>é a sua vez</b>' : '<b>' + ok + ' de ' + n + '</b> · aguardando <b>' + esc(passos[atual].nome) + '</b>';
    AP.box.className = 'nc-ter-ap nc-ter-ap--' + (reprovado ? 'nao' : cancelado ? 'neutro' : atual < 0 ? 'ok' : vez ? 'vez' : 'pend');
    AP.box.innerHTML = '<p class="nc-ter-ap-rot">Aprovação</p><p class="nc-ter-ap-resumo">' + resumo + '</p><ol class="nc-ter-ap-passos">' + passos.map(function (x, i) {
      var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === atual && !cancelado ? 'is-vez' : 'is-fila';
      var st = x.estado === 'ok' ? (x.data.replace(/\s.*$/, '') || 'Aprovou') : x.estado === 'nao' ? 'Reprovou' : cls === 'is-vez' ? (vez ? 'Sua vez' : 'Aguardando') : 'Na fila';
      return '<li class="nc-ter-ap-p ' + cls + '"><span class="nc-ter-ap-marca" aria-hidden="true"></span><span class="nc-ter-ap-nome">' + esc(x.nome) + '</span><span class="nc-ter-ap-estado">' + esc(st) + '</span></li>';
    }).join('') + '</ol>' + (vez ? '<div class="nc-ter-decisao"><p>Confira os documentos e decida.</p><div class="nc-ter-decisao-botoes"></div></div>' : '');
    var dest = AP.box.querySelector('.nc-ter-decisao-botoes');
    if (dest) bts.forEach(function (b) { dest.appendChild(b); });
  }

  /* ═══ [J11] O MAESTRO: QUANDO CADA PARTE É MONTADA ═════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a página abre: põe a marca nc-ter no corpo da página
                (é dela que o visual depende) e monta cada parte. atualizar() redesenha os estados
                (conferidas, anexos, barra, pedido, aprovação) sempre que algo muda: um campo é
                alterado, uma ação dinâmica traz valores, uma janela fecha, o stepper troca de etapa.
     CUIDADO    Não mude a ordem das chamadas em iniciar(): umas partes dependem das anteriores.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T;
  function agendar() { clearTimeout(T); T = setTimeout(atualizar, 60); }
  function atualizar() {
    desenharPerguntas();
    desenharAnexos();
    desenharAbertura();
    desenharBarra();
    desenharPedido();
    montarAprovacao();
  }
  function iniciar() {
    document.body.classList.add('nc-ter', PEDIDO ? 'nc-ter-modo-pedido' : 'nc-ter-modo-novo');
    montarAbertura();
    montarPedido();
    montarPerguntas();
    montarAnexos();
    montarDicas();
    montarPrestador();
    montarBarra();
    atualizar();
    $(document).on('change', 'input, select, textarea', agendar);
    $(document).on('apexafterrefresh apexafterclosedialog', agendar);
    $(document).on('click', '.nc-stepper__item, .nc-viewtoggle button', function () { setTimeout(agendar, 50); });
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    setTimeout(function () { alinharBotoes(); atualizar(); }, 700);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
