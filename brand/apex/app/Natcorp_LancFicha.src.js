/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · LANÇAMENTOS (A FICHA)  —  onde o gestor lança horas, faltas e valores (JS)    ║
   ║  App 9132 · Página 7 · Lançamentos de Ocorrências (janela aberta pela 9132:5)            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: LANCFICHA-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quem usa é o GESTOR da área (não é do RH, muitas vezes tem pouca instrução). A grade de 17
   colunas ("DT. INÍCIO VALIDADE", "Nº PARCELA ORIG.", "FAIXA"…) vira:
     • NO ALTO: em que folha, empresa e mês se está lançando, e os 3 passos (Preencha → Salve →
       Processe), que acendem conforme o que já foi feito;
     • À ESQUERDA: os lançamentos em cartões — o evento, quanto, para quem, o mês e se já foi
       salvo — e o botão "Novo lançamento";
     • À DIREITA: a FICHA do lançamento em perguntas: Para quem? · O que vai lançar? · Quanto? ·
       Em qual folha entra? (+ "Vale por mais de um mês?", "Dias da falta" e a observação,
       recolhidos). Escolhido o evento, os campos de "Quanto?" dizem se o evento usa horas,
       minutos ou valor (os indicadores que a própria página busca).
     • "Tabela": a grade original, para quem prefere digitar em linhas.
     • O pé da janela explica o que falta para processar; "Cancelar" confirma antes de apagar.
     • Processando: um aviso de espera; com erros, o resultado (LOG) em linhas legíveis.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada por conta própria. A ficha é a "vista de um registro" (Single Row View) da
     PRÓPRIA grade: as listas, as ações dinâmicas das colunas (dígito, indicadores, datas de
     validade, parcelas, horas/minutos), as 13 validações e o salvar são os da página. Processar
     continua sendo o botão e as ações da página. Tirou as URLs: a página volta a ser a de sempre.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 7 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_LancFicha.js
     Página 7 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_LancFicha.css
     (o aplicar-lancficha-pagina7.py já põe as duas na exportação)

   ── O "COMBINADO" COM O APEX ──────────────────────────────────────────────────────────────
     A grade é a região de ID estático IGOCORR; os campos da ficha, pelo NOME da coluna (FICHA,
     [L1]); o pé, pelos botões Cancelar/Processar da região "Buttons"; o andamento, pelos itens
     P7_EXISTE, P7_EXEC_PROCESSO e P7_LOG_PROCESSO.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [L1]  A ficha: perguntas, campos, nomes e dicas                          PODE MEXER
     [L2]  Ferramentas
     [L3]  Como a página é reconhecida                                       CUIDADO
     [L4]  Ler a grade
     [L5]  O alto: onde se está lançando e os 3 passos                       PODE MEXER
     [L6]  A lista de lançamentos
     [L7]  A ficha (a vista de um registro da grade)                         CUIDADO
     [L8]  "Quanto?" e "Para quem?": o que o evento pede
     [L9]  Salvar, novo, descartar, excluir                                  CUIDADO
     [L10] O pé da janela: Processar e Cancelar                              CUIDADO
     [L11] Processando e o resultado (LOG)
     [L12] Tabela (a grade original)
     [L13] O maestro

   ── LEGENDA ───────────────────────────────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, cores.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
