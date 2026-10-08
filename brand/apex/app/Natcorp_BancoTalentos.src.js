/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · BANCO DE TALENTOS  —  o "arrumador" da tela (JavaScript)                      ║
   ║  App 9110 (Recrutamento e Seleção) · Página 182 ("Candidatos")                           ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: BANCOTALENTOS-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Onde o recrutador procura, no banco de talentos, quem combina com a vaga aberta. Antes: 9
   botões de filtro que abriam 9 janelas (sem mostrar o que estava ativo) e um relatório de 36 colunas com o NOME na 4ª e linhas
   altíssimas (formação, cursos e empregos em células escondidas à direita). Agora:
     • PARA QUAL VAGA? — o recrutador escolhe uma das vagas abertas (nº ou cargo); os REQUISITOS da requisição (instrução,
       formações, cursos, conhecimentos, experiências, idiomas, local; exigido/desejável) vêm do
       processo NC_BT_VAGA e cada candidato ganha a ADERÊNCIA à vaga ("atende 4 de 5 exigidos",
       ✓/✗ por requisito) e a lista pode ser ordenada por ela;
     • FILTROS num painel só, por assunto, em grupos que abrem e fecham (cada um diz quantos
       campos estão preenchidos e tem "Limpar"); Externos | Internos | Selecionados em um toque;
       os filtros ativos viram etiquetas acima dos resultados;
     • UM CARTÃO POR CANDIDATO: nome, idade, cidade, situação, instrução, formação, idiomas,
       cursos, habilidades, experiência (com o tempo somado), contatos e as ações de sempre;
     • SELEÇÃO com barra "N selecionados · Incluir em processo" — a janela já vem com a vaga.
     • Lista | Tabela: a Tabela é o relatório interativo original, inteiro.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     A busca continua a do APEX: os filtros são os MESMOS itens P182_* (movidos para o painel) e
     "Pesquisar" é o botão original. A aderência é calculada NA TELA, com o texto do cadastro de
     cada candidato (é uma ESTIMATIVA — está escrito assim na tela); não grava nada.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 182 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_BancoTalentos.js
     Página 182 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_BancoTalentos.css
     Processo (Ajax Callback) NC_BT_VAGA — criado pelo aplicar-bancotalentos-pagina182.py.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [B1]  Ferramentas
     [B2]  As colunas dos relatórios (pelo título)                     CUIDADO
     [B3]  O painel de filtros (grupos)                                PODE MEXER (GRUPOS)
     [B4]  Filtros ativos (etiquetas)
     [B5]  A vaga: requisitos da requisição (NC_BT_VAGA)
     [B6]  A aderência (comparar candidato × requisitos)               PODE MEXER (pesos/níveis)
     [B7]  Ler os candidatos
     [B8]  Desenhar os cartões
     [B9]  Seleção e "Incluir em processo"
     [B10] O maestro
