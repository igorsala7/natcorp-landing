/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CONSULTA DE DOCUMENTOS (A PASTA DO COLABORADOR)  —  o "arrumador" (JS)      ║
   ║  App 2210 (CONS_GED_NATCORP) · Página 865 · abre em janela a partir da ficha           ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ──────────────────────────────────────────────────────────────────
   A página é a PASTA do colaborador: os arquivos que o RH guarda de cada pessoa (identidade,
   saúde, formação, contrato, segurança do trabalho, dependentes…). Abre em janela a partir da
   ficha (app 200, página 17) e de outras telas. Este arquivo transforma o relatório numa pasta:
     • o alto — quantos documentos, quantos arquivos, o último envio (e há quanto tempo); a
       busca, "Por assunto" / "Mais recentes" e o "Adicionar documento" (o botão do APEX);
     • as abas de pasta, uma por ASSUNTO, com a contagem — o assunto sai do NOME do documento
       (e do tipo de sub-item: Acidente de Trabalho e EPI vão para Segurança do trabalho,
       Atestados Médicos para Saúde). Tipo que ninguém previu cai em "Outros documentos": o
       cadastro de tipos é grande e cresce, e a tela não depende de conhecê-lo;
     • cada documento é UM cartão, com as versões dentro (Sequência 1, 2…: o mais novo na frente);
     • os documentos dos dependentes, por pessoa;
     • todas as linhas de uma vez: o relatório vem de 50 em 50, e o arquivo pede todas.

   ── O QUE ELE NÃO FAZ ───────────────────────────────────────────────────────────────────────
     • Não grava nem apaga nada. A ESTRUTURA é toda do APEX: o relatório interativo continua na
       página (a um clique, em "Ver tabela completa", com filtros e download).
     • Cada ação dos cartões CLICA no link original da linha: "Ver" abre a visualização
       (GLOBAL_APP_NATCORP:2) e o lápis "Editar" abre o upload (2210:860).
     • Se este arquivo for retirado da página, ela volta ao relatório padrão e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ──────────────────────────────────────────────────────────────────
     App 2210 › Página 865 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Documentos.js
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Documentos.css.
     Este é o arquivo-FONTE (.src.js). O arquivo que sobe (o .js de mesmo nome, em brand/apex/login)
     é gerado a partir dele pelo gerar-*.py da página: edite ESTE arquivo (manual, parte 2).

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ────────────────────────────────────
   Classe posta nas regiões (Page Designer › clique na região › Appearance › CSS Classes):
     nc-ged-docs   as quatro regiões de documentos (Colaborador, Candidato, Terceiro, Outros);
                   o APEX mostra só a do P865_TIPO. Posta por aplicar-documentos-pagina865.py.
   Sem a classe, vale o primeiro relatório interativo da página.
   As COLUNAS do relatório são achadas pelo NOME do cabeçalho (sem acento): Documento (ou Tipo
   Arquivo), Tipo Sub-Item, Sub-Item, Sequencia, Usuario, Data de Atualizacao, Data de Criacao.
   A ficha do alto (foto, nome) é a global da Skin, não deste arquivo.

   ── ÍNDICE: as partes deste arquivo ─────────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Os assuntos da pasta e os ícones ..... qual documento vai em qual aba        PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas; siglas em maiúsculas PODE MEXER
     [J3]  A montagem .......................... o alto, a busca, o Adicionar          PODE MEXER
     [J4]  Ler o relatório e agrupar ........... linhas → documentos com versões        CUIDADO
     [J5]  O desenho ........................... cartões, abas, "Mais recentes"        PODE MEXER
     [J6]  Os cliques e o teclado .............. Ver, Editar, abas, busca, tecla /

   ── RECEITAS RÁPIDAS ────────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'A pasta está vazia'  →  'Nenhum documento ainda'
     Um tipo de documento caiu em "Outros documentos" e devia estar noutra aba
       → [J1]: acrescente uma palavra do nome dele (sem acento, em minúsculas) ao padrão "re"
         do assunto certo. Leia o CUIDADO de [J1] antes.
     Quero mudar o nome de uma aba ("Formação e cursos")  → [J1], o "nome" do assunto
     Uma sigla aparece como "Aso" em vez de "ASO"         → [J2], lista SIGLAS
     A pasta ficou "crua" (só a tabela)
       → abra o Console do navegador (F12 › Console) e veja se há erro. O manual, parte 5,
         explica o que fazer com a mensagem.

   ── LEGENDA DAS MARCAS NOS COMENTÁRIOS ──────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, títulos.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
     (sem marca)  funciona sozinho; só mexa se souber o que está fazendo.

   ── COMO LER UM ARQUIVO JS EM 30 SEGUNDOS ───────────────────────────────────────────────────
     comentário             tudo entre barra-asterisco e asterisco-barra, e o resto da linha
                            depois de duas barras. O navegador ignora: é só para pessoas.
     function nome() { … }  uma "receita" com nome. Ela só roda quando alguém a chama: nome().
     var x = …;             guarda um valor com um nome, para usar depois.
     'texto'  ou  "texto"   um texto. Muitas vezes, é o que aparece na tela.
     /(curso|diploma)/      um "padrão de busca" (expressão regular): procura QUALQUER uma das
                            palavras separadas por | no nome do documento. \b = começo/fim de
                            palavra (\bcpf\b acha "cpf", mas não "cpfx").
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: esta linha impede que o arquivo rode duas vezes (se a URL estiver repetida na
     página, por exemplo) e que rode fora do APEX. Não apague. */
  if (window.__ncGed || !window.apex || !window.apex.jQuery) return;
  window.__ncGed = true;

  var $ = apex.jQuery;

  /* Os ícones de interface (busca, olho, lápis…), no formato SVG. Não precisa mexer. */
  var IC = {
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4 4"/>',
    olho: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="3"/>',
    lapis: '<path d="M4 20h4L19 9a2.8 2.8 0 0 0-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    tabela: '<rect x="3.5" y="4.5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M3.5 14.5h17M9.5 9.5v10"/>',
    pasta: '<path d="M3.5 7.5A1.5 1.5 0 0 1 5 6h4.2l2 2.2H19a1.5 1.5 0 0 1 1.5 1.5v8.8A1.5 1.5 0 0 1 19 20H5a1.5 1.5 0 0 1-1.5-1.5z"/>',
    camadas: '<path d="M12 4l8.5 4.5L12 13 3.5 8.5z"/><path d="M3.5 12.5L12 17l8.5-4.5"/><path d="M3.5 16.5L12 21l8.5-4.5"/>',
    seta: '<path d="M9 6l6 6-6 6"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    familia: '<circle cx="8" cy="7.5" r="3"/><circle cx="16.5" cy="9" r="2.5"/><path d="M2.5 19.5a5.5 5.5 0 0 1 11 0M13 19.5a4 4 0 0 1 8 0"/>',
    portal: '<rect x="3.5" y="4.5" width="17" height="12" rx="2"/><path d="M8.5 20h7M12 16.5V20"/>',
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    calendario: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/>'
  };

  /* ═══ [J1] OS ASSUNTOS DA PASTA E OS ÍCONES ════════════════════════════════════════════════
     O QUE É    ASSUNTOS são as abas da pasta. Cada linha é um assunto:
                  id    o nome interno (não aparece na tela)
                  nome  o nome da aba ('Saúde')
                  tom   a cor da aba e do ícone: roxo, rosa, azul, ambar, verde, ameixa ou cinza
                        (as cores estão no CSS, [C1])
                  re    o padrão de busca: as palavras que, achadas no NOME do documento (sem acento,
                        em minúsculas), mandam ele para esta aba
                OUTROS e DEPENDENTES são as abas fixas. POR_SUBITEM manda pelo tipo de sub-item (2
                acidente e 3 EPI → Segurança; 4 atestado → Saúde), antes de olhar o nome.
                iconeDoc escolhe o DESENHO de cada documento (os mesmos ícones da Skin, --nc-ic-*).
     PODE MEXER • nome e tom de cada assunto;
                • acrescentar uma palavra no "re": ponha |palavra antes do ) final, ex.:
                  (aso|saude|…|cid)  →  (aso|saude|…|cid|odontograma)
                • a ORDEM das linhas.
     CUIDADO    • A ORDEM IMPORTA: o primeiro assunto que achar uma palavra vence ("Termo de entrega
                  de EPI" é Segurança antes de ser Contrato, porque Segurança vem antes).
                • Escreva as palavras SEM acento e em minúsculas: o nome é comparado assim.
                • Não apague as barras / do começo e do fim, nem os parênteses.
                • Os tons novos precisam existir no CSS ([C1]); senão a aba fica sem cor.
     VISUAL     Natcorp_Documentos.css › [C1] (os tons) e [C4] (as abas)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER (leia [J1]): os ASSUNTOS da pasta: o primeiro que casar com o nome vence (a ordem
     importa: "Termo de entrega de EPI" é Segurança antes de ser Contrato). O tom é a cor da aba e
     do ícone. */
  var ASSUNTOS = [
    { id: 'identificacao', nome: 'Identificação', tom: 'roxo',
      re: /(identidade|\brg\b|\bcpf\b|\bcnh\b|habilita|passaporte|\brne\b|crnm|estrangeir|certid|nascimento|casamento|eleitor|reservista|militar|\bctps\b|carteira de trabalho|carteira profissional|\bpis\b|pasep|\bnis\b|\bfoto|conselho|registro profissional|\boab\b|\bcrm\b|\bcrc\b|\bcrea\b|coren)/ },
    { id: 'saude', nome: 'Saúde', tom: 'rosa',
      re: /(\baso\b|saude|\bsus\b|atestado|exame|medic|vacina|laudo|audiometr|clinic|pcmso|odonto|gestant|pre.?natal|\bcid\b)/ },
    { id: 'formacao', nome: 'Formação e cursos', tom: 'azul',
      re: /(instrucao|formacao|escolar|curso|certificad|diploma|historico|graduac|bacharel|licenciat|\bmba\b|pos.?grad|mestrad|doutorad|tecnic|treinament|\bnr.?\d|idioma|curriculo)/ },
    { id: 'seguranca', nome: 'Segurança do trabalho', tom: 'ambar',
      re: /(\bepi\b|acidente|\bcat\b|seguranca|\bppp\b|ltcat|cipa|brigada|ordem de servico)/ },
    { id: 'endereco', nome: 'Endereço e banco', tom: 'verde',
      re: /(residen|endereco|comprovante de (end|resid)|banc|conta salario|conta corrente|\bpix\b)/ },
    { id: 'contrato', nome: 'Contrato e vida funcional', tom: 'ameixa',
      re: /(contrato|admiss|termo|ficha|declarac|acordo|aditivo|opcao|recibo|aviso|demiss|rescis|ferias|holerite|contracheque|advertenc|suspens|promoc|transfer|vale|beneficio|seguro|politica|regulamento|lgpd|autoriza|procurac)/ }
  ];
  var OUTROS = { id: 'outros', nome: 'Outros documentos', tom: 'cinza' };
  var DEPENDENTES = { id: 'dependentes', nome: 'Dependentes', tom: 'rosa' };
  /* tipo de sub-item (P860_TIPO_SUB_ITEM): 0 próprio, 1 dependente, 2 acidente, 3 EPI, 4 atestado */
  var POR_SUBITEM = { '2': 'seguranca', '3': 'seguranca', '4': 'saude' };

  /* o ícone do DOCUMENTO: os mesmos desenhos da Skin (--nc-ic-*), usados na tela de upload */
  function iconeDoc(s, assunto) {
    if (/\bcnh\b|habilita/.test(s)) return 'cnh';
    if (/\bcpf\b/.test(s)) return 'cpf';
    if (/identidade|\brg\b|\brne\b|crnm/.test(s)) return 'rg';
    if (/\bctps\b|carteira de trabalho|carteira profissional/.test(s)) return 'ctps';
    if (/eleitor/.test(s)) return 'titulo';
    if (/\bpis\b|pasep|\bnis\b/.test(s)) return 'pis';
    if (/reservista|militar/.test(s)) return 'reservista';
    if (/certid|nascimento|casamento/.test(s)) return 'certidao';
    if (/passaporte|estrangeir/.test(s)) return 'passaporte';
    if (/conselho|registro profissional|\boab\b|\bcrm\b|\bcrc\b|\bcrea\b|coren/.test(s)) return 'conselho';
    if (/\bfoto/.test(s)) return 'foto';
    if (/vacina/.test(s)) return 'vacina';
    if (/acidente|\bcat\b|laudo|\bppp\b|ltcat/.test(s)) return 'laudo';
    if (/\bepi\b/.test(s)) return 'epi';
    if (/curriculo/.test(s)) return 'curriculo';
    if (/idioma|ingles|espanhol/.test(s)) return 'idioma';
    if (/certificad|curso|treinament|\bnr.?\d/.test(s)) return 'certificado';
    if (/instrucao|formacao|escolar|diploma|graduac|bacharel|licenciat|\bmba\b|pos.?grad|mestrad|doutorad/.test(s)) return 'formacao';
    if (/banc|conta salario|conta corrente|\bpix\b/.test(s)) return 'banco';
    if (/residen|endereco/.test(s)) return 'endereco';
    if (assunto === 'saude') return 'saude';
    if (assunto === 'contrato') return 'contrato';
    return 'doc';
  }

  /* ═══ [J2] FERRAMENTAS ═════════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       semAcento(…)        "Saúde" → "saude" (é assim que os nomes são comparados)
       bonito(…)           "Aso - Atestado De Saúde" → "ASO - Atestado de Saúde" (só na tela)
       haQuanto(data)      "hoje", "ontem", "há 12 dias", "há 5 meses", "há 2 anos"
     PODE MEXER a lista SIGLAS: as palavras que sempre aparecem em MAIÚSCULAS. Para acrescentar uma,
                ponha |sigla antes do ) final, em minúsculas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-ged-svg') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function semAcento(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase(); }
  function vazio(t) { return !t || /^\s*(-|—|0|null)\s*$/i.test(t); }
  function codigo(t) { var m = String(t || '').match(/^\s*(\w+)\s+-\s+/); return m ? m[1] : ''; }
  function semCodigo(t) { return String(t || '').replace(/^\s*\w+\s+-\s+/, '').trim(); }
  function maiusculas(t) { return t.length > 3 && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t); }
  function capitalizar(t) { return String(t || '').toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); }); }
  /* PODE MEXER: siglas sempre em maiúsculas na tela — acrescente com |sigla antes do ) */
  var SIGLAS = /\b(aso|cnh|cpf|rg|sus|ctps|pis|pasep|nis|epi|cat|nr|mba|crm|crc|oab|crea|coren|rne|crnm|pcmso|ppp|ltcat|fgts|inss|irpf|cep|cipa|lgpd|cid|cnpj|ghe)\b/gi;
  /* "Aso - Atestado De Saúde Ocupacional" → "ASO - Atestado de Saúde Ocupacional" (só na tela) */
  function bonito(t) {
    t = String(t || '').replace(/\s+/g, ' ').trim();
    if (maiusculas(t)) t = capitalizar(t);
    t = t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em|Para|Com)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); });
    return t.replace(SIGLAS, function (m) { return m.toUpperCase(); });
  }
  function data(t) { var m = String(t || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  /* "hoje", "ontem", "há 12 dias", "há 5 meses", "há 2 anos" */
  function haQuanto(d) {
    if (!d) return '';
    var hoje = new Date(); hoje.setHours(0, 0, 0, 0);
    var dias = Math.round((hoje - d) / 864e5);
    if (dias <= 0) return 'hoje';
    if (dias === 1) return 'ontem';
    if (dias < 31) return 'há ' + dias + ' dias';
    var meses = (hoje.getFullYear() - d.getFullYear()) * 12 + hoje.getMonth() - d.getMonth() - (hoje.getDate() < d.getDate() ? 1 : 0);
    if (meses < 1) return 'há ' + dias + ' dias';
    if (meses < 12) return meses === 1 ? 'há 1 mês' : 'há ' + meses + ' meses';
    var anos = Math.floor(meses / 12);
    return anos === 1 ? 'há 1 ano' : 'há ' + anos + ' anos';
  }
  function iniciais(nome) { var p = String(nome || '').split(/\s+/).filter(function (w) { return w.length > 2; }); return ((p[0] || '').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  function plural(n, um, varios) { return n + ' ' + (n === 1 ? um : varios); }

  /* ═══ [J3] A MONTAGEM ══════════════════════════════════════════════════════════════════════
     O QUE FAZ  Roda uma vez quando a página abre: põe a marca nc-ged no corpo da página (é dela que o
                visual depende), cria a caixa da pasta (o alto com resumo, busca, "Por assunto" /
                "Mais recentes", as abas, a pasta e o botão "Ver tabela completa") e traz o botão
                "Adicionar" do APEX para o alto (com o nome "Adicionar documento"; o clique dele
                continua o mesmo). Depois pede ao relatório TODAS as linhas de uma vez (o mesmo que
                escolher "Linhas por página" no menu Ações — fica salvo na sessão do relatório).
     PODE MEXER os textos entre aspas: 'Buscar documento, dependente…', 'Por assunto',
                'Mais recentes', 'Abrindo a pasta…', 'Ver tabela completa', 'Adicionar documento'.
     VISUAL     Natcorp_Documentos.css › [C2] e [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var G = null;

  function montar() {
    /* as quatro regiões de documentos (Colaborador, Candidato, Terceiro, Outros) têm nc-ged-docs;
       o APEX mostra só a do P865_TIPO */
    var reg = document.querySelector('.nc-ged-docs') || document.querySelector('.t-IRR-region');
    if (!reg) return;
    document.body.classList.add('nc-ged');
    var foto = document.querySelector('[id$="_FOTO_COLAB_CONTAINER"]');
    /* a região de fora (Colaborador): a foto mora numa sub-região dela */
    var quem = null;
    for (var r = foto && foto.closest('.t-Region'); r; r = r.parentElement && r.parentElement.closest('.t-Region')) quem = r;
    if (quem) quem.classList.add('nc-ged-quem');

    var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
    var caixa = el('div', 'nc-ged-caixa');
    caixa.innerHTML =
      '<div class="nc-ged-topo">' +
        '<div class="nc-ged-resumo" data-slot="resumo" aria-live="polite"></div>' +
        '<div class="nc-ged-ferr">' +
          '<label class="nc-ged-busca">' + svg(IC.busca) + '<span class="u-VisuallyHidden">Buscar documento</span>' +
            '<input type="search" autocomplete="off" spellcheck="false" placeholder="Buscar documento, dependente…"></label>' +
          '<div class="nc-ged-modo" role="group" aria-label="Organizar">' +
            '<button type="button" data-modo="assunto" aria-pressed="true">' + svg(IC.pasta) + '<span>Por assunto</span></button>' +
            '<button type="button" data-modo="recentes" aria-pressed="false">' + svg(IC.relogio) + '<span>Mais recentes</span></button>' +
          '</div>' +
          '<span class="nc-ged-add" data-slot="add"></span>' +
        '</div>' +
      '</div>' +
      '<div class="nc-ged-abas" role="group" aria-label="Filtrar por assunto" data-slot="abas"></div>' +
      '<div class="nc-ged-pasta" data-slot="pasta" aria-live="polite"><p class="nc-ged-carregando">Abrindo a pasta…</p></div>' +
      '<button type="button" class="nc-ged-link nc-ged-tabela-bt">' + svg(IC.tabela) + '<span>Ver tabela completa</span></button>';
    corpo.insertBefore(caixa, corpo.firstChild);
    reg.classList.add('nc-ged-em-cartoes');

    /* o "Adicionar" do APEX vem para o alto (o onclick dele continua o mesmo) */
    var add = [].slice.call(reg.querySelectorAll('button.t-Button, a.t-Button')).filter(function (b) { return /adicionar/i.test(b.textContent); })[0];
    if (add) {
      add.classList.add('nc-ged-add-bt');
      var rot = add.querySelector('.t-Button-label'); if (rot) rot.textContent = 'Adicionar documento';
      caixa.querySelector('[data-slot="add"]').appendChild(add);
    }

    G = { reg: reg, caixa: caixa, filtro: 'todos', modo: 'assunto', q: '', docs: [], abertos: {}, todas: false,
      busca: caixa.querySelector('.nc-ged-busca input') };
    ligar();
    desenhar();
    carregarTodas();
  }

  /* o relatório vem de 50 em 50: se houver próxima página, pede tudo (o mesmo que escolher
     "Linhas por página" no menu Ações) */
  function carregarTodas() {
    if (G.todas) return;
    var prox = G.reg.querySelector('.a-IRR-pagination [data-pagination]');
    if (!prox) return;
    G.todas = true;
    try {
      var ir = G.reg.querySelector('.a-IRR-container');
      var w = $(ir).interactiveReport('instance');
      w.options.currentRowsPerPage = 1000;
      w._search('SEARCH');
    } catch (e) { /* segue com a página que veio */ }
  }

  /* ═══ [J4] LER O RELATÓRIO E AGRUPAR ═══════════════════════════════════════════════════════
     O QUE FAZ  lerLinhas lê cada linha do relatório interativo pelas colunas (achadas pelo NOME do
                cabeçalho, sem acento) e acha os links "Ver" e "Editar" pelo DESTINO do link (a
                página 860 é o upload; o outro link é a visualização). agrupar junta as linhas do
                mesmo tipo e do mesmo dono num documento só, com as versões (Sequência) dentro, a mais
                nova na frente; tira do título a sigla ("ASO - …") e a data entre parênteses.
     CUIDADO    Se uma coluna do relatório for RENOMEADA no APEX, acrescente o nome novo (sem acento,
                em minúsculas) à lista da coluna em lerLinhas, ex.: col(tr, ['documento', 'tipo
                arquivo', 'nome novo']). Sem isso, a coluna fica vazia nos cartões.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function lerLinhas() {
    var tabelas = [].slice.call(G.reg.querySelectorAll('table.a-IRR-table'));
    var ths = {}, linhas = [];
    tabelas.forEach(function (t) {
      [].forEach.call(t.querySelectorAll('th[id]'), function (th) { var k = semAcento(th.textContent.trim()); if (k && !ths[k]) ths[k] = th.id; });
      [].forEach.call(t.querySelectorAll('tr'), function (tr) { if (tr.querySelector('td[headers]')) linhas.push(tr); });
    });
    function col(tr, nomes) {
      for (var i = 0; i < nomes.length; i++) {
        var h = ths[nomes[i]];
        var td = h && tr.querySelector('td[headers="' + h + '"]');
        if (td) return td;
      }
      return null;
    }
    function txt(td) { return td ? td.textContent.replace(/ /g, ' ').replace(/\s+/g, ' ').trim() : ''; }
    return linhas.map(function (tr) {
      /* as ações pelo DESTINO do link, não pela coluna (há duas "Visualizar", e o usuário pode
         esconder uma): a 860 é o upload (editar); a outra é a visualização */
      var links = [].slice.call(tr.querySelectorAll('td a[href]'));
      var editar = links.filter(function (a) { return /:860:/.test(a.getAttribute('href')); })[0] || null;
      var ver = links.filter(function (a) { return a !== editar; })[0] || null;
      return {
        doc: txt(col(tr, ['documento', 'tipo arquivo', 'tipo de arquivo'])),
        tipoSub: txt(col(tr, ['tipo sub-item', 'tipo de sub-item'])),
        sub: txt(col(tr, ['sub-item', 'subitem'])),
        seq: parseInt(txt(col(tr, ['sequencia'])), 10) || 1,
        usuario: txt(col(tr, ['usuario'])),
        atualizado: txt(col(tr, ['data de atualizacao'])),
        criado: txt(col(tr, ['data de criacao'])),
        editar: editar,
        ver: ver
      };
    }).filter(function (l) { return l.doc; }).map(function (l, i) { l.i = i; return l; });
  }

  /* as linhas viram DOCUMENTOS: o mesmo tipo, do mesmo dono, é um documento com versões */
  function agrupar(linhas) {
    var mapa = {}, docs = [];
    linhas.forEach(function (l) {
      var cod = codigo(l.tipoSub) || '0';
      var k = semAcento(l.doc) + '|' + cod + '|' + semAcento(l.sub);
      var d = mapa[k];
      if (!d) {
        var nome = bonito(l.doc);
        if (cod === '1') nome = nome.replace(/\s*\(dependentes?\)\s*/i, ' ').trim();
        var partes = nome.match(/^(.+?)\s+-\s+(.+)$/);
        var titulo = partes ? partes[2] : nome, sigla = partes ? partes[1] : '';
        var dataDoc = titulo.match(/\s*\((\d{2}\/\d{2}\/\d{4})\)\s*$/);
        if (dataDoc) titulo = titulo.slice(0, dataDoc.index).trim();
        var s = semAcento(nome);
        var assunto = POR_SUBITEM[cod] || (ASSUNTOS.filter(function (a) { return a.re.test(s); })[0] || OUTROS).id;
        var dono = cod === '1' ? bonito(semCodigo(l.sub)) || 'Dependente' : '';
        var detalhe = cod !== '0' && cod !== '1' ? bonito(semCodigo(l.tipoSub)) + (vazio(l.sub) ? '' : ' · ' + (semCodigo(l.sub) === l.sub ? 'nº ' + l.sub : bonito(semCodigo(l.sub)))) : '';
        d = mapa[k] = {
          k: k, titulo: titulo, sigla: sigla, dataDoc: dataDoc ? dataDoc[1] : '', cod: cod, dono: dono, detalhe: detalhe,
          assunto: assunto, ic: iconeDoc(s, assunto), versoes: []
        };
        d.busca = semAcento([nome, dono, detalhe, nomeAssunto(assunto)].join(' '));
        docs.push(d);
      }
      d.versoes.push(l);
    });
    docs.forEach(function (d) {
      d.versoes.sort(function (a, b) { return b.seq - a.seq || (data(b.atualizado) || 0) - (data(a.atualizado) || 0); });
      d.atual = d.versoes[0];
      d.quando = data(d.atual.atualizado) || data(d.atual.criado);
    });
    return docs;
  }
  function nomeAssunto(id) {
    if (id === 'dependentes') return DEPENDENTES.nome;
    return (ASSUNTOS.filter(function (a) { return a.id === id; })[0] || OUTROS).nome;
  }
  function tomAssunto(id) {
    if (id === 'dependentes') return DEPENDENTES.tom;
    return (ASSUNTOS.filter(function (a) { return a.id === id; })[0] || OUTROS).tom;
  }
  function enviadoPor(u) {
    if (!u || vazio(u)) return '';
    return /^portal$/i.test(u) ? 'pelo portal' : 'por ' + u;
  }

  /* ═══ [J5] O DESENHO ═══════════════════════════════════════════════════════════════════════
     O QUE FAZ  • cartao(): cada documento — ícone, sigla, título, "Novo" (atualizado há 30 dias ou
                  menos), a data do documento, quando foi atualizado (e há quanto tempo), quem enviou
                  ("pelo portal" ou "por fulano"), Ver / Editar e "2 arquivos" (abre as versões).
                • desenhar(): o resumo do alto, as abas com a contagem, e a pasta "Por assunto" (uma
                  seção por aba; Dependentes por pessoa) ou "Mais recentes" (por mês). Sem documentos:
                  "A pasta está vazia". Busca sem resultado: "Nada encontrado".
     PODE MEXER os textos entre aspas: 'Novo', 'Data do documento:', 'Enviado ', 'Mais recentes',
                'A pasta está vazia', 'Nada encontrado', 'Limpar a busca'…
                O 30 de "Novo" (dias) também pode mudar: procure  <= 30.
     VISUAL     Natcorp_Documentos.css › [C4] (abas), [C5] (cartões), [C6] (dependentes), [C7] (vazio)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function iconeHtml(d, tom) {
    return '<span class="nc-ged-ic nc-ged-tom--' + tom + '" aria-hidden="true"><i style="--nc-ic: var(--nc-ic-' + d.ic + ', var(--nc-ic-doc))"></i></span>';
  }
  function acoes(v, rotulo) {
    return '<span class="nc-ged-acoes">' +
      (v.ver ? '<button type="button" class="nc-ged-ver" data-ver="' + v.i + '" aria-label="Ver ' + esc(rotulo) + '">' + svg(IC.olho) + '<span>Ver</span></button>' : '') +
      (v.editar ? '<button type="button" class="nc-ged-editar" data-editar="' + v.i + '" aria-label="Editar ' + esc(rotulo) + '" title="Editar">' + svg(IC.lapis) + '</button>' : '') +
    '</span>';
  }
  function cartao(d, comAssunto) {
    var v = d.atual, n = d.versoes.length;
    var aberto = !!G.abertos[d.k];
    var rotulo = d.titulo + (d.dono ? ' de ' + d.dono : '');
    var meta = [];
    if (d.quando) meta.push('<span class="nc-ged-quando" title="Atualizado em ' + esc(v.atualizado) + (v.criado && v.criado !== v.atualizado ? ' · criado em ' + esc(v.criado) : '') + '">' + svg(IC.relogio) + '<b>' + esc(v.atualizado || v.criado) + '</b><em>' + esc(haQuanto(d.quando)) + '</em></span>');
    var por = enviadoPor(v.usuario);
    if (por) meta.push('<span class="nc-ged-por' + (/portal/.test(por) ? ' is-portal' : '') + '">' + svg(/portal/.test(por) ? IC.portal : IC.pessoa) + esc('Enviado ' + por) + '</span>');
    var novo = d.quando && (new Date() - d.quando) / 864e5 <= 30;
    return '<article class="nc-ged-doc' + (aberto ? ' is-aberto' : '') + '" data-k="' + esc(d.k) + '">' +
      iconeHtml(d, tomAssunto(d.assunto)) +
      '<div class="nc-ged-doc-txt">' +
        (comAssunto || d.sigla || d.detalhe ? '<p class="nc-ged-sigla">' +
          (comAssunto ? '<span class="nc-ged-doc-assunto nc-ged-tom--' + tomAssunto(d.cod === '1' ? 'dependentes' : d.assunto) + '">' + esc(d.dono ? 'Dependente · ' + d.dono : nomeAssunto(d.assunto)) + '</span>' : '') +
          esc([d.sigla, d.detalhe].filter(Boolean).join(' · ')) + '</p>' : '') +
        '<h4>' + esc(d.titulo) + (novo ? '<span class="nc-ged-novo">Novo</span>' : '') + '</h4>' +
        (d.dataDoc ? '<p class="nc-ged-datadoc">' + svg(IC.calendario) + 'Data do documento: ' + esc(d.dataDoc) + '</p>' : '') +
        '<div class="nc-ged-meta">' + meta.join('') + '</div>' +
      '</div>' +
      '<div class="nc-ged-doc-fim">' + acoes(v, rotulo) +
        (n > 1 ? '<button type="button" class="nc-ged-versoes-bt" data-versoes aria-expanded="' + aberto + '">' + svg(IC.camadas) + plural(n, 'arquivo', 'arquivos') + svg(IC.seta, 'nc-ged-svg nc-ged-seta') + '</button>' : '') +
      '</div>' +
      (n > 1 ? '<ol class="nc-ged-versoes">' + d.versoes.map(function (x, j) {
        return '<li><span class="nc-ged-v-txt"><b>' + (j === 0 ? 'Mais recente' : 'Arquivo ' + x.seq) + '</b>' +
          '<span>' + esc(x.atualizado || x.criado) + (enviadoPor(x.usuario) ? ' · enviado ' + esc(enviadoPor(x.usuario)) : '') + '</span></span>' +
          acoes(x, rotulo + ', arquivo ' + x.seq) + '</li>';
      }).join('') + '</ol>' : '') +
    '</article>';
  }

  function desenhar() {
    if (!G) return;
    var docs = G.docs = agrupar(lerLinhas());
    var pasta = G.caixa.querySelector('[data-slot="pasta"]');
    var arquivos = docs.reduce(function (s, d) { return s + d.versoes.length; }, 0);
    var ultimo = docs.reduce(function (m, d) { return d.quando && (!m || d.quando > m.quando) ? d : m; }, null);

    G.caixa.querySelector('[data-slot="resumo"]').innerHTML = docs.length
      ? '<b>' + docs.length + '</b><span class="nc-ged-resumo-txt">' + (docs.length === 1 ? 'documento' : 'documentos') +
          (arquivos !== docs.length ? '<em>' + plural(arquivos, 'arquivo', 'arquivos') + '</em>' : '') + '</span>' +
        (ultimo ? '<span class="nc-ged-ultimo">Último envio<b>' + esc(ultimo.atual.atualizado || ultimo.atual.criado) + '</b><em>' + esc(haQuanto(ultimo.quando)) + '</em></span>' : '')
      : '';

    /* os assuntos presentes, na ordem da pasta; dependentes por último */
    var ordem = ASSUNTOS.map(function (a) { return a.id; }).concat(['outros']);
    var porAssunto = {};
    docs.forEach(function (d) { var a = d.cod === '1' ? 'dependentes' : d.assunto; (porAssunto[a] = porAssunto[a] || []).push(d); });
    var presentes = ordem.filter(function (a) { return porAssunto[a]; });
    if (porAssunto.dependentes) presentes.push('dependentes');
    if (G.filtro !== 'todos' && !porAssunto[G.filtro]) G.filtro = 'todos';

    var q = semAcento(G.q.trim());
    function passa(d) { return !q || d.busca.indexOf(q) >= 0; }
    function contaVisiveis(lista) { return lista.filter(passa).length; }

    G.caixa.querySelector('[data-slot="abas"]').innerHTML = docs.length ?
      '<button type="button" data-filtro="todos" aria-pressed="' + (G.filtro === 'todos') + '"><span>Todos</span><em>' + contaVisiveis(docs) + '</em></button>' +
      presentes.map(function (a) {
        return '<button type="button" data-filtro="' + a + '" class="nc-ged-tom--' + tomAssunto(a) + '" aria-pressed="' + (G.filtro === a) + '"><i aria-hidden="true"></i><span>' + esc(nomeAssunto(a)) + '</span><em>' + contaVisiveis(porAssunto[a]) + '</em></button>';
      }).join('') : '';
    G.caixa.classList.toggle('is-vazia', !docs.length);

    if (!docs.length) {
      pasta.innerHTML = '<div class="nc-ged-vazio">' + svg(IC.pasta, 'nc-ged-vazio-ic') + '<h3>A pasta está vazia</h3><p>Nenhum documento foi anexado para esta pessoa ainda. Use <b>Adicionar documento</b> para enviar o primeiro.</p></div>';
      return;
    }

    var html = '';
    if (G.modo === 'recentes') {
      var lista = docs.filter(function (d) { return (G.filtro === 'todos' || (d.cod === '1' ? 'dependentes' : d.assunto) === G.filtro) && passa(d); })
        .sort(function (a, b) { return (b.quando || 0) - (a.quando || 0); });
      var mes = null;
      lista.forEach(function (d) {
        var m = d.quando ? MESES[d.quando.getMonth()] + ' de ' + d.quando.getFullYear() : 'Sem data';
        if (m !== mes) { if (mes !== null) html += '</div></section>'; mes = m; html += '<section class="nc-ged-sec nc-ged-mes"><h3 class="nc-ged-sec-cab"><span>' + esc(m.charAt(0).toUpperCase() + m.slice(1)) + '</span></h3><div class="nc-ged-lista">'; }
        html += cartao(d, true);
      });
      if (mes !== null) html += '</div></section>';
    } else {
      presentes.forEach(function (a) {
        if (G.filtro !== 'todos' && G.filtro !== a) return;
        var lista = porAssunto[a].filter(passa);
        if (!lista.length) return;
        var tom = tomAssunto(a);
        html += '<section class="nc-ged-sec nc-ged-tom--' + tom + '"><h3 class="nc-ged-sec-cab"><i aria-hidden="true"></i><span>' + esc(nomeAssunto(a)) + '</span><em>' + lista.length + '</em></h3>';
        if (a === 'dependentes') {
          var pessoas = {}, nomes = [];
          lista.forEach(function (d) { if (!pessoas[d.dono]) { pessoas[d.dono] = []; nomes.push(d.dono); } pessoas[d.dono].push(d); });
          html += '<div class="nc-ged-pessoas">' + nomes.map(function (p) {
            return '<div class="nc-ged-pessoa"><header><span class="nc-ged-avatar" aria-hidden="true">' + esc(iniciais(p)) + '</span><div><h4>' + esc(p) + '</h4><p>' + plural(pessoas[p].length, 'documento', 'documentos') + '</p></div></header>' +
              '<div class="nc-ged-lista nc-ged-lista--dep">' + pessoas[p].sort(function (x, y) { return x.titulo.localeCompare(y.titulo, 'pt'); }).map(function (d) { return cartao(d); }).join('') + '</div></div>';
          }).join('') + '</div>';
        } else {
          html += '<div class="nc-ged-lista">' + lista.sort(function (x, y) { return x.titulo.localeCompare(y.titulo, 'pt'); }).map(function (d) { return cartao(d); }).join('') + '</div>';
        }
        html += '</section>';
      });
    }
    pasta.innerHTML = html || '<div class="nc-ged-vazio nc-ged-vazio--busca">' + svg(IC.busca, 'nc-ged-vazio-ic') + '<h3>Nada encontrado</h3><p>Nenhum documento com “' + esc(G.q.trim()) + '”' + (G.filtro !== 'todos' ? ' em ' + esc(nomeAssunto(G.filtro)) : '') + '.</p><button type="button" class="nc-ged-link" data-limpar>Limpar a busca</button></div>';
  }

  /* ═══ [J6] OS CLIQUES E O TECLADO ══════════════════════════════════════════════════════════
     O QUE FAZ  Liga os cliques da pasta: "Ver" e "Editar" clicam o link original da linha; as abas
                filtram; "Por assunto" / "Mais recentes" trocam a organização; "2 arquivos" abre as
                versões; "Ver tabela completa" mostra o relatório original. A busca filtra enquanto se
                digita; Esc limpa; a tecla / (barra) leva à busca. Quando o relatório é refeito (upload
                novo, filtro na tabela), os cartões são refeitos.
                As duas últimas linhas do arquivo mandam montar tudo quando a página termina de abrir.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function linha(i) { return lerLinhas()[+i]; }
  function ligar() {
    G.caixa.addEventListener('click', function (e) {
      var b;
      if ((b = e.target.closest('[data-ver]'))) { var l = linha(b.getAttribute('data-ver')); if (l && l.ver) l.ver.click(); return; }
      if ((b = e.target.closest('[data-editar]'))) { var m = linha(b.getAttribute('data-editar')); if (m && m.editar) m.editar.click(); return; }
      if ((b = e.target.closest('[data-filtro]'))) { G.filtro = b.getAttribute('data-filtro'); desenhar(); return; }
      if ((b = e.target.closest('[data-modo]'))) {
        G.modo = b.getAttribute('data-modo');
        [].forEach.call(G.caixa.querySelectorAll('[data-modo]'), function (x) { x.setAttribute('aria-pressed', String(x === b)); });
        desenhar(); return;
      }
      if ((b = e.target.closest('[data-versoes]'))) {
        var card = b.closest('.nc-ged-doc'), k = card.getAttribute('data-k');
        G.abertos[k] = !G.abertos[k];
        card.classList.toggle('is-aberto', G.abertos[k]);
        b.setAttribute('aria-expanded', String(G.abertos[k]));
        return;
      }
      if (e.target.closest('[data-limpar]')) { G.busca.value = ''; G.q = ''; desenhar(); G.busca.focus(); return; }
      if (e.target.closest('.nc-ged-tabela-bt')) {
        var tabela = G.reg.classList.toggle('nc-ged-em-cartoes') === false;
        G.caixa.querySelector('.nc-ged-tabela-bt span').textContent = tabela ? 'Ver em cartões' : 'Ver tabela completa';
        G.caixa.classList.toggle('is-tabela', tabela);
      }
    });
    var t = 0;
    G.busca.addEventListener('input', function () { clearTimeout(t); t = setTimeout(function () { G.q = G.busca.value; desenhar(); }, 90); });
    G.busca.addEventListener('keydown', function (e) { if (e.key === 'Escape' && G.busca.value) { e.preventDefault(); e.stopPropagation(); G.busca.value = ''; G.q = ''; desenhar(); } });
    document.addEventListener('keydown', function (e) {
      if (e.key !== '/' || e.ctrlKey || e.metaKey || e.altKey) return;
      var a = document.activeElement;
      if (a && (/^(INPUT|TEXTAREA|SELECT)$/.test(a.tagName) || a.isContentEditable)) return;
      e.preventDefault(); G.busca.focus(); G.busca.select();
    });
    /* o relatório refeito (upload novo, filtro na tabela, página): os cartões são refeitos */
    $(G.reg).on('apexafterrefresh', function () { setTimeout(function () { desenhar(); carregarTodas(); }, 30); });
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(montar); });
  else $(montar);
})();
