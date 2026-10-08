/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE ALTERAÇÃO DE VAGA  —  o "arrumador" da tela (JavaScript)         ║
   ║  App 200 · Página 163 · o gestor pede para mudar dados de uma vaga                        ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   É a tela em que o gestor pede para mudar dados de uma vaga (estrutura, cargo, jornada,
   remuneração…). A página original tem duas colunas soltas — "Dados Atuais" (35 campos
   travados) e "Mudança de Posição" (os mesmos 35 para preencher). Aqui:
     • no alto, um resumo: o cargo de hoje, a vaga, o local, a filial, o motivo e "vale a
       partir de …"; do lado, o nº e a situação da requisição e quantos dados mudam;
     • cada dado vira uma linha "Hoje → Passa a ser", e os dados ficam agrupados por assunto
       (Onde a vaga fica · Cargo · Jornada · Remuneração · Condições · PCD · Outros dados);
       só aparece aberto o grupo que muda;
     • um quadro "O que vai mudar" com a lista de tudo que foi alterado;
     • a faixa da aprovação (quando houver aprovadores);
     • as regiões numeradas (1 Qual vaga e por quê · 2 O que muda · 3 Observações);
     • uma barra no rodapé com Voltar, o que falta, quantos dados mudam e Criar/Salvar.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: isso continua sendo do APEX.
     • Não decide nada: lê o que o servidor já decidiu (situação, aprovação, campos travados).
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 163 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_AlteracaoVaga.js
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_AlteracaoVaga.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Classes postas nas regiões (Page Designer › clique na região › Appearance › CSS Classes):
     nc-alt-solicitacao   "Requisição de Alteração de Vaga" (nº, data, situação, solicitante)
                          → sai da tela; os dados vão para o resumo do alto
     nc-alt-vaga          Vaga: qual vaga, o motivo e a data de efetivação → seção 1
     nc-alt-atual         Dados Atuais → sai da tela; os valores aparecem na coluna "Hoje"
     nc-alt-proposta      Mudança de Posição → vira os grupos "Hoje → Passa a ser" (seção 2)
     nc-alt-obs           Observações → seção 3
     nc-alt-acoes         Botões (Voltar / Criar / Salvar) → barra fixa no rodapé, com o resumo
     nc-alt-aprovadores   Aprovadores (quando houver) → a faixa horizontal da aprovação
   Se uma classe for apagada no APEX, só aquela parte do desenho deixa de aparecer.
   O par "hoje ↔ novo" é achado PELO NOME do item: P163_X_PROP (o novo) ↔ P163_X_ATUAL (o de
   hoje). As exceções estão na lista PAR, em [J1].
   Os campos, botões e ações dinâmicas continuam os do APEX: aqui eles só MUDAM DE LUGAR.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Os grupos e os pares hoje ↔ novo ..... títulos, ícones, campos de cada grupo  PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  O resumo do alto .................... cargo, vaga, motivo, nº e situação     PODE MEXER
     [J4]  Os grupos "Hoje → Passa a ser" ...... monta e atualiza as linhas e os grupos  PODE MEXER
     [J5]  O quadro "O que vai mudar" .......... a lista de tudo que foi alterado
     [J6]  A faixa da aprovação ................ quem aprovou, quem falta, Aprovar/Reprovar
     [J7]  A barra do rodapé ................... o que falta e quantos dados mudam      PODE MEXER
     [J8]  As seções numeradas ................. 1 Qual vaga · 2 O que muda · 3 Obs.    PODE MEXER
     [J9]  O maestro ........................... decide QUANDO cada parte é montada  CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Onde a vaga fica'  →  'Local da vaga'
     Criei um par de campos novo (X_PROP e X_ATUAL) na Mudança de Posição
       → nada a fazer: ele aparece sozinho no grupo "Outros dados". Para pô-lo num grupo
         certo, acrescente o nome-base (X, sem o P163_ e sem o _PROP) na lista "campos" do
         grupo, em [J1].
     O "hoje" de um campo aparece vazio, mas há valor
       → o nome do item de hoje não segue o padrão X_ATUAL. Acrescente o par na lista PAR,
         em [J1] (a receita está lá).
     Um campo novo de dinheiro ou porcentagem aparece sem R$ ou %   → [J1], MOEDA_CAMPOS e PCT_CAMPOS
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp alteração de vaga].
         O manual, parte 5, explica o que fazer com a mensagem.

   ── LEGENDA DAS MARCAS NOS COMENTÁRIOS ────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, títulos.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
     (sem marca)  funciona sozinho; só mexa se souber o que está fazendo.

   ── COMO LER UM ARQUIVO JS EM 30 SEGUNDOS ─────────────────────────────────────────────────
     comentário             tudo entre barra-asterisco e asterisco-barra, e o resto da linha
                            depois de duas barras. O navegador ignora: é só para pessoas.
     function nome() { … }  uma "receita" com nome. Ela só roda quando alguém a chama: nome().
     var x = …;             guarda um valor com um nome, para usar depois.
     'texto'  ou  "texto"   um texto. Muitas vezes, é o que aparece na tela.
     P + 'COD_VAGA'         junta os textos: vira 'P163_COD_VAGA', o nome do item no APEX.
     texto(…) / valor(…)    leem o que está num item do APEX (veja [J2]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: esta linha impede que o arquivo rode duas vezes (se a URL estiver repetida na
     página, por exemplo) e que rode fora do APEX. Não apague. */
  if (window.__ncAlteracaoVaga || !window.apex || !window.apex.jQuery) return;
  window.__ncAlteracaoVaga = true;

  var $ = apex.jQuery;
  /* O começo do nome de todos os itens desta página. Se a página for copiada para outro
     número (ex.: 263), troque aqui para 'P263_' — e mais nada no arquivo. */
  var P = 'P163_';
  var ILU = {"mudanca": "data:image/png;base64,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"};

  /* ═══ [J1] OS GRUPOS E OS PARES HOJE ↔ NOVO ═════════════════════════════════════════════
     O QUE É    A configuração de toda a tela: em que grupo cada dado aparece, e como achar o
                valor de hoje de cada dado.
     GRUPOS     Na ordem de leitura de quem pede a alteração. Cada grupo tem:
                  titulo → o título do grupo          icone → o desenho (os nomes estão em IC, em [J2])
                  campos → os dados do grupo, pelo NOME-BASE: sem o P163_ e sem o _PROP/_ATUAL.
                           'COD_CARGO' quer dizer P163_COD_CARGO_PROP (novo) e P163_COD_CARGO_ATUAL (hoje).
                Campo da Mudança de Posição que não esteja em nenhum grupo vai sozinho para um
                último grupo, "Outros dados", na ordem do APEX.
     PAR        Para os dados cujos nomes NÃO seguem X_PROP / X_ATUAL: 'BASE': ['item novo',
                'item de hoje'] (sem o P163_). RECEITA: copie um par inteiro e troque os nomes.
     MOEDA_CAMPOS / PCT_CAMPOS  os nomes-base que aparecem como dinheiro (R$ 1.234,56) ou como
                porcentagem (12,5%) na coluna "Hoje" e no quadro "O que vai mudar". Para acrescentar
                um, ponha uma barra | e o nome dentro dos parênteses: (VALOR_VERBA|NOVO_CAMPO).
                Isso só muda o que aparece na tela, não o valor gravado.
     PODE MEXER títulos, ícones e campos dos grupos; os pares; as listas de moeda e porcentagem.
     CUIDADO    Não mude o "id" ('estrutura', 'cargo'…): o visual usa esse nome.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: os grupos, na ordem em que aparecem */
  var GRUPOS = [
    { id: 'estrutura', titulo: 'Onde a vaga fica', icone: 'local', campos: ['COD_FILIAL', 'COD_CCUSTO', 'COD_UNIDADE_ADM', 'COD_ATIVIDADE', 'COD_LOCAL_TRAB', 'COD_CCUSTO_CONTAB', 'COD_UN_NEGOCIO'] },
    { id: 'cargo', titulo: 'Cargo e enquadramento', icone: 'cargo', campos: ['COD_CARGO', 'COD_FUNCAO', 'COD_CATEGORIA', 'COD_SINDICATO', 'COD_CAT_GRUPO_SAL', 'VINCULO'] },
    { id: 'jornada', titulo: 'Jornada e ponto', icone: 'relogio', campos: ['TIPO_MODALIDADE', 'RT_JORNADA_MENSAL', 'COD_HORARIO', 'MARCA_PONTO', 'TP_REGISTRO_PONTO'] },
    { id: 'remuneracao', titulo: 'Remuneração e custo', icone: 'dinheiro', campos: ['TIPO_SALARIO', 'VALOR_VERBA', 'PER_CALC_SALARIO', 'VLR_REMUNERACAO', 'PERC_BENEFICIO', 'REMUNERACAO_VAR'] },
    { id: 'condicoes', titulo: 'Condições da vaga', icone: 'etiqueta', campos: ['VAGA_FATURAVEL', 'VALOR_FATURAVEL', 'VAGA_CONFIDENCIAL', 'REFEITORIO'] },
    { id: 'pcd', titulo: 'Vaga para pessoa com deficiência', icone: 'pcd', campos: ['IND_DEF_FIS', 'RAIS_IND_DEF_FISICO', 'RAIS_IND_DEF_AUD', 'RAIS_IND_DEF_VISUAL', 'RAIS_IND_DEF_MENTAL', 'RAIS_IND_DEF_MULT'] }
  ];
  /* PODE MEXER: o item "novo" e o "hoje" de cada dado, quando o nome não segue X_PROP / X_ATUAL */
  var PAR = { PER_CALC_SALARIO: ['PER_CALC_SALARIO', 'PERC_REMUNERACAO_ATUAL'], TIPO_MODALIDADE: ['TIPO_MODALIDADE_PROP', 'TIPO_MODALIDADE'] };
  /* PODE MEXER: os nomes-base mostrados como dinheiro e como porcentagem */
  var MOEDA_CAMPOS = /^(VALOR_VERBA|VLR_REMUNERACAO|VALOR_FATURAVEL|REMUNERACAO_VAR)$/;
  var PCT_CAMPOS = /^(PER_CALC_SALARIO|PERC_BENEFICIO)$/;
  function ids(base) { return PAR[base] ? [P + PAR[base][0], P + PAR[base][1]] : [P + base + '_PROP', P + base + '_ATUAL']; }

  /* ═══ [J2] FERRAMENTAS ══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo: ler um item do APEX, formatar uma data
                ou um valor, achar uma região pela classe. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       texto(P + 'ITEM')   o que a PESSOA VÊ no item (o nome da opção; Sim/Não numa caixa de marcar)
       valor(P + 'ITEM')   o que o APEX GUARDA no item (o código da opção)
       caixa(P + 'ITEM')   o bloco inteiro do campo na tela (rótulo + campo)
       porClasse('x')      as regiões que têm a classe x no APEX
       travado(id)         o campo está travado (só leitura) pelo APEX?
       muda('BASE')        o valor novo está preenchido e é diferente do de hoje?
       legivel(...)        "0220 - Auxiliar De Pereciveis" → nome bonito + código à parte; moeda e %
     QUANDO MEXER  Quase nunca. Os meses abreviados (MES3) podem ser mudados.
     Os ícones (lista IC, no fim desta parte) são desenhos SVG: o nome à esquerda é o que se usa
     em "icone" nos grupos de [J1].
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MOEDA = new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' });
  var MES3 = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function vazio(t) { return !t || /^\s*(-\s*selecione\s*-|-\s*todos\s*-|-)\s*$/i.test(t); }
  function codigo(t) { var m = String(t || '').match(/^\s*([\w.]+)\s+-\s+/); return m ? m[1] : ''; }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim(); }
  function maiusculas(t) { return t.length > 3 && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t); }
  function capitalizar(t) { return String(t || '').toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); }); }
  function bonito(t) { t = String(t || ''); if (maiusculas(t)) t = capitalizar(t); return t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em|Para|Por)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); }); }
  function num(t) { t = String(t === null || t === undefined ? '' : t).replace(/[^\d,.\-]/g, ''); if (!t) return NaN; if (t.indexOf(',') > -1) t = t.replace(/\./g, '').replace(',', '.'); return parseFloat(t); }
  function dataDe(t) { var m = String(t || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function curto(d) { return d ? d.getDate() + ' ' + MES3[d.getMonth()] + ' ' + d.getFullYear() : ''; }
  function quando(d) { var h = new Date(); h = new Date(h.getFullYear(), h.getMonth(), h.getDate()); var n = Math.round((d - h) / 864e5); return n === 0 ? 'hoje' : n === 1 ? 'amanhã' : n > 1 ? 'daqui a ' + n + ' dias' : n === -1 ? 'ontem' : 'há ' + (-n) + ' dias'; }
  function valor(id) { var it = apex.item(id); return it && it.node ? String(it.getValue() || '') : ''; }
  function porClasse(cls) { return [].slice.call(document.querySelectorAll('.t-Region.' + cls + ', .t-ButtonRegion.' + cls)); }
  function corpoDe(reg) { return reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg; }
  function caixa(id) { return document.getElementById(id + '_CONTAINER'); }
  function escondido(e, ate) { for (; e && e !== ate && e !== document.body; e = e.parentElement) if (e.style && e.style.display === 'none' || e.hidden) return true; return false; }
  function tipoDe(c) { return c ? (c.className.match(/apex-item-wrapper--([\w-]+)/) || [])[1] || '' : ''; }
  function eCheckbox(id) { return tipoDe(caixa(id)) === 'checkbox'; }
  function marcado(id) { var c = caixa(id); return !!(c && c.querySelector('input[type="checkbox"]:checked')); }
  /* o texto que a pessoa vê no item: opção da lista, texto do popup, valor, Sim/Não da caixa */
  function texto(id) {
    if (eCheckbox(id)) return marcado(id) ? 'Sim' : 'Não';
    var e = document.getElementById(id);
    if (!e) return '';
    if (e.tagName === 'SELECT') { var o = e.options[e.selectedIndex]; return o && o.value !== '' && !vazio(o.text) ? o.text.trim() : ''; }
    if (e.type === 'hidden') { var d = document.getElementById(id + '_DISPLAY'); return d ? d.textContent.trim() : ''; }
    var v = String(e.value || '').trim();
    return vazio(v) ? '' : v;
  }
  function travado(id) {
    var c = caixa(id), e = document.getElementById(id);
    if (!c) return true;
    if (eCheckbox(id)) return [].every.call(c.querySelectorAll('input[type="checkbox"]'), function (i) { return i.disabled; });
    if (!e) return true;
    if (c.classList.contains('apex-item-wrapper--popup-lov')) return !!(e.disabled || e.classList.contains('apex_disabled'));
    return !!(e.disabled || e.classList.contains('apex_disabled') || e.readOnly && e.tagName !== 'SELECT');
  }
  function rotuloDe(c) { var l = c && c.querySelector('.t-Form-label'); if (!l) return ''; var k = l.cloneNode(true); [].forEach.call(k.querySelectorAll('.u-VisuallyHidden'), function (x) { x.remove(); }); return k.textContent.replace(/\s+/g, ' ').trim(); }
  /* valor legível: "0220 - Auxiliar De Pereciveis" → nome + código à parte; moeda e % formatados */
  function legivel(base, t) {
    if (!t) return { nome: '', cod: '' };
    if (MOEDA_CAMPOS.test(base) && isFinite(num(t))) return { nome: MOEDA.format(num(t)).replace(/ /g, ' '), cod: '' };
    if (PCT_CAMPOS.test(base) && isFinite(num(t)) && !/%/.test(t)) return { nome: String(num(t)).replace('.', ',') + '%', cod: '' };
    var c = codigo(t), n = c ? semCodigo(t) : t;
    return { nome: bonito(n.replace(/^Código:\s*/i, '')), cod: c };
  }
  function htmlValor(v, cls) { return v.nome ? '<span class="' + cls + '">' + esc(v.nome) + (v.cod ? ' <small>' + esc(v.cod) + '</small>' : '') + '</span>' : '<span class="' + cls + ' nc-alt-vazio">não informado</span>'; }
  var TOCADOS = {};
  /* muda? novo preenchido e diferente de hoje (caixa: só se a pessoa mexeu ou marcou) */
  function muda(base) {
    var par = ids(base), n = par[0], h = par[1];
    if (!caixa(n)) return false;
    if (eCheckbox(n)) return marcado(n) !== marcado(h) && (TOCADOS[n] || marcado(n));
    var vn = valor(n), vh = valor(h);
    if (vazio(vn) || vazio(texto(n))) return false;
    if (isFinite(num(vn)) && isFinite(num(vh)) && /^[\d.,\s-]+$/.test(vn)) return num(vn) !== num(vh);
    return vn !== vh;
  }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-alt-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  var IC = {
    local: '<path d="M12 21s-6.5-5.6-6.5-11a6.5 6.5 0 0 1 13 0c0 5.4-6.5 11-6.5 11z"/><circle cx="12" cy="10" r="2.5"/>',
    cargo: '<rect x="3.5" y="7.5" width="17" height="12" rx="2"/><path d="M8.5 7.5v-2a1.5 1.5 0 0 1 1.5-1.5h4a1.5 1.5 0 0 1 1.5 1.5v2M3.5 12.5h17"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    dinheiro: '<rect x="3" y="6.5" width="18" height="11" rx="2"/><circle cx="12" cy="12" r="2.5"/><path d="M6.5 9.5v5M17.5 9.5v5"/>',
    etiqueta: '<path d="M3.5 12.5V4.5h8l9 9-8 8z"/><circle cx="8" cy="9" r="1.5"/>',
    pcd: '<circle cx="12" cy="4.5" r="1.8"/><path d="M12 7.5v6h4.5l2 5M12 10.5h4"/><path d="M8.5 11a5.5 5.5 0 1 0 7 7.2"/>',
    outros: '<circle cx="6" cy="12" r="1.5"/><circle cx="12" cy="12" r="1.5"/><circle cx="18" cy="12" r="1.5"/>',
    seta: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    vaga: '<path d="M8 3.5h8l3 3v14H5v-14z"/><path d="M9 11h6M9 14.5h6M9 7.5h3"/>'
  };

  /* ═══ [J3] O RESUMO DO ALTO ═════════════════════════════════════════════════════════════
     O QUE FAZ  Monta o bloco do alto: o cargo de HOJE como título, "Vaga N · local · filial", o
                motivo e "vale a partir de …"; do lado, "Requisição nº …", "aberta em … por …", a
                situação e "N dados mudam". Antes de escolher a vaga, diz o que fazer.
                A região nc-alt-solicitacao sai da tela (os dados dela vêm para cá).
     LÊ DOS ITENS  COD_CARGO_ATUAL, COD_LOCAL_TRAB_ATUAL, COD_FILIAL_ATUAL, COD_FILIAL_VAGA,
                COD_VAGA, DATA_ALT_POSICAO, MOT_ALT_VAGA, COD_REQUISICAO, COD_SIT_REQUISICAO,
                DATA_REQUISICAO, SOLICITANTE.
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_AlteracaoVaga.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function lerSolicitante() {
    var partes = String(texto(P + 'SOLICITANTE')).split(/\s+\/\s+/);
    if (partes.length < 2) return bonito(semCodigo(partes[0] || ''));
    return bonito(semCodigo(partes[1]));
  }
  var TOPO = null;
  function montarTopo() {
    var ref = porClasse('nc-alt-vaga')[0];
    if (!ref) return;
    if (!TOPO) {
      TOPO = el('section', 'nc-alt-topo'); TOPO.id = 'nc-alt-topo';
      TOPO.setAttribute('aria-label', 'Resumo da alteração');
      TOPO.innerHTML = '<div class="nc-alt-topo-ilu" data-slot="ilu"></div><div class="nc-alt-topo-txt" data-slot="txt"></div><aside class="nc-alt-topo-lado" data-slot="lado"></aside>';
      var linha = ref.closest('.row') || ref;
      linha.parentNode.insertBefore(TOPO, linha);
      if (ILU.mudanca) TOPO.querySelector('[data-slot="ilu"]').innerHTML = '<img alt="" src="' + ILU.mudanca + '">';
    }
    /* 04/10: a região da solicitação só sai da tela quando a Situação NÃO pode ser trocada.
       Na requisição gravada e aberta, a página deixa trocar a Situação (1 → 3) e o Salvar
       grava pelo processo "Atualiza Situação" (com a validação "Valida Situação Req"):
       esconder a região tirava da pessoa o único jeito de fazer isso. */
    var sol = porClasse('nc-alt-solicitacao')[0];
    if (sol) {
      var selSit = document.getElementById(P + 'COD_SIT_REQUISICAO');
      var sitEditavel = !!(selSit && selSit.tagName === 'SELECT' && !selSit.disabled && !selSit.classList.contains('apex_disabled') && !escondido(caixa(P + 'COD_SIT_REQUISICAO'), sol));
      sol.classList.toggle('nc-alt-absorvida', !sitEditavel);
    }
    var cargo = legivel('COD_CARGO', texto(P + 'COD_CARGO_ATUAL'));
    var local = legivel('COD_LOCAL_TRAB', texto(P + 'COD_LOCAL_TRAB_ATUAL'));
    var filial = legivel('COD_FILIAL', texto(P + 'COD_FILIAL_ATUAL') || texto(P + 'COD_FILIAL_VAGA'));
    var vagaTxt = texto(P + 'COD_VAGA'), nVaga = (vagaTxt.match(/Vaga:\s*(\w+)/i) || [])[1] || '';
    var tem = !!(vagaTxt && cargo.nome);
    var efet = dataDe(valor(P + 'DATA_ALT_POSICAO'));
    var mot = semCodigo(texto(P + 'MOT_ALT_VAGA'));
    TOPO.classList.toggle('nc-alt-topo--vazio', !tem);
    TOPO.querySelector('[data-slot="txt"]').innerHTML = tem ?
      '<h2 class="nc-alt-topo-tit">' + esc(cargo.nome) + '</h2>' +
      '<p class="nc-alt-topo-meta">' + [nVaga ? 'Vaga ' + esc(nVaga) : '', local.nome ? esc(local.nome) : '', filial.nome ? esc(filial.nome) : ''].filter(Boolean).join(' <span aria-hidden="true">·</span> ') + '</p>' +
      (mot || efet ? '<p class="nc-alt-topo-quando">' + (mot ? '<b>' + esc(bonito(mot)) + '</b>' : '') + (mot && efet ? ' <span aria-hidden="true">·</span> ' : '') + (efet ? 'vale a partir de <b>' + curto(efet) + '</b> (' + quando(efet) + ')' : '') + '</p>' : '') :
      '<h2 class="nc-alt-topo-tit">Alteração de vaga</h2><p class="nc-alt-topo-meta">Escolha a vaga abaixo: os dados de hoje aparecem ao lado de cada campo, e você preenche só o que muda.</p>';
    /* do lado: quantas mudanças e, numa requisição gravada, o número e a situação */
    var n = contarMudancas();
    var nReq = valor(P + 'COD_REQUISICAO');
    var sit = texto(P + 'COD_SIT_REQUISICAO');
    var dReq = dataDe(valor(P + 'DATA_REQUISICAO') || texto(P + 'DATA_REQUISICAO'));
    var tom = /aprov|conclu/i.test(sit) ? 'ok' : /reprov|cancel/i.test(sit) ? 'nao' : 'andamento';
    var quem = lerSolicitante();
    TOPO.querySelector('[data-slot="lado"]').innerHTML =
      (nReq ? '<p class="nc-alt-req">Requisição <b>nº ' + esc(nReq) + '</b></p>' + (dReq ? '<p class="nc-alt-req-data">aberta em ' + curto(dReq) + (quem ? ' por ' + esc(quem) : '') + '</p>' : '') +
        (sit ? '<p class="nc-alt-sit nc-alt-sit--' + tom + '"><span aria-hidden="true"></span>' + esc(sit.charAt(0).toUpperCase() + sit.slice(1).toLowerCase()) + '</p>' : '') : '') +
      (tem ? '<p class="nc-alt-contagem' + (n ? ' is-tem' : '') + '">' + (n ? '<b>' + n + '</b> ' + (n === 1 ? 'dado muda' : 'dados mudam') : 'Nada alterado ainda') + '</p>' : '');
  }

  /* ═══ [J4] OS GRUPOS "HOJE → PASSA A SER" ═══════════════════════════════════════════════
     O QUE FAZ  montarGrupos() (uma vez): esconde a região "Dados Atuais", faz a Mudança de Posição
                ocupar a largura toda e cria um grupo para cada item de [J1]. Cada dado vira uma
                linha: rótulo · Hoje · seta · Passa a ser (o campo do APEX, levado para lá).
                atualizarGrupos() (a cada mudança):
                  • preenche a coluna "Hoje" e marca as linhas que mudam;
                  • abre sozinho o grupo que tem mudança; o botão diz "Alterar", "Ver" ou "Fechar";
                  • numa requisição só para leitura, mostra só as linhas que mudam;
                  • linha cujo campo novo foi escondido por ação dinâmica some junto;
                  • escreve no cabeçalho do grupo "Hoje: …" (os dois primeiros dados) e
                    "N alterações".
     PODE MEXER os textos entre aspas: 'Hoje', 'Passa a ser', 'Outros dados', 'Alterar', 'Ver',
                'Fechar', 'Sem alteração', 'não informado'…
     VISUAL     Natcorp_AlteracaoVaga.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FORM = null, ABERTOS = {}, GR = [];
  function montarGrupos() {
    FORM = porClasse('nc-alt-proposta')[0];
    var atual = porClasse('nc-alt-atual')[0];
    if (!FORM) return false;
    if (FORM.querySelector('.nc-alt-grupos')) return true;
    if (atual) atual.classList.add('nc-alt-absorvida');
    FORM.classList.add('nc-alt-proposta--pronta');
    /* "Dados Atuais" e "Mudança de Posição" dividiam a linha em duas colunas: a de hoje sai
       e a outra ocupa a largura toda */
    var colA = atual && atual.parentElement.classList.contains('col') ? atual.parentElement : null;
    var colP = FORM.parentElement.classList.contains('col') ? FORM.parentElement : null;
    if (colA && colA !== colP && !colA.querySelector('.t-Region:not(.nc-alt-absorvida)')) colA.classList.add('nc-alt-col-vazia');
    if (colP) colP.classList.add('nc-alt-col-cheia');
    var corpo = corpoDe(FORM);
    var box = el('div', 'nc-alt-grupos');
    corpo.insertBefore(box, corpo.firstChild);
    var usados = {};
    var todos = GRUPOS.concat([{ id: 'outros', titulo: 'Outros dados', icone: 'outros', campos: [] }]);
    /* campos da proposta que não estão em grupo nenhum: vão para "Outros dados", na ordem do APEX */
    GRUPOS.forEach(function (g) { g.campos.forEach(function (b) { usados[ids(b)[0]] = true; }); });
    [].forEach.call(FORM.querySelectorAll('.t-Form-fieldContainer'), function (c) {
      var id = c.id.replace(/_CONTAINER$/, '');
      if (!usados[id]) todos[todos.length - 1].campos.push({ livre: id });
    });
    todos.forEach(function (g) {
      var sec = el('section', 'nc-alt-grupo'); sec.id = 'nc-alt-g-' + g.id;
      sec.innerHTML = '<header class="nc-alt-grupo-cab"><span class="nc-alt-grupo-ic" aria-hidden="true">' + svg(IC[g.icone] || IC.outros) + '</span>' +
        '<div class="nc-alt-grupo-tit"><h3>' + esc(g.titulo) + '</h3><p data-slot="hoje"></p></div>' +
        '<span class="nc-alt-grupo-estado" data-slot="estado"></span>' +
        '<button type="button" class="nc-alt-abrir" aria-expanded="false" aria-controls="nc-alt-g-' + g.id + '-linhas" data-slot="abrir"></button></header>' +
        '<div class="nc-alt-linhas" id="nc-alt-g-' + g.id + '-linhas" role="group" aria-label="' + esc(g.titulo) + '">' +
        '<div class="nc-alt-cols" aria-hidden="true"><span></span><span>Hoje</span><span></span><span>Passa a ser</span></div></div>';
      var linhas = sec.querySelector('.nc-alt-linhas');
      var itens = [];
      g.campos.forEach(function (b) {
        var base = typeof b === 'string' ? b : null;
        var novo = base ? ids(base)[0] : b.livre, hoje = base ? ids(base)[1] : null;
        var cn = caixa(novo);
        if (!cn) return;
        var rot = rotuloDe(cn) || rotuloDe(caixa(hoje));
        var li = el('div', 'nc-alt-linha'); li.setAttribute('data-base', base || novo);
        li.innerHTML = '<div class="nc-alt-rot">' + esc(rot) + '</div><div class="nc-alt-hoje" data-slot="hoje"></div>' +
          '<div class="nc-alt-seta" aria-hidden="true">' + svg(IC.seta) + '</div><div class="nc-alt-novo" data-slot="novo"></div>';
        cn.classList.add('nc-alt-campo');
        li.querySelector('[data-slot="novo"]').appendChild(cn);
        linhas.appendChild(li);
        itens.push({ base: base, novo: novo, hoje: hoje, li: li, rot: rot });
      });
      if (!itens.length) return;
      box.appendChild(sec);
      GR.push({ g: g, sec: sec, itens: itens });
      sec.querySelector('[data-slot="abrir"]').addEventListener('click', function () {
        ABERTOS[g.id] = !sec.classList.contains('is-aberto');
        agendar();
        if (ABERTOS[g.id]) setTimeout(function () { var i = sec.querySelector('.nc-alt-linha input:not([type=hidden]):not([readonly]), .nc-alt-linha select, .nc-alt-linha input.popup_lov'); if (i) i.focus({ preventScroll: true }); sec.scrollIntoView({ behavior: 'smooth', block: 'nearest' }); }, 60);
      });
    });
    return true;
  }
  function contarMudancas() { var n = 0; GR.forEach(function (x) { x.itens.forEach(function (i) { if (i.base && muda(i.base)) n++; }); }); return n; }
  function atualizarGrupos() {
    var temVaga = !!texto(P + 'COD_VAGA');
    GR.forEach(function (x) {
      var nMuda = 0, editavel = false, visiveis = 0;
      x.itens.forEach(function (i) {
        var m = i.base ? muda(i.base) : !vazio(texto(i.novo));
        if (m) nMuda++;
        if (!travado(i.novo)) editavel = true;
        var h = i.hoje ? legivel(i.base, texto(i.hoje)) : { nome: '', cod: '' };
        var slot = i.li.querySelector('[data-slot="hoje"]');
        var html = i.hoje ? htmlValor(h, 'nc-alt-v') : '<span class="nc-alt-v nc-alt-vazio">—</span>';
        if (slot.innerHTML !== html) slot.innerHTML = html;
        i.li.classList.toggle('is-muda', !!m);
        i.li.classList.toggle('is-lido', travado(i.novo));
        /* a ação dinâmica escondeu o campo novo: a linha some junto */
        var some = escondido(caixa(i.novo), i.li.querySelector('[data-slot="novo"]').parentNode);
        i.li.hidden = !!some;
        if (!some) visiveis++;
      });
      var aberto = ABERTOS[x.g.id] !== undefined ? ABERTOS[x.g.id] : nMuda > 0;
      if (!editavel) aberto = nMuda > 0;                    /* só leitura: mostra só o que muda */
      x.sec.classList.toggle('is-aberto', !!aberto);
      x.sec.classList.toggle('is-leitura', !editavel);
      x.sec.classList.toggle('is-muda', nMuda > 0);
      x.sec.hidden = !visiveis;
      /* só leitura: ficam só as linhas que mudam */
      if (!editavel) x.itens.forEach(function (i) { if (!i.li.classList.contains('is-muda')) i.li.hidden = true; });
      /* resumo de hoje no cabeçalho (os dois primeiros dados que existem) */
      var resumo = x.itens.filter(function (i) { return i.hoje && texto(i.hoje) && !eCheckbox(i.hoje); }).map(function (i) { return legivel(i.base, texto(i.hoje)).nome; })
        .filter(function (v, k, a) { return a.indexOf(v) === k; }).slice(0, 2);   /* sem repetir (cargo = função) */
      var pcd = x.g.id === 'pcd' || x.g.id === 'condicoes' ? x.itens.filter(function (i) { return i.hoje && eCheckbox(i.hoje) && marcado(i.hoje); }).map(function (i) { return i.rot; }) : [];
      var hoje = resumo.concat(pcd).join(' · ');
      x.sec.querySelector('[data-slot="hoje"]').innerHTML = temVaga ? (hoje ? 'Hoje: ' + esc(hoje) : 'Hoje: nada informado') : 'Os dados de hoje aparecem depois de escolher a vaga.';
      var est = x.sec.querySelector('[data-slot="estado"]');
      est.className = 'nc-alt-grupo-estado' + (nMuda ? ' is-muda' : '');
      est.innerHTML = nMuda ? svg(IC.lapis) + nMuda + (nMuda === 1 ? ' alteração' : ' alterações') : editavel ? '' : 'Sem alteração';
      var bt = x.sec.querySelector('[data-slot="abrir"]');
      bt.hidden = !editavel;
      bt.setAttribute('aria-expanded', String(!!aberto));
      bt.textContent = aberto ? 'Fechar' : nMuda ? 'Ver' : 'Alterar';
    });
  }

  /* ═══ [J5] O QUADRO "O QUE VAI MUDAR" ═══════════════════════════════════════════════════
     O QUE FAZ  Logo abaixo dos grupos, lista cada dado que muda: rótulo · de (hoje) → para (novo).
                Some quando nada muda.
     VISUAL     Natcorp_AlteracaoVaga.css › [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarResumo() {
    if (!FORM) return;
    var r = document.getElementById('nc-alt-resumo');
    if (!r) {
      r = el('section', 'nc-alt-resumo'); r.id = 'nc-alt-resumo'; r.setAttribute('aria-live', 'polite');
      var box = FORM.querySelector('.nc-alt-grupos');
      box.parentNode.insertBefore(r, box.nextSibling);
    }
    var lista = [];
    GR.forEach(function (x) { x.itens.forEach(function (i) {
      if (!i.base || !muda(i.base)) return;
      var h = i.hoje ? legivel(i.base, texto(i.hoje)) : { nome: '' }, n = legivel(i.base, texto(i.novo));
      lista.push('<li><span class="nc-alt-resumo-rot">' + esc(i.rot) + '</span>' + htmlValor(h, 'nc-alt-de') + svg(IC.seta, 'nc-alt-ic nc-alt-resumo-seta') + htmlValor(n, 'nc-alt-para') + '</li>');
    }); });
    r.hidden = !lista.length;
    r.innerHTML = '<h3>O que vai mudar <span>' + lista.length + '</span></h3><ul>' + lista.join('') + '</ul>';
  }

  /* ═══ [J6] A FAIXA DA APROVAÇÃO (a mesma do Desligamento) ═══════════════════════════════
     O QUE FAZ  Transforma o relatório "Aprovadores" numa faixa horizontal logo abaixo do resumo
                do alto: cada aprovador com um sinal (aprovou, reprovou, aguardando, na fila) e um
                resumo do tipo "2 de 3 · aguardando Maria". Os botões Aprovar/Reprovar do APEX vêm
                para dentro da faixa.
     LÊ DE      as colunas do relatório da região nc-alt-aprovadores, pelos nomes das colunas:
                APROVADOR, DATA, STATUS, JUSTIFICATIVA.
     CUIDADO    Se uma dessas colunas for renomeada no relatório do APEX, a faixa não acha
                os dados. Renomeie também aqui (procure  headers="  logo abaixo).
     PODE MEXER os textos entre aspas: 'Aprovação', 'Ver o caminho', 'Aguardando', 'Na fila'…
     VISUAL     Natcorp_AlteracaoVaga.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function situacaoReq() {
    var t = texto(P + 'COD_SIT_REQUISICAO');
    return { texto: t, tom: /aprov|conclu/i.test(t) ? 'ok' : /reprov|cancel/i.test(t) ? 'nao' : 'andamento' };
  }
  var IC_AP = { ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>', x: '<path d="M8 8l8 8M16 8l-8 8"/>' };
  function nomeAprovador(t) {
    var m = String(t || '').match(/^\s*(\d+)\s*-\s*(\d+)\s*-\s*(.+)$/);
    if (m) return { nome: bonito(capitalizar(m[3].trim())), meta: 'Empresa ' + m[1] + ' · matrícula ' + m[2], pessoa: true };
    var n = String(t || '').trim();
    return { nome: maiusculas(n) ? capitalizar(n) : n, meta: '', pessoa: false };
  }
  function lerAprovacao(reg) {
    reg = reg || porClasse('nc-alt-aprovadores')[0];
    if (!reg) return null;
    var passos = [].slice.call(reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      var c = function (h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? td.textContent.replace(/\s+/g, ' ').trim() : ''; };
      var link = tr.querySelector('a[href*="dialog"], a[href^="javascript"]') || tr._ncLink || null;
      if (link) tr._ncLink = link;
      var st = c('STATUS');
      return { quem: nomeAprovador(c('APROVADOR')), data: c('DATA').replace(/^-$/, ''), status: st, just: c('JUSTIFICATIVA').replace(/^-$/, ''), link: link,
        estado: /reprov|recus|negad/i.test(st) ? 'nao' : /aprov/i.test(st) ? 'ok' : 'pend' };
    });
    var atual = -1;
    for (var i = 0; i < passos.length; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; });
    return { reg: reg, passos: passos, atual: reprovado ? -1 : atual, reprovado: reprovado, aprovados: passos.filter(function (x) { return x.estado === 'ok'; }).length,
      botoes: [].slice.call(reg.querySelectorAll('button, a.t-Button')).filter(function (b) { return /aprovar|reprovar/i.test(b.textContent) && !b.closest('.nc-alt-caminho'); }).concat(reg._ncBotoes || []) };
  }
  var apAberto = false;
  function montarAprovadores() {
    porClasse('nc-alt-aprovadores').forEach(function (reg) {
      if (TOPO && reg.previousElementSibling !== TOPO) TOPO.parentNode.insertBefore(reg, TOPO.nextSibling);
      var ap = lerAprovacao(reg);
      var corpo = corpoDe(reg);
      /* 04/10: sem linhas no relatório a região só some se também não tiver Aprovar/Reprovar
         (o botão tem condição própria no servidor; não pode sumir junto com a lista) */
      reg.hidden = !ap.passos.length && !ap.botoes.length;
      var box = corpo.querySelector(':scope > .nc-alt-caminho');
      if (!ap.passos.length) {
        if (box) { ap.botoes.forEach(function (b) { if (box.contains(b)) corpo.appendChild(b); }); box.remove(); }
        return;
      }
      if (!box) {
        box = el('div', 'nc-alt-caminho'); corpo.insertBefore(box, corpo.firstChild);
        box.addEventListener('click', function (e) { if (e.target.closest('.nc-alt-caminho-ver')) { apAberto = !apAberto; agendar(); } });
      }
      var bts = ap.botoes.filter(function (b, i, a) { return a.indexOf(b) === i; });
      reg._ncBotoes = bts;
      var total = ap.passos.length;
      /* requisição cancelada / reprovada no meio do caminho: ninguém mais está "aguardando" */
      var sitR = situacaoReq();
      if (sitR.tom === 'nao' && !ap.reprovado) ap.atual = -2;
      var quemNao = ap.passos.filter(function (x) { return x.estado === 'nao'; })[0];
      var resumoTxt = ap.reprovado ? '<b>Reprovada</b> por ' + esc(quemNao.quem.nome) : ap.atual === -2 ? '<b>Interrompida</b> · requisição ' + esc(sitR.texto.toLowerCase()) : ap.atual < 0 ? '<b>Aprovada</b> por todos' :
        '<b>' + ap.aprovados + ' de ' + total + '</b> · aguardando <b>' + esc(ap.passos[ap.atual].quem.nome) + '</b>';
      var estadoGeral = ap.reprovado ? 'nao' : ap.atual === -2 ? 'fim' : ap.atual < 0 ? 'ok' : bts.length ? 'vez' : 'pend';
      reg.classList.toggle('nc-alt-ap-aberto', !!(apAberto));
      box.className = 'nc-alt-caminho nc-alt-caminho--' + estadoGeral;
      box.innerHTML =
        '<p class="nc-alt-caminho-rot">Aprovação</p><div class="nc-alt-caminho-cab"><p class="nc-alt-caminho-resumo">' + resumoTxt + '</p>' +
          '<button type="button" class="nc-alt-caminho-ver" aria-expanded="' + apAberto + '">' + (apAberto ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
        '<ol class="nc-alt-passos-ap">' + ap.passos.map(function (x, i) {
          var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === ap.atual ? 'is-vez' : 'is-fila';
          var st = x.estado === 'ok' ? (x.data ? x.data.replace(/\s.*$/, '') : 'Aprovou') : x.estado === 'nao' ? 'Reprovou' : ap.atual === -2 ? 'Não chegou' : i === ap.atual ? 'Aguardando' : 'Na fila';
          var ic = x.estado === 'ok' ? IC_AP.ok : x.estado === 'nao' ? IC_AP.x : i === ap.atual ? '<path d="M12 8v4l2.5 1.5"/>' : '';
          var dica = x.quem.nome + (x.quem.meta ? ' (' + x.quem.meta + ')' : '') + ' — ' + (x.estado === 'ok' ? 'aprovou' + (x.data ? ' em ' + x.data : '') : x.estado === 'nao' ? 'reprovou' + (x.data ? ' em ' + x.data : '') : i === ap.atual ? 'aguardando a aprovação' : 'na fila') + (x.just ? ': "' + x.just + '"' : '');
          return '<li class="nc-alt-ap ' + cls + '" data-i="' + i + '" title="' + esc(dica) + '"><span class="nc-alt-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
            '<span class="nc-alt-ap-texto"><span class="nc-alt-ap-nome">' + esc(x.quem.nome) + '</span><span class="nc-alt-ap-estado">' + esc(st) + '</span></span></li>';
        }).join('') + '</ol>' +
        (bts.length ? '<div class="nc-alt-decisao-botoes" aria-label="Sua decisão"></div>' : '') +
        (quemNao && quemNao.just ? '<blockquote class="nc-alt-ap-just"><b>' + esc(quemNao.quem.nome) + ' reprovou:</b> ' + esc(quemNao.just) + '</blockquote>' : '');
      ap.passos.forEach(function (x, i) {
        if (!x.link || !x.quem.pessoa) return;
        var li = box.querySelector('.nc-alt-ap[data-i="' + i + '"] .nc-alt-ap-texto');
        x.link.classList.add('nc-alt-ap-link'); x.link.setAttribute('title', 'Ver dados de ' + x.quem.nome); x.link.setAttribute('aria-label', 'Ver dados de ' + x.quem.nome);
        li.appendChild(x.link);
      });
      var dest = box.querySelector('.nc-alt-decisao-botoes');
      if (dest) bts.sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) { b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-alt-reprovar' : 'nc-alt-aprovar'); dest.appendChild(b); });
    });
  }

  /* ═══ [J7] A BARRA DO RODAPÉ: O QUE FALTA E QUANTO MUDA ═════════════════════════════════
     O QUE FAZ  A região nc-alt-acoes é levada para depois das Observações e presa no rodapé.
                Ao lado dos botões: "Falta" + os campos obrigatórios vazios (clicar leva ao campo),
                ou "N dados mudam", ou "Nenhum dado alterado ainda…". Numa requisição só para
                leitura (sem botão de gravar), a região fica onde estava.
     COMO SABE O QUE É OBRIGATÓRIO  Pelo próprio APEX: campo com "Value Required" ligado, nas
                regiões nc-alt-vaga, nc-alt-proposta e nc-alt-obs.
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_AlteracaoVaga.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function faltas() {
    return [].slice.call(document.querySelectorAll('.nc-alt-vaga .t-Form-fieldContainer.is-required, .nc-alt-proposta .t-Form-fieldContainer.is-required, .nc-alt-obs .t-Form-fieldContainer.is-required')).filter(function (c) {
      var id = c.id.replace(/_CONTAINER$/, '');
      return !escondido(c) && !travado(id) && vazio(valor(id)) && vazio(texto(id));
    });
  }
  function montarBarra() {
    var ac = porClasse('nc-alt-acoes')[0];
    if (!ac) return;
    var gravar = [].some.call(ac.querySelectorAll('.t-Button'), function (b) { return !/voltar|fechar/i.test(b.textContent) && !escondido(b); });
    ac.classList.toggle('nc-alt-acoes--leitura', !gravar);
    if (!gravar) return;
    if (!ac.dataset.ncMovida) {
      ac.dataset.ncMovida = '1';
      var fim = porClasse('nc-alt-obs')[0] || FORM;
      var linha = fim && (fim.closest('.row') || fim);
      if (linha) linha.parentNode.insertBefore(ac, linha.nextSibling);
      var alvo = ac.querySelector('.t-ButtonRegion-col--content') || ac;
      var s = el('div', 'nc-alt-status'); s.id = 'nc-alt-status'; s.setAttribute('aria-live', 'polite');
      alvo.appendChild(s);
      s.addEventListener('click', function (e) {
        var b = e.target.closest('[data-ir]'); if (!b) return;
        var c = document.getElementById(b.getAttribute('data-ir')); if (!c) return;
        c.scrollIntoView({ behavior: 'smooth', block: 'center' });
        var i = c.querySelector('input:not([type=hidden]), select, textarea'); if (i) setTimeout(function () { i.focus({ preventScroll: true }); }, 350);
      });
    }
    var f = faltas(), n = contarMudancas();
    document.getElementById('nc-alt-status').innerHTML = f.length ?
      '<span class="nc-alt-status-rot">Falta</span> ' + f.map(function (c) { return '<button type="button" class="nc-alt-falta" data-ir="' + c.id + '">' + esc(rotuloDe(c)) + '</button>'; }).join('') :
      n ? '<span class="nc-alt-status-ok">' + svg(IC.ok) + n + (n === 1 ? ' dado muda' : ' dados mudam') + '</span>' :
      '<span class="nc-alt-status-nada">Nenhum dado alterado ainda. Abra o assunto que muda e preencha o novo valor.</span>';
  }

  /* ═══ [J8] AS SEÇÕES NUMERADAS ══════════════════════════════════════════════════════════
     O QUE FAZ  Põe um cabeçalho com número, título e explicação no alto de três regiões.
     PODE MEXER a lista logo abaixo: ['classe da região', número, 'Título', 'Explicação'].
                Troque só o título e a explicação.
     VISUAL     Natcorp_AlteracaoVaga.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function numerar() {
    [['nc-alt-vaga', 1, 'Qual vaga e por quê', 'Empresa, filial, a vaga, o motivo e a partir de quando vale.'],
      ['nc-alt-proposta', 2, 'O que muda na vaga', 'Abra só o assunto que muda. Ao lado de cada campo fica o valor de hoje.'],
      ['nc-alt-obs', 3, 'Observações', 'O que os aprovadores precisam saber (opcional).']].forEach(function (x) {
      var reg = porClasse(x[0])[0];
      if (!reg || reg.querySelector(':scope > .nc-alt-sec-cab')) return;
      var cab = el('header', 'nc-alt-sec-cab', '<span class="nc-alt-num" aria-hidden="true">' + x[1] + '</span><div><h2>' + esc(x[2]) + '</h2><p>' + esc(x[3]) + '</p></div>');
      reg.insertBefore(cab, reg.firstChild);
      reg.classList.add('nc-alt-sec');
    });
  }

  /* ═══ [J9] O MAESTRO: QUANDO CADA PARTE É MONTADA ═══════════════════════════════════════
     O QUE FAZ  tudo() chama as partes acima, nesta ordem. iniciar() roda uma vez quando a
                página abre e depois manda montar tudo de novo sempre que algo muda: um campo é
                alterado, uma ação dinâmica traz valores do servidor, uma janela fecha, a tela
                muda de tamanho.
     CUIDADO    Não mude a ordem das chamadas em tudo(): umas partes dependem das anteriores
                (os grupos precisam existir antes de o resumo contar as mudanças).
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp alteração de vaga] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tudo() {
    montarGrupos();
    numerar();
    atualizarGrupos();
    montarTopo();
    montarAprovadores();
    montarResumo();
    montarBarra();
  }
  var agendado = false, MO = null;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () {
      agendado = false;
      try { tudo(); } catch (e) { if (window.console) console.warn('[Natcorp alteração de vaga]', e); }
      if (MO) MO.takeRecords();
    });
  }
  function iniciar() {
    document.body.classList.add('nc-alt');
    tudo();
    $(document).on('change', '[id^="' + P + '"]', function (e) { var c = e.target.closest('.t-Form-fieldContainer'); if (c) TOCADOS[c.id.replace(/_CONTAINER$/, '')] = true; agendar(); });
    $(document).on('input', '.nc-alt-linha input', agendar);
    $(document).on('apexafterrefresh', agendar);
    /* valores trazidos do servidor por ação dinâmica (Executar PL/SQL, "itens a retornar")
       chegam SEM o evento change: sem isto a tela ficava com a leitura de antes da resposta */
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    $(document).on('apexafterclosedialog dialogclose', function () { setTimeout(agendar, 80); });
    $(window).on('resize apexwindowresized', agendar);
    if (window.MutationObserver) {
      MO = new MutationObserver(agendar);
      porClasse('nc-alt-proposta').concat(porClasse('nc-alt-atual'), porClasse('nc-alt-vaga')).forEach(function (r) {
        MO.observe(r, { attributes: true, childList: true, subtree: true, attributeFilter: ['style', 'disabled', 'readonly', 'class', 'value'] });
      });
    }
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
