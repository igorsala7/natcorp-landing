/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · DADOS DO CANDIDATO  —  o "arrumador" da tela (JavaScript)                     ║
   ║  App 2937 (Medicina Ocupacional) · Página 29 ("Dados Candidatos Reduzido", a janela)     ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia desta página: DADOS-CANDIDATO-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   A janela "Dados do candidato" da Agenda: a prévia de QUEM o médico vai atender. Antes: 28
   campos de formulário em grade, metade vazios, com sobras das junções do banco (" - ",
   " -  -  - "), e botões Sim/Não que pareciam editáveis.
   Agora, uma FICHA de leitura:
     • no alto, código - nome, idade, sexo e a situação do candidato (Ativo / Pendente /
       Reprovado); logo abaixo, o que pede atenção (PCD, restrição para admissão) — ou a
       confirmação de que não há;
     • Vaga pretendida (cargo, função, local, processo seletivo, empresa e filial) — o risco do
       exame vem daqui;
     • Contato (telefones formatados, que ligam no celular, e o nome para recado);
     • Identificação, Documentos (CPF, PIS, CTPS formatados), Indicação e vínculos, Uniforme;
     • só aparece o que está preenchido; o que falta vira uma linha "Sem informação: …".

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Nada é gravado (a página nunca gravou: os botões são "Never"). Os dados são os mesmos que
     o processo CARREGA_DADOS põe nos itens P29_* — este arquivo só os LÊ e os arruma. O
     formulário original continua na página, fora da vista.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 29 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_DadosCandidato.js
     Página 29 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_DadosCandidato.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [D1]  Textos e seções                                                   PODE MEXER
     [D2]  Ferramentas
     [D3]  Limpar os valores (as sobras das junções do banco)                CUIDADO
     [D4]  Montar a ficha
     [D5]  O maestro
