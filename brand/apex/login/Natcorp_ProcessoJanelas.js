/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · JANELAS DO PROCESSO SELETIVO  —  o "arrumador" das janelas (JavaScript)        ║
   ║  App 9113 (Recrutamento e Seleção) · Páginas 38, 10, 13, 3 e 35                          ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia: PROCESSOJANELAS-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   As janelas que o recrutador abre a partir do processo (página 29) e da ficha do candidato
   (página 32). Um arquivo só para as cinco: cada parte reconhece a SUA janela pelos itens
   dela e não faz nada nas outras.
     • 38 Detalhes da vaga: o link para candidatos com "Copiar link" e "Abrir", o anúncio
       ("Como o candidato vê") e a descrição legível;
     • 10 Anotações das fases: o processo numa linha, "Adicionar anotação" com nome, e o vazio
       explicado;
     • 13 Processo seletivo: a ficha do processo no alto (o que não se edita, como texto), as
       seções abertas, os campos vazios que não se editam saem;
     • 3 Aprovar candidato: quem está sendo aprovado, em texto; a data de contratação em
       destaque; aviso se a janela abriu sem o candidato;
     • 35 Enviar e-mail: "Para" (nome, e-mail, fase) numa linha; "Fechar" deixa de ser
       vermelho.
   Regra comum: campo SÓ DE LEITURA vira texto (sem caixa) e, vazio, sai da tela.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Nada é gravado por ele; nenhum item muda de valor. Botões e ações são os originais.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Páginas 38, 10, 13, 3 e 35 › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_ProcessoJanelas.js
                                  › CSS › File URLs:         #WORKSPACE_IMAGES#Natcorp_ProcessoJanelas.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [J1] Ferramentas
     [J2] Campo só de leitura vira texto                               CUIDADO
     [J3] 38 Detalhes da vaga
     [J4] 10 Anotações das fases
     [J5] 13 Processo seletivo
     [J6] 3  Aprovar candidato
     [J7] 35 Enviar e-mail
     [J8] O maestro
