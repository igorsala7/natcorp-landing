/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · ALTERAÇÃO FUNCIONAL  —  o "arrumador" da tela (JavaScript)                     ║
   ║  App 200 (Painel do Operador) · Página 116 · o gestor movimenta, transfere ou promove     ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns. Guia desta página: MOVIMENTACAO-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quando a página 116 abre, ele REORGANIZA o que o APEX já desenhou, em passos numerados como
   nas outras requisições:
     1 Quem vai mudar?      o colaborador e como ele está hoje
     2 O que você quer fazer?  cartões por intenção (Promoção, Transferência, Jornada…), que
                            marcam as caixas P116_BLK_* de verdade
     3 Preencha como fica   cada bloco de alteração (Empresa, Cargo, Salário…) vira uma linha
                            "Hoje → Como fica"; só um bloco fica aberto por vez
     4 Confira e explique   o quadro Antes | Depois e o motivo (Parecer), com começos de frase
   Mais: valores em reais (R$), uma barra no pé da tela com o que falta e o botão Enviar e,
   num pedido já gravado, o cabeçalho, o caminho da aprovação e "o que muda" logo no alto,
   para quem aprova (RH, diretoria, remuneração).
   Uso: 60% no computador e 40% no celular.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda campos de lugar no banco, não renomeia, não duplica nada e não grava nada.
     • As regras (motivos, datas, pisos, parcelamento, benefícios obrigatórios…) continuam nas
       ações dinâmicas e nos pacotes do APEX. Aqui só se LÊ o que a página decidiu.
     • Os benefícios desta página são desenhados por OUTRO arquivo: Natcorp_Beneficios.js
       (classes nc-ben-*). A máscara de dinheiro (R$) também vem de lá.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 116 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Movimentacao.js
     Página 116 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Movimentacao.css
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Movimentacao.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Classes postas nas regiões (Page Designer › clique na região › Appearance › CSS Classes):
     nc-mov-intencoes   "O que você quer fazer?" (a região das caixas P116_BLK_*) → cartões
                        por intenção, que marcam as caixas de verdade
     nc-mov-alteracoes  "Alterações": só tira da vista as abas repetidas
     nc-mov-bloco       cada bloco de alteração (Empresa, Cargo, Salário…) → cabeçalho com o
                        nome e a mudança ("Hoje → Como fica")
     nc-mov-hoje        a região "…Atual" do bloco: coluna estreita, só leitura
     nc-mov-depois      a região "…Proposta" do bloco: o formulário
     nc-mov-salario     o bloco Salário: valores em reais e a diferença
     nc-mov-resumo      "Resumo da movimentação": cada mudança e o que falta
     nc-mov-acoes       região de botões (Voltar…); o Enviar/Salvar vai para a barra do pé
   Classe posta em ITENS (item › Advanced › CSS Classes):
     nc-mov-moeda       valor de leitura mostrado em reais (R$ 21.495,65)
     No Universal Theme, a classe do item vai para o CONTÊINER do item (rótulo + campo).
   Achados SEM classe:
     • o cabeçalho do pedido: a região que contém o item P116_COD_SOLICITACAO;
     • a aprovação: o relatório com a coluna APROVADOR;
     • os botões Enviar e Salvar: pelos Static ID  CREATE  e  SAVE;
     • os botões de decisão: pelos textos exatos "Aprovar" e "Reprovar";
     • cada bloco: pelo TÍTULO da região (lista BLOCO_DE em [J2]).
   Os itens são lidos pelo nome completo, 'P116_…'. Se a página for copiada para outro número
   (ex.: 216), troque TODOS os 'P116_' deste arquivo (Ctrl+H, "substituir tudo") por 'P216_'.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Ferramentas ............................ funções pequenas usadas no arquivo todo
     [J2]  Passo 2: "O que você quer fazer?" ...... as categorias e o que cada uma muda  PODE MEXER
     [J3]  Passo 3: os blocos Hoje → Como fica .... a fila de blocos, só um aberto
     [J4]  Reais e salário ......................... R$ e a diferença do salário
     [J5]  Passo 4: o quadro Antes | Depois ........ o que muda, para quem aprova
     [J6]  Os títulos dos passos ................... "Quem vai mudar?" etc.            PODE MEXER
     [J7]  O Parecer ............................... começos de frase do motivo       PODE MEXER
     [J8]  O pedido gravado e a aprovação .......... cabeçalho, caminho, Aprovar/Reprovar
     [J9]  A barra do pé ........................... o que falta, Enviar, erros do servidor
     [J10] Benefícios e "Alterações" ............... arranjo das colunas, sem abas repetidas
     [J11] O maestro ............................... decide QUANDO cada parte é montada  CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Quem vai mudar?'  →  'Colaborador'
     Criei um bloco de alteração novo (uma caixa P116_BLK_NOVO e a região do bloco)
       → [J2]: acrescente a caixa na lista BLOCO_DE (com um pedaço do título da região) e,
         para ela aparecer num cartão, num item de CATEGORIAS. Dê à região a classe nc-mov-bloco
         e às sub-regiões as classes nc-mov-hoje e nc-mov-depois.
     Renomeei o título de uma região de bloco e o cartão do passo 2 não abre mais o bloco
       → [J2], lista BLOCO_DE: o título novo precisa ainda casar com o padrão de busca.
     Quero mudar os motivos sugeridos no Parecer             → [J7], lista MOTIVOS.
     Criei um campo de dinheiro novo e quero a máscara R$     → [J11], lista CAMPOS_MOEDA.
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp movimentação].
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
     'P116_' + 'OBS'        junta os textos: vira 'P116_OBS', o nome do item no APEX.
     val(…)                 lê o que está num item do APEX (veja [J1]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: esta linha impede que o arquivo rode duas vezes (se a URL estiver repetida na
     página, por exemplo) e que rode fora do APEX. Não apague. */
  if (window.__ncMovimentacao || !window.apex || !window.apex.jQuery) return;
  window.__ncMovimentacao = true;

  var $ = apex.jQuery;

  /* ═══ [J1] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo: ler um item do APEX, escrever um
                valor em reais, achar uma região pela classe. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('P116_ITEM')   o que o APEX GUARDA no item (o código da opção, ex.: 'S')
       texto(campo)       o que a PESSOA VÊ no campo (o nome da opção escolhida numa lista)
       cont('ITEM')       o bloco inteiro do campo na tela (rótulo + campo), sem o 'P116_'
       regiao('x') / regioes('x')   a região (ou as regiões) que têm a classe x no APEX
       brl(1500)          "R$ 1.500,00";  num('1.500,00') → 1500 (o número puro)
       camposDe(região)   os campos à vista numa região, com o rótulo e o valor
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MOEDA = new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' });
  var PCT = new Intl.NumberFormat('pt-BR', { maximumFractionDigits: 1, signDisplay: 'always' });
  function brl(n) { return isFinite(n) ? MOEDA.format(n).replace(/ /g, ' ') : ''; }
  function num(t) {
    t = String(t === null || t === undefined ? '' : t).replace(/[^\d,.\-]/g, '');
    if (!t) return NaN;
    if (t.indexOf(',') > -1) t = t.replace(/\./g, '').replace(',', '.');
    return parseFloat(t);
  }
  function val(id) { var it = apex.item(id); return it && it.node ? String(it.getValue() || '') : ''; }
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function visivel(e) { for (; e && e !== document.body; e = e.parentElement) if (e.style && e.style.display === 'none' || e.hidden || e.classList.contains('u-hidden')) return false; return !!e; }
  function regioes(cls) { return [].slice.call(document.querySelectorAll('.t-Region.' + cls + ', .t-ButtonRegion.' + cls)); }
  function regiao(cls) { return regioes(cls)[0] || null; }
  function corpoDe(reg) { return reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg.querySelector('.t-Region-body') || reg; }
  function titulo(reg) { var h = reg.querySelector(':scope > .t-Region-header .t-Region-title'); return h ? h.textContent.trim() : ''; }
  function vazio(t) { return !t || /^\s*(-\s*selecione\s*-|-)\s*$/i.test(t); }
  /* "624 - Supervisor De Setor" → "624 - Supervisor de Setor": o código fica (é por ele que o RH
     procura), só a caixa das palavras de ligação muda */
  function minusculas(t) { return String(t || '').replace(/(\s)(De|Da|Do|Das|Dos|E|Em|Para)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); }); }
  function codDesc(t) { return minusculas(String(t || '').replace(/\s+/g, ' ').trim()); }
  function semCodigo(t) { return minusculas(String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim()); }
  function cont(n) { return document.getElementById('P116_' + n + '_CONTAINER'); }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  var PEDIDO = false;
  function texto(campo) {
    if (!campo) return '';
    if (campo.tagName === 'SELECT') { var o = campo.options[campo.selectedIndex]; return o && o.value !== '' ? o.text.trim() : ''; }
    return String(campo.value || '').trim();
  }

  /* os campos de um bloco: rótulo + campo, só os que estão à vista */
  function camposDe(reg) {
    return [].slice.call(reg.querySelectorAll('.t-Form-fieldContainer')).filter(visivel).map(function (c) {
      var campo = c.querySelector('select, textarea, input:not([type="hidden"]):not([type="file"])');
      var l = c.querySelector('.t-Form-label');
      return { c: c, campo: campo, rotulo: l ? l.textContent.replace(/\s+/g, ' ').trim() : '', valor: texto(campo) };
    }).filter(function (f) { return f.campo; });
  }
  /* o campo que diz "o quê" do bloco: o primeiro que não é data, motivo nem pergunta */
  var SECUNDARIO = /^(\d+ª\s+)?(data|motivo|alteração|deseja|parcelamento|%|valor do auxílio|categoria)/i;
  function principal(campos) { return campos.filter(function (f) { return !SECUNDARIO.test(f.rotulo); })[0] || null; }
  /* dinheiro: rótulo de salário/remuneração/valor, mas não "Data do Valor" nem um valor que é data */
  function dinheiro(f) { return f && /sal[aá]rio|remunera|valor/i.test(f.rotulo) && !/^(\d+ª\s+)?data/i.test(f.rotulo) && !/^\d{1,2}\/\d{1,2}\/\d{2,4}/.test(f.valor) && isFinite(num(f.valor)); }
  function mostrar(f) { return !f || vazio(f.valor) ? '' : dinheiro(f) ? brl(num(f.valor)) : codDesc(f.valor); }

  /* ═══ [J2] PASSO 2: "O QUE VOCÊ QUER FAZER?" ══════════════════════════════════════════════
     O QUE FAZ  Na região nc-mov-intencoes, troca as caixas de marcar P116_BLK_* por cartões de
                intenção (Vaga, Promoção, Transferência, Jornada, Reajuste, Situação). Cada cartão
                abre a lista do que pode mudar nele; cada item da lista marca ou desmarca a caixa
                de verdade — por isso as ações dinâmicas do APEX continuam valendo.
     PODE MEXER a lista CATEGORIAS:
                  nome     o título do cartão           desc      a frase pequena embaixo
                  pergunta o título da lista aberta     nota      um aviso dentro da lista
                  itens    pares ['CAIXA', 'Texto'] — a caixa é o nome do item SEM o
                           'P116_BLK_'; o texto é o que a pessoa lê
     CUIDADO    • BLOCO_DE liga cada caixa ao bloco dela pelo TÍTULO da região (em minúsculas):
                  /^cargo/ = "título que começa com cargo". Se renomear a região no APEX,
                  confira se o padrão ainda casa.
                • Não mude os "id" das categorias ('vaga', 'promocao'…): o visual usa esses nomes.
     VISUAL     Natcorp_Movimentacao.css › [C1]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- nc-mov-intencoes: o que o gestor quer fazer ----------
     Cada categoria abre a lista do que pode mudar nela (uma transferência pode ser só o centro
     de custo, a unidade e a atividade). Cada item marca ou desmarca a caixa P116_BLK_* de
     verdade (apex.item().setValue): as ações dinâmicas de sempre mostram o bloco e, ao
     desmarcar, escondem e LIMPAM o que foi preenchido nele. O estado vem sempre das caixas.
     Vaga é o headcount controlado: no APEX, marcar a Vaga desmarca os outros blocos (fica o
     Salário) — a categoria diz isso. */
  var ICONE = {
    vaga: '<rect x="3.5" y="7" width="17" height="12.5" rx="2"/><path d="M8.5 7V5.5A1.5 1.5 0 0 1 10 4h4a1.5 1.5 0 0 1 1.5 1.5V7M3.5 12.5h17"/>',
    promocao: '<path d="M4 19h4v-5H4zM10 19h4V9h-4zM16 19h4V4h-4z"/><path d="M5 9.5 10 5l3 2.5L18 3"/>',
    transferencia: '<path d="M4 8h13l-3.5-3.5M20 16H7l3.5 3.5"/>',
    jornada: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    reajuste: '<path d="M12 3v18M16.5 7.5C16 6 14.3 5 12 5c-2.6 0-4.5 1.3-4.5 3.2 0 4.4 9 2.4 9 7 0 1.9-2 3.3-4.5 3.3-2.4 0-4.2-1-4.8-2.6"/>',
    situacao: '<path d="M5 21V4M5 4h11l-2 4 2 4H5"/>'
  };
  /* PODE MEXER: as categorias do passo 2 (títulos, frases e os itens de cada uma) */
  var CATEGORIAS = [
    { id: 'vaga', nome: 'Vaga', desc: 'Headcount controlado: vaga e salário', pergunta: 'O que muda na vaga?',
      itens: [['VAGA', 'Vaga'], ['SALARIO', 'Salário']],
      nota: 'A vaga não combina com as outras opções: ao marcar a vaga, os outros blocos saem do pedido.' },
    { id: 'promocao', nome: 'Promoção', desc: 'Cargo, função e salário', pergunta: 'O que muda na promoção?',
      itens: [['CARGO', 'Cargo e função'], ['SALARIO', 'Salário']] },
    { id: 'transferencia', nome: 'Transferência', desc: 'Empresa, filial, centro de custo, local…', pergunta: 'O que muda na transferência?',
      itens: [['EMPRESA', 'Empresa'], ['FILIAL', 'Filial'], ['HIERARQUIA', 'Centro de custo (célula)'], ['UNID_ADM', 'Unidade administrativa (cliente)'],
        ['ATIVIDADE', 'Atividade (serviço)'], ['CCUSTO_CONT', 'Centro de custo contábil e unidade de negócio'], ['LOCAL', 'Local de trabalho'],
        ['SINDICATO', 'Sindicato'], ['VALOR_FATURAVEL', 'Valor faturável']] },
    { id: 'jornada', nome: 'Jornada ou horário', desc: 'Jornada, horário ou modalidade', pergunta: 'O que muda na jornada?',
      itens: [['JORNADA', 'Jornada'], ['HORARIO', 'Horário de trabalho'], ['TIPO_MODALIDADE', 'Tipo de modalidade (presencial / home office)']] },
    { id: 'reajuste', nome: 'Reajuste de salário', desc: 'Muda só o salário', itens: [['SALARIO', 'Salário']] },
    { id: 'situacao', nome: 'Situação', desc: 'Afastamento, licença ou retorno', itens: [['SITUACAO', 'Situação']] }
  ];
  /* os blocos de cada caixa, pelo título da região (para abrir o bloco do item que a pessoa marcou)
     CUIDADO: cada linha é  CAIXA: /começo do título da região/  — em minúsculas */
  var BLOCO_DE = { VAGA: /^vaga$/, EMPRESA: /^empresa$/, FILIAL: /^filial$/, HIERARQUIA: /^centro de custo \(c/, UNID_ADM: /^unidade administrativa/,
    ATIVIDADE: /^atividade/, CCUSTO_CONT: /cont[aá]bil/, VALOR_FATURAVEL: /fatur[aá]vel/, CARGO: /^cargo/, LOCAL: /^local/, SINDICATO: /^sindicato/,
    JORNADA: /^jornada/, TIPO_MODALIDADE: /modalidade/, HORARIO: /^hor[aá]rio/, SALARIO: /^sal[aá]rio/, SITUACAO: /^situa/ };
  var CAIXAS = Object.keys(BLOCO_DE);
  function blocoDe(blk) { var re = BLOCO_DE[blk]; return re ? regioes('nc-mov-bloco').filter(function (b) { return re.test(titulo(b).toLowerCase()); })[0] || null : null; }
  var ABERTA = null;              // a categoria com a lista aberta
  var PEDIR_ABRIR = null;         // a caixa que a pessoa acabou de marcar: o bloco dela abre sozinho
  function marcado(b) { var it = apex.item('P116_BLK_' + b); return !!(it && it.node) && val('P116_BLK_' + b) === 'S'; }
  function caixa(b, liga) { var it = apex.item('P116_BLK_' + b); if (it && it.node && marcado(b) !== liga) it.setValue(liga ? 'S' : ''); }
  /* 04/10: a caixa como a PÁGINA a deixou. As ações dinâmicas escondem caixas (marcar a Vaga
     esconde as outras; Situação e C.Custo contábil conforme a permissão) e desabilitam outras
     (Salário/Cargo quando o pedido não pode mexer neles; Salário só leitura com vaga escolhida).
     O cartão segue: 'oculto' não aparece, 'travado' aparece sem toque, só 'livre' marca. */
  function estadoCaixa(b) {
    var it = apex.item('P116_BLK_' + b), c = document.getElementById('P116_BLK_' + b + '_CONTAINER');
    if (!it || !it.node) return 'oculto';
    if (c && !visivel(c)) return 'oculto';
    var cb = (c || document).querySelector('input[type="checkbox"][name="P116_BLK_' + b + '"], #P116_BLK_' + b + ' input[type="checkbox"]');
    if (!cb || cb.disabled || (it.isDisabled && it.isDisabled())) return 'travado';
    return 'livre';
  }
  function ativa(c) {
    if (c.id === 'vaga') return marcado('VAGA');
    if (c.id === 'promocao') return marcado('CARGO');
    if (c.id === 'reajuste') return marcado('SALARIO') && !marcado('CARGO') && !marcado('VAGA');
    return c.itens.some(function (x) { return marcado(x[0]); });
  }
  function itemDe(blk) {
    if (estadoCaixa(blk) !== 'livre') return;          // 04/10: caixa escondida/travada pela página não muda
    if (marcado('TODOS') && estadoCaixa('TODOS') === 'livre') caixa('TODOS', false);
    var liga = !marcado(blk); caixa(blk, liga); if (liga) PEDIR_ABRIR = blk; agendar();
  }
  var MARCA = '<svg class="nc-mov-marca" viewBox="0 0 24 24" aria-hidden="true"><rect x="3.5" y="3.5" width="17" height="17" rx="5"/><path d="M8 12.4l2.8 2.8L16.2 9.6"/></svg>';
  function montarIntencoes() {
    var reg = regiao('nc-mov-intencoes');
    if (!reg) return;
    var corpo = corpoDe(reg);
    var box = document.getElementById('nc-mov-intencoes');
    if (!box) {
      box = el('div', 'nc-mov-intencoes-ctrl'); box.id = 'nc-mov-intencoes';
      corpo.insertBefore(box, corpo.firstChild);
      box.addEventListener('click', function (e) {
        var it = e.target.closest('[data-blk]');
        if (it) { itemDe(it.getAttribute('data-blk')); return; }
        var b = e.target.closest('[data-intencao]'); if (!b) return;
        var c = CATEGORIAS.filter(function (x) { return x.id === b.getAttribute('data-intencao'); })[0];
        if (!c || b.disabled) return;
        if (c.itens.length === 1) { ABERTA = null; itemDe(c.itens[0][0]); return; }
        ABERTA = ABERTA === c.id ? null : c.id;
        tudo();
      });
    }
    var ae = document.activeElement, foco = box.contains(ae) && (ae.getAttribute('data-blk') ? '[data-blk="' + ae.getAttribute('data-blk') + '"]' : ae.getAttribute('data-intencao') ? '[data-intencao="' + ae.getAttribute('data-intencao') + '"]' : '');
    html(box, '<div class="nc-mov-intencoes-lista" role="group" aria-label="O que você quer fazer">' +
      CATEGORIAS.map(function (c0) {
        /* 04/10: só as caixas que a página deixa à vista; sem nenhuma, o cartão não aparece; com
           todas travadas, aparece sem toque (mostra o que está marcado, não deixa mudar) */
        var st = {}, itens = c0.itens.filter(function (x) { st[x[0]] = estadoCaixa(x[0]); return st[x[0]] !== 'oculto'; });
        if (!itens.length) return '';
        var c = { id: c0.id, nome: c0.nome, desc: c0.desc, pergunta: c0.pergunta, nota: c0.nota, itens: itens };
        var travado = itens.every(function (x) { return st[x[0]] !== 'livre'; });
        var multi = c0.itens.length > 1, on = ativa(c), n = c.itens.filter(function (x) { return marcado(x[0]); }).length, aberta = ABERTA === c.id && !travado;
        var cartao = '<button type="button" class="nc-mov-intencao' + (aberta ? ' is-aberta' : '') + '" data-intencao="' + c.id + '" aria-pressed="' + on + '"' + (multi ? ' aria-expanded="' + aberta + '"' : '') + (travado ? ' disabled' : '') + '>' +
          '<svg class="nc-mov-icone" viewBox="0 0 24 24" aria-hidden="true">' + ICONE[c.id] + '</svg>' +
          '<span class="nc-mov-intencao-texto"><span class="nc-mov-intencao-nome">' + esc(c.nome) + '</span><span class="nc-mov-intencao-desc">' + esc(c.desc) + '</span>' +
            (multi && n ? '<span class="nc-mov-intencao-conta">' + n + (n === 1 ? ' item escolhido' : ' itens escolhidos') + '</span>' : '') + '</span>' +
          (multi ? '<svg class="nc-mov-seta" viewBox="0 0 24 24" aria-hidden="true"><path d="M6 9.5l6 6 6-6"/></svg>' : MARCA) +
        '</button>';
        if (!multi || !aberta) return cartao;
        return cartao + '<div class="nc-mov-sub" role="group" aria-label="' + esc(c.pergunta) + '">' +
          '<p class="nc-mov-sub-tit">' + esc(c.pergunta) + ' <span>Marque um ou mais.</span></p>' +
          '<div class="nc-mov-sub-lista">' + c.itens.map(function (x) {
            return '<button type="button" class="nc-mov-sub-item" role="checkbox" aria-checked="' + marcado(x[0]) + '" data-blk="' + x[0] + '"' + (st[x[0]] !== 'livre' ? ' disabled' : '') + '>' + MARCA.replace('nc-mov-marca', 'nc-mov-marca nc-mov-marca--p') + '<span>' + esc(x[1]) + '</span></button>';
          }).join('') + '</div>' +
          (c.nota ? '<p class="nc-mov-dica">' + esc(c.nota) + '</p>' : '') + '</div>';
      }).join('') + '</div>');
    if (foco) { var f = box.querySelector(foco); if (f) f.focus(); }
  }
  /* pedido novo: ao escolher o colaborador, uma ação dinâmica do APEX marca TODAS as caixas.
     Aqui elas voltam a ficar desmarcadas, sem disparar as ações (nada foi preenchido ainda) —
     os blocos saem da vista e a pessoa escolhe no passo 2. Uma vez por colaborador. */
  var ZERADO_PARA = null;
  function zerarCaixas() {
    if (PEDIDO) return;
    var mat = val('P116_MAT_SOLICITADO');
    if (!mat || ZERADO_PARA === mat || (window.apex.jQuery && apex.jQuery.active)) return;
    ZERADO_PARA = mat;
    var ligadas = CAIXAS.filter(marcado);
    if (ligadas.length < 8) return;          // só o "marca tudo" do APEX; uma escolha de verdade fica
    /* a página que voltou do envio com erro traz as escolhas da pessoa: essas ficam */
    if (ERROS_SRV.length || blocosAbertos().some(function (b) { return diffsDe(b).linhas.length; })) return;
    /* 04/10: desmarca COMO a pessoa desmarcaria — com o change, para as ações de cada caixa
       rodarem (elas escondem o bloco e LIMPAM o que foi posto nele). Antes era em silêncio
       (setValue sem change) e o bloco era escondido aqui: os valores ficavam nos campos
       escondidos e iam no envio. Caixa travada/escondida pela página fica como está. */
    (marcado('TODOS') ? ['TODOS'] : []).concat(ligadas).forEach(function (b) {
      var it = apex.item('P116_BLK_' + b);
      if (it && it.node && estadoCaixa(b) === 'livre' && marcado(b)) it.setValue('');
    });
    ABERTO = null; VISTOS = {};
  }

  /* ═══ [J3] PASSO 3: OS BLOCOS HOJE → COMO FICA ════════════════════════════════════════════
     O QUE FAZ  Cada região nc-mov-bloco vira uma linha da "fila": nome do bloco, a mudança
                ("Hoje → Como fica") e um selo de estado — Pronto / Falta N / Preencher (num
                pedido gravado: Muda / Sem mudança). Só UM bloco fica aberto por vez; dentro
                dele, cada campo novo mostra ao lado o valor de hoje. "Continuar" leva ao próximo.
     COMO       Compara a sub-região nc-mov-hoje (o "…Atual") com a nc-mov-depois (o "…Proposta"),
                campo a campo, pelo RÓTULO (sem as palavras atual/proposta).
     O QUE CONTA COMO "FALTA"  Campos da proposta cujo rótulo começa com "Data" ou "Motivo"
                (ou "1ª Data"…), vazios e liberados. "2ª …" não conta.
     IMPORTANTE Abrir e fechar blocos é só desenho: nenhuma caixa P116_BLK_* muda, nenhum campo
                sai do lugar.
     PODE MEXER os textos dos selos: 'Pronto', 'Falta ', 'Preencher', 'Muda', 'Sem mudança'.
     VISUAL     Natcorp_Movimentacao.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- nc-mov-bloco: Hoje → Como fica ---------- */
  function blocosAbertos() { return regioes('nc-mov-bloco').filter(visivel); }
  function mudancaDe(b) {
    var hoje = b.querySelector('.nc-mov-hoje'), dep = b.querySelector('.nc-mov-depois');
    var fh = hoje ? principal(camposDe(hoje)) : null, fd = dep ? principal(camposDe(dep)) : null;
    var r = { de: mostrar(fh), para: mostrar(fd), fh: fh, fd: fd };
    /* Salário: muda também quando só a remuneração variável muda (o campo Salário fica vazio) */
    if (b.classList.contains('nc-mov-salario') && !(r.para && r.para !== r.de)) {
      [['', 'P116_SALARIO', 'P116_SALARIO_PROP'], ['Remuneração variável: ', 'P116_REMUNERACAO_VARIAVEL', 'P116_REMUNERACAO_VARIAVEL_PROP']].some(function (x) {
        var de = num(val(x[1])), para = num(val(x[2]));
        if (!isFinite(para) || para === de) return false;
        r.de = x[0] + brl(de); r.para = brl(para);
        return true;
      });
    }
    return r;
  }
  function faltasDe(b, comId) {
    var dep = b.querySelector('.nc-mov-depois');
    if (!dep) return [];
    return camposDe(dep).filter(function (f) {
      return /^(\d+ª\s+)?(data|motivo)/i.test(f.rotulo) && !/^2ª/.test(f.rotulo) && !f.campo.disabled && vazio(f.valor);
    }).map(function (f) { return comId ? { id: f.campo.id, rotulo: f.rotulo } : f.rotulo; });
  }
  /* ---------- os blocos: uma fila de mudanças ----------
     Com 7 ou mais blocos abertos, Hoje | Como fica lado a lado virava uma página sem fim e o
     "hoje" de cada campo ficava longe dele. Agora cada bloco é uma linha (nome, hoje → como fica,
     o estado: Pronto / Falta N / Preencher) e só UM fica aberto. Dentro dele, cada campo traz o
     seu "Hoje: …" logo acima da caixa; a coluna Hoje sai da vista (continua no DOM) e o que dela
     não tem par vira uma linha "Também hoje". No pé, "Continuar" leva ao próximo bloco.
     Abrir/fechar é só desenho: nenhuma caixa P116_BLK_* muda, nenhum campo sai do lugar. */
  var ABERTO = null;              // id do bloco aberto; '' = a pessoa fechou todos
  var VISTOS = {};                // blocos já vistos abertos pelas caixas (um novo abre sozinho)
  function chaveRot(r) {
    return String(r || '').toLowerCase().replace(/\*/g, '').replace(/\([^)]*\)/g, '')
      .normalize('NFD').replace(/[̀-ͯ]/g, '')
      .replace(/\b(atual|atuais|proposta|proposto|propostas|propostos)\b/g, '').replace(/\s+/g, ' ').trim();
  }
  function estadoDe(b) {
    var m = mudancaDe(b), f = faltasDe(b);
    var mudou = !!(m.para && m.para !== m.de);
    return { m: m, f: f, mudou: mudou, tipo: mudou ? (f.length ? 'falta' : 'ok') : 'vazio' };
  }
  function seloDe(e) {
    if (PEDIDO) return e.mudou ? ['ok', 'Muda'] : ['vazio', 'Sem mudança'];
    return e.tipo === 'ok' ? ['ok', 'Pronto'] : e.tipo === 'falta' ? ['falta', 'Falta ' + e.f.length] : ['vazio', 'Preencher'];
  }
  var IC_ESTADO = { ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>', falta: '<path d="M12 7.5v5.5M12 16.5v.5"/>', vazio: '<path d="M8 12h8"/>' };
  /* rolar até uma região sem que a barra fixa do topo (t-Header, 48 px) cubra o título dela:
     o scrollIntoView não sabe dessa barra. Mede na hora o que está fixo no alto da tela. */
  function alturaDoTopo() {
    var h = 0;
    [].forEach.call(document.querySelectorAll('.t-Header, .t-Body-title, .t-Body-topButtons'), function (e) {
      var p = getComputedStyle(e).position;
      if (p !== 'fixed' && p !== 'sticky') return;
      var r = e.getBoundingClientRect();
      if (r.height && r.top <= 1 && r.bottom > h) h = r.bottom;
    });
    return h;
  }
  /* durante a rolagem os blocos que abrem e fecham ainda estão mudando de altura (transição do
     tema) e o navegador reajusta o ponto de chegada: no fim, confere onde parou e acerta */
  function rolarAte(el) {
    if (!el) return;
    var tentativas = 0;
    function falta() { return el.getBoundingClientRect().top - alturaDoTopo() - 12; }
    function ir() { window.scrollTo({ top: window.pageYOffset + falta(), behavior: 'smooth' }); }
    function conferir() {
      if (++tentativas > 3 || Math.abs(falta()) < 4) return;
      ir(); setTimeout(conferir, 450);
    }
    ir(); setTimeout(conferir, 700);
  }
  function abrir(id, rolar) {
    ABERTO = id;
    tudo();
    if (rolar && id) setTimeout(function () { rolarAte(document.getElementById(id)); }, 80);
  }
  /* o "Hoje" de cada campo, ao lado dele */
  function compararCampos(b) {
    var hoje = b.querySelector('.nc-mov-hoje'), dep = b.querySelector('.nc-mov-depois');
    if (!hoje || !dep) return;
    var mapa = {}, usados = {};
    camposDe(hoje).forEach(function (f) { var k = chaveRot(f.rotulo); if (k && !(k in mapa)) mapa[k] = f; });
    camposDe(dep).forEach(function (f) {
      var k = chaveRot(f.rotulo), h = mapa[k], ic = f.c.querySelector('.t-Form-inputContainer') || f.c;
      var linha = f.c.querySelector('.nc-mov-campo-hoje');
      if (h) usados[k] = true;
      /* o par: à esquerda o de HOJE (caixa cinza, só leitura), à direita o campo NOVO — a mesma
         linha, para comparar sem procurar; sem par de hoje (motivo, %, datas novas…) o campo fica sozinho */
      classe(ic, 'nc-mov-par', !!h);
      if (!h) { if (linha) linha.remove(); return; }
      if (!linha) { linha = el('span', 'nc-mov-campo-hoje'); ic.insertBefore(linha, ic.firstChild); }
      var txt = vazio(h.valor) ? '' : mostrar(h);
      html(linha, '<span class="nc-mov-tag">Hoje</span>' + (txt ? '<b>' + esc(txt) + '</b>' : '<i>sem valor</i>'));
    });
    /* o que só existe do lado de hoje (Grade, Faixa…): uma linha no alto do bloco aberto */
    var resto = Object.keys(mapa).filter(function (k) { return !usados[k] && !vazio(mapa[k].valor); }).map(function (k) {
      return esc(mapa[k].rotulo.replace(/\s*\*$/, '')) + ' <b>' + esc(mostrar(mapa[k])) + '</b>';
    });
    var corpo = corpoDe(dep), tb = corpo.querySelector(':scope > .nc-mov-tambem');
    if (!resto.length) { if (tb) tb.remove(); }
    else {
      if (!tb) { tb = el('p', 'nc-mov-tambem'); corpo.insertBefore(tb, corpo.firstChild); }
      html(tb, '<span>Também hoje:</span> ' + resto.join('<span aria-hidden="true"> · </span>'));
    }
    classe(b, 'nc-mov-comparado', true);
  }
  function montarBlocos() {
    var visiveis = blocosAbertos();
    /* um bloco recém-aberto pelas caixas (intenção nova) abre sozinho; com erro do servidor, também.
       Na primeira passada (a página chegando) vale o primeiro que ainda falta preencher. */
    /* abre sozinho só o bloco do item que a pessoa acabou de marcar no passo 2 — nunca contra
       um toque dela (antes, cada bloco que aparecia tomava o lugar do que ela abriu) */
    var pedido = PEDIR_ABRIR && blocoDe(PEDIR_ABRIR);
    if (pedido && visivel(pedido)) PEDIR_ABRIR = null; else pedido = null;
    visiveis.forEach(function (b) { VISTOS[b.id] = true; });
    var comErro = visiveis.filter(function (b) { return b.querySelector('.t-Form-fieldContainer.is-error, .t-Form-error:not(:empty)'); })[0];
    if (comErro && !comErro.__ncErro) { comErro.__ncErro = true; ABERTO = comErro.id; }
    else if (pedido) ABERTO = pedido.id;
    else if (ABERTO && !visiveis.some(function (b) { return b.id === ABERTO; })) ABERTO = null;
    if (ABERTO === null && !PEDIDO) { var pend = visiveis.filter(function (b) { return estadoDe(b).tipo !== 'ok'; })[0] || visiveis[0]; ABERTO = pend ? pend.id : null; }

    regioes('nc-mov-bloco').forEach(function (b) {
      var corpo = corpoDe(b);
      var cab = corpo.querySelector(':scope > .nc-mov-cab');
      if (!cab) {
        cab = el('button', 'nc-mov-cab'); cab.type = 'button';
        corpo.insertBefore(cab, corpo.firstChild);
        cab.addEventListener('click', function () { abrir(ABERTO === b.id ? '' : b.id, ABERTO !== b.id); });
      }
      if (!visivel(b)) return;
      var e = estadoDe(b), selo = seloDe(e), aberto = ABERTO === b.id;
      classe(b, 'nc-mov-mudou', e.mudou);
      classe(b, 'nc-mov-fechado', !aberto);
      cab.setAttribute('aria-expanded', aberto ? 'true' : 'false');
      html(cab, '<span class="nc-mov-cab-marca nc-mov-cab-marca--' + selo[0] + '" aria-hidden="true"><svg viewBox="0 0 24 24">' + IC_ESTADO[selo[0]] + '</svg></span>' +
        '<span class="nc-mov-cab-txt"><span class="nc-mov-cab-titulo">' + esc(titulo(b)) + '</span>' +
        '<span class="nc-mov-cab-mudanca">' + (e.mudou
          ? '<span class="nc-mov-de">' + esc(e.m.de || 'sem valor') + '</span><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 12h15M14 6.5l5.5 5.5-5.5 5.5"/></svg><b>' + esc(e.m.para) + '</b>'
          : '<span class="nc-mov-de">Hoje: ' + esc(e.m.de || 'sem valor') + '</span>') + '</span></span>' +
        '<span class="nc-mov-selo nc-mov-selo--' + selo[0] + '">' + esc(selo[1]) + '</span>' +
        '<svg class="nc-mov-cab-seta" viewBox="0 0 24 24" aria-hidden="true"><path d="M6 9.5l6 6 6-6"/></svg>');
      if (!aberto) return;
      compararCampos(b);
      /* a legenda do par, no alto do bloco aberto: Hoje (cinza) → Novo (roxo) */
      var dep0 = b.querySelector('.nc-mov-depois');
      if (dep0) {
        var c0 = corpoDe(dep0);
        if (!c0.querySelector(':scope > .nc-mov-legenda')) {
          var lg = el('p', 'nc-mov-legenda', '<span class="nc-mov-leg nc-mov-leg--hoje">Hoje</span><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 12h15M14 6.5l5.5 5.5-5.5 5.5"/></svg><span class="nc-mov-leg nc-mov-leg--novo">Como fica (novo)</span>');
          c0.insertBefore(lg, c0.firstChild);
        }
        var velho = c0.querySelector(':scope > .nc-mov-rotulo'); if (velho) velho.remove();
      }
      /* o pé: o próximo da fila (ou o resumo, no último) */
      var pe = corpo.querySelector(':scope > .nc-mov-bloco-pe');
      if (!pe) {
        pe = el('div', 'nc-mov-bloco-pe');
        corpo.appendChild(pe);
        pe.addEventListener('click', function (ev) {
          var bt = ev.target.closest('[data-prox]'); if (!bt) return;
          var alvo = bt.getAttribute('data-prox');
          if (alvo === 'resumo') { abrir('', false); var r = regiao('nc-mov-resumo'); if (r) setTimeout(function () { rolarAte(r); }, 80); }
          else abrir(alvo, true);
        });
      }
      var i = visiveis.indexOf(b), prox = visiveis.slice(i + 1).concat(visiveis.slice(0, i)).filter(function (x) { return estadoDe(x).tipo !== 'ok'; })[0];
      html(pe, PEDIDO ? '' : (e.tipo === 'falta' ? '<p class="nc-mov-dica">Falta: ' + esc(e.f.join(', ').toLowerCase()) + '.</p>' : '<span></span>') +
        '<button type="button" class="nc-mov-prox" data-prox="' + (prox ? prox.id : 'resumo') + '">' +
          (prox ? 'Continuar: ' + esc(titulo(prox)) : 'Conferir o resumo') + '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 12h15M14 6.5l5.5 5.5-5.5 5.5"/></svg></button>');
    });
    montarMapa(visiveis);
  }
  /* o placar da fila, no passo 3: quantos blocos já estão prontos */
  function montarMapa(visiveis) {
    var p3 = document.getElementById('nc-mov-passo3');
    if (!p3) return;
    var pl = document.getElementById('nc-mov-placar');
    if (!pl) { pl = el('p', 'nc-mov-placar'); pl.id = 'nc-mov-placar'; pl.setAttribute('aria-live', 'polite'); p3.appendChild(pl); }
    var prontos = visiveis.filter(function (b) { return estadoDe(b).tipo === 'ok'; }).length;
    pl.hidden = visiveis.length < 2;
    html(pl, '<b>' + prontos + ' de ' + visiveis.length + '</b> ' + (visiveis.length === 1 ? 'bloco pronto' : 'blocos prontos'));
  }


  /* ═══ [J4] REAIS E SALÁRIO ════════════════════════════════════════════════════════════════
     O QUE FAZ  • itens com a classe nc-mov-moeda: o valor de leitura aparece em reais;
                • bloco nc-mov-salario: mostra a diferença (em R$ e em %) entre hoje e o novo,
                  avisa que salário e % de aumento são o mesmo dado de dois jeitos, e explica
                  que a tabela de parcelas só existe depois que o pedido é gravado.
     IMPORTANTE Só muda o que aparece. O valor gravado no banco continua o número puro.
     VISUAL     Natcorp_Movimentacao.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- nc-mov-moeda / nc-mov-salario: reais e a diferença ---------- */
  function montarMoeda() {
    [].slice.call(document.querySelectorAll('.nc-mov-moeda')).forEach(function (c) {
      var campo = c.matches('input') ? c : c.querySelector('input:not([type="hidden"])');
      if (!campo) return;
      var box = c.querySelector('.nc-mov-moeda-valor');
      if (!box) { box = el('span', 'nc-mov-moeda-valor'); box.setAttribute('aria-hidden', 'true'); campo.parentNode.insertBefore(box, campo.nextSibling); }
      var n = num(campo.value);
      box.textContent = isFinite(n) ? brl(n) : '—';
    });
  }
  function montarSalario() {
    var b = regiao('nc-mov-salario');
    if (!b || !visivel(b)) return;
    var dep = b.querySelector('.nc-mov-depois');
    var pares = [['Salário', 'P116_SALARIO', 'P116_SALARIO_PROP'], ['Remuneração variável', 'P116_REMUNERACAO_VARIAVEL', 'P116_REMUNERACAO_VARIAVEL_PROP'], ['Total', 'P116_TOTAL_REMUNERACAO', 'P116_TOTAL_REMUNERACAO_PROP']];
    var linhas = pares.map(function (p) {
      var de = num(val(p[1])), para = num(val(p[2]));
      if (!isFinite(para) || para === de) return '';
      var pct = isFinite(de) && de > 0 ? (para - de) / de * 100 : NaN;
      return '<li><span>' + p[0] + '</span> ' + brl(de) + ' <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 12h15M14 6.5l5.5 5.5-5.5 5.5"/></svg> <b>' + brl(para) + '</b>' +
        (isFinite(pct) ? ' <em class="nc-mov-pct' + (pct < 0 ? ' nc-mov-pct--menos' : '') + '">' + PCT.format(pct) + '%</em>' : '') + '</li>';
    }).join('');
    /* salário e % de aumento são o mesmo dado de dois jeitos (a ação dinâmica calcula um pelo
       outro): uma linha diz isso logo acima do par */
    var parSal = document.getElementById('P116_SALARIO_PROP_CONTAINER');
    var linhaSal = parSal && parSal.closest('.row');
    if (linhaSal && document.getElementById('P116_PERC_SALARIO') && !document.getElementById('nc-mov-par-dica')) {
      var d = el('p', 'nc-mov-dica nc-mov-par-dica', 'Digite o <b>salário novo</b> ou o <b>% de aumento</b>: um calcula o outro. O mesmo vale para a remuneração variável e o total.');
      d.id = 'nc-mov-par-dica';
      linhaSal.parentNode.insertBefore(d, linhaSal);
    }
    var box = document.getElementById('nc-mov-salario');
    if (!box && dep) { box = el('div', 'nc-mov-salario-conta'); box.id = 'nc-mov-salario'; box.setAttribute('aria-live', 'polite'); var c = corpoDe(dep); c.insertBefore(box, c.firstChild.nextSibling); }
    if (box) { box.hidden = !linhas; box.innerHTML = linhas ? '<ul>' + linhas + '</ul>' : ''; }
    /* o parcelamento: numa requisição nova a tabela das parcelas ainda não existe (ela nasce
       quando o pedido é gravado) — diz isso em vez de deixar a pessoa procurando */
    var parc = document.getElementById('P116_PARC_SALARIO_CONTAINER');
    if (parc) {
      var nota = document.getElementById('nc-mov-parc-nota');
      var mostra = val('P116_PARC_SALARIO') === 'S' && !val('P116_ROWID');
      if (mostra && !nota) { nota = el('p', 'nc-mov-dica nc-mov-parc-nota'); nota.id = 'nc-mov-parc-nota'; (parc.querySelector('.t-Form-inputContainer') || parc).appendChild(nota); }
      if (nota) { nota.hidden = !mostra; nota.textContent = 'As parcelas do aumento são preenchidas depois que o pedido for enviado, na própria requisição.'; }
    }
  }

  /* ═══ [J5] PASSO 4: O QUADRO ANTES | DEPOIS ═══════════════════════════════════════════════
     O QUE FAZ  Na região nc-mov-resumo, monta o quadro que quem aprova lê para decidir: cada
                campo que muda numa linha, o antes apagado e o depois em destaque, agrupado por
                bloco, com o motivo e o "a partir de". Inclui os benefícios (o que entra, sai ou
                muda de valor) e avisa o que ainda falta para enviar.
     LÊ DE      os próprios blocos ([J3]) e as tabelas que o Natcorp_Beneficios.js desenhou.
     VISUAL     Natcorp_Movimentacao.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- nc-mov-resumo: o quadro Antes | Depois ----------
     Quem aprova (RH, diretoria, remuneração) olha uma vez e decide: cada campo que muda numa
     linha, o antes apagado e o depois em destaque, agrupado por bloco com o motivo e o "a partir
     de". Os campos vêm dos próprios blocos: cada campo de "Como fica" preenchido é comparado com o
     seu par de hoje (pelo rótulo); igual a hoje não entra. O mesmo quadro é o passo 4 do gestor. */
  var SETA = '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 12h15M14 6.5l5.5 5.5-5.5 5.5"/></svg>';
  function diffsDe(b) {
    var hoje = b.querySelector('.nc-mov-hoje'), dep = b.querySelector('.nc-mov-depois');
    var mapa = {}, linhas = [], meta = [], vistos = {};
    if (hoje) camposDe(hoje).forEach(function (f) { var k = chaveRot(f.rotulo); if (k && !(k in mapa)) mapa[k] = f; });
    if (dep) camposDe(dep).forEach(function (f) {
      if (vazio(f.valor)) return;
      var rot = f.rotulo.replace(/\s*\*\s*$/, '').trim();
      /* motivo e data vão com o campo que vem logo antes deles (Cargo tem os seus, Função os
         dela); os que vêm antes de qualquer campo (Salário) valem para o bloco todo */
      var umMeta = function (r, v) {
        var alvo = linhas.length ? linhas[linhas.length - 1] : null;
        if (alvo) { alvo.meta = alvo.meta || []; if (!alvo.meta.some(function (m) { return m[0] === r; })) alvo.meta.push([r, v]); return; }
        if (!vistos[r + v]) { vistos[r + v] = true; meta.push([r, v]); }
      };
      if (/^(\d+ª\s+)?motivo/i.test(rot)) { umMeta('Motivo', codDesc(f.valor)); return; }
      if (/^(\d+ª\s+)?data/i.test(rot)) { if (!/compet/i.test(rot)) umMeta('A partir de', f.valor); return; }
      if (/^%|deseja|parcelamento|para treinamento|categoria/i.test(rot)) return;
      var h = mapa[chaveRot(rot)], de = h && !vazio(h.valor) ? mostrar(h) : '', para = mostrar(f);
      if (!para || para === de) return;
      var pct = h && dinheiro(h) && dinheiro(f) && num(h.valor) > 0 ? (num(f.valor) - num(h.valor)) / num(h.valor) * 100 : NaN;
      linhas.push({ rot: rot, de: de, para: para, pct: pct });
    });
    /* um motivo/data de campo que ficou sem campo antes dele (o campo era igual a hoje) e os do
       bloco: entram em cada linha que não tem os seus */
    linhas.forEach(function (l) {
      if (/^total/i.test(l.rot)) { delete l.meta; return; }      // o total é conta, não tem data/motivo próprio
      meta.forEach(function (m) { l.meta = l.meta || []; if (!l.meta.some(function (x) { return x[0] === m[0]; })) l.meta.push(m); });
      if (l.meta) l.meta.sort(function (a) { return a[0] === 'A partir de' ? -1 : 1; });
    });
    return { linhas: linhas, meta: meta };
  }
  function quadroAD(grupos) {
    return '<div class="nc-mov-ad" role="table" aria-label="Antes e depois">' +
      '<div class="nc-mov-ad-cab" role="row"><span class="nc-mov-ad-rot" role="columnheader">O que muda</span><span role="columnheader">Antes</span><span role="columnheader">Depois</span></div>' +
      grupos.map(function (g) {
        return '<div class="nc-mov-ad-grupo' + (g.falta.length ? ' nc-mov-ad-grupo--falta' : '') + '" role="rowgroup">' +
          '<div class="nc-mov-ad-gtit" role="row"><span role="cell"><b>' + esc(g.titulo) + '</b>' +
            (g.falta.length ? '<span class="nc-mov-ad-falta">Falta: ' + esc(g.falta.join(', ').toLowerCase()) + '</span>' : '') + '</span></div>' +
          g.linhas.map(function (l) {
            return '<div class="nc-mov-ad-linha' + (l.total ? ' nc-mov-ad-linha--total' : '') + '" role="row">' +
              '<span class="nc-mov-ad-rot" role="rowheader">' + esc(l.rot) + '</span>' +
              '<span class="nc-mov-ad-antes" role="cell"><span class="nc-mov-ad-mob">Antes</span>' + esc(l.de || 'sem valor') + '</span>' +
              '<span class="nc-mov-ad-depois" role="cell"><span class="nc-mov-ad-mob">Depois</span>' + SETA + '<b>' + esc(l.para) + '</b>' +
                (isFinite(l.pct) ? ' <em class="nc-mov-pct' + (l.pct < 0 ? ' nc-mov-pct--menos' : '') + '">' + PCT.format(l.pct) + '%</em>' : '') +
                (l.meta && l.meta.length ? '<span class="nc-mov-ad-info">' + l.meta.map(function (m) { return '<span>' + esc(m[0]) + ' <b>' + esc(m[1]) + '</b></span>'; }).join('') + '</span>' : '') + '</span>' +
            '</div>';
          }).join('') + '</div>';
      }).join('') + '</div>';
  }
  /* os benefícios (Natcorp_Beneficios já desenhou as tabelas): hoje × o novo pacote (no pedido
     gravado, os Requisitados) — o que entra, o que sai, o que muda de valor e o total */
  function linhasBen(reg) {
    if (!reg || !visivel(reg)) return [];
    return [].map.call(reg.querySelectorAll('tr.nc-ben-item'), function (tr) {
      function c(h) { return tr.querySelector('td[headers="' + h + '"]'); }
      function tx(td) { return td ? (td.getAttribute('data-nc-txt') || td.textContent).replace(/\s+/g, ' ').trim() : ''; }
      var nome = tx(c('BENEFICIO') || c('BENEFÍCIO')), tipo = tx(c('TIPO_BENEFICIO') || c('TIPO_BENEFÍCIO'));
      return { nome: nome, tipo: tipo, valor: num(tx(c('VALOR_TOTAL'))), op: tx(c('TIPO')), antes: num(tx(c('VALOR_ANTERIOR'))), chave: (nome + '|' + tipo).toLowerCase() };
    }).filter(function (x) { return x.nome; });
  }
  function grupoBeneficios() {
    var pac = regiao('nc-ben-pacote'), req = regiao('nc-ben-requisitados');
    var novo = linhasBen(pac), dePac = novo.length > 0;
    if (!dePac) novo = linhasBen(req);
    if (!novo.length) return null;
    var hoje = linhasBen(regiao('nc-ben-hoje')), mapa = {};
    hoje.forEach(function (h) { mapa[h.chave] = h; });
    var linhas = [], vistos = {};
    function rot(x) {
      var t = x.tipo, n = x.nome;
      if (!t || t.toLowerCase() === n.toLowerCase()) return n;
      return t.toLowerCase().indexOf(n.toLowerCase()) === 0 || /complementar|benef[ií]cio/i.test(n) ? t : n + ' · ' + t;
    }
    novo.forEach(function (x) {
      var h = mapa[x.chave]; vistos[x.chave] = true;
      if (/remov/i.test(x.op)) linhas.push({ rot: rot(x), de: brl(isFinite(x.antes) ? x.antes : h ? h.valor : NaN), para: 'Sai do pacote', pct: NaN });
      else if (!h) linhas.push({ rot: rot(x), de: 'Não tem', para: brl(x.valor), pct: NaN });
      else if (Math.abs(h.valor - x.valor) > 0.004) linhas.push({ rot: rot(x), de: brl(h.valor), para: brl(x.valor), pct: NaN });
    });
    /* no pedido novo o que não está no pacote sai; nos Requisitados o que sai vem como "Removido" */
    if (dePac) hoje.forEach(function (h) { if (!vistos[h.chave]) linhas.push({ rot: rot(h), de: brl(h.valor), para: 'Sai do pacote', pct: NaN }); });
    var soma = function (l) { return l.filter(function (x) { return !/remov/i.test(x.op); }).reduce(function (a, x) { return a + (isFinite(x.valor) ? x.valor : 0); }, 0); };
    var th = soma(hoje), tn = soma(novo);
    if (!linhas.length && Math.abs(th - tn) < 0.005) return null;
    linhas.push({ rot: 'Total dos benefícios', de: brl(th), para: brl(tn), pct: th > 0 ? (tn - th) / th * 100 : NaN, total: true });
    return { titulo: 'Benefícios', linhas: linhas, meta: [], falta: [] };
  }
  var ESTADO = { mudancas: [], faltas: [], abertos: 0 };
  function montarResumo() {
    var abertos = blocosAbertos();
    var semMudanca = [], mud = [], faltas = [], grupos = [];
    abertos.forEach(function (b) {
      var m = mudancaDe(b), d = diffsDe(b);
      if (!d.linhas.length && !(m.para && m.para !== m.de)) {
        semMudanca.push(titulo(b));
        if (m.fd && !m.fd.campo.disabled) faltas.push({ id: m.fd.campo.id, rotulo: titulo(b) });
        return;
      }
      if (!d.linhas.length) d.linhas.push({ rot: titulo(b), de: m.de, para: m.para, pct: NaN });
      var f = faltasDe(b, true);
      mud.push(titulo(b));
      f.forEach(function (x) { faltas.push({ id: x.id, rotulo: x.rotulo.replace(/\s*\*$/, '') }); });
      grupos.push({ titulo: titulo(b), linhas: d.linhas, meta: d.meta, falta: PEDIDO ? [] : f.map(function (x) { return x.rotulo.replace(/\s*\*$/, ''); }) });
    });
    var gb = grupoBeneficios();
    if (gb) grupos.push(gb);
    /* a sobra do valor para benefícios: o servidor só aceita o pedido com o valor todo distribuído */
    var sobra = num(val('P116_SALDO')), med = regiao('nc-ben-medidor');
    if (!PEDIDO && med && visivel(med) && !med.classList.contains('nc-ben-sem-dados') && isFinite(sobra) && sobra > 0.004)
      faltas.push({ id: 'P116_VALOR', rotulo: 'Distribuir ' + brl(sobra) + ' em benefícios' });
    /* o motivo do Parecer é obrigatório no pedido novo */
    var obs = document.getElementById('P116_OBS');
    if (!PEDIDO && obs && val('P116_MAT_SOLICITADO') && visivel(obs) && /TEXTAREA|INPUT/.test(obs.tagName) && !obs.disabled && !obs.value.trim()) faltas.push({ id: 'P116_OBS', rotulo: 'Motivo da mudança' });
    ESTADO = { mudancas: mud, faltas: faltas, abertos: abertos.length };
    var reg = regiao('nc-mov-resumo');
    if (reg) {
      var corpo = corpoDe(reg);
      var box = document.getElementById('nc-mov-resumo');
      if (!box) { box = el('div', 'nc-mov-resumo'); box.id = 'nc-mov-resumo'; corpo.insertBefore(box, corpo.firstChild); }
      var motivo = PEDIDO ? (val('P116_OBS') || '').trim() : '';
      html(box, (motivo ? '<blockquote class="nc-mov-ad-motivo"><b>Por que:</b> ' + esc(motivo) + '</blockquote>' : '') + (grupos.length ? quadroAD(grupos)
        : '<p class="nc-mov-vazio">' + (PEDIDO ? 'Este pedido ainda não tem nenhuma mudança preenchida.' : abertos.length ? 'Nenhuma mudança preenchida ainda. Cada valor novo aparece aqui, com o antes e o depois, para conferir antes de enviar.' : 'Escolha no passo 2 o que você quer fazer. Cada mudança aparece aqui, com o antes e o depois, para conferir antes de enviar.') + '</p>') +
        (semMudanca.length && !PEDIDO ? '<p class="nc-mov-sem-mudanca">Abertos sem mudança (não entram no pedido): ' + esc(semMudanca.join(', ')) + '.</p>' : ''));
      /* a decisão de quem aprova mora logo abaixo do quadro (montarAprovacao põe os botões) */
      var dec = document.getElementById('nc-mov-decisao');
      if (PEDIDO && !dec) { dec = el('div', 'nc-mov-decisao'); dec.id = 'nc-mov-decisao'; dec.hidden = true; corpo.appendChild(dec); }
    }
    var vazio3 = document.getElementById('nc-mov-passo3-vazio');
    if (vazio3) vazio3.hidden = abertos.length > 0;
    desenharBarra();
  }

  /* ═══ [J6] OS TÍTULOS DOS PASSOS ══════════════════════════════════════════════════════════
     O QUE FAZ  Troca o título de três regiões por um passo numerado (número + título + frase):
                  1 região nc-ben-perfil-regiao   2 região nc-mov-intencoes   4 região nc-mov-resumo
                O passo 3 é criado dentro da região nc-mov-alteracoes. Num pedido gravado, não há
                passos (quem aprova não preenche).
     PODE MEXER os textos: em cada linha  [região, número, 'Título', 'Frase de explicação']
                troque só os dois textos. E o texto do passo 3, logo abaixo.
     VISUAL     Natcorp_Movimentacao.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function passo(n, t, sub) {
    return '<span class="nc-mov-passo-n" aria-hidden="true">' + n + '</span><span class="nc-mov-passo-txt"><span class="nc-mov-passo-t">' + esc(t) + '</span>' +
      (sub ? '<span class="nc-mov-passo-sub">' + esc(sub) + '</span>' : '') + '</span>';
  }
  function montarPassos() {
    if (PEDIDO) return;
    [[regiao('nc-ben-perfil-regiao'), 1, 'Quem vai mudar?', 'Escolha o colaborador. Aqui aparece como ele está hoje.'],
     [regiao('nc-mov-intencoes'), 2, 'O que você quer fazer?', 'Toque em uma ou mais opções. Os campos certos aparecem logo abaixo.'],
     [regiao('nc-mov-resumo'), 4, 'Confira e explique', 'Veja cada mudança e escreva o motivo para quem vai aprovar.']].forEach(function (x) {
      var h = x[0] && x[0].querySelector(':scope > .t-Region-header .t-Region-title');
      if (!h || h.querySelector('.nc-mov-passo-n')) return;
      h.innerHTML = '<span class="nc-mov-passo">' + passo(x[1], x[2], x[3]) + '</span>';
      x[0].classList.add('nc-mov-com-passo');
    });
    var alt = regiao('nc-mov-alteracoes');
    if (alt && !document.getElementById('nc-mov-passo3')) {
      var p3 = el('div', 'nc-mov-passo nc-mov-passo--solto');
      p3.id = 'nc-mov-passo3';
      p3.innerHTML = passo(3, 'Preencha como fica', 'Toque num bloco para abrir. Em cada campo aparece como ele é hoje.') +
        '<p class="nc-mov-passo-vazio" id="nc-mov-passo3-vazio">Os campos aparecem aqui depois que você escolher, no passo 2, o que quer fazer.</p>';
      var c = corpoDe(alt);
      c.insertBefore(p3, c.firstChild);
    }
  }

  /* ═══ [J7] O PARECER: O MOTIVO, COM COMEÇOS DE FRASE ══════════════════════════════════════
     O QUE FAZ  Acima da caixa de texto P116_OBS (o rótulo vira "Por que essa mudança?"), põe
                botões com começos de frase. Tocar num botão escreve "Promoção por mérito: " na
                caixa (pelo APEX, com setValue), e a pessoa completa com as palavras dela.
                O rótulo do upload P116_ARQ_UPLOAD vira "Anexo".
     PODE MEXER a lista MOTIVOS logo abaixo: cada texto entre aspas vira um botão. Para
                acrescentar um, copie um texto com as aspas e a vírgula.
     VISUAL     Natcorp_Movimentacao.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: os começos de frase do Parecer */
  var MOTIVOS = ['Promoção por mérito', 'Bom desempenho na função', 'Cobrir uma vaga', 'Reorganização da equipe', 'Ajuste ao salário de mercado', 'A pedido do colaborador'];
  function rotular(n, t) {
    var l = document.getElementById('P116_' + n + '_LABEL');
    if (!l || l.__nc === t) return;
    for (var i = 0; i < l.childNodes.length; i++) if (l.childNodes[i].nodeType === 3 && l.childNodes[i].textContent.trim()) { l.childNodes[i].textContent = t + ' '; l.__nc = t; return; }
  }
  function montarParecer() {
    var obs = document.getElementById('P116_OBS');
    rotular('ARQ_UPLOAD', 'Anexo');
    if (!obs || obs.tagName !== 'TEXTAREA' || obs.disabled || obs.readOnly) return;
    rotular('OBS', 'Por que essa mudança?');
    var c = cont('OBS'), ic = c && c.querySelector('.t-Form-inputContainer');
    if (!ic || document.getElementById('nc-mov-motivos')) return;
    var box = el('div', 'nc-mov-motivos');
    box.id = 'nc-mov-motivos';
    box.innerHTML = '<p class="nc-mov-dica">Quem aprova (RH, diretoria, remuneração) lê isto para decidir. Toque para começar a frase e complete com suas palavras.</p>' +
      '<div class="nc-mov-atalhos">' + MOTIVOS.map(function (m) { return '<button type="button" class="nc-mov-atalho" data-m="' + esc(m) + '">' + esc(m) + '</button>'; }).join('') + '</div>';
    ic.insertBefore(box, ic.firstChild);
    box.addEventListener('click', function (e) {
      var b = e.target.closest('[data-m]'); if (!b) return;
      var atual = obs.value.trim(), m = b.getAttribute('data-m');
      if (atual.indexOf(m) < 0) apex.item('P116_OBS').setValue(atual ? atual.replace(/[.\s]*$/, '') + '. ' + m + ': ' : m + ': ');
      obs.focus();
      obs.setSelectionRange(obs.value.length, obs.value.length);
    });
  }

  /* ═══ [J8] O PEDIDO GRAVADO E A APROVAÇÃO ═════════════════════════════════════════════════
     O QUE FAZ  Só num pedido já gravado (P116_COD_SOLICITACAO ou P116_ROWID preenchidos):
                • a região do cabeçalho (a que contém P116_COD_SOLICITACAO) vira um cabeçalho
                  com o número e a situação;
                • o quadro Antes | Depois sobe para logo depois do colaborador;
                • o passo 2 e os blocos com todos os campos ficam recolhidos em
                  "Ver todos os campos do pedido";
                • o relatório com a coluna APROVADOR vira o caminho da aprovação, com os botões
                  "Aprovar" e "Reprovar" do APEX logo abaixo do quadro.
     CUIDADO    Se a coluna APROVADOR for renomeada no relatório, ou os botões mudarem de texto,
                o caminho da aprovação não é achado.
     VISUAL     Natcorp_Movimentacao.css › [C9]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- o pedido gravado: cabeçalho, aprovação e "o que muda" no alto ---------- */
  var CAB = null;
  function montarPedido() {
    if (!PEDIDO) return;
    var c = cont('COD_SOLICITACAO'), reg = c && c.closest('.t-Region');
    if (!reg) return;
    CAB = reg;
    reg.classList.add('nc-mov-pedido-reg');
    var corpo = corpoDe(reg);
    var box = el('div', 'nc-mov-pedido');
    box.id = 'nc-mov-pedido';
    corpo.insertBefore(box, corpo.firstChild);
    /* o que o cabeçalho já diz some dos campos; a Situação continua (pode ser editável) */
    ['COD_SOLICITACAO', 'DT_SOLICITACAO', 'SOLICITANTE'].forEach(function (n) { var x = cont(n); if (x) x.classList.add('nc-mov-dito'); });
    /* a ordem de quem aprova: o cabeçalho, o colaborador, o quadro Antes e depois (com o motivo,
       os benefícios e a decisão) e o andamento da aprovação. O resto — o passo 2 e os blocos com
       todos os campos — fica recolhido em "Ver todos os campos do pedido" */
    var res = regiao('nc-mov-resumo'), colab = regiao('nc-ben-perfil-regiao');
    if (res) {
      /* o cabeçalho e o colaborador moram na mesma coluna: o quadro entra logo depois do colaborador */
      if (colab && colab.parentNode === reg.parentNode) colab.after(res);
      else {
        var linha = (reg.closest('.col') || reg).closest('.row') || reg;
        var nl = el('div', 'row'), nc = el('div', 'col col-12 apex-col-auto');
        nc.appendChild(res); nl.appendChild(nc); linha.after(nl);
      }
      var colR = reg.closest('.col');
      if (colR) colR.classList.add('nc-mov-col-cheia');
      var tg = el('div', 'nc-mov-ver-tudo');
      tg.innerHTML = '<button type="button" class="nc-mov-ver-tudo-bt" aria-expanded="false"><span>Ver todos os campos do pedido</span><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M6 9.5l6 6 6-6"/></svg></button>';
      corpoDe(res).appendChild(tg);
      tg.addEventListener('click', function () {
        var on = !document.body.classList.contains('nc-mov-ver-tudo');
        verTudo(on);
        /* abriu: leva a pessoa até "O que você quer fazer?" (o começo do que apareceu) */
        var alvo = on && (regiao('nc-mov-intencoes') || regiao('nc-mov-alteracoes'));
        if (alvo) setTimeout(function () { rolarAte(alvo); }, 60);
      });
    }
  }
  function verTudo(on) {
    classe(document.body, 'nc-mov-ver-tudo', on);
    var b = document.querySelector('.nc-mov-ver-tudo-bt');
    if (b) { b.setAttribute('aria-expanded', on ? 'true' : 'false'); b.querySelector('span').textContent = on ? 'Esconder os campos do pedido' : 'Ver todos os campos do pedido'; }
  }
  function desenharPedido() {
    var box = document.getElementById('nc-mov-pedido');
    if (!box) return;
    var sel = document.getElementById('P116_COD_SIT_SOLICITACAO');
    var sit = sel && sel.tagName === 'SELECT' ? texto(sel) : val('P116_COD_SIT_SOLICITACAO');
    var tom = /aprov|conclu/i.test(sit) ? 'bom' : /reprov/i.test(sit) ? 'ruim' : /cancel|suspens/i.test(sit) ? 'neutro' : 'espera';
    var sol = val('P116_SOLICITANTE').split(/\s+\/\s+/);
    var quem = semCodigo(sol[1] || ''), cargo = codDesc(sol[2] || '');
    var dt = val('P116_DT_SOLICITACAO').replace(/\s.*$/, '');
    /* o título da região ("Requisição…: Nº 57702 - 15/05/2026 (Em Andamento)") vira o número e a
       situação; o botão do solicitante, no cabeçalho, fica onde está */
    var h = CAB && CAB.querySelector(':scope > .t-Region-header .t-Region-title');
    if (h) html(h, 'Pedido nº ' + esc(val('P116_COD_SOLICITACAO')) + (sit ? ' <span class="nc-mov-sit nc-mov-sit--' + tom + '">' + esc(semCodigo(sit)) + '</span>' : ''));
    html(box, '<p class="nc-mov-pedido-meta">' + (dt ? 'Aberto em <b>' + esc(dt) + '</b>' : 'Aberto') + (quem ? ' por <b>' + esc(quem) + '</b>' : '') +
        (cargo ? '<span class="nc-mov-sutil"> · ' + esc(cargo) + '</span>' : '') + '</p>');
    if (sel) classe(cont('COD_SIT_SOLICITACAO'), 'nc-mov-dito', sel.disabled || sel.tagName !== 'SELECT');
    var tq = regiao('nc-mov-resumo'), nomeQ = semCodigo(val('P116_MATRICULA_DISPLAY'));
    tq = tq && tq.querySelector(':scope > .t-Region-header .t-Region-title');
    if (tq) html(tq, nomeQ ? 'O que muda para ' + esc(nomeQ) : 'O que muda');
  }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }

  /* o caminho da aprovação: o mesmo das outras requisições */
  var AP = null, AP_ABERTO = false, AP_ASSIN = '';
  function nomeAprovador(t) {
    var m = /^\s*\d+\s*-\s*\d+\s*-\s*(.+)$/.exec(t || '');
    var n = (m ? m[1] : t).trim();
    if (n === n.toUpperCase()) n = n.toLowerCase().replace(/(^|\s)(\S)/g, function (x, a, b) { return a + b.toUpperCase(); });
    return minusculas(n);
  }
  function montarAprovacao() {
    if (!PEDIDO) return;
    if (!AP) {
      var td = document.querySelector('td[headers="APROVADOR"]');
      var reg = td && td.closest('.t-Region');
      if (!reg) return;
      AP = { reg: reg, botoes: [].slice.call(document.querySelectorAll('button.t-Button, a.t-Button')).filter(function (b) { return /^(aprovar|reprovar)$/i.test(b.textContent.trim()); }) };
      reg.classList.add('nc-mov-aprov');
      /* na largura toda (a página a põe numa coluna estreita à direita) e DEPOIS do quadro Antes e
         depois: quem aprova lê primeiro o que muda; o caminho é o andamento */
      if (CAB) {
        var colV = reg.closest('.col'), colH = CAB.closest('.col'), res = regiao('nc-mov-resumo');
        if (res && res !== CAB) res.after(reg); else CAB.after(reg);
        if (colH) colH.classList.add('nc-mov-col-cheia');
        if (colV && colV !== colH && !colV.querySelector('.t-Region')) colV.classList.add('nc-mov-col-vazia');
      }
      AP.box = el('div', 'nc-mov-ap');
      var corpo = corpoDe(reg);
      corpo.insertBefore(AP.box, corpo.firstChild);
      AP.box.addEventListener('click', function (e) { if (e.target.closest('.nc-mov-ap-ver')) { AP_ABERTO = !AP_ABERTO; AP_ASSIN = ''; montarAprovacao(); } });
    }
    var passos = [].slice.call(AP.reg.querySelectorAll('tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); var t = td ? td.textContent.replace(/\s+/g, ' ').trim() : ''; return /^[-–]$/.test(t) ? '' : t; }
      var st = c('STATUS');
      return { nome: nomeAprovador(c('APROVADOR')), data: c('DATA'), just: c('JUSTIFICATIVA'), estado: /^r$|reprov|recus/i.test(st) ? 'nao' : /^a$|aprov/i.test(st) ? 'ok' : 'pend' };
    }).filter(function (x) { return x.nome; });
    var n = passos.length;
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; }), atual = -1;
    if (!reprovado) for (var i = 0; i < n; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var aprovados = passos.filter(function (x) { return x.estado === 'ok'; }).length;
    var sel = document.getElementById('P116_COD_SIT_SOLICITACAO');
    var cancelado = /cancel|suspens/i.test(sel && sel.tagName === 'SELECT' ? texto(sel) : val('P116_COD_SIT_SOLICITACAO'));
    var bts = AP.botoes.filter(function (b) { return b.style.display !== 'none'; });
    var vez = bts.length > 0 && !cancelado && atual >= 0;   /* só há o que decidir com uma etapa pendente */
    var assin = JSON.stringify([passos, atual, bts.length, cancelado, AP_ABERTO]);
    if (assin === AP_ASSIN) return;
    AP_ASSIN = assin;
    classe(AP.reg, 'nc-mov-aprov--vazio', !n);
    if (!n) { AP.box.innerHTML = ''; return; }
    var quemNao = passos.filter(function (x) { return x.estado === 'nao'; })[0];
    var estado = reprovado ? 'nao' : cancelado ? 'neutro' : atual < 0 ? 'ok' : vez ? 'vez' : 'pend';
    var resumo = reprovado ? '<b>Reprovado</b> por ' + esc(quemNao.nome) : cancelado ? '<b>Pedido cancelado</b> · ' + aprovados + ' de ' + n + ' aprovaram'
      : atual < 0 ? '<b>Aprovado</b> por ' + (n === 1 ? esc(passos[0].nome) : 'todos') : vez ? '<b>' + aprovados + ' de ' + n + '</b> · <b>é a sua vez</b> — confira o antes e depois e decida'
      : '<b>' + aprovados + ' de ' + n + '</b> aprovaram · aguardando <b>' + esc(passos[atual].nome) + '</b>';
    classe(AP.reg, 'nc-mov-ap-aberto', AP_ABERTO);
    AP.box.className = 'nc-mov-ap nc-mov-ap--' + estado;
    AP.box.innerHTML = '<p class="nc-mov-ap-rot">Aprovação</p><div class="nc-mov-ap-cab"><p class="nc-mov-ap-resumo">' + resumo + '</p>' +
        '<button type="button" class="nc-mov-ap-ver" aria-expanded="' + AP_ABERTO + '">' + (AP_ABERTO ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
      '<ol class="nc-mov-ap-passos">' + passos.map(function (x, i) {
        var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === atual && !cancelado ? 'is-vez' : 'is-fila';
        var dia = x.data.replace(/\s.*$/, '');
        var st = x.estado === 'ok' ? (dia ? 'Aprovou em ' + dia : 'Aprovou') : x.estado === 'nao' ? 'Reprovou' + (dia ? ' em ' + dia : '') : cls === 'is-vez' ? (vez ? 'Sua vez' : 'Aguardando') : 'Na fila';
        var ic = x.estado === 'ok' ? '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>' : x.estado === 'nao' ? '<path d="M8 8l8 8M16 8l-8 8"/>' : cls === 'is-vez' ? '<path d="M12 8v4l2.5 1.5"/>' : '';
        return '<li class="nc-mov-ap-p ' + cls + '" title="' + esc(x.nome + (x.just ? ': "' + x.just + '"' : '')) + '"><span class="nc-mov-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
          '<span class="nc-mov-ap-texto"><span class="nc-mov-ap-nome">' + esc(x.nome) + '</span><span class="nc-mov-ap-estado">' + esc(st) + '</span></span></li>';
      }).join('') + '</ol>' +
      (vez && !document.getElementById('nc-mov-decisao') ? '<div class="nc-mov-decisao"><p class="nc-mov-decisao-txt">Confira o que muda e decida.</p><div class="nc-mov-decisao-botoes"></div></div>' : '') +
      (passos.some(function (x) { return x.just; }) ? '<div class="nc-mov-ap-justs">' + passos.filter(function (x) { return x.just; }).map(function (x) {
        return '<blockquote class="nc-mov-ap-just' + (x.estado === 'nao' ? ' is-nao' : '') + '"><b>' + esc(x.nome) + ':</b> ' + esc(x.just) + '</blockquote>'; }).join('') + '</div>' : '');
    /* com o quadro Antes | Depois na página, a decisão vai para baixo dele: lê, depois decide */
    var decQ = document.getElementById('nc-mov-decisao');
    if (decQ) {
      decQ.hidden = !vez;
      if (vez && !decQ.querySelector('.nc-mov-decisao-botoes')) decQ.innerHTML = '<p class="nc-mov-decisao-txt">Conferiu o antes e depois? Decida aqui.</p><div class="nc-mov-decisao-botoes"></div>';
    }
    var dest = (decQ && vez ? decQ : AP.box).querySelector('.nc-mov-decisao-botoes');
    if (dest) bts.slice().sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) { b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-mov-reprovar' : 'nc-mov-aprovar'); dest.appendChild(b); });
  }

  /* ═══ [J9] A BARRA DO PÉ ═══════════════════════════════════════════════════════════════════
     O QUE FAZ  Uma barra presa no pé da tela com o que ainda falta (tocar leva ao campo) e o
                botão principal: "Enviar movimentação" (pedido novo) ou "Salvar alterações".
                O botão da barra só CLICA no botão do APEX — a validação e a gravação são dele.
                Se o servidor recusar o envio, a barra diz quantos erros vieram e lista cada um.
     COMBINADO  Os botões do APEX com Static ID  CREATE  (criar) e  SAVE  (salvar).
                Sem nenhum deles à vista, a barra não aparece.
     PODE MEXER 'Enviar movimentação', 'Salvar alterações' e os outros textos da barra.
     VISUAL     Natcorp_Movimentacao.css › [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- a barra do pé: o que falta e o botão principal ---------- */
  var BARRA = null, PRINCIPAL = null;
  function montarBarra() {
    var criar = document.getElementById('CREATE'), salvar = document.getElementById('SAVE'), rot;
    if (criar && visivel(criar)) { PRINCIPAL = criar; rot = 'Enviar movimentação'; }
    else if (salvar && visivel(salvar)) { PRINCIPAL = salvar; rot = 'Salvar alterações'; }
    if (!PRINCIPAL) return;
    PRINCIPAL.classList.add('nc-mov-na-barra');
    BARRA = el('div', 'nc-mov-barra');
    BARRA.setAttribute('role', 'region');
    BARRA.setAttribute('aria-label', 'Andamento do pedido');
    BARRA.innerHTML = '<div class="nc-mov-barra-txt" aria-live="polite"></div>' +
      '<button type="button" class="nc-mov-barra-bt"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 12h15M14 6.5l5.5 5.5-5.5 5.5"/></svg><span>' + rot + '</span></button>';
    document.body.appendChild(BARRA);
    document.body.classList.add('nc-mov-com-barra');
    /* a barra fica DENTRO da página: começa onde começa o conteúdo (240 px com o menu lateral
       aberto, 48 px com ele recolhido, 0 no celular) e acompanha quando o menu abre ou fecha */
    var area = document.querySelector('.t-Body-content') || document.querySelector('.t-Body-main');
    function posicionar() {
      if (!area) return;
      var r = area.getBoundingClientRect();
      BARRA.style.setProperty('--nc-mov-barra-l', Math.max(0, Math.round(r.left)) + 'px');
      BARRA.style.setProperty('--nc-mov-barra-r', Math.max(0, Math.round(window.innerWidth - r.right)) + 'px');
    }
    posicionar();
    window.addEventListener('resize', posicionar);
    if (window.ResizeObserver && area) new ResizeObserver(posicionar).observe(area);
    document.addEventListener('transitionend', function (e) { if (e.target.closest && e.target.closest('.t-Body-nav, .t-Body-main, .t-Body-content')) posicionar(); });
    BARRA.addEventListener('click', function (e) {
      /* 04/10: só clica o original enquanto a PÁGINA o deixa à vista e habilitado — o Salvar se
         esconde no próprio clique (a página evita o envio em dobro); a barra não passa por cima */
      if (e.target.closest('.nc-mov-barra-bt')) { if (principalLivre()) PRINCIPAL.click(); return; }
      var ir = e.target.closest('[data-ir]');
      if (ir) { irPara(ir.getAttribute('data-ir')); return; }
      if (e.target.closest('[data-srv]')) { var l = BARRA.querySelector('.nc-mov-srv-lista'); if (l) { l.hidden = !l.hidden; e.target.closest('[data-srv]').setAttribute('aria-expanded', String(!l.hidden)); } }
    });
  }
  function principalLivre() { return !!PRINCIPAL && visivel(PRINCIPAL) && !PRINCIPAL.disabled && !PRINCIPAL.classList.contains('apex_disabled'); }
  /* o que o servidor recusou no envio: a lista do APEX fica no alto da página, longe de quem
     estava lá embaixo — a barra do pé diz quantos são e mostra cada um */
  var ERROS_SRV = [];
  function lerErrosDoServidor() {
    var vistos = {};
    ERROS_SRV = [].map.call(document.querySelectorAll('#t_Alert_Notification li, .t-Alert--danger .htmldbUlErr li, .t-Alert--danger li.htmldbStdErr'), function (li) {
      return li.textContent.replace(/\s+/g, ' ').replace(/^\d+\s*-\s*/, '').trim();
    }).filter(function (t) { if (!t || vistos[t]) return false; vistos[t] = true; return true; });
  }
  function irPara(id) {
    var f = document.getElementById(id), c = f && (f.closest('.t-Form-fieldContainer') || f);
    if (!c) return;
    if (PEDIDO && !document.body.classList.contains('nc-mov-ver-tudo') && c.closest('.nc-mov-alteracoes, .nc-mov-intencoes')) verTudo(true);
    var bl = c.closest('.nc-mov-bloco');
    if (bl && ABERTO !== bl.id) { ABERTO = bl.id; tudo(); }
    c.scrollIntoView({ behavior: 'smooth', block: 'center' });
    /* lista popup: abre a lista (é o único jeito de preencher); o resto ganha o foco */
    var lov = c.querySelector('.a-Button--popupLOV');
    setTimeout(function () { if (lov && f.readOnly) lov.click(); else try { f.focus({ preventScroll: true }); } catch (x) { f.focus(); } }, 450);
  }
  function desenharBarra() {
    if (!BARRA) return;
    var bt = BARRA.querySelector('.nc-mov-barra-bt');
    if (bt) bt.disabled = !principalLivre();                // 04/10: espelha o botão da página
    var nome = semCodigo(val('P116_MATRICULA_DISPLAY')).split(' ')[0];
    var mud = ESTADO.mudancas, f = ESTADO.faltas.slice(0, 6), mais = ESTADO.faltas.length - f.length;
    var frase = !val('P116_MAT_SOLICITADO') ? 'Escolha o colaborador para começar.'
      : !ESTADO.abertos ? '<b>' + esc(nome) + '</b>: escolha o que você quer fazer.'
      : mud.length > 3 ? '<b>' + esc(nome) + '</b> · <b>' + mud.length + ' mudanças</b>: ' + esc(mud[0].toLowerCase()) + ', ' + esc(mud[1].toLowerCase()) + ' e mais ' + (mud.length - 2)
      : mud.length ? '<b>' + esc(nome) + '</b> · muda ' + mud.map(function (t) { return '<b>' + esc(t.toLowerCase()) + '</b>'; }).join(', ').replace(/, ([^,]*)$/, ' e $1')
      : '<b>' + esc(nome) + '</b>: preencha como fica.';
    var n = ERROS_SRV.length;
    html(BARRA.querySelector('.nc-mov-barra-txt'), (n ? '<p class="nc-mov-srv">O envio voltou com <b>' + n + (n === 1 ? ' problema' : ' problemas') + '</b>. <button type="button" class="nc-mov-srv-bt" data-srv aria-expanded="false">Ver ' + (n === 1 ? 'qual' : 'quais') + '</button></p>' +
        '<ol class="nc-mov-srv-lista" hidden>' + ERROS_SRV.map(function (t) { return '<li>' + esc(t) + '</li>'; }).join('') + '</ol>' : '') +
      '<p class="nc-mov-frase">' + frase + '</p>' +
      (f.length ? '<div class="nc-mov-falta-lista"><span class="nc-mov-barra-rot">Falta:</span>' + f.map(function (x) {
        return '<button type="button" class="nc-mov-falta" data-ir="' + esc(x.id) + '">' + esc(x.rotulo) + '</button>'; }).join('') +
        (mais > 0 ? '<span class="nc-mov-barra-rot">+' + mais + '</span>' : '') + '</div>'
      : mud.length ? '<span class="nc-mov-barra-ok"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M6.5 12.5l3.5 3.5 7.5-8"/></svg>' +
        (PRINCIPAL && PRINCIPAL.id === 'SAVE' ? 'Tudo preenchido. Se mudou algo, salve.' : 'Tudo preenchido. Confira o resumo e envie.') + '</span>' : ''));
  }

  /* ═══ [J10] BENEFÍCIOS E "ALTERAÇÕES" ═════════════════════════════════════════════════════
     O QUE FAZ  • montarBeneficios: arruma as COLUNAS das regiões de benefícios (desenhadas pelo
                  Natcorp_Beneficios.js) como na Requisição de Benefícios, só com classes;
                • mostrarTudo: na região nc-mov-alteracoes, clica na aba "Mostrar tudo" para todos
                  os blocos ficarem à vista (as abas repetidas somem pelo CSS).
     VISUAL     Natcorp_Movimentacao.css › [C10] e [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- Benefícios: o mesmo arranjo da Requisição de Benefícios (200:168) ----------
     No APEX a linha é 4 + 3 + 5 colunas ("Adicionar" espremido em 3/12). Como na 168: à
     esquerda "Adicionar um benefício" (5/12); à direita (7/12) o "Novo pacote" e, embaixo dele,
     "O que ele tem hoje". No pedido gravado (sem Adicionar), um embaixo do outro na largura
     toda: os Requisitados e depois o de hoje — e, como na 168, sem a barra do saldo.
     Só classes: nada sai da região de origem. */
  function montarBeneficios() {
    var hoje = regiao('nc-ben-hoje'), cH = hoje && hoje.closest('.col'), linha = cH && cH.parentElement;
    if (!linha) return;
    linha.classList.add('nc-mov-ben-grade');
    cH.classList.add('nc-mov-ben-c-hoje');
    [['nc-ben-escolha', 'nc-mov-ben-c-escolha'], ['nc-ben-pacote', 'nc-mov-ben-c-pacote'], ['nc-ben-requisitados', 'nc-mov-ben-c-pacote']].forEach(function (x) {
      var r = regiao(x[0]), c = r && r.closest('.col');
      if (c && c.parentElement === linha) c.classList.add(x[1]);
    });
    [].forEach.call(linha.children, function (c) {
      classe(c, 'nc-mov-ben-c-vazia', ![].some.call(c.querySelectorAll(':scope > .t-Region'), visivel));
    });
    var esc0 = linha.querySelector(':scope > .nc-mov-ben-c-escolha');
    var consulta = !esc0 || esc0.classList.contains('nc-mov-ben-c-vazia');
    classe(linha, 'nc-mov-ben-sem-escolha', consulta);
    classe(regiao('nc-ben-medidor'), 'nc-mov-ben-so-consulta', consulta);
  }

  /* ---------- nc-mov-alteracoes: sem as abas repetidas, tudo à vista ---------- */
  function mostrarTudo() {
    var reg = regiao('nc-mov-alteracoes');
    if (!reg) return;
    var tudoAba = reg.querySelector('.apex-rds li:first-child a');
    var sel = reg.querySelector('.apex-rds li.apex-rds-selected');
    if (tudoAba && sel && sel !== tudoAba.parentElement && /mostrar tudo|show all/i.test(tudoAba.textContent)) tudoAba.click();
  }

  /* ═══ [J11] O MAESTRO: QUANDO CADA PARTE É MONTADA ═════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a página abre: descobre se é pedido novo ou
                gravado (marca a página com nc-mov-modo-novo ou nc-mov-modo-pedido), monta o
                cabeçalho, os passos, o Parecer e a barra. Depois, tudo() remonta o resto sempre
                que algo muda: um campo é alterado, uma lista é recarregada, uma janela fecha,
                uma ação dinâmica termina de trazer valores do servidor, um bloco aparece/some.
     COMO       As mudanças chegam em rajadas (dezenas por segundo). agendar() espera ~120 ms
                de calma e remonta uma vez só.
     PODE MEXER CAMPOS_MOEDA: os campos de dinheiro com a máscara R$ (nome SEM o 'P116_').
                A máscara só muda o que aparece: o campo de verdade segue com o número puro.
     CUIDADO    Não mude a ordem das chamadas em tudo() nem em iniciar(): umas partes dependem
                das anteriores (os blocos precisam existir antes do quadro Antes | Depois).
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp movimentação] seguido da mensagem. Veja o manual, parte 5.
                Para medir quanto o desenho custa, digite __ncMovT no Console.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* todas as regiões de primeiro nível na mesma largura: no APEX umas ficam em 8/12 (o passo 2
     ficava ao lado do lugar da antiga coluna dos Aprovadores) e outras em 12/12 */
  function larguraPadrao() {
    [].forEach.call(document.querySelectorAll('.t-Body-contentInner .t-Region, .t-Body-contentInner .t-ButtonRegion'), function (r) {
      if (r.parentElement.closest('.t-Region, .t-ButtonRegion')) return;
      var c = r.closest('.col');
      if (!c || c.classList.contains('nc-mov-col-cheia')) return;
      c.classList.add('nc-mov-col-cheia');
      [].forEach.call(c.parentElement.children, function (x) {
        if (x !== c && x.classList.contains('col') && !x.querySelector('.t-Region, .t-ButtonRegion, .t-Form-fieldContainer')) x.classList.add('nc-mov-col-vazia');
      });
    });
  }
  /* os campos de dinheiro editáveis (e o total, só leitura) com a máscara R$ 999.999.990,90 —
     a caixa é do Natcorp_Beneficios (window.ncMoeda); o campo de verdade segue com o número puro */
  /* PODE MEXER: os campos de dinheiro com a máscara R$ (nome sem o 'P116_') */
  var CAMPOS_MOEDA = ['SALARIO_PROP', 'REMUNERACAO_VARIAVEL_PROP', 'TOTAL_REMUNERACAO_PROP', 'VLR_AUX_TIPO_MOD_PROP', 'VALOR_FATURAVEL_PROP', 'VAGA_VALOR_FAT_PROP', 'VAGA_VLR_AUX_TP_MODAL_PROP'];
  function mascararDinheiro() {
    if (!window.ncMoeda) return;
    CAMPOS_MOEDA.forEach(function (n) { var e = document.getElementById('P116_' + n); if (e) window.ncMoeda.aplicar(e, true); });
    window.ncMoeda.syncTudo();
  }
  function tudo() {
    var t0 = window.performance ? performance.now() : 0;
    larguraPadrao();
    mascararDinheiro();
    zerarCaixas();
    classe(document.body, 'nc-mov-com-colab', !!val('P116_MAT_SOLICITADO'));
    montarIntencoes();
    montarBlocos();
    montarMoeda();
    montarSalario();
    montarResumo();
    montarBeneficios();
    desenharPedido();
    montarAprovacao();
    /* pedido que ninguém mais edita (quem aprova, ou já concluído): sem os cartões de escolha */
    if (PEDIDO) classe(document.body, 'nc-mov-leitura', !regioes('nc-mov-depois').some(function (r) {
      return camposDe(r).some(function (f) { return !f.campo.disabled && !f.campo.readOnly; });
    }));
    /* quanto o desenho custa (para medir com o console: __ncMovT) */
    if (t0) { var m = window.__ncMovT || (window.__ncMovT = { vezes: 0, ms: 0 }); m.vezes++; m.ms += performance.now() - t0; }
  }
  /* uma passada por "respiro": as ações dinâmicas da página disparam dezenas de chamadas
     seguidas; redesenhar a cada uma ocupava o navegador junto com elas. Agora junta tudo o que
     chegou em ~120 ms e redesenha uma vez (e uma no fim de cada rajada, no ajaxStop) */
  var T_AGENDA = null;
  function agendar() {
    clearTimeout(T_AGENDA);
    T_AGENDA = setTimeout(function () { try { tudo(); } catch (e) { if (window.console) console.warn('[Natcorp movimentação]', e); } }, 120);
  }
  function iniciar() {
    PEDIDO = !!(val('P116_COD_SOLICITACAO') || val('P116_ROWID'));
    document.body.classList.add('nc-mov', PEDIDO ? 'nc-mov-modo-pedido' : 'nc-mov-modo-novo');
    mostrarTudo();
    montarPedido();
    montarPassos();
    montarParecer();
    montarBarra();
    lerErrosDoServidor();
    /* "Outro Colaborador" só faz sentido com um colaborador escolhido */
    [].forEach.call(document.querySelectorAll('button.t-Button, a.t-Button'), function (b) { if (/^outro colaborador$/i.test(b.textContent.trim())) b.classList.add('nc-mov-bt-outro'); });
    tudo();
    /* valores postos pelas ações dinâmicas (change), listas recarregadas (apexafterrefresh) e
       blocos mostrados/escondidos pelas caixas (o style das regiões) */
    $(document).on('change', '[id^="P116_"]', agendar);
    $(document).on('apexafterrefresh apexafterclosedialog', agendar);
    $(document).on('input', '#P116_OBS', agendar);
    /* valores trazidos do servidor por ação dinâmica (Executar PL/SQL, "itens a retornar")
       chegam SEM o evento change: sem isto a tela ficava com a leitura de antes da resposta */
    $(document).ajaxStop(agendar);
    if (window.MutationObserver) {
      var mo = new MutationObserver(agendar);
      regioes('nc-mov-bloco').forEach(function (r) { mo.observe(r, { attributes: true, attributeFilter: ['style'] }); });
    }
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
