/* Natcorp — formulário longo no celular ("Conhecendo Você", app 600, e qualquer formulário APEX).

   Quem preenche o "Dados Pessoais" faz isso pelo celular (9 em cada 10), e a página tem
   dezessete blocos e cento e poucos campos numa rolagem de 10 mil pixels. Este arquivo
   cuida do que o CSS sozinho não alcança:

     1. TECLADO CERTO EM CADA CAMPO: número abre o teclado numérico, e-mail o de e-mail;
        CPF, CEP, PIS, conta, zona, seção… só números. O celular também passa a sugerir o
        que já sabe (nome, e-mail, telefone, CEP, endereço) — menos digitação.
     2. "IR" NO TECLADO LEVA AO PRÓXIMO CAMPO, em vez de tentar enviar a página.
     3. DATAS: digita-se só os números (as barras entram sozinhas, "27081960" vira
        27/08/1960) e o calendário ganha a escolha de MÊS e ANO — antes, para chegar a
        1960 eram mais de 700 toques na seta. Aberto pelo botão do calendário, o teclado
        não sobe por cima dele.
     4. LISTA DE BUSCA (Banco, Agência, Naturalidade): a janela diz o nome do campo
        ("Banco"), não "Caixa de Diálogo Pesquisar".
     5. "IR PARA SEÇÃO": no celular, um botão fixo embaixo mostra em que bloco a pessoa
        está ("Contato · 4 de 17") e abre a lista de todos os blocos — um toque leva a
        qualquer um. Some enquanto o teclado está aberto.

   O desenho está no Natcorp_Style_Min.css (seções "FORMULÁRIO NO CELULAR" e "IR PARA SEÇÃO").
   Não muda valor nenhum de campo nem dispara "change" — a gravação automática da página
   continua exatamente como era.

   Onde vai: Aplicação 600 › Componentes Compartilhados › Atributos da Interface do Usuário ›
   JavaScript › URLs de Arquivo:  #WORKSPACE_FILES#Natcorp_Formulario_Celular.js
   (também vai colado no fim do iframe_handling.js, para as outras aplicações). */
