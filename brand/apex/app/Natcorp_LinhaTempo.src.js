/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · LINHA DO TEMPO  —  o "arrumador" da tela (JavaScript)                         ║
   ║  App 200 (Painel do Operador) · Páginas 108 e 121 (Linha do Tempo) e 26 (Férias)         ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia desta página: LINHATEMPO-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   No alto do relatório (Interactive Report "Relatório") põe três jeitos de ver os mesmos fatos:
     Tabela       o relatório do APEX, como sempre;
     Trajetória   um gráfico de Gantt: uma faixa por assunto (cargo, função, salário, férias,
                  cursos…), cada fato como uma barra do começo ao fim, a régua dos anos desde a
                  admissão e o "hoje"; o ponto vira uma faixa por mês (quanto mais forte, mais
                  ocorrências). Tocar numa barra mostra os detalhes logo abaixo.
     Cronologia   os fatos em lista, por ano, do mais recente para o mais antigo, com filtros
                  por assunto; o ponto resumido por mês ("3 faltas, 1 atraso").
   A escolha fica guardada no navegador (quem prefere a Trajetória já abre nela).

   VÁRIOS COLABORADORES (página 121, "Colab x Fato"): quando os fatos vêm de mais de uma pessoa,
   a Trajetória vira uma linha por colaborador ("1864 - Bruno Cirilo de Morais", com o centro de
   custo e a situação embaixo) e, no trilho, um tracinho colorido por mudança. Tocar no nome abre
   as faixas daquela pessoa (uma por fato). No alto: buscar por nome ou matrícula, ordenar (Nome ·
   Mais fatos · Mais recente) e abrir/fechar todos. A Cronologia mostra de quem é cada fato e tem
   a mesma busca. Quem decide é o dado (o processo manda "quem" em cada fato), não o número da
   página.

   FÉRIAS (página 26): o mesmo desenho, com os dados lidos do PRÓPRIO relatório (as linhas que
   ele já desenhou — os filtros, a ordem e a página são os da Tabela; nada é buscado no banco).
   Em cada pessoa, uma faixa por PERÍODO AQUISITIVO: a faixa clara é o período aquisitivo; o
   contorno tracejado, o período para gozar (até a data limite de início); as barras cheias, as
   parcelas programadas (saída → retorno, com os dias); o losango, o prazo para iniciar — vermelho
   vencido com saldo, âmbar vencendo em até 60 dias. [J2b].

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não grava nada e não muda o relatório: a Tabela continua sendo o Interactive Report.
     • Não lê o banco por conta própria: pede os fatos ao processo AJAX da página
       NC_LINHA_TEMPO_DADOS (Processing › Ajax Callback), que usa a mesma consulta do
       relatório (vw_linha_do_tempo), o filtro "Fato", a checagem de acesso e a regra do
       salário calculada no servidor. Se a página ainda tiver o plugin antigo (TimelineJS), usa
       a chamada dele.
     • Tirou as URLs deste arquivo da página: tudo volta a ser como era.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Páginas 108, 121 e 26 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_LinhaTempo.js
     Páginas 108, 121 e 26 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_LinhaTempo.css

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Achados SEM classe (não é preciso pôr nada no APEX):
     • o relatório: a região Interactive Report da página (a primeira, se houver mais);
     • os dados: o processo AJAX NC_LINHA_TEMPO_DADOS da página (o nome está em PROCESSO, [J2]);
       se a página ainda tiver o plugin Linha do Tempo, a chamada dele.
   Opcional: a classe nc-lt-relatorio numa região Interactive Report escolhe QUAL relatório
   ganha o seletor, se a página tiver mais de um.
   O plugin antigo pode ser apagado (02/10): com o processo NC_LINHA_TEMPO_DADOS na página, o
   desenho não depende mais dele. Se ele ficar, a classe nc-lt-fonte na região do plugin o
   esconde (e a aba dele).

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Como a página é reconhecida ........ o relatório e o plugin             CUIDADO
     [J2]  Assuntos, faixas e cores ........... a ordem e o nome de cada faixa     PODE MEXER
     [J2b] Férias: ler o relatório ............ período aquisitivo, parcelas, prazos PODE MEXER
     [J3]  Ferramentas ........................ datas, textos, ícones
     [J4]  Ler os fatos ........................ do texto do plugin para descrição, motivo, valor
     [J5]  O seletor Tabela/Trajetória/Cronologia
     [J6]  A Trajetória (Gantt) ............... faixas, barras, régua, zoom anos→dias PODE MEXER
     [J7]  O resumo do mouse e os detalhes .... cartãozinho ao passar; o tocado embaixo
     [J8]  A Cronologia ....................... por ano, com filtros                PODE MEXER
     [J8b] Vários colaboradores ............... uma linha por pessoa, busca, ordem  PODE MEXER
     [J9]  O maestro .......................... quando busca e redesenha; o começo CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Apareceu um assunto novo e ele caiu em "Outros"
       → [J2], lista FAIXAS: acrescente uma linha com o nome que vem do APEX (a coluna Fato).
     Quero mudar o nome de uma faixa (ex.: "Local de trabalho" → "Local")
       → [J2], o segundo texto da linha.
     Quero mudar a cor de um assunto            → [J2], lista ASSUNTOS (use as cores da marca).
     Quero outras escalas de zoom (ou mais largas) → [J6], lista ESCALAS (pixels por dia).
     A tela ficou "crua" (sem o seletor)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp linha do tempo].

   ── LEGENDA DAS MARCAS NOS COMENTÁRIOS ────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, cores.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
     (sem marca)  funciona sozinho; só mexa se souber o que está fazendo.

   ── COMO LER UM ARQUIVO JS EM 30 SEGUNDOS ─────────────────────────────────────────────────
     comentário             tudo entre barra-asterisco e asterisco-barra. O navegador ignora.
     function nome() { … }  uma "receita" com nome. Ela só roda quando alguém a chama: nome().
     var x = …;             guarda um valor com um nome, para usar depois.
     'texto'  ou  "texto"   um texto. Muitas vezes, é o que aparece na tela.
     [ … ]                  uma lista;  { a: 1 }  um grupo de valores com nome.
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* ═══ [J1] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════════
     O QUE FAZ  Procura o relatório (Interactive Report) — sem ele, o arquivo para aqui e a página
                fica como o APEX desenhou — e, se existir, a região do plugin Linha do Tempo.
     CUIDADO    Este arquivo é carregado ANTES de o APEX montar o plugin (as URLs de arquivo vêm
                antes do código de abertura da página). Por isso tudo começa em iniciar(), que só
                roda quando o APEX avisa que a página está pronta (o evento apexreadyend) — veja
                o fim do arquivo. Procurar o plugin antes disso não acha nada.
                A primeira linha impede que o arquivo rode duas vezes e que rode fora do APEX.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncLinhaTempo || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;
  function iniciar() {
  if (window.__ncLinhaTempo) return;
  var IR = document.querySelector('.t-IRR-region.nc-lt-relatorio') || document.querySelector('.t-IRR-region');
  /* o plugin é achado pelo componente dele (o widget "sb.timeline" do jQuery), que já existe
     quando a página fica pronta — o desenho do TimelineJS (.tl-timeline) só aparece depois que
     os dados chegam do servidor, tarde demais para procurar por ele */
  var PLUGIN = [].filter.call(document.querySelectorAll('.t-Region, [id$="_timeline"]'), function (r) { return !!$(r).data('sb-timeline'); })[0] || null;
  if (!IR) return;
  window.__ncLinhaTempo = true;
  var OPCOES = PLUGIN ? $(PLUGIN).timeline('option') : null;
  /* o plugin só como fonte dos dados (classe nc-lt-fonte): a região e a aba dela saem da vista */
  if (PLUGIN && PLUGIN.classList.contains('nc-lt-fonte')) {
    PLUGIN.classList.add('nc-lt-escondido');
    [].forEach.call(document.querySelectorAll('.apex-rds a[href="#' + PLUGIN.id + '"]'), function (a) { var li = a.closest('li'); (li || a).classList.add('nc-lt-escondido'); });
  }

  /* ═══ [J2] ASSUNTOS, FAIXAS E CORES ══════════════════════════════════════════════════════
     ASSUNTOS  a ordem em que os assuntos aparecem (de cima para baixo) e a cor de cada um.
     FAIXAS    para cada nome que vem do APEX (a coluna Fato): [nome na tela, assunto, jeito].
               jeito: 'estado'  vale até a próxima mudança (cargo, salário…);
                      'periodo' tem começo e fim (férias, atestado, validade do curso);
                      'marco'   acontece num dia (exame, avaliação);
                      'ponto'   as ocorrências do ponto, somadas por mês.
               Nome que não está na lista cai em "Outros" (e o jeito é deduzido das datas).
     PODE MEXER os textos e as cores (use as cores da marca, pelo nome: var(--nc-roxo)…).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ASSUNTOS = [
    /* a cor depois da vírgula é a reserva, para quando o tema não definir a cor da marca */
    { id: 'contrato', rot: 'Contrato e lotação', cor: 'var(--nc-roxo, #511C76)' },
    { id: 'remun', rot: 'Remuneração', cor: 'var(--nc-bom, #1F7A52)' },
    { id: 'ausencia', rot: 'Férias, ausências e saúde', cor: 'var(--nc-rosa, #C95788)' },
    { id: 'desenv', rot: 'Desenvolvimento', cor: 'var(--nc-ameixa, #9A408A)' },
    { id: 'ponto', rot: 'Ponto', cor: 'var(--nc-ruim, #B8323F)' },
    /* Férias (página 26) */
    { id: 'aquisitivo', rot: 'Períodos aquisitivos', cor: 'var(--nc-roxo, #511C76)' },
    { id: 'gozo', rot: 'Férias programadas', cor: 'var(--nc-rosa, #C95788)' },
    { id: 'prazo', rot: 'Prazos', cor: 'var(--nc-ruim, #B8323F)' },
    { id: 'outros', rot: 'Outros', cor: 'var(--nc-grafite, #4A4460)' }
  ];
  var FAIXAS = {
    'cargo': ['Cargo', 'contrato', 'estado'],
    'funcao': ['Função', 'contrato', 'estado'],
    'centro de custo': ['Centro de custo', 'contrato', 'estado'],
    'filial': ['Filial', 'contrato', 'estado'],
    'local trabalho': ['Local de trabalho', 'contrato', 'estado'],
    'regime trabalho': ['Regime de trabalho', 'contrato', 'estado'],
    'sindicato': ['Sindicato', 'contrato', 'estado'],
    'situacao func': ['Situação', 'contrato', 'estado'],
    'tipo situacao': ['Tipo de situação', 'contrato', 'estado'],
    'salario': ['Salário', 'remun', 'estado'],
    'ferias': ['Férias', 'ausencia', 'periodo'],
    'atestado medico': ['Atestados', 'ausencia', 'periodo'],
    'exame funcionario': ['Exames', 'ausencia', 'marco'],
    'cursos': ['Cursos', 'desenv', 'periodo'],
    'avaliacao': ['Avaliações', 'desenv', 'marco'],
    'ponto eletronico (apuracao)': ['Ponto', 'ponto', 'ponto']
  };
  /* CUIDADO: o nome do processo AJAX da página que entrega os fatos (Processing › Ajax Callback).
     Mudou o nome no APEX? Mude aqui também. */
  var PROCESSO = 'NC_LINHA_TEMPO_DADOS';
  /* os itens que vão junto na chamada (o filtro "Fato" da 108; empresa e matrícula já estão na
     sessão). Na 121 nada vai junto: os filtros já foram para a sessão quando o relatório foi
     atualizado — e assim o gráfico mostra exatamente o que a Tabela mostra. */
  var ITENS = '#P108_FATO';

  /* as ocorrências do ponto em três faixas, pelo nome do evento */
  /* rot: o nome da faixa; um/varios: como a contagem aparece ("1 falta ou atraso", "3 faltas ou
     atrasos") — conta LANÇAMENTOS do ponto; as horas vêm entre parênteses */
  var PONTO = [
    { id: 'menos', rot: 'Faltas e atrasos', um: 'falta ou atraso', varios: 'faltas ou atrasos', teste: /falta|atraso|sa[ií]da|dsr/i, cor: 'var(--nc-ruim, #B8323F)' },
    { id: 'mais', rot: 'Horas a mais', um: 'crédito de horas', varios: 'créditos de horas', teste: /extra|cr[eé]dito|\bhe\b|banco/i, cor: 'var(--nc-bom, #1F7A52)' },
    { id: 'outro', rot: 'Outras ocorrências', um: 'outra ocorrência', varios: 'outras ocorrências', teste: /./, cor: 'var(--nc-grafite, #4A4460)' }
  ];

  /* ═══ [J2b] FÉRIAS: LER O RELATÓRIO ═════════════════════════════════════════════════════
     O QUE FAZ  Na página de Férias não há processo: os fatos saem das linhas que o relatório
                JÁ desenhou (por isso valem os filtros, a ordem e a página da Tabela). O relatório
                é reconhecido pelas colunas "Data Inicial Período Aquisitivo" e "Data Final
                Período Aquisitivo"; cada linha (uma pessoa × um período aquisitivo) vira:
                  • o período aquisitivo (faixa clara);
                  • o período para gozar — do fim do aquisitivo até a "Data Limite Início de
                    Férias" (contorno tracejado);
                  • cada parcela com data de saída (barra cheia: saída → retorno, "1ª · 15 dias");
                  • o prazo para iniciar (losango): VENCIDO (vermelho) com saldo e a data já
                    passou; VENCE LOGO (âmbar) com saldo e até PERTO dias; em aberto (grafite);
                    sem saldo (verde).
                Coluna escondida em Ações › Colunas simplesmente não entra (as parcelas, por
                exemplo); sem as duas datas do período aquisitivo, a página fica sem o desenho.
     PODE MEXER COLS (o nome das colunas, sem acento e em minúsculas) e PERTO (dias).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PERTO = 60;
  /* situação que encerra o período (não tem prazo a cobrar, mesmo com saldo no cadastro) */
  var RESOLVIDO = /cancel|quitad|gozad|pag[oa]s?\b|encerr|liquid|indeniz|conclu/;
  function dias(n) { var t = String(n).replace('.', ','); return t + (n === 1 ? ' dia' : ' dias'); }
  /* "há 12 dias" até dois meses; depois, em anos e meses */
  function quanto(a, b) { var d = Math.round(Math.abs(b - a) / DIA); return d <= 60 ? dias(d) : duracao(a < b ? a : b, a < b ? b : a); }
  var COLS = {
    aqIni: /^data inicial periodo aquisitivo$/, aqFim: /^data final periodo aquisitivo$/,
    limIni: /^data limite inicio de ferias$/, limProg: /^data limite de programacao de ferias$/,
    saldo: /^saldo$/, sit: /^situacao \(ferias\)$/, sitFunc: /^situacao funcional$/,
    pessoa: /^colaborador$/, empresa: /^empresa$/, ccusto: /^centro de custo/,
    saida: /^data saida parc\.? ?(\d)$/, retorno: /^data retorno parc\.? ?(\d)$/, pagto: /^data pagto parc\.? ?(\d)$/,
    dias: /^n.? ?dias parc\.? ?(\d)$/, abono: /^dias abono parc\.? ?(\d)$/, decimo: /^opcao 13.*parc\.? ?(\d)$/
  };
  function tabelaDoIR() {
    return [].slice.call(IR.querySelectorAll('.a-IRR-tableContainer .a-IRR-table')).sort(function (a, b) { return b.rows.length - a.rows.length; })[0] || null;
  }
  /* o mapa das colunas: { aqIni: 9, …, saida: { 1: 14, 2: 20 }, … } — ou null se não é Férias */
  function colunasFerias() {
    var tb = tabelaDoIR(), cab = tb && tb.rows[0] ? [].map.call(tb.rows[0].cells, function (c) { return sem(c.textContent); }) : [];
    var m = {};
    cab.forEach(function (c, k) {
      Object.keys(COLS).forEach(function (n) {
        var r = COLS[n].exec(c);
        if (!r) return;
        if (r[1]) { m[n] = m[n] || {}; m[n][r[1]] = k; } else if (m[n] === undefined) m[n] = k;
      });
    });
    return m.aqIni !== undefined && m.aqFim !== undefined ? m : null;
  }
  function dataBR(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  /* o miolo, igual para as duas fontes: pega(nome) ou pega(nome, parcela) devolve o texto */
  function fatosFerias(pega, out) {
    var h = hoje();
    var aqIni = dataBR(pega('aqIni')), aqFim = dataBR(pega('aqFim'));
    if (!aqIni || !aqFim) return;
    var pes = pega('pessoa'), mat = pes.split(' - ')[0], nome = pes.split(' - ').slice(1).join(' - ') || pes;
    var emp = pega('empresa').split(' - ')[0];
    var quem = { id: (emp || '0') + '-' + mat, mat: mat, nome: nome, sub: [pega('ccusto'), pega('sitFunc')].filter(Boolean).join(' · ') };
    var faixa = aqIni.getFullYear() === aqFim.getFullYear() ? String(aqIni.getFullYear()) : aqIni.getFullYear() + '/' + aqFim.getFullYear();
    var sit = bonito(pega('sit')), saldoT = pega('saldo'), saldo = saldoT === '' ? null : +saldoT.replace(',', '.');
    var limIni = dataBR(pega('limIni')), limProg = dataBR(pega('limProg'));
    var periodoTxt = dd(aqIni) + ' a ' + dd(aqFim);
    var nota = [sit, saldo !== null ? 'saldo ' + dias(saldo) : ''].filter(Boolean).join(' · ');
    var resolvido = RESOLVIDO.test(sem(sit));
    var base = { quem: quem, faixa: faixa, nota: nota, ordem: aqIni };
    var junta = function (o) { var x = {}; Object.keys(base).forEach(function (k) { x[k] = base[k]; }); Object.keys(o).forEach(function (k) { x[k] = o[k]; }); out.push({ nc: x, quem: quem }); };
    junta({ papel: 'fundo-aq', assunto: 'aquisitivo', jeito: 'periodo', ini: aqIni, fim: aqFim, tag: 'Período aquisitivo', titulo: 'Período aquisitivo ' + faixa,
      extra: [['Período', periodoTxt], sit ? ['Situação', sit] : null, saldo !== null ? ['Saldo', dias(saldo)] : null, limIni ? ['Iniciar as férias até', dd(limIni)] : null, limProg ? ['Programar até', dd(limProg)] : null].filter(Boolean) });
    if (limIni && limIni > aqFim) {
      junta({ papel: 'fundo-co', assunto: 'aquisitivo', jeito: 'periodo', ini: new Date(aqFim.getFullYear(), aqFim.getMonth(), aqFim.getDate() + 1), fim: limIni, tag: 'Período para gozar', titulo: 'Para gozar as férias de ' + faixa,
        extra: [['De', dd(new Date(aqFim.getTime() + DIA)) + ' até ' + dd(limIni)], limProg ? ['Programar até', dd(limProg)] : null].filter(Boolean) });
    }
    var parcelas = 0;
    ['1', '2', '3'].forEach(function (n) {
      var sai = dataBR(pega('saida', n));
      if (!sai) return;
      parcelas++;
      var ret = dataBR(pega('retorno', n)), dias = +(pega('dias', n) || 0), ab = pega('abono', n), pg = dataBR(pega('pagto', n)), dec = pega('decimo', n);
      var fimGozo = dias ? new Date(sai.getFullYear(), sai.getMonth(), sai.getDate() + dias - 1) : ret ? new Date(ret.getTime() - DIA) : sai;
      junta({ papel: 'parcela', assunto: 'gozo', jeito: 'periodo', ini: sai, fim: fimGozo, tag: n + 'ª parcela',
        titulo: n + 'ª · ' + (dias || Math.round((fimGozo - sai) / DIA) + 1) + ' dias',
        extra: [['Sai em', dd(sai) + ' · ' + SEMANA[sai.getDay()]], ret ? ['Volta em', dd(ret) + ' · ' + SEMANA[ret.getDay()]] : null, pg ? ['Pagamento', dd(pg)] : null,
          ab && ab !== '0' ? ['Abono', ab + (ab === '1' ? ' dia' : ' dias')] : null, dec ? ['13º salário', { S: 'Sim', N: 'Não' }[dec.toUpperCase()] || bonito(dec)] : null, ['Período aquisitivo', periodoTxt]].filter(Boolean) });
    });
    if (limIni) {
      var falta = Math.round((limIni - h) / DIA), alerta = resolvido ? 'fim' : saldo === 0 ? 'ok' : falta < 0 ? 'vencido' : falta <= PERTO ? 'perto' : 'aberto';
      var frase = alerta === 'fim' ? sit + ': sem prazo a cobrar'
        : alerta === 'ok' ? 'Sem saldo: férias deste período resolvidas'
        : alerta === 'vencido' ? 'Prazo vencido há ' + quanto(limIni, h) + (saldo ? ' · saldo ' + dias(saldo) : '')
        : 'Faltam ' + quanto(h, limIni) + ' para iniciar' + (saldo ? ' · saldo ' + dias(saldo) : '') + (parcelas ? '' : ' · nada programado');
      junta({ papel: 'prazo', assunto: 'prazo', jeito: 'marco', ini: limIni, fim: limIni, tag: 'Prazo para iniciar', titulo: 'Iniciar as férias de ' + faixa + ' até ' + dd(limIni),
        motivo: frase, alerta: alerta, urgencia: alerta === 'ok' || alerta === 'fim' ? Infinity : limIni.getTime(),
        extra: [limProg ? ['Programar até', dd(limProg)] : null, ['Período aquisitivo', periodoTxt]].filter(Boolean) });
    }
  }
  /* FONTE 1 — o processo da página (todos os registros): { ferias: [ { emp, mat, nome, … } ] } */
  var JSON_DE = { aqIni: 'aq_ini', aqFim: 'aq_fim', limIni: 'lim_ini', limProg: 'lim_prog', saldo: 'saldo', sit: 'sit', sitFunc: 'sit_func', ccusto: 'ccusto' };
  var JSON_PARC = { saida: 'saida', retorno: 'retorno', pagto: 'pagto', dias: 'dias', abono: 'abono', decimo: 'dec' };
  function lerFeriasJSON(lista) {
    var out = [];
    lista.forEach(function (r) {
      fatosFerias(function (k, n) {
        var t;
        if (n) { var pc = (r.parcelas || []).filter(function (x) { return String(x.n) === n; })[0]; t = pc ? pc[JSON_PARC[k]] : null; }
        else if (k === 'pessoa') t = r.mat + ' - ' + (r.nome || '');
        else if (k === 'empresa') t = r.emp;
        else t = r[JSON_DE[k]];
        return t === null || t === undefined ? '' : String(t).replace(/\s+/g, ' ').trim();
      }, out);
    });
    return out;
  }
  /* FONTE 2 — as linhas que o relatório desenhou (só a página aberta da Tabela) */
  function lerFerias(M) {
    var tb = tabelaDoIR(), out = [];
    if (!tb) return out;
    [].slice.call(tb.rows, 1).forEach(function (tr) {
      var c = tr.cells;
      if (!c || c.length < 3 || tr.querySelector('th')) return;
      var v = function (k) { return k === undefined || !c[k] ? '' : c[k].textContent.replace(/\s+/g, ' ').trim().replace(/^-$/, ''); };
      fatosFerias(function (k, n) { return v(n ? (M[k] || {})[n] : M[k]); }, out);
    });
    return out;
  }


  /* ═══ [J3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  var SEMANA = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'];
  var MES3 = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  var DIA = 864e5;
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function sem(t) { return String(t || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase().trim(); }
  function hoje() { var h = new Date(); return new Date(h.getFullYear(), h.getMonth(), h.getDate()); }
  function data(o) { return o && o.year ? new Date(+o.year, (+o.month || 1) - 1, +o.day || 1) : null; }
  function dd(d) { return d ? ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear() : ''; }
  function mesAno(d) { return MESES[d.getMonth()] + ' de ' + d.getFullYear(); }
  /* "Gerente De Recursos Humanos" → "Gerente de Recursos Humanos" */
  function bonito(t) { return String(t || '').replace(/\s+/g, ' ').trim().replace(/\s(De|Da|Do|Das|Dos|E|Em|No|Na)(?=\s)/g, function (x) { return x.toLowerCase(); }); }
  /* quanto tempo entre duas datas, em palavras: "16 anos e 10 meses", "3 meses", "12 dias" */
  function duracao(a, b) {
    var m = (b.getFullYear() - a.getFullYear()) * 12 + b.getMonth() - a.getMonth() - (b.getDate() < a.getDate() ? 1 : 0);
    if (m < 1) { var d = Math.round((b - a) / DIA) + 1; return d + (d === 1 ? ' dia' : ' dias'); }
    var an = Math.floor(m / 12), me = m % 12;
    return [an ? an + (an === 1 ? ' ano' : ' anos') : '', me ? me + (me === 1 ? ' mês' : ' meses') : ''].filter(Boolean).join(' e ');
  }
  function horasMin(t) { var m = /(\d+):(\d{2})/.exec(t || ''); return m ? +m[1] * 60 + +m[2] : 0; }
  function hhmm(min) { return Math.floor(min / 60) + ':' + ('0' + (min % 60)).slice(-2); }
  var IC = {
    tabela: '<rect x="3.5" y="4.5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M3.5 14.5h17M9.5 9.5v10"/>',
    gantt: '<path d="M4 6h9M7 12h11M5 18h7"/>',
    lista: '<path d="M8 6.5h12M8 12h12M8 17.5h12"/><circle cx="4.5" cy="6.5" r="1"/><circle cx="4.5" cy="12" r="1"/><circle cx="4.5" cy="17.5" r="1"/>',
    x: '<path d="M7 7l10 10M17 7L7 17"/>',
    mais: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5M8.5 11h5M11 8.5v5"/>',
    menos: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5M8.5 11h5"/>',
    lupa: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    seta: '<path d="M9.5 6.5l5.5 5.5-5.5 5.5"/>'
  };
  function svg(d) { return '<svg class="nc-lt-ic" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }

  /* ═══ [J4] LER OS FATOS ══════════════════════════════════════════════════════════════════
     O QUE FAZ  O plugin manda cada fato como um texto só, por exemplo:
                  "(Cargo) Gerente De Recursos Humanos Motivo: Admissão"
                  "(Salário) 8.623,13   Percentual:    0,00% Motivo: Adequação"
                  "3 - Falta Horas: 04:00 Apuração: Aberto"
                Aqui ele vira: o título ("Gerente de Recursos Humanos"), o motivo, o valor, as
                horas — e as datas de começo e fim.
     CUIDADO    Se o texto do plugin mudar de formato, o título pode vir com o texto inteiro
                (nada quebra; só fica menos arrumado).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function lerFato(e, i) {
    /* fato já montado (Férias, [J2b]): tudo vem pronto, cada um na faixa do seu período */
    if (e.nc) {
      var x = e.nc;
      return { i: i, grupo: x.faixa, rot: x.faixa, assunto: x.assunto, jeito: x.jeito, ini: x.ini, fim: x.fim, titulo: x.titulo, extra: x.extra || [], motivo: x.motivo || '',
        quem: x.quem ? String(x.quem.id) : '', faixaPropria: true, tag: x.tag, papel: x.papel, alerta: x.alerta, nota: x.nota, ordem: x.ordem, urgencia: x.urgencia };
    }
    var g = e.group || (e.text && e.text.text) || 'Outros';
    var cfg = FAIXAS[sem(g)];
    var ini = data(e.start_date), fim = data(e.end_date);
    var jeito = cfg ? cfg[2] : (!fim ? 'estado' : fim > ini ? 'periodo' : 'marco');
    // O texto do fato ("(Cargo) Gerente … Motivo: x") vem no headline; se vier no outro campo
    // (processo antigo, com os dois trocados), usa o que tiver o "(Grupo)" ou o "Motivo:".
    var t1 = (e.text && e.text.headline) || '', t2 = (e.text && e.text.text) || '';
    if (!/^\(|Motivo:/i.test(t1) && /^\(|Motivo:/i.test(t2)) t1 = t2;
    var h = bonito(t1);
    var f = { i: i, grupo: g, rot: cfg ? cfg[0] : bonito(g), assunto: cfg ? cfg[1] : 'outros', jeito: jeito, ini: ini, fim: fim, titulo: h, extra: [], motivo: '', quem: e.quem ? String(e.quem.id) : '' };
    var m = /^\(([^)]*)\)\s*(.*)$/.exec(h), corpo = h;
    if (m && sem(m[1]) === sem(g)) corpo = m[2];
    else if (m) { f.titulo = m[1]; corpo = m[2]; if (corpo) f.extra.push(['Resultado', corpo]); }
    var mm = /\s*Motivo:\s*(.*)$/i.exec(corpo);
    if (mm) { f.motivo = mm[1]; corpo = corpo.slice(0, mm.index); }
    corpo = corpo.replace(/\s*Percentual:\s*-?\s*$/i, '');   /* "Percentual: -" num fato que não é salário */
    if (!m || sem(m[1]) === sem(g)) f.titulo = corpo.trim() || f.rot;
    if (jeito === 'estado' && sem(g) === 'salario') {
      /* o percentual vem como texto ("4,50%") ou como número ("4.5"): os dois viram "4,50%" */
      var v = /^([\d.,]+)\s*(?:Percentual:\s*(-?[\d.,]+)\s*%?)?/.exec(f.titulo);
      if (v) {
        f.titulo = 'R$ ' + v[1];
        var pc = v[2] ? (/,/.test(v[2]) ? v[2] : (+v[2]).toFixed(2).replace('.', ',')) : '';
        if (pc && !/^-?0(,0+)?$/.test(pc)) f.extra.push(['Percentual', pc + '%']);
      }
    }
    if (sem(g) === 'ferias') {
      var pa = /Per[ií]odo Aquisitivo:\s*(.*)$/i.exec(f.titulo);
      if (pa) { f.extra.push(['Período aquisitivo', pa[1].replace(/\s*-\s*/, ' a ')]); }
      f.titulo = ini && fim ? Math.round((fim - ini) / DIA) + ' dias' : 'Férias';
    }
    if (jeito === 'ponto') {
      var pt = /^(.*?)\s+Horas:\s*([\d:]+)(?:\s+Apura[cç][aã]o:\s*(.*))?$/i.exec(h);
      f.evento = pt ? pt[1] : h;
      f.horas = pt ? pt[2] : '';
      if (pt && pt[3]) f.extra.push(['Apuração', pt[3]]);
      f.titulo = f.evento.replace(/^\d+\s*-\s*/, '');
      for (var k = 0; k < PONTO.length; k++) if (PONTO[k].teste.test(f.evento)) { f.sentido = PONTO[k].id; break; }
    }
    return f;
  }
  /* os estados (cargo, salário…) valem até a próxima mudança do mesmo assunto DA MESMA PESSOA */
  function periodos(fatos) {
    var por = {};
    fatos.forEach(function (f) { if (f.jeito === 'estado') (por[f.quem + '|' + f.grupo] = por[f.quem + '|' + f.grupo] || []).push(f); });
    Object.keys(por).forEach(function (g) {
      var l = por[g].sort(function (a, b) { return a.ini - b.ini; });
      l.forEach(function (f, k) { var prox = l[k + 1]; f.ate = prox ? prox.ini : hoje(); f.atual = !prox; });
    });
    fatos.forEach(function (f) { if (f.jeito !== 'estado') f.ate = f.fim && f.fim > f.ini ? f.fim : f.ini; });
    return fatos;
  }

  /* ═══ [J5] O SELETOR TABELA / TRAJETÓRIA / CRONOLOGIA ════════════════════════════════════ */
  var MODOS = [['tabela', 'Tabela', IC.tabela], ['trajetoria', 'Trajetória', IC.gantt], ['cronologia', 'Cronologia', IC.lista]];
  var CHAVE = 'nc-lt-modo';
  var modo = 'tabela';
  try { modo = localStorage.getItem(CHAVE) || 'tabela'; } catch (e) { /* sem localStorage: começa na tabela */ }
  var corpoIR = IR.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || IR;
  var barra = el('div', 'nc-lt-modos');
  barra.setAttribute('role', 'group');
  barra.setAttribute('aria-label', 'Como ver a linha do tempo');
  barra.innerHTML = MODOS.map(function (m) { return '<button type="button" data-modo="' + m[0] + '">' + svg(m[2]) + '<span>' + m[1] + '</span></button>'; }).join('');
  var painel = el('div', 'nc-lt-painel');
  painel.setAttribute('aria-live', 'polite');
  corpoIR.insertBefore(painel, corpoIR.firstChild);
  corpoIR.insertBefore(barra, painel);
  barra.addEventListener('click', function (ev) { var b = ev.target.closest('[data-modo]'); if (b) trocar(b.getAttribute('data-modo')); });
  function trocar(m) {
    modo = m;
    try { localStorage.setItem(CHAVE, m); } catch (e) { /* ok */ }
    [].forEach.call(barra.querySelectorAll('[data-modo]'), function (b) { b.setAttribute('aria-pressed', String(b.getAttribute('data-modo') === m)); });
    IR.classList.toggle('nc-lt-sem-tabela', m !== 'tabela');
    /* o cabeçalho "grudento" da tabela (a cópia que o desenho geral cria, fora da região) sai junto */
    document.body.classList.toggle('nc-lt-fora-da-tabela', m !== 'tabela');
    painel.hidden = m === 'tabela';
    if (m !== 'tabela') carregar().then(desenhar);
  }

  /* ═══ [J6] A TRAJETÓRIA (GANTT) ══════════════════════════════════════════════════════════
     O QUE FAZ  Uma faixa por assunto, na ordem de ASSUNTOS; em cada faixa, cada fato é uma barra
                do começo ao fim (os estados vão até a próxima mudança — o atual, até hoje). Os
                marcos do dia são um ponto. O ponto eletrônico vira três faixas (faltas e
                atrasos · horas a mais · outras).
                ZOOM em quatro escalas (ESCALAS): Anos (a carreira inteira na largura da tela),
                Meses, Semanas e Dias (o gráfico fica mais largo e rola para o lado, com os nomes
                das faixas presos à esquerda). Os botões − e + afastam e aproximam; Ctrl + roda
                do mouse sobre o gráfico também. Ao trocar de escala, a data que estava no meio
                continua no meio (com Ctrl + roda, a que estava debaixo do mouse); ao sair de
                Anos, a tela vai para o fato tocado ou para hoje.
                Na escala Anos o ponto é somado por mês (quadradinho mais forte = mais
                ocorrências); nas outras, cada ocorrência aparece no seu dia.
                A régua tem dois andares: ano/meses, mês/semanas, mês/dias.
     PODE MEXER a lista ESCALAS: [id, texto do botão, pixels por dia; 0 = caber na largura].
     VISUAL     Natcorp_LinhaTempo.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ESCALAS = [['anos', 'Anos', 0], ['meses', 'Meses', 3.2], ['semanas', 'Semanas', 12], ['dias', 'Dias', 36]];
  var escala = 'anos', ESCALA_ESCOLHIDA = false;
  var FATOS = null, CARREGANDO = null, SEL = null, ANCORA = null, AVISO = '', AVISO_TOM = '';
  /* EQUIPE: os fatos são de várias pessoas (página 121); PESSOAS: id → { rot, nome, sub } */
  var EQUIPE = false, PESSOAS = {};
  var SEM1 = ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sáb'];
  /* CUIDADO: os mesmos números de --nc-lt-rot no CSS ([C3], [C6] e [C7]) */
  function rotLargura() { var cel = window.matchMedia && window.matchMedia('(max-width: 640px)').matches; return EQUIPE ? (cel ? 150 : 248) : (cel ? 116 : 172); }
  function dominio() {
    /* até hoje — ou até o fato mais adiante (prazos e parcelas programadas ficam no futuro) */
    var fim = FATOS.reduce(function (a, f) { var z = f.ate || f.fim || f.ini; return z && z > a ? z : a; }, hoje());
    var ini = FATOS.reduce(function (a, f) { return f.ini && f.ini < a ? f.ini : a; }, fim);
    return [new Date(ini.getFullYear(), 0, 1), new Date(fim.getFullYear(), fim.getMonth() + 1, 1)];
  }
  function diasEntre(a, b) { return Math.round((b - a) / DIA); }
  /* a geometria da escala: pixels por dia e a largura total do trilho */
  function geometria(D) {
    var e = ESCALAS.filter(function (x) { return x[0] === escala; })[0] || ESCALAS[0];
    var livre = Math.max(EQUIPE ? 170 : 320, (painel.clientWidth || 900) - rotLargura() - 16);
    var ppd = e[2] || livre / diasEntre(D[0], D[1]);
    return { ppd: ppd, w: Math.round(diasEntre(D[0], D[1]) * ppd), x: function (d) { return Math.round(diasEntre(D[0], d) * ppd * 10) / 10; } };
  }
  /* a régua: [menor = as marcas de baixo, maior = as de cima] e as linhas fortes da grade */
  function regua(D, G) {
    var menor = [], maior = [], fortes = [], d, a;
    var porAno = 365 * G.ppd;
    if (escala === 'anos') {
      /* um ano a cada quantos? o que couber um rótulo de ~36px: 1, 2, 5, 10 ou 20 anos */
      var passo = [1, 2, 5, 10, 20].filter(function (n) { return n * porAno >= 36; })[0] || 20;
      for (a = D[0].getFullYear(); a < D[1].getFullYear() + 1; a++) {
        var da = new Date(a, 0, 1);
        if (da >= D[1]) break;
        fortes.push(G.x(da));
        if ((a - D[0].getFullYear()) % passo === 0) menor.push([G.x(da), String(a), 'is-forte']);
      }
    } else {
      for (d = new Date(D[0]); d < D[1]; d = new Date(d.getFullYear(), d.getMonth() + 1, 1)) {
        var jan = d.getMonth() === 0;
        if (escala === 'meses') {
          fortes.push([G.x(d), jan]);
          menor.push([G.x(d), MES3[d.getMonth()], jan ? 'is-forte' : '']);
          if (jan || d.getTime() === D[0].getTime()) maior.push([G.x(d), String(d.getFullYear())]);
        } else {
          fortes.push([G.x(d), jan]);
          maior.push([G.x(d), (escala === 'dias' ? MESES[d.getMonth()] : MES3[d.getMonth()]) + ' ' + d.getFullYear()]);
        }
      }
      if (escala === 'semanas') {
        d = new Date(D[0]); while (d.getDay() !== 1) d = new Date(d.getFullYear(), d.getMonth(), d.getDate() + 1);
        for (; d < D[1]; d = new Date(d.getFullYear(), d.getMonth(), d.getDate() + 7)) menor.push([G.x(d), ('0' + d.getDate()).slice(-2), '']);
      }
      if (escala === 'dias') {
        for (d = new Date(D[0]); d < D[1]; d = new Date(d.getFullYear(), d.getMonth(), d.getDate() + 1)) {
          var fds = d.getDay() === 0 || d.getDay() === 6;
          menor.push([G.x(d), '<b>' + d.getDate() + '</b>' + SEM1[d.getDay()], 'is-dia' + (fds ? ' is-fds' : '')]);
        }
      }
    }
    return { menor: menor, maior: maior, fortes: fortes };
  }
  function desenharTrajetoria() {
    var D = dominio(), h = hoje(), G = geometria(D), R = regua(D, G);
    var velho = painel.querySelector('.nc-lt-gantt'), vw = velho ? velho.clientWidth - rotLargura() : 0;
    /* a data que deve continuar no mesmo lugar depois de redesenhar */
    var alvo = ANCORA;
    if (!alvo && velho && velho.__ppd) alvo = { data: new Date(velho.__d0.getTime() + (velho.scrollLeft + vw / 2) / velho.__ppd * DIA), px: vw / 2 };
    ANCORA = null;
    var vis = FATOS.filter(function (f) { return f.ini; });
    var fino = escala !== 'anos';
    /* a grade: as linhas de mês/ano são elementos; as de dia e semana, um fundo listrado */
    var listra = escala === 'dias' ? G.ppd : escala === 'semanas' ? G.ppd * 7 : 0;
    var desloc = 0;
    if (escala === 'semanas') { var seg = new Date(D[0]); while (seg.getDay() !== 1) seg = new Date(seg.getFullYear(), seg.getMonth(), seg.getDate() + 1); desloc = G.x(seg); }
    /* DESEMPENHO (02/10): a régua, a grade e as listras são desenhadas só numa JANELA em volta
       do que está na tela (três larguras de tela), e redesenhadas quando a rolagem chega perto
       da borda dela. Em Dias, 30 anos de régua eram 11 mil rótulos e 392 mil px de listra —
       a tela travava; agora são ~120 rótulos. As barras continuam todas (são poucas). */
    var hx = G.x(h);
    var conteudoCamada = function (j0, j1) {
      return R.fortes.map(function (l) {
        var x = typeof l === 'number' ? l : l[0], forte = typeof l === 'number' || l[1];
        return x < j0 - 2 || x > j1 + 2 ? '' : '<i class="nc-lt-grade' + (forte ? ' is-forte' : '') + '" style="left:' + (x - j0) + 'px"></i>';
      }).join('') + (hx >= j0 && hx <= j1 ? '<i class="nc-lt-hoje" style="left:' + (hx - j0) + 'px"></i>' : '');
    };
    var conteudoRegua = function (j0, j1) {
      var dentro = function (m) { return m[0] >= j0 - 220 && m[0] <= j1; };
      return R.maior.filter(dentro).map(function (m) { return '<span class="nc-lt-esc-maior" style="left:' + m[0] + 'px">' + esc(m[1]) + '</span>'; }).join('') +
        R.menor.filter(dentro).map(function (m) { return '<span class="nc-lt-esc-menor ' + m[2] + '" style="left:' + m[0] + 'px' + (m[2].indexOf('is-dia') >= 0 ? ';width:' + G.ppd.toFixed(1) + 'px' : '') + '">' + (m[2].indexOf('is-dia') >= 0 ? m[1] : esc(m[1])) + '</span>'; }).join('') +
        '<b class="nc-lt-hoje-rot" style="left:' + hx + 'px">hoje</b>';
    };
    var camada = '<div class="nc-lt-camada" style="' + (listra ? '--passo:' + listra.toFixed(2) + 'px;--desloc:' + desloc + 'px' : '') + '"' + (listra ? ' data-listra' : '') + ' aria-hidden="true"></div>';
    var topo = '<div class="nc-lt-trilho-topo"><span class="nc-lt-faixa-rot" aria-hidden="true"></span><div class="nc-lt-escala' + (R.maior.length ? ' tem-maior' : '') + '" style="width:' + G.w + 'px"></div></div>';
    var EQ = EQUIPE ? linhasEquipe(vis, G, D, fino) : null;
    var linhasHtml = EQ ? EQ.html : faixasDe(vis, G, D, fino, '', true);
    var idx = ESCALAS.map(function (e) { return e[0]; }).indexOf(escala);
    var cab = '<div class="nc-lt-cab">' + (EQ ? ferramentasEquipe(EQ) : '') + '<div class="nc-lt-zoom"><div class="nc-lt-escalas" role="group" aria-label="Escala do gráfico">' +
      '<button type="button" class="nc-lt-zoom-bt" data-passo="-1" aria-label="Afastar (ver mais tempo)" title="Afastar"' + (idx <= 0 ? ' disabled' : '') + '>' + svg(IC.menos) + '</button>' +
      ESCALAS.map(function (z) { return '<button type="button" data-escala="' + z[0] + '" aria-pressed="' + (z[0] === escala) + '">' + esc(z[1]) + '</button>'; }).join('') +
      '<button type="button" class="nc-lt-zoom-bt" data-passo="1" aria-label="Aproximar (ver mais detalhe)" title="Aproximar"' + (idx >= ESCALAS.length - 1 ? ' disabled' : '') + '>' + svg(IC.mais) + '</button></div>' +
      (fino ? '<button type="button" class="nc-lt-hoje-bt" data-ir-hoje>Ir para hoje</button>' : '') + '</div>' +
      '<p class="nc-lt-conta">' + (EQ ? EQ.ids.length + (EQ.ids.length === 1 ? ' colaborador' : ' colaboradores') + (BUSCA ? (EQ.ids.length === 1 ? ' encontrado' : ' encontrados') : '') + ' · ' : '') + (EQ ? EQ.nFatos : vis.length) + ((EQ ? EQ.nFatos : vis.length) === 1 ? ' fato' : ' fatos') + (EQ ? ' · toque no nome para abrir' : '') + ' · passe o mouse para resumir · <kbd>Ctrl</kbd> + roda do mouse aproxima</p>' +
      (AVISO ? '<p class="nc-lt-aviso"' + (AVISO_TOM ? ' data-alerta="' + AVISO_TOM + '"' : '') + '>' + esc(AVISO) + '</p>' : '') + '</div>';
    painel.innerHTML = cab + (vis.length ? '<div class="nc-lt-gantt' + (EQ ? ' is-equipe' : '') + '"><div class="nc-lt-tela" style="width:calc(var(--nc-lt-rot) + ' + G.w + 'px)">' + camada + topo + linhasHtml + '</div></div>' : '<p class="nc-lt-vazio">Nenhum fato.</p>') + '<div class="nc-lt-detalhe" hidden></div>';
    var gantt = painel.querySelector('.nc-lt-gantt');
    if (gantt) {
      gantt.__ppd = G.ppd; gantt.__d0 = D[0];
      var vw2 = gantt.clientWidth - rotLargura();
      if (fino) {
        /* ao sair de Anos (ou abrir já aproximado): o fato tocado; senão o fato MAIS PERTO DE HOJE
           (se tudo é antigo, abrir em hoje mostraria uma tela vazia) */
        var perto = vis.reduce(function (m, f) { return !m || Math.abs(f.ini - h) < Math.abs(m.ini - h) ? f : m; }, null);
        /* em ordem de urgência (Férias): o prazo da PRIMEIRA pessoa da lista — a que está no alto */
        if (EQ && ORDEM === 'urgencia' && EQ.ids.length) {
          var urg = vis.filter(function (f) { return f.quem === EQ.ids[0] && isFinite(f.urgencia); }).sort(function (a, b) { return a.urgencia - b.urgencia; })[0];
          if (urg) perto = urg;
        }
        if (!alvo || !velho || !velho.__fino) alvo = { data: SEL !== null && typeof SEL === 'number' && FATOS[SEL] ? FATOS[SEL].ini : perto ? perto.ini : h, px: vw2 / 2 };
        gantt.scrollLeft = Math.max(0, G.x(alvo.data) - alvo.px);
      }
      gantt.__fino = fino;
      /* a janela da régua e da grade: [j0, j1] em px do trilho */
      var elCamada = gantt.querySelector('.nc-lt-camada'), elEscala = gantt.querySelector('.nc-lt-escala'), J = null;
      var janela = function (forcar) {
        var sl = gantt.scrollLeft, vis = Math.max(320, gantt.clientWidth - rotLargura());
        if (!forcar && J && (sl >= J[0] + vis * 0.25 || J[0] === 0) && (sl + vis <= J[1] - vis * 0.25 || J[1] === G.w)) return;
        var j0 = Math.max(0, Math.floor(sl - vis)), j1 = Math.min(G.w, Math.ceil(sl + 2 * vis));
        J = [j0, j1];
        /* por variável: a folha gerada põe !important em tudo, e um left/width direto no elemento perderia */
        elCamada.style.setProperty('--nc-lt-j0', j0 + 'px');
        elCamada.style.setProperty('--nc-lt-jw', (j1 - j0) + 'px');
        if (listra) elCamada.style.setProperty('--desloc', (desloc - j0) + 'px');
        elCamada.innerHTML = conteudoCamada(j0, j1);
        elEscala.innerHTML = conteudoRegua(j0, j1);
      };
      janela(true);
      gantt.addEventListener('wheel', function (ev) {
        if (!ev.ctrlKey && !ev.metaKey) return;
        ev.preventDefault();
        var r = gantt.getBoundingClientRect(), px = Math.max(0, ev.clientX - r.left - rotLargura());
        ANCORA = { data: new Date(D[0].getTime() + (gantt.scrollLeft + px) / G.ppd * DIA), px: px };
        passo(ev.deltaY < 0 ? 1 : -1);
      }, { passive: false });
      /* primeiro TODAS as medidas, depois as mudanças: ler e escrever alternado faz o navegador
         recalcular a página a cada barra */
      var spans = [].slice.call(painel.querySelectorAll('.nc-lt-b:not(.is-marco) span'));
      var curtas = spans.filter(function (sp) { return sp.scrollWidth > sp.clientWidth + 1 && sp.clientWidth < 72; });
      curtas.forEach(function (sp) { sp.parentNode.classList.add('is-curta'); });
      var quadro = false, acompanhar = function () { quadro = false; janela(false); };
      if (fino) {
        /* o nome da barra longa acompanha a rolagem; as medidas são lidas UMA vez aqui, e a cada
           quadro só se escreve (e só quando o valor muda) */
        var longas = [].filter.call(painel.querySelectorAll('.nc-lt-b:not(.is-marco):not(.is-curta)'), function (b) { return b.offsetWidth > vw2 / 2; })
          .map(function (b) { return { sp: b.firstChild, ini: b.offsetLeft, max: b.offsetWidth - b.firstChild.offsetWidth - 16, d: 0 }; });
        acompanhar = function () {
          quadro = false;
          janela(false);
          var sl = gantt.scrollLeft;
          longas.forEach(function (o) {
            var d = Math.max(0, Math.min(sl - o.ini, o.max));
            if (d !== o.d) { o.d = d; o.sp.style.transform = d ? 'translateX(' + d + 'px)' : ''; }
          });
        };
      }
      gantt.addEventListener('scroll', function () { if (!quadro) { quadro = true; requestAnimationFrame(acompanhar); } }, { passive: true });
      acompanhar();
    }
    if (SEL !== null) mostrarDetalhe(SEL);
  }
  /* as faixas de uma lista de fatos: por assunto (com o título do assunto, na 108) ou só as
     faixas, cada uma com a bolinha da cor do assunto (dentro de cada pessoa, na 121) */
  function faixasDe(lista, G, D, fino, quem, comTitulos) {
    var faixa = function (rot, conteudo, cor) { return '<div class="nc-lt-faixa"' + (cor ? ' style="--cor:' + cor + '"' : '') + '><span class="nc-lt-faixa-rot">' + rot + '</span><div class="nc-lt-trilho" style="width:' + G.w + 'px">' + conteudo + '</div></div>'; };
    var html = '';
    /* Férias: uma faixa por período aquisitivo, com tudo dele dentro — o fundo (aquisitivo e
       período para gozar), as parcelas e o prazo; cada barra com a cor do seu assunto */
    if (lista.some(function (f) { return f.faixaPropria; })) {
      var nomes = [], por = {};
      lista.slice().sort(function (a, b) { return a.ordem - b.ordem; }).forEach(function (f) { if (!por[f.rot]) { por[f.rot] = []; nomes.push(f.rot); } por[f.rot].push(f); });
      var peso = { 'fundo-aq': 0, 'fundo-co': 1, parcela: 2, prazo: 3 };
      nomes.forEach(function (n) {
        var fs = por[n].sort(function (a, b) { return (peso[a.papel] || 0) - (peso[b.papel] || 0); });
        var nota = fs[0] && fs[0].nota;
        html += faixa(esc(n) + (nota ? ' <small>' + esc(nota) + '</small>' : ''), fs.map(function (f) {
          var l = G.x(f.ini), r = G.x(f.ate > D[1] ? D[1] : f.ate), w = Math.max(r - l, 2);
          var cls = f.papel === 'parcela' ? ' is-parcela' : f.papel === 'prazo' ? ' is-marco is-prazo' : ' is-fundo' + (f.papel === 'fundo-co' ? ' is-concessivo' : '');
          var rotulo = f.papel === 'parcela' ? f.titulo : f.papel === 'fundo-aq' ? 'Aquisitivo' : f.papel === 'fundo-co' ? 'Para gozar' : '';
          return '<button type="button" class="nc-lt-b' + cls + (SEL === f.i ? ' is-sel' : '') + '"' + (f.alerta ? ' data-alerta="' + f.alerta + '"' : '') + ' data-i="' + f.i + '" style="left:' + l + 'px;' + (f.papel === 'prazo' ? '' : 'width:' + w + 'px;') + '--cor:' + assuntoDe(f).cor + '" aria-label="' + esc((quem && PESSOAS[quem] ? PESSOAS[quem].rot + ', ' : '') + (f.tag || n) + ': ' + f.titulo) + '"><span>' + esc(rotulo) + '</span></button>';
        }).join(''), 'var(--nc-roxo, #511C76)');
      });
      return html;
    }
    ASSUNTOS.forEach(function (a) {
      var doAssunto = lista.filter(function (f) { return f.assunto === a.id; });
      if (!doAssunto.length) return;
      var linhas = '';
      if (a.id === 'ponto') {
        PONTO.forEach(function (pt) {
          var oc = doAssunto.filter(function (f) { return f.sentido === pt.id; });
          if (!oc.length) return;
          var cel;
          if (fino) {
            cel = oc.map(function (f) {
              return '<button type="button" class="nc-lt-mes is-dia" data-i="' + f.i + '" style="left:' + G.x(f.ini) + 'px;width:' + Math.max(G.ppd, 3).toFixed(1) + 'px;--cor:' + pt.cor + '" aria-label="' + esc(pt.rot + ': ' + f.evento + ', ' + dd(f.ini) + (f.horas ? ', ' + f.horas + ' h' : '')) + '"></button>';
            }).join('');
          } else {
            var meses = {};
            oc.forEach(function (f) { var k = f.ini.getFullYear() + '-' + f.ini.getMonth(); (meses[k] = meses[k] || []).push(f); });
            var max = Math.max.apply(null, Object.keys(meses).map(function (k) { return meses[k].length; }));
            cel = Object.keys(meses).map(function (k) {
              var p = k.split('-'), d0 = new Date(+p[0], +p[1], 1), d1 = new Date(+p[0], +p[1] + 1, 1), n = meses[k].length;
              return '<button type="button" class="nc-lt-mes" data-mes="' + pt.id + '|' + k + (quem ? '|' + esc(quem) : '') + '" style="left:' + G.x(d0) + 'px;width:' + Math.max(G.x(d1) - G.x(d0), 3) + 'px;--int:' + (0.25 + 0.75 * n / max).toFixed(2) + ';--cor:' + pt.cor + '" aria-label="' + esc(pt.rot + ', ' + mesAno(d0) + ': ' + n + (n === 1 ? ' ocorrência' : ' ocorrências')) + '"></button>';
            }).join('');
          }
          linhas += faixa(esc(pt.rot) + ' <small>' + oc.length + '</small>', cel, comTitulos ? '' : pt.cor);
        });
      } else {
        var grupos = [];
        doAssunto.forEach(function (f) { if (grupos.indexOf(f.rot) < 0) grupos.push(f.rot); });
        grupos.forEach(function (g) {
          linhas += faixa(esc(g), doAssunto.filter(function (f) { return f.rot === g; }).map(function (f) {
            var l = G.x(f.ini), r = G.x(f.ate > D[1] ? D[1] : f.ate), w = r - l;
            var marco = f.jeito === 'marco' || w < 8;
            return '<button type="button" class="nc-lt-b' + (marco ? ' is-marco' : '') + (f.atual ? ' is-atual' : '') + (SEL === f.i ? ' is-sel' : '') + '" data-i="' + f.i + '" style="left:' + l + 'px;' + (marco ? '' : 'width:' + w + 'px;') + '" aria-label="' + esc((quem ? PESSOAS[quem].rot + ', ' : '') + g + ': ' + f.titulo + ', ' + dd(f.ini)) + '"><span>' + esc(marco ? '' : f.titulo) + '</span></button>';
          }).join(''), comTitulos ? '' : a.cor);
        });
      }
      html += comTitulos ? '<section class="nc-lt-assunto" style="--cor:' + a.cor + '"><h3 class="nc-lt-assunto-tit"><span>' + esc(a.rot) + '</span></h3>' + linhas + '</section>' : linhas;
    });
    return html;
  }
  function passo(n) {
    var ids = ESCALAS.map(function (e) { return e[0]; }), k = Math.max(0, Math.min(ids.length - 1, ids.indexOf(escala) + n));
    ESCALA_ESCOLHIDA = true;
    if (ids[k] !== escala) { escala = ids[k]; esconderDica(); desenhar(); } else ANCORA = null;
  }
  var redim = null;
  window.addEventListener('resize', function () { if (escala !== 'anos' || modo !== 'trajetoria' || !FATOS) return; clearTimeout(redim); redim = setTimeout(desenhar, 150); });

  /* ═══ [J7] O RESUMO AO PASSAR O MOUSE E OS DETALHES DO FATO TOCADO ═════════════════════════
     O QUE FAZ  • Passar o mouse (ou chegar pelo teclado) numa barra mostra um cartãozinho direto:
                  o assunto, o título, o período com a duração numa linha e o motivo.
                • Tocar mostra, logo abaixo do gráfico, os detalhes completos: o assunto, o título,
                  de quando a quando (e quanto tempo), o motivo e o resto. No ponto, o mês tocado
                  (escala Anos): cada ocorrência com o dia e as horas, e a soma.
     PODE MEXER os textos entre aspas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function periodo(f) {
    if (f.jeito === 'estado') return dd(f.ini) + ' → ' + (f.atual ? 'hoje' : dd(f.ate)) + ' · ' + duracao(f.ini, f.ate);
    return f.ate > f.ini ? dd(f.ini) + ' → ' + dd(f.ate) + ' · ' + duracao(f.ini, f.ate) : dd(f.ini) + ' · ' + SEMANA[f.ini.getDay()];
  }
  /* "1864 - Bruno Cirilo de Morais" no alto do resumo e dos detalhes (só com vários colaboradores) */
  function quemDe(id, cls) { var q = id && PESSOAS[id]; return q ? '<p class="' + cls + '">' + esc(q.rot) + '</p>' : ''; }
  /* as ocorrências do ponto de um mês: "sentido|ano-mês" ou "sentido|ano-mês|pessoa" */
  function ocorrencias(p) {
    var s = p[1].split('-');
    return FATOS.filter(function (f) { return f.jeito === 'ponto' && f.sentido === p[0] && f.ini.getFullYear() === +s[0] && f.ini.getMonth() === +s[1] && (!p[2] || f.quem === p[2]); });
  }
  function assuntoDe(f) { return ASSUNTOS.filter(function (x) { return x.id === f.assunto; })[0] || ASSUNTOS[ASSUNTOS.length - 1]; }
  var dica = el('div', 'nc-lt-dica');
  dica.setAttribute('role', 'tooltip');
  dica.hidden = true;
  document.body.appendChild(dica);
  function textoDica(alvo) {
    if (alvo.hasAttribute('data-i')) {
      var f = FATOS[+alvo.getAttribute('data-i')], fx = f.jeito === 'ponto' ? (PONTO.filter(function (x) { return x.id === f.sentido; })[0] || PONTO[2]) : null;
      var cor = fx ? fx.cor : assuntoDe(f).cor, nome = fx ? 'Ponto · ' + fx.rot : f.tag ? f.tag + ' · ' + f.rot : f.rot;
      var extra = f.jeito === 'ponto' ? [f.horas ? f.horas + ' h' : '', f.extra.length ? f.extra[0][1] : ''].filter(Boolean).join(' · ')
        : [f.motivo, f.extra.length ? f.extra[0][0] + ' ' + f.extra[0][1] : ''].filter(Boolean).join(' · ');
      return quemDe(f.quem, 'nc-lt-dica-quem') + '<p class="nc-lt-dica-ass" style="--cor:' + cor + '">' + esc(nome) + (f.atual ? ' · atual' : '') + '</p><p class="nc-lt-dica-tit">' + esc(f.titulo) + '</p>' +
        '<p class="nc-lt-dica-per">' + esc(periodo(f)) + '</p>' + (extra ? '<p class="nc-lt-dica-mais">' + esc(extra) + '</p>' : '');
    }
    var p = alvo.getAttribute('data-mes').split('|'), s = p[1].split('-'), pt = PONTO.filter(function (x) { return x.id === p[0]; })[0];
    var oc = ocorrencias(p);
    var tot = oc.reduce(function (t, f) { return t + horasMin(f.horas); }, 0);
    return quemDe(p[2], 'nc-lt-dica-quem') + '<p class="nc-lt-dica-ass" style="--cor:' + pt.cor + '">Ponto · ' + esc(pt.rot) + '</p><p class="nc-lt-dica-tit">' + esc(mesAno(new Date(+s[0], +s[1], 1))) + '</p>' +
      '<p class="nc-lt-dica-per">' + oc.length + ' ' + (oc.length === 1 ? pt.um : pt.varios) + (tot ? ' · ' + hhmm(tot) + ' h' : '') + '</p>';
  }
  function mostrarDica(alvo, x, y) {
    dica.innerHTML = textoDica(alvo);
    dica.hidden = false;
    var r = dica.getBoundingClientRect(), W = window.innerWidth, H = window.innerHeight;
    if (x === undefined) { var b = alvo.getBoundingClientRect(); x = Math.min(Math.max(b.left, 8), W - 8); y = b.bottom; }
    var left = Math.min(x + 14, W - r.width - 8), top = y + 18 + r.height > H - 8 ? y - r.height - 12 : y + 18;
    dica.style.left = Math.max(8, left) + 'px';
    dica.style.top = Math.max(8, top) + 'px';
  }
  function esconderDica() { dica.hidden = true; }
  painel.addEventListener('pointermove', function (ev) {
    if (ev.pointerType !== 'mouse') return;
    var alvo = ev.target.closest('[data-i], [data-mes]');
    if (!alvo || !painel.querySelector('.nc-lt-gantt') || !alvo.closest('.nc-lt-gantt')) { esconderDica(); return; }
    mostrarDica(alvo, ev.clientX, ev.clientY);
  });
  painel.addEventListener('pointerleave', esconderDica);
  painel.addEventListener('focusin', function (ev) { var a = ev.target.closest('.nc-lt-gantt [data-i], .nc-lt-gantt [data-mes]'); if (a) mostrarDica(a); });
  painel.addEventListener('focusout', esconderDica);
  window.addEventListener('scroll', esconderDica, true);

  function cardFato(f) {
    var a = assuntoDe(f);
    var quando = f.jeito === 'estado' ? 'Desde ' + dd(f.ini) + (f.atual ? ' · até hoje' : ' até ' + dd(f.ate)) + ' · ' + duracao(f.ini, f.ate)
      : f.ate > f.ini ? dd(f.ini) + ' a ' + dd(f.ate) + ' · ' + duracao(f.ini, f.ate) : dd(f.ini) + ' · ' + SEMANA[f.ini.getDay()];
    return '<div class="nc-lt-det-cab" style="--cor:' + a.cor + '"><span class="nc-lt-det-ass">' + esc(f.tag ? f.tag + ' · ' + f.rot : a.rot + ' · ' + f.rot) + '</span>' +
      '<button type="button" class="nc-lt-det-fechar" aria-label="Fechar os detalhes">' + svg(IC.x) + '</button></div>' +
      quemDe(f.quem, 'nc-lt-det-quem') + '<p class="nc-lt-det-tit">' + esc(f.jeito === 'ponto' ? f.evento : f.titulo) + (f.atual ? ' <em>atual</em>' : '') + '</p>' +
      '<dl class="nc-lt-det-fatos"><div><dt>Quando</dt><dd>' + esc(quando) + '</dd></div>' +
      (f.horas ? '<div><dt>Horas</dt><dd>' + esc(f.horas) + '</dd></div>' : '') +
      (f.motivo ? '<div' + (f.alerta ? ' class="nc-lt-det-alerta" data-alerta="' + f.alerta + '"' : '') + '><dt>' + (f.papel === 'prazo' ? 'Situação' : 'Motivo') + '</dt><dd>' + esc(f.motivo) + '</dd></div>' : '') +
      f.extra.map(function (x) { return '<div><dt>' + esc(x[0]) + '</dt><dd>' + esc(x[1]) + '</dd></div>'; }).join('') + '</dl>';
  }
  function cardMes(id) {
    var p = id.split('|'), s = p[1].split('-'), pt = PONTO.filter(function (x) { return x.id === p[0]; })[0];
    var oc = ocorrencias(p).sort(function (a, b) { return a.ini - b.ini; });
    var tot = oc.reduce(function (t, f) { return t + horasMin(f.horas); }, 0);
    return '<div class="nc-lt-det-cab" style="--cor:' + pt.cor + '"><span class="nc-lt-det-ass">Ponto · ' + esc(pt.rot) + '</span>' +
      '<button type="button" class="nc-lt-det-fechar" aria-label="Fechar os detalhes">' + svg(IC.x) + '</button></div>' +
      quemDe(p[2], 'nc-lt-det-quem') + '<p class="nc-lt-det-tit">' + esc(mesAno(new Date(+s[0], +s[1], 1))) + ': ' + oc.length + (oc.length === 1 ? ' ocorrência' : ' ocorrências') + (tot ? ' · ' + hhmm(tot) + ' h' : '') + '</p>' +
      '<ul class="nc-lt-det-lista">' + oc.map(function (f) { return '<li><b>' + dd(f.ini).slice(0, 5) + '</b><span>' + esc(f.evento) + '</span><span class="nc-lt-num">' + esc(f.horas) + '</span></li>'; }).join('') + '</ul>';
  }
  function mostrarDetalhe(alvo) {
    var box = painel.querySelector('.nc-lt-detalhe');
    if (!box) return;
    var f = typeof alvo === 'number' ? FATOS[alvo] : null;
    if (typeof alvo === 'number' && !f) return;
    box.innerHTML = f ? cardFato(f) : cardMes(alvo);
    box.hidden = false;
    [].forEach.call(painel.querySelectorAll('.is-sel'), function (b) { b.classList.remove('is-sel'); });
    var b = painel.querySelector(typeof alvo === 'number' ? '[data-i="' + alvo + '"]' : '[data-mes="' + alvo + '"]');
    if (b) b.classList.add('is-sel');
  }
  painel.addEventListener('click', function (ev) {
    var z = ev.target.closest('[data-escala]'), ps = ev.target.closest('[data-passo]'), b = ev.target.closest('[data-i]'), m = ev.target.closest('[data-mes]');
    if (z) { ESCALA_ESCOLHIDA = true; if (z.getAttribute('data-escala') !== escala) { escala = z.getAttribute('data-escala'); desenhar(); } return; }
    if (ps) { passo(+ps.getAttribute('data-passo')); return; }
    if (ev.target.closest('[data-ir-hoje]')) { var g = painel.querySelector('.nc-lt-gantt'); if (g && g.__ppd) g.scrollTo({ left: Math.max(0, (hoje() - g.__d0) / DIA * g.__ppd - (g.clientWidth - rotLargura()) / 2), behavior: 'smooth' }); return; }
    if (b) { esconderDica(); SEL = +b.getAttribute('data-i'); mostrarDetalhe(SEL); return; }
    if (m) { esconderDica(); SEL = m.getAttribute('data-mes'); mostrarDetalhe(SEL); return; }
    if (ev.target.closest('.nc-lt-det-fechar')) { SEL = null; var box = painel.querySelector('.nc-lt-detalhe'); if (box) box.hidden = true; [].forEach.call(painel.querySelectorAll('.is-sel'), function (x) { x.classList.remove('is-sel'); }); return; }
    var c = ev.target.closest('[data-filtro]');
    if (c) { var id = c.getAttribute('data-filtro'); FILTRO[id] = !FILTRO[id]; desenhar(); }
  });

  /* ═══ [J8] A CRONOLOGIA ══════════════════════════════════════════════════════════════════
     O QUE FAZ  Os fatos em lista, agrupados por ano (o mais recente em cima). Cada linha: a data,
                o assunto (com a cor), o título e o motivo. O ponto de cada mês vira UMA linha
                ("Ponto · março: 3 faltas e atrasos · 1 hora a mais"), que abre a lista do mês.
                No alto, um botão por assunto liga e desliga aquele assunto na lista.
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_LinhaTempo.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FILTRO = {};
  function desenharCronologia() {
    var itens = [];
    var daBusca = function (f) { return !EQUIPE || achaPessoa(f.quem); };
    FATOS.forEach(function (f) { if (f.ini && f.jeito !== 'ponto' && !/^fundo/.test(f.papel || '') && daBusca(f)) itens.push({ d: f.ini, f: f }); });
    /* o ponto: uma linha por mês (e por pessoa, com vários colaboradores) */
    var meses = {};
    FATOS.forEach(function (f) { if (f.jeito === 'ponto' && f.ini && daBusca(f)) { var k = f.ini.getFullYear() + '-' + ('0' + f.ini.getMonth()).slice(-2) + '|' + f.quem; (meses[k] = meses[k] || []).push(f); } });
    Object.keys(meses).forEach(function (k) { var p = k.split('|')[0].split('-'); itens.push({ d: new Date(+p[0], +p[1] + 1, 0), ponto: meses[k], quem: meses[k][0].quem }); });
    var contagem = {};
    itens.forEach(function (it) { var a = it.f ? it.f.assunto : 'ponto'; contagem[a] = (contagem[a] || 0) + 1; });
    var chips = ASSUNTOS.filter(function (a) { return contagem[a.id]; }).map(function (a) {
      var on = FILTRO[a.id] !== false;
      return '<button type="button" class="nc-lt-chip" data-filtro="' + a.id + '" aria-pressed="' + on + '" style="--cor:' + a.cor + '"><i aria-hidden="true"></i>' + esc(a.rot) + ' <small>' + contagem[a.id] + '</small></button>';
    }).join('');
    itens = itens.filter(function (it) { return FILTRO[it.f ? it.f.assunto : 'ponto'] !== false; }).sort(function (a, b) { return b.d - a.d; });
    var total = itens.length;
    if (EQUIPE) itens = itens.slice(0, LIMITE_ITENS);
    var porAno = {}, anos = [];
    itens.forEach(function (it) { var a = it.d.getFullYear(); if (!porAno[a]) { porAno[a] = []; anos.push(a); } porAno[a].push(it); });
    var corDe = function (id) { var a = ASSUNTOS.filter(function (x) { return x.id === id; })[0]; return a ? a.cor : 'var(--nc-grafite, #4A4460)'; };
    var html = anos.map(function (a) {
      return '<section class="nc-lt-ano"><h3 class="nc-lt-ano-tit">' + a + ' <small>' + porAno[a].length + (porAno[a].length === 1 ? ' fato' : ' fatos') + '</small></h3><ol class="nc-lt-lista">' +
        porAno[a].map(function (it) {
          if (it.f) {
            var f = it.f;
            var quando = f.jeito === 'estado' ? (f.atual ? 'atual · há ' + duracao(f.ini, hoje()) : 'até ' + dd(f.ate)) : f.ate > f.ini ? 'até ' + dd(f.ate) : '';
            if (f.papel === 'parcela') quando = f.extra.filter(function (x) { return x[0] === 'Volta em' || x[0] === 'Pagamento'; }).map(function (x) { return x[0].toLowerCase() + ' ' + x[1].split(' · ')[0]; }).join(' · ');
            return '<li class="nc-lt-item" style="--cor:' + corDe(f.assunto) + '"><span class="nc-lt-data">' + dd(f.ini).slice(0, 5) + '</span>' +
              '<div class="nc-lt-item-txt">' + quemDe(f.quem, 'nc-lt-quem') + '<p class="nc-lt-item-tit"><span class="nc-lt-tag"' + (f.alerta ? ' data-alerta="' + f.alerta + '"' : '') + '>' + esc(f.tag || f.rot) + '</span>' + esc(f.titulo) + '</p>' +
              '<p class="nc-lt-item-sub">' + (f.faixaPropria ? [esc(f.motivo), esc(quando), f.papel === 'parcela' ? 'período ' + esc(f.rot) : ''] : [f.motivo ? 'Motivo: ' + esc(f.motivo) : '', esc(quando)].concat(f.extra.map(function (x) { return esc(x[0] + ': ' + x[1]); }))).filter(Boolean).join(' · ') + '</p></div></li>';
          }
          var oc = it.ponto.sort(function (x, y) { return x.ini - y.ini; });
          var resumo = PONTO.map(function (pt) { var n = oc.filter(function (f) { return f.sentido === pt.id; }); var min = n.reduce(function (t, f) { return t + horasMin(f.horas); }, 0); return n.length ? n.length + ' ' + (n.length === 1 ? pt.um : pt.varios) + (min ? ' (' + hhmm(min) + ' h)' : '') : ''; }).filter(Boolean).join(' · ');
          return '<li class="nc-lt-item is-ponto" style="--cor:' + corDe('ponto') + '"><span class="nc-lt-data">' + MES3[it.d.getMonth()] + '</span>' +
            '<details class="nc-lt-item-txt"><summary>' + quemDe(it.quem, 'nc-lt-quem') + '<p class="nc-lt-item-tit"><span class="nc-lt-tag">Ponto</span>' + esc(MESES[it.d.getMonth()].charAt(0).toUpperCase() + MESES[it.d.getMonth()].slice(1)) + ': ' + oc.length + (oc.length === 1 ? ' ocorrência' : ' ocorrências') + '</p><p class="nc-lt-item-sub">' + esc(resumo) + '</p></summary>' +
            '<ul class="nc-lt-det-lista">' + oc.map(function (f) { return '<li><b>' + dd(f.ini).slice(0, 5) + '</b><span>' + esc(f.evento) + '</span><span class="nc-lt-num">' + esc(f.horas) + '</span></li>'; }).join('') + '</ul></details></li>';
        }).join('') + '</ol></section>';
    }).join('');
    var mais = total > itens.length ? '<div class="nc-lt-mais"><button type="button" data-mais="itens">Mostrar mais ' + Math.min(PASSO_ITENS, total - itens.length) + ' <small>de ' + (total - itens.length) + ' que faltam</small></button></div>' : '';
    var nPessoas = EQUIPE ? Object.keys(PESSOAS).filter(achaPessoa).length : 0;
    painel.innerHTML = '<div class="nc-lt-cab">' + (EQUIPE ? '<div class="nc-lt-equipe-ferr">' + campoBusca() + '<p class="nc-lt-conta">' + nPessoas + (nPessoas === 1 ? ' colaborador' : ' colaboradores') + ' · ' + total + (total === 1 ? ' item' : ' itens') + '</p></div>' : '') +
      '<div class="nc-lt-chips" role="group" aria-label="Assuntos mostrados">' + chips + '</div>' + (AVISO ? '<p class="nc-lt-aviso"' + (AVISO_TOM ? ' data-alerta="' + AVISO_TOM + '"' : '') + '>' + esc(AVISO) + '</p>' : '') + '</div>' +
      (html ? html + mais : '<p class="nc-lt-vazio">' + (BUSCA ? 'Ninguém com “' + esc(BUSCA) + '” no nome ou na matrícula.' : 'Nenhum fato com os assuntos escolhidos.') + '</p>');
  }

  /* ═══ [J8b] VÁRIOS COLABORADORES ═════════════════════════════════════════════════════════
     O QUE FAZ  Na Trajetória, uma linha por pessoa: o nome (código - nome) e, embaixo, o que vem
                em "sub" (centro de custo · situação). No trilho, a linha fina vai do primeiro fato
                até hoje e cada mudança é um tracinho da cor do assunto. Tocar no nome abre as
                faixas da pessoa. Até 8 pessoas, todas já abrem abertas.
                A busca (nome ou matrícula) e a ordem valem para a Trajetória e a Cronologia.
                Para não pesar, aparecem 100 pessoas (ou 300 itens na Cronologia) e um botão
                "Mostrar mais".
     PODE MEXER ORDENS (os textos dos botões), ABRIR_ATE e os limites.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ORDENS = [['nome', 'Nome'], ['fatos', 'Mais fatos'], ['recente', 'Mais recente']];
  /* com prazos (Férias), a ordem por urgência entra no lugar de "Mais fatos" */
  function ordens() { return FATOS && FATOS.some(function (f) { return f.urgencia !== undefined; }) ? [['urgencia', 'Prazo mais perto'], ['nome', 'Nome'], ['recente', 'Mais recente']] : ORDENS; }
  var ABRIR_ATE = 8, PASSO_PESSOAS = 100, PASSO_ITENS = 300;
  var ORDEM_ESCOLHIDA = false;
  var ABERTO = {}, ORDEM = 'nome', BUSCA = '', LIMITE = PASSO_PESSOAS, LIMITE_ITENS = PASSO_ITENS;
  function achaPessoa(id) { var b = sem(BUSCA); return !b || sem(PESSOAS[id] ? PESSOAS[id].rot : '').indexOf(b) >= 0; }
  function pessoasVisiveis(lista) {
    var por = {};
    lista.forEach(function (f) { (por[f.quem] = por[f.quem] || []).push(f); });
    var ult = {};
    var ids = Object.keys(por).filter(achaPessoa);
    ids.forEach(function (id) { ult[id] = por[id].reduce(function (m, f) { return f.ini > m ? f.ini : m; }, 0); });
    var urg = {};
    ids.forEach(function (id) { urg[id] = por[id].reduce(function (m, f) { return f.urgencia !== undefined && f.urgencia < m ? f.urgencia : m; }, Infinity); });
    ids.sort(function (a, c) {
      if (ORDEM === 'urgencia' && urg[a] !== urg[c]) return urg[a] - urg[c];
      if (ORDEM === 'fatos' && por[c].length !== por[a].length) return por[c].length - por[a].length;
      if (ORDEM === 'recente' && ult[c] - ult[a]) return ult[c] - ult[a];
      return (PESSOAS[a] || {}).nome.localeCompare((PESSOAS[c] || {}).nome, 'pt-BR');
    });
    return { ids: ids, por: por };
  }
  function abertoDe(id, total) { return ABERTO[id] !== undefined ? ABERTO[id] : total <= ABRIR_ATE; }
  function linhasEquipe(vis, G, D, fino) {
    var P = pessoasVisiveis(vis), mostrar = P.ids.slice(0, LIMITE), html = '';
    mostrar.forEach(function (id) {
      var p = PESSOAS[id], fs = P.por[id], aberto = abertoDe(id, P.ids.length);
      var ini = fs.reduce(function (m, f) { return f.ini < m ? f.ini : m; }, fs[0].ini);
      var fim = fs.reduce(function (m, f) { return f.ate > m ? f.ate : m; }, fs[0].ate);
      var tiques = aberto ? '' : fs.filter(function (f) { return f.jeito !== 'ponto' && !/^fundo/.test(f.papel || ''); }).map(function (f) {
        return '<i class="nc-lt-tique' + (f.papel === 'prazo' ? ' is-prazo' : '') + (SEL === f.i ? ' is-sel' : '') + '"' + (f.alerta ? ' data-alerta="' + f.alerta + '"' : '') + ' data-i="' + f.i + '" style="left:' + G.x(f.ini) + 'px;--cor:' + assuntoDe(f).cor + '"></i>';
      }).join('');
      /* Férias: o pior prazo da pessoa colore o número dela (vencido / vence logo) */
      var pior = fs.some(function (f) { return f.alerta === 'vencido'; }) ? 'vencido' : fs.some(function (f) { return f.alerta === 'perto'; }) ? 'perto' : '';
      html += '<section class="nc-lt-pessoa' + (aberto ? ' is-aberta' : '') + '">' +
        '<div class="nc-lt-faixa nc-lt-pessoa-cab"><button type="button" class="nc-lt-faixa-rot nc-lt-pessoa-rot" data-pessoa="' + esc(id) + '" aria-expanded="' + aberto + '">' + svg(IC.seta) +
        '<span class="nc-lt-pessoa-txt"><b>' + esc(p.rot) + '</b>' + (p.sub ? '<small>' + esc(p.sub) + '</small>' : '') + '</span>' +
        (pior ? '<small class="nc-lt-pessoa-n" data-alerta="' + pior + '" title="' + (pior === 'vencido' ? 'tem prazo de férias vencido' : 'tem prazo de férias vencendo') + '">' + (pior === 'vencido' ? 'vencido' : 'vence') + '</small>' : '<small class="nc-lt-pessoa-n" title="fatos">' + fs.length + '</small>') + '</button>' +
        '<div class="nc-lt-trilho" style="width:' + G.w + 'px"><i class="nc-lt-vida" style="left:' + G.x(ini) + 'px;width:' + Math.max(2, G.x(fim > D[1] ? D[1] : fim) - G.x(ini)) + 'px"></i>' + tiques + '</div></div>' +
        (aberto ? faixasDe(fs, G, D, fino, id, false) : '') + '</section>';
    });
    if (P.ids.length > mostrar.length) {
      var falta = P.ids.length - mostrar.length;
      html += '<div class="nc-lt-mais"><button type="button" data-mais="pessoas">Mostrar mais ' + Math.min(PASSO_PESSOAS, falta) + ' <small>de ' + falta + ' que faltam</small></button></div>';
    }
    if (!P.ids.length) html += '<p class="nc-lt-vazio nc-lt-mais">Ninguém com “' + esc(BUSCA) + '” no nome ou na matrícula.</p>';
    var nFatos = P.ids.reduce(function (t, id) { return t + P.por[id].length; }, 0);
    return { html: html, ids: P.ids, nFatos: nFatos, todosAbertos: mostrar.length > 0 && mostrar.every(function (id) { return abertoDe(id, P.ids.length); }), mostrar: mostrar };
  }
  function campoBusca() {
    return '<label class="nc-lt-busca">' + svg(IC.lupa) + '<span class="u-VisuallyHidden">Buscar colaborador</span>' +
      '<input type="search" data-busca placeholder="Buscar por nome ou matrícula" value="' + esc(BUSCA) + '" autocomplete="off" spellcheck="false"></label>';
  }
  function ferramentasEquipe(EQ) {
    return '<div class="nc-lt-equipe-ferr">' + campoBusca() +
      '<div class="nc-lt-zoom"><div class="nc-lt-escalas" role="group" aria-label="Ordenar os colaboradores">' +
      ordens().map(function (o) { return '<button type="button" data-ordem="' + o[0] + '" aria-pressed="' + (ORDEM === o[0]) + '">' + esc(o[1]) + '</button>'; }).join('') + '</div>' +
      (EQ.mostrar.length ? '<button type="button" data-todos="' + (EQ.todosAbertos ? 'fechar' : 'abrir') + '">' + (EQ.todosAbertos ? 'Fechar todos' : 'Abrir todos') + '</button>' : '') + '</div></div>';
  }
  /* buscar redesenha sem tirar o cursor da caixa; Enter não envia a página do APEX */
  var tBusca = null;
  painel.addEventListener('input', function (ev) {
    var inp = ev.target.closest('[data-busca]');
    if (!inp) return;
    BUSCA = inp.value; LIMITE = PASSO_PESSOAS; LIMITE_ITENS = PASSO_ITENS;
    clearTimeout(tBusca);
    tBusca = setTimeout(function () {
      var pos = inp.selectionStart;
      desenhar();
      var novo = painel.querySelector('[data-busca]');
      if (novo) { novo.focus(); try { novo.setSelectionRange(pos, pos); } catch (e) { /* ok */ } }
    }, 160);
  });
  painel.addEventListener('keydown', function (ev) { if (ev.key === 'Enter' && ev.target.closest('[data-busca]')) ev.preventDefault(); });
  painel.addEventListener('click', function (ev) {
    var pe = ev.target.closest('[data-pessoa]'), o = ev.target.closest('[data-ordem]'), t = ev.target.closest('[data-todos]'), m = ev.target.closest('[data-mais]');
    if (pe) { var id = pe.getAttribute('data-pessoa'); ABERTO[id] = pe.getAttribute('aria-expanded') !== 'true'; esconderDica(); desenhar(); var volta = painel.querySelector('[data-pessoa="' + id.replace(/"/g, '\\"') + '"]'); if (volta) volta.focus({ preventScroll: true }); return; }
    if (o) { ORDEM = o.getAttribute('data-ordem'); ORDEM_ESCOLHIDA = true; desenhar(); return; }
    if (t) { var abrir = t.getAttribute('data-todos') === 'abrir'; pessoasVisiveis(FATOS.filter(function (f) { return f.ini; })).ids.slice(0, LIMITE).forEach(function (id) { ABERTO[id] = abrir; }); desenhar(); return; }
    if (m) { if (m.getAttribute('data-mais') === 'pessoas') LIMITE += PASSO_PESSOAS; else LIMITE_ITENS += PASSO_ITENS; desenhar(); }
  });

  /* ═══ [J9] O MAESTRO ═════════════════════════════════════════════════════════════════════
     O QUE FAZ  Busca os fatos na primeira vez que a Trajetória ou a Cronologia é aberta (pela
                chamada do plugin) e redesenha. Quando o relatório é atualizado (o filtro
                "Fato" mudou, por exemplo), os fatos são buscados de novo.
     CUIDADO    A busca é a do processo NC_LINHA_TEMPO_DADOS (ou a do plugin, se ele existir).
                Sem nenhum dos dois, aparece "Não foi possível carregar a linha do tempo".
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function carregar() {
    if (FATOS) return $.Deferred().resolve().promise();
    if (CARREGANDO) return CARREGANDO;
    painel.innerHTML = '<p class="nc-lt-vazio">Carregando a linha do tempo…</p>';
    var MF = colunasFerias();
    var pronto = function (evs, aviso, tom) {
      registrarPessoas(evs);
      FATOS = periodos(evs.map(lerFato).filter(function (f) { return f.ini; }));
      FATOS.forEach(function (f, k) { f.i = k; });
      AVISO = aviso || ''; AVISO_TOM = tom || '';
      if (FATOS.some(function (f) { return f.papel; })) {
        /* Férias: o resumo dos prazos no alto, a ordem por urgência e a escala de meses */
        var nV = FATOS.filter(function (f) { return f.alerta === 'vencido'; }).length, nP = FATOS.filter(function (f) { return f.alerta === 'perto'; }).length;
        var prazos = [nV ? nV + (nV === 1 ? ' período com o prazo de férias vencido' : ' períodos com o prazo de férias vencido') : '',
          nP ? nP + (nP === 1 ? ' vence' : ' vencem') + ' em até ' + PERTO + ' dias' : ''].filter(Boolean).join(' · ');
        AVISO = [prazos, AVISO].filter(Boolean).join(' — ');
        AVISO_TOM = nV ? 'vencido' : nP ? 'perto' : '';
        if (!ORDEM_ESCOLHIDA) ORDEM = 'urgencia';   /* Férias abre com quem está mais perto do prazo */
        if (!ESCALA_ESCOLHIDA) escala = 'meses';    /* … e em meses: em anos, um período de 12 meses vira um ponto */
      }
      CARREGANDO = null;
    };
    /* a última saída, na página de Férias sem o processo: as linhas que a Tabela desenhou */
    var daTela = function () {
      var lab = (((IR.querySelector('.a-IRR-pagination-label') || {}).textContent) || '').replace(/\s+/g, ' ').trim();
      pronto(lerFerias(MF), lab ? 'mostrando os registros ' + lab + ' do relatório (para ver mais, aumente "Linhas")' : '');
    };
    var falhou = function () { CARREGANDO = null; painel.innerHTML = '<p class="nc-lt-vazio">Não foi possível carregar a linha do tempo. Use a Tabela.</p>'; };
    var feito = $.Deferred();
    /* 1º o processo da página (NC_LINHA_TEMPO_DADOS); 2º o plugin antigo (TimelineJS), se a página
       ainda tiver; 3º, na de Férias, as linhas da Tabela. O plugin da página de Férias é a linha do
       tempo de outra coisa: lá ele nunca é a fonte. */
    var peloPlugin = function () {
      if (!OPCOES || MF) { if (MF) daTela(); else falhou(); feito.resolve(); return; }
      apex.server.plugin(OPCOES.ajaxIdentifier, { x10: 'DATA', pageItems: OPCOES.pageItems }).then(function (d) {
        pronto((d && d.events) || [], d && d.cortado ? 'Mostrando os primeiros ' + ((d.events || []).length) + ' fatos. Use os filtros para ver os outros.' : '');
        feito.resolve();
      }, function () { falhou(); feito.resolve(); });
    };
    apex.server.process(PROCESSO, { pageItems: document.querySelector(ITENS) ? ITENS : undefined }, { dataType: 'json' }).then(function (d) {
      if (d && d.ferias) {
        pronto(lerFeriasJSON(d.ferias), d.cortado ? 'Mostrando os primeiros ' + d.ferias.length + ' períodos. Use os filtros para ver os outros.' : '');
      } else if (d && d.events) {
        pronto(d.events, d.cortado ? 'Mostrando os primeiros ' + d.events.length + ' fatos. Use os filtros para ver os outros.' : '');
      } else { peloPlugin(); return; }
      feito.resolve();
    }, peloPlugin);
    CARREGANDO = feito.promise();
    return CARREGANDO;
  }
  /* de quem é cada fato (a 121 e a 26 mandam "quem": { id, mat, nome, sub }) */
  function registrarPessoas(evs) {
    PESSOAS = {};
    evs.forEach(function (e) {
      var q = e.quem;
      if (!q || PESSOAS[q.id]) return;
      var nome = bonito(q.nome || '');
      PESSOAS[q.id] = { id: String(q.id), nome: nome, rot: (q.mat ? q.mat + ' - ' : '') + nome, sub: bonito(q.sub || '') };
    });
    EQUIPE = Object.keys(PESSOAS).length > 0;
  }
  function desenhar() {
    if (!FATOS || modo === 'tabela') return;
    try { if (modo === 'trajetoria') desenharTrajetoria(); else desenharCronologia(); }
    catch (e) { if (window.console) console.warn('[Natcorp linha do tempo]', e); }
  }
  $(IR).on('apexafterrefresh', function () { FATOS = null; SEL = null; if (modo !== 'tabela') carregar().then(desenhar); });
  document.body.classList.add('nc-lt');
  trocar(MODOS.some(function (m) { return m[0] === modo; }) ? modo : 'tabela');
  }

  /* COMEÇO: quando o APEX termina de montar a página (e o plugin), roda iniciar(). Se o arquivo
     chegou depois disso (colado à mão no Console, por exemplo), roda já. */
  if (window.apex.gPageContext$ && document.readyState !== 'complete') {
    $(apex.gPageContext$).one('apexreadyend', function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp linha do tempo]', e); } });
  } else {
    $(function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp linha do tempo]', e); } });
  }
})();
