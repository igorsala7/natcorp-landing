/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CURSOS DO CARGO  —  o "arrumador" da página (JavaScript)                      ║
   ║  App 300 (Portal do Colaborador) · Página 90 · Cursos Realizados                         ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: CURSOS-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   O colaborador abre esta página para saber UMA coisa: "eu tenho o que o meu cargo pede?".
   A página original mostrava três listas soltas (Exigidos, do Colaborador, à Realizar) e a
   pessoa tinha de cruzar as três de cabeça. Agora:
     • no alto, a RESPOSTA: "Falta 1 curso" / "Você tem tudo o que o seu cargo pede", com uma
       trilha de um passo por curso (cheio = feito) e "Ouvir" (o celular lê em voz alta);
     • "Cursos que o seu cargo pede": UMA lista, com a situação escrita em cada linha —
       "Falta fazer" primeiro, "Feito" depois;
     • "O seu estudo": o que o cargo pede × o que você tem;
     • "Outros cursos que você já fez": os que não são do cargo, recolhidos;
     • "Ver tabela completa" mostra as listas originais, como sempre foram.

   ── DE ONDE VÊM OS DADOS ──────────────────────────────────────────────────────────────────
     Do processo Ajax Callback NC_CURSOS_DADOS desta página (posto pelo aplicar-cursos-app300.py):
     as MESMAS consultas das três listas (curso_cargo pelo cargo + centro de custo, curriculum_v
     com ind_conclusao = 'S') numa resposta só, o nome do cargo e o estudo (pc_parametro_formacao
     × inf_pessoais, as duas na tabela instrucao). Sem o processo (página não importada): o
     desenho lê as três listas da própria página (até 15 linhas cada, o tamanho da página delas).

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada. O cartão do colaborador é a peça global (Natcorp_Colab).

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 90 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Cursos.js
     Página 90 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Cursos.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [K1] Como a página é reconhecida                                      CUIDADO
     [K2] Os textos                                                        PODE MEXER
     [K3] Ferramentas (nomes, códigos)
     [K4] Os dados: o processo, ou as listas da página                     CUIDADO
     [K5] Desenhar: a resposta, a lista do cargo, o estudo, os outros
     [K6] Ouvir
     [K7] O maestro
