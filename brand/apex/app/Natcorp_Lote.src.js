/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · AJUSTAR VÁRIOS DIAS  —  a tela da página 715 (JavaScript)                      ║
   ║  App 9503 · Página 715 (janela aberta pelo botão "Ajustar vários dias" da 203)            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: LOTE-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Pedido do cliente (08/10): o operador faz ~30 ajustes por colaborador e tem 30 colaboradores —
   900 janelas abertas, uma a uma, na 714. Aqui ele vê TODOS os dias do período de UM colaborador
   numa FOLHA DE PONTO (uma linha por dia, as posições em colunas), muda os horários que precisar
   e toca em "Salvar" UMA vez. O servidor cria UM PEDIDO DE AJUSTE POR HORÁRIO MUDADO — o mesmo
   pedido que a janela 714 cria, com as mesmas validações (processo NC_LOTE_CRIAR).
     1. A FOLHA: cada linha é um dia; cada coluna, uma posição (1ª, 2ª…). Na caixa vazia o horário
        PREVISTO aparece em cinza. Digita-se "0900" (ou "9", "930", "9:30") e vira 09:00.
     2. O TECLADO de planilha: Enter numa caixa vazia usa o previsto e desce para o dia seguinte;
        Enter numa caixa cheia só desce; ↑ ↓ andam na coluna; ← → andam na linha (no começo/fim
        do texto); Esc volta ao que era. A caixa mudada fica roxa: é um pedido que vai ser criado.
     3. ATALHOS na barra de cima: "Preencher previstos" (o que falta nos dias com problema; a
        seta ao lado tem as outras formas), motivo e observação para todos, "Desfazer tudo".
        No fim de cada linha: preencher o dia, desfazer o dia e "outro motivo" para aquele dia.
     4. FILTROS: Com problema · Todos os dias · Alterados.
     5. "Salvar" envia aos poucos (4 por vez, com a barra andando) e, no fim, mostra o que foi
        criado (caixa verde) e o que não pôde (vermelha, com a mensagem do sistema numa linha logo
        abaixo do dia). O que falhou continua marcado para corrigir e salvar de novo.
     6. "Concluir" fecha a janela e a 203 atualiza a grade (ação que a região já tem).

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não apaga marcação nem envia marcação para outra posição, não anexa comprovante e não
       replica por N dias: isso continua na janela de um horário (714), que NÃO foi mexida.
       Apagar o texto de uma caixa que tinha marcação só volta ao que era.
     • Não decide nada sozinho: os atalhos só PREENCHEM as caixas; nada é criado sem "Salvar".

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 715 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Lote.js
     Página 715 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Lote.css
   O COMBINADO com a página: a div #nc-lote (região Static ID nc_lote) e os processos Ajax
   Callback NC_LOTE_DIAS e NC_LOTE_CRIAR (gerados por gerar-pagina715.py).

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [J1] Textos e ferramentas ............ frases da tela, ícones, leitura do horário PODE MEXER
     [J2] Os dados ........................ leitura (NC_LOTE_DIAS) e a grade da 203   CUIDADO
     [J3] Os atalhos ...................... previsto, desfazer                       PODE MEXER
     [J4] O desenho ....................... barra, filtros, a folha, rodapé           PODE MEXER
     [J5] O teclado e as caixas ........... digitar, Enter, setas, Esc                 CUIDADO
     [J6] Salvar .......................... envio aos poucos e o resultado            CUIDADO
     [J7] O maestro ....................... quando cada parte roda                    CUIDADO
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncLote || !window.apex || !window.apex.server) return;
  var RAIZ = document.getElementById('nc-lote');
  if (!RAIZ) return;
  window.__ncLote = true;

  /* ═══ [J1] TEXTOS E FERRAMENTAS ═════════════════════════════════════════════════════════
     PODE MEXER os textos entre aspas. CUIDADO com os nomes à esquerda dos dois-pontos.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var SEMANA = ['', 'seg', 'ter', 'qua', 'qui', 'sex', 'sáb', 'dom'];
  var LOTE = 4;   /* quantos pedidos vão ao servidor por vez (a barra anda a cada lote) */
  var ERROS = {
    acesso: 'Você não tem acesso a este colaborador.',
    bloqueado: 'O seu perfil não pode criar ajustes de marcação.'
  };
  var FORMAS = [
    { id: 'faltas', rot: 'O que falta nos dias com problema', dica: 'As posições vazias recebem o previsto do dia' },
    { id: 'diferentes', rot: 'Dias com problema, trocando o que está diferente', dica: 'Também troca a marcação que não bate com o previsto' },
    { id: 'faltasTudo', rot: 'O que falta em todos os dias de trabalho', dica: 'Todas as posições vazias do período' }
  ];
  var IC = {
    varinha: '<path d="M4 20l11-11M14 4v3M18.5 5.5l-2 2M20 10h-3M9.5 4.5l1 2"/>',
    desfaz: '<path d="M9 7H5V3"/><path d="M5.5 7A8 8 0 1 1 4 13"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    alerta: '<path d="M12 3.5l9.5 16.5h-19z"/><path d="M12 10v4.5M12 17.2v.1"/>',
    baixo: '<path d="M6 9l6 6 6-6"/>',
    salvar: '<path d="M5 4h11l3 3v13H5z"/><path d="M8 4v5h7V4M8 20v-6h8v6"/>',
    cadeado: '<rect x="5.5" y="10.5" width="13" height="9.5" rx="2"/><path d="M8.5 10.5V8a3.5 3.5 0 0 1 7 0v2.5"/>',
    balao: '<path d="M4.5 5.5h15v10h-8l-4 3.5v-3.5h-3z"/>',
    nota: '<path d="M5 19.5l1-4L16.5 5a2 2 0 0 1 3 3L9 18.5z"/>'
  };
  function svg(d) { return '<svg class="nc-lt-ic" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function hm(t) { var m = /^(\d{1,2}):(\d{2})/.exec(t || ''); return m ? (m[1].length < 2 ? '0' : '') + m[1] + ':' + m[2] : ''; }
  function plural(n, um, varios) { return n + ' ' + (n === 1 ? um : varios); }
  function hoje() { var d = new Date(); d.setHours(0, 0, 0, 0); return d; }
  function data(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  /* PODE MEXER (com cuidado): como o que se digita vira horário.
     "9" → 09:00 · "930" → 09:30 · "0930" / "9:30" / "9h30" → 09:30. Devolve '' (vazio) ou null (inválido). */
  function lerHora(t) {
    t = String(t || '').trim().toLowerCase();
    if (!t) return '';
    var h, m, x = /^(\d{1,2})\s*[:h.,]\s*(\d{1,2})?$/.exec(t);
    if (x) { h = +x[1]; m = x[2] ? +x[2] : 0; }
    else if (/^\d{1,4}$/.test(t)) {
      if (t.length <= 2) { h = +t; m = 0; }
      else { h = +t.slice(0, t.length - 2); m = +t.slice(-2); }
    } else return null;
    if (h > 23 || m > 59) return null;
    return (h < 10 ? '0' : '') + h + ':' + (m < 10 ? '0' : '') + m;
  }

  /* ═══ [J2] OS DADOS ═════════════════════════════════════════════════════════════════════
     O QUE É    D.dias = os dias do período, cada um com as posições da jornada:
                  { p: posição, prev: previsto, atual: horário de hoje (abono ou marcação),
                    novo: o que a pessoa escreveu (null = não mexeu), invalido: escreveu algo que
                    não é horário, trava: 'pedido aberto' | 'criado', erro: mensagem do servidor }
                A situação do dia ("Com problema") vem da grade da 203 que abriu esta janela
                (vermelho/amarelo, a mesma cor que a pessoa via). Se a grade não estiver ao
                alcance, vale a conta daqui: posição sem horário num dia que já passou.
     CUIDADO    os nomes que o servidor manda (d, w, pos, p, prev, real, abono, pend) vêm do
                NC_LOTE_DIAS.plsql.sql: mudar lá = mudar aqui.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var D = null, FILTRO = 'problema', MOTIVO = '', OBS = '', SALVANDO = null, RESULT = null, COLS = 0;

  /* a grade de marcações da 203 (a janela nasce dentro dela): data → { posição: cor } */
  function lerGrade203() {
    var mapa = {};
    try {
      var doc = window.parent && window.parent !== window ? window.parent.document : null;
      var reg = doc && doc.getElementById('marcacao');
      if (!reg) return null;
      [].forEach.call(reg.querySelectorAll('tr'), function (tr) {
        var tds = tr.querySelectorAll('td'); if (tds.length < 4) return;
        var dt = (tds[1].textContent || '').trim(); if (!/^\d{2}\/\d{2}\/\d{4}$/.test(dt)) return;
        var cores = {};
        [].slice.call(tds, 3).forEach(function (td, k) {
          var a = td.querySelector('a.t-Button'); if (!a) return;
          var m = /t-Button--(hot|danger|warning|primary)/.exec(a.className);
          cores[k + 1] = m ? m[1] : 'primary';
        });
        mapa[dt] = cores;
      });
      return Object.keys(mapa).length ? mapa : null;
    } catch (e) { return null; }
  }

  function preparar(r) {
    var grade = lerGrade203(), lim = hoje();
    D = { nome: r.nome || '', mat: r.matricula, inicio: r.inicio, fim: r.fim, motivos: r.motivos || [], dias: [], grade: !!grade };
    (r.dias || []).forEach(function (x) {
      var cores = grade && grade[x.d] || {};
      var dia = { d: x.d, w: x.w, feriado: x.feriado === 'S', motivo: '', outroMotivo: false, pos: [] };
      (x.pos || []).forEach(function (p) {
        dia.pos.push({ p: +p.p, prev: hm(p.prev), real: hm(p.real), abono: hm(p.abono), atual: hm(p.abono) || hm(p.real),
          novo: null, invalido: false, trava: p.pend ? 'pedido aberto' : '', cor: cores[p.p] || '', erro: '', req: null });
      });
      var passou = data(x.d) && data(x.d) <= lim;
      dia.problema = dia.pos.length > 0 && (grade
        ? dia.pos.some(function (p) { return p.cor === 'danger' || p.cor === 'warning'; })
        : passou && dia.pos.some(function (p) { return !p.atual && !p.trava; }));
      D.dias.push(dia);
      dia.pos.forEach(function (p) { COLS = Math.max(COLS, p.p); });
    });
    if (!D.dias.some(function (d) { return d.problema; })) FILTRO = 'todos';
  }

  function mudou(p) { return p.novo !== null && p.novo !== '' && !p.invalido && p.novo !== p.atual && !p.trava; }
  function mudancas() {
    var out = [];
    D.dias.forEach(function (d) { d.pos.forEach(function (p) { if (mudou(p)) out.push({ d: d, p: p }); }); });
    return out;
  }
  function invalidos() { var n = 0; D.dias.forEach(function (d) { d.pos.forEach(function (p) { if (p.invalido) n++; }); }); return n; }
  function posDe(d, n) { return d.pos.filter(function (p) { return p.p === n; })[0] || null; }
  function motivoDe(d) { return (d.outroMotivo && d.motivo) || MOTIVO; }
  function nomeMotivo(c) { var m = D.motivos.filter(function (x) { return x.c === c; })[0]; return m ? m.n : ''; }
  function pedeComprovante(c) { return D.motivos.some(function (x) { return x.c === c && x.comprov === 'S'; }); }

  /* ═══ [J3] OS ATALHOS ═══════════════════════════════════════════════════════════════════
     O QUE FAZ  Preenchem as caixas — nada é criado sem "Salvar".
                previsto(modo):  'faltas'     → o que está vazio, nos dias com problema
                                 'faltasTudo' → o que está vazio, em todos os dias de trabalho
                                 'diferentes' → também troca o horário marcado que não bate com o
                                                previsto, nos dias com problema
     PODE MEXER os textos das formas em FORMAS ([J1]).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function previstoNoDia(d, trocarDiferentes) {
    d.pos.forEach(function (p) {
      if (p.trava || !p.prev) return;
      if (!p.atual || (trocarDiferentes && p.atual !== p.prev)) { p.novo = p.prev; p.invalido = false; }
    });
  }
  function previsto(modo) {
    D.dias.forEach(function (d) {
      if (!d.pos.length) return;
      if (modo === 'faltasTudo') previstoNoDia(d, false);
      else if (d.problema) previstoNoDia(d, modo === 'diferentes');
    });
    if (FILTRO === 'problema' && modo === 'faltasTudo') FILTRO = 'alterados';
  }
  function desfazerDia(d) { d.pos.forEach(function (p) { if (!p.trava) { p.novo = null; p.invalido = false; p.erro = ''; } }); d.outroMotivo = false; d.motivo = ''; }
  function desfazerTudo() { D.dias.forEach(desfazerDia); }

  /* ═══ [J4] O DESENHO ════════════════════════════════════════════════════════════════════
     O QUE FAZ  A barra de cima (quem, ferramentas, filtros), a folha (uma linha por dia, uma
                coluna por posição, ações no fim da linha) e o rodapé (o que vai ser criado e
                Salvar). A barra e o cabeçalho das colunas ficam presos no alto ao rolar.
     PODE MEXER textos, a ordem das ferramentas, as frases do rodapé.
     VISUAL     Natcorp_Lote.css
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function opcoesMotivo(sel, vazio) {
    return '<option value="">' + esc(vazio) + '</option>' + D.motivos.map(function (m) {
      return '<option value="' + esc(m.c) + '"' + (m.c === sel ? ' selected' : '') + '>' + esc(m.n) + (m.comprov === 'S' ? ' (pede comprovante)' : '') + '</option>';
    }).join('');
  }
  function montar() {
    var cab = '<th scope="col" class="nc-lt-th-dia">Dia</th>';
    for (var k = 1; k <= COLS; k++) cab += '<th scope="col" class="nc-lt-th-pos">' + k + 'ª</th>';
    cab += '<th scope="col" class="nc-lt-th-acoes"><span class="nc-lt-vis">Ações do dia</span></th>';
    RAIZ.innerHTML =
      '<header class="nc-lt-cab">' +
        '<div class="nc-lt-quem"><h2>' + esc(D.mat + (D.nome ? ' - ' + D.nome : '')) + '</h2><span>' + esc(D.inicio + ' a ' + D.fim) + '</span></div>' +
        '<div class="nc-lt-ferr">' +
          '<div class="nc-lt-split">' +
            '<button type="button" class="nc-lt-bt nc-lt-bt--forte" data-prev="faltas" title="' + esc(FORMAS[0].dica) + '">' + svg(IC.varinha) + '<span>Preencher previstos</span></button>' +
            '<button type="button" class="nc-lt-bt nc-lt-bt--forte nc-lt-split-seta" data-abre aria-expanded="false" aria-haspopup="menu" aria-label="Outras formas de preencher">' + svg(IC.baixo) + '</button>' +
            '<div class="nc-lt-menu" role="menu" hidden>' + FORMAS.map(function (f) {
              return '<button type="button" role="menuitem" data-prev="' + f.id + '"><b>' + esc(f.rot) + '</b><small>' + esc(f.dica) + '</small></button>';
            }).join('') + '</div>' +
          '</div>' +
          '<label class="nc-lt-f nc-lt-f--motivo"><span>Motivo</span><select data-motivo-geral>' + opcoesMotivo(MOTIVO, 'Escolha o motivo de todos') + '</select></label>' +
          '<label class="nc-lt-f nc-lt-f--obs"><span>Observação</span><input type="text" maxlength="4000" data-obs value="' + esc(OBS) + '" placeholder="Para todos (se quiser)"></label>' +
          '<button type="button" class="nc-lt-bt nc-lt-bt--sem nc-lt-obs-abre" data-obs-abre>' + svg(IC.nota) + '<span>Observação</span></button>' +
          '<button type="button" class="nc-lt-bt nc-lt-bt--sem" data-desfaz-tudo title="Volta todas as caixas ao que eram">' + svg(IC.desfaz) + '<span>Desfazer tudo</span></button>' +
        '</div>' +
        '<div class="nc-lt-l3"><div class="nc-lt-filtros" role="tablist" aria-label="Mostrar dias"></div>' +
          '<p class="nc-lt-dica">Digite <kbd>0900</kbd> e vira 09:00 · <kbd>Enter</kbd> na caixa vazia usa o previsto e desce · <kbd>↑</kbd><kbd>↓</kbd> andam na coluna</p></div>' +
      '</header>' +
      '<div class="nc-lt-aviso" role="status" hidden></div>' +
      '<div class="nc-lt-folha"><table class="nc-lt-grade"><thead><tr>' + cab + '</tr></thead><tbody></tbody></table></div>' +
      '<footer class="nc-lt-pe"><div class="nc-lt-barra" hidden><i></i></div><p class="nc-lt-resumo" aria-live="polite"></p><div class="nc-lt-pe-bts">' +
        '<button type="button" class="nc-lt-bt nc-lt-bt--sem" data-fechar>Cancelar</button>' +
        '<button type="button" class="nc-lt-bt nc-lt-bt--salvar" data-salvar>' + svg(IC.salvar) + '<span>Salvar</span></button>' +
      '</div></footer>';
    RAIZ.addEventListener('click', clique);
    RAIZ.addEventListener('input', digitou);
    RAIZ.addEventListener('change', mudouCampo);
    RAIZ.addEventListener('keydown', tecla);
    RAIZ.addEventListener('focusin', function (e) { if (e.target.matches('.nc-lt-h')) setTimeout(function () { try { e.target.select(); } catch (x) {} }, 0); });
    RAIZ.addEventListener('focusout', function (e) { if (e.target.matches('.nc-lt-h')) confirmar(e.target, false); });
    document.addEventListener('click', function (e) { if (!e.target.closest('.nc-lt-split')) fecharMenu(); });
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') fecharMenu(); });
    /* o cabeçalho das colunas gruda logo abaixo da barra: mede a altura da barra */
    var barra = RAIZ.querySelector('.nc-lt-cab');
    var medir = function () { RAIZ.style.setProperty('--lt-topo', Math.round(barra.getBoundingClientRect().height) + 'px'); };
    medir();
    if (window.ResizeObserver) new ResizeObserver(medir).observe(barra);
  }
  function fecharMenu() {
    var m = RAIZ.querySelector('.nc-lt-menu'), b = RAIZ.querySelector('[data-abre]');
    if (m && !m.hidden) { m.hidden = true; b.setAttribute('aria-expanded', 'false'); }
  }
  function temAlgo(d) { return d.pos.some(function (p) { return mudou(p) || p.erro || p.req || p.invalido; }); }
  function visivel(d) {
    if (!d.pos.length) return false;
    if (FILTRO === 'alterados') return temAlgo(d);
    if (FILTRO === 'problema') return d.problema || temAlgo(d);
    return true;
  }
  /* a semana ISO do dia (para a linha mais forte entre semanas) */
  function semana(d) { var x = data(d.d); if (!x) return 0; x.setDate(x.getDate() - (d.w - 1)); return x.getTime(); }

  function celula(d, i, p) {
    var muda = mudou(p), val = p.novo !== null ? p.novo : p.atual;
    var cls = ['nc-lt-c'], tit = [], marca = '';
    if (p.req) { cls.push('is-criado'); tit.push('Pedido ' + p.req + ' criado'); marca = svg(IC.ok); }
    else if (p.trava) { cls.push('is-trava'); tit.push('Já tem pedido aberto para este horário'); marca = svg(IC.cadeado); }
    else if (p.invalido) { cls.push('is-invalido'); tit.push('Isto não é um horário: digite como 0900 ou 9:00'); }
    else if (p.erro) { cls.push('is-erro'); tit.push(p.erro); marca = svg(IC.alerta); }
    else if (muda) { cls.push('is-mudou'); tit.push(p.atual ? 'Era ' + p.atual : 'Estava vazio'); }
    else if (p.cor === 'danger' || p.cor === 'warning') cls.push('is-' + p.cor);
    if (!muda && !p.req && p.abono) { cls.push('is-abono'); tit.push('Já ajustada antes'); }
    if (p.prev) tit.push('Previsto ' + p.prev);
    return '<td class="' + cls.join(' ') + '"' + (tit.length ? ' title="' + esc(tit.join(' · ')) + '"' : '') + '>' +
      '<input class="nc-lt-h" type="text" inputmode="numeric" autocomplete="off" spellcheck="false" maxlength="5"' +
        ' value="' + esc(val) + '" placeholder="' + esc(p.prev) + '" data-dia="' + i + '" data-pos="' + p.p + '"' +
        (p.trava ? ' readonly tabindex="-1"' : '') +
        ' aria-label="' + esc(d.d.slice(0, 5) + ', ' + p.p + 'ª marcação' + (p.prev ? ', previsto ' + p.prev : '') + (p.atual ? ', hoje ' + p.atual : ', vazia')) + '"' +
        (p.invalido || p.erro ? ' aria-invalid="true"' : '') + '>' + marca + '</td>';
  }
  function linha(d, i, novaSemana) {
    var muda = d.pos.some(mudou), comp = muda && pedeComprovante(motivoDe(d));
    var cels = '';
    for (var k = 1; k <= COLS; k++) { var p = posDe(d, k); cels += p ? celula(d, i, p) : '<td class="nc-lt-c is-nada" aria-label="sem esta posição"><span aria-hidden="true">–</span></td>'; }
    var acoes = '<button type="button" class="nc-lt-ib" data-prev-dia="' + i + '" title="Preencher este dia com o previsto" aria-label="Preencher ' + esc(d.d.slice(0, 5)) + ' com o previsto">' + svg(IC.varinha) + '</button>' +
      (muda ? '<button type="button" class="nc-lt-ib" data-desfaz-dia="' + i + '" title="Desfazer este dia" aria-label="Desfazer ' + esc(d.d.slice(0, 5)) + '">' + svg(IC.desfaz) + '</button>' : '') +
      (muda ? (d.outroMotivo
        ? '<select class="nc-lt-motivo-dia" data-motivo-dia="' + i + '" aria-label="Motivo de ' + esc(d.d.slice(0, 5)) + '">' + opcoesMotivo(d.motivo, 'O mesmo de todos') + '</select>'
        : '<button type="button" class="nc-lt-ib" data-outro="' + i + '" title="Outro motivo só neste dia" aria-label="Outro motivo em ' + esc(d.d.slice(0, 5)) + '">' + svg(IC.balao) + '</button>') : '');
    var msgs = d.pos.filter(function (p) { return p.erro && !p.req; }).map(function (p) { return '<li><b>' + p.p + 'ª</b> ' + esc(p.erro) + '</li>'; });
    if (comp) msgs.push('<li>Este motivo pede comprovante: faça este dia pela janela do horário (na Tratativa).</li>');
    return '<tr class="nc-lt-l' + (d.problema ? ' is-problema' : '') + (muda ? ' is-mudou' : '') + (novaSemana ? ' is-semana' : '') + '">' +
        '<th scope="row" class="nc-lt-dia"><span class="nc-lt-sem">' + SEMANA[d.w] + '</span> <span class="nc-lt-dt">' + esc(d.d.slice(0, 5)) + '</span>' +
          (d.problema ? '<i class="nc-lt-ponto" title="Com problema na Tratativa"><span class="nc-lt-vis">com problema</span></i>' : '') +
          (d.feriado ? '<em>feriado</em>' : '') + '</th>' +
        cels + '<td class="nc-lt-acoes">' + acoes + '</td></tr>' +
      (msgs.length ? '<tr class="nc-lt-msg"><td colspan="' + (COLS + 2) + '"><ul>' + msgs.join('') + '</ul></td></tr>' : '');
  }
  function desenhar() {
    if (!D) return;
    /* guarda a caixa em foco para devolvê-la depois do redesenho */
    var ativo = document.activeElement, foco = ativo && ativo.matches && ativo.matches('.nc-lt-h') ? [ativo.getAttribute('data-dia'), ativo.getAttribute('data-pos')] : null;
    var n = { problema: 0, todos: 0, alterados: 0 };
    D.dias.forEach(function (d) {
      if (!d.pos.length) return;
      n.todos++;
      if (d.problema) n.problema++;
      if (temAlgo(d)) n.alterados++;
    });
    RAIZ.querySelector('.nc-lt-filtros').innerHTML = [['problema', 'Com problema'], ['todos', 'Todos os dias'], ['alterados', 'Alterados']].map(function (f) {
      return '<button type="button" role="tab" aria-selected="' + (FILTRO === f[0]) + '" data-filtro="' + f[0] + '"' + (f[0] === 'problema' && !n.problema ? ' hidden' : '') + '>' + f[1] + ' <b>' + n[f[0]] + '</b></button>';
    }).join('');
    var ult = null, html = '';
    D.dias.forEach(function (d, i) {
      if (!visivel(d)) return;
      var s = semana(d);
      html += linha(d, i, ult !== null && s !== ult);
      ult = s;
    });
    RAIZ.querySelector('tbody').innerHTML = html || '<tr class="nc-lt-vazio"><td colspan="' + (COLS + 2) + '">' +
      (FILTRO === 'alterados' ? 'Nenhum horário mudado ainda. Digite nas caixas ou use <b>Preencher previstos</b>.' : 'Nenhum dia para mostrar neste filtro.') + '</td></tr>';
    if (foco) { var alvo = caixa(+foco[0], +foco[1]); if (alvo) alvo.focus({ preventScroll: true }); }
    desenharPe();
  }
  function desenharPe() {
    var m = mudancas(), dias = {}, semMotivo = 0, inv = invalidos();
    m.forEach(function (x) { dias[x.d.d] = 1; if (!motivoDe(x.d)) semMotivo++; });
    var nd = Object.keys(dias).length, bt = RAIZ.querySelector('[data-salvar]');
    var res = RAIZ.querySelector('.nc-lt-resumo');
    if (SALVANDO) res.innerHTML = SALVANDO.texto;
    else if (!m.length && !inv) res.innerHTML = '<span class="nc-lt-fraco">Nenhum horário mudado.</span>';
    else res.innerHTML = '<b>' + plural(m.length, 'pedido', 'pedidos') + '</b> <span class="nc-lt-fraco">em ' + plural(nd, 'dia', 'dias') + '</span>' +
      (inv ? ' · <span class="nc-lt-falta">' + plural(inv, 'horário inválido', 'horários inválidos') + '</span>' : '') +
      (semMotivo ? ' · <span class="nc-lt-falta">falta o motivo</span>' : MOTIVO && m.length ? ' · <span class="nc-lt-fraco">' + esc(nomeMotivo(MOTIVO)) + '</span>' : '');
    bt.disabled = !!SALVANDO || !m.length || semMotivo > 0 || inv > 0;
    bt.querySelector('span').textContent = m.length ? 'Salvar ' + plural(m.length, 'pedido', 'pedidos') : 'Salvar';
    var barra = RAIZ.querySelector('.nc-lt-barra');
    barra.hidden = !SALVANDO;
    if (SALVANDO) barra.firstChild.style.transform = 'scaleX(' + (SALVANDO.feito / SALVANDO.total).toFixed(3) + ')';
    var fechar = RAIZ.querySelector('[data-fechar]');
    fechar.textContent = RESULT && RESULT.criados ? 'Concluir' : 'Cancelar';
    fechar.disabled = !!SALVANDO;
    if (RESULT && RESULT.criados) fechar.classList.add('nc-lt-bt--concluir'); else fechar.classList.remove('nc-lt-bt--concluir');
  }
  function aviso(h, tipo) {
    var a = RAIZ.querySelector('.nc-lt-aviso');
    if (!h) { a.hidden = true; return; }
    a.className = 'nc-lt-aviso is-' + (tipo || 'info'); a.innerHTML = h; a.hidden = false;
  }

  function clique(e) {
    var t = e.target, b;
    if ((b = t.closest('[data-abre]'))) { e.stopPropagation(); var m = RAIZ.querySelector('.nc-lt-menu'); m.hidden = !m.hidden; b.setAttribute('aria-expanded', String(!m.hidden)); if (!m.hidden) m.querySelector('button').focus(); return; }
    if ((b = t.closest('[data-prev]'))) { previsto(b.getAttribute('data-prev')); fecharMenu(); desenhar(); return; }
    if ((b = t.closest('[data-filtro]'))) { FILTRO = b.getAttribute('data-filtro'); desenhar(); return; }
    if ((b = t.closest('[data-prev-dia]'))) { previstoNoDia(D.dias[+b.getAttribute('data-prev-dia')], true); desenhar(); return; }
    if ((b = t.closest('[data-desfaz-dia]'))) { desfazerDia(D.dias[+b.getAttribute('data-desfaz-dia')]); desenhar(); return; }
    if ((b = t.closest('[data-outro]'))) { var i = +b.getAttribute('data-outro'); D.dias[i].outroMotivo = true; desenhar(); var s = RAIZ.querySelector('[data-motivo-dia="' + i + '"]'); if (s) s.focus(); return; }
    if (t.closest('[data-obs-abre]')) { RAIZ.classList.add('nc-lt-com-obs'); var o = RAIZ.querySelector('[data-obs]'); if (o) o.focus(); return; }
    if (t.closest('[data-desfaz-tudo]')) { desfazerTudo(); RESULT = null; aviso(''); desenhar(); return; }
    if (t.closest('[data-salvar]')) { salvar(); return; }
    if (t.closest('[data-fechar]')) { fechar(); }
  }
  function mudouCampo(e) {
    var t = e.target;
    if (t.matches('[data-motivo-geral]')) { MOTIVO = t.value; desenhar(); return; }
    if (t.matches('[data-motivo-dia]')) { var d = D.dias[+t.getAttribute('data-motivo-dia')]; d.motivo = t.value; if (!t.value) d.outroMotivo = false; desenhar(); }
  }

  /* ═══ [J5] O TECLADO E AS CAIXAS ════════════════════════════════════════════════════════
     O QUE FAZ  Enquanto se digita, só a cor da caixa e o rodapé mudam (o cursor não sai do
                lugar). Ao sair da caixa (ou com Enter/setas), o texto vira horário (lerHora) e
                a linha é redesenhada. Enter na caixa vazia usa o previsto. Esc volta ao que era.
     CUIDADO    caixa(i, pos) acha a caixa pelo dia e pela posição; as setas pulam os dias que
                não têm aquela posição e as caixas travadas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function caixa(i, pos) { return RAIZ.querySelector('.nc-lt-h[data-dia="' + i + '"][data-pos="' + pos + '"]'); }
  function posDaCaixa(inp) { return posDe(D.dias[+inp.getAttribute('data-dia')], +inp.getAttribute('data-pos')); }
  function digitou(e) {
    var t = e.target;
    if (t.matches('[data-obs]')) { OBS = t.value; return; }
    if (!t.matches('.nc-lt-h')) return;
    var p = posDaCaixa(t); if (!p || p.trava) return;
    var v = lerHora(t.value), td = t.parentNode;
    var vaiMudar = v && v !== p.atual;
    td.classList.toggle('is-mudou', !!vaiMudar && !p.erro);
    td.classList.toggle('is-invalido', v === null && t.value.length >= 3);
  }
  /* o texto da caixa vira horário; volta true se algo mudou */
  function confirmar(inp, redesenhar) {
    var p = posDaCaixa(inp); if (!p || p.trava) return false;
    var antes = p.novo + '|' + p.invalido, v = lerHora(inp.value);
    if (v === '') { p.novo = null; p.invalido = false; }                         /* apagou: volta ao que era */
    else if (v === null) { p.novo = inp.value.trim(); p.invalido = true; }
    else { p.novo = v === p.atual ? null : v; p.invalido = false; }
    if (antes !== p.novo + '|' + p.invalido) { p.erro = ''; if (redesenhar !== false) desenhar(); else desenharSoLinha(); return true; }
    if (!p.invalido) inp.value = p.novo !== null ? p.novo : p.atual;
    return false;
  }
  /* ao sair da caixa com o mouse: redesenha tudo sem roubar o foco do que foi clicado */
  function desenharSoLinha() { setTimeout(desenhar, 0); }
  function vizinho(inp, dLinha, dCol) {
    var i = +inp.getAttribute('data-dia'), pos = +inp.getAttribute('data-pos');
    if (dCol) {
      for (var k = pos + dCol; k >= 1 && k <= COLS; k += dCol) { var c = caixa(i, k); if (c && !c.readOnly) return c; }
      return null;
    }
    var linhas = [].slice.call(RAIZ.querySelectorAll('.nc-lt-h[data-pos="' + pos + '"]:not([readonly])'));
    var j = linhas.indexOf(inp);
    return linhas[j + dLinha] || null;
  }
  function ir(alvo) {
    if (!alvo) return;
    alvo.focus();
    var r = alvo.getBoundingClientRect(), topo = parseInt(getComputedStyle(RAIZ).getPropertyValue('--lt-topo'), 10) || 0;
    if (r.top < topo + 40 || r.bottom > window.innerHeight - 70) alvo.scrollIntoView({ block: 'center' });
  }
  function tecla(e) {
    var t = e.target;
    if (!t.matches('.nc-lt-h')) {
      if (e.key === 'ArrowDown' && t.closest('.nc-lt-menu')) { e.preventDefault(); var nx = t.nextElementSibling || t.parentNode.firstElementChild; nx.focus(); }
      if (e.key === 'ArrowUp' && t.closest('.nc-lt-menu')) { e.preventDefault(); var pv = t.previousElementSibling || t.parentNode.lastElementChild; pv.focus(); }
      return;
    }
    var p = posDaCaixa(t); if (!p) return;
    var i = +t.getAttribute('data-dia'), pos = +t.getAttribute('data-pos');
    var seguir = function (dL, dC) {
      var alvo = vizinho(t, dL, dC), chave = alvo ? [alvo.getAttribute('data-dia'), alvo.getAttribute('data-pos')] : null;
      confirmar(t, true);
      if (chave) ir(caixa(+chave[0], +chave[1])); else { var mesma = caixa(i, pos); if (mesma) mesma.focus(); }
    };
    if (e.key === 'Enter') {
      e.preventDefault();
      if (!t.value.trim() && p.prev && !p.trava) t.value = p.prev;   /* vazia: usa o previsto */
      seguir(e.shiftKey ? -1 : 1, 0);
    } else if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
      e.preventDefault(); seguir(e.key === 'ArrowDown' ? 1 : -1, 0);
    } else if ((e.key === 'ArrowRight' && t.selectionStart === t.value.length && t.selectionEnd === t.value.length) ||
               (e.key === 'ArrowLeft' && t.selectionStart === 0 && t.selectionEnd === 0)) {
      e.preventDefault(); seguir(0, e.key === 'ArrowRight' ? 1 : -1);
    } else if (e.key === 'Escape') {
      e.preventDefault(); e.stopPropagation();
      p.novo = null; p.invalido = false; p.erro = ''; t.value = p.atual; desenhar();
    }
  }

  /* ═══ [J6] SALVAR ═══════════════════════════════════════════════════════════════════════
     O QUE FAZ  Manda os horários mudados ao NC_LOTE_CRIAR em lotes de 4, cada linha
                'dd/mm/aaaa|posição|hh:mm|-|motivo' (o "-" deixa o plantão com a visão da 203).
                O servidor responde um resultado por horário: criado (com o nº do pedido) ou
                não criado (com a mensagem das validações da 714). O criado TRAVA a caixa; o que
                falhou fica marcado com a mensagem logo abaixo do dia, para corrigir e salvar de novo.
     CUIDADO    o formato da linha é o que o NC_LOTE_CRIAR.plsql.sql lê.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function salvar() {
    var m = mudancas(); if (!m.length || SALVANDO || invalidos()) return;
    var fila = m.slice(), total = m.length, feitos = 0, criados = 0, falhas = 0;
    RESULT = null; aviso('');
    function terminar(h, tipo) {
      SALVANDO = null;
      RESULT = { criados: criados, falhas: falhas };
      if (falhas && FILTRO !== 'alterados') FILTRO = 'alterados';
      desenhar();
      if (h) aviso(h, tipo);
    }
    function passo() {
      if (!fila.length) {
        terminar(falhas
          ? svg(IC.alerta) + '<span><b>' + plural(criados, 'pedido criado', 'pedidos criados') + '.</b> ' + plural(falhas, 'horário não pôde', 'horários não puderam') + ' ser criado' + (falhas === 1 ? '' : 's') + ': a mensagem está logo abaixo do dia. Corrija e toque em Salvar de novo.</span>'
          : svg(IC.ok) + '<span><b>' + plural(criados, 'pedido criado', 'pedidos criados') + '.</b> Toque em <b>Concluir</b> para voltar à Tratativa com a lista atualizada.</span>', falhas ? 'alerta' : 'ok');
        return;
      }
      var parte = fila.splice(0, LOTE);
      SALVANDO = { total: total, feito: feitos, texto: '<b>Salvando ' + Math.min(feitos + parte.length, total) + ' de ' + total + '…</b> <span class="nc-lt-fraco">não feche esta janela</span>' };
      desenharPe();
      apex.server.process('NC_LOTE_CRIAR', {
        f01: parte.map(function (x) { return x.d.d + '|' + x.p.p + '|' + x.p.novo + '|-|' + motivoDe(x.d); }),
        x01: MOTIVO, x02: OBS
      }, { dataType: 'json' }).then(function (r) {
        if (r && r.erro) { terminar(svg(IC.alerta) + '<span>' + esc(ERROS[r.erro] || r.erro) + '</span>', 'alerta'); return; }
        (r.itens || []).forEach(function (it, j) {
          var x = parte[j]; if (!x) return;
          if (it.ok) { x.p.req = it.req; x.p.trava = 'criado'; x.p.atual = x.p.novo; x.p.novo = null; x.p.erro = ''; criados++; }
          else { x.p.erro = it.erro || 'Não foi possível criar'; falhas++; }
        });
        feitos += parte.length;
        passo();
      }, function (xhr, status, err) {
        var txt = (xhr && xhr.responseText) || err || status || '';
        terminar(svg(IC.alerta) + '<span>O servidor não respondeu como esperado' + (criados ? ' (' + plural(criados, 'pedido já criado', 'pedidos já criados') + ')' : '') + '. ' +
          (/NC_LOTE_CRIAR|process/i.test(txt) ? 'Confira se a página 715 tem o processo NC_LOTE_CRIAR. ' : '') + 'Tente salvar de novo.</span>', 'alerta');
      });
    }
    passo();
  }
  function fechar() {
    if (SALVANDO) return;
    /* criou algo: fecha "com sucesso" e a 203 atualiza a grade (ação da região Marcações) */
    try {
      if (RESULT && RESULT.criados) apex.navigation.dialog.close(true);
      else apex.navigation.dialog.cancel(true);
    } catch (e) { window.history.back(); }
  }

  /* ═══ [J7] O MAESTRO ════════════════════════════════════════════════════════════════════
     Lê os dias (NC_LOTE_DIAS) e monta a tela. Sem o processo na página, avisa o que falta.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function falha(t) { RAIZ.innerHTML = '<p class="nc-lt-aviso is-alerta">' + svg(IC.alerta) + '<span>' + esc(t) + '</span></p>'; }
  function iniciar() {
    apex.server.process('NC_LOTE_DIAS', {}, { dataType: 'json' }).then(function (r) {
      if (!r || r.erro) { falha('Não foi possível ler os dias: ' + ((r && r.erro) || 'resposta vazia')); return; }
      if (!r.acesso) { falha(ERROS.acesso); return; }
      if (r.bloqueado) { falha(ERROS.bloqueado); return; }
      preparar(r);
      if (!COLS) { falha('Não há dias de trabalho neste período.'); return; }
      montar();
      desenhar();
      if (!D.grade) aviso(svg(IC.alerta) + '<span>"Com problema" aqui é a posição sem horário em dia que já passou. Confira com a grade da Tratativa.</span>', 'info');
    }, function () {
      falha('Não foi possível ler os dias. Confira se a página 715 tem o processo NC_LOTE_DIAS.');
    });
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', iniciar);
  else iniciar();
})();
