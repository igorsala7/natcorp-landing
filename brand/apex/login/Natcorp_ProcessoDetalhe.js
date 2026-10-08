/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · PROCESSO SELETIVO (DETALHE)  —  o "arrumador" da tela (JavaScript)            ║
   ║  App 9113 (Recrutamento e Seleção) · Página 29 ("Descrição da Vaga")                     ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia desta página: PROCESSODETALHE-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Onde o recrutador conduz o processo seletivo: vê os candidatos, muda de fase, inclui
   candidato, abre CV, manda e-mail/WhatsApp. Antes: a vaga numa coluna lateral fixa, as
   etapas em cartões soltos (que não filtravam nada) e uma tabela de 26 colunas em que o NOME
   aparecia só no meio, depois de quatro colunas de ícones. Agora:
     • a FICHA DA VAGA no alto (situação, empresa, filial, centro de custo, selecionador,
       ativa desde, prazo de contratação com contagem, publicação) com as ações (Detalhes da
       vaga, Requisição, Anotações das fases, Processo seletivo, Finalizar processo) — a coluna
       lateral sai e os candidatos ganham a largura toda;
     • o FUNIL das etapas ("Todos 29 › Triagem inicial 26 › …"): tocar numa etapa filtra a
       lista;
     • UM CANDIDATO POR LINHA: nome, código, interno/externo, idade, sexo, localidade, último
       cargo e instrução; a etapa e a data; a nota (estrelas); os sinais (aprovado, faltam
       documentos, restrição de admissão, PCD, abaixo da nota de corte); os atalhos CV, e-mail,
       WhatsApp, LinkedIn e abrir o candidato;
     • a BARRA DE SELEÇÃO: "3 selecionados · Mudar fase · Limpar".
     • Lista | Tabela: a Tabela é o relatório interativo original, inteiro.
     • SINAIS QUE FILTRAM ("Faltam documentos 26", "Aprovados na etapa 3"…) e ORDENAR
       (etapa, nome, atualização, nota);
     • MAIS SOBRE O CANDIDATO: tocar na linha abre contato (e-mail e celular com copiar),
       perfil (nascimento, dependentes…) e a situação no processo — tudo o que o relatório traz;
     • as janelas MUDANÇA DE FASE (mostra quem vai mudar; "Aprovar" corrigido) e INCLUIR.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Nada é gravado por ele. Os dados são LIDOS do relatório "Relação de Candidatos - IR"
     (partnersIRR), da região "Descrição da Vaga" e dos cartões de etapa. A caixa de cada
     candidato é a ORIGINAL (.checkbox_item — o código da página grava a seleção no servidor e
     mostra o "Mudar Fase"); os atalhos são os links originais; os botões são os originais.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 29 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_ProcessoDetalhe.js
     Página 29 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_ProcessoDetalhe.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [D1]  As colunas do relatório (pelo título)                          CUIDADO
     [D2]  Ferramentas
     [D3]  A ficha da vaga
     [D4]  O funil das etapas
     [D5]  Ler os candidatos                                              CUIDADO
     [D6]  Desenhar os candidatos
     [D7]  Seleção (a caixa original) e a barra
     [D8]  O maestro
     [D9]  Sinais que filtram, ordem e "mais sobre o candidato"          PODE MEXER
     [D10] As janelas Mudança de fase e Incluir candidato                CUIDADO
