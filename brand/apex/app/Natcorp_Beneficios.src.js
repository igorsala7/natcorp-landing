/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE BENEFÍCIOS  —  o "arrumador" da tela (JavaScript)                ║
   ║  App 200 · Página 168 (colaborador)  ·  App 200 · Página 116 (Alteração Funcional)        ║
   ║  App 600 · Página 168 (portal do candidato, "Conhecendo Você")                            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns. Guia desta página: brand/apex/app/BENEFICIOS-MANUTENCAO.md

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quando a página abre, ele REDESENHA o que o APEX já desenhou, para a pessoa montar o pacote
   de benefícios sem se perder:
     • no alto, um cartão com o colaborador (iniciais ou foto, nome, matrícula, situação…);
     • o SALDO como uma barra colorida: quanto já foi usado e quanto ainda sobra;
     • a escolha em botões e cartões ilustrados, no lugar das listas;
     • "Quanto você quer?" com os botões − e +, uma régua e atalhos (Mínimo, Tudo o que sobra);
     • o pacote novo em cartões, comparado com o de hoje ("Novo", "Igual a hoje", "+ R$ …");
     • no pedido já gravado: a faixa do pedido (nº, situação, quem pediu) e o caminho da
       aprovação, com os botões Aprovar/Reprovar;
     • um resumo do pacote ao lado dos botões, na barra presa ao pé da tela.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda ordem, colunas, títulos, rótulos nem botões: tudo isso continua vindo do Page
       Designer e aparece na tela do mesmo jeito. Não move, não renomeia, não duplica nada.
     • Não valida e não grava: as validações continuam no servidor.
     • A lista/campo continua sendo o item de verdade. Clicar num botão ou cartão faz
       apex.item(…).setValue(…), que dispara as MESMAS ações dinâmicas e cascatas de sempre.
     • Tirou a classe de uma região ou item no APEX: aquele pedaço volta ao normal.
       Tirou as URLs de arquivo da página: a página toda volta ao padrão do APEX.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 168 (e 116) › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_Beneficios.js
     Página 168 (e 116) › CSS › File URLs:         #WORKSPACE_IMAGES#Natcorp_Beneficios.css
     (este arquivo sobe com as ilustrações embutidas; o visual fica no Natcorp_Beneficios.css)
     ATENÇÃO: o MESMO arquivo serve à página 116 (Alteração Funcional) e ao app 600. Ao mudar
     algo aqui, confira as três telas.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Classes nas REGIÕES (Page Designer › clique na região › Appearance › CSS Classes):
     nc-ben-perfil-regiao  "Colaborador Solicitado"  → cartão do colaborador (lê os itens de Colab Info)
     nc-ben-medidor        "Seu valor para benefícios" → a barra do saldo (lê TOTAL, SALDO e o pacote)
     nc-ben-pacote         "Seu novo pacote"          → cada linha vira um cartão + o que muda
     nc-ben-hoje           "O que você tem hoje"      → os mesmos cartões, mais discretos
     nc-ben-acoes          região dos botões          → o resumo do pacote ao lado dos botões
   Classes nos ITENS (Page Designer › clique no item › Advanced › CSS Classes):
     nc-ben-segmento       P168_OPCAO            → dois botões lado a lado
     nc-ben-chips          P168_BENEFICIO        → botões pequenos (com UMA opção só, já escolhe)
     nc-ben-cartoes        P168_TIPO_BENEFICIO   → cartões ilustrados
     nc-ben-valor          P168_VALOR            → campo grande com − / +, régua e o aviso de saldo
   Achados SEM classe (pelo conteúdo), só no pedido já gravado:
     a região que tem P168_COD_REQ   → a faixa do pedido
     a tabela com a coluna APROVADOR → o caminho da aprovação
     a região de ID estático BENEFICIOS_REQUISITADOS (ou título "Benefícios Requisitados…")
   O desenho de cada item entra DENTRO do item, logo abaixo do rótulo: quando uma ação
   dinâmica esconde o item, o desenho some junto.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J0]  Começo: qual página, qual prefixo ...... P168_ ou P116_, candidato ou colaborador
     [J1]  Ferramentas ............................ funções pequenas usadas no arquivo todo
     [J2]  Textos, categorias e cores ............. acentos, ilustração de cada benefício  PODE MEXER
     [J3]  Achar regiões e itens pela classe
     [J4]  Ler as linhas dos relatórios ........... nome, tipo e valor de cada benefício  CUIDADO
     [J5]  O cartão do colaborador ................ nome, matrícula, situação, desde quando
     [J6]  A barra do saldo ....................... usado, livre, a frase do que falta      PODE MEXER
     [J7]  A máscara de dinheiro .................. R$ 1.234,56 na tela, 1234,56 no banco  CUIDADO
     [J8]  Opção, Benefício e Tipo ................ botões e cartões no lugar das listas   PODE MEXER
     [J9]  O valor ................................ − / +, régua, atalhos, aviso de saldo  PODE MEXER
     [J10] Os cartões do pacote e de hoje ......... "Novo", "Igual a hoje", "Sai do pacote" PODE MEXER
     [J11] O pedido já gravado .................... nº, situação, quem pediu              PODE MEXER
     [J12] O caminho da aprovação ................. quem aprovou, quem falta, Aprovar/Reprovar
     [J13] O resumo na barra dos botões ........... "3 benefícios no pacote · …"           PODE MEXER
     [J14] O maestro .............................. decide QUANDO cada parte é montada     CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Ainda pode usar'  →  'Ainda livre'
     Um benefício novo aparece com a ilustração "genérica"
       → [J2], lista CATEGORIAS: acrescente uma palavra dele no padrão de busca da categoria
         certa (ex.: "wellhub" já leva à academia). Leia o CUIDADO de [J2] antes.
     Uma palavra aparece sem acento ("Combustivel")
       → [J2], lista ACENTO: acrescente  palavra: 'palavra com acento',  no mesmo formato.
     Quero mudar o texto embaixo dos botões de Opção ("Escolha livre, dentro do seu valor")
       → [J8], a lista "dicas" em montarSegmento.
     Uma coluna do relatório foi renomeada e os cartões sumiram
       → [J4]: os cartões leem as colunas pelo nome (BENEFICIO, TIPO_BENEFICIO, VALOR_TOTAL).
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp benefícios].
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
     P + 'SALDO'            junta os textos: vira 'P168_SALDO', o nome do item no APEX.
     val(…)                 lê o que está num item do APEX (veja [J1]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* ═══ [J0] COMEÇO: QUAL PÁGINA, QUAL PREFIXO ═════════════════════════════════════════════
     O QUE FAZ  Descobre em que página está (168 ou 116) e monta o começo do nome dos itens:
                P = 'P168_' ou 'P116_'. Por isso este arquivo NÃO tem o número da página
                escrito: serve às duas sem mudança.
                Também descobre se é o portal do candidato (app 600): lá existe o item
                COD_CANDIDATO e não existe MATRICULA.
     NOME       Os poucos itens que têm nome DIFERENTE em cada página (matrícula, admissão,
                vigência, cargo). Se um deles for renomeado no APEX, troque aqui.
     CUIDADO    A primeira linha abaixo impede que o arquivo rode duas vezes (URL repetida na
                página, por exemplo) e que rode fora do APEX. Não apague.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncBeneficios || !window.apex || !window.apex.jQuery) return;
  /* o número da página só dá o prefixo dos itens (P168_… ou P116_…) */
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  window.__ncBeneficios = true;
  /* os itens têm o mesmo nome nas duas páginas, com o prefixo dela; o que muda de nome: */
  var P = 'P' + pag + '_';
  /* o portal do candidato (app 600) escolhe os benefícios pelo CANDIDATO, não pela matrícula */
  var CANDIDATO = !!document.getElementById(P + 'COD_CANDIDATO') && !document.getElementById(P + 'MATRICULA');
  var NOME = pag === '116'
    ? { matricula: 'MAT_SOLICITADO', admissao: 'DT_ADMISSAO_DISPLAY', vigencia: '', cargo: 'CARGO_1' }
    : CANDIDATO ? { matricula: 'COD_CANDIDATO', admissao: '', vigencia: '', cargo: '' }
    : { matricula: 'MATRICULA', admissao: 'DT_ADMISSAO', vigencia: 'DT_VIGENCIA', cargo: '' };

  var $ = apex.jQuery;
  var ILU = /*@@ILUSTRACOES@@*/ {};

  /* ═══ [J1] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val(P + 'ITEM')    o que o APEX GUARDA no item (ex.: o código da opção escolhida)
       num('R$ 1.234,56') transforma o texto num número (1234.56) para fazer contas
       brl(1234.56)       o contrário: o número como dinheiro, "R$ 1.234,56"
       bonito('REEMBOLSO COMBUSTIVEL')  → "Reembolso combustível" (veja [J2])
       codDesc('700 - NATCORP DO BRASIL') → "700 - Natcorp do Brasil" (código e descrição)
     QUANDO MEXER  Quase nunca.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MOEDA = new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' });
  function brl(n) { return isFinite(n) ? MOEDA.format(n).replace(/ /g, ' ') : '—'; }
  function num(t) {
    if (t === null || t === undefined) return NaN;
    t = String(t).replace(/[^\d,.\-]/g, '');
    if (t.indexOf(',') > -1) t = t.replace(/\./g, '').replace(',', '.');
    return parseFloat(t);
  }
  function val(id) { var it = apex.item(id); return it && it.node ? String(it.getValue() || '') : ''; }
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function cap(s) { return s ? s.charAt(0).toUpperCase() + s.slice(1) : s; }

  /* ═══ [J2] TEXTOS, CATEGORIAS E CORES ═══════════════════════════════════════════════════
     O QUE FAZ  • ACENTO: os nomes vêm do cadastro em MAIÚSCULAS e sem acento ("REEMBOLSO
                  COMBUSTIVEL"); bonito() os escreve em letra normal, com acento.
                • CATEGORIAS: decide qual ILUSTRAÇÃO cada benefício ganha (carro, refeição,
                  academia, saúde…), procurando palavras no nome dele.
                • CORES: a cor de cada benefício na barra do saldo e nos cartões, na ordem.
     IMPORTANTE Só muda o que aparece na tela. O nome gravado no banco continua o mesmo.
     PODE MEXER • ACENTO: cada linha é  palavra-sem-acento: 'palavra com acento',  (em
                  minúsculas). Para acrescentar uma, copie um par e troque as duas palavras.
                • CATEGORIAS: o nome da categoria (1º texto) é o nome da ilustração — não mude.
                  O 2º é um padrão de busca entre barras: palavras separadas por | ("ou").
                  Para um benefício novo cair numa categoria, acrescente |palavra no padrão.
                • CORES: códigos de cor (#RRGGBB). Prefira as cores da marca (manual, parte 3).
     CUIDADO    • A ORDEM das CATEGORIAS importa: a primeira que combinar vence (por isso
                  odontológico vem antes de saúde). Benefício que não combina com nenhuma
                  ganha a ilustração "outro".
                • Os padrões de busca (expressões regulares) têm sinais especiais: [ií] quer
                  dizer "i ou í"; \b quer dizer "começo/fim de palavra". Só troque se souber.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: palavra sem acento (em minúsculas): 'como deve aparecer' */
  /* textos que chegam do cadastro em MAIÚSCULAS e sem acento ("REEMBOLSO COMBUSTIVEL") */
  var ACENTO = {
    combustivel: 'combustível', educacao: 'educação', locacao: 'locação', veiculo: 'veículo', beneficio: 'benefício',
    beneficios: 'benefícios', previdencia: 'previdência', refeicao: 'refeição', alimentacao: 'alimentação', saude: 'saúde',
    odontologico: 'odontológico', medico: 'médico', medica: 'médica', assistencia: 'assistência', obrigatorios: 'obrigatórios',
    obrigatorio: 'obrigatório', seguranca: 'segurança', manutencao: 'manutenção', academia: 'academia', onibus: 'ônibus',
    remuneracao: 'remuneração', 'remuneraçao': 'remuneração', basica: 'básica'
  };
  function bonito(t) {
    t = String(t || '').replace(/_/g, ' ').replace(/\s+/g, ' ').trim();
    if (!t) return t;
    var letras = t.replace(/[^A-Za-zÀ-ÿ]/g, '');
    var caixaAlta = letras.length > 2 && letras === letras.toUpperCase();
    var s = caixaAlta ? t.toLowerCase() : t;
    s = s.replace(/[A-Za-zÀ-ÿ]+/g, function (w) {
      var k = w.toLowerCase();
      if (!ACENTO[k]) return w;
      return w.charAt(0) === w.charAt(0).toUpperCase() && w.charAt(0) !== w.charAt(0).toLowerCase() ? cap(ACENTO[k]) : ACENTO[k];
    });
    return caixaAlta ? cap(s) : s;
  }
  function semCodigo(t) { return String(t || '').replace(/^\s*\d+\s*-\s*/, '').trim(); }
  /* "700 - NATCORP DO BRASIL" → "700 - Natcorp do Brasil": o código fica (o RH procura por ele) */
  function codDesc(t) {
    var m = /^\s*([\w.]+)\s+-\s+(.+)$/.exec(String(t || ''));
    var d = bonito(m ? m[2] : t).replace(/\s(De|Da|Do|Das|Dos|E|Em|Para)(?=\s)/g, function (x) { return x.toLowerCase(); });
    return m && d ? m[1] + ' - ' + d : d;
  }

  /* PODE MEXER: [nome da ilustração, /palavras|que|levam|a|ela/i] — leia o CUIDADO de [J2] */
  /* categoria → ilustração e cor; a ordem importa (odontológico antes de saúde) */
  var CATEGORIAS = [
    ['carro', /carro|ve[ií]culo|loca[cç][aã]o/i],
    ['previdencia', /previd|aposent|\bpp\b/i],
    ['refeicao', /ticket|refei|aliment|restaur|cesta|\bv\.?[ar]\b|vale.?(ref|alim)/i],
    ['academia', /gym|academ|wellhub|totalpass|fitness/i],
    ['combustivel', /combust|gasolin|quilometr/i],
    ['educacao', /educa|curso|escola|faculd|idioma|bolsa/i],
    ['odonto', /odont|dent/i],
    ['saude', /sa[uú]de|m[eé]dic|plano|assist|farm/i],
    ['transporte', /transp|[oô]nibus|metr[oô]|\bvt\b|mobilid/i],
    ['seguro', /seguro|vida|prote/i]
  ];
  function categoria(txt) {
    for (var i = 0; i < CATEGORIAS.length; i++) if (CATEGORIAS[i][1].test(txt)) return CATEGORIAS[i][0];
    return 'outro';
  }
  /* PODE MEXER: a cor de cada benefício, na ordem em que aparecem (depois do último, repete) */
  var CORES = ['#511C76', '#C95788', '#9CB4D8', '#9A408A', '#2C1A63', '#D884B4', '#544884', '#E4A9C4'];
  function ilustra(cat, cls) {
    var s = el('span', 'nc-ben-ilu' + (cls ? ' ' + cls : ''));
    s.setAttribute('aria-hidden', 'true');
    s.setAttribute('data-cat', cat);
    if (ILU[cat] || ILU.outro) s.style.backgroundImage = 'url(' + (ILU[cat] || ILU.outro) + ')';
    return s;
  }

  function dataBR(t) { var m = String(t || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  function dataExtenso(d) { return d ? (d.getDate() === 1 ? '1º' : d.getDate()) + ' de ' + MESES[d.getMonth()] + ' de ' + d.getFullYear() : ''; }
  function anosDesde(d) { if (!d) return 0; var h = new Date(), a = h.getFullYear() - d.getFullYear(); if (h < new Date(h.getFullYear(), d.getMonth(), d.getDate())) a--; return a; }


  /* ═══ [J3] ACHAR REGIÕES E ITENS PELA CLASSE ═════════════════════════════════════════════
     O QUE FAZ  regiao('nc-ben-pacote') acha a região do APEX que tem essa classe.
                item('nc-ben-valor') acha o CAMPO do item que tem essa classe.
                caixaDoItem() cria, dentro do item, o lugar onde entra o desenho novo
                (logo abaixo do campo de verdade, que fica fora da vista).
     QUANDO MEXER  Nunca, em geral. Para ligar/desligar uma parte, ponha/tire a classe no APEX.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function regiao(cls) { return document.querySelector('.t-Region.' + cls + ', .t-ButtonRegion.' + cls); }
  /* a classe do item (Avançado › Classes CSS) vai, no Universal Theme, para o CONTÊINER do
     item (.t-Form-fieldContainer), não para a lista/campo: aceita os dois e devolve o campo */
  function item(cls) {
    var e = document.querySelector('.' + cls);
    if (!e) return null;
    if (/^(SELECT|INPUT|TEXTAREA)$/.test(e.tagName)) return e;
    /* o campo de VERDADE: a caixa da máscara de dinheiro (nc-moeda) vem antes dele e a régua
       depois — nenhuma das duas é o item do APEX */
    return e.querySelector('select, textarea, input:not([type="hidden"]):not(.nc-moeda):not(.nc-ben-regua)');
  }
  function containerDe(el) { return el && el.closest('.t-Form-fieldContainer'); }
  /* o desenho do item entra dentro do contêiner dele, depois do campo (o campo real fica
     lá, fora da vista quando o desenho o substitui) */
  function caixaDoItem(campo, id) {
    var box = document.getElementById(id);
    if (box) return box;
    var c = containerDe(campo);
    var alvo = c && (c.querySelector('.t-Form-inputContainer') || c);
    if (!alvo) return null;
    box = el('div', 'nc-ben-ctrl');
    box.id = id;
    var wrap = alvo.querySelector('.t-Form-itemWrapper');
    if (wrap && wrap.nextSibling) alvo.insertBefore(box, wrap.nextSibling); else alvo.appendChild(box);
    return box;
  }
  function rotuloId(elItem) { var l = document.getElementById(elItem.id + '_LABEL'); return l ? l.id : ''; }

  /* ═══ [J4] LER AS LINHAS DOS RELATÓRIOS ══════════════════════════════════════════════════
     O QUE FAZ  Lê cada linha de "Seu novo pacote", "O que você tem hoje" e "Benefícios
                Requisitados": o benefício, o tipo e o valor. Tudo o que vem depois (barra do
                saldo, cartões, "Novo", "Igual a hoje") usa esta leitura.
     LÊ DAS COLUNAS (pelo nome da coluna no relatório do APEX):
                BENEFICIO (ou BENEFÍCIO), TIPO_BENEFICIO (ou TIPO_BENEFÍCIO), VALOR_TOTAL,
                e no pedido gravado também TIPO (a operação) e VALOR_ANTERIOR.
                A linha do "Total do relatório" é reconhecida e tratada à parte.
                No portal (app 600) o pacote vem como lista (MediaList): o texto é lido do
                título ("<b>Academia</b> | R$ 109,00") e da descrição ("Tipo de Benefício: …").
     CUIDADO    Se uma dessas colunas for RENOMEADA no relatório, os cartões e a barra do saldo
                não acham os dados. Renomeie também aqui (procure  c('  logo abaixo).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function chaveDe(bene, tipo) { return (bene + '|' + tipo).toLowerCase().replace(/\s+/g, ' '); }
  function linhas(reg) {
    var out = [];
    if (!reg) return out;
    reg.querySelectorAll('table.t-Report-report tbody tr').forEach(function (tr) {
      var c = function (h) { return tr.querySelector('td[headers="' + h + '"]'); };
      var b = c('BENEFICIO') || c('BENEFÍCIO'), t = c('TIPO_BENEFICIO') || c('TIPO_BENEFÍCIO'), v = c('VALOR_TOTAL');
      if (!b || !v) { tr.classList.add('nc-ben-linha-total'); return; }
      var bene = (b.getAttribute('data-nc-txt') || b.textContent).trim();
      var tipo = t ? (t.getAttribute('data-nc-txt') || t.textContent).trim() : '';
      if (/total do relat|^total\b/i.test(bene) || (!bene && /total/i.test(tr.textContent))) { tr.classList.add('nc-ben-linha-total'); return; }
      /* "Benefícios Requisitados" traz a operação (Inserido / Removido / -) e o valor de antes */
      var op = c('TIPO'), ant = c('VALOR_ANTERIOR');
      out.push({ tr: tr, cb: b, ct: t, cv: v, bene: bene, tipo: tipo, valor: num(v.getAttribute('data-nc-txt') || v.textContent), chave: chaveDe(bene, tipo),
        op: op ? (op.getAttribute('data-nc-txt') || op.textContent).trim() : '', anterior: ant ? num(ant.textContent) : NaN });
    });
    /* o portal (app 600) mostra o pacote em MediaList: o texto vem pronto do SQL —
       "<b>Academia</b> | R$ 109,00" no título e "Tipo de Benefício: <b>Plano Platinum</b>…" */
    reg.querySelectorAll('li.t-MediaList-item').forEach(function (li) {
      if (li.__ncBen) { out.push(li.__ncBen); return; }
      var tit = li.querySelector('.t-MediaList-title'), desc = li.querySelector('.t-MediaList-desc');
      if (!tit) return;
      var h = desc ? desc.innerHTML : '';
      function campo(rot) { var m = new RegExp(rot + ':\\s*<b>([\\s\\S]*?)</b>', 'i').exec(h); return m ? limpoHtml(m[1]) : ''; }
      var nomeTit = limpoHtml(((tit.querySelector('b') || {}).innerHTML) || tit.textContent.split('|')[0]);
      var valor = num((tit.textContent.split('|')[1] || '').replace(/R\$/, ''));
      var tipo = campo('Tipo de Benef[ií]cio');
      var i = { tr: li, lista: true, bene: nomeTit, tipo: tipo === nomeTit ? '' : tipo, valor: valor, qtd: campo('Quantidade'), escolhido: num(campo('Valor Escolhido').replace(/R\$/, '')),
        remover: li.querySelector('a.apagarBeneficio'), op: '', anterior: NaN };
      i.chave = chaveDe(i.bene, i.tipo);
      li.__ncBen = i;
      out.push(i);
    });
    return out;
  }
  function limpoHtml(t) { var d = document.createElement('div'); d.innerHTML = String(t || ''); return (d.textContent || '').replace(/\s+/g, ' ').trim(); }

  /* ═══ [J5] O CARTÃO DO COLABORADOR ═══════════════════════════════════════════════════════
     O QUE FAZ  Na região nc-ben-perfil-regiao, monta o cartão: iniciais (ou a foto), nome,
                matrícula, empresa ("700 - Natcorp do Brasil"), cargo (só na 116), situação,
                "Na empresa desde" com os anos de casa e "As escolhas valem a partir de".
                Sem colaborador escolhido, o cartão não aparece.
     LÊ DOS ITENS  P168_MATRICULA_DISPLAY, P168_COD_EMPRESA_DISPLAY, P168_SITUACAO_COLAB,
                P168_FOTO_COLAB e os da lista NOME de [J0] (admissão, vigência, cargo).
     PODE MEXER os rótulos entre aspas: 'Cargo hoje', 'Situação', 'Na empresa desde',
                'As escolhas valem a partir de', 'Matrícula '.
     VISUAL     Natcorp_Beneficios.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarPerfil() {
    var reg = regiao('nc-ben-perfil-regiao');
    if (!reg) return;
    var corpo = reg.querySelector('.t-Region-body');
    var col = val(P + 'MATRICULA_DISPLAY');
    var nome = semCodigo(col);
    var p = document.getElementById('nc-ben-perfil');
    /* 04/10: sem o colaborador escolhido (o item real vazio) não há cartão — na 116, "Selecionar
       colaborador" limpa a matrícula e MOSTRA os campos de escolha, mas o _DISPLAY guarda o nome
       de antes: o cartão ficava e escondia (fora da vista) os campos que a página acabou de mostrar */
    if (!nome || !val(P + NOME.matricula)) { if (p) p.hidden = true; reg.classList.remove('nc-ben-com-perfil'); return; }
    if (!p) { p = el('div', 'nc-ben-perfil'); p.id = 'nc-ben-perfil'; corpo.insertBefore(p, corpo.firstChild); }
    p.hidden = false;
    reg.classList.add('nc-ben-com-perfil');
    var mat = (col.match(/^\s*(\d+)/) || [])[1] || '';
    var emp = codDesc(val(P + 'COD_EMPRESA_DISPLAY'));
    var sit = val(P + 'SITUACAO_COLAB').split(/\s+-\s+/);
    var situacao = bonito(sit[1] || sit[0] || '');
    var adm = dataBR(val(P + NOME.admissao));
    var vig = NOME.vigencia ? dataBR(val(P + NOME.vigencia)) : null;
    var cargo = NOME.cargo ? codDesc((document.getElementById(P + NOME.cargo) || {}).value || '') : '';  // o texto da lista (popup): "624 - Supervisor de Setor"
    var foto = document.querySelector('#' + P + 'FOTO_COLAB_CONTAINER img');
    var ini = nome.split(/\s+/).filter(Boolean);
    ini = (ini[0] || '').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '');
    var anos = anosDesde(adm);
    p.innerHTML =
      '<div class="nc-ben-avatar">' + (foto && foto.getAttribute('src') ? '<img alt="" src="' + esc(foto.getAttribute('src')) + '">' : '<span>' + esc(ini.toUpperCase()) + '</span>') + '</div>' +
      '<div class="nc-ben-quem"><p class="nc-ben-nome">' + esc(nome) + '</p>' +
        '<p class="nc-ben-meta">' + [mat ? 'Matrícula ' + esc(mat) : '', esc(emp)].filter(Boolean).join('<span aria-hidden="true"> · </span>') + '</p></div>' +
      '<dl class="nc-ben-fatos">' +
        (cargo ? '<div><dt>Cargo hoje</dt><dd>' + esc(cargo) + '</dd></div>' : '') +
        (situacao ? '<div><dt>Situação</dt><dd><span class="nc-ben-chip' + (/ativo/i.test(situacao) ? ' nc-ben-chip--ok' : '') + '">' + esc(situacao) + '</span></dd></div>' : '') +
        (adm ? '<div><dt>Na empresa desde</dt><dd>' + MESES[adm.getMonth()] + ' de ' + adm.getFullYear() + (anos > 0 ? ' <span class="nc-ben-sutil">· ' + anos + (anos === 1 ? ' ano' : ' anos') + '</span>' : '') + '</dd></div>' : '') +
        (vig ? '<div class="nc-ben-vigencia"><dt>As escolhas valem a partir de</dt><dd>' + dataExtenso(vig) + '</dd></div>' : '') +
      '</dl>';
  }

  /* ═══ [J6] A BARRA DO SALDO ══════════════════════════════════════════════════════════════
     O QUE FAZ  Na região nc-ben-medidor, desenha: o valor total, quanto "Ainda pode usar",
                uma barra com um pedaço colorido por benefício (e o pedaço livre), a legenda
                e uma frase do que fazer ("Você já distribuiu… Ainda pode usar…").
                Os itens da região continuam lá, fora da vista: são a fonte dos números.
                Sem colaborador, a região não aparece (volta sozinha depois).
     LÊ DOS ITENS  P168_TOTAL, P168_SALDO e as linhas do pacote (veja [J4]).
                Se SALDO vier vazio, a conta é feita aqui: total menos o que está no pacote.
     PODE MEXER as frases entre aspas: 'Você já distribuiu', 'Tudo distribuído',
                'O pacote passou', 'Ainda pode usar', 'Passou do valor'…
     VISUAL     Natcorp_Beneficios.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* o pacote que vale: o "Seu novo pacote"; no pedido gravado em que ele vem escondido e vazio
     (Alteração Funcional, 116), o que foi pedido — sem os que saem */
  function itensDoPacote() {
    var pac = regiao('nc-ben-pacote'), p = linhas(pac);
    var req = regiaoRequisitados(), q = req ? linhas(req) : [];
    if (pac && !(req && q.length && (pac.style.display === 'none' || !p.length))) return p;
    return q.filter(function (x) { return !/remov/i.test(x.op); });
  }
  function montarSaldo() {
    var reg = regiao('nc-ben-medidor');
    if (!reg) return;
    var corpo = reg.querySelector('.t-Region-body') || reg;
    var s = document.getElementById('nc-ben-saldo');
    if (!s) { s = el('div', 'nc-ben-saldo'); s.id = 'nc-ben-saldo'; s.setAttribute('aria-live', 'polite'); corpo.insertBefore(s, corpo.firstChild); }
    var total = num(val(P + 'TOTAL'));
    var saldo = num(val(P + 'SALDO'));
    /* sem colaborador escolhido não há o que medir: a região some (volta sozinha depois) */
    var semDados = !isFinite(total) || !val(P + NOME.matricula);
    reg.classList.toggle('nc-ben-sem-dados', semDados);
    if (semDados) return;
    var itens = itensDoPacote();
    var usado = itens.reduce(function (a, i) { return a + (isFinite(i.valor) ? i.valor : 0); }, 0);
    if (!isFinite(saldo)) saldo = total - usado;
    var seg = itens.map(function (i, k) {
      return '<span class="nc-ben-seg" style="flex-grow:' + Math.max(i.valor, 0) + ';background:' + CORES[k % CORES.length] + '" title="' + esc(bonito(i.bene)) + ': ' + brl(i.valor) + '"></span>';
    }).join('') + (saldo > 0 ? '<span class="nc-ben-seg nc-ben-seg--livre" style="flex-grow:' + saldo + '" title="Ainda livre: ' + brl(saldo) + '"></span>' : '');
    var leg = itens.map(function (i, k) {
      return '<li><i style="background:' + CORES[k % CORES.length] + '"></i>' + esc(bonito(i.bene)) + ' <b>' + brl(i.valor) + '</b></li>';
    }).join('') + (saldo > 0 ? '<li class="nc-ben-leg-livre"><i></i>Ainda livre <b>' + brl(saldo) + '</b></li>' : '');
    var estado = saldo > 0.004 ? 'livre' : (saldo < -0.004 ? 'passou' : 'completo');
    var frase = estado === 'livre'
      ? 'Você já distribuiu <b>' + brl(usado) + '</b> de <b>' + brl(total) + '</b>. Ainda pode usar <b>' + brl(saldo) + '</b> em outro benefício.'
      : estado === 'completo' ? 'Tudo distribuído: os <b>' + brl(total) + '</b> estão no seu pacote.'
        : 'O pacote passou <b>' + brl(-saldo) + '</b> do seu valor. Remova um benefício ou diminua um valor.';
    s.setAttribute('data-estado', estado);
    s.innerHTML =
      '<div class="nc-ben-saldo-topo">' +
        '<div><p class="nc-ben-rot">Seu valor para benefícios</p><p class="nc-ben-total">' + brl(total) + '</p></div>' +
        '<div class="nc-ben-sobra"><p class="nc-ben-rot">' + (estado === 'passou' ? 'Passou do valor' : 'Ainda pode usar') + '</p><p class="nc-ben-sobra-valor">' + brl(Math.abs(saldo)) + '</p></div>' +
      '</div>' +
      '<div class="nc-ben-barra" role="img" aria-label="' + esc('Usado ' + brl(usado) + ' de ' + brl(total)) + '">' + seg + '</div>' +
      (leg ? '<ul class="nc-ben-legenda">' + leg + '</ul>' : '') +
      '<p class="nc-ben-frase">' + frase + '</p>';
    montarResumo(itens, total, saldo);
  }

  /* ═══ [J7] A MÁSCARA DE DINHEIRO ═════════════════════════════════════════════════════════
     O QUE FAZ  A pessoa vê e digita "R$ 1.234,56", mas o banco continua recebendo o número
                no formato de sempre ("1234,56", sem ponto de milhar e sem R$).
     COMO       Uma caixa de EXIBIÇÃO é posta por cima do campo de verdade. Ela não tem nome,
                então NÃO é enviada ao servidor. Quando a pessoa sai dela, o número puro vai
                para o campo de verdade (apex.item().setValue) — e as ações dinâmicas, as
                validações e o Salvar leem só o campo de verdade.
     CUIDADO    Não mude esta parte sem testar o Salvar: um erro aqui pode mandar um valor
                errado para o banco. Ela também é usada pela página 116 (window.ncMoeda, lida
                pelo Natcorp_Movimentacao.js).
     VISUAL     Natcorp_Beneficios.css › [C13] (máscara de dinheiro)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- máscara de dinheiro: R$ 999.999.990,90 ----------
     O campo de VERDADE do APEX continua com o número puro, no formato que a página já usa e o
     Oracle recebe hoje (vírgula decimal, sem ponto de milhar e sem "R$": 5200, 4028,85). A
     pessoa vê e digita numa caixa de exibição por cima (sem name: não é enviada); ao sair dela,
     o número puro vai para o campo de verdade por apex.item().setValue — as ações dinâmicas,
     as validações e o Salvar leem só ele. Quando o servidor muda o campo (o % que calcula o
     salário), a caixa se atualiza. window.ncMoeda serve à 116 (Natcorp_Movimentacao) também. */
  var MIL = new Intl.NumberFormat('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  function moedaTexto(n, prefixo) { return (prefixo ? 'R$ ' : '') + MIL.format(n); }
  /* o número puro no formato da página: inteiro sem decimais (5200) ou com vírgula (4028,85) */
  function moedaCru(n) { var c = Math.round(n * 100); return c % 100 === 0 ? String(c / 100) : (c / 100).toFixed(2).replace('.', ','); }
  /* o que a pessoa digitou: só dígitos e UMA vírgula (os pontos são de milhar, a máscara põe) */
  function moedaDigitado(t) {
    t = String(t || '').replace(/R\$\s?/g, '').replace(/\./g, '').replace(/[^\d,]/g, '');
    var i = t.indexOf(','), inteiro = (i < 0 ? t : t.slice(0, i)).replace(/^0+(?=\d)/, '').slice(0, 9), dec = i < 0 ? null : t.slice(i + 1).replace(/,/g, '').slice(0, 2);
    return { inteiro: inteiro, dec: dec };
  }
  function moedaAoDigitar(p, prefixo) {
    if (!p.inteiro && p.dec === null) return '';
    return (prefixo ? 'R$ ' : '') + (p.inteiro || '0').replace(/\B(?=(\d{3})+(?!\d))/g, '.') + (p.dec !== null ? ',' + p.dec : '');
  }
  function moedaSync(real) {
    var vis = real && real.__ncVis;
    if (!vis || document.activeElement === vis) return;
    var n = num(real.value);
    var t = real.value !== '' && isFinite(n) ? moedaTexto(n, vis.__ncPrefixo) : '';
    if (vis.value !== t) vis.value = t;
    var so = real.readOnly || real.disabled || real.classList.contains('apex_disabled');
    if (vis.readOnly !== so) vis.readOnly = so;
    vis.classList.toggle('apex_disabled', real.classList.contains('apex_disabled'));
  }
  function moedaAplicar(real, prefixo) {
    if (!real || real.tagName !== 'INPUT' || real.__ncVis) return;
    var vis = document.createElement('input');
    vis.type = 'text';
    vis.id = 'nc-moeda-' + real.id;
    vis.className = real.className.replace(/\b(number_field|text_field)\b/g, '') + ' nc-moeda';
    vis.setAttribute('inputmode', 'decimal');
    vis.setAttribute('autocomplete', 'off');
    vis.__ncPrefixo = !!prefixo;
    vis.placeholder = prefixo ? 'R$ 0,00' : '0,00';
    var lab = document.getElementById(real.id + '_LABEL');
    if (lab) { lab.htmlFor = vis.id; vis.setAttribute('aria-labelledby', lab.id); }
    real.parentNode.insertBefore(vis, real);
    real.classList.add('nc-moeda-real');
    real.tabIndex = -1;
    real.setAttribute('aria-hidden', 'true');
    real.__ncVis = vis;
    /* entrar no campo seleciona o valor (digitar já troca) — na hora do foco, antes do 1º dígito;
       o mouseup do clique desfaria a seleção, por isso é barrado uma vez */
    vis.addEventListener('focus', function () { try { vis.select(); } catch (e) {} vis.__ncSel = true; });
    vis.addEventListener('mouseup', function (e) { if (vis.__ncSel) { vis.__ncSel = false; e.preventDefault(); } });
    vis.addEventListener('keydown', function () { vis.__ncSel = false; });
    vis.addEventListener('input', function () {
      /* a máscara enquanto digita, com o cursor no mesmo dígito */
      var pos = vis.selectionStart, antes = vis.value.slice(0, pos).replace(/[^\d,]/g, '').length;
      var novo = moedaAoDigitar(moedaDigitado(vis.value), vis.__ncPrefixo);
      if (novo === vis.value) return;
      vis.value = novo;
      var k = 0, i = 0;
      for (; i < novo.length && k < antes; i++) if (/[\d,]/.test(novo[i])) k++;
      try { vis.setSelectionRange(i, i); } catch (e) {}
    });
    vis.addEventListener('change', function () {
      var p = moedaDigitado(vis.value), cru = '';
      if (p.inteiro || p.dec) { var n = parseFloat((p.inteiro || '0') + '.' + (p.dec || '0')); cru = moedaCru(n); vis.value = moedaTexto(n, vis.__ncPrefixo); }
      else vis.value = '';
      if (cru !== real.value) apex.item(real.id).setValue(cru);
    });
    vis.addEventListener('blur', function () { setTimeout(function () { moedaSync(real); }, 0); });
    $(real).on('change', function () { moedaSync(real); });
    moedaSync(real);
  }
  function moedaSyncTudo() { [].forEach.call(document.querySelectorAll('input.nc-moeda-real'), moedaSync); }
  window.ncMoeda = { aplicar: moedaAplicar, sync: moedaSync, syncTudo: moedaSyncTudo, cru: moedaCru };

  /* ═══ [J8] OPÇÃO, BENEFÍCIO E TIPO: BOTÕES E CARTÕES NO LUGAR DAS LISTAS ═════════════════
     O QUE FAZ  montarSegmento  item nc-ben-segmento (P168_OPCAO): dois botões lado a lado,
                                cada um com uma explicação curta embaixo.
                montarChips     item nc-ben-chips (P168_BENEFICIO): botões pequenos com
                                ilustração. Com UMA opção só, a pessoa toca nela (04/10).
                montarCartoes   item nc-ben-cartoes (P168_TIPO_BENEFICIO): cartões ilustrados;
                                o tipo que já está no pacote ganha o selo "Já no pacote".
     COMO       Os botões são feitos a partir das OPÇÕES da lista do APEX. Para mudar uma
                opção, mude a lista (LOV) no APEX. Clicar faz setValue na lista de verdade:
                as ações dinâmicas e cascatas disparam como antes.
     PODE MEXER • a lista "dicas" em montarSegmento: o texto pequeno de cada botão, pelo
                  VALOR da opção (C = Complementares, O = Obrigatórios).
                • 'Já no pacote'.
     VISUAL     Natcorp_Beneficios.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function opcoes(sel) { return [].slice.call(sel.options).filter(function (o) { return o.value !== ''; }); }
  function escolher(sel, v) { if (v !== sel.value) apex.item(sel.id).setValue(v); }

  function montarSegmento() {
    var sel = item('nc-ben-segmento');
    if (!sel || sel.tagName !== 'SELECT') return;
    var box = caixaDoItem(sel, 'nc-ben-ctrl-' + sel.id);
    if (!box) return;
    if (!box.getAttribute('role')) {
      box.setAttribute('role', 'radiogroup');
      box.setAttribute('aria-labelledby', rotuloId(sel));
      box.classList.add('nc-ben-segmento-ctrl');
      box.addEventListener('click', function (e) { var b = e.target.closest('button[data-v]'); if (b) escolher(sel, b.getAttribute('data-v')); });
    }
    var dicas = { C: 'Escolha livre, dentro do seu valor', O: 'Os que a empresa exige' };
    box.innerHTML = opcoes(sel).map(function (o) {
      return '<button type="button" role="radio" aria-checked="' + (o.value === sel.value) + '" data-v="' + esc(o.value) + '"><span>' + esc(bonito(o.text)) + '</span>' + (dicas[o.value] ? '<small>' + dicas[o.value] + '</small>' : '') + '</button>';
    }).join('');
  }

  function montarChips() {
    var sel = item('nc-ben-chips');
    if (!sel || sel.tagName !== 'SELECT') return;
    var ops = opcoes(sel);
    var c = containerDe(sel);
    /* 04/10 (cliente): com uma opção só, ela NÃO é escolhida sozinha — a pessoa toca nela */
    var box = caixaDoItem(sel, 'nc-ben-ctrl-' + sel.id);
    if (!box) return;
    if (!box.getAttribute('role')) {
      box.setAttribute('role', 'radiogroup');
      box.setAttribute('aria-labelledby', rotuloId(sel));
      box.classList.add('nc-ben-chips-ctrl');
      box.addEventListener('click', function (e) { var b = e.target.closest('button[data-v]'); if (b) escolher(sel, b.getAttribute('data-v')); });
    }
    if (c) c.classList.toggle('nc-ben-uma-opcao', ops.length < 2);
    box.innerHTML = ops.map(function (o) {
      var img = ILU[categoria(o.text)] || ILU.outro;
      return '<button type="button" role="radio" aria-checked="' + (o.value === sel.value) + '" data-v="' + esc(o.value) + '">' +
        (img ? '<span class="nc-ben-ilu nc-ben-ilu--chip" aria-hidden="true" style="background-image:url(' + img + ')"></span>' : '') + esc(bonito(o.text)) + '</button>';
    }).join('');
  }

  function montarCartoes() {
    var sel = item('nc-ben-cartoes');
    if (!sel || sel.tagName !== 'SELECT') return;
    var box = caixaDoItem(sel, 'nc-ben-ctrl-' + sel.id);
    if (!box) return;
    if (!box.getAttribute('role')) {
      box.setAttribute('role', 'radiogroup');
      box.setAttribute('aria-labelledby', rotuloId(sel));
      box.classList.add('nc-ben-cartoes-ctrl');
      box.addEventListener('click', function (e) { var b = e.target.closest('button[data-v]'); if (b) escolher(sel, b.getAttribute('data-v')); });
    }
    var grupo = item('nc-ben-chips');
    var noPacote = {};
    linhas(regiao('nc-ben-pacote')).forEach(function (i) { noPacote[(i.tipo || i.bene).toLowerCase()] = true; });
    box.innerHTML = '';
    opcoes(sel).forEach(function (o) {
      var b = el('button', 'nc-ben-cartao');
      b.type = 'button';
      b.setAttribute('role', 'radio');
      b.setAttribute('aria-checked', String(o.value === sel.value));
      b.setAttribute('data-v', o.value);
      b.appendChild(ilustra(categoria(o.text + ' ' + (grupo ? grupo.options[grupo.selectedIndex] && grupo.options[grupo.selectedIndex].text : ''))));
      b.appendChild(el('span', 'nc-ben-cartao-nome', esc(bonito(o.text))));
      if (noPacote[o.text.toLowerCase()]) b.appendChild(el('span', 'nc-ben-cartao-selo', 'Já no pacote'));
      box.appendChild(b);
    });
  }

  /* ═══ [J9] O VALOR: − / +, RÉGUA, ATALHOS E O AVISO DE SALDO ════════════════════════════
     O QUE FAZ  No item nc-ben-valor (P168_VALOR): botões − e + ao lado do campo, uma régua
                para arrastar, atalhos de um toque ("Mínimo", "Máximo" ou "Tudo o que sobra")
                e uma frase com a faixa permitida. Avisa ANTES quando o mínimo do benefício
                não cabe no saldo livre, e segura o "Adicionar" com um valor que o servidor
                recusaria (em vez da caixa de erro do APEX).
     LÊ DOS ITENS  P168_VALOR_MIN, P168_VALOR_MAX, P168_SALDO, P168_TIPO_BENEFICIO, e o botão
                de ID estático ADICIONAR.
     REGRAS     • O teto é o menor entre o máximo do benefício e o saldo livre.
                • Mínimo igual ao máximo (ex.: Gympass R$ 117,00) = valor fixo: já preenchido,
                  sem − e +.
                • O − e o + só avisam o servidor quando a pessoa para de tocar (450 ms): cada
                  aviso dispara as ações dinâmicas do valor.
     PODE MEXER as frases entre aspas ('Escolha um valor de', 'Valor fixo deste benefício',
                'Este benefício começa em', 'Mínimo', 'Tudo o que sobra'…).
     CUIDADO    As contas de centavos (arredondar o saldo PARA BAIXO) evitam que "Tudo o que
                sobra" seja recusado pelo servidor. Não mude.
     VISUAL     Natcorp_Beneficios.css › [C5] e [C13]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function limites() {
    var min = num(val(P + 'VALOR_MIN')), max = num(val(P + 'VALOR_MAX')), saldo = num(val(P + 'SALDO'));
    var teto = isFinite(max) ? max : NaN;
    if (isFinite(saldo) && saldo > 0 && isFinite(teto)) teto = Math.min(teto, saldo);
    /* centavos: o saldo pode vir com mais casas (751,40399) e o servidor compara arredondado —
       o teto é o saldo arredondado PARA BAIXO, assim "tudo o que sobra" sempre cabe */
    if (isFinite(teto)) teto = Math.floor(teto * 100 + 1e-6) / 100;
    var mn = isFinite(min) ? min : 0;
    /* valor fixo: mínimo igual ao máximo, ou só o mínimo (sem máximo) — o servidor responde
       "O Valor escolhido deve ser 117" (Gympass) */
    var fixo = isFinite(min) && min > 0 && (!isFinite(max) || Math.abs(max - min) < 0.005);
    return { min: mn, max: max, saldo: saldo, teto: fixo ? min : teto, fixo: fixo };
  }
  function centavos(v) { return Math.round(v * 100) / 100; }
  function emTexto(v) { return centavos(v).toFixed(2).replace('.', ','); }
  /* o valor válido para este benefício: dentro da faixa e do que sobra */
  function valorValido(v, lim) {
    if (!isFinite(v) || v <= 0) return false;
    if (v < lim.min - 0.004) return false;
    if (isFinite(lim.teto) && v > lim.teto + 0.004) return false;
    return true;
  }
  var T_VALOR = null, VALOR_PENDENTE = null;
  function mandarValor(input) { clearTimeout(T_VALOR); if (VALOR_PENDENTE !== null) { var v = VALOR_PENDENTE; VALOR_PENDENTE = null; apex.item(input.id).setValue(v); } }

  function montarValor() {
    var input = item('nc-ben-valor');
    if (!input || input.tagName !== 'INPUT') return;
    var wrap = input.closest('.t-Form-itemWrapper');
    if (wrap && !wrap.classList.contains('nc-ben-valor-linha')) {
      /* − e + ao lado do campo, dentro da mesma moldura; o campo não sai do lugar */
      wrap.classList.add('nc-ben-valor-linha');
      var menos = el('button', 'nc-ben-passo', '−'); menos.type = 'button'; menos.setAttribute('data-d', '-1'); menos.setAttribute('aria-label', 'Diminuir o valor');
      var mais = el('button', 'nc-ben-passo', '+'); mais.type = 'button'; mais.setAttribute('data-d', '1'); mais.setAttribute('aria-label', 'Aumentar o valor');
      var rs = el('span', 'nc-ben-rs', 'R$'); rs.setAttribute('aria-hidden', 'true');
      wrap.insertBefore(menos, wrap.firstChild);
      input.parentNode.insertBefore(rs, input);
      wrap.appendChild(mais);
      input.setAttribute('inputmode', 'decimal');
      moedaAplicar(input, false);
      /* − e + mudam o número na hora e só mandam ao servidor quando a pessoa para de tocar
         (cada envio dispara as ações dinâmicas do valor: antes eram ~8 chamadas por toque) */
      wrap.addEventListener('click', function (e) {
        var b = e.target.closest('.nc-ben-passo');
        if (!b || input.readOnly) return;
        var lim = limites();
        var faixa = (isFinite(lim.teto) ? lim.teto : lim.min + 1000) - lim.min;
        var passo = faixa > 1000 ? 50 : (faixa > 100 ? 10 : 1);
        var atual = num(input.value);
        var v = isFinite(atual) ? atual + passo * +b.getAttribute('data-d') : lim.min;
        if (isFinite(lim.teto)) v = Math.min(lim.teto, v);
        v = Math.max(lim.min, v);
        input.value = emTexto(v);
        VALOR_PENDENTE = input.value;
        if (input.__ncVis) input.__ncVis.value = moedaTexto(v, false);
        clearTimeout(T_VALOR);
        T_VALOR = setTimeout(function () { mandarValor(input); }, 450);
        montarValor();
      });
    }
    var box = caixaDoItem(input, 'nc-ben-ctrl-' + input.id);
    if (!box) return;
    if (!box.querySelector('.nc-ben-regua')) {
      box.innerHTML = '<input type="range" class="nc-ben-regua" aria-label="Valor do benefício" tabindex="-1"><div class="nc-ben-atalhos-valor"></div><ul class="nc-ben-limites"></ul>';
      var regua = box.querySelector('.nc-ben-regua');
      regua.addEventListener('input', function () { var v = num(regua.value); input.value = emTexto(v); if (input.__ncVis) input.__ncVis.value = moedaTexto(v, false); });
      regua.addEventListener('change', function () { var l = limites(), v = centavos(num(regua.value)); if (isFinite(l.teto)) v = Math.min(v, l.teto); apex.item(input.id).setValue(emTexto(v)); });
      /* atalhos: o mínimo, o máximo e "tudo o que sobra" — um toque e o valor está certo */
      box.querySelector('.nc-ben-atalhos-valor').addEventListener('click', function (e) {
        var b = e.target.closest('[data-v]'); if (!b) return;
        clearTimeout(T_VALOR); VALOR_PENDENTE = null;
        apex.item(input.id).setValue(b.getAttribute('data-v'));
      });
    }
    var lim = limites();
    var c = containerDe(input);
    /* o mínimo não cabe no que sobra: o servidor recusaria ("Este valor 117 está acima do
       saldo de 54") — a tela diz antes, e diz o que fazer */
    var naoCabe = isFinite(lim.min) && isFinite(lim.saldo) && lim.min > lim.saldo + 0.004;
    c.classList.toggle('nc-ben-nao-cabe', naoCabe);
    /* valor fixo (mínimo = máximo, ex.: Gympass R$ 117,00): já preenchido, sem − e + */
    var fixo = lim.fixo && !naoCabe;
    c.classList.toggle('nc-ben-valor-fixo', fixo);
    input.readOnly = fixo;
    var tipo = val(P + 'TIPO_BENEFICIO');
    if (tipo && input.__ncTipo !== tipo + '|' + lim.min + '|' + lim.max) {
      input.__ncTipo = tipo + '|' + lim.min + '|' + lim.max;
      /* um benefício novo escolhido: o campo já começa num valor que o servidor aceita */
      if (!naoCabe && isFinite(lim.min) && lim.min > 0 && (fixo || !valorValido(num(input.value), lim))) apex.item(input.id).setValue(emTexto(lim.min));
    }
    var r = box.querySelector('.nc-ben-regua');
    r.hidden = fixo || naoCabe || !(isFinite(lim.teto) && lim.teto > lim.min);
    if (!r.hidden) { r.min = lim.min; r.max = lim.teto; r.step = (lim.teto - lim.min) > 100 ? 1 : 0.5; var v = num(input.value); if (isFinite(v)) r.value = v; }
    var at = [];
    if (!fixo && !naoCabe && tipo) {
      if (lim.min > 0) at.push(['Mínimo', lim.min]);
      if (isFinite(lim.teto) && lim.teto > lim.min) at.push([isFinite(lim.max) && lim.teto < lim.max - 0.004 ? 'Tudo o que sobra' : 'Máximo', lim.teto]);
    }
    var atal = box.querySelector('.nc-ben-atalhos-valor');
    var hA = at.map(function (a) { return '<button type="button" class="nc-ben-atalho-valor" data-v="' + emTexto(a[1]) + '"><span>' + a[0] + '</span><b>' + brl(a[1]) + '</b></button>'; }).join('');
    if (atal.__h !== hA) { atal.__h = hA; atal.innerHTML = hA; }
    var frases = [];
    if (naoCabe) frases.push('<span class="nc-ben-aviso">Este benefício começa em <b>' + brl(lim.min) + '</b> e você tem <b>' + brl(Math.max(lim.saldo, 0)) + '</b> livres. Para escolhê-lo, remova ou diminua outro benefício do seu pacote.</span>');
    else if (fixo) frases.push('Valor fixo deste benefício: <b>' + brl(lim.min) + '</b>. É só tocar em Adicionar.');
    else if (tipo && isFinite(lim.teto)) frases.push('Escolha um valor de <b>' + brl(lim.min) + '</b> até <b>' + brl(lim.teto) + '</b>' + (isFinite(lim.max) && lim.teto < lim.max - 0.004 ? ' (o que sobra no seu saldo; o benefício vai até ' + brl(lim.max) + ')' : '') + '.');
    if (c.__ncInvalido) frases.push('<span class="nc-ben-aviso">' + c.__ncInvalido + '</span>');
    var hL = frases.map(function (t) { return '<li>' + t + '</li>'; }).join('');
    var ul = box.querySelector('.nc-ben-limites');
    if (ul.__h !== hL) { ul.__h = hL; ul.innerHTML = hL; }
    moedaSync(input);
  }
  /* "Adicionar" só com um valor que o servidor aceita: a caixa de OK do APEX ("O Valor
     escolhido deve estar entre 39 e 60") virava uma tentativa e erro — o aviso fica no campo */
  function guardarAdicionar() {
    document.addEventListener('click', function (e) {
      var b = e.target.closest && e.target.closest('#ADICIONAR');
      if (!b) return;
      var input = item('nc-ben-valor');
      if (!input || !input.offsetParent) return;
      mandarValor(input);
      var lim = limites(), v = num(input.value), c = containerDe(input), msg = '';
      if (!val(P + 'TIPO_BENEFICIO')) return;
      if (c.classList.contains('nc-ben-nao-cabe')) msg = 'Não cabe no saldo: remova ou diminua outro benefício antes.';
      else if (!valorValido(v, lim)) msg = isFinite(lim.teto) ? 'Para adicionar, escolha um valor de ' + brl(lim.min) + ' até ' + brl(lim.teto) + '.' : 'Para adicionar, escolha um valor a partir de ' + brl(lim.min) + '.';
      c.__ncInvalido = msg;
      if (!msg) { montarValor(); return; }
      e.preventDefault(); e.stopPropagation(); e.stopImmediatePropagation();
      montarValor();
      var alvo = input.__ncVis || input;
      try { alvo.focus({ preventScroll: true }); } catch (x) { alvo.focus(); }
      c.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }, true);
    $(document).on('change input', '#' + P + 'VALOR', function () { var c = containerDe(this); if (c && c.__ncInvalido) { c.__ncInvalido = ''; montarValor(); } });
  }


  /* ═══ [J10] OS CARTÕES DO PACOTE E DE HOJE ═══════════════════════════════════════════════
     O QUE FAZ  Cada linha de "Seu novo pacote", "O que você tem hoje" e "Benefícios
                Requisitados" vira um cartão: ilustração, nome, tipo embaixo, valor, e um selo
                com o que muda:
                  no pacote novo   "Novo" · "Igual a hoje" · "+ R$ …" · "− R$ …"
                  em hoje          "Sai do pacote" (o que não está no pacote novo)
                  no pedido gravado "Novo" · "Continua" · "Sai do pacote" (valor de antes riscado)
                O "Remover" do APEX (o mesmo link, que abre a confirmação) vai para o cartão.
                A linha do total vira "Total do novo pacote" / "Total hoje".
     PODE MEXER os textos dos selos e dos totais, entre aspas.
     CUIDADO    O candidato do portal (app 600) não tem "o que você tem hoje": por isso, lá,
                nada recebe "Novo" (veja o comentário de decorar).
     VISUAL     Natcorp_Beneficios.css › [C6] e [C10]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* o item de MediaList (portal) vira o mesmo cartão: nome e tipo, valor, e o "Remover" do
     APEX (o mesmo link, movido para o cartão) */
  function cartaoDaLista(i) {
    if (i.card) return;
    var li = i.tr;
    var card = el('div', 'nc-ben-li-card');
    var tipoTxt = bonito(i.tipo);
    var extra = [];
    if (i.qtd && +i.qtd > 1) extra.push(i.qtd + ' × ' + brl(i.escolhido));
    card.innerHTML = '<span class="nc-ben-li-bene"><span class="nc-ben-txt"><span class="nc-ben-txt-nome">' + esc(bonito(i.bene)) + '</span>' +
        (tipoTxt && tipoTxt.toLowerCase() !== bonito(i.bene).toLowerCase() ? '<small>' + esc(tipoTxt) + '</small>' : '') +
        (extra.length ? '<small>' + esc(extra.join(' · ')) + '</small>' : '') + '</span></span>' +
      '<span class="nc-ben-li-valor">' + (isFinite(i.valor) ? brl(i.valor) : '') + '</span>' +
      '<span class="nc-ben-li-remover"></span>';
    card.querySelector('.nc-ben-li-bene').insertBefore(ilustra(categoria(i.bene + ' ' + i.tipo), 'nc-ben-ilu--linha'), card.querySelector('.nc-ben-txt'));
    if (i.remover) {
      i.remover.classList.remove('t-Button--stretch');
      card.querySelector('.nc-ben-li-remover').appendChild(i.remover);
    }
    li.appendChild(card);
    li.classList.add('nc-ben-item', 'nc-ben-li');
    i.card = card;
    i.cv = card.querySelector('.nc-ben-li-valor');
  }
  /* outros = as linhas com que comparar; null = não há com que comparar (o candidato do portal
     não tem "o que você tem hoje": nada de "Novo" em tudo) */
  function decorar(reg, outros, modo) {
    if (!reg) return [];
    var semBase = outros === null;
    outros = outros || [];
    var itens = linhas(reg);
    var mapa = {};
    outros.forEach(function (o) { mapa[o.chave] = o; });
    itens.forEach(function (i, k) {
      if (i.lista) cartaoDaLista(i);
      else if (!i.cb.getAttribute('data-nc-txt')) {
        i.cb.setAttribute('data-nc-txt', i.bene);
        if (i.ct) i.ct.setAttribute('data-nc-txt', i.tipo);
        i.cv.setAttribute('data-nc-txt', i.cv.textContent.trim());
        var tipoTxt = bonito(i.tipo);
        /* nome e tipo na mesma célula, o tipo embaixo; a célula do tipo fica fora da vista */
        i.cb.innerHTML = '<span class="nc-ben-txt"><span class="nc-ben-txt-nome">' + esc(bonito(i.bene)) + '</span>' +
          (tipoTxt && tipoTxt.toLowerCase() !== bonito(i.bene).toLowerCase() ? '<small>' + esc(tipoTxt) + '</small>' : '') + '</span>';
        if (i.ct) i.ct.classList.add('nc-ben-tipo-junto');
        i.cv.textContent = brl(i.valor);
        i.cb.insertBefore(ilustra(categoria(i.bene + ' ' + i.tipo), 'nc-ben-ilu--linha'), i.cb.firstChild);
        i.tr.classList.add('nc-ben-item');
      }
      var velho = i.tr.querySelector('.nc-ben-selo');
      if (velho) velho.remove();
      var ant = i.tr.querySelector('.nc-ben-antes');
      if (ant) ant.remove();
      var par = mapa[i.chave], selo;
      var comparar = !semBase && (modo === 'pacote' || (modo === 'pedido' && outros.length));
      if (modo === 'pedido' && /remov/i.test(i.op)) {
        /* sai do pacote: o valor dele hoje riscado, no lugar do R$ 0,00 */
        selo = ['sai', 'Sai do pacote'];
        if (isFinite(i.anterior)) { i.cv.firstChild && i.cv.firstChild.nodeType === 3 && (i.cv.firstChild.textContent = ''); i.cv.insertBefore(el('s', 'nc-ben-antes', brl(i.anterior)), i.cv.firstChild); }
      } else if (modo === 'pedido' && /inser/i.test(i.op)) selo = ['novo', 'Novo'];
      else if (comparar) {
        if (!par) selo = ['novo', 'Novo'];     /* "-" que não existe hoje: é troca (Silver → Platinum) */
        else if (Math.abs(par.valor - i.valor) < 0.005) selo = ['igual', modo === 'pedido' ? 'Continua' : 'Igual a hoje'];
        else selo = [i.valor > par.valor ? 'mais' : 'menos', (i.valor > par.valor ? '+ ' : '− ') + brl(Math.abs(i.valor - par.valor))];
      } else if (modo === 'hoje' && !par) selo = ['sai', 'Sai do pacote'];
      if (selo) i.cv.appendChild(el('span', 'nc-ben-selo nc-ben-selo--' + selo[0], selo[1]));
      i.tr.classList.toggle('nc-ben-item--sai', !!selo && selo[0] === 'sai');
      if (i.tr.style.getPropertyValue('--nc-cor') !== CORES[k % CORES.length]) i.tr.style.setProperty('--nc-cor', CORES[k % CORES.length]);
    });
    var totalHoje = outros.reduce(function (a, o) { return a + (isFinite(o.valor) ? o.valor : 0); }, 0);
    reg.querySelectorAll('tr.nc-ben-linha-total td').forEach(function (td) {
      var t = td.textContent.trim();
      if (/total do relat/i.test(t)) td.textContent = modo === 'hoje' ? 'Total hoje' : 'Total do novo pacote';
      else if (/^R\$\s?[\d.,]+$/.test(t)) {
        var v = num(t), dif = v - totalHoje;
        td.innerHTML = esc(brl(v)) + (modo === 'pedido' && outros.length && Math.abs(dif) > 0.004
          ? ' <span class="nc-ben-dif nc-ben-dif--' + (dif > 0 ? 'mais' : 'menos') + '">' + (dif > 0 ? '+ ' : '− ') + esc(brl(Math.abs(dif))) + ' em relação a hoje</span>' : '');
      }
    });
    reg.querySelectorAll('a.apagarBeneficio').forEach(function (a) {
      if (a.__ncRot) return;
      var tr = a.closest('tr, li'), n = tr && (tr.querySelector('.nc-ben-txt small') || tr.querySelector('.nc-ben-txt-nome'));
      a.__ncRot = true;
      a.setAttribute('aria-label', 'Remover ' + (n ? n.textContent.trim() : bonito(a.getAttribute('data-id') || 'benefício')) + ' do pacote');
    });
    reg.classList.toggle('nc-ben-vazio', !itens.length);
    return itens;
  }
  /* "Benefícios Requisitados" (o pedido já gravado): pela classe ou, nas páginas que ainda não
     a têm, pelo ID estático / título da região — o JS põe a classe */
  function regiaoRequisitados() {
    var r = regiao('nc-ben-requisitados') || document.getElementById('BENEFICIOS_REQUISITADOS');
    if (!r) r = [].filter.call(document.querySelectorAll('.t-Region'), function (x) {
      var t = x.querySelector(':scope > .t-Region-header .t-Region-title');
      return t && /^benef[ií]cios requisitados/i.test(t.textContent.trim()) && !/\bold\b/i.test(t.textContent);
    })[0];
    if (r && !r.classList.contains('nc-ben-requisitados')) r.classList.add('nc-ben-requisitados');
    return r;
  }
  function montarRelatorios() {
    var pac = regiao('nc-ben-pacote'), hoje = regiao('nc-ben-hoje'), req = regiaoRequisitados();
    var a = linhas(hoje), p = linhas(pac), q = linhas(req);
    decorar(pac, hoje ? a : null, 'pacote');
    decorar(req, hoje ? a : null, 'pedido');
    /* o de hoje compara com o pacote novo; no pedido gravado ("Seu novo pacote" não existe),
       com o que foi pedido — sem os que saem */
    /* na Alteração Funcional (116) o "Novo pacote" existe também no pedido gravado, escondido e
       vazio: com os requisitados à vista, a comparação é com eles (senão tudo "sairia") */
    var novo = itensDoPacote();
    decorar(hoje, (pac || req) ? novo : [], 'hoje');
  }

  /* ═══ [J11] O PEDIDO JÁ GRAVADO ══════════════════════════════════════════════════════════
     O QUE FAZ  Só com a requisição já criada (P168_ROWID preenchido). A região que tem
                P168_COD_REQ vira uma faixa: "Pedido nº …", a situação em cor, "Aberto em …
                por …" e o botão de ver os dados de quem pediu. Não vale na página 116.
     LÊ DOS ITENS  P168_COD_REQ, P168_COD_SIT_REQ, P168_DT_REQ, P168_SOLICITANTE, P168_ROWID.
     PODE MEXER a lista SIT: para cada CÓDIGO de situação, [cor, texto].
                As cores possíveis: 'espera', 'bom', 'ruim', 'neutro' (definidas no CSS).
                Se o APEX mandar o texto da situação, ele vale no lugar do texto da lista.
     VISUAL     Natcorp_Beneficios.css › [C11]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- o pedido já gravado: nº, situação e quem pediu ----------
     A região do título ("Requisição de Benefícios: Nº 55808 - 19/05/2021 (Cancelada)", com
     Requisição / Situação / Data / Solicitante) vira uma faixa. Os campos continuam na região,
     fora da vista; o botão do solicitante (abre os dados dele) vai junto do nome. */
  /* PODE MEXER: código da situação: [cor, 'texto que aparece'] */
  var SIT = { '1': ['espera', 'Em aberto'], '2': ['bom', 'Concluída'], '3': ['neutro', 'Cancelada'], '4': ['ruim', 'Reprovada'], '5': ['bom', 'Aprovada'], '6': ['neutro', 'Suspensa'] };
  function txtItem(n) {
    var e = document.getElementById(P + n);
    if (!e) return '';
    if (e.tagName === 'SELECT') return e.selectedIndex >= 0 && e.value ? e.options[e.selectedIndex].text.trim() : '';
    if (/^(INPUT|TEXTAREA)$/.test(e.tagName)) return (e.value || '').trim();
    return (e.textContent || '').trim();
  }
  function montarPedido() {
    if (!val(P + 'ROWID') || !document.getElementById(P + 'COD_REQ')) return null;
    var reg = document.getElementById(P + 'COD_REQ').closest('.t-Region');
    if (!reg || reg.classList.contains('nc-ben-requisitados')) return null;
    reg.classList.add('nc-ben-pedido');
    var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    var f = document.getElementById('nc-ben-pedido');
    if (!f) {
      f = el('div', 'nc-ben-pedido-faixa', '<div class="nc-ben-pedido-conteudo"></div>'); f.id = 'nc-ben-pedido';
      (corpo || reg).insertBefore(f, (corpo || reg).firstChild);
    }
    var cod = val(P + 'COD_SIT_REQ');
    var sitTxt = txtItem('COD_SIT_REQ');
    var sit = SIT[cod] || ['neutro', ''];
    if (sitTxt && !/^\d+$/.test(sitTxt)) sit = [sit[0] === 'neutro' && /abert/i.test(sitTxt) ? 'espera' : sit[0], bonito(sitTxt)];
    if (!sit[1]) { var m = /\(([^)]+)\)\s*$/.exec((reg.querySelector('.t-Region-title') || {}).textContent || ''); sit[1] = m ? m[1] : 'Situação'; }
    var sol = txtItem('SOLICITANTE').split(/\s+\/\s+/);
    var quem = bonito(semCodigo(sol[1] || sol[0] || '')), cargo = sol[2] ? bonito(semCodigo(sol[2])) : '';
    var data = txtItem('DT_REQ');
    var h = '<div class="nc-ben-pedido-topo"><p class="nc-ben-pedido-n">Pedido nº <b>' + esc(val(P + 'COD_REQ')) + '</b></p>' +
      '<span class="nc-ben-sit nc-ben-sit--' + sit[0] + '">' + esc(sit[1]) + '</span></div>' +
      '<p class="nc-ben-pedido-quem">' + (data ? 'Aberto em <b>' + esc(data.replace(/\s.*$/, '')) + '</b>' : 'Aberto') +
        (quem ? ' por <b>' + esc(quem) + '</b>' + (cargo ? ' <span class="nc-ben-sutil">· ' + esc(cargo) + '</span>' : '') : '') + '</p>';
    var cx = f.querySelector('.nc-ben-pedido-conteudo');   /* o botão do solicitante mora fora dele */
    if (cx.__h !== h) { cx.__h = h; cx.innerHTML = h; }
    var btn = document.getElementById('p168_btn_solicitante') || [].filter.call(reg.querySelectorAll('button.t-Button, a.t-Button'), function (b) { return !f.contains(b); })[0] || f.querySelector('.nc-ben-pedido-ver');
    if (btn && btn.parentNode !== f) { btn.classList.add('nc-ben-pedido-ver'); btn.setAttribute('title', 'Ver os dados de quem pediu'); f.appendChild(btn); }
    return reg;
  }

  /* ═══ [J12] O CAMINHO DA APROVAÇÃO ═══════════════════════════════════════════════════════
     O QUE FAZ  Transforma o relatório "Aprovadores" numa faixa logo abaixo do pedido: o resumo
                ("1 de 2 · aguardando Fulano", "é a sua vez"), cada aprovador com um sinal
                (aprovou, reprovou, aguardando, na fila) e o que cada um escreveu.
                Os botões Aprovar/Reprovar do APEX vão para dentro da faixa — os mesmos botões,
                com os mesmos cliques. No celular, a lista abre por "Ver o caminho".
     LÊ DAS COLUNAS  APROVADOR, DATA, STATUS, JUSTIFICATIVA (pelo nome da coluna).
     CUIDADO    Se uma dessas colunas for renomeada no relatório, a faixa não acha os dados.
                Os botões são achados pelo TEXTO: precisam se chamar "Aprovar" e "Reprovar".
     PODE MEXER os textos entre aspas: 'Aprovação', 'Ver o caminho', 'é a sua vez',
                'Confira o pedido e decida.', 'Na fila'…
     VISUAL     Natcorp_Beneficios.css › [C12]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- o caminho da aprovação (o mesmo desenho da Requisição, do Desligamento, do
     Treinamento e do Atestado) ----------
     O relatório "Aprovadores" vira uma faixa logo abaixo do pedido: o resumo ("1 de 2 ·
     aguardando Fulano"), os aprovadores em linha ligados por um fio e o que cada um escreveu.
     Os botões Aprovar/Reprovar do APEX (só para quem aprova) vão para dentro dela — os mesmos
     botões, com os mesmos cliques e ações. A tabela continua na região, fora da vista. */
  var AP = null, AP_ABERTO = false, AP_ASSIN = '';
  function limpo(t) { t = String(t || '').replace(/\s+/g, ' ').trim(); return /^[-–—]?$/.test(t) ? '' : t; }
  function nomeAprovador(t) {
    var m = /^\s*\d+\s*-\s*\d+\s*-\s*(.+)$/.exec(t || '');
    return bonito(m ? m[1] : t).replace(/(^|\s)(\S)/g, function (x, a, b) { return a + b.toUpperCase(); }).replace(/\s(De|Da|Do|Das|Dos|E)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  function montarAprovacao(pedido) {
    if (!AP) {
      var th = document.querySelector('table.t-Report-report th#APROVADOR, td[headers="APROVADOR"]');
      var reg = th && th.closest('.t-Region');
      if (!reg) return;
      /* 04/10: TODOS os Aprovar/Reprovar que o servidor desenhou, mesmo os que uma ação dinâmica
         escondeu na abertura: se outra ação os mostrar depois (a situação volta a 1), eles têm de
         aparecer — a região de onde vêm fica fora da vista. Quem decide a vista é o style da página */
      AP = { reg: reg, botoes: [].slice.call(document.querySelectorAll('button.t-Button, a.t-Button')).filter(function (b) {
        return /^(aprovar|reprovar)$/i.test(b.textContent.trim());
      }) };
      reg.classList.add('nc-ben-aprov');
      /* sobe para logo abaixo do pedido, na largura toda; a coluna de onde saiu some */
      var ancora = pedido && (pedido.closest('.row') || pedido);
      if (ancora && ancora.parentNode) {
        var col = reg.parentElement && reg.parentElement.classList.contains('col') ? reg.parentElement : null;
        ancora.parentNode.insertBefore(reg, ancora.nextSibling);
        if (col && !col.querySelector('.t-Region')) {
          col.classList.add('nc-ben-col-vazia');
          var vizinha = pedido.parentElement && pedido.parentElement.classList.contains('col') ? pedido.parentElement : null;
          if (vizinha) vizinha.classList.add('nc-ben-col-cheia');
        }
      }
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
      AP.box = el('div', 'nc-ben-caminho');
      corpo.insertBefore(AP.box, corpo.firstChild);
      AP.box.addEventListener('click', function (e) { if (e.target.closest('.nc-ben-caminho-ver')) { AP_ABERTO = !AP_ABERTO; AP_ASSIN = ''; agendar(); } });
    }
    var passos = [].slice.call(AP.reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; }
      var st = c('STATUS');
      return { nome: nomeAprovador(c('APROVADOR')), data: c('DATA'), just: c('JUSTIFICATIVA'), status: st,
        estado: /^r$|reprov|recus/i.test(st) ? 'nao' : /^a$|aprov/i.test(st) ? 'ok' : 'pend' };
    }).filter(function (x) { return x.nome || x.status; });
    var n = passos.length;
    AP.reg.classList.toggle('nc-ben-aprov--vazio', !n);
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; });
    var atual = -1;
    if (!reprovado) for (var i = 0; i < n; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var aprovados = passos.filter(function (x) { return x.estado === 'ok'; }).length;
    var sit = val(P + 'COD_SIT_REQ') || '';
    var cancelado = sit === '3' || sit === '6' || /cancel|suspens/i.test(txtItem('COD_SIT_REQ'));
    var bts = AP.botoes.filter(function (b) { return b.style.display !== 'none'; });
    var vez = bts.length > 0 && !cancelado && atual >= 0;   /* só há o que decidir com uma etapa pendente */
    var assin = JSON.stringify([passos, atual, bts.length, cancelado, AP_ABERTO]);
    if (assin === AP_ASSIN) return;
    AP_ASSIN = assin;
    if (!n) { AP.box.innerHTML = ''; return; }
    var quemNao = passos.filter(function (x) { return x.estado === 'nao'; })[0];
    var estado = reprovado ? 'nao' : cancelado ? 'neutro' : atual < 0 ? 'ok' : vez ? 'vez' : 'pend';
    var resumo = reprovado ? '<b>Reprovado</b> por ' + esc(quemNao.nome)
      : cancelado ? '<b>Pedido ' + (sit === '6' ? 'suspenso' : 'cancelado') + '</b> · ' + aprovados + ' de ' + n + ' aprovaram'
      : atual < 0 ? '<b>Aprovado</b> por ' + (n === 1 ? esc(passos[0].nome) : 'todos')
      : vez ? '<b>' + aprovados + ' de ' + n + '</b> · <b>é a sua vez</b>'
      : '<b>' + aprovados + ' de ' + n + '</b> · aguardando <b>' + esc(passos[atual].nome) + '</b>';
    var justs = passos.filter(function (x) { return x.just; });
    AP.reg.classList.toggle('nc-ben-ap-aberto', AP_ABERTO);
    AP.box.className = 'nc-ben-caminho nc-ben-caminho--' + estado;
    AP.box.innerHTML =
      '<p class="nc-ben-caminho-rot">Aprovação</p><div class="nc-ben-caminho-cab"><p class="nc-ben-caminho-resumo">' + resumo + '</p>' +
        '<button type="button" class="nc-ben-caminho-ver" aria-expanded="' + AP_ABERTO + '">' + (AP_ABERTO ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
      '<ol class="nc-ben-passos-ap">' + passos.map(function (x, i) {
        var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === atual && !cancelado ? 'is-vez' : 'is-fila';
        var dia = x.data.replace(/\s.*$/, '');
        var st = x.estado === 'ok' ? (dia || 'Aprovou') : x.estado === 'nao' ? 'Reprovou' + (dia ? ' · ' + dia : '') : cls === 'is-vez' ? (vez ? 'Sua vez' : 'Aguardando') : 'Na fila';
        var ic = x.estado === 'ok' ? '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>' : x.estado === 'nao' ? '<path d="M8 8l8 8M16 8l-8 8"/>' : cls === 'is-vez' ? '<path d="M12 8v4l2.5 1.5"/>' : '';
        var dica = x.nome + ' — ' + (x.estado === 'ok' ? 'aprovou' + (x.data ? ' em ' + x.data : '') : x.estado === 'nao' ? 'reprovou' + (x.data ? ' em ' + x.data : '') : cls === 'is-vez' ? 'aguardando a aprovação' : 'na fila') + (x.just ? ': "' + x.just + '"' : '');
        return '<li class="nc-ben-ap ' + cls + '" title="' + esc(dica) + '"><span class="nc-ben-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
          '<span class="nc-ben-ap-texto"><span class="nc-ben-ap-nome">' + esc(x.nome || 'Aprovador') + '</span><span class="nc-ben-ap-estado">' + esc(st) + '</span></span></li>';
      }).join('') + '</ol>' +
      /* 04/10: os botões que a PÁGINA mostra vão sempre para cá (antes, só com "é a sua vez" pela
         leitura da tabela — fora disso ficavam na região escondida e sumiam) */
      (bts.length ? '<div class="nc-ben-decisao"><p class="nc-ben-decisao-txt">Confira o pedido e decida.</p><div class="nc-ben-decisao-botoes" aria-label="Sua decisão"></div></div>' : '') +
      (justs.length ? '<div class="nc-ben-ap-justs">' + justs.map(function (x) {
        return '<blockquote class="nc-ben-ap-just' + (x.estado === 'nao' ? ' is-nao' : '') + '"><b>' + esc(x.nome) + (x.estado === 'nao' ? ' reprovou' : x.estado === 'ok' ? ' aprovou' : '') + ':</b> ' + esc(x.just) + '</blockquote>';
      }).join('') + '</div>' : '');
    var dest = AP.box.querySelector('.nc-ben-decisao-botoes');
    if (dest) bts.slice().sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) {
      b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-ben-reprovar' : 'nc-ben-aprovar');
      dest.appendChild(b);
    });
  }

  /* ═══ [J13] O RESUMO NA BARRA DOS BOTÕES ═════════════════════════════════════════════════
     O QUE FAZ  Na região nc-ben-acoes (presa ao pé da tela), ao lado dos botões:
                "3 benefícios no pacote · R$ … de R$ … · R$ … livres", ou
                "Seu pacote ainda está vazio".
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_Beneficios.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarResumo(itens, total, saldo) {
    var reg = regiao('nc-ben-acoes');
    if (!reg) return;
    var r = document.getElementById('nc-ben-resumo');
    if (!r) {
      r = el('p', 'nc-ben-resumo'); r.id = 'nc-ben-resumo';
      var meio = reg.querySelector('.t-ButtonRegion-col--content') || reg.querySelector('.t-ButtonRegion-wrap') || reg;
      meio.insertBefore(r, meio.firstChild);
    }
    var n = itens.length;
    r.hidden = !val(P + NOME.matricula);
    r.innerHTML = n
      ? '<b>' + n + (n === 1 ? ' benefício' : ' benefícios') + '</b> no pacote · ' + brl(total - (isFinite(saldo) ? saldo : 0)) + ' de ' + brl(total) + (saldo > 0.004 ? ' · <span class="nc-ben-sutil">' + brl(saldo) + ' livres</span>' : '')
      : 'Seu pacote ainda está vazio';
  }

  /* ═══ [J14] O MAESTRO: QUANDO CADA PARTE É MONTADA ══════════════════════════════════════
     O QUE FAZ  tudo() chama as partes acima, nesta ordem. iniciar() roda uma vez quando a
                página abre e depois manda montar tudo de novo sempre que algo muda: um item
                muda de valor, um relatório é recarregado, uma ação dinâmica traz valores do
                servidor, uma janela (o "Remover") fecha.
     CUIDADO    Não mude a ordem das chamadas em tudo(): o saldo precisa dos cartões já lidos.
                As remontagens esperam um "respiro" de 100 ms: as ações dinâmicas disparam
                dezenas de chamadas seguidas, e redesenhar a cada uma travava o navegador.
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp benefícios] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tudo() {
    montarPerfil();
    /* o pedido e a aprovação: só na Requisição de Benefícios (a 116 tem a tela dela) */
    if (pag !== '116') montarAprovacao(montarPedido());
    montarRelatorios();
    montarSegmento();
    montarChips();
    montarCartoes();
    montarValor();
    montarSaldo();
  }
  /* uma passada por "respiro": as ações dinâmicas disparam dezenas de chamadas seguidas e
     redesenhar a cada uma ocupava o navegador junto com elas (o mesmo da Alteração Funcional) */
  var T_AGENDA = null;
  function agendar() {
    clearTimeout(T_AGENDA);
    T_AGENDA = setTimeout(function () { try { tudo(); } catch (e) { if (window.console) console.warn('[Natcorp benefícios]', e); } }, 100);
  }
  function iniciar() {
    document.body.classList.add('nc-ben');
    guardarAdicionar();
    tudo();
    /* o que o APEX muda chega por aqui: valores postos pelas ações dinâmicas (change),
       listas em cascata e relatórios recarregados (apexafterrefresh), diálogo de remover */
    $(document).on('change', '[id^="' + P + '"]', agendar);
    $(document).on('apexafterrefresh', agendar);
    /* valores trazidos do servidor por ação dinâmica (Executar PL/SQL, "itens a retornar")
       chegam SEM o evento change: sem isto a tela ficava com a leitura de antes da resposta */
    $(document).ajaxStop(agendar);
    $(document).ajaxStop(moedaSyncTudo);
    $(document).on('apexafterclosedialog dialogclose', function () { setTimeout(agendar, 60); });
    /* 04/10: de novo depois das ações dinâmicas de abertura (esconder/mostrar/desabilitar com
       "Executar na inicialização"): a primeira passada pode ter lido o estado de antes delas */
    $(window).on('apexreadyend', agendar);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