*/
(function () {
  'use strict';
  if (window.__ncBancoTalentos || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [B1] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function sem(t) { return String(t || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/\s+/g, ' ').trim(); }
  function vazio(t) { return !t || /^[\s\-–()]*$/.test(t); }
  function frase(t) { t = String(t || '').trim(); if (/[a-zà-ú]/.test(t)) return t; t = t.toLowerCase(); return t.charAt(0).toUpperCase() + t.slice(1); }
  function nome(t) { return String(t || '').toLowerCase().replace(/(^|[\s'(/-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); }).replace(/\s(De|Da|Do|Das|Dos|E|Em|Ao|Aos|A|O|Para|Com)(?=\s)/g, function (x) { return x.toLowerCase(); }); }
  function iniciais(n) { var p = String(n || '?').split(/\s+/).filter(function (x) { return x.length > 2; }); return ((p[0] || '?').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  function data(t) { var m = /(\d{1,2})\/(\d{1,2})\/(\d{4})/.exec(String(t || '')); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  /* o texto que o RH digitou na requisição ("SQL", "Pacote Office"): só arruma se veio TODO em maiúsculas */
  var SIGLAS = /^(SQL|SAP|ERP|CRM|TI|RH|DP|CNH|NR\d*|PHP|CSS|HTML|AWS|BI|UX|UI|MBA|CLT|PCD|SST|CIPA|EPI|ISO|PMP|ITIL|API|JAVA|NET)$/;
  function textoReq(t) {
    t = String(t || '').trim(); if (/[a-zà-ú]/.test(t)) return t;
    var orig = t.split(/\s+/);
    return nome(t).split(/\s+/).map(function (w, i) { var o = orig[i] || ''; return SIGLAS.test(o.replace(/[^A-Z0-9]/g, '')) || /^[B-DF-HJ-NP-TV-Z]{2,4}$/.test(o) ? o : w; }).join(' ');
  }
  function lembrar(k, v) { try { if (v === undefined) return localStorage.getItem(k); localStorage.setItem(k, v); } catch (e) { return null; } }
  var IC = {
    vaga: '<rect x="3.5" y="7" width="17" height="12.5" rx="2"/><path d="M9 7V5.5a1.5 1.5 0 0 1 1.5-1.5h3A1.5 1.5 0 0 1 15 5.5V7M3.5 12.5h17"/>',
    lupa: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    mais: '<path d="M6.5 9.5l5.5 5.5 5.5-5.5"/>', x: '<path d="M7 7l10 10M17 7L7 17"/>',
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>', nao: '<path d="M8 8l8 8M16 8l-8 8"/>',
    cv: '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4"/><circle cx="12.5" cy="12.5" r="2"/><path d="M9.5 18a3 3 0 0 1 6 0"/>',
    email: '<rect x="3.5" y="5.5" width="17" height="13" rx="2"/><path d="M4 7l8 6 8-6"/>',
    whats: '<path d="M4.5 20l1.2-4A8 8 0 1 1 8.5 19z"/><path d="M9 9.5c0 3 2.5 5.5 5.5 5.5l1-1.5-2-1-1 1a4 4 0 0 1-2-2l1-1-1-2z"/>',
    linkedin: '<rect x="3.5" y="3.5" width="17" height="17" rx="3"/><path d="M8 10.5v5.5M8 7.6v.1M11.5 16v-5.5M11.5 13a2.5 2.5 0 0 1 5 0v3"/>',
    abrir: '<path d="M9.5 6l6 6-6 6"/>', local: '<path d="M12 21s-6.5-5.6-6.5-11a6.5 6.5 0 0 1 13 0C18.5 15.4 12 21 12 21z"/><circle cx="12" cy="10" r="2.3"/>',
    lista: '<path d="M9 6.5h11M9 12h11M9 17.5h11"/><circle cx="4.8" cy="6.5" r="1"/><circle cx="4.8" cy="12" r="1"/><circle cx="4.8" cy="17.5" r="1"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M3.5 14.5h17M9.5 10v9"/>',
    pessoas: '<circle cx="9" cy="8.5" r="3.2"/><path d="M3.5 19.5a5.5 5.5 0 0 1 11 0"/><path d="M15.5 5.6a3.2 3.2 0 0 1 0 6.1M17.6 14.2a5.5 5.5 0 0 1 2.9 5.3"/>',
    funil: '<path d="M4 5h16l-6.2 7.4v5.4l-3.6 1.7v-7.1z"/>',
    pessoa: '<circle cx="12" cy="8" r="3.6"/><path d="M5 20a7 7 0 0 1 14 0"/>',
    capelo: '<path d="M2.5 9.5L12 5l9.5 4.5L12 14z"/><path d="M6.5 11.6v4.2c0 1.4 2.5 2.7 5.5 2.7s5.5-1.3 5.5-2.7v-4.2M21.5 9.5v5"/>',
    certificado: '<rect x="3.5" y="4.5" width="17" height="12" rx="2"/><path d="M7.5 8.5h9M7.5 11.5h5"/><circle cx="16" cy="14.8" r="2.2"/><path d="M14.8 16.7l-.8 3.3 2-1 2 1-.8-3.3"/>',
    idioma: '<path d="M4 5.5h9.5v6.5H8.5l-3 2.5v-2.5H4z"/><path d="M13.5 9.5H20v6.5h-1v2.5l-3-2.5h-2.5z"/>',
    estrela: '<path d="M12 4l2.4 4.9 5.4.8-3.9 3.8.9 5.4L12 16.4l-4.8 2.5.9-5.4-3.9-3.8 5.4-.8z"/>',
    casa: '<path d="M4 11l8-6.5 8 6.5"/><path d="M6 9.6v9.9h12V9.6"/><path d="M10 19.5v-5h4v5"/>',
    bandeira: '<path d="M5.5 21V4M5.5 4.5h11l-2 3.7 2 3.8h-11"/>',
    acessivel: '<circle cx="12" cy="4.6" r="1.6"/><path d="M5.5 8.2l6.5 1.3 6.5-1.3M12 9.5v4.5M12 14l-3 6M12 14l3 6"/>',
    predio: '<rect x="5" y="3.5" width="14" height="17" rx="1.5"/><path d="M9 7.5h2M13 7.5h2M9 11h2M13 11h2M9 14.5h2M13 14.5h2M10.5 20.5v-3h3v3"/>'
  };
  function ic(n) { return '<svg class="nc-bt-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  function botaoPorTexto(rx, raiz) { return [].filter.call((raiz || document).querySelectorAll('button.t-Button, a.t-Button'), function (b) { return rx.test(b.textContent.trim()); })[0]; }

  /* ═══ [B2] AS COLUNAS DOS RELATÓRIOS ═════════════════════════════════════════════════════
     CUIDADO  Os três relatórios (Externos, Internos, Selecionados) têm títulos parecidos; a
              lista liga o título (sem acento, minúsculo) ao campo. Mudou o título, mude aqui.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var COLUNAS = {
    'link': 'link', 'consultar': 'link', 'selecione': 'sel', 'nome': 'nome', 'colaborador': 'nome', 'nome social': 'social',
    'cod. candidato': 'cod', 'matricula': 'mat', 'idade': 'idade', 'sexo': 'sexo', 'genero': 'genero', 'cidade': 'cidade', 'uf': 'uf',
    'bairro': 'bairro', 'e-mail pessoal': 'mail', 'e-mail funcional': 'mailFunc', 'celular': 'cel', 'status candidato': 'status',
    'em processo seletivo?': 'emPS', 'pcd': 'pcd', 'data de cadastro': 'cad', 'data de atualizacao': 'atual', 'grau de instrucao': 'instrucao',
    'formacao': 'formacao', 'cursos': 'cursos', 'idiomas': 'idiomas', 'habilidade': 'habilidade', 'empregos anteriores': 'empregos',
    'qualificacao': 'qualif', 'cargo pretendido': 'cargoPret', 'funcao pretendida': 'funcaoPret', 'areas de interesse': 'areas',
    'local pretendido': 'localPret', 'cnh': 'cnh', 'cargo': 'cargo', 'empresa': 'empresa', 'filial': 'filial', 'situacao': 'situacao',
    'data de admissao': 'admissao', 'disponivel': 'disponivel', 'no processo seletivo': 'ps', 'nº processo seletivo': 'ps',
    'data de contratacao': 'contratacao', 'arquivo curriculo': 'arqCv', 'linkedin': 'linkedin', 'enviar e-mail': 'enviar', 'whatsapp': 'whats'
  };
  var RELATORIOS = [['candidatos_externos', 'Candidatos externos'], ['candidatos_internos', 'Candidatos internos (colaboradores)'], ['candidatos_selecionados', 'Candidatos selecionados']];

  /* ═══ [B3] O PAINEL DE FILTROS ═══════════════════════════════════════════════════════════
     Cada janela de filtro do APEX vira um GRUPO no painel (os itens são MOVIDOS para lá; o
     "Limpar Filtro" é o original). PODE MEXER  GRUPOS: [título da janela, nome no painel].
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* [título da janela, nome no painel, ícone (IC)] */
  var GRUPOS = [['dados pessoais', 'Dados pessoais', 'pessoa'], ['formacao', 'Formação', 'capelo'], ['cursos', 'Cursos', 'certificado'],
    ['idioma', 'Idiomas', 'idioma'], ['habilidade', 'Habilidades', 'estrela'], ['residencia', 'Onde mora', 'casa'],
    ['nacionalidade', 'Nacionalidade', 'bandeira'], ['pcd', 'PCD', 'acessivel'], ['vaga', 'Empresa e lotação', 'predio']];
  var TIPOS = [['E', 'Externos'], ['I', 'Internos'], ['S', 'Selecionados']];
  function janelaDe(rx) {
    return [].filter.call(document.querySelectorAll('.js-regionDialog'), function (r) {
      var t = r.closest('.ui-dialog'); t = t && t.querySelector('.ui-dialog-title');
      return t && rx === sem(t.textContent);
    })[0];
  }
  function valorItem(c) {
    var id = c.id.replace(/_CONTAINER$/, ''), it = apex.item(id), v = it && it.getValue ? it.getValue() : '';
    if (Array.isArray(v)) v = v.join(':');
    return v === null || v === undefined ? '' : String(v);
  }
  function textoItem(c) {
    var id = c.id.replace(/_CONTAINER$/, ''), e = $id(id), v = valorItem(c);
    if (!v) return '';
    if (e && e.tagName === 'SELECT') return [].filter.call(e.options, function (o) { return o.selected; }).map(function (o) { return o.text; }).join(', ');
    if (e && e.closest('.apex-item-group--popup-lov')) { try { var d = apex.item(id).displayValueFor(v); if (d && d !== v) return d; } catch (x) { /* sem displayValueFor */ } return e.value || v; }
    if (c.querySelector('input[type=checkbox]')) return [].filter.call(c.querySelectorAll('input[type=checkbox]:checked'), function (x) { return 1; }).map(function (x) { var l = c.querySelector('label[for="' + x.id + '"]'); return l ? l.textContent.trim() : 'Sim'; }).join(', ');
    return v.replace(/:/g, ', ');
  }
  function rotulo(c) { var l = c.querySelector('.t-Form-label'); return l ? l.textContent.replace(/\(Valor Necessário\)|\*/gi, '').trim() : ''; }
  var PAINEL = null, GRUPOS_EL = [];
  function montarPainel(regFiltros) {
    var corpo = regFiltros.querySelector('.t-Region-body') || regFiltros;
    var p = el('div', 'nc-bt-painel');
    /* 1. a vaga */
    var vagaAberta = lembrar('nc-bt-vaga-aberta') === 'S';   /* começa recolhida; lembra só o que o recrutador escolheu */
    p.innerHTML =
      '<details class="nc-bt-cartao nc-bt-vaga-cx"' + (vagaAberta ? ' open' : '') + '>' +
        '<summary><h2>' + ic('vaga') + 'Para qual vaga?</h2><span class="nc-bt-vaga-sel is-vazia">Nenhuma vaga escolhida</span></summary>' +
        '<div class="nc-bt-vaga-corpo">' +
        '<p class="nc-bt-ajuda">Escolha a vaga aberta: cada candidato é comparado com os requisitos da requisição.</p>' +
        '<div class="nc-bt-vaga-campo"><label class="nc-bt-vaga-rot" for="nc-bt-vaga-txt">Nº ou cargo da vaga</label>' +
          '<input type="text" id="nc-bt-vaga-txt" class="nc-bt-vaga-txt" list="nc-bt-vagas" autocomplete="off" inputmode="search" placeholder="Ex.: 57463 ou Analista">' +
          '<datalist id="nc-bt-vagas"></datalist></div><button type="button" class="nc-bt-bt nc-bt-bt--primario" data-vaga-usar>Comparar com a vaga</button>' +
        '<div class="nc-bt-vaga-res" hidden></div></div></details>' +
      '<section class="nc-bt-cartao nc-bt-quem"><h2>' + ic('pessoas') + 'Quem buscar</h2>' +
        '<div class="nc-bt-tipos" role="group" aria-label="Tipo de candidato">' + TIPOS.map(function (t) { return '<button type="button" data-tipo="' + t[0] + '">' + t[1] + '</button>'; }).join('') + '</div>' +
        '<div class="nc-bt-quem-campos"></div></section>' +
      '<section class="nc-bt-cartao nc-bt-filtros"><h2>' + ic('funil') + 'Filtros <button type="button" class="nc-bt-link" data-limpar-tudo>Limpar tudo</button></h2><div class="nc-bt-grupos"></div></section>' +
      '<div class="nc-bt-pe"></div>';
    corpo.insertBefore(p, corpo.firstChild);
    PAINEL = p;
    /* CUIDADO  a vaga comparada NÃO é o P182_PS: esse filtra a lista de SELECIONADOS pelo processo
               (só aparece nesse modo e a página o limpa ao trocar o tipo). Fica no grupo dele. */
    /* Período e Indicados */
    var quem = p.querySelector('.nc-bt-quem-campos');
    ['P182_PERIODO', 'P182_INDICADO'].forEach(function (id) { var c = $id(id + '_CONTAINER'); if (c) quem.appendChild(c); });
    var cTipo = $id('P182_TIPO_CONTAINER'); if (cTipo) cTipo.classList.add('nc-bt-guardado');
    /* os grupos */
    var cx = p.querySelector('.nc-bt-grupos');
    GRUPOS.forEach(function (g) {
      var r = janelaDe(g[0]); if (!r) return;
      var itens = [].slice.call(r.querySelectorAll('.t-Form-fieldContainer'));
      if (!itens.length) return;
      var d = el('details', 'nc-bt-grupo');
      d.innerHTML = '<summary>' + ic(g[2]) + '<span>' + esc(g[1]) + '</span><b class="nc-bt-conta" hidden></b></summary><div class="nc-bt-grupo-corpo"></div>' +
        '<div class="nc-bt-grupo-pe"><button type="button" class="nc-bt-link" data-limpar-grupo>Limpar ' + esc(g[1].toLowerCase()) + '</button></div>';
      var c2 = d.querySelector('.nc-bt-grupo-corpo');
      itens.forEach(function (c) { c2.appendChild(c); });
      d.__limpar = botaoPorTexto(/^limpar filtro$/i, r);
      d.__itens = itens; d.__nome = g[1];
      cx.appendChild(d);
      GRUPOS_EL.push(d);
    });
    /* os 9 botões que abriam as janelas saem; Pesquisar vai para o pé, fixo */
    [].forEach.call(regFiltros.querySelectorAll('.t-Button'), function (b) {
      if (p.contains(b)) return;
      if (/^pesquisar$/i.test(b.textContent.trim())) { b.classList.add('nc-bt-bt', 'nc-bt-bt--primario', 'nc-bt-pesquisar'); p.querySelector('.nc-bt-pe').appendChild(b); }
      else b.classList.add('nc-bt-guardado');
    });
    contarGrupos(true);
    marcarTipo();
  }
  function contarGrupos(abrir) {
    GRUPOS_EL.forEach(function (d) {
      var n = d.__itens.filter(function (c) { return valorItem(c); }).length;
      var b = d.querySelector('.nc-bt-conta'); b.hidden = !n; b.textContent = n;
      d.classList.toggle('is-ativo', !!n);
      if (abrir && n) d.open = true;
    });
    desenharAtivos();
  }
  function marcarTipo() {
    if (!PAINEL) return;
    var t = $v('P182_TIPO') || 'E';
    [].forEach.call(PAINEL.querySelectorAll('[data-tipo]'), function (b) { b.setAttribute('aria-pressed', String(b.getAttribute('data-tipo') === t)); });
  }

  /* ═══ [B4] FILTROS ATIVOS ════════════════════════════════════════════════════════════════
     Uma etiqueta por campo preenchido ("Idiomas: Inglês ×"). Tirar a etiqueta limpa o campo;
     a lista só muda ao Pesquisar (é a busca do APEX) — a barra avisa.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ATIVOS = null, MUDOU = false;
  function desenharAtivos() {
    if (!ATIVOS) return;
    var chips = [];
    GRUPOS_EL.forEach(function (d) {
      d.__itens.forEach(function (c) {
        var t = textoItem(c); if (!t) return;
        chips.push('<button type="button" class="nc-bt-chip" data-tira="' + esc(c.id.replace(/_CONTAINER$/, '')) + '" title="Tirar este filtro"><i>' + esc(rotulo(c) || d.__nome) + ':</i> ' + esc(t.length > 40 ? t.slice(0, 38) + '…' : t) + ic('x') + '</button>');
      });
    });
    var per = $id('P182_PERIODO'); if (per && per.offsetParent !== null && per.value && per.value !== '0') chips.unshift('<span class="nc-bt-chip nc-bt-chip--fixo"><i>Período:</i> ' + esc(per.options[per.selectedIndex].text) + '</span>');
    ATIVOS.innerHTML = chips.length ? '<span class="nc-bt-ativos-rot">Filtrando por</span>' + chips.join('') +
      (MUDOU ? '<span class="nc-bt-aviso">Filtros mudaram — <button type="button" class="nc-bt-link" data-pesquisar>Pesquisar</button></span>' : '') : '';
    ATIVOS.hidden = !chips.length;
  }

  /* ═══ [B5] A VAGA: OS REQUISITOS DA REQUISIÇÃO ═══════════════════════════════════════════
     NC_BT_VAGA (Ajax Callback desta página, só leitura) devolve, para o nº do processo (x01):
       { processo, cargo, instrucao, anos, meses, cidade, uf, modalidade,
         formacoes:[{nome,instrucao,exige}], cursos:[{nome,exige}], conhecimentos:[{nome,nivel,exige}],
         experiencias:[{nome,exige}], idiomas:[{nome,nivel}] }   ou { erro }
     Com x01 = LISTA devolve as vagas abertas { vagas:[{processo,cargo,filial}] } (a mesma regra da
     lista "Processo Seletivo" da janela de inclusão): viram as sugestões do campo.
     A vaga escolhida fica guardada (nc-bt-vaga) e volta depois do Pesquisar e no dia seguinte.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var VAGA = null, REQS = [];
  function resumoVaga() {
    var el2 = PAINEL && PAINEL.querySelector('.nc-bt-vaga-sel'); if (!el2) return;
    el2.textContent = VAGA ? VAGA.processo + ' · ' + nome(VAGA.cargo) : 'Nenhuma vaga escolhida';
    el2.classList.toggle('is-vazia', !VAGA);
  }
  function numeroDaVaga(t) {
    t = String(t || '').trim(); var m = /^(\d+)/.exec(t) || /\((\d+)\)\s*$/.exec(t);
    if (m) return m[1];
    var lista = PAINEL ? [].slice.call(PAINEL.querySelectorAll('#nc-bt-vagas option')) : [], q = sem(t);
    var achou = q && lista.filter(function (o) { return sem(o.value).indexOf(q) >= 0; });
    return achou && achou.length === 1 ? /^(\d+)/.exec(achou[0].value)[1] : '';
  }
  function listarVagas() {
    apex.server.process('NC_BT_VAGA', { x01: 'LISTA' }, { dataType: 'json' }).done(function (j) {
      var dl = PAINEL && PAINEL.querySelector('#nc-bt-vagas'); if (!dl || !j || !j.vagas) return;
      dl.innerHTML = j.vagas.map(function (v) { return '<option value="' + esc(v.processo + ' — ' + nome(v.cargo) + (v.filial ? ' · ' + nome(v.filial) : '')) + '"></option>'; }).join('');
    });
  }
  function carregarVaga(ps) {
    var res = PAINEL && PAINEL.querySelector('.nc-bt-vaga-res'), txt = PAINEL && PAINEL.querySelector('.nc-bt-vaga-txt');
    if (!res) return;
    if (ps === undefined) ps = numeroDaVaga(txt.value);
    if (!ps) {
      VAGA = null; REQS = []; lembrar('nc-bt-vaga', '');
      res.hidden = !txt.value.trim(); res.innerHTML = txt.value.trim() ? '<p class="nc-bt-erro">Não achei essa vaga entre as abertas. Digite o nº do processo ou escolha uma das sugestões.</p>' : '';
      desenharVaga(); resumoVaga(); desenhar(); return;
    }
    lembrar('nc-bt-vaga', ps);
    res.hidden = false; res.innerHTML = '<p class="nc-bt-ajuda">Lendo os requisitos da vaga…</p>';
    apex.server.process('NC_BT_VAGA', { x01: ps }, { dataType: 'json' }).done(function (j) {
      if (!j || j.erro) { VAGA = null; REQS = []; res.innerHTML = '<p class="nc-bt-erro">' + esc((j && j.erro) || 'Não foi possível ler a vaga.') + '</p>'; desenharVaga(); resumoVaga(); desenhar(); return; }
      VAGA = j; REQS = requisitos(j);
      if (txt && !/^\d+\s*—/.test(txt.value)) txt.value = j.processo + ' — ' + nome(j.cargo);
      res.innerHTML = '<p class="nc-bt-ajuda">' + REQS.filter(function (r) { return r.exige; }).length + ' exigidos · ' + REQS.filter(function (r) { return !r.exige; }).length + ' desejáveis' +
        (j.cidade ? ' · ' + esc(nome(j.cidade)) + (j.uf ? '/' + esc(j.uf) : '') : '') + '</p>' +
        '<button type="button" class="nc-bt-link" data-vaga-tirar>Não comparar</button>';
      if (!ORDEM_ESCOLHIDA) ORDEM = 'aderencia';
      desenharVaga(); resumoVaga(); desenhar();
    }).fail(function () {
      VAGA = null; REQS = [];
      res.innerHTML = '<p class="nc-bt-erro">Não foi possível ler a vaga (o processo NC_BT_VAGA desta página foi importado?).</p>';
      desenharVaga(); resumoVaga(); desenhar();
    });
  }
  function requisitos(j) {
    var out = [], ex = function (v) { return !/^n/i.test(v || 'S'); };
    if (!vazio(j.instrucao)) out.push({ tipo: 'instrucao', nome: frase(j.instrucao), exige: true });
    (j.formacoes || []).forEach(function (f) { out.push({ tipo: 'formacao', nome: textoReq(f.nome), extra: f.instrucao, exige: ex(f.exige) }); });
    (j.cursos || []).forEach(function (f) { out.push({ tipo: 'curso', nome: textoReq(f.nome), exige: ex(f.exige) }); });
    (j.conhecimentos || []).forEach(function (f) { out.push({ tipo: 'conhecimento', nome: textoReq(f.nome), nivel: f.nivel, exige: ex(f.exige) }); });
    (j.experiencias || []).forEach(function (f) { out.push({ tipo: 'experiencia', nome: textoReq(f.nome), exige: ex(f.exige) }); });
    (j.idiomas || []).forEach(function (f) { out.push({ tipo: 'idioma', nome: nome(f.nome), nivel: f.nivel, exige: true }); });
    var anos = (+j.anos || 0) + (+j.meses || 0) / 12;
    if (anos > 0) out.push({ tipo: 'tempo', nome: 'Experiência de ' + (j.anos ? j.anos + (j.anos == 1 ? ' ano' : ' anos') : '') + (j.meses ? (j.anos ? ' e ' : '') + j.meses + ' meses' : ''), anos: anos, exige: false });
    if (!vazio(j.cidade)) out.push({ tipo: 'local', nome: 'Mora em ' + nome(j.cidade) + (j.uf ? '/' + j.uf : ''), cidade: j.cidade, uf: j.uf, exige: false });
    return out;
  }
  var PERFIL = null;
  function desenharVaga() {
    if (!PERFIL) return;
    if (!VAGA) { PERFIL.hidden = true; PERFIL.innerHTML = ''; return; }
    var ex = REQS.filter(function (r) { return r.exige; }), de = REQS.filter(function (r) { return !r.exige; });
    PERFIL.hidden = false;
    PERFIL.innerHTML = '<div class="nc-bt-perfil-tit"><p>Comparando com a vaga</p><h3>' + esc(nome(VAGA.cargo)) + ' <span>' + esc(VAGA.processo) + '</span></h3></div>' +
      (ex.length ? '<div class="nc-bt-perfil-grupo"><span class="nc-bt-perfil-rot">Exigido</span>' + ex.map(function (r) { return '<span class="nc-bt-req">' + esc(r.nome) + (r.nivel ? ' · ' + esc(frase(r.nivel)) : '') + '</span>'; }).join('') + '</div>' : '') +
      (de.length ? '<div class="nc-bt-perfil-grupo"><span class="nc-bt-perfil-rot">Desejável</span>' + de.map(function (r) { return '<span class="nc-bt-req nc-bt-req--des">' + esc(r.nome) + (r.nivel ? ' · ' + esc(frase(r.nivel)) : '') + '</span>'; }).join('') + '</div>' : '') +
      (!REQS.length ? '<p class="nc-bt-ajuda">A requisição desta vaga não tem requisitos cadastrados.</p>' : '') +
      '<p class="nc-bt-nota">A aderência é estimada pelo texto do cadastro de cada candidato (formação, cursos, idiomas, habilidades, empregos).</p>';
  }

  /* ═══ [B6] A ADERÊNCIA ═══════════════════════════════════════════════════════════════════
     PODE MEXER  PESO (exigido 3, desejável 1), os níveis de instrução e de idioma, PALAVRAS_FRACAS,
                 ABREVIACOES e EQUIVALENTES.
     Instrução: o candidato atende se o nível dele for IGUAL OU MAIOR. Idioma: mesmo idioma e
     nível igual ou maior. Tempo: soma das datas dos empregos. Local: mesma cidade.
     Formação/curso/conhecimento/experiência — TEXTO CONTRA TEXTO, numa linha do cadastro de cada vez
     (uma formação, um curso, um emprego: "analista" de um emprego não soma com "negócios" de outro):
       1. sem acento, sem maiúscula, sem pontuação; "de/da/em…" saem (PALAVRAS_FRACAS);
       2. EQUIVALENTES viram um nome só ("gestão de pessoas" = "recursos humanos" = "RH");
       3. ABREVIACOES que não são começo da palavra viram a palavra ("an." = analista, "jr" = junior);
       4. plural = singular ("negócios" = "negócio", "contábeis" = "contábil");
       5. uma palavra casa com outra se for igual, se uma for o COMEÇO da outra com 3+ letras
          ("adm" ⇄ "administração", nos dois sentidos) ou, de 6 letras para cima, se diferir em
          UMA letra (erro de digitação: "adminstração");
       6. requisito de até 2 palavras: todas; de 3 ou mais: 60% delas.
     O ✓ mostra, ao passar o mouse, a linha do cadastro onde achou.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PESO = { exigido: 3, desejavel: 1 };
  var PALAVRAS_FRACAS = /^(de|da|do|das|dos|e|em|para|com|a|o|as|os|na|no|nas|nos|ao|aos|um|uma|area|curso|conhecimento|conhecimentos|experiencia|nivel|basico)$/;
  function nivelInstrucao(t) {
    t = sem(t); if (!t) return null;
    var inc = /incomplet|cursando|nao concl/.test(t), n = null;
    if (/doutor/.test(t)) n = 10; else if (/mestr/.test(t)) n = 9; else if (/pos|especializ|mba/.test(t)) n = 8;
    else if (/superior|graduac|bacharel|licenciat|tecnolog/.test(t)) n = 7; else if (/tecnico/.test(t)) n = 5;
    else if (/medio|2o grau|segundo grau|colegial/.test(t)) n = 4; else if (/fundamental|1o grau|primeiro grau|ginasio|ano/.test(t)) n = 2;
    else if (/alfabetiz|analfabet/.test(t)) n = 0;
    return n === null ? null : n - (inc ? 1 : 0);
  }
  function nivelIdioma(t) { t = sem(t); return /nativ/.test(t) ? 5 : /fluent/.test(t) ? 4 : /avanc/.test(t) ? 3 : /intermed/.test(t) ? 2 : /basic/.test(t) ? 1 : 0; }
  /* PODE MEXER  abreviações que NÃO são o começo da palavra (as que são — adm, aux, eng, coord,
                 sup, ger, tec, assist — já casam sozinhas pela regra 5). Sem acento, minúsculas. */
  var ABREVIACOES = { an: 'analista', op: 'operador', jr: 'junior', sr: 'senior', pl: 'pleno', ass: 'assistente' };
  /* PODE MEXER  nomes diferentes para a MESMA coisa; cada linha vira o 1º nome. Mais longos primeiro
                 não é preciso (o código ordena). Sem acento, minúsculas. */
  var EQUIVALENTES = [
    ['recursos humanos', 'rh', 'gestao de pessoas', 'gestao de rh', 'gestao de recursos humanos'],
    ['departamento pessoal', 'dp', 'depto pessoal', 'dep pessoal'],
    ['tecnologia da informacao', 'ti'],
    ['ciencias contabeis', 'contabilidade', 'contabil'],
    ['administracao', 'administracao de empresas', 'gestao empresarial'],
    ['seguranca do trabalho', 'sst', 'saude e seguranca do trabalho', 'tst', 'tecnico de seguranca do trabalho'],
    ['servicos gerais', 'auxiliar de limpeza', 'zeladoria'],
    ['atendimento ao cliente', 'sac', 'atendimento ao publico'],
    ['pacote office', 'ms office', 'microsoft office'],
    ['vendas', 'vendedor', 'vendedora', 'venda']
  ];
  var TROCAS = [];
  EQUIVALENTES.forEach(function (g) { g.slice(1).forEach(function (v) { TROCAS.push([v, g[0]]); }); });
  TROCAS.sort(function (a, b) { return b[0].length - a[0].length; });
  /* no REQUISITO o sinônimo vira o nome principal; no CADASTRO ele é ACRESCENTADO (as palavras do
     candidato ficam: "Administração de Empresas" ainda precisa achar o "Empresa" de "Adm. Empresa") */
  function limpar(t, acrescentar) {
    t = ' ' + sem(t).replace(/[^a-z0-9 ]/g, ' ').replace(/\s+/g, ' ') + ' ';
    var mais = [];
    TROCAS.forEach(function (x) {
      if (t.indexOf(' ' + x[0] + ' ') < 0) return;
      if (acrescentar) mais.push(x[1]); else t = t.split(' ' + x[0] + ' ').join(' ' + x[1] + ' ');
    });
    return (t + mais.join(' ')).trim();
  }
  function raiz(w) {
    w = ABREVIACOES[w] || w;
    if (w.length <= 3) return w;
    return w.replace(/coes$/, 'cao').replace(/oes$/, 'ao').replace(/aes$/, 'ao').replace(/eis$/, 'il').replace(/ais$/, 'al')
      .replace(/([rzl])es$/, '$1').replace(/([^s])s$/, '$1');
  }
  function palavras(t, acrescentar) { return limpar(t, acrescentar).split(' ').filter(function (w) { return w.length > 1 && !PALAVRAS_FRACAS.test(w); }).map(raiz); }
  function umaLetra(a, b) {                    /* diferem em no máximo uma letra (troca, falta ou sobra) */
    if (Math.abs(a.length - b.length) > 1) return false;
    var i = 0, j = 0, dif = 0;
    while (i < a.length && j < b.length) {
      if (a[i] === b[j]) { i++; j++; continue; }
      if (++dif > 1) return false;
      if (a.length > b.length) i++; else if (b.length > a.length) j++; else { i++; j++; }
    }
    return dif + (a.length - i) + (b.length - j) <= 1;
  }
  function casa(a, b) {
    if (a === b) return true;
    var curta = a.length < b.length ? a : b, longa = curta === a ? b : a;
    if (curta.length >= 3 && longa.indexOf(curta) === 0) return true;
    return a.length >= 6 && b.length >= 6 && umaLetra(a, b);
  }
  /* devolve a LINHA do cadastro que atende (ou null) */
  function contem(texto, req) {
    var ws = palavras(req); if (!ws.length) return null;
    var linhas = String(texto || '').split('\n'), melhor = null;
    for (var k = 0; k < linhas.length; k++) {
      var ts = palavras(linhas[k], true); if (!ts.length) continue;
      var achou = ws.filter(function (w) { return ts.some(function (t) { return casa(w, t); }); }).length;
      if (ws.length <= 2 ? achou === ws.length : achou / ws.length >= 0.6) { melhor = linhas[k].trim(); break; }
    }
    return melhor;
  }
  function anosDeEmprego(empregos) {
    var tot = 0, re = /(\d{1,2}\/\d{1,2}\/\d{4})\s*(?:à|a|ate|até|-)\s*(\d{1,2}\/\d{1,2}\/\d{4})?/gi, m;
    while ((m = re.exec(empregos || ''))) { var i = data(m[1]), f = m[2] ? data(m[2]) : new Date(); if (i && f && f > i) tot += (f - i) / 31557600000; }
    return tot;
  }
  function avaliar(c) {
    if (!REQS.length) return null;
    var textoTudo = [c.formacao, c.cursos, c.habilidade, c.empregos, c.qualif, c.cargoPret, c.funcaoPret, c.areas, c.cargo].join('\n');
    var res = REQS.map(function (r) {
      var ok = false, onde = '';
      var achar = function (t) { onde = contem(t, r.nome); return !!onde; };
      if (r.tipo === 'instrucao') { var a = nivelInstrucao(c.instrucao), b = nivelInstrucao(r.nome); ok = a !== null && b !== null ? a >= b : !!c.instrucao && sem(c.instrucao) === sem(r.nome); }
      else if (r.tipo === 'formacao') ok = achar(c.formacao);
      else if (r.tipo === 'curso') ok = achar(c.cursos + '\n' + c.formacao);
      else if (r.tipo === 'conhecimento') ok = achar(textoTudo);
      else if (r.tipo === 'experiencia') ok = achar([c.empregos, c.qualif, c.cargoPret, c.funcaoPret, c.cargo].join('\n'));
      else if (r.tipo === 'idioma') ok = (c.listaIdiomas || []).some(function (i) { return sem(i.nome) === sem(r.nome) && (!r.nivel || nivelIdioma(i.nivel) >= nivelIdioma(r.nivel)); });
      else if (r.tipo === 'tempo') ok = anosDeEmprego(c.empregos) >= r.anos;
      else if (r.tipo === 'local') ok = !!c.cidade && sem(c.cidade) === sem(r.cidade);
      return { r: r, ok: ok, onde: onde };
    });
    var total = 0, feito = 0, exT = 0, exOk = 0;
    res.forEach(function (x) { var p = x.r.exige ? PESO.exigido : PESO.desejavel; total += p; if (x.ok) feito += p; if (x.r.exige) { exT++; if (x.ok) exOk++; } });
    return { pct: total ? Math.round(feito / total * 100) : 0, exT: exT, exOk: exOk, itens: res };
  }

  /* ═══ [B7] LER OS CANDIDATOS ═════════════════════════════════════════════════════════════ */
  function irVisivel() {
    for (var k = 0; k < RELATORIOS.length; k++) { var r = $id(RELATORIOS[k][0]); if (r && r.querySelector('table.a-IRR-table')) return { el: r, titulo: RELATORIOS[k][1], id: RELATORIOS[k][0] }; }
    return null;
  }
  function linhasTexto(td) {
    if (!td) return [];
    var h = td.innerHTML.replace(/<br\s*\/?>/gi, '\n').replace(/<[^>]+>/g, '');
    var d = document.createElement('textarea'); d.innerHTML = h;
    return d.value.split('\n').map(function (l) { return l.replace(/^\s*-\s*/, '').replace(/\s+/g, ' ').trim(); }).filter(function (l) { return l && !vazio(l); });
  }
  function lerCandidatos(ir) {
    var nomes = {};
    [].forEach.call(ir.querySelectorAll('table.a-IRR-table th[id]'), function (th) { var k = COLUNAS[sem(th.textContent)]; if (k) nomes[th.id] = k; });
    var out = [];
    [].forEach.call(ir.querySelectorAll('table.a-IRR-table tr'), function (tr) {
      var tds = tr.querySelectorAll('td[headers]'); if (tds.length < 3) return;
      var c = { tr: tr, td: {} };
      [].forEach.call(tds, function (td) { var k = nomes[td.getAttribute('headers')] || COLUNAS[sem(td.getAttribute('headers'))]; if (k) c.td[k] = td; });
      var t = function (k) { var td = c.td[k]; var v = td ? td.textContent.replace(/\s+/g, ' ').trim() : ''; return vazio(v) ? '' : v; };
      var a = function (k) { var td = c.td[k]; return td && td.querySelector('a[href]'); };
      ['nome', 'social', 'cod', 'mat', 'idade', 'sexo', 'genero', 'cidade', 'uf', 'bairro', 'mail', 'mailFunc', 'cel', 'status', 'emPS', 'pcd', 'cad', 'atual',
        'instrucao', 'qualif', 'cargoPret', 'funcaoPret', 'areas', 'localPret', 'cnh', 'cargo', 'empresa', 'filial', 'situacao', 'admissao', 'disponivel', 'ps', 'contratacao']
        .forEach(function (k) { c[k] = t(k); });
      c.formacaoL = linhasTexto(c.td.formacao); c.cursosL = linhasTexto(c.td.cursos); c.idiomasL = linhasTexto(c.td.idiomas);
      c.habilidadeL = linhasTexto(c.td.habilidade); c.empregosL = linhasTexto(c.td.empregos);
      c.formacao = c.formacaoL.join('\n'); c.cursos = c.cursosL.join('\n'); c.habilidade = c.habilidadeL.join('\n'); c.empregos = c.empregosL.join('\n');
      c.listaIdiomas = c.idiomasL.map(function (l) { var m = /^(.*?)\s*-\s*n[ií]vel:\s*(.*)$/i.exec(l); return m ? { nome: m[1], nivel: m[2] } : { nome: l, nivel: '' }; });
      c.chk = c.td.sel && c.td.sel.querySelector('input.checkbox_item');
      c.aLink = a('link'); c.aCv = a('arqCv'); c.aLinkedin = a('linkedin'); c.aEnviar = a('enviar'); c.aWhats = a('whats');
      c.anos = anosDeEmprego(c.empregos);
      c.av = avaliar(c);
      out.push(c);
    });
    return out;
  }

  /* ═══ [B8] DESENHAR OS CARTÕES ═══════════════════════════════════════════════════════════ */
  var CANDS = [], ORDEM = '', ORDEM_ESCOLHIDA = false, ABERTOS = {}, APP = null, IR = null;
  var ORDENS = {
    aderencia: function (a, b) { return (b.av ? b.av.pct : -1) - (a.av ? a.av.pct : -1); },
    recente: function (a, b) { return (data(b.atual) || 0) - (data(a.atual) || 0); },
    nome: function (a, b) { return String(a.nome).localeCompare(String(b.nome), 'pt-BR'); }
  };
  function formacaoTxt(l) {
    var m = /^(.*?)\s*-\s*entidade:\s*(.*?)\s*-\s*(n[aã]o\s+)?conclu[ií]do$/i.exec(l);
    return m ? '<b>' + esc(nome(m[1])) + '</b> <span>' + esc(nome(m[2])) + ' · ' + (m[3] ? 'não concluído' : 'concluído') + '</span>' : esc(l);
  }
  function cursoTxt(l) {
    var m = /^(.*?)\s*-\s*local:\s*(.*?)\s*-\s*(n[aã]o\s+)?conclu[ií]do$/i.exec(l);
    return m ? '<b>' + esc(nome(m[1])) + '</b> <span>' + esc(nome(m[2])) + (m[3] ? ' · não concluído' : '') + '</span>' : esc(l);
  }
  function empregoTxt(l) {
    var m = /^(.*?)\s*\|\s*(.*?)\s+(\d{1,2}\/\d{1,2}\/\d{4}.*)$/.exec(l);
    return m ? '<b>' + esc(nome(m[2])) + '</b> <span>' + esc(nome(m[1])) + ' · ' + esc(m[3].replace(/\s*à\s*/, ' a ')) + '</span>' : esc(l);
  }
  function bloco(tit, linhas, fmt, max) {
    if (!linhas.length) return '';
    max = max || 3;
    return '<div class="nc-bt-bloco"><h4>' + esc(tit) + '</h4><ul>' + linhas.slice(0, max).map(function (l) { return '<li>' + fmt(l) + '</li>'; }).join('') +
      (linhas.length > max ? '<li class="nc-bt-fraco">+ ' + (linhas.length - max) + ' no currículo</li>' : '') + '</ul></div>';
  }
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  function mesAno(d) { return MESES[d.getMonth()] + '/' + d.getFullYear(); }
  function duracao(i, f) {
    var m = (f.getFullYear() - i.getFullYear()) * 12 + f.getMonth() - i.getMonth(); if (m < 1) return '';
    var a = Math.floor(m / 12), r = m % 12;
    return (a ? a + (a === 1 ? ' ano' : ' anos') : '') + (a && r ? ' e ' : '') + (r ? r + (r === 1 ? ' mês' : ' meses') : '');
  }
  /* o emprego mais recente (pela data de entrada) — "Empresa | cargo dd/mm/aaaa à dd/mm/aaaa" */
  function ultimaExperiencia(c) {
    var melhor = null;
    (c.empregosL || []).forEach(function (l) {
      var m = /^(.*?)\s*\|\s*(.*?)\s+(\d{1,2}\/\d{1,2}\/\d{4})\s*(?:à|a|até|-)?\s*(\d{1,2}\/\d{1,2}\/\d{4})?/i.exec(l);
      if (!m) return;
      var ini = data(m[3]); if (!ini) return;
      if (!melhor || ini > melhor.ini) melhor = { empresa: m[1], cargo: m[2], ini: ini, fim: m[4] ? data(m[4]) : null };
    });
    if (!melhor) return '';
    var fim = melhor.fim || new Date(), d = duracao(melhor.ini, fim);
    return '<p class="nc-bt-ultima"><span class="nc-bt-ultima-rot">Última experiência</span> ' +
      '<b>' + esc(nome(melhor.cargo) || 'Cargo não informado') + '</b>' + (melhor.empresa ? ' · ' + esc(nome(melhor.empresa)) : '') +
      ' · <span class="nc-bt-fraco">' + (melhor.fim ? mesAno(melhor.ini) + ' a ' + mesAno(melhor.fim) : 'desde ' + mesAno(melhor.ini) + ', atual') +
      (d ? ' (' + d + ')' : '') + '</span></p>';
  }
  function anosTxt(a) { if (a < 1) { var m = Math.round(a * 12); return m ? m + (m === 1 ? ' mês' : ' meses') : ''; } var n = Math.floor(a); return n + (n === 1 ? ' ano' : ' anos') + ' de experiência'; }
  /* O ARQUIVO DO CURRÍCULO: a consulta da página montava o link com &APP_ID. (o 9110), mas o processo
     GET_UPLOAD_FILES e os itens GET_TIPO_ITEM… só existem no app de processos seletivos (RS_PRC_<base>,
     o 9113) — no 9110 dava ERR-1002 (conferido 03/10). A exportação já foi corrigida; isto garante
     enquanto ela não é importada: troca o app do link pelo RS_PRC_ que a própria página já usa. */
  function appArquivos() {
    var a = document.querySelector('a[href*="f?p=RS_PRC_"]'), m = a && /f\?p=(RS_PRC_[A-Z0-9_]+):/i.exec(a.getAttribute('href'));
    if (m) return m[1];
    var d = /f\?p=(RS_PRC_[A-Z0-9_]+):/i.exec(document.body.innerHTML.slice(0, 400000));
    return d ? d[1] : '9113';
  }
  function corrigirArquivo(href) {
    if (!href || href.indexOf('APPLICATION_PROCESS=GET_UPLOAD_FILES') < 0) return href;
    var atual = $v('pFlowId'), alias = $v('pFlowAlias') || '';
    return href.replace(/^f\?p=([^:]+):/, function (m0, app) {
      return (app === atual || (alias && app.toUpperCase() === alias.toUpperCase())) ? 'f?p=' + appArquivos() + ':' : m0;
    });
  }
  function corrigirLinksArquivo(raiz) {
    [].forEach.call((raiz || document).querySelectorAll('a[href*="APPLICATION_PROCESS=GET_UPLOAD_FILES"]'), function (a) {
      var h = a.getAttribute('href'), n = corrigirArquivo(h);
      if (n !== h) a.setAttribute('href', n);
    });
  }
  function atalho(a, n, rot) { return a ? '<a class="nc-bt-atalho" href="' + esc(a.getAttribute('href')) + '"' + (a.target ? ' target="' + esc(a.target) + '" rel="noopener"' : '') + ' title="' + esc(rot) + '" aria-label="' + esc(rot) + '">' + ic(n) + '</a>' : ''; }
  function cartao(c, i) {
    var av = c.av, tom = !av ? '' : av.pct >= 80 ? 'alto' : av.pct >= 50 ? 'medio' : 'baixo';
    var quem = nome(c.nome || ('Código ' + c.cod));
    var meta = [c.idade && c.idade + ' anos', c.cidade && ('<span class="nc-bt-lugar">' + ic('local') + esc(nome(c.cidade)) + (c.uf ? '/' + esc(c.uf) : '') + '</span>'), c.mat && 'Matrícula ' + esc(c.mat)].filter(Boolean);
    var selos = [];
    if (c.status) selos.push('<span class="nc-bt-selo" data-tom="' + (/aprov|contrat/i.test(c.status) ? 'bom' : /reprov|desist/i.test(c.status) ? 'ruim' : 'neutro') + '">' + esc(frase(c.status)) + '</span>');
    if (/^sim$/i.test(c.emPS)) selos.push('<span class="nc-bt-selo" data-tom="info">Em processo seletivo</span>');
    if (c.pcd && !/^n/i.test(c.pcd)) selos.push('<span class="nc-bt-selo" data-tom="info">PCD</span>');
    if (c.situacao) selos.push('<span class="nc-bt-selo" data-tom="neutro">' + esc(frase(c.situacao)) + '</span>');
    if (/^sim$/i.test(c.disponivel)) selos.push('<span class="nc-bt-selo" data-tom="bom">Disponível</span>');
    var resumo = [c.instrucao && frase(c.instrucao.replace(/\.$/, '')), c.anos >= 1 || c.anos > 0.08 ? anosTxt(c.anos) : '', c.cargo && 'Cargo: ' + nome(c.cargo), c.cargoPret && 'Pretende: ' + nome(c.cargoPret)].filter(Boolean);
    var aberto = !!ABERTOS[c.cod || c.mat || i];
    var reqHtml = av ? '<div class="nc-bt-reqs">' + av.itens.map(function (x) { return '<span class="nc-bt-req-ok" data-ok="' + x.ok + '" data-exige="' + x.r.exige + '" title="' + (x.r.exige ? 'Exigido' : 'Desejável') + (x.onde ? ' · encontrado em: ' + esc(x.onde.length > 120 ? x.onde.slice(0, 118) + '…' : x.onde) : '') + '">' + ic(x.ok ? 'check' : 'nao') + esc(x.r.nome) + (x.r.nivel ? ' · ' + esc(frase(x.r.nivel)) : '') + '</span>'; }).join('') + '</div>' : '';
    return '<li class="nc-bt-cand' + (aberto ? ' is-aberto' : '') + '" data-i="' + i + '">' +
      '<label class="nc-bt-caixa"' + (c.chk ? '' : ' title="Sem seleção"') + '><input type="checkbox" data-sel="' + i + '"' + (c.chk ? (c.chk.checked ? ' checked' : '') : ' disabled') + ' aria-label="Selecionar ' + esc(quem) + '"></label>' +
      '<span class="nc-bt-avatar" aria-hidden="true">' + esc(iniciais(quem)) + '</span>' +
      '<div class="nc-bt-quem-cand">' +
        '<p class="nc-bt-nome">' + (c.aLink ? '<a href="' + esc(c.aLink.getAttribute('href')) + '">' + esc(quem) + '</a>' : esc(quem)) + (c.social && sem(c.social) !== sem(c.nome) ? ' <span class="nc-bt-social">(' + esc(nome(c.social)) + ')</span>' : '') + (c.cod ? ' <span class="nc-bt-cod">' + esc(c.cod) + '</span>' : '') + '</p>' +
        (meta.length ? '<p class="nc-bt-meta">' + meta.join(' <span aria-hidden="true">·</span> ') + '</p>' : '') +
        (selos.length ? '<p class="nc-bt-selos">' + selos.join('') + '</p>' : '') +
        (resumo.length ? '<p class="nc-bt-resumo">' + resumo.map(esc).join(' · ') + '</p>' : '') +
        (c.mat ? '' : ultimaExperiencia(c) || '<p class="nc-bt-ultima nc-bt-fraco">Sem experiência registrada</p>') +
      '</div>' +
      (av ? '<div class="nc-bt-ader" data-tom="' + tom + '" title="Aderência estimada à vaga"><b>' + av.pct + '%</b><span>' + (av.exT ? av.exOk + ' de ' + av.exT + ' exigidos' : 'aderência') + '</span></div>' : '<div class="nc-bt-ader nc-bt-ader--vazio"></div>') +
      '<div class="nc-bt-acoes">' + atalho(c.aCv, 'cv', 'Arquivo do currículo') + atalho(c.aEnviar, 'email', 'Enviar e-mail') + atalho(c.aWhats, 'whats', 'WhatsApp') + atalho(c.aLinkedin, 'linkedin', 'LinkedIn') +
        '<button type="button" class="nc-bt-atalho nc-bt-mais" data-mais="' + i + '" aria-expanded="' + aberto + '" title="Ver formação, cursos, idiomas e experiência" aria-label="Ver mais">' + ic('mais') + '</button></div>' +
      reqHtml +
      '<div class="nc-bt-detalhe"' + (aberto ? '' : ' hidden') + '>' +
        bloco('Formação', c.formacaoL, formacaoTxt) + bloco('Idiomas', c.idiomasL, esc) + bloco('Cursos', c.cursosL, cursoTxt) +
        bloco('Habilidades', c.habilidadeL, esc, 6) + bloco('Experiência', c.empregosL, empregoTxt) +
        (c.qualif ? '<div class="nc-bt-bloco nc-bt-bloco--largo"><h4>Sobre</h4><p>' + esc(c.qualif) + '</p></div>' : '') +
        '<div class="nc-bt-bloco nc-bt-bloco--largo nc-bt-contatos">' +
          [c.mail && '<span>' + ic('email') + esc(c.mail) + '</span>', c.mailFunc && '<span>' + ic('email') + esc(c.mailFunc) + '</span>', c.cel && !vazio(c.cel.replace(/[()\s]/g, '')) && '<span>' + esc(c.cel) + '</span>',
            c.cad && '<span class="nc-bt-fraco">Cadastro ' + esc(c.cad) + (c.atual && c.atual !== c.cad ? ' · atualizado ' + esc(c.atual) : '') + '</span>'].filter(Boolean).join('') +
          (c.aLink ? '<a class="nc-bt-bt" href="' + esc(c.aLink.getAttribute('href')) + '">Abrir o cadastro completo</a>' : '') + '</div>' +
      '</div>' +
    '</li>';
  }
  function desenhar() {
    if (!APP || !IR) return;
    corrigirLinksArquivo(IR.el);   /* vale também para a Tabela */
    CANDS = lerCandidatos(IR.el);
    var vis = CANDS.map(function (c, i) { return [c, i]; });
    if (ORDENS[ORDEM]) vis.sort(function (a, b) { return ORDENS[ORDEM](a[0], b[0]) || a[1] - b[1]; });
    var lista = (APP._resto || APP).querySelector('.nc-bt-lista');
    lista.innerHTML = vis.length ? vis.map(function (x) { return cartao(x[0], x[1]); }).join('')
      : '<li class="nc-bt-vazio"><p><b>Nenhum candidato com estes filtros.</b></p><p>Tire algum filtro (as etiquetas acima) ou aumente o período.</p></li>';
    var conta = APP.querySelector('.nc-bt-conta-res'), pag = IR.el.querySelector('.a-IRR-pagination');
    conta.textContent = CANDS.length ? CANDS.length + (CANDS.length === 1 ? ' candidato' : ' candidatos') + (pag && /\d/.test(pag.textContent) ? ' nesta página (' + pag.textContent.replace(/\s+/g, ' ').trim() + ')' : '') : '';
    var sel = APP.querySelector('[data-ordem]'); if (sel) { sel.querySelector('option[value="aderencia"]').disabled = !REQS.length; sel.value = ORDENS[ORDEM] && (ORDEM !== 'aderencia' || REQS.length) ? ORDEM : ''; }
    barra();
  }

  /* ═══ [B9] SELEÇÃO E "INCLUIR EM PROCESSO" ═══════════════════════════════════════════════
     A caixa do cartão APERTA a original (.checkbox_item, f01): a página grava a seleção numa
     coleção (salvar_ids) e mostra o "Incluir em Processo". Ao abrir a janela de inclusão, o
     processo já vem com a vaga comparada (se houver e o campo estiver vazio).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function barra() {
    var b = APP && (APP._resto || APP).querySelector('.nc-bt-barra'); if (!b) return;
    var n = CANDS.filter(function (c) { return c.chk && c.chk.checked; }).length;
    b.hidden = !n; b.querySelector('.nc-bt-barra-n').textContent = n === 1 ? '1 candidato selecionado' : n + ' candidatos selecionados';
    if (n) alinharBarra();
  }
  /* a barra é fixa na janela: acompanha a largura da coluna dos resultados */
  function alinharBarra() {
    var reg = APP && (APP.closest('.nc-bt-reg') || APP), b = APP && (APP._resto || APP).querySelector('.nc-bt-barra');
    if (!reg || !b) return;
    var r = reg.getBoundingClientRect(), m = window.innerWidth <= 640 ? 10 : 16;
    b.style.setProperty('--nc-bt-bx', Math.max(m, r.left + m) + 'px');
    b.style.setProperty('--nc-bt-bw', Math.max(200, Math.min(r.width, window.innerWidth - r.left) - 2 * m) + 'px');
  }
  window.addEventListener('resize', function () { if (APP) alinharBarra(); });
  function marcar(c, v) { if (c.chk && c.chk.checked !== v) c.chk.click(); }
  function janelaIncluir() {
    $(document).on('dialogopen', function (e) {
      if (!e.target.querySelector || !e.target.querySelector('#P182_PROCESSO_SELETIVO')) return;
      if (VAGA && !$v('P182_PROCESSO_SELETIVO')) apex.item('P182_PROCESSO_SELETIVO').setValue(String(VAGA.processo), nome(VAGA.cargo) + ' (' + VAGA.processo + ')');
    });
  }

  /* ═══ [B10] O MAESTRO ════════════════════════════════════════════════════════════════════ */
  function iniciar() {
    if (!$id('P182_TIPO')) return;
    window.__ncBancoTalentos = true;
    document.body.classList.add('nc-bt-ativo');
    var regFiltros = $id('P182_TIPO').closest('.t-Region');
    if (regFiltros) montarPainel(regFiltros);
    IR = irVisivel();
    var regRes = IR && IR.el.closest('.t-Region:not(.a-IRR-container)') || (IR && IR.el);
    var visao = lembrar('nc-bt-visao') === 'tabela' ? 'tabela' : 'lista';
    ORDEM = lembrar('nc-bt-ordem') || ''; ORDEM_ESCOLHIDA = !!ORDEM;
    if (IR) {
      APP = el('section', 'nc-bt');
      APP.setAttribute('aria-label', 'Candidatos');
      APP.innerHTML =
        '<header class="nc-bt-cab"><div><h2>' + esc(IR.titulo) + '</h2><p class="nc-bt-conta-res"></p></div>' +
          '<label class="nc-bt-ordem"><span>Ordenar</span><select data-ordem><option value="">Como no relatório</option><option value="aderencia">Mais aderentes à vaga</option><option value="recente">Atualizados por último</option><option value="nome">Nome (A a Z)</option></select></label>' +
          '<div class="nc-bt-visao" role="group" aria-label="Ver como"><button type="button" data-visao="lista" aria-pressed="' + (visao === 'lista') + '">' + ic('lista') + 'Cartões</button><button type="button" data-visao="tabela" aria-pressed="' + (visao === 'tabela') + '">' + ic('tabela') + 'Tabela</button></div>' +
          '<div class="nc-bt-cab-acoes"></div></header>' +
        '<div class="nc-bt-perfil" hidden></div>' +
        '<div class="nc-bt-ativos" hidden></div>' +
        '<ol class="nc-bt-lista"></ol>' +
        '<div class="nc-bt-barra" hidden role="region" aria-label="Selecionados"><span class="nc-bt-barra-n"></span><span class="nc-bt-barra-acoes"></span><button type="button" class="nc-bt-link" data-limpar-sel>Limpar seleção</button></div>';
      var alvo = IR.el.querySelector('.a-IRR-toolbar');
      var corpo = regRes.querySelector('.t-Region-body') || regRes;
      corpo.insertBefore(APP, corpo.firstChild);
      regRes.classList.add('nc-bt-reg');
      /* a lista vai logo DEPOIS da barra do relatório (busca, Ações continuam valendo) */
      if (alvo) {
        var resto = el('div', 'nc-bt nc-bt-resto');
        ['.nc-bt-lista', '.nc-bt-barra'].forEach(function (q) { resto.appendChild(APP.querySelector(q)); });
        alvo.parentNode.insertBefore(resto, alvo.nextSibling);
        APP._resto = resto;
      }
      PERFIL = APP.querySelector('.nc-bt-perfil'); ATIVOS = APP.querySelector('.nc-bt-ativos');
      var cad = botaoPorTexto(/^cadastrar$/i); if (cad) { cad.classList.add('nc-bt-bt'); APP.querySelector('.nc-bt-cab-acoes').appendChild(cad); }
      /* "Incluir em Processo" (o do relatório à vista; o da janela de inclusão não) vai para a barra */
      [].forEach.call(document.querySelectorAll('button.t-Button'), function (b) {
        if (/incluir em processo/i.test(b.textContent) && !b.closest('.ui-dialog, .js-regionDialog')) { b.classList.add('nc-bt-bt', 'nc-bt-bt--primario'); (APP._resto || APP).querySelector('.nc-bt-barra-acoes').appendChild(b); }
      });
      document.body.classList.toggle('nc-bt-tabela', visao === 'tabela');
      var raiz = document.querySelector('.t-Body-contentInner') || document.body;
      raiz.addEventListener('click', function (ev) {
        var b;
        if ((b = ev.target.closest('[data-visao]')) && APP.contains(b)) { visao = b.getAttribute('data-visao'); lembrar('nc-bt-visao', visao); document.body.classList.toggle('nc-bt-tabela', visao === 'tabela'); [].forEach.call(APP.querySelectorAll('[data-visao]'), function (x) { x.setAttribute('aria-pressed', String(x === b)); }); return; }
        if ((b = ev.target.closest('[data-mais]'))) { var li = b.closest('.nc-bt-cand'), c = CANDS[+b.getAttribute('data-mais')], d = li.querySelector('.nc-bt-detalhe'); d.hidden = !d.hidden; li.classList.toggle('is-aberto', !d.hidden); b.setAttribute('aria-expanded', String(!d.hidden)); ABERTOS[c.cod || c.mat || b.getAttribute('data-mais')] = !d.hidden; return; }
        if ((b = ev.target.closest('[data-tira]'))) { apex.item(b.getAttribute('data-tira')).setValue(''); MUDOU = true; contarGrupos(); return; }
        if (ev.target.closest('[data-pesquisar]')) { var p = document.querySelector('.nc-bt-pesquisar'); if (p) p.click(); return; }
        if (ev.target.closest('[data-limpar-sel]')) { CANDS.forEach(function (c) { marcar(c, false); }); setTimeout(barra, 0); return; }
      });
      raiz.addEventListener('change', function (ev) {
        var t = ev.target;
        if (t.hasAttribute('data-ordem')) { ORDEM = t.value; ORDEM_ESCOLHIDA = true; lembrar('nc-bt-ordem', ORDEM); desenhar(); return; }
        if (t.hasAttribute('data-sel')) { var c = CANDS[+t.getAttribute('data-sel')]; if (c) marcar(c, t.checked); setTimeout(barra, 0); }
      });
      $(IR.el).on('apexafterrefresh', function () { setTimeout(desenhar, 0); });
    }
    /* o painel: tipo, grupos, limpar, vaga */
    if (PAINEL) {
      PAINEL.addEventListener('click', function (ev) {
        var b;
        if ((b = ev.target.closest('.nc-bt-vaga-cx > summary'))) { var dv = b.parentNode; setTimeout(function () { lembrar('nc-bt-vaga-aberta', dv.open ? 'S' : 'N'); if (dv.open) { var tx = dv.querySelector('.nc-bt-vaga-txt'); if (tx && !tx.value) tx.focus(); } }, 0); return; }
        if ((b = ev.target.closest('[data-tipo]'))) {
          var s = $id('P182_TIPO'); if (s.value === b.getAttribute('data-tipo')) return;
          s.value = b.getAttribute('data-tipo'); $(s).trigger('change'); marcarTipo();
          var p = document.querySelector('.nc-bt-pesquisar'); if (p) setTimeout(function () { p.click(); }, 50);   /* troca de lista = nova busca */
          return;
        }
        if ((b = ev.target.closest('[data-limpar-grupo]'))) { var d = b.closest('.nc-bt-grupo'); if (d.__limpar) d.__limpar.click(); else d.__itens.forEach(function (c) { apex.item(c.id.replace(/_CONTAINER$/, '')).setValue(''); }); MUDOU = true; setTimeout(contarGrupos, 50); return; }
        if (ev.target.closest('[data-limpar-tudo]')) { GRUPOS_EL.forEach(function (d) { if (d.__limpar) d.__limpar.click(); }); MUDOU = true; setTimeout(contarGrupos, 80); return; }
        if (ev.target.closest('[data-vaga-usar]')) { carregarVaga(); return; }
        if (ev.target.closest('[data-vaga-tirar]')) { PAINEL.querySelector('.nc-bt-vaga-txt').value = ''; if (ORDEM === 'aderencia') ORDEM = ''; carregarVaga(''); return; }
      });
      PAINEL.addEventListener('change', function (ev) { if (ev.target.closest('.nc-bt-grupo, .nc-bt-quem-campos')) { MUDOU = true; contarGrupos(); } });
      $(PAINEL).on('change', function (ev) { if ($(ev.target).closest('.nc-bt-grupo').length) { MUDOU = true; contarGrupos(); } });
      var vt = PAINEL.querySelector('.nc-bt-vaga-txt');
      vt.addEventListener('keydown', function (e) { if (e.key === 'Enter') { e.preventDefault(); carregarVaga(); } });
      /* escolher uma sugestão já compara (o "change" da lista nativa) */
      vt.addEventListener('change', function () { if (/^\d+\s*—/.test(vt.value)) carregarVaga(); });
    }
    janelaIncluir();
    desenharAtivos();
    var guardada = lembrar('nc-bt-vaga') || ($v('P182_TIPO') === 'S' && ($v('P182_PS') || '').trim()) || '';
    if (PAINEL) listarVagas();
    resumoVaga();
    if (guardada && PAINEL) { PAINEL.querySelector('.nc-bt-vaga-txt').value = guardada; carregarVaga(guardada); } else desenhar();
  }
  var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp banco de talentos]', e); } }, 0); };
  if (document.readyState === 'complete') vai();
  else { if (window.apex.gPageContext$) $(apex.gPageContext$).one('apexreadyend', vai); window.addEventListener('load', vai); }
})();
