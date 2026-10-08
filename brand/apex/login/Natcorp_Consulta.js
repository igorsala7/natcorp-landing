/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CONSULTAS DO PORTAL  —  o "arrumador" dos relatórios interativos (JavaScript) ║
   ║  App 300 (Portal do Colaborador) · todas as páginas de consulta com relatório interativo ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia: CONSULTA-MANUTENCAO.md. (A consulta de Férias, 300:77, tem desenho próprio:
   Natcorp_FeriasConsulta — mais rico, com as partes das férias.)

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Um MOTOR para as consultas do Portal: quem usa quer VER os dados de um jeito claro, no
   celular; as ferramentas do relatório interativo ficam em segundo plano ("Ver como tabela").
   Cada relatório da página vira uma lista de cartões, de um de três jeitos:
     • PEDIDOS  (há coluna de nº de requisição): "Pedido 1234" ou o assunto do pedido, a
                situação com a cor do sistema, "feito em …", "Ver pedido";
     • DADOS    (histórico, folha, EPI, empréstimo…): o assunto da linha em destaque, o valor
                ou o período ao lado, os outros dados com o título da coluna;
     • PESSOAS  (listas de colaboradores, para o gestor): a pessoa (foto ou iniciais), o cargo,
                os dados dela, e o link para a ficha.
   Junto: os botões da barra do relatório (Criar Requisição, Abono…) vão para o alto — o de
   criar em destaque —; com coluna de situação, botões por situação e os cancelados guardados;
   com muitos cartões, uma busca. O que é de cada página (textos, coluna principal, valor…)
   fica numa RECEITA ([K2]); sem receita, o motor escolhe pelos títulos das colunas.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada e não muda o que aparece: consulta, filtros da página, paginação, botões
     e links são os da página (o toque é o clique no link ORIGINAL). Os dados são LIDOS do
     relatório pelo TÍTULO de cada coluna. Tirou as URLs: volta o de antes.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Consulta.js
     Página › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Consulta.css
     (aplicar-consulta.py põe as duas; no app inteiro, aplicar-consultas-app300.py)

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [K1] Como a página é reconhecida                                      CUIDADO
     [K2] As receitas (uma por página)                                     PODE MEXER
     [K3] Ferramentas e os 7 status
     [K4] Lê um relatório (pelos títulos das colunas)                      CUIDADO
     [K5] O colaborador
     [K6] Os cartões (pedidos, dados, pessoas)
     [K7] Uma lista (o alto, a situação, a busca)
     [K8] Cartões × tabela
     [K9] O maestro
