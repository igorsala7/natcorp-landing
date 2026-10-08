/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE FÉRIAS  —  o "arrumador" da tela (JavaScript)                    ║
   ║  App 200 (Painel do Operador) · Página 78 · o colaborador pede as férias                  ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns. O guia desta página: FERIAS-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quem usa é o colaborador, 90% no celular, muitas vezes com pouca leitura. Este arquivo
   REDESENHA, no mesmo lugar, o que tem uma classe posta no APEX:
     • no alto, duas frases: "Você tem N dias de férias" e "Você precisa começar até …", com
       os detalhes do período recolhidos atrás de "Ver os detalhes do período";
     • "Como você quer tirar suas férias?" uma pergunta de cada vez: primeiro "Você quer vender
       dias?" (Não/Sim), depois só as opções que servem, em cartões;
     • listas Não/Sim e de dias viram botões grandes; uma lista com UMA opção vira frase;
     • a data de volta dita em frase ("Você volta a trabalhar na quarta-feira, …");
     • "Confira suas férias": cada parte em frases (começa / volta), com avisos escritos;
     • ao lado dos botões, o que falta ("Falta escolher o dia de início de 1 parte").

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • A ESTRUTURA é toda do APEX (ordem, colunas, títulos, rótulos, botões): este arquivo não
       move, não renomeia e não duplica nada. Para mudar a tela, mude o APEX.
     • As regras (datas permitidas, mínimo por parte, feriados…) continuam nas ações dinâmicas
       e nos pacotes: aqui não se valida nada, só se mostra.
     • A lista continua sendo o item de verdade: tocar num botão faz apex.item().setValue, que
       dispara as mesmas ações dinâmicas de sempre.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX. (Nesse
       caso, ponha também a região LINHA_FERIAS em Condição › Nunca: ela é vazia no APEX,
       quem a desenha é este arquivo.)

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 78 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Ferias.js
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Ferias.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Classes postas nas REGIÕES (Page Designer › região › Appearance › CSS Classes):
     nc-fer-direito     "Suas férias" (PER)         → duas frases no alto e o botão dos detalhes
     nc-fer-detalhes    Período de Férias e Dados   → recolhidas atrás de "Ver os detalhes"
     nc-fer-parte       1ª, 2ª e 3ª parte           → cada parte das férias
     nc-fer-programada  as partes já programadas    → cartão só de leitura ("Já programada")
     nc-fer-linha       "Confira suas férias"       → cada parte em frases (começa / volta)
     nc-fer-acoes       a região dos botões         → o que falta, ao lado deles
     nc-fer-colaborador "Colaborador Solicitado"    → o cartão do colaborador (foto, nome…)
   Achados SEM classe (pelo conteúdo):
     a região que tem P78_COD_SOLICITACAO           → o cartão do pedido (nº, situação)
     o relatório com a coluna APROVADOR             → o caminho da aprovação
   Classes postas nos ITENS (Page Designer › item › Advanced › CSS Classes):
     nc-fer-opcao       P78_OPCAO_FERIAS(_A)        → "Quer vender dias?" e as opções em cartões
     nc-fer-simnao      lista de duas opções        → Não/Sim como dois botões
     nc-fer-dias        lista de dias / abono       → um botão por quantidade; com uma opção
                                                      só, vira frase (venda "nenhum" some)
     nc-fer-retorno     data de retorno             → "Volta ao trabalho em…"
   A classe do item vai para o CONTÊINER do item no Universal Theme (rótulo + campo); o
   desenho entra dentro dele, logo abaixo do rótulo. Tirou a classe, aquele pedaço volta ao
   normal do APEX. Itens lidos pelo NOME: P78_SALDO_1, P78_DT_LIMITE_REQ, e os das partes
   (P78_DT_SAIDA_PARC…, P78_DT_RETORNO_PARC…, P78_NUM_DIAS_PARC…). A 3ª parte usa os itens
   de número 4 (…PARC4), como no APEX.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Ferramentas ......................... funções pequenas; meses e dias       PODE MEXER
     [J2]  "Suas férias" no alto ............... as duas frases e os detalhes         PODE MEXER
     [J3]  Como tirar: uma pergunta por vez .... vender dias? e as opções em cartões  PODE MEXER
     [J4]  Não/Sim e dias ...................... listas viram botões ou frase         PODE MEXER
     [J5]  A volta em frase .................... "Você volta a trabalhar…"            PODE MEXER
     [J6]  As partes ........................... lê as datas de cada parte           CUIDADO
     [J7]  "Confira suas férias" ............... cada parte em frases, com avisos     PODE MEXER
     [J8]  O que falta ......................... a frase ao lado dos botões          PODE MEXER
     [J9]  O maestro ........................... decide QUANDO tudo é redesenhado    CUIDADO
     [J10] O pedido ............................ nº, situação, quem pediu            PODE MEXER
     [J11] O caminho da aprovação .............. quem aprovou, quem falta             PODE MEXER
     [J12] O cartão do colaborador ............. foto, nome, filial, anos de casa     PODE MEXER

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Ver os detalhes do período'  →  'Ver mais'
     Quero mudar um título, rótulo, ordem ou coluna      → direto no APEX. Nada a mudar aqui.
     Quero tirar o desenho de um item ou região          → tire a classe dele no APEX.
     Criei uma opção nova de divisão das férias
       → nada a fazer, desde que o texto siga o formato
         "N Parcela(s): X dias de férias + Y dias de abono". Em outro formato, o cartão mostra
         o texto inteiro (veja lerOpcao, em [J3]).
     Renomeei um item P78_… citado acima
       → procure o nome antigo aqui (Ctrl+F "P78_") e troque, senão aquele pedaço para de
         funcionar em silêncio. Se a página for copiada para outro número, troque TODOS os
         "P78_" deste arquivo.
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp férias].
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
     'P78_SALDO_1'        o nome do item no APEX (aqui escrito por inteiro).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: esta linha impede que o arquivo rode duas vezes (se a URL estiver repetida na
     página, por exemplo) e que rode fora do APEX. Não apague. */
  if (window.__ncFerias || !window.apex || !window.apex.jQuery) return;
  window.__ncFerias = true;

  var $ = apex.jQuery;
  var ILU = /*@@ILUSTRACOES@@*/ {};

  /* ═══ [J1] FERRAMENTAS ════════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('P78_ITEM')   o que o APEX GUARDA no item
       dataBR('31/12/2026')  transforma o texto numa data;  extenso(data) → "31 de dezembro
                         de 2026" (o dia 1 sai "1º")
       regiao('classe')  a região que tem aquela classe no APEX
       campos('classe')  os campos (listas, caixas) dos itens que têm aquela classe
       caixaDoItem(…)    o espaço, logo abaixo do rótulo do item, onde o desenho entra
       escolher(lista, valor)  escolhe a opção na lista de verdade (dispara as ações dinâmicas)
     PODE MEXER os nomes dos meses e dos dias da semana (MESES, SEMANA).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function val(id) { var it = apex.item(id); return it && it.node ? String(it.getValue() || '') : ''; }
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  /* "22.5" ou "22,5" → 22.5 (o saldo pode ter meio dia; inteiro() leria 225) */
  function numero(t) { var n = parseFloat(String(t || '').replace(/\s/g, '').replace(',', '.')); return isFinite(n) ? n : NaN; }
  function diasTxt(n) { return String(Math.round(n * 10) / 10).replace('.', ',') + (n === 1 ? '&nbsp;dia' : '&nbsp;dias'); }
  function inteiro(t) { var n = parseInt(String(t || '').replace(/[^\d-]/g, ''), 10); return isFinite(n) ? n : NaN; }
  function dataBR(t) { var m = String(t || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  var SEMANA = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'];
  function dia(d) { return d.getDate() === 1 ? '1º' : String(d.getDate()); }
  function extenso(d) { return d ? dia(d) + ' de ' + MESES[d.getMonth()] + ' de ' + d.getFullYear() : ''; }
  function hoje() { var h = new Date(); return new Date(h.getFullYear(), h.getMonth(), h.getDate()); }
  var DIA = 864e5;
  function mais(d, n) { return new Date(d.getTime() + n * DIA); }

  function regiao(cls) { return document.querySelector('.t-Region.' + cls + ', .t-ButtonRegion.' + cls); }
  function regioes(cls) { return [].slice.call(document.querySelectorAll('.t-Region.' + cls)); }
  function visivel(e) { for (; e && e !== document.body; e = e.parentElement) if (e.style && e.style.display === 'none' || e.hidden) return false; return !!e; }
  function containerDe(campo) { return campo && campo.closest('.t-Form-fieldContainer'); }
  /* a classe vem no contêiner do item (ou no próprio campo): devolve os campos */
  function campos(cls) {
    return [].slice.call(document.querySelectorAll('.' + cls)).map(function (e) {
      return /^(SELECT|INPUT|TEXTAREA)$/.test(e.tagName) ? e : e.querySelector('select, textarea, input:not([type="hidden"])');
    }).filter(Boolean);
  }
  function caixaDoItem(campo, sufixo) {
    var id = 'nc-fer-' + sufixo + '-' + campo.id;
    var box = document.getElementById(id);
    if (box) return box;
    var c = containerDe(campo);
    var alvo = c && (c.querySelector('.t-Form-inputContainer') || c);
    if (!alvo) return null;
    box = el('div', 'nc-fer-ctrl');
    box.id = id;
    var wrap = alvo.querySelector('.t-Form-itemWrapper');
    if (wrap && wrap.nextSibling) alvo.insertBefore(box, wrap.nextSibling); else alvo.appendChild(box);
    return box;
  }
  function rotuloId(campo) { var l = document.getElementById(campo.id + '_LABEL'); return l ? l.id : ''; }
  /* as opções da lista, sem a vazia e SEM REPETIÇÃO: no pedido já feito a lista do APEX não é
     filtrada pela empresa e chega a trazer a mesma opção centenas de vezes (vista no app 300:
     722 linhas, 9 opções) — vale a primeira de cada valor */
  function opcoes(sel) {
    var vistos = {};
    return [].slice.call(sel.options).filter(function (o) {
      if (o.value === '' || o.value === '-' || vistos[o.value]) return false;
      vistos[o.value] = true;
      return true;
    });
  }
  /* campo travado pelo APEX (pedido já feito, cancelado, em aprovação): o desenho só MOSTRA a
     resposta, sem botões para trocar — a mesma regra do campo original */
  function soLeitura(campo) { return !!(campo.disabled || campo.readOnly); }
  function escolher(sel, v) { if (!soLeitura(sel) && v !== sel.value) apex.item(sel.id).setValue(v); }
  function grupoDeBotoes(sel, sufixo, cls, conteudo) {
    var box = caixaDoItem(sel, sufixo);
    if (!box) return null;
    box.setAttribute('role', 'radiogroup');
    box.setAttribute('aria-labelledby', rotuloId(sel));
    box.classList.add(cls);
    if (!box.dataset.grupo) {
      box.dataset.grupo = '1';
      box.addEventListener('click', function (e) { var b = e.target.closest('button[data-v]'); if (b) escolher(sel, b.getAttribute('data-v')); });
    }
    /* redesenhar troca os botões: quem estava com o foco (teclado) volta para o mesmo valor */
    var foco = box.contains(document.activeElement) && document.activeElement.getAttribute('data-v');
    box.innerHTML = conteudo;
    var leitura = soLeitura(sel);
    box.classList.toggle('nc-fer-leitura', leitura);
    if (leitura) [].forEach.call(box.querySelectorAll('button'), function (b) { b.disabled = true; });
    if (foco !== false && foco !== null) { var b = box.querySelector('button[data-v="' + foco.replace(/"/g, '\\"') + '"]'); if (b) b.focus(); }
    return box;
  }

  /* ═══ [J2] "SUAS FÉRIAS" NO ALTO (classe nc-fer-direito) ══════════════════════════════════
     O QUE FAZ  Abre a região com duas frases: "Você tem N dias de férias" e "Você precisa
                começar até …" (com "Faltam N dias" quando faltam 60 ou menos; e o aviso de
                prazo vencido). O botão "Ver os detalhes do período" mostra/esconde as regiões
                nc-fer-detalhes.
     LÊ DOS ITENS  P78_SALDO_1 (os dias) e P78_DT_LIMITE_REQ (o limite para começar)
     PEDIDO JÁ FEITO  os dias são os da ÉPOCA DO PEDIDO: o valor que o APEX trouxe da coluna
                SALDO do pedido (o value original de P78_SALDO_1, no HTML). Depois que a página
                abre, a ação dinâmica "(Pesquisa) Matricula: Popula_Campos 1" troca o item pelo
                saldo de HOJE — o desenho não usa esse, e não mexe no item.
                A frase vira "Você tinha N dias de férias quando fez este pedido, em …".
     PODE MEXER as frases entre aspas.
     VISUAL     Natcorp_Ferias.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- nc-fer-direito: duas frases no alto; os detalhes do período, recolhidos ----------
     Quem usa é o colaborador, no celular, muitas vezes com pouca leitura: no alto só o que
     decide (quantos dias e até quando começar). Os 11 números do período (regiões
     nc-fer-detalhes) ficam atrás de um botão; nada sai do APEX, só da vista. */
  function montarDireito() {
    var reg = regiao('nc-fer-direito');
    if (!reg) return;
    var corpo = reg.querySelector('.t-Region-body') || reg;
    var box = document.getElementById('nc-fer-resumo');
    if (!box) {
      box = el('div', 'nc-fer-resumo'); box.id = 'nc-fer-resumo';
      corpo.insertBefore(box, corpo.firstChild);
      box.addEventListener('click', function (e) {
        var b = e.target.closest('.nc-fer-ver-detalhes');
        if (!b) return;
        var aberto = document.body.classList.toggle('nc-fer-detalhes-aberto');
        b.setAttribute('aria-expanded', String(aberto));
        b.querySelector('span').textContent = aberto ? 'Esconder os detalhes' : 'Ver os detalhes do período';
      });
    }
    var gravado = !!(val('P78_ROWID') || val('P78_COD_SOLICITACAO'));
    var it = document.getElementById('P78_SALDO_1');
    var saldo = numero(gravado && it && it.defaultValue !== '' ? it.defaultValue : val('P78_SALDO_1'));
    var limite = dataBR(val('P78_DT_LIMITE_REQ'));
    var pedidoEm = dataBR(val('P78_DT_SOLICITACAO'));
    box.hidden = !isFinite(saldo);
    if (box.hidden) return;
    var faltam = limite ? Math.round((limite - hoje()) / DIA) : NaN;
    var dias = '<b>' + diasTxt(saldo) + '</b>';
    var titulo = gravado ? 'Você tinha ' + dias + ' de férias' : 'Você tem ' + dias + ' de férias';
    /* no pedido já feito, o prazo é um fato da época (sem "Faltam…" nem "Fale com o RH") */
    var prazo = gravado ? (pedidoEm ? 'Quando fez este pedido, em <b>' + extenso(pedidoEm) + '</b>.' : 'Quando fez este pedido.') + (limite ? ' O prazo para começar era <b>' + extenso(limite) + '</b>.' : '')
      : !limite ? '' : faltam < 0 ? 'O prazo para começar acabou em <b>' + extenso(limite) + '</b>. Fale com o RH.'
      : 'Você precisa começar até <b>' + extenso(limite) + '</b>.' + (faltam <= 60 ? ' Faltam <b>' + faltam + (faltam === 1 ? ' dia' : ' dias') + '</b>.' : '');
    var aberto = document.body.classList.contains('nc-fer-detalhes-aberto');
    var temDetalhes = regioes('nc-fer-detalhes').some(visivel);
    box.innerHTML =
      (ILU.ferias ? '<span class="nc-fer-ilu" aria-hidden="true" style="background-image:url(' + ILU.ferias + ')"></span>' : '') +
      '<div class="nc-fer-resumo-texto">' +
        '<p class="nc-fer-resumo-titulo">' + titulo + '</p>' +
        (prazo ? '<p class="nc-fer-resumo-prazo">' + prazo + '</p>' : '') +
        (temDetalhes ? '<button type="button" class="nc-fer-ver-detalhes" aria-expanded="' + aberto + '"><span>' + (aberto ? 'Esconder os detalhes' : 'Ver os detalhes do período') + '</span></button>' : '') +
      '</div>';
  }

  /* ═══ [J3] COMO TIRAR: UMA PERGUNTA DE CADA VEZ (classe nc-fer-opcao) ═════════════════════
     O QUE FAZ  Transforma a lista de opções de férias em duas perguntas:
                  1. "Você quer vender dias das suas férias?" (Não / Sim) — só aparece se a
                     lista tem opções com venda E sem venda;
                  2. as opções que servem para a resposta, em cartões ("Tudo de uma vez",
                     "Em 2 vezes"…), da mais simples para a mais dividida.
                lerOpcao() lê o texto da opção no formato
                  "N Parcela(s): X dias de férias + Y dias de abono".
     IMPORTANTE A pergunta da venda é SÓ da tela: o que vale é a opção escolhida na lista.
                Trocar a resposta desfaz uma opção que não serve mais.
     PODE MEXER as frases entre aspas ('Você quer vender dias…', 'Tudo de uma vez'…).
     VISUAL     Natcorp_Ferias.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- nc-fer-opcao: uma pergunta de cada vez ----------
     A lista do APEX tem as opções misturadas (com e sem venda de dias). Na tela: primeiro
     "Você quer vender dias?" (Não/Sim), depois só as opções que servem para essa resposta,
     da mais simples para a mais dividida. A pergunta da venda é só da tela: a resposta que
     vale é a opção escolhida na lista. */
  function lerOpcao(texto) {
    var m = String(texto).match(/^\s*(\d+)\s*Parcela\(s\)\s*:\s*(.+)$/i);
    var partes = [], abono = 0;
    String(m ? m[2] : texto).split('+').forEach(function (p) {
      var n = inteiro(p);
      if (!isFinite(n)) return;
      if (/abono/i.test(p)) abono += n; else partes.push(n);
    });
    var nome = partes.length === 1 ? 'Tudo de uma vez' : partes.length ? 'Em ' + partes.length + ' vezes' : String(texto);
    var conta = partes.length === 1 ? partes[0] + ' dias seguidos' : partes.map(function (n) { return n + ' dias'; }).join(' + ');
    return { partes: partes, abono: abono, nome: nome, conta: conta, ok: partes.length > 0 };
  }
  var vender = {};   // por lista: a resposta de "Você quer vender dias?" (true/false; sem resposta = undefined)
  var CHECK = '<svg class="nc-fer-marca-check" viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="10.5"/><path d="M7.5 12.4l3 3 6-6.4"/></svg>';
  function montarOpcoes() {
    campos('nc-fer-opcao').forEach(function (sel) {
      if (sel.tagName !== 'SELECT') return;
      /* a lista escondida pela ação dinâmica pode ter centenas de opções: só desenha a que
         está à vista (o observador redesenha quando ela aparece) */
      if (!visivel(containerDe(sel))) return;
      var ops = opcoes(sel).map(function (o) { var d = lerOpcao(o.text); d.v = o.value; return d; });
      var comVenda = ops.filter(function (d) { return d.abono; }), semVenda = ops.filter(function (d) { return !d.abono; });
      var leitura = soLeitura(sel);
      var perguntar = !leitura && comVenda.length && semVenda.length;
      var atual = ops.filter(function (d) { return d.v === sel.value; })[0];
      if (atual) vender[sel.id] = !!atual.abono;
      var resp = perguntar ? vender[sel.id] : undefined;
      var visiveis = leitura ? (atual ? [atual] : []) : !perguntar ? ops : resp === undefined ? [] : resp ? comVenda : semVenda;
      visiveis = visiveis.slice().sort(function (a, b) { return a.partes.length - b.partes.length || (b.partes[0] || 0) - (a.partes[0] || 0); });
      var diasVenda = comVenda.map(function (d) { return d.abono; }).filter(function (n, i, a) { return a.indexOf(n) === i; });
      var rotulo = document.getElementById(sel.id + '_LABEL');
      var pergunta2 = rotulo ? rotulo.textContent.trim() : 'Como você quer tirar suas férias?';
      var html = '';
      if (perguntar) {
        html += '<div class="nc-fer-passo">' +
          '<p class="nc-fer-pergunta" id="nc-fer-venda-' + sel.id + '">Você quer vender dias das suas férias?</p>' +
          '<p class="nc-fer-dica">Vender é trabalhar nesses dias e receber o valor em dinheiro.</p>' +
          '<div class="nc-fer-simnao-ctrl nc-fer-venda" role="radiogroup" aria-labelledby="nc-fer-venda-' + sel.id + '">' +
            '<button type="button" role="radio" data-vender="n" aria-checked="' + (resp === false) + '">Não</button>' +
            '<button type="button" role="radio" data-vender="s" aria-checked="' + (resp === true) + '">Sim' + (diasVenda.length === 1 ? ', vender ' + diasVenda[0] + ' dias' : '') + '</button>' +
          '</div></div>';
      }
      if (visiveis.length) {
        html += '<div class="nc-fer-passo">' +
          '<p class="nc-fer-pergunta" id="nc-fer-como-' + sel.id + '">' + esc(pergunta2) + '</p>' +
          '<div class="nc-fer-opcoes" role="radiogroup" aria-labelledby="nc-fer-como-' + sel.id + '">' +
          visiveis.map(function (d) {
            var seg = d.partes.map(function (n, i) { return '<span class="nc-fer-seg nc-fer-seg--' + (i % 3) + '" style="flex-grow:' + n + '">' + n + '</span>'; }).join('');
            return '<button type="button" class="nc-fer-cartao-opcao" role="radio" aria-checked="' + (d.v === sel.value) + '" data-v="' + esc(d.v) + '"' + (leitura ? ' disabled' : '') + '>' +
              '<span class="nc-fer-cartao-texto"><span class="nc-fer-cartao-nome">' + esc(d.nome) + '</span>' +
              (d.ok ? '<span class="nc-fer-cartao-conta">' + esc(d.conta) + (d.abono ? '<br>e vende ' + d.abono + ' dias' : '') + '</span>' : '') +
              (d.ok && d.partes.length > 1 ? '<span class="nc-fer-faixa" aria-hidden="true">' + seg + '</span>' : '') + '</span>' +
              CHECK + '</button>';
          }).join('') + '</div></div>';
      }
      var box = caixaDoItem(sel, 'opcao');
      if (!box) return;
      if (!box.dataset.pronto) {
        box.dataset.pronto = '1';
        box.classList.add('nc-fer-opcoes-ctrl');
        box.addEventListener('click', function (e) {
          var b = e.target.closest('button');
          if (!b) return;
          if (b.hasAttribute('data-vender')) {
            vender[sel.id] = b.getAttribute('data-vender') === 's';
            var a = opcoes(sel).filter(function (o) { return o.value === sel.value; })[0];
            /* a opção já escolhida não serve para a nova resposta: desfaz, para não enviar a errada */
            if (a && !!lerOpcao(a.text).abono !== vender[sel.id]) apex.item(sel.id).setValue('');
            agendar();
          } else if (b.hasAttribute('data-v')) escolher(sel, b.getAttribute('data-v'));
        });
      }
      var foco = box.contains(document.activeElement) && (document.activeElement.getAttribute('data-v') || document.activeElement.getAttribute('data-vender'));
      box.innerHTML = html;
      box.classList.toggle('nc-fer-leitura', leitura);
      if (foco) { var f = box.querySelector('[data-v="' + foco.replace(/"/g, '\\"') + '"], [data-vender="' + foco + '"]'); if (f) f.focus(); }
      containerDe(sel).classList.add('nc-fer-rotulo-dentro');
    });
  }

  /* ═══ [J4] NÃO/SIM E DIAS (classes nc-fer-simnao e nc-fer-dias) ═══════════════════════════
     O QUE FAZ  • nc-fer-simnao: as opções da lista viram botões (com o texto da própria lista).
                • nc-fer-dias: um botão por quantidade ("15 dias", "Nenhum"). Com UMA opção só,
                  ela NÃO é escolhida sozinha (04/10); depois de tocada vira frase ("São 15 dias
                  de férias nesta parte"); na venda, "nenhum" escolhido como única opção some.
     PODE MEXER as frases entre aspas.
     VISUAL     Natcorp_Ferias.css › [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarSimNao() {
    campos('nc-fer-simnao').forEach(function (sel) {
      if (sel.tagName !== 'SELECT') return;
      var ops = opcoes(sel);
      grupoDeBotoes(sel, 'simnao', 'nc-fer-simnao-ctrl', ops.map(function (o) {
        return '<button type="button" role="radio" aria-checked="' + (o.value === sel.value) + '" data-v="' + esc(o.value) + '">' + esc(o.text) + '</button>';
      }).join(''));
    });
  }
  /* pergunta com UMA resposta só não é pergunta: vira uma frase ("São 15 dias nesta parte").
     Venda de dias com só "nenhum" nem aparece. */
  function montarDias() {
    campos('nc-fer-dias').forEach(function (sel) {
      if (sel.tagName !== 'SELECT') return;
      var ops = opcoes(sel);
      var c = containerDe(sel);
      var venda = /ABONO/i.test(sel.id);
      /* 04/10 (cliente): a opção única NÃO é escolhida sozinha — a pessoa toca nela, como na
         página. Só vira frase (ou some, na venda com "nenhum") depois de escolhida. */
      var fato = ops.length === 1 && sel.value === ops[0].value;
      var unica = ops.length === 1 ? inteiro(ops[0].text) : NaN;
      if (c) {
        c.classList.toggle('nc-fer-sem-pergunta', venda && fato && unica === 0);
        c.classList.toggle('nc-fer-rotulo-dentro', fato);
      }
      if (fato) {
        var box = caixaDoItem(sel, 'dias');
        if (!box) return;
        box.removeAttribute('role');
        box.className = 'nc-fer-ctrl nc-fer-fato';
        box.innerHTML = !isFinite(unica) ? esc(ops[0].text) : venda ? 'Você vende <b>' + unica + ' dias</b> nesta parte.' : 'São <b>' + unica + ' dias</b> de férias nesta parte.';
        return;
      }
      var b2 = grupoDeBotoes(sel, 'dias', 'nc-fer-dias-ctrl', ops.map(function (o) {
        var n = inteiro(o.text);
        var txt = n === 0 ? 'Nenhum' : isFinite(n) ? n + (n === 1 ? ' dia' : ' dias') : esc(o.text);
        return '<button type="button" role="radio" aria-checked="' + (o.value === sel.value) + '" data-v="' + esc(o.value) + '">' + txt + '</button>';
      }).join(''));
      if (b2) b2.className = 'nc-fer-ctrl nc-fer-dias-ctrl';
    });
  }

  /* ═══ [J5] A VOLTA DITA EM FRASE (classe nc-fer-retorno) ══════════════════════════════════
     O QUE FAZ  A data de retorno vira "Você volta a trabalhar na quarta-feira, 20 de janeiro
                de 2027." Sem data: "Escolha o dia em que começa, e aqui aparece o dia…".
     PODE MEXER as frases entre aspas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function maiuscula(t) { return t.charAt(0).toUpperCase() + t.slice(1); }
  function naSemana(d) { var g = d.getDay(); return (g === 0 || g === 6 ? 'no ' : 'na ') + SEMANA[g]; }
  function montarRetornos() {
    campos('nc-fer-retorno').forEach(function (inp) {
      var box = caixaDoItem(inp, 'retorno');
      if (!box) return;
      var d = dataBR(inp.value);
      box.classList.add('nc-fer-retorno-frase');
      containerDe(inp).classList.add('nc-fer-rotulo-dentro');
      box.innerHTML = d ? 'Você volta a trabalhar ' + naSemana(d) + ', <b>' + extenso(d) + '</b>.' : '<span class="nc-fer-sutil">Escolha o dia em que começa, e aqui aparece o dia em que você volta.</span>';
    });
  }

  /* ═══ [J6] AS PARTES (AS DATAS DE CADA UMA) ═══════════════════════════════════════════════
     O QUE FAZ  Lê, de cada região nc-fer-parte e nc-fer-programada à vista, o dia de saída, o
                de retorno e o número de dias. Não desenha nada: entrega a lista para [J7] e [J8].
     CUIDADO    Acha os campos pelo COMEÇO do nome: P78_DT_SAIDA_PARC, P78_DT_RETORNO_PARC e
                P78_NUM_DIAS_PARC. Se esses itens forem renomeados, mude aqui também.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* o campo de verdade pelo começo do nome: a página tem auxiliares escondidos com o mesmo
     começo (P78_DT_RETORNO_PARC1_X, P78_NUM_DIAS_PARC1_DSP…), vazios no pedido já feito —
     pegar o primeiro achado dava "volta no dia seguinte". Vale o primeiro que não é escondido
     e tem valor; sem valor em nenhum, o primeiro não escondido. */
  function campoPeloNome(reg, sel) {
    var cs = [].slice.call(reg.querySelectorAll(sel)).filter(function (c) { return c.type !== 'hidden'; });
    return cs.filter(function (c) { return c.value; })[0] || cs[0] || null;
  }
  function partes() {
    var out = [];
    regioes('nc-fer-parte').concat(regioes('nc-fer-programada')).forEach(function (reg, i) {
      if (!visivel(reg)) return;
      var saida = campoPeloNome(reg, 'input[id^="P78_DT_SAIDA_PARC"]');
      var volta = campoPeloNome(reg, 'input[id^="P78_DT_RETORNO_PARC"]');
      var ini = saida && dataBR(saida.value), ret = volta && dataBR(volta.value);
      if (!ini) return;
      var dias = NaN;
      var lst = campoPeloNome(reg, 'select[id^="P78_NUM_DIAS_PARC"]');
      if (lst && lst.value) dias = inteiro(lst.value);
      if (!isFinite(dias)) { var t = campoPeloNome(reg, 'input[id^="P78_NUM_DIAS_PARC"]'); if (t) dias = inteiro(t.value); }
      if (!isFinite(dias) && ret) dias = Math.round((ret - ini) / DIA);
      var titulo = ((reg.querySelector('.t-Region-title') || {}).textContent || '').replace(/\s*\(.*\)\s*/, '').trim();
      out.push({ ini: ini, fim: ret ? mais(ret, -1) : (isFinite(dias) ? mais(ini, dias - 1) : ini), volta: ret, dias: dias, titulo: titulo || (i + 1) + 'ª parte', programada: reg.classList.contains('nc-fer-programada') });
    });
    return out.sort(function (a, b) { return a.ini - b.ini; });
  }

  /* ═══ [J7] "CONFIRA SUAS FÉRIAS" (classe nc-fer-linha) ════════════════════════════════════
     O QUE FAZ  Cada parte em frases: "Começa: terça-feira, 5 de janeiro de 2027" / "Volta ao
                trabalho: …", e o aviso escrito quando a parte começa depois do limite
                (P78_DT_LIMITE_REQ) ou cruza com outra parte.
     IMPORTANTE A região LINHA_FERIAS é vazia no APEX de propósito: quem desenha é este arquivo.
     PODE MEXER as frases entre aspas.
     VISUAL     Natcorp_Ferias.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- nc-fer-linha: "Confira suas férias", em frases ----------
     Sem régua de meses: cada parte diz quando começa e quando a pessoa volta, com o aviso
     escrito quando começa depois do limite ou cruza com outra parte. */
  function montarLinha(ps) {
    var reg = regiao('nc-fer-linha');
    if (!reg) return;
    var corpo = reg.querySelector('.t-Region-body') || reg;
    var box = document.getElementById('nc-fer-linha');
    if (!box) { box = el('div', 'nc-fer-confira'); box.id = 'nc-fer-linha'; corpo.insertBefore(box, corpo.firstChild); }
    var limite = dataBR(val('P78_DT_LIMITE_REQ'));
    if (!ps.length) {
      box.innerHTML = '<p class="nc-fer-vazio">Escolha o dia em que cada parte começa. Suas férias aparecem aqui para você conferir.</p>';
      return;
    }
    box.innerHTML = '<ol class="nc-fer-lista">' + ps.map(function (p, i) {
      var tarde = limite && p.ini > limite;
      var junto = ps.some(function (q, j) { return j !== i && p.ini <= q.fim && q.ini <= p.fim; });
      var volta = p.volta || mais(p.fim, 1);
      return '<li class="nc-fer-item nc-fer-item--' + (i % 3) + (p.programada ? ' nc-fer-item--programada' : '') + (tarde || junto ? ' nc-fer-item--atencao' : '') + '">' +
        '<p class="nc-fer-item-titulo"><i aria-hidden="true"></i>' + esc(p.titulo) + (isFinite(p.dias) ? ' · ' + p.dias + ' dias' : '') + (p.programada ? ' · já programada' : '') + '</p>' +
        '<p><span>Começa</span> ' + maiuscula(SEMANA[p.ini.getDay()]) + ', <b>' + extenso(p.ini) + '</b></p>' +
        '<p><span>Volta ao trabalho</span> ' + maiuscula(SEMANA[volta.getDay()]) + ', <b>' + extenso(volta) + '</b></p>' +
        (tarde ? '<p class="nc-fer-aviso">Esta parte precisa começar até ' + extenso(limite) + '.</p>' : '') +
        (junto ? '<p class="nc-fer-aviso">Esta parte está no mesmo período de outra. Escolha outro dia.</p>' : '') +
        '</li>';
    }).join('') + '</ol>';
  }

  /* ═══ [J8] O QUE FALTA, AO LADO DOS BOTÕES (classe nc-fer-acoes) ══════════════════════════
     O QUE FAZ  Uma frase ao lado dos botões: "Escolha como você quer tirar suas férias.",
                "Falta escolher o dia de início de 1 parte." ou "Pronto: 30 dias escolhidos.
                Confira e envie."
     PODE MEXER as frases entre aspas.
     VISUAL     Natcorp_Ferias.css › [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarResumo(ps) {
    var reg = regiao('nc-fer-acoes');
    if (!reg) return;
    var r = document.getElementById('nc-fer-resumo-acoes');
    if (!r) {
      r = el('p', 'nc-fer-resumo-acoes'); r.id = 'nc-fer-resumo-acoes';
      r.setAttribute('role', 'status');
      var meio = reg.querySelector('.t-ButtonRegion-col--content') || reg.querySelector('.t-ButtonRegion-wrap') || reg;
      meio.insertBefore(r, meio.firstChild);
    }
    var opcao = campos('nc-fer-opcao').filter(function (s) { return s.tagName === 'SELECT' && visivel(containerDe(s)); })[0];
    var abertas = regioes('nc-fer-parte').filter(visivel);
    var semData = abertas.filter(function (reg) { var i = campoPeloNome(reg, 'input[id^="P78_DT_SAIDA_PARC"]'); return i && !i.value; }).length;
    var novas = ps.filter(function (p) { return !p.programada; });
    var dias = novas.reduce(function (s, p) { return s + (isFinite(p.dias) ? p.dias : 0); }, 0);
    r.classList.toggle('nc-fer-resumo-pronto', !!(opcao && opcao.value && abertas.length && !semData));
    if (opcao && soLeitura(opcao)) opcao = null;   /* pedido já feito: nada a escolher nem a enviar */
    r.hidden = !opcao;
    r.innerHTML = !opcao ? '' : !opcao.value ? 'Escolha como você quer tirar suas férias.'
      : semData ? 'Falta escolher o dia de início de ' + (semData === 1 ? '1 parte.' : semData + ' partes.')
      : abertas.length ? '<b>Pronto: ' + dias + ' dias escolhidos.</b> Confira e envie.' : '';
  }

  /* ═══ [J10] O PEDIDO: NÚMERO, SITUAÇÃO E QUEM PEDIU ═══════════════════════════════════════
     O QUE FAZ  A região do título ("Requisição de Férias: Nº 55477 - 28/07/2020 (Cancelada)",
                com Requisição / Data / Situação / Solicitante / Usuário) vira um cartão claro:
                "Pedido de férias nº …", a situação numa etiqueta colorida e "Aberto em … por
                … · cargo". No pedido novo: "Novo pedido de férias" e quem está pedindo.
                Os campos continuam na região, fora da vista. A Situação continua à vista
                quando o APEX deixa trocar (lista aberta). O botão de ver quem pediu vai para
                dentro do cartão — o mesmo botão, com o mesmo clique.
     ACHADO SEM CLASSE  a região que contém o item P78_COD_SOLICITACAO.
     LÊ DOS ITENS  P78_COD_SOLICITACAO, P78_ROWID, P78_SIT_REQUISICAO, P78_DT_SOLICITACAO,
                P78_DT_ATUALIZACAO, P78_SOLICITANTE ("empresa / matrícula - nome / cargo").
     PODE MEXER as frases entre aspas e a lista TOM (que cor tem cada situação).
     VISUAL     Natcorp_Ferias.css › [C11]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim(); }
  /* "SUPERVISOR DE SETOR" ou "Supervisor De Setor" → "Supervisor de Setor" */
  function nomeProprio(t) {
    t = String(t || '').trim();
    if (t === t.toUpperCase()) t = t.toLowerCase().replace(/(^|\s)(\S)/g, function (x, a, b) { return a + b.toUpperCase(); });
    return t.replace(/\s(De|Da|Do|Das|Dos|E)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  /* "624 - Supervisor De Setor" → "624 - Supervisor de Setor" (sempre código e descrição) */
  function codDesc(t) { var m = /^\s*([\w.]+)\s+-\s+(.+)$/.exec(String(t || '')); return m ? m[1] + ' - ' + nomeProprio(m[2]) : nomeProprio(t); }
  function textoDe(id) {
    var e = document.getElementById(id);
    if (!e) return '';
    if (e.tagName === 'SELECT') return e.selectedIndex >= 0 && e.value ? e.options[e.selectedIndex].text.trim() : '';
    return String(/^(INPUT|TEXTAREA)$/.test(e.tagName) ? e.value : e.textContent).trim();
  }
  function contDe(id) { var e = document.getElementById(id); return document.getElementById(id + '_CONTAINER') || (e && e.closest('.t-Form-fieldContainer')); }
  /* PODE MEXER: pelo texto da situação, a cor da etiqueta — o mesmo esquema da Marcação - Abono:
     'ok' verde (aprovada, concluída), 'nao' vermelho (cancelada, reprovada); o resto, 'anda'
     âmbar (em andamento, suspensa…) */
  var TOM = [[/aprov|conclu|program|efetiv/i, 'ok'], [/cancel|reprov|recus|negad/i, 'nao']];
  function tomDe(sit) { for (var i = 0; i < TOM.length; i++) if (TOM[i][0].test(sit)) return TOM[i][1]; return 'anda'; }
  /* os ícones da situação: certo, x, relógio */
  var IC_TOM = { ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>', nao: '<path d="M7 7l10 10M17 7L7 17"/>', anda: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>' };
  function iconeTom(t) { return '<svg viewBox="0 0 24 24" aria-hidden="true">' + (IC_TOM[t] || IC_TOM.anda) + '</svg>'; }
  var PED = null;
  function montarPedido() {
    var cod = document.getElementById('P78_COD_SOLICITACAO');
    var reg = cod && cod.closest('.t-Region');
    if (!reg) return null;
    if (!PED) {
      PED = { reg: reg, box: el('div', 'nc-fer-pedido') };
      reg.classList.add('nc-fer-pedido-reg');
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
      corpo.insertBefore(PED.box, corpo.firstChild);
      /* o que o cartão já diz sai dos campos */
      ['P78_COD_SOLICITACAO', 'P78_DT_SOLICITACAO', 'P78_SOLICITANTE', 'P78_USUARIO', 'P78_DT_ATUALIZACAO'].forEach(function (id) { var c = contDe(id); if (c) c.classList.add('nc-fer-dito'); });
      PED.botao = [].filter.call(corpo.querySelectorAll('button.t-Button, a.t-Button'), function (b) { return !PED.box.contains(b); })[0] || null;
    }
    var gravado = !!(val('P78_ROWID') || val('P78_COD_SOLICITACAO'));
    var sel = document.getElementById('P78_SIT_REQUISICAO');
    var sit = textoDe('P78_SIT_REQUISICAO');
    if (!sit) { var m = /\(([^)]+)\)\s*$/.exec(val('P78_TITULO')); sit = m ? m[1] : ''; }
    /* a Situação só fica à vista quando dá para trocar E gravar: lista aberta e um botão que
       grava na página (Salvar, Aplicar, Alterar…). Sem botão, trocar não teria efeito */
    var grava = [].some.call(document.querySelectorAll('button.t-Button'), function (b) { return visivel(b) && /salvar|aplicar|alterar|gravar|atualizar/i.test(b.textContent); });
    var c = contDe('P78_SIT_REQUISICAO');
    if (c) c.classList.toggle('nc-fer-dito', !sel || sel.tagName !== 'SELECT' || sel.disabled || !grava);
    var sol = textoDe('P78_SOLICITANTE').split(/\s+\/\s+/);
    var quem = nomeProprio(semCodigo(sol[1] || '')), cargo = sol[2] ? codDesc(sol[2]) : '';
    var aberto = textoDe('P78_DT_SOLICITACAO').replace(/\s.*$/, ''), mudou = textoDe('P78_DT_ATUALIZACAO').replace(/\s.*$/, '');
    var h = '<span class="nc-fer-pedido-ic" aria-hidden="true"><svg viewBox="0 0 24 24"><rect x="3.5" y="5" width="17" height="15.5" rx="3"/><path d="M3.5 10h17M8 3v4M16 3v4"/></svg></span>' +
      '<div class="nc-fer-pedido-texto">' +
        '<div class="nc-fer-pedido-topo"><p class="nc-fer-pedido-n">' + (gravado ? 'Pedido de férias nº <b>' + esc(val('P78_COD_SOLICITACAO')) + '</b>' : '<b>Novo pedido de férias</b>') + '</p>' +
          (gravado && sit ? '<span class="nc-fer-sit nc-fer-sit--' + tomDe(sit) + '">' + iconeTom(tomDe(sit)) + esc(nomeProprio(sit)) + '</span>' : '') + '</div>' +
        '<p class="nc-fer-pedido-quem">' + (gravado ? (aberto ? 'Aberto em <b>' + esc(aberto) + '</b>' : 'Aberto') + (quem ? ' por <b>' + esc(quem) + '</b>' : '') : (quem ? 'Quem pede: <b>' + esc(quem) + '</b>' : '')) +
          (cargo ? '<span class="nc-fer-sutil"> · ' + esc(cargo) + '</span>' : '') +
          (gravado && mudou && mudou !== aberto ? '<span class="nc-fer-sutil"> · atualizado em ' + esc(mudou) + '</span>' : '') + '</p>' +
      '</div>';
    if (PED.box.__h !== h) { PED.box.__h = h; PED.box.innerHTML = h; }
    if (PED.botao && PED.botao.parentNode !== PED.box) {
      PED.botao.classList.add('nc-fer-pedido-ver');
      PED.botao.setAttribute('title', 'Ver os dados de quem pediu');
      PED.botao.setAttribute('aria-label', 'Ver os dados de quem pediu');
      PED.box.appendChild(PED.botao);
    } else if (PED.botao && PED.box.lastChild !== PED.botao) PED.box.appendChild(PED.botao);
    return reg;
  }

  /* ═══ [J11] O CAMINHO DA APROVAÇÃO (o mesmo das outras requisições) ══════════════════════
     O QUE FAZ  O relatório "Aprovadores" sai da coluna estreita da direita e vai para logo
                abaixo do pedido, na largura toda (a coluna vazia some). Vira uma faixa: o
                resumo ("1 de 5 aprovaram · aguardando Fulano"), cada aprovador com um sinal
                (aprovou, reprovou, aguardando, na fila) e o que cada um escreveu. Tocar no
                nome abre os "Dados do Colaborador", como a lupa do relatório.
                Os botões Aprovar/Reprovar do APEX, se a página tiver, vão para dentro da faixa
                quando é a vez de quem está vendo — os mesmos botões, com os mesmos cliques.
                No celular, a lista abre por "Ver o caminho".
     ACHADO SEM CLASSE  o relatório com a coluna APROVADOR.
     LÊ DAS COLUNAS  APROVADOR, DATA, STATUS, JUSTIFICATIVA (pelo nome da coluna).
     CUIDADO    Se uma dessas colunas for renomeada no relatório, a faixa não acha os dados.
     PODE MEXER os textos entre aspas: 'Aprovação', 'Ver o caminho', 'Na fila'…
     VISUAL     Natcorp_Ferias.css › [C12]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var AP = null, AP_ABERTO = false, AP_ASSIN = '';
  function limpo(t) { t = String(t || '').replace(/\s+/g, ' ').trim(); return /^[-–—]?$/.test(t) ? '' : t; }
  /* "700 - 477 - JOSE OLIVEIRA" → "Jose Oliveira"; "MASTER" → "Master" */
  function nomeAprovador(t) { var m = /^\s*\d+\s*-\s*\d+\s*-\s*(.+)$/.exec(t || ''); return nomeProprio(m ? m[1] : t); }
  /* a coluna da região fica sem nada à vista: some, e a vizinha ocupa a linha toda */
  function colunaVazia(col, cheia) {
    if (!col || col === cheia || [].some.call(col.querySelectorAll(':scope > .t-Region'), visivel)) return;
    col.classList.add('nc-fer-col-vazia');
    if (cheia) cheia.classList.add('nc-fer-col-cheia');
  }
  function montarAprovacao(pedido) {
    if (!AP) {
      var th = document.querySelector('table.t-Report-report th#APROVADOR, td[headers="APROVADOR"]');
      var reg = th && th.closest('.t-Region');
      if (!reg) return;
      AP = { reg: reg, botoes: [].slice.call(document.querySelectorAll('button.t-Button, a.t-Button')).filter(function (b) { return /^(aprovar|reprovar)$/i.test(b.textContent.trim()); }) };
      AP.botoes.forEach(function (b) { b.__ncCasa = b.parentNode; });   /* 04/10: o lugar de origem */
      reg.classList.add('nc-fer-aprov');
      if (pedido) {
        var colV = reg.closest('.col'), colP = pedido.closest('.col');
        pedido.after(reg);
        colunaVazia(colV, colP);
      }
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
      AP.box = el('div', 'nc-fer-caminho');
      corpo.insertBefore(AP.box, corpo.firstChild);
      AP.box.addEventListener('click', function (e) {
        if (e.target.closest('.nc-fer-caminho-ver')) { AP_ABERTO = !AP_ABERTO; AP_ASSIN = ''; agendar(); return; }
        var b = e.target.closest('[data-ap]');
        var tr = b && AP.linhas[+b.getAttribute('data-ap')];
        var a = tr && tr.querySelector('td[headers="APROVADOR"] a, a');
        if (a) a.click();   /* a mesma lupa do relatório: abre os Dados do Colaborador */
      });
    }
    AP.linhas = [].slice.call(AP.reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); });
    var passos = AP.linhas.map(function (tr, i) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; }
      var st = c('STATUS');
      return { i: i, nome: nomeAprovador(c('APROVADOR')), data: c('DATA'), just: c('JUSTIFICATIVA'), link: !!tr.querySelector('a'),
        estado: /^r$|reprov|recus/i.test(st) ? 'nao' : /^a$|aprov/i.test(st) ? 'ok' : 'pend' };
    }).filter(function (x) { return x.nome; });
    var n = passos.length;
    AP.reg.classList.toggle('nc-fer-aprov--vazio', !n);
    if (!n && AP.reg.closest('.col') !== (PED && PED.reg.closest('.col'))) colunaVazia(AP.reg.closest('.col'), PED && PED.reg.closest('.col'));
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; }), atual = -1;
    if (!reprovado) for (var i = 0; i < n; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var aprovados = passos.filter(function (x) { return x.estado === 'ok'; }).length;
    var cancelado = /cancel|suspens/i.test(textoDe('P78_SIT_REQUISICAO') || val('P78_TITULO'));
    var bts = AP.botoes.filter(function (b) { return b.style.display !== 'none'; });
    var vez = bts.length > 0 && !cancelado && atual >= 0;   /* só há o que decidir com uma etapa pendente */
    var assin = JSON.stringify([passos, atual, bts.length, cancelado, AP_ABERTO]);
    if (assin === AP_ASSIN) return;
    AP_ASSIN = assin;
    /* 04/10: antes de reescrever a faixa, Aprovar/Reprovar voltam ao lugar de origem — reescrita
       com eles dentro, saíam da página (a ação dinâmica que os mostra não os achava mais) */
    AP.botoes.forEach(function (b) { if (b.__ncCasa && !b.__ncCasa.contains(b)) b.__ncCasa.appendChild(b); });
    if (!n) { AP.box.innerHTML = ''; return; }
    var quemNao = passos.filter(function (x) { return x.estado === 'nao'; })[0];
    /* o tom da faixa, no esquema da etiqueta: reprovado ou cancelado vermelho, todos aprovaram
       verde, ainda andando âmbar */
    var estado = reprovado || cancelado ? 'nao' : atual < 0 ? 'ok' : 'anda';
    var resumo = reprovado ? '<b>Reprovado</b> por ' + esc(quemNao.nome)
      : cancelado ? '<b>Pedido cancelado</b> · ' + aprovados + ' de ' + n + (aprovados === 1 ? ' aprovou' : ' aprovaram')
      : atual < 0 ? '<b>Aprovado</b> por ' + (n === 1 ? esc(passos[0].nome) : 'todos')
      : vez ? '<b>' + aprovados + ' de ' + n + '</b> · <b>é a sua vez</b>'
      : '<b>' + aprovados + ' de ' + n + '</b> ' + (aprovados === 1 ? 'aprovou' : 'aprovaram') + ' · aguardando <b>' + esc(passos[atual].nome) + '</b>';
    var justs = passos.filter(function (x) { return x.just; });
    AP.reg.classList.toggle('nc-fer-ap-aberto', AP_ABERTO);
    AP.box.className = 'nc-fer-caminho nc-fer-caminho--' + estado + (vez ? ' is-sua-vez' : '');
    AP.box.innerHTML =
      '<p class="nc-fer-caminho-rot">Aprovação</p><div class="nc-fer-caminho-cab"><p class="nc-fer-caminho-faixa">' + iconeTom(estado) + '<span>' + resumo + '</span></p>' +
        '<button type="button" class="nc-fer-caminho-ver" aria-expanded="' + AP_ABERTO + '">' + (AP_ABERTO ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
      '<ol class="nc-fer-passos-ap">' + passos.map(function (x, k) {
        var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : k === atual && !cancelado ? 'is-vez' : 'is-fila';
        var dia = x.data.replace(/\s.*$/, '');
        var st = x.estado === 'ok' ? (dia ? 'Aprovou em ' + dia : 'Aprovou') : x.estado === 'nao' ? 'Reprovou' + (dia ? ' em ' + dia : '') : cls === 'is-vez' ? (vez ? 'Sua vez' : 'Aguardando') : 'Na fila';
        var ic = IC_TOM[x.estado === 'ok' ? 'ok' : x.estado === 'nao' ? 'nao' : 'anda'];
        var dica = x.nome + ' — ' + st.toLowerCase() + (x.just ? ': "' + x.just + '"' : '') + (x.link ? ' (toque para ver os dados)' : '');
        var nome = x.link ? '<button type="button" class="nc-fer-ap-nome" data-ap="' + x.i + '">' + esc(x.nome) + '</button>' : '<span class="nc-fer-ap-nome">' + esc(x.nome) + '</span>';
        return '<li class="nc-fer-ap ' + cls + '" title="' + esc(dica) + '"><span class="nc-fer-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
          '<span class="nc-fer-ap-texto">' + nome + '<span class="nc-fer-ap-estado">' + esc(st) + '</span></span></li>';
      }).join('') + '</ol>' +
      /* 04/10: a decisão aparece sempre que a PÁGINA mostra Aprovar/Reprovar (a condição é dela);
         antes só com "é a sua vez", e fora disso os botões ficavam no cabeçalho escondido */
      (bts.length ? '<div class="nc-fer-decisao"><p class="nc-fer-decisao-txt">Confira as férias e decida.</p><div class="nc-fer-decisao-botoes" aria-label="Sua decisão"></div></div>' : '') +
      (justs.length ? '<div class="nc-fer-ap-justs">' + justs.map(function (x) {
        return '<blockquote class="nc-fer-ap-just' + (x.estado === 'nao' ? ' is-nao' : '') + '"><b>' + esc(x.nome) + (x.estado === 'nao' ? ' reprovou' : x.estado === 'ok' ? ' aprovou' : '') + ':</b> ' + esc(x.just) + '</blockquote>';
      }).join('') + '</div>' : '');
    var dest = AP.box.querySelector('.nc-fer-decisao-botoes');
    if (dest) bts.slice().sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) {
      b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-fer-reprovar' : 'nc-fer-aprovar');
      dest.appendChild(b);
    });
  }

  /* ═══ [J12] O CARTÃO DO COLABORADOR (classe nc-fer-colaborador) ═══════════════════════════
     O QUE FAZ  Na região "Colaborador Solicitado", monta o cartão: a foto (ou as iniciais),
                o nome, "Matrícula … · empresa", a filial, a situação e "Na empresa desde"
                com os anos de casa — o mesmo cartão da Requisição de Benefícios.
                As sub-regiões Colab Foto e Colab Info saem da vista (o cartão diz o que elas
                diziam). No pedido NOVO, a escolha do colaborador (a lupa) continua à vista,
                acima do cartão; no pedido já feito, ela sai também. O botão Visualizar do
                título fica onde está.
     LÊ DOS ITENS  P78_MATRICULA_DISPLAY, P78_COD_EMPRESA_DISPLAY, P78_SITUACAO_COLAB,
                P78_DT_ADMISSAO, P78_FOTO_COLAB e a filial escrita em P78_MATRICULA
                ("… - Filial: (97) Natcorp …").
     PODE MEXER os rótulos entre aspas: 'Filial', 'Situação', 'Na empresa desde', 'Matrícula '.
     VISUAL     Natcorp_Ferias.css › [C13]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarColaborador() {
    var reg = regiao('nc-fer-colaborador');
    if (!reg) return;
    var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
    var col = textoDe('P78_MATRICULA_DISPLAY');
    var nome = nomeProprio(semCodigo(col));
    var p = document.getElementById('nc-fer-perfil');
    reg.classList.toggle('nc-fer-com-perfil', !!nome);
    if (!nome) { if (p) p.hidden = true; return; }
    if (!p) { p = el('div', 'nc-fer-perfil'); p.id = 'nc-fer-perfil'; }
    p.hidden = false;
    /* a escolha do colaborador (o contêiner com P78_MATRICULA) fica no alto no pedido novo */
    var gravado = !!(val('P78_ROWID') || val('P78_COD_SOLICITACAO'));
    var esc0 = document.getElementById('P78_MATRICULA'), escolha = esc0 && esc0.closest('.container');
    [].forEach.call(corpo.children, function (c) { if (c !== p) c.classList.toggle('nc-fer-fora', gravado || c !== escolha); });
    if (p.parentNode !== corpo) corpo.appendChild(p);
    var mat = (col.match(/^\s*(\d+)/) || [])[1] || '';
    var emp = codDesc(textoDe('P78_COD_EMPRESA_DISPLAY'));
    /* "Matrícula: (205818) Fulano - Filial: (97) Natcorp Fil 97 - C.Custo: (…) … - Local: (…) …":
       a filial vai até o próximo " - Rótulo: (" */
    var fil = /Filial:\s*\((\w+)\)\s*(.+?)(?=\s+-\s+[^-:()]+:\s*\(|$)/i.exec(textoDe('P78_MATRICULA'));
    var filial = fil ? fil[1] + ' - ' + nomeProprio(fil[2].trim()) : '';
    var sit = textoDe('P78_SITUACAO_COLAB').split(/\s+-\s+/);
    var situacao = nomeProprio(sit[1] || sit[0] || ''), desdeSit = dataBR(sit[2] || '');
    var adm = dataBR(textoDe('P78_DT_ADMISSAO'));
    var anos = adm ? Math.floor((hoje() - adm) / (365.25 * DIA)) : 0;
    var foto = document.querySelector('#P78_FOTO_COLAB, #P78_FOTO_COLAB_CONTAINER img');
    var src = foto && foto.getAttribute('src');
    var ini = nome.split(/\s+/).filter(Boolean);
    ini = (ini[0] || '').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '');
    var h =
      '<div class="nc-fer-avatar">' + (src ? '<img alt="" src="' + esc(src) + '">' : '<span>' + esc(ini.toUpperCase()) + '</span>') + '</div>' +
      '<div class="nc-fer-quem"><p class="nc-fer-nome">' + esc(nome) + '</p>' +
        '<p class="nc-fer-meta">' + [mat ? 'Matrícula ' + esc(mat) : '', esc(emp)].filter(Boolean).join('<span aria-hidden="true"> · </span>') + '</p></div>' +
      '<dl class="nc-fer-fatos">' +
        (filial ? '<div><dt>Filial</dt><dd>' + esc(filial) + '</dd></div>' : '') +
        (situacao ? '<div><dt>Situação</dt><dd><span class="nc-fer-chip' + (/ativo/i.test(situacao) ? ' nc-fer-chip--ok' : '') + '">' + esc(situacao) + '</span>' + (desdeSit ? ' <span class="nc-fer-sutil">desde ' + esc(sit[2]) + '</span>' : '') + '</dd></div>' : '') +
        (adm ? '<div><dt>Na empresa desde</dt><dd>' + MESES[adm.getMonth()] + ' de ' + adm.getFullYear() + (anos > 0 ? ' <span class="nc-fer-sutil">· ' + anos + (anos === 1 ? ' ano' : ' anos') + '</span>' : '') + '</dd></div>' : '') +
      '</dl>';
    if (p.__h !== h) {
      p.__h = h; p.innerHTML = h;
      /* a foto não carregou (sessão vencida, arquivo apagado): ficam as iniciais */
      var img = p.querySelector('.nc-fer-avatar img');
      if (img) img.addEventListener('error', function () { img.parentNode.innerHTML = '<span>' + esc(ini.toUpperCase()) + '</span>'; });
    }
  }

  /* ═══ [J9] O MAESTRO: QUANDO TUDO É REDESENHADO ═══════════════════════════════════════════
     O QUE FAZ  tudo() chama as partes acima, nesta ordem. iniciar() roda uma vez quando a
                página abre e depois manda redesenhar sempre que algo muda: um item P78_ é
                alterado, uma lista é recarregada, uma ação dinâmica traz valores do servidor,
                uma parte aparece ou some.
     CUIDADO    Não mude a ordem das chamadas em tudo(): [J7] e [J8] usam as partes lidas em [J6].
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp férias] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tudo() {
    var pedido = montarPedido();
    montarAprovacao(pedido);
    montarColaborador();
    montarDireito();
    montarOpcoes();
    montarSimNao();
    montarDias();
    montarRetornos();
    var ps = partes();
    montarLinha(ps);
    montarResumo(ps);
  }
  var agendado = false;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () { agendado = false; try { tudo(); } catch (e) { if (window.console) console.warn('[Natcorp férias]', e); } });
  }
  function iniciar() {
    document.body.classList.add('nc-fer');
    tudo();
    /* valores postos pelas ações dinâmicas (change), listas recarregadas (apexafterrefresh),
       partes mostradas/escondidas pela opção escolhida (o style das regiões) */
    $(document).on('change', '[id^="P78_"]', agendar);
    $(document).on('apexafterrefresh', agendar);
    /* valores trazidos do servidor por ação dinâmica (Executar PL/SQL, "itens a retornar")
       chegam SEM o evento change: sem isto a tela ficava com a leitura de antes da resposta */
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    if (window.MutationObserver) {
      var mo = new MutationObserver(agendar);
      regioes('nc-fer-parte').concat(regioes('nc-fer-programada'))
        .concat(campos('nc-fer-opcao').map(containerDe).filter(Boolean))
        .forEach(function (r) { mo.observe(r, { attributes: true, attributeFilter: ['style'] }); });
    }
  }
  /* 04/10: CUIDADO — começa DEPOIS das ações de abertura da página ("apexreadyend"): "Disable
     Fields Consult" trava as partes, "Opção de Parcelas"/"Estagiário" mostram e escondem os
     campos e "Hide Aprov Sit <> 1" / "Hide / Show Aprovações" (app 300) escondem botões. Antes delas o
     desenho lia o estado errado (campo aberto, botão à vista) e podia escolher sozinho a opção
     única de uma lista que a página ia esconder. Sem o evento em 3 s, começa assim mesmo. */
  var comecou = false;
  function comecarUmaVez() { if (comecou) return; comecou = true; setTimeout(iniciar, 0); }
  $(window).one('apexreadyend', comecarUmaVez);
  $(function () { setTimeout(comecarUmaVez, 3000); });
})();