(function () {
  'use strict';

  if (window.__ncFormCelular || !window.apex || !window.jQuery) return;
  window.__ncFormCelular = true;

  var $ = window.jQuery;
  var TOQUE = window.matchMedia && window.matchMedia('(pointer: coarse)').matches;
  var ESTREITO = window.matchMedia ? window.matchMedia('(max-width: 767px)') : { matches: false };

  function texto(el) { return el ? (el.textContent || '').replace(/\s+/g, ' ').trim() : ''; }

  function rotulo(campo) {
    var l = campo.id && document.querySelector('label[for="' + campo.id + '"]');
    return texto(l);
  }

  function tituloDaRegiao(campo) {
    var r = campo.closest && campo.closest('.t-Region');
    return r ? texto(r.querySelector('.t-Region-title')) : '';
  }

  function por(el, nome, valor) {
    if (!el.hasAttribute(nome)) el.setAttribute(nome, valor);
  }

  /* ---------- 1. TECLADO CERTO ---------- */
  var SO_NUMERO = /^(n[º°o.]*\s*)?(de\s+|do\s+)?(cpf|cep|pis|pasep|nis|cnh|conta|ag[eê]ncia|zona|se[cç][aã]o|s[eé]rie|ramal|ano|anos|meses|registro)\b|n[uú]mero do pis|ano de chegada|habilita[cç][aã]o profissional/i;
  /* "Número" sozinho depende do documento: RG e passaporte têm letras */
  var NUMERO_SO_DIGITOS = /^(cpf|pis|t[ií]tulo de eleitor|carteira profissional|endere[cç]o|contribui[cç][aã]o inss)$/i;

  function ajustarTeclado(campo) {
    if (campo.__ncTeclado) return;
    campo.__ncTeclado = true;
    var tipo = (campo.getAttribute('type') || 'text').toLowerCase();
    if (!/^(text|tel|email|url|search|number)$/.test(tipo)) return;
    var r = rotulo(campo), reg = tituloDaRegiao(campo), id = campo.id || '';
    var cls = ' ' + campo.className + ' ';

    por(campo, 'enterkeyhint', 'next');

    if (/hasDatepicker|apex-item-datepicker/.test(cls)) {
      por(campo, 'inputmode', 'numeric');
      por(campo, 'autocomplete', 'off');
      return;
    }
    if (/e-?mail/i.test(r) || /E_?MAIL/i.test(id)) {
      por(campo, 'inputmode', 'email');
      por(campo, 'autocomplete', /funcional|corporativ|comercial/i.test(r) ? 'off' : 'email');
      por(campo, 'autocapitalize', 'none');
      por(campo, 'spellcheck', 'false');
      return;
    }
    if (tipo === 'url' || /linkedin|site|url/i.test(r)) {
      por(campo, 'inputmode', 'url');
      por(campo, 'autocapitalize', 'none');
      por(campo, 'spellcheck', 'false');
      return;
    }
    if (/altura|peso|metros|\(kg\)/i.test(r)) { por(campo, 'inputmode', 'decimal'); return; }
    if (tipo === 'tel' || /number_field/.test(cls) || SO_NUMERO.test(r) ||
        (/^n[uú]mero$/i.test(r) && NUMERO_SO_DIGITOS.test(reg))) {
      if (/popup_lov|popup-lov/.test(cls)) return;          /* Banco/Agência: busca por nome */
      por(campo, 'inputmode', tipo === 'tel' && /telefone|celular|recado|nextel/i.test(r) ? 'tel' : 'numeric');
      if (/cep/i.test(r)) por(campo, 'autocomplete', 'postal-code');
      else if (/celular/i.test(r)) por(campo, 'autocomplete', 'tel-national');
      else por(campo, 'autocomplete', 'off');
      return;
    }
    /* texto: o celular sugere o que já sabe da pessoa — só nos campos DELA */
    var sugestao =
      /^nome completo$|^nome$/i.test(r) ? 'name' :
      /^endere[cç]o$|logradouro/i.test(r) && !/select/i.test(campo.tagName) ? 'address-line1' :
      /^complemento$/i.test(r) ? 'address-line2' :
      /^cidade$/i.test(r) && /endere/i.test(reg) ? 'address-level2' :
      /^bairro$/i.test(r) ? 'address-level3' : '';
    if (sugestao) por(campo, 'autocomplete', sugestao);
    else if (/^nome|c[oô]njuge|m[aã]e|pai|contato/i.test(r)) por(campo, 'autocomplete', 'off');
    if (/nome|bairro|cidade|endere|emissor|complemento/i.test(r)) por(campo, 'autocapitalize', 'words');
    if (/d[ií]gito|categoria|sigla/i.test(r)) por(campo, 'autocapitalize', 'characters');
  }

  function ajustarTeclados(raiz) {
    var c = (raiz || document).querySelectorAll('.t-Form-inputContainer input');
    for (var i = 0; i < c.length; i++) ajustarTeclado(c[i]);
  }

  /* ---------- 2. "IR" LEVA AO PRÓXIMO CAMPO ---------- */
  function visivel(el) {
    return !!(el.offsetWidth || el.offsetHeight || el.getClientRects().length) &&
      window.getComputedStyle(el).visibility !== 'hidden';
  }

  function proximoCampo(atual) {
    var todos = document.querySelectorAll('.t-Body-content input:not([type=hidden]):not([type=radio]):not([type=checkbox]), .t-Body-content select, .t-Body-content textarea, .t-Dialog-body input:not([type=hidden]):not([type=radio]):not([type=checkbox]), .t-Dialog-body select, .t-Dialog-body textarea');
    var achou = false;
    for (var i = 0; i < todos.length; i++) {
      var c = todos[i];
      if (achou && !c.disabled && !c.readOnly && visivel(c)) return c;
      if (c === atual) achou = true;
    }
    return null;
  }

  if (TOQUE) {
    document.addEventListener('keydown', function (e) {
      var c = e.target;
      if (e.key !== 'Enter' || e.defaultPrevented || !c || c.tagName !== 'INPUT') return;
      if (!c.closest || !c.closest('.t-Form-inputContainer')) return;
      if (/^(button|submit|radio|checkbox)$/.test(c.type)) return;
      if (c.closest('.a-PopupLOV-searchBar')) return;       /* Enter na busca é "buscar" */
      e.preventDefault();
      e.stopPropagation();
      var p = proximoCampo(c);
      if (p) p.focus(); else c.blur();
    }, true);
  }

  /* ---------- 3. DATAS ---------- */
  function temMascara(campo) {
    var ev = $._data && $._data(campo, 'events');
    return !!(ev && ev.unmask);
  }

  /* dd/mm/aaaa enquanto digita: só números, as barras entram sozinhas; apagar funciona */
  function mascararData(campo) {
    if (campo.__ncData || temMascara(campo)) return;
    campo.__ncData = true;
    campo.addEventListener('input', function (e) {
      if (e.inputType && /^delete/.test(e.inputType)) return;
      var d = campo.value.replace(/\D/g, '').slice(0, 8);
      var v = d.length > 4 ? d.slice(0, 2) + '/' + d.slice(2, 4) + '/' + d.slice(4)
            : d.length > 2 ? d.slice(0, 2) + '/' + d.slice(2) : d;
      if (v !== campo.value) campo.value = v;
    });
  }

  function ajustarDatas(raiz) {
    $(raiz || document).find('input.hasDatepicker').each(function () {
      var fmt = $(this).datepicker('option', 'dateFormat') || '';
      if (!/^dd.mm.yy$/.test(fmt)) return;                   /* só o formato brasileiro */
      /* direto na configuração do calendário deste campo: o datepicker('option') do jQuery
         RECRIA o botão do calendário, e o novo vem sem as classes do APEX (ia para a
         esquerda, por cima do rótulo) */
      var inst = !this.__ncCalendario && $.data(this, 'datepicker');
      if (inst && inst.settings) {
        this.__ncCalendario = true;
        inst.settings.changeMonth = true;
        inst.settings.changeYear = true;
        inst.settings.yearRange = '-110:+20';
      }
      mascararData(this);
    });
  }

  /* aberto pelo botão do calendário, o jQuery põe o foco no campo — e o teclado subia por
     cima do calendário. Enquanto ele está aberto o campo pede "sem teclado"; ao fechar,
     volta ao numérico e o foco sai (senão o teclado subiria logo depois da escolha). */
  if (TOQUE) {
    document.addEventListener('pointerdown', function (e) {
      var b = e.target && e.target.closest && e.target.closest('.ui-datepicker-trigger');
      if (!b) return;
      var campo = b.previousElementSibling;
      if (!campo || campo.tagName !== 'INPUT') return;
      campo.setAttribute('inputmode', 'none');
      var cal = document.getElementById('ui-datepicker-div');
      var espera = setInterval(function () {
        cal = cal || document.getElementById('ui-datepicker-div');
        if (cal && window.getComputedStyle(cal).display !== 'none') return;
        clearInterval(espera);
        campo.setAttribute('inputmode', 'numeric');
        if (document.activeElement === campo) campo.blur();
      }, 250);
    }, true);
  }

  /* ---------- 4. LISTA DE BUSCA COM O NOME DO CAMPO ---------- */
  $(document).on('dialogopen', function (e) {
    var id = (e.target && e.target.id) || '';
    var m = /^PopupLov_\d+_(.+)_dlg$/.exec(id);
    if (!m) return;
    var campo = document.getElementById(m[1]);
    var nome = campo && rotulo(campo);
    if (!nome) return;
    var janela = e.target.closest('.ui-dialog');
    var t = janela && janela.querySelector('.ui-dialog-title');
    if (t) t.textContent = nome;
    var busca = e.target.querySelector('.a-PopupLOV-search');
    if (busca) {
      if (!busca.getAttribute('placeholder')) busca.setAttribute('placeholder', 'Digite para buscar');
      busca.setAttribute('enterkeyhint', 'search');
      busca.setAttribute('autocomplete', 'off');
    }
  });

  /* ---------- 5. IR PARA SEÇÃO ---------- */
  var ICONE_LISTA = '<svg viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M8 6h12M8 12h12M8 18h12"/><circle cx="4" cy="6" r="1.2"/><circle cx="4" cy="12" r="1.2"/><circle cx="4" cy="18" r="1.2"/></svg>';
  var ICONE_FECHAR = '<svg viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M6 6l12 12M18 6L6 18"/></svg>';

  var secoes = [], botao = null, painel = null, atual = -1, ultimoFoco = null, ouvintes = false;

  function coletarSecoes() {
    var lista = [];
    var rs = document.querySelectorAll('.t-Body-content .t-Region:not(.t-Region--removeHeader):not(.t-Region--noUI)');
    for (var i = 0; i < rs.length; i++) {
      var r = rs[i];
      if (r.parentElement && r.parentElement.closest('.t-Region:not(.t-Region--noUI)')) continue;   /* região dentro de região */
      var t = r.querySelector(':scope > .t-Region-header .t-Region-title');
      if (!t || !visivel(r) || !r.querySelector('.t-Form-fieldContainer')) continue;
      var ic = r.querySelector(':scope > .t-Region-header .t-Region-headerIcon .t-Icon');
      lista.push({ el: r, nome: texto(t), icone: ic ? ic.className : '' });
    }
    return lista;
  }

  function irPara(i) {
    var s = secoes[i];
    if (!s) return;
    var topo = s.el.getBoundingClientRect().top + window.pageYOffset;
    /* subindo, o cabeçalho do tema reaparece (150 px): o título não pode ficar debaixo dele */
    var folga = topo < window.pageYOffset ? 162 : 12;
    var reduzir = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    window.scrollTo({ top: Math.max(0, topo - folga), behavior: reduzir ? 'auto' : 'smooth' });
    var titulo = s.el.querySelector('.t-Region-title');
    if (titulo) {
      titulo.setAttribute('tabindex', '-1');
      titulo.focus({ preventScroll: true });
    }
  }

  function abrir() {
    if (!painel) return;
    ultimoFoco = document.activeElement;
    marcarAtual(true);
    painel.hidden = false;
    void painel.offsetWidth;
    painel.classList.add('is-aberto');
    botao.setAttribute('aria-expanded', 'true');
    document.documentElement.classList.add('nc-secoes-travado');
    var alvo = painel.querySelector('.nc-secoes-item.is-atual') || painel.querySelector('.nc-secoes-item');
    if (alvo) {
      alvo.focus({ preventScroll: true });
      alvo.scrollIntoView({ block: 'center' });
    }
  }

  function fechar(devolverFoco) {
    if (!painel || painel.hidden) return;
    painel.classList.remove('is-aberto');
    botao.setAttribute('aria-expanded', 'false');
    document.documentElement.classList.remove('nc-secoes-travado');
    setTimeout(function () { painel.hidden = true; }, 220);
    if (devolverFoco && ultimoFoco && ultimoFoco.focus) ultimoFoco.focus({ preventScroll: true });
  }

  function marcarAtual(forcar) {
    if (!secoes.length || !botao) return;
    var linha = Math.min(window.innerHeight * 0.3, 220), i = 0;
    for (var k = 0; k < secoes.length; k++) {
      if (secoes[k].el.getBoundingClientRect().top <= linha) i = k;
    }
    var primeira = secoes[0].el.getBoundingClientRect().top;
    /* aparece quando a pessoa começa a rolar — na abertura da página, a tela é do formulário */
    botao.classList.toggle('is-visivel', window.pageYOffset > 120 && primeira < window.innerHeight * 0.6);
    if (i === atual && !forcar) return;
    atual = i;
    botao.querySelector('.nc-secoes-atual').textContent = secoes[i].nome;
    botao.querySelector('.nc-secoes-conta').textContent = (i + 1) + ' de ' + secoes.length;
    var itens = painel.querySelectorAll('.nc-secoes-item');
    for (var j = 0; j < itens.length; j++) {
      itens[j].classList.toggle('is-atual', j === i);
      if (j === i) itens[j].setAttribute('aria-current', 'true'); else itens[j].removeAttribute('aria-current');
    }
  }

  function montarSecoes() {
    if (botao || !ESTREITO.matches) return;
    secoes = coletarSecoes();
    if (secoes.length < 5) return;                            /* formulário curto: não precisa */

    botao = document.createElement('button');
    botao.type = 'button';
    botao.className = 'nc-secoes-botao';
    botao.setAttribute('aria-haspopup', 'dialog');
    botao.setAttribute('aria-expanded', 'false');
    botao.innerHTML = ICONE_LISTA +
      '<span class="nc-secoes-textos"><span class="nc-secoes-rotulo">Ir para seção</span>' +
      '<span class="nc-secoes-atual"></span></span><span class="nc-secoes-conta"></span>';
    botao.addEventListener('click', abrir);

    painel = document.createElement('div');
    painel.className = 'nc-secoes';
    painel.hidden = true;
    var itens = secoes.map(function (s, i) {
      return '<li><button type="button" class="nc-secoes-item" data-i="' + i + '">' +
        '<span class="nc-secoes-ic" aria-hidden="true">' + (s.icone ? '<span class="' + s.icone.replace(/"/g, '') + '"></span>' : '') + '</span>' +
        '<span class="nc-secoes-nome"></span></button></li>';
    }).join('');
    painel.innerHTML =
      '<div class="nc-secoes-folha" role="dialog" aria-modal="true" aria-labelledby="nc-secoes-titulo">' +
      '<div class="nc-secoes-topo"><span class="nc-secoes-alca" aria-hidden="true"></span>' +
      '<h2 id="nc-secoes-titulo">Ir para seção</h2>' +
      '<button type="button" class="nc-secoes-fechar" aria-label="Fechar">' + ICONE_FECHAR + '</button></div>' +
      '<ol class="nc-secoes-lista">' + itens + '</ol></div>';
    /* o nome entra como texto (não como HTML): vem da página */
    var nomes = painel.querySelectorAll('.nc-secoes-nome');
    for (var n = 0; n < nomes.length; n++) nomes[n].textContent = secoes[n].nome;

    painel.addEventListener('click', function (e) {
      var item = e.target.closest('.nc-secoes-item');
      if (item) {
        var i = +item.getAttribute('data-i');
        fechar(false);
        setTimeout(function () { irPara(i); }, 60);
        return;
      }
      if (e.target.closest('.nc-secoes-fechar') || !e.target.closest('.nc-secoes-folha')) fechar(true);
    });
    painel.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') { e.preventDefault(); fechar(true); return; }
      if (e.key !== 'Tab') return;                           /* o foco fica dentro da folha */
      var f = painel.querySelectorAll('button');
      var ini = f[0], fim = f[f.length - 1];
      if (e.shiftKey && document.activeElement === ini) { e.preventDefault(); fim.focus(); }
      else if (!e.shiftKey && document.activeElement === fim) { e.preventDefault(); ini.focus(); }
    });

    document.body.appendChild(painel);
    document.body.appendChild(botao);

    marcarAtual(true);
    if (ouvintes) return;                                     /* remontado por recontar(): já ligados */
    ouvintes = true;

    var agendado = false;
    window.addEventListener('scroll', function () {
      if (agendado) return;
      agendado = true;
      window.requestAnimationFrame(function () { agendado = false; marcarAtual(false); });
    }, { passive: true });

    /* com o teclado aberto o botão flutuaria em cima do campo. "Teclado aberto" = um campo
       de digitação em foco E a área visível encolhida (o foco sozinho não basta: ao fechar
       a lista de busca o APEX devolve o foco ao campo, sem teclado nenhum) */
    var vv = window.visualViewport;
    function campoDeDigitacao(a) {
      return !!(a && a.matches && a.matches('input:not([type=radio]):not([type=checkbox]):not([type=button]), textarea'));
    }
    function avaliarTeclado() {
      if (!botao) return;
      var aberto = campoDeDigitacao(document.activeElement) &&
        (vv ? vv.height < window.innerHeight - 120 : true);
      botao.classList.toggle('is-digitando', aberto);
    }
    if (vv) vv.addEventListener('resize', avaliarTeclado);
    document.addEventListener('focusin', function () { setTimeout(avaliarTeclado, 300); });
    document.addEventListener('focusout', function () { setTimeout(avaliarTeclado, 120); });
  }

  /* blocos que aparecem/somem por ação dinâmica (Nacionalidade mostra "Estrangeiro"…) */
  function recontar() {
    if (!botao) return;
    var novas = coletarSecoes();
    if (novas.length === secoes.length) return;
    botao.remove(); painel.remove(); botao = painel = null; atual = -1;
    montarSecoes();
  }

  /* ---------- início ---------- */
  function iniciar() {
    ajustarTeclados();
    ajustarDatas();
    montarSecoes();
  }

  $(function () { setTimeout(iniciar, 0); });
  $(document).on('apexafterrefresh', function (e) {
    ajustarTeclados(e.target);
    ajustarDatas(e.target);
    setTimeout(recontar, 50);
  });
  if (ESTREITO.addEventListener) ESTREITO.addEventListener('change', function () { if (ESTREITO.matches) montarSecoes(); });
})();