*/
(function () {
  'use strict';
  if (window.__ncLancFicha || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [L1] A FICHA: PERGUNTAS, CAMPOS, NOMES E DICAS ════════════════════════════════════
     Cada linha: [coluna da grade, nome na ficha, 'meia' (meia linha) ou null, dica embaixo].
     { sec } abre uma pergunta: ic = ícone, tit = a pergunta, dica = a explicação embaixo,
     recolhe = começa fechada (abre sozinha se tiver erro dentro).
     Coluna fora da lista não aparece na ficha (a página preenche sozinha: dígito, unidades,
     indicadores). Coluna que a página não mostra (ex.: Família fora de Pagamentos diversos)
     simplesmente não entra.
     PODE MEXER os nomes, a ordem, as perguntas, as dicas; a coluna tem de ser a da grade. */
  var FICHA = [
    { sec: 'quem', ic: 'pessoas', tit: 'Para quem é o lançamento?' },
    ['COD_EMPRESA', 'Empresa'],
    ['MATRICULA', 'Colaboradores', null, 'Toque no botão da lista para escolher. Pode escolher mais de um.'],
    { sec: 'oque', ic: 'etiqueta', tit: 'O que você vai lançar?' },
    ['COD_OCORR', 'Evento da folha', null, 'Procure pelo nome. Ex.: hora extra, falta, adicional noturno.'],
    ['COD_FAMILIA', 'Família do benefício', null, 'Só em Pagamentos diversos.'],
    { sec: 'quanto', ic: 'balanca', tit: 'Quanto?' },
    ['HORA_QTD', 'Horas ou quantidade', 'meia', 'Ex.: 10 horas → 10. Três dias → 3.'],
    ['MIN_DIA', 'Minutos', 'meia', 'De 0 a 59. Ex.: 10 h 30 min → 30. Sem minutos → 0.'],
    ['VALOR', 'Valor em reais', 'meia', 'Só números. Ex.: 150,00'],
    ['FAIXA', 'Faixa', 'meia', 'Só se o RH pediu uma faixa.'],
    { sec: 'quando', ic: 'calendario', tit: 'Em qual folha entra?' },
    ['DATA_REF', 'Mês da folha', 'meia', 'O mês em que vai aparecer no holerite.'],
    ['DT_RETENCAO', 'Data de retenção', 'meia'],
    { sec: 'repete', ic: 'repete', tit: 'Vale por mais de um mês?', recolhe: true,
      dica: 'As datas se preenchem sozinhas com o mês da folha. Mude só para repetir o lançamento, por exemplo um desconto em 3 parcelas.' },
    ['PARC_NOVA', 'Em quantas parcelas', 'meia', 'Ex.: 3 → este mês e os 2 seguintes.'],
    ['PARC_ORIG', 'Parcelas pelas datas', 'meia', 'Calculado pelas datas abaixo.'],
    ['DT_INIC_VAL', 'Vale a partir de', 'meia'],
    ['DT_FIN_VAL', 'Vale até', 'meia'],
    { sec: 'falta', ic: 'falta', tit: 'Dias da falta', recolhe: true,
      dica: 'Só para faltas que descontam das férias. Nos outros eventos, deixe em branco.' },
    ['DT_INIC_EVENTO', 'Primeiro dia', 'meia'],
    ['DT_FIN_EVENTO', 'Último dia', 'meia'],
    { sec: 'obs', ic: 'nota', tit: 'Quer deixar um recado?' },
    ['OBSERVACAO', 'Observação', null, 'Opcional. Algo que ajude o RH a entender o lançamento.'],
    ['SIT_FECHAMENTO', 'Situação', 'meia']
  ];
  /* o nome de cada processo (P7_PROCESSO), como o gestor fala */
  var PROCESSOS = { 1: 'Folha e rescisão', 2: 'Adiantamento', 3: 'Férias', 4: '13º salário', 5: 'Participação nos lucros (PLR)', 6: 'Pagamentos diversos' };
  /* siglas que ficam em maiúsculas nos nomes dos eventos */
  var SIGLAS = ['DSR', 'INSS', 'FGTS', 'IRRF', 'IR', 'PLR', 'VT', 'VA', 'VR', 'ATS', 'CCT', 'PCD', 'CLT', 'CPF', 'PIS', 'HE', 'AD', 'CIPA', 'SAT', 'RAT', 'PPR', 'EPI'];
  /* os campos de "Quanto?" e o indicador da página que diz se o evento os usa */
  var QUANTO = { HORA_QTD: 'IND_UNID1', MIN_DIA: 'IND_UNID2', VALOR: 'IND_VALOR', FAIXA: 'IND_FAIXA' };

  /* ═══ [L2] FERRAMENTAS ════════════════════════════════════════════════════════════════════ */
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function limpo(t) { t = String(t == null ? '' : t).replace(/<[^>]*>/g, ' ').replace(/\s+/g, ' ').trim(); return t === '-' || t === '.' ? '' : t; }
  function plural(n, um, varios) { return n + ' ' + (n === 1 ? um : varios); }
  function item(n) { try { var v = apex.item(n).getValue(); return Array.isArray(v) ? v.join(':') : String(v == null ? '' : v); } catch (e) { return ''; } }
  /* "HORA EXTRA 50% - DSR" → "Hora extra 50% - DSR" (frase com as siglas em maiúsculas) */
  function frase(t) {
    t = limpo(t); if (!t) return '';
    if (/[a-zà-ú]/.test(t)) return t;
    var s = t.toLowerCase().replace(/^([^a-zà-ú]*)([a-zà-ú])/, function (m, a, b) { return a + b.toUpperCase(); });
    SIGLAS.forEach(function (x) { s = s.replace(new RegExp('(^|[^a-zà-ú0-9])' + x.toLowerCase() + '(?=$|[^a-zà-ú0-9])', 'g'), function (m, a) { return a + x; }); });
    return s;
  }
  /* "0123 4 - HORA EXTRA 50%" → { cod: '0123', nome: 'Hora extra 50%' } */
  function evento(d) {
    d = limpo(d); var m = /^(\d+)(?:\s+\d)?\s+-\s+(.+)$/.exec(d);
    return m ? { cod: m[1], nome: frase(m[2]) } : { cod: '', nome: frase(d) };
  }
  /* "700 - NATCORP DO BRASIL" → "700 - Natcorp do Brasil" */
  function codNome(t) {
    t = limpo(t); var m = /^(\S+)\s*-\s*(.+)$/.exec(t);
    var nome = function (x) { return /[a-zà-ú]/.test(x) ? x : x.toLowerCase().replace(/(^|[\s(/-])([a-zà-ú])/g, function (a, b, c) { return b + c.toUpperCase(); }).replace(/\s(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (x) { return x.toLowerCase(); }); };
    return m ? m[1] + ' - ' + nome(m[2]) : nome(t);
  }
  /* "01/05/2026" ou "MAI/2026" → "Maio de 2026" */
  function mesExtenso(t) {
    var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''), i = -1, a = '';
    if (m) { i = +m[2] - 1; a = m[3]; }
    else { m = /^([A-Za-zÇç]{3})[a-zç]*\s*\/\s*(\d{4})/.exec(limpo(t)); if (m) { i = MESES.map(function (x) { return x.slice(0, 3); }).indexOf(m[1].toLowerCase()); a = m[2]; } }
    return i >= 0 ? MESES[i].replace(/^./, function (c) { return c.toUpperCase(); }) + ' de ' + a : limpo(t);
  }
  function numero(t) { t = String(t == null ? '' : t).replace(/[^\d,.-]/g, ''); if (!t) return NaN; if (t.indexOf(',') > -1) t = t.replace(/\./g, '').replace(',', '.'); return Number(t); }
  function reais(t) { var n = numero(t); return isNaN(n) ? limpo(t) : n.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }); }
  var IC = {
    pessoas: '<circle cx="9" cy="8" r="3.2"/><path d="M3.5 19c.5-3.4 2.7-5.3 5.5-5.3s5 1.9 5.5 5.3"/><circle cx="16.5" cy="9" r="2.6"/><path d="M15.5 13.9c2.6-.3 4.6 1.4 5 4.6"/>',
    pessoa: '<circle cx="12" cy="8" r="3.5"/><path d="M5 20c.6-4 3.4-6 7-6s6.4 2 7 6"/>',
    etiqueta: '<path d="M3.5 12.2V4.5a1 1 0 0 1 1-1h7.7l8.3 8.3a1.4 1.4 0 0 1 0 2l-6.7 6.7a1.4 1.4 0 0 1-2 0z"/><circle cx="8" cy="8" r="1.4"/>',
    balanca: '<path d="M12 4v16M7 20h10M5 7.5h14M5 7.5 2.5 13a2.5 2.5 0 0 0 5 0zM19 7.5 16.5 13a2.5 2.5 0 0 0 5 0z"/>',
    calendario: '<rect x="3.5" y="5" width="17" height="15.5" rx="2.5"/><path d="M3.5 10h17M8 3v4M16 3v4"/>',
    repete: '<path d="M4 12a8 8 0 0 1 13.7-5.6L20 8.5M20 4v4.5h-4.5M20 12a8 8 0 0 1-13.7 5.6L4 15.5M4 20v-4.5h4.5"/>',
    falta: '<rect x="3.5" y="5" width="17" height="15.5" rx="2.5"/><path d="M3.5 10h17M8 3v4M16 3v4M9.5 13.5l5 5M14.5 13.5l-5 5"/>',
    nota: '<path d="M5 4.5h14v11l-4.5 4.5H5z"/><path d="M14.5 20v-4.5H19M8.5 9h7M8.5 12.5h4"/>',
    mais: '<path d="M12 5v14M5 12h14"/>', check: '<path d="M5 12.5l4.5 4.5L19 7.5"/>', fechar: '<path d="M6 6l12 12M18 6L6 18"/>',
    lixo: '<path d="M4.5 7h15M9.5 7V4.5h5V7M6.5 7l1 13h9l1-13M10.5 11v5.5M13.5 11v5.5"/>', voltar: '<path d="M15 6l-6 6 6 6"/>',
    seta: '<path d="M9 6l6 6-6 6"/>', tabela: '<rect x="3" y="4.5" width="18" height="15" rx="2"/><path d="M3 9.5h18M9 9.5v10"/>',
    ficha: '<rect x="4" y="3.5" width="16" height="17" rx="2.5"/><path d="M8 8h8M8 12h8M8 16h5"/>',
    aviso: '<path d="M12 3.5 2.5 20h19z"/><path d="M12 10v4.5M12 17.3v.2"/>', relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    predio: '<path d="M5 20.5V6.5l7-3 7 3v14M3.5 20.5h17M9 9.5h.01M15 9.5h.01M9 13.5h.01M15 13.5h.01M10.5 20.5v-3.5h3v3.5"/>',
    folha: '<path d="M6.5 3.5h8l3.5 3.5v13.5h-11.5z"/><path d="M14.5 3.5V7H18M9 11h6M9 14.5h6M9 18h3.5"/>',
    lapis: '<path d="M14.5 5.5l4 4L9 19H5v-4z"/>'
  };
  function ic(n) { return '<svg class="nc-lf-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }

  var G = null;                 /* a grade: { reg, ig, w, v, m, acoes } */
  var APP = null, FICHA_EL = null, LISTA_EL = null, TOPO_EL = null;
  var ESTADO = { rid: null, modo: 'inicio', ocupado: false, oQue: '', depois: '', espera: 0 };
  var QUEM = {};                /* por lançamento novo: 'todos' | 'escolher' (o que o gestor tocou) */
  var ABERTAS = {};             /* perguntas recolhidas que o gestor abriu */

  function iniciar() {
    if (window.__ncLancFicha) return;
    /* ═══ [L3] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════
       CUIDADO  A grade de ID estático IGOCORR com a coluna COD_OCORR. Sem ela (outra página
                com este arquivo por engano), nada acontece.
       ════════════════════════════════════════════════════════════════════════════════════ */
    var reg = $id('IGOCORR'); if (!reg) return;
    try {
      var w = apex.region('IGOCORR').widget(), v = w.interactiveGrid('getViews', 'grid');
      if (!v || !v.model || !v.modelColumns.COD_OCORR) return;
      G = { reg: reg, ig: w[0], w: w, v: v, m: v.model, acoes: w.interactiveGrid('getActions') };
    } catch (e) { return; }
    window.__ncLancFicha = true;
    reg.classList.add('nc-grade-nao');                 /* a grade padrão (Natcorp_Grade) fica de fora */
    document.body.classList.add('nc-lf-ativo');
    montar();
  }

  /* ═══ [L4] LER A GRADE ═════════════════════════════════════════════════════════════════ */
  function val(rec, col) {
    var x; try { x = G.m.getValue(rec, col); } catch (e) { return { v: '', d: '' }; }
    if (x && typeof x === 'object') return { v: x.v == null ? '' : String(x.v), d: limpo(x.d == null ? x.v : x.d) };
    x = x == null ? '' : String(x); return { v: x, d: limpo(x) };
  }
  function rid(rec) { try { var i = G.m.getRecordId(rec); return i == null ? null : String(i); } catch (e) { return null; } }
  function meta(id) { try { return G.m.getRecordMetadata(id) || {}; } catch (e) { return {}; } }
  function registro(id) { try { return G.m.getRecord(id); } catch (e) { return null; } }
  function ids() { var o = []; G.m.forEach(function (r) { var i = rid(r); if (i != null) o.push(i); }); return o; }
  function temErro(md) {
    if (!md) return false;
    if (md.error) return true;
    var f = md.fields || {}; return Object.keys(f).some(function (k) { return f[k] && f[k].error; });
  }
  /* um lançamento novo ainda em branco (só a empresa, que vem sozinha) */
  function emBranco(rec) {
    return ['COD_OCORR', 'MATRICULA', 'HORA_QTD', 'MIN_DIA', 'VALOR', 'FAIXA', 'DATA_REF', 'OBSERVACAO', 'PARC_NOVA'].every(function (c) { return !val(rec, c).v; });
  }
  function lancamentos() {
    var out = [];
    G.m.forEach(function (rec) {
      var id = rid(rec); if (id == null) return;
      var md = meta(id); if (md.deleted || md.agg) return;
      var ev = evento(val(rec, 'COD_OCORR').d), mat = val(rec, 'MATRICULA');
      out.push({
        id: id, rec: rec, md: md,
        novo: !!md.inserted, mudou: !!(md.inserted || md.updated), erro: temErro(md), branco: !!md.inserted && emBranco(rec),
        ev: ev, quem: mat, mes: val(rec, 'DATA_REF').d, empresa: val(rec, 'COD_EMPRESA').d,
        h: val(rec, 'HORA_QTD').v, min: val(rec, 'MIN_DIA').v, valor: val(rec, 'VALOR').v,
        u2: val(rec, 'IND_UNID2').v, parc: val(rec, 'PARC_NOVA').v || val(rec, 'PARC_ORIG').v
      });
    });
    return out;
  }
  function quanto(l) {
    var p = [];
    if (l.h) p.push(l.min || l.u2 === 'S' ? l.h + ' h' + (l.min && +l.min ? ' ' + l.min + ' min' : '') : l.h);
    else if (l.min) p.push(l.min + ' min');
    if (l.valor) p.push(reais(l.valor));
    return p.join(' · ');
  }
  function quemTexto(l) {
    if (!l.quem.v) return null;
    var nomes = l.quem.d ? l.quem.d.split(/\s*,\s*(?=\d)/) : l.quem.v.split(':');
    if (nomes.length === 1) { var m = /^(\d+)\s*-\s*(.+)$/.exec(nomes[0]); return m ? frase(m[2]).replace(/(^|\s)([a-zà-ú])/g, function (a, b, c) { return b + c.toUpperCase(); }).replace(/\s(De|Da|Do|Das|Dos|E)(?=\s)/g, function (x) { return x.toLowerCase(); }) : nomes[0]; }
    return plural(nomes.length, 'colaborador', 'colaboradores');
  }
  function haPendente() { try { return G.m.isChanged(); } catch (e) { return false; } }
  function salvos() { return lancamentos().filter(function (l) { return !l.novo; }).length; }

  /* ═══ MONTAGEM ════════════════════════════════════════════════════════════════════════ */
  function montar() {
    APP = el('section', 'nc-lf');
    APP.setAttribute('aria-label', 'Lançamentos');
    TOPO_EL = el('header', 'nc-lf-topo');
    var area = el('div', 'nc-lf-area');
    LISTA_EL = el('div', 'nc-lf-lista');
    FICHA_EL = el('div', 'nc-lf-ficha');
    FICHA_EL.innerHTML = '<div class="nc-lf-fcab"></div><div class="nc-lf-fcorpo"><div class="nc-lf-fmsg"></div><div class="nc-lf-fgrade"><div class="nc-lf-fmotor"></div><aside class="nc-lf-resumo" aria-live="polite" aria-label="Como vai ficar"></aside></div></div><div class="nc-lf-fpe"></div>';
    area.appendChild(LISTA_EL); area.appendChild(FICHA_EL);
    APP.appendChild(TOPO_EL); APP.appendChild(area);
    G.reg.parentNode.insertBefore(APP, G.reg);
    /* o grid (o .a-IG, onde mora a vista de um registro) vai para a ficha; a região fica no lugar
       para a Tabela ([L12]) e para as ações da página que a escondem/mostram */
    G.lugar = document.createComment('nc-lf-grade');
    G.ig.parentNode.insertBefore(G.lugar, G.ig);
    FICHA_EL.querySelector('.nc-lf-fmotor').appendChild(G.ig);
    G.ig.classList.add('nc-lf-motor');
    /* CUIDADO: fora da região, as listas das colunas (Evento, Mês, Colaboradores) perdiam o contexto
       da linha — o APEX acha a região subindo pelo HTML — e o servidor respondia "Ocorreu um erro ao
       tentar processar as informações". data-owning-region diz ao APEX a quem o grid pertence. */
    G.ig.setAttribute('data-owning-region', G.reg.id);
    montarTopo();
    ligarLista();
    ligarFicha();
    ligarPe();
    ligarProcesso();
    /* abre: lançamento em branco (janela nova) → a ficha dele; senão, o convite */
    var ls = lancamentos(), branco = ls.filter(function (l) { return l.novo; })[0];
    if (branco) abrir(branco.id); else mostrarInicio();
    desenhar();
  }

  /* ═══ [L5] O ALTO: ONDE SE ESTÁ LANÇANDO E OS 3 PASSOS ════════════════════════════════════
     PODE MEXER os textos dos passos.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PASSOS = [
    ['Preencha', 'Quem, o quê, quanto e quando.'],
    ['Salve', 'Fica guardado, ainda fora da folha.'],
    ['Processe', 'Leva os salvos para a folha.']
  ];
  function montarTopo() {
    var proc = PROCESSOS[item('P7_PROCESSO')] || limpo(item('P7_PROC_TXT')).replace(/\s*\|\s*/g, ' e ') || 'Lançamentos';
    var emps = [];
    try {
      var sel = $id(G.v.modelColumns.COD_EMPRESA.elementId);
      emps = [].filter.call(sel.options, function (o) { return o.value; }).map(function (o) { return codNome(o.text); });
    } catch (e) { /* ok */ }
    var meses = item('P7_DATAREF').split(':').filter(Boolean).map(mesExtenso);
    TOPO_EL.innerHTML =
      '<div class="nc-lf-onde">' +
        '<span class="nc-lf-onde-ic">' + ic('folha') + '</span>' +
        '<div class="nc-lf-onde-txt"><h2>' + esc(proc) + '</h2>' +
          '<p>' + [emps.length ? '<span>' + ic('predio') + esc(emps.length > 2 ? plural(emps.length, 'empresa', 'empresas') : emps.join(' · ')) + '</span>' : '',
                  meses.length ? '<span>' + ic('calendario') + esc(meses.length > 3 ? plural(meses.length, 'mês', 'meses') : meses.join(' · ')) + '</span>' : ''].join('') + '</p></div>' +
      '</div>' +
      '<ol class="nc-lf-passos" aria-label="Passo a passo">' + PASSOS.map(function (p, i) {
        return '<li class="nc-lf-passo" data-passo="' + (i + 1) + '"><span class="nc-lf-passo-n" aria-hidden="true"><span>' + (i + 1) + '</span>' + ic('check') + '</span>' +
          '<span class="nc-lf-passo-txt"><b>' + esc(p[0]) + '</b><span>' + esc(p[1]) + '</span></span></li>';
      }).join('') + '</ol>' +
      '<div class="nc-lf-vistas" role="group" aria-label="Como ver os lançamentos">' +
        '<button type="button" data-vista="ficha" aria-pressed="true" title="Um lançamento por vez, com perguntas">' + ic('ficha') + '<span>Ficha</span></button>' +
        '<button type="button" data-vista="tabela" aria-pressed="false" title="Todos em linhas, como planilha">' + ic('tabela') + '<span>Tabela</span></button>' +
      '</div>';
    TOPO_EL.addEventListener('click', function (ev) { var b = ev.target.closest('[data-vista]'); if (b) vista(b.getAttribute('data-vista')); });
  }
  function desenharPassos(ls) {
    /* 1 enquanto o lançamento aberto não tem as 4 respostas; 2 quando tem e falta salvar; 3 com tudo salvo */
    var pend = ls.filter(function (l) { return l.mudou && !l.branco; }).length, ok = ls.filter(function (l) { return !l.novo; }).length;
    var atual = ESTADO.modo === 'editando' && !ESTADO.completo ? 1 : pend ? 2 : ok ? 3 : 1;
    [].forEach.call(TOPO_EL.querySelectorAll('.nc-lf-passo'), function (li) {
      var n = +li.getAttribute('data-passo');
      li.classList.toggle('is-feito', n < atual);
      li.classList.toggle('is-atual', n === atual);
      if (n === atual) li.setAttribute('aria-current', 'step'); else li.removeAttribute('aria-current');
    });
  }

  /* ═══ [L6] A LISTA DE LANÇAMENTOS ════════════════════════════════════════════════════════ */
  function ligarLista() {
    LISTA_EL.addEventListener('click', function (ev) {
      var b = ev.target.closest('[data-novo],[data-id]'); if (!b) return;
      if (b.hasAttribute('data-novo')) return novo();
      trocar(b.getAttribute('data-id'));
    });
  }
  function desenharLista(ls) {
    var podeNovo = false; try { podeNovo = !!G.m.allowAdd(); } catch (e) { /* ok */ }
    var visiveis = ls.filter(function (l) { return !l.branco || l.id === ESTADO.rid; });
    var cab = '<div class="nc-lf-lcab"><h3>Lançamentos <span class="nc-lf-conta">' + visiveis.length + '</span></h3></div>';
    var novoBt = podeNovo ? '<button type="button" class="nc-lf-novo" data-novo>' + ic('mais') + '<span>Novo lançamento</span></button>' : '';
    var itens = visiveis.map(function (l, i) {
      var q = quanto(l), quem = quemTexto(l), sit;
      if (l.erro) sit = ['erro', 'Precisa corrigir'];
      else if (l.branco) sit = ['branco', 'Em branco'];
      else if (l.mudou) sit = ['pendente', 'Falta salvar'];
      else sit = ['ok', 'Salvo'];
      return '<li><button type="button" class="nc-lf-cartao is-' + sit[0] + (l.id === ESTADO.rid && ESTADO.modo === 'editando' ? ' is-aberto' : '') + '" data-id="' + esc(l.id) + '"' +
        (l.id === ESTADO.rid && ESTADO.modo === 'editando' ? ' aria-current="true"' : '') + '>' +
        '<span class="nc-lf-c-topo"><span class="nc-lf-c-n">' + (i + 1) + '</span>' +
          '<span class="nc-lf-sit is-' + sit[0] + '">' + esc(sit[1]) + '</span></span>' +
        '<span class="nc-lf-c-ev">' + (l.ev.nome ? esc(l.ev.nome) + (l.ev.cod ? ' <i>' + esc(l.ev.cod) + '</i>' : '') : '<em>Evento ainda não escolhido</em>') + '</span>' +
        (q ? '<span class="nc-lf-c-q">' + esc(q) + '</span>' : '') +
        '<span class="nc-lf-c-linha">' +
          (quem ? '<span>' + ic(l.quem.v.indexOf(':') > -1 ? 'pessoas' : 'pessoa') + esc(quem) + '</span>'
                : (l.branco ? '' : '<span class="is-todos">' + ic('pessoas') + 'Todos da pesquisa</span>')) +
          (l.mes ? '<span>' + ic('calendario') + esc(l.mes) + '</span>' : '') +
        '</span>' +
      '</button></li>';
    }).join('');
    LISTA_EL.innerHTML = cab + novoBt + (itens ? '<ol class="nc-lf-cartoes">' + itens + '</ol>' :
      '<p class="nc-lf-lvazio">' + ic('folha') + '<span>Nenhum lançamento ainda. Toque em <b>Novo lançamento</b> para começar.</span></p>');
  }

  /* ═══ [L7] A FICHA (A VISTA DE UM REGISTRO DA GRADE) ═════════════════════════════════════
     CUIDADO  A ficha é a "vista de um registro" (Single Row View) da PRÓPRIA grade: o .a-IG
              mora dentro dela. Trocar de lançamento = andar com a vista até o registro.
              A vista REESCREVE as classes dos campos a cada registro: ordem, largura, o que
              aparece e os avisos do "Quanto?" vão numa folha presa ao ID de cada campo (feita
              uma vez) e em atributos da própria ficha (data-q-*, data-quem, is-fecha-*).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function srvAtual() { try { var r = G.v.singleRowView$ && G.v.singleRowView$.recordView('getRecord'); return r ? rid(r) : null; } catch (e) { return null; } }
  function srvAberta() { try { return !!G.v.singleRowMode; } catch (e) { return false; } }
  function irPara(id) {
    try { G.acoes.set('edit', true); } catch (e) { /* já em edição */ }
    if (!srvAberta()) {
      try { G.v.view$.grid('gotoCell', id, 'COD_OCORR'); } catch (e) { /* ok */ }
      try { G.acoes.invoke('single-row-view'); } catch (e) { /* ok */ }
    }
    var lista = ids(), alvo = lista.indexOf(id);
    for (var i = 0; i < 400 && srvAtual() !== id; i++) {
      var aqui = lista.indexOf(srvAtual()); if (aqui < 0 || alvo < 0) break;
      try { G.acoes.invoke(aqui < alvo ? 'next-record' : 'previous-record'); } catch (e) { break; }
    }
  }
  function abrir(id) {
    ESTADO.rid = id; ESTADO.modo = 'editando';
    FICHA_EL.classList.remove('is-inicio', 'is-pronto');
    FICHA_EL.classList.add('is-editando');
    irPara(id);
    arrumarFicha();
    estadoFicha();
    cabecalhoFicha();
    peFicha();
    document.body.classList.add('nc-lf-ficha-aberta');
    FICHA_EL.querySelector('.nc-lf-fcorpo').scrollTop = 0;
    desenhar();
  }
  /* sem lançamento aberto: o convite (janela aberta com lançamentos já salvos) */
  function mostrarInicio() {
    fecharVista();
    ESTADO.rid = null; ESTADO.modo = 'inicio';
    FICHA_EL.classList.remove('is-editando', 'is-pronto'); FICHA_EL.classList.add('is-inicio');
    FICHA_EL.querySelector('.nc-lf-fcab').innerHTML = '';
    FICHA_EL.querySelector('.nc-lf-fmsg').innerHTML =
      '<div class="nc-lf-convite">' + ic('ficha') + '<h3>Escolha um lançamento na lista</h3>' +
      '<p>Toque num cartão para ver ou corrigir. Para lançar algo novo, use o botão abaixo.</p>' +
      '<button type="button" class="nc-lf-bt nc-lf-bt--forte" data-fnovo>' + ic('mais') + '<span>Novo lançamento</span></button></div>';
    FICHA_EL.querySelector('.nc-lf-fpe').innerHTML = '';
    document.body.classList.remove('nc-lf-ficha-aberta');
  }
  /* depois de salvar: o que fazer agora */
  function mostrarPronto(oQue) {
    fecharVista();
    ESTADO.rid = null; ESTADO.modo = 'pronto';
    FICHA_EL.classList.remove('is-editando', 'is-inicio'); FICHA_EL.classList.add('is-pronto');
    FICHA_EL.querySelector('.nc-lf-fcab').innerHTML = '';
    var n = salvos();
    FICHA_EL.querySelector('.nc-lf-fmsg').innerHTML =
      '<div class="nc-lf-convite is-ok"><span class="nc-lf-ok">' + ic('check') + '</span>' +
      '<h3>' + (oQue === 'excluido' ? 'Lançamento excluído' : 'Lançamento salvo') + '</h3>' +
      '<p>' + (n ? 'Você tem ' + plural(n, 'lançamento salvo', 'lançamentos salvos') + '. Tem mais algum? Lance agora. Terminou? Toque em <b>Processar lançamentos</b>, no pé da janela.'
                 : 'Para lançar algo, use o botão abaixo.') + '</p>' +
      '<button type="button" class="nc-lf-bt nc-lf-bt--forte" data-fnovo>' + ic('mais') + '<span>Lançar outro</span></button></div>';
    FICHA_EL.querySelector('.nc-lf-fpe').innerHTML = '';
    document.body.classList.remove('nc-lf-ficha-aberta');
    desenhar();
  }
  function fecharVista() { if (srvAberta()) try { G.acoes.invoke('close-single-row-view'); } catch (e) { /* ok */ } }
  function cabecalhoFicha() {
    var l = lancamentos().filter(function (x) { return x.id === ESTADO.rid; })[0];
    var t = !l ? 'Lançamento' : l.novo ? 'Novo lançamento' : (l.ev.nome || 'Lançamento');
    FICHA_EL.querySelector('.nc-lf-fcab').innerHTML =
      '<button type="button" class="nc-lf-bt nc-lf-bt--icone nc-lf-fvolta" data-fvolta aria-label="Voltar para a lista">' + ic('voltar') + '</button>' +
      '<div class="nc-lf-ftit"><h3 id="nc-lf-ftit">' + esc(t) + '</h3>' +
      (l && !l.novo ? '<p>' + (l.mudou ? 'Alterado · falta salvar' : 'Salvo · pode corrigir e salvar de novo') + '</p>' : '<p>Responda às perguntas e toque em Salvar.</p>') + '</div>';
    FICHA_EL.querySelector('.nc-lf-fmsg').innerHTML = '';
  }
  function peFicha() {
    var l = lancamentos().filter(function (x) { return x.id === ESTADO.rid; })[0], pe = FICHA_EL.querySelector('.nc-lf-fpe');
    var podeEx = false; try { podeEx = l && !l.novo && G.m.allowDelete(l.rec); } catch (e) { /* ok */ }
    var podeNovo = false; try { podeNovo = !!G.m.allowAdd(); } catch (e) { /* ok */ }
    pe.innerHTML =
      (podeEx ? '<button type="button" class="nc-lf-bt nc-lf-bt--perigo" data-fexcluir>' + ic('lixo') + '<span>Excluir</span></button>' : '') +
      '<span class="nc-lf-espaco"></span>' +
      '<button type="button" class="nc-lf-bt" data-fdescartar>' + (l && l.novo ? 'Descartar' : 'Desfazer') + '</button>' +
      (podeNovo ? '<button type="button" class="nc-lf-bt nc-lf-bt--claro" data-fsalvar="outro">' + ic('mais') + '<span>Salvar e lançar outro</span></button>' : '') +
      '<button type="button" class="nc-lf-bt nc-lf-bt--forte" data-fsalvar>' + ic('check') + '<span>Salvar</span></button>';
  }
  var folha = null;
  function arrumarFicha() {
    var rv = G.ig.querySelector('.a-RV'), form = rv && rv.querySelector('.u-Form'); if (!form) return;
    var regras = [], sec = null, base = 'html body:not(#nc-a1):not(#nc-a2).nc-lf-ativo .nc-lf-ficha .a-RV .u-Form > ';
    FICHA.forEach(function (f, i) {
      if (!f.length) {
        sec = f.sec;
        /* só a pergunta que tem algum campo na página */
        var tem = false;
        for (var k = i + 1; k < FICHA.length && FICHA[k].length; k++) { var mc0 = G.v.modelColumns[FICHA[k][0]]; if (mc0 && $id(mc0.elementId + '_CONTAINER')) { tem = true; break; } }
        var h = form.querySelector('.nc-lf-sec[data-sec="' + f.sec + '"]');
        if (!tem) { if (h) h.remove(); return; }
        if (!h) {
          h = el(f.recolhe ? 'button' : 'div', 'nc-lf-sec' + (f.recolhe ? ' is-recolhe' : ''),
            '<span class="nc-lf-sec-ic">' + ic(f.ic) + '</span><span class="nc-lf-sec-txt"><b>' + esc(f.tit) + '</b>' +
            '<span class="nc-lf-sec-dica">' + esc(f.dica || '') + '</span></span>' + (f.recolhe ? '<span class="nc-lf-sec-seta">' + ic('seta') + '</span>' : ''));
          if (f.recolhe) { h.type = 'button'; h.setAttribute('aria-expanded', 'false'); }
          h.setAttribute('data-sec', f.sec); h.style.order = i * 10;
          form.appendChild(h);
        }
        if (f.sec === 'quem' && !form.querySelector('.nc-lf-quem')) {
          var q = el('div', 'nc-lf-quem', '<p class="nc-lf-quem-perg" id="nc-lf-quem-perg">Quem recebe este lançamento?</p>' +
            '<div class="nc-lf-quem-ops" role="radiogroup" aria-labelledby="nc-lf-quem-perg">' +
              '<button type="button" role="radio" aria-checked="false" data-quem="escolher">' + ic('pessoa') + '<span><b>Escolher colaboradores</b><span>Um ou mais, pelo nome ou matrícula</span></span></button>' +
              '<button type="button" role="radio" aria-checked="false" data-quem="todos">' + ic('pessoas') + '<span><b>Todos da pesquisa</b><span>Todos os colaboradores que a pesquisa trouxe</span></span></button>' +
            '</div>');
          q.style.order = (i + 1) * 10 + 5;    /* depois da Empresa (a 1ª linha da pergunta), antes dos Colaboradores */
          form.appendChild(q);
        }
        return;
      }
      var mc = G.v.modelColumns[f[0]], id = mc && mc.elementId + '_CONTAINER', c = id && $id(id);
      if (!c) return;
      var ordem = i * 10 + (f[0] === 'MATRICULA' ? 6 : 0);
      regras.push(base + '#' + id + ':not(#nc-lf-x){display:flex!important;order:' + ordem + '!important;grid-column:' + (f[2] === 'meia' ? 'auto' : '1 / -1') + '!important}');
      if (FICHA.some(function (x) { return x.recolhe && x.sec === sec; })) regras.push('html body:not(#nc-a1):not(#nc-a2).nc-lf-ativo .nc-lf-ficha.is-fecha-' + sec + ' .a-RV .u-Form > #' + id + ':not(#nc-lf-x):not(#nc-lf-y){display:none!important}');
      if (f[0] === 'MATRICULA') regras.push('html body:not(#nc-a1):not(#nc-a2).nc-lf-ativo .nc-lf-ficha:not([data-quem="escolher"]) .a-RV .u-Form > #' + id + ':not(#nc-lf-x):not(#nc-lf-y){display:none!important}');
      if (QUANTO[f[0]]) {
        var q2 = 'html body:not(#nc-a1):not(#nc-a2).nc-lf-ativo .nc-lf-ficha[data-q-' + f[0].toLowerCase() + '="';
        regras.push(q2 + 'nao"] .a-RV .u-Form > #' + id + ' .u-Form-inputContainer{opacity:.45!important;border-style:dashed!important;background:transparent!important}');
        regras.push(q2 + 'nao"] .a-RV .u-Form > #' + id + ' .u-Form-label::after{content:"Não se usa neste evento"!important;color:var(--lf-fraco)!important;background:var(--lf-fundo)!important}');
        regras.push(q2 + 'nao"] .a-RV .u-Form > #' + id + ' .nc-lf-dica{display:none!important}');
        regras.push(q2 + 'pede"] .a-RV .u-Form > #' + id + ' .u-Form-label::after{content:"Preencha"!important;color:var(--lf-rosa-escuro)!important;background:var(--lf-rosa-claro)!important}');
        regras.push(q2 + 'pode"] .a-RV .u-Form > #' + id + ' .u-Form-label::after{content:"Este evento aceita"!important;color:var(--lf-rosa-escuro)!important;background:var(--lf-rosa-claro)!important}');
        regras.push(q2 + 'apague"] .a-RV .u-Form > #' + id + ' .u-Form-label::after{content:"Apague: este evento não usa"!important;color:#fff!important;background:var(--lf-ruim)!important}');
        regras.push(q2 + 'dispensa-h"] .a-RV .u-Form > #' + id + ' .u-Form-label::after{content:"Não precisa: já tem horas"!important;color:var(--lf-texto)!important;background:var(--lf-fundo)!important}');
        regras.push(q2 + 'dispensa-v"] .a-RV .u-Form > #' + id + ' .u-Form-label::after{content:"Não precisa: já tem valor"!important;color:var(--lf-texto)!important;background:var(--lf-fundo)!important}');
        regras.push(q2 + 'apague"] .a-RV .u-Form > #' + id + ' .u-Form-inputContainer{border-color:var(--lf-ruim)!important}');
      }
      /* nome e dica (a vista pode refazer o campo: conferido a cada abertura) */
      var lb = c.querySelector('.u-Form-label'); if (lb && f[1] && lb.textContent !== f[1]) lb.textContent = f[1];
      var dica = f[3];
      if (f[0] === 'DT_RETENCAO') dica = item('P7_PROCESSO') === '6' ? 'Obrigatória em Pagamentos diversos.' : 'Opcional. Deixe em branco se não souber.';
      if (f[0] === 'DATA_REF' && item('P7_DATAREF') && item('P7_DATAREF').indexOf(':') < 0) dica = 'Na pesquisa você escolheu ' + mesExtenso(item('P7_DATAREF')).toLowerCase() + '.';
      var dEl = c.querySelector('.nc-lf-dica');
      if (dica) { if (!dEl) { dEl = el('p', 'nc-lf-dica'); c.appendChild(dEl); } if (dEl.textContent !== dica) dEl.textContent = dica; }
    });
    if (!folha) { folha = el('style'); folha.id = 'nc-lf-folha'; document.head.appendChild(folha); folha.textContent = regras.join('\n'); }
  }

  /* ═══ [L8] "QUANTO?" E "PARA QUEM?": O QUE O EVENTO PEDE ═══════════════════════════════════
     Os indicadores (IND_*) são os que a ação "Atribui Indicadores" da página traz ao escolher o
     evento — as mesmas regras das validações "Valida Valor / Hora Qtd. / Min. Dia / Faixa":
       IND_UNID1 = S → horas/quantidade · IND_UNID2 = S → minutos · IND_VALOR = S → valor ·
       IND_FAIXA = S → faixa. "N" = a validação recusa o campo preenchido.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function estadoFicha() {
    var rec = ESTADO.rid && registro(ESTADO.rid); if (!rec) return;
    var ind = {}; Object.keys(QUANTO).forEach(function (c) { ind[c] = val(rec, QUANTO[c]).v; });
    var temEv = !!val(rec, 'COD_OCORR').v, temInd = Object.keys(ind).some(function (c) { return ind[c]; });
    var vS = ind.VALOR === 'S', u1 = ind.HORA_QTD === 'S', u2 = ind.MIN_DIA === 'S';
    Object.keys(QUANTO).forEach(function (c) {
      var s = '';
      if (temEv && temInd) {
        if (ind[c] === 'N') s = val(rec, c).v ? 'apague' : 'nao';
        else if (ind[c] === 'S') {
          if (c === 'VALOR') s = (u1 || u2) ? 'pode' : 'pede';
          else if (c === 'FAIXA') s = 'pode';
          else s = vS ? 'pode' : 'pede';
        }
      }
      /* aceita horas OU valor: preenchido um, o outro não precisa */
      if (s === 'pode' && c !== 'FAIXA' && vS && (u1 || u2)) {
        var temH = val(rec, 'HORA_QTD').v || val(rec, 'MIN_DIA').v, temV = val(rec, 'VALOR').v;
        if (c === 'VALOR' && temH && !temV) s = 'dispensa-h';
        if (c !== 'VALOR' && temV && !temH) s = 'dispensa-v';
      }
      if (s) FICHA_EL.setAttribute('data-q-' + c.toLowerCase(), s); else FICHA_EL.removeAttribute('data-q-' + c.toLowerCase());
    });
    resumo(rec, { temEv: temEv, temInd: temInd, vS: vS, u1: u1, u2: u2 });
    var dq = FICHA_EL.querySelector('.nc-lf-sec[data-sec="quanto"] .nc-lf-sec-dica');
    if (dq) {
      var t;
      if (!temEv) t = 'Escolha primeiro o evento: ele diz se é lançado em horas, quantidade ou valor.';
      else if (!temInd) t = 'Conferindo o que este evento pede…';
      else if ((u1 || u2) && vS) t = 'Este evento aceita horas/quantidade ou valor: preencha um deles.';
      else if (u1 && u2) t = 'Este evento é lançado em horas e minutos (ou quantidade).';
      else if (u1) t = 'Este evento é lançado em horas ou quantidade.';
      else if (vS) t = 'Este evento é lançado em valor (R$).';
      else t = 'Este evento não pede horas nem valor.';
      if (dq.textContent !== t) dq.textContent = t;
    }
    /* para quem: o vazio na grade quer dizer "todos da pesquisa" (como sempre foi) */
    var mat = val(rec, 'MATRICULA').v, md = meta(ESTADO.rid);
    var quem = mat ? 'escolher' : (QUEM[ESTADO.rid] || (md.inserted ? '' : 'todos'));
    if (quem) FICHA_EL.setAttribute('data-quem', quem); else FICHA_EL.removeAttribute('data-quem');
    [].forEach.call(FICHA_EL.querySelectorAll('.nc-lf-quem [data-quem]'), function (b) { b.setAttribute('aria-checked', String(b.getAttribute('data-quem') === quem)); });
    /* recolhidas: abertas se o gestor abriu, se há erro dentro, ou se "repete" foi mudado à mão */
    FICHA.forEach(function (f) {
      if (!f.recolhe) return;
      var cols = colunasDe(f.sec), erro = cols.some(function (c) { return campoComErro(c); });
      var aberta = ABERTAS[f.sec] || erro || (f.sec === 'falta' && cols.some(function (c) { return val(rec, c).v; })) || (f.sec === 'repete' && val(rec, 'PARC_NOVA').v);
      FICHA_EL.classList.toggle('is-fecha-' + f.sec, !aberta);
      var h = FICHA_EL.querySelector('.nc-lf-sec[data-sec="' + f.sec + '"]'); if (!h) return;
      h.setAttribute('aria-expanded', String(!!aberta));
      var d = h.querySelector('.nc-lf-sec-dica');
      if (d && !aberta) {
        var resumo = f.dica;
        if (f.sec === 'repete') { var a = val(rec, 'DT_INIC_VAL').v, b = val(rec, 'DT_FIN_VAL').v; resumo = a && b ? 'Vale de ' + a + ' a ' + b + '. Toque para mudar.' : 'As datas se preenchem sozinhas quando você escolhe o mês da folha.'; }
        if (d.textContent !== resumo) d.textContent = resumo;
      } else if (d && d.textContent !== f.dica) d.textContent = f.dica;
    });
  }
  /* "COMO VAI FICAR": o lançamento lido em voz alta, numa frase, e o que ainda falta.
     PODE MEXER as frases. */
  function resumo(rec, x) {
    var caixa = FICHA_EL.querySelector('.nc-lf-resumo'); if (!caixa) return;
    var l = lancamentos().filter(function (y) { return y.id === ESTADO.rid; })[0]; if (!l) { caixa.innerHTML = ''; return; }
    var q = quanto(l), quem = quemTexto(l), qEsc = FICHA_EL.getAttribute('data-quem');
    var quemTxt = quem || (qEsc === 'todos' ? 'todos os colaboradores da pesquisa' : '');
    var mes = l.mes ? mesExtenso(l.mes).toLowerCase() : '';
    var semQuanto = x.temEv && x.temInd && !x.vS && !x.u1 && !x.u2;
    var falta = function (t) { return '<span class="nc-lf-falta">' + esc(t) + '</span>'; };
    var frase0 = 'Lançar ' + (semQuanto ? '' : (q ? '<b>' + esc(q) + '</b> de ' : falta('quanto') + ' de ')) +
      (l.ev.nome ? '<b>' + esc(l.ev.nome) + '</b>' : falta('qual evento')) +
      ' para ' + (quemTxt ? '<b>' + esc(quemTxt) + '</b>' : falta('quem')) +
      ', na folha de ' + (mes ? '<b>' + esc(mes) + '</b>' : falta('qual mês')) + '.';
    var a = val(rec, 'DT_INIC_VAL').v, b = val(rec, 'DT_FIN_VAL').v, pn = +val(rec, 'PARC_NOVA').v || 0;
    var repete = pn > 1 ? 'Em ' + pn + ' parcelas' + (a && b ? ', de ' + a + ' a ' + b : '') : (a && b && a.slice(3) !== b.slice(3) ? 'De ' + a + ' a ' + b : 'Só neste mês');
    var itens = [
      ['Para quem', quemTxt ? frase(quemTxt).replace(/^./, function (c) { return c.toUpperCase(); }) : '', 'Escolha uma opção'],
      ['Evento', l.ev.nome, 'Escolha o evento'],
      ['Quanto', semQuanto ? 'Este evento não pede' : q, 'Preencha horas ou valor'],
      ['Mês da folha', mes ? mes.replace(/^./, function (c) { return c.toUpperCase(); }) : '', 'Escolha o mês'],
      ['Repetir', l.mes ? repete : '', 'Depois do mês da folha']
    ];
    var feitos = itens.slice(0, 4).filter(function (i) { return i[1]; }).length;
    ESTADO.completo = feitos === 4;
    var html = '<h4>Como vai ficar</h4><p class="nc-lf-frase">' + frase0 + '</p>' +
      '<ul class="nc-lf-confere">' + itens.map(function (i) {
        var info = i[0] === 'Repetir';
        return '<li class="' + (info ? 'is-info' + (i[1] ? '' : ' is-falta') : i[1] ? 'is-ok' : 'is-falta') + '"><span class="nc-lf-marca" aria-hidden="true">' + (info ? ic('repete') : i[1] ? ic('check') : '') + '</span>' +
          '<span><i>' + esc(i[0]) + '</i><b>' + esc(i[1] || i[2]) + '</b></span></li>';
      }).join('') + '</ul>' +
      '<p class="nc-lf-pronto' + (feitos === 4 ? ' is-ok' : '') + '">' + (feitos === 4 ? 'Tudo preenchido. Confira e toque em Salvar.' : 'Faltam ' + (4 - feitos) + ' de 4 respostas.') + '</p>';
    if (caixa.__html !== html) { caixa.innerHTML = html; caixa.__html = html; }
  }
  function colunasDe(sec) {
    var out = [], dentro = false;
    FICHA.forEach(function (f) { if (!f.length) { dentro = f.sec === sec; return; } if (dentro) out.push(f[0]); });
    return out;
  }
  function campoComErro(col) {
    var md = ESTADO.rid ? meta(ESTADO.rid) : {}; var f = md.fields && md.fields[col];
    if (f && f.error) return true;
    var mc = G.v.modelColumns[col], c = mc && $id(mc.elementId + '_CONTAINER');
    return !!(c && c.classList.contains('is-error'));
  }
  function escolherQuem(q) {
    var rec = ESTADO.rid && registro(ESTADO.rid); if (!rec) return;
    QUEM[ESTADO.rid] = q;
    if (q === 'todos' && val(rec, 'MATRICULA').v) { try { G.m.setValue(rec, 'MATRICULA', { v: '', d: '' }); } catch (e) { /* ok */ } }
    estadoFicha(); desenhar();
    if (q === 'escolher') {
      var mc = G.v.modelColumns.MATRICULA, bt = mc && $id(mc.elementId + '_lov_btn');
      setTimeout(function () { if (bt && bt.offsetParent) bt.click(); }, 60);
    }
  }

  function ligarFicha() {
    FICHA_EL.addEventListener('click', function (ev) {
      var t = ev.target;
      if (t.closest('[data-fnovo]')) return novo();
      if (t.closest('[data-fsalvar]')) return salvar(t.closest('[data-fsalvar]').getAttribute('data-fsalvar') || '');
      if (t.closest('[data-fdescartar]')) return descartar();
      if (t.closest('[data-fexcluir]')) return excluir();
      if (t.closest('[data-fvolta]')) return voltarLista();
      var q = t.closest('.nc-lf-quem [data-quem]'); if (q) return escolherQuem(q.getAttribute('data-quem'));
      var s = t.closest('.nc-lf-sec.is-recolhe');
      if (s) { var k = s.getAttribute('data-sec'); ABERTAS[k] = s.getAttribute('aria-expanded') !== 'true'; estadoFicha(); }
    });
    /* setas nas opções de "Para quem" (radio) */
    FICHA_EL.addEventListener('keydown', function (ev) {
      var b = ev.target.closest && ev.target.closest('.nc-lf-quem [data-quem]');
      if (b && /^Arrow/.test(ev.key)) { ev.preventDefault(); var o = b.parentNode.querySelectorAll('[data-quem]'), i = [].indexOf.call(o, b), n = o[(i + (/Right|Down/.test(ev.key) ? 1 : o.length - 1)) % o.length]; n.focus(); escolherQuem(n.getAttribute('data-quem')); }
    });
    /* Ctrl+S salva; Esc no celular volta para a lista */
    window.addEventListener('keydown', function (ev) {
      if (ESTADO.modo !== 'editando' || document.body.classList.contains('nc-lf-tabela')) return;
      if ((ev.ctrlKey || ev.metaKey) && (ev.key === 's' || ev.key === 'S')) { ev.preventDefault(); ev.stopImmediatePropagation(); salvar(''); }
    }, true);
  }

  /* ═══ [L9] SALVAR, NOVO, DESCARTAR, EXCLUIR ════════════════════════════════════════════════
     CUIDADO  Salvar = o "save" da grade (as validações da página valem). A grade só passa o
              último campo digitado para o registro quando o foco vai para OUTRO campo dela: antes
              de salvar, cada campo da ficha é copiado do formulário (sincronizar). As ações das
              colunas rodam ao sair do campo: espera-se as chamadas voltarem (até 6 s).
              Um lançamento por vez: trocar com algo por salvar pede para salvar ou descartar.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function sincronizar() {
    var rec = ESTADO.rid && registro(ESTADO.rid); if (!rec) return;
    FICHA.forEach(function (f) {
      if (!f.length) return;
      var mc = G.v.modelColumns[f[0]], it; if (!mc) return;
      try { it = apex.item(mc.elementId); } catch (e) { return; }
      if (!it || !it.node || it.node.disabled || it.node.readOnly) return;
      var nv = it.getValue(); if (Array.isArray(nv)) nv = nv.join(':'); nv = nv == null ? '' : String(nv);
      var atual = G.m.getValue(rec, f[0]), obj = !!atual && typeof atual === 'object', av = obj ? String(atual.v == null ? '' : atual.v) : String(atual == null ? '' : atual);
      if (nv === av) return;
      if (!obj && nv && av && numero(nv) === numero(av)) return;
      try {
        if (obj) { var d = ''; try { d = it.displayValueFor ? it.displayValueFor(nv) : ''; } catch (e) { /* ok */ } G.m.setValue(rec, f[0], { v: nv, d: d || nv }); }
        else G.m.setValue(rec, f[0], nv);
      } catch (e) { /* ok */ }
    });
  }
  /* algo por salvar além de um lançamento novo ainda em branco? */
  function pendenteDeVerdade() { return lancamentos().some(function (l) { return l.mudou && !l.branco; }); }
  function tirarBrancos(menos) {
    var fora = lancamentos().filter(function (l) { return l.branco && l.id !== menos; }).map(function (l) { return l.rec; });
    if (fora.length) try { G.m.deleteRecords(fora); } catch (e) { /* ok */ }
  }
  function trocar(id) {
    if (ESTADO.ocupado || (id === ESTADO.rid && ESTADO.modo === 'editando')) return;
    if (ESTADO.modo === 'editando') sincronizar();
    var atual = lancamentos().filter(function (l) { return l.id === ESTADO.rid; })[0];
    if (atual && atual.mudou && !atual.branco) return avisar('Salve ou desfaça este lançamento antes de abrir outro.', true);
    tirarBrancos(id);
    abrir(id);
  }
  function novo() {
    if (ESTADO.ocupado) return;
    if (document.body.classList.contains('nc-lf-tabela')) vista('ficha');
    if (ESTADO.modo === 'editando') sincronizar();
    var atual = lancamentos().filter(function (l) { return l.id === ESTADO.rid; })[0];
    if (atual && atual.branco) return abrir(atual.id);
    if (atual && atual.mudou) return avisar('Salve ou descarte este lançamento antes de começar outro.', true);
    var j = lancamentos().filter(function (l) { return l.branco; })[0];
    if (j) return abrir(j.id);
    fecharVista();
    /* CUIDADO: logo depois de fechar a vista de um registro (ou de descartar), a grade às vezes
       ainda não aceita a linha nova: tenta de novo no quadro seguinte (até 5 vezes) */
    var tentar = function (n) {
      var antes = ids();
      try { G.acoes.set('edit', true); } catch (e) { /* ok */ }
      try { G.acoes.invoke('selection-add-row'); } catch (e) { /* segue */ }
      var id = ids().filter(function (x) { return antes.indexOf(x) < 0; })[0];
      if (id == null && n < 5) return setTimeout(function () { tentar(n + 1); }, 80);
      if (id == null) return avisar('Não foi possível começar um lançamento novo.', true);
      abrir(id);
      setTimeout(focoPrimeiro, 120);
    };
    tentar(0);
  }
  function focoPrimeiro() {
    var f = [].filter.call(FICHA_EL.querySelectorAll('.nc-lf-quem [data-quem], .a-RV .u-Form input:not([type="hidden"]):not([readonly]):not([disabled]), .a-RV .u-Form select:not([disabled])'), function (x) { return x.offsetParent !== null; })[0];
    if (f) f.focus({ preventScroll: true });
  }
  function descartar() {
    if (ESTADO.ocupado || !ESTADO.rid) return;
    /* CUIDADO: excluída a linha, o APEX limpa o "inserted" dos metadados — guardar antes */
    var id = ESTADO.rid, rec = registro(id), md = meta(id), eraNovo = !!md.inserted;
    var faz = function () {
      try { if (rec) { if (eraNovo) G.m.deleteRecords([rec]); else G.m.revertRecords([rec]); } } catch (e) { /* ok */ }
      delete QUEM[id];
      if (eraNovo) { fecharVista(); if (lancamentos().length) mostrarInicio(); else { ESTADO.modo = 'inicio'; ESTADO.rid = null; setTimeout(novo, 60); } }
      else abrir(id);
      desenhar();
    };
    var l = lancamentos().filter(function (x) { return x.id === id; })[0];
    if (!l || l.branco || !l.mudou) return faz();
    apex.message.confirm(eraNovo ? 'Descartar este lançamento? O que foi preenchido será perdido.' : 'Desfazer as mudanças deste lançamento? Ele volta a ser como estava salvo.', function (ok) { if (ok) faz(); });
  }
  function excluir() {
    if (ESTADO.ocupado || !ESTADO.rid) return;
    var id = ESTADO.rid;
    apex.message.confirm('Excluir este lançamento? Ele sai da lista e não vai para a folha.', function (ok) {
      if (!ok || ESTADO.rid !== id) return;
      try { G.m.deleteRecords([registro(id)]); } catch (e) { return avisar('Não foi possível excluir.', true); }
      salvar('', 'excluido');
    });
  }
  function salvar(depois, oQue) {
    if (ESTADO.ocupado || (ESTADO.modo !== 'editando' && oQue !== 'excluido')) return;
    if ($.active > 0 && (!ESTADO.espera || Date.now() - ESTADO.espera < 6000)) {
      if (!ESTADO.espera) ESTADO.espera = Date.now();
      return setTimeout(function () { salvar(depois, oQue); }, 80);
    }
    ESTADO.espera = 0;
    if (oQue !== 'excluido') sincronizar();
    var rec = ESTADO.rid && registro(ESTADO.rid);
    if (oQue !== 'excluido' && rec && emBranco(rec)) return avisar('Preencha o lançamento antes de salvar: comece pelo evento.', true);
    tirarBrancos(oQue === 'excluido' ? null : ESTADO.rid);
    if (!haPendente()) { if (depois === 'outro') return novo(); return mostrarPronto('salvo'); }
    /* "Todos da pesquisa" sem o gestor ter escolhido: confirma antes (é o lançamento de maior alcance) */
    if (oQue !== 'excluido' && rec && !val(rec, 'MATRICULA').v && QUEM[ESTADO.rid] !== 'todos' && meta(ESTADO.rid).inserted) {
      return apex.message.confirm('Ninguém foi escolhido em "Para quem". Este lançamento vai para TODOS os colaboradores da pesquisa. Está certo?', function (ok) {
        if (!ok) { escolherQuem('escolher'); return; }
        QUEM[ESTADO.rid] = 'todos'; salvar(depois, oQue);
      });
    }
    ESTADO.ocupado = true; ESTADO.oQue = oQue || 'salvo'; ESTADO.depois = depois || ''; ocupado(true);
    try { G.acoes.invoke('save'); } catch (e) { ESTADO.ocupado = false; ocupado(false); return avisar('Não foi possível salvar. Tente de novo.', true); }
    /* a grade barrou antes de ir ao servidor (campo obrigatório ou inválido, já marcado) */
    setTimeout(function () {
      if (!ESTADO.ocupado || $.active > 0 || !haPendente()) return;
      ESTADO.ocupado = false; ocupado(false); recusado();
    }, 450);
  }
  function recusado() {
    estadoFicha(); desenhar();
    avisar('Falta preencher ou corrigir os campos marcados em vermelho.', true);
    var errado = FICHA_EL.querySelector('.a-RV .is-error');
    if (errado) errado.scrollIntoView({ block: 'center', behavior: 'smooth' });
  }
  function ocupado(sim) {
    FICHA_EL.classList.toggle('is-ocupada', sim);
    [].forEach.call(FICHA_EL.querySelectorAll('.nc-lf-fpe button'), function (b) { b.disabled = sim; });
    var s = FICHA_EL.querySelector('.nc-lf-fpe [data-fsalvar=""] span'); if (s) s.textContent = sim ? 'Salvando…' : 'Salvar';
  }
  /* CUIDADO: "interactivegridsave" chega também quando a gravação FALHA. Só é sucesso com status
     ok E sem nada pendente no modelo; senão a ficha fica aberta com o que foi digitado. */
  function aoSalvar(ev, data) {
    if (!ESTADO.ocupado) return;
    var ok = (!data || data.status === undefined || data.status === 'success') && !haPendente();
    ESTADO.ocupado = false; ocupado(false);
    if (!ok) return recusado();
    var oQue = ESTADO.oQue, depois = ESTADO.depois;
    avisar(oQue === 'excluido' ? 'Lançamento excluído' : 'Lançamento salvo');
    QUEM = {};
    if (depois === 'outro') novo(); else mostrarPronto(oQue);
    /* busca de novo: o servidor completa campos ao gravar (dígito da matrícula) */
    setTimeout(function () { try { apex.region('IGOCORR').refresh(); } catch (x) { /* ok */ } }, 50);
  }
  function voltarLista() {
    if (ESTADO.modo !== 'editando') return;
    sincronizar();
    var l = lancamentos().filter(function (x) { return x.id === ESTADO.rid; })[0];
    if (l && l.mudou && !l.branco) return apex.message.confirm('Voltar sem salvar? O que foi preenchido será descartado.', function (ok) { if (ok) { descartar0(l); } });
    if (l && l.branco) descartar0(l); else mostrarInicio();
    desenhar();
  }
  function descartar0(l) {
    try { if (l.novo) G.m.deleteRecords([l.rec]); else G.m.revertRecords([l.rec]); } catch (e) { /* ok */ }
    mostrarInicio(); desenhar();
  }

  /* ═══ [L10] O PÉ DA JANELA: PROCESSAR E CANCELAR ════════════════════════════════════════════
     CUIDADO  Os botões e as caixas são os da página (região "Buttons", no rodapé da janela):
              Processar continua desligado até salvar (ações "Disable PROCESSA" e "Enable Disable
              BT Create"). Aqui só se explica o porquê e se pede confirmação no Cancelar, que
              APAGA os lançamentos desta tela (ação "Limpa Lancto Ocorr").
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PE = null;
  function botao(nome) {
    return [].filter.call(document.querySelectorAll('.t-Dialog-footer button, .t-ButtonRegion button'), function (b) {
      return limpo(b.textContent).toLowerCase().indexOf(nome) === 0;
    })[0] || null;
  }
  function ligarPe() {
    var proc = botao('processar'), canc = botao('cancelar');
    var reg = (proc || canc) && (proc || canc).closest('.t-ButtonRegion, .t-Dialog-footer');
    if (!reg) return;
    reg.classList.add('nc-lf-pe');
    var rodape = reg.closest('.t-Dialog-footer') || reg;
    var mede = function () { document.body.style.setProperty('--lf-pe', Math.ceil(rodape.getBoundingClientRect().height) + 'px'); };
    mede(); if (window.ResizeObserver) new ResizeObserver(mede).observe(rodape);
    PE = { reg: reg, proc: proc, canc: canc, msg: el('p', 'nc-lf-pe-msg') };
    PE.msg.setAttribute('role', 'status'); PE.msg.setAttribute('aria-live', 'polite');
    var dir = proc && proc.parentNode; if (dir) dir.insertBefore(PE.msg, proc);
    if (proc) { var sp = proc.querySelector('.t-Button-label') || proc; if (/Processar Lan/.test(sp.textContent)) sp.textContent = 'Processar lançamentos'; }
    if (canc) {
      var sc = canc.querySelector('.t-Button-label') || canc; if (limpo(sc.textContent) === 'Cancelar') sc.textContent = 'Sair sem processar';
      /* captura: a confirmação vem antes da ação da página (que apaga os lançamentos e fecha) */
      document.addEventListener('click', function (ev) {
        if (!ev.target.closest || ev.target.closest('button') !== canc || canc.__ncOk) return;
        var n = salvos(), pend = pendenteDeVerdade();
        if (!n && !pend) return;
        ev.preventDefault(); ev.stopImmediatePropagation();
        apex.message.confirm((n ? 'Sair sem processar? ' + (n === 1 ? 'O lançamento salvo será apagado' : 'Os ' + n + ' lançamentos salvos serão apagados') : 'Sair sem salvar? O que foi preenchido será apagado') + ' e não vai para a folha.', function (ok) {
          if (!ok) return; canc.__ncOk = true; canc.click(); setTimeout(function () { canc.__ncOk = false; }, 500);
        });
      }, true);
    }
    /* as caixas "Processar Demitidos?/Transferidos?" ganham explicação */
    [['P7_DEMITIDOS', 'Incluir desligados', 'Lança também para quem já foi desligado.'], ['P7_TRANSFERIDOS', 'Incluir transferidos', 'Lança também para quem foi transferido.']].forEach(function (x) {
      var c = $id(x[0] + '_CONTAINER') || ($id(x[0]) && $id(x[0]).closest('.t-Form-fieldContainer')); if (!c) return;
      c.classList.add('nc-lf-caixa');
      var lb = c.querySelector('.apex-item-option label'); if (lb && !lb.querySelector('.nc-lf-caixa-d')) lb.innerHTML = '<b>' + esc(x[1]) + '</b><span class="nc-lf-caixa-d">' + esc(x[2]) + '</span>';
    });
  }
  function desenharPe() {
    if (!PE || !PE.msg) return;
    var pend = pendenteDeVerdade(), n = salvos(), desl = PE.proc && (PE.proc.disabled || PE.proc.classList.contains('apex_disabled'));
    var t = '', tom = '';
    if (pend) { t = 'Salve o lançamento aberto para poder processar.'; tom = 'aviso'; }
    else if (!n) t = 'Salve pelo menos um lançamento para poder processar.';
    else if (!desl) { t = plural(n, 'lançamento pronto', 'lançamentos prontos') + ' para ir para a folha.'; tom = 'ok'; }
    else t = 'Salve os lançamentos para poder processar.';
    PE.msg.className = 'nc-lf-pe-msg' + (tom ? ' is-' + tom : '');
    if (PE.msg.textContent !== t) PE.msg.textContent = t;
  }

  /* ═══ [L11] PROCESSANDO E O RESULTADO (LOG) ═══════════════════════════════════════════════
     Processar (página): confirma → envia a página → ao voltar, P7_EXEC_PROCESSO = S roda o
     processamento. Sem erro: aviso de sucesso e a janela fecha. Com erro: a grade some e o LOG
     aparece (ações "Finaliza Execução Processo com Log"). Aqui: o aviso de espera e o LOG legível.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ESPERA = null;
  function ligarProcesso() {
    $('#P7_EXEC_PROCESSO').on('change', function () {
      if (item('P7_EXEC_PROCESSO') !== 'S') return;
      if (!ESPERA) {
        ESPERA = el('div', 'nc-lf-espera', '<div class="nc-lf-espera-caixa" role="status" aria-live="polite"><span class="nc-lf-roda" aria-hidden="true"></span>' +
          '<h3>Processando os lançamentos…</h3><p>Pode levar alguns minutos. Não feche esta janela.</p></div>');
        document.body.appendChild(ESPERA);
      }
      ESPERA.classList.add('is-visivel');
      $(document).one('ajaxStop', function () { setTimeout(function () { if (ESPERA) ESPERA.classList.remove('is-visivel'); }, 200); });
    });
    var logReg = [].filter.call(document.querySelectorAll('.t-Region'), function (r) { return /LOG Lan/i.test((r.querySelector('.t-Region-title') || {}).textContent || ''); })[0];
    if (!logReg) return;
    logReg.classList.add('nc-lf-log');
    var t = logReg.querySelector('.t-Region-title'); if (t) t.textContent = 'Alguns lançamentos não foram feitos';
    var hdr = logReg.querySelector('.t-Region-header');
    if (hdr && !logReg.querySelector('.nc-lf-log-exp')) hdr.parentNode.insertBefore(el('p', 'nc-lf-log-exp', 'O processamento terminou, mas os colaboradores abaixo ficaram de fora. Leia o motivo de cada um e, se precisar, fale com o RH. Para sair, toque em Fechar.'), hdr.nextSibling);
    var olhar = function () {
      var vis = logReg.offsetParent !== null && getComputedStyle(logReg).display !== 'none';
      document.body.classList.toggle('nc-lf-com-log', vis);
    };
    olhar();
    if (window.MutationObserver) new MutationObserver(olhar).observe(logReg, { attributes: true, attributeFilter: ['style', 'class'] });
    $('#P7_LOG_PROCESSO').on('change', function () { setTimeout(olhar, 50); });
  }

  /* ═══ [L12] TABELA (A GRADE ORIGINAL) ══════════════════════════════════════════════════════
     Para quem prefere digitar em linhas: o grid volta para a região, como sempre foi, em edição.
     A janela SEMPRE abre na Ficha (o modo do gestor); a Tabela vale só até fechar a janela.
     CUIDADO: o grid volta com a largura e a altura que tinha na ficha (~1050 px) e cortava as colunas
     depois de "Ocorrência" (09/10). grid('resize') da vista NÃO resolve; interactiveGrid('resize')
     resolve — chamado em dois tempos (o navegador pode ainda não ter assentado a região).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function vista(v) {
    var tabela = v === 'tabela';
    if (tabela === document.body.classList.contains('nc-lf-tabela')) return;
    if (tabela) {
      if (ESTADO.modo === 'editando') sincronizar();
      fecharVista();
      G.lugar.parentNode.insertBefore(G.ig, G.lugar);
      G.ig.classList.remove('nc-lf-motor');
      document.body.classList.add('nc-lf-tabela');
      ESTADO.modo = 'tabela';
      try { G.acoes.set('edit', true); } catch (e) { /* ok */ }
      var ajusta = function () { try { G.w.interactiveGrid('resize'); } catch (e) { /* ok */ } };
      requestAnimationFrame(ajusta); setTimeout(ajusta, 120); setTimeout(ajusta, 400);
    } else {
      FICHA_EL.querySelector('.nc-lf-fmotor').appendChild(G.ig);
      G.ig.classList.add('nc-lf-motor');
      document.body.classList.remove('nc-lf-tabela');
      var ls = lancamentos(), pend = ls.filter(function (l) { return l.mudou && !l.branco; })[0] || ls.filter(function (l) { return l.branco; })[0];
      if (pend) abrir(pend.id); else mostrarInicio();
    }
    desenhar();
  }

  /* ═══ [L13] O MAESTRO ══════════════════════════════════════════════════════════════════════ */
  var toast = null, tAviso = null;
  function avisar(t, erro) {
    if (!toast) { toast = el('div', 'nc-lf-aviso'); toast.setAttribute('role', 'status'); toast.setAttribute('aria-live', 'polite'); document.body.appendChild(toast); }
    toast.innerHTML = (erro ? ic('aviso') : ic('check')) + '<span>' + esc(t) + '</span>';
    toast.classList.toggle('is-erro', !!erro); toast.classList.add('is-visivel');
    clearTimeout(tAviso); tAviso = setTimeout(function () { toast.classList.remove('is-visivel'); }, 4200);
  }
  function desenhar() {
    try {
      var ls = lancamentos();
      if (ESTADO.modo === 'editando') estadoFicha();
      desenharLista(ls);
      desenharPassos(ls);
      desenharPe();
      var tab = document.body.classList.contains('nc-lf-tabela');
      [].forEach.call(TOPO_EL.querySelectorAll('[data-vista]'), function (b) { b.setAttribute('aria-pressed', String((b.getAttribute('data-vista') === 'tabela') === tab)); });
      if (ESTADO.modo === 'editando') { estadoFicha(); var h = FICHA_EL.querySelector('.nc-lf-ftit p'), l = ls.filter(function (x) { return x.id === ESTADO.rid; })[0]; if (h && l && !l.novo) h.textContent = l.mudou ? 'Alterado · falta salvar' : 'Salvo · pode corrigir e salvar de novo'; }
    } catch (e) { if (window.console) console.warn('Natcorp_LancFicha', e); }
  }
  var tDes = null;
  function depois() { clearTimeout(tDes); tDes = setTimeout(desenhar, 60); }
  function ligarMaestro() {
    try { G.m.subscribe({ onChange: depois }); } catch (e) { /* ok */ }
    $(G.reg).on('interactivegridsave', aoSalvar);
    $(G.reg).on('apexafterrefresh', function () {
      setTimeout(function () {
        try { G.m = G.v.model; } catch (e) { /* ok */ }
        try { G.m.subscribe({ onChange: depois }); } catch (e) { /* ok */ }
        if (!document.body.classList.contains('nc-lf-tabela') && ESTADO.modo === 'editando' && !registro(ESTADO.rid)) mostrarInicio();
        desenhar();
      }, 80);
    });
    $(document).on('apexerror', function () { if (ESTADO.ocupado) { ESTADO.ocupado = false; ocupado(false); recusado(); } });
    $('#P7_EXISTE').on('change', function () { setTimeout(desenharPe, 30); });
    /* a vista pode refazer o formulário (outro registro, erro do servidor): confere títulos e nomes */
    if (window.MutationObserver) {
      var tm = null;
      new MutationObserver(function () { clearTimeout(tm); tm = setTimeout(function () { if (ESTADO.modo === 'editando') { arrumarFicha(); estadoFicha(); } }, 40); })
        .observe(FICHA_EL.querySelector('.nc-lf-fmotor'), { childList: true, subtree: true });
    }
  }

  function comecar() {
    iniciar();
    if (!window.__ncLancFicha || !G || G.ligado) return;
    G.ligado = true;
    ligarMaestro();
    try { localStorage.removeItem('nc-lf-vista'); } catch (e) { /* ok: a 1ª versão guardava a escolha */ }
  }
  /* a Grade padrão fica de fora da IGOCORR (a lista e a ficha são deste desenho). Marcado já aqui:
     a Grade pode ligar antes do comecar() (19/10, quando ela passou a valer em toda página). */
  (function () { var r = $id('IGOCORR'); if (r) r.classList.add('nc-grade-nao'); })();
  /* depois das ações de abertura da página ("Edit Mode", "Atribui Existe", "Disable PROCESSA") */
  $(document).on('apexreadyend', function () { setTimeout(comecar, 0); });
  if (document.readyState === 'complete') setTimeout(comecar, 400);
  else window.addEventListener('load', function () { setTimeout(comecar, 400); });
})();
