/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE DESLIGAMENTO  —  o "arrumador" da tela (JavaScript)              ║
   ║  App 200 · Página 59 · tela em que o gestor pede o desligamento de um colaborador         ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quando a página 59 abre, ele REORGANIZA o que o APEX já desenhou, para o gestor ler e
   preencher com calma:
     • no alto, um cartão com a foto, o nome e os fatos do colaborador, e a ficha da requisição;
     • a faixa da aprovação (quem já aprovou, quem falta);
     • o formulário dividido em 5 perguntas numeradas, cada uma dizendo "Pronto" ou "Falta";
     • ajudas em palavras simples ("93 - Inic Empregador S/Jc" vira "Iniciativa da empresa");
     • a carta de desligamento no lugar certo para cada momento;
     • uma barra no rodapé com Voltar, o que falta e Salvar.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: isso continua sendo do APEX.
     • Não decide nada: lê o que o servidor já decidiu (situação, aprovação, campos travados).
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 59 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Desligamento.js
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Desligamento.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Classes postas nas regiões (Page Designer › clique na região › Appearance › CSS Classes):
     nc-desl-solicitacao   região "Requisição de Desligamento: Nº …"  → vira a ficha da
                           requisição (nº, abertura, situação, quem pediu), à direita no alto
     nc-desl-perfil        região "Colaborador Solicitado"            → vira o cartão do colaborador
     nc-desl-aprovadores   região "Aprovadores"                        → vira a faixa da aprovação
     nc-desl-form          região "Informações para Desligamento"      → vira as 5 perguntas
     nc-desl-acoes         região dos botões Voltar / Salvar           → vira a barra do rodapé
   Se uma classe for apagada no APEX, só aquela parte do desenho deixa de aparecer.
   Os campos, botões e ações dinâmicas continuam os do APEX: aqui eles só MUDAM DE LUGAR.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J2]  Tradução dos códigos ................ "S/Jc" → "sem justa causa" etc.   PODE MEXER
     [J3]  O cartão do colaborador (no alto) ... foto, nome, nome social, fatos, ficha
     [J4]  A faixa da aprovação ................ quem aprovou, quem falta, Aprovar/Reprovar
     [J5]  O formulário em 5 perguntas ......... títulos e ordem das seções         PODE MEXER
     [J6]  As ajudas dentro das perguntas ...... tradução, linha do tempo, reposição  PODE MEXER
     [J7]  A carta de desligamento ............. onde aparece e os passos             PODE MEXER
     [J8]  Campos travados ..................... as notas "Preenchido pelo sistema"  PODE MEXER
     [J9]  O que falta + barra do rodapé ....... "Falta 2 campos", "Tudo preenchido"
     [J10] Contadores de letras ................ "120 de 4.000"
     [J11] Limpeza ............................. esconde linhas e colunas que ficaram vazias
     [J12] O maestro ........................... decide QUANDO cada parte é montada  CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Quem vai sair'  →  'Colaborador'
     Quero mudar o título ou a explicação de uma das 5 perguntas         → [J5], lista SECOES
     Criei um campo no formulário e ele caiu na pergunta errada
       → nada a mudar aqui: mude a ORDEM (Sequence) do campo no Page Designer. Cada pergunta
         começa num campo-marco e vai até o próximo (explicado em [J5]).
     Criei um campo na região "Colaborador Solicitado" e ele não aparece
       → essa região é escondida; o cartão mostra só o que está na lista de [J3].
         Siga a receita "MOSTRAR UM DADO NOVO NO CARTÃO" em [J3].
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp desligamento].
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
     P + 'NOME_SOCIAL'      junta os textos: vira 'P59_NOME_SOCIAL', o nome do item no APEX.
     texto(…) / valor(…)    leem o que está num item do APEX (veja [J1]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: esta linha impede que o arquivo rode duas vezes (se a URL estiver repetida na
     página, por exemplo) e que rode fora do APEX. Não apague. */
  if (window.__ncDesligamento || !window.apex || !window.apex.jQuery) return;
  window.__ncDesligamento = true;

  var $ = apex.jQuery;
  /* O começo do nome de todos os itens desta página. Se a página for copiada para outro
     número (ex.: 159), troque aqui para 'P159_' — e mais nada no arquivo. */
  var P = 'P59_';
  var ILU = {"carta": "data:image/png;base64,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", "caminho": "data:image/png;base64,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"};

  /* ═══ [J1] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo: ler um item do APEX, formatar
                uma data, achar uma região pela classe. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       texto(P + 'ITEM')   o que a PESSOA VÊ no item (o nome da opção escolhida numa lista)
       valor(P + 'ITEM')   o que o APEX GUARDA no item (o código da opção, ex.: 'S' ou 'N')
       caixa('ITEM')       o bloco inteiro do campo na tela (rótulo + campo)
       porClasse('x')      as regiões que têm a classe x no APEX
       dataDe('31/12/2026') transforma o texto numa data;  curto(data) → "31 dez 2026"
     QUANDO MEXER  Quase nunca. Os meses e dias da semana abaixo podem ser traduzidos/mudados.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: como os meses e os dias da semana aparecem escritos na tela */
  var MES3 = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  var SEMANA = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'];
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function vazio(t) { return !t || /^\s*(-\s*selecione\s*-|-\s*todos\s*-|-)\s*$/i.test(t); }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim(); }
  function codigo(t) { var m = String(t || '').match(/^\s*([\w.]+)\s+-\s+/); return m ? m[1] : ''; }
  function bonito(t) { return String(t || '').replace(/(\s)(De|Da|Do|Das|Dos|E|Em|Para|Por|Ou)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); }); }
  function capitalizar(t) { return String(t || '').toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); }); }
  function maiusculas(t) { return t.length > 3 && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t); }
  function iniciais(n) { var p = String(n || '').split(/\s+/).filter(Boolean); return ((p[0] || '').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  function dataDe(t) { var m = String(t || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function curto(d) { return d ? d.getDate() + ' ' + MES3[d.getMonth()] + ' ' + d.getFullYear() : ''; }
  function hoje() { var d = new Date(); return new Date(d.getFullYear(), d.getMonth(), d.getDate()); }
  function dias(a, b) { return Math.round((b - a) / 864e5); }
  /* anos e meses completos entre duas datas */
  function tempo(a, b) {
    var m = (b.getFullYear() - a.getFullYear()) * 12 + (b.getMonth() - a.getMonth());
    if (b.getDate() < a.getDate()) m--;
    return { anos: Math.floor(m / 12), meses: m % 12 };
  }
  function tempoTexto(t) {
    var p = [];
    if (t.anos) p.push(t.anos + (t.anos === 1 ? ' ano' : ' anos'));
    if (t.meses) p.push(t.meses + (t.meses === 1 ? ' mês' : ' meses'));
    return p.length ? p.join(' e ') : 'menos de 1 mês';
  }
  function quando(d) {
    var n = dias(hoje(), d);
    return n === 0 ? 'hoje' : n === 1 ? 'amanhã' : n === -1 ? 'ontem' : n > 1 ? 'daqui a ' + n + ' dias' : 'há ' + (-n) + ' dias';
  }
  /* texto que a pessoa vê no item: a opção da lista, o texto do popup, o valor */
  function texto(id) {
    var e = document.getElementById(id);
    if (!e) return '';
    if (e.tagName === 'SELECT') { var o = e.options[e.selectedIndex]; return o && o.value !== '' && !vazio(o.text) ? o.text.trim() : ''; }
    if (e.tagName === 'IMG') return e.getAttribute('src') || '';
    if (e.type === 'hidden') { var d = document.getElementById(id + '_DISPLAY'); return d ? d.textContent.trim() : ''; }
    var v = String(e.value || '').trim();
    return vazio(v) ? '' : v;
  }
  function valor(id) { var it = apex.item(id); return it && it.node ? String(it.getValue() || '') : ''; }
  function porClasse(cls) { return [].slice.call(document.querySelectorAll('.t-Region.' + cls + ', .t-ButtonRegion.' + cls)); }
  function corpoDe(reg) { return reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg; }
  function caixa(id) { return document.getElementById(P + id + '_CONTAINER'); }
  function botaoPorTexto(raiz, re) { return [].slice.call((raiz || document).querySelectorAll('button.t-Button, a.t-Button')).filter(function (b) { return re.test(b.textContent); })[0] || null; }
  /* escondido pelo APEX (ação dinâmica / condição) */
  function escondido(e, ate) { for (; e && e !== ate && e !== document.body; e = e.parentElement) if (e.style && e.style.display === 'none' || e.hidden) return true; return false; }
  function travado(id) {
    var e = document.getElementById(P + id), c = caixa(id);
    if (!e) return false;
    /* o popup de lista é sempre readonly (abre a janela no clique): travado só com apex_disabled */
    if (c && c.classList.contains('apex-item-wrapper--popup-lov')) return !!(e.disabled || e.classList.contains('apex_disabled'));
    /* sempre booleano: em SELECT, readOnly é undefined — e classList.toggle(c, undefined)
       INVERTE a classe em vez de tirar (era o campo que sumia e voltava a cada mudança) */
    return !!(e.disabled || e.classList.contains('apex_disabled') || e.readOnly && e.tagName !== 'SELECT');
  }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-desl-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    cadeado: '<rect x="5" y="10.5" width="14" height="10" rx="2"/><path d="M8.5 10.5V8a3.5 3.5 0 0 1 7 0v2.5"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    atencao: '<path d="M12 4l9 16H3z"/><path d="M12 10v4.5M12 17.5v.5"/>',
    info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5.5M12 8v.5"/>',
    x: '<path d="M8 8l8 8M16 8l-8 8"/>',
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    caneta: '<path d="M4 20h16M14.5 4.5l5 5L9 20H4v-5z"/>',
    doc: '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4M9.5 12h5M9.5 15.5h5"/>',
    clipe: '<path d="M16.5 7.5l-7 7a2 2 0 0 0 2.8 2.8l7.4-7.4a4 4 0 0 0-5.7-5.7L6.6 11.6a6 6 0 0 0 8.5 8.5l5.4-5.4"/>',
    seta: '<path d="M5 12h14M13 6l6 6-6 6"/>'
  };

  /* ═══ [J2] TRADUÇÃO DOS CÓDIGOS ══════════════════════════════════════════════════════════
     O QUE FAZ  As listas do APEX mostram textos abreviados, como "93 - Inic Empregador S/Jc" e
                "Demissao S/ Justa Causa - (026)". Aqui eles viram frases que qualquer um
                entende: "Iniciativa da empresa, sem justa causa".
     IMPORTANTE Só muda o que aparece na AJUDA ao lado do campo. A lista, o código gravado no
                banco e tudo o que o sistema calcula a partir dele continuam iguais.
     PODE MEXER • a lista ACENTOS: cada par é [palavra sem acento, como deve aparecer].
                  Para acrescentar uma, copie um par inteiro e troque as duas palavras.
                • as frases entre aspas em traduzirSituacao ('Iniciativa da empresa' etc.).
     CUIDADO    Os trechos entre barras, como /aposent/i, são "padrões de busca" (expressões
                regulares): procuram aquele pedaço no texto do APEX. Só troque se souber.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: [/\bpalavra-sem-acento\b/gi, 'palavra com acento'] — copie um par inteiro */
  var ACENTOS = [[/\bdemissao\b/gi, 'demissão'], [/\brescisao\b/gi, 'rescisão'], [/\btermino\b/gi, 'término'], [/\bexperiencia\b/gi, 'experiência'],
    [/\btransferencia\b/gi, 'transferência'], [/\breducao\b/gi, 'redução'], [/\bsuspensao\b/gi, 'suspensão'], [/\bconclusao\b/gi, 'conclusão'], [/\bpedido de demissao\b/gi, 'pedido de demissão']];
  function causa(t) { return /c\/\s*j\.?\s*c\b|c\/\s*justa|com justa/i.test(t) ? 'com justa causa' : /s\/\s*j\.?\s*c\b|s\/\s*justa|sem justa/i.test(t) ? 'sem justa causa' : ''; }
  function traduzirSituacao(t) {
    var s = semCodigo(t), q = '';
    if (/inic\w*\.?\s*(do\s+|da\s+)?(empregador|empresa)/i.test(s)) q = 'Iniciativa da empresa';
    else if (/inic\w*\.?\s*(do\s+)?empregado\b|pedido/i.test(s)) q = 'Pedido do colaborador';
    else if (/acordo|484/i.test(s)) q = 'Acordo entre empresa e colaborador';
    else if (/t[eé]rm\w*|fim\s+(de\s+|do\s+)?contr/i.test(s)) q = 'Término do contrato';
    else if (/falec|[oó]bito/i.test(s)) q = 'Falecimento';
    else if (/aposent/i.test(s)) q = 'Aposentadoria';
    else if (/transf/i.test(s)) q = 'Transferência';
    var c = causa(s);
    if (!q) { var b = s; ACENTOS.forEach(function (a) { b = b.replace(a[0], a[1]); }); return maiusculas(b) ? capitalizar(b) : b; }
    return q + (c ? ', ' + c : '');
  }
  function lerMotivo(t) {
    t = String(t || '').trim();
    var m = t.match(/\(\s*([\w.]+)\s*\)\s*$/), cod = m ? m[1] : codigo(t);
    var n = t.replace(/\s*-?\s*\(\s*[\w.]+\s*\)\s*$/, '');
    n = semCodigo(n).replace(/\bS\/\s*J\.?\s*C\b|\bS\/\s*Justa Causa/gi, 'sem justa causa').replace(/\bC\/\s*J\.?\s*C\b|\bC\/\s*Justa Causa/gi, 'com justa causa');
    ACENTOS.forEach(function (a) { n = n.replace(a[0], a[1]); });
    n = n.toLowerCase();
    return { nome: n.charAt(0).toUpperCase() + n.slice(1), cod: cod };
  }

  /* ═══ [J3] O CARTÃO DO COLABORADOR, NO ALTO DA TELA ═════════════════════════════════════
     O QUE FAZ  Monta o cartão do alto: foto (ou as iniciais), nome completo, nome social,
                matrícula, empresa, um resumo do desligamento e os "fatos" que pesam na decisão
                (tempo de casa, contrato, situação, PCD). À direita, a ficha da requisição:
                número, data de abertura, situação e quem pediu.
     COMO       As regiões nc-desl-perfil e nc-desl-solicitacao são ESCONDIDAS, e os valores
                dos itens delas são lidos e mostrados aqui, organizados.
     LÊ DOS ITENS  P59_MATRICULA_DISPLAY, P59_MAT_SOLICITADO, P59_NOME_SOCIAL, P59_FOTO_COLAB,
                P59_DT_ADMISSAO, P59_IND_CONTRATO, P59_DT_CONTRATO, P59_DT_PRORROG,
                P59_SITUACAO_COLAB, P59_IND_DEF_FIS, P59_COD_EMPRESA, P59_COD_DESLIGAMENTO,
                P59_DT_DESLIGAMENTO, P59_COD_SIT_DESLIGAMENTO, P59_SOLICITANTE
     VISUAL     Natcorp_Desligamento.css › [C2]

     RECEITA: MOSTRAR UM DADO NOVO NO CARTÃO
       Um item novo posto na região "Colaborador Solicitado" fica escondido junto com ela.
       Para que ele apareça como um "fato" do cartão (as linhas com marcador):
         1. Ache abaixo a linha que começa com   if (/^s(im)?$/i.test(texto(P + 'IND_DEF_FIS')))
         2. Logo DEPOIS dela, acrescente uma linha assim (troque NOME_DO_ITEM e o texto):
              if (texto(P + 'NOME_DO_ITEM')) fatos.push(['Texto antes: ' + esc(texto(P + 'NOME_DO_ITEM')), '', '']);
         3. Salve, suba o arquivo para o Workspace Images e recarregue a página.
       O segundo texto entre aspas ('') é a letra miúda ao lado; o terceiro pode ser
       'destaque' ou 'atencao' para dar cor. O nome social foi acrescentado assim (01/10).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MOVIDOS = {};
  function situacaoReq() {
    var t = texto(P + 'COD_SIT_DESLIGAMENTO') || valor(P + 'DESC_SITUACAO');
    var c = valor(P + 'COD_SIT_DESLIGAMENTO');
    var tom = /aprov|conclu/i.test(t) ? 'ok' : /reprov|cancel/i.test(t) ? 'nao' : /susp/i.test(t) ? 'pausa' : 'andamento';
    return { texto: t ? t.charAt(0).toUpperCase() + t.slice(1).toLowerCase() : '', cod: c, tom: tom };
  }
  function lerSolicitante() {
    var partes = texto(P + 'SOLICITANTE').split(/\s+\/\s+/);
    if (partes.length < 2) return { nome: bonito(capitalizar(semCodigo(partes[0] || ''))), cargo: '' };
    var nome = semCodigo(partes[1]);
    return { nome: bonito(maiusculas(nome) ? capitalizar(nome) : nome), cargo: bonito(semCodigo(partes[2] || '')) };
  }
  /* numa linha, o essencial para quem aprova: como, o aviso e o último dia */
  function resumoDesligamento() {
    var sit = texto(P + 'SIT_DESLIG'), av = valor(P + 'AVISO_PREVIO'), du = dataDe(valor(P + 'DT_SIT_DESLIGAMENTO'));
    var partes = [];
    if (sit) partes.push('<b>' + esc(traduzirSituacao(sit)) + '</b>');
    if (av === 'I' || av === 'T') partes.push('aviso ' + (av === 'I' ? 'indenizado' : 'trabalhado'));
    if (du) partes.push('último dia <b>' + curto(du) + '</b> (' + quando(du) + ')');
    return partes.length ? '<p class="nc-desl-resumo-linha">' + partes.join(' <span aria-hidden="true">·</span> ') + '</p>' : '';
  }
  function montarTopo() {
    var sol = porClasse('nc-desl-solicitacao')[0], perfil = porClasse('nc-desl-perfil')[0];
    var ref = sol || perfil;
    if (!ref) return;
    var topo = document.getElementById('nc-desl-topo');
    if (!topo) {
      topo = el('section', 'nc-desl-topo'); topo.id = 'nc-desl-topo';
      topo.setAttribute('aria-label', 'Colaborador e requisição');
      topo.innerHTML = '<div class="nc-desl-quem"><div class="nc-desl-foto" data-slot="foto"></div><div class="nc-desl-quem-txt"><div data-slot="quem"></div>' +
        '<div class="nc-desl-quem-acoes" data-slot="ficha"></div></div></div>' +
        '<aside class="nc-desl-ticket"><div data-slot="ticket"></div><div class="nc-desl-ticket-por" data-slot="por"></div>' +
        '<div class="nc-desl-sit-campo" data-slot="sit" hidden></div></aside>';
      var linha = ref.closest('.row') || ref;
      linha.parentNode.insertBefore(topo, linha);
      topo.addEventListener('click', function (e) {
        var b = e.target.closest('.nc-desl-mudar');
        if (!b) return;
        var campo = topo.querySelector('[data-slot="sit"]');
        campo.hidden = !campo.hidden;
        b.setAttribute('aria-expanded', String(!campo.hidden));
        b.textContent = campo.hidden ? 'Alterar situação' : 'Fechar';
        if (!campo.hidden) { var s = document.getElementById(P + 'COD_SIT_DESLIGAMENTO'); if (s) s.focus(); }
      });
      /* o que sai das regiões do APEX e vem para cá: o botão "dados do colaborador", o do
         solicitante e a lista da situação (que continua sendo o item P59_COD_SIT_DESLIGAMENTO) */
      MOVIDOS.ficha = perfil && perfil.querySelector(':scope > .t-Region-header .t-Button');
      MOVIDOS.solicitante = document.getElementById(P + 'SOLICITANTE_CONTAINER') && document.getElementById(P + 'SOLICITANTE_CONTAINER').querySelector('button, a.t-Button');
      if (!MOVIDOS.solicitante && sol) MOVIDOS.solicitante = sol.querySelector('.t-Button--noLabel, .t-Button--icon');
      MOVIDOS.sit = caixa('COD_SIT_DESLIGAMENTO');
      /* 04/10: a região de onde a lista saiu — se a página a esconde (ação "Hide Region" na
         criação), "Alterar situação" não aparece */
      MOVIDOS.sitReg = MOVIDOS.sit && MOVIDOS.sit.closest('.t-Region');
      if (MOVIDOS.ficha) { MOVIDOS.ficha.classList.add('nc-desl-ficha-bt'); MOVIDOS.ficha.setAttribute('title', 'Dados do colaborador'); topo.querySelector('[data-slot="ficha"]').appendChild(MOVIDOS.ficha); }
      if (MOVIDOS.sit) topo.querySelector('[data-slot="sit"]').appendChild(MOVIDOS.sit);
      if (sol) sol.classList.add('nc-desl-absorvida');
      if (perfil) perfil.classList.add('nc-desl-absorvida');
    }

    /* a foto (a do APEX; sem foto, as iniciais) */
    /* na criação a região do colaborador não existe: o nome vem da própria escolha (Matrícula) */
    var nomeCompleto = texto(P + 'MATRICULA_DISPLAY') || (valor(P + 'MAT_SOLICITADO') ? texto(P + 'MAT_SOLICITADO') : '');
    var mat = codigo(nomeCompleto) || valor(P + 'MAT_SOLICITADO');
    var nome = semCodigo(nomeCompleto);
    nome = bonito(maiusculas(nome) ? capitalizar(nome) : nome);
    /* o nome social (P59_NOME_SOCIAL, novo em 01/10): o campo mora na região do colaborador, que o
       desenho absorve — sem esta linha ele sumia. Como na janela "Dados do Colaborador": o nome
       completo em destaque e o social logo abaixo, quando houver e for outro */
    var social = texto(P + 'NOME_SOCIAL');
    social = social ? bonito(maiusculas(social) ? capitalizar(social) : social) : '';
    if (social && social.toLowerCase() === nome.toLowerCase()) social = '';
    var foto = document.getElementById(P + 'FOTO_COLAB');
    var slotFoto = topo.querySelector('[data-slot="foto"]');
    var src = foto && foto.getAttribute('src');
    if (slotFoto.getAttribute('data-src') !== String(src)) {
      slotFoto.setAttribute('data-src', String(src));
      slotFoto.innerHTML = '<span class="nc-desl-iniciais" aria-hidden="true">' + esc(iniciais(nome) || '?') + '</span>' +
        (src ? '<img alt="" src="' + esc(src) + '">' : '');
      var im = slotFoto.querySelector('img');
      if (im) { im.addEventListener('error', function () { im.remove(); }); im.addEventListener('load', function () { if (im.naturalWidth < 8) im.remove(); }); }
    }

    /* os fatos que pesam na decisão */
    var adm = dataDe(texto(P + 'DT_ADMISSAO'));
    var fatos = [];
    if (adm) fatos.push(['<b>' + esc(tempoTexto(tempo(adm, hoje()))) + '</b> de casa', 'desde ' + curto(adm), '']);
    var contrato = texto(P + 'IND_CONTRATO');
    var indet = /indetermin/i.test(contrato);
    if (contrato) {
      if (indet || !dataDe(texto(P + 'DT_PRORROG')) && !dataDe(texto(P + 'DT_CONTRATO'))) fatos.push(['Contrato ' + esc(contrato.toLowerCase()), '', '']);
      else {
        var fim = dataDe(texto(P + 'DT_PRORROG')) || dataDe(texto(P + 'DT_CONTRATO'));
        fatos.push(['Contrato ' + esc(contrato.toLowerCase()), (dataDe(texto(P + 'DT_PRORROG')) ? 'prorrogado até ' : 'até ') + curto(fim), 'atencao']);
      }
    }
    var sitColab = texto(P + 'SITUACAO_COLAB');
    if (sitColab) fatos.push([esc(bonito(semCodigo(sitColab).replace(/\s*-\s*\d{2}\/\d{2}\/\d{4}\s*$/, ''))), '', '']);
    if (/^s(im)?$/i.test(texto(P + 'IND_DEF_FIS'))) fatos.push(['Pessoa com deficiência', 'conta na cota legal', 'destaque']);
    var emp = semCodigo(texto(P + 'COD_EMPRESA_DISPLAY') || texto(P + 'COD_EMPRESA'));
    /* criação, antes de escolher o colaborador: o alto diz o que fazer, sem dados vazios */
    /* criação: uma faixa baixa (sem foto nem ficha da requisição, que ainda não existem) */
    topo.classList.toggle('nc-desl-topo--criacao', !gravada());
    topo.classList.toggle('nc-desl-topo--novo', !nome);
    if (!nome) {
      topo.querySelector('[data-slot="quem"]').innerHTML = '<h2 class="nc-desl-nome">Novo desligamento</h2><p class="nc-desl-meta">Comece escolhendo a empresa e o colaborador em "Quem vai sair".</p>';
      if (!src) slotFoto.innerHTML = '<span class="nc-desl-iniciais">' + svg(IC.pessoa, 'nc-desl-ic nc-desl-ic--foto') + '</span>';
    } else topo.querySelector('[data-slot="quem"]').innerHTML =
      '<h2 class="nc-desl-nome">' + esc(nome) + '</h2>' +
      (social ? '<p class="nc-desl-social">Nome social: <b>' + esc(social) + '</b></p>' : '') +
      '<p class="nc-desl-meta">' + [mat ? 'Matrícula ' + esc(mat) : '', emp ? esc(bonito(emp)) : ''].filter(Boolean).join(' <span aria-hidden="true">·</span> ') + '</p>' +
      resumoDesligamento() +
      '<ul class="nc-desl-fatos">' + fatos.map(function (f) {
        return '<li class="' + (f[2] ? 'nc-desl-fato--' + f[2] : '') + '">' + (f[2] === 'atencao' ? svg(IC.atencao) : '') + '<span>' + f[0] + (f[1] ? ' <small>' + esc(f[1]) + '</small>' : '') + '</span></li>';
      }).join('') + '</ul>';

    /* a ficha da requisição */
    var st = situacaoReq();
    var nReq = valor(P + 'COD_DESLIGAMENTO') || texto(P + 'COD_DESLIGAMENTO');
    var aberta = dataDe(texto(P + 'DT_DESLIGAMENTO') || valor(P + 'DT_DESLIGAMENTO'));
    var sit = document.getElementById(P + 'COD_SIT_DESLIGAMENTO');
    /* 04/10: escondido(sit) contava o [hidden] da própria gaveta (data-slot="sit") e o botão
       "Alterar situação" nunca aparecia — a situação, que a página libera (1, 5, 6), ficava
       inalcançável. Agora só conta o que a PÁGINA esconde/trava. */
    var slotSit = topo.querySelector('[data-slot="sit"]');
    var podeMudar = sit && !sit.disabled && !escondido(sit, slotSit) && !(MOVIDOS.sitReg && escondido(MOVIDOS.sitReg));
    topo.querySelector('[data-slot="ticket"]').innerHTML =
      (nReq ? '<p class="nc-desl-ticket-n">Requisição <b>nº ' + esc(nReq) + '</b></p>' : '<p class="nc-desl-ticket-n nc-desl-ticket-n--nova">Nova requisição</p>') +
      (aberta ? '<p class="nc-desl-ticket-data">aberta em ' + curto(aberta) + '</p>' : '') +
      (st.texto ? '<p class="nc-desl-sit nc-desl-sit--' + st.tom + '"><span aria-hidden="true"></span>' + esc(st.texto) + '</p>' : '') +
      (podeMudar ? '<button type="button" class="nc-desl-mudar" aria-expanded="' + !topo.querySelector('[data-slot="sit"]').hidden + '">' + (topo.querySelector('[data-slot="sit"]').hidden ? 'Alterar situação' : 'Fechar') + '</button>' : '');
    var sl = lerSolicitante();
    var por = topo.querySelector('[data-slot="por"]');
    var porTxt = por.querySelector('.nc-desl-por-txt');
    if (!porTxt) { porTxt = el('p', 'nc-desl-por-txt'); por.appendChild(porTxt); if (MOVIDOS.solicitante) { MOVIDOS.solicitante.classList.add('nc-desl-solic-bt'); MOVIDOS.solicitante.setAttribute('title', 'Dados de quem pediu'); por.appendChild(MOVIDOS.solicitante); } }
    porTxt.innerHTML = sl.nome ? 'Pedida por <b>' + esc(sl.nome) + '</b>' + (sl.cargo ? '<br><small>' + esc(sl.cargo) + '</small>' : '') : '';
    por.hidden = !sl.nome;
  }

  /* ═══ [J4] A FAIXA DA APROVAÇÃO ══════════════════════════════════════════════════════════
     O QUE FAZ  Transforma o relatório "Aprovadores" numa faixa horizontal: cada aprovador com
                um sinal (aprovou ✓, reprovou ✕, aguardando, na fila) e um resumo do tipo
                "2 de 3 · aguardando Maria". Os botões Aprovar/Reprovar do APEX vêm para dentro
                da faixa. É o mesmo desenho da Requisição de Pessoal.
     LÊ DE      as colunas do relatório da região nc-desl-aprovadores, pelos nomes das colunas:
                APROVADOR, DATA, STATUS, JUSTIFICATIVA.
     CUIDADO    Se uma dessas colunas for renomeada no relatório do APEX, a faixa não acha
                os dados. Renomeie também aqui (procure  headers="  logo abaixo).
     PODE MEXER os textos entre aspas: 'Aprovação', 'Ver o caminho', 'Aguardando', 'Na fila'…
     VISUAL     Natcorp_Desligamento.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function nomeAprovador(t) {
    var m = String(t || '').match(/^\s*(\d+)\s*-\s*(\d+)\s*-\s*(.+)$/);
    if (m) return { nome: bonito(capitalizar(m[3].trim())), meta: 'Empresa ' + m[1] + ' · matrícula ' + m[2], pessoa: true };
    var n = String(t || '').trim();
    return { nome: maiusculas(n) ? capitalizar(n) : n, meta: '', pessoa: false };
  }
  function lerAprovacao(reg) {
    reg = reg || porClasse('nc-desl-aprovadores')[0];
    if (!reg) return null;
    var passos = [].slice.call(reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      var c = function (h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? td.textContent.replace(/\s+/g, ' ').trim() : ''; };
      var link = tr.querySelector('a[href*="dialog"], a[href^="javascript"]') || tr._ncLink || null;
      if (link) tr._ncLink = link;
      var st = c('STATUS');
      return { quem: nomeAprovador(c('APROVADOR')), data: c('DATA').replace(/^-$/, ''), status: st, just: c('JUSTIFICATIVA').replace(/^-$/, ''), link: link,
        estado: /reprov|recus|negad/i.test(st) ? 'nao' : /aprov/i.test(st) ? 'ok' : 'pend' };
    });
    var atual = -1;
    for (var i = 0; i < passos.length; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; });
    return { reg: reg, passos: passos, atual: reprovado ? -1 : atual, reprovado: reprovado, aprovados: passos.filter(function (x) { return x.estado === 'ok'; }).length,
      botoes: [].slice.call(reg.querySelectorAll('button, a.t-Button')).filter(function (b) { return /aprovar|reprovar/i.test(b.textContent) && !b.closest('.nc-desl-caminho'); }).concat(reg._ncBotoes || []) };
  }
  var apAberto = false;
  function montarAprovadores() {
    porClasse('nc-desl-aprovadores').forEach(function (reg) {
      var topo = document.getElementById('nc-desl-topo');
      if (topo && reg.previousElementSibling !== topo) topo.parentNode.insertBefore(reg, topo.nextSibling);
      var ap = lerAprovacao(reg);
      var corpo = corpoDe(reg);
      reg.hidden = !ap.passos.length;
      var box = corpo.querySelector(':scope > .nc-desl-caminho');
      if (!ap.passos.length) { if (box) box.remove(); return; }
      if (!box) {
        box = el('div', 'nc-desl-caminho'); corpo.insertBefore(box, corpo.firstChild);
        box.addEventListener('click', function (e) { if (e.target.closest('.nc-desl-caminho-ver')) { apAberto = !apAberto; agendar(); } });
      }
      var bts = ap.botoes.filter(function (b, i, a) { return a.indexOf(b) === i; });
      reg._ncBotoes = bts;
      var total = ap.passos.length;
      /* requisição cancelada / reprovada no meio do caminho: ninguém mais está "aguardando" */
      var sitR = situacaoReq();
      if (sitR.tom === 'nao' && !ap.reprovado) ap.atual = -2;
      var quemNao = ap.passos.filter(function (x) { return x.estado === 'nao'; })[0];
      var resumoTxt = ap.reprovado ? '<b>Reprovada</b> por ' + esc(quemNao.quem.nome) : ap.atual === -2 ? '<b>Interrompida</b> · requisição ' + esc(sitR.texto.toLowerCase()) : ap.atual < 0 ? '<b>Aprovada</b> por todos' :
        '<b>' + ap.aprovados + ' de ' + total + '</b> · aguardando <b>' + esc(ap.passos[ap.atual].quem.nome) + '</b>';
      var estadoGeral = ap.reprovado ? 'nao' : ap.atual === -2 ? 'fim' : ap.atual < 0 ? 'ok' : bts.length ? 'vez' : 'pend';
      reg.classList.toggle('nc-desl-ap-aberto', !!(apAberto));
      box.className = 'nc-desl-caminho nc-desl-caminho--' + estadoGeral;
      box.innerHTML =
        '<p class="nc-desl-caminho-rot">Aprovação</p><div class="nc-desl-caminho-cab"><p class="nc-desl-caminho-resumo">' + resumoTxt + '</p>' +
          '<button type="button" class="nc-desl-caminho-ver" aria-expanded="' + apAberto + '">' + (apAberto ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
        '<ol class="nc-desl-passos-ap">' + ap.passos.map(function (x, i) {
          var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === ap.atual ? 'is-vez' : 'is-fila';
          var st = x.estado === 'ok' ? (x.data ? x.data.replace(/\s.*$/, '') : 'Aprovou') : x.estado === 'nao' ? 'Reprovou' : ap.atual === -2 ? 'Não chegou' : i === ap.atual ? 'Aguardando' : 'Na fila';
          var ic = x.estado === 'ok' ? IC.ok : x.estado === 'nao' ? IC.x : i === ap.atual ? '<path d="M12 8v4l2.5 1.5"/>' : '';
          var dica = x.quem.nome + (x.quem.meta ? ' (' + x.quem.meta + ')' : '') + ' — ' + (x.estado === 'ok' ? 'aprovou' + (x.data ? ' em ' + x.data : '') : x.estado === 'nao' ? 'reprovou' + (x.data ? ' em ' + x.data : '') : i === ap.atual ? 'aguardando a aprovação' : 'na fila') + (x.just ? ': "' + x.just + '"' : '');
          return '<li class="nc-desl-ap ' + cls + '" data-i="' + i + '" title="' + esc(dica) + '"><span class="nc-desl-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
            '<span class="nc-desl-ap-texto"><span class="nc-desl-ap-nome">' + esc(x.quem.nome) + '</span><span class="nc-desl-ap-estado">' + esc(st) + '</span></span></li>';
        }).join('') + '</ol>' +
        (bts.length ? '<div class="nc-desl-decisao-botoes" aria-label="Sua decisão"></div>' : '') +
        (quemNao && quemNao.just ? '<blockquote class="nc-desl-ap-just"><b>' + esc(quemNao.quem.nome) + ' reprovou:</b> ' + esc(quemNao.just) + '</blockquote>' : '');
      ap.passos.forEach(function (x, i) {
        if (!x.link || !x.quem.pessoa) return;
        var li = box.querySelector('.nc-desl-ap[data-i="' + i + '"] .nc-desl-ap-texto');
        x.link.classList.add('nc-desl-ap-link'); x.link.setAttribute('title', 'Ver dados de ' + x.quem.nome); x.link.setAttribute('aria-label', 'Ver dados de ' + x.quem.nome);
        li.appendChild(x.link);
      });
      var dest = box.querySelector('.nc-desl-decisao-botoes');
      if (dest) bts.sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) { b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-desl-reprovar' : 'nc-desl-aprovar'); dest.appendChild(b); });
    });
  }
  function aprovacaoCompleta() {
    var st = situacaoReq();
    if (/^(2|5)$/.test(st.cod) || /aprovad|conclu/i.test(st.texto)) return true;
    var ap = lerAprovacao();
    return !!(ap && ap.passos.length && ap.atual < 0 && !ap.reprovado);
  }

  /* ═══ [J5] O FORMULÁRIO EM 5 PERGUNTAS ═══════════════════════════════════════════════════
     O QUE FAZ  Divide os campos da região nc-desl-form em 5 seções numeradas ("1 Quem vai
                sair", "2 Como vai ser"…), cada uma com título e explicação curta.
     COMO       Os campos são lidos NA ORDEM DO APEX (a Sequence do Page Designer). Cada seção
                começa num campo-"marco" e vai até o próximo marco:
                  1 Quem vai sair ....... do primeiro campo até antes de SIT_DESLIG
                  2 Como vai ser ........ de SIT_DESLIG até antes de DT_COMUNICACAO
                  3 Datas e aviso ....... de DT_COMUNICACAO até antes de HAVERA_REP
                  4 E depois ............ de HAVERA_REP até antes de JUSTIFICATIVA
                  5 Por que ............. de JUSTIFICATIVA até o fim
                Por isso, um CAMPO NOVO cai sozinho na seção do trecho onde for posto.
                Para mudá-lo de seção, mude a ordem dele no Page Designer, não este arquivo.
     PODE MEXER a lista SECOES logo abaixo:
                  titulo  → o título da seção        sub → a frase de explicação embaixo
                  marco   → o campo que abre a seção (o nome do item SEM o "P59_")
     CUIDADO    Não mude o "id" ('quem', 'como'…): o visual e outras partes usam esse nome.
     VISUAL     Natcorp_Desligamento.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: títulos, explicações e campos-marco das 5 seções */
  var SECOES = [
    { id: 'quem', titulo: 'Quem vai sair', sub: 'A empresa e o colaborador. Os dados dele aparecem no alto da página.' },
    { id: 'como', marco: 'SIT_DESLIG', titulo: 'Como vai ser o desligamento', sub: 'O tipo, o motivo e o aviso prévio. O sistema completa o que depende deles.' },
    { id: 'quando', marco: 'DT_COMUNICACAO', titulo: 'Datas e cumprimento do aviso', sub: 'Quando o colaborador fica sabendo e qual é o último dia de trabalho.' },
    { id: 'depois', marco: 'HAVERA_REP', titulo: 'E depois', sub: 'A vaga que fica e o futuro desta pessoa na empresa.' },
    { id: 'porque', marco: 'JUSTIFICATIVA', titulo: 'Por que', sub: 'O que levou à decisão. Os aprovadores leem este texto.' }
  ];
  /* requisição já gravada (edição) ou nova (criação): na criação nada some da tela */
  function gravada() { return !!(valor(P + 'COD_DESLIGAMENTO') || valor(P + 'ROWID')); }
  var FORM = null, BT = {};
  function montarSecoes() {
    FORM = porClasse('nc-desl-form')[0];
    if (!FORM) return false;
    var corpo = corpoDe(FORM);
    if (corpo.querySelector(':scope > .nc-desl-secoes')) return true;
    /* os botões do cabeçalho vão para onde a decisão acontece */
    BT.gerar = botaoPorTexto(FORM, /imprim/i);
    BT.anexar = botaoPorTexto(FORM, /anex/i);
    BT.vaga = botaoPorTexto(FORM, /requisi[cç][aã]o de pessoal/i);
    var box = el('div', 'nc-desl-secoes');
    /* os campos do formulário, na ordem do APEX, antes de qualquer mudança de lugar */
    var ordem = [].slice.call(corpo.querySelectorAll('.t-Form-fieldContainer')).filter(function (k) { return k.closest('.t-Region') === FORM; });
    corpo.insertBefore(box, corpo.firstChild);
    var destino = {};
    SECOES.forEach(function (s, i) {
      var sec = el('section', 'nc-desl-secao nc-desl-secao--' + s.id);
      sec.id = 'nc-desl-' + s.id;
      sec.setAttribute('aria-labelledby', 'nc-desl-' + s.id + '-t');
      sec.innerHTML = '<header class="nc-desl-secao-cab"><span class="nc-desl-num" aria-hidden="true">' + (i + 1) + '</span>' +
        '<div class="nc-desl-secao-tit"><h3 id="nc-desl-' + s.id + '-t">' + esc(s.titulo) + '</h3><p>' + esc(s.sub) + '</p></div>' +
        '<span class="nc-desl-secao-estado" data-slot="estado"></span></header>' +
        '<div class="nc-desl-secao-corpo"><div class="nc-desl-campos"></div><div class="nc-desl-extra" data-slot="extra"></div></div>';
      destino[s.id] = sec.querySelector('.nc-desl-campos');
      box.appendChild(sec);
    });
    var marcos = {};
    SECOES.forEach(function (s) { if (s.marco) marcos[s.marco] = s.id; });
    var atualSec = SECOES[0].id;
    ordem.forEach(function (k) {
      var c = k.id.replace(/_CONTAINER$/, '').replace(P, '');
      if (marcos[c]) atualSec = marcos[c];
      k.classList.add('nc-desl-campo', 'nc-desl-campo--' + c.toLowerCase().replace(/_/g, '-'));
      destino[atualSec].appendChild(k);
    });
    FORM.classList.add('nc-desl-form--pronto');

    /* 3 · a vaga que fica: o botão "Criar Requisição de Pessoal" ao lado da pergunta */
    var rep = caixa('HAVERA_REP');
    if (rep && BT.vaga) {
      var junto = el('div', 'nc-desl-reposicao');
      rep.parentNode.insertBefore(junto, rep);
      junto.appendChild(rep);
      var acao = el('div', 'nc-desl-reposicao-acao');
      acao.appendChild(BT.vaga);
      acao.appendChild(el('p', 'nc-desl-reposicao-nota', 'Abre a Requisição de Pessoal já ligada a este desligamento.'));
      junto.appendChild(acao);
    }
    /* a pergunta que pesa: um cartão próprio, com o porquê do cuidado */
    var res = caixa('RESTRICAO_REALOCACAO');
    if (res) {
      var card = el('div', 'nc-desl-reservado');
      res.parentNode.insertBefore(card, res);
      card.appendChild(el('p', 'nc-desl-reservado-cab', svg(IC.info) + '<span>Esta resposta acompanha a pessoa em futuras contratações. Se for <b>Sim</b>, conte o motivo na justificativa.</span>'));
      card.appendChild(res);
    }
    var depois = document.getElementById('nc-desl-depois');
    if (depois && ILU.caminho) depois.querySelector('[data-slot="extra"]').innerHTML = '<img class="nc-desl-ilu nc-desl-ilu--caminho" alt="" src="' + ILU.caminho + '">';

    /* a carta: um bloco próprio (não uma seção do formulário). Cada botão fica DENTRO do seu
       passo, logo abaixo do texto que diz o que ele faz; montarCarta decide onde o bloco fica */
    var carta = el('section', 'nc-desl-carta'); carta.id = 'nc-desl-carta';
    carta.setAttribute('aria-labelledby', 'nc-desl-carta-t');
    carta.innerHTML = (ILU.carta ? '<img class="nc-desl-ilu nc-desl-ilu--carta" alt="" src="' + ILU.carta + '">' : '') +
      '<div class="nc-desl-carta-corpo"><header class="nc-desl-carta-cab"><span class="nc-desl-carta-marca" aria-hidden="true" data-slot="marca"></span>' +
      '<div><h3 id="nc-desl-carta-t">Carta de desligamento</h3><p data-slot="sub"></p></div></header>' +
      '<ol class="nc-desl-trilha" aria-label="Passos da carta"><li data-passo="aprovacao"></li>' +
      '<li data-passo="gerar"><div data-slot="txt"></div><div class="nc-desl-trilha-bt" data-slot="bt"></div></li>' +
      '<li data-passo="assinar"></li>' +
      '<li data-passo="anexar"><div data-slot="txt"></div><div class="nc-desl-trilha-bt" data-slot="bt"></div></li>' +
      (document.getElementById(P + 'CHECK_DOCUMENTO_CONTAINER') ? '<li data-passo="conferir"></li>' : '') + '</ol></div>';
    if (BT.gerar) carta.querySelector('[data-passo="gerar"] [data-slot="bt"]').appendChild(BT.gerar);
    if (BT.anexar) carta.querySelector('[data-passo="anexar"] [data-slot="bt"]').appendChild(BT.anexar);
    box.appendChild(carta);
    return true;
  }

  /* ═══ [J6] AS AJUDAS DENTRO DAS PERGUNTAS ════════════════════════════════════════════════
     Três ajudas que aparecem ao lado dos campos e se atualizam a cada resposta:
       montarTraducao   pergunta 2: o que a situação e o motivo escolhidos querem dizer,
                        e o que é aviso indenizado ou trabalhado
       montarLinha      pergunta 3: a linha do tempo "Comunicação → Último dia", com o dia da
                        semana, "daqui a N dias" e avisos de datas trocadas
       montarReposicao  pergunta 4: o botão "Criar Requisição de Pessoal" ganha destaque
                        quando "Haverá reposição?" é Sim
     PODE MEXER todos os textos entre aspas destas três funções.
     CUIDADO    A conta do aviso proporcional (30 + 3 por ano, até 90) é só uma referência na
                tela; quem calcula de verdade é a folha. Mudar aqui não muda nenhum cálculo.
     VISUAL     Natcorp_Desligamento.css › [C3] (partes 1, 2 e 3)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* 1 · o que a escolha significa, em palavras */
  function montarTraducao() {
    var sec = document.getElementById('nc-desl-como');
    if (!sec) return;
    var sit = texto(P + 'SIT_DESLIG'), mot = texto(P + 'COD_MOT_DESLIG');
    var alvo = sec.querySelector('[data-slot="extra"]');
    if (!sit && !mot) { alvo.innerHTML = '<p class="nc-desl-traducao nc-desl-traducao--vazia">Escolha a situação e o motivo. Aqui aparece, em palavras simples, o que a escolha significa.</p>'; return; }
    var m = lerMotivo(mot), av = valor(P + 'AVISO_PREVIO'), cump = texto(P + 'INDCUMPRPARC');
    var aviso = av === 'I' ? '<b>Aviso prévio indenizado:</b> a pessoa não trabalha o período do aviso, e ele é pago na rescisão.' :
      av === 'T' ? '<b>Aviso prévio trabalhado:</b> a pessoa continua trabalhando até o último dia; o período entre a comunicação e o último dia é o aviso.' : '';
    alvo.innerHTML = '<div class="nc-desl-traducao">' +
      (sit ? '<p class="nc-desl-traducao-tit">' + esc(traduzirSituacao(sit)) + (codigo(sit) ? ' <span class="nc-desl-cod" title="Código da situação">' + esc(codigo(sit)) + '</span>' : '') + '</p>' : '') +
      (mot ? '<p class="nc-desl-traducao-mot">Motivo: ' + esc(m.nome) + (m.cod ? ' <span class="nc-desl-cod" title="Código do motivo">' + esc(m.cod) + '</span>' : '') + '</p>' : '') +
      (aviso ? '<p class="nc-desl-traducao-aviso">' + aviso + '</p>' : '') +
      (cump && !/^\s*$/.test(cump) ? '<p class="nc-desl-traducao-nota">Para o eSocial: ' + esc(semCodigo(cump).charAt(0).toLowerCase() + semCodigo(cump).slice(1)) + '.</p>' : '') +
      '</div>';
  }

  /* 2 · a linha do tempo do aviso */
  function montarLinha() {
    var sec = document.getElementById('nc-desl-quando');
    if (!sec) return;
    var alvo = sec.querySelector('[data-slot="extra"]');
    var dc = dataDe(valor(P + 'DT_COMUNICACAO')), du = dataDe(valor(P + 'DT_SIT_DESLIGAMENTO'));
    var av = valor(P + 'AVISO_PREVIO');
    if (!dc && !du) { alvo.innerHTML = '<p class="nc-desl-linha-vazia">Informe as datas: aqui aparece a linha do tempo do aviso.</p>'; return; }
    var ponto = function (d, rot, cls) {
      return '<li class="nc-desl-marco ' + (cls || '') + '"><span class="nc-desl-marco-bola" aria-hidden="true"></span><span class="nc-desl-marco-rot">' + rot + '</span>' +
        (d ? '<span class="nc-desl-marco-data">' + curto(d) + '</span><span class="nc-desl-marco-dia">' + SEMANA[d.getDay()] + ' · ' + quando(d) + '</span>' : '<span class="nc-desl-marco-data nc-desl-marco-data--falta">sem data</span>') + '</li>';
    };
    var html, nota = '', tom = '';
    if (dc && du && +dc === +du) {
      html = '<ol class="nc-desl-linha nc-desl-linha--um">' + ponto(dc, 'Comunicação e último dia', 'is-unico') + '</ol>';
      if (av === 'T') { nota = 'No aviso <b>trabalhado</b> o último dia vem depois da comunicação. Confira as datas.'; tom = 'atencao'; }
    } else {
      var n = dc && du ? dias(dc, du) : null;
      html = '<ol class="nc-desl-linha">' + ponto(dc, 'Comunicação') +
        '<li class="nc-desl-vao' + (n !== null && n < 0 ? ' is-erro' : '') + '" aria-hidden="' + (n === null) + '"><span>' + (n === null ? '' : n < 0 ? 'datas invertidas' : n + (n === 1 ? ' dia' : ' dias') + (av === 'T' ? ' de aviso' : '')) + '</span></li>' +
        ponto(du, 'Último dia de trabalho', 'is-fim') + '</ol>';
      if (n !== null && n < 0) { nota = 'O último dia está <b>antes</b> da comunicação.'; tom = 'erro'; }
      else if (av === 'I' && n > 0) { nota = 'No aviso <b>indenizado</b>, o último dia costuma ser o próprio dia da comunicação.'; tom = 'atencao'; }
    }
    /* estimativa do aviso proporcional (Lei 12.506/2011): só informa; quem calcula é a folha */
    var est = '';
    var adm = dataDe(texto(P + 'DT_ADMISSAO'));
    var sit = texto(P + 'SIT_DESLIG');
    if (adm && /empregador|empresa/i.test(sit) && /s\/\s*j|sem justa/i.test(sit)) {
      var anos = tempo(adm, dc || hoje()).anos;
      var d = Math.min(90, 30 + 3 * anos);
      est = '<p class="nc-desl-estimativa">' + svg(IC.info) + '<span>Aviso proporcional estimado: <b>' + d + ' dias</b> (30 + 3 por ano completo de casa, até 90). É só uma referência: o valor final sai da folha.</span></p>';
    }
    alvo.innerHTML = html + (nota ? '<p class="nc-desl-linha-nota nc-desl-linha-nota--' + tom + '">' + svg(tom === 'erro' ? IC.x : IC.atencao) + '<span>' + nota + '</span></p>' : '') + est;
  }

  /* 3 · reposição: o botão ganha peso quando a resposta é Sim */
  function montarReposicao() {
    var j = document.querySelector('.nc-desl-reposicao');
    if (!j) return;
    var sim = valor(P + 'HAVERA_REP') === 'S';
    j.classList.toggle('nc-desl-reposicao--sim', !!(sim));
    if (BT.vaga) BT.vaga.classList.toggle('t-Button--hot', !!(sim));
    var res = document.querySelector('.nc-desl-reservado');
    if (res) res.classList.toggle('nc-desl-reservado--sim', valor(P + 'RESTRICAO_REALOCACAO') === 'S');
  }

  /* ═══ [J7] A CARTA DE DESLIGAMENTO ═══════════════════════════════════════════════════════
     O QUE FAZ  Mostra a carta como uma trilha de passos (gerar → assinar → anexar → conferência
                do RH) e escolhe ONDE ela aparece conforme a situação da requisição.
     LÊ DOS ITENS  P59_CARTA_ANEXADA, P59_EXISTE_ANEXO, P59_CHECK_DOCUMENTO, P59_DT_ARQUIVO,
                e a região de alerta cujo título tem "Anexo de Carta".
     PODE MEXER os títulos e explicações dos passos: as chamadas  passo('gerar', …, 'Título',
                'Explicação')  — troque só os dois últimos textos.
     VISUAL     Natcorp_Desligamento.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* a carta, no lugar e no tom que a hora dela pede:
       exigida agora   a página mostrou o "Alerta Anexo de Carta" (aviso trabalhado etc.): o
                       aviso assinado precisa ser anexado ANTES de criar — o bloco vai para o fim
                       do formulário, destacado, e entra no "Falta" da barra (sem ele, o Criar
                       volta com o erro do art. 477)
       aprovada        logo abaixo da aprovação: gerar → assinar → anexar → conferência do RH
       nos outros      uma linha no fim, com os dois botões à mão (discretos)
       cancelada/reprovada  some
     Os botões são sempre os do APEX e estão sempre ao alcance: quem decide se a ação vale é
     a ação dinâmica deles (que avisa quando não vale). O desenho não bloqueia nada. */
  /* visível para o APEX: nem ele nem um ancestral com display:none no estilo (ação dinâmica /
     condição) — as classes do desenho não contam */
  function visivelApex(b) { return !!b && document.body.contains(b) && !escondido(b); }
  function alertaAnexo() {
    var a = [].slice.call(document.querySelectorAll('.t-Alert, .t-Region')).filter(function (r) {
      if (r.closest('.t-DialogRegion, .ui-dialog')) return false;
      var t = r.querySelector('.t-Alert-title, .t-Region-title');
      return t && /anexo de carta/i.test(t.textContent);
    })[0];
    if (!a) return null;
    a.classList.add('nc-desl-absorvida');
    var corpo = a.querySelector('.t-Alert-body, .t-Region-body');
    return { visivel: !escondido(a), texto: corpo ? corpo.textContent.replace(/\s+/g, ' ').trim() : '' };
  }
  var CARTA_EXIGIDA = false;
  function montarCarta() {
    var sec = document.getElementById('nc-desl-carta');
    if (!sec) return;
    var st = situacaoReq();
    var liberada = st.tom !== 'nao' && aprovacaoCompleta();
    var anexada = valor(P + 'CARTA_ANEXADA') === 'S' || valor(P + 'EXISTE_ANEXO') === 'S';
    var alerta = alertaAnexo();
    var exigida = st.tom !== 'nao' && !liberada && !!alerta && alerta.visivel;
    var modo = st.tom === 'nao' ? 'fim' : liberada ? 'agora' : exigida ? 'exigida' : 'depois';
    CARTA_EXIGIDA = exigida && !anexada;
    var conf = valor(P + 'CHECK_DOCUMENTO');
    var refez = anexada && conf === 'N';
    var dtArq = texto(P + 'DT_ARQUIVO') || valor(P + 'DT_ARQUIVO');
    sec.hidden = modo === 'fim';
    sec.className = 'nc-desl-carta nc-desl-carta--' + modo + (anexada && !refez ? ' nc-desl-carta--anexada' : '');
    if (modo === 'agora') {
      var ap0 = porClasse('nc-desl-aprovadores')[0];
      var ref = ap0 && !ap0.hidden ? ap0 : document.getElementById('nc-desl-topo');
      if (ref && ref.nextElementSibling !== sec) ref.parentNode.insertBefore(sec, ref.nextSibling);
    } else {
      var box = document.querySelector('.nc-desl-secoes');
      if (box && box.lastElementChild !== sec) box.appendChild(sec);
    }
    if (modo === 'fim') return;
    var ap = lerAprovacao();
    var h3 = sec.querySelector('#nc-desl-carta-t');
    var titulo = modo === 'exigida' ? (anexada ? 'Aviso assinado anexado' : 'Anexe o aviso assinado antes de criar') : 'Carta de desligamento';
    if (h3.textContent !== titulo) h3.textContent = titulo;
    var sub = modo === 'exigida' ? (anexada ? 'Pronto: a requisição já pode ser criada.' : alerta.texto || 'Esta requisição só pode ser criada com o aviso assinado pelo colaborador anexado.') :
      modo === 'depois' ? 'A carta sai depois da aprovação' + (ap && ap.passos.length ? ' (' + ap.aprovados + ' de ' + ap.passos.length + ' aprovações).' : '.') :
      !anexada ? 'A requisição foi aprovada. Agora é gerar a carta, colher a assinatura e anexar.' :
      refez ? 'O RH pediu uma nova carta: anexe de novo a carta assinada.' :
      conf === 'S' ? 'Carta anexada e conferida pelo RH.' : 'Carta anexada. Falta o RH conferir.';
    sec.querySelector('[data-slot="sub"]').textContent = sub;
    sec.querySelector('[data-slot="marca"]').innerHTML = svg(anexada && !refez ? IC.ok : modo === 'exigida' ? IC.clipe : IC.doc);
    var passo = function (k, estado, tit, txt) {
      var li = sec.querySelector('[data-passo="' + k + '"]');
      if (!li) return;
      li.className = 'nc-desl-passo is-' + estado;
      var ic = estado === 'ok' ? IC.ok : estado === 'nao' ? IC.x : estado === 'vez' ? IC.seta : estado === 'espera' ? IC.relogio : '';
      var h = '<span class="nc-desl-passo-marca" aria-hidden="true">' + svg(ic) + '</span><div class="nc-desl-passo-txt"><p class="nc-desl-passo-tit">' + tit + '</p><p class="nc-desl-passo-sub">' + txt + '</p></div>';
      var slot = li.querySelector('[data-slot="txt"]');
      if (slot) slot.innerHTML = h; else li.innerHTML = h;
    };
    if (modo === 'exigida') {
      passo('aprovacao', 'fila', 'Aprovação', 'Depois de criada, a requisição segue para os aprovadores.');
      passo('gerar', anexada ? 'ok' : 'vez', 'Gerar o documento', 'Escolha o documento e informe as datas; ele sai pronto para imprimir.');
      passo('assinar', anexada ? 'ok' : BT.gerar && visivelApex(BT.gerar) ? 'fila' : 'vez', 'Colher a carta assinada', 'O colaborador escreve e assina, como descrito acima.');
      passo('anexar', anexada ? 'ok' : 'vez', anexada ? 'Aviso anexado' : 'Anexar o aviso assinado', anexada ? 'Arquivo enviado.' : 'Digitalize ou fotografe o aviso assinado e envie o arquivo.');
      passo('conferir', 'fila', 'Conferência do RH', 'O RH confere o documento depois.');
    } else {
      passo('aprovacao', 'ok', 'Aprovada', ap && ap.passos.length ? 'Todos os ' + ap.passos.length + ' aprovadores aprovaram.' : 'A requisição foi aprovada.');
      passo('gerar', anexada ? 'ok' : 'vez', 'Gerar a carta', 'Informe a data de pagamento e o encontro no RH; a carta sai pronta para imprimir.');
      passo('assinar', anexada ? 'ok' : 'fila', 'Colher a assinatura', 'O colaborador assina a carta impressa.');
      passo('anexar', anexada && !refez ? 'ok' : refez ? 'vez' : 'fila', anexada && !refez ? 'Carta anexada' : 'Anexar a carta assinada',
        anexada && !refez ? (dtArq ? 'Enviada em ' + esc(dtArq) + '.' : 'Arquivo enviado.') : 'Digitalize ou fotografe a carta assinada e envie o arquivo.');
      passo('conferir', !anexada ? 'fila' : conf === 'S' ? 'ok' : refez ? 'nao' : 'espera', conf === 'S' ? 'Conferida pelo RH' : refez ? 'RH pediu nova carta' : 'Conferência do RH',
        conf === 'S' ? 'Documentação correta.' : refez ? 'A carta enviada não foi aceita.' : 'O RH confere se a carta está correta.');
    }
    /* passo com botão que a página não mostra agora (ex.: na criação não existe "Imprima a
       Carta"): o passo sai da trilha, em vez de prometer uma ação que não está lá */
    [['gerar', BT.gerar], ['anexar', BT.anexar]].forEach(function (x) {
      var li = sec.querySelector('[data-passo="' + x[0] + '"]');
      if (li && !(anexada && x[0] === 'anexar')) li.classList.toggle('nc-desl-passo--sem', !x[1] || !visivelApex(x[1]));
    });
    /* um destaque por vez: exigida → anexar; aprovada → gerar (ou anexar, se o RH pediu outra) */
    if (BT.gerar) BT.gerar.classList.toggle('nc-desl-bt-sec', modo === 'exigida' || modo === 'depois' || anexada);
    if (BT.anexar) BT.anexar.classList.toggle('nc-desl-bt-sec', modo === 'exigida' ? anexada : !refez);
  }

  /* ═══ [J8] CAMPOS TRAVADOS ═══════════════════════════════════════════════════════════════
     O QUE FAZ  Campo que o APEX travou (só leitura) aparece sem borda, como texto, com uma nota
                curta: "Preenchido pelo sistema" ou "Libera conforme as respostas anteriores".
                Numa requisição já gravada, campo travado E vazio some (não tem o que mostrar).
     IMPORTANTE Quem trava é o APEX. Aqui só se muda a APARÊNCIA do que já está travado.
     PODE MEXER as notas entre aspas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function vazioOuTravado() {
    var ed = gravada();
    document.body.classList.toggle('nc-desl--criacao', !ed);
    var avTrab = valor(P + 'AVISO_PREVIO') === 'T';
    [].forEach.call(document.querySelectorAll('.nc-desl-campo'), function (c) {
      var id = c.id.replace(/_CONTAINER$/, '').replace(P, '');
      var t = travado(id);
      var semValor = vazio(texto(P + id)) && vazio(valor(P + id));
      c.classList.toggle('nc-desl-lido', !!(t));
      /* só numa requisição gravada o travado-e-vazio some; na criação ele está só esperando
         as respostas anteriores (e a página o libera sozinha) */
      /* campo obrigatório nunca some: se está vazio, alguém ainda vai precisar dele */
      c.classList.toggle('nc-desl-sem-valor', !!(t && semValor && ed && !c.classList.contains('is-required')));
      /* a ação dinâmica escondeu só o controle (a lista), deixando o rótulo sozinho: some tudo */
      var ctrl = document.getElementById(P + id);
      c.classList.toggle('nc-desl-sem-controle', !!ctrl && ctrl.type !== 'hidden' && ctrl.style.display === 'none');
      var nota = !t || ed ? '' : id === 'DT_SIT_DESLIGAMENTO' && avTrab ? 'Preenchida pelo sistema a partir da data de comunicação e do aviso trabalhado. Para mudar, revise essas duas respostas.' :
        semValor ? 'Libera conforme as respostas anteriores.' : 'Preenchido pelo sistema.';
      var w = c.querySelector('.t-Form-inputContainer') || c;
      var n = w.querySelector(':scope > .nc-desl-nota-sis');
      if (!nota) { if (n) n.remove(); return; }
      if (!n) { n = el('p', 'nc-desl-nota-sis'); w.appendChild(n); }
      if (n.textContent !== nota) n.textContent = nota;
    });
  }

  /* ═══ [J9] O QUE FALTA + A BARRA DO RODAPÉ ═══════════════════════════════════════════════
     O QUE FAZ  Conta os campos OBRIGATÓRIOS ainda vazios. Cada seção mostra "Falta N campos"
                ou "Pronto"; a barra do rodapé lista os que faltam (clicar leva ao campo) ou
                mostra "Tudo preenchido". A barra é a região nc-desl-acoes, levada para baixo
                do formulário e presa no rodapé da tela.
     COMO SABE O QUE É OBRIGATÓRIO  Pelo próprio APEX: campo com "Value Required" ligado.
                Para um campo entrar ou sair do "Falta", mude isso no Page Designer.
     PODE MEXER os textos 'Falta', 'Pronto', 'Tudo preenchido'.
     VISUAL     Natcorp_Desligamento.css › [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function rotulo(c) { var l = c.querySelector('.t-Form-label'); if (!l) return ''; var k = l.cloneNode(true); [].forEach.call(k.querySelectorAll('.u-VisuallyHidden'), function (x) { x.remove(); }); return k.textContent.replace(/\s*\(.*?\)\s*/g, ' ').replace(/[*:?]\s*$/, '').trim(); }
  function faltas(raiz) {
    return [].slice.call((raiz || document).querySelectorAll('.t-Form-fieldContainer')).filter(function (c) {
      if (!FORM || !FORM.contains(c) || escondido(c, FORM)) return false;
      var id = c.id.replace(/_CONTAINER$/, '');
      var e = document.getElementById(id) || document.getElementById(id + '_HIDDENVALUE');
      var req = c.classList.contains('is-required') || e && e.required;
      if (!req || travado(id.replace(P, ''))) return false;
      return vazio(valor(id)) && vazio(texto(id));
    });
  }
  function montarEstados() {
    var n = 0;
    SECOES.forEach(function (s) {
      var sec = document.getElementById('nc-desl-' + s.id);
      if (!sec) return;
      /* seção sem nenhum campo à vista (o APEX escondeu todos) some, e a numeração segue */
      /* escondido(c, sec): o [hidden] da própria seção não conta, senão ela não voltaria mais */
      var visiveis = [].some.call(sec.querySelectorAll('.nc-desl-campo'), function (c) { return !escondido(c, sec) && !c.classList.contains('nc-desl-sem-valor') && !c.classList.contains('nc-desl-sem-controle'); });
      sec.hidden = !visiveis;
      if (!visiveis) return;
      sec.querySelector('.nc-desl-num').textContent = ++n;
      var f = faltas(sec).length;
      var est = sec.querySelector('[data-slot="estado"]');
      /* só leitura (requisição fechada): "Pronto" não diz nada a quem não pode mudar */
      var temCampo = [].some.call(sec.querySelectorAll('.nc-desl-campo'), function (c) { return !c.classList.contains('nc-desl-lido') && !escondido(c); });
      est.className = 'nc-desl-secao-estado' + (f ? ' is-falta' : temCampo ? ' is-ok' : '');
      est.innerHTML = f ? 'Falta ' + f + (f === 1 ? ' campo' : ' campos') : temCampo ? svg(IC.ok) + 'Pronto' : '';
    });
  }
  function montarBarra() {
    var ac = porClasse('nc-desl-acoes')[0];
    if (!ac || !FORM) return;
    /* requisição só para leitura (sem Salvar): só há o Voltar, que fica no alto, onde já estava */
    var gravar = [].some.call(ac.querySelectorAll('.t-Button'), function (b) { return !/voltar|fechar/i.test(b.textContent) && getComputedStyle(b).display !== 'none'; });
    ac.classList.toggle('nc-desl-acoes--leitura', !gravar);
    if (!gravar && !ac.dataset.ncMovida) return;
    var linha = FORM.closest('.row') || FORM;
    if (!ac.dataset.ncMovida) {
      ac.dataset.ncMovida = '1';
      var col = ac.parentElement && ac.parentElement.classList.contains('col') ? ac.parentElement : null;
      linha.parentNode.insertBefore(ac, linha.nextSibling);
      if (col && !col.children.length) col.classList.add('nc-desl-col-vazia');
      var alvo = ac.querySelector('.t-ButtonRegion-col--content') || ac;
      var s = el('div', 'nc-desl-status'); s.id = 'nc-desl-status'; s.setAttribute('aria-live', 'polite');
      alvo.appendChild(s);
      s.addEventListener('click', function (e) {
        var b = e.target.closest('[data-ir]');
        if (!b) return;
        var c = document.getElementById(b.getAttribute('data-ir'));
        if (!c) return;
        c.scrollIntoView({ behavior: 'smooth', block: 'center' });
        var i = c.querySelector('input:not([type=hidden]), select, textarea');
        if (i) setTimeout(function () { i.focus({ preventScroll: true }); }, 350);
      });
    }
    var f = faltas();
    var s2 = document.getElementById('nc-desl-status');
    var extra = CARTA_EXIGIDA ? '<button type="button" class="nc-desl-falta" data-ir="nc-desl-carta">Anexar o aviso assinado</button>' : '';
    s2.innerHTML = f.length || extra ? '<span class="nc-desl-status-rot">Falta</span> ' + f.map(function (c) { return '<button type="button" class="nc-desl-falta" data-ir="' + c.id + '">' + esc(rotulo(c)) + '</button>'; }).join('') + extra :
      '<span class="nc-desl-status-ok">' + svg(IC.ok) + 'Tudo preenchido</span>';
  }

  /* ═══ [J10] CONTADORES DE LETRAS ══════════════════════════════════════════════════════════
     O QUE FAZ  Embaixo de cada caixa de texto que tem limite de tamanho, mostra
                "120 de 4.000" enquanto a pessoa escreve. O limite vem do APEX (Maximum Length).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarContadores() {
    [].forEach.call(document.querySelectorAll('.nc-desl-secoes textarea[maxlength]'), function (t) {
      var max = parseInt(t.getAttribute('maxlength'), 10);
      if (!max || max < 0) return;
      var c = document.getElementById(t.id + '_nc-cont');
      if (!c) {
        c = el('p', 'nc-desl-contador'); c.id = t.id + '_nc-cont'; c.setAttribute('aria-live', 'polite');
        var w = t.closest('.t-Form-inputContainer') || t.parentNode; w.appendChild(c);
        t.addEventListener('input', function () { contar(t, c, max); });
      }
      contar(t, c, max);
    });
  }
  function contar(t, c, max) {
    var n = t.value.length;
    c.textContent = n.toLocaleString('pt-BR') + ' de ' + max.toLocaleString('pt-BR');
    c.classList.toggle('nc-desl-contador--perto', n > max * 0.9);
  }

  /* ═══ [J11] LIMPEZA ═══════════════════════════════════════════════════════════════════════
     O QUE FAZ  Depois que as regiões e campos mudam de lugar, sobram linhas e colunas vazias
                do layout do APEX, que deixariam buracos na tela. Aqui elas são escondidas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function limparLinhas() {
    [].forEach.call(document.querySelectorAll('.t-Body-contentInner .col'), function (col) {
      if (col.closest('.t-Region-body')) return;
      var vivos = [].filter.call(col.children, function (c) { return !c.classList.contains('nc-desl-absorvida') && !c.hidden && c.style.display !== 'none'; });
      col.classList.toggle('nc-desl-col-vazia', !vivos.length);
    });
    [].forEach.call(document.querySelectorAll('.nc-desl-form .t-Region-body > .container .row'), function (row) {
      var vivo = [].some.call(row.querySelectorAll('.t-Form-fieldContainer, .t-Region, button, .t-Button, img'), function (c) { return !escondido(c, row) && c.offsetParent !== null; });
      row.classList.toggle('nc-desl-linha-vazia', !vivo);
    });
  }

  /* ═══ [J12] O MAESTRO: QUANDO CADA PARTE É MONTADA ══════════════════════════════════════
     O QUE FAZ  tudo() chama as partes acima, nesta ordem. iniciar() roda uma vez quando a
                página abre e depois manda montar tudo de novo sempre que algo muda: um campo é
                alterado, uma ação dinâmica traz valores do servidor, uma janela fecha, a tela
                muda de tamanho.
     CUIDADO    Não mude a ordem das chamadas em tudo(): umas partes dependem das anteriores
                (as seções precisam existir antes de as ajudas entrarem nelas).
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp desligamento] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tudo() {
    montarTopo();
    montarAprovadores();
    if (montarSecoes()) {
      vazioOuTravado();
      montarTraducao();
      montarLinha();
      montarReposicao();
      montarCarta();
      montarContadores();
      montarEstados();
      montarBarra();
    }
    limparLinhas();
  }
  var agendado = false, MO = null;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () {
      agendado = false;
      try { tudo(); } catch (e) { if (window.console) console.warn('[Natcorp desligamento]', e); }
      if (MO) MO.takeRecords();   /* o que o próprio desenho mudou não conta como mudança do APEX */
    });
  }
  function iniciar() {
    document.body.classList.add('nc-desl');
    tudo();
    $(document).on('change', '[id^="' + P + '"]', agendar);
    $(document).on('input', '.nc-desl-secoes textarea, .nc-desl-secoes input', agendar);
    $(document).on('apexafterrefresh', agendar);
    /* valores trazidos do servidor por ação dinâmica (Executar PL/SQL, "itens a retornar")
       chegam SEM o evento change: sem isto a tela ficava com a leitura de antes da resposta */
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    $(document).on('apexafterclosedialog dialogclose', function () { setTimeout(agendar, 80); });
    $(window).on('resize apexwindowresized', agendar);
    /* 04/10: o desenho monta antes das ações de abertura da página (habilita/desabilita, alerta
       da carta, esconde a região do título). Nenhuma delas procura campo por região, mas o
       desenho LÊ o estado que elas mudam: remonta quando todas terminaram */
    $(window).one('apexreadyend', agendar);
    setTimeout(agendar, 3000);
    /* ações dinâmicas que mostram / escondem / travam campos mexem em style e disabled */
    if (window.MutationObserver && FORM) {
      /* ações dinâmicas que mostram, escondem, travam e liberam campos, e listas em cascata
         recarregadas (as opções da lista mudam sem evento "change") */
      MO = new MutationObserver(agendar);
      MO.observe(FORM, { attributes: true, childList: true, subtree: true, attributeFilter: ['style', 'disabled', 'readonly', 'class'] });
    }
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
