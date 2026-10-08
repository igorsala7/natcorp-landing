/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · ELEIÇÃO DA CIPA  —  o "arrumador" das duas telas (JavaScript)                 ║
   ║  App 2942 (Segurança do Trabalho - CIPA) · Página 34 (lista) · Página 35 (confirmação)   ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia destas páginas: CIPA-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quem vota é o COLABORADOR, quase sempre pelo celular e muitas vezes com pouca leitura. Então:
     • PÁGINA 34 (a lista): no alto, o que é a eleição e COMO votar em 3 passos curtos, com
       "você vota uma vez só"; quando a inscrição está aberta (o botão Inscrever-se aparece),
       um cartão "Quer ser candidato?" com o botão ORIGINAL. Cada candidato vira um cartão
       grande: as iniciais num círculo, o nome (sem caixa alta), o apelido, o cargo, o setor e a
       unidade, e o botão "Votar". Mais de 6 na página: busca pelo nome. Lista vazia: um aviso
       claro. Depois de votar, a faixa "Pronto! Seu voto foi registrado" e o selo "Seu voto".
     • PÁGINA 35 (a janela de confirmação): em vez de uma frase solta, o cartão de QUEM recebe o
       voto (o mesmo da lista), a pergunta, o aviso de que não dá para trocar, e os botões
       ORIGINAIS ("Confirmar meu voto" e "Voltar"). As outras respostas da página — "Voto já
       realizado" e "o período de votação é entre…" — viram telas próprias e claras.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Nada é gravado por aqui. O toque no cartão é o clique no LINK ORIGINAL da lista (abre a
     página 35 com os mesmos itens); o "Confirmar meu voto" é o botão ORIGINAL (o processo
     CONFIRMAR VOTO grava e a janela fecha com "Voto Confirmado com Sucesso!"). Continuam
     valendo: a consulta (quem pode votar, desistentes fora), a paginação, a condição do
     botão Inscrever-se e a ação que reenvia a página ao fechar a inscrição, a ação que
     esconde os Filtros no painel do colaborador, a condição do Confirmar (período, candidato
     e voto único) e o texto que a página calcula. Tirou as URLs: volta o de antes.
     Única trava acrescentada: o 2º toque no Confirmar é ignorado enquanto a página envia (o
     processo grava sem conferir se já existe voto — dois toques gravariam dois).

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Páginas 34 e 35 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Cipa.js
     Páginas 34 e 35 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Cipa.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [J1] Como as páginas são reconhecidas                                 CUIDADO
     [J2] Os textos                                                        PODE MEXER
     [J3] Ferramentas (nomes sem caixa alta, iniciais, cores, ícones)
     [J4] Página 34 · o alto (a eleição e como votar)
     [J5] Página 34 · os candidatos (lê a lista original)                  CUIDADO
     [J6] Página 34 · depois de votar
     [J7] Página 35 · a confirmação
     [J8] O maestro
