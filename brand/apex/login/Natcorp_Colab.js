/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · COLABORADOR E FILTROS  —  peça GLOBAL (JavaScript)                            ║
   ║  Todas as páginas (trazida pelo Natcorp_Temas.js, lista PECAS)                           ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia: COLAB-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
     1. A região "Colaborador" das páginas do Portal (a foto P<n>_FOTO + os campos de texto
        Empresa, Colaborador P<n>_MATRICULA, Situação, Data de Admissão) vira um CARTÃO CURTO:
        foto, nome, matrícula e situação, empresa, "Na empresa desde …" e o botão original
        (Visualizar). Com TODOS os campos vazios, a região SOME (pedido de 04/10) — e volta se
        uma ação da página preencher depois.
     2. Os filtros de escolha múltipla (o plugin Select2 da página, ex.: "Fato" na Linha do
        Tempo): o campo ocupa a largura, rótulo em cima, as escolhas como etiquetas, uma dica
        curta, e o botão de filtrar (só ícone) ganha o texto "Filtrar", ao lado do campo.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não muda valores, não envia nada. O botão Filtrar e o Visualizar são os ORIGINAIS (só mudam
     de lugar e de roupa). Os campos da região continuam na página (só saem da vista).
     Páginas que já fazem o cartão (Natcorp_Consulta, Natcorp_FeriasConsulta) ficam como estão.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [C1] Ferramentas
     [C2] A região Colaborador                                             CUIDADO
     [C3] Os filtros de escolha múltipla
     [C4] O maestro
