/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · FOLHA DE PAGAMENTO DO MÊS  —  o "arrumador" da página (JavaScript)            ║
   ║  App 300 (Portal do Colaborador) · Página 74 · Folha do Mês (a consulta do holerite)     ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: FOLHA-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   O colaborador abre esta página para saber três coisas: QUANTO GANHOU, QUANTO FOI DESCONTADO e
   QUANTO RECEBE. Quase sempre no celular, e muitos leem com dificuldade. Então:
     • o MÊS no alto, com setas para o anterior e o seguinte (a lista original continua mandando);
     • o RECIBO: a conta em três linhas — Você ganhou − Foi descontado = Você recebe —, uma barra
       que mostra a parte que fica com a pessoa, e a frase "De cada R$ 100 que você ganhou,
       R$ 38 foram descontados". Botão "Ouvir": o celular lê o resumo em voz alta;
     • "O que você ganhou" e "O que foi descontado": uma linha por verba, a maior primeiro. Quando
       a verba é conhecida (INSS, DSR, 1/3 de férias, vale-transporte…), tocar nela abre "o que
       é isso", em palavras simples;
     • "Bases de cálculo": recolhidas — não é dinheiro que entra nem que sai;
     • "Ver tabela completa" mostra o relatório original, como sempre foi.

   ── MODO "OCORRÊNCIAS" (300:104, Ocorrência de Pagamento) ────────────────────────────────
     A mesma página serve os LANÇAMENTOS para o cálculo (ocorrencia_calculo). Ligado pela página:
     JavaScript › Function and Global Variable Declaration:
         var ncFolha = { modo: 'ocorrencias', processo: 'NC_OCORR_DADOS' };
     Diferenças: ocorrência NÃO é o pagamento — o resumo mostra Ganhos e Descontos lançados, sem
     "Você recebe", e aponta para a Folha do Mês; a lista tem "Todos os meses" (uma faixa por mês
     com os totais, a mais nova aberta, as outras montadas só ao abrir).

   ── DE ONDE VÊM OS DADOS ──────────────────────────────────────────────────────────────────
     Do processo Ajax Callback NC_FOLHA_DADOS desta página (posto pelo aplicar-folha-app300.py):
     a MESMA consulta do relatório + o TIPO de cada verba (ocorr_pagto.tipo_rubrica: 1 crédito,
     2 débito, 3 base) e a MESMA validação do mês da ação dinâmica "Valida Dt Ref"
     (pkg_executa_f011544.valida_parametros). O relatório não tem o tipo — sem ele não dá para
     separar ganho de desconto. Sem o processo (página não importada): fica o relatório de sempre.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada. Não troca o mês por conta própria: as setas e a lista nova só escolhem uma
     opção na lista original (P74_DATA_REF), e as ações da página rodam como antes. O cartão do
     colaborador é a peça global (Natcorp_Colab).

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 74 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Folha.js
     Página 74 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Folha.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [F1] Como a página é reconhecida                                      CUIDADO
     [F2] Os textos                                                        PODE MEXER
     [F3] "O que é isso?" — a explicação de cada verba conhecida           PODE MEXER
     [F4] Ferramentas (dinheiro, nomes, meses)
     [F5] O mês no alto
     [F6] Buscar os dados (NC_FOLHA_DADOS)                                 CUIDADO
     [F7] Desenhar: recibo, listas, bases
     [F8] Ouvir
     [F9] O maestro
