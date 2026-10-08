/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · NORMAS E PROCEDIMENTOS  —  o "arrumador" das páginas (JavaScript)             ║
   ║  App 300 (Portal do Colaborador) · Página 56 (a lista) + Página 57 (a norma, janela)     ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia destas páginas: NORMAS-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   O colaborador vem aqui para ACHAR uma regra da empresa e LER com calma — quase sempre no
   celular, e muitos leem com dificuldade. Então:
     Página 56 (Normas e Procedimentos) vira um ÍNDICE, como o de um livrinho:
       • "Normas da empresa", uma frase do que fazer e uma busca grande (acha na hora, sem
         acento e sem maiúscula);
       • as normas agrupadas pelo assunto do título ("Folha de Pagamento - Férias" fica em
         "Folha de Pagamento"), cada uma com um desenho que ajuda a reconhecer o tema;
       • abreviações escritas por extenso (Pgto → Pagamento, Transf. → Transferência);
       • "Já leu" nas que a pessoa já abriu neste aparelho;
       • tocar abre a norma (o link original da linha, a janela da página 57).
     Página 57 (a janela da norma) vira uma página de LEITURA:
       • o nome da norma grande e quanto tempo leva para ler;
       • "Ouvir" (o celular lê a norma em voz alta) e "Letra maior";
       • o texto em partes: os títulos numerados ("1. OBJETIVO") viram títulos de verdade,
         os itens ("2.1 …") viram uma lista com o número ao lado; atalhos para cada parte;
       • "Entendi" fecha a janela.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada no sistema. Os dados vêm da própria página (o relatório da 56, o texto da
     57). "Já leu" e o tamanho da letra ficam só no aparelho da pessoa (localStorage).
     Tirou as URLs: volta o de antes.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Páginas 56 e 57 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Normas.js
     Páginas 56 e 57 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Normas.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [N1] Como as páginas são reconhecidas                                 CUIDADO
     [N2] Os textos, as abreviações e os desenhos por assunto              PODE MEXER
     [N3] Ferramentas
     [N4] 56 · lê as normas do relatório e agrupa
     [N5] 56 · o índice, a busca e "Já leu"
     [N6] 57 · lê o texto e separa em partes                               CUIDADO
     [N7] 57 · a página de leitura: Ouvir, Letra maior, Entendi
     [N8] O maestro
