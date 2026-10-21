/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · BENEFÍCIOS  —  o painel de indicadores (JavaScript)                            ║
   ║  App 200 · Página 164 (Consulta de Benefícios)                                            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: BENEFPAINEL-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Acima do relatório, um RESUMO com o que o DP de uma grande empresa não pode deixar de olhar.
   A página tem duas consultas ("Opção de Consulta"), e o resumo acompanha a que está na tela:
     COLABORADORES  Custo do mês (a última compra) · Com benefício · Recebem sem trabalhar
                    (afastados ou desligados com compra) · Benefício parado (aberto sem compra) ·
                    Terminam em 60 dias. Aberto: para onde vai o dinheiro, custo por centro de custo,
                    quem participa de cada benefício, maiores valores de VT e por pessoa, saúde.
     DEPENDENTES    Dependentes nos planos · Filhos com 21+ · Fazem 21 em 90 dias · CPF a corrigir ·
                    Saem do plano em 60 dias. Aberto: parentesco, idade, por plano, titulares.
   Tocar num número mostra QUEM são; tocar numa pessoa ou num benefício filtra a tabela.
   O painel nasce COMPACTO (só a faixa de números): a tabela é a função principal da página.
   Os números vêm do servidor (NC_BENEF_INDICADORES), com os MESMOS filtros e a MESMA segurança.
   Mesmo desenho dos painéis 200:16, 25 e 26: o CSS é o mesmo, gerado como Natcorp_BenefPainel.css
   a partir do Natcorp_Afastamentos.src.css.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 164 › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_BenefPainel.js
     Página 164 › CSS › File URLs:         #WORKSPACE_IMAGES#Natcorp_BenefPainel.css
     Página 164 › Processing › Ajax Callback NC_BENEF_INDICADORES   (aplicar-beneficios-pagina164.py)
   O COMBINADO com a página: Colaboradores = relatório "IR_1", Dependentes = "IR_4"; filtros P164_*.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [J1] Textos e ferramentas ............ frases, ícones, nomes                     PODE MEXER
     [J2] Os dados ........................ chamada ao servidor                        CUIDADO
     [J3] A moldura ....................... título, compacto/aberto
     [J4] Hoje ............................ a faixa de 5 números e a lista "quem são"  PODE MEXER
     [J5] A análise ....................... os quadros de cada consulta                PODE MEXER
     [J6] O começo
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncBenefPainel) return;
  window.__ncBenefPainel = true;
  /* a consulta na tela: o APEX só desenha o relatório da opção escolhida */
  function relatorio() { return document.getElementById('IR_1') || document.getElementById('IR_4'); }
  var RID = '';

  /* estes relatórios continuam com Tabela | Cartões (o Natcorp_Registros pula página com desenho
     próprio — esta tem — a não ser que o relatório venha marcado com nc-reg-sim) */
  function marcarRelatorio() { ['IR_1', 'IR_4'].forEach(function (id) { var ir = document.getElementById(id); if (ir) ir.classList.add('nc-reg-sim'); }); }
  marcarRelatorio();
  document.addEventListener('DOMContentLoaded', marcarRelatorio);

  /* ═══ [J1] TEXTOS E FERRAMENTAS ═════════════════════════════════════════════════════════ */
  var PROCESSO = 'NC_BENEF_INDICADORES';
  var ITENS = ['P164_OPCAO', 'P164_EMPRESA', 'P164_FILIAL', 'P164_CCUSTO', 'P164_UNIDADE_ADM', 'P164_ATIVIDADE', 'P164_MATRICULA_1',
               'P164_INDICE', 'P164_INDICE_N', 'P164_SITUACAO_1', 'P164_EMP', 'P164_MAT', 'P164_PESQUISA'];
  var POR_VEZ = 30;                       /* pessoas que a lista "quem são" mostra de cada vez */
  var POR_VEZ_Q = 6;                      /* linhas de cada quadro, de cada vez */
  var GUARDA = 'nc-bf-fechado';           /* '0' = a análise aberta (lembrado neste navegador) */
  var VALIDADE = 10 * 60 * 1000;         /* o resumo calculado vale 10 min nesta aba (mesmos filtros) */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];

  /* os 5 números de HOJE de cada consulta: a ordem é a ordem na tela. semLista = não abre lista */
  var HOJE = {
    C: [
      { k: 'custo',    cor: 'roxo',     ic: 'dinheiro', diz: 'Custo do mês', semLista: true },
      { k: 'pessoas',  cor: 'roxo',     ic: 'pessoas',  diz: 'Com benefício', semLista: true },
      { k: 'semtrab',  cor: 'vermelho', ic: 'alarme',   diz: 'Recebem sem trabalhar', alerta: true },
      { k: 'parados',  cor: 'ambar',    ic: 'pausa',    diz: 'Benefício parado', alerta: true },
      { k: 'terminam', cor: 'ambar',    ic: 'relogio',  diz: 'Terminam em 60 dias', alerta: true }
    ],
    D: [
      { k: 'dependentes', cor: 'roxo',     ic: 'familia', diz: 'Dependentes nos planos', semLista: true },
      { k: 'filhos21',    cor: 'vermelho', ic: 'alarme',  diz: 'Filhos com 21 anos ou mais', alerta: true },
      { k: 'fazem21',     cor: 'ambar',    ic: 'bolo',    diz: 'Fazem 21 anos em 90 dias', alerta: true },
      { k: 'cpf',         cor: 'ambar',    ic: 'duvida',  diz: 'CPF a corrigir', alerta: true },
      { k: 'encerram',    cor: 'ambar',    ic: 'relogio', diz: 'Saem do plano em 60 dias', alerta: true }
    ]
  };

  var IC = {
    tabela: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    descer: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    atualiza: '<path d="M20 11a8 8 0 0 0-14.6-4.5L4 8"/><path d="M4 4v4h4"/><path d="M4 13a8 8 0 0 0 14.6 4.5L20 16"/><path d="M20 20v-4h-4"/>',
    dinheiro: '<rect x="3" y="6.5" width="18" height="11" rx="2.5"/><circle cx="12" cy="12" r="2.6"/><path d="M6.5 9.5v5M17.5 9.5v5"/>',
    pessoas: '<circle cx="9" cy="8" r="3.2"/><path d="M3.5 19c.6-3.2 2.8-5 5.5-5s4.9 1.8 5.5 5"/><circle cx="17" cy="9" r="2.4"/><path d="M15.5 14.2c2.4.1 4.3 1.6 5 4.8"/>',
    familia: '<circle cx="8" cy="7" r="2.8"/><circle cx="16" cy="7" r="2.8"/><circle cx="12" cy="14.2" r="2"/><path d="M3.5 19c.4-3.4 2.2-5.4 4.5-5.4M20.5 19c-.4-3.4-2.2-5.4-4.5-5.4M8.6 20.5c.5-2 1.8-3.3 3.4-3.3s2.9 1.3 3.4 3.3"/>',
    alarme: '<circle cx="12" cy="13" r="7"/><path d="M12 9.5V13l2 1.5M5 4.5 3 6.5M19 4.5l2 2"/>',
    pausa: '<circle cx="12" cy="12" r="8.5"/><path d="M10 9v6M14 9v6"/>',
    relogio: '<rect x="4" y="5" width="16" height="15" rx="2.5"/><path d="M4 9.5h16M8.5 3v4M15.5 3v4"/><path d="M9 14h3v3"/>',
    bolo: '<path d="M4.5 20h15M5.5 20v-6.5a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2V20"/><path d="M5.5 15.5c1.2 1 2.4 1 3.6 0s2.4-1 3.6 0 2.4 1 3.6 0 1.6-.8 2.2-.4"/><path d="M12 11.5V8.5"/><path d="M12 4.5c.9 1 .9 2.1 0 3-.9-.9-.9-2 0-3z"/>',
    duvida: '<circle cx="12" cy="12" r="8.5"/><path d="M9.6 9.4a2.5 2.5 0 0 1 4.8.9c0 1.7-2.4 2-2.4 3.7"/><path d="M12 17h.01"/>',
    fechar: '<path d="M6 15l6-6 6 6"/>',
    abrir: '<path d="M6 9l6 6 6-6"/>',
    aviso: '<path d="M12 4 2.8 19.5h18.4z"/><path d="M12 10v4.5M12 17.2h.01"/>'
  };
  function ic(n) { return '<svg class="nc-af-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html != null) e.innerHTML = html; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function num(n) { return Number(n || 0).toLocaleString('pt-BR'); }
  function plural(n, um, varios) { return num(n) + ' ' + (Number(n) === 1 ? um : varios); }
  function reais(v) { return Number(v || 0).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL', maximumFractionDigits: 0 }); }
  function data(t) { var m = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function dias(a, b) { return Math.round((b - a) / 864e5); }
  function curta(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2); }
  function mesAno(d) { return d ? MESES[d.getMonth()] + '/' + d.getFullYear() : ''; }
  function semAcento(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase(); }
  /* "123 - Fulano De Tal" → ["123", "Fulano De Tal"] (o código fica, como no resto do sistema) */
  function partes(t) { var m = /^(\S+)\s+-\s+(.+)$/.exec(t || ''); return m ? [m[1], m[2]] : ['', t || '']; }
  /* os índices da página com nome de gente */
  var INDICE = { 'vale transporte': 'Vale-transporte', 'pacote de beneficios': 'Pacote de benefícios', 'plano medico': 'Plano médico',
                 'plano odontologico': 'Plano odontológico', 'previdencia': 'Previdência' };
  function indice(t) { return INDICE[semAcento(t).trim()] || bonito(t); }
  /* o cadastro vem em CAIXA ALTA: "REFEIÇÃO - MG" → "Refeição - MG" (siglas de 2 letras ficam) */
  var MIUDAS = { de: 1, da: 1, do: 1, das: 1, dos: 1, e: 1, em: 1, com: 1, para: 1, a: 1, o: 1 };
  function bonito(t) {
    /* palavra a palavra: só mexe na que está TODA em maiúsculas ("mai/2022" que o servidor junta fica) */
    return String(t || '').replace(/[^\s/()·,-]+/g, function (w, i) {
      if (w !== w.toUpperCase() || !/[A-ZÀ-Ý]/.test(w)) return w;
      var m = w.toLowerCase();
      if (/^[a-z]{2}$/.test(m) && !MIUDAS[m]) return w;
      if (i && MIUDAS[m]) return m;
      return m.charAt(0).toUpperCase() + m.slice(1);
    });
  }

  /* ═══ [J2] OS DADOS ═════════════════════════════════════════════════════════════════════
     CUIDADO  Os filtros vão com a chamada (pageItems) — os mesmos que o relatório usa.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function modo() { return (apex.item('P164_OPCAO').getValue() || 'C') === 'D' ? 'D' : 'C'; }
  function chaveCache() {
    return 'nc-bf-dados:' + ITENS.map(function (i) { return document.getElementById(i) ? (apex.item(i).getValue() || '') : ''; }).join('|');
  }
  /* CUIDADO  Os números de Colaboradores vêm da BI_BENEFICIOS, que o Pesquisar REGRAVA (a página
     recarrega com os mesmos filtros e outros dados). Por isso o guardado só vale quando a pessoa
     VOLTA à página (botão voltar); em toda carga nova, recalcula — senão aparecia o número antigo
     e, num segundo, o novo. */
  function voltou() {
    try { var n = performance.getEntriesByType('navigation')[0]; return !!n && n.type === 'back_forward'; } catch (e) { return false; }
  }
  function buscar(forcar) {
    var k = chaveCache(), c = null;
    try { c = JSON.parse(sessionStorage.getItem(k) || 'null'); } catch (e) { /* ok */ }
    if (!forcar && voltou() && c && c.d && Date.now() - c.t < VALIDADE) { desenhar(c.d, c.t); return; }
    carregando();
    var itens = ITENS.filter(function (i) { return document.getElementById(i); }).map(function (i) { return '#' + i; }).join(',');
    /* error próprio: sem ele o APEX abre o aviso vermelho dele além do nosso */
    apex.server.process(PROCESSO, { pageItems: itens }, { dataType: 'json', error: function () { /* tratado no .fail */ } })
      .done(function (d) {
        pararCalculo();
        if (!d || d.erro) return erro(d && d.erro);
        try { sessionStorage.setItem(k, JSON.stringify({ t: Date.now(), d: d })); } catch (e) { /* cheio ou bloqueado: só não guarda */ }
        try { desenhar(d, Date.now()); } catch (e) { erro(e && e.message); }
      })
      /* processo que não existe na página: o APEX responde 200 VAZIO (o JSON quebra sem texto) */
      .fail(function (x) { pararCalculo(); erro(x && (x.status === 404 || (x.status === 200 && !x.responseText)) ? 'processo ausente' : (x && x.responseText || '').slice(0, 160)); });
  }

  /* ═══ [J3] A MOLDURA ═══════════════════════════════════════════════════════════════════ */
  var P = null;   /* { caixa, corpo, quando, botao, dados, modo, filtro } */
  function montar() {
    if (P) return true;
    var ir = relatorio();
    if (!ir) return false;
    RID = ir.id;
    var m = modo();
    var caixa = el('section', 'nc-af nc-bf');
    caixa.setAttribute('aria-labelledby', 'nc-af-titulo');
    caixa.innerHTML =
      '<header class="nc-af-cab"><h2 id="nc-af-titulo">' + (m === 'D' ? 'Resumo dos dependentes nos planos' : 'Resumo dos benefícios') + '</h2>' +
      '<p class="nc-af-quando" aria-live="polite"></p><span class="nc-af-espaco"></span>' +
      '<button type="button" class="nc-af-bt" data-af-ir-tabela>' + ic('descer') + '<span>Ir para a tabela</span></button>' +
      '<button type="button" class="nc-af-bt" data-af-atualiza hidden>' + ic('atualiza') + '<span>Atualizar</span></button>' +
      '<button type="button" class="nc-af-bt" data-af-esconde aria-controls="nc-af-corpo"></button></header>' +
      '<div class="nc-af-corpo" id="nc-af-corpo"></div>';
    ir.parentNode.insertBefore(caixa, ir);
    P = { caixa: caixa, corpo: caixa.querySelector('.nc-af-corpo'), quando: caixa.querySelector('.nc-af-quando'), botao: caixa.querySelector('[data-af-esconde]'), modo: m, filtro: null };
    /* nasce COMPACTO (só a faixa de números; a tabela é a função principal): abre a análise quem pediu */
    var aberto = false; try { aberto = localStorage.getItem(GUARDA) === '0'; } catch (e) { /* ok */ }
    abrirFechar(aberto);
    caixa.addEventListener('click', clique);
    return true;
  }
  function abrirFechar(aberto) {
    P.caixa.classList.toggle('is-fechado', !aberto);
    P.botao.setAttribute('aria-expanded', String(aberto));
    P.botao.innerHTML = ic(aberto ? 'fechar' : 'abrir') + '<span>' + (aberto ? 'Mostrar menos' : 'Ver análise completa') + '</span>';
    try { if (aberto) localStorage.setItem(GUARDA, '0'); else localStorage.removeItem(GUARDA); } catch (e) { /* ok */ }
  }
  function clique(e) {
    var b = e.target.closest('button'); if (!b || !P.caixa.contains(b)) return;
    if (b.hasAttribute('data-af-esconde')) return abrirFechar(P.caixa.classList.contains('is-fechado'));
    if (b.hasAttribute('data-af-num')) {
      var k = b.getAttribute('data-af-num');
      P.filtro = P.filtro === k ? null : k;
      desenharHoje(); return;
    }
    if (b.hasAttribute('data-af-revela')) { revelar(b.previousElementSibling, +b.getAttribute('data-af-revela'), true); return; }
    if (b.hasAttribute('data-af-tabela')) { naTabela(b.getAttribute('data-af-tabela')); return; }
    if (b.hasAttribute('data-af-ir-tabela')) { irParaTabela(); return; }
    if (b.hasAttribute('data-af-tenta') || b.hasAttribute('data-af-atualiza')) buscar(true);
  }
  /* CALCULANDO: o painel ganha a faixa que corre no topo; o texto diz o que está fazendo (muda a cada
     4 s) e há quantos segundos — o número fica fora do aria-live (leitor de tela não repete a cada 1 s) */
  function calculando(passos) {
    var t0 = Date.now(), passo = -1;
    P.caixa.classList.add('is-calculando');
    P.caixa.setAttribute('aria-busy', 'true');
    function tique() {
      var s = Math.floor((Date.now() - t0) / 1000), i = Math.min(passos.length - 1, Math.floor(s / 4));
      if (i !== passo) { passo = i; P.quando.innerHTML = '<span class="nc-af-pulso" aria-hidden="true"></span>' + passos[i] + '<span class="nc-af-seg" aria-hidden="true" hidden></span>'; }
      var seg = P.quando.querySelector('.nc-af-seg'); if (seg && s >= 3) { seg.hidden = false; seg.textContent = s + ' s'; }
    }
    tique();
    return setInterval(tique, 1000);
  }
  function pararCalculo() {
    clearInterval(P.lento);
    P.caixa.classList.remove('is-calculando');
    P.caixa.removeAttribute('aria-busy');
  }
  /* CHEGOU: os números sobem e as barras crescem UMA vez (escolher um número depois não repete) */
  function chegou() {
    P.caixa.classList.add('is-novo');
    clearTimeout(P.novo);
    P.novo = setTimeout(function () { P.caixa.classList.remove('is-novo'); }, 1400);
  }
  function carregando() {
    var regua = HOJE[P.modo].map(function (h) {
      return '<div class="nc-af-num is-carregando"><span class="nc-af-sinal">' + ic(h.ic) + '</span>' +
        '<span class="nc-af-valor"><i class="nc-af-esq" style="width:56px;height:26px"></i></span><span class="nc-af-diz">' + h.diz + '</span></div>';
    }).join('');
    P.corpo.innerHTML = '<div class="nc-af-secao" aria-busy="true"><p class="nc-af-rot">Hoje</p><div class="nc-af-regua">' + regua + '</div></div>' +
      '<div class="nc-af-secao nc-af-periodo"><i class="nc-af-esq" style="width:60%;height:16px"></i><div class="nc-af-quadros" style="margin-top:14px">' +
      '<div class="nc-af-q" style="height:190px"></div><div class="nc-af-q" style="height:190px"></div><div class="nc-af-q" style="height:190px"></div></div></div>';
    P.quando.textContent = 'Calculando…';
    P.caixa.querySelector('[data-af-atualiza]').hidden = true;
    pararCalculo();
    P.lento = calculando(["Buscando os benefícios…", "Somando as compras do mês…", "Conferindo quem recebe…", "Ainda calculando: com muitos colaboradores leva mais tempo"]);
  }
  function erro(msg) {
    var falta = /processo ausente|ERR-1002|not found/i.test(msg || '');
    P.quando.textContent = '';
    P.corpo.innerHTML = '<div class="nc-af-aviso" role="alert">' + ic('aviso') + '<div><b>Não foi possível montar o resumo agora.</b>' +
      (falta ? 'Falta instalar nesta página o processo ' + PROCESSO + ' (veja o guia BENEFPAINEL-MANUTENCAO.md).'
             : 'A tabela abaixo continua funcionando. Tente de novo em instantes; se continuar, avise a equipe de sistemas.' + (msg ? ' <small>(' + esc(msg) + ')</small>' : '')) +
      '</div><span class="nc-af-espaco"></span><button type="button" class="nc-af-bt" data-af-tenta>Tentar de novo</button></div>';
  }

  /* ═══ [J4] HOJE ═════════════════════════════════════════════════════════════════════════ */
  function desenhar(d, quando) {
    pararCalculo();
    chegou();
    P.dados = d; P.hoje = data(d.hoje) || new Date(); P.ref = data(d.ref); P.filtro = null;
    ['semtrab', 'parados', 'terminam', 'fazem21', 'encerram', 'filhos21'].forEach(function (k) { (d[k] || []).forEach(function (p) { p.dA = data(p.a); }); });
    var hm = quando ? new Date(quando).toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }) : '';
    P.quando.innerHTML = (d.modo === 'C' && P.ref ? 'Compras de <b>' + mesAno(P.ref) + '</b>' : 'Hoje, <b>' + esc(d.hoje) + '</b>') +
      ' · com os filtros da página' + (hm ? ' · calculado às ' + hm : '');
    P.caixa.querySelector('[data-af-atualiza]').hidden = false;
    if (d.vazio) {
      P.corpo.innerHTML = '<div class="nc-af-aviso nc-qd-convite">' + ic('busca') + '<div><b>' +
        (d.modo === 'D' ? 'Nenhum dependente nos planos com estes filtros.' : 'Nenhum benefício na tabela com estes filtros.') + '</b>' +
        'Escolha os filtros ao lado e toque em Pesquisar: o resumo usa o mesmo resultado da tabela.</div></div>';
      return;
    }
    P.corpo.innerHTML =
      '<div class="nc-af-secao"><p class="nc-af-rot">Hoje</p><div class="nc-af-regua" role="group" aria-label="Os benefícios hoje"></div>' +
      '<div class="nc-af-quem" id="nc-af-quem" hidden aria-live="polite"></div></div>' +
      '<div class="nc-af-secao nc-af-periodo"></div>';
    desenharHoje();
    desenharAnalise();
  }
  /* o número grande e o que cada um diz embaixo (depende dos dados) */
  /* reais no quadrinho: até 100 mil inteiro; acima, "R$ 730 mil" / "R$ 10,7 milhões" (o exato vai
     no title e na frase da análise) — número grande cortado ninguém lê */
  function reaisCurto(v) {
    v = Number(v || 0);
    if (v >= 1e6) { var m = v / 1e6; return { v: 'R$ ' + m.toLocaleString('pt-BR', { maximumFractionDigits: m < 10 ? 2 : 1 }), u: m < 2 ? 'milhão' : 'milhões' }; }
    if (v >= 1e5) return { v: 'R$ ' + Math.round(v / 1e3).toLocaleString('pt-BR'), u: 'mil' };
    return { v: reais(v), u: '' };
  }
  function valorDe(h, a) {
    if (h.k === 'custo') return reaisCurto(a.custo);
    if (h.k === 'cpf' && !a.cpf_visivel) return { v: '—', u: '' };
    var v = Number(a[h.k] || 0);
    return { v: num(v), u: h.k === 'dependentes' ? (v === 1 ? 'pessoa' : 'pessoas') : v === 1 ? 'pessoa' : 'pessoas' };
  }
  function dicaDe(h, a) {
    var ref = mesAno(P.ref);
    switch (h.k) {
      case 'custo': return 'comprado em ' + ref + ' · ' + reais(a.custo / Math.max(1, a.compraram)) + ' por pessoa, em média';
      case 'pessoas': return num(a.vt) + ' com vale-transporte · ' + num(a.saude) + ' com plano de saúde';
      case 'semtrab': return a.semtrab ? reais(a.semtrab_valor) + ' comprados em ' + ref + ' para quem está afastado ou já saiu' : 'ninguém afastado ou desligado recebeu compra em ' + ref;
      case 'parados': return 'aberto no cadastro, mas sem compra desde antes de ' + ref + ': encerrar ou corrigir';
      case 'terminam': return 'benefícios com data de fim chegando: renovar ou avisar';
      case 'dependentes': return 'de ' + plural(a.titulares, 'titular', 'titulares') + ' · ' + (a.titulares ? (a.dependentes / a.titulares).toLocaleString('pt-BR', { maximumFractionDigits: 1 }) : 0) + ' por titular, em média';
      case 'filhos21': return 'confira se ainda têm direito ao plano (estudante, até 24 anos?)';
      case 'fazem21': return 'avise a família antes de o filho perder o plano';
      case 'cpf': return a.cpf_visivel ? 'sem CPF ou com dígito errado: o eSocial e a operadora recusam' : 'você não tem permissão para ver o CPF dos dependentes';
      case 'encerram': return 'adesão com data final chegando';
    }
    return '';
  }
  function desenharHoje() {
    var a = P.dados.agora || {};
    P.caixa.querySelector('.nc-af-regua').innerHTML = HOJE[P.dados.modo].map(function (h) {
      var vd = valorDe(h, a), v = Number(a[h.k] || 0), on = P.filtro === h.k, temLista = !h.semLista && v && !(h.k === 'cpf' && !a.cpf_visivel);
      /* alerta sem ninguém é notícia boa: o quadro fica verde, "Ninguém" */
      var zeroBom = h.alerta && !v && vd.v !== '—';
      return '<button type="button" class="nc-af-num nc-af-num--' + (zeroBom ? 'verde' : h.cor) + (v || h.semLista ? '' : ' is-zero') + (h.alerta && v ? ' is-alerta' : '') + '" data-af-num="' + h.k + '"' +
        ' aria-pressed="' + on + '" aria-controls="nc-af-quem"' + (temLista ? '' : ' disabled') + (h.k === 'custo' ? ' title="' + reais(a.custo) + '"' : '') + '>' +
        '<span class="nc-af-sinal">' + ic(h.ic) + '</span>' +
        '<span class="nc-af-valor' + (zeroBom || vd.v === '—' ? ' is-texto' : '') + '">' + (zeroBom ? 'Ninguém' : vd.v + (vd.u ? '<small>' + vd.u + '</small>' : '')) + '</span>' +
        '<span class="nc-af-diz">' + h.diz + '</span><span class="nc-af-dica">' + dicaDe(h, a) + '</span></button>';
    }).join('');
    desenharLista();
  }
  /* cada lista: título, a ordem e o que vai no meio e no selo do fim da linha */
  var LISTA = {
    semtrab: { tit: 'Recebem sem trabalhar', ordem: 'o maior valor primeiro',
      det: function (p) { return [esc(p.t) + (p.dA ? ' · desde ' + mesAno(p.dA) : ''), '<span class="nc-af-volta nc-af-volta--atrasada">' + reais(p.v) + ' no mês</span>']; } },
    parados: { tit: 'Benefício parado', ordem: 'parado há mais tempo primeiro',
      det: function (p) { return [esc(bonito(p.t)), '<span class="nc-af-volta nc-af-volta--sem">Sem compra desde ' + mesAno(p.dA) + '</span>']; } },
    terminam: { tit: 'Terminam em 60 dias', ordem: 'o fim mais perto primeiro',
      det: function (p) { var n = dias(P.hoje, p.dA); return [esc(bonito(p.t)), '<span class="nc-af-volta nc-af-volta--sem">' + (n === 0 ? 'Termina hoje' : 'Termina em ' + plural(n, 'dia', 'dias')) + ' · ' + curta(p.dA) + '</span>']; } },
    filhos21: { tit: 'Filhos com 21 anos ou mais no plano', ordem: 'o mais velho primeiro',
      det: function (p) { return [esc(p.t), '<span class="nc-af-volta nc-af-volta--atrasada">Conferir o direito</span>']; } },
    fazem21: { tit: 'Fazem 21 anos nos próximos 90 dias', ordem: 'o aniversário mais perto primeiro',
      det: function (p) { var n = dias(P.hoje, p.dA); return [esc(p.t), '<span class="nc-af-volta nc-af-volta--sem">' + (n === 0 ? 'Hoje' : 'Em ' + plural(n, 'dia', 'dias')) + ' · ' + curta(p.dA) + '</span>']; } },
    cpf: { tit: 'CPF a corrigir', ordem: 'por titular',
      det: function (p) { return [esc(p.t), '<span class="nc-af-volta nc-af-volta--sem">Corrigir o CPF</span>']; } },
    encerram: { tit: 'Saem do plano em 60 dias', ordem: 'a saída mais perto primeiro',
      det: function (p) { var n = dias(P.hoje, p.dA); return [esc(bonito(p.t)), '<span class="nc-af-volta nc-af-volta--sem">' + (n === 0 ? 'Sai hoje' : 'Sai em ' + plural(n, 'dia', 'dias')) + ' · ' + curta(p.dA) + '</span>']; } }
  };
  function desenharLista() {
    var box = P.caixa.querySelector('.nc-af-quem');
    if (!P.filtro || !LISTA[P.filtro]) { box.hidden = true; box.innerHTML = ''; return; }
    var c = LISTA[P.filtro];
    listaPessoas(box, c.tit, c.ordem, P.dados[P.filtro], c.det, Number((P.dados.agora || {})[P.filtro] || 0));
  }
  /* uma lista "quem são": busca, rolagem, ver na tabela */
  function listaPessoas(box, titulo, ordem, lista, det, tot) {
    var ps = (lista || []).slice();
    box.hidden = false;
    box.innerHTML = '<div class="nc-af-quem-cab"><h3>' + titulo + ': ' + plural(tot, 'pessoa', 'pessoas') + '</h3><p>' + ordem + ' · toque numa pessoa para ver na tabela</p>' +
      (ps.length > 12 ? '<label class="nc-af-procura">' + ic('busca') + '<span class="nc-af-vis">Procurar nesta lista</span><input type="search" placeholder="Procurar nome ou centro de custo" data-af-procura autocomplete="off"></label>' : '') + '</div>' +
      rolo('ul', 'nc-af-lista', ps.map(function (p) { return linhaPessoa(p, det(p)); }), POR_VEZ, 'pessoas') +
      (tot > ps.length ? '<p class="nc-af-nota">A lista mostra ' + num(ps.length) + ' de ' + num(tot) + ' pessoas. Use os filtros da página para ver menos de cada vez.</p>' : '');
    ligarRolos(box);
    var pr = box.querySelector('[data-af-procura]');
    if (pr) pr.addEventListener('input', function () { procurar(box, pr.value); });
  }
  function linhaPessoa(p, dt) {
    return '<li data-af-texto="' + esc(semAcento([p.n, p.s, p.t].join(' '))) + '"><button type="button" class="nc-af-p nc-fp-p" data-af-tabela="' + esc(p.q || p.n) + '" title="Ver ' + esc(partes(p.n)[1]) + ' na tabela">' +
      '<span class="nc-af-p-quem"><b>' + esc(p.n) + '</b><span>' + esc(p.s || '') + '</span></span>' +
      '<span class="nc-af-p-tipo">' + dt[0] + '</span>' + dt[1] + '<span class="nc-af-p-ir" aria-hidden="true">' + ic('tabela') + '</span></button></li>';
  }
  /* a busca da lista: mostra só quem bate (todas as linhas, sem o "de pouco em pouco") */
  function procurar(box, q) {
    var r = box.querySelector('.nc-af-rolo'), lis = r.querySelectorAll('li'), t = semAcento(q.trim()), n = 0;
    if (!t) { desenharLista(); var p2 = P.caixa.querySelector('[data-af-procura]'); if (p2) p2.focus(); return; }
    [].forEach.call(lis, function (li) { var ok = li.getAttribute('data-af-texto').indexOf(t) >= 0; li.hidden = !ok; if (ok) n++; });
    var bt = r.nextElementSibling; if (bt && bt.hasAttribute('data-af-revela')) bt.hidden = true;
    var nada = r.querySelector('.nc-af-nada'); if (nada) nada.remove();
    if (!n) r.insertAdjacentHTML('beforeend', '<p class="nc-af-nada">Ninguém nesta lista com “' + esc(q.trim()) + '”.</p>');
  }

  /* ═══ LISTAS QUE VÃO APARECENDO ═════════════════════════════════════════════════════════
     Cada lista mora numa caixa de altura máxima (.nc-af-rolo) que rola por dentro. Mostra as
     primeiras N linhas; perto do fim da caixa aparecem as próximas sozinhas; o botão embaixo diz
     quantas faltam (para quem prefere tocar, ou usa o teclado).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function rolo(tag, cls, itens, passo, unid) {
    return '<div class="nc-af-rolo" data-af-unid="' + unid + '"><' + tag + ' class="' + cls + '">' +
      itens.map(function (h, i) { return i < passo ? h : h.replace(/^<li/, '<li hidden'); }).join('') +
      '</' + tag + '><span class="nc-af-sentinela" aria-hidden="true"></span></div>' +
      (itens.length > passo ? '<button type="button" class="nc-af-mais" data-af-revela="' + passo + '"></button>' : '');
  }
  function escondidos(r) { return r.querySelectorAll('li[hidden]:not(.is-filtrado)'); }
  function revelar(r, passo, foco) {
    var es = [].slice.call(escondidos(r), 0, passo);
    es.forEach(function (li) { li.hidden = false; });
    if (foco && es[0]) { var b = es[0].querySelector('button'); (b || es[0]).focus({ preventScroll: true }); es[0].scrollIntoView({ block: 'nearest', behavior: 'smooth' }); }
    contar(r);
  }
  function contar(r) {
    var bt = r.nextElementSibling; if (!bt || !bt.hasAttribute('data-af-revela')) return;
    var falta = escondidos(r).length, passo = +bt.getAttribute('data-af-revela'), u = r.getAttribute('data-af-unid');
    bt.hidden = !falta;
    bt.textContent = 'Mostrar mais ' + Math.min(passo, falta) + ' · ' + (falta === 1 ? 'falta 1' : 'faltam ' + num(falta)) + ' ' + (u === 'pessoas' ? (falta === 1 ? 'pessoa' : 'pessoas') : (falta === 1 ? 'linha' : 'linhas'));
  }
  function ligarRolos(raiz) {
    [].forEach.call(raiz.querySelectorAll('.nc-af-rolo'), function (r) {
      contar(r);
      var bt = r.nextElementSibling, passo = bt && bt.hasAttribute('data-af-revela') ? +bt.getAttribute('data-af-revela') : 0;
      if (!passo || !window.IntersectionObserver) return;
      var io = new IntersectionObserver(function (es) { if (es[0].isIntersecting && escondidos(r).length) revelar(r, passo); }, { root: r, rootMargin: '0px 0px 60px 0px' });
      io.observe(r.querySelector('.nc-af-sentinela'));
    });
  }

  /* ═══ VER NA TABELA ═════════════════════════════════════════════════════════════════════
     Tocar num benefício, num centro de custo ou numa pessoa usa a PRÓPRIA busca do relatório
     (campo + "Ir"): a tabela fica só com aquilo, com o filtro à vista e o × para tirar.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function naTabela(texto) {
    var f = document.getElementById(RID + '_search_field'), b = document.getElementById(RID + '_search_button');
    if (!f || !b) return irParaTabela();
    P.quando.textContent = 'Filtrando a tabela…';
    irParaTabela();
    var t0 = Date.now();
    /* o relatório ainda carregando PERDE o clique na busca: espera a página ficar livre (até 8 s) */
    (function quandoLivre() {
      if (apex.jQuery.active > 0 && Date.now() - t0 < 8000) return setTimeout(quandoLivre, 120);
      f.value = texto;
      b.click();
      P.quando.innerHTML = 'A tabela abaixo agora mostra só <b>' + esc(texto) + '</b>. Para ver tudo de novo, toque no <b>×</b> do filtro, em cima da tabela.';
    })();
  }
  function irParaTabela() {
    var ir = document.getElementById(RID); if (!ir) return;
    ir.scrollIntoView({ behavior: window.matchMedia && matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth', block: 'start' });
  }

  /* ═══ [J5] A ANÁLISE ════════════════════════════════════════════════════════════════════ */
  function desenharAnalise() {
    var per = P.caixa.querySelector('.nc-af-periodo');
    per.innerHTML = P.dados.modo === 'D' ? analiseDependentes(P.dados) : analiseColaboradores(P.dados);
    ligarRolos(per);
  }
  function analiseColaboradores(d) {
    var a = d.agora || {}, ref = mesAno(P.ref);
    var frase = '<p class="nc-af-frase">Em <b>' + ref + '</b> foram comprados <b>' + reais(a.custo) + '</b> em benefícios para <b>' + plural(a.compraram, 'pessoa', 'pessoas') + '</b>: ' +
      'em média <b>' + reais(a.custo / Math.max(1, a.compraram)) + '</b> por pessoa.' +
      '<span class="nc-af-taxa">Planos de saúde e seguros não entram nessa conta: o custo deles vem na fatura da operadora.</span></p>';
    var fam = (d.familias || []).map(function (x) { var p = partes(x.t); return { t: p[0] + ' - ' + bonito(p[1]), k: x.k, q: x.q, n: x.n }; });
    var ade = (d.adesao || []).map(function (x) { return { t: indice(x.t), q: x.q }; });
    var sau = (d.saude || []).map(function (x) { var i = x.t.indexOf(': '); return { t: indice(x.t.slice(0, i)) + ': ' + bonito(x.t.slice(i + 2)), q: x.q }; });
    return frase + '<div class="nc-af-quadros nc-af-quadros--3">' +
      quadro('Para onde vai o dinheiro', 'Cada benefício comprado em ' + ref + ' · toque para ver na tabela', fam.length ? barrasValor(fam, a.custo) : '<p class="nc-af-vazio-q">Nenhuma compra no mês.</p>') +
      quadro('Custo por centro de custo', 'Quanto cada setor recebeu em ' + ref + ' · toque para ver na tabela', (d.setores || []).length ? barrasValor(d.setores, a.custo) : '<p class="nc-af-vazio-q">Nenhuma compra no mês.</p>') +
      quadro('Quem participa de cada benefício', 'Pessoas com o benefício em vigor, de ' + plural(a.pessoas, 'pessoa', 'pessoas') + ' na tabela', fixas(ade, a.pessoas, 'pessoa', 'pessoas')) +
      quadro('Vale-transporte: os maiores valores', 'Por pessoa no mês · valor alto pede conferir o endereço e o trajeto', pessoasValor(d.vtmaior, function (p) { return esc(p.t || ''); })) +
      quadro('Quem tem o maior custo', 'Soma de todos os benefícios comprados para a pessoa no mês', pessoasValor(d.pessoamaior, function () { return ''; })) +
      quadro('Planos de saúde por operadora', 'Pessoas com plano em vigor (titulares)', sau.length ? fixas(sau, a.saude, 'pessoa', 'pessoas') : '<p class="nc-af-vazio-q">Ninguém com plano de saúde em vigor nesta tabela.</p>') +
      '</div>';
  }
  function analiseDependentes(d) {
    var a = d.agora || {};
    var frase = '<p class="nc-af-frase"><b>' + plural(a.dependentes, 'dependente está', 'dependentes estão') + '</b> nos planos, de <b>' + plural(a.titulares, 'titular', 'titulares') + '</b>.' +
      '<span class="nc-af-taxa">Filho que completa 21 anos costuma sair do plano, a não ser que estude (até 24) ou seja inválido: confira o contrato da operadora.</span></p>';
    var pla = (d.planos || []).map(function (x) { var i = x.t.indexOf(': '); return { t: indice(x.t.slice(0, i)) + ': ' + bonito(x.t.slice(i + 2)), q: x.q }; });
    return frase + '<div class="nc-af-quadros nc-af-quadros--3">' +
      quadro('Parentesco', 'Quem são os dependentes', fixas(d.parentesco, a.dependentes, 'dependente', 'dependentes')) +
      quadro('Idade dos dependentes', 'Por faixa de idade', fixas((d.idade || []).map(function (x) { return { t: x.t.replace(/^[A-Z]\s*\(\s*(.+?)\s*\)$/, '$1 anos'), q: x.q }; }), a.dependentes, 'dependente', 'dependentes')) +
      quadro('Por plano', 'Dependentes em cada plano', fixas(pla, a.dependentes, 'dependente', 'dependentes')) +
      quadro('Titulares com mais dependentes', 'Toque para ver na tabela', pessoasValor(d.titulares, function () { return ''; }, function (v) { return plural(v, 'dependente', 'dependentes'); })) +
      '</div>';
  }
  function quadro(tit, dica, corpo, cls) { return '<section class="nc-af-q' + (cls ? ' ' + cls : '') + '"><h3>' + tit + '</h3><p>' + dica + '</p>' + corpo + '</section>'; }
  /* pessoas com um valor (maiores custos, titulares): a linha toda filtra a tabela por ela */
  function pessoasValor(xs, meio, fmt) {
    xs = xs || [];
    if (!xs.length) return '<p class="nc-af-vazio-q">Ninguém nesta lista.</p>';
    return rolo('ul', 'nc-af-lista', xs.map(function (p) {
      return linhaPessoa(p, [meio(p), '<span class="nc-af-volta">' + (fmt ? fmt(p.v) : reais(p.v)) + '</span>']);
    }), POR_VEZ_Q, 'pessoas');
  }
  /* barras de VALOR: reais, % do total, pessoas; toque = ver na tabela */
  function barrasValor(xs, total) {
    var max = Math.max.apply(null, xs.map(function (x) { return x.q; })) || 1;
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var p = partes(x.t), pct = total ? Math.round(x.q / total * 100) : null;
      return '<li><button type="button" class="nc-af-b' + (i === 0 ? ' is-maior' : '') + '" data-af-tabela="' + esc(x.k || x.t) + '" title="Ver ' + esc(x.t) + ' na tabela">' +
        '<span class="nc-af-b-nome">' + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1]) + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(x.q / max * 100)) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + reais(x.q) + ' <small>· ' + (pct < 1 ? '&lt;1' : pct) + '% · ' + plural(x.n, 'pessoa', 'pessoas') + '</small></span>' +
        '<span class="nc-af-b-ir" aria-hidden="true">Ver na tabela' + ic('tabela') + '</span></button></li>';
    }), POR_VEZ_Q, 'linhas');
  }
  /* barras SÓ DE LEITURA: número, % do total; a maior em destaque */
  function fixas(xs, total, um, varios) {
    xs = xs || [];
    if (!xs.length) return '<p class="nc-af-vazio-q">Sem informação.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return x.q; })) || 1;
    return rolo('ol', 'nc-af-barras', xs.map(function (x) {
      var pct = total ? Math.round(x.q / total * 100) : 0;
      return '<li><div class="nc-af-b nc-af-b--fixa' + (x.q === max ? ' is-maior' : '') + '" title="' + esc(x.t) + '"><span class="nc-af-b-nome">' + esc(x.t) + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(x.q / max * 100)) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + (pct < 1 ? '&lt;1' : pct) + '% <small>· ' + plural(x.q, um, varios) + '</small></span></div></li>';
    }), 8, 'linhas');
  }

  /* ═══ [J6] O COMEÇO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() { if (window.__ncBenefIniciou) return; if (montar()) { window.__ncBenefIniciou = true; buscar(); } }
  window.__ncBenefDesenhar = function (d) { if (montar()) desenhar(d); };   /* para conferir o desenho com dados de teste */
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).one('apexreadyend', iniciar);
    if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  }
})();
