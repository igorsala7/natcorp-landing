/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REEMBOLSOS / LANÇAMENTOS DIVERSOS EM LOTE  —  o "arrumador" (JavaScript)    ║
   ║  App 2060 · Página 7 · lançar um evento da folha para várias pessoas de uma vez        ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ──────────────────────────────────────────────────────────────────
   A página é aberta pela aba "Requisição de Reembolsos" do Painel (app de Reembolsos). O gestor
   lança um EVENTO da folha (a rubrica: reembolso de almoço com cliente, estacionamento, bônus,
   desconto por celular quebrado…) para várias pessoas de uma vez. Primeiro escolhe QUEM
   (empresa, processo e filtros de elegibilidade → "Pesquisar" devolve as matrículas), depois O
   QUE (evento, motivo, valor) e envia. Este arquivo organiza isso assim:
     1. Um cabeçalho com os TRÊS PASSOS (Quem vai receber → O que lançar → Conferir e enviar) e em
        qual a pessoa está.
     2. QUEM: empresa e processo à vista; os outros filtros (filial, sindicato, centro de custo,
        cargo, situação…) em "Filtrar mais". Depois da busca, o passo vira um resumo ("Filial 97 ·
        2 pessoas encontradas") com "Mudar a busca". "Pesquisar" → "Buscar as pessoas".
     3. O QUE: "Tipo de lançamento" (o evento) e o motivo; "Quanto?" com o valor em R$ ou a
        quantidade de horas/dias; as datas que o sistema já decidiu viram uma frase ("Entra na folha
        de junho de 2026, pode lançar até o dia 30, 1 parcela"); "Vale a partir de / até".
     4. CONFERIR: "N de N pessoas marcadas", Marcar todas / Desmarcar todas, e só as colunas que
        têm algum dado.
     5. No pé, a barra: "Você vai lançar [evento] de R$ [valor] para N pessoas (total R$ …)", o que
        falta (o toque leva ao campo) e "Criar Requisicao" como "Enviar lançamentos".
     PEDIDO GRAVADO: cabeçalho com nº, situação e efetivação; a busca resumida; e o caminho da
     aprovação (o mesmo das outras requisições), com Aprovar/Reprovar dentro, para quem aprova.

   ── O QUE ELE NÃO FAZ ───────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco. Continuam sendo do APEX: os itens,
       o "Pesquisar" e o "Criar Requisicao" (submits da página), as caixas de seleção das
       matrículas (f01), as validações e os processos.
     • Só reorganiza a leitura e, nos botões "Marcar todas" / "Desmarcar todas", marca ou
       desmarca as caixas f01 que já existem.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ──────────────────────────────────────────────────────────────────
     App 2060 › Página 7 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Reembolso.js
     (no FIM da lista)
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Reembolso.css.
     Este é o arquivo-FONTE (.src.js). O arquivo que sobe (o .js de mesmo nome, em brand/apex/login)
     é gerado a partir dele pelo gerar-*.py da página: edite ESTE arquivo (manual, parte 2).

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ────────────────────────────────────
   Esta página NÃO usa classes próprias nas regiões. O arquivo se reconhece sozinho:
     • só liga se a página tiver o item …_COD_PROCESSO e mais um destes: …_COD_ELEGIBILIDADE,
       …_EVENTOS ou …_COD_REQ (não testa o número do app nem da página);
     • as regiões são achadas pelos itens que têm dentro: COD_PROCESSO (busca), EVENTOS
       (lançamento), VALOR (quanto), DATA_VIGENCIA (quando), OBSERVACOES (explicação),
       COD_REQ (pedido gravado);
     • a lista de matrículas é o relatório interativo da página, com as caixas f01;
     • os botões "Pesquisar", "Criar Requisicao", "Cancelar", "Voltar", "Aprovar" e "Reprovar"
       são achados pelo TEXTO;
     • a aprovação é o relatório que tem a coluna APROVADOR.
   Os campos, botões e ações dinâmicas continuam os do APEX: aqui eles só MUDAM DE LUGAR.

   ── ÍNDICE: as partes deste arquivo ─────────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Ferramentas ......................... funções pequenas; acentos dos eventos   PODE MEXER
     [J2]  As peças da página e os nomes ....... filtros e nomes dos campos             PODE MEXER
     [J3]  O cabeçalho: os três passos ......... "Quem vai receber → … → Conferir"       PODE MEXER
     [J4]  Passo 1: quem vai receber ........... filtros, resumo da busca              PODE MEXER
     [J5]  Passo 2: o que lançar ............... evento, quanto, frase das datas       PODE MEXER
     [J6]  Passo 3: conferir quem vai receber .. "N de N marcadas", colunas vazias
     [J7]  A barra do pé ....................... a frase do lançamento e o que falta    PODE MEXER
     [J8]  Pedido gravado: o cabeçalho
     [J9]  O caminho da aprovação .............. Aprovar/Reprovar dentro da faixa
     [J10] O maestro ........................... decide QUANDO cada parte é montada    CUIDADO

   ── RECEITAS RÁPIDAS ────────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Buscar as pessoas'  →  'Pesquisar'
     Quero mudar o nome que um campo mostra na tela      → [J2], lista NOMES
     Criei um filtro novo na busca e quero que ele fique em "Filtrar mais"
       → [J2], acrescente o nome do item (sem o prefixo P7_) na lista FILTROS
     Um evento aparece sem acento ("Diferenca Salarial") → [J1], lista ACENTO
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
     P + 'EVENTOS'          junta os textos: vira 'P7_EVENTOS', o nome do item no APEX.
     val(…) / txt(…)        leem o que está num item do APEX (veja [J1]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: estas linhas decidem SE o arquivo roda. Ele roda uma vez só, só dentro do APEX e só
     numa página que tenha …_COD_PROCESSO e um de …_COD_ELEGIBILIDADE / …_EVENTOS / …_COD_REQ. */
  if (window.__ncReembolso || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_COD_PROCESSO_CONTAINER"]');
  if (!achado) return;
  /* P = o começo do nome dos itens desta página (ex.: 'P7_'). Ele é DESCOBERTO sozinho a partir
     do item COD_PROCESSO: se a página for copiada para outro número, nada muda aqui. */
  var P = achado.id.replace(/COD_PROCESSO_CONTAINER$/, '');
  if (!document.getElementById(P + 'COD_ELEGIBILIDADE') && !document.getElementById(P + 'EVENTOS') && !document.getElementById(P + 'COD_REQ')) return;
  window.__ncReembolso = true;

  var $ = apex.jQuery;
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    pessoas: '<circle cx="9" cy="8" r="3.2"/><path d="M3 19.5c.8-3.3 3.2-5 6-5s5.2 1.7 6 5"/><circle cx="17" cy="9" r="2.4"/><path d="M16.5 14.3c2.3.2 4 1.6 4.5 4.2"/>',
    lanc: '<rect x="3.5" y="5.5" width="17" height="13" rx="2.5"/><path d="M3.5 10h17"/><path d="M7.5 14.5h4"/>',
    conferir: '<path d="M9 5.5H6.5a2 2 0 0 0-2 2V19a2 2 0 0 0 2 2h11a2 2 0 0 0 2-2V7.5a2 2 0 0 0-2-2H15"/><rect x="9" y="3.5" width="6" height="4" rx="1.2"/><path d="M8.5 14l2.5 2.5 4.5-5"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    filtro: '<path d="M4 6h16M7 12h10M10 18h4"/>',
    cal: '<rect x="3.5" y="5" width="17" height="15.5" rx="2.5"/><path d="M3.5 10h17M8 3v4M16 3v4"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>'
  };

  /* ═══ [J1] FERRAMENTAS ═════════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('ITEM')         o que o APEX GUARDA no item (o código da opção, o valor digitado)
       txt('ITEM')         o que a PESSOA VÊ no item (o nome da opção escolhida numa lista)
       cont('ITEM')        o bloco inteiro do campo na tela (rótulo + campo)
       regDe('ITEM')       a região do APEX onde o item está
       renomear('ITEM', 'Novo nome')  troca o NOME do campo só na tela (no APEX continua o mesmo)
       bonito(…)           "DIFERENCA SALARIAL" → "Diferença Salarial" (usa a lista ACENTO)
       brl(1234.5)         → "R$ 1.234,50"
     PODE MEXER a lista ACENTO: cada par é  palavra_sem_acento: 'palavra com acento'  (tudo em
                minúsculas). Para acrescentar uma, copie um par inteiro, com a vírgula.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-re-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function cont(n) { return document.getElementById(P + n + '_CONTAINER'); }
  function regDe(n) { var c = cont(n); return c && c.closest('.t-Region'); }
  function limpo(t) { t = String(t || '').replace(/\s+/g, ' ').trim(); return /^[-–—]?$/.test(t) ? '' : t; }
  function val(n) { if (!document.getElementById(P + n)) return ''; try { return limpo(apex.item(P + n).getValue()); } catch (x) { return ''; } }
  /* o que a pessoa VÊ (o texto da lista de pesquisa, não o código) */
  function txt(n) {
    var e = document.getElementById(P + n); if (!e) return '';
    if (e.tagName === 'SELECT') return e.selectedIndex >= 0 && e.value ? limpo(e.options[e.selectedIndex].text) : '';
    if (/^(INPUT|TEXTAREA)$/.test(e.tagName)) return limpo(e.value);
    return limpo(e.textContent);
  }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim(); }
  /* PODE MEXER: os eventos e motivos chegam do cadastro em MAIÚSCULAS e sem acento
     ("DIFERENCA SALARIAL"). Esta lista devolve o acento SÓ NA TELA (o banco não muda). */
  var ACENTO = { diferenca: 'diferença', alimentacao: 'alimentação', refeicao: 'refeição', locacao: 'locação', comissao: 'comissão',
    premiacao: 'premiação', gratificacao: 'gratificação', bonificacao: 'bonificação', remuneracao: 'remuneração', adiantamento: 'adiantamento',
    espontaneo: 'espontâneo', indenizacao: 'indenização', veiculo: 'veículo', combustivel: 'combustível', medico: 'médico', saude: 'saúde',
    ferias: 'férias', salario: 'salário', horario: 'horário', ajuda: 'ajuda', educacao: 'educação', manutencao: 'manutenção', celular: 'celular',
    excecao: 'exceção', reposicao: 'reposição', devolucao: 'devolução', mensalidade: 'mensalidade', estacionamento: 'estacionamento' };
  function bonito(t) {
    t = String(t || '').trim();
    var alta = t && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t);
    if (alta) t = t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); });
    t = t.replace(/[A-Za-zÀ-ÿ]+/g, function (w) {
      var k = w.toLowerCase(); if (!ACENTO[k]) return w;
      return w.charAt(0) !== w.charAt(0).toLowerCase() ? ACENTO[k].charAt(0).toUpperCase() + ACENTO[k].slice(1) : ACENTO[k];
    });
    return t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em|No|Na)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); });
  }
  function num(t) { t = String(t || '').replace(/[^\d,.\-]/g, ''); if (t.indexOf(',') > -1) t = t.replace(/\./g, '').replace(',', '.'); var n = parseFloat(t); return isFinite(n) ? n : NaN; }
  var MOEDA = new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' });
  function brl(n) { return MOEDA.format(n); }
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  function lerData(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function tituloDe(r) { var h = r && r.querySelector(':scope > .t-Region-header .t-Region-title'); return h ? h.textContent.replace(/\s+/g, ' ').trim() : ''; }
  function aVista(e) { return !!(e && (e.offsetParent || e.getClientRects().length)); }
  function renomear(n, t) {
    var l = document.getElementById(P + n + '_LABEL');
    if (!l || l.getAttribute('data-nc-re') === t) return;
    for (var i = 0; i < l.childNodes.length; i++) {
      var x = l.childNodes[i];
      if (x.nodeType === 3 && x.textContent.trim()) { x.textContent = t + ' '; l.setAttribute('data-nc-re', t); return; }
    }
  }
  function botaoPorTexto(re, dentro) {
    return [].filter.call((dentro || document).querySelectorAll('button.t-Button, a.t-Button'), function (b) {
      var o = b.getAttribute('data-nc-re-orig') || b.textContent.replace(/\s+/g, ' ').trim();
      return re.test(o);
    })[0];
  }
  function rotuloBotao(b, t) {
    if (!b) return;
    if (!b.getAttribute('data-nc-re-orig')) b.setAttribute('data-nc-re-orig', b.textContent.replace(/\s+/g, ' ').trim());
    var l = b.querySelector('.t-Button-label');
    if (l && l.textContent !== t) l.textContent = t;
  }

  /* ═══ [J2] AS PEÇAS DA PÁGINA E OS NOMES DOS CAMPOS ════════════════════════════════════════
     O QUE FAZ  Guarda as peças da página que as outras partes usam:
                  PARAM   a região da busca (a do item COD_PROCESSO)
                  EVREG   a região do evento (EVENTOS); LANC, a região "Lançamentos" em volta dela
                  REQREG  a região do pedido gravado (COD_REQ)
                  PEDIDO  o pedido já foi gravado (COD_REQ tem valor)?
                FILTROS são os filtros que ficam escondidos em "Filtrar mais".
                NOMES são os nomes que os campos mostram na tela (só na tela; no APEX não mudam).
     PODE MEXER • NOMES:   NOME_DO_ITEM: 'Nome na tela',   (o item SEM o prefixo P7_)
                • FILTROS: os itens que vão para "Filtrar mais" (entre aspas, separados por vírgula)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PARAM = regDe('COD_PROCESSO');
  var EVREG = regDe('EVENTOS');
  var LANC = EVREG && EVREG.parentElement && EVREG.parentElement.closest('.t-Region') || EVREG;
  var REQREG = regDe('COD_REQ');
  var PEDIDO = !!txt('COD_REQ');
  /* PODE MEXER: os filtros que ficam escondidos em "Filtrar mais" */
  var FILTROS = ['FILIAIS', 'SINDICATOS', 'CLASSIFICACAO_CENTRO_CUSTO', 'CENTRO_CUSTO', 'UNIDADE_ADMINISTRATIVA', 'ATIVIDADE', 'CLASSIFICACAO_CARGO', 'CARGOS', 'SITUACAO'];
  /* PODE MEXER: o nome que cada campo mostra na tela */
  var NOMES = {
    COD_EMPRESA: 'Empresa', COD_PROCESSO: 'Processo da folha', FILIAIS: 'Filial', SINDICATOS: 'Sindicato',
    CLASSIFICACAO_CENTRO_CUSTO: 'Tipo de centro de custo', CENTRO_CUSTO: 'Centro de custo (célula)', UNIDADE_ADMINISTRATIVA: 'Unidade (cliente)',
    ATIVIDADE: 'Atividade', CLASSIFICACAO_CARGO: 'Tipo de cargo', CARGOS: 'Cargo', SITUACAO: 'Situação do colaborador',
    EVENTOS: 'Tipo de lançamento', MOTIVOS: 'Motivo',
    QTD_HORAS: 'Horas', QTD_MINUTOS: 'Minutos', QTD_DIAS: 'Dias', VALOR: 'Valor em R$',
    DATA_VIGENCIA: 'Vigência', DIA_LIMITE_LANCTO: 'Dia limite para lançar', DATA_VIGENCIA_EFETIVACAO: 'Vigência da efetivação',
    DATA_VALIDADE_INICIAL: 'Vale a partir de', DATA_VALIDADE_FINAL: 'Vale até', QTD_PARCELAS: 'Parcelas',
    OBSERVACOES: 'Explique o lançamento (opcional)'
  };
  function matrReg() {
    var ir = document.querySelector('.a-IRR-container');
    var r = ir && ir.closest('.t-Region');
    while (r && !tituloDe(r) && r.parentElement) r = r.parentElement.closest('.t-Region');
    return r;
  }
  function caixas() { return [].slice.call(document.querySelectorAll('input[type=checkbox][name="f01"]')); }

  /* ═══ [J3] O CABEÇALHO: OS TRÊS PASSOS ═════════════════════════════════════════════════════
     O QUE FAZ  Num pedido NOVO, acima da busca: "Lançar reembolso, bônus ou desconto" e os três passos
                (Quem vai receber → O que lançar → Conferir e enviar), com o passo atual marcado e os
                anteriores com ✓. Também põe o número do passo no título de cada região.
     COMO SABE O PASSO  Sem a região do evento na tela → passo 1. Com evento, motivo e valor/quantidade
                preenchidos → passo 3. Senão → passo 2.
     PODE MEXER o título, a frase de baixo e os nomes dos três passos (lista P3, em desenharTopo).
     VISUAL     Natcorp_Reembolso.css › [C2] e [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var TOPO, FILTRO_BTN, RESUMO_BUSCA, FRASE_DATAS, CONTA, BARRA, CRIAR, BUSCA_ABERTA = false;
  function montarTopo() {
    if (PEDIDO || !PARAM) return;
    TOPO = el('section', 'nc-re-topo');
    TOPO.innerHTML = '<div class="nc-re-topo-txt"><h1 class="nc-re-topo-tit">Lançar reembolso, bônus ou desconto</h1>' +
      '<p>Para várias pessoas de uma vez. Siga os três passos.</p></div><ol class="nc-re-passos" data-passos></ol>';
    PARAM.parentNode.insertBefore(TOPO, PARAM);
    var linha = TOPO.closest('.row');
    if (linha && linha.parentNode && TOPO.parentNode.classList.contains('col')) linha.parentNode.insertBefore(TOPO, linha);
  }
  function passoAtual() {
    if (!EVREG) return 1;
    var lanc = !!val('EVENTOS') && !!val('MOTIVOS') && temQuantia();
    return lanc ? 3 : 2;
  }
  function desenharTopo() {
    if (!TOPO) return;
    var a = passoAtual();
    var P3 = [['Quem vai receber', IC.pessoas], ['O que lançar', IC.lanc], ['Conferir e enviar', IC.conferir]];
    html(TOPO.querySelector('[data-passos]'), P3.map(function (p, i) {
      var n = i + 1, st = n < a ? 'feito' : n === a ? 'agora' : 'depois';
      return '<li class="nc-re-passo is-' + st + '"' + (n === a ? ' aria-current="step"' : '') + '><span class="nc-re-passo-n">' + (st === 'feito' ? svg(IC.ok) : n) + '</span><span class="nc-re-passo-t">' + esc(p[0]) + '</span></li>';
    }).join(''));
  }
  /* o título da região ganha o número do passo */
  function titulo(reg, n, t, sub) {
    if (!reg) return;
    reg.classList.add('nc-re-passo-reg');
    var h = reg.querySelector(':scope > .t-Region-header .t-Region-title');
    if (!h || h.getAttribute('data-nc-re')) return;
    h.setAttribute('data-nc-re', '1');
    h.innerHTML = (n ? '<span class="nc-re-reg-n">' + n + '</span>' : '') + '<span class="nc-re-reg-t">' + esc(t) + '</span>';
    if (sub) {
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
      if (corpo) corpo.insertBefore(el('p', 'nc-re-reg-sub', sub), corpo.firstChild);
    }
  }

  /* ═══ [J4] PASSO 1: QUEM VAI RECEBER ═══════════════════════════════════════════════════════
     O QUE FAZ  Na região da busca: título "Quem vai receber?" e explicação; empresa e processo à vista;
                os filtros de FILTROS ([J2]) recolhidos no botão "Filtrar mais…", que diz quantos estão
                em uso (abre sozinho se algum já tem valor).
                "Pesquisar" vira "Buscar as pessoas". Depois da busca (ou num pedido gravado), o passo
                fecha num resumo: etiquetas Empresa · Processo · filtros, "N pessoas encontradas" e
                "Mudar a busca".
     PODE MEXER os textos entre aspas: título, explicação, 'Filtrar mais: …', 'Esconder os filtros',
                'Mudar a busca', 'pessoas encontradas'.
     CUIDADO    O filtro SITUACAO com valor 'T' (todos) não conta como filtro em uso.
     VISUAL     Natcorp_Reembolso.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarBusca() {
    if (!PARAM) return;
    /* no pedido gravado a lista de pessoas já se chama "Quem vai receber": este bloco é o dos parâmetros */
    titulo(PARAM, PEDIDO ? '' : 1, PEDIDO ? 'Parâmetros' : 'Quem vai receber?', PEDIDO ? '' : 'Escolha a empresa e o processo da folha. Para lançar só para um grupo, use "Filtrar mais".');
    PARAM.classList.add('nc-re-busca');
    /* 04/10: o item PERFIL (só leitura) não some mais: quem esconde item é a página */
    FILTROS.forEach(function (n) { var c = cont(n); if (c) c.classList.add('nc-re-filtro'); });
    var corpo = PARAM.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    var grade = corpo && corpo.querySelector(':scope > .container');
    if (grade && !PEDIDO) {
      FILTRO_BTN = el('button', 'nc-re-filtrar', '');
      FILTRO_BTN.type = 'button';
      grade.parentNode.insertBefore(FILTRO_BTN, grade.nextSibling);
      FILTRO_BTN.addEventListener('click', function () { PARAM.__filtros = !PARAM.classList.contains('nc-re-filtros-abertos'); atualizar(); });
    }
    /* depois da busca (ou no pedido gravado): o passo vira um resumo */
    RESUMO_BUSCA = el('div', 'nc-re-busca-resumo');
    if (corpo) corpo.insertBefore(RESUMO_BUSCA, corpo.firstChild);
    RESUMO_BUSCA.addEventListener('click', function (e) { if (e.target.closest('[data-mudar]')) { BUSCA_ABERTA = true; agendar(); } });
    rotuloBotao(botaoPorTexto(/^pesquisar$/i, PARAM), 'Buscar as pessoas');
    var voltar = [].filter.call(PARAM.querySelectorAll('.t-Button'), function (b) { return /back/i.test(b.getAttribute('title') || '') || b.querySelector('.fa-undo-arrow'); })[0];
    if (voltar) { voltar.setAttribute('title', 'Limpar a busca'); voltar.setAttribute('aria-label', 'Limpar a busca'); }
  }
  function desenharBusca() {
    if (!PARAM) return;
    var algumFiltro = FILTROS.some(function (n) { return val(n) && !(n === 'SITUACAO' && val(n) === 'T'); });
    /* abre sozinho quando algum filtro já tem valor; depois do primeiro toque, vale o que a pessoa escolheu */
    var abertos = typeof PARAM.__filtros === 'boolean' ? PARAM.__filtros : algumFiltro;
    classe(PARAM, 'nc-re-filtros-abertos', !!abertos);
    /* escondidos, os filtros continuam valendo: o botão diz quantos estão em uso */
    var emUso = FILTROS.filter(function (n) { return val(n) && !(n === 'SITUACAO' && val(n) === 'T'); }).length;
    if (FILTRO_BTN) html(FILTRO_BTN, svg(IC.filtro) + '<span>' + (abertos ? 'Esconder os filtros' : 'Filtrar mais: filial, sindicato, cargo, centro de custo…') + '</span>' +
      (emUso && !abertos ? '<b class="nc-re-em-uso">' + emUso + (emUso === 1 ? ' filtro em uso' : ' filtros em uso') + '</b>' : ''));
    var fechado = (EVREG || PEDIDO) && !BUSCA_ABERTA;
    classe(PARAM, 'nc-re-fechado', !!fechado);
    RESUMO_BUSCA.hidden = !fechado;
    if (!fechado) return;
    var chips = [['Empresa', semCodigo(txt('COD_EMPRESA'))], ['Processo', semCodigo(txt('COD_PROCESSO'))]];
    FILTROS.forEach(function (n) { var t = txt(n); if (t && !(n === 'SITUACAO' && /^todos$/i.test(t))) chips.push([NOMES[n], semCodigo(t)]); });
    var n = caixas().length;
    html(RESUMO_BUSCA, '<ul class="nc-re-chips">' + chips.filter(function (c) { return c[1]; }).map(function (c) {
      return '<li><span>' + esc(c[0]) + '</span><b>' + esc(bonito(c[1])) + '</b></li>';
    }).join('') + '</ul>' + (!PEDIDO ? '<p class="nc-re-achadas">' + svg(IC.pessoas) + '<b>' + n + (n === 1 ? ' pessoa encontrada' : ' pessoas encontradas') + '</b></p>' +
      '<button type="button" class="nc-re-mudar" data-mudar>' + svg(IC.lapis) + 'Mudar a busca</button>' : ''));
  }

  /* ═══ [J5] PASSO 2: O QUE LANÇAR ═══════════════════════════════════════════════════════════
     O QUE FAZ  Na região "Lançamentos": título "O que você vai lançar?" e as sub-regiões com nomes
                curtos — "O que é" (evento e motivo, com uma dica do que é tipo de lançamento),
                "Quanto" (valor em R$ ou horas/dias, com dica), "Quando" e "Explicação". As datas que
                o sistema já decidiu (só leitura) ganham uma frase em cima: "Entra na folha de junho
                de 2026, pode ser lançado até o dia 30, 1 parcela." (os itens continuam à vista).
                No celular, os campos de número abrem o teclado numérico.
     PODE MEXER os títulos ('O que é', 'Quanto', 'Quando', 'Explicação'), as dicas e o exemplo da
                caixa Explicação.
     VISUAL     Natcorp_Reembolso.css › [C3] (sub-regiões) e [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function temQuantia() { return ['VALOR', 'QTD_HORAS', 'QTD_MINUTOS', 'QTD_DIAS'].some(function (n) { var v = val(n); return v && num(v) !== 0; }); }
  function montarLancamento() {
    if (!EVREG) return;
    titulo(LANC, PEDIDO ? '' : 2, 'O que você vai lançar?', PEDIDO ? '' : 'Vale para todas as pessoas marcadas no passo 3.');
    if (LANC !== EVREG) EVREG.classList.add('nc-re-sub');
    var tEv = EVREG.querySelector(':scope > .t-Region-header .t-Region-title'); if (tEv) tEv.textContent = 'O que é';
    var dEv = EVREG.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    if (dEv && !PEDIDO && !dEv.querySelector('.nc-re-dica')) dEv.appendChild(el('p', 'nc-re-dica', 'O <b>tipo de lançamento</b> é o evento da folha: reembolso (almoço com cliente, estacionamento), bônus, desconto (por exemplo, celular quebrado)…'));
    var VAL = regDe('VALOR');
    if (VAL) {
      VAL.classList.add('nc-re-sub');
      var t = VAL.querySelector(':scope > .t-Region-header .t-Region-title'); if (t) t.textContent = 'Quanto';
      var d = VAL.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
      if (d && !PEDIDO && !d.querySelector('.nc-re-dica')) d.appendChild(el('p', 'nc-re-dica', 'Preencha o que o tipo de lançamento pede: o <b>valor em reais</b> ou a <b>quantidade de horas ou dias</b>. É o valor de <b>cada pessoa</b>.'));
    }
    var i = document.getElementById(P + 'VALOR'); if (i) { i.setAttribute('inputmode', 'decimal'); if (!PEDIDO && !i.getAttribute('placeholder')) i.setAttribute('placeholder', '0,00'); }
    ['QTD_HORAS', 'QTD_MINUTOS', 'QTD_DIAS'].forEach(function (n) { var x = document.getElementById(P + n); if (x) x.setAttribute('inputmode', 'numeric'); });
    var DAT = regDe('DATA_VIGENCIA');
    if (DAT) {
      DAT.classList.add('nc-re-sub', 'nc-re-datas');
      var td = DAT.querySelector(':scope > .t-Region-header .t-Region-title'); if (td) td.textContent = 'Quando';
      var cd = DAT.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
      FRASE_DATAS = el('p', 'nc-re-frase-datas');
      if (cd) cd.insertBefore(FRASE_DATAS, cd.firstChild);
      /* as datas que o sistema já decidiu (só leitura) ganham a frase acima.
         04/10: os itens (Vigência, Dia limite, Efetivação, Parcelas) continuam à vista */
    }
    var OBS = regDe('OBSERVACOES');
    if (OBS) {
      OBS.classList.add('nc-re-sub');
      var to = OBS.querySelector(':scope > .t-Region-header .t-Region-title'); if (to) to.textContent = 'Explicação';
      var o = document.getElementById(P + 'OBSERVACOES');
      if (o && !PEDIDO && !o.getAttribute('placeholder')) o.setAttribute('placeholder', 'Ex.: almoço com cliente no dia 12/06 — nota fiscal no anexo');
    }
  }
  function desenharDatas() {
    if (!FRASE_DATAS) return;
    var vig = lerData(txt('DATA_VIGENCIA') || val('DATA_VIGENCIA')), efe = txt('DATA_VIGENCIA_EFETIVACAO') || val('DATA_VIGENCIA_EFETIVACAO');
    var lim = txt('DIA_LIMITE_LANCTO') || val('DIA_LIMITE_LANCTO'), parc = txt('QTD_PARCELAS') || val('QTD_PARCELAS');
    var partes = [];
    if (vig) partes.push('Entra na folha de <b>' + MESES[vig.getMonth()] + ' de ' + vig.getFullYear() + '</b>');
    if (lim) partes.push('pode ser lançado até o dia <b>' + esc(lim) + '</b>');
    if (parc) partes.push('<b>' + esc(parc) + (+parc === 1 ? ' parcela' : ' parcelas') + '</b>');
    var ef = efe && efe !== (txt('DATA_VIGENCIA') || val('DATA_VIGENCIA')) ? ' (efetivação em ' + esc(efe) + ')' : '';
    FRASE_DATAS.hidden = !partes.length;
    html(FRASE_DATAS, svg(IC.cal) + '<span>' + partes.join(', ') + ef + '.</span>');
  }

  /* ═══ [J6] PASSO 3: CONFERIR QUEM VAI RECEBER ══════════════════════════════════════════════
     O QUE FAZ  A lista de matrículas (o relatório interativo, que no APEX mora DENTRO de
                "Lançamentos") sai do cartão do passo 2 e vem logo depois dele, com o título "Confira
                quem vai receber", "N de N pessoas marcadas" e Marcar todas / Desmarcar todas.
                Colunas sem nenhum dado saem de vista; "Selecionar" vira "Incluir", "Upload" vira
                "Anexo", "Download" vira "Baixar".
     CUIDADO    O relatório interativo tem DUAS tabelas (a do cabeçalho fixo é uma cópia, sem ids): por
                isso a coluna é achada pela POSIÇÃO, não pelo nome.
     PODE MEXER os textos entre aspas: títulos, 'Marcar todas', 'Desmarcar todas', os nomes de coluna.
     VISUAL     Natcorp_Reembolso.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MATR = null;
  function montarConferir() {
    MATR = matrReg();
    if (!MATR) return;
    titulo(MATR, PEDIDO ? '' : 3, PEDIDO ? 'Quem vai receber' : 'Confira quem vai receber', PEDIDO ? '' : 'Todas as pessoas encontradas já vêm marcadas. Desmarque quem não deve receber.');
    MATR.classList.add('nc-re-matr');
    /* no APEX a lista mora DENTRO de "Lançamentos": o passo 3 sai do cartão do passo 2 e vem logo depois */
    if (LANC && LANC !== MATR && LANC.contains(MATR)) LANC.parentNode.insertBefore(MATR, LANC.nextSibling);
    var corpo = MATR.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    CONTA = el('div', 'nc-re-conta');
    if (corpo) corpo.insertBefore(CONTA, corpo.querySelector('.nc-re-reg-sub') ? corpo.querySelector('.nc-re-reg-sub').nextSibling : corpo.firstChild);
    CONTA.addEventListener('click', function (e) {
      var b = e.target.closest('[data-marcar]'); if (!b) return;
      var on = b.getAttribute('data-marcar') === '1';
      caixas().forEach(function (c) { if (!c.disabled && c.checked !== on) { c.checked = on; $(c).trigger('change'); } });
      agendar();
    });
  }
  /* colunas sem nenhum dado (antes de criar, Evento/Motivo/Qtd… vêm "-") saem da vista */
  function colunasVazias() {
    if (!MATR) return;
    /* o IR tem DUAS tabelas (a do cabeçalho fixo é uma cópia, sem ids): a coluna vai pela posição */
    var linhasDados = [].filter.call(MATR.querySelectorAll('.a-IRR-table tr'), function (tr) { return tr.querySelector('td'); });
    var cabecalhos = [].filter.call(MATR.querySelectorAll('.a-IRR-table tr'), function (tr) { return tr.querySelector('th.a-IRR-header') && !tr.querySelector('td'); });
    if (!linhasDados.length || !cabecalhos.length) return;
    var ths = [].slice.call(cabecalhos[0].children);
    ths.forEach(function (th, i) {
      var rot = (th.textContent || '').replace(/\s+/g, ' ').trim();
      var vazia = linhasDados.every(function (tr) { var td = tr.children[i]; return !td || (!limpo(td.textContent) && !td.querySelector('input, a, img, .fa')); });
      cabecalhos.concat(linhasDados).forEach(function (tr) { if (tr.children[i]) classe(tr.children[i], 'nc-re-col-vazia', vazia); });
    });
    [].forEach.call(MATR.querySelectorAll('.a-IRR-table th.a-IRR-header'), function (th) {
      var rot = (th.textContent || '').replace(/\s+/g, ' ').trim();
      var lab = th.querySelector('.a-IRR-headerLabel, .a-IRR-headerLink');
      if (lab && !lab.getAttribute('data-nc-re')) {
        var novo = /^selecionar$/i.test(rot) ? 'Incluir' : /^upload$/i.test(rot) ? 'Anexo' : /^download$/i.test(rot) ? 'Baixar' : '';
        if (novo) { lab.setAttribute('data-nc-re', '1'); lab.textContent = novo; }
      }
    });
    [].forEach.call(MATR.querySelectorAll('td a .fa-cloud-upload, td a .fa-cloud-download'), function (i) {
      var a = i.closest('a'); if (a && !a.getAttribute('aria-label')) a.setAttribute('aria-label', i.classList.contains('fa-cloud-upload') ? 'Anexar comprovante' : 'Baixar o anexo');
    });
  }
  /* as pessoas da lista: as linhas de dados do relatório (no pedido gravado não há caixa de marcar) */
  function pessoasNaLista() {
    if (!MATR) return 0;
    return [].filter.call(MATR.querySelectorAll('.a-IRR-table tr'), function (tr) { return tr.querySelector('td') && !tr.querySelector('td.a-IRR-noDataMsg, .a-IRR-noDataMsg'); }).length;
  }
  function desenharConferir() {
    if (!CONTA) return;
    /* pedido gravado: só quantas pessoas estão nele */
    if (PEDIDO) {
      var np = pessoasNaLista();
      classe(CONTA, 'is-nenhuma', false);
      html(CONTA, '<p class="nc-re-conta-n">' + svg(IC.pessoas) + '<span>' + (np ? '<b>' + np + (np === 1 ? ' pessoa' : ' pessoas') + '</b> neste pedido' : 'Nenhuma pessoa neste pedido') + '</span></p>');
      return;
    }
    var cs = caixas(), n = cs.filter(function (c) { return c.checked; }).length;
    classe(CONTA, 'is-nenhuma', !cs.length || n === 0);
    html(CONTA, cs.length ? '<p class="nc-re-conta-n">' + svg(IC.pessoas) + '<span><b>' + n + ' de ' + cs.length + '</b> ' + (cs.length === 1 ? 'pessoa marcada' : 'pessoas marcadas') + '</span></p>' +
      '<div class="nc-re-conta-bts"><button type="button" data-marcar="1"' + (n === cs.length ? ' disabled' : '') + '>Marcar todas</button><button type="button" data-marcar="0"' + (!n ? ' disabled' : '') + '>Desmarcar todas</button></div>'
      : '<p class="nc-re-conta-n">' + svg(IC.pessoas) + '<span>Nenhuma pessoa encontrada com essa busca. Mude a busca no passo 1.</span></p>');
  }

  /* ═══ [J7] A BARRA DO PÉ ═══════════════════════════════════════════════════════════════════
     O QUE FAZ  Na região dos botões: "Você vai lançar [evento] de R$ [valor] para N pessoas · total
                R$ …", o que falta (Tipo de lançamento, Motivo, Valor ou quantidade, Pelo menos 1
                pessoa; o toque leva ao lugar) ou "Tudo certo. Confira e envie." "Criar Requisicao"
                vira "Enviar lançamentos" e "Cancelar" vira "Cancelar este pedido".
     COMO SABE O QUE FALTA  Pela lista fixa em desenharBarra (não pelo "Value Required" do APEX).
     PODE MEXER os textos entre aspas, inclusive os nomes do "Falta:" (o 1º texto de cada falta.push).
     VISUAL     Natcorp_Reembolso.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarBarra() {
    CRIAR = botaoPorTexto(/^criar requisi/i);
    rotuloBotao(CRIAR, 'Enviar lançamentos');
    rotuloBotao(botaoPorTexto(/^cancelar$/i), 'Cancelar este pedido');
    var reg = (CRIAR || botaoPorTexto(/^voltar$/i) || {}).closest ? (CRIAR || botaoPorTexto(/^voltar$/i)).closest('.t-ButtonRegion, .t-Region') : null;
    if (!reg) return;
    reg.classList.add('nc-re-acoes');
    if (!CRIAR) return;
    reg.classList.add('nc-re-acoes--envia');
    var meio = reg.querySelector('.t-ButtonRegion-col--content') || reg;
    BARRA = el('div', 'nc-re-barra');
    BARRA.setAttribute('aria-live', 'polite');
    meio.insertBefore(BARRA, meio.firstChild);
    BARRA.addEventListener('click', function (e) {
      var b = e.target.closest('[data-ir]'); if (!b) return;
      var alvo = document.getElementById(b.getAttribute('data-ir')); if (!alvo) return;
      alvo.scrollIntoView({ behavior: 'smooth', block: 'center' });
      var i = alvo.querySelector('input:not([type=hidden]):not([disabled]), textarea, .a-Button--popupLOV');
      if (i) setTimeout(function () { if (i.classList.contains('a-Button--popupLOV')) i.click(); else try { i.focus({ preventScroll: true }); } catch (x) { i.focus(); } }, 380);
    });
  }
  function desenharBarra() {
    if (!BARRA) return;
    var marcadas = caixas().filter(function (c) { return c.checked; }).length;
    var falta = [];
    if (!val('EVENTOS')) falta.push(['Tipo de lançamento', P + 'EVENTOS_CONTAINER']);
    if (!val('MOTIVOS')) falta.push(['Motivo', P + 'MOTIVOS_CONTAINER']);
    if (!temQuantia()) falta.push(['Valor ou quantidade', P + 'VALOR_CONTAINER']);
    if (!marcadas) falta.push(['Pelo menos 1 pessoa', MATR ? MATR.id : '']);
    var ev = bonito(semCodigo(txt('EVENTOS'))), v = num(val('VALOR'));
    var quanto = isFinite(v) && v ? ' de <b>' + esc(brl(v)) + '</b>' : ['QTD_HORAS', 'QTD_MINUTOS', 'QTD_DIAS'].map(function (n) { var q = val(n); return q ? q + ' ' + { QTD_HORAS: 'h', QTD_MINUTOS: 'min', QTD_DIAS: q === '1' ? 'dia' : 'dias' }[n] : ''; }).filter(Boolean).join(' ');
    if (quanto && quanto.charAt(0) !== ' ') quanto = ' de <b>' + esc(quanto) + '</b>';
    var frase = ev ? 'Você vai lançar <b>' + esc(ev) + '</b>' + quanto + ' para <b>' + marcadas + (marcadas === 1 ? ' pessoa' : ' pessoas') + '</b>' +
      (isFinite(v) && v && marcadas > 1 ? ' <span class="nc-re-total">· total ' + esc(brl(v * marcadas)) + '</span>' : '') : '';
    html(BARRA, (frase ? '<p class="nc-re-barra-frase">' + frase + '</p>' : '') +
      (falta.length ? '<p class="nc-re-barra-falta"><span>Falta:</span>' + falta.map(function (f) { return '<button type="button" data-ir="' + esc(f[1]) + '">' + esc(f[0]) + '</button>'; }).join('') + '</p>'
        : '<p class="nc-re-barra-ok">' + svg(IC.ok) + 'Tudo certo. Confira e envie.</p>'));
    classe(CRIAR, 'is-pronto', !falta.length);
  }

  /* ═══ [J8] PEDIDO GRAVADO: O CABEÇALHO ═════════════════════════════════════════════════════
     O QUE FAZ  Quando o pedido já tem número: "Pedido nº …", a situação com cor (verde aprovado,
                vermelho reprovado, cinza cancelado/suspenso, amarelo em andamento), a data de criação
                e se já foi efetivado na folha.
     LÊ DOS ITENS  COD_REQ, REQ_SIT_DSP, REQ_DATA, REQ_DATA_SIT, EFETIVACAO.
     VISUAL     Natcorp_Reembolso.css › [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var HERO;
  function montarPedido() {
    if (!PEDIDO || !REQREG) return;
    REQREG.classList.add('nc-re-pedido');
    var corpo = REQREG.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    HERO = el('div', 'nc-re-hero');
    if (corpo) corpo.insertBefore(HERO, corpo.firstChild);
    var sit = semCodigo(txt('REQ_SIT_DSP')) || txt('REQ_SIT_DSP');
    var tom = /aprov|conclu/i.test(sit) ? 'bom' : /reprov/i.test(sit) ? 'ruim' : /cancel|suspens/i.test(sit) ? 'neutro' : 'espera';
    var efe = txt('EFETIVACAO');
    HERO.innerHTML = '<div class="nc-re-hero-topo"><p class="nc-re-hero-n">Pedido nº <b>' + esc(txt('COD_REQ')) + '</b></p><span class="nc-re-sit nc-re-sit--' + tom + '">' + esc(bonito(sit) || 'Situação') + '</span></div>' +
      '<p class="nc-re-hero-quem">Criado em <b>' + esc(txt('REQ_DATA')) + '</b>' + (txt('REQ_DATA_SIT') && txt('REQ_DATA_SIT') !== txt('REQ_DATA') ? ' · situação desde ' + esc(txt('REQ_DATA_SIT')) : '') +
      (efe ? ' · <span class="nc-re-efe">' + (/^s/i.test(efe) ? 'Já efetivado na folha' : 'Ainda não efetivado na folha') + '</span>' : '') + '</p>';
  }

  /* ═══ [J9] O CAMINHO DA APROVAÇÃO ══════════════════════════════════════════════════════════
     O QUE FAZ  O relatório de aprovadores (o que tem a coluna APROVADOR) vem para logo abaixo do
                pedido e vira uma faixa: o resumo ("2 de 3 · aguardando Maria"), "Ver o caminho" com
                cada aprovador e o estado dele, e as justificativas. Quando é a vez de quem está vendo,
                os botões Aprovar/Reprovar do APEX vêm para dentro da faixa.
     LÊ DE      as colunas do relatório: APROVADOR, DATA, STATUS, JUSTIFICATIVA.
     CUIDADO    Se uma dessas colunas for renomeada no relatório do APEX, a faixa não acha os dados.
     VISUAL     Natcorp_Reembolso.css › [C9]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var AP = null, AP_ABERTO = false, AP_ASSIN = '';
  function nomeAprovador(t) { var m = /^\s*\d+\s*-\s*\d+\s*-\s*(.+)$/.exec(t || ''); return bonito(m ? m[1] : t).replace(/(^|\s)(\S)/g, function (x, a, b) { return a + b.toUpperCase(); }).replace(/\s(De|Da|Do|Das|Dos|E)(?=\s)/g, function (x) { return x.toLowerCase(); }); }
  function montarAprovacao() {
    if (!AP) {
      var th = document.querySelector('table.t-Report-report th#APROVADOR, td[headers="APROVADOR"]');
      var reg = th && th.closest('.t-Region');
      if (!reg) return;
      AP = { reg: reg, botoes: [].slice.call(document.querySelectorAll('button.t-Button, a.t-Button')).filter(function (b) { return /^(aprovar|reprovar)$/i.test(b.textContent.trim()) && aVista(b); }) };
      /* 04/10: o lugar original de cada botão, para devolvê-lo quando não for "a sua vez" */
      AP.casa = AP.botoes.map(function (b) { return [b, b.parentNode, b.nextSibling]; });
      reg.classList.add('nc-re-aprov');
      var ancora = REQREG && (REQREG.closest('.row') || REQREG);
      if (ancora && ancora.parentNode) {
        var col = reg.parentElement && reg.parentElement.classList.contains('col') ? reg.parentElement : null;
        ancora.parentNode.insertBefore(reg, ancora.nextSibling);
        if (col && !col.querySelector('.t-Region')) col.classList.add('nc-re-col-sai');
      }
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
      AP.box = el('div', 'nc-re-caminho');
      corpo.insertBefore(AP.box, corpo.firstChild);
      AP.box.addEventListener('click', function (e) { if (e.target.closest('.nc-re-caminho-ver')) { AP_ABERTO = !AP_ABERTO; AP_ASSIN = ''; agendar(); } });
    }
    var passos = [].slice.call(AP.reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; }
      var st = c('STATUS');
      return { nome: nomeAprovador(c('APROVADOR')), data: c('DATA'), just: c('JUSTIFICATIVA'), estado: /^r$|reprov|recus/i.test(st) ? 'nao' : /^a$|aprov/i.test(st) ? 'ok' : 'pend' };
    }).filter(function (x) { return x.nome; });
    var n = passos.length;
    /* 04/10: sem aprovadores a região só sai se não tiver Aprovar/Reprovar (ela guarda os botões) */
    classe(AP.reg, 'nc-re-aprov--vazio', !n && !AP.botoes.length);
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; }), atual = -1;
    if (!reprovado) for (var i = 0; i < n; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var aprovados = passos.filter(function (x) { return x.estado === 'ok'; }).length;
    var cancelado = /cancel|suspens/i.test(txt('REQ_SIT_DSP'));
    var bts = AP.botoes, vez = bts.length > 0 && !cancelado && atual >= 0;   /* só há o que decidir com uma etapa pendente */
    var assin = JSON.stringify([passos, atual, bts.length, cancelado, AP_ABERTO]);
    if (assin === AP_ASSIN) return;
    AP_ASSIN = assin;
    if (!n) { AP.box.innerHTML = ''; return; }
    var quemNao = passos.filter(function (x) { return x.estado === 'nao'; })[0];
    var estado = reprovado ? 'nao' : cancelado ? 'neutro' : atual < 0 ? 'ok' : vez ? 'vez' : 'pend';
    var resumo = reprovado ? '<b>Reprovado</b> por ' + esc(quemNao.nome) : cancelado ? '<b>Pedido cancelado</b> · ' + aprovados + ' de ' + n + ' aprovaram'
      : atual < 0 ? '<b>Aprovado</b> por ' + (n === 1 ? esc(passos[0].nome) : 'todos') : vez ? '<b>' + aprovados + ' de ' + n + '</b> · <b>é a sua vez</b>'
      : '<b>' + aprovados + ' de ' + n + '</b> · aguardando <b>' + esc(passos[atual].nome) + '</b>';
    classe(AP.reg, 'nc-re-ap-aberto', AP_ABERTO);
    AP.box.className = 'nc-re-caminho nc-re-caminho--' + estado;
    AP.box.innerHTML = '<p class="nc-re-caminho-rot">Aprovação</p><div class="nc-re-caminho-cab"><p class="nc-re-caminho-resumo">' + resumo + '</p>' +
        '<button type="button" class="nc-re-caminho-ver" aria-expanded="' + AP_ABERTO + '">' + (AP_ABERTO ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
      '<ol class="nc-re-passos-ap">' + passos.map(function (x, i) {
        var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === atual && !cancelado ? 'is-vez' : 'is-fila';
        var dia = x.data.replace(/\s.*$/, '');
        var st = x.estado === 'ok' ? (dia || 'Aprovou') : x.estado === 'nao' ? 'Reprovou' + (dia ? ' · ' + dia : '') : cls === 'is-vez' ? (vez ? 'Sua vez' : 'Aguardando') : 'Na fila';
        var ic = x.estado === 'ok' ? '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>' : x.estado === 'nao' ? '<path d="M8 8l8 8M16 8l-8 8"/>' : cls === 'is-vez' ? '<path d="M12 8v4l2.5 1.5"/>' : '';
        return '<li class="nc-re-ap ' + cls + '" title="' + esc(x.nome + (x.just ? ': "' + x.just + '"' : '')) + '"><span class="nc-re-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
          '<span class="nc-re-ap-texto"><span class="nc-re-ap-nome">' + esc(x.nome) + '</span><span class="nc-re-ap-estado">' + esc(st) + '</span></span></li>';
      }).join('') + '</ol>' +
      (vez ? '<div class="nc-re-decisao"><p class="nc-re-decisao-txt">Confira o lançamento e decida.</p><div class="nc-re-decisao-botoes"></div></div>' : '') +
      (passos.some(function (x) { return x.just; }) ? '<div class="nc-re-ap-justs">' + passos.filter(function (x) { return x.just; }).map(function (x) {
        return '<blockquote class="nc-re-ap-just' + (x.estado === 'nao' ? ' is-nao' : '') + '"><b>' + esc(x.nome) + ':</b> ' + esc(x.just) + '</blockquote>'; }).join('') + '</div>' : '');
    var dest = AP.box.querySelector('.nc-re-decisao-botoes');
    /* 04/10: fora da "sua vez", Aprovar/Reprovar voltam ao lugar original (não somem com a faixa) */
    if (!dest) AP.casa.forEach(function (c) { if (c[0].parentNode !== c[1]) c[1].insertBefore(c[0], c[2] && c[2].parentNode === c[1] ? c[2] : null); });
    if (dest) bts.slice().sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) { b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-re-reprovar' : 'nc-re-aprovar'); dest.appendChild(b); });
  }

  /* ═══ [J10] O MAESTRO: QUANDO CADA PARTE É MONTADA ═════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a página abre: põe a marca nc-re no corpo da página (é
                dela que o visual depende), troca os nomes dos campos (NOMES) e monta cada parte.
                atualizar() redesenha o que muda (passos, resumo, datas, colunas, contagem, barra,
                aprovação) sempre que um campo é alterado ou o relatório é recarregado.
     CUIDADO    Não mude a ordem das chamadas em iniciar(): umas partes dependem das anteriores.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function nomes() { Object.keys(NOMES).forEach(function (n) { renomear(n, NOMES[n]); }); }
  var T;
  function agendar() { clearTimeout(T); T = setTimeout(atualizar, 60); }
  function atualizar() {
    desenharTopo();
    desenharBusca();
    desenharDatas();
    colunasVazias();
    desenharConferir();
    desenharBarra();
    if (AP || PEDIDO) montarAprovacao();
  }
  function iniciar() {
    document.body.classList.add('nc-re', PEDIDO ? 'nc-re-modo-pedido' : EVREG ? 'nc-re-modo-lancar' : 'nc-re-modo-buscar');
    nomes();
    montarTopo();
    montarBusca();
    montarLancamento();
    montarConferir();
    montarBarra();
    montarPedido();
    atualizar();
    $(document).on('change', 'input, select, textarea', agendar);
    $(document).on('input', '#' + P + 'VALOR, #' + P + 'QTD_HORAS, #' + P + 'QTD_MINUTOS, #' + P + 'QTD_DIAS', agendar);
    $(document).on('apexafterrefresh', agendar);
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    setTimeout(atualizar, 700);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