*/
(function () {
  'use strict';
  if (window.__ncNormas || !window.apex || !window.apex.jQuery) return;

  /* ═══ [N1] COMO AS PÁGINAS SÃO RECONHECIDAS ══════════════════════════════════════════════
     CUIDADO  57 = os itens P57_TEXTO_CONDUTA + P57_COD_TOPICO_CONDUTA.
              56 não tem itens: é o relatório cujo link da linha abre a página 57 com
              P57_COD_TOPICO_CONDUTA. O relatório é montado pelo JS dele DEPOIS deste arquivo:
              procurado na montagem, com novas tentativas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  function eh56() { return !!document.querySelector('.a-IRR td[headers] a[href*="P57_COD_TOPICO_CONDUTA"]'); }
  var PAG = $id('P57_TEXTO_CONDUTA') && $id('P57_COD_TOPICO_CONDUTA') ? 57 : 56;
  window.__ncNormas = true;
  var $ = window.apex.jQuery;

  /* ═══ [N2] OS TEXTOS, AS ABREVIAÇÕES E OS DESENHOS POR ASSUNTO ═══════════════════════════
     PODE MEXER  ABREV: o que se escreve por extenso no título. DESENHOS: a primeira regra que
                 achar a palavra no título dá o desenho (sem acento, minúsculas).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T = {
    titulo: 'Normas da empresa',
    frase: 'As regras do dia a dia. Toque num assunto para ler.',
    busca: 'Procure um assunto',
    buscaRotulo: 'Procurar uma norma',
    limpar: 'Limpar',
    quantas: function (n) { return n === 1 ? '1 norma' : n + ' normas'; },
    lidas: function (l, n) { return l === 0 ? '' : (l === n ? 'Você já leu todas.' : 'Você já leu ' + l + ' de ' + n + '.'); },
    jaLeu: 'Já leu',
    nada: function (q) { return 'Nada encontrado com "' + q + '". Tente outra palavra.'; },
    vazia: 'Ainda não há normas para ler.',
    outros: 'Outros assuntos',
    verTabela: 'Ver como tabela',
    verLista: 'Ver como lista',
    /* 57 */
    janela: 'Norma da empresa',
    leitura: function (min) { return min <= 1 ? 'Leitura de 1 minuto' : 'Leitura de cerca de ' + min + ' minutos'; },
    ouvir: 'Ouvir',
    parar: 'Parar',
    maior: 'Letra maior',
    menor: 'Letra menor',
    irPara: 'Ir para',
    entendi: 'Entendi',
    semTexto: 'Esta norma ainda não tem texto.'
  };
  var ABREV = [
    [/\bpg?to\b\.?|\bpagto\b\.?/gi, 'Pagamento'],
    [/\btransf\b\.?/gi, 'Transferência'],
    [/\bfunc\b\.?/gi, 'Funcionário'],
    [/\brh\b/gi, 'RH']
  ];
  /* palavras que o cadastro escreveu sem acento (a primeira letra segue a do cadastro) */
  var ACENTOS = { ferias: 'férias', frequencia: 'frequência', funcionarios: 'funcionários', funcionario: 'funcionário',
    predio: 'prédio', logistica: 'logística', taxi: 'táxi', servico: 'serviço', servicos: 'serviços', rescisao: 'rescisão',
    admissao: 'admissão', aplicacao: 'aplicação', orientacao: 'orientação', transferencia: 'transferência',
    medico: 'médico', saude: 'saúde', seguranca: 'segurança', conduta: 'conduta', uniformes: 'uniformes', etica: 'ética',
    horario: 'horário', horarios: 'horários', salario: 'salário', beneficios: 'benefícios', beneficio: 'benefício' };
  var DESENHOS = [
    [/ponto|marcac/, 'relogio'],
    [/frequenc|controle de|controde/, 'calendario'],
    [/ferias/, 'sol'],
    [/rescis|demiss|deslig/, 'saida'],
    [/admiss|contrata/, 'entrada'],
    [/transfer/, 'setas'],
    [/disciplin|advert|puni/, 'escudo'],
    [/predio|acesso|portaria|cracha/, 'predio'],
    [/taxi|transporte|veiculo|carro/, 'carro'],
    [/treinament|curso/, 'chapeu'],
    [/seguranc|epi\b|acidente/, 'escudo'],
    [/uniforme|roupa/, 'camisa']
  ];
  var IC = {
    livro: '<path d="M5 4.5h10.5A3.5 3.5 0 0 1 19 8v11.5H8.5A3.5 3.5 0 0 1 5 16z"/><path d="M5 16a3.5 3.5 0 0 1 3.5-3.5H19"/>',
    relogio: '<circle cx="12" cy="12" r="8.2"/><path d="M12 7.5V12l3 2"/>',
    calendario: '<rect x="4" y="5.5" width="16" height="14.5" rx="2"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4M8 14h2M12 14h2M8 17h2"/>',
    sol: '<circle cx="12" cy="12" r="3.8"/><path d="M12 3v2M12 19v2M3 12h2M19 12h2M5.6 5.6 7 7M17 17l1.4 1.4M5.6 18.4 7 17M17 7l1.4-1.4"/>',
    saida: '<path d="M10 4.5H6a1.5 1.5 0 0 0-1.5 1.5v12A1.5 1.5 0 0 0 6 19.5h4"/><path d="M14 8l4 4-4 4M18 12H9"/>',
    entrada: '<circle cx="10" cy="8.5" r="3.6"/><path d="M3.5 20c.8-3.5 3.3-5.5 6.5-5.5s5.7 2 6.5 5.5"/><path d="M18.5 7v6M15.5 10h6"/>',
    setas: '<path d="M4 8h15M15 4l4 4-4 4M20 16H5M9 12l-4 4 4 4"/>',
    escudo: '<path d="M12 3.5 5 6v5.5c0 4.2 2.9 7.6 7 9 4.1-1.4 7-4.8 7-9V6z"/><path d="M12 8.5v4.5M12 15.8v.1"/>',
    predio: '<path d="M5 20.5V5.5A1.5 1.5 0 0 1 6.5 4h7A1.5 1.5 0 0 1 15 5.5v15M15 10h3.5a1.5 1.5 0 0 1 1.5 1.5v9M3.5 20.5h17"/><path d="M8.5 8h3M8.5 11.5h3M8.5 15h3"/>',
    carro: '<path d="M5 16.5v-4l1.8-4.6A2 2 0 0 1 8.7 6.6h6.6a2 2 0 0 1 1.9 1.3l1.8 4.6v4"/><path d="M4 16.5h16v2H4zM5 12.5h14"/><circle cx="8" cy="18.5" r="1.4"/><circle cx="16" cy="18.5" r="1.4"/>',
    chapeu: '<path d="M2.5 9.5 12 5l9.5 4.5L12 14z"/><path d="M6.5 11.5V16c1.4 1.6 3.3 2.5 5.5 2.5s4.1-.9 5.5-2.5v-4.5M21.5 9.5V15"/>',
    camisa: '<path d="M8.5 4 4 6.5l1.8 4 2.2-1v10.5h8V9.5l2.2 1 1.8-4L15.5 4c-.6 1.4-1.9 2.3-3.5 2.3S9.1 5.4 8.5 4z"/>',
    lupa: '<circle cx="10.5" cy="10.5" r="6"/><path d="m15 15 5 5"/>',
    x: '<path d="M6 6l12 12M18 6 6 18"/>',
    seta: '<path d="m9 5 7 7-7 7"/>',
    ok: '<path d="m5 12.5 4.5 4.5L19 7.5"/>',
    som: '<path d="M4 9.5h3.5L12 5.5v13l-4.5-4H4z"/><path d="M15.5 9a4.2 4.2 0 0 1 0 6M18 6.5a7.8 7.8 0 0 1 0 11"/>',
    parar: '<rect x="6.5" y="6.5" width="11" height="11" rx="2"/>',
    letra: '<path d="M3.5 18 8 6l4.5 12M5.2 13.5h5.6"/><path d="M14.5 18l3-8 3 8M15.6 15.2h3.8"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M9 10v9"/>',
    lista: '<path d="M9 6.5h11M9 12h11M9 17.5h11"/><circle cx="4.8" cy="6.5" r="1.1"/><circle cx="4.8" cy="12" r="1.1"/><circle cx="4.8" cy="17.5" r="1.1"/>'
  };

  /* ═══ [N3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/\s+/g, ' ').trim(); }
  function sem(t) { return limpo(t).toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, ''); }
  function ic(n, cls) { return '<svg class="nc-nm-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || IC.livro) + '</svg>'; }
  var MIUDAS = /^(da|de|do|das|dos|e|em|na|no|a|o|ao|aos|as|os|por|para|com)$/;
  /* "Folha De Pgto" → "Folha de Pagamento"; "TREINAMENTO EXTERNO" → "Treinamento externo" */
  function bonito(t, frase) {
    t = limpo(t); if (!t) return t;
    ABREV.forEach(function (a) { t = t.replace(a[0], a[1]); });
    t = t.replace(/[A-Za-z]+/g, function (w) { var a = ACENTOS[w.toLowerCase()]; if (!a) return w; return w === w.toUpperCase() && w.length > 1 ? a.toUpperCase() : (w.charAt(0) === w.charAt(0).toUpperCase() ? a.charAt(0).toUpperCase() + a.slice(1) : a); });
    if (frase || t === t.toUpperCase()) { t = t.toLowerCase().replace(/\brh\b/g, 'RH'); return t.charAt(0).toUpperCase() + t.slice(1); }
    return t.replace(/[^\s\-\/().]+/g, function (w, i) { return i > 0 && MIUDAS.test(w.toLowerCase()) ? w.toLowerCase() : w; });
  }
  function desenhoDe(t) { var s = sem(t), d = DESENHOS.filter(function (x) { return x[0].test(s); })[0]; return d ? d[1] : 'livro'; }
  var CHAVE_LIDAS = 'nc-nm-lidas', CHAVE_TAM = 'nc-nm-tamanho', CHAVE_ABRINDO = 'nc-nm-abrindo';
  function lidas() { try { return JSON.parse(localStorage.getItem(CHAVE_LIDAS) || '[]'); } catch (e) { return []; } }
  function marcarLida(cod) { try { var l = lidas(); if (l.indexOf(cod) < 0) { l.push(cod); localStorage.setItem(CHAVE_LIDAS, JSON.stringify(l)); } } catch (e) { /* sem armazenamento */ } }

  /* ═══ [N4] 56 · LÊ AS NORMAS DO RELATÓRIO E AGRUPA ═══════════════════════════════════════
     O título "Assunto - Norma" (o hífen com ou sem espaços) separa o grupo do nome. Um grupo
     cujo nome é o começo de outro ("Folha" e "Folha de Pagamento") entra no maior. Título sem
     hífen fica em "Outros assuntos". A ordem é a do relatório (o código).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var IR, IRREG, CAIXA, NORMAS = [];
  function lerNormas() {
    var tb = [].slice.call(IR.querySelectorAll('.a-IRR-table')).sort(function (a, b) { return b.rows.length - a.rows.length; })[0];
    if (!tb) return [];
    var colT = '', colC = '';
    [].forEach.call(IR.querySelectorAll('th[id]'), function (th) { var s = sem(th.textContent); if (/^titulo|^descri/.test(s)) colT = th.id; if (/^codigo/.test(s)) colC = th.id; });
    return [].filter.call(tb.rows, function (tr) { return tr.querySelector('td[headers] a'); }).map(function (tr) {
      var a = tr.querySelector('td[headers] a');
      var tit = colT ? limpo((tr.querySelector('td[headers="' + colT + '"]') || {}).textContent) : '';
      var cod = colC ? limpo((tr.querySelector('td[headers="' + colC + '"]') || {}).textContent) : '';
      if (!cod) { var m = /P57_COD_TOPICO_CONDUTA:([^&'\\]+)/.exec(a.getAttribute('href') || ''); cod = m ? m[1] : ''; }
      var partes = tit.split(/\s*-\s*/).filter(Boolean);
      var grupo = partes.length > 1 ? bonito(partes[0]) : '';
      var nome = partes.length > 1 ? partes.slice(1).map(function (p) { return bonito(p); }).join(' · ') : bonito(tit);
      return { cod: cod, titulo: tit, grupo: grupo, nome: nome, desenho: desenhoDe(tit), link: a };
    });
  }
  function agrupar(lista) {
    var chaves = [];
    lista.forEach(function (n) { if (n.grupo && chaves.indexOf(n.grupo) < 0) chaves.push(n.grupo); });
    var para = {};
    chaves.forEach(function (k) {
      var maior = chaves.filter(function (o) { return o !== k && sem(o).indexOf(sem(k) + ' ') === 0; })[0];
      para[k] = maior || k;
    });
    var grupos = [], idx = {};
    lista.forEach(function (n) {
      var g = n.grupo ? para[n.grupo] : T.outros;
      n.grupoFinal = g;
      if (!(g in idx)) { idx[g] = grupos.length; grupos.push({ nome: g, itens: [] }); }
      grupos[idx[g]].itens.push(n);
    });
    /* "Outros assuntos" sempre no fim */
    grupos.sort(function (a, b) { return (a.nome === T.outros) - (b.nome === T.outros); });
    return grupos;
  }

  /* ═══ [N5] 56 · O ÍNDICE, A BUSCA E "JÁ LEU" ═════════════════════════════════════════════ */
  function itemHtml(n, i) {
    return '<li class="nc-nm-item" data-i="' + i + '" data-busca="' + esc(sem(n.titulo + ' ' + n.nome + ' ' + n.grupoFinal)) + '">' +
      '<button type="button" class="nc-nm-abrir" data-abrir="' + i + '">' +
        '<span class="nc-nm-desenho" aria-hidden="true">' + ic(n.desenho) + '</span>' +
        '<span class="nc-nm-nome">' + esc(n.nome) + '</span>' +
        '<span class="nc-nm-lida" hidden>' + ic('ok') + esc(T.jaLeu) + '</span>' +
        ic('seta', 'nc-nm-seta') +
      '</button></li>';
  }
  function desenhar() {
    NORMAS = lerNormas();
    var grupos = agrupar(NORMAS), varios = grupos.length > 1;
    var corpo = CAIXA.querySelector('.nc-nm-indice');
    if (!NORMAS.length) { corpo.innerHTML = '<p class="nc-nm-vazio">' + esc(T.vazia) + '</p>'; atualizarLidas(); return; }
    corpo.innerHTML = grupos.map(function (g) {
      return '<section class="nc-nm-grupo">' +
        (varios ? '<h3 class="nc-nm-grupo-tit">' + esc(g.nome) + ' <span>' + g.itens.length + '</span></h3>' : '') +
        '<ul class="nc-nm-lista">' + g.itens.map(function (n) { return itemHtml(n, NORMAS.indexOf(n)); }).join('') + '</ul></section>';
    }).join('') + '<p class="nc-nm-nada" hidden></p>';
    CAIXA.querySelector('.nc-nm-quantas').textContent = T.quantas(NORMAS.length);
    atualizarLidas();
    filtrar();
  }
  function atualizarLidas() {
    var l = lidas(), n = 0;
    [].forEach.call(CAIXA.querySelectorAll('.nc-nm-item'), function (li) {
      var x = NORMAS[+li.getAttribute('data-i')], foi = x && l.indexOf(x.cod) >= 0;
      li.classList.toggle('nc-nm-item--lida', foi);
      li.querySelector('.nc-nm-lida').hidden = !foi;
      if (foi) n++;
    });
    var p = CAIXA.querySelector('.nc-nm-progresso'); p.textContent = T.lidas(n, NORMAS.length); p.hidden = !n;
  }
  function filtrar() {
    var inp = CAIXA.querySelector('.nc-nm-busca input'), q = sem(inp.value), vistos = 0;
    var palavras = q.split(' ').filter(Boolean);
    [].forEach.call(CAIXA.querySelectorAll('.nc-nm-item'), function (li) {
      var b = li.getAttribute('data-busca'), ok = palavras.every(function (w) { return b.indexOf(w) >= 0; });
      li.hidden = !ok; if (ok) vistos++;
    });
    [].forEach.call(CAIXA.querySelectorAll('.nc-nm-grupo'), function (g) { g.hidden = !g.querySelector('.nc-nm-item:not([hidden])'); });
    var nada = CAIXA.querySelector('.nc-nm-nada');
    if (nada) { nada.hidden = vistos > 0 || !q; nada.textContent = T.nada(inp.value.trim()); }
    CAIXA.querySelector('.nc-nm-limpar').hidden = !q;
  }
  var CHAVE_MODO = 'nc-nm-modo';
  function modo(m) {
    try { localStorage.setItem(CHAVE_MODO, m); } catch (e) { /* sem armazenamento */ }
    document.body.classList.toggle('nc-nm-tabela', m === 'tabela');
    [].forEach.call(document.querySelectorAll('.nc-nm-modo'), function (b) { b.hidden = b.getAttribute('data-modo') === m; });
  }
  var montado = false;
  function iniciar56() {
    if (montado || !eh56()) return;
    IR = document.querySelector('.a-IRR');
    montado = true;
    try {
      document.body.classList.add('nc-nm-ativo');
      IRREG = IR.closest('.t-IRR-region, .t-Region') || IR.parentNode;
      CAIXA = el('div', 'nc-nm');
      CAIXA.innerHTML =
        '<header class="nc-nm-topo">' +
          '<h2 class="nc-nm-h1">' + esc(T.titulo) + '</h2>' +
          '<p class="nc-nm-frase">' + esc(T.frase) + '</p>' +
          '<label class="nc-nm-busca"><span class="nc-nm-sr">' + esc(T.buscaRotulo) + '</span>' + ic('lupa', 'nc-nm-lupa') +
            '<input type="search" enterkeyhint="search" autocomplete="off" placeholder="' + esc(T.busca) + '">' +
            '<button type="button" class="nc-nm-limpar" aria-label="' + esc(T.limpar) + '" hidden>' + ic('x') + '</button></label>' +
          '<p class="nc-nm-conta"><span class="nc-nm-quantas"></span><span class="nc-nm-progresso" hidden></span></p>' +
        '</header>' +
        '<div class="nc-nm-indice"></div>' +
        '<button type="button" class="nc-nm-modo" data-modo="tabela">' + ic('tabela') + '<span>' + esc(T.verTabela) + '</span></button>';
      IRREG.parentNode.insertBefore(CAIXA, IRREG);
      var volta = el('button', 'nc-nm-modo nc-nm-modo--volta', ic('lista') + '<span>' + esc(T.verLista) + '</span>'); volta.type = 'button'; volta.setAttribute('data-modo', 'lista');
      IRREG.parentNode.insertBefore(volta, IRREG);
      desenhar();
      var m = 'lista'; try { m = localStorage.getItem(CHAVE_MODO) || 'lista'; } catch (e) { /* padrão */ }
      modo(m);
      CAIXA.querySelector('.nc-nm-busca input').addEventListener('input', filtrar);
      $(document).on('apexafterrefresh', function (e) { if (IRREG.contains(e.target) || e.target === IRREG) desenhar(); });
      /* a janela fechou: atualiza o "Já leu" */
      $(window).on('apexafterclosedialog apexafterclosecanceldialog dialogclose', function () { setTimeout(atualizarLidas, 50); });
      document.addEventListener('click', function (e) {
        var md = e.target.closest('.nc-nm-modo'); if (md) { modo(md.getAttribute('data-modo')); return; }
        if (e.target.closest('.nc-nm-limpar')) { var i = CAIXA.querySelector('.nc-nm-busca input'); i.value = ''; filtrar(); i.focus(); return; }
        var a = e.target.closest('.nc-nm [data-abrir]');
        if (a) {
          var n = NORMAS[+a.getAttribute('data-abrir')]; if (!n || !n.link) return;
          /* a janela 57 não sabe o nome da norma: vai junto, só para este clique */
          try { sessionStorage.setItem(CHAVE_ABRINDO, JSON.stringify({ cod: n.cod, nome: n.nome, grupo: n.grupoFinal === T.outros ? '' : n.grupoFinal, desenho: n.desenho })); } catch (x) { /* sem armazenamento */ }
          n.link.click();
        }
      });
    } catch (e) { if (window.console) console.error('Natcorp_Normas', e); }
  }

  /* ═══ [N6] 57 · LÊ O TEXTO E SEPARA EM PARTES ════════════════════════════════════════════
     CUIDADO  o texto vem do jeito que foi digitado no cadastro. Reconhece:
              "ASSUNTO: X"            → some (o nome já está no alto);
              "1.<tab>OBJETIVO"       → título de parte (número + palavra em maiúsculas);
              "2.1<tab>Compete …"     → item numerado;
              linhas em branco        → separam parágrafos.
              Texto que não segue o formato fica em parágrafos, como veio.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function caixaAlta(t) { return t === t.toUpperCase() && /[A-ZÀ-Ú]{2}/.test(t); }
  function partesDoTexto(txt) {
    /* "¿" = travessão/apóstrofo que o banco não guardou (fora do Latin-1): " ¿ " → " – ", "Voucher¿s" → "Voucher's" */
    var limpoTxt = String(txt || '').replace(/\r/g, '').replace(/\s¿\s/g, ' – ').replace(/(\w)¿(\w)/g, "$1'$2").replace(/¿/g, '–');
    var blocos = limpoTxt.split(/\n\s*\n+/).map(function (b) { return b.replace(/[ \t]+/g, ' ').replace(/ ?\n ?/g, ' ').trim(); }).filter(Boolean);
    var assunto = '', partes = [], atual = { titulo: '', num: '', itens: [] };
    function novaParte(tit, num) { if (atual.titulo || atual.itens.length) partes.push(atual); atual = { titulo: bonito(tit, true), num: num || '', itens: [] }; }
    blocos.forEach(function (b) {
      var m;
      if (!partes.length && !atual.itens.length && !atual.titulo && (m = /^assunto\s*:\s*(.+)$/i.exec(b))) { assunto = m[1]; return; }
      /* "1. OBJETIVO" → título de parte numerado */
      if ((m = /^(\d+)\s*[.)\-–]?\s+(.{2,80})$/.exec(b)) && caixaAlta(m[2])) { novaParte(m[2], m[1]); return; }
      /* "INSTRUÇÕES DE USO" (curto, tudo maiúsculo) → título de parte sem número */
      if (b.length <= 80 && caixaAlta(b) && !/^\d/.test(b)) { novaParte(b, ''); return; }
      /* "2.1 Compete …" / "1 - Este serviço …" → item numerado */
      if ((m = /^(\d+(?:\.\d+)*)\s*[.)\-–]?\s+([\s\S]+)$/.exec(b))) { atual.itens.push({ n: m[1], t: m[2] }); return; }
      atual.itens.push({ n: '', t: b });
    });
    if (atual.titulo || atual.itens.length) partes.push(atual);
    return { assunto: assunto, partes: partes };
  }

  /* ═══ [N7] 57 · A PÁGINA DE LEITURA: OUVIR, LETRA MAIOR, ENTENDI ═════════════════════════ */
  var falando = false;
  function pararVoz() { try { window.speechSynthesis && speechSynthesis.cancel(); } catch (e) { /* sem voz */ } falando = false; }
  function falar(texto, aoFim) {
    var s = window.speechSynthesis; if (!s) return;
    pararVoz();
    /* em pedaços pequenos: o Chrome corta falas longas */
    var pedacos = texto.match(/[^.!?;:\n]+[.!?;:]?/g) || [texto];
    var voz = (s.getVoices() || []).filter(function (v) { return /^pt(-|_)BR/i.test(v.lang); })[0];
    falando = true;
    pedacos.forEach(function (p, i) {
      var u = new SpeechSynthesisUtterance(p.trim()); u.lang = 'pt-BR'; u.rate = .95; if (voz) u.voice = voz;
      if (i === pedacos.length - 1) u.onend = function () { falando = false; if (aoFim) aoFim(); };
      s.speak(u);
    });
  }
  var TAMANHOS = ['', 'nc-nm-t2', 'nc-nm-t3'];
  function iniciar57() {
    if (document.body.classList.contains('nc-nm-janela')) return;
    var campo = $id('P57_TEXTO_CONDUTA'), reg = campo && campo.closest('.t-Region'); if (!reg) return;
    var cod = limpo($id('P57_COD_TOPICO_CONDUTA').value);
    document.body.classList.add('nc-nm-janela');
    reg.classList.add('nc-nm-reg');
    var info = {}; try { info = JSON.parse(sessionStorage.getItem(CHAVE_ABRINDO) || '{}'); } catch (e) { info = {}; }
    if (String(info.cod) !== cod) info = {};
    var txt = campo.value != null ? campo.value : campo.textContent;
    var p = partesDoTexto(txt);
    var nome = info.nome || bonito(p.assunto, true) || T.janela;
    var palavras = limpo(txt).split(' ').filter(Boolean).length, min = Math.max(1, Math.round(palavras / 130));
    var temVoz = 'speechSynthesis' in window;
    var com = p.partes.filter(function (x) { return x.titulo; });

    var art = el('article', 'nc-nm-ler');
    art.innerHTML =
      '<header class="nc-nm-ler-topo">' +
        '<span class="nc-nm-desenho nc-nm-desenho--grande" aria-hidden="true">' + ic(info.desenho || desenhoDe(nome + ' ' + p.assunto)) + '</span>' +
        '<div><h2 class="nc-nm-ler-nome">' + esc(nome) + '</h2>' +
        '<p class="nc-nm-ler-sub">' + (info.grupo ? esc(info.grupo) + ' · ' : '') + esc(T.leitura(min)) + '</p></div>' +
      '</header>' +
      '<div class="nc-nm-ferramentas">' +
        (temVoz ? '<button type="button" class="nc-nm-ouvir" aria-pressed="false">' + ic('som') + '<span>' + esc(T.ouvir) + '</span></button>' : '') +
        '<button type="button" class="nc-nm-letra">' + ic('letra') + '<span>' + esc(T.maior) + '</span></button>' +
      '</div>' +
      (com.length >= 3 ? '<nav class="nc-nm-atalhos" aria-label="' + esc(T.irPara) + '"><span>' + esc(T.irPara) + '</span>' +
        com.map(function (x, i) { return '<a href="#nc-nm-p' + i + '">' + esc(x.titulo) + '</a>'; }).join('') + '</nav>' : '') +
      '<div class="nc-nm-texto">' +
        (p.partes.length ? p.partes.map(function (x) {
          var i = com.indexOf(x);
          return '<section class="nc-nm-parte"' + (i >= 0 ? ' id="nc-nm-p' + i + '"' : '') + '>' +
            (x.titulo ? '<h3>' + (x.num ? '<span aria-hidden="true">' + esc(x.num) + '</span>' : '') + esc(x.titulo) + '</h3>' : '') +
            x.itens.map(function (it) {
              return it.n ? '<p class="nc-nm-it"><b>' + esc(it.n) + '</b><span>' + esc(it.t) + '</span></p>' : '<p>' + esc(it.t) + '</p>';
            }).join('') + '</section>';
        }).join('') : '<p class="nc-nm-vazio">' + esc(T.semTexto) + '</p>') +
      '</div>' +
      '<button type="button" class="nc-nm-entendi">' + ic('ok') + '<span>' + esc(T.entendi) + '</span></button>';
    var corpo = reg.querySelector('.t-Region-body') || reg;
    corpo.insertBefore(art, corpo.firstChild);

    /* o título da janela (fica na página de cima) */
    try { var dlg = window.frameElement && window.frameElement.closest('.ui-dialog'), tt = dlg && dlg.querySelector('.ui-dialog-title'); if (tt) tt.textContent = T.janela; } catch (e) { /* outra origem */ }
    if (p.partes.length) marcarLida(cod);

    /* letra: 3 tamanhos, guardados no aparelho */
    var tam = 0; try { tam = +localStorage.getItem(CHAVE_TAM) || 0; } catch (e) { tam = 0; }
    function poeTam() {
      TAMANHOS.forEach(function (c) { if (c) art.classList.remove(c); });
      if (TAMANHOS[tam]) art.classList.add(TAMANHOS[tam]);
      art.querySelector('.nc-nm-letra span').textContent = tam === TAMANHOS.length - 1 ? T.menor : T.maior;
    }
    poeTam();
    art.addEventListener('click', function (e) {
      if (e.target.closest('.nc-nm-letra')) { tam = (tam + 1) % TAMANHOS.length; try { localStorage.setItem(CHAVE_TAM, tam); } catch (x) { /* sem armazenamento */ } poeTam(); return; }
      var ou = e.target.closest('.nc-nm-ouvir');
      if (ou) {
        var liga = function (on) { ou.setAttribute('aria-pressed', String(on)); ou.innerHTML = ic(on ? 'parar' : 'som') + '<span>' + esc(on ? T.parar : T.ouvir) + '</span>'; };
        if (falando) { pararVoz(); liga(false); return; }
        var falado = nome + '. ' + p.partes.map(function (x) { return (x.titulo ? x.titulo + '. ' : '') + x.itens.map(function (it) { return it.t; }).join(' '); }).join(' ');
        liga(true); falar(falado, function () { liga(false); });
        return;
      }
      var at = e.target.closest('.nc-nm-atalhos a');
      if (at) { e.preventDefault(); var alvo = document.getElementById(at.getAttribute('href').slice(1)); if (alvo) alvo.scrollIntoView({ behavior: 'smooth', block: 'start' }); return; }
      if (e.target.closest('.nc-nm-entendi')) {
        pararVoz();
        try { window.apex.navigation.dialog.cancel(true); } catch (x) { /* fora de janela: fica */ }
      }
    });
    window.addEventListener('pagehide', pararVoz);
    window.addEventListener('beforeunload', pararVoz);
  }

  /* ═══ [N8] O MAESTRO ═════════════════════════════════════════════════════════════════════ */
  var iniciar = PAG === 57 ? iniciar57 : iniciar56;
  $(window).one('apexreadyend', function () { setTimeout(iniciar, 0); });
  $(function () { setTimeout(iniciar, 800); setTimeout(iniciar, 3000); });
  if (document.readyState === 'complete') setTimeout(iniciar, 200);
})();
