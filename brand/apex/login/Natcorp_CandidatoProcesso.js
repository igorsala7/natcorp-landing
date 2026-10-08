/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CANDIDATO NO PROCESSO  —  o "arrumador" da tela (JavaScript)                  ║
   ║  App 9113 (Recrutamento e Seleção) · Página 32 ("Dados do Candidato")                    ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: CANDIDATOPROCESSO-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   A ficha do candidato DENTRO de um processo seletivo (aberta da lista da página 29). Antes:
   9 abas em maiúsculas, os dados numa tabela de 5 colunas com rótulos azuis, o mesmo dado em
   duas abas (Dados do candidato e Dados pessoais; Fases e Avaliações), relatórios de 10
   colunas para 4 linhas, e o celular com um link quebrado. Agora:
     • CARTÃO DO CANDIDATO no alto: iniciais, nome (e nome social), código, idade e cidade, a
       etapa de hoje, a nota, e-mail e celular (com copiar e WhatsApp) e as ações de sempre
       (Aprovar candidato, Avaliar fase, Ver currículo); "Pessoa anterior" vai para o alto;
     • ABAS POR ASSUNTO, em frase: Resumo · Fases e avaliações · Questionário · Anotações ·
       Documentos · Linha do tempo · Outros processos. "Dados pessoais" entra no Resumo e
       "Fases" entra em "Fases e avaliações" (as abas antigas saem; os dados são os mesmos);
     • RESUMO em grupos: Contato, Perfil, Endereço, No processo, Identificação;
     • FASES E AVALIAÇÕES numa linha do tempo: cada fase com data, aprovado, avaliação,
       motivo, avaliador, nota e resultado, e o lápis original ("Avaliar");
     • QUESTIONÁRIO agrupado por fase e questionário: pergunta, resposta, peso e nota;
     • OUTROS PROCESSOS em linhas (situação, vaga, empresa, selecionador, fase, prazo), com
       o processo atual marcado.
   Em cada relatório transformado há "Ver tabela" (o relatório original, inteiro).

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Nada é gravado por ele. Os dados são LIDOS da própria página (região "DADOS DO
     CANDIDATO" e os relatórios). Os botões e links são os originais.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 32 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_CandidatoProcesso.js
     Página 32 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_CandidatoProcesso.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [K1]  Ferramentas
     [K2]  Ler: a região "DADOS DO CANDIDATO" e os relatórios          CUIDADO
     [K3]  O cartão do candidato
     [K4]  As abas (nomes, ordem, as que saem)                         PODE MEXER
     [K5]  Resumo
     [K6]  Fases e avaliações
     [K7]  Questionário
     [K8]  Outros processos
     [K9]  Anotações e linha do tempo (vazios)
     [K10] O maestro
*/
(function () {
  'use strict';
  if (window.__ncCandidatoProcesso || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [K1] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function sem(t) { return String(t || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/\s+/g, ' ').trim(); }
  function frase(t) { t = String(t || '').trim(); if (/[a-zà-ú]/.test(t)) return t; t = t.toLowerCase(); return t.charAt(0).toUpperCase() + t.slice(1); }
  function etapa(t) { var m = /^\s*(\d+)\s*-\s*(.+)$/.exec(t || ''); return m ? m[1] + ' - ' + frase(m[2]) : frase(t); }
  function nome(t) { return String(t || '').toLowerCase().replace(/(^|[\s'(/-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); }).replace(/\s(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (x) { return x.toLowerCase(); }); }
  function num(t) { return String(t || '').replace(/^,/, '0,'); }
  function vazio(t) { return !t || /^[\s\-–]*$/.test(t); }
  function iniciais(n) { var p = String(n || '?').split(/\s+/).filter(function (x) { return x.length > 2; }); return ((p[0] || '?').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  function fone(n) { var m = /^(\d{2})(\d{4,5})(\d{4})$/.exec(n || ''); return m ? '(' + m[1] + ') ' + m[2] + '-' + m[3] : n; }
  var IC = {
    email: '<rect x="3.5" y="5.5" width="17" height="13" rx="2"/><path d="M4 7l8 6 8-6"/>',
    fone: '<rect x="7" y="3" width="10" height="18" rx="2.2"/><path d="M11 17.5h2"/>',
    whats: '<path d="M4.5 20l1.2-4A8 8 0 1 1 8.5 19z"/><path d="M9 9.5c0 3 2.5 5.5 5.5 5.5l1-1.5-2-1-1 1a4 4 0 0 1-2-2l1-1-1-2z"/>',
    copiar: '<rect x="8.5" y="8.5" width="11" height="11" rx="2"/><path d="M5.5 15.5v-9a1 1 0 0 1 1-1h9"/>',
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>', relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    lapis: '<path d="M4.5 19.5l1-4L15.8 5.2a2 2 0 0 1 2.9 0l.1.1a2 2 0 0 1 0 2.9L8.5 18.5z"/><path d="M13.5 7.5l3 3"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M3.5 14.5h17M9.5 10v9"/>',
    abrir: '<path d="M9.5 6l6 6-6 6"/>',
    /* os ícones das abas (mesmo traço dos demais) */
    resumo: '<rect x="3.5" y="5" width="17" height="14" rx="2.5"/><circle cx="9" cy="11" r="2.2"/><path d="M5.8 16.2c.6-1.6 1.8-2.4 3.2-2.4s2.6.8 3.2 2.4M14.5 10h3.5M14.5 13.5h2.5"/>',
    fases: '<circle cx="6" cy="6.5" r="2"/><circle cx="6" cy="17.5" r="2"/><path d="M6 8.5v7M10.5 6.5h9M10.5 17.5h9M10.5 12h6"/>',
    questionario: '<rect x="5" y="4.5" width="14" height="16" rx="2.2"/><path d="M9 3.5h6v2.5H9zM9 11h6M9 14.5h6M9 18h3.5"/>',
    anotacoes: '<path d="M5.5 4.5h13v10l-5 5h-8z"/><path d="M13.5 19.5v-5h5M8.5 9h7M8.5 12.5h4"/>',
    documentos: '<path d="M7 3.5h7l4.5 4.5v12.5H7z"/><path d="M14 3.5V8h4.5M10 12.5h5.5M10 16h5.5"/>',
    linha: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7v5l3.5 2M3.5 12H2"/>',
    processos: '<rect x="3.5" y="7.5" width="17" height="12" rx="2"/><path d="M9 7.5V5.5a1.5 1.5 0 0 1 1.5-1.5h3A1.5 1.5 0 0 1 15 5.5v2M3.5 12.5h17"/>', local: '<path d="M12 21s-6.5-5.6-6.5-11a6.5 6.5 0 0 1 13 0C18.5 15.4 12 21 12 21z"/><circle cx="12" cy="10" r="2.3"/>'
  };
  function ic(n) { return '<svg class="nc-cp-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  function estrelas(n) {
    var h = ''; for (var k = 1; k <= 5; k++) h += '<svg class="nc-cp-estrela' + (k <= n ? ' is-cheia' : '') + '" viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3.8l2.5 5.1 5.6.8-4 3.9.9 5.6-5-2.6-5 2.6.9-5.6-4-3.9 5.6-.8z"/></svg>';
    return '<span class="nc-cp-nota" title="Nota ' + n + ' de 5" aria-label="Nota ' + n + ' de 5">' + h + '</span>';
  }
  function botaoPorTexto(rx) { return [].filter.call(document.querySelectorAll('button.t-Button, a.t-Button'), function (b) { return rx.test(b.textContent.trim()); })[0]; }
  function copiar(t, b) {
    if (!navigator.clipboard || !navigator.clipboard.writeText) return;
    navigator.clipboard.writeText(t).then(function () { b.classList.add('is-copiado'); setTimeout(function () { b.classList.remove('is-copiado'); }, 1600); }, function () { /* sem permissão */ });
  }
  function bCopiar(t, rot) { return '<button type="button" class="nc-cp-copiar" data-copiar="' + esc(t) + '" title="' + esc(rot) + '" aria-label="' + esc(rot) + '">' + ic('copiar') + '</button>'; }
  function fato(rot, val) { return vazio(String(val).replace(/<[^>]+>/g, '')) ? '' : '<div><dt>' + esc(rot) + '</dt><dd>' + val + '</dd></div>'; }

  /* ═══ [K2] LER ═══════════════════════════════════════════════════════════════════════════
     CUIDADO  "DADOS DO CANDIDATO" é HTML montado na consulta: <label class="label">Rótulo
              </label><br>valor<br><br>. Os relatórios são lidos pelo TÍTULO das colunas
              (sem acento, minúsculo), não pela posição: mudou o título, mude aqui.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function regiaoPorTitulo(rx) {
    return [].filter.call(document.querySelectorAll('.t-Region'), function (r) { var h = r.querySelector('.t-Region-title'); return h && rx.test(sem(h.textContent)); })[0];
  }
  function lerDados(reg) {
    var o = {}, corpo = reg.querySelector('.t-Region-body');
    [].forEach.call(corpo.querySelectorAll('label.label'), function (l) {
      var v = '', n = l.nextSibling;
      while (n && !(n.nodeType === 1 && n.matches && n.matches('label.label'))) {
        if (n.nodeType === 3) v += n.textContent; else if (n.nodeType === 1 && !n.matches('br')) v += ' ' + (n.matches('a') ? (n.firstChild && n.firstChild.nodeType === 3 ? n.firstChild.textContent : '') : n.textContent);
        n = n.nextSibling;
      }
      o[sem(l.textContent)] = v.replace(/\s+/g, ' ').trim();
    });
    var p = corpo.querySelector('p'); o._linha = p ? p.textContent.replace(/\s+/g, ' ').trim() : '';
    var nota = corpo.querySelector('.a-StarRating input'); o._nota = nota ? Math.max(0, Math.min(5, Math.round(+nota.value || 0))) : null;
    return o;
  }
  /* um relatório interativo vira uma lista de objetos { 'titulo da coluna': texto, _td: {…} } */
  function lerIR(container) {
    if (!container) return [];
    /* CUIDADO: o relatório tem DUAS tabelas a-IRR-table (o cabeçalho fixo, sem dados, e a de
       dados): os títulos vêm de qualquer uma, as linhas só de quem tem td[headers] */
    var tabs = container.querySelectorAll('table.a-IRR-table'); if (!tabs.length) return [];
    var nomes = {};
    [].forEach.call(container.querySelectorAll('table.a-IRR-table th[id]'), function (th) { nomes[th.id] = sem(th.textContent); });
    var out = [];
    [].forEach.call(container.querySelectorAll('table.a-IRR-table tr'), function (tr) {
      var tds = tr.querySelectorAll('td[headers]'); if (!tds.length) return;
      var o = { _td: {}, _tr: tr };
      [].forEach.call(tds, function (td) {
        var k = nomes[td.getAttribute('headers')] || sem(td.getAttribute('headers'));
        var v = td.textContent.replace(/\s+/g, ' ').trim();
        o[k] = vazio(v) ? '' : v; o._td[k] = td;
      });
      out.push(o);
    });
    return out;
  }
  function painelDaAba(rx) {
    var a = [].filter.call(document.querySelectorAll('a.t-Tabs-link'), function (x) { return rx.test(sem(x.textContent)); })[0];
    return a ? document.getElementById(a.getAttribute('aria-controls')) : null;
  }

  /* ═══ [K3] O CARTÃO DO CANDIDATO ═════════════════════════════════════════════════════════ */
  function montarCartao(d, dp, faseHoje) {
    var nome = (dp && dp.nome) || (document.getElementById('P32_NOME_CANDIDATO') || {}).value || '';
    var social = dp && dp['nome social'] && sem(dp['nome social']) !== sem(nome) ? dp['nome social'] : '';
    var cel = (d.celular || '').replace(/\D/g, ''), tel = (d.telefone || '').replace(/\D/g, '');
    var mail = d['e-mail'] || (dp && dp['e-mail']) || '';
    var linha = d._linha.split(/\s+-\s+/).map(function (x) { return x.trim(); }).filter(Boolean);
    var idade = /\d+\s*anos?/i.test(linha[0] || '') ? linha.shift().replace(/anos?/i, 'anos') : '';
    var cidade = linha.join('/');
    var cod = (dp && dp['cod. candidato']) || '';
    var c = el('section', 'nc-cp-cartao');
    c.setAttribute('aria-label', 'O candidato');
    c.innerHTML =
      '<div class="nc-cp-quem"><span class="nc-cp-avatar" aria-hidden="true">' + esc(iniciais(nome)) + '</span><div>' +
        '<p class="nc-cp-nome">' + esc(nome) + (cod ? ' <span class="nc-cp-cod">' + esc(cod) + '</span>' : '') + '</p>' +
        (social ? '<p class="nc-cp-social">Nome social: ' + esc(social) + '</p>' : '') +
        '<p class="nc-cp-meta">' + [idade, cidade && ic('local') + esc(cidade)].filter(Boolean).map(function (x, i) { return i === 0 && idade ? esc(x) : x; }).join(' <span aria-hidden="true">·</span> ') + '</p>' +
        '<p class="nc-cp-etapa">' + (faseHoje ? '<span class="nc-cp-fase">' + esc(etapa(faseHoje)) + '</span>' : '') + '<span class="nc-cp-nota-viva"></span>' + '</p>' +
      '</div></div>' +
      '<div class="nc-cp-contato">' +
        (mail ? '<p>' + ic('email') + '<a href="mailto:' + esc(mail) + '">' + esc(mail) + '</a>' + bCopiar(mail, 'Copiar o e-mail') + '</p>' : '') +
        (cel ? '<p>' + ic('fone') + '<span>' + esc(fone(cel)) + '</span>' + bCopiar(cel, 'Copiar o celular') + '<a class="nc-cp-whats" href="https://api.whatsapp.com/send?phone=55' + esc(cel.replace(/^55(?=\d{10,11}$)/, '')) + '" target="_blank" rel="noopener" title="Conversar no WhatsApp" aria-label="Conversar no WhatsApp">' + ic('whats') + '</a></p>' : '') +
        (tel && tel !== cel ? '<p>' + ic('fone') + '<span>' + esc(fone(tel)) + '</span>' + bCopiar(tel, 'Copiar o telefone') + '</p>' : '') +
        (!mail && !cel && !tel ? '<p class="nc-cp-fraco">Sem e-mail ou telefone no cadastro.</p>' : '') +
      '</div>' +
      '<div class="nc-cp-acoes"></div>';
    /* CUIDADO: as estrelas são o item ORIGINAL P32_PONTUACAO, MOVIDO para o cartão — clicar
       dispara a ação "Update Pontuacao" (grava candidato.pontuacao). Não trocar por desenho
       próprio: em 03/10 o desenho era só leitura e a gravação parou. Sem o item, só o desenho. */
    var vivo = document.getElementById('P32_PONTUACAO'), lugar = c.querySelector('.nc-cp-nota-viva');
    if (vivo) {
      lugar.appendChild(vivo);
      lugar.title = 'Pontuação do candidato — clique numa estrela para gravar';
    } else if (d._nota !== null) lugar.outerHTML = estrelas(d._nota);
    var acoes = c.querySelector('.nc-cp-acoes');
    /* 04/10: "Remover Aprovação" e "Excluir Candidato" moram no mesmo cabeçalho da região "DADOS
       DO CANDIDATO" (que o Resumo esconde): vêm junto, senão sumiam da página */
    [[/^aprovar candidato$/i, 'nc-cp-bt--sucesso'], [/^avaliar fase$/i, 'nc-cp-bt--primario'], [/^visualizar cv$/i, ''],
      [/^remover aprova/i, ''], [/^excluir candidato$/i, '']].forEach(function (x) {
      var b = botaoPorTexto(x[0]); if (!b) return;
      b.classList.add('nc-cp-bt'); if (x[1]) b.classList.add(x[1]);
      var l = b.querySelector('.t-Button-label');
      if (l) l.textContent = /visualizar cv/i.test(b.textContent) ? 'Ver currículo' : frase(l.textContent.trim().charAt(0) + l.textContent.trim().slice(1).toLowerCase());
      acoes.appendChild(b);
    });
    return c;
  }

  /* ═══ [K4] AS ABAS ═══════════════════════════════════════════════════════════════════════
     PODE MEXER  ABAS: [como o título original começa (sem acento, minúsculo), nome novo,
                 ordem]. ordem 0 = a aba sai (o conteúdo dela foi para outra aba).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* [3] = ícone (IC); [4] = o que contar no painel da aba (a contagem aparece ao lado do nome) */
  var ABAS = [
    [/^dados do candidato/, 'Resumo', 1, 'resumo'], [/^avaliacoes/, 'Fases e avaliações', 2, 'fases', '.nc-cp-jornada > li'],
    [/^questionario/, 'Questionário', 3, 'questionario', '.nc-cp-q-grupo li'], [/^anotacoes/, 'Anotações', 4, 'anotacoes', '.t-Comments-item'],
    [/^documentos/, 'Documentos', 5, 'documentos', '.t-Cards-item'], [/^timeline/, 'Linha do tempo', 6, 'linha', '.t-Timeline-item'],
    [/^historico de processos/, 'Outros processos', 7, 'processos', '.nc-cp-proc-lista > li'],
    [/^dados pessoais/, '', 0], [/^fases$/, '', 0]
  ];
  /* a contagem de uma aba: zero deixa a aba apagada (ainda clicável); Documentos = anexados/total */
  function contarAba(x) {
    var painel = document.getElementById(x.li.getAttribute('aria-controls') || '');
    if (!painel || !x.cfg[4]) return null;
    var itens = painel.querySelectorAll(x.cfg[4]);
    if (x.cfg[3] === 'documentos' && itens.length) {
      var ok = [].filter.call(itens, function (c) { return c.classList.contains('classe_ok'); }).length;
      return { n: itens.length, txt: ok + '/' + itens.length, dica: ok + ' de ' + itens.length + ' documentos anexados' };
    }
    return { n: itens.length, txt: String(itens.length), dica: itens.length ? '' : 'Nada registrado' };
  }
  function arrumarAbas() {
    var ul = document.querySelector('ul.t-Tabs'); if (!ul) return;
    var itens = [].map.call(ul.querySelectorAll(':scope > li'), function (li) {
      var a = li.querySelector('a.t-Tabs-link'), t = sem(a ? a.textContent : '');
      var cfg = ABAS.filter(function (x) { return x[0].test(t); })[0];
      return { li: li, a: a, cfg: cfg };
    });
    itens.forEach(function (x) {
      if (!x.cfg) return;
      if (!x.cfg[2]) { x.li.classList.add('nc-cp-guardado'); return; }
      var c = contarAba(x);
      x.a.innerHTML = (x.cfg[3] ? ic(x.cfg[3]) : '') + '<span class="nc-cp-aba-nome">' + esc(x.cfg[1]) + '</span>' +
        (c && c.n ? '<span class="nc-cp-aba-conta">' + esc(c.txt) + '</span>' : '');
      if (c) { x.li.classList.toggle('is-vazia', !c.n); if (c.dica) x.a.title = c.dica; else x.a.removeAttribute('title'); }
    });
    itens.filter(function (x) { return x.cfg && x.cfg[2]; }).sort(function (a, b) { return a.cfg[2] - b.cfg[2]; }).forEach(function (x) { ul.appendChild(x.li); });
    itens.filter(function (x) { return !x.cfg; }).forEach(function (x) { ul.appendChild(x.li); });
    /* se a aba lembrada (localStorage do APEX) era uma das que saíram, abre o Resumo */
    var ativa = ul.querySelector('li.is-active, a.t-Tabs-link[aria-selected="true"]');
    var li = ativa && (ativa.closest('li') || ativa);
    if (li && li.classList.contains('nc-cp-guardado')) { var r = ul.querySelector('li:not(.nc-cp-guardado) a.t-Tabs-link'); if (r) r.click(); }
  }

  /* um relatório transformado ganha "Ver tabela" (mostra o relatório original no lugar) */
  function trocaTabela(cab, alvo) {
    var b = el('button', 'nc-cp-vertabela', ic('tabela') + '<span>Ver tabela</span>');
    b.type = 'button'; b.setAttribute('aria-pressed', 'false');
    b.addEventListener('click', function () {
      var on = alvo.classList.toggle('nc-cp-modo-tabela');
      b.setAttribute('aria-pressed', String(on)); b.querySelector('span').textContent = on ? 'Ver em cartões' : 'Ver tabela';
    });
    cab.appendChild(b);
  }

  /* ═══ [K5] RESUMO ═════════════════════════════════════════════════════════════════════════ */
  function montarResumo(reg, d, dp, faseHoje) {
    var corpo = reg.querySelector('.t-Region-body');
    /* o cabeçalho "DADOS DO CANDIDATO" repetia o nome da aba (os botões dele foram para o cartão) */
    var cabR = reg.querySelector('.t-Region-header'); if (cabR) cabR.classList.add('nc-cp-guardado');
    [].forEach.call(corpo.children, function (x) { x.classList.add('nc-cp-guardado'); });
    var end = [d.endereco, d.bairro, [d.cidade, d.uf].filter(Boolean).join('/'), d.cep && 'CEP ' + d.cep].filter(function (x) { return !vazio(x); });
    var grupos = [
      ['Contato', fato('E-mail', esc(d['e-mail'] || (dp && dp['e-mail']) || '')) + fato('Celular', esc(fone((d.celular || '').replace(/\D/g, '')))) + fato('Telefone', esc(fone((d.telefone || '').replace(/\D/g, ''))))],
      ['Perfil', fato('Nascimento', esc(d['data de nascimento'] || (dp && dp['data nascimento']) || '') + (dp && dp.idade ? ' <span class="nc-cp-fraco">· ' + esc(dp.idade) + ' anos</span>' : '')) +
        fato('Sexo', esc(dp && dp.sexo)) + (dp && dp.genero && sem(dp.genero) !== sem(dp.sexo) ? fato('Gênero', esc(dp.genero)) : '') +
        fato('Instrução', esc(d['grau de instrucao'] || (dp && dp['grau instrucao']))) + fato('Último cargo', esc(d['ultimo cargo'] || (dp && dp['ultimo cargo']))) +
        fato('Dependentes', esc(d['possui dependente(s)'] || (dp && dp['possui dependente']))) + fato('PCD', esc(d.pcd))],
      ['Endereço', end.length ? fato('Onde mora', esc(end.join(' · '))) : ''],
      ['No processo', fato('Etapa', esc(etapa(faseHoje || d.etapa))) + fato('Cadastro', esc(d.cadastro)) + fato('Candidaturas', esc(d['hist. de candidatura'])) +
        fato('Apresentação', esc(d['data apresentacao'])) + fato('Convocação', esc(d['data convocacao']))],
      ['Identificação', fato('Nome completo', esc(dp && dp.nome)) + fato('Nome social', esc(dp && dp['nome social'])) + fato('CPF', esc(dp && dp.cpf)) + fato('Identidade', esc(d['no identidade'] || d['nº identidade']))]
    ].filter(function (g) { return g[1]; });
    var r = el('div', 'nc-cp-resumo', grupos.map(function (g) { return '<section><h3>' + esc(g[0]) + '</h3><dl>' + g[1] + '</dl></section>'; }).join(''));
    corpo.appendChild(r);
  }

  /* ═══ [K6] FASES E AVALIAÇÕES ════════════════════════════════════════════════════════════
     Lidas do relatório AVALIACOES (fase, datas, avaliação, motivo, avaliador, nota, resultado,
     aprovado, lápis). Sem avaliação, as linhas do relatório FASES.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarFases(painel, aval, fases) {
    var linhas = aval.length ? aval : fases;
    if (!painel) return;
    var ir = painel.querySelector('.a-IRR-container'); if (!ir) return;
    var lista = el('div', 'nc-cp-vista nc-cp-fases');
    var cab = el('div', 'nc-cp-vista-cab', '<p>' + (linhas.length ? linhas.length + (linhas.length === 1 ? ' fase' : ' fases') + ' até aqui' : 'Nenhuma fase registrada') + '</p>');
    lista.appendChild(cab);
    var ol = el('ol', 'nc-cp-jornada');
    ol.innerHTML = linhas.map(function (f) {
      var ap = /^sim$/i.test(f.aprovado || ''), lap = f._td.link && f._td.link.querySelector('a[href]');
      var nota = f.nota !== undefined && f.nota !== '' ? f.nota : '';
      return '<li data-tom="' + (ap ? 'bom' : 'aberto') + '"><span class="nc-cp-marco" aria-hidden="true">' + (ap ? ic('check') : ic('relogio')) + '</span>' +
        '<div class="nc-cp-jornada-corpo"><p class="nc-cp-jornada-titulo"><b>' + esc(etapa(f.fase)) + '</b>' +
          '<span class="nc-cp-selo" data-tom="' + (ap ? 'bom' : 'aberto') + '">' + (ap ? 'Aprovado' : 'Em andamento') + '</span>' +
          (lap ? '<a class="nc-cp-bt nc-cp-bt--mini" href="' + esc(lap.getAttribute('href')) + '">' + ic('lapis') + 'Avaliar</a>' : '') + '</p>' +
          '<dl>' + fato('Na fase desde', esc(f['data da fase'] || f['dt fase'])) + fato('Avaliação', esc(f.avaliacao)) + fato('Motivo', esc(f['motivo de avaliacao'])) +
            fato('Avaliado em', esc(f['data de avaliacao'])) + fato('Avaliador', esc(f.avaliador)) + fato('Nota', esc(num(nota))) + fato('Resultado', esc(f['resultado fase'])) + '</dl></div></li>';
    }).join('');
    lista.appendChild(ol);
    ir.parentNode.insertBefore(lista, ir);
    painel.classList.add('nc-cp-transformado');
    trocaTabela(cab, painel);
  }

  /* ═══ [K7] QUESTIONÁRIO ══════════════════════════════════════════════════════════════════ */
  function montarQuestionario(painel, linhas) {
    if (!painel) return;
    var ir = painel.querySelector('.a-IRR-container'); if (!ir) return;
    var grupos = [], idx = {};
    linhas.forEach(function (q) {
      var k = (q.fase || '') + '|' + (q.questionario || '');
      if (!idx[k]) { idx[k] = { fase: q.fase, nome: q.questionario, max: q['nota maxima'], qs: [] }; grupos.push(idx[k]); }
      idx[k].qs.push(q);
    });
    var v = el('div', 'nc-cp-vista nc-cp-quest');
    var cab = el('div', 'nc-cp-vista-cab', '<p>' + (linhas.length ? linhas.length + ' respostas em ' + grupos.length + (grupos.length === 1 ? ' questionário' : ' questionários') : 'Nenhuma resposta de questionário') + '</p>');
    v.appendChild(cab);
    v.insertAdjacentHTML('beforeend', grupos.map(function (g) {
      return '<section class="nc-cp-q-grupo"><header><span class="nc-cp-fase">' + esc(etapa(g.fase)) + '</span><h3>' + esc(g.nome) + '</h3>' + (g.max ? '<span class="nc-cp-fraco">nota máxima ' + esc(g.max) + '</span>' : '') + '</header><ol>' +
        g.qs.map(function (q) {
          return '<li><p class="nc-cp-pergunta">' + esc(q.pergunta) + '</p><p class="nc-cp-resposta">' + (q.resposta ? esc(q.resposta) : '<span class="nc-cp-fraco">Sem resposta</span>') + '</p>' +
            '<p class="nc-cp-pontos">' + [q['nota da resposta'] !== '' && q['nota da resposta'] !== undefined ? 'nota <b>' + esc(num(q['nota da resposta'])) + '</b>' : '', q['peso da nota'] ? 'peso ' + esc(num(q['peso da nota'])) : ''].filter(Boolean).join(' · ') + '</p></li>';
        }).join('') + '</ol></section>';
    }).join(''));
    ir.parentNode.insertBefore(v, ir);
    painel.classList.add('nc-cp-transformado');
    trocaTabela(cab, painel);
  }

  /* ═══ [K8] OUTROS PROCESSOS ══════════════════════════════════════════════════════════════ */
  function montarProcessos(painel, linhas, atual) {
    if (!painel) return;
    var ir = painel.querySelector('.a-IRR-container'); if (!ir) return;
    var v = el('div', 'nc-cp-vista nc-cp-procs');
    var cab = el('div', 'nc-cp-vista-cab', '<p>' + (linhas.length === 1 ? '1 processo' : linhas.length + ' processos') + ' com este candidato</p>');
    v.appendChild(cab);
    var ul = el('ul', 'nc-cp-proc-lista');
    ul.innerHTML = linhas.map(function (p) {
      var cod = p['cod. requisicao'] || '', a = p._td.link && p._td.link.querySelector('a[href]');
      /* toda linha abre o que a lupa do relatório abre (o processo atual também: vai para o
         detalhe dele, a página 29) — é o mesmo destino da Tabela */
      var eu = cod && cod === atual;
      var corpo = '<p class="nc-cp-proc-vaga"><b>' + esc(frase(p.cargo)) + '</b> <span class="nc-cp-cod">' + esc(cod) + '</span>' + (eu ? ' <span class="nc-cp-selo" data-tom="info">este processo</span>' : '') + '</p>' +
        '<p class="nc-cp-fraco">' + [p.empresa, p.filial, p['centro de custo']].filter(Boolean).map(esc).join(' · ') + '</p>' +
        '<p class="nc-cp-fraco">' + [p.selecionador && 'Selecionador ' + nome(p.selecionador), p['fase processo requerimento'] && 'Fase ' + p['fase processo requerimento'], p['prazo contratacao'] && 'Prazo ' + p['prazo contratacao']].filter(Boolean).map(esc).join(' · ') + '</p>';
      return '<li' + (eu ? ' class="is-atual"' : '') + '><span class="nc-cp-selo" data-tom="' + (/aberta|publicada/i.test(p.status) ? 'aberto' : /fechad|contrat/i.test(p.status) ? 'bom' : 'neutro') + '">' + esc(p.status || '—') + '</span>' +
        (a ? '<a class="nc-cp-proc-corpo" href="' + esc(a.getAttribute('href')) + '">' + corpo + '</a>' + ic('abrir') : '<div class="nc-cp-proc-corpo">' + corpo + '</div>') + '</li>';
    }).join('');
    v.appendChild(ul);
    ir.parentNode.insertBefore(v, ir);
    painel.classList.add('nc-cp-transformado');
    trocaTabela(cab, painel);
  }

  /* ═══ [K9] ANOTAÇÕES E LINHA DO TEMPO ════════════════════════════════════════════════════ */
  function arrumarVazios() {
    var an = regiaoPorTitulo(/^anotacoes/), tl = regiaoPorTitulo(/^timeline/);
    if (an) {
      var b = [].filter.call(an.querySelectorAll('.t-Button'), function (x) { return /^adicionar$/i.test(x.textContent.trim()); })[0];
      if (b) { var l = b.querySelector('.t-Button-label'); if (l) l.textContent = 'Adicionar anotação'; }
      var nd = an.querySelector('.nodatafound'); if (nd) nd.textContent = 'Nenhuma anotação ainda. Registre aqui o que foi conversado ou combinado com o candidato.';
    }
    if (tl) { var n2 = tl.querySelector('.nodatafound'); if (n2) n2.textContent = 'Nada registrado na linha do tempo deste candidato.'; }
  }

  /* ═══ [K10] O MAESTRO ════════════════════════════════════════════════════════════════════ */
  function iniciar() {
    var regDados = regiaoPorTitulo(/^dados do candidato/); if (!regDados) return;
    window.__ncCandidatoProcesso = true;
    document.body.classList.add('nc-cp-ativo');
    var d = lerDados(regDados);
    var dp = lerIR(painelDaAba(/^dados pessoais/))[0] || null;
    var aval = lerIR(document.getElementById('AVALIACOES')), fases = lerIR(document.getElementById('FASES'));
    var faseHoje = d.etapa || (fases.length ? fases[fases.length - 1].fase : '');

    /* o alto é a VAGA, como na página 29: "ANALISTA DE SISTEMAS JUNIOR - 57463" vira o título
       "Analista de sistemas junior 57463" e embaixo "Ficha do candidato". O nome da pessoa fica
       só no cartão logo abaixo (no alto ele repetia o cartão). */
    var hero = document.querySelector('.t-HeroRegion-col--content');
    var processo = '';
    if (hero) {
      var h1 = hero.querySelector('.t-HeroRegion-title'), desc = '';
      [].forEach.call(hero.childNodes, function (n) { if (n.nodeType === 3 && n.textContent.trim()) { desc = n.textContent.trim(); hero.removeChild(n); } });
      desc = desc || (document.getElementById('P32_DESC_PROCESSO') || {}).value || '';
      var m = /^(.*?)\s*-\s*(\d+)\s*$/.exec(desc);
      processo = m ? m[2] : '';
      if (h1 && desc) {
        h1.innerHTML = esc(frase(m ? m[1] : desc)) + (m ? ' <span class="nc-cp-num">' + esc(m[2]) + '</span>' : '');
        h1.parentNode.insertBefore(el('p', 'nc-cp-sub', 'Ficha do candidato'), h1.nextSibling);
      }
    }
    /* "Pessoa anterior" vai para o alto, ao lado de Voltar */
    var pa = botaoPorTexto(/^pessoa anterior$/i), alto = document.querySelector('.t-HeroRegion-buttons');
    /* CUIDADO: a região do botão também guarda a barra das etapas; só a COLUNA vazia sai */
    if (pa && alto) { var colPa = pa.closest('.col'); pa.classList.add('nc-cp-bt'); var lp = pa.querySelector('.t-Button-label'); if (lp) lp.textContent = 'Pessoa anterior'; alto.insertBefore(pa, alto.firstChild); if (colPa && !colPa.querySelector('.t-Button, .t-WizardSteps, .t-Region')) colPa.classList.add('nc-cp-guardado'); }

    /* o cartão (a PESSOA) vem logo abaixo do alto (a VAGA), antes da barra das etapas — que mora
       no .t-Body-fullContent, acima do conteúdo. Sem essa área, fica antes das abas. */
    var abas = document.querySelector('.t-TabsRegion'), cheio = document.querySelector('.t-Body-fullContent');
    var cartao = montarCartao(d, dp, faseHoje);
    if (cheio && cheio.querySelector('.t-WizardSteps')) cheio.insertBefore(cartao, cheio.firstChild);
    else if (abas) abas.parentNode.insertBefore(cartao, abas); else regDados.parentNode.insertBefore(cartao, regDados);
    /* as estrelas foram movidas: redesenha com o valor de hoje, sem disparar a gravação */
    try { if (cartao.querySelector('#P32_PONTUACAO')) apex.item('P32_PONTUACAO').setValue(apex.item('P32_PONTUACAO').getValue(), null, true); } catch (x) { /* fica como está */ }

    montarResumo(regDados, d, dp, faseHoje);
    montarFases(painelDaAba(/^avaliacoes/), aval, fases);
    montarQuestionario(painelDaAba(/^questionario/), lerIR(painelDaAba(/^questionario/)));
    montarProcessos(painelDaAba(/^historico de processos/), lerIR(document.getElementById('VAGAS')), processo);
    arrumarVazios();
    arrumarAbas();

    document.addEventListener('click', function (ev) {
      var b = ev.target.closest('[data-copiar]'); if (b) copiar(b.getAttribute('data-copiar'), b);
    });
  }
  var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp candidato]', e); } }, 0); };
  if (document.readyState === 'complete') vai();
  else { if (window.apex.gPageContext$) $(apex.gPageContext$).one('apexreadyend', vai); window.addEventListener('load', vai); }
})();
