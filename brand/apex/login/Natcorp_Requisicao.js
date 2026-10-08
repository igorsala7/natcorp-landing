/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE PESSOAL / DE POSIÇÃO  —  o "arrumador" da tela (JavaScript)      ║
   ║  App 2010 · Página 52 (Requisição de Pessoal)  e  App 200 · Página 76 (de Posição)        ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns. O guia desta tela é o REQUISICAO-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   A tela em que o gestor pede a abertura de um processo seletivo e o selecionador acompanha
   (a mesma visão para os dois; 70% no computador; um gestor abre dezenas por dia). Quando a
   página abre, ele REORGANIZA o que o APEX já desenhou em volta de uma pergunta: "o que
   falta para esta vaga sair?"
     • no alto, o resumo da vaga: cargo, posições, marcas (temporária, confidencial, PCD,
       divulgação) e a estrutura; o resto em "Detalhes";
     • as ações (Suspender, Revisar, Cancelar, Publicar) sempre à vista;
     • a faixa da aprovação (quem já aprovou, de quem é a vez, Aprovar/Reprovar);
     • as etapas, UMA POR VEZ, com um menu ("Falta 2 campos", "Completa"), botões "Voltar" e
       "Próxima" no fim de cada uma; a etapa aberta é lembrada ao recarregar e um erro do
       servidor abre a etapa em que o erro está;
     • as seções se leem como documento; "Editar" abre o formulário (que nunca sai da página);
     • listas de requisitos viram etiquetas (Obrigatório / Desejável); inscritos viram cartões;
     • a última etapa mostra a vaga como o candidato vai vê-la, e "Antes de publicar".

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: isso continua sendo do APEX.
     • Não muda a ordem das regiões. Os botões e links que ele mostra (Aprovar, Reprovar, a
       lupa do aprovador, o × de uma linha) SÃO OS ORIGINAIS do APEX mudados de lugar, com as
       mesmas ações dinâmicas. Não são cópias.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX (todas as
       etapas uma embaixo da outra) e continua funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 52 (app 2010) e página 76 (app 200) › JavaScript › File URLs:
       #WORKSPACE_IMAGES#Natcorp_Requisicao.js   (na p52, depois dos três que já estavam)
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Requisicao.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Classes postas nas regiões (Page Designer › clique na região › Appearance › CSS Classes):
     nc-req-etapas        a região que contém as etapas (a "avó" nc-stepper-host): ganha no
                          alto o resumo da vaga, a faixa de aprovação e o menu das etapas
     nc-req-etapa         cada etapa (Identificação, Cargo, Remuneração…): uma por vez; o nome
                          no menu é o TÍTULO da região; a ordem é a Sequence
     nc-req-acoes         a região "Botões Requisição" (Publicar, Cancelar, Descendentes…):
                          no canto do resumo (computador) ou logo abaixo dele (celular)
     nc-req-solicitacao   a seção "Solicitação": nº, origem, situação, motivo, data, solicitante
     nc-req-aprovadores   a região Aprovadores: vira a faixa horizontal abaixo do resumo
     nc-req-ficha         seção que se lê como documento; "Editar" abre o formulário. Abre já
                          em edição se faltar obrigatório ou houver erro
     nc-req-lista         cada lista de requisitos (Formação, Cursos, Idiomas…): as linhas viram
                          etiquetas, separadas em Obrigatório / Desejável quando a lista tem a
                          coluna EXIGÊNCIA; vazia, vira uma linha só
     nc-req-grupo         a região que junta listas (Requisitos Técnicos, Desempenho…): as
                          listas lado a lado no computador
     nc-req-opcional      região opcional (Indicação de Candidato): recolhida enquanto vazia,
                          com "Indicar um candidato" para abrir
     nc-req-escrita       a região da descrição: no computador, lado a lado com a prévia
     nc-req-plano         região que agrupa outras (Indicação para Avaliar): as de dentro sem
                          moldura própria (nada de cartão dentro de cartão)
     nc-req-pessoas       relatório de inscritos: cada linha vira o cartão da pessoa
     nc-req-candidatos    a etapa dos inscritos: o menu mostra quantos são
     nc-req-etapa-previa  a etapa "Prévia do anúncio"; nc-req-previa, a região dentro dela
                          (vazia no APEX: o JS desenha o anúncio)
   Em toda a página: textos com limite (Maximum Length) ganham o contador "1.234 de 4.000".
   O menu usa as classes do stepper que o time já desenhou no Natcorp_Style_Min.css
   (nc-stepper, nc-stepper__item, is-active, is-ok, is-pending) — aqui só o comportamento.
   Itens lidos pelo nome: estão em cada parte abaixo (P52_COD_CARGO, P52_COD_REQ…).

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Reconhecer a página ................ p52 ou p76, e os nomes dos itens      CUIDADO
     [J2]  Ferramentas ........................ funções pequenas usadas no arquivo todo
     [J3]  As etapas .......................... uma por vez, o menu, Voltar / Próxima
     [J4]  O resumo da vaga ................... o cabeçalho do alto e "Detalhes"     PODE MEXER
     [J5]  Listas de requisitos ............... as linhas viram etiquetas
     [J6]  A prévia do anúncio ................ a vaga como o candidato vai ver      PODE MEXER
     [J7]  Seções opcionais ................... recolhidas enquanto vazias
     [J8]  Contadores de letras ............... "1.234 de 4.000 caracteres"
     [J9]  Ícones das seções .................. um desenho por assunto              PODE MEXER
     [J10] Campos que só o sistema altera ..... a Data de Situação                    PODE MEXER
     [J11] A Solicitação ...................... nº, situação, motivo, solicitante
     [J12] Seções como ficha .................. leitura e "Editar" / "Concluir"
     [J13] O cabeçalho de cada etapa .......... "Faltam 2 campos obrigatórios"
     [J14] Inscritos como cartões ............. colaboradores e candidatos
     [J15] A faixa da aprovação ............... quem aprovou, de quem é a vez
     [J16] Antes de publicar e as ações ....... a conferência e o lugar dos botões   PODE MEXER
     [J17] A barra fixa do topo ............... a altura que o resto desconta
     [J18] O maestro .......................... decide QUANDO cada parte é montada  CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Antes de publicar'  →  'Confira antes de publicar'
     Criei uma seção nova numa etapa
       → no APEX, ponha a classe nc-req-ficha nela para lê-la como documento. Sem classe, ela
         aparece como formulário comum. Nada a mudar aqui.
     Criei uma etapa nova
       → região filha de Steppers com a classe nc-req-etapa. Ela entra no menu sozinha, na
         ordem da Sequence. Nada a mudar aqui.
     Quero mudar o que o resumo do alto mostra   → [J4], listas fatos e detalhes.
     Mais um campo que só o sistema altera       → [J10], lista SO_SISTEMA.
     Renomeei um item P52_… (ou P76_…) no APEX
       → procure o nome antigo neste arquivo (Ctrl+F, sem o "P52_") e troque também. Se o nome
         for diferente nas duas páginas, ajuste a tabela PAGINAS em [J1].
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp requisição].
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
     it('COD_CARGO')        vira 'P52_COD_CARGO' (ou o nome certo na p76): o item no APEX.
     texto(…) / valor(…)    leem o que está num item do APEX (veja [J2]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* ═══ [J1] RECONHECER A PÁGINA ══════════════════════════════════════════════════════════
     O QUE FAZ  Lê o número da página (52 ou 76) e escolhe os nomes dos itens. As duas páginas
                usam os mesmos nomes, menos os da tabela PAGINAS abaixo (à esquerda o nome na
                p52, à direita o nome na p76). Um item que não existe numa das páginas fica
                vazio no resumo e na prévia, sem erro.
     COMO USAR  Em todo o arquivo os itens são lidos com it('NOME_NA_P52'): it() acrescenta o
                começo certo (P52_ ou P76_) e troca o nome quando a p76 usa outro.
     PODE MEXER a tabela PAGINAS, se um item for renomeado numa das páginas.
     CUIDADO    A primeira linha abaixo impede que o arquivo rode duas vezes (URL repetida na
                página) ou fora do APEX: não apague. Numa terceira página com os MESMOS nomes de
                itens não é preciso acrescentar nada; só se algum item tiver outro nome, ponha o
                número dela em PAGINAS com as trocas (ex.: '90': { COD_REQ: 'COD_REQUISICAO' }).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncRequisicao || !window.apex || !window.apex.jQuery) return;
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  /* as páginas de requisição com este desenho: Requisição de Pessoal (p. 52; app 2010) e
     Requisição de Posição (p. 76; app 200). Os itens têm os mesmos nomes, fora os da tabela
     NOMES abaixo (o nome da p. 52 → o da outra página); o que não existe numa página fica vazio. */
  /* o número da página só escolhe os nomes dos itens (P52_… ou P76_…) */
  /* PODE MEXER: nome do item na p52 → nome na p76 */
  var PAGINAS = { '52': {}, '76': {
    COD_REQ: 'COD_REQUISICAO', DT_REQ: 'DATA_REQUISICAO', COD_SIT_REQ: 'COD_SIT_REQUISICAO', DT_SIT_REQ: 'DT_SIT_REQUISICAO',
    QTD_POSICAO: 'QTDE_VAGAS', COD_MOT_REQ: 'MOT_ABERT_VAGA', COD_CCUSTO_DSP: 'COD_CCUSTO', COD_UNIDADE_ADM_DSP: 'COD_UNIDADE_ADM',
    COD_CCUSTO_CONTAB_DSP: 'COD_CCUSTO_CONTAB', COD_ATIVIDADE_DSP: 'ATIVIDADE', OBSERVACAO: 'TEXTO' } };
  var NOMES = PAGINAS[pag] || {};
  window.__ncRequisicao = true;
  var P = 'P' + pag + '_';
  function it(n) { return P + (NOMES[n] || n); }
  /* o que muda de uma página para a outra além dos nomes dos itens */
  var POSICAO = pag === '76';
  /* PODE MEXER: o título do alto numa requisição nova, em cada página */
  var NOVA = POSICAO ? 'Nova requisição de posição' : 'Nova requisição de pessoal';

  var $ = apex.jQuery;
  var ILU = {"recrutamento": "data:image/png;base64,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"};

  /* ═══ [J2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       texto(it('ITEM'))  o que a PESSOA VÊ no item (o nome da opção escolhida numa lista)
       valor(it('ITEM'))  o que o APEX GUARDA no item (o código da opção, ex.: 'S' ou 'N')
       porClasse('x')     as regiões que têm a classe x no APEX
       titulo(região)     o título da região, como aparece na tela
       brl(1234.5)        → "R$ 1.234,50"      curto('31/12/2026') → "31 dez 2026"
     QUANDO MEXER  Quase nunca. Os meses abreviados (MES3) podem ser mudados.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MOEDA = new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' });
  /* PODE MEXER: como os meses aparecem abreviados na tela */
  var MES3 = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  function num(t) {
    t = String(t === null || t === undefined ? '' : t).replace(/[^\d,.\-]/g, '');
    if (!t) return NaN;
    if (t.indexOf(',') > -1) t = t.replace(/\./g, '').replace(',', '.');
    return parseFloat(t);
  }
  function brl(n) { return isFinite(n) ? MOEDA.format(n).replace(/ /g, ' ') : ''; }
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function vazio(t) { return !t || /^\s*(-\s*selecione\s*-|-\s*todos\s*-|-)\s*$/i.test(t); }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim(); }
  /* "Diretoria De Recursos Humanos" → "Diretoria de Recursos Humanos" (a primeira palavra fica) */
  function bonito(t) { return String(t || '').replace(/(\s)(De|Da|Do|Das|Dos|E|Em|Para)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); }); }
  function curto(t) { var m = String(t || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return m ? (+m[1]) + ' ' + MES3[+m[2] - 1] + ' ' + m[3] : ''; }
  /* texto que a pessoa vê no item: a opção da lista, o texto do popup, o valor */
  function texto(id) {
    var e = document.getElementById(id);
    if (!e) return '';
    if (e.tagName === 'SELECT') { var o = e.options[e.selectedIndex]; return o && o.value !== '' && !vazio(o.text) ? o.text.trim() : ''; }
    if (e.type === 'hidden') { var d = document.getElementById(id + '_DISPLAY'); if (d) return d.textContent.trim(); var c = document.getElementById(id + '_CONTAINER'); var s = c && c.querySelector('.apex-item-display-only, .display_only'); return s ? s.textContent.trim() : ''; }
    if (e.type === 'checkbox' || e.type === 'radio') return e.checked ? 'S' : '';
    var v = String(e.value || '').trim();
    return vazio(v) ? '' : v;
  }
  function valor(id) { var it = apex.item(id); return it && it.node ? String(it.getValue() || '') : ''; }
  function simNao(id) { var v = valor(id); return v === 'S' || v === 'Y'; }
  function porClasse(cls) { return [].slice.call(document.querySelectorAll('.t-Region.' + cls + ', .t-ButtonRegion.' + cls)); }
  function corpoDe(reg) { return reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg; }
  function titulo(reg) { var h = reg.querySelector(':scope > .t-Region-header .t-Region-title'); if (!h) return ''; var c = h.cloneNode(true); [].forEach.call(c.querySelectorAll('.nc-native-header__subtitle'), function (x) { x.remove(); }); return c.textContent.replace(/\s+/g, ' ').trim(); }
  /* escondido pelo APEX (ação dinâmica / condição), sem contar o "uma etapa por vez" daqui */
  function escondido(e, ate) { for (; e && e !== ate && e !== document.body; e = e.parentElement) if (e.style && e.style.display === 'none' || e.hidden) return true; return false; }

  /* ═══ [J3] AS ETAPAS ═════════════════════════════════════════════════════════════════════
     O QUE FAZ  Mostra UMA etapa (região nc-req-etapa) por vez e monta:
                  • o menu das etapas, cada uma com o estado: "Completa", "Falta 1 campo",
                    "Corrigir" (erro do servidor), "N inscritos" (etapa Candidatos) ou
                    "N de M conferidos" (Prévia do anúncio). Setas ← → do teclado trocam;
                  • no fim de cada etapa, "← etapa anterior" e "Próxima: …";
                  • a troca é animada (desliza no sentido do avanço) e a página rola até o topo
                    da etapa, descontando a barra fixa do alto ([J17]).
     QUAL ETAPA ABRE  Um erro do servidor ganha de tudo (abre a etapa do erro); senão, a última
                etapa aberta, guardada no navegador (sessionStorage) por requisição; senão, a 1ª.
     O QUE CONTA COMO "FALTA"  Campo com "Value Required" no APEX, vazio e à vista na etapa.
     PODE MEXER os textos entre aspas ('Completa', 'Próxima: '…).
     VISUAL     Natcorp_Requisicao.css › [C1], [C4], [C5] e [C12]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var host = null, etapas = [], atual = 0;
  var CHAVE = 'nc-req-etapa-' + (valor(it('COD_REQ')) || 'nova');
  function lerEtapas() {
    host = porClasse('nc-req-etapas')[0] || null;
    etapas = porClasse('nc-req-etapa').filter(function (r) { return !escondido(r); });
  }
  /* o que falta: campos obrigatórios (is-required) vazios e à vista na etapa */
  function faltas(reg) {
    return [].slice.call(reg.querySelectorAll('.t-Form-fieldContainer.is-required')).filter(function (c) {
      if (escondido(c, reg)) return false;
      var id = c.id.replace(/_CONTAINER$/, '');
      return vazio(valor(id)) && vazio(texto(id));
    });
  }
  function erros(reg) { return reg.querySelectorAll('.t-Form-fieldContainer.is-error, .a-Form-error:not(:empty)').length; }
  function contarInscritos(reg) {
    var n = 0;
    [].forEach.call(reg.querySelectorAll('table.t-Report-report tbody tr'), function (tr) { if (tr.querySelector('td[headers]')) n++; });
    return n;
  }
  function montarMenu() {
    if (!host || !etapas.length) return;
    var corpo = corpoDe(host);
    var nav = document.getElementById('nc-req-menu');
    if (!nav) {
      nav = el('ol', 'nc-stepper nc-req-menu'); nav.id = 'nc-req-menu';
      nav.setAttribute('aria-label', 'Etapas da requisição');
      var t = trilho();
      t.insertBefore(nav, t.firstChild);
      nav.addEventListener('click', function (e) { var b = e.target.closest('[data-etapa]'); if (b) ir(+b.getAttribute('data-etapa'), true); });
      nav.addEventListener('keydown', function (e) {
        if (e.key !== 'ArrowRight' && e.key !== 'ArrowLeft') return;
        var i = atual + (e.key === 'ArrowRight' ? 1 : -1);
        if (i >= 0 && i < etapas.length) { ir(i, false); var b = nav.querySelector('[data-etapa="' + i + '"]'); if (b) b.focus(); e.preventDefault(); }
      });
    }
    nav.innerHTML = etapas.map(function (r, i) {
      var f = faltas(r).length, er = erros(r), cand = r.classList.contains('nc-req-candidatos');
      var estado = er ? 'is-pending' : f ? 'is-pending' : 'is-ok';
      var status = er ? 'Corrigir' : f ? (f === 1 ? 'Falta 1 campo' : 'Faltam ' + f + ' campos') : cand ? (function (n) { return n ? n + (n === 1 ? ' inscrito' : ' inscritos') : 'Nenhum inscrito'; })(contarInscritos(r)) : 'Completa';
      if (cand) estado = 'is-info';
      if (r.classList.contains('nc-req-etapa-previa')) {
        var ic = itensConferir(), ok = ic.filter(function (x) { return x[0]; }).length;
        estado = ok === ic.length ? 'is-ok' : 'is-info';
        status = ok === ic.length ? 'Pronto para publicar' : ok + ' de ' + ic.length + ' conferidos';
      }
      return '<li><button type="button" class="nc-stepper__item ' + estado + (i === atual ? ' is-active' : '') + '" data-etapa="' + i + '"' + (i === atual ? ' aria-current="step"' : '') + '>' +
        '<span class="nc-stepper__num" aria-hidden="true">' + (estado === 'is-ok' && i !== atual ? '<svg viewBox="0 0 24 24"><path d="M6.5 12.5l3.5 3.5 7.5-8"/></svg>' : (i + 1)) + '</span>' +
        '<span class="nc-stepper__text"><span class="nc-stepper__label">' + esc(titulo(r) || 'Etapa ' + (i + 1)) + '</span><span class="nc-stepper__status">' + esc(status) + '</span></span>' +
      '</button></li>';
    }).join('');
  }
  function montarPassos() {
    etapas.forEach(function (r, i) {
      var corpo = corpoDe(r);
      var p = corpo.querySelector(':scope > .nc-req-passos');
      if (!p) {
        p = el('div', 'nc-req-passos'); corpo.appendChild(p);
        p.addEventListener('click', function (e) { var b = e.target.closest('[data-ir]'); if (b) ir(+b.getAttribute('data-ir'), true); });
      }
      var ant = etapas[i - 1], prox = etapas[i + 1];
      p.innerHTML = (ant ? '<button type="button" class="nc-req-passo nc-req-passo--voltar" data-ir="' + (i - 1) + '"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M19 12H5M10.5 6.5 5 12l5.5 5.5"/></svg>' + esc(titulo(ant)) + '</button>' : '<span></span>') +
        (prox ? '<button type="button" class="nc-req-passo nc-req-passo--seguir" data-ir="' + (i + 1) + '">Próxima: ' + esc(titulo(prox)) + '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M5 12h14M13.5 6.5 19 12l-5.5 5.5"/></svg></button>' : '');
    });
  }
  function ir(i, rolar) {
    var de = atual;
    atual = Math.max(0, Math.min(etapas.length - 1, i));
    etapas.forEach(function (r, k) { r.classList.toggle('nc-req-fora', k !== atual); r.classList.toggle('nc-req-ativa', k === atual); });
    /* a troca se vê: a etapa entra deslizando no sentido do avanço (para trás, do outro
       lado) e as seções chegam em cascata curta. Só quando a pessoa troca, nunca ao carregar. */
    if (rolar && de !== atual && etapas[atual]) {
      var nova = etapas[atual];
      nova.classList.remove('nc-req-entra', 'nc-req-entra--volta');
      void nova.offsetWidth;
      nova.classList.add('nc-req-entra');
      if (atual < de) nova.classList.add('nc-req-entra--volta');
      clearTimeout(nova._ncEntra);
      nova._ncEntra = setTimeout(function () { nova.classList.remove('nc-req-entra', 'nc-req-entra--volta'); }, 900);
      var menu = document.getElementById('nc-req-menu');
      if (menu) { menu.classList.add('nc-req-trocou'); clearTimeout(menu._ncTroca); menu._ncTroca = setTimeout(function () { menu.classList.remove('nc-req-trocou'); }, 600); }
    }
    try { sessionStorage.setItem(CHAVE, String(atual)); } catch (e) { /* sem armazenamento: só não lembra a etapa */ }
    montarMenu();
    /* no celular o menu rola para o lado: a etapa atual fica à vista */
    var ativo = document.querySelector('#nc-req-menu .is-active');
    if (ativo && ativo.parentElement.parentElement.scrollWidth > ativo.parentElement.parentElement.clientWidth) {
      var nav = ativo.closest('ol');
      nav.scrollTo({ left: nav.scrollLeft + ativo.getBoundingClientRect().left - nav.getBoundingClientRect().left - 8, behavior: rolar ? 'smooth' : 'auto' });
    }
    /* relatórios e grades que estavam fora da vista recalculam a largura */
    setTimeout(function () { window.dispatchEvent(new Event('resize')); $(window).trigger('apexwindowresized'); }, 30);
    if (rolar) {
      /* o topo da etapa, abaixo da barra fixa (e, no celular, do menu que gruda) */
      var alvo = etapas[atual], tr = document.getElementById('nc-req-trilho');
      var folga = topo() + 16 + (window.innerWidth < 1100 && tr ? tr.offsetHeight : 0);
      if (alvo) window.scrollTo({ top: Math.max(0, alvo.getBoundingClientRect().top + window.scrollY - folga), behavior: 'smooth' });
    }
  }
  function etapaInicial() {
    /* um erro do servidor ganha de tudo: abre a etapa onde ele está */
    for (var i = 0; i < etapas.length; i++) if (erros(etapas[i])) return i;
    try { var s = parseInt(sessionStorage.getItem(CHAVE), 10); if (isFinite(s) && s < etapas.length) return s; } catch (e) { /* segue */ }
    return 0;
  }

  /* ═══ [J4] O RESUMO DA VAGA (no alto, sempre à vista) ════════════════════════════════════
     O QUE FAZ  Monta o cabeçalho no alto da região nc-req-etapas: "Requisição nº … · aberta em
                … · motivo", o CARGO em destaque, as marcas (vaga temporária, Confidencial,
                Para PCD, período de divulgação dito em relação a hoje), a situação e a
                estrutura da vaga. O resto fica atrás do botão "Detalhes".
                Numa requisição NOVA (sem cargo ainda), o alto vira uma faixa baixa com
                "x de N etapas completas" e uma barra de andamento.
     PODE MEXER • a lista  fatos  em montarResumo: o que aparece sempre no alto. Cada linha é
                  dado('Rótulo na tela', it('NOME_DO_ITEM')). Para mostrar mais um dado,
                  copie uma linha e troque o rótulo e o item.
                • a lista  detalhes : o que aparece em "Detalhes" (mesmo formato).
                • os textos entre aspas.
     LÊ DOS ITENS  COD_CARGO, COD_REQ, DT_REQ, COD_MOT_REQ, COD_SIT_REQ, QTD_POSICAO,
                DATA_INICIO, DATA_FIM, FLAG_TEMPORARIO, VAGA_CONFIDENCIAL, IND_DEF_FIS e os de
                fatos e detalhes.
     VISUAL     Natcorp_Requisicao.css › [C2], [C10] e [C17]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function local() {
    var t = texto(it('COD_LOCAL_TRAB'));
    var cs = t.match(/([A-Za-zÀ-ÿ'][A-Za-zÀ-ÿ' ]*)\/([A-Z]{2})\b/g) || [];
    var cidade = cs.length ? cs[cs.length - 1].match(/^(.*)\/([A-Z]{2})$/) : [];
    var nome = semCodigo(t).split(/\s*[|:]\s*/)[0];
    return cidade[1] ? bonito(cidade[1].trim().toLowerCase().replace(/(^|\s)\S/g, function (c) { return c.toUpperCase(); })) + '/' + cidade[2] : nome;
  }
  function dataBR(t) { var m = String(t || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function hoje() { var h = new Date(); return new Date(h.getFullYear(), h.getMonth(), h.getDate()); }
  /* o período de divulgação dito em relação a hoje — o selecionador vê na hora se está no ar */
  function publicacao() {
    var ini = dataBR(valor(it('DATA_INICIO'))), fim = dataBR(valor(it('DATA_FIM'))), h = hoje();
    if (fim && fim < h) return { estado: 'fim', texto: 'Publicação encerrada em ' + curto(valor(it('DATA_FIM'))) };
    if (ini && ini > h) return { estado: 'breve', texto: 'Publicação a partir de ' + curto(valor(it('DATA_INICIO'))) };
    if (ini && fim) return { estado: 'ar', texto: 'Publicada até ' + curto(valor(it('DATA_FIM'))) };
    return null;
  }
  var resumoAberto = false;
  /* o valor de um item como a pessoa vê (lista, popup, só exibição) */
  function valorCampo(id) {
    var e = document.getElementById(id);
    if (!e) return '';
    if (id === it('TIPO_PUBLICACAO')) return { T: 'Interna e externa', E: 'Externa', I: 'Interna' }[e.value] || '';
    if (e.tagName === 'SELECT') { var o = e.options[e.selectedIndex]; var t = o ? o.text.trim() : ''; return vazio(t) ? '' : t; }
    return texto(id);
  }
  function montarResumo() {
    if (!host) return;
    var corpo = corpoDe(host);
    var box = document.getElementById('nc-req-resumo');
    if (box && ACOES && ACOES.parentNode === box) box.parentNode.insertBefore(ACOES, box.nextSibling);
    if (!box) {
      box = el('section', 'nc-req-resumo'); box.id = 'nc-req-resumo'; box.setAttribute('aria-label', 'Resumo da vaga'); corpo.insertBefore(box, corpo.firstChild);
      box.addEventListener('click', function (e) {
        if (e.target.closest('.nc-req-mais')) { resumoAberto = !resumoAberto; montarResumo(); lugarDasAcoes(); return; }
        if (!e.target.closest('.nc-req-marca-ap')) return;
        var ap = porClasse('nc-req-aprovadores')[0], et = ap && ap.closest('.nc-req-etapa');
        var i = etapas.indexOf(et);
        if (i >= 0) ir(i, false);
        setTimeout(function () { if (ap) window.scrollTo({ top: ap.getBoundingClientRect().top + window.scrollY - topo() - 16, behavior: 'smooth' }); }, 60);
      });
    }
    var cargo = bonito(semCodigo(texto(it('COD_CARGO'))));
    /* requisição sem cargo (nova): não há vaga para resumir ainda — uma faixa baixa com o
       andamento das etapas, em vez de um cabeçalho cheio de "não informado" */
    if (!cargo) {
      var conta = etapas.filter(function (r) { return !r.classList.contains('nc-req-candidatos') && !r.classList.contains('nc-req-etapa-previa'); });
      var prontas = conta.filter(function (r) { return !faltas(r).length && !erros(r); }).length;
      var pct = conta.length ? Math.round(prontas / conta.length * 100) : 0;
      box.classList.add('nc-req-resumo--nova');
      box.innerHTML =
        (ILU.recrutamento ? '<span class="nc-req-ilu" aria-hidden="true" style="background-image:url(' + ILU.recrutamento + ')"></span>' : '') +
        '<div class="nc-req-nova-texto"><h2 class="nc-req-nova-titulo">' + (valor(it('COD_REQ')) ? 'Requisição nº ' + esc(valor(it('COD_REQ'))) : NOVA) + '</h2>' +
        '<p class="nc-req-nova-sub">O resumo da vaga aparece aqui assim que você escolher o cargo.</p></div>' +
        '<div class="nc-req-andamento" role="img" aria-label="' + prontas + ' de ' + conta.length + ' etapas completas">' +
          '<p><b>' + prontas + ' de ' + conta.length + '</b> etapas completas</p>' +
          '<span class="nc-req-barra"><span style="width:' + pct + '%"></span></span></div>';
      return;
    }
    box.classList.remove('nc-req-resumo--nova');
    var n = parseInt(valor(it('QTD_POSICAO')), 10);
    var sit = texto(it('COD_SIT_REQ'));
    /* no alto, onde a vaga fica na estrutura; o resto em "+ Detalhes" */
    var dado = function (rot, id) { var v = valorCampo(id); return [rot, v ? formatar(rot, v) : '']; };
    /* PODE MEXER: o que o resumo mostra sempre — dado('Rótulo', it('ITEM')) */
    var fatos = [
      dado('Empresa', it('COD_EMPRESA')),
      dado('Filial', it('COD_FILIAL')),
      dado('Centro de custo', it('COD_CCUSTO_DSP')),
      dado('Unidade administrativa', it('COD_UNIDADE_ADM_DSP')),
      dado('Unidade de negócio', it('COD_UN_NEGOCIO'))
    ].filter(function (f) { return f[1]; });
    var pb0 = publicacao();
    /* PODE MEXER: o que aparece em "Detalhes" */
    var detalhes = [
      ['Posições', isFinite(n) ? esc(n + (n === 1 ? ' vaga' : ' vagas')) : ''],
      ['Remuneração total', esc(brl(num(valor(it('TOTAL_SALARIO')))))],
      dado('Tipo de salário', it('TIPO_SALARIO')),
      dado('Vínculo', it('VINCULO')),
      dado('Tipo de contrato', it('TIPO_CONTRATO')),
      dado('Modalidade', it('TIPO_MODALIDADE')),
      dado('Horário', it('COD_HORARIO')),
      dado('Carga horária', it('RT_JORNADA_MENSAL')),
      dado('Local de trabalho', it('COD_LOCAL_TRAB')),
      dado('Atividade (serviço)', it('COD_ATIVIDADE_DSP')),
      dado('C. custo contábil', it('COD_CCUSTO_CONTAB_DSP')),
      dado('Sindicato', it('COD_SINDICATO')),
      dado('Grau de instrução', it('COD_INSTRUCAO')),
      ['Divulgação', pb0 ? esc(pb0.texto) : '']
    ].filter(function (f) { return f[1]; });
    var marcas = [
      texto(it('FLAG_TEMPORARIO')) ? 'Vaga ' + texto(it('FLAG_TEMPORARIO')).toLowerCase() : '',
      simNao(it('VAGA_CONFIDENCIAL')) ? 'Confidencial' : '',
      simNao(it('IND_DEF_FIS')) ? 'Para PCD' : ''
    ].filter(Boolean);
    var pub = publicacao();
    var apv = null;   /* a aprovação tem a faixa própria, logo abaixo do resumo */
    var linha = [valor(it('COD_REQ')) ? 'Requisição nº ' + valor(it('COD_REQ')) : 'Nova requisição', curto(valor(it('DT_REQ'))) ? 'aberta em ' + curto(valor(it('DT_REQ'))) : '', bonito(texto(it('COD_MOT_REQ')))].filter(Boolean).join(' · ');
    box.innerHTML =
      (ILU.recrutamento ? '<span class="nc-req-ilu" aria-hidden="true" style="background-image:url(' + ILU.recrutamento + ')"></span>' : '') +
      '<div class="nc-req-resumo-topo">' +
        '<div class="nc-req-resumo-quem"><p class="nc-req-resumo-linha">' + esc(linha) + '</p>' +
        '<h2 class="nc-req-resumo-cargo">' + esc(cargo) + '</h2>' +
        (marcas.length || pub || apv ? '<p class="nc-req-marcas">' + marcas.map(function (m) { return '<span>' + esc(m) + '</span>'; }).join('') +
          (pub ? '<span class="nc-req-marca--' + pub.estado + '">' + esc(pub.texto) + '</span>' : '') +
          (apv ? '<button type="button" class="nc-req-marca-ap nc-req-marca-ap--' + (apv.reprovado ? 'nao' : apv.atual < 0 ? 'ok' : apv.botoes.length ? 'vez' : 'pend') + '">' +
            esc(apv.reprovado ? 'Reprovada' : apv.atual < 0 ? 'Aprovada' : apv.botoes.length ? 'Aguardando a sua aprovação' : 'Aprovação ' + apv.aprovados + ' de ' + apv.passos.length + ' · ' + apv.passos[apv.atual].quem.nome) + '</button>' : '') + '</p>' : '') + '</div>' +
        (sit ? '<p class="nc-req-situacao nc-req-situacao--' + esc(sit.toLowerCase().replace(/[^a-z]+/g, '-')) + '">' + esc(sit) + '</p>' : '') +
      '</div>' +
      (fatos.length ? '<dl class="nc-req-fatos">' + fatos.map(function (f) { return '<div><dt>' + esc(f[0]) + '</dt><dd>' + f[1] + '</dd></div>'; }).join('') + '</dl>' : '') +
      (detalhes.length ? '<button type="button" class="nc-req-mais" aria-expanded="' + resumoAberto + '" aria-controls="nc-req-detalhes">' +
          '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="' + (resumoAberto ? 'M5 12h14' : 'M12 5v14M5 12h14') + '"/></svg>' + (resumoAberto ? 'Menos detalhes' : 'Detalhes') + '</button>' +
        '<dl class="nc-req-detalhes" id="nc-req-detalhes"' + (resumoAberto ? '' : ' hidden') + '>' + detalhes.map(function (f) { return '<div><dt>' + esc(f[0]) + '</dt><dd>' + f[1] + '</dd></div>'; }).join('') + '</dl>' : '');
    box.classList.toggle('nc-req-resumo--aberto', resumoAberto);
  }

  /* ═══ [J5] LISTAS DE REQUISITOS: AS LINHAS VIRAM ETIQUETAS ═══════════════════════════════
     O QUE FAZ  Em cada relatório com a classe nc-req-lista, cada linha vira uma etiqueta, com
                as colunas ditas em palavras ("3" → "3 anos"; "Concluído: não" → "em
                andamento"). Com a coluna EXIGÊNCIA, as etiquetas se separam em Obrigatório e
                Desejável. A linha de total (sem "Apagar", só o valor) vai para o rodapé.
                O × de cada etiqueta é o link "Apagar" original do relatório (o mesmo diálogo).
     CUIDADO    O link de apagar é achado pela classe "apagar" ou t-Button--danger; a coluna de
                exigência pelo nome EXIGÊNCIA / EXIGENCIA. Mudar isso no relatório quebra a lista.
     PODE MEXER 'Obrigatório', 'Desejável', 'Nenhum item ainda.', 'Total'.
     VISUAL     Natcorp_Requisicao.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarListas() {
    porClasse('nc-req-lista').forEach(function (reg) {
      var corpo = corpoDe(reg);
      var linhas = [].slice.call(reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers]'); });
      reg.classList.toggle('nc-req-lista--vazia', !linhas.length);
      var box = corpo.querySelector(':scope > .nc-req-etiquetas');
      if (!linhas.length) { if (box) box.remove(); var nd = reg.querySelector('.nodatafound'); if (nd) nd.textContent = 'Nenhum item ainda.'; return; }
      if (!box) { box = el('div', 'nc-req-etiquetas'); corpo.insertBefore(box, corpo.firstChild); }
      var grupos = { o: [], d: [], s: [] }, total = '';
      linhas.forEach(function (tr) {
        var ex = tr.querySelector('td[headers="EXIGÊNCIA"], td[headers="EXIGENCIA"]');
        /* o link já levado para a etiqueta num desenho anterior fica guardado na linha */
        var apagar = tr.querySelector('a.apagar, a.t-Button--danger') || tr._ncApagar || null;
        if (apagar) tr._ncApagar = apagar;
        /* cada coluna dita com o nome dela quando o valor sozinho não diz nada:
           "3" → "3 anos", "Não" → "Certificado: não"; "Concluído: não" → "em andamento" */
        var partes = [];
        [].forEach.call(tr.querySelectorAll('td[headers]'), function (td) {
          var h = td.getAttribute('headers');
          var v = td.textContent.replace(/\s+/g, ' ').trim().replace(/\.$/, '');
          if (td === ex || /^DERIVED\$|^APAGAR/.test(h) || !v || v === '-') return;
          var th = reg.querySelector('th[id="' + h + '"]');
          var nome = th ? th.textContent.replace(/\s+/g, ' ').trim() : '';
          if (/conclu/i.test(h + nome)) { if (/^n/i.test(v)) partes.push('em andamento'); return; }
          if (/^(sim|não|nao)$/i.test(v)) { partes.push((nome || h) + ': ' + v.toLowerCase()); return; }
          if (/^\d+([.,]\d+)?$/.test(v) && nome) { partes.push(v + ' ' + nome.toLowerCase()); return; }
          partes.push(v);
        });
        var chave = !ex ? 's' : /obrig/i.test(ex.textContent) ? 'o' : 'd';
        /* a linha de total do relatório (sem "Apagar", só o valor) vai para o rodapé */
        if (!apagar && linhas.length > 1 && partes.length === 1 && /^R\$|^\d/.test(partes[0])) { total = partes[0]; return; }
        grupos[chave].push({ texto: partes.join(' · '), apagar: apagar });
      });
      box.innerHTML = '';
      [['o', 'Obrigatório'], ['d', 'Desejável'], ['s', '']].forEach(function (g) {
        if (!grupos[g[0]].length) return;
        var bloco = el('div', 'nc-req-grupo-etq nc-req-grupo-etq--' + g[0]);
        if (g[1]) bloco.appendChild(el('p', 'nc-req-grupo-nome', g[1]));
        var ul = el('ul', 'nc-req-chips');
        grupos[g[0]].forEach(function (it) {
          var li = el('li', 'nc-req-chip');
          li.appendChild(el('span', 'nc-req-chip-texto', esc(it.texto)));
          if (it.apagar) {
            /* o link "Apagar" do relatório é o de verdade (abre o diálogo de sempre): vai junto */
            it.apagar.classList.add('nc-req-chip-apagar');
            it.apagar.setAttribute('aria-label', 'Remover ' + it.texto);
            it.apagar.setAttribute('title', 'Remover');
            li.appendChild(it.apagar);
          }
          ul.appendChild(li);
        });
        bloco.appendChild(ul);
        box.appendChild(bloco);
      });
      if (total) box.appendChild(el('p', 'nc-req-total', 'Total <b>' + esc(total.replace(/^R\$\s*/, 'R$ ')) + '</b>'));
    });
  }

  /* ═══ [J6] A PRÉVIA DO ANÚNCIO ═══════════════════════════════════════════════════════════
     O QUE FAZ  Na região nc-req-previa (vazia no APEX), desenha a vaga como o candidato vai
                vê-la: canal e período de divulgação, cargo, empresa, etiquetas (local,
                modalidade, vínculo, vagas, PCD), a descrição das atividades e os requisitos
                ("O que é obrigatório" / "Será um diferencial"). Embaixo, "Antes de publicar"
                ([J16]).
     LÊ DOS ITENS  COD_CARGO, DESC_ATIVIDADES, TIPO_PUBLICACAO (T/E/I), DATA_INICIO, DATA_FIM,
                COD_EMPRESA, QTD_POSICAO, COD_LOCAL_TRAB, TIPO_MODALIDADE, VINCULO, IND_DEF_FIS.
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_Requisicao.css › [C7] e [C13]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarPrevia() {
    porClasse('nc-req-previa').forEach(function (reg) {
      var corpo = corpoDe(reg);
      var box = corpo.querySelector(':scope > .nc-req-anuncio');
      if (!box) { box = el('article', 'nc-req-anuncio'); corpo.insertBefore(box, corpo.firstChild); }
      var cargo = bonito(semCodigo(texto(it('COD_CARGO')))) || 'Cargo da vaga';
      var desc = valor(it('DESC_ATIVIDADES')).trim();
      var pub = { T: 'interna e externa', E: 'externa', I: 'interna' }[valor(it('TIPO_PUBLICACAO'))] || texto(it('TIPO_PUBLICACAO')).toLowerCase();
      var ini = curto(valor(it('DATA_INICIO'))), fim = curto(valor(it('DATA_FIM')));
      var obrig = [], desej = [];
      porClasse('nc-req-lista').forEach(function (l) {
        [].forEach.call(l.querySelectorAll('.nc-req-grupo-etq--o .nc-req-chip-texto'), function (t) { obrig.push(t.textContent); });
        [].forEach.call(l.querySelectorAll('.nc-req-grupo-etq--d .nc-req-chip-texto, .nc-req-grupo-etq--s .nc-req-chip-texto'), function (t) { desej.push(t.textContent); });
      });
      var empresa = bonito(semCodigo(texto(it('COD_EMPRESA'))));
      var nv = parseInt(valor(it('QTD_POSICAO')), 10);
      var chips = [local(), texto(it('TIPO_MODALIDADE')), bonito(semCodigo(texto(it('VINCULO')))), isFinite(nv) && nv > 0 ? nv + (nv === 1 ? ' vaga' : ' vagas') : '', simNao(it('IND_DEF_FIS')) ? 'Vaga para PCD' : ''].filter(Boolean);
      var lista = function (titulo, xs, cls) { return xs.length ? '<div class="nc-req-anuncio-req ' + cls + '"><p>' + titulo + '</p><ul>' + xs.map(function (o) { return '<li>' + esc(o) + '</li>'; }).join('') + '</ul></div>' : ''; };
      box.innerHTML =
        '<header class="nc-req-anuncio-topo">' +
          '<p class="nc-req-anuncio-canal">' + esc(pub ? 'Divulgação ' + pub : 'Divulgação') + (ini || fim ? ' · ' + esc([ini, fim].filter(Boolean).join(' a ')) : '') + '</p>' +
          '<h3 class="nc-req-anuncio-cargo">' + esc(cargo) + '</h3>' +
          (empresa ? '<p class="nc-req-anuncio-empresa">' + esc(empresa) + '</p>' : '') +
          (chips.length ? '<ul class="nc-req-anuncio-chips">' + chips.map(function (c) { return '<li>' + esc(c) + '</li>'; }).join('') + '</ul>' : '') +
        '</header>' +
        (desc ? '<div class="nc-req-anuncio-texto">' + esc(desc.replace(/^[ \t]*¿[ \t]*/gm, '')).replace(/\n{2,}/g, '</p><p>').replace(/\n/g, '<br>').replace(/^/, '<p>') + '</p></div>'
          : '<p class="nc-req-anuncio-vazio">A descrição das atividades (etapa Detalhamento) aparece aqui, do jeito que o candidato vai ler.</p>') +
        (obrig.length || desej.length ? '<div class="nc-req-anuncio-reqs">' + lista('O que é obrigatório', obrig, 'is-obrig') + lista('Será um diferencial', desej, 'is-desej') + '</div>' : '');
      /* abaixo do anúncio (no celular; no computador ele fica no trilho) */
      var lista = corpo.querySelector(':scope > .nc-req-conferir');
      if (!lista) { lista = el('aside', 'nc-req-conferir nc-req-conferir--previa'); corpo.insertBefore(lista, box.nextSibling); }
      lista.innerHTML = htmlConferir();
    });
  }

  /* ═══ [J7] SEÇÕES OPCIONAIS ══════════════════════════════════════════════════════════════
     O QUE FAZ  A região com a classe nc-req-opcional fica recolhida enquanto todos os campos
                dela estão vazios, com um botão no cabeçalho para abrir ("Indicar um candidato"
                ou "Preencher …"). Com algum valor ou erro, fica aberta.
     PODE MEXER o texto do botão para cada título de região, na lista
                { 'Indicação de Candidato': 'Indicar um candidato' } dentro de montarOpcionais.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var abertas = {};
  function montarOpcionais() {
    porClasse('nc-req-opcional').forEach(function (reg) {
      var cheia = [].some.call(reg.querySelectorAll('input:not([type="hidden"]):not([type="checkbox"]):not([type="radio"]), select, textarea'), function (c) { return !vazio(c.value); }) || erros(reg) > 0;
      var aberta = cheia || abertas[reg.id];
      reg.classList.toggle('nc-req-recolhida', !aberta);
      var cab = reg.querySelector(':scope > .t-Region-header');
      var b = reg.querySelector('.nc-req-abrir');
      if (!b) {
        b = el('button', 'nc-req-abrir'); b.type = 'button';
        /* no cabeçalho da região, junto dos botões dela (ou, sem cabeçalho, antes do corpo) */
        var area = cab && cab.querySelector('.t-Region-headerItems--buttons');
        if (cab && !area) { area = el('div', 't-Region-headerItems t-Region-headerItems--buttons'); cab.appendChild(area); }
        if (area) area.insertBefore(b, area.firstChild); else reg.insertBefore(b, reg.querySelector(':scope > .t-Region-bodyWrap'));
        b.addEventListener('click', function () { abertas[reg.id] = !reg.classList.contains('nc-req-recolhida') ? false : true; agendar(); });
      }
      b.hidden = cheia;
      b.setAttribute('aria-expanded', String(!!aberta));
      b.innerHTML = aberta ? 'Recolher' : '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 5v14M5 12h14"/></svg>' + esc(({ 'Indicação de Candidato': 'Indicar um candidato' })[titulo(reg)] || 'Preencher ' + titulo(reg).toLowerCase());
    });
  }

  /* ═══ [J8] CONTADORES DE LETRAS ═══════════════════════════════════════════════════════════
     O QUE FAZ  Embaixo de cada caixa de texto das etapas que tem limite de tamanho, mostra
                "120 de 4.000 caracteres" enquanto a pessoa escreve. O limite vem do APEX
                (Maximum Length). Perto do limite (90%), o contador muda de cor.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarContadores() {
    [].forEach.call(document.querySelectorAll('.nc-req-etapa textarea[maxlength]'), function (t) {
      var max = parseInt(t.getAttribute('maxlength'), 10);
      if (!max) return;
      var c = document.getElementById(t.id + '_nc-cont');
      if (!c) {
        c = el('p', 'nc-req-contador'); c.id = t.id + '_nc-cont'; c.setAttribute('aria-live', 'polite');
        var w = t.closest('.t-Form-inputContainer') || t.parentNode; w.appendChild(c);
        t.addEventListener('input', function () { contar(t, c, max); });
      }
      contar(t, c, max);
    });
  }
  function contar(t, c, max) {
    var n = t.value.length;
    c.textContent = n.toLocaleString('pt-BR') + ' de ' + max.toLocaleString('pt-BR') + ' caracteres';
    c.classList.toggle('nc-req-contador--perto', n > max * 0.9);
  }

  /* ═══ [J9] ÍCONES DAS SEÇÕES ══════════════════════════════════════════════════════════════
     O QUE FAZ  Põe um desenho por assunto no cabeçalho de cada seção das etapas, no lugar do
                losango repetido. O desenho é escolhido pelo TÍTULO da região.
     PODE MEXER a lista ICONES: cada linha é [padrão de busca do título, desenho SVG]. Para uma
                seção nova ganhar o ícone de outra, acrescente a palavra no padrão (ex.:
                /remunera|benef/i). O primeiro padrão que combinar vence.
     CUIDADO    Os trechos entre barras, como /hor[aá]rio/i, são "padrões de busca" (expressões
                regulares): [aá] aceita "a" ou "á"; | quer dizer "ou"; o i final ignora
                maiúsculas. Os desenhos (path d=…) não precisam ser mexidos.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: [padrão de busca do título da seção, desenho] */
  var ICONES = [
    [/solicita|requisi[cç][aã]o de pessoal/i, '<path d="M8 3.5h6l4 4v13H8z"/><path d="M14 3.5v4h4M10.5 12h5M10.5 15.5h5"/><path d="M6 6.5v14.5h10"/>'],
    [/informa[cç][oõ]es da vaga/i, '<rect x="3.5" y="7.5" width="17" height="12" rx="2"/><path d="M8.5 7.5v-2a1.5 1.5 0 0 1 1.5-1.5h4a1.5 1.5 0 0 1 1.5 1.5v2M3.5 12.5h17"/>'],
    [/empresa|estrutura/i, '<path d="M4 20.5V5.5l8-2v17M12 8.5l8 2.5v9.5M2.5 20.5h19M7 8h2M7 11.5h2M7 15h2M15 13.5h2M15 17h2"/>'],
    [/local de trabalho/i, '<path d="M12 21s-6.5-5.6-6.5-11a6.5 6.5 0 0 1 13 0c0 5.4-6.5 11-6.5 11z"/><circle cx="12" cy="10" r="2.5"/>'],
    [/publica[cç][aã]o/i, '<path d="M3.5 10v4l11 5V5z"/><path d="M14.5 8.5a4 4 0 0 1 0 7M7.5 15.5l1 4.5h3l-1-3"/>'],
    [/^cargo/i, '<rect x="4" y="3.5" width="16" height="17" rx="2"/><circle cx="12" cy="10" r="3"/><path d="M7.5 17a4.5 4.5 0 0 1 9 0"/>'],
    [/hor[aá]rio/i, '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>'],
    [/frequ[eê]ncia|ponto/i, '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4M8.5 14.5l2.5 2.5 4.5-5"/>'],
    [/remunera/i, '<ellipse cx="9" cy="7" rx="5.5" ry="2.5"/><path d="M3.5 7v4c0 1.4 2.5 2.5 5.5 2.5s5.5-1.1 5.5-2.5V7"/><path d="M9.5 16.3c.6.1 1.3.2 2 .2 3 0 5.5-1.1 5.5-2.5v-3c1.9.4 3.5 1.2 3.5 2.3v4c0 1.4-2.5 2.5-5.5 2.5S9.5 18.7 9.5 17.3z"/>'],
    [/insalub|periculos/i, '<path d="M12 3.5l7.5 3v5.5c0 4.5-3.2 7.7-7.5 9-4.3-1.3-7.5-4.5-7.5-9V6.5z"/><path d="M12 8.5v4.5M12 16v.5"/>'],
    [/projeto|contrato/i, '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4M9.5 16c1.5-2.5 2.5-2.5 3 0s1.5 2.5 3 0M9.5 11.5h4"/>'],
    [/aprovadores/i, '<circle cx="6" cy="5.5" r="2.5"/><circle cx="6" cy="18.5" r="2.5"/><path d="M6 8v8M11 5.5h4.5a3 3 0 0 1 0 6H9.5a3 3 0 0 0 0 6H14"/><path d="M15.5 16l2.5 2.5 3.5-4"/>'],
    [/avaliar/i, '<circle cx="9" cy="8" r="3.5"/><path d="M2.5 20a6.5 6.5 0 0 1 13 0M15 11.5l2 2 4-4.5"/>'],
    [/caracter[ií]sticas do candidato/i, '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>'],
    [/indica[cç][aã]o de candidato/i, '<circle cx="10" cy="8" r="3.5"/><path d="M3.5 20a6.5 6.5 0 0 1 13 0M19 7.5v6M16 10.5h6"/>'],
    [/requisitos/i, '<path d="M2.5 9l9.5-4.5L21.5 9 12 13.5z"/><path d="M6.5 11v5c1.5 1.5 3.5 2.3 5.5 2.3s4-.8 5.5-2.3v-5M21.5 9v5"/>'],
    [/desempenho/i, '<circle cx="12" cy="12" r="8.5"/><circle cx="12" cy="12" r="4.5"/><circle cx="12" cy="12" r="1"/>'],
    [/detalhamento/i, '<path d="M4 20h16M14.5 4.5l5 5L9 20H4v-5z"/>'],
    [/descri[cç][aã]o de atividades/i, '<path d="M4 20h16M14.5 4.5l5 5L9 20H4v-5z"/>'],
    [/observa[cç][oõ]es/i, '<path d="M4 5.5h16v11H9l-5 4z"/><path d="M8 10h8M8 13h5"/>'],
    [/fatur/i, '<path d="M7 3.5h10v17l-2.5-1.5L12 20.5 9.5 19 7 20.5z"/><path d="M9.5 8h5M9.5 11.5h5M9.5 15h3"/>'],
    [/^pcd$|defici/i, '<circle cx="12" cy="4.5" r="1.8"/><path d="M12 7.5v6h4.5l2 5M12 10.5h4"/><path d="M8.5 11a5.5 5.5 0 1 0 7 7.2"/>'],
    [/ferramentas|equipamentos/i, '<path d="M14.5 6.5a4 4 0 0 0-5.3 5.3L4 17l3 3 5.2-5.2a4 4 0 0 0 5.3-5.3l-2.5 2.5-2.5-.5-.5-2.5z"/>'],
    [/pr[eé]via/i, '<path d="M2 12s3.5-6.5 10-6.5S22 12 22 12s-3.5 6.5-10 6.5S2 12 2 12z"/><circle cx="12" cy="12" r="3"/>'],
    [/perfil da vaga/i, '<circle cx="12" cy="12" r="8.5"/><path d="M15.5 8.5l-2 5-5 2 2-5z"/>'],
    [/parecer/i, '<path d="M4 5.5h16v11H9l-5 4z"/><path d="M8 10h8M8 13h5"/>'],
    [/colaboradores/i, '<circle cx="9" cy="8" r="3.5"/><path d="M2.5 20a6.5 6.5 0 0 1 13 0"/><circle cx="17" cy="9" r="2.5"/><path d="M17.5 14.5a5 5 0 0 1 4 5"/>'],
    [/candidatos/i, '<circle cx="10" cy="8" r="3.5"/><path d="M3.5 20a6.5 6.5 0 0 1 9.5-5.8"/><circle cx="17" cy="16" r="3"/><path d="M19.2 18.2L21.5 20.5"/>']
  ];
  function montarIcones() {
    [].forEach.call(document.querySelectorAll('.nc-req-etapa .t-Region > .t-Region-header .t-Region-headerIcon'), function (ic) {
      if (ic.querySelector('.nc-req-icone')) return;
      var t = titulo(ic.closest('.t-Region'));
      var achado = ICONES.filter(function (i) { return i[0].test(t); })[0];
      if (!achado) return;
      ic.classList.add('nc-req-com-icone');
      ic.insertAdjacentHTML('beforeend', '<svg class="nc-req-icone" viewBox="0 0 24 24" aria-hidden="true">' + achado[1] + '</svg>');
    });
  }

  /* ═══ [J10] CAMPOS QUE SÓ O SISTEMA ALTERA ═══════════════════════════════════════════════
     O QUE FAZ  Os itens da lista SO_SISTEMA ficam somente leitura NA TELA, sem calendário, com
                a nota "Atualizada pelo sistema quando a situação muda".
     IMPORTANTE readonly, não disabled: o valor continua indo no envio, então os processos que
                gravam a data seguem iguais. A regra de verdade deve ficar também no APEX.
     PODE MEXER a lista SO_SISTEMA: acrescente  it('NOME_DO_ITEM')  separado por vírgula.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- campos que só o programa altera ----------
     Data de Situação muda junto com a situação, pelo sistema. Na tela fica somente leitura
     (readonly, não disabled: o valor continua indo no envio da página, como antes) e sem o
     botão do calendário. A regra de verdade deve ficar também no APEX (ver o guia). */
  /* PODE MEXER: os itens que só o sistema altera */
  var SO_SISTEMA = [it('DT_SIT_REQ')];
  function travarCampos() {
    SO_SISTEMA.forEach(function (id) {
      var e = document.getElementById(id);
      if (!e || e.dataset.ncTravado) return;
      e.dataset.ncTravado = '1';
      e.readOnly = true;
      e.setAttribute('aria-readonly', 'true');
      e.setAttribute('tabindex', '-1');
      var c = document.getElementById(id + '_CONTAINER');
      if (c) {
        c.classList.add('nc-req-so-sistema');
        var w = c.querySelector('.t-Form-inputContainer') || c;
        if (!w.querySelector('.nc-req-so-sistema-nota')) w.appendChild(el('p', 'nc-req-so-sistema-nota', 'Atualizada pelo sistema quando a situação muda'));
      }
    });
  }

  /* há algo que a pessoa possa mudar nesta seção? (sem nada editável, não há "Editar") — usado em [J12] */
  function editavel(reg) {
    return [].some.call(reg.querySelectorAll('.t-Form-fieldContainer'), function (c) {
      if (escondido(c, reg)) return false;
      /* o popup de lista é sempre readonly (a escolha é na janela): conta como editável se não
         estiver desabilitado — senão a seção abria só para leitura, sem "Editar" */
      var popup = c.classList.contains('apex-item-wrapper--popup-lov');
      return [].some.call(c.querySelectorAll('input:not([type="hidden"]), select, textarea'), function (i) { return !i.disabled && (!i.readOnly || popup) && !i.classList.contains('apex_disabled'); });
    }) || [].some.call(corpoDe(reg).querySelectorAll('.t-Button'), function (b) {
      /* 04/10: botão da página no corpo da seção (ex.: o do solicitante, ADD_LOCAL) só aparece
         no formulário; sem campo editável não havia "Editar" e o botão ficava inalcançável */
      return !b.disabled && !escondido(b, reg) && !b.closest('.nc-req-leitura');
    });
  }

  /* ═══ [J11] A SOLICITAÇÃO ═════════════════════════════════════════════════════════════════
     O QUE FAZ  Numa requisição gravada, a seção nc-req-solicitacao (lida como ficha, [J12])
                mostra: "Requisição nº …" (e "criada a partir da nº …"), a situação com um
                cadeado e "desde …", o motivo, a data de abertura e o solicitante (iniciais,
                nome, cargo, empresa, matrícula).
     LÊ DOS ITENS  SOLICITANTE ("empresa / pessoa / cargo", cada parte "código - nome"),
                COD_SIT_REQ, DT_SIT_REQ, DT_REQ, COD_REQ, COD_REQ_PAI, COD_MOT_REQ.
     PODE MEXER os rótulos entre aspas ('Situação', 'Motivo', 'Aberta em', 'Solicitante').
     VISUAL     Natcorp_Requisicao.css › [C15]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function lerSolicitante() {
    var partes = String(valor(it('SOLICITANTE')) || texto(it('SOLICITANTE'))).split(/\s+\/\s+/).map(function (p) {
      var m = p.match(/^\s*([\w.]+)\s+-\s+(.+)$/); return m ? { cod: m[1], nome: bonito(capitalizar(m[2].trim())) } : { cod: '', nome: bonito(capitalizar(p.trim())) };
    });
    return { empresa: partes[0] || null, pessoa: partes[1] || null, cargo: partes[2] || null };
  }
  function htmlSolicitacao() {
    var sol = lerSolicitante();
    var nome = sol.pessoa ? sol.pessoa.nome : '';
    var sit = texto(it('COD_SIT_REQ'));
    var dSit = valor(it('DT_SIT_REQ')), dReq = valor(it('DT_REQ'));
    var pai = valor(it('COD_REQ_PAI'));
    var classe = sit ? sit.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-z]+/g, '-') : '';
    return '<div class="nc-req-sol">' +
      '<div class="nc-req-sol-num"><p class="nc-req-sol-rot">Requisição</p><p class="nc-req-sol-n">nº ' + esc(valor(it('COD_REQ')) || '—') + '</p>' +
        (pai ? '<p class="nc-req-sol-origem">criada a partir da nº ' + esc(pai) + '</p>' : '') + '</div>' +
      '<div class="nc-req-sol-linha">' +
        (sit ? '<div class="nc-req-sol-item"><p class="nc-req-sol-rot">Situação</p><p><span class="nc-req-situacao nc-req-situacao--' + esc(classe) + '">' + esc(sit) + '</span></p>' +
          (dSit ? '<p class="nc-req-sol-sub"><svg viewBox="0 0 24 24" aria-hidden="true"><rect x="5" y="10.5" width="14" height="10" rx="2"/><path d="M8.5 10.5V8a3.5 3.5 0 0 1 7 0v2.5"/></svg>desde ' + esc(curto(dSit) || dSit) + '</p>' : '') + '</div>' : '') +
        '<div class="nc-req-sol-item"><p class="nc-req-sol-rot">Motivo</p><p class="nc-req-sol-v">' + esc(bonito(texto(it('COD_MOT_REQ'))) || '—') + '</p></div>' +
        '<div class="nc-req-sol-item"><p class="nc-req-sol-rot">Aberta em</p><p class="nc-req-sol-v">' + esc(curto(dReq) || dReq || '—') + '</p></div>' +
      '</div>' +
      (nome ? '<div class="nc-req-sol-quem"><span class="nc-req-avatar" aria-hidden="true">' + esc(iniciais(nome)) + '</span>' +
        '<div><p class="nc-req-sol-rot">Solicitante</p><p class="nc-req-sol-nome">' + esc(nome) + '</p>' +
        '<p class="nc-req-sol-sub">' + [sol.cargo ? sol.cargo.nome : '', sol.empresa ? sol.empresa.nome : '', sol.pessoa && sol.pessoa.cod ? 'matrícula ' + sol.pessoa.cod : ''].filter(Boolean).map(esc).join(' · ') + '</p></div></div>' : '') +
    '</div>';
  }

  /* ═══ [J12] SEÇÕES COMO FICHA: LEITURA E "EDITAR" ═══════════════════════════════════════
     O QUE FAZ  Cada região com a classe nc-req-ficha aparece como documento: rótulo e valor,
                com o código separado do nome ("700 - Natcorp"), valores em reais e "Falta
                preencher" nos obrigatórios vazios. "Editar" (no cabeçalho) mostra o
                formulário; "Concluir" volta à leitura. Clicar num dado abre a edição nele.
     QUANDO ABRE EM EDIÇÃO  requisição nova, obrigatório vazio ou erro do servidor. Sem nada
                editável na seção, não há botão "Editar".
     PODE MEXER 'Editar', 'Concluir', 'Falta preencher', 'Não informado'.
     VISUAL     Natcorp_Requisicao.css › [C10]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- nc-req-ficha: a seção se lê como documento; "Editar" abre o formulário ----------
     O formulário continua no lugar (só fora da vista): itens, ações dinâmicas e validações são
     os mesmos. Seção com obrigatório vazio ou com erro já abre no modo de edição. */
  var editando = {};
  function rotuloDe(c) {
    var l = c.querySelector('.t-Form-label');
    if (!l) return '';
    var k = l.cloneNode(true);
    [].forEach.call(k.querySelectorAll('.u-VisuallyHidden, .t-Form-required'), function (x) { x.remove(); });
    return k.textContent.replace(/\s+/g, ' ').replace(/\s*\*\s*$/, '').trim();
  }
  function maiusculas(t) { return t.length > 3 && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t); }
  function capitalizar(t) { return t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); }); }
  function valorDe(c) {
    var id = c.id.replace(/_CONTAINER$/, '');
    var e = document.getElementById(id);
    if (!e) return '';
    var ops = e.querySelectorAll ? e.querySelectorAll('input[type="radio"], input[type="checkbox"]') : [];
    if (ops.length) {
      var marc = [].filter.call(ops, function (i) { return i.checked; });
      if (ops.length === 1) return marc.length ? 'Sim' : 'Não';
      return marc.map(function (i) { var l = c.querySelector('label[for="' + i.id + '"]'); return l ? l.textContent.trim() : i.value; }).join(', ');
    }
    if (e.tagName === 'TEXTAREA') return e.value.replace(/^[ \t]*\u00bf[ \t]*/gm, '').trim();
    if (id === it('TIPO_PUBLICACAO')) return { T: 'Interna e externa', E: 'Externa', I: 'Interna' }[e.value] || texto(id);
    if (e.tagName === 'SELECT') {
      /* opção escolhida de valor vazio mas com nome (ex.: "FULL CLT"): vale o nome */
      var o = e.options[e.selectedIndex];
      var tx = o ? o.text.trim() : '';
      return vazio(tx) ? '' : tx;
    }
    if (!/^(INPUT|SELECT|TEXTAREA)$/.test(e.tagName)) return e.textContent.replace(/\s+/g, ' ').trim();
    return texto(id);
  }
  function formatar(rot, v) {
    if (!v) return '';
    /* "700 - Natcorp / 365785 - Fernando / 202 - Gerente": cada parte com o seu código */
    if (/\s\/\s/.test(v) && (v.match(/\s-\s/g) || []).length > 1) return v.split(/\s+\/\s+/).map(function (p) { return '<span class="nc-req-parte">' + formatar(rot, p) + '</span>'; }).join('');
    if (/\(R\$\)|valor|sal[aá]rio|remunera/i.test(rot) && /^[\d.,\s]+$/.test(v) && isFinite(num(v))) return '<span class="nc-req-num">' + brl(num(v)) + '</span>';
    var m = v.match(/^\s*([\w.]{1,10})\s+-\s+(.+)$/);
    var cod = '', nome = v;
    if (m && !/\s/.test(m[1])) { cod = m[1]; nome = m[2]; }
    if (maiusculas(nome)) nome = capitalizar(nome);
    nome = bonito(nome);
    return (cod ? '<span class="nc-req-cod">' + esc(cod) + '</span>' : '') + esc(nome).replace(/\n/g, '<br>');
  }
  function montarFichas() {
    porClasse('nc-req-ficha').forEach(function (reg) {
      if (escondido(reg)) return;
      var corpo = corpoDe(reg);
      var f = faltas(reg).length, er = erros(reg), podeEditar = editavel(reg);
      if (editando[reg.id] === undefined) editando[reg.id] = !!(f || er || !valor(it('COD_REQ')));
      if (er) editando[reg.id] = true;
      if (!podeEditar) editando[reg.id] = false;
      var ed = editando[reg.id];
      reg.classList.toggle('nc-req-lendo', !ed);
      /* botão no cabeçalho, antes dos botões do APEX */
      var cab = reg.querySelector(':scope > .t-Region-header');
      var bt = cab && cab.querySelector('.nc-req-editar');
      if (cab && !bt) {
        var area = cab.querySelector('.t-Region-headerItems--buttons');
        if (!area) { area = el('div', 't-Region-headerItems t-Region-headerItems--buttons'); cab.appendChild(area); }
        bt = el('button', 'nc-req-editar'); bt.type = 'button';
        area.insertBefore(bt, area.firstChild);
        bt.addEventListener('click', function () {
          editando[reg.id] = !reg.classList.contains('nc-req-lendo') ? false : true;
          agendar();
          if (editando[reg.id]) setTimeout(function () { var c = reg.querySelector('.t-Form-fieldContainer input:not([type="hidden"]):not([disabled]), .t-Form-fieldContainer select:not([disabled]), .t-Form-fieldContainer textarea'); if (c) c.focus({ preventScroll: true }); }, 60);
        });
      }
      if (bt) {
        bt.setAttribute('aria-expanded', String(ed));
        bt.innerHTML = ed ? '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M5.5 12.5l4 4 9-9.5"/></svg>Concluir'
          : '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 20h4L19 9l-4-4L4 16z"/></svg>Editar';
        bt.hidden = !podeEditar || (ed && (f > 0 || er > 0));
      }
      /* a leitura */
      var dl = corpo.querySelector(':scope > .nc-req-leitura');
      if (!dl) {
        dl = el('dl', 'nc-req-leitura'); corpo.insertBefore(dl, corpo.firstChild);
        dl.addEventListener('click', function (e) {
          var d = e.target.closest('[data-campo]');
          if (!d) return;
          editando[reg.id] = true; agendar();
          setTimeout(function () { var c = document.getElementById(d.getAttribute('data-campo')); var i = c && c.querySelector('input:not([type="hidden"]):not([disabled]), select:not([disabled]), textarea'); if (i) { i.focus({ preventScroll: true }); window.scrollTo({ top: i.getBoundingClientRect().top + window.scrollY - topo() - 80, behavior: 'smooth' }); } }, 80);
        });
      }
      if (ed) { dl.innerHTML = ''; return; }
      if (reg.classList.contains('nc-req-solicitacao') && valor(it('COD_REQ'))) { dl.innerHTML = htmlSolicitacao(); return; }
      dl.innerHTML = [].slice.call(reg.querySelectorAll('.t-Form-fieldContainer')).filter(function (c) {
        return !escondido(c, reg) && !c.closest('.nc-req-leitura') && rotuloDe(c);
      }).map(function (c) {
        var rot = rotuloDe(c), v = valorDe(c), obr = c.classList.contains('is-required');
        var longo = v.length > 56 || c.querySelector('textarea');
        var dd = v ? formatar(rot, v) : obr ? '<span class="nc-req-falta">Falta preencher</span>' : '<span class="nc-req-nada">Não informado</span>';
        return '<div class="nc-req-dado' + (longo ? ' nc-req-dado--largo' : '') + (c.querySelector('textarea') ? ' nc-req-dado--texto' : '') + (v ? '' : ' nc-req-dado--vazio') + '" data-campo="' + esc(c.id) + '" title="Clique para editar">' +
          '<dt>' + esc(rot) + '</dt><dd>' + dd + '</dd></div>';
      }).join('');
    });
  }

  /* ═══ [J13] O CABEÇALHO DE CADA ETAPA ════════════════════════════════════════════════════
     O QUE FAZ  No alto de cada etapa: o número, o título e o estado ("Tudo preenchido",
                "Faltam 2 campos obrigatórios", "Tem campo para corrigir", "N pessoas
                inscritas", "N de M itens conferidos").
     PODE MEXER os textos entre aspas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarCabecalhos() {
    etapas.forEach(function (r, i) {
      var corpo = corpoDe(r);
      var c = corpo.querySelector(':scope > .nc-req-etapa-cab');
      if (!c) { c = el('div', 'nc-req-etapa-cab'); corpo.insertBefore(c, corpo.firstChild); }
      var f = faltas(r).length, cand = r.classList.contains('nc-req-candidatos');
      var prev = r.classList.contains('nc-req-etapa-previa');
      var st = cand ? (function (n) { return n ? n + (n === 1 ? ' pessoa inscrita' : ' pessoas inscritas') : 'Ninguém inscrito ainda'; })(contarInscritos(r))
        : prev ? (function (ic) { var ok = ic.filter(function (x) { return x[0]; }).length; return ok === ic.length ? 'Tudo certo para publicar' : ok + ' de ' + ic.length + ' itens conferidos'; })(itensConferir())
        : erros(r) ? 'Tem campo para corrigir' : f ? (f === 1 ? 'Falta 1 campo obrigatório' : 'Faltam ' + f + ' campos obrigatórios') : 'Tudo preenchido';
      if (prev) cand = true;
      c.innerHTML = '<h2 class="nc-req-etapa-titulo"><span class="nc-req-etapa-num">' + (i + 1) + '</span>' + esc(titulo(r)) + '</h2>' +
        '<p class="nc-req-etapa-estado' + (cand ? '' : erros(r) || f ? ' is-falta' : ' is-ok') + '">' + esc(st) + '</p>';
    });
  }

  /* ═══ [J14] INSCRITOS COMO CARTÕES ═══════════════════════════════════════════════════════
     O QUE FAZ  Cada linha do relatório com a classe nc-req-pessoas vira um cartão: iniciais,
                nome, cargo e as outras colunas numa linha miúda. O × é o link "Apagar" original.
     COMO ACHA AS COLUNAS  Pelo nome da coluna no relatório: COLABORADOR / CANDIDATO / NOME é o
                nome; CARGO é o cargo; EMPRESA não aparece; DATA / DT_ vira "… em 01/10/2026".
     PODE MEXER 'Ninguém inscrito ainda.', 'Sem nome'.
     VISUAL     Natcorp_Requisicao.css › [C10]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function iniciais(n) { var p = n.split(/\s+/).filter(Boolean); return ((p[0] || '').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  function montarPessoas() {
    porClasse('nc-req-pessoas').forEach(function (reg) {
      var corpo = corpoDe(reg);
      var linhas = [].slice.call(reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers]'); });
      reg.classList.toggle('nc-req-lista--vazia', !linhas.length);
      var box = corpo.querySelector(':scope > .nc-req-gente');
      if (!linhas.length) { if (box) box.remove(); var nd = reg.querySelector('.nodatafound'); if (nd) nd.textContent = 'Ninguém inscrito ainda.'; return; }
      if (!box) { box = el('ul', 'nc-req-gente'); corpo.insertBefore(box, corpo.firstChild); }
      box.innerHTML = '';
      linhas.forEach(function (tr) {
        var apagar = tr.querySelector('a.apagar, a.t-Button--danger') || tr._ncApagar || null;
        if (apagar) tr._ncApagar = apagar;
        var nome = '', cargo = '', meta = [];
        [].forEach.call(tr.querySelectorAll('td[headers]'), function (td) {
          var h = td.getAttribute('headers'), v = td.textContent.replace(/\s+/g, ' ').trim();
          if (/^DERIVED\$/.test(h) || !v || v === '-') return;
          var th = reg.querySelector('th[id="' + h + '"]'), rot = th ? th.textContent.replace(/\s+/g, ' ').trim() : h;
          var limpo = bonito(semCodigo(v));
          if (!nome && /COLABORADOR|CANDIDATO|NOME/i.test(h)) nome = limpo;
          else if (/CARGO/i.test(h)) cargo = limpo;
          else if (/^EMPRESA/i.test(h)) return;
          else meta.push(/DATA|DT_/i.test(h) ? rot.replace(/^Data de /i, '') + ' em ' + v : limpo);
        });
        var li = el('li', 'nc-req-pessoa');
        li.innerHTML = '<span class="nc-req-avatar" aria-hidden="true">' + esc(iniciais(nome)) + '</span>' +
          '<span class="nc-req-pessoa-dados"><b>' + esc(nome || 'Sem nome') + '</b>' + (cargo ? '<span>' + esc(cargo) + '</span>' : '') +
          (meta.length ? '<span class="nc-req-sutil">' + meta.map(esc).join(' · ') + '</span>' : '') + '</span>';
        if (apagar) { apagar.classList.add('nc-req-chip-apagar'); apagar.setAttribute('aria-label', 'Remover ' + nome); apagar.setAttribute('title', 'Remover'); li.appendChild(apagar); }
        box.appendChild(li);
      });
    });
  }

  /* ═══ [J15] A FAIXA DA APROVAÇÃO ═════════════════════════════════════════════════════════
     O QUE FAZ  A região nc-req-aprovadores vai para logo abaixo do resumo, em todas as etapas,
                e o relatório vira uma faixa: cada aprovador com um sinal (aprovou, reprovou,
                aguardando, na fila) e um resumo ("2 de 3 · aguardando Maria"). Os botões
                Aprovar/Reprovar do APEX entram na faixa. "Ver o caminho" abre a lista completa.
     LÊ DE      as colunas do relatório: APROVADOR, DATA, STATUS, JUSTIFICATIVA.
     CUIDADO    Se uma dessas colunas for renomeada no relatório do APEX, a faixa não acha os
                dados. Os botões são achados pelo texto "Aprovar" / "Reprovar".
     PODE MEXER os textos entre aspas: 'Aprovação', 'Ver o caminho', 'Aguardando', 'Na fila'…
     VISUAL     Natcorp_Requisicao.css › [C14]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- nc-req-aprovadores: o caminho da aprovação ----------
     O relatório de aprovadores vira uma linha do tempo: quem já aprovou, de quem é a vez e
     quem vem depois. Os botões Aprovar/Reprovar (quando o APEX os mostra) vão para o cartão
     "É a sua vez" — os mesmos botões, com os mesmos cliques. O link de cada aprovador (o
     diálogo com os dados da pessoa) vai junto do nome. */
  function nomeAprovador(t) {
    var m = String(t || '').match(/^\s*(\d+)\s*-\s*(\d+)\s*-\s*(.+)$/);
    if (m) return { nome: bonito(capitalizar(m[3].trim())), meta: 'Empresa ' + m[1] + ' · matrícula ' + m[2], pessoa: true };
    var n = String(t || '').trim();
    return { nome: maiusculas(n) || n === n.toUpperCase() ? capitalizar(n) : n, meta: '', pessoa: false };
  }
  function lerAprovacao(reg) {
    reg = reg || porClasse('nc-req-aprovadores')[0];
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
      botoes: [].slice.call(reg.querySelectorAll('button, a.t-Button')).filter(function (b) { return /aprovar|reprovar/i.test(b.textContent) && !b.closest('.nc-req-caminho'); }).concat(reg._ncBotoes || []) };
  }
  /* a faixa da aprovação: uma linha logo abaixo do resumo, em todas as etapas. A região do
     APEX (a mesma, com o relatório e os botões) só muda de lugar na tela. */
  var apAberto = false;
  function montarAprovadores() {
    porClasse('nc-req-aprovadores').forEach(function (reg) {
      var resumo = document.getElementById('nc-req-resumo');
      if (resumo && reg.previousElementSibling !== resumo) {
        /* a coluna de onde ela saiu fica vazia: a vizinha ocupa a linha toda */
        var col = reg.parentElement && reg.parentElement.classList.contains('col') ? reg.parentElement : null;
        resumo.parentNode.insertBefore(reg, resumo.nextSibling);
        if (col && !col.querySelector('.t-Region')) col.classList.add('nc-req-col-vazia');
      }
      var ap = lerAprovacao(reg);
      var corpo = corpoDe(reg);
      reg.classList.toggle('nc-req-lista--vazia', !ap.passos.length);
      reg.hidden = !ap.passos.length;
      var box = corpo.querySelector(':scope > .nc-req-caminho');
      if (!ap.passos.length) { if (box) box.remove(); return; }
      if (!box) {
        box = el('div', 'nc-req-caminho'); corpo.insertBefore(box, corpo.firstChild);
        box.addEventListener('click', function (e) { if (e.target.closest('.nc-req-caminho-ver')) { apAberto = !apAberto; agendar(); } });
      }
      var bts = ap.botoes.filter(function (b, i, a) { return a.indexOf(b) === i; });
      reg._ncBotoes = bts;
      var total = ap.passos.length;
      var quemNao = ap.passos.filter(function (x) { return x.estado === 'nao'; })[0];
      var resumoTxt = ap.reprovado ? '<b>Reprovada</b> por ' + esc(quemNao.quem.nome) : ap.atual < 0 ? '<b>Aprovada</b> por todos' :
        '<b>' + ap.aprovados + ' de ' + total + '</b> · aguardando <b>' + esc(ap.passos[ap.atual].quem.nome) + '</b>';
      var estadoGeral = ap.reprovado ? 'nao' : ap.atual < 0 ? 'ok' : bts.length ? 'vez' : 'pend';
      reg.classList.toggle('nc-req-ap-aberto', apAberto);
      box.className = 'nc-req-caminho nc-req-caminho--' + estadoGeral;
      box.innerHTML =
        '<p class="nc-req-caminho-rot">Aprovação</p><div class="nc-req-caminho-cab"><p class="nc-req-caminho-resumo">' + resumoTxt + '</p>' +
          '<button type="button" class="nc-req-caminho-ver" aria-expanded="' + apAberto + '">' + (apAberto ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
        '<ol class="nc-req-passos-ap">' + ap.passos.map(function (x, i) {
          var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === ap.atual ? 'is-vez' : 'is-fila';
          var st = x.estado === 'ok' ? (x.data ? x.data.replace(/\s.*$/, '') : 'Aprovou') : x.estado === 'nao' ? 'Reprovou' : i === ap.atual ? 'Aguardando' : 'Na fila';
          var ic = x.estado === 'ok' ? '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>' : x.estado === 'nao' ? '<path d="M8 8l8 8M16 8l-8 8"/>' : i === ap.atual ? '<path d="M12 8v4l2.5 1.5"/>' : '';
          var dica = x.quem.nome + (x.quem.meta ? ' (' + x.quem.meta + ')' : '') + ' — ' + (x.estado === 'ok' ? 'aprovou' + (x.data ? ' em ' + x.data : '') : x.estado === 'nao' ? 'reprovou' + (x.data ? ' em ' + x.data : '') : i === ap.atual ? 'aguardando a aprovação' : 'na fila') + (x.just ? ': "' + x.just + '"' : '');
          return '<li class="nc-req-ap ' + cls + '" data-i="' + i + '" title="' + esc(dica) + '"><span class="nc-req-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
            '<span class="nc-req-ap-texto"><span class="nc-req-ap-nome">' + esc(x.quem.nome) + '</span><span class="nc-req-ap-estado">' + esc(st) + '</span></span></li>';
        }).join('') + '</ol>' +
        (bts.length ? '<div class="nc-req-decisao-botoes" aria-label="Sua decisão"></div>' : '') +
        (quemNao && quemNao.just ? '<blockquote class="nc-req-ap-just"><b>' + esc(quemNao.quem.nome) + ' reprovou:</b> ' + esc(quemNao.just) + '</blockquote>' : '');
      ap.passos.forEach(function (x, i) {
        if (!x.link || !x.quem.pessoa) return;
        var li = box.querySelector('.nc-req-ap[data-i="' + i + '"] .nc-req-ap-texto');
        x.link.classList.add('nc-req-ap-link'); x.link.setAttribute('title', 'Ver dados de ' + x.quem.nome); x.link.setAttribute('aria-label', 'Ver dados de ' + x.quem.nome);
        li.appendChild(x.link);
      });
      var dest = box.querySelector('.nc-req-decisao-botoes');
      if (dest) bts.sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) { b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-req-reprovar' : 'nc-req-aprovar'); dest.appendChild(b); });
    });
  }

  /* ═══ [J16] ANTES DE PUBLICAR E O LUGAR DAS AÇÕES ════════════════════════════════════════
     O QUE FAZ  • "Antes de publicar": a conferência do que deixa a vaga boa para o candidato —
                  cargo escolhido, descrição com 300 caracteres ou mais, requisitos no perfil,
                  algum requisito obrigatório e o período de divulgação. Na p76, que não tem as
                  listas de requisitos, só 3 itens. Aparece no trilho (computador) e abaixo da
                  prévia (celular).
                • O trilho: a coluna da esquerda, no computador, com o menu das etapas.
                • As ações (região nc-req-acoes): a partir de 1100px de largura, no canto direito
                  do resumo; em telas menores, logo abaixo dele. A região e os botões são os do
                  APEX. Sem nenhum botão à vista, a região some.
     PODE MEXER a lista em itensConferir: cada linha é [está ok?, texto quando ok/não,
                dica quando falta]. O número 300 (tamanho mínimo da descrição) também.
     VISUAL     Natcorp_Requisicao.css › [C10] (trilho), [C3] e [C18] (ações)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function itensConferir() {
    var desc = valor(it('DESC_ATIVIDADES')).trim();
    var obrig = 0, nReq = 0;
    porClasse('nc-req-lista').forEach(function (l) { obrig += l.querySelectorAll('.nc-req-grupo-etq--o .nc-req-chip').length; nReq += l.querySelectorAll('.nc-req-chip').length; });
    var pb = publicacao();
    /* os requisitos (formação, experiência, idiomas) só existem na Requisição de Pessoal */
    var temRequisitos = !!porClasse('nc-req-grupo').length;
    return [
      [!!texto(it('COD_CARGO')), 'Cargo escolhido', 'Escolha o cargo na etapa Cargo.'],
      [desc.length >= 300, desc.length >= 300 ? 'Descrição com ' + desc.length.toLocaleString('pt-BR') + ' caracteres' : 'Descrição curta', 'Conte o dia a dia e o que a pessoa vai encontrar (uns 300 caracteres ou mais).'],
      [nReq > 0, nReq ? nReq + (nReq === 1 ? ' requisito' : ' requisitos') + ' no perfil' : 'Nenhum requisito', 'Formação, experiência e idiomas ajudam a filtrar (etapa Perfil).'],
      [obrig > 0, obrig ? obrig + (obrig === 1 ? ' obrigatório' : ' obrigatórios') : 'Nenhum requisito obrigatório', 'Sem obrigatórios, todo candidato passa no primeiro filtro.'],
      [!!pb && pb.estado !== 'fim', pb ? pb.texto : 'Sem período de divulgação', POSICAO ? 'Ajuste Data de Início e Data de Encerramento em Identificação.' : 'Ajuste as datas em Identificação › Publicação de Vaga.']
    ].filter(function (x, i) { return temRequisitos || (i !== 2 && i !== 3); });
  }
  function htmlConferir() {
    var itens = itensConferir();
    var ok = itens.filter(function (i) { return i[0]; }).length;
    return '<p class="nc-req-conferir-titulo">Antes de publicar <span>' + ok + ' de ' + itens.length + '</span></p><ul>' + itens.map(function (i) {
      return '<li class="' + (i[0] ? 'is-ok' : 'is-atencao') + '"><svg viewBox="0 0 24 24" aria-hidden="true">' + (i[0] ? '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>' : '<path d="M12 7v6M12 16.5v.5"/>') + '</svg><span><b>' + esc(i[1]) + '</b>' + (i[0] ? '' : '<br>' + esc(i[2])) + '</span></li>';
    }).join('') + '</ul>';
  }
  function trilho() {
    var t = document.getElementById('nc-req-trilho');
    if (t || !host || !etapas.length) return t;
    t = el('aside', 'nc-req-trilho'); t.id = 'nc-req-trilho';
    var primeira = etapas[0].closest('.row') || etapas[0];
    primeira.parentNode.insertBefore(t, primeira);
    /* as ações da requisição (Publicar, Cancelar, Descendentes) vão junto: a mesma região, os
       mesmos botões — só mudam de lugar na tela */
    var conf = el('div', 'nc-req-conferir nc-req-conferir--trilho'); conf.id = 'nc-req-conferir-trilho';
    t.appendChild(conf);
    var ac = porClasse('nc-req-acoes')[0];
    if (ac) t.appendChild(ac);
    return t;
  }
  /* as ações da requisição (Suspender, Revisar, Cancelar, Publicar) sempre à vista, uma ao
     lado da outra: no computador no canto de cima, à direita, do resumo da vaga; no celular
     logo abaixo do resumo, antes da aprovação. A região e os botões são os do APEX. */
  var ACOES = null;
  function lugarDasAcoes() {
    ACOES = porClasse('nc-req-acoes')[0] || ACOES;
    var ac = ACOES, resumo = document.getElementById('nc-req-resumo');
    if (!ac || !resumo) return;
    var tem = [].some.call(ac.querySelectorAll('.t-Button'), function (b) { return b.offsetParent !== null || getComputedStyle(b).display !== 'none'; });
    ac.hidden = !tem;
    if (window.innerWidth >= 1100 && !resumo.classList.contains('nc-req-resumo--nova')) {
      if (ac.parentNode !== resumo) resumo.appendChild(ac);
      ac.classList.add('nc-req-acoes--resumo'); ac.classList.remove('nc-req-acoes--topo');
      resumo.style.setProperty('--nc-req-acoes-w', (ac.offsetWidth + 24) + 'px');
    } else {
      if (resumo.nextElementSibling !== ac) resumo.parentNode.insertBefore(ac, resumo.nextSibling);
      ac.classList.add('nc-req-acoes--topo'); ac.classList.remove('nc-req-acoes--resumo');
      resumo.style.removeProperty('--nc-req-acoes-w');
    }
  }
  function montarTrilho() {
    var t = trilho();
    if (!t) return;
    var c = document.getElementById('nc-req-conferir-trilho');
    if (c) c.innerHTML = htmlConferir();
  }

  /* ═══ [J17] A BARRA FIXA DO TOPO ═════════════════════════════════════════════════════════
     O QUE FAZ  Mede a altura da barra de título do APEX (Voltar, Salvar…), que fica FIXA no
                topo, e guarda o valor para o CSS (--nc-req-topo). Assim o que gruda (trilho,
                prévia) e a rolagem entre etapas não ficam escondidos atrás dela.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- a barra fixa do topo (Voltar, Salvar…) ----------
     O tema deixa a barra de título FIXA no topo: o que gruda (trilho, prévia) e a rolagem
     entre etapas descontam a altura dela, senão ficam por baixo. */
  function topo() {
    var alt = 0;
    [].forEach.call(document.querySelectorAll('.t-Header, .t-Body-title'), function (e) {
      var c = getComputedStyle(e);
      if (c.position === 'fixed' || c.position === 'sticky') alt = Math.max(alt, e.getBoundingClientRect().bottom);
    });
    alt = Math.max(0, Math.round(alt));
    document.documentElement.style.setProperty('--nc-req-topo', (alt + 12) + 'px');
    return alt;
  }

  /* ═══ [J18] O MAESTRO: QUANDO CADA PARTE É MONTADA ══════════════════════════════════════
     O QUE FAZ  tudo() chama as partes acima, nesta ordem. iniciar() roda uma vez quando a
                página abre (põe a marca nc-req na página, escolhe a etapa inicial) e depois
                manda montar tudo de novo sempre que algo muda: um campo é alterado, uma lista
                é recarregada, uma ação dinâmica traz valores do servidor, uma janela fecha, a
                tela muda de tamanho.
     CUIDADO    Não mude a ordem das chamadas em tudo(): umas partes dependem das anteriores
                (o menu e "Antes de publicar" leem as etiquetas que montarListas cria).
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp requisição] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tudo() {
    lerEtapas();
    montarResumo();
    montarAprovadores();
    travarCampos();
    montarIcones();
    montarListas();
    montarPessoas();
    montarPrevia();
    montarOpcionais();
    montarFichas();
    montarContadores();
    if (etapas.length) {
      if (atual >= etapas.length) atual = etapas.length - 1;
      etapas.forEach(function (r, k) { r.classList.toggle('nc-req-fora', k !== atual); r.classList.toggle('nc-req-ativa', k === atual); });
      montarMenu();
      montarTrilho();
      montarCabecalhos();
      montarPassos();
      lugarDasAcoes();
    }
  }
  var agendado = false;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () { agendado = false; try { tudo(); } catch (e) { if (window.console) console.warn('[Natcorp requisição]', e); } });
  }
  function iniciar() {
    document.body.classList.add('nc-req');
    topo();
    $(window).on('resize apexwindowresized', function () { topo(); agendar(); });
    setTimeout(topo, 400);
    lerEtapas();
    atual = etapaInicial();
    tudo();
    if (etapas.length) ir(atual, false);
    /* valores postos pelas ações dinâmicas (change), listas recarregadas (apexafterrefresh),
       diálogos de adicionar/apagar que fecham, e o texto da descrição enquanto é digitado */
    $(document).on('change', '[id^="' + P + '"]', agendar);
    $(document).on('input', '#' + it('DESC_ATIVIDADES'), agendar);
    $(document).on('apexafterrefresh', agendar);
    /* valores trazidos do servidor por ação dinâmica (Executar PL/SQL, "itens a retornar")
       chegam SEM o evento change: sem isto a tela ficava com a leitura de antes da resposta */
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    $(document).on('apexafterclosedialog dialogclose', function () { setTimeout(agendar, 80); });
    if (window.MutationObserver) {
      var mo = new MutationObserver(agendar);
      porClasse('nc-req-etapa').forEach(function (r) { mo.observe(r, { attributes: true, attributeFilter: ['style'] }); });
    }
  }
  /* 04/10: monta DEPOIS das ações de abertura da página ("apexreadyend"). Na p76, a ação
     "Enable/Disable" faz $("#INF_VAGA *").attr("disabled").off("click") numa requisição gravada;
     montado antes, a faixa de Aprovadores (região de fora de INF_VAGA) já estava lá dentro e
     Aprovar/Reprovar ficavam desabilitados e sem o clique. Sem o evento em 3 s, monta assim mesmo. */
  /* 08/10: e depois que as chamadas Ajax da abertura terminam (até 2,5 s): a p52 dispara ~60
     (listas em cascata das ações dinâmicas); montada no meio delas, a tela se redesenhava 15 vezes
     e a página demorava a sossegar (o carregando esperava). O aviso vem do document: um handler
     do arquivo do time devolvia false ali e o evento não chegava a window (só o reserva de 3 s). */
  var iniciado = false;
  function iniciarUmaVez() {
    if (iniciado) return;
    iniciado = true;
    var limite = Date.now() + 2500;
    (function quandoParar() {
      if ($.active > 0 && Date.now() < limite) { setTimeout(quandoParar, 40); return; }
      iniciar();
    })();
  }
  $(document).one('apexreadyend', iniciarUmaVez);
  $(function () { setTimeout(iniciarUmaVez, 3000); });
})();