*/
(function () {
  'use strict';
  if (window.__ncDadosCandidato || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [D1] TEXTOS E SEÇÕES ═══════════════════════════════════════════════════════════════
     SECOES   a ordem das seções e, em cada uma, [rótulo, item, formato]. O formato diz como
              limpar o valor ([D3]). Tirar uma linha tira o campo da ficha (o item continua).
     STATUS   a cor do selo de situação (a chave é o texto que o banco devolve).
     PODE MEXER
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var SECOES = [
    { id: 'vaga', titulo: 'Vaga pretendida', ic: 'maleta', campos: [
      ['Cargo', 'P29_CARGO_PRETENDIDO', 'coddesc'], ['Função', 'P29_FUNCAO_PRETENDIDA', 'coddesc'], ['Local', 'P29_LOCAL_PRETENDIDO', 'coddesc'],
      ['Processo seletivo', 'P29_PS', 'texto'], ['Empresa', 'P29_EMPRESA', 'empresa'], ['Filial', 'P29_COD_FILIAL', 'empresa']] },
    { id: 'contato', titulo: 'Contato', ic: 'telefone', campos: [
      ['Telefone', 'P29_TELEFONE', 'telefone'], ['Telefone para recados', 'P29_TELEFONE_RECADOS', 'telefone'], ['Falar com', 'P29_NOME_CONTATO', 'pessoa']] },
    { id: 'ident', titulo: 'Identificação', ic: 'pessoa', campos: [
      ['Nascimento', 'P29_DT_NAC', 'nascimento'], ['UF de nascimento', 'P29_UF_NACTO', 'texto'], ['Nome da mãe', 'P29_NOME_MAE', 'pessoa'],
      ['Cadastrado em', 'P29_DATA_CADASTRO', 'desde']] },
    { id: 'docs', titulo: 'Documentos', ic: 'documento', campos: [
      ['CPF', 'P29_NUM_CPF', 'cpf'], ['RG', 'P29_NUM_IDENTIDADE', 'texto'], ['PIS', 'P29_NUM_PIS_PASEP', 'texto'],
      ['CTPS', 'P29_NUM_CART_PROF', 'ctps'], ['CTPS emitida em', 'P29_DT_EMIS_CART', 'texto'], ['UF da CTPS', 'P29_EST_EMIS_PROF', 'texto']] },
    { id: 'ref', titulo: 'Indicação e vínculos', ic: 'elo', campos: [
      ['Indicado por', 'P29_IND_POR', 'referencia'], ['Parente na empresa', 'P29_PARENTE', 'referencia'], ['Já foi funcionário', 'P29_EX_FUNCIONARIO', 'referencia']] },
    { id: 'uniforme', titulo: 'Uniforme', ic: 'camisa', curta: true, campos: [
      ['Camisa', 'P29_NUM_CAMISA', 'texto'], ['Calça', 'P29_NUM_CALCA', 'texto'], ['Calçado', 'P29_NUM_CALCADO', 'texto']] }
  ];
  var STATUS = { ativo: 'bom', pendente: 'atencao', reprovado: 'ruim' };

  /* ═══ [D2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function nome(t) {
    return String(t || '').toLowerCase().replace(/(^|[\s'(/-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); })
      .replace(/\s(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  function frase(t) { t = String(t || '').trim(); if (/[a-zà-ú]/.test(t)) return t; t = t.toLowerCase(); return t.charAt(0).toUpperCase() + t.slice(1); }
  /* o valor do item: o texto que a página mostra (lista → o nome; só leitura → o texto) */
  function bruto(id) {
    var d = $id(id + '_DISPLAY'); if (d) return String(d.value || d.textContent || '').trim();
    var e = $id(id); if (!e) return '';
    if (e.tagName === 'SELECT') return e.selectedIndex >= 0 && e.value ? e.options[e.selectedIndex].text.trim() : '';
    var c = $id(id + '_CONTAINER');
    if (e.type === 'hidden' && c) { var s = c.querySelector('.display_only, .apex-item-display-only'); if (s && s.textContent.trim()) return s.textContent.trim(); }
    return String(e.value || '').trim();
  }
  function marcado(id) { var v = apex.item(id) ? apex.item(id).getValue() : ''; v = [].concat(v || []); return v.indexOf('S') >= 0; }
  function data(t) { var m = /^(\d{1,2})\/(\d{1,2})\/(\d{4})/.exec(String(t || '')); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function anos(d) { if (!d) return null; var h = new Date(), a = h.getFullYear() - d.getFullYear(); if (h.getMonth() < d.getMonth() || (h.getMonth() === d.getMonth() && h.getDate() < d.getDate())) a--; return a; }
  var IC = {
    maleta: '<rect x="3.5" y="7.5" width="17" height="12" rx="2"/><path d="M9 7.5V5.5h6v2M3.5 12.5h17"/>',
    telefone: '<path d="M6.5 4h3l1.5 4-2 1.5a10 10 0 0 0 5.5 5.5l1.5-2 4 1.5v3a2 2 0 0 1-2 2A15 15 0 0 1 4.5 6a2 2 0 0 1 2-2z"/>',
    pessoa: '<circle cx="12" cy="8.5" r="3.5"/><path d="M5 20a7 7 0 0 1 14 0"/>',
    documento: '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4M9.5 12.5h6M9.5 16h6"/>',
    elo: '<path d="M10 14a4 4 0 0 0 5.7 0l3-3a4 4 0 0 0-5.7-5.7l-1 1"/><path d="M14 10a4 4 0 0 0-5.7 0l-3 3a4 4 0 0 0 5.7 5.7l1-1"/>',
    camisa: '<path d="M8.5 4L4 7l2 3.5L8 9.5V20h8V9.5l2 1L20 7l-4.5-3c-.5 1.5-2 2.5-3.5 2.5S9 5.5 8.5 4z"/>',
    alerta: '<path d="M12 4l9 16H3z"/><path d="M12 10v4M12 17h.01"/>',
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>',
    acessivel: '<circle cx="12" cy="4.5" r="1.8"/><path d="M6 8.5h12M12 8.5v5l-3 6M12 13.5l3 6"/>'
  };
  function ic(n) { return '<svg class="nc-dc-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }

  /* ═══ [D3] LIMPAR OS VALORES ══════════════════════════════════════════════════════════════
     CUIDADO  O CARREGA_DADOS junta colunas com ' - ' mesmo quando estão vazias: telefone sem
              DDD vem " - 36420361", CPF vazio vem " - ", referência vazia " -  -  - ". Cada
              formato abaixo devolve { t: texto, href: link opcional } ou null (= vazio).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function vazio(t) { return !t || /^[\s\-–.]*$/.test(t); }
  function partes(t) { return String(t || '').split(/\s+-\s+|^\s*-\s+|\s+-\s*$/).map(function (p) { return p.trim(); }).filter(function (p) { return p && p !== '-'; }); }
  function codDesc(t, pessoa) {
    t = String(t || '').trim(); var m = /^(\S+)\s+-\s+(.+)$/.exec(t), f = pessoa ? nome : frase;
    if (!m) return /[a-zà-ú]/.test(t) ? t : f(t);
    return m[1] + ' - ' + (/[a-zà-ú]/.test(m[2]) ? m[2] : f(m[2]));
  }
  var FORMATOS = {
    texto: function (t) { return vazio(t) ? null : { t: t.replace(/^\s*-\s+|\s+-\s*$/g, '').trim() }; },
    pessoa: function (t) { return vazio(t) ? null : { t: /[a-zà-ú]/.test(t) ? t : nome(t) }; },
    coddesc: function (t) { return vazio(t) ? null : { t: codDesc(t) }; },
    empresa: function (t) { return vazio(t) ? null : { t: codDesc(t, true) }; },
    telefone: function (t) {
      var p = partes(t); if (!p.length) return null;
      var ddd = p.length > 1 ? p[0].replace(/\D/g, '') : '', n = p[p.length - 1].replace(/\D/g, '');
      if (!n) return null;
      var fmt = n.length === 9 ? n.slice(0, 5) + '-' + n.slice(5) : n.length === 8 ? n.slice(0, 4) + '-' + n.slice(4) : n;
      return { t: (ddd ? '(' + ddd + ') ' : '') + fmt, href: 'tel:' + ddd + n, nota: ddd ? '' : 'sem DDD' };
    },
    cpf: function (t) {
      var p = partes(t).map(function (x) { return x.replace(/\D/g, ''); }).filter(Boolean); if (!p.length) return null;
      /* número e dígito vêm em colunas numéricas: perdem os zeros da esquerda, cada um */
      var d = p.length === 2 && p[0].length <= 9 && p[1].length <= 2 ? ('000000000' + p[0]).slice(-9) + ('00' + p[1]).slice(-2) : p.join('');
      return { t: d.length === 11 ? d.slice(0, 3) + '.' + d.slice(3, 6) + '.' + d.slice(6, 9) + '-' + d.slice(9) : d };
    },
    ctps: function (t) { var p = partes(t); if (!p.length) return null; return { t: p[0] + (p[1] ? ' · série ' + p[1] : '') }; },
    nascimento: function (t) { var d = data(t); if (!d) return vazio(t) ? null : { t: t }; return { t: t.slice(0, 10) + ' (' + anos(d) + ' anos)' }; },
    desde: function (t) {
      var d = data(t); if (!d) return vazio(t) ? null : { t: t };
      var a = anos(d);
      return { t: t.slice(0, 10) + (a >= 1 ? ' (há ' + a + (a === 1 ? ' ano' : ' anos') + ')' : '') };
    },
    /* "700 - 12345 - 1 - 1 - FULANO" (empresa, matrícula, dígito, dígito - nome) → "12345 - Fulano · empresa 700" */
    referencia: function (t) {
      var p = partes(t); if (!p.length) return null;
      var nm = p.filter(function (x) { return /[A-Za-zÀ-ú]/.test(x); }).pop() || '';
      var emp = p[0], matr = p[1] || '';
      if (!matr && !nm) return { t: p.join(' - ') };
      return { t: (matr ? matr + (nm ? ' - ' : '') : '') + (nm ? nome(nm) : ''), nota: emp && matr ? 'empresa ' + emp : '' };
    }
  };
  function ler(campo) { var f = FORMATOS[campo[2]] || FORMATOS.texto; try { return f(bruto(campo[1])); } catch (x) { return null; } }

  /* ═══ [D4] MONTAR A FICHA ═════════════════════════════════════════════════════════════════ */
  function iniciar() {
    var cNome = $id('P29_NOME_CONTAINER'); if (!cNome) return;
    window.__ncDadosCandidato = true;
    var regForm = cNome.closest('[id^="R"]');
    if (!regForm) return;
    document.body.classList.add('nc-dc-ativo');
    var app = el('section', 'nc-dc'); app.setAttribute('aria-label', 'Dados do candidato');
    regForm.parentNode.insertBefore(app, regForm);
    regForm.classList.add('nc-dc-guardada');
    /* a coluna da grade herdou a classe de ícone da região (fa-address-book-o): o ícone solto sai */
    for (var x = app.parentNode; x && x !== document.body; x = x.parentNode) if (/(^|\s)fa-/.test(x.className || '')) x.classList.add('nc-dc-sem-icone');
    /* o título repetido da página (região de navegação "Candidatos (Reduzido)") sai da vista */
    [].forEach.call(document.querySelectorAll('.t-BreadcrumbRegion, .t-HeroRegion'), function (r) { var x = r.closest('[id^="R"]') || r; if (!x.contains(app)) x.classList.add('nc-dc-guardada'); });

    /* — sem cadastro (o CARREGA_DADOS não achou o candidato): aviso, não um formulário vazio — */
    if (vazio(bruto('P29_NOME'))) {
      var c0 = bruto('P29_COD_CANDIDATO');
      app.innerHTML = '<div class="nc-dc-sem" role="alert">' + ic('alerta') + '<div><p><b>Não encontramos o cadastro do candidato' + (c0 ? ' ' + esc(c0) : '') + '.</b></p>' +
        '<p>O candidato está na agenda, mas os dados pessoais dele não foram encontrados. Confira o cadastro no Recrutamento.</p></div></div>';
      return;
    }

    /* — quem — */
    var quem = bruto('P29_NOME'), m = /^\s*(\S+)\s+-\s+(.+)$/.exec(quem), cod = m ? m[1] : bruto('P29_COD_CANDIDATO'), nm = m ? m[2] : quem;
    if (nm && !/[a-zà-ú]/.test(nm)) nm = nome(nm);
    var ini = String(nm || '?').split(/\s+/).filter(function (p) { return p.length > 2; });
    ini = ((ini[0] || '?').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '')).toUpperCase();
    var nasc = data(bruto('P29_DT_NAC')), idade = anos(nasc);
    var sexo = bruto('P29_SEXO'); sexo = /^m/i.test(sexo) ? 'Masculino' : /^f/i.test(sexo) ? 'Feminino' : (vazio(sexo) ? '' : frase(sexo));
    var st = bruto('P29_STATUS_CANDIDATO'), tom = STATUS[st.toLowerCase()] || 'neutro';
    var cargo = ler(['', 'P29_CARGO_PRETENDIDO', 'coddesc']);
    var meta = ['Candidato', idade != null ? idade + ' anos' : '', sexo].filter(Boolean);

    /* — o que pede atenção: PCD e restrição (Eximido é informação, não alerta) — */
    var atencao = [];
    if (marcado('P29_IND_DEF_FIS')) atencao.push(['acessivel', 'PCD — pessoa com deficiência']);
    if (marcado('P29_RESTRICAO_ADMISSAO')) atencao.push(['alerta', 'Restrição para admissão']);
    var confirma = [!marcado('P29_RESTRICAO_ADMISSAO') ? 'sem restrição para admissão' : '', !marcado('P29_IND_DEF_FIS') ? 'não é PCD' : '', marcado('P29_IND_EXIMIDO') ? 'eximido' : ''].filter(Boolean);

    var html =
      '<header class="nc-dc-cab">' +
        '<span class="nc-dc-avatar" aria-hidden="true">' + esc(ini) + '</span>' +
        '<div class="nc-dc-quem"><h1>' + (cod ? '<span class="nc-dc-cod">' + esc(cod) + ' - </span>' : '') + esc(nm || 'Candidato') + '</h1>' +
          '<p>' + esc(meta.join(' · ')) + (cargo ? ' · para <b>' + esc(cargo.t) + '</b>' : '') + '</p></div>' +
        (st ? '<span class="nc-dc-status" data-tom="' + tom + '">' + esc(st) + '</span>' : '') +
      '</header>' +
      (atencao.length ? '<div class="nc-dc-atencao" role="note">' + atencao.map(function (a) { return '<span>' + ic(a[0]) + esc(a[1]) + '</span>'; }).join('') + (confirma.length ? '<small>' + esc(frase(confirma.join(' · '))) + '</small>' : '') + '</div>'
        : '<p class="nc-dc-ok">' + ic('check') + esc(frase(confirma.join(' · '))) + '</p>') +
      '<div class="nc-dc-grade">' + SECOES.map(secao).join('') + '</div>';
    app.innerHTML = html;
  }

  function secao(s) {
    var cheios = [], faltam = [];
    s.campos.forEach(function (c) { var v = ler(c); if (v) cheios.push([c[0], v]); else faltam.push(c[0]); });
    var corpo = cheios.length ? '<dl' + (s.curta ? ' class="is-curta"' : '') + '>' + cheios.map(function (x) {
      var v = x[1];
      return '<div><dt>' + esc(x[0]) + '</dt><dd>' + (v.href ? '<a href="' + esc(v.href) + '">' + esc(v.t) + '</a>' : esc(v.t)) + (v.nota ? ' <small>' + esc(v.nota) + '</small>' : '') + '</dd></div>';
    }).join('') + '</dl>' : '<p class="nc-dc-nada">Nada informado.</p>';
    return '<section class="nc-dc-sec" data-sec="' + s.id + '"' + (cheios.length ? '' : ' data-vazia') + '><h2>' + ic(s.ic) + esc(s.titulo) + '</h2>' + corpo +
      (cheios.length && faltam.length ? '<p class="nc-dc-falta">Sem informação: ' + esc(faltam.join(', ')) + '</p>' : '') + '</section>';
  }

  /* ═══ [D5] O MAESTRO ═════════════════════════════════════════════════════════════════════ */
  var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp dados do candidato]', e); } }, 0); };
  if (document.readyState === 'complete') vai();
  else { if (window.apex.gPageContext$) $(apex.gPageContext$).one('apexreadyend', vai); window.addEventListener('load', vai); }
})();
