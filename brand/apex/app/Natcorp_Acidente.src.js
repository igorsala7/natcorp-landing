/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · COMUNICAÇÃO DE ACIDENTE/INCIDENTE  —  o "arrumador" das telas (JavaScript)    ║
   ║  App 2943 (SEG_CTRL_NATCORP) · páginas 91, 92 e 31                                        ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Um arquivo só, para TRÊS telas. Quando a página abre, ele descobre qual delas é e
   REORGANIZA o que o APEX já desenhou:

   1) Página 91 — "Criar/Editar: Comunicação de Acidente/Incidente" (quem COMUNICA: o gestor ou
      o próprio colaborador, muita gente com pouca prática com sistemas, também no celular).
      A página vira 6 passos, na ordem em que se conta um acidente:
        1 Quem se acidentou   2 Quando aconteceu   3 Onde aconteceu
        4 Que parte do corpo foi atingida (a lista + Adicionar, e uma figura do corpo)
        5 O que aconteceu (o relato)   6 Atendimento e registros (médico, B.O., óbito)
      Cada passo diz "Pronto" ou "Falta N campos"; o rodapé gruda no pé da tela, diz o que
      falta e o botão "Criar Requisição" aparece como "Enviar comunicação". No fim da criação,
      "Confira antes de enviar" mostra a ficha exatamente como quem analisa vai ver.
      Na comunicação já gravada: cabeçalho (nº, aberta em/por, situação), o botão
      "Caracterização CAT" no alto, a FICHA do acidente e a Aprovação no fim.
   2) Página 92 — a janela "Parte do Corpo Atingida" (aberta pelo Adicionar): o lado vira
      quatro botões grandes e a figura marca a parte enquanto a pessoa escolhe.
   3) Página 31 — a ANÁLISE (Médico do Trabalho / Técnico de Segurança): as 13 abas viram 4
      "frentes" (Atendimento médico, Classificação da CAT, Acidente e local, Investigação), com
      o caso fixo à esquerda e uma barra no pé com o que falta e o Salvar (também Ctrl+S).

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: isso continua sendo do APEX.
     • Nunca reescreve o VALOR de um item que vai no envio: muda só rótulos, ajudas, textos de
       exibição e a ordem de leitura. Listas trocadas por botões continuam existindo
       (escondidas) e são elas que vão no envio e disparam as ações dinâmicas.
     • O que o perfil da página esconde (abas de segurança, fatores para a área médica)
       continua escondido.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Páginas 91, 92 e 31 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Acidente.js
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Acidente.css
     (que também precisa estar nas três páginas, em CSS › File URLs).

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   NENHUMA classe precisa ser posta no APEX. O arquivo reconhece a página pelos ITENS:
     página 91   tem …_ESPEC_LOCAL_ACIDENTE e …_DESCRICAO_TEXTO
     página 92   tem …_COD_PARTE_LESADA e …_LATERALIDADE
     página 31   tem os itens da 91 e mais …_COD_MED_EMIT_CAT_1 e …_DIAGNO_PROVAVEL
   O começo do nome dos itens (P91_, P92_, P31_) é descoberto sozinho. Sem esses itens, o
   arquivo não faz nada. Os itens e as regiões usados estão listados em cada parte abaixo
   (PASSOS em [J2], FRENTES em [J12]) e as regiões são achadas pelo Static ID: PARTE_CORPO,
   FREQUENCIA, STATIC_APROV, ANALISE, PARTE, ACIDENTE, AVALIADOR, SERVICO, COLABORADOR,
   DIAGRAMA, CONSEQUENCIA, TESTEMUNHA, TERCEIROS, EPI, CUSTO, PLANO, CONCLUSAO.
   CUIDADO: renomear um desses itens ou Static IDs no APEX faz a parte correspondente sumir.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
   Tela de COMUNICAÇÃO (p91):
     [J1]  Reconhecer a página ............... qual das três telas é esta            CUIDADO
     [J2]  Configuração da comunicação ....... os 6 passos, rótulos, ajudas, exemplos PODE MEXER
     [J3]  Ferramentas ....................... funções pequenas usadas no arquivo todo
     [J4]  Os 6 passos ....................... monta os passos, o cartão da pessoa, as escolhas
     [J5]  O cabeçalho da comunicação gravada  nº, aberta em/por, situação, Caracterização CAT
     [J6]  A parte do corpo e a figura ........ a lista, o Adicionar, os pontos na figura
     [J7]  A ficha do acidente ............... "Confira antes de enviar" e o resumo  PODE MEXER
     [J8]  A aprovação ....................... a lista de quem aprovou, no fim da página
     [J9]  O rodapé .......................... o que falta + "Enviar comunicação"
     [J10] Atalhos de data e roteiro do relato  "Hoje", "Ontem", "Me ajude a contar"  PODE MEXER
     [J11] O maestro da comunicação .......... recalcula tudo a cada mudança        CUIDADO
   Tela de ANÁLISE (p31):
     [J12] Configuração da análise ........... as 4 frentes, rótulos, nomes de regiões PODE MEXER
     [J13] Montar a análise .................. frentes, barra do pé, Salvar, troca de frente
     [J14] Listas curtas viram botões ........ e o cabeçalho do caso
     [J15] O maestro da análise .............. o que falta, o afastamento, o caso à esquerda
     [J16] Regiões inteiras e grades ......... títulos, "Adicionar …", "Salvar lista"
     [J17] O índice da Investigação .......... "N de M preenchidas"
     [J18] O que só aparece quando faz sentido  B.O. e afastamento; caixas que crescem
     [J20] As listas em cartões .............. partes, EPIs, custos (gaveta) e testemunhas PODE MEXER
   JANELA da parte do corpo (p92):
     [J19] A janela "Parte do Corpo Atingida"  o lado em botões e a figura           PODE MEXER

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Quem se acidentou?'  →  'Quem se machucou?'
     Quero mudar o rótulo, a ajuda ou o exemplo de um campo
       → comunicação (p91): lista ROTULOS em [J2];  análise (p31): ROTULOS_ANALISE em [J12];
         janela (p92): ROTULOS dentro de [J19]. Cada linha é  NOME_DO_ITEM: ['rótulo',
         'ajuda embaixo do rótulo', 'exemplo dentro da caixa vazia'].
     Criei um campo novo na página 91 e ele não entrou em nenhum passo
       → ele fica na região original, abaixo dos passos. Para pô-lo num passo, acrescente o
         nome dele (SEM o "P91_") na lista  itens  do passo certo, em PASSOS ([J2]).
     Criei um campo novo na página 31 e ele não entrou em nenhuma frente
       → acrescente  ['NOME_DO_ITEM', 2]  na lista  itens  do bloco certo, em FRENTES ([J12]).
         O número é a largura: 1 = um quarto da linha, 2 = meia linha, 4 = linha inteira.
     Quero que um campo entre (ou saia) do "Falta"
       → mude "Value Required" do item no Page Designer. O nome curto que aparece no rodapé
         da p91 vem da lista CURTOS ([J2]).
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e veja se há erro em vermelho.
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
     P + 'DESCRICAO_TEXTO'  junta os textos: vira 'P91_DESCRICAO_TEXTO', o nome do item no APEX.
     val('ITEM') / txt('ITEM')  leem o que está num item do APEX (veja [J3]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* ═══ [J1] RECONHECER A PÁGINA ══════════════════════════════════════════════════════════
     O QUE FAZ  Descobre em qual das três telas o arquivo está, pelos itens que existem nela,
                e guarda isso em MODO:
                  'comunicacao' → página 91     'parte' → janela 92     'analise' → página 31
                Também descobre o começo do nome dos itens (P91_, P92_, P31_) e guarda em P.
     COMO       Procura os itens pelo FIM do nome (…_ESPEC_LOCAL_ACIDENTE, …_COD_PARTE_LESADA,
                …_COD_MED_EMIT_CAT_1). Por isso funciona mesmo que a página mude de número.
     CUIDADO    Não apague nem renomeie esses itens no APEX: sem eles o arquivo não reconhece a
                página e não desenha nada. A primeira linha abaixo impede que o arquivo rode
                duas vezes (URL repetida na página) ou fora do APEX: não apague.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncAcidente || !window.apex || !window.apex.jQuery) return;
  var MODO = 'comunicacao';
  var achado = document.querySelector('[id$="_ESPEC_LOCAL_ACIDENTE_CONTAINER"]');
  if (!achado || !document.querySelector('[id$="_DESCRICAO_TEXTO_CONTAINER"]')) {
    achado = document.querySelector('[id$="_COD_PARTE_LESADA_CONTAINER"]');
    if (!achado || !document.querySelector('[id$="_LATERALIDADE_CONTAINER"]')) return;   /* sem os itens, nada a desenhar */
    MODO = 'parte';
  }
  var P = achado.id.replace(/(ESPEC_LOCAL_ACIDENTE|COD_PARTE_LESADA)_CONTAINER$/, '');
  /* a página de análise (Médico do Trabalho / Técnico de Segurança) tem os mesmos itens do acidente
     e mais o atendimento médico: é outro desenho */
  /* (a 91 é cópia da 31 e traz o Diagnóstico numa região que nunca aparece: o que só a análise tem
     é o "Médico que atendeu") */
  if (MODO === 'comunicacao' && document.getElementById(P + 'COD_MED_EMIT_CAT_1_CONTAINER') && document.getElementById(P + 'DIAGNO_PROVAVEL_CONTAINER')) MODO = 'analise';
  window.__ncAcidente = true;

  var $ = apex.jQuery;

  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    tempo: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    local: '<path d="M12 21s-6.5-5.6-6.5-11a6.5 6.5 0 0 1 13 0c0 5.4-6.5 11-6.5 11z"/><circle cx="12" cy="10" r="2.4"/>',
    corpo: '<circle cx="12" cy="4.8" r="2.3"/><path d="M12 7.6v6.9M6.5 9.4l5.5 1.6 5.5-1.6M8.8 21l3.2-6.5 3.2 6.5"/>',
    relato: '<path d="M4 5.5h16v10.5H9.5L5 20v-4H4z"/><path d="M8.5 9.5h7M8.5 12.5h4.5"/>',
    cruz: '<rect x="3.5" y="3.5" width="17" height="17" rx="4.5"/><path d="M12 8v8M8 12h8"/>',
    predio: '<rect x="4.5" y="3.5" width="11" height="17" rx="1.5"/><path d="M15.5 9.5h4v11h-4M8 7.5h1M11.5 7.5h1M8 11h1M11.5 11h1M8 14.5h1M11.5 14.5h1M9 20.5v-3h2.5v3"/>',
    rota: '<circle cx="6" cy="18" r="2.2"/><circle cx="18" cy="6" r="2.2"/><path d="M8.2 18H15a3 3 0 0 0 0-6H9a3 3 0 0 1 0-6h6.8"/>',
    ficha: '<rect x="5" y="4.5" width="14" height="16.5" rx="2"/><path d="M9 4.5v-1h6v1M8 13h2.2l1.3-2.8 1.9 5.3 1.3-2.5H16"/>',
    mais: '<path d="M12 5.5v13M5.5 12h13"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5M12 8v.01"/>',
    alerta: '<path d="M12 3.5l9 16H3z"/><path d="M12 10v4M12 17v.01"/>',
    enviar: '<path d="M4 12l16-8-6 16-3-7z"/><path d="M11 13l9-9"/>',
    aprovacao: '<circle cx="9" cy="8" r="3.2"/><path d="M3 19.5a6 6 0 0 1 11.2-3"/><path d="M14.5 16.5l2.2 2.2 4.3-4.6"/>',
    x: '<path d="M7 7l10 10M17 7L7 17"/>',
    espera: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>'
  };

  /* ═══ [J2] CONFIGURAÇÃO DA COMUNICAÇÃO (página 91) ══════════════════════════════════════════
     O QUE É    As listas que dizem COMO a página 91 é organizada. Mudar aqui muda a tela sem
                mexer no resto do arquivo.
     PODE MEXER • PASSOS: os 6 passos, na ordem em que aparecem. Em cada passo:
                    titulo / sub   o título e a frase de explicação do passo
                    itens          os campos do passo, na ordem (nome do item SEM o "P91_")
                    pessoa         (passo 1) os campos que viram o cartão da pessoa
                    endereco       (passo 3) os campos do endereço, que vêm do cadastro
                    regioes        (passo 2) regiões inteiras postas no passo (Static ID)
                    ic             o ícone do passo (um dos nomes da lista IC acima)
                • ROTULOS: o texto na tela de cada campo. Cada linha é
                    NOME_DO_ITEM: ['rótulo', 'ajuda embaixo do rótulo', 'exemplo na caixa vazia']
                  (a ajuda e o exemplo são opcionais). Só o texto muda; o item é o mesmo.
                • CURTOS: o nome curto de cada campo no "Falta" do rodapé.
                • ROTEIRO: o texto que o botão "Me ajude a contar" escreve no relato.
                • OPCOES: as duas escolhas grandes de "Onde a pessoa estava?" (N = no
                  trabalho, S = no caminho): [ícone, título, explicação].
                • SIMNAO: as perguntas de Sim/Não que viram dois botões grandes.
     CUIDADO    Não mude o "id" dos passos ('quem', 'quando'…): o visual e outras partes usam
                esse nome. Os nomes de itens precisam existir na página, escritos igual.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: os passos, na ordem em que se conta um acidente (a página tem os itens em outra ordem) */
  var PASSOS = [
    { id: 'quem', ic: 'pessoa', titulo: 'Quem se acidentou?', sub: 'Escolha a empresa e o colaborador. Os dados da pessoa aparecem sozinhos.',
      itens: ['COD_EMPRESA', 'MATRICULA', 'TELEFONE_FUNC_1_DSP'],
      pessoa: ['NOME', 'CPF', 'CARGO_DSP', 'DESCRICAO_CARGO_DSP', 'LOCAL_TRAB_FUNC_DSP', 'COD_FILIAL_DSP'] },
    { id: 'quando', ic: 'tempo', titulo: 'Quando aconteceu?', sub: 'O dia e a hora do acidente.',
      itens: ['DT_ACIDENTE', 'HOR_ACIDENTE', 'DT_ULT_DIA_TRAB', 'HORAS_TRAB'], regioes: ['FREQUENCIA'] },
    { id: 'onde', ic: 'local', titulo: 'Onde aconteceu?', sub: 'Onde a pessoa estava e em que ponto exato.',
      itens: ['IND_TRAJETO', 'ESPEC_LOCAL_ACIDENTE'],
      endereco: ['CEP_DSP', 'COD_TP_LOGR', 'ENDERECO_ACIDENTE', 'NUM_LOCAL_ACIDENTE_AUX', 'COMPLEMENTO', 'BAIRRO_ACIDENTE', 'LOCAL_ACIDENTE', 'UF_LOCAL_ACIDENTE', 'CX_POSTAL'] },
    { id: 'corpo', ic: 'corpo', titulo: 'Que parte do corpo foi atingida?', sub: 'Adicione cada parte machucada. Pode ser mais de uma.', corpo: true },
    { id: 'oque', ic: 'relato', titulo: 'O que aconteceu?', sub: 'Conte com as suas palavras. Quem analisa precisa entender como foi.',
      itens: ['DESCRICAO_TEXTO', 'DESCRICAO_OBSERVACAO'] },
    { id: 'depois', ic: 'cruz', titulo: 'Atendimento e registros', sub: 'O que aconteceu depois do acidente.',
      itens: ['SERV_MED_ATEND', 'ARQ', 'IND_EXPERIENCIA_OPERACAO', 'IND_DEPTO_POLICIAL', 'NUM_BOLETIM_OCORR', 'DATA_BOLETIM_OCORR', 'ARQ_BO', 'IND_OBITO', 'DT_OBITO'] }
  ];
  /* PODE MEXER: nomes na tela (só o texto do rótulo; o item continua o mesmo), uma linha de ajuda e o exemplo */
  var ROTULOS = {
    MATRICULA: ['Colaborador', 'Procure pelo nome ou pela matrícula de quem se acidentou.'],
    TELEFONE_FUNC_1_DSP: ['Telefone da pessoa', 'Para a equipe de saúde falar com ela, se precisar.'],
    NOME: ['Nome'], COD_FILIAL_DSP: ['Filial'], LOCAL_TRAB_FUNC_DSP: ['Local de trabalho'], CARGO_DSP: ['Cargo'], DESCRICAO_CARGO_DSP: ['Descrição do cargo'],
    DT_ACIDENTE: ['Data do acidente'],
    HOR_ACIDENTE: ['Hora do acidente', '', 'Ex.: 14:30'],
    DT_ULT_DIA_TRAB: ['Último dia trabalhado', 'Se a pessoa trabalhou no dia do acidente, é a mesma data.'],
    HORAS_TRAB: ['Horas trabalhadas antes do acidente', 'Quanto a pessoa já tinha trabalhado naquele dia. Ex.: 06:30'],
    IND_TRAJETO: ['Onde a pessoa estava?'],
    ESPEC_LOCAL_ACIDENTE: ['Em que ponto exatamente?', '', 'Ex.: escada do bloco B, perto da máquina de corte, estacionamento, calçada em frente ao nº 100'],
    CEP_DSP: ['CEP'], COD_TP_LOGR: ['Tipo'], ENDERECO_ACIDENTE: ['Endereço'], NUM_LOCAL_ACIDENTE_AUX: ['Número'], BAIRRO_ACIDENTE: ['Bairro'], LOCAL_ACIDENTE: ['Cidade'],
    DESCRICAO_TEXTO: ['Como foi o acidente?', 'Diga o que a pessoa estava fazendo, o que aconteceu e o que causou.',
      'Ex.: Ao descer a escada carregando caixas, escorregou num degrau molhado e caiu sobre o ombro direito.'],
    DESCRICAO_OBSERVACAO: ['Mais alguma informação?', 'Se quiser: quem viu, se usava equipamento de proteção, o que foi feito na hora.'],
    SERV_MED_ATEND: ['A pessoa foi atendida por médico por causa do acidente?', 'Em pronto-socorro, hospital, clínica ou ambulatório.'],
    ARQ: ['Documento do atendimento', 'Foto ou PDF do atestado, da guia ou do relatório médico. Se não tiver agora, pode enviar sem: o comprovante será pedido no dia da consulta.'],
    IND_EXPERIENCIA_OPERACAO: ['Foi feito boletim de ocorrência (B.O.)?', 'O registro na polícia.'],
    NUM_BOLETIM_OCORR: ['Número do B.O.'], DATA_BOLETIM_OCORR: ['Data do B.O.'], ARQ_BO: ['Documento do B.O.'],
    IND_OBITO: ['A pessoa faleceu por causa do acidente?'],
    DT_OBITO: ['Data do falecimento']
  };
  /* PODE MEXER: o nome curto de cada campo no "Falta" do rodapé (__corpo = a parte do corpo) */
  var CURTOS = { COD_EMPRESA: 'Empresa', MATRICULA: 'Colaborador', DT_ACIDENTE: 'Data', HOR_ACIDENTE: 'Hora', ESPEC_LOCAL_ACIDENTE: 'Ponto do local',
    DESCRICAO_TEXTO: 'Como foi', __corpo: 'Parte do corpo', DT_OBITO: 'Data do falecimento', SERV_MED_ATEND: 'Atendimento médico' };
  /* PODE MEXER: o roteiro do "Me ajude a contar": as três perguntas que quem analisa precisa ver respondidas.
     \n é a quebra de linha. CUIDADO: o "Falta" compara o relato com este texto para saber se a
     pessoa só deixou as perguntas sem responder — mude o texto, mas mantenha o formato. */
  var ROTEIRO = 'O que a pessoa estava fazendo: \nO que aconteceu: \nO que causou: ';
  /* PODE MEXER: "Não/Sim" que merece cartão: onde a pessoa estava (N = no trabalho, S = no caminho) */
  var OPCOES = {
    IND_TRAJETO: {
      N: ['predio', 'No trabalho', 'Na empresa ou no lugar onde a pessoa trabalha.'],
      S: ['rota', 'No caminho do trabalho', 'Indo para o trabalho ou voltando para casa.']
    }
  };
  /* PODE MEXER: as perguntas de Sim/Não que viram dois botões grandes ("Sim" sempre à esquerda) */
  var SIMNAO = ['SERV_MED_ATEND', 'IND_EXPERIENCIA_OPERACAO', 'IND_OBITO'];

  /* ═══ [J3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val('ITEM')    o que o APEX GUARDA no item (o código da opção, ex.: 'S' ou 'N')
       txt('ITEM')    o que a PESSOA VÊ no item (o nome da opção escolhida numa lista)
       cont('ITEM')   o bloco inteiro do campo na tela (rótulo + campo)
       pegar(…)       prepara um campo para mudar de lugar (sem desfazer o que a página escondeu)
       vazio(texto)   diz se o valor está vazio (inclui "- Selecione -")
       data('31/12/2026')  transforma o texto numa data
     QUANDO MEXER  Quase nunca. Os dias da semana (DIAS) podem ser mudados.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-aci-svg') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function cont(n) { return document.getElementById(P + n + '_CONTAINER'); }
  function val(n) { try { return String(apex.item(P + n).getValue() || '').trim(); } catch (e) { var i = document.getElementById(P + n); return i ? String(i.value || '').trim() : ''; } }
  function vazio(v) { return !v || /^\s*(-\s*selecione\s*-|-|—|\(\)\s*-?)\s*$/i.test(v); }
  /* escondido pela página (style display:none em algum ancestral). A região que era aba e entrou
     numa frente (.nc-aci-inv) carrega o display:none que o seletor de abas escreve, mas está à
     vista (o CSS vence): só conta como escondida se o perfil a tirou (.nc-aci-perfil-fora). */
  function escondido(c) {
    for (var e = c; e && e !== document.body; e = e.parentElement) {
      if (e.classList && e.classList.contains('nc-aci-inv')) { if (e.classList.contains('nc-aci-perfil-fora')) return true; continue; }
      if (e.style && e.style.display === 'none') return true;
    }
    return false;
  }
  function sem(t) { return String(t || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase(); }
  function data(t) { var m = String(t || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function plural(n, a, b) { return n + ' ' + (n === 1 ? a : b); }
  /* só escreve quando muda: o observador olha "class" dentro dos passos (senão vira laço) */
  function classe(e, v) { if (e.className !== v) e.className = v; }
  function html(e, v) { if (e.innerHTML !== v) e.innerHTML = v; }
  /* "DORCA OLIVEIRA" → "Dorca Oliveira"; "1800 - TECNICO DE LABORATORIO" → "Tecnico de Laboratorio" */
  function nomeProprio(t) {
    return String(t || '').toLowerCase().replace(/(^|[\s\-/(])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); })
      .replace(/\s(Da|De|Do|Das|Dos|E)(?=\s)/g, function (m) { return m.toLowerCase(); });
  }
  /* antes de mudar um campo de lugar: o que uma folha da página já escondia (sem style inline, ou
     seja, sem ação dinâmica — ex.: os anexos na comunicação gravada) continua escondido */
  function pegar(c, n) {
    if (getComputedStyle(c).display === 'none' && !c.style.display) c.classList.add('nc-aci-oculto');
    c.classList.add('nc-aci-campo', 'nc-aci-campo--' + n.toLowerCase());
    return c;
  }
  function semCodigo(t) { return String(t || '').replace(/^\s*\d+\s*-\s*/, '').trim(); }
  /* o texto que a tela mostra de um item: exibição, lista, rádio ou campo */
  function txt(n) {
    var d = document.getElementById(P + n + '_DISPLAY');
    if (d) return d.textContent.replace(/\s+/g, ' ').trim();
    var i = document.getElementById(P + n);
    if (!i) return '';
    if (i.tagName === 'SELECT') { var o = i.options[i.selectedIndex]; return o && i.value ? o.text.trim() : ''; }
    if (i.classList.contains('apex-item-group')) {
      var r = i.querySelector('input:checked'), l = r && i.querySelector('label[for="' + r.id + '"]');
      return l ? (l.querySelector('.nc-aci-op-tit') || l).textContent.trim() : '';
    }
    if (i.tagName === 'SPAN' || i.classList.contains('apex-item-display-only')) return i.textContent.replace(/\s+/g, ' ').trim();
    return String(i.value || '').trim();
  }
  function simNao(n) { var v = sem(val(n)); return v === 's' || v === 'sim' ? 'S' : v === 'n' || v === 'nao' ? 'N' : ''; }
  /* PODE MEXER: como os dias da semana aparecem escritos na tela */
  var DIAS = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'];
  /* "02" → "2 h"; "06:30" → "6 h 30 min" */
  function horas(t) {
    var m = String(t || '').match(/^\s*(\d{1,2})(?::(\d{2}))?\s*$/); if (!m) return String(t || '').trim();
    var h = +m[1], mi = +(m[2] || 0);
    return (h ? h + ' h' : '') + (mi ? (h ? ' ' : '') + mi + ' min' : '') || '0 h';
  }

  /* ═══ [J4] OS 6 PASSOS (página 91) ═══════════════════════════════════════════════════════
     O QUE FAZ  A linha logo abaixo é o PONTO DE PARTIDA do arquivo: quando a página termina de
                carregar, chama montarParte (p92), montarAnalise (p31) ou montar (p91).
                montar() cria a caixa dos passos no alto da página e, para cada passo da lista
                PASSOS ([J2]), leva para dentro dele os campos do APEX. Depois aplica os rótulos
                (ROTULOS), as escolhas grandes (OPCOES, SIMNAO), os atalhos de data e o roteiro
                ([J10]), esconde as abas ("Mostrar tudo" fica selecionado) e monta o rodapé ([J9]).
     NOVA OU GRAVADA  A comunicação é "nova" quando P91_ROWID está vazio. Não serve o nº
                (P91_COD_REQ): a página já o reserva quando o colaborador é escolhido.
                Gravada e sem campos editáveis = modo "só leitura" (mostra a ficha, [J7]).
     REGIÕES QUE SOBRAM  Regiões do APEX que ficaram sem nenhum campo à vista perdem só a moldura
                (classe nc-aci-casca): se uma ação dinâmica mostrar algo lá dentro, aparece.
     LÊ DOS ITENS  os de PASSOS ([J2]) e P91_ROWID, P91_COD_REQ, P91_DT_ACIDENTE.
     VISUAL     Natcorp_Acidente.css › [C2] abertura, [C6] passos, [C7] cartão da pessoa,
                [C8] endereço, [C10] escolhas grandes
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* CUIDADO (análise, p31): o desenho só move os campos DEPOIS que a página roda as ações de
     abertura ("apexreadyend") — "Read Only Local Acidente" procura os campos dentro de #LOCAL,
     "Habilita/Desabilita Campos" e "SHOW/HIDE Campos" agem no carregamento. Movidos antes, a regra
     não os acharia (ficariam editáveis). Sem o evento em 3 s, monta assim mesmo. */
  if (MODO === 'analise') {
    var analiseFeita = false, montarUmaVez = function () { if (analiseFeita) return; analiseFeita = true; setTimeout(montarAnalise, 0); };
    $(window).one('apexreadyend', montarUmaVez);
    $(function () { setTimeout(montarUmaVez, 3000); });
  } else $(function () { setTimeout(MODO === 'parte' ? montarParte : montar, 40); });

  var CAIXA = null, SECS = [], FALTA = null, LEITURA = false, NOVA = true, CORPO = null;

  function montar() {
    document.body.classList.add('nc-aci');
    /* nova = ainda não gravada. Não serve o nº: a página já o reserva quando o colaborador é
       escolhido (e ele volta preenchido se o envio der erro e a página recarregar) */
    NOVA = document.getElementById(P + 'ROWID') ? !val('ROWID') : !val('COD_REQ');
    var dt = document.getElementById(P + 'DT_ACIDENTE');
    LEITURA = !NOVA && (!dt || dt.type === 'hidden' || !!document.getElementById(P + 'DT_ACIDENTE_DISPLAY'));
    document.body.classList.toggle('nc-aci-leitura', LEITURA);

    var ancora = document.getElementById('ANALISE') || cont('COD_EMPRESA').closest('.t-Region');
    while (ancora.parentElement && ancora.parentElement.closest('.t-Region')) ancora = ancora.parentElement.closest('.t-Region');

    CAIXA = el('div', 'nc-aci-passos');
    ancora.parentNode.insertBefore(CAIXA, ancora);

    if (NOVA) {
      var intro = el('div', 'nc-aci-intro');
      intro.innerHTML = '<p class="nc-aci-intro-txt">São 6 passos. Os campos com <b class="nc-aci-ast">*</b> são obrigatórios.</p>' +
        '<p class="nc-aci-intro-aviso">' + svg(IC.cruz) + '<span>Se alguém está ferido agora, cuide do socorro primeiro. A comunicação pode ser feita em seguida.</span></p>';
      CAIXA.appendChild(intro);
    } else {
      montarPedido();
    }

    PASSOS.forEach(function (p, i) {
      var sec = el('section', 'nc-aci-passo nc-aci-passo--' + p.id);
      sec.setAttribute('aria-labelledby', 'nc-aci-t-' + p.id);
      sec.innerHTML = '<header class="nc-aci-passo-cab"><span class="nc-aci-num" aria-hidden="true">' + (i + 1) + '</span>' +
        '<div class="nc-aci-passo-tit"><h3 id="nc-aci-t-' + p.id + '">' + esc(p.titulo) + '</h3><p>' + esc(p.sub) + '</p></div>' +
        '<span class="nc-aci-passo-estado" aria-live="polite"></span></header><div class="nc-aci-campos"></div>';
      var campos = sec.querySelector('.nc-aci-campos');
      (p.itens || []).forEach(function (n) {
        var c = cont(n); if (!c) return;
        campos.appendChild(pegar(c, n));
        /* o ponto exato vem logo depois de "onde estava"; o endereço, por último */
        if (n === 'ESPEC_LOCAL_ACIDENTE' && p.endereco) campos.appendChild(montarEndereco(p.endereco));
      });
      if (p.pessoa) campos.appendChild(montarPessoa(p.pessoa));
      if (p.id === 'quando') campos.appendChild(el('p', 'nc-aci-quando', ''));
      (p.regioes || []).forEach(function (id) { var r = document.getElementById(id); if (r) { r.classList.add('nc-aci-sub'); campos.appendChild(r); } });
      if (p.corpo) montarCorpo(sec, campos);
      CAIXA.appendChild(sec);
      SECS.push({ p: p, sec: sec });
    });

    if (LEITURA) montarFicha();
    else if (NOVA) montarPrevia();
    montarAprovacao();

    /* as regiões que ficaram sem campo à vista perdem a moldura (não somem: se uma ação dinâmica
       mostrar algo lá dentro, aparece) */
    [].forEach.call(document.querySelectorAll('.t-Region'), function (r) {
      if (CAIXA.contains(r) || r.classList.contains('nc-aci-fora')) return;
      var vivo = [].some.call(r.querySelectorAll('.t-Form-fieldContainer, .t-Report, .t-Timeline, .t-Button:not(.t-Button--iconOnly)'), function (x) { return !escondido(x) && !CAIXA.contains(x); });
      if (!vivo && !/FOOTER/i.test(r.id) && !r.querySelector('[data-nc-envia]')) r.classList.add('nc-aci-casca');
    });

    rotulos();
    opcoes('IND_TRAJETO');
    SIMNAO.forEach(simNaoMontar);
    if (!LEITURA) { atalhos(); roteiro(); }
    abas();
    rodape();

    /* tudo que muda o que se vê: o que a pessoa escolhe, e o que as ações dinâmicas devolvem */
    $(document).on('change', '[id^="' + P + '"]', agendar);
    $(document).on('input', '#' + P + 'DESCRICAO_TEXTO, #' + P + 'ESPEC_LOCAL_ACIDENTE', agendar);
    $(document).ajaxComplete(agendar);
    new MutationObserver(agendar).observe(CAIXA, { attributes: true, attributeFilter: ['style', 'disabled'], subtree: true });
    atualizar();
  }

  /* os dados da pessoa (o APEX mostra depois que o colaborador é escolhido) viram um cartão */
  function montarPessoa(lista) {
    var box = el('div', 'nc-aci-pessoa');
    box.innerHTML = '<span class="nc-aci-pessoa-av" aria-hidden="true"></span><div class="nc-aci-pessoa-dados"></div>';
    var dados = box.querySelector('.nc-aci-pessoa-dados');
    lista.forEach(function (n) { var c = cont(n); if (c) dados.appendChild(pegar(c, n)); });
    return box;
  }

  function montarEndereco(lista) {
    var box = el('div', 'nc-aci-endereco');
    box.innerHTML = '<p class="nc-aci-endereco-tit">' + svg(IC.local) + '<span>Endereço do local <small>vem do cadastro do local de trabalho</small></span></p><div class="nc-aci-endereco-campos"></div>';
    var campos = box.querySelector('.nc-aci-endereco-campos');
    lista.forEach(function (n) { var c = cont(n); if (c) campos.appendChild(pegar(c, n)); });
    return box;
  }

  function rotulos() {
    Object.keys(ROTULOS).forEach(function (n) {
      var c = cont(n); if (!c) return;
      var l = c.querySelector('.t-Form-label');
      var r = ROTULOS[n];
      if (l && l.firstChild && l.firstChild.nodeType === 3) l.firstChild.nodeValue = r[0] + ' ';
      if (r[1] && !c.querySelector('.nc-aci-ajuda')) {
        var lc = c.querySelector('.t-Form-labelContainer');
        var aj = el('span', 'nc-aci-ajuda', esc(r[1]));
        aj.id = P + n + '_NC_AJUDA';
        if (lc) lc.appendChild(aj);
        var i = document.getElementById(P + n);
        if (i && i.setAttribute) i.setAttribute('aria-describedby', ((i.getAttribute('aria-describedby') || '') + ' ' + aj.id).trim());
      }
      var t = document.getElementById(P + n);
      if (r[2] && t && /TEXTAREA|INPUT/.test(t.tagName) && !t.getAttribute('placeholder')) t.setAttribute('placeholder', r[2]);
    });
  }

  /* "Não/Sim" viram duas escolhas grandes; os rádios do APEX continuam (e disparam o change) */
  function opcoes(n) {
    var c = cont(n); if (!c) return;
    c.classList.add('nc-aci-escolha');
    [].forEach.call(c.querySelectorAll('.apex-item-option'), function (op) {
      var r = op.querySelector('input[type=radio]'), lb = op.querySelector('label');
      var o = OPCOES[n][r && r.value];
      if (!r || !lb || !o || lb.querySelector('.nc-aci-op-tit')) return;
      lb.innerHTML = '<span class="nc-aci-op-ic" aria-hidden="true">' + svg(IC[o[0]]) + '</span>' +
        '<span class="nc-aci-op-txt"><b class="nc-aci-op-tit">' + esc(o[1]) + '</b><small>' + esc(o[2]) + '</small></span>' +
        '<span class="nc-aci-op-marca" aria-hidden="true">' + svg(IC.ok) + '</span>';
    });
  }

  /* as perguntas de sim ou não: sempre "Sim" à esquerda e "Não" à direita, botões grandes */
  function simNaoMontar(n) {
    var c = cont(n); if (!c) return;
    c.classList.add('nc-aci-simnao');
    [].forEach.call(c.querySelectorAll('.apex-item-option'), function (op) {
      var r = op.querySelector('input[type=radio]'); if (!r) return;
      var v = sem(r.value);
      op.classList.add(v === 's' || v === 'sim' ? 'nc-aci-op-sim' : 'nc-aci-op-nao');
      var lb = op.querySelector('label');
      if (lb && !lb.querySelector('.nc-aci-sn-marca')) lb.insertAdjacentHTML('afterbegin', '<span class="nc-aci-sn-marca" aria-hidden="true">' + svg(IC.ok) + '</span>');
    });
    if (LEITURA && !c.querySelector('input:checked') && !c.querySelector('.nc-aci-sem-resposta')) {
      var ic = c.querySelector('.t-Form-inputContainer');
      if (ic) ic.appendChild(el('span', 'nc-aci-sem-resposta', 'Não informado'));
    }
  }

  /* com os passos na tela, as abas ("Mostrar tudo", "Comunicação"…) não ajudam: tudo à vista */
  function abas() {
    var rds = document.querySelector('.apex-rds-container');
    if (!rds) return;
    var tudo = rds.querySelector('a[href="#SHOW_ALL"]');
    if (tudo && tudo.getAttribute('aria-selected') !== 'true') tudo.click();
    var reg = rds.closest('.t-Region') || rds;
    reg.classList.add('nc-aci-fora');
  }

  /* ═══ [J5] O CABEÇALHO DA COMUNICAÇÃO GRAVADA ════════════════════════════════════════════
     O QUE FAZ  Numa comunicação já gravada, mostra no alto: "Comunicação de acidente nº …",
                aberta em / por quem, e a situação com uma cor (verde aprovada/concluída,
                vermelho cancelada/reprovada, amarelo suspensa/pendente). O botão
                "Caracterização CAT" (o próximo passo de quem analisa) sobe para o cabeçalho.
     LÊ DOS ITENS  P91_COD_REQ, P91_DT_REQ, P91_MAT_SOLICITANTE, P91_COD_SIT_REQ, P91_DT_SIT_REQ
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_Acidente.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tomSituacao(t) {
    var s = sem(t);
    if (/aprovad|conclu|disponibiliz/.test(s)) return 'bom';
    if (/cancelad|reprovad/.test(s)) return 'ruim';
    if (/suspens|pendent/.test(s)) return 'atencao';
    return 'meio';
  }
  function montarPedido() {
    var c = cont('COD_REQ');
    var reg = c && c.closest('.t-Region');
    var quem = semCodigo(txt('MAT_SOLICITANTE'));
    var cab = el('section', 'nc-aci-pedido');
    cab.setAttribute('aria-label', 'Dados da comunicação');
    var sit = txt('COD_SIT_REQ'), desde = val('DT_SIT_REQ');
    cab.innerHTML = '<span class="nc-aci-pedido-ic" aria-hidden="true">' + svg(IC.ficha) + '</span>' +
      '<div class="nc-aci-pedido-txt"><h2>Comunicação de acidente nº ' + esc(val('COD_REQ')) + '</h2>' +
      '<p>' + (val('DT_REQ') ? 'Aberta em <b>' + esc(val('DT_REQ')) + '</b>' : '') + (quem ? ' por <b>' + esc(nomeProprio(quem)) + '</b>' : '') + '</p></div>' +
      '<div class="nc-aci-pedido-lado">' + (sit ? '<span class="nc-aci-sit nc-aci-sit--' + tomSituacao(sit) + '"><i aria-hidden="true"></i>' + esc(sit) + '</span>' +
        (desde ? '<span class="nc-aci-sit-desde">desde ' + esc(desde) + '</span>' : '') : '') + '</div>';
    CAIXA.appendChild(cab);
    /* o "Caracterização CAT" (de quem analisa) sobe para o cabeçalho — é o próximo passo dessa pessoa */
    var cat = [].slice.call(document.querySelectorAll('.t-Button')).filter(function (b) { return /caracteriza/i.test(b.textContent); })[0];
    if (cat) {
      cat.classList.add('nc-aci-cat');
      if (!cat.querySelector('.nc-aci-svg')) cat.insertAdjacentHTML('afterbegin', svg(IC.ficha));
      var acao = el('div', 'nc-aci-pedido-acao');
      acao.appendChild(cat);
      cab.appendChild(acao);
    }
    if (reg) reg.classList.add('nc-aci-fora');
  }

  /* ═══ [J6] A PARTE DO CORPO E A FIGURA ═══════════════════════════════════════════════════
     O QUE FAZ  No passo 4, junta o relatório das partes (região PARTE_CORPO), o botão
                "Adicionar parte do corpo" e uma figura do corpo com um ponto em cada parte.
     A FIGURA   Vista de frente: o lado DIREITO da pessoa fica à ESQUERDA de quem olha
                (por isso as letras D e E embaixo).
     O ADICIONAR  A janela p92 só pode abrir depois que a página monta o endereço dela, o que
                acontece quando o colaborador e a data estão escolhidos (item
                P91_URL_PARTE_LESADA). Antes disso o botão fica apagado e diz o que falta.
                Se o colaborador for trocado DEPOIS da data, o arquivo "confirma" a data de
                novo (dispara o change dela, uma vez por combinação), para a página remontar o
                endereço com o colaborador certo — senão as partes iriam para outra comunicação.
     PODE MEXER • PARTES: cada linha é [padrão de busca do nome da parte, posição na figura].
                  Para uma parte nova ganhar ponto, copie uma linha parecida e troque o padrão.
                  As posições são coordenadas (x, y) na figura de 120 × 208.
                • os textos entre aspas (aviso do Adicionar, legenda da figura).
     CUIDADO    Os trechos entre barras, como /joelho|patela/, são "padrões de busca"
                (expressões regulares): procuram aquele pedaço no nome da parte, sem acento.
     VISUAL     Natcorp_Acidente.css › [C5] figura, [C9] parte do corpo
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* pontos na figura (vista de frente: o lado DIREITO da pessoa fica à esquerda de quem olha).
     [x, y] central; [[xDir, y], [xEsq, y]] quando a parte tem os dois lados */
  var PARTES = [
    [/dedo.*\bpe\b|dedos? do pe|artelho|halux|halux/, [[39, 197], [81, 197]]],
    [/tornozelo/, [[46, 188], [74, 188]]],
    [/\bpes?\b|calcanhar|planta do pe/, [[43, 195], [77, 195]]],
    [/joelho|patela/, [[48, 151], [72, 151]]],
    [/perna|panturrilha|canela|tibia/, [[47, 170], [73, 170]]],
    [/coxa|femur/, [[50, 130], [70, 130]]],
    [/quadril|bacia|pelve|virilha|nadega|gluteo/, [[51, 108], [69, 108]]],
    [/genita|pubis/, [60, 112]],
    [/dedo|polegar|indicador|falange/, [[21, 137], [99, 137]]],
    [/\bmaos?\b|palma/, [[22, 129], [98, 129]]],
    [/punho|pulso/, [[23, 122], [97, 122]]],
    [/antebraco/, [[27, 105], [93, 105]]],
    [/cotovelo/, [[30, 87], [90, 87]]],
    [/braco|umero/, [[35, 69], [85, 69]]],
    [/ombro|clavicula|escapula/, [[41, 52], [79, 52]]],
    [/olho|ocular|palpebra/, [[55, 19], [65, 19]]],
    [/orelha|ouvido|auricular/, [[47, 21], [73, 21]]],
    [/face|rosto|boca|nariz|labio|dente|mandibula|queixo|maxilar/, [60, 27]],
    [/cabeca|cranio|couro cabeludo|testa/, [60, 15]],
    [/pescoco|cervical|garganta/, [60, 39]],
    [/torax|peito|costela|esterno|mama/, [60, 64]],
    [/costas|dorso|coluna|lombar|dorsal/, [60, 82]],
    [/abdome|abdomen|barriga/, [60, 94]]
  ];
  function pontos(parte, lado) {
    var s = sem(parte), l = sem(lado);
    for (var i = 0; i < PARTES.length; i++) {
      if (!PARTES[i][0].test(s)) continue;
      var p = PARTES[i][1];
      if (typeof p[0] === 'number') return [p];
      if (/direit/.test(l)) return [p[0]];
      if (/esquerd/.test(l)) return [p[1]];
      return [p[0], p[1]];
    }
    return [];
  }
  function lerPartes() {
    var reg = CORPO && CORPO.reg; if (!reg) return [];
    return [].slice.call(reg.querySelectorAll('table.t-Report-report tbody tr')).map(function (tr) {
      var tds = tr.querySelectorAll('td');
      function c(h, k) { var td = tr.querySelector('td[headers="' + h + '"]') || tds[k]; return td ? td.textContent.replace(/\s+/g, ' ').trim() : ''; }
      return { parte: c('PARTE_LESADA', 0), lado: c('LATERALIDADE', 1), desc: c('DESCRICAO_PARTE_LESADA', 2) };
    }).filter(function (l) { return l.parte; });
  }
  function nomeParte(t) { var s = String(t || '').replace(/\s*\(\d+\)\s*$/, '').trim(); return s ? s.charAt(0).toUpperCase() + s.slice(1).toLowerCase() : ''; }
  function figura(partes) {
    var marcas = '';
    partes.forEach(function (p) { pontos(p.parte, p.lado).forEach(function (xy) {
      marcas += '<circle class="nc-aci-bon-halo" cx="' + xy[0] + '" cy="' + xy[1] + '" r="10"/><circle class="nc-aci-bon-ponto" cx="' + xy[0] + '" cy="' + xy[1] + '" r="5"/>';
    }); });
    var nomes = partes.map(function (p) { return nomeParte(p.parte) + (p.lado && !vazio(p.lado) ? ' ' + p.lado.toLowerCase() : ''); }).join(', ');
    return '<svg class="nc-aci-boneco" viewBox="0 0 120 208" role="img" aria-label="' + esc(partes.length ? 'Figura do corpo com a parte atingida marcada: ' + nomes : 'Figura do corpo, sem parte marcada') + '">' +
      '<g class="nc-aci-bon-corpo"><circle cx="60" cy="19" r="12.5"/><path d="M60 31.5V41"/><path d="M40.5 50q19.5-8 39 0l-3 57.5q-16.5 7-33 0z"/>' +
      '<path d="M40 51.5l-10 35.5-7 36"/><path d="M80 51.5l10 35.5 7 36"/><path d="M51.5 112l-3.5 39.5-2 37.5-4 5.5"/><path d="M68.5 112l3.5 39.5 2 37.5 4 5.5"/></g>' +
      marcas + '<text class="nc-aci-bon-lado" x="6" y="206">D</text><text class="nc-aci-bon-lado" x="106" y="206">E</text></svg>';
  }
  function montarCorpo(sec, campos) {
    var reg = document.getElementById('PARTE_CORPO') || (document.querySelector('.t-Report-report th#PARTE_LESADA') || { closest: function () { return null; } }).closest('.t-Region');
    if (!reg) return;
    var add = [].slice.call(reg.querySelectorAll('.t-Region-header .t-Button, .t-Region-buttons .t-Button')).filter(function (b) { return !b.classList.contains('t-Button--iconOnly'); })[0];
    var grade = el('div', 'nc-aci-corpo');
    grade.innerHTML = '<div class="nc-aci-corpo-fig" aria-hidden="false"></div><div class="nc-aci-corpo-lista"></div>';
    var lista = grade.querySelector('.nc-aci-corpo-lista');
    reg.classList.add('nc-aci-sub', 'nc-aci-corpo-reg');
    lista.appendChild(reg);
    var aviso = el('p', 'nc-aci-corpo-aviso');
    aviso.setAttribute('aria-live', 'polite');
    aviso.hidden = true;
    if (add) {
      add.classList.add('nc-aci-corpo-add');
      var l = add.querySelector('.t-Button-label');
      if (l) l.textContent = 'Adicionar parte do corpo';
      lista.appendChild(aviso);
      lista.appendChild(add);
      /* a janela só abre depois que a página monta o endereço dela (quando o colaborador e a data
         estão escolhidos). Antes disso o botão não fazia nada: agora ele diz o que falta */
      add.addEventListener('click', function (e) {
        if (corpoPronto()) return;
        e.preventDefault(); e.stopImmediatePropagation();
        aviso.hidden = false;
        desenharAvisoCorpo(true);
      }, true);
      aviso.addEventListener('click', function (e) {
        var b = e.target.closest('[data-ir]'); if (!b) return;
        irPara(b.getAttribute('data-ir'));
      });
    }
    campos.appendChild(grade);
    campos.appendChild(el('p', 'nc-aci-corpo-leg', 'Na figura, a pessoa está de frente: <b>D</b> é o lado direito dela, <b>E</b> o esquerdo.'));
    CORPO = { reg: reg, add: add, aviso: aviso, fig: grade.querySelector('.nc-aci-corpo-fig') };
    $(reg).on('apexafterrefresh', function () { setTimeout(agendar, 30); });
  }
  /* pronto = a página já montou o endereço da janela E ele é do colaborador e do nº de agora */
  function corpoPronto() {
    var u = val('URL_PARTE_LESADA'), mat = val('MATRICULA'), req = val('COD_REQ');
    if (!/dialog\(/.test(u)) return false;
    if (LEITURA || !document.getElementById(P + 'MATRICULA') || document.getElementById(P + 'MATRICULA').type === 'hidden') return true;
    return !!mat && !!req && u.indexOf(',' + mat + ',' + req) > -1;
  }
  function desenharAvisoCorpo(pediu) {
    if (!CORPO || !CORPO.add) return;
    var pronto = corpoPronto();
    CORPO.add.classList.toggle('is-espera', !pronto);
    CORPO.add.setAttribute('aria-disabled', pronto ? 'false' : 'true');
    if (pronto) { CORPO.aviso.hidden = true; return; }
    var falta = [];
    if (!val('MATRICULA')) falta.push('<button type="button" class="nc-aci-link" data-ir="MATRICULA">o colaborador</button> (passo 1)');
    if (!val('DT_ACIDENTE')) falta.push('<button type="button" class="nc-aci-link" data-ir="DT_ACIDENTE">a data do acidente</button> (passo 2)');
    html(CORPO.aviso, svg(IC.info) + '<span>' + (falta.length
      ? 'Para adicionar, escolha antes ' + falta.join(' e ') + '.'
      : 'Preparando a lista das partes do corpo… tente de novo em um instante.') + '</span>');
    if (!pediu && CORPO.aviso.hidden) return;
    CORPO.aviso.hidden = false;
  }
  /* a página monta o endereço da janela quando a DATA muda, com o colaborador e o nº daquele
     momento. Se o colaborador for trocado depois, o endereço ficaria com o anterior (e as partes
     iriam para outra comunicação): a data é "confirmada" de novo, uma vez por combinação */
  var conferido = '';
  function conferirEnderecoCorpo() {
    if (LEITURA || !CORPO || !CORPO.add || $.active) return;
    var mat = val('MATRICULA'), req = val('COD_REQ'), dt = val('DT_ACIDENTE');
    if (!mat || !req || !dt) return;
    var u = val('URL_PARTE_LESADA');
    if (u.indexOf(',' + mat + ',' + req) > -1) return;
    var chave = [val('COD_EMPRESA'), mat, req, dt].join('|');
    if (conferido === chave) return;
    conferido = chave;
    $('#' + P + 'DT_ACIDENTE').trigger('change');
  }
  function desenharCorpo() {
    if (!CORPO) return 0;
    var partes = lerPartes();
    html(CORPO.fig, figura(partes));
    /* o relatório vira lista: o rótulo de cada coluna vai junto (no celular a tabela não cabe) */
    [].forEach.call(CORPO.reg.querySelectorAll('table.t-Report-report tbody td'), function (td) {
      var th = td.getAttribute('headers') && document.getElementById(td.getAttribute('headers'));
      if (th && !td.getAttribute('data-nc-rot')) td.setAttribute('data-nc-rot', th.textContent.trim());
    });
    return partes.length;
  }

  /* ═══ [J7] A FICHA DO ACIDENTE ═══════════════════════════════════════════════════════════
     O QUE FAZ  Monta o resumo para quem analisa (Médico do Trabalho, Técnico de Segurança):
                a pessoa, quando (com o dia da semana), onde, a parte atingida na figura, o
                relato e os "sinais" (atendimento médico, B.O., óbito).
                  • Na CRIAÇÃO, aparece no fim como "Confira antes de enviar" (a prévia), assim
                    que o colaborador é escolhido: o que a pessoa escreve é o que o médico lê.
                  • Na comunicação GRAVADA (só leitura), aparece no alto como "Resumo do
                    acidente", antes de "Todos os dados da comunicação".
     NO CAMINHO DO TRABALHO  O lugar é o ponto do caminho; o endereço mostrado é o do local de
                trabalho, e a ficha diz isso.
     PODE MEXER os textos entre aspas ('Confira antes de enviar', 'Parte atingida'…).
     VISUAL     Natcorp_Acidente.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FICHA = null, PREVIA = false;
  /* na criação: a mesma ficha, no fim, antes de enviar — o que a pessoa escreve é o que o médico lê */
  function montarPrevia() {
    PREVIA = true;
    FICHA = el('section', 'nc-aci-ficha nc-aci-ficha--previa');
    FICHA.setAttribute('aria-labelledby', 'nc-aci-t-ficha');
    FICHA.hidden = true;
    CAIXA.appendChild(FICHA);
  }
  function montarFicha() {
    FICHA = el('section', 'nc-aci-ficha');
    FICHA.setAttribute('aria-labelledby', 'nc-aci-t-ficha');
    var primeiro = CAIXA.querySelector('.nc-aci-passo');
    CAIXA.insertBefore(FICHA, primeiro);
    var t = el('h3', 'nc-aci-passos-tit', 'Todos os dados da comunicação');
    CAIXA.insertBefore(t, primeiro);
  }
  function desenharFicha() {
    if (!FICHA) return;
    var nome = nomeProprio(txt('NOME') || semCodigo(txt('MATRICULA')));
    var ini = nome.split(/\s+/).filter(Boolean); ini = (ini[0] || '').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '');
    var cargo = nomeProprio(semCodigo(txt('CARGO_DSP')));
    var local = nomeProprio(semCodigo(txt('LOCAL_TRAB_FUNC_DSP')));
    var mat = (txt('MATRICULA').match(/^\s*(\d+)/) || [])[1] || val('MATRICULA');
    var d = data(val('DT_ACIDENTE')), hora = val('HOR_ACIDENTE');
    var quando = d ? '<b>' + DIAS[d.getDay()].charAt(0).toUpperCase() + DIAS[d.getDay()].slice(1) + ', ' + esc(val('DT_ACIDENTE')) + '</b>' + (hora ? ' <b>às ' + esc(hora) + '</b>' : '') : '<b>—</b>';
    var ht = txt('HORAS_TRAB'), ult = val('DT_ULT_DIA_TRAB');
    var trajeto = simNao('IND_TRAJETO') === 'S';
    var cidade = [nomeProprio(txt('LOCAL_ACIDENTE')), txt('UF_LOCAL_ACIDENTE')].filter(function (x) { return x && !vazio(x); }).join('/');
    var rua = [nomeProprio(txt('ENDERECO_ACIDENTE')), txt('NUM_LOCAL_ACIDENTE_AUX')].filter(function (x) { return x && !vazio(x); }).join(', ');
    var ponto = txt('ESPEC_LOCAL_ACIDENTE');
    var partes = lerPartes();
    var relato = txt('DESCRICAO_TEXTO'), outras = txt('DESCRICAO_OBSERVACAO');

    function sinal(n, rot, forte) {
      var v = simNao(n);
      var tom = v === 'S' ? forte : v === 'N' ? 'nao' : 'vazio';
      return '<li class="nc-aci-sinal nc-aci-sinal--' + tom + '"><span>' + esc(rot) + '</span><b>' + (v === 'S' ? 'Sim' : v === 'N' ? 'Não' : PREVIA ? 'Sem resposta' : 'Não informado') + '</b></li>';
    }

    html(FICHA,
      (PREVIA
        ? '<header class="nc-aci-ficha-cab"><span class="nc-aci-ficha-ic" aria-hidden="true">' + svg(IC.ficha) + '</span><div><h3 id="nc-aci-t-ficha">Confira antes de enviar</h3>' +
          '<p>É assim que a equipe de saúde e segurança vai ver esta comunicação. Se algo estiver errado ou faltando, corrija nos passos acima.</p></div></header>'
        : '<header class="nc-aci-ficha-cab"><h3 id="nc-aci-t-ficha">Resumo do acidente</h3><p>O essencial para a análise, num lugar só.</p></header>') +
      '<div class="nc-aci-ficha-grade">' +
        '<div class="nc-aci-fato nc-aci-fato--quem"><span class="nc-aci-av" aria-hidden="true">' + esc(ini.toUpperCase() || '?') + '</span><div>' +
          '<b class="nc-aci-fato-nome">' + esc(nome || '—') + '</b>' +
          '<span>' + esc([mat ? 'Matrícula ' + mat : '', cargo].filter(Boolean).join(' · ')) + '</span>' +
          (local ? '<span>' + esc(local) + '</span>' : '') + '</div></div>' +
        '<dl class="nc-aci-fato"><dt>' + svg(IC.tempo) + 'Quando</dt><dd>' + quando +
          '<span>' + esc([ht && !vazio(ht) ? horas(ht) + ' trabalhadas antes' : '', ult ? 'último dia trabalhado ' + ult : ''].filter(Boolean).join(' · ')) + '</span></dd></dl>' +
        '<dl class="nc-aci-fato"><dt>' + svg(IC.local) + 'Onde</dt><dd><b>' + (trajeto ? 'No trajeto (ida ou volta do trabalho)' : 'No local de trabalho') + '</b>' +
          /* no trajeto, o lugar é o ponto do caminho; o endereço é só o do local de trabalho */
          (trajeto
            ? (ponto && !vazio(ponto) ? '<span class="nc-aci-fato-ponto">' + esc(ponto) + '</span>' : '') +
              (rua || cidade ? '<span>Local de trabalho: ' + esc([rua, cidade].filter(Boolean).join(' · ')) + '</span>' : '')
            : (rua || cidade ? '<span>' + esc([rua, cidade].filter(Boolean).join(' · ')) + '</span>' : '') +
              (ponto && !vazio(ponto) ? '<span class="nc-aci-fato-ponto">' + esc(ponto) + '</span>' : '')) + '</dd></dl>' +
      '</div>' +
      '<div class="nc-aci-ficha-meio">' +
        '<div class="nc-aci-ficha-corpo"><div class="nc-aci-ficha-fig">' + figura(partes) + '</div><div><h4>Parte atingida</h4>' +
          (partes.length ? '<ul class="nc-aci-partes">' + partes.map(function (p) {
            return '<li><b>' + esc(nomeParte(p.parte)) + '</b>' + (p.lado && !vazio(p.lado) ? '<span class="nc-aci-lado">' + esc(p.lado) + '</span>' : '') +
              (p.desc && !vazio(p.desc) ? '<small>' + esc(p.desc) + '</small>' : '') + '</li>';
          }).join('') + '</ul>' : '<p class="nc-aci-ficha-vazio">' + (PREVIA ? 'Falta adicionar a parte do corpo (passo 4).' : 'Nenhuma parte informada.') + '</p>') + '</div></div>' +
        '<div class="nc-aci-ficha-relato"><h4>Relato de quem comunicou</h4>' +
          (relato && !vazio(relato) ? '<blockquote>' + esc(relato) + '</blockquote>' : '<p class="nc-aci-ficha-vazio">' + (PREVIA ? 'Falta contar como foi (passo 5).' : 'Sem relato.') + '</p>') +
          (outras && !vazio(outras) ? '<h4>Outras informações</h4><p class="nc-aci-ficha-outras">' + esc(outras) + '</p>' : '') + '</div>' +
      '</div>' +
      '<ul class="nc-aci-sinais" aria-label="Sinais de gravidade">' +
        sinal('SERV_MED_ATEND', 'Atendimento médico', 'info') + sinal('IND_EXPERIENCIA_OPERACAO', 'Boletim de ocorrência', 'atencao') + sinal('IND_OBITO', 'Óbito', 'grave') +
      '</ul>');
  }

  /* ═══ [J8] A APROVAÇÃO ═══════════════════════════════════════════════════════════════════
     O QUE FAZ  Numa comunicação gravada, a região de aprovação (Static ID STATIC_APROV) sai da
                aba e vira uma lista no fim da página: quem, o que decidiu, quando e a
                justificativa. Lê a linha do tempo (Timeline) ou, se não houver, o relatório
                com as colunas APROVADOR, DATA, STATUS, JUSTIFICATIVA.
     CUIDADO    Se essas colunas forem renomeadas no APEX, a lista não acha os dados.
     PODE MEXER os textos entre aspas ('Aprovação', 'Ainda não há aprovação registrada.'…).
     VISUAL     Natcorp_Acidente.css › [C12]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var APROV = null;
  function montarAprovacao() {
    var reg = document.getElementById('STATIC_APROV');
    if (!reg) { var tl = document.querySelector('.t-Timeline, .t-Report-report th#APROVADOR'); reg = tl && tl.closest('.t-Region'); }
    if (!reg || NOVA) return;
    var sec = el('section', 'nc-aci-aprov');
    sec.setAttribute('aria-labelledby', 'nc-aci-t-aprov');
    sec.innerHTML = '<header class="nc-aci-aprov-cab"><span class="nc-aci-aprov-ic" aria-hidden="true">' + svg(IC.aprovacao) + '</span>' +
      '<div><h3 id="nc-aci-t-aprov">Aprovação</h3><p>Quem analisou a comunicação e o que decidiu.</p></div></header><ol class="nc-aci-aprov-lista" data-slot="lista"></ol>';
    CAIXA.appendChild(sec);
    APROV = { reg: reg, sec: sec };
    reg.classList.add('nc-aci-fora');
    $(reg).on('apexafterrefresh', function () { setTimeout(desenharAprovacao, 30); });
    desenharAprovacao();
  }
  function tomAprov(t) {
    var s = sem(t);
    if (/aprovad|conclu/.test(s)) return ['bom', IC.ok];
    if (/reprovad|recusad|negad|cancelad/.test(s)) return ['ruim', IC.x];
    return ['atencao', IC.espera];
  }
  function limpo(t) { t = String(t || '').replace(/\s+/g, ' ').trim(); return vazio(t) ? '' : t; }
  function desenharAprovacao() {
    if (!APROV) return;
    var linhas = [].slice.call(APROV.reg.querySelectorAll('.t-Timeline-item')).map(function (li) {
      function c(s) { var e = li.querySelector(s); return e ? limpo(e.textContent) : ''; }
      var datas = [c('.t-Timeline-desc'), c('.t-Timeline-date')].filter(function (x) { return /\d{2}\/\d{2}\/\d{4}/.test(x); });
      var tit = c('.t-Timeline-title'), desc = c('.t-Timeline-desc');
      return { quem: c('.t-Timeline-username'), status: c('.t-Timeline-typename'), data: datas[0] || '',
        just: [tit, /\d{2}\/\d{2}\/\d{4}/.test(desc) ? '' : desc].filter(Boolean).join(' — ') };
    });
    if (!linhas.length) linhas = [].slice.call(APROV.reg.querySelectorAll('table.t-Report-report tbody tr')).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; }
      return { quem: c('APROVADOR'), data: c('DATA'), status: c('STATUS'), just: c('JUSTIFICATIVA') };
    });
    linhas = linhas.filter(function (l) { return l.quem || l.status; });
    var ol = APROV.sec.querySelector('[data-slot="lista"]');
    html(ol, !linhas.length ? '<li class="nc-aci-aprov-vazio">Ainda não há aprovação registrada.</li>' : linhas.map(function (l) {
      var t = tomAprov(l.status);
      return '<li class="nc-aci-aprov-item nc-aci-aprov-item--' + t[0] + '"><span class="nc-aci-aprov-marca" aria-hidden="true">' + svg(t[1]) + '</span>' +
        '<div class="nc-aci-aprov-txt"><b>' + esc(l.quem || 'Aprovador') + '</b>' +
          '<span><span class="nc-aci-aprov-status">' + esc(l.status || 'Aguardando') + '</span>' + (l.data ? ' · ' + esc(l.data) : '') + '</span>' +
          (l.just ? '<q>' + esc(l.just) + '</q>' : '') + '</div></li>';
    }).join(''));
  }

  /* ═══ [J9] O RODAPÉ ═══════════════════════════════════════════════════════════════════════
     O QUE FAZ  Acha o botão "Criar" / "Criar Requisição" do APEX, troca o texto para
                "Enviar comunicação" e leva a região dele para o fim dos passos, onde ela gruda
                no pé da tela. Ao lado, a lista do que falta: clicar num item leva ao campo.
     CUIDADO    O botão é achado pelo TEXTO "Criar" ou "Criar Requisição". Se o rótulo do botão
                mudar no APEX, o rodapé deixa de ser montado.
     PODE MEXER o texto 'Enviar comunicação'.
     VISUAL     Natcorp_Acidente.css › [C13]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function rodape() {
    var criar = [].slice.call(document.querySelectorAll('.t-Button')).filter(function (b) { return /^criar( requisi[çc][ãa]o)?$/i.test(b.textContent.trim()); })[0];
    if (!criar) return;
    criar.setAttribute('data-nc-envia', '1');
    criar.classList.add('nc-aci-enviar');
    var l = criar.querySelector('.t-Button-label');
    if (l) l.textContent = 'Enviar comunicação'; else criar.textContent = 'Enviar comunicação';
    /* a região do botão vai para o fim dos passos: é ali dentro que ela gruda no pé da tela */
    var reg = criar.closest('.t-Region');
    if (reg) { reg.classList.add('nc-aci-rodape'); CAIXA.appendChild(reg); }
    FALTA = el('div', 'nc-aci-falta');
    FALTA.setAttribute('aria-live', 'polite');
    criar.parentNode.insertBefore(FALTA, criar);
    FALTA.addEventListener('click', function (e) {
      var b = e.target.closest('[data-ir]'); if (!b) return;
      irPara(b.getAttribute('data-ir'));
    });
  }
  function irPara(n) {
    var alvo = n === '__corpo' ? (CORPO && (CORPO.add || CORPO.reg)) : cont(n);
    if (!alvo) return;
    alvo.scrollIntoView({ behavior: 'smooth', block: 'center' });
    var i = n === '__corpo' ? CORPO.add : alvo.querySelector('input:not([type=hidden]):not([disabled]), textarea, select');
    if (i) setTimeout(function () { try { i.focus({ preventScroll: true }); } catch (x) { i.focus(); } }, 350);
  }

  /* ═══ [J10] ATALHOS DE DATA E ROTEIRO DO RELATO ══════════════════════════════════════════
     O QUE FAZ  • Botões "Hoje" / "Ontem" na data do acidente e "Mesmo dia do acidente" no
                  último dia trabalhado. Eles preenchem o item pelo jeito oficial do APEX
                  (apex.item…setValue), então as ações dinâmicas rodam como se fosse digitado.
                • "Me ajude a contar": escreve no relato as três perguntas do ROTEIRO ([J2]).
                • Dicas gentis quando o relato ou o "ponto exato" estão curtos demais
                  (menos de 40 e 10 letras), ou quando o relato só tem as perguntas.
     PODE MEXER os textos dos botões ('Hoje', 'Ontem', 'Mesmo dia do acidente', 'Me ajude a
                contar'), as dicas entre aspas e os mínimos de letras (40 e 10).
     VISUAL     Natcorp_Acidente.css › [C14]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function fmt(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear(); }
  function atalho(n, botoes) {
    var c = cont(n), ic = c && c.querySelector('.t-Form-inputContainer'); if (!ic) return;
    var box = el('div', 'nc-aci-atalhos');
    box.setAttribute('data-de', n);
    box.innerHTML = botoes.map(function (b) { return '<button type="button" class="nc-aci-atalho" data-v="' + b[0] + '">' + esc(b[1]) + '</button>'; }).join('');
    ic.appendChild(box);
    box.addEventListener('click', function (e) {
      var b = e.target.closest('[data-v]'); if (!b) return;
      var v = b.getAttribute('data-v'), hoje = new Date();
      var dt = v === 'hoje' ? fmt(hoje) : v === 'ontem' ? fmt(new Date(hoje.getFullYear(), hoje.getMonth(), hoje.getDate() - 1)) : val('DT_ACIDENTE');
      if (dt) apex.item(P + n).setValue(dt);      /* com o change: as ações da página rodam como se fosse digitado */
    });
  }
  function atalhos() {
    atalho('DT_ACIDENTE', [['hoje', 'Hoje'], ['ontem', 'Ontem']]);
    atalho('DT_ULT_DIA_TRAB', [['igual', 'Mesmo dia do acidente']]);
  }
  function desenharAtalhos() {
    [].forEach.call(CAIXA.querySelectorAll('.nc-aci-atalhos'), function (box) {
      var n = box.getAttribute('data-de'), v = val(n), hoje = new Date();
      [].forEach.call(box.querySelectorAll('[data-v]'), function (b) {
        var k = b.getAttribute('data-v');
        var alvo = k === 'hoje' ? fmt(hoje) : k === 'ontem' ? fmt(new Date(hoje.getFullYear(), hoje.getMonth(), hoje.getDate() - 1)) : val('DT_ACIDENTE');
        b.setAttribute('aria-pressed', v && v === alvo ? 'true' : 'false');
        if (k === 'igual') b.hidden = !val('DT_ACIDENTE');
      });
    });
  }
  function roteiro() {
    var c = cont('DESCRICAO_TEXTO'), t = document.getElementById(P + 'DESCRICAO_TEXTO'); if (!c || !t) return;
    var ic = c.querySelector('.t-Form-inputContainer'); if (!ic) return;
    var b = el('button', 'nc-aci-roteiro', svg(IC.relato) + '<span>Me ajude a contar</span>');
    b.type = 'button';
    ic.insertBefore(b, ic.firstChild);
    b.addEventListener('click', function () {
      if (!t.value.trim()) apex.item(P + 'DESCRICAO_TEXTO').setValue(ROTEIRO);
      var fim = t.value.indexOf('\n'); fim = fim < 0 ? t.value.length : fim;
      t.focus(); try { t.setSelectionRange(fim, fim); } catch (x) {}
      agendar();
    });
    [['DESCRICAO_TEXTO', 40], ['ESPEC_LOCAL_ACIDENTE', 10]].forEach(function (d) {
      var k = cont(d[0]), ik = k && k.querySelector('.t-Form-inputContainer');
      if (ik) { var p = el('p', 'nc-aci-dica'); p.hidden = true; p.setAttribute('data-de', d[0]); p.setAttribute('data-min', d[1]); p.setAttribute('aria-live', 'polite'); ik.appendChild(p); }
    });
  }
  /* o relato com só as três perguntas do roteiro ainda não foi contado */
  function soRoteiro() { return val('DESCRICAO_TEXTO').replace(/\s+/g, ' ').trim() === ROTEIRO.replace(/\s+/g, ' ').trim(); }
  /* o relato "OK" não ajuda ninguém: um aviso gentil quando o texto é curto demais */
  function desenharDicas() {
    var rot = CAIXA.querySelector('.nc-aci-roteiro'), t = document.getElementById(P + 'DESCRICAO_TEXTO');
    if (rot && t) rot.hidden = !!t.value.trim();
    [].forEach.call(CAIXA.querySelectorAll('.nc-aci-dica'), function (p) {
      var n = p.getAttribute('data-de'), v = val(n), min = +p.getAttribute('data-min');
      var roteiroSo = n === 'DESCRICAO_TEXTO' && soRoteiro();
      var curto = v && (v.replace(/\s+/g, '').length < min || roteiroSo);
      p.hidden = !curto;
      if (curto) html(p, svg(IC.info) + '<span>' + (n === 'DESCRICAO_TEXTO'
        ? (roteiroSo ? 'Responda cada pergunta depois dos dois-pontos.' : 'Está curto. Conte o que a pessoa fazia, o que aconteceu e o que causou.')
        : (simNao('IND_TRAJETO') === 'S' ? 'Diga o lugar do caminho: rua, número perto, ponto de ônibus…' : 'Diga o lugar exato: setor, máquina, escada, sala…')) + '</span>');
    });
  }

  /* ═══ [J11] O MAESTRO DA COMUNICAÇÃO ═════════════════════════════════════════════════════
     O QUE FAZ  atualizar() roda de novo sempre que algo muda (um campo, uma resposta de ação
                dinâmica, o relatório das partes) e refaz o que depende das respostas:
                o cartão da pessoa, o "Pronto / Falta N campos" de cada passo, a ficha, o
                rodapé, e o resumo do "quando" (dia da semana, "Há 3 dias", e avisos de data no
                futuro ou de último dia trabalhado depois do acidente).
     O QUE CONTA COMO "FALTA"  Os campos com "Value Required" no APEX que estão à vista e
                liberados; e mais dois que a página não exige mas o médico precisa: a parte
                do corpo e o "atendimento médico" (o envio continua livre).
     NO CAMINHO DO TRABALHO  trajeto() troca o rótulo e o exemplo do "ponto exato" (lista
                TEXTOS_ONDE, PODE MEXER).
     CUIDADO    Não mude a ordem das chamadas dentro de atualizar(): umas dependem das outras.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var tAg = 0;
  function agendar() { clearTimeout(tAg); tAg = setTimeout(atualizar, 60); }

  function obrigatorio(c) { return c.classList.contains('is-required'); }

  function atualizar() {
    var nPartes = desenharCorpo();
    if (!LEITURA) { conferirEnderecoCorpo(); desenharAvisoCorpo(false); desenharAtalhos(); desenharDicas(); trajeto(); telefone(); }

    /* o cartão da pessoa só existe com a pessoa escolhida; o que veio vazio não ocupa lugar */
    var pessoa = CAIXA.querySelector('.nc-aci-pessoa');
    if (pessoa) {
      var nome = txt('NOME');
      pessoa.classList.toggle('nc-aci-oculto', vazio(nome));
      var av = pessoa.querySelector('.nc-aci-pessoa-av');
      var p = nomeProprio(nome).split(/\s+/).filter(Boolean);
      html(av, esc(((p[0] || '').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase()));
      PASSOS[0].pessoa.forEach(function (n) { var c = cont(n); if (c) c.classList.toggle('nc-aci-oculto', vazio(txt(n))); });
    }
    var tel = cont('TELEFONE_FUNC_1_DSP'), ti = document.getElementById(P + 'TELEFONE_FUNC_1_DSP');
    if (tel && ti) tel.classList.toggle('nc-aci-oculto', ti.disabled && !/\d/.test(ti.value));
    /* 04/10: o "Documento do atendimento" (P91_ARQ) NÃO é mais escondido até o "Sim": a página não
       tem essa regra (nenhuma ação dinâmica o esconde), e com "Não" depois de anexar o arquivo ia
       escondido no envio. Só a página mostra/esconde campo. */

    var faltam = [];
    var editavel = !!document.querySelector('[data-nc-envia]');
    SECS.forEach(function (s) {
      var req = (s.p.itens || []).filter(function (n) {
        var c = cont(n);
        if (!c || escondido(c) || c.classList.contains('nc-aci-oculto')) return false;
        var i = document.getElementById(P + n);
        if (i && (i.disabled || i.type === 'hidden')) return false;
        return obrigatorio(c);
      });
      var f = req.filter(function (n) { return vazio(val(n)) || (n === 'DESCRICAO_TEXTO' && soRoteiro()); });
      if (s.p.corpo && editavel && CORPO && CORPO.add) { req.push('__corpo'); if (!nPartes) f.push('__corpo'); }
      /* o atendimento médico não é obrigatório para a página, mas sem ele a ficha fica "Não
         informado" para o médico: entra no que falta (o envio continua livre) */
      if (s.p.id === 'depois' && editavel && cont('SERV_MED_ATEND')) { req.push('SERV_MED_ATEND'); if (!simNao('SERV_MED_ATEND')) f.push('SERV_MED_ATEND'); }
      f.forEach(function (n) { faltam.push(n); });
      var est = s.sec.querySelector('.nc-aci-passo-estado');
      var mostra = editavel && req.length;
      classe(est, 'nc-aci-passo-estado' + (!mostra ? '' : f.length ? ' is-falta' : ' is-ok'));
      html(est, !mostra ? '' : f.length ? 'Falta ' + plural(f.length, 'campo', 'campos') : svg(IC.ok) + 'Pronto');
      s.sec.classList.toggle('is-ok', !!mostra && !f.length);
    });

    quando();
    desenharFicha();
    if (FICHA && PREVIA) FICHA.hidden = vazio(val('MATRICULA'));

    if (FALTA) {
      var criar = document.querySelector('[data-nc-envia]');
      var podeEnviar = criar && criar.style.display !== 'none';
      html(FALTA, faltam.length
        ? '<span class="nc-aci-falta-rot">Falta</span>' + faltam.map(function (n) { return '<button type="button" class="nc-aci-falta-item" data-ir="' + n + '">' + esc(CURTOS[n] || n) + '</button>'; }).join('') +
          (faltam.length > 3 ? '<span class="nc-aci-falta-mais" aria-hidden="true">+' + (faltam.length - 3) + '</span>' : '')
        : podeEnviar ? '<span class="nc-aci-pronto">' + svg(IC.ok) + 'Tudo preenchido. Pode enviar.</span>' : '');
    }
  }

  /* PODE MEXER: no caminho do trabalho, o ponto exato é o lugar do caminho (o endereço é o do local de trabalho).
     Cada linha: [rótulo, exemplo na caixa vazia, frase sobre o endereço]. N = no trabalho, S = no caminho. */
  var TEXTOS_ONDE = {
    N: ['Em que ponto exatamente?', 'Ex.: escada do bloco B, perto da máquina de corte, estacionamento, calçada em frente ao nº 100', 'vem do cadastro do local de trabalho'],
    S: ['Em que ponto do caminho?', 'Ex.: Av. Brasil, perto do nº 200, no ponto de ônibus', 'é o do local de trabalho; o lugar do caminho vai no campo acima']
  };
  function trajeto() {
    var t = TEXTOS_ONDE[simNao('IND_TRAJETO') === 'S' ? 'S' : 'N'];
    var c = cont('ESPEC_LOCAL_ACIDENTE'), l = c && c.querySelector('.t-Form-label'), i = document.getElementById(P + 'ESPEC_LOCAL_ACIDENTE');
    if (l && l.firstChild && l.firstChild.nodeType === 3 && l.firstChild.nodeValue !== t[0] + ' ') l.firstChild.nodeValue = t[0] + ' ';
    if (i && i.getAttribute('placeholder') !== t[1]) i.setAttribute('placeholder', t[1]);
    var sm = CAIXA.querySelector('.nc-aci-endereco-tit small'); if (sm && sm.textContent !== t[2]) sm.textContent = t[2];
  }
  function telefone() {
    var aj = document.getElementById(P + 'TELEFONE_FUNC_1_DSP_NC_AJUDA'), i = document.getElementById(P + 'TELEFONE_FUNC_1_DSP');
    if (!aj || !i) return;
    var t = !vazio(txt('NOME')) && !/\d/.test(i.value) && !i.disabled ? 'Não há telefone no cadastro. Se souber, informe aqui.' : 'Para a equipe de saúde falar com ela, se precisar.';
    if (aj.textContent !== t) aj.textContent = t;
  }

  /* o resumo do "quando" — dia da semana, e os erros de data que dá para ver na hora */
  function quando() {
    var box = CAIXA.querySelector('.nc-aci-quando'); if (!box) return;
    if (LEITURA) { box.hidden = true; return; }
    var d = data(val('DT_ACIDENTE')), u = data(val('DT_ULT_DIA_TRAB')), h = val('HOR_ACIDENTE');
    if (!d) { box.hidden = true; return; }
    box.hidden = false;
    var hoje = new Date(); hoje.setHours(0, 0, 0, 0);
    if (d > hoje) {
      classe(box, 'nc-aci-quando is-erro');
      html(box, svg(IC.alerta) + '<span>A data do acidente está <b>no futuro</b>. Confira o dia.</span>');
      return;
    }
    if (u && u > d) {
      classe(box, 'nc-aci-quando is-erro');
      html(box, svg(IC.alerta) + '<span>O <b>último dia trabalhado</b> está depois do dia do acidente. Confira as datas.</span>');
      return;
    }
    classe(box, 'nc-aci-quando');
    var ha = Math.round((hoje - d) / 864e5);
    html(box, svg(IC.tempo) + '<span><b>' + DIAS[d.getDay()].charAt(0).toUpperCase() + DIAS[d.getDay()].slice(1) + ', ' + esc(val('DT_ACIDENTE')) + '</b>' +
      (/^\d{2}:\d{2}$/.test(h) ? ', às <b>' + esc(h) + '</b>' : '') + '. ' + (ha === 0 ? 'Hoje.' : ha === 1 ? 'Ontem.' : 'Há ' + plural(ha, 'dia', 'dias') + '.') + '</span>');
  }

  /* ═══ [J12] CONFIGURAÇÃO DA ANÁLISE (página 31) ══════════════════════════════════════════
     O QUE É    As listas que dizem COMO a página 31 é organizada.
     PODE MEXER • FRENTES: as 4 frentes (botões grandes no alto) e, dentro de cada uma, os
                  blocos com título (t). Cada bloco tem:
                    itens    os campos, cada um como ['NOME_DO_ITEM', largura] — a largura é
                             1 (um quarto da linha), 2 (meia linha) ou 4 (linha inteira)
                    regioes  regiões inteiras do APEX, pelo Static ID
                • REGIOES: o título na tela de cada região inteira e, quando ela é uma lista,
                  a palavra que completa o botão "Adicionar …" (ex.: 'testemunha').
                • REPETIDOS: campos que repetem o que o caso já mostra; somem da frente.
                • ROTULOS_ANALISE: rótulo, ajuda e exemplo de cada campo (mesmo formato de
                  ROTULOS em [J2]).
     CUIDADO    Não mude os "id" das frentes ('atend', 'cat', 'local', 'inv'). A frente 'inv'
                tem  indice: true  (o índice de [J17]); não tire.
                Uma região só entra numa frente se a ABA dela estiver à vista no APEX (é o
                perfil da página que decide): esconder a aba esconde a região aqui também.
     VISUAL     Natcorp_Acidente.css › [C16] e [C17]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* =====================================================================
     A ANÁLISE (Médico do Trabalho / Técnico de Segurança): a página "Criar/Editar: Comunicação de
     Acidente de Trabalho". Treze abas viram quatro FRENTES de trabalho, com o caso fixo ao lado:
       · Atendimento médico — quem atendeu, a lesão, internação e afastamento, observações
       · Classificação da CAT — tipo, CAT, classificação, iniciativa, óbito, B.O., registros
       · Acidente e local — quem, quando, onde, o relato e as partes do corpo (a grade)
       · Investigação — avaliador, fatores, serviço, consequência, testemunhas… conclusão
     O que o perfil da página esconde (as abas de segurança, os fatores para a área médica)
     continua escondido: só entra numa frente a região cuja aba o APEX deixou à vista.
     ===================================================================== */
  /* PODE MEXER: as frentes e os blocos (ver o quadro [J12] acima) */
  var FRENTES = [
    { id: 'atend', ic: 'cruz', titulo: 'Atendimento médico', blocos: [
      { t: 'Quem atendeu', itens: [['COD_MED_EMIT_CAT_1', 2], ['SERV_MED_ATEND', 2], ['DT_ATEND', 1], ['HORA_ATEND', 1], ['HORA_ATEND_TXT', 1], ['QTDE_DIAS_TRATAMENTO', 1]] },
      { t: 'A lesão', itens: [['CID', 2], ['CODIGO', 2], ['DIAGNO_PROVAVEL', 4], ['COD_AGENTE_LESAO', 2], ['COD_FATOR_TRABALHO', 2]] },
      { t: 'Internação e afastamento', itens: [['IND_PROT_TIPO_ACIDENTE', 1], ['IND_AFASTAMENTO', 1], ['QTD_DIAS_AFASTAMENTO', 1], ['DT_RETORNO', 1]], resumo: 'afast' },
      { t: 'Observações e documento', itens: [['OBSERVACAO_CAT', 4], ['OBSERVACAO', 4], ['ARQ', 4]] }
    ] },
    { id: 'cat', ic: 'ficha', titulo: 'Classificação da CAT', blocos: [
      { t: 'Tipo e classificação', itens: [['COD_ANALISE_ACIDENTE', 1], ['COD_ACIDENTE_TIPO', 2], ['TIPO_ANALISE', 2], ['CLASS_ACIDENTE', 2], ['TP_REGISTRO_CAT', 2], ['AFASTAMENTO_IMEDIATO', 2], ['STATUS_CAT', 1]] },
      { t: 'Jornada no dia', itens: [['DT_ULT_DIA_TRAB', 1], ['HORAS_TRAB', 1]] },
      { t: 'Óbito e registro policial', itens: [['IND_OBITO', 2], ['DT_OBITO', 1], ['IND_EXPERIENCIA_OPERACAO', 2], ['IND_DEPTO_POLICIAL', 1], ['NUM_BOLETIM_OCORR', 1], ['DATA_BOLETIM_OCORR', 1], ['ARQ_BO', 4]] },
      { t: 'Registro da CAT', itens: [['NUM_PROTOCOLO', 2], ['DT_EMISSAO_CAT', 1], ['IND_ACIDENTE_ANTERIOR', 1], ['COD_SISAN', 2], ['DT_CONCLUSAO_SISAN', 1]] }
    ] },
    { id: 'local', ic: 'local', titulo: 'Acidente e local', blocos: [
      { t: 'Quem e quando', itens: [['COD_EMPRESA', 2], ['MATRICULA', 2], ['DT_ACIDENTE', 1], ['HOR_ACIDENTE', 1], ['COD_EMP_SOLICITANTE', 1], ['MAT_SOLICITANTE', 1]] },
      { t: 'Onde', itens: [['TIPO_LOCAL_ACIDENTE', 2], ['IND_TRAJETO', 2], ['COD_EMP_ACIDENTE', 2], ['COD_FIL_ACIDENTE', 2], ['COD_LOCAL_TRAB', 2], ['CNPJ_LOCAL_ACIDENTE', 2],
        ['CEP_DSP', 1], ['COD_TP_LOGR', 1], ['ENDERECO_ACIDENTE', 2], ['NUM_LOCAL_ACIDENTE', 1], ['COMPLEMENTO', 1], ['BAIRRO_ACIDENTE', 2], ['LOCAL_ACIDENTE', 2], ['UF_LOCAL_ACIDENTE', 1], ['PAIS_ACIDENTE', 1],
        ['CX_POSTAL', 1], ['ESPEC_LOCAL_ACIDENTE', 4]] },
      { t: 'Relato e parte do corpo', regioes: ['ACIDENTE', 'PARTE'] }
    ] },
    /* na ordem de uma investigação: quem investiga → o que a pessoa fazia → por que aconteceu →
       o que causou → quem viu → proteção e custos → o que fazer → como terminou */
    { id: 'inv', ic: 'aprovacao', titulo: 'Investigação', indice: true, blocos: [
      { t: 'Quem investiga', regioes: ['AVALIADOR'] },
      { t: 'O que a pessoa fazia', regioes: ['SERVICO', 'COLABORADOR'] },
      { t: 'Por que aconteceu', regioes: ['DIAGRAMA'] },
      { t: 'Consequências', regioes: ['CONSEQUENCIA'] },
      { t: 'Quem viu', regioes: ['TESTEMUNHA', 'TERCEIROS'] },
      { t: 'Proteção e custos', regioes: ['EPI', 'CUSTO'] },
      { t: 'O que fazer e conclusão', regioes: ['PLANO', 'CONCLUSAO'] }
    ] }
  ];
  /* PODE MEXER: a ordem das frentes num acidente NOVO (página aberta pelo "Criar", sem registro):
     primeiro o básico — quem, quando, onde, o relato e a parte do corpo —, depois o atendimento,
     a CAT e a investigação. No acidente já registrado vale a ordem de FRENTES. */
  var ORDEM_NOVO = ['local', 'atend', 'cat', 'inv'];
  /* PODE MEXER: nomes das regiões na tela (o título do APEX é trocado só no texto) e o que cada lista acrescenta */
  var REGIOES = {
    ACIDENTE: ['Relato do acidente'], PARTE: ['Partes do corpo atingidas', 'parte'],
    AVALIADOR: ['Avaliadores'], COLABORADOR: ['Fatores do acidente'], SERVICO: ['Tarefa e providências'],
    CONSEQUENCIA: ['Danos causados'], TESTEMUNHA: ['Testemunhas da empresa', 'testemunha'], TERCEIROS: ['Testemunhas de fora (terceiros)', 'terceiro'],
    EPI: ['EPIs em uso no momento', 'EPI'], CUSTO: ['Custos do acidente', 'custo'], PLANO: ['Plano de ação'],
    DIAGRAMA: ['Causas pelos 6Ms'], CONCLUSAO: ['Conclusão e acompanhamento']
  };
  /* PODE MEXER: o que repete o que o caso já mostra (exibição só): sai da frente */
  var REPETIDOS = [];   /* 04/10: vazio — tudo o que a página mostra, o desenho mostra (antes saíam os _DSP que repetem o caso) */
  /* PODE MEXER: rótulo, ajuda e exemplo de cada campo da análise */
  var ROTULOS_ANALISE = {
    COD_MED_EMIT_CAT_1: ['Médico que atendeu', 'Não está na lista? Use "Cadastrar médico", logo abaixo.'],
    SERV_MED_ATEND: ['Unidade de atendimento', 'Hospital, pronto-socorro, clínica ou ambulatório.'],
    DT_ATEND: ['Data do atendimento'], HORA_ATEND: ['Hora do atendimento', '', 'Ex.: 14:30'], HORA_ATEND_TXT: ['Hora do atendimento'],
    QTDE_DIAS_TRATAMENTO: ['Tratamento provável (dias)'],
    CID: ['CID'], COD_ANALISE_ACIDENTE: ['Código da análise'], CODIGO: ['Descrição da lesão'], DIAGNO_PROVAVEL: ['Diagnóstico provável'],
    COD_AGENTE_LESAO: ['Agente da lesão'], COD_FATOR_TRABALHO: ['Situação geradora'],
    IND_PROT_TIPO_ACIDENTE: ['Houve internação?'], IND_AFASTAMENTO: ['Houve afastamento?'], QTD_DIAS_AFASTAMENTO: ['Dias de afastamento'], DT_RETORNO: ['Data da alta'],
    OBSERVACAO_CAT: ['Observação da CAT', 'Acompanha a CAT.'], OBSERVACAO: ['Observação médica', 'Anotações do médico sobre o caso.'], ARQ: ['Documento', 'Atestado, laudo ou relatório (foto ou PDF).'],
    COD_ACIDENTE_TIPO: ['Tipo de acidente'], TIPO_ANALISE: ['Tipo de CAT'], CLASS_ACIDENTE: ['Classificação do acidente'], TP_REGISTRO_CAT: ['Iniciativa da CAT'],
    AFASTAMENTO_IMEDIATO: ['Afastamento imediato?'], STATUS_CAT: ['Status da investigação'],
    DT_ULT_DIA_TRAB: ['Último dia trabalhado'], HORAS_TRAB: ['Horas trabalhadas antes do acidente', '', 'Ex.: 06:30'],
    IND_OBITO: ['Houve óbito?'], DT_OBITO: ['Data do óbito'], IND_EXPERIENCIA_OPERACAO: ['Houve registro policial?'],
    IND_DEPTO_POLICIAL: ['Delegacia (D.P.)'], NUM_BOLETIM_OCORR: ['Nº do B.O.'], DATA_BOLETIM_OCORR: ['Data do B.O.'], ARQ_BO: ['Documento do B.O.'],
    NUM_PROTOCOLO: ['Número da CAT'], DT_EMISSAO_CAT: ['Registro na Previdência'], IND_ACIDENTE_ANTERIOR: ['Acidente anterior?'], COD_SISAN: ['Registro SINAN'], DT_CONCLUSAO_SISAN: ['Conclusão SINAN'],
    COD_EMP_SOLICITANTE: ['Empresa de quem comunicou'], MAT_SOLICITANTE: ['Quem comunicou'],
    TIPO_LOCAL_ACIDENTE: ['Tipo de local'], IND_TRAJETO: ['Acidente de trajeto?'], COD_EMP_ACIDENTE: ['Empresa do local'], COD_FIL_ACIDENTE: ['Filial do local'],
    COD_LOCAL_TRAB: ['Local de trabalho'], CNPJ_LOCAL_ACIDENTE: ['CNPJ do local'], COD_TP_LOGR: ['Tipo de logradouro'], LOCAL_ACIDENTE: ['Município'], PAIS_ACIDENTE: ['País'],
    ESPEC_LOCAL_ACIDENTE: ['Especificação do local'], DESCRICAO_TEXTO: ['Relato do acidentado'], DESCRICAO_OBSERVACAO: ['Informações complementares'],
    CIPEIRO_AREA: ['Cipeiro da área'], COD_EMPRESA_TEC_SEGURANCA: ['Empresa'], MATRICULA_TEC_SEGURANCA: ['Técnico de segurança'],
    COD_EMPRESA_ENG_SEGURANCA: ['Empresa'], MATRICULA_ENG_SEGURANCA: ['Engenheiro de segurança'],
    COD_FATOR_PESSOAL: ['Fator pessoal'], COD_ATO_INSEGURO: ['Ato inseguro'], COD_CONDICAO_INSEGURA: ['Condição insegura'],
    SERVICO_TEXTO: ['Tarefa que a pessoa executava', '', 'Ex.: troca de peça na esteira 2, com a máquina parada'],
    TEXTO_PROV_IMEDIATAS: ['Providências imediatas', '', 'O que foi feito na hora. Ex.: primeiros socorros, área isolada'],
    TEXTO_PROV_MEDIATAS: ['Providências posteriores', '', 'O que foi feito depois. Ex.: troca da proteção, novo treinamento'],
    TEXTO_DADOS_PESSOAIS: ['Danos pessoais', '', 'Ex.: corte no antebraço, 3 dias de afastamento'],
    TEXTO_DADOS_MATERIAIS: ['Danos materiais', '', 'Ex.: ferramenta quebrada, EPI danificado'],
    TEXTO_DADOS_PRODUCAO: ['Danos à produção', '', 'Ex.: linha parada por 2 horas'],
    ITEM_1: ['Meio ambiente', '', 'Ex.: piso molhado, pouca luz, ruído, calor'],
    ITEM_2: ['Máquina', '', 'Ex.: proteção faltando, falha no equipamento'],
    ITEM_3: ['Matéria-prima', '', 'Ex.: material pesado, cortante, produto químico'],
    ITEM_4: ['Mão de obra', '', 'Ex.: falta de treino, pressa, cansaço'],
    ITEM_5: ['Método', '', 'Ex.: procedimento inexistente ou não seguido'],
    ITEM_6: ['Medida', '', 'Ex.: medição errada, instrumento sem calibração'],
    EFEITO: ['Efeito', 'O resultado das causas acima.'],
    TIPO_ACAO: ['Tipo de ação'], PLANO_TEXTO: ['Descrição da ação'], PLANO_OQUE: ['O quê', '', 'O que será feito'],
    PLANO_COMO: ['Como', '', 'Como será feito'], PLANO_QUANDO: ['Quando', '', 'Prazo. Ex.: até 30/10'],
    CONCLUSAO_TEXTO: ['Acompanhamento', '', 'Como o caso terminou e o que continua sendo acompanhado']
  };
  /* ═══ [J13] MONTAR A ANÁLISE ═════════════════════════════════════════════════════════════
     O QUE FAZ  montarAnalise() cria a "mesa": o cabeçalho do caso no alto, o caso fixo à
                esquerda (desce junto ao rolar) e, à direita, os botões das frentes e a frente
                aberta. Os campos e regiões do APEX são levados para as frentes conforme
                FRENTES ([J12]). A barra do pé recebe o botão Salvar do APEX, que também
                responde a Ctrl+S (⌘S no Mac). O botão "Cadastro de Médico" vira
                "Cadastrar médico", logo abaixo do campo do médico.
     A FRENTE ABERTA  fica guardada no navegador (sessionStorage) por análise: ao voltar à mesma
                análise, ela abre na frente em que a pessoa estava.
     TOPO GRUDADO  O título da página do APEX gruda no alto ao rolar; medirTopo() mede onde ele
                termina para o caso e as frentes grudarem logo abaixo.
     NO CELULAR  O caso começa resumido (pessoa, quando, onde), com "Ver mais do caso".
     CUIDADO    O Salvar é achado pelo TEXTO "Salvar"; se o rótulo mudar no APEX, ele não vai
                para a barra do pé.
     VISUAL     Natcorp_Acidente.css › [C16]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var AN = { frentes: [], caso: null, barra: null, falta: null, ativa: '' };
  /* no celular o caso começa resumido (pessoa, quando, onde): o trabalho aparece logo */
  var CASO_ABERTO = !(window.matchMedia && window.matchMedia('(max-width: 760px)').matches);

  function montarAnalise() {
    document.body.classList.add('nc-aci', 'nc-aci-analise');
    /* acidente NOVO: a página veio pelo "Criar" (sem registro, P31_ROWID vazio) */
    AN.novo = vazio(val('ROWID'));
    if (AN.novo) document.body.classList.add('nc-aci-novo');
    var rds = document.querySelector('.apex-rds-container');
    var topo = (rds && rds.closest('.t-Region')) || document.getElementById('ANALISE');
    while (topo.parentElement && topo.parentElement.closest('.t-Region')) topo = topo.parentElement.closest('.t-Region');

    var raiz = el('div', 'nc-aci-analise-raiz');
    raiz.innerHTML = '<section class="nc-aci-caso-cab" aria-label="Análise do acidente"></section>' +
      '<div class="nc-aci-mesa"><aside class="nc-aci-caso" aria-label="O caso"></aside>' +
      '<div class="nc-aci-trabalho nc-aci-passos"><nav class="nc-aci-frentes" role="tablist" aria-label="Frentes da análise"></nav></div></div>';
    topo.parentNode.insertBefore(raiz, topo);
    CAIXA = raiz;
    var trab = raiz.querySelector('.nc-aci-trabalho'), nav = raiz.querySelector('.nc-aci-frentes');
    AN.caso = raiz.querySelector('.nc-aci-caso');

    /* TODAS as regiões das FRENTES entram; o que o perfil esconde é seguido ao vivo por
       sincronizarPerfil() ([J15]) — a ação "Area Segurança / Médica" da página roda DEPOIS do
       desenho (espera o servidor), então decidir aqui, na montagem, pegava o perfil errado */
    AN.regs = [];

    var ordem = AN.novo ? ORDEM_NOVO.map(function (id) { return FRENTES.filter(function (f) { return f.id === id; })[0]; }).filter(Boolean)
      .concat(FRENTES.filter(function (f) { return ORDEM_NOVO.indexOf(f.id) < 0; })) : FRENTES;
    ordem.forEach(function (f) {
      var box = el('div', 'nc-aci-frente');
      box.id = 'nc-aci-f-' + f.id;
      box.setAttribute('role', 'tabpanel');
      box.setAttribute('aria-labelledby', 'nc-aci-fb-' + f.id);
      var temAlgo = false;
      f.blocos.forEach(function (b) {
        var sec = el('section', 'nc-aci-bloco' + (b.regioes ? ' nc-aci-bloco--regioes' : ''));
        if (b.t) sec.innerHTML = '<h3 class="nc-aci-bloco-tit">' + esc(b.t) + '</h3>';
        var grade = el('div', b.regioes ? 'nc-aci-regioes' : 'nc-aci-grade');
        (b.itens || []).forEach(function (x) {
          var c = cont(x[0]); if (!c) return;
          grade.appendChild(pegar(c, x[0]));
          c.classList.add('nc-aci-larg-' + x[1]);
          temAlgo = true;
        });
        (b.regioes || []).forEach(function (id) {
          var r = document.getElementById(id); if (!r) return;
          if (r.classList.contains('a-Tabs-panel')) r.style.display = '';   /* era a aba escondida */
          r.classList.add('nc-aci-sub', 'nc-aci-inv');
          AN.regs.push(r);
          grade.appendChild(r);
          temAlgo = true;
        });
        if (b.resumo === 'afast') grade.appendChild(el('p', 'nc-aci-afast', ''));
        if (grade.children.length) { sec.appendChild(grade); box.appendChild(sec); }
      });
      if (!temAlgo) return;
      trab.appendChild(box);
      var bt = el('button', 'nc-aci-frente-bt', '<span class="nc-aci-frente-ic" aria-hidden="true">' + svg(IC[f.ic]) + '</span>' +
        '<span class="nc-aci-frente-txt"><b>' + esc(f.titulo) + '</b><small data-slot="estado"></small></span>');
      bt.type = 'button';
      bt.id = 'nc-aci-fb-' + f.id;
      bt.setAttribute('role', 'tab');
      bt.setAttribute('aria-controls', box.id);
      bt.addEventListener('click', function () { ativar(f.id, true); });
      nav.appendChild(bt);
      AN.frentes.push({ f: f, box: box, bt: bt });
    });

    /* botões: Salvar vai para a barra que gruda no pé; os relatórios, para o cabeçalho do caso */
    montarCabecalhoCaso(raiz.querySelector('.nc-aci-caso-cab'));
    AN.barra = el('div', 'nc-aci-barra');
    AN.barra.innerHTML = '<div class="nc-aci-falta" aria-live="polite"></div>';
    AN.falta = AN.barra.querySelector('.nc-aci-falta');
    trab.appendChild(AN.barra);
    /* acidente novo: o botão é o "Criar" do APEX (o Salvar só existe depois de gravado) */
    var salvar = [].slice.call(document.querySelectorAll('.t-Button')).filter(function (b) { return /^(salvar|criar)$/i.test(b.textContent.trim()); })[0];
    if (salvar) {
      salvar.classList.add('nc-aci-salvar');
      if (/^criar$/i.test(salvar.textContent.trim())) { var lc = salvar.querySelector('.t-Button-label'); if (lc) lc.textContent = 'Criar comunicação'; else salvar.textContent = 'Criar comunicação'; }
      salvar.setAttribute('title', (AN.novo ? 'Criar a comunicação' : 'Salvar') + ' (Ctrl+S)');
      AN.barra.appendChild(salvar);
      document.addEventListener('keydown', function (e) {
        if ((e.ctrlKey || e.metaKey) && !e.shiftKey && !e.altKey && (e.key === 's' || e.key === 'S')) {
          if (salvar.offsetParent === null && getComputedStyle(salvar).position !== 'fixed') return;
          e.preventDefault(); salvar.click();
        }
      });
    }
    AN.falta.addEventListener('click', function (e) { var b = e.target.closest('[data-ir]'); if (b) irParaAnalise(b.getAttribute('data-ir')); });

    /* o médico ao lado do "Cadastrar médico" */
    var cadMed = [].slice.call(document.querySelectorAll('.t-Button')).filter(function (b) { return /cadastro de m[ée]dico/i.test(b.textContent); })[0];
    var cm = cont('COD_MED_EMIT_CAT_1');
    if (cadMed && cm) { cadMed.classList.add('nc-aci-botao-leve'); var l = cadMed.querySelector('.t-Button-label'); if (l) l.textContent = 'Cadastrar médico'; (cm.querySelector('.t-Form-inputContainer') || cm).appendChild(cadMed); }

    /* as regiões que ficaram vazias perdem a moldura; a barra de abas sai */
    if (rds) (rds.closest('.t-Region') || rds).classList.add('nc-aci-fora');
    [].forEach.call(document.querySelectorAll('.t-Region'), function (r) {
      if (raiz.contains(r)) return;
      var vivo = [].some.call(r.querySelectorAll('.t-Form-fieldContainer, .t-Report, .a-IG, .t-Button:not(.t-Button--iconOnly)'), function (x) { return !escondido(x) && !raiz.contains(x); });
      if (!vivo && !/FOOTER/i.test(r.id)) r.classList.add('nc-aci-casca');
    });

    ROTULOS = ROTULOS_ANALISE;
    [].forEach.call(raiz.querySelectorAll('.nc-aci-inv'), prepararRegiao);
    montarIndice();
    montarListas();
    rotulos();
    [].forEach.call(raiz.querySelectorAll('select'), function (s) { segmentar(s); });
    atalho('DT_ATEND', [['igual', 'Mesmo dia do acidente'], ['hoje', 'Hoje']]);

    var guardada = ''; try { if (!AN.novo) guardada = sessionStorage.getItem('nc-aci-frente-' + val('COD_ANALISE_ACIDENTE')) || ''; } catch (x) {}
    ativar(AN.frentes.some(function (x) { return x.f.id === guardada; }) ? guardada : (AN.frentes[0] && AN.frentes[0].f.id), false);

    medirTopo();
    window.addEventListener('resize', pedirTopo);
    window.addEventListener('scroll', pedirTopo, { passive: true });
    $(document).on('change', '[id^="' + P + '"]', agendarAnalise);
    $(document).ajaxComplete(agendarAnalise);
    ['PARTE', 'ACIDENTE'].forEach(function (id) { var r = document.getElementById(id); if (r) $(r).on('apexafterrefresh', agendarAnalise); });
    new MutationObserver(agendarAnalise).observe(raiz.querySelector('.nc-aci-trabalho'), { attributes: true, attributeFilter: ['style', 'disabled'], subtree: true });
    /* o perfil liga e desliga as abas (li "…_tab") e a região AVALIADOR: segue ao vivo */
    var olho = new MutationObserver(function () { sincronizarPerfil(); agendarAnalise(); });
    AN.regs.forEach(function (r) {
      var li = document.getElementById(r.id + '_tab');
      olho.observe(li || r, { attributes: true, attributeFilter: ['style'] });
    });
    sincronizarPerfil();
    atualizarAnalise();
  }

  /* fora do perfil: a aba da região está escondida (li "ID_tab"); região sem aba (Avaliadores),
     quando a própria página a escondeu. Bloco sem nada à vista some; frente vazia também (e, se
     era a aberta, abre a primeira que tem conteúdo). */
  function foraDoPerfil(r) {
    var li = document.getElementById(r.id + '_tab');
    if (li) return li.style.display === 'none';
    return !r.classList.contains('a-Tabs-panel') && r.style.display === 'none';
  }
  function sincronizarPerfil() {
    if (!AN.regs || !AN.frentes.length) return;
    AN.regs.forEach(function (r) { r.classList.toggle('nc-aci-perfil-fora', foraDoPerfil(r)); });
    [].forEach.call(CAIXA.querySelectorAll('.nc-aci-bloco'), function (b) {
      var vivo = [].some.call(b.querySelectorAll(':scope > .nc-aci-grade > *, :scope > .nc-aci-regioes > *'), function (x) {
        return !x.classList.contains('nc-aci-perfil-fora') && !x.classList.contains('nc-aci-oculto') && !x.classList.contains('nc-aci-afast');
      });
      b.classList.toggle('nc-aci-oculto', !vivo);
    });
    AN.frentes.forEach(function (x) {
      x.vazia = ![].some.call(x.box.querySelectorAll('.nc-aci-bloco'), function (b) { return !b.classList.contains('nc-aci-oculto'); });
      x.bt.classList.toggle('nc-aci-oculto', x.vazia);
    });
    var at = AN.frentes.filter(function (x) { return x.f.id === AN.ativa; })[0];
    if (at && at.vazia) { var p = AN.frentes.filter(function (x) { return !x.vazia; })[0]; if (p) ativar(p.f.id, false); }
  }

  /* a folha do APEX tem o título da página grudado no alto: o caso e as frentes grudam logo abaixo */
  /* o título do APEX gruda ao rolar (e muda de altura): mede-se onde ele termina, na hora */
  var ultTopo = -1, pedidoTopo = 0;
  function medirTopo() {
    pedidoTopo = 0;
    var t = document.querySelector('.t-Body-title');
    var fim = 0;
    if (t) { var r = t.getBoundingClientRect(), pos = getComputedStyle(t).position; if (pos === 'fixed' || pos === 'sticky' || r.top <= 0) fim = Math.max(0, Math.round(r.bottom)); }
    var v = fim + 12;
    if (v !== ultTopo) { ultTopo = v; document.documentElement.style.setProperty('--nc-aci-topo', v + 'px'); }
  }
  function pedirTopo() { if (!pedidoTopo) pedidoTopo = requestAnimationFrame(medirTopo); }

  function ativar(id, clicou) {
    AN.ativa = id;
    AN.frentes.forEach(function (x) {
      var on = x.f.id === id;
      x.box.hidden = !on;
      x.bt.setAttribute('aria-selected', on ? 'true' : 'false');
      x.bt.setAttribute('tabindex', on ? '0' : '-1');
      /* grades (IG) e relatórios que estavam escondidos precisam saber que agora aparecem */
      if (on && apex.widget && apex.widget.util && apex.widget.util.visibilityChange) { try { apex.widget.util.visibilityChange(x.box, true); } catch (e) {} }
    });
    setTimeout(function () { [].forEach.call(CAIXA.querySelectorAll('.nc-aci-frente:not([hidden]) textarea'), crescer); }, 30);
    try { sessionStorage.setItem('nc-aci-frente-' + val('COD_ANALISE_ACIDENTE'), id); } catch (x) {}
    if (clicou) { var t = CAIXA.querySelector('.nc-aci-mesa'); if (t && t.getBoundingClientRect().top < 0) t.scrollIntoView({ behavior: 'smooth', block: 'start' }); }
  }

  function irParaAnalise(n) {
    var c = cont(n) || document.getElementById(n); if (!c) return;   /* campo ou região inteira (PARTE) */
    var fr = AN.frentes.filter(function (x) { return x.box.contains(c); })[0];
    if (fr && fr.f.id !== AN.ativa) ativar(fr.f.id, false);
    setTimeout(function () {
      c.scrollIntoView({ behavior: 'smooth', block: 'center' });
      var i = c.querySelector('.nc-aci-seg-bt, input:not([type=hidden]):not([disabled]), textarea, select:not(.nc-aci-sel-escondido)');
      if (i) setTimeout(function () { try { i.focus({ preventScroll: true }); } catch (x) { i.focus(); } }, 350);
    }, 30);
  }

  /* ═══ [J14] LISTAS CURTAS VIRAM BOTÕES, E O CABEÇALHO DO CASO ═══════════════════════════
     O QUE FAZ  • Toda lista (select) da análise com 2 ou 3 opções curtas (até 26 letras) vira
                  uma fila de botões; "Sim" e "Inicial" sempre vêm primeiro.
                • O cabeçalho do caso recebe os relatórios "Investigação (PDF)" e "CAT (PDF)"
                  (os botões do APEX, achados pelo texto, com o rótulo trocado).
     IMPORTANTE A lista do APEX continua lá, escondida: é ela que vai no envio e dispara as
                ações dinâmicas. O botão só preenche a lista.
     VISUAL     Natcorp_Acidente.css › [C16]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* lista curta (Sim/Não, Inicial/Reabertura…) vira botões: um clique em vez de dois. A lista do
     APEX continua (escondida) e é ela que vai no envio e dispara as ações da página */
  function segmentar(sel) {
    if (!sel.id || sel.classList.contains('nc-aci-sel-escondido') || sel.multiple) return;
    var ops = [].filter.call(sel.options, function (o) { return o.value !== ''; });
    if (ops.length < 2 || ops.length > 3 || ops.some(function (o) { return o.text.trim().length > 26; })) return;
    /* Sim sempre antes de Não (a página tem os dois jeitos) */
    var peso = function (o) { var t = sem(o.text).trim(); return t === 'sim' || /^inicial/.test(t) ? 0 : t === 'nao' || /^reabert/.test(t) ? 1 : 2; };
    ops = ops.slice().sort(function (a, b) { return peso(a) - peso(b); });
    var grupo = el('div', 'nc-aci-seg');
    grupo.setAttribute('role', 'radiogroup');
    grupo.setAttribute('aria-labelledby', sel.id + '_LABEL');
    grupo.setAttribute('data-de', sel.id);
    ops.forEach(function (o) {
      var b = el('button', 'nc-aci-seg-bt', '<span class="nc-aci-sn-marca" aria-hidden="true">' + svg(IC.ok) + '</span>' + esc(o.text.replace(/^\s*\d+\s*-\s*/, '').trim()));
      b.type = 'button'; b.setAttribute('role', 'radio'); b.setAttribute('data-v', o.value);
      grupo.appendChild(b);
    });
    sel.classList.add('nc-aci-sel-escondido');
    sel.setAttribute('tabindex', '-1');
    sel.setAttribute('aria-hidden', 'true');
    sel.parentNode.insertBefore(grupo, sel);
    grupo.addEventListener('click', function (e) {
      var b = e.target.closest('[data-v]'); if (!b || sel.disabled) return;
      apex.item(sel.id).setValue(b.getAttribute('data-v'));
      desenharSegmentos();
    });
  }
  function desenharSegmentos() {
    [].forEach.call(CAIXA.querySelectorAll('.nc-aci-seg'), function (g) {
      var sel = document.getElementById(g.getAttribute('data-de')); if (!sel) return;
      g.classList.toggle('is-travado', !!sel.disabled);
      /* a página escondeu a lista (ex.: "Read Only Local Acidente" troca por texto): os botões somem junto */
      g.classList.toggle('nc-aci-oculto', sel.style.display === 'none');
      [].forEach.call(g.querySelectorAll('[data-v]'), function (b) {
        var on = sel.value === b.getAttribute('data-v');
        if (b.getAttribute('aria-checked') !== String(on)) b.setAttribute('aria-checked', String(on));
        if (b.disabled !== !!sel.disabled) b.disabled = !!sel.disabled;
      });
    });
  }

  function montarCabecalhoCaso(cab) {
    cab.innerHTML = '<span class="nc-aci-pedido-ic" aria-hidden="true">' + svg(IC.ficha) + '</span>' +
      '<div class="nc-aci-pedido-txt"><h2 data-slot="tit"></h2><p data-slot="sub"></p></div>' +
      '<div class="nc-aci-pedido-lado" data-slot="sit"></div><div class="nc-aci-caso-acoes"></div>';
    var acoes = cab.querySelector('.nc-aci-caso-acoes');
    [[/investiga[çc][ãa]o de acidente/i, 'Investigação (PDF)'], [/relat[óo]rio cat/i, 'CAT (PDF)']].forEach(function (r) {
      var b = [].slice.call(document.querySelectorAll('.t-Button')).filter(function (x) { return r[0].test(x.textContent); })[0];
      if (!b) return;
      if (AN.novo) { b.classList.add('nc-aci-oculto'); return; }   /* o relatório precisa do acidente gravado */
      b.classList.add('nc-aci-botao-leve');
      var l = b.querySelector('.t-Button-label'); if (l) l.textContent = r[1];
      if (!b.querySelector('.nc-aci-svg')) b.insertAdjacentHTML('afterbegin', svg(IC.ficha));
      acoes.appendChild(b);
    });
    if (!acoes.children.length) acoes.remove();
  }

  /* ═══ [J15] O MAESTRO DA ANÁLISE ═════════════════════════════════════════════════════════
     O QUE FAZ  atualizarAnalise() roda de novo a cada mudança e refaz: os botões das listas
                curtas, o índice da Investigação, o aviso de lista não salva, o "Faltam N" de
                cada frente, a barra do pé (cada item leva ao campo, trocando de frente se
                precisar), o resumo do afastamento e o caso à esquerda.
     O QUE CONTA COMO "FALTA"  Só campo com "Value Required" no APEX, à vista e liberado.
     O CASO À ESQUERDA  pessoa, quando, onde, a parte do corpo na figura (lida da grade
                interativa da região PARTE), o relato e os sinais (afastamento imediato,
                internação, afastamento com dias, óbito, registro policial).
     PODE MEXER os textos entre aspas, e LADO_COD (o nome de cada código de lado).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var tAn = 0;
  function agendarAnalise() { clearTimeout(tAn); tAn = setTimeout(atualizarAnalise, 80); }

  function atualizarAnalise() {
    if (GX) return;   /* gaveta aberta: a tela por trás espera (a ficha mexe no modelo da grade) */
    desenharSegmentos();
    desenharListas();
    desenharAtalhos();
    revelar();
    desenharIndice();
    avisarListas();
    /* o que falta, por frente (só o obrigatório que está à vista e liberado) */
    var faltam = [];
    AN.frentes.forEach(function (x) {
      var f = [].filter.call(x.box.querySelectorAll('.t-Form-fieldContainer.is-required'), function (c) {
        if (escondido(c) || c.classList.contains('nc-aci-oculto')) return false;
        var n = c.id.replace(/_CONTAINER$/, '').slice(P.length), i = document.getElementById(P + n);
        if (!i || i.disabled || i.type === 'hidden' || i.tagName === 'SPAN') return false;
        return vazio(val(n));
      }).map(function (c) { return c.id.replace(/_CONTAINER$/, '').slice(P.length); });
      f.forEach(function (n) { faltam.push(n); });
      var est = x.bt.querySelector('[data-slot="estado"]');
      var obrig = x.box.querySelectorAll('.t-Form-fieldContainer.is-required').length;
      var sec = x.f.indice ? contarSecoes() : null;
      html(est, f.length ? 'Faltam ' + f.length : sec ? sec[0] + ' de ' + sec[1] + ' preenchidas' : obrig ? svg(IC.ok) + 'Obrigatórios ok' : 'Sem obrigatórios');
      x.bt.classList.toggle('is-falta', !!f.length);
      x.bt.classList.toggle('is-ok', !f.length && !!obrig);
    });
    function nome(n) { var c = cont(n), l = c && c.querySelector('.t-Form-label'); return l && l.firstChild ? String(l.firstChild.nodeValue || l.textContent).trim() : n; }
    html(AN.falta, faltam.length
      ? '<span class="nc-aci-falta-rot">' + (faltam.length === 1 ? 'Falta 1 obrigatório' : 'Faltam ' + faltam.length + ' obrigatórios') + '</span>' +
        faltam.slice(0, 6).map(function (n) { return '<button type="button" class="nc-aci-falta-item" data-ir="' + n + '">' + esc(nome(n)) + '</button>'; }).join('') +
        (faltam.length > 6 ? '<span class="nc-aci-falta-mais is-sempre">+' + (faltam.length - 6) + '</span>' : '')
      : '<span class="nc-aci-pronto">' + svg(IC.ok) + 'Obrigatórios preenchidos.</span>');
    desenharAfastamento();
    desenharCaso();
  }

  function desenharAfastamento() {
    var p = CAIXA.querySelector('.nc-aci-afast'); if (!p) return;
    var af = sem(txt('IND_AFASTAMENTO')), dias = val('QTD_DIAS_AFASTAMENTO'), alta = val('DT_RETORNO'), inter = sem(txt('IND_PROT_TIPO_ACIDENTE'));
    var partes = [];
    if (/^s/.test(inter)) partes.push('<b>Com internação</b>');
    if (/^s/.test(af)) partes.push('<b>Afastado</b>' + (dias ? ' por <b>' + esc(plural(+dias || dias, 'dia', 'dias')) + '</b>' : '') + (alta ? ', alta em <b>' + esc(alta) + '</b>' : ''));
    else if (/^n/.test(af)) partes.push('Sem afastamento');
    p.hidden = !partes.length;
    html(p, partes.length ? svg(IC.tempo) + '<span>' + partes.join(' · ') + '.</span>' : '');
  }

  /* as partes do corpo vêm da grade interativa (modelo do IG; se não der, da tabela na tela) */
  /* PODE MEXER: o nome na tela de cada código de lado gravado na grade */
  var LADO_COD = { '0': 'Não aplicável', '1': 'Esquerda', '2': 'Direita', '3': 'Ambas' };
  function partesAnalise() {
    var out = [];
    try {
      /* a grade é uma região própria dentro de PARTE: o id vem do elemento .a-IG ("…_ig") */
      var igEl = document.querySelector('#PARTE .a-IG'), reg = igEl ? igEl.id.replace(/_ig$/, '') : 'PARTE';
      var g = apex.region(reg).widget().interactiveGrid('getViews', 'grid'), m = g.model, cols = g.view$.grid('getColumns');
      var achar = function (re) { return cols.filter(function (c) { return re.test(sem(c.heading || c.label || '')); })[0]; };
      /* "Cód. Parte Lesada" mostra o NOME da parte (é uma lista); "Descrição" é o texto livre */
      var cP = achar(/cod.*parte|parte lesada|parte atingida/), cD = achar(/descri/), cL = achar(/lateral/);
      if (cP && cD && cP === cD) cD = null;
      var dv = function (r, c) { if (!c) return ''; var v = m.getValue(r, c.property); return v && typeof v === 'object' ? (v.d || v.v || '') : String(v == null ? '' : v); };
      m.forEach(function (r) {
        var md = m.getRecordMetadata(m.getRecordId(r)) || {}; if (md.deleted) return;   /* marcada para excluir: sai da figura */
        var lado = dv(r, cL); lado = LADO_COD[lado] || nomeLado(lado); lado = lado ? lado.charAt(0).toUpperCase() + lado.slice(1) : '';
        var parte = dv(r, cP), desc = dv(r, cD);
        if (parte) out.push({ parte: parte.replace(/\s*\(\d{5,}\)\s*$/, ''), lado: lado, desc: desc });
      });
    } catch (e) {}
    return out;
  }

  function desenharCaso() {
    if (!AN.caso) return;
    var mat = txt('MATRICULA'), nome = nomeProprio(semCodigo(mat)), num = (mat.match(/^\s*(\d+)/) || [])[1] || '';
    var ini = nome.split(/\s+/).filter(Boolean); ini = ((ini[0] || '').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '')).toUpperCase();
    var d = data(val('DT_ACIDENTE')), hora = val('HOR_ACIDENTE');
    var dia = d ? DIAS[d.getDay()].charAt(0).toUpperCase() + DIAS[d.getDay()].slice(1) : '';
    var st = txt('STATUS_CAT');
    /* o cabeçalho */
    var cab = CAIXA.querySelector('.nc-aci-caso-cab');
    if (cab) {
      html(cab.querySelector('[data-slot="tit"]'), AN.novo ? 'Nova comunicação de acidente' : 'Análise do acidente' + (val('COD_ANALISE_ACIDENTE') ? ' nº ' + esc(val('COD_ANALISE_ACIDENTE')) : ''));
      var subCab = [nome ? '<b>' + esc(nome) + '</b>' : '', d ? esc(dia.toLowerCase()) + ', <b>' + esc(val('DT_ACIDENTE')) + '</b>' + (hora ? ' às <b>' + esc(hora) + '</b>' : '') : ''].filter(Boolean).join(' · ');
      html(cab.querySelector('[data-slot="sub"]'), subCab || (AN.novo ? 'Comece por quem se acidentou, quando e onde. O resumo ao lado se monta enquanto você preenche.' : ''));
      html(cab.querySelector('[data-slot="sit"]'), st && !AN.novo ? '<span class="nc-aci-sit nc-aci-sit--' + (/conclu/i.test(sem(st)) ? 'bom' : /pendent/i.test(sem(st)) ? 'atencao' : 'meio') + '"><i aria-hidden="true"></i>' + esc(st) + '</span>' : '');
    }
    var partes = partesAnalise();
    var relato = val('DESCRICAO_TEXTO'), compl = val('DESCRICAO_OBSERVACAO');
    var trajeto = /^s/.test(sem(txt('IND_TRAJETO')));
    var ponto = val('ESPEC_LOCAL_ACIDENTE');
    var cidade = [nomeProprio(val('LOCAL_ACIDENTE')), val('UF_LOCAL_ACIDENTE')].filter(Boolean).join('/');
    function sinal(rot, v, forte) {
      var s = sem(v), tom = /^s/.test(s) ? forte : /^n/.test(s) ? 'nao' : 'vazio';
      return '<li class="nc-aci-sinal nc-aci-sinal--' + tom + '"><span>' + esc(rot) + '</span><b>' + (/^s/.test(s) ? 'Sim' : /^n/.test(s) ? 'Não' : '—') + '</b></li>';
    }
    var dias = val('QTD_DIAS_AFASTAMENTO');
    /* "0 h trabalhadas antes" não informa nada (é o valor que a página põe no acidente novo) */
    var trab = val('HORAS_TRAB'), trabOk = trab && !/^[0:.,\s]*$/.test(trab);
    /* cada linha do caso leva ao campo (data-ir); no acidente novo, o que falta vira convite */
    var falta = function (t) { return '<b class="nc-aci-caso-falta">' + esc(t) + '</b>'; };
    var tipoLocal = semCodigo(txt('TIPO_LOCAL_ACIDENTE'));
    html(AN.caso,
      '<button type="button" class="nc-aci-caso-pessoa nc-aci-caso-ir" data-ir="MATRICULA"><span class="nc-aci-av" aria-hidden="true">' + (ini ? esc(ini) : svg(IC.pessoa)) + '</span><div>' +
        (nome ? '<b>' + esc(nome) + '</b>' : falta('Escolha o colaborador')) +
        '<span>' + esc([num ? 'Matrícula ' + num : '', semCodigo(txt('COD_EMPRESA'))].filter(Boolean).join(' · ') || 'Empresa e matrícula') + '</span></div></button>' +
      '<dl class="nc-aci-caso-dados">' +
        '<div class="nc-aci-caso-ir" data-ir="DT_ACIDENTE" role="button" tabindex="0"><dt>' + svg(IC.tempo) + 'Quando</dt><dd>' + (d ? '<b>' + esc(dia + ', ' + val('DT_ACIDENTE')) + (hora ? ' às ' + esc(hora) : '') + '</b>' : falta('Falta a data e a hora')) +
          (trabOk ? '<span>' + esc(horas(trab)) + ' trabalhadas antes</span>' : '') + '</dd></div>' +
        '<div class="nc-aci-caso-ir" data-ir="TIPO_LOCAL_ACIDENTE" role="button" tabindex="0"><dt>' + svg(IC.local) + 'Onde</dt><dd>' + (trajeto ? '<b>No trajeto</b>' : tipoLocal ? '<b>' + esc(tipoLocal) + '</b>' : AN.novo ? falta('Falta o local') : '<b>No local de trabalho</b>') +
          (ponto && !vazio(ponto) ? '<span class="nc-aci-fato-ponto">' + esc(ponto) + '</span>' : '') + (cidade ? '<span>' + esc(cidade) + '</span>' : '') + '</dd></div>' +
      '</dl>' +
      '<details class="nc-aci-caso-mais"' + (CASO_ABERTO ? ' open' : '') + '><summary>Ver mais do caso</summary>' +
      '<div class="nc-aci-caso-corpo nc-aci-caso-ir" data-ir="PARTE" role="button" tabindex="0"><div class="nc-aci-ficha-fig">' + figura(partes) + '</div><div><h4>Parte atingida</h4>' +
        (partes.length ? '<ul class="nc-aci-partes">' + partes.map(function (p) { return '<li><b>' + esc(nomeParte(p.parte)) + '</b>' + (p.lado && !vazio(p.lado) && !/aplic/i.test(p.lado) ? '<span class="nc-aci-lado">' + esc(p.lado) + '</span>' : '') + (p.desc && !vazio(p.desc) ? '<small>' + esc(p.desc) + '</small>' : '') + '</li>'; }).join('') + '</ul>'
          : '<p class="nc-aci-ficha-vazio">' + (AN.novo ? 'Toque para informar a parte do corpo.' : 'Nenhuma parte informada.') + '</p>') + '</div></div>' +
      '<div class="nc-aci-caso-relato nc-aci-caso-ir" data-ir="DESCRICAO_TEXTO" role="button" tabindex="0"><h4>Relato</h4>' + (relato && !vazio(relato) ? '<blockquote>' + esc(relato) + '</blockquote>' : '<p class="nc-aci-ficha-vazio">' + (AN.novo ? 'Toque para escrever o que aconteceu.' : 'Sem relato.') + '</p>') +
        (compl && !vazio(compl) ? '<p class="nc-aci-ficha-outras">' + esc(compl) + '</p>' : '') + '</div>' +
      '<ul class="nc-aci-sinais" aria-label="Sinais">' +
        sinal('Afastamento imediato', txt('AFASTAMENTO_IMEDIATO'), 'atencao') +
        sinal('Internação', txt('IND_PROT_TIPO_ACIDENTE'), 'grave') +
        sinal('Afastamento' + (dias && /^s/.test(sem(txt('IND_AFASTAMENTO'))) ? ' (' + dias + ' d)' : ''), txt('IND_AFASTAMENTO'), 'atencao') +
        sinal('Óbito', txt('IND_OBITO'), 'grave') + sinal('Registro policial', txt('IND_EXPERIENCIA_OPERACAO'), 'atencao') +
      '</ul></details>');
    var dt = AN.caso.querySelector('.nc-aci-caso-mais');
    if (dt && !dt.__nc) { dt.__nc = true; dt.addEventListener('toggle', function () { CASO_ABERTO = dt.open; }); }
    if (!AN.caso.__nc) {
      AN.caso.__nc = true;
      var ir = function (e) { var b = e.target.closest('.nc-aci-caso-ir'); if (b && AN.caso.contains(b)) irParaAnalise(b.getAttribute('data-ir')); };
      AN.caso.addEventListener('click', ir);
      AN.caso.addEventListener('keydown', function (e) { if ((e.key === 'Enter' || e.key === ' ') && e.target.matches('.nc-aci-caso-ir[role="button"]')) { e.preventDefault(); ir(e); } });
    }
  }

  /* ═══ [J16] REGIÕES INTEIRAS E GRADES INTERATIVAS ════════════════════════════════════════
     O QUE FAZ  • Cada região inteira posta numa frente ganha o título de REGIOES ([J12]); o
                  que repete o caso (REPETIDOS) some; as providências imediatas vêm antes das
                  posteriores; o botão "Adicionar" diz o que acrescenta ("Adicionar testemunha").
                • Nas grades interativas (partes do corpo, EPIs, custos) a barra fica só com
                  "Adicionar …" e "Salvar lista" (rótulos trocados pela API de ações da grade;
                  "Redefinir" escondido), mais uma linha explicando como usar.
                • Alteração numa grade que ainda não foi salva aparece na barra do pé, com o
                  botão "Salvar lista".
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_Acidente.css › [C17]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function prepararRegiao(r) {
    var def = REGIOES[r.id];
    var tit = r.querySelector(':scope > .t-Region-header .t-Region-title');
    if (def && tit) tit.textContent = def[0];
    /* o que repete o caso sai; os campos ganham o desenho de rótulo em cima */
    [].forEach.call(r.querySelectorAll('.t-Form-fieldContainer'), function (c) {
      if (c.closest('.a-IG')) return;
      var n = c.id.replace(/_CONTAINER$/, '').slice(P.length);
      if (REPETIDOS.indexOf(n) > -1) { c.classList.add('nc-aci-oculto'); return; }
      pegar(c, n);
    });
    /* providências: a imediata vem antes da posterior */
    var im = cont('TEXTO_PROV_IMEDIATAS'), me = cont('TEXTO_PROV_MEDIATAS');
    if (r.id === 'SERVICO' && im && me && (me.compareDocumentPosition(im) & Node.DOCUMENT_POSITION_FOLLOWING)) {
      var colMe = me.closest('.col') || me, colIm = im.closest('.col') || im;
      if (colMe.parentNode === colIm.parentNode) colMe.parentNode.insertBefore(colIm, colMe);
      else if (colMe.closest('.row') && colIm.closest('.row')) colMe.closest('.row').parentNode.insertBefore(colIm.closest('.row'), colMe.closest('.row'));
    }
    /* listas: o botão do APEX diz o que acrescenta */
    [].forEach.call(r.querySelectorAll('.t-Region-header .t-Button, .t-Region-buttons .t-Button, .a-IRR-buttons .t-Button'), function (b) {
      if (/^adicionar$/i.test(b.textContent.trim()) && def && def[1]) {
        var l = b.querySelector('.t-Button-label'); var t = 'Adicionar ' + def[1];
        if (l) l.textContent = t; else b.textContent = t;
        if (!b.querySelector('.nc-aci-svg')) b.insertAdjacentHTML('afterbegin', svg(IC.mais));
      }
    });
    if (r.querySelector('.a-IRR')) r.classList.add('nc-aci-lista');
    [].forEach.call(r.querySelectorAll('.a-IG'), function (ig) { prepararGrade(ig, def ? def[1] : ''); });
  }

  /* a grade interativa (não dá para trocar por outra coisa): fica só com Adicionar e Salvar lista,
     com os nomes certos, e uma linha dizendo como se usa */
  var GRADES = [];
  function prepararGrade(ig, nome) {
    var rid = ig.id.replace(/_ig$/, ''), w, acts;
    try { w = apex.region(rid).widget(); acts = w.interactiveGrid('getActions'); } catch (e) { return; }
    function rotular(acao, texto) { var a = acts.lookup(acao); if (a) { a.label = texto; acts.update(acao); } }
    rotular('selection-add-row', 'Adicionar ' + (nome || 'linha'));
    rotular('save', 'Salvar lista');
    rotularBotoes(ig);
    ['reset-report'].forEach(function (a) { try { acts.hide(a); } catch (e) {} });
    ig.classList.add('nc-aci-grade-ig');
    var reg = ig.closest('.nc-aci-inv');
    if (reg && !reg.querySelector('.nc-aci-grade-como')) {
      var como = el('p', 'nc-aci-grade-como', svg(IC.info) + '<span><b>Adicionar ' + esc(nome || 'linha') + '</b> cria uma linha: preencha na própria tabela e toque em <b>Salvar lista</b>. ' +
        'Para apagar, use o menu <b>≡</b> da linha.</span>');
      ig.parentNode.insertBefore(como, ig);
    }
    GRADES.push({ rid: rid, nome: nome, w: w, acts: acts, reg: reg });
    try { w.on('interactivegridviewmodelcreate', agendarAnalise); } catch (e) {}
    $(ig).on('change keyup', agendarAnalise);
  }
  function rotularBotoes(ig) {
    [].forEach.call(ig.querySelectorAll('.a-Toolbar [data-action="save"]'), function (b) {
      var l = b.querySelector('.a-Button-label') || b;
      if (/^\s*salvar\s*$/i.test(l.textContent)) l.textContent = 'Salvar lista';
    });
  }
  /* alteração na grade que ainda não foi salva: a barra do pé avisa (e salva a lista) */
  function avisarListas() {
    GRADES.forEach(function (g) { var ig = document.getElementById(g.rid + '_ig'); if (ig) rotularBotoes(ig); });
    var pend = AN.novo ? [] : GRADES.filter(function (g) {
      try { var m = g.w.interactiveGrid('getViews', 'grid').model; return m.isChanged && m.isChanged(); } catch (e) { return false; }
    });
    var box = AN.barra && AN.barra.querySelector('.nc-aci-pendente');
    if (!box && AN.barra) { box = el('div', 'nc-aci-pendente'); box.setAttribute('aria-live', 'polite'); AN.barra.insertBefore(box, AN.barra.firstChild); box.addEventListener('click', function (e) {
      var b = e.target.closest('[data-grade]'); if (!b) return;
      var g = GRADES.filter(function (x) { return x.rid === b.getAttribute('data-grade'); })[0];
      if (g) { try { g.acts.invoke('save'); } catch (x) {} setTimeout(agendarAnalise, 800); }
    }); }
    if (!box) return;
    html(box, pend.map(function (g) {
      var sv = g.acts.lookup('save'), comPagina = !sv || !!sv.hide;
      return '<span class="nc-aci-pendente-item">' + svg(IC.alerta) + 'Lista de ' + esc(g.nome === 'EPI' ? 'EPIs' : g.nome ? g.nome + 's' : 'itens') + ' com alteração não salva' +
        (comPagina ? ' — grava ao tocar em Salvar' : '<button type="button" class="nc-aci-link" data-grade="' + g.rid + '">Salvar lista</button>') + '</span>';
    }).join(''));
    box.hidden = !pend.length;
  }

  /* ═══ [J17] O ÍNDICE DA INVESTIGAÇÃO ═════════════════════════════════════════════════════
     O QUE FAZ  No alto da frente Investigação, uma fila de botões com as seções (regiões) e um
                sinal nas que já têm conteúdo; o botão da frente mostra "N de M preenchidas".
                Clicar numa seção rola até ela.
     COMO CONTA  Grade: só as colunas VISÍVEIS (as escondidas — usuário, data, chaves — vêm
                preenchidas até na linha em branco). Relatório: tem linha. Campos: algum texto
                preenchido (lista com valor padrão não conta).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var INDICE = null;
  function secoesInv() {
    var fr = AN.frentes.filter(function (x) { return x.f.indice; })[0];
    if (!fr) return [];
    /* o display:none do seletor de abas não conta (o CSS mostra a região): vale o perfil */
    return [].filter.call(fr.box.querySelectorAll('.t-Region.nc-aci-inv'), function (r) { return !r.classList.contains('nc-aci-oculto') && !r.classList.contains('nc-aci-perfil-fora'); });
  }
  function preenchida(r) {
    if (r.querySelector('.a-IG')) {
      var g = GRADES.filter(function (x) { return x.reg === r; })[0], n = 0;
      try {
        /* só as colunas que a pessoa vê: as escondidas (usuário, data, chaves) vêm preenchidas
           até na linha em branco */
        var vw = g.w.interactiveGrid('getViews', 'grid'), m = vw.model;
        var props = vw.view$.grid('getColumns').filter(function (c) { return !c.hidden && c.property && !/^APEX\$/.test(c.property); }).map(function (c) { return c.property; });
        m.forEach(function (rec) {
          var tem = props.some(function (p) { var v = m.getValue(rec, p); return v && (typeof v === 'string' ? !!v.trim() : typeof v === 'object' ? !!(v.v || v.d) : typeof v === 'number'); });
          if (tem) n++;
        });
      } catch (e) {}
      return n > 0;
    }
    var irr = r.querySelector('.a-IRR');
    if (irr) return !!irr.querySelector('tbody tr td:not(.a-IRR-noDataMsg)') && !irr.querySelector('.a-IRR-noDataMsg');
    return [].some.call(r.querySelectorAll('textarea, input[type=text], select'), function (i) {
      var c = i.closest('.t-Form-fieldContainer');
      if (!c || c.classList.contains('nc-aci-oculto') || escondido(c)) return false;
      if (i.tagName === 'SELECT') return false;   /* lista com valor padrão não conta como "preenchida" */
      return !vazio(i.value);
    });
  }
  function contarSecoes() { var s = secoesInv(); return s.length ? [s.filter(preenchida).length, s.length] : null; }
  function montarIndice() {
    var fr = AN.frentes.filter(function (x) { return x.f.indice; })[0];
    if (!fr) return;
    INDICE = el('nav', 'nc-aci-indice');
    INDICE.setAttribute('aria-label', 'Seções da investigação');
    fr.box.insertBefore(INDICE, fr.box.firstChild);
    INDICE.addEventListener('click', function (e) {
      var b = e.target.closest('[data-r]'); if (!b) return;
      var r = document.getElementById(b.getAttribute('data-r')); if (!r) return;
      var y = r.getBoundingClientRect().top + window.pageYOffset - (ultTopo > 0 ? ultTopo : 16) - 90;
      window.scrollTo({ top: y, behavior: 'smooth' });
    });
  }
  function desenharIndice() {
    if (!INDICE) return;
    html(INDICE, '<span class="nc-aci-indice-rot">Seções</span>' + secoesInv().map(function (r) {
      var ok = preenchida(r), t = (REGIOES[r.id] || [((r.querySelector('.t-Region-title') || {}).textContent || r.id)])[0];
      return '<button type="button" class="nc-aci-indice-bt' + (ok ? ' is-ok' : '') + '" data-r="' + r.id + '">' + (ok ? svg(IC.ok) : '<i aria-hidden="true"></i>') + esc(t) + '</button>';
    }).join(''));
    /* a seção sem nada à vista (ex.: Fatores, para a área médica) sai da frente */
    [].forEach.call(CAIXA.querySelectorAll('.t-Region.nc-aci-inv'), function (r) {
      if (r.querySelector('.a-IG, .a-IRR, .t-Region')) return;
      var algum = [].some.call(r.querySelectorAll('.t-Form-fieldContainer'), function (c) { return !c.classList.contains('nc-aci-oculto') && !escondido(c); });
      r.classList.toggle('nc-aci-oculto', !algum);
    });
  }

  /* ═══ [J18] O QUE SÓ APARECE QUANDO FAZ SENTIDO ══════════════════════════════════════════
     O QUE FAZ  • Os campos do B.O. só aparecem com "Houve registro policial?" = Sim; dias de
                  afastamento e data da alta, só com "Houve afastamento?" = Sim (ou se já
                  tiverem valor). Isto é do desenho, NÃO são ações dinâmicas da página.
                • As caixas de texto da análise crescem com o que se escreve (até 420px).
     PODE MEXER as listas de campos dentro de grupo(…) — o primeiro nome é a pergunta, a lista
                são os campos que dependem dela.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function revelar() {
    function grupo(n, lista) {
      var sim = /^s/.test(sem(txt(n)));
      lista.forEach(function (x) {
        var c = cont(x); if (!c) return;
        var temValor = !vazio(val(x)) || (c.querySelector('input[type=file]') && c.querySelector('.apex-item-filename, a'));
        c.classList.toggle('nc-aci-oculto', !sim && !temValor);
      });
    }
    /* 04/10: o desenho NÃO esconde campo por conta própria (B.O. e dias/alta ficavam escondidos até
       "Sim" — regra que a página não tem). Mostrar e esconder é só das ações dinâmicas da página
       (ex.: Data do óbito, pela ação "Óbito"). grupo() fica para uso futuro. */
    void grupo;
    /* caixas de texto crescem com o que se escreve (a Skin trava a altura: vai por variável) */
    [].forEach.call(CAIXA.querySelectorAll('.nc-aci-trabalho textarea'), crescer);
  }
  function crescer(t) {
    if (!t.__ncCresce) { t.__ncCresce = true; t.addEventListener('input', function () { crescer(t); }); }
    if (!t.offsetParent) return;
    var min = t.closest('.nc-aci-campo--diagno_provavel, .nc-aci-campo--descricao_texto') ? 110 : 76;
    t.style.setProperty('--nc-aci-h', min + 'px');
    var h = Math.min(Math.max(t.scrollHeight + 2, min), 420);
    t.style.setProperty('--nc-aci-h', h + 'px');
  }

  /* ═══ [J20] AS LISTAS EM CARTÕES (partes do corpo, EPIs, custos, testemunhas, terceiros) ════
     O QUE FAZ  As cinco listas da análise viram CARTÕES, um por linha, com "Adicionar …" no fim:
                • GRADES (partes, EPIs, custos): tocar num cartão — ou em "Adicionar" — abre uma
                  GAVETA com a ficha da PRÓPRIA grade ("vista de um registro"): as listas, os
                  valores padrão e as validações são os da página. Acidente GRAVADO: o Salvar da
                  gaveta grava na hora (o salvar da grade, com os processos dela). Acidente NOVO:
                  a linha fica na lista ("vai junto ao criar") e é gravada pelo "Criar
                  comunicação" — o código do acidente só nasce no Criar (processo PRE-INSERT).
                • RELATÓRIOS (testemunhas, terceiros): tocar abre a janela de sempre (páginas 33 e
                  34, o lápis da linha); "Adicionar" é o botão original; ao fechar a janela, o
                  relatório é buscado de novo e os cartões se refazem.
     A GRADE/O RELATÓRIO continuam na página, escondidos: é deles que vem tudo (e a figura do
                corpo continua lendo as partes da grade).
     PODE MEXER LISTAS e RELATORIOS: textos, nomes dos campos da gaveta, o que o cartão mostra.
     CUIDADO    A ficha da grade REESCREVE as classes dos campos a cada registro: ordem e largura
                vão numa folha presa ao ID do campo (como no Histórico, 2937:6). Linha NOVA
                cancelada sai com deleteRecords (revertRecords não a tira). A grade dispara
                "interactivegridsave" também quando FALHA: só é sucesso com status ok e sem
                pendência no modelo.
     VISUAL     Natcorp_Acidente.css › [C20]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var LISTAS = {
    PARTE: { um: 'parte do corpo', novo: 'Adicionar parte do corpo', vazio: 'Nenhuma parte do corpo informada ainda.', ic: 'corpo',
      ficha: [['COD_PARTE_LESADA', 'Parte do corpo'], ['LATERALIDADE', 'Lado'], ['DESCRICAO_PARTE_LESADA', 'Como ficou (o ferimento)']],
      cartao: function (d) { var lado = LADO_COD[d.v('LATERALIDADE')] || d.d('LATERALIDADE'); return { tit: nomeParte(d.d('COD_PARTE_LESADA')) || 'Parte não escolhida', marca: lado && !/aplic/i.test(lado) ? lado : '', txt: d.d('DESCRICAO_PARTE_LESADA') }; } },
    EPI: { um: 'EPI', novo: 'Adicionar EPI', vazio: 'Nenhum EPI informado. Informe o que a pessoa usava no momento.', ic: 'ok',
      ficha: [['COD_EQUIP', 'EPI que estava usando']],
      cartao: function (d) { return { tit: semCodigo(d.d('COD_EQUIP')) || 'EPI não escolhido', marca: (d.d('COD_EQUIP').match(/^\s*(\d+)\s*-/) || [])[1] ? 'Cód. ' + d.d('COD_EQUIP').match(/^\s*(\d+)/)[1] : '' }; } },
    CUSTO: { um: 'custo', novo: 'Adicionar custo', vazio: 'Nenhum custo informado.', ic: 'ficha', total: 'VALOR_CUSTO_ACIDENTE',
      ficha: [['DESCRICAO_CUSTO', 'O que gerou o custo'], ['VALOR_CUSTO_ACIDENTE', 'Valor (R$)']],
      cartao: function (d) { return { tit: d.d('DESCRICAO_CUSTO') || 'Custo sem descrição', valor: reais(d.v('VALOR_CUSTO_ACIDENTE')) }; } }
  };
  var RELATORIOS = {
    TESTEMUNHA: { um: 'testemunha', vazio: 'Nenhuma testemunha da empresa informada.' },
    TERCEIROS: { um: 'terceiro', vazio: 'Nenhuma testemunha de fora informada.' }
  };
  function reais(v) {
    var n = Number(String(v == null ? '' : v).replace(/\./g, '').replace(',', '.'));
    if (String(v).indexOf(',') < 0) n = Number(v);
    return isFinite(n) && String(v).trim() !== '' ? n.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }) : '';
  }
  var LS = {};        /* id da região → { def, reg, sub, ig, w, v, acts, caixa } */
  function montarListas() {
    Object.keys(LISTAS).forEach(function (id) {
      var reg = document.getElementById(id), igEl = reg && reg.querySelector('.a-IG'); if (!igEl) return;
      var w, v, acts; try { w = apex.region(igEl.id.replace(/_ig$/, '')).widget(); v = w.interactiveGrid('getViews', 'grid'); acts = w.interactiveGrid('getActions'); } catch (e) { return; }
      var caixa = el('div', 'nc-aci-cartoes'); caixa.setAttribute('data-lista', id);
      /* a região da GRADE é a do id do IG sem o "_ig" (o modelo dela pode não ter .t-Region);
         os cartões entram no lugar dela — o texto de ajuda da região fica acima */
      var sub = document.getElementById(igEl.id.replace(/_ig$/, '')) || igEl;
      sub.classList.add('nc-aci-grade-orig');
      sub.parentNode.insertBefore(caixa, sub);
      reg.classList.add('nc-aci-com-cartoes');
      /* grade sem o Salvar na barra (as partes): na página ela só grava com o Salvar/Criar da página —
         é lá que roda "É obrigatório informar ao menos uma Parte Lesada". A gaveta respeita: a linha
         fica na lista e vai no Salvar. Grade com Salvar na barra (EPIs, custos): grava na hora. */
      var sv = acts.lookup('save'), comPagina = !sv || !!sv.hide;
      LS[id] = { def: LISTAS[id], reg: reg, sub: sub, ig: igEl, w: w, v: v, acts: acts, caixa: caixa, comPagina: comPagina };
      try { v.model.subscribe({ onChange: function () { if (!GX) agendarAnalise(); } }); } catch (e) {}
      caixa.addEventListener('click', function (ev) { var b = ev.target.closest('[data-rid],[data-novo]'); if (b) abrirLista(id, b.hasAttribute('data-novo') ? null : b.getAttribute('data-rid'), b); });
    });
    Object.keys(RELATORIOS).forEach(function (id) {
      var reg = document.getElementById(id); if (!reg || !reg.querySelector('.a-IRR')) return;
      var caixa = el('div', 'nc-aci-cartoes'); caixa.setAttribute('data-lista', id);
      var irr = reg.querySelector('.t-IRR-region') || reg.querySelector('.a-IRR').parentNode;
      irr.parentNode.insertBefore(caixa, irr);
      reg.classList.add('nc-aci-com-cartoes');
      LS[id] = { rel: RELATORIOS[id], reg: reg, caixa: caixa };
      caixa.addEventListener('click', function (ev) {
        var b = ev.target.closest('[data-abrir],[data-novo]'); if (!b) return;
        if (b.hasAttribute('data-novo')) { var add = botaoAdicionar(reg); if (add) add.click(); return; }
        var a = reg.querySelector('[data-nc-aci-abrir="' + b.getAttribute('data-abrir') + '"]'); if (a) a.click();
      });
      $(reg).on('apexafterrefresh', agendarAnalise);
    });
    /* janela de testemunha/terceiro fechada: o relatório é buscado de novo */
    $(document).on('apexafterclosedialog', function () {
      Object.keys(RELATORIOS).forEach(function (id) { var r = LS[id], irr = r && r.reg.querySelector('.t-IRR-region'); if (irr && irr.id) try { apex.region(irr.id).refresh(); } catch (e) {} });
    });
  }
  function botaoAdicionar(reg) { return [].slice.call(reg.querySelectorAll('.t-Button')).filter(function (b) { return /^\+?\s*adicionar/i.test(b.textContent.trim()); })[0]; }

  function desenharListas() {
    Object.keys(LS).forEach(function (id) {
      var L = LS[id], h = '';
      if (L.def) {
        var m = L.v.model, itens = [], soma = 0, temSoma = false;
        m.forEach(function (rec) {
          var rid = m.getRecordId(rec), md = m.getRecordMetadata(rid) || {};
          if (md.deleted && !L.comPagina) return;
          var d = { v: function (c) { var x = m.getValue(rec, c); return x && typeof x === 'object' ? String(x.v == null ? '' : x.v) : String(x == null ? '' : x); },
                    d: function (c) { var x = m.getValue(rec, c); return String((x && typeof x === 'object' ? (x.d || x.v) : x) || '').trim(); } };
          var c = L.def.cartao(d);
          /* linha em branco que a grade cria sozinha (nada visível preenchido) não vira cartão */
          var vazia = L.def.ficha.every(function (f) { return !d.v(f[0]) && !d.d(f[0]); });
          if (vazia && !md.inserted) return;
          if (L.def.total) { var n = Number(String(d.v(L.def.total)).replace(',', '.')); if (isFinite(n)) { soma += n; temSoma = true; } }
          var pend = md.inserted || md.updated;
          itens.push('<li><button type="button" class="nc-aci-cartao-l' + (pend || md.deleted ? ' is-pendente' : '') + (md.deleted ? ' is-excluido' : '') + (md.error ? ' is-erro' : '') + '" data-rid="' + esc(rid) + '"' + (md.deleted ? ' disabled' : '') + '>' +
            '<span class="nc-aci-cartao-ic" aria-hidden="true">' + svg(IC[L.def.ic] || IC.ficha) + '</span>' +
            '<span class="nc-aci-cartao-txt"><b>' + esc(c.tit) + '</b>' + (c.marca ? '<span class="nc-aci-cartao-marca">' + esc(c.marca) + '</span>' : '') +
              (c.txt ? '<small>' + esc(c.txt) + '</small>' : '') +
              (md.error ? '<em class="nc-aci-cartao-estado is-erro">Tem campo para corrigir</em>' : pend ? '<em class="nc-aci-cartao-estado">' + (md.deleted ? 'Será excluído' : AN.novo ? 'Vai junto ao criar a comunicação' : L.comPagina ? 'Será gravado ao tocar em Salvar' : 'Ainda não gravado') + '</em>' : '') + '</span>' +
            (c.valor ? '<span class="nc-aci-cartao-valor">' + esc(c.valor) + '</span>' : '') +
            '<span class="nc-aci-cartao-ir">' + svg(IC.ficha) + 'Editar</span></button></li>');
        });
        var podeAdd = true; try { podeAdd = !!m.allowAdd(); } catch (e) {}
        h = (itens.length ? '<ul class="nc-aci-cartoes-lista">' + itens.join('') + '</ul>' : '<p class="nc-aci-cartoes-vazio">' + esc(L.def.vazio) + '</p>') +
          (temSoma && itens.length > 1 ? '<p class="nc-aci-cartoes-total">Total <b>' + esc(reais(soma)) + '</b></p>' : '') +
          (podeAdd ? '<button type="button" class="nc-aci-cartoes-novo" data-novo>' + svg(IC.mais) + esc(L.def.novo) + '</button>' : '');
      } else {
        /* relatório. CUIDADO: com cabeçalho fixo o APEX faz DUAS tabelas a-IRR-table (a 1ª só com
           o cabeçalho, a 2ª com as linhas) — ler só a 1ª dava "nenhuma testemunha" (04/10). Cada
           célula é casada com a coluna pelo id (td headers="C<id>" ↔ th a[data-column="<id>"]). */
        var rot = {};
        [].forEach.call(L.reg.querySelectorAll('.a-IRR-headerLink[data-column]'), function (a) { rot['C' + a.getAttribute('data-column')] = sem(a.textContent).trim(); });
        var linhasTr = [].filter.call(L.reg.querySelectorAll('table.a-IRR-table tr'), function (tr) { return tr.querySelector('td') && !tr.querySelector('.a-IRR-noDataMsg'); });
        var cards = [];
        linhasTr.forEach(function (tr, n) {
          var dado = {};
          [].forEach.call(tr.querySelectorAll('td'), function (td) { var k = rot[td.getAttribute('headers')]; if (k) dado[k] = td.textContent.replace(/\s+/g, ' ').trim(); });
          var pega = function (re) { for (var k in dado) if (re.test(k)) return vazio(dado[k]) ? '' : dado[k]; return ''; };
          var quem = pega(/^testemunha/), cod = (quem.match(/^\s*(\d+)\s*-\s*/) || [])[1];
          var nome = nomeProprio(semCodigo(quem)) || 'Sem nome';
          var lugar = [nomeProprio(pega(/cidade/)), pega(/^uf$/)].filter(Boolean).join('/'), fone = pega(/telefone/).replace(/^\(\s*\)\s*/, ''), dep = pega(/depoimento/);   /* "() 5331563": DDD vazio sai */
          var link = tr.querySelector('a[href]:not([href="#"]), a[href^="javascript"]');
          if (link) link.setAttribute('data-nc-aci-abrir', n);
          cards.push('<li><button type="button" class="nc-aci-cartao-l' + (link ? '' : ' is-leitura') + '" data-abrir="' + n + '"' + (link ? '' : ' disabled') + '>' +
            '<span class="nc-aci-cartao-ic" aria-hidden="true">' + svg(IC.pessoa) + '</span>' +
            '<span class="nc-aci-cartao-txt"><b>' + esc(nome) + '</b>' + (cod ? '<span class="nc-aci-cartao-marca">Matrícula ' + esc(cod) + '</span>' : '') +
              ([fone, lugar].filter(Boolean).length ? '<span class="nc-aci-cartao-meta">' + esc([fone, lugar].filter(Boolean).join(' · ')) + '</span>' : '') +
              (dep ? '<small class="nc-aci-cartao-citacao">“' + esc(dep) + '”</small>' : '') + '</span>' +
            (link ? '<span class="nc-aci-cartao-ir">' + svg(IC.ficha) + 'Abrir</span>' : '') + '</button></li>');
        });
        var add = botaoAdicionar(L.reg);
        /* sem o "Adicionar": a página não o desenhou (autorização do usuário; e a de testemunha
           da empresa só aparece enquanto o acidente não tem nenhuma) */
        h = (cards.length ? '<ul class="nc-aci-cartoes-lista">' + cards.join('') + '</ul>' : '<p class="nc-aci-cartoes-vazio">' + esc(L.rel.vazio) +
            (add ? '' : ' <span>Adicionar ' + esc(L.rel.um) + ' não está liberado para o seu usuário.</span>') + '</p>') +
          (add ? '<button type="button" class="nc-aci-cartoes-novo" data-novo>' + svg(IC.mais) + 'Adicionar ' + esc(L.rel.um) + '</button>' : '');
      }
      html(L.caixa, h);
    });
  }

  /* a gaveta: a ficha da grade */
  var GX = null, GAVX = null, folhasX = {};
  function montarGavetaX() {
    if (GAVX) return;
    GAVX = { fundo: el('div', 'nc-aci-gfundo'), caixa: el('aside', 'nc-aci-gaveta') };
    GAVX.caixa.tabIndex = -1; GAVX.caixa.setAttribute('role', 'dialog'); GAVX.caixa.setAttribute('aria-modal', 'true'); GAVX.caixa.setAttribute('aria-labelledby', 'nc-aci-gtit');
    GAVX.cab = el('header', 'nc-aci-gcab'); GAVX.corpo = el('div', 'nc-aci-gcorpo'); GAVX.pe = el('footer', 'nc-aci-gpe');
    GAVX.caixa.appendChild(GAVX.cab); GAVX.caixa.appendChild(GAVX.corpo); GAVX.caixa.appendChild(GAVX.pe);
    document.body.appendChild(GAVX.fundo); document.body.appendChild(GAVX.caixa);
    GAVX.fundo.addEventListener('click', function () { fecharListaCuidado(); });
    /* tocar em qualquer ponto da moldura do campo leva o cursor para ele */
    GAVX.corpo.addEventListener('click', function (ev) {
      var box = ev.target.closest('.u-Form-inputContainer'); if (!box || ev.target.closest('input, textarea, select, button, a')) return;
      var c = box.querySelector('textarea, input:not([type=hidden]):not([readonly]), select'); if (c && !c.disabled) c.focus();
    });
    GAVX.caixa.addEventListener('click', function (ev) {
      if (ev.target.closest('[data-gfechar]')) fecharListaCuidado();
      else if (ev.target.closest('[data-gcancelar]')) fecharLista(true);
      else if (ev.target.closest('[data-gsalvar]')) salvarLista();
      else if (ev.target.closest('[data-gexcluir]')) excluirLista();
    });
    /* captura: com a gaveta aberta o Esc é dela (calendário e listas abertas ficam com o próprio) */
    window.addEventListener('keydown', function (ev) {
      if (!GX) return;
      if (ev.key === 'Escape') {
        if ([].some.call(document.querySelectorAll('.ui-datepicker, .ui-dialog'), function (d) { return d.offsetParent !== null; })) return;
        ev.preventDefault(); ev.stopImmediatePropagation(); fecharListaCuidado();
      }
    }, true);
  }
  function idsX(m) { var ids = []; m.forEach(function (r) { ids.push(m.getRecordId(r)); }); return ids; }
  function abrirLista(id, rid, volta) {
    var L = LS[id]; if (GX || !L || !L.def) return;
    montarGavetaX();
    var v = L.v, m = v.model, acts = L.acts, novo = rid == null;
    GX = { id: id, L: L, rid: rid, novo: novo, volta: volta, lugar: document.createComment('nc-aci-grade') };
    L.sub.parentNode.insertBefore(GX.lugar, L.sub);
    GAVX.corpo.appendChild(L.sub); L.sub.classList.add('nc-aci-motor');
    document.body.classList.add('nc-aci-gaveta-aberta');
    if (novo) {
      try { acts.set('edit', true); } catch (e) {}
      var antes = idsX(m);
      acts.invoke('selection-add-row');
      GX.rid = idsX(m).filter(function (x) { return antes.indexOf(x) < 0; })[0];
      if (GX.rid == null) { fecharLista(false); return; }
    }
    var g0 = GX;
    GAVX.caixa.classList.add('is-abrindo');
    irParaX(L, GX.rid, function (ok) {
      if (GX !== g0) return;
      GAVX.caixa.classList.remove('is-abrindo');
      if (!ok) { avisoX('Não consegui abrir este registro. Tente de novo.', true); return fecharLista(true); }
      arrumarFichaX(L);
      setTimeout(function () {
        var f = [].filter.call(GAVX.corpo.querySelectorAll('.u-Form > .u-Form-fieldContainer:not(.is-readonly) :is(input:not([type=hidden]):not([readonly]), select, textarea)'), function (x) { return x.offsetParent !== null; })[0];
        (f && f.focus ? f : GAVX.caixa).focus();
      }, 60);
    });
    GAVX.cab.innerHTML = '<span class="nc-aci-gcab-ic" aria-hidden="true">' + svg(IC[L.def.ic] || IC.ficha) + '</span><div><h2 id="nc-aci-gtit">' + (novo ? esc(L.def.novo) : 'Editar ' + esc(L.def.um)) + '</h2>' +
      '<p>' + (AN.novo ? 'Vai junto quando você criar a comunicação.' : L.comPagina ? 'Fica na lista e é gravado quando você tocar em Salvar, no pé da página.' : 'Grava na hora, ao salvar.') + '</p></div>' +
      '<button type="button" class="nc-aci-gx" data-gfechar aria-label="Fechar">' + svg(IC.x) + '</button>';
    var podeDel = false; try { podeDel = !novo && m.allowDelete(m.getRecord(GX.rid)); } catch (e) {}
    GAVX.pe.innerHTML = (podeDel ? '<button type="button" class="nc-aci-gbt is-perigo" data-gexcluir>Excluir</button>' : '') +
      '<span class="nc-aci-gpe-espaco"></span><button type="button" class="nc-aci-gbt" data-gcancelar>Cancelar</button>' +
      '<button type="button" class="nc-aci-gbt is-primario" data-gsalvar>' + svg(IC.ok) + '<span>' + (AN.novo || L.comPagina ? (novo ? 'Adicionar' : 'Pronto') : 'Salvar') + '</span></button>';
    GAVX.corpo.scrollTop = 0;
  }
  /* CUIDADO  Como a ficha é posta no registro certo (o jeito da 2937:11, testado 15 de 15):
              • a "vista de um registro" é aberta UMA vez e nunca fechada — fechar e reabrir a
                deixava presa, mostrando "Dados não encontrados" (pego em 04/10, depois de um
                registro novo cancelado);
              • para trocar de registro: sai da edição → recordOffset = a posição dele (sem os
                excluídos) → entra na edição;
              • e CONFERE o registro; sem bater, a gaveta não abre (avisa e fecha). */
  function irParaX(L, rid, cb0) {
    var feito = false, cb = function (ok) { if (feito) return; feito = true; cb0(ok); };
    setTimeout(function () { cb(false); }, 4000);
    var passo = function (f, ms) { setTimeout(function () { try { f(); } catch (x) { cb(false); } }, ms); };
    var v = L.v, acts = L.acts;
    if (!v.singleRowMode) { try { acts.invoke('single-row-view'); } catch (x) { return cb(false); } }
    var rv = v.singleRowView$; if (!rv) return cb(false);
    try { acts.set('edit', false); } catch (x) {}
    passo(function () {
      var ids = []; v.model.forEach(function (r, i, id) { var md = v.model.getRecordMetadata(id) || {}; if (!md.deleted) ids.push(String(id)); });
      var k = ids.indexOf(String(rid)); if (k < 0) return cb(false);
      rv.recordView('option', 'recordOffset', k);
      passo(function () {
        try { acts.set('edit', true); } catch (x) {}
        passo(function () { var r = rv.recordView('getRecord'); cb(!!r && String(v.model.getRecordId(r)) === String(rid)); }, 220);
      }, 60);
    }, 40);
  }
  function arrumarFichaX(L) {
    var rv = L.sub.querySelector('.a-RV'), form = rv && rv.querySelector('.u-Form'); if (!form) return;
    var id = L.reg.id, regras = [];
    L.def.ficha.forEach(function (f, i) {
      var mc = L.v.modelColumns[f[0]], cid = mc && (mc.elementId || '') + '_CONTAINER', c = cid && document.getElementById(cid);
      if (!c) return;
      regras.push('html body:not(#nc-a1):not(#nc-a2).nc-aci.nc-aci-analise .nc-aci-gaveta .nc-aci-motor .a-RV .u-Form > #' + cid + ':not(#nc-aci-x):not(#nc-aci-y):not(#nc-aci-z){display:flex!important;order:' + i + '!important}');
      var lb = c.querySelector('.u-Form-label, label'); if (lb && lb.textContent !== f[1]) lb.textContent = f[1];
    });
    if (!folhasX[id]) { folhasX[id] = el('style'); folhasX[id].id = 'nc-aci-ficha-' + id; document.head.appendChild(folhasX[id]); folhasX[id].textContent = regras.join('\n'); }
  }
  function fecharListaCuidado() {
    if (!GX || GX.ocupado) return;
    var mudou = false; try { var md = GX.L.v.model.getRecordMetadata(GX.rid); mudou = !!(md && (md.inserted || md.updated)) && GX.sujou; } catch (e) {}
    if (!mudou) return fecharLista(true);
    apex.message.confirm('Sair sem salvar? O que foi preenchido será descartado.', function (ok) { if (ok) fecharLista(true); });
  }
  function fecharLista(desfazer) {
    if (!GX) return;
    var g = GX, L = g.L, m = L.v.model;
    if (desfazer) {
      try {
        var r = m.getRecord(g.rid), md = r && m.getRecordMetadata(g.rid);
        /* linha nova sai (revertRecords não a tira); a que existia volta ao gravado — mas, no
           acidente novo, só o que foi mexido NESTA gaveta (o resto da lista continua pendente) */
        if (r) { if (md && md.inserted && g.novo) m.deleteRecords([r]); else if (g.sujou && !(md && md.inserted)) m.revertRecords([r]); }
      } catch (e) {}
    }
    /* a vista de um registro NÃO é fechada (ver irParaX): só sai da edição */
    try { L.acts.set('edit', false); } catch (e) {}
    L.sub.classList.remove('nc-aci-motor');
    if (g.lugar.parentNode) { g.lugar.parentNode.insertBefore(L.sub, g.lugar); g.lugar.parentNode.removeChild(g.lugar); }
    document.body.classList.remove('nc-aci-gaveta-aberta');
    GX = null;
    agendarAnalise();
    if (g.volta && document.body.contains(g.volta)) try { g.volta.focus(); } catch (e) {}
  }
  /* CUIDADO: a ficha da grade só passa o valor de um campo para a grade quando o foco vai para
     OUTRO campo dela (Tab). Clicar no Salvar da gaveta (fora da ficha) não passa: o que acabou de
     ser digitado ficava de fora — a gaveta achava que não havia nada a gravar e fechava. Antes de
     salvar, cada campo da FICHA é copiado do formulário para a grade. */
  function numero(t) { t = String(t == null ? '' : t).trim(); if (!t) return NaN; if (t.indexOf(',') > -1) t = t.replace(/\./g, '').replace(',', '.'); return Number(t); }
  function sincronizarFichaX(g) {
    var v = g.L.v, m = v.model, rec = m.getRecord(g.rid); if (!rec) return;
    g.L.def.ficha.forEach(function (f) {
      var mc = v.modelColumns[f[0]], it; if (!mc) return;
      try { it = apex.item(mc.elementId); } catch (e) { return; }
      if (!it || !it.node) return;
      var nv = it.getValue(); if (Array.isArray(nv)) nv = nv.join(':'); nv = nv == null ? '' : String(nv);
      var atual = m.getValue(rec, f[0]), obj = !!atual && typeof atual === 'object', av = obj ? String(atual.v == null ? '' : atual.v) : String(atual == null ? '' : atual);
      if (nv === av) return;
      if (!obj && nv && av && numero(nv) === numero(av)) return;   /* "450" e "450,00": o mesmo número */
      if (obj) { var d = ''; try { d = it.displayValueFor ? it.displayValueFor(nv) : ''; } catch (e) {} m.setValue(rec, f[0], { v: nv, d: d || nv }); }
      else m.setValue(rec, f[0], nv);
    });
  }
  function faltandoX(g) {
    var m = g.L.v.model, r = m.getRecord(g.rid), falta = [];
    g.L.def.ficha.forEach(function (f) {
      var mc = g.L.v.modelColumns[f[0]]; if (!mc || !mc.isRequired) return;
      var x = m.getValue(r, f[0]), v = x && typeof x === 'object' ? x.v : x;
      if (v == null || String(v).trim() === '') falta.push(f[1]);
    });
    return falta;
  }
  function salvarLista(oQue) {
    if (!GX || GX.ocupado) return;
    var g = GX, m = g.L.v.model;
    if (oQue !== 'excluido') sincronizarFichaX(g);
    if (oQue !== 'excluido') {
      var falta = faltandoX(g);
      if (falta.length) return avisoX('Falta preencher: ' + falta.join(', ') + '.', true);
    }
    if (AN.novo || g.L.comPagina) {   /* fica na lista; grava no "Criar comunicação" / "Salvar" da página */
      avisoX(oQue === 'excluido' ? 'Marcado para excluir. Grava ao tocar em ' + (AN.novo ? 'Criar comunicação' : 'Salvar') + '.'
        : 'Na lista. Grava ao tocar em ' + (AN.novo ? 'Criar comunicação' : 'Salvar') + '.');
      return fecharLista(false);
    }
    if (!m.isChanged()) return fecharLista(false);
    g.ocupado = true; g.oQue = oQue || 'salvo'; ocupadoX(true);
    /* CUIDADO: grava pelo MODELO da grade, não pela ação "save": a grade das partes não tem o
       Salvar na barra (grava junto com o Salvar da página) e, assim configurada, a ação existe mas
       não faz nada — a gaveta ficava esperando e dava "confira os campos". model.save() é o que a
       própria grade usa por baixo: roda o processo de gravação da região (e o "Forçar Valores Grid") */
    var fim = function () {
      if (GX !== g || !g.ocupado) return;
      g.ocupado = false; ocupadoX(false);
      var erro = m.hasErrors && m.hasErrors();
      if (m.isChanged() || erro) return avisoX(mensagemX(g) || 'Não foi possível salvar. Confira a mensagem e tente de novo.', true);
      avisoX(g.oQue === 'excluido' ? 'Excluído.' : 'Salvo.');
      fecharLista(false);
      agendarAnalise();
    };
    var pr; try { pr = m.save(); } catch (e) { g.ocupado = false; ocupadoX(false); return avisoX('Não foi possível salvar. Tente de novo.', true); }
    if (pr && typeof pr.then === 'function') pr.then(fim, fim); else setTimeout(fim, 1500);
  }
  /* a mensagem que o servidor pôs no registro (ou num campo dele) */
  function mensagemX(g) {
    try {
      var md = g.L.v.model.getRecordMetadata(g.rid) || {}, f = md.fields || {};
      if (md.message) return md.message;
      for (var k in f) if (f[k] && f[k].message) return f[k].message;
    } catch (e) {}
    return '';
  }
  function excluirLista() {
    if (!GX || GX.ocupado) return;
    var g = GX;
    apex.message.confirm('Excluir ' + (g.L.def.um === 'EPI' ? 'este EPI' : 'esta ' + g.L.def.um) .replace('esta custo', 'este custo') + '?', function (ok) {
      if (!ok || GX !== g) return;
      try { g.L.v.model.deleteRecords([g.L.v.model.getRecord(g.rid)]); } catch (e) { return avisoX('Não foi possível excluir.', true); }
      salvarLista('excluido');
    });
  }
  function ocupadoX(sim) { if (!GAVX) return; GAVX.caixa.classList.toggle('is-ocupada', sim); [].forEach.call(GAVX.pe.querySelectorAll('button'), function (b) { b.disabled = sim; }); }
  $(document).on('apexerror', function () { if (GX && GX.ocupado) { GX.ocupado = false; ocupadoX(false); } });
  /* marca que a pessoa mexeu na ficha (para perguntar antes de descartar) */
  document.addEventListener('input', function (e) { if (GX && GAVX && GAVX.corpo.contains(e.target)) GX.sujou = true; }, true);
  document.addEventListener('change', function (e) { if (GX && GAVX && GAVX.corpo.contains(e.target)) GX.sujou = true; }, true);
  var avisoEl = null, tAvisoX = 0;
  function avisoX(t, erro) {
    if (!avisoEl) { avisoEl = el('div', 'nc-aci-avisox'); avisoEl.setAttribute('role', 'status'); avisoEl.setAttribute('aria-live', 'polite'); document.body.appendChild(avisoEl); }
    avisoEl.innerHTML = (erro ? svg(IC.alerta) : svg(IC.ok)) + '<span>' + esc(t) + '</span>';
    avisoEl.classList.toggle('is-erro', !!erro); avisoEl.classList.add('is-visivel');
    clearTimeout(tAvisoX); tAvisoX = setTimeout(function () { avisoEl.classList.remove('is-visivel'); }, 3800);
  }

  /* ═══ [J19] A JANELA "PARTE DO CORPO ATINGIDA" (página 92) ═══════════════════════════════
     O QUE FAZ  Na janela aberta pelo "Adicionar parte do corpo": a figura no alto marcando a
                parte escolhida, rótulos simples, o lado em quatro botões grandes (Direito,
                Esquerdo, Os dois lados, Não se aplica) e o botão "Criar" como "Adicionar parte".
     LÊ DOS ITENS  P92_COD_PARTE_LESADA, P92_LATERALIDADE, P92_DESCRICAO_PARTE_LESADA
     PODE MEXER • LADOS: [padrão de busca do nome do lado, texto do botão, explicação].
                • ROTULOS (dentro de montarParte): rótulo, ajuda e exemplo dos três campos.
                • os textos 'Adicionar parte' e 'Escolha a parte do corpo e o lado.'.
     CUIDADO    O botão é achado pelo TEXTO "Criar"; se o rótulo mudar no APEX, ele fica como está.
     VISUAL     Natcorp_Acidente.css › [C15]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- a janela "Parte do Corpo Atingida" (p92, aberta pelo Adicionar) ----------
     O lado vira quatro botões (a lista do APEX continua, escondida, e é ela que vai no envio) e a
     figura marca a parte enquanto a pessoa escolhe — é o mesmo ponto que o médico vai ver na ficha */
  var LADOS = [[/direit/, 'Direito', 'O lado direito da pessoa'], [/esquerd/, 'Esquerdo', 'O lado esquerdo da pessoa'],
    [/ambas|dois|bilateral/, 'Os dois lados', ''], [/aplic/, 'Não se aplica', 'Cabeça, peito, costas…']];
  function nomeLado(t) { return String(t || '').replace(/\s*-\s*\d+\s*$/, '').trim().toLowerCase(); }
  function montarParte() {
    document.body.classList.add('nc-aci', 'nc-aci-janela');
    var cP = cont('COD_PARTE_LESADA'), cL = cont('LATERALIDADE'), cD = cont('DESCRICAO_PARTE_LESADA');
    var base = cP.closest('.container') || cP.parentNode;
    var box = el('div', 'nc-aci-passos nc-aci-parte');
    box.innerHTML = '<div class="nc-aci-parte-fig" aria-live="polite"></div><div class="nc-aci-campos"></div>';
    base.parentNode.insertBefore(box, base);
    CAIXA = box;
    var campos = box.querySelector('.nc-aci-campos');
    [['COD_PARTE_LESADA', cP], ['LATERALIDADE', cL], ['DESCRICAO_PARTE_LESADA', cD]].forEach(function (x) { if (x[1]) campos.appendChild(pegar(x[1], x[0])); });
    /* PODE MEXER: rótulo, ajuda e exemplo dos campos da janela */
    ROTULOS = {
      COD_PARTE_LESADA: ['Que parte do corpo?', 'Toque na lista e procure pelo nome: mão, joelho, cabeça…'],
      LATERALIDADE: ['De que lado?', 'O lado da própria pessoa que se machucou.'],
      DESCRICAO_PARTE_LESADA: ['Como ficou?', 'Se quiser: corte, inchaço, dor, queimadura, torção…', 'Ex.: corte no dedo, joelho inchado']
    };
    rotulos();
    var sel = document.getElementById(P + 'LATERALIDADE');
    if (sel && sel.tagName === 'SELECT') {
      var grupo = el('div', 'nc-aci-lados');
      grupo.setAttribute('role', 'radiogroup');
      grupo.setAttribute('aria-labelledby', P + 'LATERALIDADE_LABEL');
      /* na ordem em que se pensa: direito, esquerdo, os dois, não se aplica */
      function ordem(o) { var t = sem(o.text); for (var k = 0; k < LADOS.length; k++) if (LADOS[k][0].test(t)) return k; return 9; }
      [].slice.call(sel.options).sort(function (a, b) { return ordem(a) - ordem(b); }).forEach(function (o) {
        if (!o.value) return;
        var t = sem(o.text), def = LADOS.filter(function (l) { return l[0].test(t); })[0];
        var b = el('button', 'nc-aci-lado-bt', '<span class="nc-aci-sn-marca" aria-hidden="true">' + svg(IC.ok) + '</span><span><b>' +
          esc(def ? def[1] : o.text.replace(/\s*-\s*\d+\s*$/, '')) + '</b>' + (def && def[2] ? '<small>' + esc(def[2]) + '</small>' : '') + '</span>');
        b.type = 'button';
        b.setAttribute('role', 'radio');
        b.setAttribute('data-v', o.value);
        grupo.appendChild(b);
      });
      sel.classList.add('nc-aci-sel-escondido');
      sel.setAttribute('tabindex', '-1');
      sel.setAttribute('aria-hidden', 'true');
      sel.parentNode.insertBefore(grupo, sel);
      grupo.addEventListener('click', function (e) {
        var b = e.target.closest('[data-v]'); if (!b || sel.disabled) return;
        apex.item(P + 'LATERALIDADE').setValue(b.getAttribute('data-v'));
        desenharParte();
      });
      /* 04/10: travar/destravar (ação dinâmica) não dispara change: observa o atributo */
      if (window.MutationObserver) new MutationObserver(function () { desenharParte(); }).observe(sel, { attributes: true, attributeFilter: ['disabled'] });
    }
    var criar = [].slice.call(document.querySelectorAll('.t-Button')).filter(function (b) { return /^criar$/i.test(b.textContent.trim()); })[0];
    if (criar) { var l = criar.querySelector('.t-Button-label'); if (l) l.textContent = 'Adicionar parte'; else criar.textContent = 'Adicionar parte'; }
    $(document).on('change', '[id^="' + P + '"]', function () { setTimeout(desenharParte, 30); });
    $(document).ajaxComplete(function () { setTimeout(desenharParte, 30); });
    desenharParte();
  }
  function desenharParte() {
    var sel = document.getElementById(P + 'LATERALIDADE');
    [].forEach.call(document.querySelectorAll('.nc-aci-lado-bt'), function (b) {
      var on = !!sel && sel.value === b.getAttribute('data-v');
      if (b.getAttribute('aria-checked') !== String(on)) b.setAttribute('aria-checked', String(on));
      /* 04/10: a lista travada pela página (disabled) trava os botões também */
      var trava = !!sel && sel.disabled;
      if (b.disabled !== trava) b.disabled = trava;
    });
    var parte = txt('COD_PARTE_LESADA'), lado = sel && sel.value && sel.options[sel.selectedIndex] ? sel.options[sel.selectedIndex].text : '';
    var fig = document.querySelector('.nc-aci-parte-fig'); if (!fig) return;
    var marcou = parte && pontos(parte, lado).length;
    html(fig, figura(parte ? [{ parte: parte, lado: lado }] : []) +
      '<p class="nc-aci-parte-leg">' + (!parte ? 'Escolha a parte do corpo e o lado.'
        : '<b>' + esc(nomeParte(parte)) + '</b>' + (lado && !/aplic/i.test(lado) ? ' · ' + esc(nomeLado(lado)) : '') + (marcou ? '' : '<small>Esta parte não tem ponto na figura.</small>')) + '</p>');
  }
})();