*/
(function () {
  'use strict';
  if (window.__ncColab || !window.apex || !window.apex.jQuery) return;
  window.__ncColab = true;
  var $ = window.apex.jQuery;

  /* ═══ [C1] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/\s+/g, ' ').trim(); }
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  function extenso(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? (+m[1]) + ' de ' + MESES[+m[2] - 1] + ' de ' + m[3] : t; }
  function semCodigo(t) { return limpo(String(t || '').replace(/^\s*\d+\s*-\s*/, '')); }
  /* CAIXA ALTA do banco → "Tony Oliveira", "Natcorp do Brasil" (a mesma regra do Natcorp_Consulta) */
  var MIUDAS = /^(da|de|do|das|dos|e|em|na|no)$/;
  function bonito(t) {
    t = limpo(t); if (!t || t !== t.toUpperCase() || !/[A-Z]/.test(t)) return t;
    return t.toLowerCase().replace(/[^\s\-\/().]+/g, function (w, i) {
      if (i > 0 && MIUDAS.test(w)) return w;
      if (!/[aeiouáéíóúâêôãõà]/.test(w)) return w.toUpperCase();
      return w.charAt(0).toUpperCase() + w.slice(1);
    });
  }
  function codigo(t) { return (/^\s*(\d+)\s*-/.exec(t || '') || [])[1] || ''; }
  var IC_PESSOA = '<svg viewBox="0 0 24 24" aria-hidden="true" focusable="false"><circle cx="12" cy="8.5" r="3.7"/><path d="M5 20c.9-3.6 3.6-5.6 7-5.6s6.1 2 7 5.6"/></svg>';
  var IC_FUNIL = '<svg class="nc-filtro-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M4 5h16l-6.2 7.4V18l-3.6 1.8v-7.4z"/></svg>';

  /* ═══ [C2] A REGIÃO COLABORADOR ══════════════════════════════════════════════════════════
     CUIDADO  reconhecida pelo FORMATO, não pelo título: uma região com a foto (img P<n>_FOTO) e
              o campo de texto P<n>_MATRICULA do mesmo prefixo (a foto pode estar numa sub-região),
              sem relatório dentro e SÓ com campos de leitura do colaborador — região com campo de
              preencher (ex.: saldo na Requisição de Férias) fica como está, para nada sumir.
              Campos lidos (só os de DENTRO da região): …_MATRICULA (ou …_MATRICULA_DESC, quando
              …_MATRICULA é um filtro de lista), …_COD_EMPRESA1/…_COD_EMPRESA_1/…_COD_EMPRESA,
              …_SITUACAO/…_SITUACAO_1/…_SITUACAO_COLAB/…_SITUACAO_DESC/…_DESC_SITUACAO e …_DT_ADMISSAO. A ficha do app 200 (sub-regiões Colab Foto/Colab Info)
              é outra coisa: fica com o desenho dela (Natcorp_Paginas).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var CAMPO_COLAB = /_(MATRICULA|MATRICULA_DESC|MATRICULA_1|COD_EMPRESA_?1?|SITUACAO|SITUACAO_1|SITUACAO_COLAB|SITUACAO_DESC|DESC_SITUACAO|DT_ADMISSAO|FOTO)(_DISPLAY)?$/;
  function regioesColab() {
    return [].filter.call(document.querySelectorAll('img[id$="_FOTO"]'), function (img) { return /^P\d+_FOTO$/.test(img.id); }).map(function (img) {
      var P = img.id.replace(/FOTO$/, ''), mat = null, reg = null;
      /* o campo do colaborador pode ter outro nome quando P<n>_MATRICULA é outra coisa (um filtro
         em lista, ex.: 300:28; a matrícula de um dependente, ex.: 300:22): vale o primeiro que
         estiver na MESMA região da foto (a foto pode estar numa sub-região) */
      ['MATRICULA', 'MATRICULA_DESC', 'MATRICULA_1'].some(function (nm) {
        var m = document.getElementById(P + nm);
        if (!m || m.tagName !== 'INPUT' || m.type === 'hidden') return false;
        var r = img.closest('.t-Region');
        while (r && !r.contains(m)) r = r.parentElement && r.parentElement.closest('.t-Region');
        if (r) { mat = m; reg = r; return true; }
        return false;
      });
      if (!reg || reg.querySelector('.a-IRR, .a-IG')) return null;
      if (reg.classList.contains('nc-cq-colab-reg') || reg.classList.contains('nc-fc-colab-reg')) return null;   /* a página já faz o cartão */
      /* só a região SÓ DE LEITURA do colaborador: com campo de preencher (ex.: saldo de férias) fica como está */
      var outro = [].some.call(reg.querySelectorAll('input:not([type="hidden"]), select, textarea'), function (e) {
        return !(e.readOnly || e.disabled) || !CAMPO_COLAB.test(e.id);
      });
      if (outro) return null;
      return { P: P, reg: reg, img: img, mat: mat };
    }).filter(Boolean);
  }
  function valor(c, nome) { var e = document.getElementById(c.P + nome); return e && c.reg.contains(e) ? limpo(e.value != null ? e.value : e.textContent) : ''; }
  function vestirColab(c) {
    var P = c.P, reg = c.reg;
    var quem = valor(c, 'MATRICULA') || valor(c, 'MATRICULA_DESC') || valor(c, 'MATRICULA_1'), emp = valor(c, 'COD_EMPRESA1') || valor(c, 'COD_EMPRESA_1') || valor(c, 'COD_EMPRESA');
    var sit = valor(c, 'SITUACAO') || valor(c, 'SITUACAO_1') || valor(c, 'SITUACAO_COLAB') || valor(c, 'SITUACAO_DESC') || valor(c, 'DESC_SITUACAO'), adm = valor(c, 'DT_ADMISSAO');
    var vazio = !quem && !emp && !sit && !adm;
    reg.classList.add('nc-colab-reg');
    reg.classList.toggle('nc-colab-vazio', vazio);
    var card = reg.querySelector('.nc-colab');
    if (vazio) { if (card) card.hidden = true; return; }
    if (!card) {
      card = el('div', 'nc-colab');
      var corpo = reg.querySelector('.t-Region-body') || reg;
      corpo.insertBefore(card, corpo.firstChild);
      /* o botão da região (Visualizar, só ícone) vai para o cartão */
      var bt = [].filter.call(reg.querySelectorAll('.t-Region-headerItems--buttons .t-Button, .t-Region-buttons .t-Button'), function (b) { return !b.closest('.js-maximizeButtonContainer'); })[0];
      if (bt) { bt.classList.add('nc-colab-bt'); c.bt = bt; }
    }
    card.hidden = false;
    var sitTxt = limpo(sit.replace(/^\d+\s*-\s*/, '').replace(/\s*-\s*\d{2}\/\d{2}\/\d{4}\s*$/, ''));
    var src = c.img.getAttribute('src') || '';
    var nome = bonito(semCodigo(quem) || quem);
    var foto = src && !/PROFILE\.jpg/i.test(src) ? '<img class="nc-colab-foto" alt="" src="' + esc(src) + '">' : '<span class="nc-colab-foto nc-colab-foto--ini">' + IC_PESSOA + '</span>';
    card.innerHTML = foto +
      '<div class="nc-colab-txt"><b>' + esc(nome || '—') + '</b>' +
      '<span>' + esc([codigo(quem) ? 'Matrícula ' + codigo(quem) : '', bonito(sitTxt)].filter(Boolean).join(' · ')) + '</span>' +
      (emp ? '<span>' + esc(bonito(semCodigo(emp))) + '</span>' : '') +
      (adm ? '<span>Na empresa desde ' + esc(extenso(adm)) + '</span>' : '') + '</div>';
    if (c.bt) card.appendChild(c.bt);
  }
  function montarColab() {
    regioesColab().forEach(function (c) {
      vestirColab(c);
      /* valor que chega depois (ação dinâmica): refaz o cartão, ou mostra a região */
      $(c.reg).on('change', 'input', function () { vestirColab(c); });
    });
  }

  /* ═══ [C3] OS FILTROS DE ESCOLHA MÚLTIPLA ════════════════════════════════════════════════
     O plugin Select2 (be.ctb.select2) com várias escolhas: rótulo em cima, campo na largura,
     dica curta. O botão de filtrar da MESMA região (só ícone: funil/lupa, título "Filtrar" ou
     "Pesquisar") ganha o texto e vai para o lado do campo.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarFiltros() {
    [].forEach.call(document.querySelectorAll('.apex-item-wrapper.plugin-be\\.ctb\\.select2'), function (cx) {
      if (cx.classList.contains('nc-filtro')) return;
      var sel = cx.querySelector('select[multiple]'); if (!sel) return;
      cx.classList.add('nc-filtro');
      var wrap = cx.querySelector('.t-Form-itemWrapper');
      var reg = cx.closest('.t-Region') || document;
      var bt = [].filter.call(reg.querySelectorAll('button.t-Button'), function (b) {
        var t = (b.getAttribute('title') || '') + ' ' + (b.getAttribute('aria-label') || '') + ' ' + b.textContent;
        return /filtrar|pesquisar/i.test(t) && !b.closest('.nc-filtro');
      })[0];
      if (bt && wrap) {
        bt.classList.add('nc-filtro-bt');
        if (!limpo(bt.textContent)) bt.insertAdjacentHTML('beforeend', '<span class="nc-filtro-txt">Filtrar</span>');
        if (!bt.querySelector('.t-Icon, .fa')) bt.insertAdjacentHTML('afterbegin', IC_FUNIL);
        wrap.appendChild(bt);
      }
      var dica = el('p', 'nc-filtro-dica', 'Escolha um ou mais. Sem escolha, aparecem todos.');
      (cx.querySelector('.t-Form-inputContainer') || cx).appendChild(dica);
    });
  }

  /* ═══ [C4] O MAESTRO ═════════════════════════════════════════════════════════════════════
     Depois das ações de abertura da página (apexreadyend), com reserva de 3 s; o plugin
     Select2 se monta sozinho — os filtros são vistos de novo um pouco depois.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var foi = false;
  function iniciar() {
    if (foi) return; foi = true;
    try { montarColab(); montarFiltros(); setTimeout(montarFiltros, 800); } catch (e) { if (window.console) console.warn('[Natcorp colab]', e); }
  }
  $(window).one('apexreadyend', function () { setTimeout(iniciar, 60); });
  $(function () { setTimeout(iniciar, 3000); });
  if (document.readyState === 'complete') setTimeout(iniciar, 300);
})();