*/
(function () {
  'use strict';
  if (window.__ncFolha || !window.apex || !window.apex.jQuery) return;

  /* ═══ [F1] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════════
     O QUE FAZ  Continua só se a página tiver a lista do mês (…_DATA_REF), os itens ocultos
                …_EMP e …_MAT e um relatório interativo. O prefixo (P74_) sai da própria lista.
     CUIDADO    Se P74_DATA_REF, P74_EMP ou P74_MAT forem renomeados no APEX, o desenho some e
                volta o relatório de sempre.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var SEL = document.querySelector('select[id$="_DATA_REF"]');
  if (!SEL) return;
  var P = SEL.id.replace(/DATA_REF$/, '');
  if (!document.getElementById(P + 'EMP') || !document.getElementById(P + 'MAT')) return;
  window.__ncFolha = true;
  var $ = window.apex.jQuery;
  var PROCESSO = 'NC_FOLHA_DADOS', OCORR = false;
  /* a lista do mês mora na região do colaborador: com ela lá, o cartão global (Natcorp_Colab)
     não se monta (região com campo de escolher). Ela sai já, ANTES dele, para uma guarda fora
     da vista ao lado da região — o APEX continua lendo, escrevendo e validando a lista. */
  (function () {
    var c = document.getElementById(SEL.id + '_CONTAINER'), reg = c && c.closest('.t-Region');
    while (reg && reg.parentElement && reg.parentElement.closest('.t-Region')) reg = reg.parentElement.closest('.t-Region');
    if (!c || !reg) return;
    var guarda = document.createElement('div'); guarda.className = 'nc-fo-guarda';
    reg.parentNode.insertBefore(guarda, reg.nextSibling);
    guarda.appendChild(c);
  })();

  /* ═══ [F2] OS TEXTOS ═════════════════════════════════════════════════════════════════════
     PODE MEXER  tudo entre aspas. Mantenha as frases curtas: quem lê, lê com dificuldade.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T = {
    titulo: function (mes) { return 'Seu pagamento de ' + mes; },
    periodo: function (a, b) { return 'De ' + a + ' a ' + b; },
    ganhou: 'Você ganhou',
    descontado: 'Foi descontado',
    recebe: 'Você recebe',
    recebeNegativo: 'Ficou faltando',
    fica: 'Fica com você',
    descontos: 'Descontos',
    deCada: function (d) { return 'De cada <b>R$ 100</b> que você ganhou, <b>R$ ' + d + '</b> ' + (d === '1' ? 'foi descontado' : 'foram descontados') + '.'; },
    passou: 'Neste mês os descontos foram maiores que os ganhos.',
    gGanho: 'O que você ganhou',
    gDesc: 'O que foi descontado',
    gBase: 'Bases de cálculo e informações',
    gBaseDica: 'Não é dinheiro que entra nem que sai do seu pagamento. São valores que o sistema usa para fazer as contas de impostos, FGTS e benefícios.',
    itens: function (n) { return n === 1 ? '1 item' : n + ' itens'; },
    nenhumGanho: 'Nenhum valor a receber neste mês.',
    nenhumDesc: 'Nenhum desconto neste mês.',
    oQueE: 'O que é isso?',
    ref: 'Referência',
    cod: 'Código',
    mesAnt: 'Mês anterior',
    mesProx: 'Mês seguinte',
    escolher: 'Escolha o mês',
    carregando: 'Buscando o seu pagamento…',
    semMes: 'Ainda não há pagamento para mostrar.',
    bloqueadoTit: 'Este mês ainda não pode ser consultado',
    erro: 'Não foi possível mostrar o pagamento agora.',
    erroDica: 'Toque em "Ver tabela completa" para ver os valores.',
    verTabela: 'Ver tabela completa',
    esconderTabela: 'Esconder tabela completa',
    ouvir: 'Ouvir',
    parar: 'Parar'
  };
  /* PODE MEXER — os textos do modo "ocorrências" (300:104): trocam os de cima */
  var T_OCORR = {
    titulo: function (mes) { return 'Lançamentos de ' + mes; },
    ganhou: 'Ganhos lançados',
    descontado: 'Descontos lançados',
    gGanho: 'Ganhos lançados',
    gDesc: 'Descontos lançados',
    nenhumGanho: 'Nenhum ganho lançado neste mês.',
    nenhumDesc: 'Nenhum desconto lançado neste mês.',
    carregando: 'Buscando os lançamentos…',
    semMes: 'Nenhum lançamento para mostrar.',
    erro: 'Não foi possível mostrar os lançamentos agora.',
    dica: 'São os valores lançados para o cálculo da folha. O que você recebe aparece na Folha do Mês.',
    soBases: 'Neste mês só há bases de cálculo (abertas logo abaixo).',
    verFolha: 'Ver a Folha do Mês',
    todosMeses: 'Todos os meses',
    todosTit: 'Todos os lançamentos',
    todosSub: function (m, n) { return (m === 1 ? '1 mês' : m + ' meses') + ' · ' + (n === 1 ? '1 lançamento' : n + ' lançamentos'); },
    soBasesCurto: 'Só bases'
  };

  /* ═══ [F3] "O QUE É ISSO?" — A EXPLICAÇÃO DE CADA VERBA CONHECIDA ═══════════════════════
     O QUE É    Uma lista de [ teste, explicação ]. O teste é feito no NOME da verba, sem acento
                e em minúsculas; a PRIMEIRA que casar vence. A explicação pode ser uma frase só,
                ou { g: 'quando é ganho', d: 'quando é desconto' }.
     PODE MEXER as frases e a ordem; acrescentar linhas.
     CUIDADO    Só diga o que vale para TODO mundo. Na dúvida, não explique: a linha fica sem o
                "O que é isso?", o que é melhor do que uma explicação errada.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var EXPLICA = [
    [/^(base|bs\b|sal(ario)? contr|capital segurado|dias uteis)/, 'Valor usado só para fazer contas. Não entra nem sai do seu pagamento.'],
    [/1\/3|um terco|terco/, 'Um terço a mais sobre as férias. É um direito de todo trabalhador.'],
    [/inss|i\.n\.s\.s/, 'Contribuição para o INSS (Previdência Social). Garante aposentadoria, auxílio-doença e outros direitos. É descontada por lei.'],
    [/irrf|imposto de renda|\bi\.?r\.?\b/, 'Imposto de Renda, do governo. É descontado direto do salário e depende de quanto você ganha.'],
    [/fgts/, 'A empresa deposita este valor numa conta do FGTS em seu nome. Não sai do seu salário.'],
    [/^media\b.*(ferias|13)/, 'Média dos valores que mudam todo mês (como horas extras), somada às férias ou ao 13º.'],
    [/horas? normais|salario base|^salario$/, 'O seu salário pelas horas de trabalho do mês.'],
    [/horas? extras?|\bh\.?e\.?\b/, 'Horas que você trabalhou além do seu horário, pagas com um valor a mais.'],
    [/\bdsr\b|repouso/, 'Descanso Semanal Remunerado: o pagamento dos seus dias de folga.'],
    [/adicional noturno|ad\.? ?noturno/, 'Valor a mais por trabalhar à noite.'],
    [/insalubr/, 'Valor a mais por trabalhar em lugar que pode fazer mal à saúde.'],
    [/periculos/, 'Valor a mais por trabalhar em atividade de risco.'],
    [/\b13[oº]?\b.*sal|decimo terceiro|13o sal/, 'O 13º salário: um salário a mais por ano.'],
    [/ferias/, { g: 'O pagamento das suas férias.', d: 'Desconto ligado às suas férias (por exemplo, o valor das férias já pago antes).' }],
    [/comiss/, 'Valor ganho pelas suas vendas ou resultados.'],
    [/tempo de servico|anuenio|quinquenio/, 'Valor a mais pelo tempo que você trabalha na empresa.'],
    [/vale.?transporte|\bv\.?t\.?\b/, { g: 'Valor do vale-transporte.', d: 'A sua parte no vale-transporte. A lei permite descontar até 6% do salário.' }],
    [/refeic|aliment|ticket|\bv\.?r\.?\b|\bv\.?a\.?\b/, { g: 'Valor do vale-refeição ou vale-alimentação.', d: 'A sua parte no vale-refeição ou vale-alimentação.' }],
    [/odonto/, { g: 'Valor ligado ao plano odontológico.', d: 'A sua parte no plano odontológico (o seu e o dos seus dependentes, se tiver).' }],
    [/plano medico|unimed|saude|amil|hapvida|sulamerica/, { g: 'Valor ligado ao plano de saúde.', d: 'A sua parte no plano de saúde (o seu e o dos seus dependentes, se tiver).' }],
    [/pensao/, { d: 'Pensão alimentícia: valor que a Justiça mandou descontar e repassar a quem tem direito.' }],
    [/adiant/, { g: 'Parte do salário paga antes do fim do mês.', d: 'Valor que você já recebeu antes (adiantamento), agora descontado.' }],
    [/falta|atraso/, { d: 'Desconto por faltas ou atrasos sem justificativa.' }],
    [/sindic/, { d: 'Contribuição para o sindicato da sua categoria.' }],
    [/prev(idencia)?\.? ?priv/, { g: 'Valor ligado à sua previdência privada.', d: 'A sua contribuição para a previdência privada (aposentadoria complementar).' }],
    [/emprestimo|consignado/, { d: 'Parcela de um empréstimo, descontada do salário.' }]
  ];

  /* ═══ [F4] FERRAMENTAS (DINHEIRO, NOMES, MESES) ═════════════════════════════════════════ */
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function sem(t) { return String(t || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  function num(v) { if (typeof v === 'number') return v; var n = parseFloat(String(v == null ? '' : v).replace(/[^\d,.-]/g, '').replace(/\.(?=\d{3}(\D|$))/g, '').replace(',', '.')); return isFinite(n) ? n : 0; }
  function real(v) { return 'R$ ' + Math.abs(v).toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 }); }
  function falado(v) {
    var c = Math.round(Math.abs(v) * 100), r = Math.floor(c / 100), ct = c % 100;
    return (r ? r + (r === 1 ? ' real' : ' reais') : '') + (r && ct ? ' e ' : '') + (ct ? ct + (ct === 1 ? ' centavo' : ' centavos') : '') || 'zero reais';
  }
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  /* "Junho/2026" → "junho de 2026" */
  function mesExtenso(txt) { var m = String(txt || '').match(/([A-Za-zÀ-ú]+)\s*\/\s*(\d{4})/); return m ? m[1].toLowerCase().replace('marco', 'março') + ' de ' + m[2] : String(txt || ''); }
  function maiuscula(t) { return t.charAt(0).toUpperCase() + t.slice(1); }
  /* "01/09/2026" → "setembro de 2026" */
  function mesDeData(d) { var m = String(d || '').match(/\d{2}\/(\d{2})\/(\d{4})/); return m ? MESES[+m[1] - 1] + ' de ' + m[2] : ''; }
  function soma(l) { return l.reduce(function (s, i) { return s + i.v; }, 0); }
  /* "01/06/2026" → "1º de junho de 2026" (o dia 1 com o º, como se fala) */
  function dataExtenso(d) { var m = String(d || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); if (!m) return ''; var dia = +m[1]; return (dia === 1 ? '1º' : dia) + ' de ' + MESES[+m[2] - 1] + ' de ' + m[3]; }
  /* os nomes do cadastro: sem acento e abreviados ("Desc.Adiant.Quinzenal", "Inss C/Aliquota") */
  var ACENTOS = { ferias: 'férias', salario: 'salário', salarial: 'salarial', refeicao: 'refeição', servico: 'serviço', medico: 'médico',
    pensao: 'pensão', alimenticia: 'alimentícia', alimentacao: 'alimentação', minimo: 'mínimo', calculo: 'cálculo', diferenca: 'diferença',
    comissao: 'comissão', media: 'média', uteis: 'úteis', mes: 'mês', contribuicao: 'contribuição', previdencia: 'previdência',
    aliquota: 'alíquota', reducao: 'redução', indevido: 'indevido', judicial: 'judicial', odontologico: 'odontológico', adicional: 'adicional',
    periculosidade: 'periculosidade', insalubridade: 'insalubridade', liquido: 'líquido', decimo: 'décimo', emprestimo: 'empréstimo',
    familia: 'família', saude: 'saúde', credito: 'crédito', debito: 'débito', antecipacao: 'antecipação', gratificacao: 'gratificação',
    rescisao: 'rescisão', indenizacao: 'indenização', funcao: 'função', premio: 'prêmio', horario: 'horário', noturno: 'noturno', cartao: 'cartão', ate: 'até', remuneracao: 'remuneração', educacao: 'educação' };
  var SIGLAS = { inss: 'INSS', fgts: 'FGTS', irrf: 'IRRF', dsr: 'DSR', bh: 'BH', vt: 'VT', vr: 'VR', va: 'VA', pis: 'PIS', ir: 'IR', he: 'HE', pp: 'PP', 'i.n.s.s.': 'INSS' };
  function nome(t) {
    return maiuscula(String(t || '').trim()).replace(/[A-Za-zÀ-ú.]+/g, function (w) {
      var k = w.toLowerCase();
      if (SIGLAS[k]) return SIGLAS[k];
      var base = k.replace(/\.$/, '');
      if (SIGLAS[base]) return SIGLAS[base] + (w.slice(-1) === '.' ? '' : '');
      if (ACENTOS[base]) { var a = ACENTOS[base]; return (w.charAt(0) === w.charAt(0).toUpperCase() ? maiuscula(a) : a) + (w.slice(-1) === '.' ? '.' : ''); }
      return w;
    });
  }
  function explicacao(desc, tipo) {
    var s = sem(desc);
    for (var i = 0; i < EXPLICA.length; i++) {
      if (!EXPLICA[i][0].test(s)) continue;
      var e = EXPLICA[i][1];
      if (typeof e === 'string') return e;
      return (tipo === 2 ? e.d : e.g) || '';
    }
    return '';
  }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-fo-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  var IC = {
    mais: '<path d="M12 6v12M6 12h12"/>',
    menos: '<path d="M6 12h12"/>',
    igual: '<path d="M6 9.5h12M6 14.5h12"/>',
    esq: '<path d="M14.5 6l-6 6 6 6"/>',
    dir: '<path d="M9.5 6l6 6-6 6"/>',
    seta: '<path d="M7 10l5 5 5-5"/>',
    voz: '<path d="M4 9.5v5h3.5L12 18.5v-13L7.5 9.5z"/><path d="M15.5 9a4 4 0 0 1 0 6M18 6.5a7.5 7.5 0 0 1 0 11"/>',
    pausa: '<path d="M8.5 6v12M15.5 6v12"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M3.5 14.5h17M9 10v9"/>',
    info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5M12 8v.1"/>',
    cadeado: '<rect x="5.5" y="10.5" width="13" height="9" rx="2"/><path d="M8.5 10.5V8a3.5 3.5 0 0 1 7 0v2.5"/>'
  };

  /* ═══ [F5] O MÊS NO ALTO ═════════════════════════════════════════════════════════════════
     O QUE FAZ  Setas para o mês anterior/seguinte e uma lista nativa (no celular abre o
                seletor do próprio aparelho). As duas só ESCOLHEM uma opção na lista original
                (apex.item(...).setValue): a ação "Valida Dt Ref" da página roda como sempre.
                A lista vem em ordem do mais novo para o mais velho.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var RAIZ = null, MESBAR = null, CORPO = null, IR = null, TABELA = false;
  function opcoes() { return [].filter.call(SEL.options, function (o) { return o.value || OCORR; }).map(function (o) { return { v: o.value, t: o.value ? o.text.trim() : T.todosMeses }; }); }
  /* Folha: escolhe na lista original e a ação "Valida Dt Ref" roda como sempre.
     Ocorrências: o vazio também é escolha ("Todos os meses"), e a troca é SEM recarregar a página —
     a lista da 104 recarrega a página inteira no onchange; aqui o valor vai para a lista, o
     relatório escondido se atualiza (ele já envia o …_DATA_REF) e os lançamentos são buscados. */
  function escolher(v) {
    if (v === SEL.value || (!v && !OCORR)) return;
    if (!OCORR) { apex.item(SEL.id).setValue(v); return; }
    SEL.value = v;
    var irr = document.querySelector('.a-IRR');
    var reg = irr && (irr.closest('.t-IRR-region') || irr.closest('.t-Region'));
    if (reg) $(reg).trigger('apexrefresh');
    buscar();
  }
  function desenharMes() {
    var ops = opcoes(), i = -1;
    ops.forEach(function (o, k) { if (o.v === SEL.value) i = k; });
    var atual = i >= 0 ? maiuscula(mesExtenso(ops[i].t)) : '';
    var ant = ops[i + 1], prox = i > 0 ? ops[i - 1] : null;
    MESBAR.innerHTML =
      '<button type="button" class="nc-fo-mes-seta" data-v="' + esc(ant ? ant.v : '') + '"' + (ant ? ' aria-label="' + esc(T.mesAnt + ': ' + mesExtenso(ant.t)) + '"' : ' disabled aria-label="' + T.mesAnt + '"') + '>' + svg(IC.esq) + '</button>' +
      '<label class="nc-fo-mes-atual"><span class="nc-fo-mes-nome">' + esc(atual || T.escolher) + '</span>' +
      (ops.length > 1 ? '<span class="nc-fo-mes-dica">' + svg(IC.seta) + '</span>' : '') +
      '<select class="nc-fo-mes-sel" aria-label="' + T.escolher + '">' + ops.map(function (o) { return '<option value="' + esc(o.v) + '"' + (o.v === SEL.value ? ' selected' : '') + '>' + esc(maiuscula(mesExtenso(o.t))) + '</option>'; }).join('') + '</select></label>' +
      '<button type="button" class="nc-fo-mes-seta" data-v="' + esc(prox ? prox.v : '') + '"' + (prox ? ' aria-label="' + esc(T.mesProx + ': ' + mesExtenso(prox.t)) + '"' : ' disabled aria-label="' + T.mesProx + '"') + '>' + svg(IC.dir) + '</button>';
  }

  /* ═══ [F6] BUSCAR OS DADOS (NC_FOLHA_DADOS) ══════════════════════════════════════════════
     O QUE FAZ  Pede ao processo NC_FOLHA_DADOS as verbas do mês escolhido (manda a lista do
                mês junto). Resposta: { bloqueado, msg }, { erro } ou { itens: [ { codigo, descricao,
                tipo (1 ganho, 2 desconto, 3 base), total ('g' | 'd' | 'l' nas linhas de total),
                qtde, dias, valor, faixa, inicio, fim } ] }. O tipo e o total vêm da FAIXA do
                código, decidida no servidor por P74_QUATRO_DIGITOS (N: 1-499 / 500-899 / 900+,
                totais 997-999; S: 1-4999 / 5000-8999 / 9000+, totais 9997-9999).
     CUIDADO    O nome do processo (PROCESSO, em [F1]) tem de ser igual ao do APEX. Sem o
                processo, o desenho se desliga e o relatório de sempre volta à vista.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PEDIDO = 0, ULTIMO = null;
  function buscar() {
    var ref = SEL.value, n = ++PEDIDO;
    desenharMes();
    if (!ref && !OCORR) { estado('vazio'); return; }
    estado('carregando');
    apex.server.process(PROCESSO, { pageItems: '#' + SEL.id }, { dataType: 'json' })
      .done(function (d) {
        if (n !== PEDIDO) return;
        /* o processo pegou um erro do banco e o devolveu em { erro } (a tela não quebra) */
        if (d && d.erro) { if (window.console) console.warn('[Natcorp_Folha] NC_FOLHA_DADOS:', d.erro); estado('erro'); return; }
        ULTIMO = d; desenhar(d);
      })
      .fail(function (x) {
        if (n !== PEDIDO) return;
        /* processo inexistente (página não importada): o APEX responde VAZIO ou "não encontrado" —
           o desenho sai e fica o relatório de sempre */
        var txt = String((x && x.responseText) || '');
        if (x && (!txt.trim() || /NC_[A-Z_]+_DADOS|not found|n[ãa]o encontrad/i.test(txt))) { desligar(); return; }
        estado('erro');
      });
  }

  /* ═══ [F7] DESENHAR: RECIBO, LISTAS, BASES ═══════════════════════════════════════════════ */
  function estado(qual, msg) {
    var h = '';
    if (qual === 'carregando') h = '<div class="nc-fo-estado nc-fo-estado--carregando" role="status"><span class="nc-fo-giro" aria-hidden="true"></span>' + T.carregando + '</div>';
    else if (qual === 'vazio') h = '<div class="nc-fo-estado">' + svg(IC.info, 'nc-fo-estado-ic') + '<p>' + T.semMes + '</p></div>';
    else if (qual === 'bloqueado') h = '<div class="nc-fo-estado nc-fo-estado--aviso">' + svg(IC.cadeado, 'nc-fo-estado-ic') + '<div><p class="nc-fo-estado-tit">' + T.bloqueadoTit + '</p>' + (msg ? '<p>' + esc(msg) + '</p>' : '') + '</div></div>';
    else if (qual === 'erro') h = '<div class="nc-fo-estado nc-fo-estado--aviso">' + svg(IC.info, 'nc-fo-estado-ic') + '<div><p class="nc-fo-estado-tit">' + T.erro + '</p><p>' + T.erroDica + '</p></div></div>';
    CORPO.innerHTML = h;
    document.body.classList.toggle('nc-fo-bloqueado', qual === 'bloqueado');
  }
  function referencia(it) {
    var q = num(it.qtde), d = num(it.dias), r = [];
    if (q) r.push(q.toLocaleString('pt-BR'));
    if (d) r.push(d.toLocaleString('pt-BR'));
    return r.join(' / ');
  }
  function linha(it, tipo) {
    var ex = tipo === 3 ? '' : explicacao(it.descricao, tipo);
    var ref = referencia(it);
    var meta = (ref ? '<span class="nc-fo-item-ref">' + T.ref + ' ' + ref + '</span> · ' : '') + '<span class="nc-fo-item-cod">' + T.cod + ' ' + esc(String(it.codigo || '').replace(/\s+/g, '')) + '</span>';
    var miolo = '<span class="nc-fo-item-txt"><span class="nc-fo-item-nome">' + esc(nome(it.descricao)) + '</span><span class="nc-fo-item-meta">' + meta + '</span></span>' +
      '<span class="nc-fo-item-valor">' + (tipo === 2 ? '− ' : '') + real(num(it.valor)) + '</span>';
    if (!ex) return '<li class="nc-fo-item"><div class="nc-fo-item-linha">' + miolo + '</div></li>';
    return '<li class="nc-fo-item nc-fo-item--explica"><button type="button" class="nc-fo-item-linha" aria-expanded="false">' + miolo +
      '<span class="nc-fo-item-mais">' + svg(IC.seta) + '</span></button>' +
      '<div class="nc-fo-item-explica" hidden><span class="nc-fo-item-explica-tit">' + T.oQueE + '</span>' + esc(ex) + '</div></li>';
  }
  function grupo(cls, titulo, itens, tipo, vazio, total) {
    return '<section class="nc-fo-grupo nc-fo-grupo--' + cls + '" aria-label="' + esc(titulo) + '">' +
      '<header class="nc-fo-grupo-cab"><span class="nc-fo-grupo-sinal" aria-hidden="true">' + svg(tipo === 1 ? IC.mais : IC.menos) + '</span>' +
      '<h3 class="nc-fo-grupo-tit">' + titulo + '<span class="nc-fo-grupo-n">' + T.itens(itens.length) + '</span></h3>' +
      '<span class="nc-fo-grupo-total">' + (tipo === 2 && total ? '− ' : '') + real(total) + '</span></header>' +
      (itens.length ? '<ul class="nc-fo-lista">' + itens.map(function (it) { return linha(it, tipo); }).join('') + '</ul>' : '<p class="nc-fo-grupo-vazio">' + vazio + '</p>') +
      '</section>';
  }
  /* As linhas de TOTAL que a própria folha calcula (997/998/999, ou 9997/9998/9999 com quatro
     dígitos): quando existem, são elas que valem no recibo — a soma das linhas poderia contar o
     que é da empresa (INSS Empresa, por exemplo). E saem das listas. O servidor as marca em
     it.total; o nome ("Total De Proventos"...) só vale de reserva, se a marca não vier. */
  var TOTAIS = { g: /^total (de |dos )?(proventos|vencimentos|creditos)/, d: /^total (de |dos )?(descontos|debitos)/, l: /^(total )?(do )?liquido( a receber)?$|^total liquido/ };
  function desenhar(d) {
    if (OCORR) { desenharOcorr(d); return; }
    if (!d || d.bloqueado) { estado('bloqueado', d && d.msg); return; }
    document.body.classList.remove('nc-fo-bloqueado');
    var itens = (d.itens || []).map(function (it) { it.tipo = +it.tipo; it.v = num(it.valor); return it; });
    if (!itens.length) { estado('vazio'); return; }
    var tot = {}, marcado = d.quatro_digitos != null;   /* o servidor já marcou os totais pela faixa */
    itens = itens.filter(function (it) {
      if (it.total) { tot[it.total] = it.v; return false; }
      if (marcado) return true;
      var s = sem(it.descricao);
      for (var k in TOTAIS) if (TOTAIS[k].test(s)) { tot[k] = it.v; return false; }
      return true;
    });
    var porValor = function (a, b) { return b.v - a.v; };
    var G = itens.filter(function (i) { return i.tipo === 1; }).sort(porValor);
    var D = itens.filter(function (i) { return i.tipo === 2; }).sort(porValor);
    var B = itens.filter(function (i) { return i.tipo !== 1 && i.tipo !== 2; }).sort(porValor);
    var g = tot.g != null ? tot.g : soma(G), ds = tot.d != null ? tot.d : soma(D);
    var liq = tot.l != null ? tot.l : g - ds;
    var mes = mesExtenso((SEL.options[SEL.selectedIndex] || {}).text);
    var ini = itens[0].inicio, fim = itens[0].fim;
    var pctDesc = g > 0 ? Math.min(100, ds / g * 100) : (ds > 0 ? 100 : 0);
    var deCada = g > 0 ? Math.round(ds / g * 100) : 0;

    var recibo = '<article class="nc-fo-recibo" aria-label="' + esc(T.titulo(mes)) + '">' +
      '<header class="nc-fo-recibo-cab"><div><h2 class="nc-fo-recibo-tit">' + esc(T.titulo(mes)) + '</h2>' +
      (ini && fim ? '<p class="nc-fo-recibo-periodo">' + esc(T.periodo(dataExtenso(ini), dataExtenso(fim))) + '</p>' : '') + '</div>' +
      ('speechSynthesis' in window ? '<button type="button" class="nc-fo-ouvir" aria-pressed="false">' + svg(IC.voz) + '<span>' + T.ouvir + '</span></button>' : '') + '</header>' +
      '<dl class="nc-fo-conta">' +
      '<div class="nc-fo-conta-linha nc-fo-conta-linha--ganho"><dt><span class="nc-fo-conta-sinal" aria-hidden="true">' + svg(IC.mais) + '</span>' + T.ganhou + '</dt><dd>' + real(g) + '</dd></div>' +
      '<div class="nc-fo-conta-linha nc-fo-conta-linha--desc"><dt><span class="nc-fo-conta-sinal" aria-hidden="true">' + svg(IC.menos) + '</span>' + T.descontado + '</dt><dd>' + (ds ? '− ' : '') + real(ds) + '</dd></div>' +
      '<div class="nc-fo-conta-linha nc-fo-conta-linha--liq' + (liq < 0 ? ' is-negativo' : '') + '"><dt><span class="nc-fo-conta-sinal" aria-hidden="true">' + svg(IC.igual) + '</span>' + (liq < 0 ? T.recebeNegativo : T.recebe) + '</dt><dd>' + real(liq) + '</dd></div>' +
      '</dl>' +
      '<div class="nc-fo-barra" role="img" aria-label="' + esc(T.fica + ' ' + Math.max(0, 100 - Math.round(pctDesc)) + '%, ' + T.descontos + ' ' + Math.round(pctDesc) + '%') + '">' +
      '<span class="nc-fo-barra-fica" style="width:' + (100 - pctDesc).toFixed(2) + '%"></span><span class="nc-fo-barra-desc" style="width:' + pctDesc.toFixed(2) + '%"></span></div>' +
      '<div class="nc-fo-barra-leg"><span class="nc-fo-barra-leg-fica">' + T.fica + ' <b>' + Math.max(0, 100 - Math.round(pctDesc)) + '%</b></span><span class="nc-fo-barra-leg-desc">' + T.descontos + ' <b>' + Math.round(pctDesc) + '%</b></span></div>' +
      '<p class="nc-fo-recibo-frase">' + (liq < 0 ? T.passou : T.deCada(String(deCada))) + '</p>' +
      '</article>';

    var listas = '<div class="nc-fo-grupos">' +
      grupo('ganho', T.gGanho, G, 1, T.nenhumGanho, g) +
      grupo('desc', T.gDesc, D, 2, T.nenhumDesc, ds) + '</div>';
    CORPO.innerHTML = recibo + listas + basesHTML(B);
    RESUMO = { mes: mes, g: g, ds: ds, liq: liq, maiorG: G[0], maiorD: D[0] };
  }
  function basesHTML(B, aberto) {
    return B.length ? '<details class="nc-fo-bases"' + (aberto ? ' open' : '') + '><summary><span class="nc-fo-bases-tit">' + T.gBase + '</span><span class="nc-fo-grupo-n">' + T.itens(B.length) + '</span>' + svg(IC.seta, 'nc-fo-ic nc-fo-bases-seta') + '</summary>' +
      '<p class="nc-fo-bases-dica">' + T.gBaseDica + '</p><ul class="nc-fo-lista">' + B.map(function (it) { return linha(it, 3); }).join('') + '</ul></details>' : '';
  }

  /* ═══ [F7b] MODO OCORRÊNCIAS: OS LANÇAMENTOS (300:104) ═══════════════════════════════════
     O QUE FAZ  Mês escolhido: um resumo (Ganhos lançados, Descontos lançados — sem "Você
                recebe": ocorrência não é o pagamento) e as mesmas listas da Folha. "Todos os
                meses": uma faixa por mês com os totais; a mais nova aberta, as outras montadas
                só quando abrem (são dezenas de meses).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var OCMESES = [];
  function separar(itens) {
    var porValor = function (a, b) { return b.v - a.v; };
    var G = itens.filter(function (i) { return i.tipo === 1; }).sort(porValor);
    var D = itens.filter(function (i) { return i.tipo === 2; }).sort(porValor);
    var B = itens.filter(function (i) { return i.tipo !== 1 && i.tipo !== 2; }).sort(porValor);
    return { G: G, D: D, B: B, g: soma(G), ds: soma(D) };
  }
  function listasOcorr(x) {
    if (!x.G.length && !x.D.length) return basesHTML(x.B, true);
    return '<div class="nc-fo-grupos">' + grupo('ganho', T.gGanho, x.G, 1, T.nenhumGanho, x.g) + grupo('desc', T.gDesc, x.D, 2, T.nenhumDesc, x.ds) + '</div>' + basesHTML(x.B);
  }
  /* o atalho para a Folha do Mês: o link do próprio menu (com a sessão e a soma de conferência) */
  function linkFolha() {
    var a = [].filter.call(document.querySelectorAll('a[href]'), function (x) { return /folha de pagamento do m[eê]s/i.test(x.textContent) && !/^javascript:/i.test(x.getAttribute('href')); })[0];
    return a ? '<a class="nc-fo-ocorr-link" href="' + esc(a.getAttribute('href')) + '">' + T.verFolha + svg(IC.dir) + '</a>' : '';
  }
  function contaOcorr(x) {
    return '<dl class="nc-fo-conta">' +
      '<div class="nc-fo-conta-linha nc-fo-conta-linha--ganho"><dt><span class="nc-fo-conta-sinal" aria-hidden="true">' + svg(IC.mais) + '</span>' + T.ganhou + '</dt><dd>' + real(x.g) + '</dd></div>' +
      '<div class="nc-fo-conta-linha nc-fo-conta-linha--desc"><dt><span class="nc-fo-conta-sinal" aria-hidden="true">' + svg(IC.menos) + '</span>' + T.descontado + '</dt><dd>' + (x.ds ? '− ' : '') + real(x.ds) + '</dd></div></dl>';
  }
  function desenharOcorr(d) {
    document.body.classList.remove('nc-fo-bloqueado');
    var itens = ((d && d.itens) || []).map(function (it) { it.tipo = +it.tipo; it.v = num(it.valor); return it; });
    if (!itens.length) { estado('vazio'); RESUMO = null; return; }
    var link = linkFolha();
    if (SEL.value) {
      var x = separar(itens), mes = mesExtenso((SEL.options[SEL.selectedIndex] || {}).text) || mesDeData(itens[0].ref);
      var so = !x.G.length && !x.D.length;
      CORPO.innerHTML = '<article class="nc-fo-recibo nc-fo-recibo--ocorr" aria-label="' + esc(T.titulo(mes)) + '">' +
        '<header class="nc-fo-recibo-cab"><div><h2 class="nc-fo-recibo-tit">' + esc(T.titulo(mes)) + '</h2>' +
        '<p class="nc-fo-recibo-periodo">' + esc(T.itens(itens.length)) + '</p></div>' +
        (!so && 'speechSynthesis' in window ? '<button type="button" class="nc-fo-ouvir" aria-pressed="false">' + svg(IC.voz) + '<span>' + T.ouvir + '</span></button>' : '') + '</header>' +
        (so ? '' : contaOcorr(x)) +
        '<p class="nc-fo-ocorr-dica">' + (so ? T.soBases : T.dica) + (link ? ' ' + link : '') + '</p></article>' +
        listasOcorr(x);
      RESUMO = so ? null : { ocorr: true, mes: mes, g: x.g, ds: x.ds, maiorG: x.G[0], maiorD: x.D[0] };
      return;
    }
    /* Todos os meses: na ordem do servidor (o mais novo primeiro) */
    var porMes = {}, ordem = [];
    itens.forEach(function (it) { var k = it.ref || ''; if (!porMes[k]) { porMes[k] = []; ordem.push(k); } porMes[k].push(it); });
    OCMESES = ordem.map(function (k) { return { ref: k, x: separar(porMes[k]), n: porMes[k].length }; });
    CORPO.innerHTML = '<article class="nc-fo-recibo nc-fo-recibo--ocorr" aria-label="' + esc(T.todosTit) + '">' +
      '<header class="nc-fo-recibo-cab"><div><h2 class="nc-fo-recibo-tit">' + T.todosTit + '</h2>' +
      '<p class="nc-fo-recibo-periodo">' + esc(T.todosSub(OCMESES.length, itens.length)) + '</p></div></header>' +
      '<p class="nc-fo-ocorr-dica">' + T.dica + (link ? ' ' + link : '') + '</p></article>' +
      '<div class="nc-fo-meses">' + OCMESES.map(function (m, k) {
        var x = m.x, so = !x.G.length && !x.D.length;
        return '<details class="nc-fo-mesbloco" data-k="' + k + '"' + (k === 0 ? ' open' : '') + '><summary>' +
          '<span class="nc-fo-mesbloco-tit"><span class="nc-fo-mesbloco-nome">' + esc(maiuscula(mesDeData(m.ref) || m.ref)) + '</span>' +
          '<span class="nc-fo-grupo-n">' + esc(T.itens(m.n)) + '</span></span>' +
          '<span class="nc-fo-mesbloco-nums">' +
          (x.g ? '<span class="nc-fo-mini nc-fo-mini--g"><span class="nc-fo-sr">' + T.gGanho + ': </span>+ ' + real(x.g) + '</span>' : '') +
          (x.ds ? '<span class="nc-fo-mini nc-fo-mini--d"><span class="nc-fo-sr">' + T.gDesc + ': </span>− ' + real(x.ds) + '</span>' : '') +
          (so ? '<span class="nc-fo-mini nc-fo-mini--b">' + T.soBasesCurto + '</span>' : '') + '</span>' +
          svg(IC.seta, 'nc-fo-ic nc-fo-mesbloco-seta') + '</summary>' +
          '<div class="nc-fo-mesbloco-corpo">' + (k === 0 ? listasOcorr(x) : '') + '</div></details>';
      }).join('') + '</div>';
    RESUMO = null;
  }

  /* ═══ [F8] OUVIR ═════════════════════════════════════════════════════════════════════════
     O QUE FAZ  O celular lê o resumo em voz alta: o mês, quanto ganhou, quanto foi
                descontado e quanto recebe. Os valores vão por extenso ("20779 reais e 13
                centavos"), que a voz lê sem tropeçar no "R$".
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var RESUMO = null, FALANDO = false;
  function pararVoz() { try { window.speechSynthesis && speechSynthesis.cancel(); } catch (e) { /* sem voz */ } FALANDO = false; marcarOuvir(); }
  function marcarOuvir() {
    var b = RAIZ && RAIZ.querySelector('.nc-fo-ouvir');
    if (!b) return;
    b.setAttribute('aria-pressed', String(FALANDO));
    b.innerHTML = svg(FALANDO ? IC.pausa : IC.voz) + '<span>' + (FALANDO ? T.parar : T.ouvir) + '</span>';
  }
  function ouvir() {
    if (FALANDO) { pararVoz(); return; }
    var r = RESUMO; if (!r || !window.speechSynthesis) return;
    var txt = r.ocorr ? 'Lançamentos de ' + r.mes + '. ' + 'Ganhos lançados: ' + falado(r.g) + '. ' + 'Descontos lançados: ' + falado(r.ds) + '.' +
      (r.maiorD ? ' O maior desconto é ' + nome(r.maiorD.descricao) + ': ' + falado(r.maiorD.v) + '.' : '') : 'Seu pagamento de ' + r.mes + '. ' +
      'Você ganhou ' + falado(r.g) + '. ' +
      'Foram descontados ' + falado(r.ds) + '. ' +
      (r.liq < 0 ? 'Ficou faltando ' + falado(r.liq) + '.' : 'Você recebe ' + falado(r.liq) + '.') +
      (r.maiorD ? ' O maior desconto foi ' + nome(r.maiorD.descricao) + ': ' + falado(r.maiorD.v) + '.' : '');
    var u = new SpeechSynthesisUtterance(txt);
    u.lang = 'pt-BR'; u.rate = .95;
    var v = (speechSynthesis.getVoices() || []).filter(function (x) { return /^pt(-|_)BR/i.test(x.lang); })[0];
    if (v) u.voice = v;
    u.onend = u.onerror = function () { FALANDO = false; marcarOuvir(); };
    speechSynthesis.cancel();
    speechSynthesis.speak(u);
    FALANDO = true; marcarOuvir();
  }

  /* ═══ [F9] O MAESTRO ═════════════════════════════════════════════════════════════════════
     O QUE FAZ  Monta o lugar do desenho logo acima do relatório (que sai da vista), liga os
                cliques e busca o mês. A cada troca na lista original (setas, lista nova ou a
                própria página), busca de novo.
                desligar(): sem o processo, tira o desenho e devolve o relatório à vista.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function desligar() {
    pararVoz();
    if (RAIZ) RAIZ.remove();
    RAIZ = null;
    document.body.classList.remove('nc-fo', 'nc-fo-tabela', 'nc-fo-bloqueado');
    if (IR) IR.classList.remove('nc-fo-ir');
  }
  function montar() {
    var irr = document.querySelector('.a-IRR');
    IR = irr && irr.closest('.t-Region, .t-IRR-region');
    while (IR && IR.parentElement && IR.parentElement.closest('.t-Region')) IR = IR.parentElement.closest('.t-Region');
    if (!IR) return false;
    IR.classList.add('nc-fo-ir');
    /* o aviso fixo da página ("o relatório não está disponível"): o desenho mostra o motivo */
    [].forEach.call(document.querySelectorAll('.t-Alert'), function (a) { if (/n[ãa]o est[áa] dispon[íi]vel/i.test(a.textContent)) a.classList.add('nc-fo-aviso'); });
    RAIZ = el('section', 'nc-fo-raiz'); RAIZ.id = 'nc-fo';
    RAIZ.innerHTML = '<nav class="nc-fo-mes" aria-label="' + T.escolher + '"></nav><div class="nc-fo-corpo" aria-live="polite"></div>' +
      '<div class="nc-fo-pe"><button type="button" class="nc-fo-tabela-bt" aria-expanded="false">' + svg(IC.tabela) + '<span>' + T.verTabela + '</span></button></div>';
    var linhaIR = IR.closest('.row') || IR;
    linhaIR.parentNode.insertBefore(RAIZ, linhaIR);
    MESBAR = RAIZ.querySelector('.nc-fo-mes');
    CORPO = RAIZ.querySelector('.nc-fo-corpo');
    document.body.classList.add('nc-fo');

    $(RAIZ).on('click', '.nc-fo-mes-seta', function () { escolher(this.getAttribute('data-v')); });
    $(RAIZ).on('change', '.nc-fo-mes-sel', function () { escolher(this.value); });
    $(RAIZ).on('click', '.nc-fo-item--explica > .nc-fo-item-linha', function () {
      var aberto = this.getAttribute('aria-expanded') === 'true';
      this.setAttribute('aria-expanded', String(!aberto));
      this.parentNode.classList.toggle('is-aberto', !aberto);
      this.nextElementSibling.hidden = aberto;
    });
    $(RAIZ).on('click', '.nc-fo-ouvir', ouvir);
    /* "Todos os meses": a faixa monta as listas só quando abre (toggle não sobe: escuta na descida) */
    RAIZ.addEventListener('toggle', function (e) {
      var dt = e.target;
      if (!dt.open || !dt.classList || !dt.classList.contains('nc-fo-mesbloco')) return;
      var c = dt.querySelector('.nc-fo-mesbloco-corpo'), m = OCMESES[+dt.getAttribute('data-k')];
      if (c && m && !c.firstChild) c.innerHTML = listasOcorr(m.x);
    }, true);
    $(RAIZ).on('click', '.nc-fo-tabela-bt', function () {
      TABELA = !TABELA;
      document.body.classList.toggle('nc-fo-tabela', TABELA);
      this.setAttribute('aria-expanded', String(TABELA));
      this.querySelector('span').textContent = TABELA ? T.esconderTabela : T.verTabela;
      /* o relatório estava fora da vista: o APEX recalcula as colunas ao aparecer */
      if (TABELA) { try { apex.widget.util.visibilityChange(IR, true); } catch (e) { /* versão antiga */ } $(window).trigger('apexwindowresized'); }
    });
    $(SEL).on('change', buscar);
    window.addEventListener('pagehide', pararVoz);
    return true;
  }
  /* o modo vem da página (JavaScript › Function and Global Variable Declaration), que roda
     depois deste arquivo — por isso é lido aqui, com a página pronta */
  function configurar() {
    var c = window.ncFolha || {};
    OCORR = c.modo === 'ocorrencias';
    if (c.processo) PROCESSO = String(c.processo);
    if (OCORR) { for (var k in T_OCORR) T[k] = T_OCORR[k]; document.documentElement.classList.add('nc-fo-modo-ocorr'); }
  }
  function iniciar() { configurar(); if (montar()) buscar(); }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