*/
(function () {
  'use strict';
  if (window.__ncProcessoDetalhe || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [D1] AS COLUNAS DO RELATÓRIO ═══════════════════════════════════════════════════════
     CUIDADO  Cada célula traz no "headers" o ID da coluna (C5236…), não o nome; o nome é o
              título do cabeçalho. A lista liga o título (sem acento, minúsculo) ao campo.
              Coluna que a pessoa escondeu no relatório (Ações › Colunas) só não aparece.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var COLUNAS = {
    'link': 'link', 'selecione': 'sel', 'cv': 'cv', 'linkedin': 'linkedin', 'enviar e-mail': 'email', 'whatsapp': 'whats',
    'restricao admissao': 'restricao', 'nome': 'nome', 'cod. candidato': 'cod', 'tipo candidato': 'tipo', 'pontuacao': 'nota',
    'fase': 'fase', 'data atualizacao': 'dAtual', 'data da fase': 'dFase', 'idade': 'idade', 'sexo': 'sexo', 'pcd': 'pcd',
    'localidade': 'local', 'ultimo cargo': 'cargo', 'grau instrucao': 'instrucao', 'aprovado': 'aprovado',
    'status candidato': 'status', 'documentos': 'docs', 'e-mail': 'mail', 'genero': 'genero',
    'data nascimento': 'nasc', 'possui dependente': 'dep', 'selecionador': 'selec', 'avaliacao': 'aval',
    'motivo avaliacao': 'motivo', 'data avaliacao': 'dAval', 'resultado fase': 'resultado', 'aprovado na fase': 'aprovFase',
    'usuario': 'usuario'
  };
  var SITUACAO_VAGA = { publicada: 'publicada', aberta: 'aberta', prevista: 'prevista', fechada: 'fechada', cancelada: 'cancelada', reprovada: 'reprovada' };

  /* ═══ [D2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function sem(t) { return String(t || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/\s+/g, ' ').trim(); }
  function nome(t) {
    return String(t || '').toLowerCase().replace(/(^|[\s'(/-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); })
      .replace(/\s(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  function frase(t) { t = String(t || '').trim(); if (/[a-zà-ú]/.test(t)) return t; t = t.toLowerCase(); return t.charAt(0).toUpperCase() + t.slice(1); }
  function codNome(t) { t = String(t || '').trim(); var m = /^(\S+)\s+-\s+(.+)$/.exec(t); return m ? m[1] + ' - ' + nome(m[2]) : nome(t); }
  function vazio(t) { return !t || /^[\s\-–]*$/.test(t); }
  function data(t) { var m = /(\d{1,2})\/(\d{1,2})\/(\d{4})/.exec(String(t || '')); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function hoje() { var n = new Date(); return new Date(n.getFullYear(), n.getMonth(), n.getDate()); }
  function dias(n) { return n === 1 ? '1 dia' : n + ' dias'; }
  function iniciais(n) { var p = String(n || '?').split(/\s+/).filter(function (x) { return x.length > 2; }); return ((p[0] || '?').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  var IC = {
    cv: '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4"/><circle cx="12.5" cy="12.5" r="2"/><path d="M9.5 18a3 3 0 0 1 6 0"/>',
    email: '<rect x="3.5" y="5.5" width="17" height="13" rx="2"/><path d="M4 7l8 6 8-6"/>',
    whats: '<path d="M4.5 20l1.2-4A8 8 0 1 1 8.5 19z"/><path d="M9 9.5c0 3 2.5 5.5 5.5 5.5l1-1.5-2-1-1 1a4 4 0 0 1-2-2l1-1-1-2z"/>',
    linkedin: '<rect x="3.5" y="3.5" width="17" height="17" rx="3"/><path d="M8 10.5v5.5M8 7.6v.1M11.5 16v-5.5M11.5 13a2.5 2.5 0 0 1 5 0v3"/>',
    abrir: '<path d="M9.5 6l6 6-6 6"/>', seta: '<path d="M9.5 6.5l5 5.5-5 5.5"/>',
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>', alerta: '<path d="M12 4l9 16H3z"/><path d="M12 10v4M12 17h.01"/>',
    doc: '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4M9.5 13h6M9.5 16.5h4"/>', pcd: '<circle cx="12" cy="4.5" r="1.8"/><path d="M6 8.5h12M12 8.5v5l-3 6M12 13.5l3 6"/>',
    lista: '<path d="M9 6.5h11M9 12h11M9 17.5h11"/><circle cx="4.8" cy="6.5" r="1"/><circle cx="4.8" cy="12" r="1"/><circle cx="4.8" cy="17.5" r="1"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M3.5 14.5h17M9.5 10v9"/>',
    corte: '<path d="M5 12h14"/><path d="M8 8l-3 4 3 4"/>',
    mais: '<path d="M6.5 9.5l5.5 5.5 5.5-5.5"/>', copiar: '<rect x="8.5" y="8.5" width="11" height="11" rx="2"/><path d="M5.5 15.5v-9a1 1 0 0 1 1-1h9"/>',
    ordem: '<path d="M7 5v14M4 16l3 3 3-3M14 7h6M14 12h4.5M14 17h3"/>', lupa: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>'
  };
  function ic(n) { return '<svg class="nc-pd-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  function estrela(cheia) { return '<svg class="nc-pd-estrela' + (cheia ? ' is-cheia' : '') + '" viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3.8l2.5 5.1 5.6.8-4 3.9.9 5.6-5-2.6-5 2.6.9-5.6-4-3.9 5.6-.8z"/></svg>'; }
  function botaoPorTexto(rx) { return [].filter.call(document.querySelectorAll('button.t-Button, a.t-Button'), function (b) { return rx.test(b.textContent.trim()); })[0]; }

  /* ═══ [D3] A FICHA DA VAGA ═══════════════════════════════════════════════════════════════
     Lida da região "Descrição da Vaga" (coluna lateral): linhas "Rótulo:" + valor, e a
     situação (PUBLICADA, ABERTA…) logo depois dos botões. Os botões originais vêm junto.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function lerVaga(reg) {
    var o = {}, txt = reg.innerText.split('\n').map(function (l) { return l.trim(); }).filter(Boolean);
    for (var i = 0; i < txt.length; i++) {
      var l = txt[i], m = /^([^:]{2,40}):\s*(.*)$/.exec(l);
      if (m) { o[sem(m[1])] = m[2] || (txt[i + 1] && !/:\s*$/.test(txt[i + 1]) && !/^[^:]{2,40}:/.test(txt[i + 1]) ? txt[++i] : ''); continue; }
      if (!o.situacao && SITUACAO_VAGA[sem(l)]) o.situacao = l;
    }
    return o;
  }
  function montarFicha(regVaga, alvo) {   /* alvo: não usado desde a coluna lateral (03/10) */
    var v = lerVaga(regVaga.querySelector('.t-Region-body') || regVaga);
    var sit = sem(v.situacao || ''), prazo = data(v['prazo de contratacao']), cont = '';
    if (prazo && (sit === 'publicada' || sit === 'aberta')) {
      var n = Math.round((prazo - hoje()) / 864e5);
      cont = '<small data-tom="' + (n < 0 ? 'vencido' : n <= 7 ? 'perto' : 'ok') + '">' + (n < 0 ? 'vencido há ' + dias(-n) : n === 0 ? 'vence hoje' : 'faltam ' + dias(n)) + '</small>';
    }
    var fatos = [['Empresa', v.empresa && codNome(v.empresa)], ['Filial', v.filial], ['Centro de custo', v['centro de custo']], ['Selecionador', v.selecionador && codNome(v.selecionador)],
      ['Ativa desde', v['ativo em']], ['Prazo de contratação', v['prazo de contratacao'] && esc(v['prazo de contratacao']) + cont, true],
      ['Publicação', [v['tipo de publicacao'], !vazio(v.publicacao) && frase(v.publicacao)].filter(Boolean).join(' · ')]].filter(function (f) { return !vazio(f[1]); });
    var ficha = el('section', 'nc-pd-ficha');
    ficha.setAttribute('aria-label', 'A vaga');
    /* os dados da vaga começam RECOLHIDOS (a coluna mostra logo as etapas); a escolha fica lembrada */
    var aberta = false; try { aberta = localStorage.getItem('nc-pd-vaga-aberta') === 'sim'; } catch (x) { /* sem armazenamento */ }
    if (window.matchMedia && window.matchMedia('(max-width: 1000px)').matches) aberta = false;   /* no celular começa recolhida */
    ficha.innerHTML =
      '<header class="nc-pd-ficha-cab"><h2>A vaga</h2>' + (v.situacao ? '<span class="nc-pd-situacao" data-sit="' + esc(sit) + '">' + esc(frase(v.situacao)) + '</span>' : '') + '</header>' +
      (prazo ? '<p class="nc-pd-prazo"><span>Prazo de contratação</span><b>' + esc(v['prazo de contratacao']) + '</b>' + cont + '</p>' : '') +
      '<details class="nc-pd-ficha-mais"' + (aberta ? ' open' : '') + '><summary>Dados da vaga</summary>' +
        '<dl>' + fatos.filter(function (f) { return f[0] !== 'Prazo de contratação'; }).map(function (f) { return '<div><dt>' + esc(f[0]) + '</dt><dd>' + (f[2] ? f[1] : esc(f[1])) + '</dd></div>'; }).join('') + '</dl></details>' +
      '<div class="nc-pd-acoes" role="group" aria-label="Ações da vaga"></div>';
    /* só o CLIQUE da pessoa é lembrado (o "toggle" também dispara quando a própria página abre) */
    var det = ficha.querySelector('details');
    det.querySelector('summary').addEventListener('click', function () { var vai = !det.open; try { localStorage.setItem('nc-pd-vaga-aberta', vai ? 'sim' : 'nao'); } catch (x) { /* sem armazenamento */ } });
    /* as ações originais (os mesmos botões, com o que já faziam) */
    var acoes = ficha.querySelector('.nc-pd-acoes');
    [/^detalhes da vaga$/i, /^requisi/i, /^anota/i, /^processo seletivo$/i, /^finalizar processo$/i].forEach(function (rx) {
      var b = botaoPorTexto(rx); if (!b) return;
      b.classList.add('nc-pd-bt'); if (/finalizar/i.test(b.textContent)) b.classList.add('nc-pd-bt--perigo');
      acoes.appendChild(b);
    });
    regVaga.classList.add('nc-pd-guardado');
    document.body.classList.add('nc-pd-sem-lado');
    return ficha;
  }

  /* ═══ [D4] O FUNIL DAS ETAPAS ════════════════════════════════════════════════════════════
     Lido dos cartões "Visualizar candidato(s) por etapa" (título = etapa, subtítulo = quantos).
     Tocar numa etapa filtra a lista pela coluna Fase (comparação sem acento/maiúsculas).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ETAPA = '', ETAPAS_N = {};   /* ETAPAS_N: quantos o funil diz em cada etapa ('' = Todos) */
  function lerEtapas(reg) {
    return [].map.call(reg.querySelectorAll('.t-Cards-item'), function (li) {
      return { t: ((li.querySelector('.t-Card-title') || {}).textContent || '').trim(), n: +(((li.querySelector('.t-Card-subtitle') || {}).textContent || '0').trim()) || 0 };
    }).filter(function (e) { return e.t; });
  }
  /* a coluna da esquerda mostra as etapas EM PÉ, como um funil: cada uma com quantos estão nela e
     uma barra do tamanho dessa parte no total — dá para ver de relance onde os candidatos param */
  function htmlFunil(etapas) {
    var total = Math.max.apply(null, etapas.map(function (e) { return e.n; }).concat([1])), num = 0;
    return '<nav class="nc-pd-funil" aria-label="Etapas do processo"><h3 class="nc-pd-lado-tit">Etapas</h3><ul>' + etapas.map(function (e) {
      var k = /^todos$/i.test(e.t) ? '' : sem(e.t);
      return '<li><button type="button" data-etapa="' + esc(k) + '" aria-pressed="' + (ETAPA === k) + '"' + (e.n ? '' : ' data-zero') + ' style="--nc-pd-parte:' + Math.round(e.n / total * 100) + '%">' +
        (k ? '<i aria-hidden="true">' + (++num) + '</i>' : '<i aria-hidden="true" class="nc-pd-todos">' + ic('lista') + '</i>') +
        '<span>' + esc(frase(e.t)) + '</span><b>' + e.n + '</b></button></li>';
    }).join('') + '</ul></nav>';
  }

  /* ═══ [D5] LER OS CANDIDATOS ═════════════════════════════════════════════════════════════
     CUIDADO  Lê só as linhas do relatório à vista (a página de linhas atual). Os atalhos são
              os <a> originais (CV e e-mail abrem janelas do APEX; WhatsApp e LinkedIn, links).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function mapaColunas(ir) {
    var m = {};
    [].forEach.call(ir.querySelectorAll('table.a-IRR-table th[id]'), function (th) {
      var k = COLUNAS[sem(th.textContent)]; if (k && th.id) m[th.id] = k;
    });
    return m;
  }
  function lerCandidatos(ir) {
    var mapa = mapaColunas(ir), out = [];
    [].forEach.call(ir.querySelectorAll('table.a-IRR-table tr'), function (tr) {
      var tds = tr.querySelectorAll('td[headers]'); if (tds.length < 3) return;
      var c = { tr: tr, cel: {} };
      [].forEach.call(tds, function (td) { var k = mapa[td.getAttribute('headers')]; if (k) c.cel[k] = td; });
      var t = function (k) { var td = c.cel[k]; var v = td ? td.textContent.replace(/\s+/g, ' ').trim() : ''; return vazio(v) ? '' : v; };
      var a = function (k) { var td = c.cel[k]; return td && td.querySelector('a[href]'); };
      c.nome = t('nome'); c.cod = t('cod'); c.tipo = t('tipo'); c.fase = t('fase'); c.dFase = t('dFase');
      c.idade = t('idade'); c.sexo = t('sexo'); c.local = t('local'); c.cargo = t('cargo'); c.instrucao = t('instrucao');
      c.aprovado = /^sim$/i.test(t('aprovado')); c.status = t('status'); c.docs = t('docs'); c.restricao = t('restricao');
      c.pcd = !!(c.cel.pcd && c.cel.pcd.querySelector('.fa'));
      c.mail = t('mail'); c.nasc = t('nasc'); c.dep = t('dep'); c.genero = t('genero'); c.dAtual = t('dAtual');
      c.selec = t('selec'); c.aval = t('aval'); c.motivo = t('motivo'); c.dAval = t('dAval'); c.resultado = t('resultado'); c.usuario = t('usuario');
      var nota = c.cel.nota && c.cel.nota.querySelector('input[name="PONTUACAO"], input');
      c.nota = nota ? Math.max(0, Math.min(5, Math.round(+nota.value || 0))) : null;
      c.chk = c.cel.sel && c.cel.sel.querySelector('input.checkbox_item');
      c.semCaixa = !!c.cel.sel && !c.chk;   /* a página não põe a caixa em quem está abaixo da nota de corte */
      c.vermelha = !!tr.querySelector('.marcador-linha.linha-vermelha');
      c.aAbrir = a('link'); c.aCv = a('cv'); c.aEmail = a('email'); c.aWhats = a('whats'); c.aLinkedin = a('linkedin');
      c.chaveEtapa = sem((/^\s*\d+\s*-\s*(.+)$/.exec(c.fase) || [0, c.fase])[1]);
      c.numEtapa = +((/^\s*(\d+)/.exec(c.fase) || [0, 0])[1]);
      c.docsOk = !!c.docs && /\bok\b|complet|entregue/i.test(c.docs);
      /* o celular só vem dentro do link do WhatsApp (…send?phone=55…) */
      var fone = c.aWhats && /phone=\+?(\d+)/.exec(c.aWhats.getAttribute('href') || '');
      c.fone = fone ? fone[1].replace(/^55(?=\d{10,11}$)/, '') : '';
      out.push(c);
    });
    return out;
  }

  /* ═══ [D6] DESENHAR OS CANDIDATOS ════════════════════════════════════════════════════════ */
  var CANDS = [];
  function atalho(a, n, rot) {
    if (!a) return '';
    return '<a class="nc-pd-atalho" href="' + esc(a.getAttribute('href')) + '"' + (a.target ? ' target="' + esc(a.target) + '" rel="noopener"' : '') + ' title="' + esc(rot) + '" aria-label="' + esc(rot) + '">' + ic(n) + '</a>';
  }
  function linha(c, i) {
    var faseM = /^\s*(\d+)\s*-\s*(.+)$/.exec(c.fase || '');
    var meta = [c.idade && c.idade + ' anos', c.sexo && frase(c.sexo), c.local && c.local].filter(Boolean).join(' · ');
    var carreira = [c.cargo && !/^n[aã]o informado$/i.test(c.cargo) && 'Último cargo: ' + c.cargo, c.instrucao && !/^n[aã]o informado$/i.test(c.instrucao) && c.instrucao].filter(Boolean).join(' · ');
    var sinais = [];
    if (c.aprovado) sinais.push('<span class="nc-pd-sinal" data-tom="bom">' + ic('check') + 'Aprovado</span>');
    if (c.semCaixa) sinais.push('<span class="nc-pd-sinal" data-tom="ruim">' + ic('corte') + 'Abaixo da nota de corte</span>');
    if (c.restricao) sinais.push('<span class="nc-pd-sinal" data-tom="ruim">' + ic('alerta') + 'Restrição: ' + esc(c.restricao) + '</span>');
    if (c.docs) sinais.push('<span class="nc-pd-sinal" data-tom="' + (/\bok\b|complet|entregue/i.test(c.docs) ? 'bom' : 'atencao') + '">' + ic('doc') + esc(frase(c.docs)) + '</span>');
    if (c.pcd) sinais.push('<span class="nc-pd-sinal" data-tom="info">' + ic('pcd') + 'PCD</span>');
    /* sem nome no cadastro: o link continua tocável (a ficha do candidato é onde se corrige) */
    var rotulo = c.nome ? esc(c.nome) : '<span class="nc-pd-semnome">Nome não informado</span>';
    var nota = !c.nota ? '' : '<span class="nc-pd-nota" title="Nota ' + c.nota + ' de 5" aria-label="Nota ' + c.nota + ' de 5">' + [1, 2, 3, 4, 5].map(function (k) { return estrela(k <= c.nota); }).join('') + '</span>';
    return '<li class="nc-pd-cand' + (ABERTOS[c.cod] ? ' is-aberta' : '') + '" data-i="' + i + '"' + (c.aprovado ? ' data-tom="bom"' : c.vermelha ? ' data-tom="ruim"' : '') + '>' +
      '<label class="nc-pd-caixa"' + (c.chk ? '' : ' title="' + (c.semCaixa ? 'Abaixo da nota de corte: não pode mudar de fase' : 'Sem seleção') + '"') + '><input type="checkbox" data-sel="' + i + '"' + (c.chk ? (c.chk.checked ? ' checked' : '') : ' disabled') + ' aria-label="Selecionar ' + esc(c.nome) + '"></label>' +
      '<span class="nc-pd-avatar" aria-hidden="true">' + esc(iniciais(c.nome)) + '</span>' +
      '<div class="nc-pd-quem">' +
        '<p class="nc-pd-nome">' + (c.aAbrir ? '<a href="' + esc(c.aAbrir.getAttribute('href')) + '">' + rotulo + '</a>' : rotulo) +
          (c.cod ? ' <span class="nc-pd-cod">' + esc(c.cod) + '</span>' : '') + (c.tipo ? ' <span class="nc-pd-tipo">' + esc(c.tipo) + '</span>' : '') + '</p>' +
        (meta ? '<p class="nc-pd-meta">' + esc(meta) + '</p>' : '') +
        (carreira ? '<p class="nc-pd-meta nc-pd-fraco">' + esc(carreira) + '</p>' : '') +
        (sinais.length ? '<p class="nc-pd-sinais">' + sinais.join('') + '</p>' : '') +
      '</div>' +
      '<div class="nc-pd-etapa">' + (c.fase ? '<span class="nc-pd-fase">' + (faseM ? '<i>' + esc(faseM[1]) + '</i>' + esc(frase(faseM[2])) : esc(frase(c.fase))) + '</span>' : '') +
        (c.dFase ? '<small>desde ' + esc(c.dFase) + '</small>' : c.dAtual ? '<small>atualizado em ' + esc(c.dAtual) + '</small>' : '') + nota + '</div>' +
      '<div class="nc-pd-atalhos">' + atalho(c.aCv, 'cv', 'Currículo de ' + c.nome) + atalho(c.aEmail, 'email', 'Enviar e-mail') + atalho(c.aWhats, 'whats', 'WhatsApp') + atalho(c.aLinkedin, 'linkedin', 'LinkedIn') +
        '<button type="button" class="nc-pd-atalho nc-pd-detalhe-bt" data-detalhe="' + i + '" aria-expanded="' + !!ABERTOS[c.cod] + '" aria-controls="nc-pd-info-' + i + '" title="Mais sobre ' + esc(c.nome || 'o candidato') + '" aria-label="Mais sobre ' + esc(c.nome || 'o candidato') + '">' + ic('mais') + '</button>' +
        (c.aAbrir ? '<a class="nc-pd-abrir" href="' + esc(c.aAbrir.getAttribute('href')) + '" title="Abrir a ficha completa" aria-label="Abrir a ficha de ' + esc(c.nome) + '">' + ic('abrir') + '</a>' : '') + '</div>' +
      detalhes(c, i) +
    '</li>';
  }
  function desenharCandidatos(app, ir) {
    CANDS = lerCandidatos(ir);
    desenharFiltros(app);
    var f = FILTRO && FILTROS.filter(function (x) { return x[0] === FILTRO; })[0];
    var bq = sem(BUSCA);
    var vis = CANDS.map(function (c, i) { return [c, i]; }).filter(function (x) {
      var c = x[0];
      return (!ETAPA || c.chaveEtapa === ETAPA) && (!f || f[2](c)) &&
        (!bq || sem([c.nome, c.cod, c.mail, c.local, c.cargo, c.fase, c.fone].join(' ')).indexOf(bq) >= 0);
    });
    /* QUANTOS: o relatório vem paginado (50 por página) e não diz o total — quem sabe é o funil
       (o servidor conta). Sem filtro no relatório: o número é o total da etapa escolhida (ou de
       Todos) e, se a lista só cobre esta página, "N nesta página" ao lado. Busca e sinais filtram
       só a página à vista: aí o número diz isso. Com filtro no próprio relatório (Enter na
       busca), o funil deixa de valer e conta-se a página. */
    var conta = (RAIZ || app).querySelector('.nc-pd-conta'), nota = (RAIZ || app).querySelector('.nc-pd-conta-pag');
    var paginado = temMaisPaginas(ir), filtrado = !!ir.querySelector('.a-IRR-controls-item, .a-IRR-controls li');
    var doFunil = !filtrado && Object.prototype.hasOwnProperty.call(ETAPAS_N, ETAPA) ? ETAPAS_N[ETAPA] : null;
    var n, extra = '';
    if (!paginado) n = vis.length === CANDS.length ? String(CANDS.length) : vis.length + ' de ' + CANDS.length;
    else if (!f && !bq && doFunil !== null) { n = String(doFunil); if (vis.length !== doFunil) extra = vis.length + ' nesta página'; }
    else { n = String(vis.length); extra = 'nesta página'; }
    if (conta) conta.textContent = n;
    if (nota) { nota.textContent = extra; nota.hidden = !extra; }
    var rotPag = ir.querySelector('.a-IRR-pagination-label'), m0 = (RAIZ || app).querySelector('.nc-pd-mais');
    if (m0) m0.textContent = (rotPag ? 'Mostrando ' + rotPag.textContent.trim().replace(/\s*-\s*/, '–') + (doFunil !== null && !ETAPA ? ' de ' + doFunil : '') + '. ' : '') + 'Passe as páginas abaixo para ver os outros candidatos.';
    if (ORDENS[ORDEM]) vis.sort(function (a, b) { return ORDENS[ORDEM](a[0], b[0]) || a[1] - b[1]; });
    var lu = (app._resto || app).querySelector('.nc-pd-lista');
    lu.innerHTML = vis.length ? vis.map(function (x) { return linha(x[0], x[1]); }).join('')
      : '<li class="nc-pd-vazio"><p><b>' + (CANDS.length ? 'Nenhum candidato ' + (bq ? 'com “' + esc(BUSCA) + '”' + (ETAPA || f ? ' com estes filtros' : '') : f ? 'com “' + f[1].toLowerCase() + '”' + (ETAPA ? ' nesta etapa' : '') : 'nesta etapa') + (temMaisPaginas(ir) ? ' nesta página do relatório' : '') + '.' : 'Nenhum candidato neste processo.') + '</b></p>' +
        (bq && temMaisPaginas(ir) ? '<p class="nc-pd-fraco">Aperte Enter na busca para procurar em todas as páginas.</p>' : '') +
        (CANDS.length ? '<button type="button" class="nc-pd-bt" data-etapa="" data-filtro="" data-limpa-busca>Ver todos</button>' : '') + '</li>';
    var ma = (app._resto || app).querySelector('.nc-pd-mais'); if (ma) ma.hidden = !temMaisPaginas(ir);
    barra(app);
  }
  function temMaisPaginas(ir) { return !!ir.querySelector('.a-IRR-pagination a, .a-IRR-button--pagination:not([disabled])'); }

  /* ═══ [D9] SINAIS QUE FILTRAM, ORDEM E "MAIS SOBRE O CANDIDATO" ═══════════════════════════
     Os sinais das linhas viram filtros de um toque, com a contagem ("Faltam documentos 26");
     somam com a etapa do funil. A ordem é só da lista à vista (não mexe no relatório).
     PODE MEXER  a lista FILTROS (chave, texto, regra, tom) e a lista ORDENS.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FILTRO = '', ORDEM = '', ABERTOS = {}, BUSCA = '', RAIZ = null;
  var FILTROS = [
    ['docs', 'Faltam documentos', function (c) { return !!c.docs && !c.docsOk; }, 'atencao'],
    ['docsok', 'Documentos OK', function (c) { return c.docsOk; }, 'bom'],
    ['aprov', 'Aprovados na etapa', function (c) { return c.aprovado; }, 'bom'],
    ['restr', 'Com restrição de admissão', function (c) { return !!c.restricao; }, 'ruim'],
    ['corte', 'Abaixo da nota de corte', function (c) { return c.semCaixa; }, 'ruim'],
    ['pcd', 'PCD', function (c) { return c.pcd; }, 'info']
  ];
  function pt(a, b) { return String(a || '').localeCompare(String(b || ''), 'pt-BR', { sensitivity: 'base' }); }
  var ORDENS = {
    etapa: function (a, b) { return b.numEtapa - a.numEtapa || pt(a.nome, b.nome); },
    nome: function (a, b) { return (!a.nome) - (!b.nome) || pt(a.nome, b.nome); },
    recente: function (a, b) { return (data(b.dAtual) || 0) - (data(a.dAtual) || 0); },
    nota: function (a, b) { return (b.nota || 0) - (a.nota || 0); }
  };
  function desenharFiltros(app) {
    var caixa = (RAIZ || app).querySelector('.nc-pd-filtros'); if (!caixa) return;
    var lista = FILTROS.map(function (f) { return [f, CANDS.filter(f[2]).length]; }).filter(function (x) { return x[1] > 0; });
    if (FILTRO && !lista.some(function (x) { return x[0][0] === FILTRO; })) FILTRO = '';
    caixa.querySelector('.nc-pd-filtros-lista').innerHTML = lista.map(function (x) {
      return '<li><button type="button" class="nc-pd-filtro" data-filtro="' + x[0][0] + '" data-tom="' + x[0][3] + '" aria-pressed="' + (FILTRO === x[0][0]) + '"><i aria-hidden="true"></i><span>' + esc(x[0][1]) + '</span><b>' + x[1] + '</b></button></li>';
    }).join('');
    caixa.hidden = !lista.length;
  }
  function etapaTxt(f) { var m = /^\s*(\d+)\s*-\s*(.+)$/.exec(f || ''); return m ? m[1] + ' - ' + frase(m[2]) : frase(f); }
  function fone(n) { var m = /^(\d{2})(\d{4,5})(\d{4})$/.exec(n || ''); return m ? '(' + m[1] + ') ' + m[2] + '-' + m[3] : n; }
  function fato(rot, val) { return val ? '<div><dt>' + esc(rot) + '</dt><dd>' + val + '</dd></div>' : ''; }
  function detalhes(c, i) {
    var nasc = c.nasc ? esc(c.nasc) + (c.idade ? ' <span class="nc-pd-fraco">· ' + esc(c.idade) + ' anos</span>' : '') : '';
    var contato = fato('E-mail', c.mail && '<a href="mailto:' + esc(c.mail) + '">' + esc(c.mail) + '</a> <button type="button" class="nc-pd-copiar" data-copiar="' + esc(c.mail) + '" title="Copiar o e-mail" aria-label="Copiar o e-mail">' + ic('copiar') + '</button>') +
      fato('Celular', c.fone && esc(fone(c.fone)) + ' <button type="button" class="nc-pd-copiar" data-copiar="' + esc(c.fone) + '" title="Copiar o celular" aria-label="Copiar o celular">' + ic('copiar') + '</button>') +
      fato('LinkedIn', c.aLinkedin && '<a href="' + esc(c.aLinkedin.getAttribute('href')) + '" target="_blank" rel="noopener">Ver perfil</a>');
    var perfil = fato('Nascimento', nasc) + fato('Sexo', esc(frase(c.sexo))) + (c.genero && sem(c.genero) !== sem(c.sexo) ? fato('Gênero', esc(frase(c.genero))) : '') +
      fato('Dependentes', esc(c.dep)) + fato('Instrução', esc(c.instrucao)) + fato('Último cargo', esc(c.cargo)) + fato('Mora em', esc(c.local));
    var processo = fato('Etapa', esc(etapaTxt(c.fase))) + fato('Na etapa desde', esc(c.dFase)) + fato('Aprovado na etapa', c.aprovado ? 'Sim' : 'Não') +
      fato('Situação', esc(frase(c.status))) + fato('Documentos', esc(frase(c.docs))) + fato('Restrição de admissão', esc(c.restricao)) +
      fato('Selecionador', esc(c.selec)) + fato('Avaliação', esc(c.aval)) + fato('Motivo', esc(c.motivo)) + fato('Resultado', esc(c.resultado)) +
      fato('Última atualização', esc(c.dAtual) + (c.usuario ? ' <span class="nc-pd-fraco">· ' + esc(c.usuario) + '</span>' : ''));
    var acoes = (c.aAbrir ? '<a class="nc-pd-bt nc-pd-bt--primario" href="' + esc(c.aAbrir.getAttribute('href')) + '">Abrir a ficha completa</a>' : '') +
      (c.aCv ? '<a class="nc-pd-bt" href="' + esc(c.aCv.getAttribute('href')) + '">' + ic('cv') + 'Currículo</a>' : '') +
      (c.aEmail ? '<a class="nc-pd-bt" href="' + esc(c.aEmail.getAttribute('href')) + '">' + ic('email') + 'Enviar e-mail</a>' : '');
    return '<div class="nc-pd-info" id="nc-pd-info-' + i + '"' + (ABERTOS[c.cod] ? '' : ' hidden') + '>' +
      (contato ? '<section><h3>Contato</h3><dl>' + contato + '</dl></section>' : '') +
      (perfil ? '<section><h3>Perfil</h3><dl>' + perfil + '</dl></section>' : '') +
      '<section><h3>No processo</h3><dl>' + processo + '</dl></section>' +
      (acoes ? '<footer>' + acoes + '</footer>' : '') + '</div>';
  }
  function copiar(t, b) {
    var ok = function () { b.classList.add('is-copiado'); b.setAttribute('title', 'Copiado'); setTimeout(function () { b.classList.remove('is-copiado'); }, 1600); };
    if (navigator.clipboard && navigator.clipboard.writeText) navigator.clipboard.writeText(t).then(ok, function () { /* sem permissão: o texto está à vista */ });
  }

  /* ═══ [D10] AS JANELAS DA PÁGINA: MUDANÇA DE FASE E INCLUIR CANDIDATO ═══════════════════
     As duas são regiões em janela (abrem por ação dinâmica). Ao abrir:
       • Mudança de fase: no alto, QUEM vai mudar (nomes dos selecionados e a etapa de hoje);
         "Voltar" vira "Cancelar".
       • "Aprovar Candidato" (aparece com 1 selecionado): CUIDADO — o original monta o
         endereço com &P32_COD_CANDIDATO. e outros itens da PÁGINA 32, ou seja, com o último
         candidato aberto na ficha (p32) nesta sessão, não com o selecionado. Aqui ele abre a
         FICHA do candidato selecionado (p32), onde "Aprovar Candidato" usa os dados certos.
       • Incluir candidato: uma linha diz o que acontece (entra na etapa 1).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function janelas() {
    $(document).on('dialogopen', function (ev) {
      var r = ev.target; if (!r || !r.querySelector) return;
      if (r.querySelector('#P29_NEW_FASE')) janelaFase(r);
      else if (r.querySelector('#P29_NEW_TIPO_CAND')) janelaIncluir(r);
    });
  }
  function janelaFase(r) {
    var sel = CANDS.filter(function (c) { return c.chk && c.chk.checked; });
    var corpo = r.querySelector('.t-DialogRegion-body, .t-Region-body') || r;
    var q = corpo.querySelector('.nc-pd-quem-muda') || corpo.insertBefore(el('div', 'nc-pd-quem-muda'), corpo.firstChild);
    var nomes = sel.slice(0, 8).map(function (c) { return '<li>' + esc(c.nome || 'Código ' + c.cod) + (sel.length === 1 && c.fase ? ' <span class="nc-pd-fraco">· hoje em ' + esc(etapaTxt(c.fase)) + '</span>' : '') + '</li>'; }).join('') +
      (sel.length > 8 ? '<li class="nc-pd-fraco">e mais ' + (sel.length - 8) + '</li>' : '');
    q.innerHTML = sel.length ? '<p><b>' + (sel.length === 1 ? 'Mudar a fase de 1 candidato' : 'Mudar a fase de ' + sel.length + ' candidatos') + '</b></p><ul>' + nomes + '</ul>' +
      '<p class="nc-pd-fraco">Escolha a nova fase. Se a fase tiver nota mínima, ela aparece aqui embaixo.' +
        (sel.length === 1 && sel[0].aAbrir ? ' “Aprovar candidato” abre a ficha de ' + esc((sel[0].nome || 'quem foi escolhido').split(' ')[0]) + ', onde a aprovação é confirmada.' : '') + '</p>'
      : '<p class="nc-pd-fraco">Nenhum candidato selecionado.</p>';
    /* os botões numa linha só, no pé: Cancelar à esquerda; Aprovar e Confirmar à direita */
    var conf = [].filter.call(r.querySelectorAll('.t-Button'), function (b) { return /^confirmar fase$/i.test(b.textContent.trim()); })[0];
    var aprov = [].filter.call(r.querySelectorAll('.t-Button'), function (b) { return /^aprovar candidato$/i.test(b.textContent.trim()); })[0];
    if (conf) { var pe = conf.closest('.t-ButtonRegion'); if (pe) pe.classList.add('nc-pd-janela-pe'); }
    if (conf && aprov && aprov.parentNode !== conf.parentNode) {
      var regAp = aprov.closest('.t-ButtonRegion');
      conf.parentNode.insertBefore(aprov, conf);
      aprov.classList.remove('t-Button--stretch');
      if (regAp) regAp.classList.add('nc-pd-guardado');
    }
    if (aprov) { var la = aprov.querySelector('.t-Button-label'); if (la) la.textContent = 'Aprovar candidato'; }
    if (conf) { var lc = conf.querySelector('.t-Button-label'); if (lc) lc.textContent = 'Confirmar fase'; }
    [].forEach.call(r.querySelectorAll('.t-Button'), function (b) {
      var l = b.querySelector('.t-Button-label') || b, t = l.textContent.trim();
      if (/^voltar$/i.test(t)) l.textContent = 'Cancelar';
      if (/^aprovar candidato$/i.test(t)) {
        b.classList.add('nc-pd-aprovar');
        var um = sel.length === 1 && sel[0].aAbrir;
        b.removeAttribute('onclick'); b.onclick = null;
        if (!b.__ncAprovar) {
          b.__ncAprovar = true;
          b.addEventListener('click', function (e) {
            var s1 = CANDS.filter(function (c) { return c.chk && c.chk.checked; });
            e.preventDefault(); e.stopImmediatePropagation();
            if (s1.length === 1 && s1[0].aAbrir) apex.navigation.redirect(s1[0].aAbrir.getAttribute('href'));
          }, true);
        }
        b.title = um ? 'Abre a ficha de ' + (sel[0].nome || 'candidato') + ', onde a aprovação é feita' : '';
      }
    });
  }
  function janelaIncluir(r) {
    var corpo = r.querySelector('.t-DialogRegion-body, .t-Region-body') || r;
    if (corpo.querySelector('.nc-pd-quem-muda')) return;
    var p = el('div', 'nc-pd-quem-muda', '<p class="nc-pd-fraco">Escolha se é alguém de fora (externo) ou que já trabalha na empresa (interno) e procure pelo nome ou código. Quem você incluir entra no processo na etapa <b>1 - Triagem inicial</b>.</p>');
    corpo.insertBefore(p, corpo.firstChild);
  }

  /* ═══ [D7] SELEÇÃO E A BARRA ═════════════════════════════════════════════════════════════
     A nossa caixa APERTA a original (.checkbox_item): o código da página grava a seleção no
     servidor (salvar_ids) e liga o "Mudar Fase". "Mudar fase" na barra = o botão original.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function barra(app) {
    var n = CANDS.filter(function (c) { return c.chk && c.chk.checked; }).length;
    var raiz = app._resto || app, b = raiz.querySelector('.nc-pd-barra');
    b.hidden = !n;
    b.querySelector('.nc-pd-barra-n').textContent = n === 1 ? '1 candidato selecionado' : n + ' candidatos selecionados';
    var todos = raiz.querySelector('[data-todos]'), comCaixa = CANDS.filter(function (c) { return c.chk; });
    if (todos) { todos.checked = comCaixa.length > 0 && comCaixa.every(function (c) { return c.chk.checked; }); todos.indeterminate = n > 0 && !todos.checked; }
  }
  function marcar(c, v) { if (c.chk && c.chk.checked !== v) c.chk.click(); }

  /* ═══ [D8] O MAESTRO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() {
    var ir = $id('partnersIRR'); if (!ir) return;
    window.__ncProcessoDetalhe = true;
    document.body.classList.add('nc-pd-ativo');
    var regCand = ir.closest('.t-Region:not(#partnersIRR)') || ir.parentElement.closest('.t-Region');
    var regEtapas = [].filter.call(document.querySelectorAll('.t-Region'), function (r) { return r.querySelector('.t-Cards') && /etapa/i.test((r.querySelector('.t-Region-title') || {}).textContent || ''); })[0];
    var regVaga = document.querySelector('.t-Body-side .t-Region');
    /* o título da página: "ANALISTA DE SISTEMAS JUNIOR (57463)" → "Analista de sistemas junior · 57463" */
    var h = document.querySelector('.t-HeroRegion-title');
    if (h) { var m = /^(.*?)\s*\((\d+)\)\s*$/.exec(h.textContent.trim()); h.innerHTML = esc(frase(m ? m[1] : h.textContent)) + (m ? ' <span class="nc-pd-num">' + esc(m[2]) + '</span>' : ''); }
    /* duas colunas: à esquerda a vaga, as etapas e os sinais (o que FILTRA e situa); à direita só os
       candidatos. A região original dos candidatos é MOVIDA para dentro da coluna da direita. */
    var layout = el('div', 'nc-pd-layout'), lado = el('aside', 'nc-pd-lado'), principal = el('div', 'nc-pd-principal');
    lado.setAttribute('aria-label', 'Vaga e filtros');
    regCand.parentNode.insertBefore(layout, regCand);
    layout.appendChild(lado); layout.appendChild(principal); principal.appendChild(regCand);
    RAIZ = layout;
    /* a coluna da esquerda gruda logo abaixo do cabeçalho fixo da página (altura medida) */
    var topo = function () { var t = document.querySelector('.t-Body-title'), hd = document.querySelector('.t-Header'); var y = Math.max(t ? t.getBoundingClientRect().bottom : 0, hd ? hd.getBoundingClientRect().bottom : 0); layout.style.setProperty('--nc-pd-topo', Math.round(Math.max(0, y) + 12) + 'px'); };
    topo(); window.addEventListener('resize', topo);
    var ficha = regVaga ? montarFicha(regVaga) : null;
    if (ficha) lado.appendChild(ficha);

    /* o painel dos candidatos: funil + barra de ferramentas + lista (dentro da região original) */
    var etapas = regEtapas ? lerEtapas(regEtapas) : [];
    etapas.forEach(function (e) { ETAPAS_N[/^todos$/i.test(e.t) ? '' : sem(e.t)] = e.n; });
    if (regEtapas) regEtapas.classList.add('nc-pd-guardado');
    var app = el('section', 'nc-pd');
    app.setAttribute('aria-label', 'Candidatos');
    var visao = 'lista';
    try { visao = localStorage.getItem('nc-pd-visao') === 'tabela' ? 'tabela' : 'lista'; ORDEM = localStorage.getItem('nc-pd-ordem') || ''; } catch (x) { /* sem armazenamento */ }
    if (!ORDENS[ORDEM]) ORDEM = '';
    /* coluna da esquerda: etapas (funil) e sinais — os dois filtram a lista */
    lado.insertAdjacentHTML('beforeend', (etapas.length ? htmlFunil(etapas) : '') +
      '<div class="nc-pd-filtros" hidden><h3 class="nc-pd-lado-tit">Sinais</h3><ul class="nc-pd-filtros-lista" role="group" aria-label="Filtrar por sinal"></ul></div>');
    /* a barra dos candidatos numa linha só: título e quantos · busca na hora · ordem · Lista|Tabela · Incluir */
    app.innerHTML =
      '<header class="nc-pd-cab"><h2>Candidatos <span class="nc-pd-conta"></span><span class="nc-pd-conta-pag" hidden></span></h2>' +
        '<label class="nc-pd-busca">' + ic('lupa') + '<span class="u-VisuallyHidden">Buscar candidato</span><input type="search" data-busca placeholder="Buscar nome, código, e-mail, cidade…" autocomplete="off"></label>' +
        '<label class="nc-pd-ordem" title="Ordenar">' + ic('ordem') + '<span class="u-VisuallyHidden">Ordenar</span><select data-ordem aria-label="Ordenar">' +
          '<option value="">Como no relatório</option><option value="etapa">Etapa mais adiantada</option><option value="nome">Nome (A a Z)</option>' +
          '<option value="recente">Atualizados por último</option><option value="nota">Maior nota</option></select></label>' +
        '<div class="nc-pd-grupo" role="group" aria-label="Ver como"><button type="button" data-visao="lista" aria-pressed="' + (visao === 'lista') + '">' + ic('lista') + 'Lista</button><button type="button" data-visao="tabela" aria-pressed="' + (visao === 'tabela') + '">' + ic('tabela') + 'Tabela</button></div>' +
        '<div class="nc-pd-cab-acoes"></div>' +
      '</header>' +
      '<div class="nc-pd-titulos"><label class="nc-pd-caixa" title="Selecionar todos desta página"><input type="checkbox" data-todos aria-label="Selecionar todos"></label><span></span><span>Candidato</span><span>Etapa e nota</span><span>Atalhos</span></div>' +
      '<ol class="nc-pd-lista"></ol>' +
      '<p class="nc-pd-mais" hidden>Há mais candidatos nas próximas páginas do relatório (passe as páginas abaixo).</p>' +
      '<div class="nc-pd-barra" hidden role="region" aria-label="Selecionados"><span class="nc-pd-barra-n"></span><span class="nc-pd-barra-acoes"></span><button type="button" class="nc-pd-link" data-limpar>Limpar seleção</button></div>';
    var corpoCand = regCand.querySelector('.t-Region-body') || regCand;
    corpoCand.insertBefore(app, corpoCand.firstChild);
    regCand.classList.add('nc-pd-reg');
    var selOrdem = app.querySelector('[data-ordem]'); if (selOrdem) selOrdem.value = ORDEM;
    /* a barra de busca do relatório (lupa, Ações) fica ENTRE o funil e a lista: o alto (título e
       funil) vai antes do relatório; títulos, lista e barra de seleção, logo depois da barra
       dele (ela continua no lugar dela — o relatório segue funcionando igual) */
    var barraIR = ir.querySelector('.a-IRR-toolbar');
    if (barraIR) {
      var resto = el('div', 'nc-pd nc-pd-resto');
      ['.nc-pd-titulos', '.nc-pd-lista', '.nc-pd-mais', '.nc-pd-barra'].forEach(function (q) { var x = app.querySelector(q); if (x) resto.appendChild(x); });
      barraIR.parentNode.insertBefore(resto, barraIR.nextSibling);
      app.classList.add('nc-pd-topo');
      app._resto = resto;
    }
    /* Incluir candidato fica no alto do painel; Mudar fase vai para a barra de seleção */
    var inc = botaoPorTexto(/^incluir candidato$/i); if (inc) { inc.classList.add('nc-pd-bt', 'nc-pd-bt--primario'); app.querySelector('.nc-pd-cab-acoes').appendChild(inc); }
    var mud = botaoPorTexto(/^mudar fase$/i); if (mud) { mud.classList.add('nc-pd-bt', 'nc-pd-bt--primario'); (app._resto || app).querySelector('.nc-pd-barra-acoes').appendChild(mud); }
    document.body.classList.toggle('nc-pd-tabela', visao === 'tabela');

    var painel = layout;
    /* busca: filtra na hora o que está à vista; com mais páginas no relatório, Enter usa a busca dele */
    var busca = app.querySelector('[data-busca]');
    busca.addEventListener('input', function () { BUSCA = busca.value; desenharCandidatos(app, ir); });
    busca.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && busca.value) { busca.value = BUSCA = ''; desenharCandidatos(app, ir); return; }
      if (e.key !== 'Enter') return;
      e.preventDefault();
      var campo = $id('partnersIRR_search_field'), ir_ir = $id('partnersIRR_search_button');
      if (temMaisPaginas(ir) && campo && ir_ir) { campo.value = busca.value; ir_ir.click(); }
    });
    painel.addEventListener('click', function (ev) {
      var b = ev.target.closest('[data-copiar]');
      if (b) { copiar(b.getAttribute('data-copiar'), b); return; }
      if ((b = ev.target.closest('[data-filtro]')) && !b.hasAttribute('data-etapa')) {
        FILTRO = FILTRO === b.getAttribute('data-filtro') ? '' : b.getAttribute('data-filtro');
        return desenharCandidatos(app, ir);
      }
      /* "mais sobre": a seta, ou um toque no espaço livre da linha */
      var li = ev.target.closest('.nc-pd-cand');
      if ((b = ev.target.closest('[data-detalhe]')) || (li && !ev.target.closest('a, button, input, label, select, .nc-pd-info'))) {
        var k = b ? +b.getAttribute('data-detalhe') : +li.getAttribute('data-i'), c = CANDS[k];
        var info = document.getElementById('nc-pd-info-' + k); if (!c || !info) return;
        ABERTOS[c.cod] = info.hidden; info.hidden = !info.hidden;
        var bt = (li || b.closest('.nc-pd-cand')).querySelector('[data-detalhe]'); if (bt) bt.setAttribute('aria-expanded', String(!info.hidden));
        (li || b.closest('.nc-pd-cand')).classList.toggle('is-aberta', !info.hidden);
        return;
      }
      b = ev.target.closest('[data-etapa]');
      if (b) {
        if (b.hasAttribute('data-filtro')) FILTRO = '';
        if (b.hasAttribute('data-limpa-busca')) { BUSCA = ''; if (busca) busca.value = ''; }
        ETAPA = b.getAttribute('data-etapa');
        [].forEach.call(painel.querySelectorAll('.nc-pd-funil [data-etapa]'), function (x) { x.setAttribute('aria-pressed', String(x.getAttribute('data-etapa') === ETAPA)); });
        if (visao === 'tabela') { visao = 'lista'; document.body.classList.remove('nc-pd-tabela'); [].forEach.call(painel.querySelectorAll('[data-visao]'), function (x) { x.setAttribute('aria-pressed', String(x.getAttribute('data-visao') === 'lista')); }); }
        return desenharCandidatos(app, ir);
      }
      if ((b = ev.target.closest('[data-visao]'))) {
        visao = b.getAttribute('data-visao');
        try { localStorage.setItem('nc-pd-visao', visao); } catch (x) { /* sem armazenamento */ }
        document.body.classList.toggle('nc-pd-tabela', visao === 'tabela');
        [].forEach.call(painel.querySelectorAll('[data-visao]'), function (x) { x.setAttribute('aria-pressed', String(x === b)); });
        return;
      }
      if (ev.target.closest('[data-limpar]')) { CANDS.forEach(function (c) { marcar(c, false); }); setTimeout(function () { barra(app); }, 0); }
    });
    painel.addEventListener('change', function (ev) {
      var t = ev.target;
      if (t.hasAttribute('data-ordem')) { ORDEM = t.value; try { localStorage.setItem('nc-pd-ordem', ORDEM); } catch (x) { /* sem armazenamento */ } return desenharCandidatos(app, ir); }
      if (t.hasAttribute('data-sel')) { var c = CANDS[+t.getAttribute('data-sel')]; if (c) marcar(c, t.checked); barra(app); return; }
      if (t.hasAttribute('data-todos')) { var vis = painel.querySelectorAll('.nc-pd-lista [data-sel]:not(:disabled)'); [].forEach.call(vis, function (x) { var c = CANDS[+x.getAttribute('data-sel')]; x.checked = t.checked; marcar(c, t.checked); }); barra(app); }
    });
    desenharCandidatos(app, ir);
    janelas();
    /* o relatório redesenhou (página, busca, filtro) ou a seleção foi gravada: lê de novo */
    $(ir).on('apexafterrefresh', function () { setTimeout(function () { desenharCandidatos(app, ir); }, 0); });
  }
  var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp processo seletivo]', e); } }, 0); };
  if (document.readyState === 'complete') vai();
  else { if (window.apex.gPageContext$) $(apex.gPageContext$).one('apexreadyend', vai); window.addEventListener('load', vai); }
})();