*/
(function () {
  'use strict';
  if (window.__ncCursos || !window.apex || !window.apex.jQuery) return;

  /* ═══ [K1] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════════
     O QUE FAZ  Continua só se a página tiver o item do estudo (…_VA_INSTR1) e as três listas
                pelos títulos "Cursos Exigidos", "Cursos do Colaborador" e "Cursos à Realizar".
     CUIDADO    Renomear essas regiões no APEX desliga o desenho (volta a página de sempre).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var INSTR = document.querySelector('[id$="_VA_INSTR1"]');
  if (!INSTR || !/^P\d+_VA_INSTR1$/.test(INSTR.id)) return;
  var P = INSTR.id.replace(/VA_INSTR1$/, '');
  function regiao(re) {
    var t = [].filter.call(document.querySelectorAll('.t-Region-title, .t-Report-colHead, h2'), function (h) { return re.test(h.textContent.trim()); })[0];
    return t && t.closest('.t-IRR-region, .t-Region');
  }
  var R_EXIG = regiao(/^cursos exigidos$/i), R_COLAB = regiao(/^cursos do colaborador$/i), R_FALTA = regiao(/^cursos [àa] realizar$/i);
  if (!R_EXIG || !R_COLAB || !R_FALTA) return;
  window.__ncCursos = true;
  var $ = window.apex.jQuery;
  var PROCESSO = 'NC_CURSOS_DADOS';

  /* ═══ [K2] OS TEXTOS ═════════════════════════════════════════════════════════════════════
     PODE MEXER  tudo entre aspas. Frases curtas: quem lê, lê com dificuldade.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T = {
    titulo: 'O que o seu cargo pede',
    cargo: 'Seu cargo',
    falta: function (n) { return n === 1 ? 'Falta 1 curso' : 'Faltam ' + n + ' cursos'; },
    faltaEstudo: 'Falta o estudo que o seu cargo pede',
    tudo: 'Você tem tudo o que o seu cargo pede',
    nada: 'O seu cargo não pede cursos',
    jaFez: function (f, n) { return 'Você já fez <b>' + f + '</b> de <b>' + n + '</b> ' + (n === 1 ? 'curso' : 'cursos') + ' que o seu cargo pede.'; },
    fezTodos: function (n) { return n === 1 ? 'Você fez o curso que o seu cargo pede.' : 'Você fez os ' + n + ' cursos que o seu cargo pede.'; },
    nadaDica: 'Não há curso obrigatório cadastrado para o seu cargo.',
    estudoAbaixoDica: 'O seu estudo está abaixo do que o cargo pede.',
    oQueFazer: 'Para fazer o que falta, fale com o seu líder ou com o RH.',
    lista: 'Cursos que o seu cargo pede',
    listaVazia: 'Nenhum curso obrigatório para o seu cargo.',
    feito: 'Feito',
    faltaFazer: 'Falta fazer',
    cod: 'Código',
    estudo: 'O seu estudo',
    estudoPede: 'O cargo pede',
    estudoTem: 'Você tem',
    estudoSemPedido: 'Nenhum estudo mínimo',
    estudoSemDado: 'Não informado',
    estudoOk: 'Atende',
    estudoAbaixo: 'Abaixo do pedido',
    outros: 'Outros cursos que você já fez',
    outrosDica: 'Cursos que você concluiu e que não são pedidos pelo seu cargo.',
    nenhumOutro: 'Nenhum outro curso concluído.',
    itens: function (n) { return n === 1 ? '1 curso' : n + ' cursos'; },
    parcial: 'A página mostra até 15 cursos por lista. Para ver todos, toque em "Ver tabela completa".',
    carregando: 'Buscando os seus cursos…',
    erro: 'Não foi possível mostrar os seus cursos agora.',
    erroDica: 'Toque em "Ver tabela completa" para ver as listas.',
    verTabela: 'Ver tabela completa',
    esconderTabela: 'Esconder tabela completa',
    ouvir: 'Ouvir',
    parar: 'Parar'
  };

  /* ═══ [K3] FERRAMENTAS (NOMES, CÓDIGOS) ══════════════════════════════════════════════════ */
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/\s+/g, ' ').trim(); }
  function sem(t) { return String(t || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  function maiuscula(t) { return t.charAt(0).toUpperCase() + t.slice(1); }
  /* os nomes do cadastro vêm sem acento e com Toda Palavra Maiúscula: "Tecnicas De Boas Praticas" */
  var ACENTOS = { tecnicas: 'técnicas', tecnica: 'técnica', praticas: 'práticas', pratica: 'prática', ingles: 'inglês', espanhol: 'espanhol',
    integracao: 'integração', padrao: 'padrão', seguranca: 'segurança', manipulacao: 'manipulação', saude: 'saúde', basico: 'básico',
    basica: 'básica', medio: 'médio', tecnico: 'técnico', superior: 'superior', graduacao: 'graduação', pos: 'pós', formacao: 'formação',
    educacao: 'educação', informatica: 'informática', lideranca: 'liderança', gestao: 'gestão', operacao: 'operação', prevencao: 'prevenção',
    combate: 'combate', incendio: 'incêndio', eletrica: 'elétrica', eletricidade: 'eletricidade', primeiros: 'primeiros', socorros: 'socorros',
    higiene: 'higiene', acougue: 'açougue', padaria: 'padaria', comunicacao: 'comunicação', excelencia: 'excelência', reciclagem: 'reciclagem',
    conducao: 'condução', veiculos: 'veículos', maquinas: 'máquinas', nivel: 'nível', area: 'área', avancado: 'avançado' };
  var MINUSCULAS = { de: 1, da: 1, do: 1, das: 1, dos: 1, e: 1, em: 1, na: 1, no: 1, nas: 1, nos: 1, a: 1, o: 1, ao: 1, aos: 1, as: 1, os: 1, para: 1, com: 1, por: 1 };
  var SIGLAS = { nr: 'NR', epi: 'EPI', epis: 'EPIs', cipa: 'CIPA', mg: 'MG', sp: 'SP', rj: 'RJ', rh: 'RH', ti: 'TI', sesmt: 'SESMT', ppra: 'PPRA', pcmso: 'PCMSO' };
  function nome(t) {
    var k = 0;
    return maiuscula(limpo(t).replace(/[A-Za-zÀ-ú]+/g, function (w) {
      var l = w.toLowerCase(), primeira = k++ === 0;
      if (SIGLAS[l]) return SIGLAS[l];
      if (!primeira && MINUSCULAS[l]) return l;
      var a = ACENTOS[l] || l;
      return primeira || w.charAt(0) === w.charAt(0).toUpperCase() ? maiuscula(a) : a;
    }));
  }
  /* "07 - Ensino Médio Completo." → { cod: '07', nome: 'Ensino médio completo' } */
  function codNome(t) {
    var s = limpo(t).replace(/\.$/, ''), m = s.match(/^(\S+)\s+-\s+(.*)$/);
    if (!s || s === '-') return null;
    return m ? { cod: m[1], nome: m[2] } : { cod: '', nome: s };
  }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-cu-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  var IC = {
    ok: '<path d="M5.5 12.5l4 4 9-9.5"/>',
    falta: '<circle cx="12" cy="12" r="7.5"/><path d="M12 8.5V12l2.5 1.5"/>',
    vazio: '<rect x="4.5" y="4.5" width="15" height="15" rx="3.5"/><path d="M8.5 12h7"/>',
    livro: '<path d="M4.5 5.5A1.5 1.5 0 0 1 6 4h5.5v15.5H6a1.5 1.5 0 0 1-1.5-1.5z"/><path d="M19.5 5.5A1.5 1.5 0 0 0 18 4h-5.5v15.5H18a1.5 1.5 0 0 0 1.5-1.5z"/>',
    estudo: '<path d="M2.5 9.5L12 5l9.5 4.5L12 14z"/><path d="M6.5 11.5v4.5c1.5 1.3 3.4 2 5.5 2s4-.7 5.5-2v-4.5"/><path d="M21.5 9.5v5"/>',
    pessoa: '<circle cx="12" cy="8.5" r="3.5"/><path d="M5 19.5c1-3.6 3.7-5.5 7-5.5s6 1.9 7 5.5"/>',
    seta: '<path d="M7 10l5 5 5-5"/>',
    voz: '<path d="M4 9.5v5h3.5L12 18.5v-13L7.5 9.5z"/><path d="M15.5 9a4 4 0 0 1 0 6M18 6.5a7.5 7.5 0 0 1 0 11"/>',
    pausa: '<path d="M8.5 6v12M15.5 6v12"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M3.5 14.5h17M9 10v9"/>',
    info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5M12 8v.1"/>'
  };

  /* ═══ [K4] OS DADOS ══════════════════════════════════════════════════════════════════════
     O QUE FAZ  Pede ao processo NC_CURSOS_DADOS: { cargo, escolaridade: { exigida_cod,
                exigida, atual_cod, atual }, exigidos: [ { cod, nome, feito: 'S'|'N' } ],
                outros: [ { cod, nome } ] }. Se o processo não existir (o APEX responde vazio),
                lê as três listas da página: exigidos, concluídos e "à realizar" (feito = não
                está em "à realizar"), e o estudo dos itens …_VA_INSTR1/2_DISPLAY.
     CUIDADO    O nome do processo (PROCESSO, em [K1]) tem de ser igual ao do APEX.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function linhas(reg) {
    return [].map.call(reg.querySelectorAll('td'), function (td) { return codNome(td.textContent); }).filter(Boolean);
  }
  function exibido(nomeItem) {
    var e = document.getElementById(P + nomeItem + '_DISPLAY') || document.getElementById(P + nomeItem);
    return codNome(e ? (e.value != null && e.tagName === 'INPUT' ? e.value : e.textContent) : '');
  }
  function daPagina() {
    var falta = {}, exig = {};
    linhas(R_FALTA).forEach(function (c) { falta[c.cod + '|' + sem(c.nome)] = 1; });
    var exigidos = linhas(R_EXIG).map(function (c) { exig[c.cod + '|' + sem(c.nome)] = 1; return { cod: c.cod, nome: c.nome, feito: falta[c.cod + '|' + sem(c.nome)] ? 'N' : 'S' }; });
    var outros = linhas(R_COLAB).filter(function (c) { return !exig[c.cod + '|' + sem(c.nome)]; });
    var ex = exibido('VA_INSTR1_DISPLAY'), at = exibido('VA_INSTR2_DISPLAY');
    var parcial = [R_EXIG, R_COLAB, R_FALTA].some(function (r) { return r.querySelector('.t-Report-paginationLink--next, .t-Report-pagination a'); });
    return { cargo: '', parcial: parcial, escolaridade: { exigida_cod: ex && ex.cod, exigida: ex && ex.nome, atual_cod: at && at.cod, atual: at && at.nome }, exigidos: exigidos, outros: outros };
  }
  function buscar() {
    estado('carregando');
    apex.server.process(PROCESSO, {}, { dataType: 'text' })
      .done(function (txt) {
        var d = null;
        if (String(txt || '').trim()) { try { d = JSON.parse(txt); } catch (e) { d = null; } }
        if (!d) { desenhar(daPagina()); return; }          /* sem o processo: as listas da página */
        if (d.erro) { if (window.console) console.warn('[Natcorp_Cursos] NC_CURSOS_DADOS:', d.erro); desenhar(daPagina()); return; }
        desenhar(d);
      })
      .fail(function () { desenhar(daPagina()); });
  }

  /* ═══ [K5] DESENHAR ══════════════════════════════════════════════════════════════════════ */
  var RAIZ = null, CORPO = null, TABELA = false, ORIG = [], RESUMO = null;
  function estado(qual) {
    if (qual === 'carregando') CORPO.innerHTML = '<div class="nc-cu-estado" role="status"><span class="nc-cu-giro" aria-hidden="true"></span>' + T.carregando + '</div>';
    else CORPO.innerHTML = '<div class="nc-cu-estado nc-cu-estado--aviso">' + svg(IC.info, 'nc-cu-ic nc-cu-estado-ic') + '<div><p class="nc-cu-estado-tit">' + T.erro + '</p><p>' + T.erroDica + '</p></div></div>';
  }
  /* estudo: os códigos da tabela instrucao crescem com o grau (eSocial: 07 médio completo,
     09 superior completo…). Só compara quando os dois são números. */
  function situacaoEstudo(e) {
    if (!e || !e.exigida) return 'sem';
    if (!e.atual) return 'semDado';
    var a = parseInt(e.atual_cod, 10), x = parseInt(e.exigida_cod, 10);
    if (isNaN(a) || isNaN(x)) return 'semComparar';
    return a >= x ? 'ok' : 'abaixo';
  }
  function trilha(lista) {
    var n = lista.length;
    if (!n) return '';
    if (n > 16) {
      var f = lista.filter(function (c) { return c.feito === 'S'; }).length;
      return '<div class="nc-cu-trilha nc-cu-trilha--barra" aria-hidden="true"><span style="width:' + (f / n * 100).toFixed(1) + '%"></span></div>';
    }
    /* enche da esquerda para a direita: os feitos primeiro */
    lista = lista.filter(function (c) { return c.feito === 'S'; }).concat(lista.filter(function (c) { return c.feito !== 'S'; }));
    return '<ol class="nc-cu-trilha" aria-hidden="true">' + lista.map(function (c) { return '<li class="' + (c.feito === 'S' ? 'is-feito' : '') + '"></li>'; }).join('') + '</ol>';
  }
  function itemCurso(c) {
    var feito = c.feito === 'S';
    return '<li class="nc-cu-curso ' + (feito ? 'is-feito' : 'is-falta') + '">' +
      '<span class="nc-cu-curso-sinal">' + svg(feito ? IC.ok : IC.falta) + '</span>' +
      '<span class="nc-cu-curso-txt"><span class="nc-cu-curso-nome">' + esc(nome(c.nome)) + '</span>' +
      (c.cod ? '<span class="nc-cu-curso-cod">' + T.cod + ' ' + esc(c.cod) + '</span>' : '') + '</span>' +
      '<span class="nc-cu-curso-sit">' + (feito ? T.feito : T.faltaFazer) + '</span></li>';
  }
  function desenhar(d) {
    var porNome = function (a, b) { return sem(a.nome) < sem(b.nome) ? -1 : 1; };
    var exig = (d.exigidos || []).slice().sort(function (a, b) { return (a.feito === 'S') - (b.feito === 'S') || porNome(a, b); });
    var outros = (d.outros || []).slice().sort(porNome);
    var n = exig.length, f = exig.filter(function (c) { return c.feito === 'S'; }).length, p = n - f;
    var est = d.escolaridade || {}, se = situacaoEstudo(est);
    var cargo = codNome(d.cargo);
    var tom = p ? 'falta' : se === 'abaixo' ? 'falta' : n ? 'ok' : 'nada';
    var tit = p ? T.falta(p) : se === 'abaixo' ? T.faltaEstudo : n ? T.tudo : T.nada;
    var sub = p ? T.jaFez(f, n) : n ? T.fezTodos(n) : T.nadaDica;
    if (p && se === 'abaixo') sub += ' ' + T.estudoAbaixoDica;

    var resposta = '<article class="nc-cu-resposta nc-cu-resposta--' + tom + '" aria-label="' + esc(T.titulo) + '">' +
      '<header class="nc-cu-resposta-cab"><div><h2 class="nc-cu-resposta-tit">' + T.titulo + '</h2>' +
      (cargo ? '<p class="nc-cu-cargo">' + svg(IC.pessoa) + '<span>' + T.cargo + ': <b>' + esc(nome(cargo.nome)) + '</b></span></p>' : '') + '</div>' +
      ('speechSynthesis' in window ? '<button type="button" class="nc-cu-ouvir" aria-pressed="false">' + svg(IC.voz) + '<span>' + T.ouvir + '</span></button>' : '') + '</header>' +
      '<div class="nc-cu-veredito"><span class="nc-cu-veredito-sinal">' + (tom === 'falta' ? (p ? '<b>' + p + '</b>' : svg(IC.estudo)) : svg(tom === 'ok' ? IC.ok : IC.livro)) + '</span>' +
      '<div><p class="nc-cu-veredito-tit">' + tit + '</p><p class="nc-cu-veredito-sub">' + sub + '</p></div></div>' +
      trilha(exig) +
      (tom === 'falta' ? '<p class="nc-cu-fazer">' + svg(IC.info) + '<span>' + T.oQueFazer + '</span></p>' : '') +
      '</article>';

    var lista = '<section class="nc-cu-bloco nc-cu-bloco--lista" aria-label="' + esc(T.lista) + '">' +
      '<header class="nc-cu-bloco-cab"><span class="nc-cu-bloco-ic">' + svg(IC.livro) + '</span><h3 class="nc-cu-bloco-tit">' + T.lista + '</h3>' +
      '<span class="nc-cu-bloco-n">' + (n ? f + ' de ' + n : '') + '</span></header>' +
      (n ? '<ul class="nc-cu-cursos">' + exig.map(itemCurso).join('') + '</ul>' : '<p class="nc-cu-vazio">' + T.listaVazia + '</p>') +
      '</section>';

    var chip = { ok: '<span class="nc-cu-chip nc-cu-chip--ok">' + svg(IC.ok) + T.estudoOk + '</span>', abaixo: '<span class="nc-cu-chip nc-cu-chip--falta">' + T.estudoAbaixo + '</span>' }[se] || '';
    var estudo = '<section class="nc-cu-bloco nc-cu-bloco--estudo" aria-label="' + esc(T.estudo) + '">' +
      '<header class="nc-cu-bloco-cab"><span class="nc-cu-bloco-ic">' + svg(IC.estudo) + '</span><h3 class="nc-cu-bloco-tit">' + T.estudo + '</h3>' + chip + '</header>' +
      '<dl class="nc-cu-estudo">' +
      '<div><dt>' + T.estudoPede + '</dt><dd>' + (est.exigida ? esc(nome(est.exigida)) : '<span class="nc-cu-fraco">' + T.estudoSemPedido + '</span>') + '</dd></div>' +
      '<div><dt>' + T.estudoTem + '</dt><dd>' + (est.atual ? esc(nome(est.atual)) : '<span class="nc-cu-fraco">' + T.estudoSemDado + '</span>') + '</dd></div>' +
      '</dl></section>';

    var outrosH = '<details class="nc-cu-outros"' + (n ? '' : ' open') + '><summary><span class="nc-cu-bloco-ic">' + svg(IC.ok) + '</span>' +
      '<span class="nc-cu-outros-tit">' + T.outros + '</span><span class="nc-cu-bloco-n">' + T.itens(outros.length) + '</span>' + svg(IC.seta, 'nc-cu-ic nc-cu-outros-seta') + '</summary>' +
      '<p class="nc-cu-outros-dica">' + T.outrosDica + '</p>' +
      (outros.length ? '<ul class="nc-cu-cursos nc-cu-cursos--outros">' + outros.map(function (c) { return itemCurso({ cod: c.cod, nome: c.nome, feito: 'S' }); }).join('') + '</ul>' : '<p class="nc-cu-vazio">' + T.nenhumOutro + '</p>') +
      '</details>';

    /* cargo sem curso obrigatório: a lista vazia só repetiria a resposta — fica o estudo e os outros */
    CORPO.innerHTML = resposta +
      (n ? '<div class="nc-cu-grade"><div class="nc-cu-col">' + lista + '</div><div class="nc-cu-col">' + estudo + outrosH + '</div></div>'
         : '<div class="nc-cu-grade nc-cu-grade--igual"><div class="nc-cu-col">' + outrosH + '</div><div class="nc-cu-col">' + estudo + '</div></div>') +
      (d.parcial ? '<p class="nc-cu-parcial">' + svg(IC.info) + '<span>' + T.parcial + '</span></p>' : '');
    RESUMO = { cargo: cargo && nome(cargo.nome), p: p, f: f, n: n, faltam: exig.filter(function (c) { return c.feito !== 'S'; }).map(function (c) { return nome(c.nome); }), est: est, se: se };
  }

  /* ═══ [K6] OUVIR ═════════════════════════════════════════════════════════════════════════
     O celular lê a resposta em voz alta: o que falta, pelo nome, e o estudo.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FALANDO = false;
  function marcarOuvir() {
    var b = RAIZ && RAIZ.querySelector('.nc-cu-ouvir');
    if (!b) return;
    b.setAttribute('aria-pressed', String(FALANDO));
    b.innerHTML = svg(FALANDO ? IC.pausa : IC.voz) + '<span>' + (FALANDO ? T.parar : T.ouvir) + '</span>';
  }
  function pararVoz() { try { window.speechSynthesis && speechSynthesis.cancel(); } catch (e) { /* sem voz */ } FALANDO = false; marcarOuvir(); }
  function ouvir() {
    if (FALANDO) { pararVoz(); return; }
    var r = RESUMO; if (!r || !window.speechSynthesis) return;
    var txt = (r.cargo ? 'Seu cargo: ' + r.cargo + '. ' : '') +
      (r.p ? (r.p === 1 ? 'Falta um curso: ' : 'Faltam ' + r.p + ' cursos: ') + r.faltam.join(', ') + '. Você já fez ' + r.f + ' de ' + r.n + '.' :
        r.n ? 'Você tem todos os ' + r.n + ' cursos que o seu cargo pede.' : 'O seu cargo não pede cursos.') +
      (r.se === 'ok' ? ' O seu estudo atende ao que o cargo pede.' : r.se === 'abaixo' ? ' O seu estudo está abaixo do que o cargo pede: ' + nome(r.est.exigida) + '.' : '') +
      (r.p || r.se === 'abaixo' ? ' ' + T.oQueFazer : '');
    var u = new SpeechSynthesisUtterance(txt);
    u.lang = 'pt-BR'; u.rate = .95;
    var v = (speechSynthesis.getVoices() || []).filter(function (x) { return /^pt(-|_)BR/i.test(x.lang); })[0];
    if (v) u.voice = v;
    u.onend = u.onerror = function () { FALANDO = false; marcarOuvir(); };
    speechSynthesis.cancel();
    speechSynthesis.speak(u);
    FALANDO = true; marcarOuvir();
  }

  /* ═══ [K7] O MAESTRO ═════════════════════════════════════════════════════════════════════
     O QUE FAZ  As três listas originais (e a linha delas) saem da vista e o desenho entra no
                lugar; "Ver tabela completa" as traz de volta. Liga os cliques e busca os dados.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montar() {
    ORIG = [R_EXIG, R_COLAB, R_FALTA];
    var linha = R_EXIG.closest('.row');
    var mesma = linha && ORIG.every(function (r) { return linha.contains(r); });
    if (mesma) ORIG = [linha];
    ORIG.forEach(function (r) { r.classList.add('nc-cu-orig'); });
    RAIZ = document.createElement('section'); RAIZ.className = 'nc-cu-raiz'; RAIZ.id = 'nc-cu';
    RAIZ.innerHTML = '<div class="nc-cu-corpo" aria-live="polite"></div>' +
      '<div class="nc-cu-pe"><button type="button" class="nc-cu-tabela-bt" aria-expanded="false">' + svg(IC.tabela) + '<span>' + T.verTabela + '</span></button></div>';
    var antes = mesma ? linha : R_EXIG;
    antes.parentNode.insertBefore(RAIZ, antes);
    CORPO = RAIZ.querySelector('.nc-cu-corpo');
    document.body.classList.add('nc-cu');
    $(RAIZ).on('click', '.nc-cu-ouvir', ouvir);
    $(RAIZ).on('click', '.nc-cu-tabela-bt', function () {
      TABELA = !TABELA;
      document.body.classList.toggle('nc-cu-tabela', TABELA);
      this.setAttribute('aria-expanded', String(TABELA));
      this.querySelector('span').textContent = TABELA ? T.esconderTabela : T.verTabela;
      if (TABELA) $(window).trigger('apexwindowresized');
    });
    window.addEventListener('pagehide', pararVoz);
  }
  function iniciar() { montar(); buscar(); }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
