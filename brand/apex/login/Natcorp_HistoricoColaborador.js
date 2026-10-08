/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · HISTÓRICO DO COLABORADOR  —  o "arrumador" da tela (JavaScript)               ║
   ║  App 2937 (Medicina Ocupacional) · Página 6 · Dados de Funcionário (modal)               ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia desta página: HISTORICOCOLABORADOR-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   É onde o médico CONSULTA o passado do colaborador que está atendendo. As 9 abas (consultas,
   doenças, exames, atestados, vacinas, consulta ocupacional, restrições, atividades,
   acidentes) viram:
     • no alto, fixo, QUEM é (código - nome, idade, cargo, setor, local, filial, empresa);
     • à esquerda, o que pede ATENÇÃO agora: restrições, doença sem data de término, atestado
       em vigor, exame vencido ou vencendo, vacina com dose atrasada, acidente recente — e o
       sangue (tipo e fator RH, editáveis, com Salvar) e o que a função faz;
     • à direita, a LINHA DO TEMPO: tudo junto, do mais novo ao mais antigo, por ano, com
       filtro por tipo (com quantos) e busca. Tocar num item abre os detalhes; "Ver consulta"
       e "Abrir análise" são os links de sempre;
     • LANÇAR E CORRIGIR sem sair do desenho: "Novo atestado" / "Nova doença" no alto e
       "Editar" no detalhe abrem uma GAVETA com a ficha do registro (a "vista de um registro"
       da própria grade, só com os campos que importam, por assunto);
     • "Tabelas": as abas originais, só para consultar.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava por conta própria: a gaveta é a ficha da GRADE, e Salvar é o salvar da grade —
     as listas (CID, médico, motivo), os valores padrão, as validações e o processo que grava
     são os da página. Só oferece lançar/editar/excluir no que a página deixa (região editável
     e os esquemas de autorização de incluir, alterar e excluir). Se um relatório tiver mais
     páginas do que a tela mostra, a linha do tempo diz e manda para a tabela. Tirou as URLs
     deste arquivo: a página volta a ser a de abas.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 6 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_HistoricoColaborador.js
     Página 6 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_HistoricoColaborador.css

   ── O "COMBINADO" COM O APEX ──────────────────────────────────────────────────────────────
     Cada fonte é achada pelo CONTEÚDO (nunca pelo id da região): as grades pelas colunas
     (DT_ATESTADO_MEDICO, COD_EXAME, COD_DOENCA+DT_INICIO), os relatórios pelos cabeçalhos
     (DT_CONSULTA, DT_ACIDENTE, "Data Agd Consulta", "Vacina", "Descrição de Atividades").
     Fonte que não existir só não aparece.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [H1]  Como a página é reconhecida                                      CUIDADO
     [H2]  Os tipos de registro, as cores e os prazos                       PODE MEXER
     [H3]  Ferramentas
     [H4]  Quem é (o alto)
     [H5]  Ler as fontes (grades e relatórios)                              CUIDADO
     [H6]  Atenção (o resumo à esquerda)
     [H7]  A linha do tempo
     [H8]  Tabelas (as abas originais) e o rodapé
     [H9]  Lançar e corrigir (a ficha da grade numa gaveta)                CUIDADO
     [H10] O maestro

   ── LEGENDA ───────────────────────────────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, cores.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