*/
(function () {
  'use strict';
  if (window.__ncConsulta || !window.apex || !window.apex.jQuery) return;

  /* ═══ [K1] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════════
     CUIDADO  o arquivo só entra nas páginas certas (File URLs). O prefixo dos itens vem do nº
              da página (P77_, P135_…), para achar a receita e os itens do colaborador. Os
              relatórios (.a-IRR) só existem depois que o JS deles roda: são procurados na
              montagem, nunca aqui.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  var PAG = ($id('pFlowStepId') || {}).value;
  if (!PAG) return;
  var P = 'P' + PAG + '_';
  window.__ncConsulta = true;
  var $ = window.apex.jQuery;

  /* ═══ [K2] AS RECEITAS ═══════════════════════════════════════════════════════════════════
     PODE MEXER  uma receita por página (pelo prefixo dos itens). Tudo opcional:
       titulo      o título da lista               explica   uma frase embaixo do título
       pedir       o texto do botão de criar (o botão é o ORIGINAL)
       modo        'pedidos' | 'dados' | 'pessoas'  (sem: o motor escolhe)
       principal   título da coluna que vai em destaque no cartão
       prefixo     texto antes do principal ("Dia " + data)
       sub         título da coluna da linha de baixo (ex.: 'Grau de Parentesco')
       valor       título da coluna do valor grande, à direita (ex.: 'Valor')
       periodo     [início, fim] — títulos das colunas do período ("de … a …")
       ocultar     títulos de colunas que não aparecem no cartão
       ver         o texto do botão da linha ('Ver pedido', 'Ver detalhes', 'Abrir'…)
       situacao    situação de TODA linha quando não há coluna de situação
       vazioTit / vazioTxt   a lista vazia (sem: a mensagem do próprio relatório)
       filtrosDepois  true: no celular, a região "Filtros" da página vai para DEPOIS da lista
       umAberto    true: só um pedido aberto por vez → "Ver meu pedido" vira o principal
       regioes     { 'Título da região': { …o mesmo… } } — página com mais de um relatório
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var UM_ABERTO_TXT = 'Você já tem um pedido em andamento. Para mudar alguma coisa, abra o pedido.';
  var RECEITAS = {
    /* ── PEDIDOS do colaborador ── */
    /* app 2060 (REQ_REEMBOLSO_NATCORP) · página 2: Requisição de Lançamentos Diversos (reembolsos e outros) */
    A2060_P2_: { titulo: 'Seus pedidos de reembolso', pedir: 'Fazer um pedido', explica: 'Gastou do seu dinheiro a trabalho, ou precisa de outro lançamento na folha? Peça aqui e acompanhe.',
      modo: 'pedidos', ver: 'Ver pedido', ocultar: ['Empresa', 'Matricula Solicitada', 'Empresa Solicitante', 'Solicitante', 'Cod Empresa', 'Cod Solicitacao', 'Cod Empresa Solicitante', 'Mat Solicitante', 'Matricula', 'Filial', 'Centro De Custo', 'Unidade Adm', 'Atividade', 'Cargo', 'Cod Processo'],
      filtrosDepois: true, vazioTit: 'Nenhum pedido neste período', vazioTxt: 'Para pedir um reembolso, toque em "Fazer um pedido". Tenha em mãos a nota ou o recibo.' },
    P133_: { titulo: 'Seus pedidos de mudança de endereço', pedir: 'Pedir mudança de endereço', explica: 'Mudou de casa? Informe o endereço novo e anexe o comprovante.',
      situacao: 'Em andamento', umAberto: true, vazioTit: 'Nenhum pedido em andamento', vazioTxt: 'Mudou de casa? Toque em "Pedir mudança de endereço". Tenha em mãos um comprovante (conta de luz, água ou telefone).' },
    P135_: { titulo: 'Seus pedidos de alteração de dados', pedir: 'Pedir alteração de dados', explica: 'Endereço, telefone, documentos, banco e outros dados.',
      situacao: 'Em andamento', umAberto: true, vazioTit: 'Nenhum pedido em andamento', vazioTxt: 'Mudou de endereço, de telefone ou de documento? Toque em "Pedir alteração de dados".' },
    P117_: { titulo: 'Seus pedidos de treinamento', pedir: 'Pedir um treinamento', principal: 'Curso', vazioTit: 'Nenhum pedido de treinamento', vazioTxt: 'Quer fazer um curso da empresa? Toque em "Pedir um treinamento".' },
    P119_: { titulo: 'Seus pedidos de curso', pedir: 'Pedir um curso', principal: 'Curso', vazioTit: 'Nenhum pedido de curso', vazioTxt: 'Para pedir um curso, toque em "Pedir um curso".' },
    P131_: { titulo: 'Seus pedidos de dependentes', pedir: 'Incluir ou mudar dependente', explica: 'Filho, cônjuge e outras pessoas que dependem de você.', principal: 'Nome do Dependente', sub: 'Grau de Parentesco', ocultar: ['Nº'], vazioTit: 'Nenhum pedido de dependente', vazioTxt: 'Para incluir ou mudar um dependente, toque em "Incluir ou mudar dependente".' },
    P58_: { titulo: 'Pedidos de dependentes', pedir: 'Incluir ou mudar dependente', principal: 'Nome do Dependente', sub: 'Grau de Parentesco', ocultar: ['Nº'] },
    P137_: { titulo: 'Seus pedidos de abono', pedir: 'Pedir abono', explica: 'Marcação de ponto esquecida ou errada.', principal: 'Data ponto', prefixo: 'Dia ', ocultar: ['Cod solicitacao'], vazioTit: 'Nenhum pedido de abono', vazioTxt: 'Esqueceu de bater o ponto ou bateu errado? Toque em "Pedir abono".' },
    P138_: { titulo: 'Seus pedidos de hora extra', pedir: 'Pedir hora extra', principal: 'Data', prefixo: 'Dia ', ocultar: ['Cod solicitacao'], vazioTit: 'Nenhum pedido de hora extra' },
    P166_: { titulo: 'Seus pedidos de benefícios', pedir: 'Pedir mudança nos benefícios', explica: 'Vale-refeição, plano de saúde e outros benefícios.', vazioTit: 'Nenhum pedido de benefício' },
    P23_: { titulo: 'Alertas e pedidos pendentes', modo: 'pedidos', principal: 'Evento', explica: 'O que está esperando por você.', ver: 'Abrir' },
    P24_: { titulo: 'Pedidos encontrados', modo: 'pedidos', principal: 'Tipo de Requisição', ver: 'Abrir' },
    /* ── DADOS do colaborador ── */
    P18_: { titulo: 'Seus dependentes', modo: 'dados', principal: 'Nome Dependente', sub: 'Grau de Parentesco', icone: 'pessoa', ocultar: ['Num. Dependente', 'Codigo Plano', 'Codigo Tipo'], ver: 'Ver detalhes', vazioTit: 'Nenhum dependente cadastrado' },
    P19_: { titulo: 'Histórico cadastral', modo: 'dados', principal: 'Descrição do Fato', sub: 'Descrição', periodo: ['Data de Vigência', 'Data de Vigência Final'], ocultar: ['Matrícula', 'Fato', 'Código', 'Motivo'], icone: 'historico' },
    P20_: { titulo: 'Histórico salarial', modo: 'dados', principal: 'Descrição de Motivo', valor: 'Valor', sub: 'Data de Vigência', ocultar: ['Matrícula', 'Motivo'], icone: 'dinheiro' },
    P21_: { titulo: 'Histórico financeiro', modo: 'dados', principal: 'Nome Ocorrência', valor: 'Valor', sub: 'Data Referência', ocultar: ['Matrícula', 'Nome', 'Ocorrência'], icone: 'dinheiro' },
    P73_: { titulo: 'Restrições de desligamento', modo: 'dados', principal: 'Restrição', periodo: ['Início Validade', 'Fim Validade'], icone: 'escudo' },
    P79_: { titulo: 'Seus EPIs', modo: 'dados', principal: 'EPI', sub: 'Agente', icone: 'escudo', explica: 'Equipamentos de proteção que você recebeu.', vazioTit: 'Nenhum EPI registrado' },
    P80_: { titulo: 'Informações complementares', modo: 'dados', principal: 'Campo', icone: 'item' },
    P81_: { titulo: 'Seus empréstimos', modo: 'dados', principal: 'Produto', sub: 'Convênio', valor: 'Valor Saldo', periodo: ['Data Início', 'Data Fim'], icone: 'dinheiro', vazioTit: 'Nenhum empréstimo' },
    P82_: { titulo: 'Necessidade de treinamento', modo: 'dados', principal: 'Curso', sub: 'Local', icone: 'estudo' },
    P83_: { titulo: 'Histórico de médias', modo: 'dados', principal: 'Descrição', valor: 'Valor', ocultar: ['Código de Ocorrência'], periodo: ['Data Início', 'Data Fim'], icone: 'dinheiro' },
    P84_: { titulo: 'Previsão funcional', modo: 'dados', principal: 'Alteração Solicitada', sub: 'Descrição', icone: 'historico' },
    P85_: { titulo: 'Histórico funcional', modo: 'dados', principal: 'Histórico Funcional', sub: 'Ítem', icone: 'historico' },
    P86_: { titulo: 'Avaliações', modo: 'dados', principal: 'Avaliação', valor: 'Nota', ocultar: ['Empresa Avaliado', 'Empresa Avaliador'], icone: 'estrela', ver: 'Ver avaliação' },
    P91_: { titulo: 'Pensionistas', modo: 'dados', principal: 'Nome', sub: 'Grau de Parentesco', icone: 'pessoa' },
    P104_: { titulo: 'Ocorrências de pagamento', modo: 'dados', principal: 'Descrição', valor: 'Valor', ocultar: ['Código de Ocorrência'], periodo: ['Data Início', 'Data Fim'], icone: 'dinheiro' },
    P110_: { titulo: 'Feedbacks', modo: 'dados', principal: 'Descrição', icone: 'balao' },
    P150_: { titulo: 'Acidentes de trabalho', modo: 'dados', principal: 'Tipo', sub: 'Data do Acidente', ocultar: ['Cod Empresa', 'Matricula', 'Matrícula Téc. Segurança', 'Matrícula Eng. Segurança'], icone: 'escudo', ver: 'Ver análise' },
    P12_: { titulo: 'Seus contatos favoritos', modo: 'pessoas', sub: 'Centro de Custo', ocultar: ['Inicial'] },
    P899_: { titulo: 'Colaboradores', modo: 'pessoas', sub: 'Cargo', ocultar: ['Favorito'] },
    /* ── EQUIPE (gestor) ── */
    P16_: { titulo: 'Sua equipe', modo: 'pessoas', sub: 'Nome Cargo', ocultar: ['Empresa', 'Filial', 'C. Custo', 'Cargo', 'Matrícula'] },
    P25_: { titulo: 'Colaboradores afastados', modo: 'pessoas', sub: 'Centro Cust.', ocultar: ['Cód'] },
    P26_: { titulo: 'Férias da equipe', modo: 'pessoas', sub: 'Centro de Custo', ocultar: ['dc', 'Matrícula'] },
    P103_: { titulo: 'Contratos de gestão', modo: 'pessoas', sub: 'Cargo' },
    P105_: { titulo: 'Metas da empresa', modo: 'dados', principal: 'Objetivo', sub: 'Categoria', valor: '% Atingido', icone: 'estrela' },
    /* P108_ (Linha do Tempo) usa o Natcorp_LinhaTempo — não entra aqui */
    P112_: { titulo: 'Eventos de ponto', modo: 'dados', principal: 'Evento', valor: 'Horas', sub: 'Colaborador', icone: 'relogio' }
  };
  /* receita de outro app: chave "A<app>_P<pág>_" (a página 2 do app 2060 não é a 2 de outro app) */
  var APP = ($id('pFlowId') || {}).value;
  var RP = RECEITAS['A' + APP + '_' + P] || RECEITAS[P] || {};
  var BASE_T = {
    todos: 'Todos', pedido: 'Pedido', feito: 'feito em', pedidoPor: 'Pedido por', colaborador: 'Colaborador',
    verPedido: 'Ver pedido', verDados: 'Ver detalhes', verPessoa: 'Ver colaborador', verMeu: 'Ver meu pedido',
    verTabela: 'Ver como tabela', verCartoes: 'Ver em cartões', buscar: 'Procurar nesta lista',
    mais: function (n) { return 'Mais ' + n + (n === 1 ? ' dado' : ' dados'); },
    nenhumFiltro: 'Nenhum item com essa situação nesta página.', nenhumBusca: 'Nada encontrado com esse texto.',
    verEncerrados: function (n) { return 'Ver cancelados e reprovados (' + n + ')'; },
    esconderEncerrados: 'Esconder cancelados e reprovados', admissao: 'Na empresa desde', de: 'de', a: 'a'
  };

  /* ═══ [K3] FERRAMENTAS E OS 7 STATUS ═════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/\s+/g, ' ').trim(); }
  function sem(t) { return limpo(t).toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  function vazio(v) { return !v || v === '-'; }
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  var MES3 = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  function dataBR(t) { var m = /^\s*(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function curta(d) { return d.getDate() + ' ' + MES3[d.getMonth()] + ' ' + d.getFullYear(); }
  function extenso(d) { return d.getDate() + ' de ' + MESES[d.getMonth()] + ' de ' + d.getFullYear(); }
  function nomeDe(t) { return limpo(String(t || '').replace(/^\d+\s*-\s*/, '')); }
  function codDe(t) { return (/^(\d+)\s*-/.exec(limpo(t)) || [])[1] || ''; }
  var MIUDAS = /^(da|de|do|das|dos|e|em|na|no)$/;
  function bonito(t) {
    t = limpo(t); if (!t || t !== t.toUpperCase() || !/[A-Z]/.test(t)) return t;
    return t.toLowerCase().replace(/[^\s\-\/().]+/g, function (w, i) {
      if (i > 0 && MIUDAS.test(w)) return w;
      if (!/[aeiouáéíóúâêôãõà]/.test(w)) return w.toUpperCase();
      return w.charAt(0).toUpperCase() + w.slice(1);
    });
  }
  function iniciais(n) { var p = limpo(n).split(' ').filter(function (w) { return w && !MIUDAS.test(w.toLowerCase()); }); return ((p[0] || '?').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  var CORES = [['#EFE6F7', '#511C76'], ['#FBE7EF', '#8E2F5C'], ['#E2EFF3', '#1F5A6B'], ['#E6F3EC', '#1F6B45'], ['#FFF0DA', '#7A4B00'], ['#ECEAF8', '#3E3A8C']];
  function corDe(n) { var h = 0, s = sem(n); for (var i = 0; i < s.length; i++) h = (h * 31 + s.charCodeAt(i)) >>> 0; return CORES[h % CORES.length]; }
  /* os 7 status padrão das requisições — a mesma regra do Natcorp_Registros (window.ncStatus) */
  var STATUS = [
    ['cancelado', /cancel/, 'x'], ['reprovado', /reprov|desaprov|recusad|negad|rejeit|indefer/, 'x'],
    ['suspenso', /suspens/, 'pausa'], ['concluido', /conclu|finaliz/, 'check'], ['aprovado', /aprovad|deferid/, 'check'],
    ['andamento', /andamento|em analise/, 'andamento'], ['aberto', /^(em )?abert[oa]s?$|em aberto/, 'relogio']
  ];
  function statusDe(t) { var s = sem(t), x = STATUS.filter(function (p) { return p[1].test(s); })[0]; return x ? { k: x[0], ic: x[2] } : { k: '', ic: 'ponto' }; }
  var ENCERRADA = /^(cancelado|reprovado)$/;
  var IC = {
    mais: '<path d="M12 5v14M5 12h14"/>',
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    andamento: '<path d="M4.5 12a7.5 7.5 0 0 1 13.1-5"/><path d="M18.5 3.5V7.5h-4"/><path d="M19.5 12a7.5 7.5 0 0 1-13.1 5"/><path d="M5.5 20.5v-4h4"/>',
    pausa: '<path d="M9 6.5v11M15 6.5v11"/>',
    x: '<path d="M7 7l10 10M17 7L7 17"/>',
    ponto: '<circle cx="12" cy="12" r="3.5"/>',
    pessoa: '<circle cx="12" cy="8.5" r="3.7"/><path d="M5 20c.9-3.6 3.6-5.6 7-5.6s6.1 2 7 5.6"/>',
    seta: '<path d="M9.5 6l6 6-6 6"/>',
    calendario: '<rect x="4" y="5.5" width="16" height="14.5" rx="2"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M3.5 14.5h17M9.5 10v9"/>',
    cartoes: '<rect x="3.5" y="4.5" width="17" height="6.5" rx="1.8"/><rect x="3.5" y="13" width="17" height="6.5" rx="1.8"/>',
    papel: '<path d="M7 3.5h7l4.5 4.5v12a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1v-15.5a1 1 0 0 1 1-1z"/><path d="M14 3.5V8h4.5M9 13h6M9 16.5h4"/>',
    info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5M12 8v.5"/>',
    item: '<rect x="4.5" y="4.5" width="15" height="15" rx="3"/><path d="M8.5 12h7M8.5 8.5h7M8.5 15.5h4"/>',
    historico: '<path d="M4.5 12a7.5 7.5 0 1 0 2.2-5.3"/><path d="M4 4.5v3.7h3.7"/><path d="M12 8.2V12l2.6 1.7"/>',
    dinheiro: '<rect x="3" y="6.5" width="18" height="11" rx="2"/><circle cx="12" cy="12" r="2.6"/><path d="M6.5 9.5v5M17.5 9.5v5"/>',
    escudo: '<path d="M12 3.5l7 2.5v5.5c0 4.5-3 7.8-7 9-4-1.2-7-4.5-7-9V6z"/><path d="M9 12l2.2 2.2L15.5 10"/>',
    estudo: '<path d="M3 9l9-4.5L21 9l-9 4.5z"/><path d="M7 11v4.5c1.4 1.3 3.1 2 5 2s3.6-.7 5-2V11"/>',
    estrela: '<path d="M12 4l2.4 5 5.4.6-4 3.7 1.1 5.4L12 16l-4.9 2.7 1.1-5.4-4-3.7 5.4-.6z"/>',
    onibus: '<rect x="5" y="3.5" width="14" height="14" rx="2.5"/><path d="M5 11h14M8 17.5v2.5M16 17.5v2.5"/><circle cx="8.5" cy="14.3" r=".8"/><circle cx="15.5" cy="14.3" r=".8"/>',
    balao: '<path d="M5 5.5h14a1.5 1.5 0 0 1 1.5 1.5v8.5A1.5 1.5 0 0 1 19 17h-7l-4.5 3.5V17H5a1.5 1.5 0 0 1-1.5-1.5V7A1.5 1.5 0 0 1 5 5.5z"/>',
    lupa: '<circle cx="11" cy="11" r="6"/><path d="M20 20l-4.5-4.5"/>'
  };
  function ic(n, cls) { return '<svg class="nc-cq-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || IC.item) + '</svg>'; }
  function mesmo(a, b) { return sem(a) === sem(b); }

  /* ═══ [K4] LÊ UM RELATÓRIO ═══════════════════════════════════════════════════════════════
     CUIDADO  cada coluna pelo TÍTULO (th id ↔ td headers). Papéis automáticos:
                num      Requisição / Pedido / Solicitação / Cod solicitação  → "Pedido N"
                data     a 1ª coluna "Data…" (no modo pedidos: "feito em …")
                sit      Situação / Status                     → o selo com a cor do sistema
                pessoa   Colaborador / Nome / Avaliado          → no modo pessoas, o título
                foto     coluna com imagem                      → no modo pessoas, a foto
                empresa  colunas "Empresa…"                     → só com mais de uma na lista
              Dado que é a PRÓPRIA pessoa (o código dela) não aparece. LINK (o lápis) = a ação
              da linha. Célula com link (o nome que abre a ficha, a batida…) continua clicável.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function papel(t) {
    var s = sem(t);
    if (/^(requisicao|pedido|solicitacao|n.? ?(da )?(requisicao|pedido|solicitacao)|cod(igo)? (da )?req|cod solicitacao)$/.test(s)) return 'num';
    if (/^(situacao|status)/.test(s)) return 'sit';
    if (/^solicitante$/.test(s)) return 'solicitante';
    if (/^(colaborador|nome|avaliado)$/.test(s)) return 'pessoa';
    if (/^empresa/.test(s)) return 'empresa';
    if (/^(foto)$/.test(s)) return 'foto';
    if (/^data/.test(s)) return 'data';
    return 'outro';
  }
  function eu() {
    var m = $id(P + 'MATRICULA'), v = m ? (m.value || m.textContent || '') : '';
    return codDe(v) || (($id(P + 'MAT') || {}).value || '') || (($id(P + 'MAT_COLAB') || {}).value || '');
  }
  function ler(L) {
    var nomes = {};
    [].forEach.call(L.ir.querySelectorAll('th[id]'), function (th) { nomes[th.id] = limpo(th.textContent); });
    var tb = [].slice.call(L.ir.querySelectorAll('.a-IRR-table')).sort(function (a, b) { return b.rows.length - a.rows.length; })[0];
    if (!tb) return [];
    var euCod = eu();
    return [].filter.call(tb.rows, function (tr) { return tr.querySelector('td[headers]'); }).map(function (tr) {
      var p = { cel: [], acao: null, extras: [] };
      [].forEach.call(tr.querySelectorAll('td[headers]'), function (td) {
        var h = td.getAttribute('headers'), nome = nomes[h] || '', v = limpo(td.textContent);
        var a = td.querySelector('a[href], a[onclick]');
        if (h === 'LINK') { p.acao = a; return; }
        /* coluna de link só com ícone ("Detalhes" com a lupa, ex.: 2060:2) = a ação da linha */
        if (!p.acao && a && !limpo(a.textContent) && a.querySelector('img, .fa, span[class*="fa-"]') && /^(detalhes?|ver|abrir|link|editar|visualizar)$/i.test(sem(nome))) { p.acao = a; return; }
        if (!nome) { if (a && a.querySelector('img, .fa, span[class*="fa-"]')) p.extras.push({ a: a, rot: limpo(a.getAttribute('title') || a.textContent) || 'Abrir' }); return; }
        var img = td.querySelector('img');
        p.cel.push({ nome: nome, v: v, a: a, img: img ? img.getAttribute('src') : '', papel: papel(nome), meu: !!euCod && (codDe(v) === euCod || v === euCod) });
      });
      return p;
    });
  }
  function achar(p, nome) { return p.cel.filter(function (c) { return mesmo(c.nome, nome); })[0] || null; }
  function primeiro(p, papelX) { return p.cel.filter(function (c) { return c.papel === papelX; })[0] || null; }

  /* ═══ [K5] O COLABORADOR ═════════════════════════════════════════════════════════════════
     A região "Colaborador" (com o campo de texto P<n>_MATRICULA) vira um cartão curto; o
     botão "Visualizar" é o original. Os campos de leitura continuam na página. Campo de
     ESCOLHER que estiver na região (lista "Data de Referência" da 81/83/104) fica à vista,
     logo abaixo do cartão (.nc-cq-colab-campos).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarColaborador() {
    var mat = $id(P + 'MATRICULA'); if (!mat || mat.tagName !== 'INPUT' || mat.type === 'hidden') return;
    var reg = mat.closest('.t-Region'), fotoP = $id(P + 'FOTO');
    /* a foto pode estar numa sub-região VIZINHA (300:81/83/104: "Foto" ao lado de "Dados"): o cartão
       é a região que tem as duas — senão a foto aparecia duas vezes (a real e o ícone do cartão) */
    if (fotoP && reg && !reg.contains(fotoP)) {
      var r = reg.parentElement && reg.parentElement.closest('.t-Region');
      while (r && !r.contains(fotoP)) r = r.parentElement && r.parentElement.closest('.t-Region');
      if (r && !r.querySelector('.a-IRR')) reg = r;
    }
    if (!reg || reg.offsetParent === null || reg.querySelector('.a-IRR') || reg.classList.contains('nc-colab-reg')) return;   /* a peça global (Natcorp_Colab) já fez */
    var foto = (fotoP && reg.contains(fotoP) ? fotoP : null) || reg.querySelector('img'), quem = mat.value;
    if (!quem) return;
    var sit = ($id(P + 'SITUACAO') || {}).value || '', adm = ($id(P + 'DT_ADMISSAO') || {}).value || '';
    var sitTxt = limpo(sit.replace(/^\d+\s*-\s*/, '').replace(/\s*-\s*\d{2}\/\d{2}\/\d{4}$/, ''));
    var c = el('div', 'nc-cq-colab');
    c.innerHTML = (foto ? '<img class="nc-cq-colab-foto" alt="" src="' + esc(foto.getAttribute('src')) + '">' : '<span class="nc-cq-colab-foto">' + ic('pessoa') + '</span>') +
      '<div class="nc-cq-colab-txt"><b>' + esc(nomeDe(quem)) + '</b>' +
      '<span>' + esc([codDe(quem) ? 'Matrícula ' + codDe(quem) : '', sitTxt].filter(Boolean).join(' · ')) + '</span>' +
      (adm ? '<span>' + esc(BASE_T.admissao + ' ' + (dataBR(adm) ? extenso(dataBR(adm)) : adm)) + '</span>' : '') + '</div>';
    var bt = [].filter.call(reg.querySelectorAll('button, a.t-Button'), function (b) { return /visualizar/i.test(b.textContent + (b.title || '')) || b.querySelector('.fa-user'); })[0];
    if (bt) { bt.classList.add('nc-cq-colab-bt'); c.appendChild(bt); }
    reg.classList.add('nc-cq-colab-reg');
    var corpo = reg.querySelector('.t-Region-body'); if (corpo) corpo.insertBefore(c, corpo.firstChild);
    /* campo de ESCOLHER na região (ex.: "Data de Referência" na 300:81/83/104): o cartão esconde o
       resto da região, então ele vem para logo abaixo do cartão — sem isso não dava para trocar o mês */
    var campos = [].filter.call(reg.querySelectorAll('select, textarea, input:not([type="hidden"])'), function (e) {
      return e.id && !(e.readOnly || e.disabled) && !c.contains(e) && e.closest('.t-Form-fieldContainer');
    });
    if (campos.length && corpo) {
      var faixa = el('div', 'nc-cq-colab-campos');
      campos.forEach(function (e) { var fc = e.closest('.t-Form-fieldContainer'); if (!faixa.contains(fc)) faixa.appendChild(fc); });
      corpo.insertBefore(faixa, c.nextSibling);
    }
  }

  /* ═══ [K6] OS CARTÕES ════════════════════════════════════════════════════════════════════ */
  function sitDe(L, p) { var s = primeiro(p, 'sit'); return s && !vazio(s.v) ? s.v : (L.R.situacao || ''); }
  function modoDe(L, lista) {
    if (L.R.modo) return L.R.modo;
    if (lista.some(function (p) { return primeiro(p, 'num'); })) return 'pedidos';
    var pessoas = {}; lista.forEach(function (p) { var x = primeiro(p, 'pessoa'); if (x && !x.meu) pessoas[x.v] = 1; });
    return Object.keys(pessoas).length >= 2 ? 'pessoas' : 'dados';
  }
  function ddDe(L, i, c, k) {
    var v = esc(c.papel === 'pessoa' || c.papel === 'solicitante' ? nomeDe(c.v) : c.v);
    return c.a ? '<button type="button" class="nc-cq-link" data-l="' + L.n + ':' + i + ':' + k + '">' + v + '</button>' : v;
  }
  function cartao(L, p, i) {
    var R = L.R, usadas = [], meta = '', titulo = '', sub = '', lado = '', cab = '';
    var oculto = (R.ocultar || []).map(sem);
    var usar = function (c) { if (c) usadas.push(c); return c; };
    var sit = sitDe(L, p), st = statusDe(sit);
    var principal = R.principal ? usar(achar(p, R.principal)) : null;
    if (L.modo === 'pedidos') {
      var num = usar(primeiro(p, 'num')), dt = usar(primeiro(p, 'data'));
      titulo = principal && !vazio(principal.v) ? (R.prefixo || '') + bonito(nomeDe(principal.v)) : (num ? BASE_T.pedido + ' ' + num.v : BASE_T.pedido);
      var d = dt && dataBR(dt.v);
      meta = [principal && num ? BASE_T.pedido + ' ' + num.v : '', d ? BASE_T.feito + ' ' + extenso(d) : ''].filter(Boolean).join(' · ');
      cab = '<span class="nc-cq-ic-pedido">' + ic(R.icone || 'papel') + '</span>';
    } else if (L.modo === 'pessoas') {
      var pes = usar(R.principal ? principal : primeiro(p, 'pessoa')) || usar(p.cel.filter(function (c) { return c.papel === 'outro' && !vazio(c.v); })[0]);
      var foto = usar(primeiro(p, 'foto')) || p.cel.filter(function (c) { return c.img; })[0];
      var nome = pes ? bonito(nomeDe(pes.v)) : '';
      titulo = nome; L.temLinkPessoa = L.temLinkPessoa || !!(pes && pes.a);
      p.linkPessoa = pes && pes.a ? pes.a : null;
      var cor = corDe(nome || '?');
      cab = foto && foto.img && !/PROFILE\.jpg/i.test(foto.img) ? '<img class="nc-cq-foto" alt="" src="' + esc(foto.img) + '">'
        : '<span class="nc-cq-foto nc-cq-foto--ini" style="--av-bg:' + cor[0] + ';--av-tx:' + cor[1] + '" aria-hidden="true">' + esc(iniciais(nome || '?')) + '</span>';
      if (pes && codDe(pes.v)) meta = 'Matrícula ' + codDe(pes.v);
    } else {
      var tit = principal || usar(p.cel.filter(function (c) { return c.papel === 'outro' && !vazio(c.v) && oculto.indexOf(sem(c.nome)) < 0; })[0]);
      if (tit && !principal) usadas.push(tit);
      titulo = tit && !vazio(tit.v) ? (R.prefixo || '') + bonito(nomeDe(tit.v)) : '—';
      cab = '<span class="nc-cq-ic-pedido">' + ic(R.icone || 'item') + '</span>';
      if (R.periodo) {
        var ini = usar(achar(p, R.periodo[0])), fim = usar(achar(p, R.periodo[1]));
        var di = ini && dataBR(ini.v), df = fim && dataBR(fim.v);
        meta = di && df ? BASE_T.de + ' ' + curta(di) + ' ' + BASE_T.a + ' ' + curta(df) : di ? 'desde ' + curta(di) : df ? 'até ' + curta(df) : '';
      }
    }
    if (R.sub) { var s = usar(achar(p, R.sub)); if (s && !vazio(s.v)) sub = esc(dataBR(s.v) && !/\D{3,}/.test(s.v) ? curta(dataBR(s.v)) : bonito(nomeDe(s.v))); }
    if (R.valor) { var vv = usar(achar(p, R.valor)); if (vv && !vazio(vv.v)) lado = '<span class="nc-cq-valor"><small>' + esc(vv.nome) + '</small>' + esc(vv.v) + '</span>'; }
    var euCod = eu();
    var sol = primeiro(p, 'solicitante'), outroSol = sol && !vazio(sol.v) && !sol.meu && L.modo === 'pedidos';
    if (sol) usadas.push(sol);
    var empresas = L.variasEmpresas;
    var dados = p.cel.filter(function (c) {
      if (usadas.indexOf(c) >= 0 || vazio(c.v) || c.meu || c.img) return false;
      if (c.papel === 'sit' || c.papel === 'foto') return false;
      if (c.papel === 'num' && L.modo === 'pedidos') return false;
      if (c.papel === 'empresa' && !empresas) return false;
      if (oculto.indexOf(sem(c.nome)) >= 0) return false;
      if (c.papel === 'pessoa' && L.modo !== 'pessoas' && !euCod) return true;
      return true;
    });
    var vis = dados.slice(0, 6), resto = dados.slice(6);
    var acao = p.acao || (L.modo === 'pessoas' ? p.linkPessoa : null);
    var verTxt = R.ver || (p.acao ? (L.modo === 'pedidos' ? BASE_T.verPedido : BASE_T.verDados) : BASE_T.verPessoa);
    var linha = function (c, k) { return '<div><dt>' + esc(c.nome) + '</dt><dd>' + ddDe(L, i, c, k) + '</dd></div>'; };
    var idx = function (c) { return p.cel.indexOf(c); };
    return '<li class="nc-cq-item nc-cq-item--' + L.modo + '" data-sit="' + esc(sit || '—') + '" data-st="' + st.k + '" data-busca="' + esc(sem(p.cel.map(function (c) { return c.v; }).join(' '))) + '">' +
      '<article class="nc-cq-cartao' + (ENCERRADA.test(st.k) ? ' is-encerrada' : '') + (acao ? ' is-clicavel' : '') + '">' +
      '<header class="nc-cq-cab">' + cab +
        '<div class="nc-cq-cab-txt"><h3>' + esc(titulo) + '</h3>' + (sub ? '<p class="nc-cq-sub">' + sub + '</p>' : '') +
        (meta ? '<p>' + (L.modo !== 'pessoas' ? ic('calendario') : '') + esc(meta) + '</p>' : '') + '</div>' + lado +
        (sit ? '<span class="nc-cq-sit"' + (st.k ? ' data-nc-status="' + st.k + '"' : '') + '>' + ic(st.ic) + esc(sit) + '</span>' : '') +
      '</header>' +
      ((outroSol || vis.length) ? '<dl class="nc-cq-dados">' +
        (outroSol ? '<div><dt>' + esc(BASE_T.pedidoPor) + '</dt><dd>' + ddDe(L, i, sol, idx(sol)) + '</dd></div>' : '') +
        vis.map(function (c) { return linha(c, idx(c)); }).join('') + '</dl>' : '') +
      (resto.length ? '<details class="nc-cq-mais"><summary>' + esc(BASE_T.mais(resto.length)) + '</summary><dl class="nc-cq-dados">' +
        resto.map(function (c) { return linha(c, idx(c)); }).join('') + '</dl></details>' : '') +
      ((acao || p.extras.length) ? '<footer class="nc-cq-acoes">' +
        p.extras.map(function (x, k) { return '<button type="button" class="nc-cq-bt" data-x="' + L.n + ':' + i + ':' + k + '">' + esc(x.rot) + '</button>'; }).join('') +
        (acao ? '<button type="button" class="nc-cq-bt nc-cq-bt--ver" data-ver="' + L.n + ':' + i + '">' + esc(verTxt) + ic('seta') + '</button>' : '') + '</footer>' : '') +
    '</article></li>';
  }

  /* ═══ [K7] UMA LISTA ═════════════════════════════════════════════════════════════════════
     Uma por relatório da página. Os botões da barra do relatório (escondida em cartões) vão
     para o alto dela: o de criar em destaque; os outros, em contorno.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var LISTAS = [];
  function tituloRegiao(reg) { var h = reg && reg.querySelector('.t-Region-title, .t-IRR-region > h2, h2'); return h ? limpo(h.textContent) : ''; }
  function receitaDe(reg) {
    var t = tituloRegiao(reg), R = {}, k;
    for (k in RP) if (k !== 'regioes') R[k] = RP[k];
    if (RP.regioes) Object.keys(RP.regioes).forEach(function (n) { if (mesmo(n, t)) { var o = RP.regioes[n]; for (k in o) R[k] = o[k]; } });
    if (!R.titulo) R.titulo = t || document.title;
    return R;
  }
  function montarLista(ir, n) {
    var reg = ir.closest('.t-IRR-region') || ir.closest('.t-Region') || ir.parentNode;
    var L = { n: n, ir: ir, reg: reg, R: receitaDe(reg), filtro: '', verEnc: false, busca: '' };
    L.caixa = el('div', 'nc-cq');
    L.caixa.innerHTML = '<div class="nc-cq-topo"></div><div class="nc-cq-conteudo"></div>';
    reg.parentNode.insertBefore(L.caixa, reg);
    var topo = L.caixa.querySelector('.nc-cq-topo');
    /* os da barra do relatório e os da própria região (posição TOP/acima do relatório, ex.: 2060:2) */
    var daRegiao = [].filter.call(reg.querySelectorAll('button.t-Button, a.t-Button'), function (b) { return !b.closest('.a-IRR, .nc-cq, .js-maximizeButtonContainer'); });
    [].slice.call(ir.querySelectorAll('.a-IRR-toolbar button.t-Button, .a-IRR-toolbar a.t-Button, .a-IRR-buttons .t-Button')).concat(daRegiao).forEach(function (b) {
      if (b.closest('.nc-cq, .js-maximizeButtonContainer') || b.classList.contains('t-Button--noLabel')) return;   /* o "ampliar" do relatório fica */
      var criar = /criar|nov[oa]|incluir|adicionar/i.test(b.textContent);
      if (criar && !L.criar) {
        L.criar = b; b.classList.add('nc-cq-criar');
        var lb = b.querySelector('.t-Button-label'); if (lb && L.R.pedir) lb.textContent = L.R.pedir;
        topo.insertBefore(b, topo.firstChild);
      } else { b.classList.add('nc-cq-outro'); topo.appendChild(b); }
    });
    $(reg).on('apexafterrefresh', function () { desenhar(L); });
    LISTAS.push(L);
    desenhar(L);
  }
  function desenhar(L) {
    var lista = ler(L);
    L.lista = lista;
    L.modo = modoDe(L, lista);
    var emps = {}; lista.forEach(function (p) { p.cel.forEach(function (c) { if (c.papel === 'empresa' && !vazio(c.v)) emps[c.v] = 1; }); });
    L.variasEmpresas = Object.keys(emps).length > 1;
    var sits = {}; lista.forEach(function (p) { var s = sitDe(L, p); if (s) sits[s] = (sits[s] || 0) + 1; });
    var nomesSit = Object.keys(sits);
    if (L.filtro && !sits[L.filtro]) L.filtro = '';
    var abertos = lista.filter(function (p) { var k = statusDe(sitDe(L, p)).k; return !ENCERRADA.test(k) && k !== 'concluido'; });
    var R = L.R;
    var h = '<div class="nc-cq-lista-cab"><div><h2>' + esc(R.titulo) + (lista.length ? ' <span class="nc-cq-conta">' + lista.length + '</span>' : '') + '</h2>' + (R.explica ? '<p>' + esc(R.explica) + '</p>' : '') + '</div>' +
      (n0(L) ? '<button type="button" class="nc-cq-modo" data-modo="tabela">' + ic('tabela') + '<span>' + esc(BASE_T.verTabela) + '</span></button>' : '') + '</div>';
    if (R.umAberto && abertos.length) h += '<p class="nc-cq-aviso">' + ic('info') + '<span>' + esc(UM_ABERTO_TXT) + '</span></p>';
    if (lista.length > 8) h += '<label class="nc-cq-busca">' + ic('lupa') + '<span class="nc-cq-so-leitor">' + esc(BASE_T.buscar) + '</span><input type="search" autocomplete="off" placeholder="' + esc(BASE_T.buscar) + '" data-busca="' + L.n + '" value="' + esc(L.busca) + '"></label>';
    if (lista.length && nomesSit.length > 1) {
      h += '<div class="nc-cq-filtro" role="radiogroup" aria-label="Situação">' +
        '<button type="button" role="radio" data-f="" data-lista="' + L.n + '" aria-checked="' + (!L.filtro) + '">' + esc(BASE_T.todos) + ' <b>' + lista.length + '</b></button>' +
        nomesSit.map(function (s) { var st = statusDe(s); return '<button type="button" role="radio" data-lista="' + L.n + '" data-f="' + esc(s) + '" aria-checked="' + (L.filtro === s) + '"><i class="nc-cq-ponto" data-ponto="' + st.k + '" aria-hidden="true"></i>' + esc(s) + ' <b>' + sits[s] + '</b></button>'; }).join('') + '</div>';
    }
    if (!lista.length) {
      var msg = limpo((L.ir.querySelector('.a-IRR-noDataMsg-text') || {}).textContent || '');
      h += '<div class="nc-cq-vazio">' + ic(R.icone || 'papel') + '<b>' + esc(R.vazioTit || msg || 'Nada para mostrar por aqui') + '</b>' + (R.vazioTxt ? '<span>' + esc(R.vazioTxt) + '</span>' : '') + '</div>';
    } else {
      h += '<ul class="nc-cq-cartoes nc-cq-cartoes--' + L.modo + '">' + lista.map(function (p, i) { return cartao(L, p, i); }).join('') + '</ul>' +
        '<p class="nc-cq-nenhum" hidden></p><button type="button" class="nc-cq-encerrados" data-lista="' + L.n + '" hidden></button>';
    }
    L.caixa.querySelector('.nc-cq-conteudo').innerHTML = h;
    L.cards = L.caixa.querySelector('.nc-cq-cartoes');
    /* um pedido aberto por vez: "Ver meu pedido" sobe e o criar fica discreto */
    var topo = L.caixa.querySelector('.nc-cq-topo'), velho = topo.querySelector('.nc-cq-vermeu');
    if (velho) velho.remove();
    L.caixa.classList.toggle('nc-cq--tem-aberto', !!(R.umAberto && abertos.length));
    if (R.umAberto && abertos.length === 1 && lista.length === 1 && lista[0].acao) {
      var b = el('button', 'nc-cq-vermeu', ic('papel') + '<span>' + esc(BASE_T.verMeu) + '</span>' + ic('seta'));
      b.type = 'button'; b.setAttribute('data-ver', L.n + ':0');
      topo.insertBefore(b, topo.firstChild);
    }
    filtrar(L);
  }
  function n0(L) { return L === LISTAS[0] || !LISTAS.length; }
  function filtrar(L) {
    if (!L.cards) return;
    var n = 0, enc = 0, q = sem(L.busca);
    [].forEach.call(L.cards.children, function (li) {
      var s = li.getAttribute('data-sit'), e = ENCERRADA.test(li.getAttribute('data-st'));
      if (!L.filtro && e) enc++;
      var okk = (L.filtro ? s === L.filtro : (!e || L.verEnc)) && (!q || li.getAttribute('data-busca').indexOf(q) >= 0);
      li.hidden = !okk; if (okk) n++;
    });
    var nn = L.caixa.querySelector('.nc-cq-nenhum'), bt = L.caixa.querySelector('.nc-cq-encerrados');
    if (nn) { nn.hidden = n > 0; nn.textContent = q ? BASE_T.nenhumBusca : BASE_T.nenhumFiltro; }
    if (bt) {
      bt.hidden = !!L.filtro || !enc || !!q;
      bt.setAttribute('aria-expanded', String(L.verEnc));
      bt.innerHTML = ic(L.verEnc ? 'x' : 'mais') + '<span>' + esc(L.verEnc ? BASE_T.esconderEncerrados : BASE_T.verEncerrados(enc)) + '</span>';
    }
  }

  /* ═══ [K8] CARTÕES × TABELA ══════════════════════════════════════════════════════════════
     Em cartões, os relatórios ficam na página (paginam e são a fonte), só sem a barra e a
     tabela à vista. A escolha vale para a página toda e fica no aparelho.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var CHAVE = 'nc-cq-modo:' + P;
  function modo(m) {
    try { localStorage.setItem(CHAVE, m); } catch (e) { /* sem armazenamento */ }
    document.body.classList.toggle('nc-cq-tabela', m === 'tabela');
    var volta = document.querySelector('.nc-cq-volta-cartoes'); if (volta) volta.hidden = m !== 'tabela';
  }

  /* ═══ [K9] O MAESTRO ═════════════════════════════════════════════════════════════════════ */
  function porId(s) { var x = String(s).split(':'); return { L: LISTAS[+x[0]], i: +x[1], k: +x[2] }; }
  var montado = false;
  function iniciar() {
    if (montado) return;
    var irs = [].filter.call(document.querySelectorAll('.a-IRR'), function (ir) { return !ir.closest('.ui-dialog'); });
    if (!irs.length) return;
    montado = true;
    try {
      document.body.classList.add('nc-cq-ativo');
      montarColaborador();
      irs.forEach(function (ir, n) { montarLista(ir, n); });
      /* receita com filtrosDepois: no celular, a região "Filtros" vai para depois da lista (CSS) */
      if (RP.filtrosDepois) [].forEach.call(document.querySelectorAll('.t-Region'), function (r) {
        if (!/^filtros$/i.test(tituloRegiao(r))) return;
        var col = r.closest('.col');
        if (col) { col.classList.add('nc-cq-col-depois'); return; }
        /* na coluna lateral do modelo (não está na grade): no celular, muda de lugar para depois da lista */
        if (window.matchMedia && window.matchMedia('(max-width: 640px)').matches) { var ult = LISTAS[LISTAS.length - 1].reg; ult.parentNode.insertBefore(r, ult.nextSibling); r.classList.add('nc-cq-filtros-depois'); }
      });
      var primeiraReg = LISTAS[0].reg;
      var volta = el('button', 'nc-cq-modo nc-cq-volta-cartoes', ic('cartoes') + '<span>' + esc(BASE_T.verCartoes) + '</span>');
      volta.type = 'button'; volta.setAttribute('data-modo', 'cartoes'); volta.hidden = true;
      LISTAS[0].caixa.parentNode.insertBefore(volta, LISTAS[0].caixa);
      var m = 'cartoes'; try { m = localStorage.getItem(CHAVE) || 'cartoes'; } catch (e) { /* padrão */ }
      modo(m);
      document.addEventListener('input', function (e) {
        var b = e.target.closest && e.target.closest('[data-busca]'); if (!b || b.tagName !== 'INPUT') return;
        var L = LISTAS[+b.getAttribute('data-busca')]; if (L) { L.busca = b.value; filtrar(L); }
      });
      document.addEventListener('click', function (e) {
        var t = e.target;
        var f = t.closest('.nc-cq [data-f]');
        if (f) { var L = LISTAS[+f.getAttribute('data-lista')]; L.filtro = f.getAttribute('data-f'); [].forEach.call(f.parentNode.children, function (x) { x.setAttribute('aria-checked', String(x === f)); }); filtrar(L); return; }
        var enc = t.closest('.nc-cq-encerrados'); if (enc) { var L2 = LISTAS[+enc.getAttribute('data-lista')]; L2.verEnc = !L2.verEnc; filtrar(L2); return; }
        var md = t.closest('[data-modo]'); if (md && (md.closest('.nc-cq') || md.classList.contains('nc-cq-volta-cartoes'))) { modo(md.getAttribute('data-modo')); return; }
        var lk = t.closest('.nc-cq [data-l]'); if (lk) { var a = porId(lk.getAttribute('data-l')), c = a.L && a.L.lista[a.i] && a.L.lista[a.i].cel[a.k]; if (c && c.a) c.a.click(); return; }
        var x = t.closest('.nc-cq [data-x]'); if (x) { var b = porId(x.getAttribute('data-x')), xx = b.L && b.L.lista[b.i] && b.L.lista[b.i].extras[b.k]; if (xx) xx.a.click(); return; }
        var v = t.closest('.nc-cq [data-ver]');
        if (v) { var d = porId(v.getAttribute('data-ver')), p = d.L && d.L.lista[d.i]; var ac = p && (p.acao || p.linkPessoa); if (ac) ac.click(); return; }
        var cart = t.closest('.nc-cq-cartao.is-clicavel');
        if (cart && !t.closest('button, a, summary, details, input')) { var bt = cart.querySelector('[data-ver]'); if (bt) bt.click(); }
      });
      void primeiraReg;
    } catch (e) { if (window.console) console.error('Natcorp_Consulta', e); }
  }
  $(window).one('apexreadyend', iniciar);
  $(function () { setTimeout(iniciar, 0); setTimeout(iniciar, 800); setTimeout(iniciar, 3000); });
})();