*/
(function () {
  'use strict';
  if (window.__ncCipa || !window.apex || !window.apex.jQuery) return;
  window.__ncCipa = true;
  var $ = window.apex.jQuery;

  /* ═══ [J1] COMO AS PÁGINAS SÃO RECONHECIDAS ══════════════════════════════════════════════
     CUIDADO  pelos ITENS, não pelo número da página: a 34 tem P34_CAND_MATRICULA (nos Filtros,
              que ficam na página mesmo escondidos), a 35 tem P35_TEXTO e P35_CAND_MATRICULA.
              A lista: a região cujo título fala em "candidat" e que tem o relatório (…_catch).
              O alto: a 1ª t-HeroRegion. Os botões: pelo TEXTO (Inscrever, Confirmar, Voltar).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  var E34 = !!$id('P34_CAND_MATRICULA');
  var E35 = !!($id('P35_CAND_MATRICULA') && ($id('P35_TEXTO') || $id('P35_TEXTO_DISPLAY')));
  if (!E34 && !E35) return;

  /* ═══ [J2] OS TEXTOS ═════════════════════════════════════════════════════════════════════
     PODE MEXER  tudo daqui. Frases curtas, palavras do dia a dia: quem lê é o colaborador.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var TOQUE = !!(window.matchMedia && window.matchMedia('(pointer: coarse)').matches);
  var VERBO = TOQUE ? 'Toque' : 'Clique';
  var T = {
    titulo: 'Eleição da CIPA',
    explica: 'A CIPA é a comissão de colegas que ajuda a prevenir acidentes no trabalho. Escolha quem vai representar você.',
    passos: [
      ['Escolha', VERBO + ' na pessoa que você quer.'],
      ['Confira', 'Veja se é a pessoa certa.'],
      ['Confirme', VERBO + ' em "Confirmar meu voto".']
    ],
    umaVez: 'Você vota uma vez só.',
    inscricaoTit: 'Quer ser candidato?',
    inscricaoTxt: 'As inscrições estão abertas.',
    listaTit: 'Candidatos',
    listaInstr: VERBO + ' em quem você quer escolher.',
    busca: 'Procurar pelo nome',
    semBusca: 'Nenhum nome encontrado.',
    vazioTit: 'Nenhum candidato por enquanto',
    vazioTxt: 'Quando houver candidatos nesta eleição, eles aparecem aqui.',
    votar: 'Votar',
    seuVoto: 'Seu voto',
    votouTit: 'Pronto! Seu voto foi registrado.',
    votouTxt: 'Obrigado por participar da eleição da CIPA.',
    /* página 35 */
    pergunta: 'Você quer votar nesta pessoa?',
    naoTroca: 'Depois de confirmar, não dá para trocar o voto.',
    confirmar: 'Confirmar meu voto',
    enviando: 'Registrando seu voto…',
    voltarOutra: 'Voltar e escolher outra pessoa',
    voltar: 'Voltar',
    jaVotouTit: 'Você já votou',
    jaVotouTxt: 'Seu voto nesta eleição já foi registrado. Obrigado por participar!',
    foraTit: 'A votação não está aberta agora',
    foraSemData: 'Agora não é o período de votação.'
  };
  function foraTxt(de, ate) { return 'Você pode votar de <b>' + esc(de) + '</b> até <b>' + esc(ate) + '</b>.'; }

  /* ═══ [J3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/\s+/g, ' ').trim(); }
  function semAcento(t) { return limpo(t).toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  /* "JOSE DA SILVA" → "Jose da Silva". Só mexe no que veio TODO em caixa alta; siglas sem vogal (RH, SST) ficam */
  var MIUDAS = /^(da|de|do|das|dos|e|em|na|no|nas|nos|a|o|as|os)$/;
  function bonito(t) {
    t = limpo(t);
    if (!t || t !== t.toUpperCase()) return t;
    return t.toLowerCase().replace(/[^\s\-\/().]+/g, function (w, i) {
      if (i > 0 && MIUDAS.test(w)) return w;
      if (!/[aeiouáéíóúâêôãõà]/.test(w)) return w.toUpperCase();
      return w.charAt(0).toUpperCase() + w.slice(1);
    });
  }
  function iniciais(nome) {
    var p = limpo(nome).split(' ').filter(function (w) { return w && !MIUDAS.test(w.toLowerCase()); });
    if (!p.length) return '?';
    return (p[0].charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase();
  }
  /* cada pessoa ganha sempre a mesma cor (pelo nome): ajuda a reconhecer na lista e na confirmação */
  var CORES = [['#EFE6F7', '#511C76'], ['#FBE7EF', '#8E2F5C'], ['#E2EFF3', '#1F5A6B'], ['#E6F3EC', '#1F6B45'], ['#FFF0DA', '#7A4B00'], ['#ECEAF8', '#3E3A8C']];
  function corDe(nome) { var h = 0, s = semAcento(nome); for (var i = 0; i < s.length; i++) h = (h * 31 + s.charCodeAt(i)) >>> 0; return CORES[h % CORES.length]; }
  var IC = {
    urna: '<path d="M4.5 12.5h15v7a1 1 0 0 1-1 1h-13a1 1 0 0 1-1-1z"/><path d="M8 12.5V5.5a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1v7"/><path d="M10 8.5l1.6 1.6L14.5 7"/><path d="M8 16.5h8"/>',
    pessoa: '<circle cx="12" cy="8.5" r="3.7"/><path d="M5 20c.9-3.6 3.6-5.6 7-5.6s6.1 2 7 5.6"/>',
    pessoas: '<circle cx="9" cy="8.5" r="3.2"/><path d="M3 19.5c.7-3.2 3-5 6-5s5.3 1.8 6 5"/><circle cx="17" cy="9.5" r="2.5"/><path d="M16.5 14.6c2.3.2 3.9 1.7 4.5 4.4"/>',
    maleta: '<rect x="3.5" y="7.5" width="17" height="12" rx="2"/><path d="M9 7.5V6a1.5 1.5 0 0 1 1.5-1.5h3A1.5 1.5 0 0 1 15 6v1.5M3.5 12.5h17"/>',
    predio: '<path d="M5 20.5V5.5a1 1 0 0 1 1-1h8a1 1 0 0 1 1 1v15M15 9.5h3a1 1 0 0 1 1 1v10M3.5 20.5h17M8.5 8.5h3M8.5 12h3M8.5 15.5h3"/>',
    info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5M12 8v.5"/>',
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>',
    seta: '<path d="M9.5 6l6 6-6 6"/>',
    lupa: '<circle cx="11" cy="11" r="6"/><path d="M20 20l-4.5-4.5"/>',
    calendario: '<rect x="4" y="5.5" width="16" height="14.5" rx="2"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4"/>',
    mais: '<circle cx="12" cy="12" r="8.5"/><path d="M12 8.5v7M8.5 12h7"/>'
  };
  function ic(n, cls) { return '<svg class="nc-cp-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  function guardar(chave, v) { try { sessionStorage.setItem(chave, JSON.stringify(v)); } catch (e) { /* aba privada: segue sem */ } }
  function ler(chave) { try { var v = sessionStorage.getItem(chave); return v ? JSON.parse(v) : null; } catch (e) { return null; } }
  function botaoPorTexto(raiz, re) {
    return [].filter.call((raiz || document).querySelectorAll('button, a.t-Button'), function (b) { return re.test(limpo(b.textContent)); })[0] || null;
  }
  /* o cartão de uma pessoa (o mesmo na lista e na confirmação) */
  function avatar(c, cls) {
    var cor = c.cor || corDe(c.nome);
    return '<span class="nc-cp-avatar' + (cls ? ' ' + cls : '') + '" style="--av-bg:' + cor[0] + ';--av-tx:' + cor[1] + '" aria-hidden="true">' + esc(c.ini || iniciais(c.nome)) + '</span>';
  }
  function detalhes(c, comEmpresa) {
    var h = '';
    if (c.apelido) h += '<span class="nc-cp-apelido">Conhecido como ' + esc(c.apelido) + '</span>';
    if (c.cargo) h += '<span class="nc-cp-cargo">' + ic('maleta') + '<span>' + esc(c.cargo) + '</span></span>';
    var onde = [];
    if (c.setor) onde.push('Setor: ' + esc(c.setor));
    if (c.unidade) onde.push('Unidade: ' + esc(c.unidade));
    if (comEmpresa && c.empresa) onde.push('Empresa: ' + esc(c.empresa));
    if (onde.length) h += '<span class="nc-cp-onde">' + ic('predio') + '<span>' + onde.join(' · ') + '</span></span>';
    return h;
  }

  /* ═══ [J4] PÁGINA 34 · O ALTO ════════════════════════════════════════════════════════════
     A região "CIPA" (modelo Hero) continua na página: o conteúdo dela sai da vista e o nosso
     entra no lugar. A 2ª frase do texto original ("Para realizar a sua inscrição clique no
     botão 'Inscrever - se'") só faz sentido COM o botão: vira o cartão da inscrição, que só
     aparece quando a condição do botão deixa ele na página.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarAlto(lista) {
    var hero = document.querySelector('.t-HeroRegion');
    var topo = el('section', 'nc-cp-topo');
    topo.setAttribute('aria-labelledby', 'nc-cp-titulo');
    topo.innerHTML =
      '<div class="nc-cp-topo-cab">' +
        '<span class="nc-cp-selo">' + ic('urna') + '</span>' +
        '<div><h1 id="nc-cp-titulo">' + esc(T.titulo) + '</h1><p>' + esc(T.explica) + '</p></div>' +
      '</div>' +
      '<ol class="nc-cp-passos" aria-label="Como votar">' + T.passos.map(function (p, i) {
        return '<li><span class="nc-cp-passo-n" aria-hidden="true">' + (i + 1) + '</span><span><b>' + esc(p[0]) + '</b>' + esc(p[1]) + '</span></li>';
      }).join('') + '</ol>' +
      '<p class="nc-cp-umavez">' + ic('info') + '<span>' + esc(T.umaVez) + '</span></p>';
    if (hero) {
      var wrap = hero.querySelector('.t-HeroRegion-wrap');
      if (wrap) wrap.classList.add('nc-cp-guardado');
      hero.classList.add('nc-cp-hero');
      hero.appendChild(topo);
    } else if (lista) {
      lista.parentNode.insertBefore(topo, lista);
    }
    /* o botão Inscrever-se (o original, com a ação que reenvia a página ao fechar a janela) */
    var insc = lista && botaoPorTexto(lista, /inscrever/i);
    if (insc) {
      var cartao = el('div', 'nc-cp-inscricao',
        '<span class="nc-cp-inscricao-ic">' + ic('mais') + '</span>' +
        '<span class="nc-cp-inscricao-txt"><b>' + esc(T.inscricaoTit) + '</b>' + esc(T.inscricaoTxt) + '</span>');
      insc.classList.add('nc-cp-bt-inscrever');
      cartao.appendChild(insc);
      topo.appendChild(cartao);
    }
  }

  /* ═══ [J5] PÁGINA 34 · OS CANDIDATOS ═════════════════════════════════════════════════════
     CUIDADO  lê a lista ORIGINAL (modelo Media List): o título (.t-MediaList-title) traz
              "NOME (APELIDO: x) (NOME SOCIAL: y)" e a descrição (.t-MediaList-desc) traz
              "Empresa <b>…</b> Filial <b>…</b> Centro de Custo <b>…</b> Cargo <b>…</b>". Se a
              consulta mudar esses rótulos, o cartão perde a linha correspondente (o nome fica).
              O nome social, quando existe, é o nome mostrado (é como a pessoa é chamada).
              O link de cada linha leva os itens da página 35; dele sai a chave da pessoa
              (empresa-matrícula) e o código da CIPA, para a confirmação mostrar o mesmo cartão.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var LISTA = null, CARDS = null, CANDS = [], BUSCA = null;
  function lerItens(catchEl) {
    return [].map.call(catchEl.querySelectorAll('.t-MediaList-item'), function (li) {
      var a = li.querySelector('a[href]');
      var tit = limpo((li.querySelector('.t-MediaList-title') || {}).textContent);
      var desc = li.querySelector('.t-MediaList-desc');
      var apelido = (/\(APELIDO:\s*([^)]*)\)/i.exec(tit) || [])[1];
      var social = (/\(NOME SOCIAL:\s*([^)]*)\)/i.exec(tit) || [])[1];
      var civil = limpo(tit.replace(/\s*\((APELIDO|NOME SOCIAL):[^)]*\)/gi, ''));
      var c = { a: a, nome: bonito(social || civil), apelido: apelido ? bonito(apelido) : '' };
      if (desc) [].forEach.call(desc.querySelectorAll('b'), function (b) {
        var r = b.previousSibling, rot = '';
        while (r && !rot) { rot = r.nodeType === 3 ? limpo(r.textContent) : ''; r = r.previousSibling; }
        var v = bonito(b.textContent);
        if (/^empresa/i.test(rot)) c.empresa = v;
        else if (/^filial/i.test(rot)) c.unidade = v;
        else if (/centro/i.test(rot)) c.setor = v;
        else if (/^cargo/i.test(rot)) c.cargo = v;
      });
      var href = '';
      try { href = decodeURIComponent((a && a.getAttribute('href')) || ''); } catch (e) { href = (a && a.getAttribute('href')) || ''; }
      var m = /P35_COD_EMPRESA,P35_COD_FILIAL,P35_COD_CIPA,P35_CAND_COD_EMPRESA,P35_CAND_MATRICULA:([^&'"\s]+)/i.exec(href);
      var v = m ? m[1].split(',') : [];
      c.cipa = v[2] || '';
      c.chave = v.length >= 5 ? v[3] + '-' + v[4] : '';
      c.ini = iniciais(c.nome);
      c.cor = corDe(c.nome);
      return c;
    });
  }
  function votoDaSessao() { var c = CANDS[0]; return c && c.cipa ? ler('nc-cipa-votou:' + c.cipa) : null; }
  function montarLista() {
    var catchEl = LISTA && LISTA.querySelector('[id$="_catch"]');
    if (!catchEl) return;
    var ul = catchEl.querySelector('.t-MediaList');
    var vazio = catchEl.querySelector('.nodatafound');
    CANDS = lerItens(catchEl);
    if (ul) ul.classList.add('nc-cp-guardado');
    if (vazio) vazio.classList.add('nc-cp-guardado');
    /* a lista só é trocada se TODOS os itens foram lidos (com link); senão fica a original */
    if (ul && CANDS.some(function (c) { return !c.a; })) { ul.classList.remove('nc-cp-guardado'); return; }
    var corpo = catchEl.parentNode;
    var antigo = corpo.querySelector('.nc-cp-lista'); if (antigo) antigo.remove();
    var box = el('div', 'nc-cp-lista');
    var empresas = {}; CANDS.forEach(function (c) { if (c.empresa) empresas[c.empresa] = 1; });
    var comEmpresa = Object.keys(empresas).length > 1;
    var voto = votoDaSessao();
    var h = '<div class="nc-cp-lista-cab"><h2>' + esc(T.listaTit) +
      (CANDS.length ? ' <span class="nc-cp-conta">' + CANDS.length + '</span>' : '') + '</h2>' +
      (CANDS.length ? '<p>' + esc(T.listaInstr) + '</p>' : '') + '</div>';
    if (voto) h += '<div class="nc-cp-votou" role="status">' + ic('check') + '<span><b>' + esc(T.votouTit) + '</b>' + esc(T.votouTxt) + '</span></div>';
    if (CANDS.length > 6) h += '<label class="nc-cp-busca">' + ic('lupa') + '<span class="nc-cp-so-leitor">' + esc(T.busca) + '</span><input type="search" autocomplete="off" placeholder="' + esc(T.busca) + '"></label>';
    if (!CANDS.length) {
      h += '<div class="nc-cp-vazio">' + ic('pessoas') + '<b>' + esc(T.vazioTit) + '</b><span>' + esc(T.vazioTxt) + '</span></div>';
    } else {
      h += '<ul class="nc-cp-cards">' + CANDS.map(function (c, i) {
        var meu = voto && c.chave && voto === c.chave;
        return '<li><button type="button" class="nc-cp-card' + (meu ? ' nc-cp-card--meu' : '') + '" data-i="' + i + '" aria-label="' + esc(T.votar + ' em ' + c.nome + (c.cargo ? ', ' + c.cargo : '')) + '">' +
          avatar(c) +
          '<span class="nc-cp-info"><span class="nc-cp-nome">' + esc(c.nome) + '</span>' + detalhes(c, comEmpresa) + '</span>' +
          (meu ? '<span class="nc-cp-selo-voto">' + ic('check') + esc(T.seuVoto) + '</span>'
               : '<span class="nc-cp-votar" aria-hidden="true">' + esc(T.votar) + ic('seta') + '</span>') +
          '</button></li>';
      }).join('') + '</ul><p class="nc-cp-sem-busca" hidden>' + esc(T.semBusca) + '</p>';
    }
    box.innerHTML = h;
    corpo.insertBefore(box, catchEl);
    CARDS = box.querySelector('.nc-cp-cards');
    BUSCA = box.querySelector('.nc-cp-busca input');
    if (BUSCA) BUSCA.addEventListener('input', filtrar);
  }
  function filtrar() {
    var q = semAcento(BUSCA.value), n = 0;
    [].forEach.call(CARDS.children, function (li, i) {
      var c = CANDS[i], ok = !q || semAcento(c.nome + ' ' + (c.apelido || '')).indexOf(q) >= 0;
      li.hidden = !ok; if (ok) n++;
    });
    LISTA.querySelector('.nc-cp-sem-busca').hidden = n > 0;
  }
  /* o toque no cartão: guarda quem é (para a confirmação mostrar o mesmo cartão) e clica o link original */
  function aoTocar(e) {
    var b = e.target.closest('.nc-cp-card'); if (!b) return;
    var c = CANDS[+b.getAttribute('data-i')]; if (!c || !c.a) return;
    if (c.chave) guardar('nc-cipa-cand:' + c.chave, { nome: c.nome, apelido: c.apelido, cargo: c.cargo, setor: c.setor, unidade: c.unidade, ini: c.ini, cor: c.cor });
    ULTIMO = c;
    c.a.click();
  }

  /* ═══ [J6] PÁGINA 34 · DEPOIS DE VOTAR ═══════════════════════════════════════════════════
     A janela 35 fecha com a mensagem "Voto Confirmado com Sucesso!" (processo Close Dialog).
     Com ela, a lista mostra a faixa de agradecimento e o selo "Seu voto" no cartão escolhido
     (guardado na sessão do navegador, por CIPA). Sem a mensagem (Voltar, Esc), nada muda.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ULTIMO = null;
  function aoFecharJanela(e, data) {
    var ok = data && data.successMessage && data.successMessage.text;
    if (!ok || !ULTIMO || !ULTIMO.cipa || !ULTIMO.chave) return;
    guardar('nc-cipa-votou:' + ULTIMO.cipa, ULTIMO.chave);
    montarLista();
  }

  function iniciar34() {
    LISTA = [].filter.call(document.querySelectorAll('.t-Region'), function (r) {
      var t = r.querySelector('.t-Region-title');
      return t && /candidat/i.test(t.textContent) && r.querySelector('[id$="_catch"]');
    })[0] || null;
    document.body.classList.add('nc-cp-ativo', 'nc-cp-p34');
    montarAlto(LISTA);
    if (!LISTA) return;
    LISTA.classList.add('nc-cp-regiao-lista');
    montarLista();
    LISTA.addEventListener('click', aoTocar);
    $(LISTA).on('apexafterrefresh', montarLista);            /* a paginação recarrega só a região */
    $(window).on('apexafterclosedialog', aoFecharJanela);   /* o link chama a janela com "this" = window */
    $(document).on('apexafterclosedialog', function (e, d) { if (e.target !== window) aoFecharJanela(e, d); });
  }

  /* ═══ [J7] PÁGINA 35 · A CONFIRMAÇÃO ═════════════════════════════════════════════════════
     LÊ  o texto que a própria página calcula (P35_TEXTO, processo "Inicio"), um de três:
           "Deseja confirmar seu voto em NOME?"   → o cartão da pessoa + pergunta + botões
           "Voto Já Realizado!"                    → "Você já votou"
           "O Periodo de votação é entre: X e Y"   → "A votação não está aberta agora"
         O botão Confirmar só existe quando a página deixa (período, candidato e voto único).
         Sem ele, mesmo com a pergunta, fica só o texto da página e o Voltar.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function iniciar35() {
    var alvo = $id('P35_TEXTO_DISPLAY') || $id('P35_TEXTO');
    var txt = limpo(alvo ? (alvo.value != null && alvo.tagName === 'INPUT' ? alvo.value : alvo.textContent) : '');
    var reg = (alvo && alvo.closest('.t-Region')) || document.querySelector('.t-Region');
    if (!reg) return;
    var bSim = botaoPorTexto(reg, /confirmar/i), bNao = botaoPorTexto(reg, /voltar/i);
    var estado = /j[aá]\s+realizado/i.test(txt) ? 'votou'
      : /per[ií]odo\s+de\s+vota/i.test(txt) ? 'fora'
      : (bSim && /deseja\s+confirmar/i.test(txt)) ? 'confirmar' : 'outro';
    document.body.classList.add('nc-cp-ativo', 'nc-cp-p35');
    reg.classList.add('nc-cp-regiao-conf');
    var cx = alvo && alvo.closest('.t-Form-fieldContainer'); if (cx) cx.classList.add('nc-cp-guardado');

    var box = el('div', 'nc-cp-conf nc-cp-conf--' + estado), h = '';
    if (estado === 'confirmar') {
      var chave = (apex.item('P35_CAND_COD_EMPRESA').getValue() || '') + '-' + (apex.item('P35_CAND_MATRICULA').getValue() || '');
      var nomeTxt = bonito((/em\s+(.+?)\s*\?\s*$/i.exec(txt) || [])[1] || '');
      var c = ler('nc-cipa-cand:' + chave) || { nome: nomeTxt };
      if (!c.nome) c.nome = nomeTxt;
      h = '<div class="nc-cp-conf-pessoa">' + avatar(c, 'nc-cp-avatar--g') +
        '<h2 class="nc-cp-conf-nome">' + esc(c.nome) + '</h2>' +
        '<div class="nc-cp-conf-det">' + detalhes(c, false) + '</div></div>' +
        '<p class="nc-cp-pergunta">' + esc(T.pergunta) + '</p>' +
        '<p class="nc-cp-aviso">' + ic('info') + '<span>' + esc(T.naoTroca) + '</span></p>';
    } else if (estado === 'votou') {
      h = '<span class="nc-cp-estado-ic nc-cp-estado-ic--bom">' + ic('check') + '</span>' +
        '<h2>' + esc(T.jaVotouTit) + '</h2><p>' + esc(T.jaVotouTxt) + '</p>';
    } else if (estado === 'fora') {
      var m = /entre:\s*(.*?)\s+e\s+(.*?)\s*$/i.exec(txt);
      var de = m && limpo(m[1]), ate = m && limpo(m[2]);
      h = '<span class="nc-cp-estado-ic">' + ic('calendario') + '</span>' +
        '<h2>' + esc(T.foraTit) + '</h2><p>' + (de && ate ? foraTxt(de, ate) : esc(T.foraSemData)) + '</p>';
    } else {
      h = '<p class="nc-cp-conf-texto">' + esc(txt) + '</p>';
    }
    box.innerHTML = h;
    var acoes = el('div', 'nc-cp-acoes');
    if (estado === 'confirmar' && bSim) { rotulo(bSim, T.confirmar); bSim.classList.add('nc-cp-bt-sim'); acoes.appendChild(bSim); travarDuplo(bSim); }
    else if (bSim) { bSim.classList.add('nc-cp-bt-sim'); acoes.appendChild(bSim); }
    if (bNao) { rotulo(bNao, estado === 'confirmar' ? T.voltarOutra : T.voltar); bNao.classList.add('nc-cp-bt-nao'); acoes.appendChild(bNao); }
    box.appendChild(acoes);
    var corpo = reg.querySelector('.t-Region-body') || reg;
    corpo.insertBefore(box, corpo.firstChild);
    if (bSim && estado === 'confirmar') setTimeout(function () { try { bSim.focus({ preventScroll: true }); } catch (e) { /* ok */ } }, 60);
  }
  function rotulo(b, t) { var l = b.querySelector('.t-Button-label'); if (l) l.textContent = t; else b.textContent = t; }
  /* o 1º toque envia; os seguintes, enquanto a página envia, não (o processo grava sem conferir) */
  function travarDuplo(b) {
    var foi = false;
    b.addEventListener('click', function (e) {
      if (foi) { e.preventDefault(); e.stopImmediatePropagation(); return; }
      foi = true;
      setTimeout(function () { b.classList.add('nc-cp-enviando'); b.setAttribute('aria-disabled', 'true'); rotulo(b, T.enviando); }, 0);
    }, true);
  }

  /* ═══ [J8] O MAESTRO ═════════════════════════════════════════════════════════════════════
     Monta DEPOIS das ações de abertura da página (apexreadyend): a 34 esconde os Filtros no
     painel do colaborador na abertura. Sem o evento em 3 s, monta assim mesmo (uma vez só).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var montado = false;
  function iniciar() {
    if (montado) return;
    montado = true;
    try { if (E34) iniciar34(); else iniciar35(); } catch (e) { if (window.console) console.error('Natcorp_Cipa', e); }
  }
  $(window).one('apexreadyend', iniciar);
  $(function () { setTimeout(iniciar, 3000); });
})();