*/
(function () {
  'use strict';
  if (window.__ncHistorico || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [H2] OS TIPOS DE REGISTRO, AS CORES E OS PRAZOS ════════════════════════════════════
     TIPOS   chave → nome no filtro, ícone e o nome da aba original (para "Editar na tabela").
     PERTO   com quantos dias antes um exame / vacina fica "vence em breve".
     RECENTE acidente com menos de quantos dias entra na Atenção.
     PODE MEXER os nomes, a ordem do filtro, os prazos.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var TIPOS = {
    consulta: { rot: 'Consultas', um: 'Consulta', ic: 'estetoscopio', aba: /^consultas$/i },
    exame: { rot: 'Exames', um: 'Exame', ic: 'frasco', aba: /^exames$/i },
    atestado: { rot: 'Atestados', um: 'Atestado', ic: 'documento', aba: /^atestados$/i },
    doenca: { rot: 'Doenças', um: 'Doença', ic: 'cruz', aba: /^doen/i },
    vacina: { rot: 'Vacinas', um: 'Vacina', ic: 'seringa', aba: /^vacinas$/i },
    cmo: { rot: 'Consulta ocupacional', um: 'Consulta ocupacional', ic: 'prancheta', aba: /ocupacional/i },
    acidente: { rot: 'Acidentes', um: 'Acidente', ic: 'alerta', aba: /acidente/i }
  };
  var ORDEM = ['consulta', 'exame', 'atestado', 'doenca', 'vacina', 'cmo', 'acidente'];
  var PERTO = 30, RECENTE = 365;

  /* FICHAS  o que a gaveta de lançar/corrigir mostra de cada grade, nesta ordem, com o nome que
             o campo ganha NA GAVETA (a grade continua com o título original). { sec } é um
             título de bloco; 'meia' põe o campo em meia linha (datas e horas lado a lado).
             Coluna fora da lista não aparece: a grade preenche sozinha (empresa, matrícula,
             usuário, data de atualização). Tipo sem ficha (exames) não ganha "Novo"/"Editar".
     PODE MEXER os nomes, a ordem, os blocos; a coluna (COD_DOENCA…) tem de ser a da grade. */
  var FICHAS = {
    atestado: [
      { sec: 'O atestado' },
      ['COD_ATESTADO_MEDICO', 'Tipo de atestado'],
      ['DT_ATESTADO_MEDICO', 'Data do atestado', 'meia'], ['OCUPACIONAL', 'Ocupacional?', 'meia'],
      ['COD_MOTIVO', 'Motivo'], ['DESC_MOTIVO', 'Descrição do motivo'], ['COD_DOENCA', 'CID'],
      { sec: 'Quem atestou' },
      ['COD_PREST_SERV', 'Médico'], ['COD_ENTIDADE', 'Entidade'],
      { sec: 'Afastamento' },
      ['DT_INICIO_AFASTAMENTO', 'Início', 'meia'], ['HORA_INICIO_AFASTAMENTO', 'Hora do início', 'meia'],
      ['DT_TERMINO_AFASTAMENTO', 'Término', 'meia'], ['HORA_TERMINO_AFASTAMENTO', 'Hora do término', 'meia'],
      ['QTDE_DIAS_AFASTAMENTO', 'Dias afastado', 'meia'], ['QTDE_HORAS_ABONADAS', 'Horas abonadas', 'meia']
    ],
    doenca: [
      ['COD_DOENCA', 'Doença (CID)'],
      ['DT_INICIO', 'Início', 'meia'], ['DT_TERMINO', 'Término (vazio = ainda em aberto)', 'meia']
    ]
  };

  /* ═══ [H3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function nome(t) {
    return String(t || '').toLowerCase().replace(/(^|[\s'(/-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); })
      .replace(/\s(De|Da|Do|Das|Dos|E|Em|Sem|Com)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  /* "478 - CONFEITEIRO" → "478 - Confeiteiro"; "101338-Ivanilda" → "101338 - Ivanilda" */
  function codDesc(t) {
    t = String(t || '').trim(); if (!t || t === '-') return '';
    var m = /^([^\s-][^\s]*?)\s*-\s*(.+)$/.exec(t);
    if (!m || !/\d/.test(m[1])) return /[a-zà-ú]/.test(t) ? t : nome(t);
    return m[1] + ' - ' + (/[a-zà-ú]/.test(m[2]) ? m[2] : nome(m[2]));
  }
  function limpo(t) { t = String(t == null ? '' : t).replace(/\s+/g, ' ').trim(); return t === '-' || t === '.' ? '' : t; }
  function texto(id) { var e = $id(id + '_DISPLAY') || $id(id); if (!e) return ''; if (e.tagName === 'SELECT') return e.selectedIndex >= 0 && e.value ? e.options[e.selectedIndex].text.trim() : ''; return String(/^(INPUT|TEXTAREA)$/.test(e.tagName) ? e.value : e.textContent).trim(); }
  function dataBR(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function dd(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear(); }
  function hoje() { var n = new Date(); return new Date(n.getFullYear(), n.getMonth(), n.getDate()); }
  function dias(a, b) { return Math.round((b - a) / 864e5); }
  function quanto(n) {
    n = Math.abs(n);
    if (n >= 365) { var a = Math.floor(n / 365.25), m = Math.floor((n - a * 365.25) / 30.44); return a + (a === 1 ? ' ano' : ' anos') + (m > 0 && a < 3 ? ' e ' + m + (m === 1 ? ' mês' : ' meses') : ''); }
    if (n >= 60) return Math.floor(n / 30.44) + ' meses';
    return n + (n === 1 ? ' dia' : ' dias');
  }
  var IC = {
    estetoscopio: '<path d="M6 4v5a4 4 0 0 0 8 0V4"/><path d="M10 13v2a4.5 4.5 0 0 0 9 0v-1.5"/><circle cx="19" cy="12" r="1.8"/>',
    frasco: '<path d="M9.5 3.5h5M10.5 3.5v5.2L5.6 17.3A2 2 0 0 0 7.3 20.3h9.4a2 2 0 0 0 1.7-3l-4.9-8.6V3.5"/><path d="M7.7 14h8.6"/>',
    documento: '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4M9.5 12.5h6M9.5 16h6"/>',
    cruz: '<path d="M9.5 4h5v5.5H20v5h-5.5V20h-5v-5.5H4v-5h5.5z"/>',
    seringa: '<path d="M14.5 3.5l6 6M17.5 6.5l-9 9-3-3 9-9M8.5 15.5l-5 5M10 9l2 2M12.5 6.5l2 2"/>',
    prancheta: '<rect x="5.5" y="5" width="13" height="15.5" rx="2"/><path d="M9 5V3.5h6V5M8.5 10.5h7M8.5 14h7M8.5 17.5h4"/>',
    alerta: '<path d="M12 4l9 16H3z"/><path d="M12 10v4M12 17h.01"/>',
    busca: '<circle cx="11" cy="11" r="6"/><path d="M20 20l-4.2-4.2"/>', seta: '<path d="M9.5 6l6 6-6 6"/>',
    lista: '<path d="M9 6h11M9 12h11M9 18h11M4.5 6h.01M4.5 12h.01M4.5 18h.01"/>', tempo: '<circle cx="12" cy="12" r="8"/><path d="M12 7.5V12l3 2"/>',
    gota: '<path d="M12 3.5s6 6.6 6 11a6 6 0 0 1-12 0c0-4.4 6-11 6-11z"/>', lapis: '<path d="M14.5 5.5l4 4L9 19H5v-4z"/>', fora: '<path d="M14 4.5h5.5V10M19.5 4.5L11 13M17 14v5.5H4.5V7H10"/>',
    mais: '<path d="M12 5v14M5 12h14"/>', fechar: '<path d="M6 6l12 12M18 6L6 18"/>', check: '<path d="M5 12.5l4.5 4.5L19 7.5"/>',
    lixo: '<path d="M4.5 7h15M9.5 7V4.5h5V7M6.5 7l1 13h9l1-13M10.5 11v5.5M13.5 11v5.5"/>'
  };
  function ic(n) { return '<svg class="nc-hc-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }

  function iniciar() {
    if (window.__ncHistorico) return;
    /* ═══ [H1] COMO A PÁGINA É RECONHECIDA ════════════════════════════════════════════════ */
    var abas = document.querySelector('.t-TabsRegion');
    if (!abas || !$id('P6_MATRICULA') || !$id('P6_NOME')) return;
    window.__ncHistorico = true;
    document.body.classList.add('nc-hc-ativo');
    var cabDlg = document.querySelector('.t-Dialog-header'), peDlg = document.querySelector('.t-Dialog-footer');
    var regDados = ($id('P6_NOME_CONTAINER') || $id('P6_NOME')).closest('.t-Region');
    var app = el('section', 'nc-hc'); app.setAttribute('aria-label', 'Histórico do colaborador');
    abas.parentNode.insertBefore(app, abas);
    /* o título grande ("Dados de Funcionário - Medicina do Trabalho") sai: o alto já diz quem é */
    [].forEach.call(document.querySelectorAll('.t-BreadcrumbRegion, .t-HeroRegion'), function (r) { if (!abas.contains(r)) r.classList.add('nc-hc-guardada'); });

    /* ═══ [H4] QUEM É ════════════════════════════════════════════════════════════════════ */
    var pac = el('header', 'nc-hc-paciente');
    function desenharPaciente() {
      var nm = texto('P6_NOME'), cod = texto('P6_MATRICULA');
      if (nm && !/[a-zà-ú]/.test(nm)) nm = nome(nm);
      var ini = String(nm || '?').split(/\s+/).filter(function (p) { return p.length > 2; });
      ini = ((ini[0] || '?').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '')).toUpperCase();
      var idade = texto('P6_IDADE');
      var dados = [['Idade', idade ? idade + ' anos' : ''], ['Cargo', codDesc(texto('P6_CARGO'))], ['Setor', codDesc(texto('P6_COD_CCUSTO'))], ['Local', codDesc(texto('P6_COD_LOCALIZACAO'))], ['Filial', codDesc(texto('P6_FILIAL'))], ['Empresa', codDesc(texto('P6_COD_EMPRESA'))]]
        .filter(function (d) { return d[1]; });
      pac.innerHTML = '<span class="nc-hc-avatar" aria-hidden="true">' + esc(ini) + '</span>' +
        '<div class="nc-hc-pac-nome"><h1>' + (cod ? '<span class="nc-hc-cod">' + esc(cod) + ' - </span>' : '') + esc(nm || 'Colaborador') + '</h1>' +
        '<dl class="nc-hc-pac-dados">' + dados.map(function (d) { return '<div data-k="' + esc(d[0].toLowerCase()) + '"><dt>' + esc(d[0]) + '</dt><dd>' + esc(d[1]) + '</dd></div>'; }).join('') + '</dl></div>';
    }
    var estreito = window.matchMedia && window.matchMedia('(max-width: 760px)');
    function lugarPaciente() { if ((estreito && estreito.matches) || !cabDlg) app.insertBefore(pac, app.firstChild); else cabDlg.appendChild(pac); document.body.classList.toggle('nc-hc-cab-fixo', pac.parentNode === cabDlg); }

    /* ═══ [H5] LER AS FONTES ══════════════════════════════════════════════════════════════
       CUIDADO  Só leitura. Grade: o modelo (valor e texto da lista — {v, d}); relatório: as
                células, pelo id da coluna (relatório clássico) ou pelo cabeçalho (interativo).
       ════════════════════════════════════════════════════════════════════════════════════ */
    function grades() {
      var out = {};
      [].forEach.call(abas.querySelectorAll('.a-IG'), function (e) {
        var ig = $(e), v; try { v = ig.interactiveGrid('getViews', 'grid'); } catch (x) { return; }
        if (!v || !v.modelColumns) return;
        var c = v.modelColumns;
        var tipo = c.DT_ATESTADO_MEDICO ? 'atestado' : c.COD_EXAME ? 'exame' : (c.COD_DOENCA && c.DT_INICIO) ? 'doenca' : null;
        if (tipo) out[tipo] = { v: v, ig: e, reg: e.closest('.t-Region, .t-IRR-region') || e };
      });
      return out;
    }
    function val(v, rec, col) {
      if (!v.modelColumns[col]) return { v: '', d: '' };
      var x = v.model.getValue(rec, col);
      if (x && typeof x === 'object') return { v: x.v == null ? '' : String(x.v), d: limpo(x.d == null ? x.v : x.d) };
      return { v: x == null ? '' : String(x), d: limpo(x) };
    }
    function novoNaoGravado(v, rec) { var m = v.model.getRecordMetadata(v.model.getRecordId(rec)); return !!(m && (m.inserted || m.deleted)); }
    function relatorios() {
      var out = {};
      [].forEach.call(abas.querySelectorAll('table.t-Report-report, table.a-IRR-table'), function (t) {
        var reg = t.closest('.t-IRR-region, .t-Region');
        var ths = [].slice.call(t.querySelectorAll('th'));
        var cols = ths.map(function (h) { return { id: h.id || '', rot: limpo(h.textContent) }; });
        var tem = function (re) { return cols.some(function (c) { return re.test(c.id) || re.test(c.rot); }); };
        var tipo = tem(/^DT_CONSULTA$/) ? 'consulta' : tem(/^DT_ACIDENTE$/) ? 'acidente' : tem(/^data agd consulta$/i) ? 'cmo' : tem(/^vacina$/i) ? 'vacina' : tem(/descri.*atividades/i) ? 'atividades' : null;
        if (!tipo) return;
        var linhas = [];
        [].forEach.call(t.querySelectorAll('tbody tr'), function (tr) {
          var tds = tr.querySelectorAll('td'); if (!tds.length) return;
          var l = { _links: {} };
          [].forEach.call(tds, function (td, i) {
            var hid = td.getAttribute('headers') || (cols[i] && cols[i].id) || '';
            var col = cols.filter(function (c) { return c.id === hid; })[0] || cols[i] || { id: 'c' + i, rot: '' };
            var chave = col.id && !/^C\d+$/.test(col.id) ? col.id : col.rot;
            l[chave] = limpo(td.textContent);
            l['@' + chave] = col.rot;
            var a = td.querySelector('a[href]'); if (a && !/^#/.test(a.getAttribute('href'))) l._links[chave] = { href: a.getAttribute('href'), alvo: a.getAttribute('target') || '' };
          });
          linhas.push(l);
        });
        /* há mais páginas do que a tela mostra? (o relatório tem "próximo") */
        var mais = !!(reg && reg.querySelector('.t-Report-paginationLink--next, .a-IRR-button--pagination[title*="Próx"], a.t-Report-paginationLink[href*="next"], button[data-pagination="next"]:not([disabled])'));
        out[tipo] = { reg: reg, linhas: linhas, mais: mais };
      });
      return out;
    }
    function porRotulo(l, re) { var k = Object.keys(l).filter(function (k) { return k.charAt(0) === '@' && re.test(l[k]); })[0]; return k ? l[k.slice(1)] || '' : ''; }
    function campos(l) { return Object.keys(l).filter(function (k) { return k.charAt(0) === '@' && l[k.slice(1)] && l[k] && !/^visualizar$/i.test(l[k]); }).map(function (k) { return [l[k], l[k.slice(1)]]; }); }

    /* junta tudo em registros: { tipo, data, titulo, sub[], tom, det[[rótulo, valor]], links[] } */
    var FONTES = null;
    function registros() {
      var g = grades(), r = relatorios(), out = [];
      FONTES = { g: g, r: r };
      if (g.exame) g.exame.v.model.forEach(function (rec) {
        if (novoNaoGravado(g.exame.v, rec)) return;
        var v = g.exame.v, ex = val(v, rec, 'COD_EXAME'), res = val(v, rec, 'RESULTADO').d || val(v, rec, 'COD_RESULTADO').d, prox = dataBR(val(v, rec, 'DT_PROX_EXAME_PERIOD').v);
        out.push({ tipo: 'exame', rid: v.model.getRecordId(rec), data: dataBR(val(v, rec, 'DT_EXAME').v), titulo: ex.d.replace(/^\S+\s+-\s+/, '') || ex.v, cod: ex.v, res: res.replace(/^\d+\s*-\s*/, ''), prox: prox,
          sub: [val(v, rec, 'TIPO_EXAME').d, codDesc(val(v, rec, 'COD_PREST_SERV').d)].filter(Boolean),
          det: [['Exame', ex.d], ['Resultado', res], ['Próximo exame', prox ? dd(prox) : ''], ['Tipo', val(v, rec, 'TIPO_EXAME').d], ['Ocupacional', val(v, rec, 'OCUPACIONAL').d], ['Médico', codDesc(val(v, rec, 'COD_PREST_SERV').d)], ['Entidade', codDesc(val(v, rec, 'ENTIDADE').d)], ['Origem', codDesc(val(v, rec, 'COD_PREST_SERV_ORIGEM').d)]] });
      });
      if (g.atestado) g.atestado.v.model.forEach(function (rec) {
        if (novoNaoGravado(g.atestado.v, rec)) return;
        var v = g.atestado.v, ini = dataBR(val(v, rec, 'DT_INICIO_AFASTAMENTO').v), fim = dataBR(val(v, rec, 'DT_TERMINO_AFASTAMENTO').v), qd = val(v, rec, 'QTDE_DIAS_AFASTAMENTO').d, hs = val(v, rec, 'QTDE_HORAS_ABONADAS').d;
        var cid = val(v, rec, 'COD_DOENCA').d, tipoA = codDesc(val(v, rec, 'COD_ATESTADO_MEDICO').d), mot = limpo(val(v, rec, 'DESC_MOTIVO').d) || codDesc(val(v, rec, 'COD_MOTIVO').d);
        out.push({ tipo: 'atestado', rid: v.model.getRecordId(rec), data: dataBR(val(v, rec, 'DT_ATESTADO_MEDICO').v), titulo: (tipoA.replace(/^\S+\s+-\s+/, '') || 'Atestado') + (cid ? ' · ' + cid.replace(/\s+-\s+.*/, '') : ''), ini: ini, fim: fim,
          sub: [ini ? 'Afastamento ' + dd(ini) + (fim ? ' a ' + dd(fim) : '') + (qd ? ' (' + qd + (qd === '1' ? ' dia' : ' dias') + ')' : '') : '', hs ? hs + ' h abonadas' : '', cid].filter(Boolean),
          det: [['Atestado', tipoA], ['Motivo', mot], ['CID', cid], ['Ocupacional', val(v, rec, 'OCUPACIONAL').d], ['Afastamento', ini ? dd(ini) + (fim ? ' a ' + dd(fim) : '') : ''], ['Dias', qd], ['Horas abonadas', hs], ['Médico', codDesc(val(v, rec, 'COD_PREST_SERV').d)], ['Entidade', codDesc(val(v, rec, 'COD_ENTIDADE').d)]] });
      });
      if (g.doenca) g.doenca.v.model.forEach(function (rec) {
        if (novoNaoGravado(g.doenca.v, rec)) return;
        var v = g.doenca.v, d = val(v, rec, 'COD_DOENCA'), ini = dataBR(val(v, rec, 'DT_INICIO').v), fim = dataBR(val(v, rec, 'DT_TERMINO').v);
        out.push({ tipo: 'doenca', rid: v.model.getRecordId(rec), data: ini, titulo: d.d || d.v, ini: ini, fim: fim, aberta: !fim,
          sub: [ini ? (fim ? dd(ini) + ' a ' + dd(fim) + ' (' + quanto(dias(ini, fim)) + ')' : 'Desde ' + dd(ini) + ', sem término') : ''].filter(Boolean),
          det: [['CID', d.d], ['Início', ini ? dd(ini) : ''], ['Término', fim ? dd(fim) : 'Em aberto']] });
      });
      if (r.consulta) r.consulta.linhas.forEach(function (l) {
        var lk = l._links.VISUALIZAR;
        out.push({ tipo: 'consulta', data: dataBR(l.DT_CONSULTA), hora: (l.HORA || '').replace(/\s/g, ''), titulo: codDesc(l.TIPO_CONSULTA).replace(/^\S+\s+-\s+/, '') || 'Consulta',
          sub: [codDesc(l.MEDICO), codDesc(l.ESPECIALIDADE).replace(/^\S+\s+-\s+/, '')].filter(Boolean), det: campos(l).filter(function (c) { return !/empresa|matr/i.test(c[0]); }),
          links: lk ? [{ rot: 'Ver consulta', href: lk.href, alvo: lk.alvo, ic: 'seta' }] : [] });
      });
      if (r.acidente) r.acidente.linhas.forEach(function (l) {
        var lk = l._links.VISUALIZAR, qd = l.QUANTIDADE_DIAS_AFASTAMENTO;
        out.push({ tipo: 'acidente', data: dataBR(l.DT_ACIDENTE), titulo: 'Acidente ' + (l.TIPO || '').toLowerCase(),
          sub: [l.IND_AFASTAMENTO === 'Sim' ? 'Afastado' + (qd ? ' ' + qd + (qd === '1' ? ' dia' : ' dias') : '') : 'Sem afastamento', l.CID ? 'CID ' + l.CID : '', l.ESPEC_LOCAL_ACIDENTE].filter(Boolean),
          det: campos(l).filter(function (c) { return !/empresa|colaborador|hora acidente/i.test(c[0]); }),
          links: lk ? [{ rot: 'Abrir análise', href: lk.href, alvo: lk.alvo || '_blank', ic: 'fora' }] : [] });
      });
      if (r.cmo) r.cmo.linhas.forEach(function (l) {
        out.push({ tipo: 'cmo', data: dataBR(porRotulo(l, /data agd/i)), titulo: codDesc(porRotulo(l, /tipo consulta/i)).replace(/^\S+\s+-\s+/, '') || 'Consulta ocupacional',
          sub: [porRotulo(l, /resultado aso/i) ? 'ASO ' + porRotulo(l, /resultado aso/i) : '', porRotulo(l, /validade/i) ? 'válido até ' + porRotulo(l, /validade/i) : ''].filter(Boolean), det: campos(l).filter(function (c) { return !/^(cod empresa|matricula)$/i.test(c[0]); }) });
      });
      if (r.vacina) r.vacina.linhas.forEach(function (l) {
        var prox = dataBR(porRotulo(l, /pr[oó]x/i));
        out.push({ tipo: 'vacina', data: dataBR(porRotulo(l, /^data$/i)), titulo: porRotulo(l, /^vacina$/i) || 'Vacina', prox: prox,
          sub: [porRotulo(l, /^dose$/i), prox ? 'próxima dose ' + dd(prox) : ''].filter(Boolean), det: campos(l) });
      });
      out.sort(function (a, b) { return (b.data || 0) - (a.data || 0); });
      return out;
    }

    /* ═══ [H6] ATENÇÃO (O RESUMO À ESQUERDA) ══════════════════════════════════════════════ */
    var lado = el('aside', 'nc-hc-lado'); lado.setAttribute('aria-label', 'Resumo');
    var principal = el('div', 'nc-hc-principal');
    var corpo = el('div', 'nc-hc-corpo'); corpo.appendChild(lado); corpo.appendChild(principal); app.appendChild(corpo);
    function atencao(lista) {
      var h = hoje(), itens = [];
      var restr = texto('P6_RESTRICAO_REST');
      if (restr) itens.push({ tom: 'ruim', tit: 'Restrições', txt: restr, acao: 'restricoes' });
      lista.filter(function (e) { return e.tipo === 'atestado' && e.fim && e.fim >= h; }).forEach(function (e) { itens.push({ tom: 'ruim', tit: 'Afastado até ' + dd(e.fim), txt: e.titulo }); });
      lista.filter(function (e) { return e.tipo === 'doenca' && e.aberta; }).forEach(function (e) { itens.push({ tom: 'atencao', tit: 'Doença sem término', txt: e.titulo + (e.ini ? ', desde ' + dd(e.ini) : '') }); });
      /* exames: o último de cada exame, com o próximo vencido ou perto */
      var vistos = {};
      lista.filter(function (e) { return e.tipo === 'exame'; }).forEach(function (e) {
        if (vistos[e.cod]) return; vistos[e.cod] = true;
        if (!e.prox) return;
        var n = dias(h, e.prox);
        if (n < 0) itens.push({ tom: 'ruim', tit: e.titulo + ' vencido', txt: 'Venceu há ' + quanto(n) + ' (' + dd(e.prox) + ')' });
        else if (n <= PERTO) itens.push({ tom: 'atencao', tit: e.titulo + ' vence em breve', txt: (n ? 'Em ' + quanto(n) : 'Hoje') + ' (' + dd(e.prox) + ')' });
      });
      lista.filter(function (e) { return e.tipo === 'vacina' && e.prox; }).forEach(function (e) {
        var n = dias(h, e.prox); if (n <= PERTO) itens.push({ tom: n < 0 ? 'ruim' : 'atencao', tit: e.titulo + (n < 0 ? ': dose atrasada' : ': próxima dose'), txt: dd(e.prox) });
      });
      lista.filter(function (e) { return e.tipo === 'acidente' && e.data && dias(e.data, h) <= RECENTE; }).forEach(function (e) { itens.push({ tom: 'atencao', tit: e.titulo + ' recente', txt: dd(e.data) + (e.sub[0] ? ' · ' + e.sub[0] : '') }); });
      return itens;
    }
    /* três caixas: Atenção e Função se redesenham; Sangue é montada UMA vez (os campos
       originais vivem nela — redesenhar com innerHTML os tiraria do formulário) */
    var cxAtencao = el('section', 'nc-hc-caixa nc-hc-atencao'), cxSangue = el('section', 'nc-hc-caixa nc-hc-sangue'), cxFuncao = el('section', 'nc-hc-caixa nc-hc-funcao');
    lado.appendChild(cxAtencao); lado.appendChild(cxSangue); lado.appendChild(cxFuncao);
    cxSangue.innerHTML = '<h2>' + ic('gota') + 'Sangue</h2><div class="nc-hc-sangue-campos"></div>';
    (function () {
      var sc = cxSangue.querySelector('.nc-hc-sangue-campos');
      ['P6_TIPO_SANGUINEO', 'P6_FATOR_RH'].forEach(function (id) { var c = $id(id + '_CONTAINER'); if (c) { c.classList.add('nc-hc-campo'); sc.appendChild(c); } });
      var lab = $id('P6_TIPO_SANGUINEO_LABEL'); if (lab) lab.textContent = 'Tipo';
      lab = $id('P6_FATOR_RH_LABEL'); if (lab) lab.textContent = 'Fator RH';
      if (!sc.children.length) cxSangue.hidden = true;
    })();
    function desenharLado(lista) {
      var itens = atencao(lista);
      var ativ = FONTES.r.atividades && FONTES.r.atividades.linhas.map(function (l) { return campos(l).map(function (c) { return c[1]; }).join(' '); }).filter(Boolean).join('\n');
      cxAtencao.innerHTML = '<h2>Atenção</h2>' + (itens.length ?
        '<ul>' + itens.map(function (i) { return '<li data-tom="' + i.tom + '"><b>' + esc(i.tit) + '</b><span>' + esc(i.txt) + '</span>' + (i.acao ? '<button type="button" class="nc-hc-link" data-ir="' + i.acao + '">' + ic('lapis') + 'Editar</button>' : '') + '</li>'; }).join('') + '</ul>'
        : '<p class="nc-hc-ok">Nada pendente: sem restrições, afastamentos ou exames vencidos.</p>');
      cxFuncao.hidden = !ativ;
      cxFuncao.innerHTML = ativ ? '<h2>O que a função faz</h2><p>' + esc(ativ) + '</p>' : '';
    }
    lado.addEventListener('click', function (ev) { var b = ev.target.closest('[data-ir]'); if (b) irParaAba(/restri/i); });

    /* ═══ [H7] A LINHA DO TEMPO ═══════════════════════════════════════════════════════════ */
    var FILTRO = '', BUSCA = '', ABERTO = {};
    principal.innerHTML = '<div class="nc-hc-topo"><div class="nc-hc-vistas" role="tablist" aria-label="Como ver">' +
      '<button type="button" role="tab" data-vista="tempo" aria-selected="true">' + ic('tempo') + 'Linha do tempo</button>' +
      '<button type="button" role="tab" data-vista="tabelas" aria-selected="false">' + ic('lista') + 'Tabelas</button></div>' +
      '<div class="nc-hc-novos"></div>' +
      '<label class="nc-hc-busca">' + ic('busca') + '<span class="nc-hc-so-leitor">Buscar no histórico</span><input type="search" placeholder="Buscar: CID, exame, médico, motivo…" autocomplete="off"></label></div>' +
      '<div class="nc-hc-tempo"><div class="nc-hc-filtros" role="toolbar" aria-label="Filtrar por tipo"></div><div class="nc-hc-avisos"></div><div class="nc-hc-linha"></div></div>';
    var novos = principal.querySelector('.nc-hc-novos'), filtros = principal.querySelector('.nc-hc-filtros'), linha = principal.querySelector('.nc-hc-linha'), avisos = principal.querySelector('.nc-hc-avisos');
    var TODOS = [];
    function desenharTempo() {
      /* 04/10 (cliente: "Nova doença, por enquanto deixa como já está no programa original"): no
         original não se inclui doença aqui — CID e início são "Read Only: Always" na grade. Sem
         "Nova doença"; editar a existente (o término) continua. */
      var SEM_NOVO = ['doenca'];
      var podeNovo = Object.keys(FICHAS).filter(function (t) { return SEM_NOVO.indexOf(t) < 0 && pode(t, 'novo'); });
      novos.innerHTML = podeNovo.map(function (t) { return '<button type="button" class="nc-hc-bt nc-hc-novo" data-tipo="' + t + '" data-novo="' + t + '">' + ic('mais') + (t === 'doenca' ? 'Nova ' : 'Novo ') + esc(TIPOS[t].um.toLowerCase()) + '</button>'; }).join('');
      novos.hidden = !podeNovo.length;
      var conta = {}; TODOS.forEach(function (e) { conta[e.tipo] = (conta[e.tipo] || 0) + 1; });
      filtros.innerHTML = '<button type="button" class="nc-hc-chip" data-filtro="" aria-pressed="' + (!FILTRO) + '">Tudo <span>' + TODOS.length + '</span></button>' +
        ORDEM.filter(function (t) { return conta[t]; }).map(function (t) { return '<button type="button" class="nc-hc-chip" data-tipo="' + t + '" data-filtro="' + t + '" aria-pressed="' + (FILTRO === t) + '">' + ic(TIPOS[t].ic) + esc(TIPOS[t].rot) + ' <span>' + conta[t] + '</span></button>'; }).join('');
      var mais = Object.keys(FONTES.r).filter(function (k) { return FONTES.r[k].mais && TIPOS[k]; });
      avisos.innerHTML = mais.length ? '<p class="nc-hc-nota">Há mais ' + mais.map(function (k) { return TIPOS[k].rot.toLowerCase(); }).join(' e ') + ' do que a tela mostra. <button type="button" class="nc-hc-link" data-ir-tipo="' + mais[0] + '">Ver na tabela</button></p>' : '';
      var b = BUSCA.toLowerCase();
      var vis = TODOS.filter(function (e) {
        if (FILTRO && e.tipo !== FILTRO) return false;
        if (!b) return true;
        return [e.titulo, e.sub.join(' '), e.det.map(function (d) { return d.join(' '); }).join(' '), e.data ? dd(e.data) : ''].join(' ').toLowerCase().indexOf(b) >= 0;
      });
      if (!TODOS.length) { linha.innerHTML = '<p class="nc-hc-vazio"><b>Nenhum registro no histórico deste colaborador.</b></p>'; return; }
      if (!vis.length) { linha.innerHTML = '<p class="nc-hc-vazio">Nada encontrado' + (BUSCA ? ' para "' + esc(BUSCA) + '"' : '') + '.</p>'; return; }
      var html = '', ano = null;
      vis.forEach(function (e) {
        var a = e.data ? e.data.getFullYear() : 'Sem data';
        if (a !== ano) { if (ano !== null) html += '</ol>'; html += '<h3 class="nc-hc-ano">' + a + '</h3><ol class="nc-hc-itens">'; ano = a; }
        /* a chave não depende da posição: o item aberto continua aberto ao filtrar ou buscar */
        var chave = e.tipo + ':' + (e.data ? +e.data : 'x') + ':' + e.titulo + ':' + e.sub.join('|'), aberto = !!ABERTO[chave];
        var res = e.res ? '<span class="nc-hc-res" data-tom="' + (/inapto|alterad|anormal/i.test(e.res) ? 'ruim' : /apto|normal/i.test(e.res) ? 'bom' : 'neutro') + '">' + esc(e.res) + '</span>' : '';
        var marca = e.aberta ? '<span class="nc-hc-marca" data-tom="atencao">Sem término</span>' : (e.tipo === 'atestado' && e.fim && e.fim >= hoje()) ? '<span class="nc-hc-marca" data-tom="ruim">Em vigor</span>' : '';
        html += '<li class="nc-hc-item" data-tipo="' + e.tipo + '">' +
          '<button type="button" class="nc-hc-linha-bt" aria-expanded="' + aberto + '" data-chave="' + esc(chave) + '">' +
            '<span class="nc-hc-quando">' + (e.data ? '<b>' + ('0' + e.data.getDate()).slice(-2) + ' ' + MESES[e.data.getMonth()] + '</b>' : '<b>—</b>') + (e.hora ? '<span>' + esc(e.hora) + '</span>' : '') + '</span>' +
            '<span class="nc-hc-marcador" aria-hidden="true">' + ic(TIPOS[e.tipo].ic) + '</span>' +
            '<span class="nc-hc-txt"><span class="nc-hc-tipo">' + esc(TIPOS[e.tipo].um) + '</span><span class="nc-hc-tit">' + esc(e.titulo) + res + marca + '</span>' +
              (e.sub.length ? '<span class="nc-hc-sub">' + e.sub.map(function (s) { return '<span>' + esc(s) + '</span>'; }).join('') + '</span>' : '') + '</span>' +
            ic('seta') +
          '</button>' +
          (aberto ? '<div class="nc-hc-det"><dl>' + e.det.filter(function (d) { return d[1]; }).map(function (d) { return '<div><dt>' + esc(d[0]) + '</dt><dd>' + esc(d[1]) + '</dd></div>'; }).join('') + '</dl>' +
            '<div class="nc-hc-det-acoes">' + (e.links || []).map(function (l) { return '<a class="nc-hc-bt" href="' + esc(l.href) + '"' + (l.alvo ? ' target="' + esc(l.alvo) + '" rel="noopener"' : '') + '>' + ic(l.ic) + esc(l.rot) + '</a>'; }).join('') +
            (e.rid != null && pode(e.tipo, 'editar', e.rid) ? '<button type="button" class="nc-hc-bt nc-hc-bt--primario" data-editar="' + e.tipo + '" data-rid="' + esc(e.rid) + '">' + ic('lapis') + 'Editar</button>' :
              '<button type="button" class="nc-hc-bt nc-hc-bt--leve" data-ir-tipo="' + e.tipo + '">' + ic('lista') + 'Ver na tabela</button>') + '</div></div>' : '') +
        '</li>';
      });
      linha.innerHTML = html + '</ol>';
    }
    principal.addEventListener('click', function (ev) {
      var t = ev.target.closest('[data-filtro],[data-chave],[data-vista],[data-ir-tipo],[data-editar],[data-novo]'); if (!t) return;
      if (t.hasAttribute('data-novo')) return abrirFicha(t.getAttribute('data-novo'), null, t);
      if (t.hasAttribute('data-editar')) return abrirFicha(t.getAttribute('data-editar'), t.getAttribute('data-rid'), t);
      if (t.hasAttribute('data-filtro')) { FILTRO = t.getAttribute('data-filtro'); return desenharTempo(); }
      if (t.hasAttribute('data-chave')) { var k = t.getAttribute('data-chave'); ABERTO[k] = !ABERTO[k]; return desenharTempo(); }
      if (t.hasAttribute('data-vista')) return vista(t.getAttribute('data-vista'));
      if (t.hasAttribute('data-ir-tipo')) { var tp = TIPOS[t.getAttribute('data-ir-tipo')]; if (tp) irParaAba(tp.aba); }
    });
    principal.querySelector('input[type="search"]').addEventListener('input', function (ev) { BUSCA = ev.target.value.trim(); desenharTempo(); });

    /* ═══ [H8] TABELAS (AS ABAS ORIGINAIS) E O RODAPÉ ═════════════════════════════════════
       As abas originais vão para dentro da coluna da direita e aparecem em "Tabelas" — só para
       consultar: os botões de editar da grade ficam escondidos (lançar e corrigir é na gaveta,
       [H9]). "Ver na tabela" abre a aba do tipo.
       ════════════════════════════════════════════════════════════════════════════════════ */
    principal.appendChild(abas); abas.classList.add('nc-hc-abas');
    function vista(v) {
      document.body.classList.toggle('nc-hc-tabelas', v === 'tabelas');
      [].forEach.call(principal.querySelectorAll('[data-vista]'), function (b) { b.setAttribute('aria-selected', b.getAttribute('data-vista') === v ? 'true' : 'false'); });
      if (v === 'tabelas') $(window).trigger('resize');   /* grades que estavam escondidas se ajustam */
      else atualizar();
    }
    function irParaAba(re) {
      vista('tabelas');
      var a = [].filter.call(abas.querySelectorAll('.t-Tabs-item a, .a-Tabs-item a'), function (x) { return re.test(x.textContent.trim()); })[0];
      if (a) { a.click(); setTimeout(function () { $(window).trigger('resize'); abas.scrollIntoView({ block: 'start' }); }, 60); }
    }
    /* rodapé: Voltar e Salvar (os originais, da região de dados) */
    var pe = el('div', 'nc-hc-pe'), peEsq = el('div', 'nc-hc-pe-esq'), peDir = el('div', 'nc-hc-pe-dir');
    pe.appendChild(peEsq); pe.appendChild(peDir);
    if (regDados) [].forEach.call(regDados.querySelectorAll('.t-Region-header button.t-Button, .t-Region-headerItems--buttons button.t-Button'), function (b) {
      b.classList.add('nc-hc-bt'); if (/salvar/i.test(b.textContent)) { b.classList.add('nc-hc-bt--primario'); b.title = 'Salva o tipo sanguíneo, o fator RH e o que foi mudado nas tabelas'; peDir.appendChild(b); } else peEsq.appendChild(b);
    });
    if (peDlg) { peDlg.classList.add('nc-hc-rodape'); peDlg.appendChild(pe); } else app.appendChild(pe);
    if (regDados) regDados.classList.add('nc-hc-guardada');

    /* ═══ [H9] LANÇAR E CORRIGIR (A FICHA DA GRADE NUMA GAVETA) ═══════════════════════════
       CUIDADO  A gaveta é a "vista de um registro" (Single Row View) da PRÓPRIA grade: a região
                da grade sai da aba, entra na gaveta enquanto ela está aberta e volta ao fechar.
                As listas, os padrões (empresa e matrícula vêm da página), as validações e a
                gravação são os da grade; Salvar = o salvar da grade (processo "Save Interactive
                Grid Data"). Novo = a linha nova da grade; Cancelar desfaz a linha.
       Só aparece o que a página deixa: região sem "Somente leitura" e os esquemas de autorização
       de incluir / alterar / excluir. Os campos e os nomes estão em FICHAS ([H2]).
       ════════════════════════════════════════════════════════════════════════════════════ */
    var GAV = null, EDIT = null;
    function pode(tipo, op, rid) {
      var g = FONTES && FONTES.g[tipo]; if (!g || !FICHAS[tipo]) return false;
      var m = g.v.model, rec;
      try {
        if (!m.getOption('editable')) return false;
        if (op === 'novo') return !!m.allowAdd();
        rec = m.getRecord(rid); if (!rec) return false;
        return !!(op === 'excluir' ? m.allowDelete(rec) : m.allowEdit(rec));
      } catch (x) { return false; }
    }
    function montarGaveta() {
      if (GAV) return;
      GAV = { fundo: el('div', 'nc-hc-gfundo'), caixa: el('aside', 'nc-hc-gaveta') };
      GAV.caixa.tabIndex = -1; GAV.caixa.setAttribute('role', 'dialog'); GAV.caixa.setAttribute('aria-modal', 'true'); GAV.caixa.setAttribute('aria-labelledby', 'nc-hc-gtit');
      GAV.cab = el('header', 'nc-hc-gcab'); GAV.corpo = el('div', 'nc-hc-gcorpo'); GAV.pe = el('footer', 'nc-hc-gpe');
      GAV.caixa.appendChild(GAV.cab); GAV.caixa.appendChild(GAV.corpo); GAV.caixa.appendChild(GAV.pe);
      document.body.appendChild(GAV.fundo); document.body.appendChild(GAV.caixa);
      GAV.fundo.addEventListener('click', function () { fecharComCuidado(); });
      GAV.caixa.addEventListener('click', function (ev) {
        if (ev.target.closest('[data-gfechar]')) fecharComCuidado();
        else if (ev.target.closest('[data-gcancelar]')) fecharFicha(true);
        else if (ev.target.closest('[data-gsalvar]')) salvarFicha();
        else if (ev.target.closest('[data-gexcluir]')) excluirFicha();
      });
      /* captura: com a gaveta aberta, o Esc é dela — sem isso a janela do APEX (que também
         ouve o Esc) fecharia a página inteira. Calendário aberto fica com o próprio Esc. */
      window.addEventListener('keydown', function (ev) {
        if (!EDIT) return;
        if (ev.key === 'Escape') {
          if ([].some.call(document.querySelectorAll('.ui-datepicker, .ui-dialog'), function (d) { return d.offsetParent !== null; })) return;
          ev.preventDefault(); ev.stopImmediatePropagation(); fecharComCuidado();
        }
        if ((ev.ctrlKey || ev.metaKey) && (ev.key === 's' || ev.key === 'S')) { ev.preventDefault(); ev.stopImmediatePropagation(); salvarFicha(); }
      }, true);
    }
    function idsDe(m) { var ids = []; m.forEach(function (r) { ids.push(m.getRecordId(r)); }); return ids; }
    function abrirFicha(tipo, rid, volta) {
      if (EDIT) return;
      var g = FONTES && FONTES.g[tipo], acoes;
      if (!g || !pode(tipo, rid == null ? 'novo' : 'editar', rid)) return;
      try { acoes = $(g.ig).interactiveGrid('getActions'); } catch (x) { return; }
      montarGaveta();
      var v = g.v, m = v.model;
      EDIT = { tipo: tipo, g: g, v: v, acoes: acoes, novo: rid == null, rid: rid, volta: volta, lugar: document.createComment('nc-hc-grade') };
      g.reg.parentNode.insertBefore(EDIT.lugar, g.reg);
      GAV.corpo.appendChild(g.reg); g.reg.classList.add('nc-hc-motor');
      document.body.classList.add('nc-hc-editando');
      try { acoes.set('edit', true); } catch (x) { /* já está em edição */ }
      if (EDIT.novo) {
        var antes = idsDe(m);
        acoes.invoke('selection-add-row');
        EDIT.rid = idsDe(m).filter(function (id) { return antes.indexOf(id) < 0; })[0];
        if (EDIT.rid == null) { fecharFicha(false); return; }
      }
      /* a vista de um registro mostra o registro da célula ATIVA (como na Agenda Médica): a célula
         vai para o registro certo antes; depois se confere e, se preciso, anda até ele */
      var col = FICHAS[tipo].filter(function (f) { return f.length; })[0][0];
      try { v.view$.grid('gotoCell', EDIT.rid, col); } catch (x) { /* ok */ }
      acoes.invoke('single-row-view');
      try {
        var atual = function () { var r = v.singleRowView$ && v.singleRowView$.recordView('getRecord'); return r ? m.getRecordId(r) : null; };
        var lista = idsDe(m), alvo = lista.indexOf(EDIT.rid);
        for (var passo = 0; passo < 200 && atual() !== EDIT.rid; passo++) {
          var aqui = lista.indexOf(atual()); if (aqui < 0 || alvo < 0) break;
          acoes.invoke(aqui < alvo ? 'next-record' : 'previous-record');
        }
      } catch (x) { /* ok: segue com o que abriu */ }
      arrumarFicha(g, tipo);
      if (tipo === 'atestado') prepararHoras(v, EDIT.rid);
      var um = TIPOS[tipo].um.toLowerCase(), nm = texto('P6_NOME');
      GAV.cab.innerHTML = '<div><p class="nc-hc-gtipo" data-tipo="' + tipo + '">' + ic(TIPOS[tipo].ic) + esc(TIPOS[tipo].um) + '</p>' +
        '<h2 id="nc-hc-gtit">' + (EDIT.novo ? (tipo === 'doenca' ? 'Nova ' : 'Novo ') + um : 'Editar ' + um) + '</h2>' +
        (nm ? '<p class="nc-hc-gsub">' + esc(/[a-zà-ú]/.test(nm) ? nm : nome(nm)) + '</p>' : '') + '</div>' +
        '<button type="button" class="nc-hc-bt nc-hc-bt--icone" data-gfechar aria-label="Fechar">' + ic('fechar') + '</button>';
      GAV.pe.innerHTML = (!EDIT.novo && pode(tipo, 'excluir', EDIT.rid) ? '<button type="button" class="nc-hc-bt nc-hc-bt--perigo" data-gexcluir>' + ic('lixo') + 'Excluir</button>' : '') +
        '<span class="nc-hc-gpe-espaco"></span><button type="button" class="nc-hc-bt" data-gcancelar>Cancelar</button>' +
        '<button type="button" class="nc-hc-bt nc-hc-bt--primario" data-gsalvar>' + ic('check') + 'Salvar</button>';
      GAV.corpo.scrollTop = 0;
      setTimeout(function () {
        var f = [].filter.call(GAV.corpo.querySelectorAll('.u-Form > .u-Form-fieldContainer:not(.is-readonly) :is(input:not([type="hidden"]):not([readonly]), select, textarea)'), function (x) { return x.offsetParent !== null; })[0];
        (f && f.focus ? f : GAV.caixa).focus();   /* o foco fica na gaveta (Esc, Tab) */
      }, 120);
    }
    /* os campos de FICHAS ganham ordem, largura e o nome da gaveta; os outros somem; os blocos
       ganham título. CUIDADO: a ficha do grid REESCREVE as classes dos campos a cada registro —
       por isso ordem, largura e o que aparece vão numa folha presa ao ID de cada campo (uma por
       grade), e o nome é conferido a cada abertura. */
    var folhas = {};
    function arrumarFicha(g, tipo) {
      var rv = g.reg.querySelector('.a-RV'), form = rv && rv.querySelector('.u-Form'); if (!form) return;
      g.reg.setAttribute('data-ficha', tipo);
      var regras = [];
      FICHAS[tipo].forEach(function (f, i) {
        if (!f.length) {
          if (!form.querySelector('.nc-hc-gsec[data-i="' + i + '"]')) { var h = el('p', 'nc-hc-gsec', esc(f.sec)); h.setAttribute('data-i', i); h.style.order = i; form.appendChild(h); }
          return;
        }
        var mc = g.v.modelColumns[f[0]], id = mc && (mc.elementId || '') + '_CONTAINER', c = id && $id(id);
        if (!c) return;
        regras.push('html body:not(#nc-a1):not(#nc-a2).nc-hc-ativo .nc-hc-motor .a-RV .u-Form > #' + id + ':not(#nc-hc-x){display:flex!important;order:' + i + '!important;grid-column:' + (f[2] === 'meia' ? 'auto' : '1 / -1') + '!important}');
        var lb = c.querySelector('.u-Form-label, label'); if (lb && f[1] && lb.textContent !== f[1]) lb.textContent = f[1];
      });
      if (!folhas[tipo]) { folhas[tipo] = el('style'); folhas[tipo].id = 'nc-hc-ficha-' + tipo; document.head.appendChild(folhas[tipo]); folhas[tipo].textContent = regras.join('\n'); }
    }
    /* HORAS: hora do início e do término são TEXTO no banco (5 posições) e chegam de todo jeito
       ("1100", "11:00", "930"). Na gaveta: máscara 00:00 ao digitar (só números, os dois-pontos
       entram sozinhos), o que veio do banco aparece já como HH:MM, hora inválida avisa no campo, e
       ao salvar o registro vai SEMPRE com ":" (o que estava sem é corrigido na mesma gravação). */
    var HORAS = ['HORA_INICIO_AFASTAMENTO', 'HORA_TERMINO_AFASTAMENTO'];
    function fmtHora(t) {                       /* '' = vazio · null = inválida · 'HH:MM' */
      t = String(t == null ? '' : t).trim(); if (!t) return '';
      var d = t.replace(/\D/g, ''); if (!d || d.length > 4) return null;
      if (d.length <= 2) d = ('0' + d).slice(-2) + '00'; else if (d.length === 3) d = '0' + d;
      return +d.slice(0, 2) > 23 || +d.slice(2) > 59 ? null : d.slice(0, 2) + ':' + d.slice(2);
    }
    function valorDe(m, rec, col) { var x = m.getValue(rec, col); return x && typeof x === 'object' ? x.v : x; }
    function prepararHoras(v, rid) {
      var rec = v.model.getRecord(rid);
      HORAS.forEach(function (col) {
        var mc = v.modelColumns[col], inp = mc && $id(mc.elementId);
        if (!inp || inp.tagName !== 'INPUT') return;
        var cont = inp.closest('.u-Form-fieldContainer');
        if (!inp.getAttribute('data-nc-hora')) {
          inp.setAttribute('data-nc-hora', '1'); inp.setAttribute('inputmode', 'numeric'); inp.setAttribute('placeholder', '00:00');
          inp.setAttribute('autocomplete', 'off'); inp.maxLength = 5;
          var aviso = el('p', 'nc-hora-aviso', 'Hora inválida. Use de 00:00 a 23:59.'); aviso.hidden = true; if (cont) cont.appendChild(aviso);
          inp.addEventListener('input', function () {
            var d = inp.value.replace(/\D/g, '').slice(0, 4), novo = d.length > 2 ? d.slice(0, 2) + ':' + d.slice(2) : d;
            if (novo !== inp.value) inp.value = novo;
            aviso.hidden = true; if (cont) cont.classList.remove('nc-hora-ruim');
          });
          /* no "change" do próprio campo (antes de a grade ler o valor): completa "930" → "09:30" */
          inp.addEventListener('change', function () {
            var f = fmtHora(inp.value);
            if (f !== null) inp.value = f;
            aviso.hidden = f !== null; if (cont) cont.classList.toggle('nc-hora-ruim', f === null);
          }, true);
        }
        /* o que veio do banco aparece formatado (sem mexer no registro: só muda se ele salvar) */
        var f = rec ? fmtHora(valorDe(v.model, rec, col)) : null;
        if (f && inp.value !== f && document.activeElement !== inp) inp.value = f;
        var av = cont && cont.querySelector('.nc-hora-aviso'); if (av) av.hidden = true; if (cont) cont.classList.remove('nc-hora-ruim');
      });
    }
    /* antes de salvar: false se alguma hora é inválida; senão põe ":" no que estiver sem */
    function horasNoPadrao(v, rid) {
      var m = v.model, rec = m.getRecord(rid), md = rec && m.getRecordMetadata(rid), ok = true;
      if (!rec || (md && md.deleted)) return true;
      HORAS.forEach(function (col) {
        if (!v.modelColumns[col]) return;
        var atual = valorDe(m, rec, col), f = fmtHora(atual);
        if (f === null) { ok = false; var mc = v.modelColumns[col], inp = $id(mc.elementId), cont = inp && inp.closest('.u-Form-fieldContainer'); if (cont) { cont.classList.add('nc-hora-ruim'); var av = cont.querySelector('.nc-hora-aviso'); if (av) av.hidden = false; } return; }
        if (f !== String(atual == null ? '' : atual)) m.setValue(rec, col, f);
      });
      return ok;
    }
    /* CUIDADO: a ficha da grade só passa o valor de um campo para a grade quando o foco vai para
       OUTRO campo dela (Tab); clicar no Salvar da gaveta (fora da ficha) não passa — o último campo
       digitado ficava de fora. Antes de salvar, cada campo da ficha é copiado do formulário. */
    function numeroF(t) { t = String(t == null ? '' : t).trim(); if (!t) return NaN; if (t.indexOf(',') > -1) t = t.replace(/\./g, '').replace(',', '.'); return Number(t); }
    function sincronizarFicha(v, rid, cols) {
      var m = v.model, rec = m.getRecord(rid); if (!rec) return;
      cols.forEach(function (col) {
        var mc = v.modelColumns[col], it; if (!mc) return;
        try { it = apex.item(mc.elementId); } catch (e) { return; }
        if (!it || !it.node || it.node.disabled) return;
        var nv = it.getValue(); if (Array.isArray(nv)) nv = nv.join(':'); nv = nv == null ? '' : String(nv);
        var atual = m.getValue(rec, col), obj = !!atual && typeof atual === 'object', av = obj ? String(atual.v == null ? '' : atual.v) : String(atual == null ? '' : atual);
        if (nv === av) return;
        if (!obj && nv && av && numeroF(nv) === numeroF(av)) return;
        if (obj) { var d = ''; try { d = it.displayValueFor ? it.displayValueFor(nv) : ''; } catch (e) {} m.setValue(rec, col, { v: nv, d: d || nv }); }
        else m.setValue(rec, col, nv);
      });
    }
    function fecharComCuidado() {
      if (!EDIT || EDIT.ocupado) return;
      var mudou = false; try { mudou = EDIT.v.model.isChanged(); } catch (x) { /* ok */ }
      if (!mudou) return fecharFicha(true);
      apex.message.confirm('Descartar o que foi preenchido?', function (ok) { if (ok) fecharFicha(true); });
    }
    function fecharFicha(desfazer) {
      if (!EDIT) return;
      var e = EDIT, m = e.v.model;
      /* desfazer: linha NOVA sai da grade (revertRecords não a tira, no APEX 19.2); linha que já
         existia volta ao que estava gravado */
      if (desfazer) {
        try {
          var r = m.getRecord(e.rid), md = r && m.getRecordMetadata(e.rid);
          if (r) { if (md && md.inserted) m.deleteRecords([r]); else m.revertRecords([r]); }
        } catch (x) { /* ok */ }
      }
      try { e.acoes.invoke('close-single-row-view'); } catch (x) { /* ok */ }
      try { if (!m.isChanged()) e.acoes.set('edit', false); } catch (x) { /* ok */ }
      e.g.reg.classList.remove('nc-hc-motor');
      if (e.lugar.parentNode) { e.lugar.parentNode.insertBefore(e.g.reg, e.lugar); e.lugar.parentNode.removeChild(e.lugar); }
      document.body.classList.remove('nc-hc-editando');
      EDIT = null;
      atualizar();
      if (e.volta && document.body.contains(e.volta)) e.volta.focus();
    }
    /* Salvar: o salvar da grade. Sem pedido ao servidor logo depois (a grade barrou por campo
       obrigatório ou inválido, e já marcou o campo), a gaveta destrava e avisa. */
    function salvarFicha(oQue) {
      if (!EDIT || EDIT.ocupado) return;
      /* 04/10: o último campo mexido dispara as ações dinâmicas da coluna (motivo → descrição,
         término → dias) ao sair dele — o clique no Salvar. Espera essas chamadas voltarem (até
         6 s) antes de copiar a ficha e salvar, senão o valor que a ação traz fica de fora. */
      if ($.active > 0 && (!EDIT.espera || Date.now() - EDIT.espera < 6000)) {
        var e0 = EDIT; if (!e0.espera) e0.espera = Date.now();
        return setTimeout(function () { if (EDIT === e0) salvarFicha(oQue); }, 80);
      }
      EDIT.espera = 0;
      var e = EDIT, m = e.v.model;
      if (oQue !== 'excluido') sincronizarFicha(e.v, e.rid, FICHAS[e.tipo].filter(function (f) { return f.length; }).map(function (f) { return f[0]; }));
      if (!m.isChanged()) return fecharFicha(false);
      if (oQue !== 'excluido' && e.tipo === 'atestado' && !horasNoPadrao(e.v, e.rid)) return avisar('Confira a hora: use de 00:00 a 23:59.', true);
      e.ocupado = true; e.oQue = oQue || (e.novo ? 'salvo' : 'atualizado'); ocupado(true);
      try { e.acoes.invoke('save'); } catch (x) { e.ocupado = false; ocupado(false); return avisar('Não foi possível salvar. Tente de novo.', true); }
      setTimeout(function () {
        if (EDIT !== e || !e.ocupado || $.active > 0) return;
        if (!m.isChanged()) return;   /* já gravou: o aviso vem pelo evento da grade */
        e.ocupado = false; ocupado(false);
        avisar('Confira os campos destacados antes de salvar.', true);
      }, 400);
    }
    function excluirFicha() {
      if (!EDIT || EDIT.ocupado) return;
      var e = EDIT;
      apex.message.confirm('Excluir este ' + (e.tipo === 'doenca' ? 'registro de doença' : TIPOS[e.tipo].um.toLowerCase()) + '? Depois de excluir não dá para desfazer.', function (ok) {
        if (!ok || EDIT !== e) return;
        try { var r = e.v.model.getRecord(e.rid); e.v.model.deleteRecords([r]); } catch (x) { return avisar('Não foi possível excluir.', true); }
        salvarFicha('excluido');
      });
    }
    function ocupado(sim) {
      if (!GAV) return;
      GAV.caixa.classList.toggle('is-ocupada', sim);
      [].forEach.call(GAV.pe.querySelectorAll('button'), function (b) { b.disabled = sim; });
    }
    /* CUIDADO: a grade dispara "interactivegridsave" também quando a gravação FALHA (com status
       de erro). Só é sucesso com status ok E sem nada pendente no modelo. */
    $(document).on('interactivegridsave', function (ev, data) {
      if (!EDIT || !EDIT.ocupado || !EDIT.g.reg.contains(ev.target)) return;
      var e = EDIT, fem = e.tipo === 'doenca', fim = { excluido: 'excluíd', salvo: 'lançad', atualizado: 'atualizad' }[e.oQue] || 'salv';
      var ok = (!data || data.status === undefined || data.status === 'success') && !e.v.model.isChanged();
      e.ocupado = false; ocupado(false);
      if (!ok) return avisar('Não foi possível salvar. Confira a mensagem e tente de novo.', true);
      avisar(TIPOS[e.tipo].um + ' ' + fim + (fem ? 'a' : 'o'));
      fecharFicha(false);
    });
    /* erro do servidor (validação da página, banco): a gaveta destrava e fica aberta */
    $(document).on('apexerror', function () { if (EDIT && EDIT.ocupado) { EDIT.ocupado = false; ocupado(false); } });

    var toast = el('div', 'nc-hc-aviso'); toast.setAttribute('role', 'status'); toast.setAttribute('aria-live', 'polite');
    document.body.appendChild(toast);
    var tAviso = null;
    function avisar(t, erro) {
      toast.innerHTML = (erro ? '' : ic('check')) + '<span>' + esc(t) + '</span>';
      toast.classList.toggle('is-erro', !!erro); toast.classList.add('is-visivel');
      clearTimeout(tAviso); tAviso = setTimeout(function () { toast.classList.remove('is-visivel'); }, 3600);
    }

    /* ═══ [H10] O MAESTRO═════════════════════════════════════════════════════════════════ */
    function atualizar() { try { TODOS = registros(); desenharLado(TODOS); desenharTempo(); } catch (x) { if (window.console) console.warn('Natcorp_HistoricoColaborador', x); } }
    desenharPaciente(); lugarPaciente();
    if (estreito && estreito.addEventListener) estreito.addEventListener('change', lugarPaciente);
    atualizar();
    var t0 = null, refaz = function () { clearTimeout(t0); t0 = setTimeout(function () { if (!EDIT && !document.body.classList.contains('nc-hc-tabelas')) atualizar(); }, 120); };
    $(document).on('apexafterrefresh interactivegridsave', refaz);
    [].forEach.call(abas.querySelectorAll('.a-IG'), function (e) { try { $(e).interactiveGrid('getViews', 'grid').model.subscribe({ onChange: refaz }); } catch (x) { /* ok */ } });
  }

  $(window).on('apexreadyend', function () { setTimeout(iniciar, 0); });
  if (document.readyState === 'complete') setTimeout(iniciar, 300);
  else window.addEventListener('load', function () { setTimeout(iniciar, 300); });
})();
