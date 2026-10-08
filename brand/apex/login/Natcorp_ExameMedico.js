/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · EXAME MÉDICO OCUPACIONAL  —  o "arrumador" da tela (JavaScript)               ║
   ║  App 2937 (Medicina Ocupacional) · Página 19 · Exame Médico Ocupacional (modal)          ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia desta página: EXAMEMEDICO-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   É a janela em que o médico FAZ o exame (aberta pela Agenda Médica). O médico passa o dia
   nela, consulta atrás de consulta; o desenho troca as 3 abas e os 57 campos soltos por uma
   ficha na ordem do atendimento:
     • no alto, fixo, QUEM é o paciente: código - nome, idade, função e há quanto tempo, setor,
       empresa, documentos, e o tipo de exame (Admissional, Periódico, Mudança de função…);
     • à esquerda, o EXAME: sinais vitais (com unidade, IMC com a classificação e um aviso
       discreto quando a pressão, a temperatura ou o pulso saem da referência) e os exames
       complementares (a acuidade visual numa tabela de verdade — olho × sem/com óculos ×
       perto/longe —, audiometria, dinamometria, espirometria e outros);
     • à direita, o PARECER: Apto / Inapto num toque, a data do resultado (com aviso quando é
       diferente da data do exame), a validade em botões com o "vale até", o nº do ASO, se foi
       feito na empresa, a conduta, o procedimento e os médicos (o CRM e o endereço do
       coordenador numa linha);
     • embaixo, fixo, Exames · Relatório ASO e o Salvar (ou Criar, no exame novo), com o aviso
       "alterações não salvas" e o que falta para salvar (procedimento, resultado);
     • com o paciente no pré-atendimento, um aviso no alto com o "Iniciar atendimento".
   Para quem digita o dia todo: Enter passa para o próximo campo, Ctrl+S (⌘S) salva, e a altura,
   o peso e a pressão aceitam o jeito rápido ("170" vira "1,70"; "12080" vira "120/80").

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Nenhum campo é criado ou trocado: os campos do APEX são MUDADOS DE LUGAR (com o rótulo e o
     lugar do erro), dentro das mesmas regiões. Por isso continuam valendo, sem mudar nada:
       • o salvar (o botão Salvar original, com a validação), o Relatório ASO e o Exames;
       • as ações dinâmicas (o IMC calculado no banco, os dados do coordenador, os campos da
         mudança de função que aparecem só no tipo M);
       • a TRAVA do pré-atendimento (a ação "Disable Tabs" desliga as regiões complementares,
         adicionais e wecker até o médico apertar "Iniciar Atendimento" — o desenho põe esse
         botão no aviso do alto);
       • as validações do Salvar (procedimento obrigatório; com procedimento, o resultado) —
         o rodapé avisa antes o que falta.
     Apto / Inapto, Validade e "Feito na empresa" são botões que escrevem no campo original
     (setValue), como se o médico tivesse escolhido na lista. Tirou as URLs: volta o de antes.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 19 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_ExameMedico.js
     Página 19 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_ExameMedico.css

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
     • as regiões com Static ID informacoes, adicionais, wecker e complementares;
     • os itens P19_… de sempre (os que faltarem só não aparecem);
     • os botões SAVE ("Salvar") ou INSERT ("Criar"), "Relatório ASO", "Exames" e "Iniciar
       Atendimento" na região informacoes.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [E1]  Como a página é reconhecida                                      CUIDADO
     [E2]  Textos, unidades, referências e resultados                       PODE MEXER
     [E3]  Ferramentas
     [E4]  Quem é o paciente (o alto)
     [E5]  Sinais vitais
     [E6]  Exames complementares
     [E7]  O parecer
     [E8]  O rodapé: Exames, Relatório ASO, Salvar
     [E9]  Teclado: Enter, Ctrl+S e o jeito rápido de digitar
     [E10] Pré-atendimento (a trava)
     [E11] O maestro                                                        CUIDADO

   ── LEGENDA ───────────────────────────────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, cores.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
