/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CONSULTA DE BENEFÍCIOS  —  o "arrumador" da página (JavaScript)               ║
   ║  App 300 (Portal do Colaborador) · Página 89 · Cadastro de Benefícios (a consulta)       ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: BENEFICIOSCONSULTA-MANUTENCAO.md. O mesmo jeito da janela "Benefícios"
   da Ficha (Natcorp_Ficha [J9]): ícone por tipo, ativos na frente, encerrados recolhidos.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   O colaborador quer saber: QUAIS benefícios ele tem, QUANTO vale cada um e desde quando.
   Quase sempre no celular, e muitos leem com dificuldade. Então:
     • "Seus benefícios": um cartão por benefício (as linhas do mesmo benefício juntas), com o
       desenho do tipo, o valor grande, a conta quando há mais de um lançamento ("30 × R$ 20,00")
       e "Desde 1º de março de 2018". Os que terminaram ficam em "Ver os que terminaram (N)";
     • "Vale-transporte": um cartão por linha (ônibus, rodoviário…) com a conta em palavras —
       "2 passagens por dia × 21 dias × R$ 3,85" — e o total do mês somado no alto;
     • data de fim em 2090 ou depois conta como "sem fim" (o cadastro usa 2094, 2099);
     • números de código e preços que vieram grudados no nome saem da vista
       ("1 - Plano Silver - R$ 54,90" → "Plano Silver");
     • "Ver como tabela" mostra os relatórios originais (com as abas Benefícios/Transporte).

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada e não muda o que aparece: os dados são LIDOS dos dois relatórios
     interativos pelo TÍTULO de cada coluna. O cartão do colaborador é a peça global
     (Natcorp_Colab). Tirou as URLs: volta o de antes.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 89 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_BeneficiosConsulta.js
     Página 89 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_BeneficiosConsulta.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [B1] Como a página é reconhecida                                      CUIDADO
     [B2] Os textos, os acentos e os desenhos                              PODE MEXER
     [B3] Ferramentas (valores, datas, nomes)
     [B4] Lê os dois relatórios (pelos títulos das colunas)                CUIDADO
     [B5] Os cartões
     [B6] O desenho e o modo tabela
     [B7] O maestro