*/
(function () {
  'use strict';
  if (window.__ncProcessoJanelas || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [J1] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function frase(t) { t = String(t || '').trim(); if (/[a-zà-ú]/.test(t)) return t; t = t.toLowerCase(); return t.charAt(0).toUpperCase() + t.slice(1); }
  function vazio(t) { return !t || /^[\s\-–]*$/.test(t); }
  function valor(id) { var i = $id(id); if (!i) return ''; var v = i.value !== undefined ? i.value : i.textContent; v = String(v || '').trim(); return vazio(v) ? '' : v; }
  function rotulo(c) { var l = c.querySelector('.t-Form-label'); return l ? l.textContent.replace(/\(Valor Necessário\)/i, '').trim() : ''; }
  function ic(n) {
    var P = {
      copiar: '<rect x="8.5" y="8.5" width="11" height="11" rx="2"/><path d="M5.5 15.5v-9a1 1 0 0 1 1-1h9"/>',
      abrir: '<path d="M14 4.5h5.5V10M19.5 4.5L11 13M17 14v4.5a1 1 0 0 1-1 1H6.5a1 1 0 0 1-1-1V8a1 1 0 0 1 1-1H11"/>',
      mais: '<path d="M12 5v14M5 12h14"/>', aviso: '<path d="M12 4l9 16H3z"/><path d="M12 10v4M12 17h.01"/>'
    };
    return '<svg class="nc-pj-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + P[n] + '</svg>';
  }
  function botaoPorTexto(rx, raiz) { return [].filter.call((raiz || document).querySelectorAll('button.t-Button, a.t-Button'), function (b) { return rx.test(b.textContent.trim()); })[0]; }
  function rotuloBotao(b, t) { if (!b) return; var l = b.querySelector('.t-Button-label'); if (l) l.textContent = t; }

  /* ═══ [J2] CAMPO SÓ DE LEITURA VIRA TEXTO ════════════════════════════════════════════════
     CUIDADO  "Só de leitura" = input/textarea com readonly e SEM botão de lista (popup LOV com
              botão continua campo: ainda dá para escolher). Vazio ("", "-") sai da tela; se uma
              região ficar sem nenhum campo à vista, ela diz "Nada informado".
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function leitura(raiz) {
    [].forEach.call((raiz || document).querySelectorAll('.t-Form-fieldContainer'), function (c) {
      var i = c.querySelector('input:not([type="hidden"]), textarea');
      var so = c.querySelector('.apex-item-display-only, .display_only');
      if (i && !i.readOnly && !i.disabled) return;
      if (i && c.querySelector('.a-Button--popupLOV, .ui-datepicker-trigger, .a-Button--calendar')) return;   /* tem botão: ainda se escolhe */
      if (!i && !so) return;
      var v = i ? i.value : so.textContent;
      c.classList.add('nc-pj-leitura');
      if (vazio(v)) c.classList.add('nc-pj-vazio');
    });
    [].forEach.call((raiz || document).querySelectorAll('.t-Region .t-Region-body'), function (b) {
      if (!b.querySelector('.t-Form-fieldContainer') || b.querySelector('.t-Region')) return;
      var vis = [].some.call(b.querySelectorAll('.t-Form-fieldContainer'), function (c) { return !c.classList.contains('nc-pj-vazio'); });
      if (!vis && !b.querySelector('.nc-pj-nada')) b.appendChild(el('p', 'nc-pj-nada', 'Nada informado.'));
    });
  }
  /* valor que chega DEPOIS (ação dinâmica da página) faz o campo voltar a aparecer */
  function acompanharLeitura() {
    $(document).on('change', '.nc-pj-leitura input, .nc-pj-leitura textarea', function () {
      var c = this.closest('.nc-pj-leitura'); if (c) c.classList.toggle('nc-pj-vazio', vazio(this.value));
    });
  }
  function abrirRecolhidas() {
    [].forEach.call(document.querySelectorAll('.t-Region--hideShow.is-collapsed'), function (r) {
      var b = r.querySelector('.t-Region-header .t-Button--hideShow'); if (b) b.click();
    });
  }

  /* ═══ [J3] 38 DETALHES DA VAGA ═══════════════════════════════════════════════════════════ */
  function janela38() {
    var c = $id('P38_URL_CONTAINER'), a = c && c.querySelector('a[href]');
    if (a) {
      var href = a.getAttribute('href');
      var caixa = el('section', 'nc-pj-link',
        '<p class="nc-pj-rot">Link para os candidatos se inscreverem</p>' +
        '<div class="nc-pj-link-linha"><a href="' + esc(href) + '" target="_blank" rel="noopener">' + esc(href.replace(/^https?:\/\//, '')) + '</a>' +
        '<button type="button" class="nc-pj-bt" data-copiar="' + esc(href) + '">' + ic('copiar') + '<span>Copiar link</span></button>' +
        '<a class="nc-pj-bt" href="' + esc(href) + '" target="_blank" rel="noopener">' + ic('abrir') + '<span>Abrir</span></a></div>');
      c.parentNode.insertBefore(caixa, c);
      c.classList.add('nc-pj-guardado');
      /* CUIDADO: a ação "Popula URL" (ao abrir) reescreve P38_URL — na base de teste aponta para
         /jobs_dev. O cartão acompanha o que estiver no item. */
      var atualizar = function () {
        var n = c.querySelector('a[href]'); if (!n) return;
        var h = n.getAttribute('href');
        var l = caixa.querySelector('.nc-pj-link-linha > a:first-child'), ab = caixa.querySelector('a.nc-pj-bt'), cp = caixa.querySelector('[data-copiar]');
        if (l.getAttribute('href') === h) return;
        l.setAttribute('href', h); l.textContent = h.replace(/^https?:\/\//, ''); ab.setAttribute('href', h); cp.setAttribute('data-copiar', h);
      };
      if (window.MutationObserver) new MutationObserver(atualizar).observe(c, { childList: true, subtree: true, characterData: true });
    }
    var vaga = $id('VAGA');
    var anuncio = vaga && [].filter.call(vaga.querySelectorAll('.t-Region-body > .container > .row'), function (r) { return !r.querySelector('#P38_URL_CONTAINER, .nc-pj-link'); })[0];
    if (anuncio) anuncio.insertAdjacentHTML('beforebegin', '<p class="nc-pj-rot nc-pj-rot--secao">Como o candidato vê o anúncio</p>');
    var desc = $id('P38_DESCRICAO_CONTAINER');
    if (desc) { desc.insertAdjacentHTML('beforebegin', '<p class="nc-pj-rot nc-pj-rot--secao">Descrição da vaga</p>'); desc.classList.add('nc-pj-texto'); }
  }

  /* ═══ [J4] 10 ANOTAÇÕES DAS FASES ════════════════════════════════════════════════════════ */
  function janela10() {
    var reg = [].filter.call(document.querySelectorAll('.t-Region'), function (r) { return r.querySelector('.a-ListView'); })[0];
    if (!reg) return;
    reg.classList.add('nc-pj-anot');
    var mais = reg.querySelector('.t-Region-header .t-Button');
    if (mais && !mais.querySelector('.t-Button-label')) {
      mais.classList.remove('t-Button--noLabel'); mais.classList.add('nc-pj-bt-mais');
      mais.insertAdjacentHTML('beforeend', '<span class="t-Button-label">Adicionar anotação</span>');
    }
    var arrumar = function () {
      var nd = reg.querySelector('.apex-no-data-found');
      if (nd && !nd.classList.contains('nc-pj-sem')) { nd.classList.add('nc-pj-sem'); nd.innerHTML = '<b>Nenhuma anotação neste processo ainda.</b><br>Use “Adicionar anotação” para registrar o que aconteceu em cada fase.'; }
    };
    arrumar();
    $(reg).on('apexafterrefresh', arrumar);
  }

  /* ═══ [J5] 13 PROCESSO SELETIVO ══════════════════════════════════════════════════════════
     A ficha do alto é LIDA dos campos do corpo (Processo, Status, Empresa, Filial, Vaga, Cargo,
     C. custo, Requisição). Os campos continuam lá (escondidos), com o valor de sempre.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FICHA13 = [['P13_CARGO_TXT', 'Cargo'], ['P13_COD_EMPRESA', 'Empresa'], ['P13_COD_FILIAL', 'Filial'], ['P13_CCUSTO_TXT', 'Centro de custo'], ['P13_COD_VAGA', 'Vaga'], ['P13_COD_REQ', 'Requisição']];
  function janela13() {
    var proc = valor('P13_COD_PROCESSO'), st = valor('P13_STATUS_TXT');
    var primeiro = $id('P13_COD_PROCESSO_CONTAINER'); if (!primeiro) return;
    var fatos = FICHA13.map(function (f) { var v = valor(f[0]); return v ? '<div><dt>' + esc(f[1]) + '</dt><dd>' + esc(/TXT$/.test(f[0]) ? v.replace(/^(\S+\s+-\s+)(.+)$/, function (m, a, b) { return a + frase(b); }) : v) + '</dd></div>' : ''; }).join('');
    var ficha = el('section', 'nc-pj-ficha',
      '<header><h2>Processo ' + esc(proc) + '</h2>' + (st ? '<span class="nc-pj-selo" data-st="' + esc(st.charAt(0).toLowerCase()) + '">' + esc(st.replace(/^\S+\s+-\s+/, '')) + '</span>' : '') + '</header>' +
      (fatos ? '<dl>' + fatos + '</dl>' : ''));
    var linha = primeiro.closest('.row');
    linha.parentNode.insertBefore(ficha, linha);
    ['P13_COD_PROCESSO', 'P13_STATUS_TXT'].concat(FICHA13.map(function (f) { return f[0]; })).forEach(function (id) {
      var c = $id(id + '_CONTAINER'); if (c) c.classList.add('nc-pj-na-ficha');
    });
    /* o que se edita ganha um título */
    var tipo = $id('P13_COD_TIPO_PROCESSO_CONTAINER');
    if (tipo) { var r = tipo.closest('.row'); r.insertAdjacentHTML('beforebegin', '<p class="nc-pj-rot nc-pj-rot--secao">Classificação e responsável</p>'); }
    abrirRecolhidas();
  }

  /* ═══ [J6] 3 APROVAR CANDIDATO ═══════════════════════════════════════════════════════════ */
  function janela3() {
    var cand = valor('P3_CANDIDATO') || valor('P3_CODCANDIDATO_TXT');
    var alto = el('section', 'nc-pj-aviso' + (cand ? '' : ' is-erro'));
    alto.innerHTML = cand
      ? '<p><b>Aprovar ' + esc(frase(cand)) + '</b></p><p>Confira os dados e informe a data de contratação. Ao confirmar, a aprovação é gravada.</p>'
      : ic('aviso') + '<div><p><b>Esta janela abriu sem o candidato.</b></p><p>Feche e faça a aprovação pela ficha do candidato (botão “Aprovar candidato”).</p></div>';
    var primeiro = document.querySelector('.t-Dialog-body .t-Form-fieldContainer, .t-Body-content .t-Form-fieldContainer');
    if (primeiro) { var row = primeiro.closest('.row'); row.parentNode.insertBefore(alto, row); }
    var dt = $id('P3_DT_CONTRATACAO_CONTAINER'); if (dt) dt.classList.add('nc-pj-destaque');
    var conf = botaoPorTexto(/^confirmar$/i); rotuloBotao(conf, 'Confirmar aprovação');
  }

  /* ═══ [J7] 35 ENVIAR E-MAIL — uma janela de "nova mensagem", como no Mail do macOS ═══════
     No alto, a barra: "Nova mensagem" e o assunto em cinza; Fechar e Enviar (os botões
     ORIGINAIS, movidos — as ações deles continuam: Enviar pergunta e envia, Fechar fecha). Depois
     as linhas finas de cabeçalho — Para (quem, e-mail, fase), Modelo, Assunto — e o corpo, que
     ocupa o resto da janela. Os campos são os MESMOS itens (os contêineres são movidos para as
     linhas), então a ação "Set Template Email" e a gravação seguem iguais.
     CUIDADO  Os botões são achados pelo texto ("Fechar", "Enviar"); o editor pelo item
              P35_MESSAGE_EMAIL (CKEditor 4 do APEX). A altura do editor acompanha a janela.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function janela35() {
    var nome = valor('P35_CANDIDATO_DISPLAY'), social = valor('P35_NOME').replace(/\s*\(Nome Social\)\s*$/i, ''), mail = valor('P35_TO_EMAIL'), fase = valor('P35_FASE'), emp = valor('P35_COD_EMPRESA_DISPLAY');
    var cTpl = $id('P35_TEMPLATE_EMAIL_CONTAINER'), cAss = $id('P35_SUBJECT_EMAIL_CONTAINER'), cMsg = $id('P35_MESSAGE_EMAIL_CONTAINER');
    /* 04/10: o E-mail (P35_TO_EMAIL) é campo EDITÁVEL na página e é para ele que o processo envia:
       vem para uma linha própria (o mesmo item), em vez de sumir com a região "Colab Info" */
    var cTo = $id('P35_TO_EMAIL_CONTAINER');
    if (!cTpl || !cAss || !cMsg) return;
    var regInfo = $id('COLABORADOR'), regMsg = cMsg.closest('.t-Region');
    var ini = String(nome || '?').split(/\s+/).filter(function (x) { return x.length > 2; });
    ini = ((ini[0] || '?').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '')).toUpperCase();
    var faseTxt = fase.replace(/^(\d+\s*-\s*)(.+)$/, function (m, a, b) { return a + frase(b); });
    var m = el('section', 'nc-pj-mail');
    m.setAttribute('aria-label', 'Nova mensagem');
    m.innerHTML =
      '<header class="nc-pj-mail-bar"><div class="nc-pj-mail-tit"><b>Nova mensagem</b><span data-assunto></span></div><div class="nc-pj-mail-botoes"></div></header>' +
      '<div class="nc-pj-mail-linha nc-pj-mail-para"><span class="nc-pj-mail-rot">Para:</span>' +
        (nome ? '<span class="nc-pj-mail-dest"><span class="nc-pj-mail-av" aria-hidden="true">' + esc(ini) + '</span><span><b>' + esc(nome) + '</b>' + (social && social !== nome ? ' <span class="nc-pj-fraco">(' + esc(social) + ')</span>' : '') +
          (mail && !cTo ? ' <span class="nc-pj-mail-end">&lt;' + esc(mail) + '&gt;</span>' : '') + '</span></span>' : '') +
        (mail ? '' : '<span class="nc-pj-erro">Sem e-mail no cadastro: a mensagem não tem para onde ir.</span>') +
        ([faseTxt, emp].filter(Boolean).length ? '<span class="nc-pj-mail-ctx">' + [faseTxt, emp].filter(Boolean).map(esc).join(' · ') + '</span>' : '') +
      '</div>' +
      (cTo ? '<div class="nc-pj-mail-linha"><label class="nc-pj-mail-rot" for="P35_TO_EMAIL">E-mail:</label><div class="nc-pj-mail-campo" data-to></div></div>' : '') +
      '<div class="nc-pj-mail-linha"><label class="nc-pj-mail-rot" for="P35_TEMPLATE_EMAIL">Modelo:</label><div class="nc-pj-mail-campo" data-tpl></div><span class="nc-pj-mail-dica">preenche o assunto e a mensagem</span></div>' +
      '<div class="nc-pj-mail-linha"><label class="nc-pj-mail-rot" for="P35_SUBJECT_EMAIL">Assunto:</label><div class="nc-pj-mail-campo" data-ass></div></div>' +
      '<div class="nc-pj-mail-corpo"></div>';
    (regInfo || regMsg).parentNode.insertBefore(m, regInfo || regMsg);
    if (cTo) m.querySelector('[data-to]').appendChild(cTo);
    m.querySelector('[data-tpl]').appendChild(cTpl);
    m.querySelector('[data-ass]').appendChild(cAss);
    m.querySelector('.nc-pj-mail-corpo').appendChild(cMsg);
    [regInfo, regMsg].forEach(function (r) { if (r) r.classList.add('nc-pj-guardado'); });
    /* Fechar e Enviar vão para a barra de cima; o pé da janela fica vazio e some */
    var bar = m.querySelector('.nc-pj-mail-botoes');
    var fechar = botaoPorTexto(/^fechar$/i), enviar = botaoPorTexto(/^enviar$/i);
    if (fechar) { fechar.classList.remove('t-Button--danger', 't-Button--large'); fechar.classList.add('nc-pj-neutro'); bar.appendChild(fechar); }
    if (enviar) { enviar.classList.remove('t-Button--large'); enviar.classList.add('nc-pj-enviar'); bar.appendChild(enviar); }
    document.body.classList.add('nc-pj-mail-ativo');
    /* o assunto aparece também na barra (como o título da janela no Mail) */
    var ass = $id('P35_SUBJECT_EMAIL'), tit = m.querySelector('[data-assunto]');
    var poeTitulo = function () { tit.textContent = (ass && ass.value) || 'Sem assunto'; };
    if (ass) { ass.addEventListener('input', poeTitulo); $(ass).on('change', poeTitulo); }
    poeTitulo();
    /* o corpo ocupa a altura que sobra na janela */
    var ajustar = function () {
      var ed = window.CKEDITOR && CKEDITOR.instances.P35_MESSAGE_EMAIL; if (!ed || ed.status !== 'ready') return;
      var corpo = m.querySelector('.nc-pj-mail-corpo'), topo = corpo.getBoundingClientRect().top;
      var h = Math.max(240, Math.round(window.innerHeight - topo - 16));
      ed.resize('100%', h);
    };
    var esperar = function (n) {
      var ed = window.CKEDITOR && CKEDITOR.instances.P35_MESSAGE_EMAIL;
      if (ed && ed.status === 'ready') return ajustar();
      if (ed) return ed.once('instanceReady', ajustar);
      if (n < 40) setTimeout(function () { esperar(n + 1); }, 150);
    };
    esperar(0);
    window.addEventListener('resize', function () { clearTimeout(ajustar.t); ajustar.t = setTimeout(ajustar, 120); });
  }

  /* ═══ [J8] O MAESTRO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() {
    var qual = $id('P38_URL') ? 38 : $id('P10_PROCESSO') ? 10 : $id('P13_COD_PROCESSO') ? 13 : $id('P3_DT_CONTRATACAO') ? 3 : $id('P35_TEMPLATE_EMAIL') ? 35 : 0;
    if (!qual) return;
    window.__ncProcessoJanelas = true;
    document.body.classList.add('nc-pj-ativo', 'nc-pj-' + qual);
    ({ 38: janela38, 10: janela10, 13: janela13, 3: janela3, 35: janela35 })[qual]();
    if (qual !== 38) { leitura(); acompanharLeitura(); }
    document.addEventListener('click', function (ev) {
      var b = ev.target.closest('[data-copiar]'); if (!b || !navigator.clipboard) return;
      navigator.clipboard.writeText(b.getAttribute('data-copiar')).then(function () {
        var s = b.querySelector('span'), t = s && s.textContent; if (s) s.textContent = 'Copiado'; b.classList.add('is-copiado');
        setTimeout(function () { if (s) s.textContent = t; b.classList.remove('is-copiado'); }, 1600);
      }, function () { /* sem permissão: o link está à vista */ });
    });
  }
  var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp janelas do processo]', e); } }, 0); };
  if (document.readyState === 'complete') vai();
  else { if (window.apex.gPageContext$) $(apex.gPageContext$).one('apexreadyend', vai); window.addEventListener('load', vai); }
})();