*/
(function () {
  'use strict';
  if (window.__ncExameMedico || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [E2] TEXTOS, UNIDADES, REFERÊNCIAS E RESULTADOS ════════════════════════════════════
     ROTULOS     o nome que aparece em cima de cada campo (o do APEX fica para as mensagens).
     UNIDADES    o que aparece dentro do campo, à direita.
     EXEMPLOS    o exemplo cinza no campo vazio (mostra o formato que o banco espera).
     RESULTADOS  os botões do parecer: v = o código da lista "Resultado ASO", d = o texto que
                 a lista mostra. Se o exame vier com um código que não está aqui, a lista
                 original aparece no lugar dos botões.
     TIPOS       a cor do tipo de exame (pelo texto).
     PODE MEXER  tudo daqui.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ROTULOS = {
    P19_PESO: 'Peso', P19_ALTURA: 'Altura', P19_MASSA_CORPOREA: 'IMC', P19_PRESSAO_ARTERIAL: 'Pressão arterial',
    P19_TEMPERATURA: 'Temperatura', P19_PULSO: 'Pulso',
    P19_OUV_DIR_DB: 'Ouvido direito', P19_OUV_ESQ_DB: 'Ouvido esquerdo',
    P19_MAO_DIREITA: 'Mão direita', P19_MAO_ESQUERDA: 'Mão esquerda', P19_COLUNA: 'Coluna',
    P19_ESPIROMETRIA: 'Espirometria', P19_EXAMES_COMPL: 'Outros exames',
    P19_RESULT_EXAME: 'Resultado', P19_DT_RESULTADO_ASO: 'Data do resultado', P19_VAL_ASO: 'Validade',
    P19_NUM_ATESTADO: 'Nº do ASO', P19_FEITO_LOJA: 'Feito na empresa', P19_CONDUTA: 'Conduta',
    P19_COD_PROCEDIMENTO: 'Procedimento', P19_OBS_PROCEDIMENTO: 'Observação do procedimento',
    P19_MEDICO_AUX: 'Médico do trabalho', P19_COD_MEDICO_COORDENADOR: 'Médico coordenador',
    P19_CARGO_PROPOSTO: 'Cargo', P19_FUNCAO_PROPOSTA: 'Função', P19_FILIAL_PROPOSTA: 'Filial', P19_LOCAL_PRETENDIDO: 'Local'
  };
  var UNIDADES = { P19_PESO: 'kg', P19_ALTURA: 'm', P19_PRESSAO_ARTERIAL: 'mmHg', P19_TEMPERATURA: '°C', P19_PULSO: 'bpm', P19_OUV_DIR_DB: 'dB', P19_OUV_ESQ_DB: 'dB' };
  var EXEMPLOS = { P19_PESO: '72,5', P19_ALTURA: '1,70', P19_PRESSAO_ARTERIAL: '120/80', P19_TEMPERATURA: '36,5', P19_PULSO: '72' };
  var RESULTADOS = [
    { v: '1', d: '1 - APTO', rot: 'Apto', tom: 'apto', ic: 'check' },
    { v: '2', d: '2 - INAPTO', rot: 'Inapto', tom: 'inapto', ic: 'x' }
  ];
  var TIPOS = [[/admiss/i, 'admissional'], [/demiss/i, 'demissional'], [/peri[oó]d/i, 'periodico'], [/mudan/i, 'mudanca'], [/retorno/i, 'retorno']];
  /* a acuidade visual: as linhas (olho) e as colunas (sem/com óculos × perto/longe) da tabela */
  var OLHOS = [['OD', 'Olho direito', 'OD'], ['OE', 'Olho esquerdo', 'OE'], ['AO', 'Ambos os olhos', 'AO_OD']];
  var VISAO = [['SO', 'PERTO', 'Sem óculos', 'Perto'], ['SO', 'LONGE', 'Sem óculos', 'Longe'], ['CO', 'PERTO', 'Com óculos', 'Perto'], ['CO', 'LONGE', 'Com óculos', 'Longe']];
  /* as referências dos sinais vitais: só AVISAM (nada é bloqueado) */
  function referenciaPA(t) {
    var m = /^(\d{2,3})\/(\d{2,3})$/.exec(t || ''); if (!m) return t ? { tom: 'aviso', txt: 'Use o formato 120/80' } : null;
    var s = +m[1], d = +m[2];
    if (s >= 140 || d >= 90) return { tom: 'atencao', txt: 'Acima de 140/90' };
    if (s < 90 || d < 60) return { tom: 'atencao', txt: 'Abaixo de 90/60' };
    return null;
  }
  function referenciaTemp(n) { if (n == null) return null; if (n >= 37.8) return { tom: 'atencao', txt: 'Febre (37,8 °C ou mais)' }; if (n < 35) return { tom: 'atencao', txt: 'Abaixo de 35 °C' }; return null; }
  function referenciaPulso(n) { if (n == null) return null; if (n > 100) return { tom: 'atencao', txt: 'Acima de 100 bpm' }; if (n < 60) return { tom: 'atencao', txt: 'Abaixo de 60 bpm' }; return null; }
  function classeIMC(n) {
    if (n == null || !(n > 0)) return null;
    if (n < 18.5) return { tom: 'atencao', txt: 'Abaixo do peso' };
    if (n < 25) return { tom: 'bom', txt: 'Peso adequado' };
    if (n < 30) return { tom: 'atencao', txt: 'Sobrepeso' };
    if (n < 35) return { tom: 'atencao', txt: 'Obesidade grau I' };
    if (n < 40) return { tom: 'atencao', txt: 'Obesidade grau II' };
    return { tom: 'atencao', txt: 'Obesidade grau III' };
  }

  /* ═══ [E3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function cx(id) { return $id(id + '_CONTAINER'); }
  /* "NATCORP DO BRASIL" → "Natcorp do Brasil" (siglas de até 3 letras com número ficam) */
  function nome(t) {
    return String(t || '').toLowerCase().replace(/(^|[\s'(/-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); })
      .replace(/\s(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  /* "700 - NATCORP DO BRASIL" → "700 - Natcorp do Brasil"; sem código, só o nome arrumado */
  function codDesc(t) {
    t = String(t || '').trim(); if (!t) return '';
    var m = /^([^\s]+)\s+-\s+(.+)$/.exec(t);
    if (!m) return /[a-zà-ú]/.test(t) ? t : nome(t);
    return m[1] + ' - ' + (/[a-zà-ú]/.test(m[2]) ? m[2] : nome(m[2]));
  }
  function texto(id) { var e = $id(id + '_DISPLAY') || $id(id); if (!e) return ''; return String(e.tagName === 'INPUT' || e.tagName === 'SELECT' ? e.value : e.textContent).trim(); }
  function dataBR(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function dd(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear(); }
  function anos(de, ate) { if (!de || !ate) return null; var a = ate.getFullYear() - de.getFullYear(); if (ate.getMonth() < de.getMonth() || (ate.getMonth() === de.getMonth() && ate.getDate() < de.getDate())) a--; return a; }
  function num(t) { t = String(t == null ? '' : t).trim().replace(/\s/g, ''); if (!t) return null; if (/,/.test(t)) t = t.replace(/\./g, '').replace(',', '.'); var n = parseFloat(t); return isNaN(n) ? null : n; }
  var IC = {
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>', x: '<path d="M7 7l10 10M17 7L7 17"/>',
    cadeado: '<rect x="5.5" y="10.5" width="13" height="9" rx="2"/><path d="M8.5 10.5V8a3.5 3.5 0 0 1 7 0v2.5"/>',
    salvar: '<path d="M5 4.5h11l3 3V19a.5.5 0 0 1-.5.5h-13A.5.5 0 0 1 5 19z"/><path d="M8.5 4.5V9h6V4.5M8 19.5v-6h8v6"/>',
    imprimir: '<path d="M7 9V4.5h10V9M7 16.5H5.5A1.5 1.5 0 0 1 4 15v-4.5A1.5 1.5 0 0 1 5.5 9h13a1.5 1.5 0 0 1 1.5 1.5V15a1.5 1.5 0 0 1-1.5 1.5H17"/><path d="M7 13.5h10v6H7z"/>',
    frasco: '<path d="M9.5 3.5h5M10.5 3.5v5.2L5.6 17.3A2 2 0 0 0 7.3 20.3h9.4a2 2 0 0 0 1.7-3l-4.9-8.6V3.5"/><path d="M7.7 14h8.6"/>',
    calendario: '<rect x="4" y="5.5" width="16" height="14" rx="2.5"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4"/>',
    seta: '<path d="M5 12h13M13 6.5l5.5 5.5-5.5 5.5"/>',
    relogio: '<circle cx="12" cy="12" r="8"/><path d="M12 7.5V12l3 2"/>',
    play: '<path d="M8 5.5v13l10.5-6.5z"/>'
  };
  function ic(n) { return '<svg class="nc-em-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }
  /* o campo está "preenchido"? (para os contadores de cada parte) */
  function preenchido(id) { var e = $id(id); if (!e) return false; var v = e.tagName === 'SPAN' ? e.textContent : e.value; return String(v || '').trim() !== ''; }
  /* põe o contêiner do campo (rótulo + campo + lugar do erro) dentro de "onde" */
  function mover(id, onde, cls) {
    var c = cx(id); if (!c || !onde) return null;
    c.classList.add('nc-em-campo'); if (cls) c.classList.add(cls);
    onde.appendChild(c);
    var l = c.querySelector('#' + id + '_LABEL');   /* pelo contêiner: "onde" pode ainda estar fora da página */
    if (l && ROTULOS[id]) l.textContent = ROTULOS[id];
    return c;
  }
  /* a unidade dentro do campo, à direita, e o exemplo cinza */
  function vestir(id) {
    var e = $id(id); if (!e) return;
    if (EXEMPLOS[id] && !e.placeholder) e.placeholder = 'ex. ' + EXEMPLOS[id];
    if (/^P19_(PESO|ALTURA|TEMPERATURA|PULSO|OUV_|MAO_)/.test(id)) e.setAttribute('inputmode', 'decimal');
    if (id === 'P19_PRESSAO_ARTERIAL') e.setAttribute('inputmode', 'numeric');
    e.setAttribute('autocomplete', 'off');
    if (UNIDADES[id]) { var w = e.closest('.t-Form-itemWrapper'); if (w && !w.querySelector('.nc-em-un')) { w.classList.add('nc-em-com-un'); w.appendChild(el('span', 'nc-em-un', esc(UNIDADES[id]))); } }
  }
  /* uma nota curta embaixo do campo (referência, formato, aviso) */
  function nota(id, r) {
    var c = cx(id); if (!c) return;
    var n = c.querySelector('.nc-em-nota');
    if (!r) { if (n) n.remove(); c.removeAttribute('data-ref'); return; }
    if (!n) { n = el('p', 'nc-em-nota'); n.setAttribute('aria-live', 'polite'); c.querySelector('.t-Form-inputContainer').appendChild(n); }
    n.textContent = r.txt; c.setAttribute('data-ref', r.tom);
  }
  /* o cabeçalho de cada parte: título + "3 de 5" */
  function cabecalho(reg, titulo, ids) {
    var h = reg.querySelector('.nc-em-sec-cab');
    if (!h) { h = el('header', 'nc-em-sec-cab', '<h2 class="nc-em-sec-tit"></h2><span class="nc-em-conta"></span>'); reg.querySelector('.t-Region-body').insertBefore(h, reg.querySelector('.t-Region-body').firstChild); }
    h.querySelector('.nc-em-sec-tit').textContent = titulo;
    reg._ncIds = ids;
    return h;
  }
  function contar(reg) {
    if (!reg || !reg._ncIds) return;
    var ids = reg._ncIds.filter(function (i) { return $id(i) && cx(i) && cx(i).style.display !== 'none'; });
    var f = ids.filter(preenchido).length;
    var s = reg.querySelector('.nc-em-conta');
    if (s) { s.textContent = f + ' de ' + ids.length; s.setAttribute('data-completo', f === ids.length && ids.length ? 'sim' : 'nao'); s.title = f + ' de ' + ids.length + ' campos preenchidos'; }
  }

  /* ═══ [E4] QUEM É O PACIENTE ═════════════════════════════════════════════════════════════
     Lido dos campos de "Informações Cadastrais" (só leitura). Fica no alto da janela, fixo,
     para o médico nunca perder de vista com quem está (no celular, rola com a página).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function paciente(caixa) {
    var quem = texto('P19_MATRICULA');                       /* "101338 - Ivanilda Oliveira" */
    var m = /^\s*(\S+)\s+-\s+(.+)$/.exec(quem);
    var cod = m ? m[1] : '', nm = m ? m[2] : quem;
    if (nm && !/[a-zà-ú]/.test(nm)) nm = nome(nm);
    var ini = String(nm || '?').split(/\s+/).filter(function (p) { return p.length > 2 || /^[A-ZÀ-Ú]/.test(p); });
    ini = ((ini[0] || '?').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '')).toUpperCase();
    var tipo = texto('P19_TIPO_EXAME'), tom = 'outro';
    TIPOS.forEach(function (t) { if (tom === 'outro' && t[0].test(tipo)) tom = t[1]; });
    var dExame = dataBR(texto('P19_DATA_ATUAL')), nasc = dataBR(texto('P19_DATA_NASC')), adm = dataBR(texto('P19_DATA_ADM'));
    var idade = anos(nasc, dExame || new Date()), casa = anos(adm, dExame || new Date());
    var funcao = texto('P19_FUNCAO'), tempo = texto('P19_TEMPO_NA_FUNCAO').replace(/m[eê]s\(es\)/i, 'meses').replace(/\b1 meses\b/, '1 mês');
    var dados = [
      ['Idade', idade != null ? idade + ' anos' : ''],
      ['Função', funcao ? nome(funcao) + (tempo ? ' <span class="nc-em-fraco">há ' + esc(tempo) + '</span>' : '') : '', true],
      ['Setor', nome(texto('P19_SETOR'))],
      ['Depto', codDesc(texto('P19_DEPTO_LOJA'))],
      ['Empresa', codDesc(texto('P19_EMPRESA'))],
      ['Admissão', adm ? dd(adm) + (casa != null ? ' <span class="nc-em-fraco">' + (casa < 1 ? 'menos de 1 ano' : casa + (casa === 1 ? ' ano' : ' anos')) + ' de casa</span>' : '') : '', true],
      ['RG', [texto('P19_RG'), texto('P19_UF_RG') && texto('P19_RG').indexOf(texto('P19_UF_RG')) < 0 ? texto('P19_UF_RG') : ''].filter(Boolean).join(' ')],
      ['CTPS', [texto('P19_CART_PROFISSIONAL'), texto('P19_SERIE') ? 'série ' + texto('P19_SERIE') : ''].filter(Boolean).join(' ')]
    ].filter(function (d) { return d[1]; });
    caixa.innerHTML =
      '<div class="nc-em-pac-id">' +
        '<span class="nc-em-avatar" aria-hidden="true">' + esc(ini) + '</span>' +
        '<div class="nc-em-pac-nome"><h1>' + (cod ? '<span class="nc-em-cod">' + esc(cod) + ' - </span>' : '') + esc(nm || 'Paciente') + '</h1>' +
        '<dl class="nc-em-pac-dados">' + dados.map(function (d) { return '<div data-k="' + esc(d[0].toLowerCase()) + '"><dt>' + esc(d[0]) + '</dt><dd>' + (d[2] ? d[1] : esc(d[1])) + '</dd></div>'; }).join('') + '</dl></div>' +
      '</div>' +
      '<div class="nc-em-pac-exame">' +
        (tipo ? '<span class="nc-em-tipo" data-tom="' + tom + '">' + esc(tipo) + '</span>' : '') +
        (dExame ? '<span class="nc-em-data">' + ic('calendario') + 'Exame de ' + dd(dExame) + '</span>' : '') +
      '</div>';
  }

  /* ═══ [E5] SINAIS VITAIS ═════════════════════════════════════════════════════════════════
     Região "Dados Adicionais" (adicionais). O IMC é calculado no banco (a ação dinâmica de
     sempre, quando muda o peso ou a altura); o desenho só põe a classificação ao lado.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var VITAIS = ['P19_PESO', 'P19_ALTURA', 'P19_PRESSAO_ARTERIAL', 'P19_TEMPERATURA', 'P19_PULSO'];
  function montarVitais(reg) {
    if (!reg) return;
    reg.classList.add('nc-em-sec', 'nc-em-vitais');
    cabecalho(reg, 'Sinais vitais', VITAIS);
    var g = el('div', 'nc-em-grade nc-em-grade--vitais');
    reg.querySelector('.t-Region-body').appendChild(g);
    ['P19_PESO', 'P19_ALTURA', 'P19_MASSA_CORPOREA', 'P19_PRESSAO_ARTERIAL', 'P19_TEMPERATURA', 'P19_PULSO'].forEach(function (id) { mover(id, g); vestir(id); });
    var imc = cx('P19_MASSA_CORPOREA'); if (imc) imc.classList.add('nc-em-imc');
    esvaziar(reg);
  }
  function referenciasVitais() {
    nota('P19_MASSA_CORPOREA', classeIMC(num(texto('P19_MASSA_CORPOREA'))));
    nota('P19_PRESSAO_ARTERIAL', referenciaPA(texto('P19_PRESSAO_ARTERIAL')));
    nota('P19_TEMPERATURA', referenciaTemp(num(texto('P19_TEMPERATURA'))));
    nota('P19_PULSO', referenciaPulso(num(texto('P19_PULSO'))));
    var alt = num(texto('P19_ALTURA'));
    nota('P19_ALTURA', alt != null && (alt < 0.5 || alt > 2.5) ? { tom: 'aviso', txt: 'Em metros, como 1,70' } : null);
  }
  /* o grid antigo da região (as linhas e colunas do APEX) fica vazio: some */
  function esvaziar(reg) { var c = reg.querySelector('.t-Region-body > .container'); if (c) c.classList.add('nc-em-vazio'); }

  /* ═══ [E6] EXAMES COMPLEMENTARES ═════════════════════════════════════════════════════════
     Região "Tabela de Wecker" (wecker) e as sub-regiões dela. A acuidade visual vira tabela:
     cada célula é o campo original (P19_OD_SO_PERTO…), na ordem em que se lê.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var COMPLEMENTARES = [];
  OLHOS.forEach(function (o) { VISAO.forEach(function (v) { COMPLEMENTARES.push('P19_' + o[2] + '_' + v[0] + '_' + v[1]); }); });
  COMPLEMENTARES = COMPLEMENTARES.concat(['P19_OUV_DIR_DB', 'P19_OUV_ESQ_DB', 'P19_MAO_DIREITA', 'P19_MAO_ESQUERDA', 'P19_COLUNA', 'P19_ESPIROMETRIA', 'P19_EXAMES_COMPL']);
  function bloco(pai, titulo, cls) { var b = el('section', 'nc-em-bloco' + (cls ? ' ' + cls : ''), '<h3 class="nc-em-bloco-tit">' + esc(titulo) + '</h3>'); pai.appendChild(b); return b; }
  function montarComplementares(reg) {
    if (!reg) return;
    reg.classList.add('nc-em-sec', 'nc-em-compl');
    cabecalho(reg, 'Exames complementares', COMPLEMENTARES);
    var corpo = el('div', 'nc-em-compl-corpo');
    reg.querySelector('.t-Region-body').appendChild(corpo);

    /* a acuidade visual */
    var bv = bloco(corpo, 'Acuidade visual', 'nc-em-bloco--visao');
    var tab = el('table', 'nc-em-visao');
    tab.innerHTML = '<caption class="nc-em-so-leitor">Acuidade visual por olho, sem e com óculos, de perto e de longe</caption>' +
      '<thead><tr><td></td><th scope="colgroup" colspan="2">Sem óculos</th><th scope="colgroup" colspan="2">Com óculos</th></tr>' +
      '<tr><td></td><th scope="col">Perto</th><th scope="col">Longe</th><th scope="col">Perto</th><th scope="col">Longe</th></tr></thead><tbody></tbody>';
    var tb = tab.querySelector('tbody');
    OLHOS.forEach(function (o) {
      var tr = el('tr', '', '<th scope="row"><abbr title="' + esc(o[1]) + '">' + esc(o[0]) + '</abbr><span class="nc-em-olho">' + esc(o[1]) + '</span></th>');
      VISAO.forEach(function (v, i) {
        var id = 'P19_' + o[2] + '_' + v[0] + '_' + v[1];
        var td = el('td', i === 2 ? 'nc-em-visao-co' : '');
        var c = mover(id, td, 'nc-em-campo--celula'), e = c && c.querySelector('input');   /* a tabela ainda está fora da página: $id não acha */
        if (e) { e.setAttribute('aria-label', o[1] + ', ' + v[2].toLowerCase() + ', ' + v[3].toLowerCase()); e.setAttribute('autocomplete', 'off'); }
        tr.appendChild(td);
      });
      tb.appendChild(tr);
    });
    var rola = el('div', 'nc-em-visao-rola'); rola.appendChild(tab); bv.appendChild(rola);

    /* audiometria e dinamometria lado a lado */
    var par = el('div', 'nc-em-par'); corpo.appendChild(par);
    var ba = bloco(par, 'Audiometria'), ga = el('div', 'nc-em-grade'); ba.appendChild(ga);
    ['P19_OUV_DIR_DB', 'P19_OUV_ESQ_DB'].forEach(function (id) { mover(id, ga); vestir(id); });
    var bd = bloco(par, 'Dinamometria'), gd = el('div', 'nc-em-grade nc-em-grade--3'); bd.appendChild(gd);
    ['P19_MAO_DIREITA', 'P19_MAO_ESQUERDA', 'P19_COLUNA'].forEach(function (id) { mover(id, gd); vestir(id); });

    /* espirometria e outros exames (texto livre) */
    var par2 = el('div', 'nc-em-par'); corpo.appendChild(par2);
    ['P19_ESPIROMETRIA', 'P19_EXAMES_COMPL'].forEach(function (id) {
      var b = bloco(par2, ROTULOS[id]); var c = mover(id, b, 'nc-em-campo--texto');
      if (c) { c.querySelector('.t-Form-labelContainer').classList.add('nc-em-so-leitor'); contador(id); }
    });
    /* as sub-regiões antigas (Visão, S/OCULOS…) ficaram vazias */
    esvaziar(reg);
  }
  /* "12 de 500" embaixo do texto livre */
  function contador(id) {
    var e = $id(id); if (!e || !(e.maxLength > 0)) return;
    var c = cx(id), s = c.querySelector('.nc-em-limite');
    if (!s) { s = el('span', 'nc-em-limite'); c.querySelector('.t-Form-inputContainer').appendChild(s); }
    var f = function () { s.textContent = (e.value || '').length + ' de ' + e.maxLength; s.setAttribute('data-perto', (e.value || '').length > e.maxLength * 0.9 ? 'sim' : 'nao'); };
    f(); e.addEventListener('input', f);
  }

  /* ═══ [E7] O PARECER ═════════════════════════════════════════════════════════════════════
     Região "Informações Complementares" (complementares). Os três "escolha um" viram botões:
       • Resultado (lista com busca do APEX)  → Apto / Inapto, pelo setValue(código, texto);
       • Validade e Feito na empresa (listas) → um botão por opção da própria lista.
     A lista original continua ali (escondida) e é ela que vai para o banco.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PARECER = ['P19_RESULT_EXAME', 'P19_DT_RESULTADO_ASO', 'P19_VAL_ASO', 'P19_NUM_ATESTADO', 'P19_FEITO_LOJA', 'P19_CONDUTA', 'P19_COD_PROCEDIMENTO', 'P19_OBS_PROCEDIMENTO', 'P19_MEDICO_AUX', 'P19_COD_MEDICO_COORDENADOR'];
  function escolhas(id, opcoes, grande) {
    var c = cx(id); if (!c) return null;
    var g = el('div', 'nc-em-escolha' + (grande ? ' nc-em-escolha--grande' : ''));
    g.setAttribute('role', 'radiogroup');
    g.setAttribute('aria-labelledby', id + '_LABEL');
    opcoes.forEach(function (o) {
      var b = el('button', 'nc-em-opcao', (o.ic ? ic(o.ic) : '') + '<span>' + esc(o.rot) + '</span>');
      b.type = 'button'; b.setAttribute('role', 'radio'); b.setAttribute('data-v', o.v); if (o.tom) b.setAttribute('data-tom', o.tom);
      b.addEventListener('click', function () {
        if (c.closest('.apex_disabled')) return;
        var it = apex.item(id);
        if (o.d != null) it.setValue(o.v, o.d); else it.setValue(o.v);
        sujo(true); marcar(); contar(c.closest('.nc-em-sec')); faltando();
      });
      g.appendChild(b);
    });
    /* setas do teclado andam entre as opções (o jeito de um grupo de rádio) */
    g.addEventListener('keydown', function (ev) {
      if (!/^Arrow(Left|Right|Up|Down)$/.test(ev.key)) return;
      var bs = [].slice.call(g.querySelectorAll('.nc-em-opcao')), i = bs.indexOf(document.activeElement);
      if (i < 0) return; ev.preventDefault();
      var n = bs[(i + (/Right|Down/.test(ev.key) ? 1 : bs.length - 1)) % bs.length]; n.focus(); n.click();
    });
    function marcar() {
      var v = apex.item(id).getValue(), achou = false;
      [].forEach.call(g.querySelectorAll('.nc-em-opcao'), function (b) { var s = b.getAttribute('data-v') === v; achou = achou || s; b.setAttribute('aria-checked', s ? 'true' : 'false'); b.tabIndex = s ? 0 : -1; });
      if (!achou && g.firstChild) g.firstChild.tabIndex = 0;
      c.classList.toggle('nc-em-fora-da-lista', !achou && v !== '');
    }
    c.classList.add('nc-em-campo--escolha');
    c.querySelector('.t-Form-inputContainer').insertBefore(g, c.querySelector('.t-Form-inputContainer').firstChild);
    $('#' + id).on('change', marcar);
    marcar();
    return marcar;
  }
  function opcoesDaLista(id) {
    var s = $id(id); if (!s || !s.options) return [];
    var l = [].filter.call(s.options, function (o) { return o.value !== ''; }).map(function (o) { return { v: o.value, rot: o.text.trim().replace(/^(\d+)\s+(Ano|Anos|Mês|Meses)$/i, function (m, n, u) { return n + ' ' + u.toLowerCase(); }) }; });
    /* prazos em ordem de tamanho (6 meses, 1 ano, 2 anos), como se lê */
    if (l.length && l.every(function (o) { return meses(o.rot) != null; })) l.sort(function (a, b) { return meses(a.rot) - meses(b.rot); });
    return l;
  }
  /* "6 Meses" → 6; "1 Ano" → 12; "2 anos" → 24 */
  function meses(t) { var m = /(\d+)\s*(ano|m[eê]s)/i.exec(t || ''); return m ? +m[1] * (/ano/i.test(m[2]) ? 12 : 1) : null; }
  function montarParecer(reg) {
    if (!reg) return;
    reg.classList.add('nc-em-sec', 'nc-em-parecer');
    cabecalho(reg, 'Parecer e ASO', PARECER);
    var corpo = el('div', 'nc-em-parecer-corpo');
    reg.querySelector('.t-Region-body').appendChild(corpo);

    /* o resultado, grande */
    var br = el('div', 'nc-em-linha nc-em-linha--resultado'); corpo.appendChild(br);
    mover('P19_RESULT_EXAME', br, 'nc-em-campo--resultado');
    escolhas('P19_RESULT_EXAME', RESULTADOS, true);

    /* a data do resultado e a validade (com o "vale até") */
    var bdv = el('div', 'nc-em-linha nc-em-linha--2'); corpo.appendChild(bdv);
    mover('P19_DT_RESULTADO_ASO', bdv);
    mover('P19_VAL_ASO', bdv);
    escolhas('P19_VAL_ASO', opcoesDaLista('P19_VAL_ASO'));

    /* o nº do ASO e se foi feito na empresa */
    var ba = el('div', 'nc-em-linha nc-em-linha--2'); corpo.appendChild(ba);
    mover('P19_NUM_ATESTADO', ba);
    mover('P19_FEITO_LOJA', ba);
    escolhas('P19_FEITO_LOJA', opcoesDaLista('P19_FEITO_LOJA'));

    /* conduta e procedimento */
    var bc = el('div', 'nc-em-linha'); corpo.appendChild(bc);
    mover('P19_CONDUTA', bc); contador('P19_CONDUTA');
    var bp = el('div', 'nc-em-linha nc-em-linha--2'); corpo.appendChild(bp);
    mover('P19_COD_PROCEDIMENTO', bp);
    mover('P19_OBS_PROCEDIMENTO', bp);

    /* os médicos: o do trabalho e o coordenador (CRM e endereço numa linha) */
    var bm = bloco(corpo, 'Médicos', 'nc-em-bloco--medicos');
    var gm = el('div', 'nc-em-linha nc-em-linha--2'); bm.appendChild(gm);
    mover('P19_MEDICO_AUX', gm);
    mover('P19_COD_MEDICO_COORDENADOR', gm);
    var guarda = el('div', 'nc-em-guardados'); bm.appendChild(guarda);   /* CRM, endereço, bairro, CEP: só leitura */
    ['P19_CRM_MEDICO_COORDENADOR', 'P19_END_MEDICO_COORDENADOR', 'P19_BAIRRO_MEDICO_COORDENADOR', 'P19_CEP_MEDICO_COORDENADOR'].forEach(function (id) { var c = cx(id); if (c) guarda.appendChild(c); });
    var coord = cx('P19_COD_MEDICO_COORDENADOR');
    if (coord) coord.querySelector('.t-Form-inputContainer').appendChild(el('p', 'nc-em-coord'));
    /* o que sobrou no grid da região (algum campo novo que o desenho não conhece) vai para o fim */
    [].forEach.call(reg.querySelectorAll('.t-Region-body > .container .t-Form-fieldContainer'), function (c) { if (!c.closest('.nc-em-guardados')) { var o = el('div', 'nc-em-linha'); o.appendChild(c); corpo.appendChild(o); } });
    esvaziar(reg);
  }
  function derivadosParecer() {
    /* "vale até" = data do resultado + validade */
    var dr = dataBR(texto('P19_DT_RESULTADO_ASO')), sel = $id('P19_VAL_ASO');
    var mm = sel && sel.selectedIndex >= 0 ? meses(sel.options[sel.selectedIndex].text) : null;
    var cVal = cx('P19_VAL_ASO');
    if (cVal) {
      var n = cVal.querySelector('.nc-em-vale');
      if (!n) { n = el('p', 'nc-em-vale'); cVal.querySelector('.t-Form-inputContainer').appendChild(n); }
      if (dr && mm) { var f = new Date(dr.getFullYear(), dr.getMonth() + mm, dr.getDate()); n.innerHTML = 'Vale até <b>' + dd(f) + '</b>'; n.setAttribute('data-vencido', f < hoje() ? 'sim' : 'nao'); }
      else n.textContent = dr ? 'Escolha a validade' : 'Preencha a data do resultado';
    }
    /* a data do resultado diferente da data do exame: avisa e oferece a do exame */
    var dx = dataBR(texto('P19_DATA_ATUAL')), cDt = cx('P19_DT_RESULTADO_ASO');
    if (cDt) {
      var a = cDt.querySelector('.nc-em-difere');
      var difere = dx && (!dr || dd(dr) !== dd(dx));
      if (!difere) { if (a) a.remove(); }
      else {
        if (!a) { a = el('p', 'nc-em-difere'); cDt.querySelector('.t-Form-inputContainer').appendChild(a); }
        a.innerHTML = (dr ? 'Diferente da data do exame. ' : '') + '<button type="button" class="nc-em-usar">Usar ' + dd(dx) + '</button>';
        a.querySelector('button').onclick = function () { if (cDt.closest('.apex_disabled')) return; apex.item('P19_DT_RESULTADO_ASO').setValue(dd(dx)); sujo(true); derivadosParecer(); contar(cDt.closest('.nc-em-sec')); };
      }
    }
    /* o coordenador: CRM · endereço · bairro · CEP numa linha */
    var p = document.querySelector('.nc-em-coord');
    if (p) {
      var crm = texto('P19_CRM_MEDICO_COORDENADOR'), end = [texto('P19_END_MEDICO_COORDENADOR'), texto('P19_BAIRRO_MEDICO_COORDENADOR'), texto('P19_CEP_MEDICO_COORDENADOR') ? 'CEP ' + texto('P19_CEP_MEDICO_COORDENADOR') : ''].filter(Boolean);
      p.innerHTML = crm || end.length ? (crm ? '<b>CRM ' + esc(crm) + '</b>' : '') + (end.length ? '<span>' + esc(end.join(', ')) + '</span>' : '') : '';
      p.hidden = !(crm || end.length);
    }
  }
  function hoje() { var n = new Date(); return new Date(n.getFullYear(), n.getMonth(), n.getDate()); }

  /* ═══ [E8] O RODAPÉ: EXAMES, RELATÓRIO ASO, SALVAR ═══════════════════════════════════════
     Os BOTÕES ORIGINAIS são mudados para o rodapé da janela (fica sempre à vista): continuam
     com o mesmo id e as mesmas ações (o Salvar valida e grava; o Relatório ASO usa o que está
     GRAVADO — por isso o aviso quando há alteração não salva).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var bSalvar, bIniciar, rodape, estado, falta, SUJO = false;
  function botaoPorTexto(re) { return [].filter.call(document.querySelectorAll('#informacoes button.t-Button, #informacoes .t-Region-buttons button'), function (b) { return re.test(b.textContent); })[0]; }
  function montarRodape(onde) {
    /* exame já gravado: SAVE ("Salvar"); exame novo: INSERT ("Criar") — o APEX mostra só um */
    bSalvar = $id('SAVE') || $id('INSERT') || botaoPorTexto(/^\s*(salvar|criar)\s*$/i);
    var bRel = botaoPorTexto(/relat[oó]rio\s+aso/i), bEx = botaoPorTexto(/^\s*exames\s*$/i);
    bIniciar = botaoPorTexto(/iniciar\s+atendimento/i);
    rodape = el('div', 'nc-em-rodape');
    var esq = el('div', 'nc-em-rodape-esq'), meio = el('div', 'nc-em-rodape-meio'), dir = el('div', 'nc-em-rodape-dir');
    falta = el('p', 'nc-em-falta'); meio.appendChild(falta);
    estado = el('p', 'nc-em-estado'); estado.setAttribute('aria-live', 'polite'); meio.appendChild(estado);
    [[bEx, 'frasco'], [bRel, 'imprimir']].forEach(function (x) { if (!x[0]) return; x[0].classList.add('nc-em-bt'); x[0].title = x[0].textContent.trim(); x[0].insertAdjacentHTML('afterbegin', ic(x[1])); esq.appendChild(x[0]); });
    /* outro botão que a região tenha (algum que a página ganhe depois) vai junto */
    [].forEach.call(document.querySelectorAll('#informacoes .t-Region-buttons button.t-Button'), function (b) { if (b !== bSalvar && b !== bRel && b !== bEx && b !== bIniciar) { b.classList.add('nc-em-bt'); esq.appendChild(b); } });
    if (bSalvar) {
      bSalvar.classList.add('nc-em-bt', 'nc-em-bt--salvar');
      var l = bSalvar.querySelector('.t-Button-label'); if (l) l.textContent = 'Salvar exame';
      [].forEach.call(bSalvar.querySelectorAll('.t-Icon, .fa'), function (i) { i.remove(); });
      bSalvar.insertAdjacentHTML('afterbegin', ic('salvar'));
      bSalvar.title = 'Salvar (' + (/Mac|iPhone|iPad/.test(navigator.platform) ? '⌘' : 'Ctrl+') + 'S)';
      dir.appendChild(bSalvar);
    }
    rodape.appendChild(esq); rodape.appendChild(meio); rodape.appendChild(dir);
    onde.appendChild(rodape);
    sujo(false);
  }
  /* o que o servidor exige no Salvar (validações da página): avisa antes, no rodapé */
  var EXIGE = [['P19_COD_PROCEDIMENTO', 'o procedimento'], ['P19_RESULT_EXAME', 'o resultado (Apto ou Inapto)']];
  function faltando() {
    if (!falta) return;
    var f = EXIGE.filter(function (x) { return $id(x[0]) && !preenchido(x[0]); }).map(function (x) { return x[1]; });
    falta.textContent = f.length ? 'Para salvar, falta ' + f.join(' e ') : '';
    EXIGE.forEach(function (x) { var c = cx(x[0]); if (c) c.classList.add('nc-em-exigido'); });
  }
  function sujo(s) {
    SUJO = s; if (!estado) return;
    estado.setAttribute('data-sujo', s ? 'sim' : 'nao');
    estado.innerHTML = s ? '<span class="nc-em-ponto" aria-hidden="true"></span>Alterações não salvas<span class="nc-em-dica"> · o Relatório ASO usa o que está salvo</span>' : '';
  }

  /* ═══ [E9] TECLADO: ENTER, CTRL+S E O JEITO RÁPIDO DE DIGITAR ════════════════════════════
     • Enter num campo de texto vai para o próximo (na ordem da ficha); no texto livre, Enter
       continua pulando linha.
     • Ctrl+S / ⌘S aperta o Salvar.
     • ARRUMAR roda ANTES das ações dinâmicas (fase de captura do "change"): o banco recebe
       "1,70" mesmo que o médico digite "170" — o IMC sai certo.
     CUIDADO  o formato que o banco espera: vírgula decimal, altura em metros, pressão "120/80".
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ARRUMAR = {
    P19_ALTURA: function (t) { t = t.replace(/\s/g, '').replace('.', ','); if (/^\d{3}$/.test(t) && +t >= 50 && +t <= 250) return t.charAt(0) + ',' + t.slice(1); return t; },
    P19_PESO: function (t) { return t.replace(/\s/g, '').replace('.', ','); },
    P19_TEMPERATURA: function (t) { t = t.replace(/\s/g, '').replace('.', ','); if (/^\d{3}$/.test(t) && +t >= 340 && +t <= 429) return t.slice(0, 2) + ',' + t.charAt(2); return t; },
    P19_PRESSAO_ARTERIAL: function (t) {
      t = t.replace(/\s/g, '').replace(/[xX\\\-_.,;:]/g, '/');
      if (/^\d{4,6}$/.test(t)) { var s = t.length === 4 ? 2 : 3; return t.slice(0, s) + '/' + t.slice(s); }
      return t;
    }
  };
  function teclado(raiz) {
    document.addEventListener('change', function (ev) {
      var f = ev.target && ARRUMAR[ev.target.id]; if (!f) return;
      var novo = f(ev.target.value || ''); if (novo !== ev.target.value) ev.target.value = novo;
    }, true);
    raiz.addEventListener('keydown', function (ev) {
      if (ev.key !== 'Enter' || ev.shiftKey || ev.altKey || ev.ctrlKey || ev.metaKey) return;
      var t = ev.target;
      if (!t || t.tagName !== 'INPUT' || !/^(text|number|tel)$/i.test(t.type) || t.classList.contains('apex-item-popup-lov') || t.classList.contains('hasDatepicker')) return;
      ev.preventDefault();
      var todos = [].filter.call(raiz.querySelectorAll('input.apex-item-text, select.apex-item-select, textarea'), function (e) { return e.offsetParent && !e.readOnly && !e.disabled && !e.closest('.apex_disabled'); });
      var i = todos.indexOf(t);
      /* sem disparar "change" à mão: ao sair do campo o navegador dispara o dele, que passa
         pelo ARRUMAR antes da ação dinâmica (um "change" do jQuery pularia o ARRUMAR e o banco
         receberia "70.5" — erro no cálculo do IMC) */
      if (i >= 0 && todos[i + 1]) { todos[i + 1].focus(); if (todos[i + 1].select && todos[i + 1].tagName === 'INPUT') todos[i + 1].select(); }
    });
    document.addEventListener('keydown', function (ev) {
      if ((ev.ctrlKey || ev.metaKey) && !ev.altKey && (ev.key === 's' || ev.key === 'S')) {
        ev.preventDefault();
        if (!bSalvar || bSalvar.disabled || bSalvar.closest('.apex_disabled') || bSalvar.classList.contains('apex_disabled')) return;
        /* sai do campo (o navegador dispara o "change" e as ações dinâmicas, como o IMC) e
           espera as chamadas ao banco terminarem — no máximo 3 s — antes de apertar o Salvar */
        if (document.activeElement && document.activeElement.blur) document.activeElement.blur();
        var t0 = Date.now();
        (function esperar() { if ($.active > 0 && Date.now() - t0 < 3000) return setTimeout(esperar, 80); bSalvar.click(); })();
      }
    });
  }

  /* ═══ [E10] PRÉ-ATENDIMENTO (A TRAVA) ═══════════════════════════════════════════════════
     Quando o paciente está no pré-atendimento (P19_PRE_ATEND = 'S', processo "Pre-Atendimento"),
     a ação "Disable Tabs" desliga as regiões e os botões (classe apex_disabled) até o médico
     apertar "Iniciar Atendimento" (ação "Insere MT_CHAMADA_PACIENTE_STATUS": grava o início e
     liga tudo de novo). O desenho põe esse botão ORIGINAL no aviso do alto, grande — é o
     primeiro passo da consulta — e o aviso some quando as regiões voltam.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function trava(aviso) {
    var regs = ['complementares', 'adicionais', 'wecker'].map($id).filter(Boolean);
    var ver = function () {
      var t = regs.some(function (r) { return r.classList.contains('apex_disabled'); });
      document.body.classList.toggle('nc-em-travado', t);
      aviso.hidden = !t;
    };
    aviso.innerHTML = ic('relogio') + '<div class="nc-em-aviso-txt"><p><b>Paciente no pré-atendimento.</b></p><p>Inicie o atendimento para liberar a ficha.</p></div>';
    if (bIniciar) {
      bIniciar.classList.add('nc-em-bt', 'nc-em-bt--iniciar');
      var l = bIniciar.querySelector('.t-Button-label'); if (l) l.textContent = 'Iniciar atendimento';
      bIniciar.insertAdjacentHTML('afterbegin', ic('play'));
      aviso.appendChild(bIniciar);
    } else aviso.querySelector('.nc-em-aviso-txt p + p').textContent = 'Os campos estão só para consulta.';
    ver();
    if (window.MutationObserver) regs.forEach(function (r) { new MutationObserver(ver).observe(r, { attributes: true, attributeFilter: ['class'] }); });
  }

  /* ═══ [E11] O MAESTRO ════════════════════════════════════════════════════════════════════
     [E1] A página é reconhecida pelas regiões e pelos itens (nunca pelo número do app): sem
     elas, o arquivo para aqui e a página fica como o APEX desenhou.
     CUIDADO  Roda depois das ações "ready" (a trava e os valores que o banco devolve).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function iniciar() {
    if (window.__ncExameMedico) return;
    var info = $id('informacoes'), ad = $id('adicionais'), wk = $id('wecker'), cp = $id('complementares');
    if (!info || !ad || !wk || !cp || !$id('P19_PESO') || !$id('P19_RESULT_EXAME')) return;
    window.__ncExameMedico = true;
    var corpoDlg = document.querySelector('.t-Dialog-body') || info.parentNode;
    var cabDlg = document.querySelector('.t-Dialog-header'), peDlg = document.querySelector('.t-Dialog-footer');
    document.body.classList.add('nc-em-ativo');

    var app = el('section', 'nc-em'); app.setAttribute('aria-label', 'Exame médico ocupacional');
    corpoDlg.insertBefore(app, corpoDlg.firstChild);

    /* o paciente: no alto da janela (fixo) no computador; no celular, rola com a ficha */
    var pac = el('header', 'nc-em-paciente');
    var estreito = window.matchMedia && window.matchMedia('(max-width: 720px)');
    var lugarPaciente = function () { if (estreito && estreito.matches || !cabDlg) app.insertBefore(pac, app.firstChild); else cabDlg.appendChild(pac); document.body.classList.toggle('nc-em-cab-fixo', pac.parentNode === cabDlg); };
    paciente(pac); lugarPaciente();
    if (estreito && estreito.addEventListener) estreito.addEventListener('change', lugarPaciente);

    var aviso = el('div', 'nc-em-aviso'); aviso.setAttribute('role', 'status'); aviso.hidden = true; app.appendChild(aviso);

    var grade = el('div', 'nc-em-corpo'), esq = el('div', 'nc-em-exame'), dir = el('div', 'nc-em-lado');
    grade.appendChild(esq); grade.appendChild(dir); app.appendChild(grade);

    /* a mudança de função (só no tipo M — a ação dinâmica de sempre mostra/esconde os campos) */
    var mud = el('section', 'nc-em-sec nc-em-mudanca');
    var funcaoHoje = texto('P19_FUNCAO');
    mud.innerHTML = '<header class="nc-em-sec-cab"><h2 class="nc-em-sec-tit">Mudança de função</h2></header>' +
      (funcaoHoje ? '<p class="nc-em-hoje">Hoje: <b>' + esc(nome(funcaoHoje)) + '</b>' + ic('seta') + '<span>vai para</span></p>' : '');
    var gmu = el('div', 'nc-em-grade nc-em-grade--4'); mud.appendChild(gmu);
    ['P19_CARGO_PROPOSTO', 'P19_FUNCAO_PROPOSTA', 'P19_FILIAL_PROPOSTA', 'P19_LOCAL_PRETENDIDO'].forEach(function (id) { mover(id, gmu); });
    esq.appendChild(mud);
    /* 04/10: no exame novo (sem ROWID) a página deixa escolher o tipo de exame (obrigatório; o
       tipo M mostra a mudança de função) e, quando vêm vazios, a data, a empresa e o paciente.
       A região de cadastro sai da vista: o que nela estiver EDITÁVEL vem para a ficha (o que é
       só leitura continua no alto, como antes). */
    var editaveis = ['P19_TIPO_EXAME', 'P19_DATA_ATUAL', 'P19_EMPRESA', 'P19_MATRICULA'].filter(function (id) {
      var e = $id(id); return e && cx(id) && e.type !== 'hidden' && !$id(id + '_DISPLAY') && !e.classList.contains('display_only');
    });
    if (editaveis.length) {
      var cad = el('section', 'nc-em-sec nc-em-cadastro', '<header class="nc-em-sec-cab"><h2 class="nc-em-sec-tit">Dados do exame</h2></header>');
      var gca = el('div', 'nc-em-grade nc-em-grade--4'); cad.appendChild(gca);
      editaveis.forEach(function (id) { mover(id, gca); });
      esq.insertBefore(cad, mud);
    }
    var verMudanca = function () { mud.hidden = ![].some.call(gmu.children, function (c) { return c.style.display !== 'none'; }); };
    verMudanca();

    esq.appendChild(ad); montarVitais(ad);
    esq.appendChild(wk); montarComplementares(wk);
    dir.appendChild(cp); montarParecer(cp);

    montarRodape(peDlg || app);
    if (!peDlg) rodape.classList.add('nc-em-rodape--solto');
    /* o que restou da região de cadastro e as abas (vazias) saem da vista — ficam na página */
    info.classList.add('nc-em-guardada');
    var abas = document.querySelector('.t-TabsRegion'); if (abas) abas.classList.add('nc-em-guardada');

    trava(aviso);
    teclado(app);
    var tudo = function () { referenciasVitais(); derivadosParecer(); [ad, wk, cp].forEach(contar); verMudanca(); faltando(); };
    tudo();
    /* alterações do médico (não as que as ações dinâmicas fazem) deixam a ficha "não salva" */
    app.addEventListener('input', function (ev) { if (!ev.isTrusted) return; sujo(true); var r = ev.target.closest && ev.target.closest('.nc-em-sec'); if (r) contar(r); });
    app.addEventListener('change', function (ev) { if (ev.isTrusted) sujo(true); setTimeout(tudo, 0); });
    $(document).on('ajaxComplete', function () { setTimeout(tudo, 0); });
    /* as listas de busca (Popup LOV) escrevem pelo setValue: "change" sem isTrusted */
    $('#P19_COD_PROCEDIMENTO, #P19_MEDICO_AUX, #P19_CARGO_PROPOSTO, #P19_FUNCAO_PROPOSTA, #P19_FILIAL_PROPOSTA, #P19_LOCAL_PRETENDIDO').on('change', function () { if (document.activeElement && app.contains(document.activeElement)) sujo(true); setTimeout(tudo, 0); });
    /* o banco devolve valores depois do "ready" (o paciente pode chegar depois) */
    $(document).one('ajaxStop', function () { paciente(pac); tudo(); });
  }

  /* começa no que vier primeiro: o fim do "ready" do APEX ou a página já pronta */
  if (window.apex && apex.jQuery) {
    $(window).on('apexreadyend', function () { setTimeout(iniciar, 0); });
    if (document.readyState === 'complete') setTimeout(iniciar, 300);
    else window.addEventListener('load', function () { setTimeout(iniciar, 300); });
  }
})();