*/
(function () {
  'use strict';
  if (window.__ncBeneficiosConsulta || !window.apex || !window.apex.jQuery) return;

  /* ═══ [B1] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════════
     CUIDADO  pelos itens ocultos P89_EMP e P89_MAT. Os relatórios (.a-IRR) são montados pelo
              JS deles DEPOIS deste arquivo: são procurados na montagem, com novas tentativas.
              Qual é qual: o de Benefícios tem a coluna "Benefício"; o de Transporte, "Meio
              Locomoção".
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  if (!$id('P89_EMP') || !$id('P89_MAT')) return;
  window.__ncBeneficiosConsulta = true;
  var $ = window.apex.jQuery;

  /* ═══ [B2] OS TEXTOS, OS ACENTOS E OS DESENHOS ═══════════════════════════════════════════ */
  var T = {
    titulo: 'Seus benefícios',
    resumo: function (a, e) { return (a === 1 ? '1 benefício ativo' : a + ' benefícios ativos'); },
    nenhum: 'Você não tem benefícios ativos agora.',
    terminaram: function (n) { return 'Ver os que terminaram (' + n + ')'; },
    esconderTerminaram: 'Esconder os que terminaram',
    terminou: function (d) { return 'Terminou em ' + d; },
    desde: function (d) { return 'Desde ' + d; },
    ate: function (d) { return 'até ' + d; },
    semValor: 'Sem valor',
    cartao: function (n) { return 'Cartão nº ' + n; },
    vt: 'Vale-transporte',
    vtResumo: function (n) { return n === 1 ? '1 passagem cadastrada' : n + ' passagens cadastradas'; },
    vtTotal: 'Total do mês',
    vtConta: function (porDia, dias, preco) { return porDia + (porDia === 1 ? ' passagem' : ' passagens') + ' por dia × ' + dias + ' dias × ' + preco; },
    vtPreco: 'Passagem',
    vtPorDia: function (n) { return n + (n === 1 ? ' por dia' : ' por dia'); },
    fretado: 'Fretado',
    escola: 'Escola',
    verTabela: 'Ver como tabela',
    verCartoes: 'Ver como cartões'
  };
  /* palavras que o cadastro manda sem acento (a primeira letra segue a do cadastro) */
  var ACENTOS = { beneficio: 'benefício', beneficios: 'benefícios', medico: 'médico', medica: 'médica', odontologico: 'odontológico',
    previdencia: 'previdência', alimentacao: 'alimentação', refeicao: 'refeição', locacao: 'locação', veiculo: 'veículo',
    basica: 'básica', rodoviario: 'rodoviário', saude: 'saúde', odontologica: 'odontológica', familia: 'família', vitalicio: 'vitalício',
    onibus: 'ônibus', metro: 'metrô' };
  /* o desenho pelo nome — a mesma regra da Ficha (tipoBeneficio): a primeira que casar vence */
  function tipoBeneficio(txt) {
    var s = sem(txt);
    if (/odonto|dent/.test(s)) return 'dente';
    if (/saude|medic|unimed|hosp|amil|bradesco saude|sulamerica|hapvida|vitallis|medisantas|clinic/.test(s)) return 'saude';
    if (/cesta/.test(s)) return 'cesta';
    if (/refei|restaur|ticket|aliment|\bva\b|\bvr\b|sodexo|alelo|pluxee|vale.?refe/.test(s)) return 'talher';
    if (/transporte|\bvt\b|onibus|bhbus|rodovi|metro|passe|mobilidade|serrana/.test(s)) return 'onibus';
    if (/carro|veicul|combust|frota|estaciona/.test(s)) return 'carro';
    if (/academia|gym|wellhub|gympass|totalpass|fitness/.test(s)) return 'halter';
    if (/previd|aposent|pgbl|vgbl/.test(s)) return 'cofrinho';
    if (/seguro/.test(s)) return 'escudo';
    if (/creche|escola|educa|bolsa|curso|faculdade|idioma/.test(s)) return 'capelo';
    if (/campanha|premio|bonus/.test(s)) return 'megafone';
    return 'presente';
  }
  var ICB = {
    saude: '<path d="M20.5 8.8c0 5.2-8.5 11.2-8.5 11.2S3.5 14 3.5 8.8A4.3 4.3 0 0 1 12 6.6a4.3 4.3 0 0 1 8.5 2.2z"/><path d="M6.5 12h3l1.5-2.5 2 4.5 1.5-2h3"/>',
    dente: '<path d="M7.5 3.5c-2.5 0-4 2-4 4.5 0 3 1.5 4 2 7s.8 5.5 2.3 5.5c1.6 0 1.6-5 4.2-5s2.6 5 4.2 5c1.5 0 1.8-2.5 2.3-5.5s2-4 2-7c0-2.5-1.5-4.5-4-4.5-1.8 0-2.7 1-4.5 1s-2.7-1-4.5-1z"/>',
    talher: '<path d="M7 3v7.5M4.5 3v5a2.5 2.5 0 0 0 5 0V3M7 10.5V21"/><path d="M17 21V3c-2.2 1-3.5 3.5-3.5 7v3.5H17"/>',
    cesta: '<path d="M3 10h18l-1.8 9a1.5 1.5 0 0 1-1.5 1.2H6.3a1.5 1.5 0 0 1-1.5-1.2z"/><path d="M8 10l3-6M16 10l-3-6M9 14v3M12 14v3M15 14v3"/>',
    onibus: '<rect x="4.5" y="3.5" width="15" height="15" rx="2.5"/><path d="M4.5 11h15M8 18.5v2M16 18.5v2M8 15h.01M16 15h.01M8 7h8"/>',
    carro: '<path d="M4 16.5V12l2-5a2 2 0 0 1 1.9-1.3h8.2A2 2 0 0 1 18 7l2 5v4.5"/><rect x="3" y="12" width="18" height="5" rx="1.5"/><path d="M6 17v2.5M18 17v2.5M7 14.5h.01M17 14.5h.01"/>',
    halter: '<path d="M6.5 7v10M17.5 7v10M3.5 9.5v5M20.5 9.5v5M6.5 12h11"/>',
    cofrinho: '<path d="M4.5 11.5c0-3.3 3.1-6 7-6 1.4 0 2.8.4 3.9 1l2.6-1v3c.9.8 1.5 1.8 1.8 3H21v3h-1.3c-.5 1.4-1.6 2.6-3 3.3V20h-3v-1.5a8 8 0 0 1-2.6 0V20h-3v-2.1c-2.2-1.1-3.6-3.2-3.6-6.4z"/><path d="M15.5 10.5h.01M9.5 8.5h3"/>',
    escudo: '<path d="M12 3l7.5 3v5.5c0 4.6-3.2 8.2-7.5 9.5-4.3-1.3-7.5-4.9-7.5-9.5V6z"/><path d="M9 12l2 2 4-4"/>',
    capelo: '<path d="M2.5 9L12 4.5 21.5 9 12 13.5z"/><path d="M6.5 11v4.5c1.5 1.3 3.5 2 5.5 2s4-.7 5.5-2V11M21.5 9v5"/>',
    megafone: '<path d="M3.5 10v4a1 1 0 0 0 1 1H7l7 4V5L7 9H4.5a1 1 0 0 0-1 1z"/><path d="M17.5 9a4 4 0 0 1 0 6M7.5 15l1 5h2.5l-1-5"/>',
    presente: '<rect x="3.5" y="8" width="17" height="4" rx="1"/><path d="M5 12v7.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V12M12 8v12.5M12 8S10.5 3.5 8 4.5 9 8 12 8zM12 8s1.5-4.5 4-3.5S15 8 12 8z"/>',
    seta: '<path d="m9 5 7 7-7 7"/>',
    calendario: '<rect x="4" y="5.5" width="16" height="14.5" rx="2"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M9 10v9"/>',
    cartoes: '<rect x="4" y="4.5" width="16" height="6.5" rx="1.8"/><rect x="4" y="13" width="16" height="6.5" rx="1.8"/>'
  };

  /* ═══ [B3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/ /g, ' ').replace(/\s+/g, ' ').trim(); }
  function sem(t) { return limpo(t).toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  function vazio(t) { return !t || /^\s*(-|—|null)\s*$/i.test(t); }
  function svg(n, cls) { return '<svg class="nc-bc-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + ICB[n] + '</svg>'; }
  var MIUDAS = /^(da|de|do|das|dos|e|em|na|no|a|o|ao|com|para|por)$/;
  function acentuar(t) {
    return String(t || '').replace(/[A-Za-zÀ-ÿ]+/g, function (w) {
      var a = ACENTOS[w.toLowerCase()]; if (!a) return w;
      return w.charAt(0) === w.charAt(0).toUpperCase() ? a.charAt(0).toUpperCase() + a.slice(1) : a;
    });
  }
  /* "1 - Plano Silver - R$ 54,90" → "Plano Silver"; "Ref_Consultores" → "Ref Consultores" */
  function nome(t) {
    t = limpo(t).replace(/^\s*[\w.]+\s+-\s+/, '').replace(/_/g, ' ');
    t = t.replace(/\s*-?\s*(R\$\s*)?\d{1,3}(\.\d{3})*,\d{2}\s*$/, '').replace(/\s*-\s*$/, '');
    t = acentuar(t);
    return t.replace(/[^\s\-\/().]+/g, function (w, i) { return i > 0 && MIUDAS.test(w.toLowerCase()) ? w.toLowerCase() : w; });
  }
  /* "2.987,00" / "R$3,85" → número; vazio → null */
  function num(t) { if (vazio(t)) return null; var s = String(t).replace(/[^\d,.-]/g, ''); if (!s) return null; var n = parseFloat(s.replace(/\./g, '').replace(',', '.')); return isNaN(n) ? null : n; }
  function reais(n) { return 'R$ ' + n.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 }); }
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  function data(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function extenso(d) { return (d.getDate() === 1 ? '1º' : d.getDate()) + ' de ' + MESES[d.getMonth()] + ' de ' + d.getFullYear(); }
  function hoje() { var h = new Date(); h.setHours(0, 0, 0, 0); return h; }
  /* fim: sem data ou ano 2090+ = sem fim; no passado = terminou */
  function fimDe(t) { var d = data(t); if (!d || d.getFullYear() >= 2090) return { tipo: 'aberto' }; return { tipo: d < hoje() ? 'passado' : 'futuro', d: d }; }

  /* ═══ [B4] LÊ OS DOIS RELATÓRIOS (PELOS TÍTULOS DAS COLUNAS) ═════════════════════════════
     CUIDADO  as colunas são achadas pelo TÍTULO (sem acento, minúsculas), ligadas às células
              pelo td[headers]. Mudou um título no APEX? Ajuste aqui.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function relatorio(ir) {
    var col = {};
    [].forEach.call(ir.querySelectorAll('th[id]'), function (th) { var k = sem(th.textContent); if (k && !col[k]) col[k] = th.id; });
    var linhas = [].slice.call(ir.querySelectorAll('table.a-IRR-table tr')).filter(function (tr) { return tr.querySelector('td[headers]'); });
    return { col: col, linhas: linhas.map(function (tr) {
      return function (titulo) { var h = col[titulo]; var td = h && tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; };
    }) };
  }
  var IRB = null, IRT = null;
  function acharRelatorios() {
    [].forEach.call(document.querySelectorAll('.a-IRR'), function (ir) {
      var t = [].map.call(ir.querySelectorAll('th[id]'), function (th) { return sem(th.textContent); });
      if (t.indexOf('meio locomocao') >= 0) IRT = ir; else if (t.indexOf('beneficio') >= 0) IRB = ir;
    });
    return IRB || IRT;
  }
  function lerBeneficios() {
    if (!IRB) return [];
    var r = relatorio(IRB), mapa = {}, ordem = [];
    r.linhas.forEach(function (c) {
      var fam = c('beneficio'); if (!fam) return;
      var k = sem(fam);
      if (!mapa[k]) { mapa[k] = { nome: nome(fam), linhas: [] }; ordem.push(k); }
      mapa[k].linhas.push({ tipo: nome(c('tipo')), valor: num(c('valor')), qtd: num(c('quantidade')) || 1, total: num(c('valor total')),
        cartao: vazio(c('nº cartao')) ? '' : c('nº cartao'), ini: data(c('data de inicio')), fim: fimDe(c('data fim')) });
    });
    return ordem.map(function (k) {
      var b = mapa[k];
      b.ativo = b.linhas.some(function (l) { return l.fim.tipo !== 'passado'; });
      var vale = b.linhas.filter(function (l) { return b.ativo ? l.fim.tipo !== 'passado' : true; });
      b.total = vale.reduce(function (s, l) { var v = l.total !== null ? l.total : (l.valor !== null ? l.valor * l.qtd : null); return v === null ? s : (s || 0) + v; }, null);
      b.desde = b.linhas.map(function (l) { return l.ini; }).filter(Boolean).sort(function (a, c) { return a - c; })[0] || null;
      var futuros = b.linhas.map(function (l) { return l.fim; }).filter(function (f) { return f.tipo === 'futuro'; }).sort(function (a, c) { return a.d - c.d; });
      var passados = b.linhas.map(function (l) { return l.fim; }).filter(function (f) { return f.tipo === 'passado'; }).sort(function (a, c) { return c.d - a.d; });
      b.ate = b.ativo ? (futuros[0] && futuros[0].d) : null;
      b.terminou = b.ativo ? null : (passados[0] && passados[0].d);
      b.cartoes = b.linhas.map(function (l) { return l.cartao; }).filter(Boolean).filter(function (x, i, a) { return a.indexOf(x) === i; });
      b.ic = tipoBeneficio(b.nome + ' ' + b.linhas.map(function (l) { return l.tipo; }).join(' '));
      b.vale = vale;
      return b;
    });
  }
  function lerTransporte() {
    if (!IRT) return [];
    var r = relatorio(IRT);
    return r.linhas.map(function (c) {
      var fretado = /^sim/i.test(c('fretado')), escola = /^sim/i.test(c('escola'));
      return {
        nome: nome(c('meio locomocao')), empresa: nome(c('empresa vale')),
        preco: num(c('valor unitario')), porDia: num(c('utilizacao diaria')), dias: num(c('dias compras')),
        total: num(c('valor total')), cartao: vazio(c('nº cartao')) ? '' : c('nº cartao'),
        ini: data(c('inicio de validade')), fim: fimDe(c('fim de validade')), fretado: fretado, escola: escola,
        obs: vazio(c('observacoes')) ? '' : c('observacoes')
      };
    }).filter(function (t) { return t.nome; });
  }

  /* ═══ [B5] OS CARTÕES ════════════════════════════════════════════════════════════════════ */
  function cartaoBeneficio(b) {
    var contas = b.vale.length > 1 || b.vale.some(function (l) { return l.qtd > 1; });
    /* rótulo de cada lançamento: o tipo, quando diferencia; senão "Valor 1", "Valor 2" */
    var tiposIguais = b.vale.every(function (l) { return sem(l.tipo) === sem(b.vale[0].tipo); });
    var linhas = contas ? '<ul class="nc-bc-contas">' + b.vale.map(function (l, i) {
      var v = l.total !== null ? l.total : (l.valor !== null ? l.valor * l.qtd : null);
      var rot = !l.tipo || (tiposIguais && b.vale.length > 1) ? 'Valor ' + (i + 1) : l.tipo;
      return '<li><span>' + esc(rot) + '</span><b>' + (l.qtd > 1 && l.valor !== null ? esc(l.qtd + ' × ' + reais(l.valor) + ' = ') : '') + (v !== null ? esc(reais(v)) : '—') + '</b></li>';
    }).join('') + '</ul>' : '';
    var tipo1 = !contas && b.vale[0] && b.vale[0].tipo && sem(b.vale[0].tipo) !== sem(b.nome) ? b.vale[0].tipo : '';
    var datas = b.ativo ? [b.desde ? T.desde(extenso(b.desde)) : '', b.ate ? T.ate(extenso(b.ate)) : ''].filter(Boolean).join(' ') : (b.terminou ? T.terminou(extenso(b.terminou)) : '');
    var valor = b.total !== null && b.total > 0 ? '<b class="nc-bc-valor">' + esc(reais(b.total)) + '</b>' : '<span class="nc-bc-semvalor">' + esc(T.semValor) + '</span>';
    return '<li class="nc-bc-card' + (b.ativo ? '' : ' nc-bc-card--fim') + '">' +
      '<span class="nc-bc-desenho nc-bc-tom--' + b.ic + '" aria-hidden="true">' + svg(b.ic) + '</span>' +
      '<div class="nc-bc-txt">' +
        '<h3>' + esc(b.nome) + '</h3>' +
        (tipo1 ? '<p class="nc-bc-sub">' + esc(tipo1) + '</p>' : '') +
        valor + linhas +
        (datas ? '<p class="nc-bc-datas">' + svg('calendario') + '<span>' + esc(datas) + '</span></p>' : '') +
        (b.cartoes.length ? '<p class="nc-bc-sub">' + esc(b.cartoes.map(T.cartao).join(' · ')) + '</p>' : '') +
      '</div></li>';
  }
  function cartaoTransporte(t) {
    var conta = t.porDia && t.dias && t.preco !== null && t.total !== null && Math.abs(t.porDia * t.dias * t.preco - t.total) < 0.05;
    var ativo = t.fim.tipo !== 'passado';
    var datas = ativo ? [t.ini ? T.desde(extenso(t.ini)) : '', t.fim.tipo === 'futuro' ? T.ate(extenso(t.fim.d)) : ''].filter(Boolean).join(' ') : T.terminou(extenso(t.fim.d));
    return '<li class="nc-bc-card' + (ativo ? '' : ' nc-bc-card--fim') + '">' +
      '<span class="nc-bc-desenho nc-bc-tom--onibus" aria-hidden="true">' + svg('onibus') + '</span>' +
      '<div class="nc-bc-txt">' +
        '<h3>' + esc(t.nome) + '</h3>' +
        (t.empresa && sem(t.empresa) !== sem(t.nome) ? '<p class="nc-bc-sub">' + esc(t.empresa) + '</p>' : '') +
        (t.total !== null ? '<b class="nc-bc-valor">' + esc(reais(t.total)) + '</b>' : '') +
        (conta ? '<p class="nc-bc-conta">' + esc(T.vtConta(t.porDia, t.dias, reais(t.preco))) + '</p>'
               : '<p class="nc-bc-conta">' + [t.preco !== null ? esc(T.vtPreco + ' ' + reais(t.preco)) : '', t.porDia ? esc(T.vtPorDia(t.porDia)) : ''].filter(Boolean).join(' · ') + '</p>') +
        ((t.fretado || t.escola) ? '<p class="nc-bc-etiquetas">' + (t.fretado ? '<span>' + esc(T.fretado) + '</span>' : '') + (t.escola ? '<span>' + esc(T.escola) + '</span>' : '') + '</p>' : '') +
        (datas ? '<p class="nc-bc-datas">' + svg('calendario') + '<span>' + esc(datas) + '</span></p>' : '') +
        (t.cartao ? '<p class="nc-bc-sub">' + esc(T.cartao(t.cartao)) + '</p>' : '') +
        (t.obs ? '<p class="nc-bc-obs">' + esc(t.obs) + '</p>' : '') +
      '</div></li>';
  }

  /* ═══ [B6] O DESENHO E O MODO TABELA ═════════════════════════════════════════════════════ */
  var CAIXA, VER_FIM = false;
  function desenhar() {
    var bs = lerBeneficios(), ts = lerTransporte();
    var at = bs.filter(function (b) { return b.ativo; }), fim = bs.filter(function (b) { return !b.ativo; });
    var tAt = ts.filter(function (t) { return t.fim.tipo !== 'passado'; }), tFim = ts.filter(function (t) { return t.fim.tipo === 'passado'; });
    var somaVT = tAt.reduce(function (s, t) { return t.total === null ? s : (s || 0) + t.total; }, null);
    var h = '';
    if (IRB) {
      h += '<section class="nc-bc-secao">' +
        '<header class="nc-bc-cab"><h2>' + esc(T.titulo) + '</h2><p>' + esc(T.resumo(at.length)) + '</p></header>' +
        (at.length ? '<ul class="nc-bc-lista">' + at.map(cartaoBeneficio).join('') + '</ul>' : '<p class="nc-bc-vazio">' + esc(T.nenhum) + '</p>') +
        (fim.length ? '<button type="button" class="nc-bc-mais" data-fim aria-expanded="' + VER_FIM + '">' + svg('seta') + '<span>' + esc(VER_FIM ? T.esconderTerminaram : T.terminaram(fim.length)) + '</span></button>' +
          '<ul class="nc-bc-lista nc-bc-lista--fim"' + (VER_FIM ? '' : ' hidden') + '>' + fim.map(cartaoBeneficio).join('') + '</ul>' : '') +
      '</section>';
    }
    if (IRT && ts.length) {
      h += '<section class="nc-bc-secao">' +
        '<header class="nc-bc-cab"><h2>' + esc(T.vt) + '</h2><p>' + esc(T.vtResumo(tAt.length)) + '</p>' +
          (somaVT !== null ? '<div class="nc-bc-soma"><span>' + esc(T.vtTotal) + '</span><b>' + esc(reais(somaVT)) + '</b></div>' : '') + '</header>' +
        '<ul class="nc-bc-lista">' + tAt.concat(tFim).map(cartaoTransporte).join('') + '</ul>' +
      '</section>';
    }
    CAIXA.querySelector('.nc-bc-conteudo').innerHTML = h;
  }
  var CHAVE_MODO = 'nc-bc-modo';
  function modo(m) {
    try { localStorage.setItem(CHAVE_MODO, m); } catch (e) { /* sem armazenamento */ }
    document.body.classList.toggle('nc-bc-tabela', m === 'tabela');
    [].forEach.call(document.querySelectorAll('.nc-bc-modo'), function (b) { b.hidden = b.getAttribute('data-modo') === m; });
  }

  /* ═══ [B7] O MAESTRO ═════════════════════════════════════════════════════════════════════ */
  var montado = false;
  function iniciar() {
    if (montado || !acharRelatorios()) return;
    montado = true;
    try {
      document.body.classList.add('nc-bc-ativo');
      /* a caixa entra antes da região das abas (Benefícios/Transporte), que fica por trás */
      var algum = IRB || IRT, raiz = algum.closest('.t-Region'), r = raiz;
      while (r && r.parentElement && r.parentElement.closest('.t-Region')) r = r.parentElement.closest('.t-Region');
      raiz = r || raiz;
      raiz.classList.add('nc-bc-original');
      CAIXA = el('div', 'nc-bc');
      CAIXA.innerHTML = '<div class="nc-bc-conteudo"></div>' +
        '<button type="button" class="nc-bc-modo" data-modo="tabela">' + svg('tabela') + '<span>' + esc(T.verTabela) + '</span></button>';
      raiz.parentNode.insertBefore(CAIXA, raiz);
      var volta = el('button', 'nc-bc-modo nc-bc-modo--volta', svg('cartoes') + '<span>' + esc(T.verCartoes) + '</span>'); volta.type = 'button'; volta.setAttribute('data-modo', 'cartoes');
      raiz.parentNode.insertBefore(volta, raiz);
      desenhar();
      var m = 'cartoes'; try { m = localStorage.getItem(CHAVE_MODO) || 'cartoes'; } catch (e) { /* padrão */ }
      modo(m);
      $(document).on('apexafterrefresh', function (e) { if ((IRB && IRB.closest('.t-Region').contains(e.target)) || (IRT && IRT.closest('.t-Region').contains(e.target))) desenhar(); });
      document.addEventListener('click', function (e) {
        var md = e.target.closest('.nc-bc-modo'); if (md) { modo(md.getAttribute('data-modo')); return; }
        if (e.target.closest('.nc-bc [data-fim]')) { VER_FIM = !VER_FIM; desenhar(); }
      });
    } catch (e) { if (window.console) console.error('Natcorp_BeneficiosConsulta', e); }
  }
  $(window).one('apexreadyend', function () { setTimeout(iniciar, 0); });
  $(function () { setTimeout(iniciar, 800); setTimeout(iniciar, 3000); });
  if (document.readyState === 'complete') setTimeout(iniciar, 200);
})();
