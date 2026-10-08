/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · DEPENDENTES  —  o "arrumador" das telas (JavaScript)                           ║
   ║  Um arquivo, TRÊS telas:                                                                 ║
   ║    BLOCO A  Requisição de Dependentes ... app 200 pág. 132  e  app 600 pág. 133          ║
   ║    BLOCO B  Janela "Cadastro de Beneficiárias" (pensão alimentícia) ... app 9132 pág. 3   ║
   ║    BLOCO C  Lista "Dependentes" do portal Conhecendo Você ............ app 600 pág. 131   ║
   ║    BLOCO D  Ficha "Dados de Dependentes" (só consulta) ............... app 300 pág. 22    ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Cada bloco só age na tela dele: ele mesmo verifica, ao abrir, se está na página certa
   (procurando itens que só aquela tela tem). Nas outras páginas, não faz nada.

   BLOCO A · Requisição de Dependentes (p132 do app 200; p133 do app 600)
     O colaborador (ou o gestor, por ele) pede para incluir um dependente, corrigir os dados de
     um dependente ou tirá-lo da lista. Público com pouca leitura, quase sempre no celular.
     No lugar do formulário de 33 campos, UMA PERGUNTA POR VEZ:
       1. "Quem é o dependente?"   cartões com os dependentes de hoje + "Incluir novo dependente"
                                   (tocar num cartão escolhe na lista Dependente do APEX, e a
                                   ação dinâmica da página carrega os dados, como sempre);
       2. "O que você quer fazer?" só para quem já é dependente: Corrigir dados ou Tirar da
                                   lista (é o "Excluir dependente" do APEX: Não / Sim);
       3. os campos em seções por assunto (Quem é, Onde nasceu, Documentos, Mãe, Benefícios,
          Uniforme), com dicas curtas no que é sigla ou jargão. Campo que não estiver no mapa
          vai para "Outros dados": NADA SOME;
       4. os documentos para anexar e a barra do rodapé com o que falta.
     Na p133 (o pedido visto por QUEM APROVA, só com Aprovar/Reprovar): a barra do rodapé vira
     a DECISÃO, com o número de campos alterados (o servidor os pinta de amarelo) e o botão
     "Ver só o que mudou".

   BLOCO B · Janela "Cadastro de Beneficiárias" (p3 do app 9132)
     A pensão alimentícia de um dependente, aberta pelo Editar da região Pensão Alimentícia da
     p133. Os 40 e poucos campos viram seções por assunto; número + dígito (CPF, CEP, telefone,
     agência, conta) ficam lado a lado como uma coisa só; o tipo de chave PIX vira botões; o
     rodapé diz o que falta.

   BLOCO C · Lista "Dependentes" (p131 do app 600)
     As pessoas que a pessoa já tem no cadastro e os pedidos que esperam o RH, em cartões com
     a idade e a situação, em dois grupos. "Adicionar" vira "Incluir dependente".

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: isso continua sendo do APEX.
     • Os campos, botões e ações dinâmicas são os do APEX: aqui eles só MUDAM DE LUGAR.
       O que a página esconde continua escondido.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Nas 4 páginas (200:132, 600:133, 600:131 e 9132:3) › JavaScript › File URLs:
         #WORKSPACE_IMAGES#Natcorp_Dependentes.js
     Na p132, ele entra NO FIM da lista de JavaScript da página (depois de jquery.maskedinput,
     forms-functions e jquery.maskMoney).
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Dependentes.css
     (as mesmas 4 páginas › CSS › File URLs).

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   BLOCO A, página 132: classes postas nas regiões
   (Page Designer › clique na região › Appearance › CSS Classes):
     nc-dep-colaborador   região "Colaborador"                  → a ficha (desenho da Skin geral)
     nc-dep-solicitacao   região "&P132_TITULO." (nº, data)      → sai da tela; o nº vai para o alto
     nc-dep-form          região "Dados do Dependente"          → vira as perguntas e as seções
     nc-dep-anexos        região "Documentos" (Upload)           → desce para depois das seções
     nc-dep-acoes         região dos botões                     → vira a barra do rodapé
   BLOCO A, página 133: SEM classes. O arquivo acha cada região pelo que ela tem (a do item
     NUM_DEPEND, a do COD_REQUISICAO, a que tem título "Documentos…", a que tem "Pensão" no
     título, a dos botões Criar/Salvar). Veja a função regiao() em [J3].
   Itens que o arquivo PRECISA achar (o fim do nome; o começo P132_/P133_ é achado sozinho):
     _NUM_DEPEND e _EXCLUIR_DEPENDENTE (bloco A) · _NOME_LOV, _CHAVE_PIX e _CONTA_CORRENTE
     (bloco B) · uma lista (Media List) cujos links levam _NUM_DEPEND (bloco C).
   Se um desses itens for renomeado no APEX, aquele bloco deixa de agir (a tela fica crua).

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
   BLOCO A · Requisição de Dependentes (p132 / p133)
     [J1]  Como a página é reconhecida ......... e o prefixo P132_/P133_             CUIDADO
     [J2]  O mapa das seções ................... que campo vai em que seção         PODE MEXER
     [J3]  Ferramentas ......................... funções pequenas + achar as regiões
     [J4]  Montar a tela (uma vez) ............. o alto, as perguntas 1 e 2, as seções
     [J5]  Os cartões e o alto ................. "Quem é o dependente?" e o título  PODE MEXER
     [J6]  Atualizar a cada mudança ............ pergunta 2, seções, dica dos documentos
     [J7]  A barra do rodapé ................... o que falta, "Enviar pedido"        PODE MEXER
     [J8]  O que mudou (p133) .................. "N campos alterados neste pedido"
     [J9]  A decisão (p133) .................... Reprovar · Enviar e-mail · Aprovar
     [J10] O maestro ........................... decide QUANDO tudo é montado      CUIDADO
   BLOCO B · Janela "Cadastro de Beneficiárias" (9132 p3)
     [J11] Como a janela é reconhecida ......... e o prefixo                       CUIDADO
     [J12] Seções, rótulos, PIX ................ mapa dos campos e palavras         PODE MEXER
     [J13] Ferramentas ......................... inclui a conferência do CPF
     [J14] Montar a janela (uma vez) ........... o alto, as seções, a grade de descontos
     [J15] PIX, titular e rodapé ............... botões do PIX, "Usar o nome e o CPF"  PODE MEXER
     [J16] Atualizar a cada mudança ............ o alto, avisos de CPF, o que falta    PODE MEXER
     [J17] O maestro ........................... decide QUANDO tudo é montado      CUIDADO
   BLOCO C · Lista "Dependentes" (600 p131)
     [J18] Como a lista é reconhecida ..........                                    CUIDADO
     [J19] Ferramentas ......................... inclui o cálculo da idade
     [J20] O alto e o "Incluir dependente" .....                                    PODE MEXER
     [J21] Os cartões e os dois grupos .........                                    PODE MEXER
     [J22] O maestro ...........................                                    CUIDADO
   BLOCO D · Ficha "Dados de Dependentes" (300 p22)
     [J23] Como a ficha é reconhecida ..........                                    CUIDADO
     [J24] O mapa da ficha e os textos .........  o que vai em cada parte           PODE MEXER
     [J25] Ferramentas .........................  idade, CPF, Sim/Não
     [J26] Montar a ficha ......................  o cartão, "O que ele tem", partes
     [J27] O maestro ...........................

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Quem é o dependente?'  →  'Qual dependente?'
     Criei um campo novo na p132/p133 e ele apareceu em "Outros dados"
       → é o esperado (nada some). Para pô-lo numa seção, siga a receita em [J2].
     Quero mudar a largura de um campo ou a ordem dos campos numa seção     → [J2], lista SECOES
     Na janela da pensão, quero trocar o nome (rótulo) de um campo          → [J12], ROTULOS
     Um campo da janela da pensão deve abrir o teclado de números no celular → [J12], NUMEROS
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp dependentes],
         [Natcorp beneficiária] ou [Natcorp dependentes · lista]. O manual, parte 5, explica.

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
     P + 'NOME_DEPEND'      junta os textos: vira 'P132_NOME_DEPEND', o nome do item no APEX.
     texto(…) / valor(…)    leem o que está num item do APEX (veja [J3]).
     (function () { … })(); um "bloco" que roda sozinho ao carregar. Este arquivo tem três.
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
/* ██████████████████████████████████████████████████████████████████████████████████████████
   BLOCO A · REQUISIÇÃO DE DEPENDENTES (app 200 p132 e app 600 p133)            partes [J1] a [J10]
   ██████████████████████████████████████████████████████████████████████████████████████████ */
(function () {
  'use strict';

  /* ═══ [J1] COMO A PÁGINA É RECONHECIDA (BLOCO A) ═════════════════════════════════════════
     O QUE FAZ  Só continua se a página tiver os itens que terminam em _NUM_DEPEND e em
                _EXCLUIR_DEPENDENTE. Senão, o bloco A para aqui e a página fica como o APEX
                desenhou. A primeira linha impede que o bloco rode duas vezes (URL repetida na
                página, por exemplo) e que rode fora do APEX.
     O PREFIXO  P é o começo do nome dos itens, achado sozinho a partir do NUM_DEPEND: P132_ no
                app 200, P133_ no portal. Por isso o arquivo serve às duas páginas sem mudança.
                DEP e EXC são os nomes completos dos dois itens principais.
     CUIDADO    Se NUM_DEPEND ou EXCLUIR_DEPENDENTE forem renomeados no APEX, o desenho some.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncDependentes || !window.apex || !window.apex.jQuery) return;
  /* o prefixo dos itens vem da própria página (P132_ no app 200, P133_ no portal) */
  var achado = document.querySelector('[id$="_NUM_DEPEND_CONTAINER"]');
  /* a 300:54 não tem EXCLUIR_DEPENDENTE (não tira da lista): vale a classe nc-dep-form na região */
  if (!achado || !document.querySelector('[id$="_EXCLUIR_DEPENDENTE_CONTAINER"]') && !achado.closest('.nc-dep-form')) return;
  window.__ncDependentes = true;

  var $ = apex.jQuery;
  var P = achado.id.replace(/NUM_DEPEND_CONTAINER$/, '');
  var DEP = P + 'NUM_DEPEND', EXC = P + 'EXCLUIR_DEPENDENTE';

  /* ═══ [J2] O MAPA DAS SEÇÕES (BLOCO A) ═══════════════════════════════════════════════════
     O QUE É    A lista SECOES diz, na ordem da tela, quais seções existem e que campos vão em
                cada uma. Campo da região que NÃO estiver aqui vai para "Outros dados" (a
                última seção): nada some da tela.
     COMO LER   Cada seção:  { id, titulo, dica, icone, campos: [ … ] }
                  titulo / dica  → o título da seção e a frase de explicação embaixo dele
                  icone          → o desenho (um dos nomes da lista IC logo abaixo)
                Cada campo:  ['NOME_DO_ITEM', largura no computador, largura no celular, 'dica']
                  NOME_DO_ITEM   → o nome do item SEM o P132_ (ex.: 'NOME_DEPEND')
                  largura no computador → de 1 a 12 (12 = linha inteira, 6 = meia linha)
                  largura no celular    → de 1 a 6  (6 = linha inteira, 3 = meia linha)
                  'dica'         → opcional: frase pequena embaixo do campo. Só diga o que a
                                   página realmente faz.
     PODE MEXER títulos, dicas, larguras, a ORDEM dos campos e em que seção cada um fica.

     RECEITA: PÔR UM CAMPO NOVO NUMA SEÇÃO
       1. Ache a seção desejada abaixo (ex.: a linha com  titulo: 'Uniforme').
       2. Dentro dos colchetes de "campos", acrescente  ['NOME_DO_ITEM', 6, 6]  separado dos
          outros por vírgula. Exemplo:  ['MANEQUIM', 3, 3], ['CALCADO', 3, 3], ['NOVO_ITEM', 6, 6]
       3. Salve, gere, suba o arquivo e recarregue a página (manual, parte 2).
     CUIDADO    Não mude os "id" ('quem', 'docs', 'outros'…) nem apague a seção 'outros': é para
                lá que vai todo campo sem lugar. O texto com aspas e apóstrofo precisa de
                cuidado: dentro de '…' use aspas duplas, como em 'Só quando a condição é "Inválido".'
     VISUAL     Natcorp_Dependentes.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: as seções e seus campos (veja a receita acima) */
  var SECOES = [
    { id: 'quem', titulo: 'Quem é', dica: 'Nome, nascimento e parentesco.', icone: 'pessoa', campos: [
      ['NOME_DEPEND', 8, 6], ['DT_NASC', 4, 6], ['SEXO_DEPEND', 4, 3], ['GRAU_PARENTESCO', 4, 3],
      ['CONDICAO_DEPEND', 4, 3], ['DTLAUDO', 4, 3, 'Só quando a condição é "Inválido".']] },
    { id: 'onde', titulo: 'Onde nasceu', dica: 'País, cidade e nacionalidade.', icone: 'local', campos: [
      ['PAIS_NASCIMENTO', 6, 6], ['CIDADE_NASC', 4, 4], ['EST_NASC', 2, 2],
      ['PAIS_NACIONALIDADE', 6, 6], ['CLASS_TRAB_ESTRANG', 6, 6, 'Só para quem nasceu fora do Brasil.']] },
    { id: 'docs', titulo: 'Documentos', dica: 'CPF e certidão de nascimento ou de casamento.', icone: 'documento', campos: [
      ['NUM_CPF_CONJUGE_DISPLAY', 4, 6],
      /* 300:54: o CPF vem em dois campos, o número e o dígito */
      ['NUM_CPF_CONJUGE', 3, 4], ['DC_CPF_CONJUGE', 1, 2],
      ['TIPO_CERTIDAO', 4, 6], ['DATA_CERTIDAO', 4, 6],
      ['CARTORIO', 6, 6], ['NUM_REGISTRO', 2, 3], ['NUM_LIVRO', 2, 3], ['NUM_FOLHA', 2, 3],
      ['DECL_NASC_VIVOS_DISPLAY', 6, 6, 'Número da Declaração de Nascido Vivo (DNV).'],
      ['DECL_NASC_VIVOS', 6, 6, 'Número da Declaração de Nascido Vivo (DNV).']] },
    { id: 'mae', titulo: 'Mãe do dependente', dica: 'Nome e CPF da mãe.', icone: 'mae', campos: [
      ['MAE_DEPEND', 8, 6], ['CPF_MAE_DEPEND_DISPLAY', 4, 6], ['CPF_MAE_DEPEND', 3, 4], ['DC_CPF_MAE_DEPEND', 1, 2]] },
    { id: 'beneficios', titulo: 'Benefícios e descontos', dica: 'Plano de saúde, imposto de renda e salário-família.', icone: 'escudo', campos: [
      ['DT_DEPENDENTE', 3, 6, 'A partir de quando entra na folha.'], ['DESC_VL_PL_MEDICO', 3, 3], ['DESC_VL_PL_ODONTO', 3, 3], ['IND_AGREGADO', 3, 6],
      ['INCID_IR', 3, 3, 'Imposto de Renda. O sistema ajusta pela idade e pelo parentesco.'],
      ['INCID_SF', 3, 3, 'O sistema ajusta pela idade e pelo parentesco.'],
      ['CART_VACIN', 3, 3], ['FREQ_ESCOLAR', 3, 3]] },
    { id: 'uniforme', titulo: 'Uniforme', dica: 'Tamanho de roupa e de calçado.', icone: 'camisa', campos: [
      ['MANEQUIM', 3, 3], ['CALCADO', 3, 3]] },
    { id: 'outros', titulo: 'Outros dados', dica: '', icone: 'mais', campos: [] }
  ];
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    local: '<path d="M12 21s-6.5-5.6-6.5-11a6.5 6.5 0 0 1 13 0c0 5.4-6.5 11-6.5 11z"/><circle cx="12" cy="10" r="2.5"/>',
    documento: '<rect x="3" y="5" width="18" height="14" rx="2"/><circle cx="8.5" cy="11" r="2"/><path d="M5.5 16c.6-1.5 1.7-2.3 3-2.3s2.4.8 3 2.3M14 10h4.5M14 13.5h3"/>',
    mae: '<circle cx="9" cy="7" r="3.2"/><path d="M3 20a6 6 0 0 1 12 0"/><circle cx="17.5" cy="11.5" r="2.2"/><path d="M14.5 20a3 3 0 0 1 6 0"/>',
    escudo: '<path d="M12 3l7.5 3v5.5c0 4.6-3.2 8.2-7.5 9.5-4.3-1.3-7.5-4.9-7.5-9.5V6z"/><path d="M12 8.5v6M9 11.5h6"/>',
    camisa: '<path d="M8 3.5L3.5 7l2.5 3.5L8 9.5V20.5h8V9.5l2 1 2.5-3.5L16 3.5c-.8 1.3-2.2 2-4 2s-3.2-.7-4-2z"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    sair: '<path d="M14 4h4.5A1.5 1.5 0 0 1 20 5.5v13a1.5 1.5 0 0 1-1.5 1.5H14"/><path d="M10 8l-4 4 4 4M6 12h9"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    clipe: '<path d="M16.5 7.5l-7 7a2 2 0 0 0 2.8 2.8l7.4-7.4a4 4 0 0 0-5.7-5.7L6.6 11.6a6 6 0 0 0 8.5 8.5l5.4-5.4"/>',
    alerta: '<path d="M12 3.5l9.5 16.5h-19z"/><path d="M12 10v4.5M12 17.2v.1"/>'
  };

  /* ═══ [J3] FERRAMENTAS (BLOCO A) ═════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo bloco todo. Não desenham nada sozinhas.
     AS MAIS USADAS:
       texto(id)    o que a PESSOA VÊ no item (o nome da opção escolhida numa lista)
       valor(id)    o que o APEX GUARDA no item (o código da opção, ex.: 'S' ou 'N')
       travado(id)  o item está desabilitado / só leitura no APEX?
       escondido(e) o APEX escondeu este pedaço (ação dinâmica ou condição)?
       bonito(t)    "MARIA DA SILVA" → "Maria da Silva"
       regiao('nc-dep-form')  acha uma região: primeiro pela classe do APEX (p132); se não
                    houver classe (p133), pelo que a região tem dentro.
     CUIDADO    regiao() acha as regiões da p133 por títulos e itens: título começando com
                "Documentos", título com "Pensão", botões "Criar"/"Salvar". Se esses títulos ou
                botões forem renomeados na p133, mude aqui também.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function vazio(t) { return !t || /^\s*(-\s*selecione\s*-|-\s*novo dependente\s*-|-)\s*$/i.test(t); }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.\/ ]+?\s+-\s+/, '').trim(); }
  function maiusculas(t) { return t.length > 3 && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t); }
  function capitalizar(t) { return String(t || '').toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); }); }
  function bonito(t) { t = String(t || '').trim(); if (maiusculas(t)) t = capitalizar(t); return t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); }); }
  function valor(id) { var it = apex.item(id); return it && it.node ? String(it.getValue() || '') : ''; }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-dep-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function porClasse(cls) { return [].slice.call(document.querySelectorAll('.t-Region.' + cls + ', .t-ButtonRegion.' + cls)); }
  /* a região pela classe do APEX (p132); sem ela (p133), pelo que a região tem */
  function topo(r) { while (r && r.parentElement && r.parentElement.closest('.t-Region')) r = r.parentElement.closest('.t-Region'); return r; }
  function dono(n) { var c = document.getElementById(P + n + '_CONTAINER'); return c ? c.closest('.t-Region') : null; }
  function tituloDe(r) { var h = r.querySelector(':scope > .t-Region-header .t-Region-title'); return h ? h.textContent.trim() : ''; }
  function regiao(cls) {
    var r = porClasse(cls)[0];
    if (r) return r;
    if (cls === 'nc-dep-form') return dono('NUM_DEPEND');
    if (cls === 'nc-dep-solicitacao') { var s = dono('COD_REQUISICAO'); return s && s !== dono('NUM_DEPEND') ? s : null; }
    if (cls === 'nc-dep-colaborador') { var c = topo(dono('MATRICULA_DISPLAY')); return c && !escondido(c) ? c : null; }
    if (cls === 'nc-dep-anexos') return [].filter.call(document.querySelectorAll('.t-Region'), function (x) { return /^documentos/i.test(tituloDe(x)) && topo(x) === x; })[0] || null;
    if (cls === 'nc-dep-pensao') return [].filter.call(document.querySelectorAll('.t-Region'), function (x) { return /pens[ãa]o/i.test(tituloDe(x)) && topo(x) === x; })[0] || null;
    if (cls === 'nc-dep-acoes') {
      var b = [].filter.call(document.querySelectorAll('.t-Button'), function (x) { return /^\s*(criar|salvar)\s*$/i.test(x.textContent); })[0];
      return b ? b.closest('.t-ButtonRegion, .t-Region') : null;
    }
    return null;
  }
  function escondido(e, ate) { for (; e && e !== ate && e !== document.body; e = e.parentElement) if (e.style && e.style.display === 'none' || e.hidden) return true; return false; }
  function texto(id) {
    var e = document.getElementById(id);
    if (!e) return '';
    if (e.tagName === 'SELECT') { var o = e.options[e.selectedIndex]; return o && o.value !== '' && !vazio(o.text) ? o.text.trim() : ''; }
    var v = String(e.value || '').trim();
    return vazio(v) ? '' : v;
  }
  /* campo de lista (popup) é sempre readonly: só conta como travado se estiver desabilitado */
  function travado(id) {
    var c = document.getElementById(id + '_CONTAINER'), e = document.getElementById(id);
    if (!e) return true;
    if (c && c.classList.contains('apex-item-wrapper--popup-lov')) return !!(e.disabled || e.classList.contains('apex_disabled'));
    return !!(e.disabled || e.classList.contains('apex_disabled') || e.readOnly && e.tagName !== 'SELECT');
  }
  function rotulo(c) { var l = c && c.querySelector('.t-Form-label'); if (!l) return ''; var k = l.cloneNode(true); [].forEach.call(k.querySelectorAll('.u-VisuallyHidden'), function (x) { x.remove(); }); return k.textContent.replace(/\s+/g, ' ').trim(); }
  function iniciais(nome) { var p = bonito(nome).split(/\s+/).filter(function (w) { return w.length > 2 || /^[A-ZÀ-Ý]/.test(w); }); return ((p[0] || '').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  function primeiro(nome) { return bonito(nome).split(/\s+/)[0] || ''; }

  /* ═══ [J4] MONTAR A TELA (UMA VEZ, BLOCO A) ══════════════════════════════════════════════
     O QUE FAZ  Roda uma vez, ao abrir. Cria:
                  • o ALTO (TOPO): "Dependentes de Fulano" e o nº do pedido. A região da
                    solicitação sai da tela, mas os itens continuam no formulário e vão no envio;
                  • a pergunta 1 (QUEM) e a pergunta 2 (ACAO), no topo da região do formulário;
                  • as SEÇÕES (a lista SECOES de [J2]): cada campo do APEX é levado para a sua;
                  • os DOCUMENTOS descem para depois das seções, na largura toda (e a Pensão
                    Alimentícia, no portal, logo depois deles).
                A lista Dependente e o Excluir do APEX ficam dentro da pergunta 1, fora da vista
                (o APEX e os leitores de tela continuam enxergando). Os cartões e os botões
                "Corrigir" / "Tirar da lista" apenas escolhem um valor NESSES itens.
     PODE MEXER os textos entre aspas: 'Quem é o dependente?', 'Toque em um dependente…',
                'Trocar dependente', 'O que você quer fazer?', 'Corrigir ou completar dados',
                'Tirar da lista de dependentes' e as frases pequenas embaixo de cada opção.
     CUIDADO    Não mude data-exc="N" / data-exc="S": são os valores gravados no item
                EXCLUIR_DEPENDENTE (N = continua, S = sai da lista).
     VISUAL     Natcorp_Dependentes.css › [C2] (o alto), [C3] (perguntas), [C4] (seções),
                [C5] (documentos)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FORM = null, TOPO = null, QUEM = null, ACAO = null, SECS = {}, VER = false, ASSINATURA = '';
  /* a lista de dependentes fica aberta num pedido novo; escolhido alguém (ou já gravado), fecha
     no escolhido + "Trocar dependente" — 12 cartões empilhados no celular são uma tela inteira */
  var ABERTA = null;
  function montar() {
    if (FORM) return;
    FORM = regiao('nc-dep-form');
    if (!FORM) return;
    var corpo = FORM.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    if (!corpo) { FORM = null; return; }

    /* o alto: de quem, e o número do pedido (a região da solicitação sai da tela, mas os itens
       continuam no formulário e vão junto no envio) */
    var col = regiao('nc-dep-colaborador');
    var ancora = col || FORM;
    var linha = ancora.closest('.row') || ancora;
    TOPO = el('section', 'nc-dep-topo'); TOPO.id = 'nc-dep-topo';
    TOPO.innerHTML = '<span class="nc-dep-topo-ic" aria-hidden="true">' + svg(IC.mae) + '</span><div class="nc-dep-topo-txt" data-slot="txt"></div>';
    linha.parentNode.insertBefore(TOPO, linha);
    [regiao('nc-dep-solicitacao')].filter(Boolean).forEach(function (s) { s.classList.add('nc-dep-absorvida'); });

    /* 1. quem é o dependente — os cartões substituem a lista (que continua lá, só fora da vista) */
    QUEM = el('section', 'nc-dep-quem'); QUEM.id = 'nc-dep-quem';
    QUEM.setAttribute('aria-labelledby', 'nc-dep-quem-t');
    QUEM.innerHTML = '<h2 id="nc-dep-quem-t" class="nc-dep-pergunta"><span class="nc-dep-passo" aria-hidden="true">1</span>Quem é o dependente?</h2>' +
      '<p class="nc-dep-sub">Toque em um dependente para ver e corrigir os dados, ou inclua um novo.</p>' +
      '<div class="nc-dep-pessoas" role="radiogroup" aria-labelledby="nc-dep-quem-t" data-slot="pessoas"></div>' +
      '<button type="button" class="nc-dep-trocar" data-slot="trocar">Trocar dependente</button>';
    ACAO = el('section', 'nc-dep-acao'); ACAO.id = 'nc-dep-acao';
    ACAO.setAttribute('aria-labelledby', 'nc-dep-acao-t');
    ACAO.innerHTML = '<h2 id="nc-dep-acao-t" class="nc-dep-pergunta"><span class="nc-dep-passo" aria-hidden="true">2</span><span data-slot="acao-t">O que você quer fazer?</span></h2>' +
      '<div class="nc-dep-opcoes" role="radiogroup" aria-labelledby="nc-dep-acao-t">' +
        '<button type="button" class="nc-dep-opcao" role="radio" data-exc="N">' + '<span class="nc-dep-opcao-ic" aria-hidden="true">' + svg(IC.lapis) + '</span><span class="nc-dep-opcao-tit">Corrigir ou completar dados</span><span class="nc-dep-opcao-dica">Os dados continuam; só muda o que você corrigir.</span></button>' +
        '<button type="button" class="nc-dep-opcao nc-dep-opcao--sair" role="radio" data-exc="S">' + '<span class="nc-dep-opcao-ic" aria-hidden="true">' + svg(IC.sair) + '</span><span class="nc-dep-opcao-tit">Tirar da lista de dependentes</span><span class="nc-dep-opcao-dica">Ele deixa de ser seu dependente na empresa.</span></button>' +
      '</div><div class="nc-dep-aviso-sair" data-slot="aviso" hidden></div>';
    corpo.insertBefore(QUEM, corpo.firstChild);
    QUEM.parentNode.insertBefore(ACAO, QUEM.nextSibling);

    /* 3. as seções: cada contêiner de campo vai para a sua (o item é o mesmo, com as mesmas
       ações dinâmicas); os que não estão no mapa vão para "Outros dados" */
    var todos = [].slice.call(corpo.querySelectorAll('.t-Form-fieldContainer'));
    var usados = {};
    var LISTA = el('div', 'nc-dep-secoes'); LISTA.id = 'nc-dep-secoes';
    ACAO.parentNode.insertBefore(LISTA, ACAO.nextSibling);
    SECOES.forEach(function (s) {
      var sec = el('section', 'nc-dep-sec'); sec.setAttribute('data-sec', s.id);
      sec.setAttribute('aria-labelledby', 'nc-dep-sec-' + s.id);
      sec.innerHTML = '<header class="nc-dep-sec-cab"><span class="nc-dep-sec-ic" aria-hidden="true">' + svg(IC[s.icone]) + '</span><div><h3 id="nc-dep-sec-' + s.id + '">' + esc(s.titulo) + '</h3>' + (s.dica ? '<p>' + esc(s.dica) + '</p>' : '') + '</div><span class="nc-dep-sec-alt" data-slot="alt" hidden></span></header><div class="nc-dep-campos"></div>';
      var grade = sec.querySelector('.nc-dep-campos');
      s.campos.forEach(function (f) {
        var c = document.getElementById(P + f[0] + '_CONTAINER');
        if (!c || usados[c.id]) return;
        usados[c.id] = true;
        grade.appendChild(celula(c, f[1], f[2], f[3]));
      });
      SECS[s.id] = sec;
      LISTA.appendChild(sec);
    });
    todos.forEach(function (c) {
      if (usados[c.id] || c.id === DEP + '_CONTAINER' || c.id === EXC + '_CONTAINER') return;
      SECS.outros.querySelector('.nc-dep-campos').appendChild(celula(c, 6, 6));
    });
    /* a lista Dependente e o Excluir ficam na pergunta, fora da vista (leitores de tela e o
       APEX continuam enxergando) */
    [DEP, EXC].forEach(function (id) { var c = document.getElementById(id + '_CONTAINER'); if (c) { c.classList.add('nc-dep-nativo'); QUEM.appendChild(c); } });
    /* o que sobrou da grade original (colunas vazias e itens ocultos) sai da vista */
    [].forEach.call(corpo.querySelectorAll(':scope > .container'), function (k) { k.classList.add('nc-dep-grade-velha'); });

    /* 4. documentos: depois das seções, na largura toda */
    var anexos = regiao('nc-dep-anexos');
    var formLinha = FORM.closest('.row');
    if (anexos && formLinha) {
      var velhaCol = anexos.closest('.col');
      formLinha.parentNode.insertBefore(anexos, formLinha.nextSibling);
      anexos.classList.add('nc-dep-anexos--fluxo');
      var dica = el('p', 'nc-dep-anexos-dica'); dica.id = 'nc-dep-anexos-dica';
      var cAnexo = anexos.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || anexos;
      cAnexo.insertBefore(dica, cAnexo.firstChild);
      /* a Pensão Alimentícia (portal) vem junto, logo depois dos documentos */
      var pen = regiao('nc-dep-pensao');
      if (pen) { anexos.parentNode.insertBefore(pen, anexos.nextSibling); pen.classList.add('nc-dep-anexos--fluxo', 'nc-dep-pensao'); }
      if (velhaCol && !velhaCol.querySelector('.t-Region, .t-ButtonRegion')) velhaCol.classList.add('nc-dep-col-vazia');
      var fc = FORM.closest('.col'); if (fc) fc.classList.add('nc-dep-col-cheia');
    }

    /* eventos da pergunta */
    QUEM.addEventListener('click', function (e) {
      if (e.target.closest('[data-slot="trocar"]')) {
        ABERTA = true; agendar();
        setTimeout(function () { var s = QUEM.querySelector('.nc-dep-pessoa.is-on') || QUEM.querySelector('.nc-dep-pessoa'); if (s) s.focus(); }, 60);
        return;
      }
      var b = e.target.closest('.nc-dep-pessoa'); if (!b) return;
      var v = b.getAttribute('data-v');
      ABERTA = false;
      if (v !== valor(DEP)) apex.item(DEP).setValue(v);   /* dispara o change: a ação da página carrega os dados */
      VER = false;
      agendar();
    });
    ACAO.addEventListener('click', function (e) {
      var b = e.target.closest('.nc-dep-opcao'); if (!b) return;
      var v = b.getAttribute('data-exc');
      if (v !== valor(EXC)) apex.item(EXC).setValue(v);
      VER = false;
      agendar();
    });
    ACAO.addEventListener('click', function (e) {
      if (!e.target.closest('[data-ver]')) return;
      VER = !VER; agendar();
    });
    /* setas entre os cartões (grupo de rádio) */
    QUEM.addEventListener('keydown', function (e) {
      if (!/^(ArrowRight|ArrowDown|ArrowLeft|ArrowUp)$/.test(e.key)) return;
      var bs = [].slice.call(QUEM.querySelectorAll('.nc-dep-pessoa'));
      var i = bs.indexOf(document.activeElement); if (i < 0) return;
      e.preventDefault();
      var n = bs[(i + (/Right|Down/.test(e.key) ? 1 : -1) + bs.length) % bs.length];
      n.focus();
    });
  }
  function celula(c, larg, cel, dica) {
    var w = el('div', 'nc-dep-campo');
    w.style.setProperty('--nc-l', larg);
    w.style.setProperty('--nc-c', cel);
    w.setAttribute('data-item', c.id.replace(/_CONTAINER$/, ''));
    w.appendChild(c);
    if (dica) w.appendChild(el('p', 'nc-dep-dica', esc(dica)));
    return w;
  }

  /* ═══ [J5] OS CARTÕES DE DEPENDENTES E O ALTO (BLOCO A) ══════════════════════════════════
     O QUE FAZ  montarPessoas(): um cartão para cada opção da lista Dependente do APEX (a opção
                vazia vira "Incluir novo dependente"), com as iniciais e uma frase ("Já é
                dependente", "Ainda não está na lista"). Dois dependentes com o MESMO nome
                mostram o número para diferenciar. Num pedido já gravado, aparece só o escolhido
                e o botão "Trocar dependente".
                montarTopo(): o título "Dependentes de Fulano" e "Pedido nº … · feito em … ·
                por …" (ou, num pedido novo, a frase de explicação).
     LÊ DOS ITENS  NUM_DEPEND (a lista), MATRICULA_DISPLAY, COD_REQUISICAO, DATA_REQUISICAO,
                SOLICITANTE.
     PODE MEXER os textos entre aspas ('Incluir novo dependente', 'Já é dependente',
                'Pedido nº', 'Incluir, corrigir ou tirar um dependente…').
     VISUAL     Natcorp_Dependentes.css › [C2] e [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function opcoes() {
    var s = document.getElementById(DEP);
    if (s && s.options) return [].map.call(s.options, function (o) { return { v: o.value, t: o.text.trim() }; });
    /* o pedido já tem o dependente (a página mostra o nome e guarda o nº num item oculto) */
    var d = document.getElementById(DEP + '_DISPLAY');
    return d && valor(DEP) ? [{ v: valor(DEP), t: d.textContent.trim(), fixo: true }] : [];
  }
  /* dependente que ainda não está no cadastro (incluído por este pedido): o APEX põe na lista uma
     opção com o próprio NÚMERO como texto ("13"). O nome, então, vem do campo Nome. */
  function soNumero(t) { return /^\s*\d+\s*$/.test(t || ''); }
  function nomeDe(t) { if (!soNumero(t)) return t; var n = texto(P + 'NOME_DEPEND'); return !n ? t : n === n.toLowerCase() ? capitalizar(n) : n; }
  function nomeDep() { var d = document.getElementById(DEP + '_DISPLAY'); return nomeDe(d && d.textContent.trim() ? d.textContent.trim() : texto(DEP)); }
  var FIXO = false;
  function montarPessoas() {
    var ops = opcoes();
    var atual = valor(DEP);
    var assinatura = ops.map(function (o) { return o.v + '=' + o.t; }).join('|') + '#' + atual + '#' + texto(P + 'NOME_DEPEND');
    if (assinatura === ASSINATURA) return;
    ASSINATURA = assinatura;
    var nomes = {};
    ops.forEach(function (o) { if (o.v) nomes[o.t.toLowerCase()] = (nomes[o.t.toLowerCase()] || 0) + 1; });
    var foco = document.activeElement && document.activeElement.classList.contains('nc-dep-pessoa');
    var alvo = QUEM.querySelector('[data-slot="pessoas"]');
    FIXO = ops.length === 1 && !!ops[0].fixo;
    var travada = FIXO || travado(DEP) || escondido(document.getElementById(DEP + '_CONTAINER'));
    alvo.innerHTML = ops.map(function (o) {
      var novo = !o.v, on = o.v === atual;
      var nome = novo ? 'Incluir novo dependente' : bonito(nomeDe(o.t));
      var sub = novo ? 'Ainda não está na lista' : o.fixo || soNumero(o.t) ? 'Dependente deste pedido' : (nomes[o.t.toLowerCase()] > 1 ? 'Dependente nº ' + esc(o.v) : 'Já é dependente');
      return '<button type="button" class="nc-dep-pessoa' + (novo ? ' nc-dep-pessoa--novo' : '') + (on ? ' is-on' : '') + '" role="radio" aria-checked="' + on + '" tabindex="' + (on ? '0' : '-1') + '" data-v="' + esc(o.v) + '"' + (travada ? ' disabled' : '') + '>' +
        '<span class="nc-dep-avatar" aria-hidden="true">' + (novo ? svg(IC.mais) : esc(iniciais(nomeDe(o.t)))) + '</span>' +
        '<span class="nc-dep-pessoa-nome">' + esc(nome) + '</span><span class="nc-dep-pessoa-sub">' + sub + '</span>' +
        '<span class="nc-dep-marca" aria-hidden="true">' + svg(IC.ok) + '</span></button>';
    }).join('');
    if (!alvo.querySelector('[tabindex="0"]') && alvo.firstChild) alvo.firstChild.setAttribute('tabindex', '0');
    if (foco) { var f = alvo.querySelector('.is-on'); if (f) f.focus(); }
  }

  function montarTopo() {
    var col = semCodigo(texto(P + 'MATRICULA_DISPLAY'));
    var nReq = valor(P + 'COD_REQUISICAO');
    var dt = texto(P + 'DATA_REQUISICAO');
    var sol = bonito(semCodigo(texto(P + 'SOLICITANTE')));
    var html = '<h1 class="nc-dep-topo-tit">' + (col ? 'Dependentes de ' + esc(primeiro(col)) : 'Dependentes') + '</h1>' +
      (nReq ? '<p class="nc-dep-topo-req">Pedido nº <b>' + esc(nReq) + '</b>' + (dt ? ' · feito em ' + esc(dt) : '') + (sol && col && sol.toLowerCase() !== bonito(col).toLowerCase() ? ' · por ' + esc(sol) : '') + '</p>' :
        '<p class="nc-dep-topo-req">' + (document.getElementById(EXC + '_CONTAINER') ? 'Incluir, corrigir ou tirar um dependente.' : 'Incluir um dependente ou corrigir os dados.') + ' O RH confere antes de valer.</p>');
    var t = TOPO.querySelector('[data-slot="txt"]');
    if (t.innerHTML !== html) t.innerHTML = html;
  }

  /* ═══ [J6] ATUALIZAR A CADA MUDANÇA (BLOCO A) ═══════════════════════════════════════════
     O QUE FAZ  modo() descobre a situação: dependente que já existe? pode tirar da lista? a
                pessoa escolheu "tirar"? Com isso, atualizar():
                  • mostra a pergunta 2 só para quem já é dependente;
                  • no "tirar da lista", mostra o aviso e FECHA as seções (os dados não mudam),
                    com o botão "Ver os dados de …";
                  • esconde a seção que ficou sem nenhum campo à vista;
                  • some com os cartões de dependente quando a página esconde a lista
                    Dependente (p133, dependente novo digitado pelo nome) — 04/10;
                  • conta os campos alterados (p133) — veja [J8];
                  • troca a frase de ajuda dos documentos conforme o caso (montarAnexos).
     PODE MEXER os textos entre aspas (o aviso de saída, 'Ver os dados de', as 3 frases da dica
                dos documentos).
     VISUAL     Natcorp_Dependentes.css › [C3] (aviso de saída), [C4], [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function modo() {
    var existe = !!valor(DEP);
    var cExc = document.getElementById(EXC + '_CONTAINER');
    var podeSair = existe && cExc && !escondido(cExc) && !travado(EXC);
    return { existe: existe, podeSair: !!podeSair, sair: !!podeSair && valor(EXC) === 'S', nome: existe ? bonito(nomeDep()) : '' };
  }

  function atualizar() {
    montarPessoas();
    if (ABERTA === null) ABERTA = !valor(P + 'COD_REQUISICAO');
    QUEM.classList.toggle('nc-dep-quem--fechado', !ABERTA);
    QUEM.classList.toggle('nc-dep-quem--fixo', FIXO);
    QUEM.querySelector('.nc-dep-sub').hidden = !ABERTA || FIXO;
    /* 04/10: a página escondeu a lista Dependente (p133, dependente novo digitado pelo nome):
       os cartões que a substituem somem junto (o item continua lá e vai no envio) */
    QUEM.classList.toggle('nc-dep-quem--sem-lista', escondido(document.getElementById(DEP + '_CONTAINER'), QUEM));
    var m = modo();
    document.body.classList.toggle('nc-dep-modo-novo', !m.existe);
    document.body.classList.toggle('nc-dep-modo-sair', m.sair);

    /* 2. a ação: só para quem já é dependente */
    ACAO.hidden = !m.podeSair;
    if (m.podeSair) {
      ACAO.querySelector('[data-slot="acao-t"]').textContent = DECISAO ? 'O que foi pedido para ' + primeiro(m.nome) : 'O que você quer fazer com ' + primeiro(m.nome) + '?';
      [].forEach.call(ACAO.querySelectorAll('.nc-dep-opcao'), function (b) {
        var on = b.getAttribute('data-exc') === (m.sair ? 'S' : 'N');
        b.classList.toggle('is-on', on); b.setAttribute('aria-checked', String(on));
      });
      var av = ACAO.querySelector('[data-slot="aviso"]');
      av.hidden = !m.sair;
      if (m.sair) {
        var h = '<span class="nc-dep-aviso-ic" aria-hidden="true">' + svg(IC.alerta) + '</span><div><p><b>' + esc(m.nome) + '</b> vai sair da sua lista de dependentes. O RH confere o pedido antes de dar baixa.</p>' +
          '<p>Os dados abaixo não mudam. <button type="button" class="nc-dep-link" data-ver>' + (VER ? 'Esconder os dados' : 'Ver os dados de ' + esc(primeiro(m.nome))) + '</button></p></div>';
        if (av.innerHTML !== h) av.innerHTML = h;
      }
    }

    /* 3. as seções: some a que não tem campo à vista; no "tirar", ficam fechadas até pedir */
    ALTS = 0;
    SECOES.forEach(function (s) {
      var sec = SECS[s.id];
      var celulas = [].slice.call(sec.querySelectorAll('.nc-dep-campo'));
      var algum = false, alt = 0;
      celulas.forEach(function (w) {
        var c = w.querySelector('.t-Form-fieldContainer');
        var fora = !c || escondido(c, w);
        /* 04/10: a Data Laudo NÃO sai mais da vista fora do "Inválido": a página só a TRAVA
           (DA "(Enable/Disable) DTLAUDO"); quem esconde item é a página, nunca o desenho */
        w.classList.toggle('nc-dep-campo--fora', fora);
        var mudou = !fora && alterado(c);
        w.classList.toggle('nc-dep-campo--mudou', mudou);
        if (mudou) alt++;
        if (!fora) algum = true;
      });
      ALTS += alt;
      var chip = sec.querySelector('[data-slot="alt"]');
      if (chip) { chip.hidden = !alt; var t = alt === 1 ? '1 alterado' : alt + ' alterados'; if (chip.textContent !== t) chip.textContent = t; }
      sec.classList.toggle('nc-dep-sec--sem-mudanca', !alt);
      /* 04/10: no "tirar", a seção com campo marcado pela VALIDAÇÃO da página não fica fechada
         (a mensagem do servidor apontava para um campo fora da vista) */
      var erro = !!sec.querySelector('.t-Form-fieldContainer.is-error, .apex-page-item-error');
      sec.hidden = !algum || (m.sair && !VER && !erro);
    });
    document.body.classList.toggle('nc-dep-so-mudou', SO_MUDOU && ALTS > 0);
    montarAlteracoes();

    montarAnexos(m);
    montarBarra(m);
  }

  function montarAnexos(m) {
    var d = document.getElementById('nc-dep-anexos-dica');
    if (!d) return;
    var h = DECISAO ? 'Os documentos que vieram com o pedido. Confira antes de decidir.' : m.sair ?
      'Se tiver, anexe o documento que mostra o motivo da saída. Toque em <b>Anexar</b>.' :
      'Envie foto ou PDF dos documentos do dependente, como a <b>certidão</b> e o <b>CPF</b>. Toque em <b>Anexar</b>.';
    if (d.innerHTML !== h) d.innerHTML = h;
  }

  /* ═══ [J7] A BARRA DO RODAPÉ (BLOCO A) ═══════════════════════════════════════════════════
     O QUE FAZ  A região dos botões (nc-dep-acoes) desce para o fim da tela e fica presa no
                rodapé. Nela aparece o que falta preencher (cada campo é um botão que leva até
                ele; no celular, só "N campos"), ou "Tudo preenchido" / "Pronto para enviar a
                correção" / "Pedido: tirar Fulano". O botão "Criar" passa a se chamar "Enviar
                pedido"; "Deletar" vira "Apagar pedido", discreto e longe do principal.
     COMO SABE O QUE É OBRIGATÓRIO  Pelo próprio APEX: campo com "Value Required" ligado.
                No "tirar da lista", os obrigatórios vazios CONTINUAM contando, mesmo com as
                seções fechadas, porque o servidor valida do mesmo jeito.
     PODE MEXER 'Falta', 'Enviar pedido', 'Apagar pedido', 'Tudo preenchido',
                'Pronto para enviar a correção', 'Pedido: tirar'.
     CUIDADO    /^\s*(criar|salvar)\s*$/i e /^\s*deletar\s*$/i são os textos que o arquivo
                PROCURA nos botões do APEX. Se os botões forem renomeados no APEX, mude aqui.
                Sem botão Criar/Salvar (p133, quem aprova), a barra vira a decisão de [J9].
     VISUAL     Natcorp_Dependentes.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function faltas() {
    return [].slice.call(document.querySelectorAll('#nc-dep-secoes .t-Form-fieldContainer.is-required')).filter(function (c) {
      var id = c.id.replace(/_CONTAINER$/, '');
      var w = c.closest('.nc-dep-campo');
      /* a seção fechada no "tirar" NÃO conta como escondida: o servidor valida o campo do mesmo jeito */
      return !escondido(c, c.closest('.nc-dep-sec')) && !(w && w.classList.contains('nc-dep-campo--fora')) && !travado(id) && vazio(valor(id)) && vazio(texto(id));
    });
  }
  function montarBarra(m) {
    var ac = regiao('nc-dep-acoes');
    if (!ac) return montarDecisao();
    /* quem grava é marcado pelo texto ORIGINAL (o "Criar" passa a se chamar "Enviar pedido") */
    [].forEach.call(ac.querySelectorAll('.t-Button'), function (b) { if (!b.dataset.ncGrava) b.dataset.ncGrava = /^\s*(criar|salvar)\s*$/i.test(b.textContent) ? '1' : '0'; });
    var gravar = [].some.call(ac.querySelectorAll('.t-Button'), function (b) { return b.dataset.ncGrava === '1' && !escondido(b); });
    ac.classList.toggle('nc-dep-acoes--leitura', !gravar);
    if (!ac.dataset.ncMovida) {
      ac.dataset.ncMovida = '1';
      var fim = regiao('nc-dep-pensao') || regiao('nc-dep-anexos') || FORM;
      var linha = fim.classList.contains('nc-dep-anexos--fluxo') ? fim : (fim.closest('.row') || fim);
      linha.parentNode.insertBefore(ac, linha.nextSibling);
      var alvo = ac.querySelector('.t-ButtonRegion-col--content') || ac.querySelector('.t-ButtonRegion-wrap') || ac;
      var s = el('div', 'nc-dep-status'); s.id = 'nc-dep-status'; s.setAttribute('aria-live', 'polite');
      alvo.appendChild(s);
      s.addEventListener('click', function (e) {
        var b = e.target.closest('[data-ir]'); if (!b) return;
        if (document.body.classList.contains('nc-dep-modo-sair') && !VER) { VER = true; tudo(); }
        var c = document.getElementById(b.getAttribute('data-ir')); if (!c) return;
        c.scrollIntoView({ behavior: 'smooth', block: 'center' });
        var i = c.querySelector('input:not([type=hidden]), select, textarea'); if (i) setTimeout(function () { i.focus({ preventScroll: true }); }, 350);
      });
      /* o botão de criar diz o que faz; o de apagar o pedido fica discreto, longe do principal */
      [].forEach.call(ac.querySelectorAll('.t-Button'), function (b) {
        if (/^\s*criar\s*$/i.test(b.textContent)) { var l = b.querySelector('.t-Button-label') || b; l.textContent = 'Enviar pedido'; }
        if (/^\s*deletar\s*$/i.test(b.textContent)) { b.classList.add('nc-dep-apagar'); var l2 = b.querySelector('.t-Button-label') || b; l2.textContent = 'Apagar pedido'; }
      });
    }
    if (!gravar) return;
    var f = faltas();
    var html = f.length ?
      '<span class="nc-dep-status-rot">Falta</span> ' + f.map(function (c) { return '<button type="button" class="nc-dep-falta nc-dep-so-largo" data-ir="' + c.id + '">' + esc(rotulo(c)) + '</button>'; }).join('') +
        '<button type="button" class="nc-dep-falta nc-dep-so-celular" data-ir="' + f[0].id + '">' + f.length + (f.length === 1 ? ' campo' : ' campos') + '</button>' :
      m.sair ? '<span class="nc-dep-status-sair">' + svg(IC.sair) + 'Pedido: tirar ' + esc(primeiro(m.nome)) + '</span>' :
      '<span class="nc-dep-status-ok">' + svg(IC.ok) + (m.existe ? 'Pronto para enviar a correção' : 'Tudo preenchido') + '</span>';
    var st = document.getElementById('nc-dep-status');
    if (st.innerHTML !== html) st.innerHTML = html;
  }

  /* ═══ [J8] O QUE MUDOU (p133, BLOCO A) ═══════════════════════════════════════════════════
     O QUE FAZ  O servidor pinta de AMARELO (background yellow) o campo que o pedido mudou.
                Aqui esses campos são contados: no alto aparece "N campos alterados neste
                pedido" e o botão "Ver só o que mudou" (esconde os campos sem mudança e as
                seções sem nenhuma mudança). Cada seção mostra "N alterados".
     CUIDADO    Depende do amarelo que o servidor põe (processo "Pintar Campos"). Se a cor do
                destaque mudar no APEX, a contagem deixa de funcionar.
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_Dependentes.css › [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- o que mudou (o servidor pinta de amarelo o campo alterado no pedido) ---------- */
  var ALTS = 0, SO_MUDOU = false, ALT_BOX = null;
  function alterado(c) { return !!(c && c.querySelector('input[style*="yellow"], select[style*="yellow"], textarea[style*="yellow"]')); }
  function montarAlteracoes() {
    if (!TOPO) return;
    if (!ALT_BOX) {
      ALT_BOX = el('div', 'nc-dep-mudou'); ALT_BOX.setAttribute('aria-live', 'polite');
      TOPO.appendChild(ALT_BOX);
      ALT_BOX.addEventListener('click', function (e) { if (e.target.closest('[data-so-mudou]')) { SO_MUDOU = !SO_MUDOU; agendar(); } });
    }
    ALT_BOX.hidden = !ALTS;
    var h = ALTS ? '<span class="nc-dep-mudou-n"><i aria-hidden="true"></i>' + (ALTS === 1 ? '1 campo alterado' : ALTS + ' campos alterados') + ' neste pedido</span>' +
      '<button type="button" class="nc-dep-mudou-bt" data-so-mudou aria-pressed="' + SO_MUDOU + '">' + (SO_MUDOU ? 'Ver todos os dados' : 'Ver só o que mudou') + '</button>' : '';
    if (ALT_BOX.innerHTML !== h) ALT_BOX.innerHTML = h;
  }

  /* ═══ [J9] A DECISÃO (p133 COM APROVAR/REPROVAR, BLOCO A) ════════════════════════════════
     O QUE FAZ  Quando a página não tem Criar/Salvar mas tem Aprovar/Reprovar, cria a barra da
                decisão no fim da tela: "Pedido de Fulano", quantos campos mudaram, e os botões
                do APEX nesta ordem: Reprovar, Enviar e-mail, Aprovar (o principal, por último).
                São os MESMOS botões, com as mesmas ações: só mudam de lugar.
     CUIDADO    Os botões são achados pelo texto: Aprovar, Reprovar, Enviar e-mail.
     PODE MEXER 'Pedido de', 'Este pedido' e as frases 'Confira…'.
     VISUAL     Natcorp_Dependentes.css › [C8]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- a decisão (página só com Aprovar/Reprovar: quem aprova) ---------- */
  var DECISAO = false, DEC = null;
  function botoesDecisao() {
    return [].filter.call(document.querySelectorAll('.t-Button'), function (b) { return /^\s*(aprovar|reprovar|enviar e-?mail)\s*$/i.test(b.textContent) && !b.closest('.nc-dep-decisao'); });
  }
  function montarDecisao() {
    if (!DEC) {
      var bts = botoesDecisao().filter(function (b) { return !escondido(b); });
      if (!bts.some(function (b) { return /aprovar|reprovar/i.test(b.textContent); })) return;
      DECISAO = true;
      document.body.classList.add('nc-dep-modo-decisao');
      var orig = bts[0].closest('.t-Region, .t-ButtonRegion');
      DEC = el('section', 'nc-dep-decisao'); DEC.id = 'nc-dep-decisao';
      DEC.setAttribute('aria-label', 'Decisão sobre o pedido');
      DEC.innerHTML = '<div class="nc-dep-decisao-txt" data-slot="txt"></div><div class="nc-dep-decisao-bts"></div>';
      var fim = regiao('nc-dep-pensao') || regiao('nc-dep-anexos') || FORM;
      var linha = fim.classList.contains('nc-dep-anexos--fluxo') ? fim : (fim.closest('.row') || fim);
      linha.parentNode.insertBefore(DEC, linha.nextSibling);
      var alvo = DEC.querySelector('.nc-dep-decisao-bts');
      /* Reprovar à esquerda, o e-mail no meio, Aprovar por último (o principal) */
      bts.sort(function (a, b) { var o = function (x) { return /reprovar/i.test(x.textContent) ? 0 : /e-?mail/i.test(x.textContent) ? 1 : 2; }; return o(a) - o(b); })
        .forEach(function (b) {
          b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-dep-reprovar' : /e-?mail/i.test(b.textContent) ? 'nc-dep-email' : 'nc-dep-aprovar');
          alvo.appendChild(b);
        });
      if (orig && !orig.querySelector('.t-Button:not([style*="none"])')) orig.classList.add('nc-dep-absorvida');
      setTimeout(agendar, 0);   /* a pergunta e a dica dos documentos mudam de voz no modo decisão */
    }
    var nome = primeiro(bonito(nomeDep()));
    var h = '<b>' + (nome ? 'Pedido de ' + esc(nome) : 'Este pedido') + '</b>' +
      '<span>' + (ALTS ? (ALTS === 1 ? '1 campo alterado' : ALTS + ' campos alterados') + ' (em amarelo). Confira antes de decidir.' : 'Confira os dados e os documentos antes de decidir.') + '</span>';
    var t = DEC.querySelector('[data-slot="txt"]');
    if (t.innerHTML !== h) t.innerHTML = h;
  }

  /* ═══ [J10] O MAESTRO (BLOCO A): QUANDO TUDO É MONTADO ═══════════════════════════════════
     O QUE FAZ  tudo() monta (só na primeira vez) e atualiza. iniciar() roda uma vez quando a
                página abre, põe a marca nc-dep na página (é ela que liga o visual do CSS) e
                manda atualizar de novo sempre que algo muda: um item é alterado, uma ação
                dinâmica traz valores do servidor, uma janela fecha, o APEX mostra/esconde/trava
                campos. Uma última atualização roda 0,9 segundo depois de abrir.
     CUIDADO    Não mude a ordem das chamadas em tudo().
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp dependentes] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* rótulos da MESMA linha com a mesma altura: um rótulo que quebra em duas linhas ("Data de
     Nascimento" numa coluna estreita) descia a caixa dele e desalinhava a linha inteira. Os
     campos são agrupados pela altura em que começam; cada rótulo ganha a altura do maior. */
  function alinharRotulos() {
    [].forEach.call(document.querySelectorAll('#nc-dep-secoes .nc-dep-campos'), function (g) {
      var linhas = {};
      [].forEach.call(g.querySelectorAll(':scope > .nc-dep-campo'), function (c) {
        var l = c.querySelector('.t-Form-labelContainer');
        if (!l) return;
        l.style.minHeight = '';
        if (!c.offsetParent) return;
        var y = Math.round(c.getBoundingClientRect().top);
        (linhas[y] = linhas[y] || []).push(l);
      });
      Object.keys(linhas).forEach(function (y) {
        var ls = linhas[y];
        if (ls.length < 2) return;
        var h = Math.max.apply(null, ls.map(function (l) { return l.getBoundingClientRect().height; }));
        ls.forEach(function (l) { if (l.getBoundingClientRect().height < h - .5) l.style.minHeight = h + 'px'; });
      });
    });
  }
  function tudo() {
    montar();
    if (!FORM) return;
    montarTopo();
    atualizar();
    alinharRotulos();
  }
  var agendado = false, MO = null;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () {
      agendado = false;
      try { tudo(); } catch (e) { if (window.console) console.warn('[Natcorp dependentes]', e); }
      if (MO) MO.takeRecords();
    });
  }
  function iniciar() {
    document.body.classList.add('nc-dep');
    tudo();
    $(document).on('change', '[id^="' + P + '"]', agendar);
    $(document).on('input', '#nc-dep-secoes input, #nc-dep-secoes textarea', agendar);
    $(document).on('apexafterrefresh', agendar);
    /* valores trazidos do servidor por ação dinâmica (Executar PL/SQL, "itens a retornar")
       chegam SEM o evento change: sem isto a tela ficava com a leitura de antes da resposta */
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    $(document).on('apexafterclosedialog dialogclose', function () { setTimeout(agendar, 80); });
    if (window.MutationObserver && FORM) {
      /* as ações da página mostram, escondem, travam e trocam as opções da lista */
      MO = new MutationObserver(agendar);
      MO.observe(FORM, { attributes: true, subtree: true, childList: true, attributeFilter: ['style', 'disabled', 'class'] });
    }
    setTimeout(agendar, 900);
    /* a largura muda as quebras dos rótulos ([alinharRotulos]) */
    window.addEventListener('resize', agendar);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();

/* ██████████████████████████████████████████████████████████████████████████████████████████
   BLOCO B · JANELA "CADASTRO DE BENEFICIÁRIAS" (app 9132, página 3)            partes [J11] a [J17]
   ██████████████████████████████████████████████████████████████████████████████████████████
   A JANELA "Cadastro de Beneficiárias" (app 9132, página 3): a pensão alimentícia de um
   dependente, aberta pelo Editar da Pensão Alimentícia da página 133. O colaborador informa
   quem recebe, o que a Justiça decidiu, onde a pessoa mora e para onde vai o dinheiro.
   Os 40 e poucos campos do APEX vão para quatro seções por assunto; CPF, CEP, telefone,
   agência e conta, que a página guarda em duas caixas (número + dígito), ficam lado a lado
   como uma coisa só. O tipo de chave PIX vira botões; "Usar os dados de …" copia nome e CPF
   de quem recebe para o titular da conta. O rodapé diz o que falta. Nada é gravado aqui:
   continua sendo o Salvar da página.
   ===================================================================== */
(function () {
  'use strict';

  /* ═══ [J11] COMO A JANELA É RECONHECIDA (BLOCO B) ════════════════════════════════════════
     O QUE FAZ  Só continua se a página tiver os itens que terminam em _NOME_LOV, _CHAVE_PIX e
                _CONTA_CORRENTE (só a janela da pensão tem os três). O prefixo P (o começo do
                nome dos itens) é achado sozinho a partir do NOME_LOV.
     CUIDADO    Se um desses três itens for renomeado no APEX, a janela fica crua.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncBeneficiaria || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_NOME_LOV_CONTAINER"]');
  if (!achado || !document.querySelector('[id$="_CHAVE_PIX_CONTAINER"]') || !document.querySelector('[id$="_CONTA_CORRENTE_CONTAINER"]')) return;
  window.__ncBeneficiaria = true;

  var $ = apex.jQuery;
  var P = achado.id.replace(/NOME_LOV_CONTAINER$/, '');

  /* ═══ [J12] SEÇÕES, RÓTULOS E PIX (BLOCO B) ═════════════════════════════════════════════
     SECOES   O mapa dos campos, igual ao de [J2]:
                ['NOME_DO_ITEM', largura no computador (de 12), no celular (de 6), 'dica']
              Diferenças desta janela:
                • um PAR  [['NUM_CPF', 'DC_CPF'], 7, 6]  junta número + dígito numa caixa só,
                  com um traço no meio;
                • um texto começando com '#' (ex.: '#Chave PIX') vira um subtítulo na seção;
                • col: 'a' / 'b' diz em que coluna a seção fica na tela larga; 'fim' = embaixo,
                  na largura toda;
                • grade: 'processo' diz que a seção recebe a grade interativa "Processo de
                  Pagamento" (veja [J14]).
              Campo sem lugar no mapa vai para "Outros dados".
     ROTULOS  Os nomes (rótulos) dos campos em palavras de todo dia. O servidor continua
              usando os rótulos dele nas mensagens de erro.
     NUMEROS  Campos que abrem o teclado de números no celular. O dígito de agência e de conta
              fica de fora de propósito: pode ser a letra X.
     PIX      Os tipos de chave PIX, na ordem dos botões: v = o código da opção na lista do
              APEX, t = o texto do botão, dica = o exemplo que aparece dentro da caixa da
              chave, modo = o teclado do celular (numeric, tel, email, text). Só vira botão o
              tipo que a lista da página tiver; um tipo novo da lista entra com o texto dela.
     PODE MEXER títulos, dicas, larguras, a ordem, os rótulos, os textos e dicas do PIX.
     CUIDADO    Não mude os códigos v: '01', '02'… (são os valores gravados).
     VISUAL     Natcorp_Dependentes.css › [C9] a [C13]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: as seções e seus campos.
     cada campo: [item sem o prefixo, colunas no computador (de 12), no celular (de 6), dica].
     Um PAR ([[a, b], …]) é número + dígito numa célula só. */
  var SECOES = [
    { id: 'colab', col: 'a', titulo: 'De quem é o desconto', dica: 'O colaborador que paga a pensão.', icone: 'crachá', campos: [
      ['COD_EMPRESA', 6, 6], ['MATRICULA', 6, 6], ['DSP_EMPRESA', 6, 6], ['DSP_MATRICULA', 6, 6]] },
    { id: 'quem', col: 'a', titulo: 'Quem recebe', dica: 'A pessoa que recebe a pensão.', icone: 'pessoa', campos: [
      ['NOME_LOV', 12, 6], ['GRAU_PARENTESCO', 5, 6], ['CONDICAO_DEPEND_ES', 7, 6],
      ['DT_NASCIMENTO', 5, 6], [['NUM_CPF', 'DC_CPF'], 7, 6], ['NUM_IDENTIDADE', 5, 6]] },
    { id: 'justica', col: 'a', titulo: 'O que a Justiça decidiu', dica: 'Copie do ofício que a empresa recebeu.', icone: 'balanca', campos: [
      ['NUM_OFICIO', 4, 3], ['ORDEM', 3, 3], ['VALOR_GARANTIA', 5, 6],
      ['DATA_SOLICITACAO', 6, 6], ['DATA_FIM', 6, 6, 'Só se o ofício disser quando a pensão acaba.'],
      ['TEXT_OFICIO', 12, 6, 'O que está escrito no ofício sobre o valor e o desconto.']] },
    { id: 'desconto', col: 'fim', titulo: 'Quanto é descontado', dica: 'Uma linha para cada processo de pagamento, com o tipo e o percentual da pensão.', icone: 'porcento', grade: 'processo', campos: [] },
    { id: 'casa', col: 'a', titulo: 'Endereço e telefone', dica: 'Onde mora quem recebe a pensão.', icone: 'casa', campos: [
      [['CEP', 'COMPLEMENTO_CEP'], 5, 6], ['ENDERECO', 7, 6], ['NUMERO', 3, 2], ['COMPLEM', 4, 4],
      ['BAIRRO', 5, 6], ['CIDADE', 7, 6], ['UF', 5, 6], [['DDD', 'TELEFONE'], 6, 6]] },
    { id: 'dinheiro', col: 'b', titulo: 'Para onde vai o dinheiro', dica: 'A conta ou a chave PIX em que a pensão é depositada.', icone: 'banco', campos: [
      '#Titular da conta', ['NOME_CORR', 12, 6], [['NUM_CPF_CORR', 'DC_CPF_CORR'], 7, 6],
      '#Banco e conta', ['BANCO', 3, 3], ['BANCO_NOME', 9, 3],
      [['AGENCIA', 'DC_AGENCIA'], 5, 6], ['AGENCIA_NOME', 7, 6],
      [['CONTA_CORRENTE', 'DC_CONTA_CORRENTE'], 5, 6], ['COD_TP_TRANS_BCA', 7, 6], ['MODALIDADE', 6, 6],
      ['TIPO_OPERACAO', 6, 6, 'Só em conta da Caixa (ex.: 013).'],
      '#Chave PIX', ['TP_ID_CHAVE_PIX', 12, 6], ['CHAVE_PIX', 12, 6]] },
    { id: 'outros', col: 'fim', titulo: 'Outros dados', dica: '', icone: 'mais', campos: [] }
  ];
  /* PODE MEXER: os rótulos da página, em palavras de todo dia (o servidor continua usando os
     dele). Formato:  NOME_DO_ITEM: 'Rótulo novo',  (sem o prefixo) */
  var ROTULOS = {
    NOME_LOV: 'Nome de quem recebe', DT_NASCIMENTO: 'Data de nascimento', NUM_CPF: 'CPF', DC_CPF: 'Dígito',
    NUM_IDENTIDADE: 'RG', NUM_OFICIO: 'Nº do ofício', ORDEM: 'Ordem', VALOR_GARANTIA: 'Valor da garantia',
    DATA_SOLICITACAO: 'Data de inclusão', DATA_FIM: 'Data de término', TEXT_OFICIO: 'Texto do ofício',
    COMPLEMENTO_CEP: 'Final', NUMERO: 'Número', COMPLEM: 'Complemento', UF: 'Estado',
    NOME_CORR: 'Nome do titular', NUM_CPF_CORR: 'CPF do titular', DC_CPF_CORR: 'Dígito',
    BANCO: 'Nº do banco', BANCO_NOME: 'Nome do banco', DC_AGENCIA: 'Dígito', AGENCIA_NOME: 'Nome da agência',
    CONTA_CORRENTE: 'Conta', DC_CONTA_CORRENTE: 'Dígito', COD_TP_TRANS_BCA: 'Tipo de conta',
    TIPO_OPERACAO: 'Operação', TP_ID_CHAVE_PIX: 'Tipo de chave', CHAVE_PIX: 'Chave PIX', MATRICULA: 'Matrícula', DSP_MATRICULA: 'Matrícula'
  };
  /* PODE MEXER: teclado de números no celular (o dígito de agência e conta pode ser X: fica de fora) */
  var NUMEROS = ['NUM_CPF', 'DC_CPF', 'CEP', 'COMPLEMENTO_CEP', 'DDD', 'TELEFONE', 'NUM_CPF_CORR', 'DC_CPF_CORR', 'BANCO', 'AGENCIA', 'CONTA_CORRENTE'];
  /* PODE MEXER (só t, dica e a ordem): tipos de chave PIX, na ordem de uso; a lista da página
     diz quais existem */
  var PIX = [
    { v: '03', t: 'CPF ou CNPJ', dica: 'Só os números do CPF ou do CNPJ', modo: 'numeric' },
    { v: '01', t: 'Celular', dica: 'DDD e número, ex.: 11 99999-9999', modo: 'tel' },
    { v: '02', t: 'E-mail', dica: 'ex.: nome@email.com', modo: 'email' },
    { v: '04', t: 'Chave aleatória', dica: 'Cole a chave que o banco gerou', modo: 'text' }
  ];
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    'crachá': '<rect x="4" y="3.5" width="16" height="17" rx="2.5"/><circle cx="12" cy="10" r="2.6"/><path d="M8 16.5c.8-1.6 2.3-2.4 4-2.4s3.2.8 4 2.4M10 3.5v2h4v-2"/>',
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    balanca: '<path d="M12 4v16M8 20h8M5 7.5h14M12 4.5l-7 3M12 4.5l7 3"/><path d="M5 7.5L2.5 13a2.5 2.5 0 0 0 5 0zM19 7.5L16.5 13a2.5 2.5 0 0 0 5 0z"/>',
    casa: '<path d="M3.5 11L12 4l8.5 7"/><path d="M6 9.5V20h12V9.5"/><path d="M10 20v-5h4v5"/>',
    banco: '<path d="M3 9.5L12 4l9 5.5z"/><path d="M5.5 10.5v7M10 10.5v7M14 10.5v7M18.5 10.5v7M3 20.5h18"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    porcento: '<path d="M18.5 5.5l-13 13"/><circle cx="7" cy="7" r="2.5"/><circle cx="17" cy="17" r="2.5"/>',
    info: '<circle cx="12" cy="12" r="9"/><path d="M12 11v5.5M12 7.6v.1"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    copiar: '<rect x="8.5" y="8.5" width="11" height="11" rx="2"/><path d="M15.5 8.5V6a1.5 1.5 0 0 0-1.5-1.5H6A1.5 1.5 0 0 0 4.5 6v8A1.5 1.5 0 0 0 6 15.5h2.5"/>',
    alerta: '<path d="M12 3.5l9.5 16.5h-19z"/><path d="M12 10v4.5M12 17.2v.1"/>'
  };

  /* ═══ [J13] FERRAMENTAS (BLOCO B) ════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo bloco todo. Aqui elas recebem o nome do item SEM
                o prefixo: valor('NUM_CPF') lê o P…_NUM_CPF.
       valor(n)     o que o APEX guarda no item       mostra(n)    o que a pessoa vê nele
       cont(n)      o bloco inteiro do campo          editavel(n)  dá para digitar nele?
       cpfBate(num, dv)  confere se os 9 números e os 2 dígitos do CPF combinam (só avisa;
                    nunca impede salvar). Responde null enquanto o CPF está incompleto.
     QUANDO MEXER  Quase nunca.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-ben-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function cont(n) { return document.getElementById(P + n + '_CONTAINER'); }
  function valor(n) { var it = apex.item(P + n); return it && it.node ? String(it.getValue() || '').trim() : ''; }
  function mostra(n) { var d = document.getElementById(P + n + '_DISPLAY'); if (d && d.textContent.trim()) return d.textContent.trim(); var e = document.getElementById(P + n); if (e && e.tagName === 'SELECT') { var o = e.selectedOptions[0]; return o && o.value ? o.text.trim() : ''; } return valor(n); }
  function editavel(n) { var e = document.getElementById(P + n); return !!(e && e.tagName !== 'SPAN' && e.type !== 'hidden' && !e.disabled && !e.readOnly); }
  function oculto(c) { return !c || c.style.display === 'none' || c.classList.contains('nc-ben-guardado'); }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function maiusculas(t) { return t.length > 3 && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t); }
  function bonito(t) { t = String(t || '').trim(); if (maiusculas(t)) t = t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); }); return t.replace(/(\s)(De|Da|Do|Das|Dos|E)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); }); }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.\/]+\s*-\s*/, '').trim(); }
  function iniciais(n) { var p = bonito(n).split(/\s+/).filter(function (w) { return w.length > 2; }); if (!p.length) p = bonito(n).split(/\s+/); return ((p[0] || '').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  function rotulo(c) { var l = c && c.querySelector('.t-Form-label'); if (!l) return ''; var k = l.cloneNode(true); [].forEach.call(k.querySelectorAll('.u-VisuallyHidden'), function (x) { x.remove(); }); return k.textContent.replace(/\s+/g, ' ').trim(); }
  function renomear(n, t) {
    var l = document.getElementById(P + n + '_LABEL');
    if (!l || l.getAttribute('data-nc-ben')) return;
    for (var i = 0; i < l.childNodes.length; i++) {
      var x = l.childNodes[i];
      if (x.nodeType === 3 && x.textContent.trim()) { x.textContent = t + ' '; l.setAttribute('data-nc-ben', '1'); return; }
    }
  }
  /* CPF: os 9 números e os 2 dígitos batem? (null = ainda incompleto) */
  function cpfBate(num, dv) {
    var d = String(num).replace(/\D/g, ''), v = String(dv).replace(/\D/g, '');
    if (d.length !== 9 || v.length !== 2) return null;
    if (/^(\d)\1{8}$/.test(d) && v === d.charAt(0) + d.charAt(0)) return false;
    function dig(s) { var t = 0; for (var i = 0; i < s.length; i++) t += +s.charAt(i) * (s.length + 1 - i); var r = (t * 10) % 11; return r === 10 ? 0 : r; }
    var a = dig(d), b = dig(d + a);
    return v === '' + a + b;
  }

  /* ═══ [J14] MONTAR A JANELA (UMA VEZ, BLOCO B) ═══════════════════════════════════════════
     O QUE FAZ  Cria a área nova (RAIZ) antes das regiões do APEX, com:
                  • o ALTO: as iniciais, "Pensão para Fulana", o parentesco e "Descontada do
                    salário de …" (preenchidos em [J16]);
                  • as SEÇÕES do mapa de [J12], em duas colunas na tela larga;
                  • a GRADE "Processo de Pagamento", tirada da aba e posta na seção "Quanto é
                    descontado", com só "Adicionar processo" e "Salvar lista" na barra dela.
                Também troca os rótulos (ROTULOS), põe o teclado de números (NUMEROS), e deixa
                o texto do ofício com 4 linhas que crescem com o texto (até 420px).
                As regiões e a região de abas antigas saem da vista (o que estava escondido nelas
                continua lá).
     PODE MEXER o texto de ajuda da grade ("Adicionar … cria uma linha…").
     CUIDADO    rotular('selection-add-row', …) e rotular('save', …) usam nomes internos da grade
                interativa do APEX: troque só o texto, nunca o primeiro nome.
     VISUAL     Natcorp_Dependentes.css › [C9] (alto), [C10] (seções), [C11] (grade)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var RAIZ = null, TOPO = null, SECS = {}, CELS = [], PIXBOX = null, TITULAR = null, STATUS = null, AVISOS = {};
  function celula(itens, larg, cel, dica) {
    var cs = itens.map(cont).filter(Boolean);
    if (!cs.length) return null;
    var w = el('div', 'nc-ben-campo' + (cs.length > 1 ? ' nc-ben-par' : ''));
    w.style.setProperty('--nc-l', larg);
    w.style.setProperty('--nc-c', cel);
    w.setAttribute('data-item', P + itens[0]);
    if (cs.length > 1) {
      var g = el('div', 'nc-ben-par-g');
      cs.forEach(function (c, i) { if (i) g.appendChild(el('span', 'nc-ben-traco', '–')); g.appendChild(c); });
      w.appendChild(g);
    } else w.appendChild(cs[0]);
    if (dica) w.appendChild(el('p', 'nc-ben-dica', esc(dica)));
    w.__cs = cs;
    CELS.push(w);
    return w;
  }
  function montar() {
    if (RAIZ) return;
    var regs = [].slice.call(document.querySelectorAll('.t-Dialog-body .t-Region, .t-Body-content .t-Region')).filter(function (r) { return r.querySelector('.t-Form-fieldContainer'); });
    if (!regs.length) return;
    RAIZ = el('div', 'nc-ben-raiz');
    RAIZ.id = 'nc-ben';
    regs[0].parentNode.insertBefore(RAIZ, regs[0]);

    TOPO = el('div', 'nc-ben-topo');
    TOPO.innerHTML = '<span class="nc-ben-av" aria-hidden="true"></span><div class="nc-ben-topo-txt"><h2 class="nc-ben-tit"></h2><p class="nc-ben-de"></p></div>';
    RAIZ.appendChild(TOPO);
    /* duas colunas na tela larga (quem recebe, a Justiça e o endereço | o dinheiro); a grade de
       descontos embaixo, na largura toda, para as quatro colunas dela caberem sem rolar */
    var grade = el('div', 'nc-ben-secoes'), COL = { a: el('div', 'nc-ben-coluna'), b: el('div', 'nc-ben-coluna'), fim: el('div', 'nc-ben-coluna nc-ben-coluna--toda') };
    grade.appendChild(COL.a); grade.appendChild(COL.b); grade.appendChild(COL.fim);
    RAIZ.appendChild(grade);

    Object.keys(ROTULOS).forEach(function (n) { renomear(n, ROTULOS[n]); });
    NUMEROS.forEach(function (n) { var e = document.getElementById(P + n); if (e && e.tagName === 'INPUT') e.setAttribute('inputmode', 'numeric'); });
    var vg = document.getElementById(P + 'VALOR_GARANTIA'); if (vg) vg.setAttribute('inputmode', 'decimal');

    var usados = {};
    SECOES.forEach(function (s) {
      var sec = el('section', 'nc-ben-sec nc-ben-sec--' + s.id);
      sec.setAttribute('aria-labelledby', 'nc-ben-t-' + s.id);
      sec.innerHTML = '<header class="nc-ben-sec-cab"><span class="nc-ben-sec-ic">' + svg(IC[s.icone]) + '</span><div><h3 id="nc-ben-t-' + s.id + '">' + esc(s.titulo) + '</h3>' + (s.dica ? '<p class="nc-ben-sec-dica">' + esc(s.dica) + '</p>' : '') + '</div></header>';
      var campos = el('div', 'nc-ben-campos');
      sec.appendChild(campos);
      s.campos.forEach(function (f) {
        if (typeof f === 'string') { campos.appendChild(el('h4', 'nc-ben-grupo', esc(f.slice(1)))); return; }
        var itens = Array.isArray(f[0]) ? f[0] : [f[0]];
        var w = celula(itens, f[1], f[2], f[3]);
        if (!w) return;
        itens.forEach(function (n) { usados[P + n + '_CONTAINER'] = 1; });
        campos.appendChild(w);
      });
      if (s.id === 'outros') {
        regs.forEach(function (r) {
          [].forEach.call(r.querySelectorAll('.t-Form-fieldContainer'), function (c) {
            if (usados[c.id] || c.closest('.nc-ben-raiz')) return;
            var w = celula([c.id.replace(P, '').replace(/_CONTAINER$/, '')], 6, 6);
            if (w) campos.appendChild(w);
          });
        });
      }
      if (s.grade) moverGrade(campos, s.grade);
      SECS[s.id] = sec;
      COL[s.col].appendChild(sec);
    });
    /* a região de abas (Ofício / Processo de Pagamento): o ofício e a grade já saíram dela */
    [].forEach.call(document.querySelectorAll('.t-TabsRegion'), function (r) {
      if (r.closest('.nc-ben-raiz') || r.parentElement.closest('.t-TabsRegion')) return;
      var sobra = [].some.call(r.querySelectorAll('.t-Form-fieldContainer, .a-IG, .a-IRR, .t-Report'), function (x) { return x.style.display !== 'none'; });
      if (!sobra) r.classList.add('nc-ben-absorvida');
    });
    /* o que sobrou nas regiões antigas (itens ocultos) fica lá; a região sai da vista */
    regs.forEach(function (r) { r.classList.add('nc-ben-absorvida'); });

    /* o texto do ofício: começa com 4 linhas e cresce com o texto */
    var tx = document.getElementById(P + 'TEXT_OFICIO');
    if (tx) { tx.setAttribute('rows', '4'); tx.style.removeProperty('resize'); tx.addEventListener('input', crescer); }

    montarPix();
    montarTitular();
    montarRodape();
  }
  /* a grade interativa (Processo de Pagamento) vem da aba para a seção; na barra dela só
     "Adicionar processo" e "Salvar lista" */
  var GRADE = null;
  function moverGrade(campos, nome) {
    var ig = [].filter.call(document.querySelectorAll('.a-IG'), function (x) { return !x.closest('.nc-ben-raiz'); })[0];
    if (!ig) return;
    var rid = ig.id.replace(/_ig$/, ''), reg = document.getElementById(rid) || ig, w, acts;
    try { w = apex.region(rid).widget(); acts = w.interactiveGrid('getActions'); } catch (e) { return; }
    var cx = el('div', 'nc-ben-campo nc-ben-grade');
    cx.style.setProperty('--nc-l', 12);
    cx.style.setProperty('--nc-c', 6);
    cx.appendChild(el('p', 'nc-ben-grade-como', svg(IC.info) + '<span><b>Adicionar ' + esc(nome) + '</b> cria uma linha: preencha na própria tabela e toque em <b>Salvar lista</b>. Para apagar uma linha, use o menu <b>≡</b> dela.<span class="nc-ben-so-celular"> No celular, arraste a tabela para o lado para ver o tipo e o percentual.</span></span>'));
    cx.appendChild(reg);
    campos.appendChild(cx);
    ig.classList.add('nc-ben-grade-ig');
    function rotular(acao, texto) { var a = acts.lookup(acao); if (a) { a.label = texto; acts.update(acao); } }
    rotular('selection-add-row', 'Adicionar ' + nome);
    rotular('save', 'Salvar lista');
    try { acts.hide('reset-report'); } catch (e) {}
    GRADE = { w: w, acts: acts, reg: reg };
    /* a grade estava numa aba fechada: sem isto, nasce sem largura */
    setTimeout(function () {
      try { apex.widget.util.visibilityChange(reg, true); } catch (e) {}
      try { w.interactiveGrid('resize'); } catch (e) {}
    }, 60);
    $(reg).on('change keyup', agendar);
    try { w.on('interactivegridviewmodelcreate', agendar); } catch (e) {}
  }
  function gradePendente() {
    if (!GRADE) return false;
    try { var m = GRADE.w.interactiveGrid('getViews', 'grid').model; return !!(m.isChanged && m.isChanged()); } catch (e) { return false; }
  }
  function crescer() {
    var tx = document.getElementById(P + 'TEXT_OFICIO');
    if (!tx) return;
    tx.style.setProperty('--nc-ben-h', '0px');
    var h = Math.min(Math.max(tx.scrollHeight + 2, 132), 420);
    tx.style.setProperty('--nc-ben-h', h + 'px');
  }

  /* ═══ [J15] PIX, TITULAR E RODAPÉ (BLOCO B) ══════════════════════════════════════════════
     montarPix()     Os botões do tipo de chave PIX no lugar da lista (a lista continua lá,
                     escondida, e é ELA que vai no envio: o botão só escolhe o valor nela).
                     Inclui "Sem PIX" se a lista tiver a opção vazia.
     montarTitular() O botão "A conta é de Fulana? Usar o nome e o CPF de Fulana": copia NOME,
                     NUM_CPF e DC_CPF de quem recebe para NOME_CORR, NUM_CPF_CORR e DC_CPF_CORR.
     montarRodape()  No rodapé da janela: o que falta preencher (cada campo leva até ele).
                     "Salvar" vira "Salvar pensão"; "Criar" vira "Cadastrar pensão"; "Excluir"
                     vira "Excluir esta pensão" e vai para o FIM da janela, longe do Salvar
                     (apagar é raro e não tem volta).
     PODE MEXER os textos entre aspas.
     CUIDADO    /^salvar$/i, /^(deletar|excluir)$/i e /^criar$/i são os textos que o arquivo
                PROCURA nos botões do APEX. Se forem renomeados no APEX, mude aqui também.
     VISUAL     Natcorp_Dependentes.css › [C12] (titular e PIX) e [C13] (rodapé e excluir)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* tipo de chave PIX: botões no lugar da lista (a lista continua, escondida, e é a enviada) */
  function montarPix() {
    var s = document.getElementById(P + 'TP_ID_CHAVE_PIX'), c = cont('TP_ID_CHAVE_PIX');
    if (!s || !s.options || !c) return;
    var tem = {}; [].forEach.call(s.options, function (o) { tem[o.value] = o.text.trim(); });
    var ops = PIX.filter(function (p) { return tem[p.v] !== undefined; });
    /* opção que a lista tenha e que não conhecemos: entra com o texto da lista */
    Object.keys(tem).forEach(function (v) { if (v && !ops.some(function (p) { return p.v === v; })) ops.push({ v: v, t: tem[v], dica: '', modo: 'text' }); });
    if (!ops.length) return;
    PIXBOX = el('div', 'nc-ben-pix');
    PIXBOX.setAttribute('role', 'radiogroup');
    PIXBOX.setAttribute('aria-label', 'Tipo de chave PIX');
    PIXBOX.innerHTML = ops.map(function (p) { return '<button type="button" class="nc-ben-pix-op" role="radio" data-v="' + esc(p.v) + '">' + esc(p.t) + '</button>'; }).join('') +
      (tem[''] !== undefined ? '<button type="button" class="nc-ben-pix-op nc-ben-pix-op--sem" role="radio" data-v="">Sem PIX</button>' : '');
    c.classList.add('nc-ben-nativo-c');
    c.parentNode.insertBefore(PIXBOX, c);
    PIXBOX.__ops = ops;
    PIXBOX.addEventListener('click', function (e) {
      var b = e.target.closest('.nc-ben-pix-op'); if (!b || s.disabled) return;
      var v = b.getAttribute('data-v');
      if (v !== s.value) apex.item(P + 'TP_ID_CHAVE_PIX').setValue(v);
      agendar();
      if (v) setTimeout(function () { var k = document.getElementById(P + 'CHAVE_PIX'); if (k && !k.value) k.focus(); }, 40);
    });
    PIXBOX.addEventListener('keydown', function (e) {
      if (!/^Arrow(Right|Down|Left|Up)$/.test(e.key)) return;
      var bs = [].slice.call(PIXBOX.querySelectorAll('.nc-ben-pix-op')), i = bs.indexOf(document.activeElement);
      if (i < 0) return;
      e.preventDefault();
      var n = bs[(i + (/Right|Down/.test(e.key) ? 1 : -1) + bs.length) % bs.length];
      n.focus(); n.click();
    });
  }
  /* "Usar os dados de …": o titular da conta é, quase sempre, a própria pessoa que recebe */
  function montarTitular() {
    var c = cont('NOME_CORR');
    if (!c) return;
    TITULAR = el('div', 'nc-ben-titular');
    var w = c.closest('.nc-ben-campo');
    w.parentNode.insertBefore(TITULAR, w);
    TITULAR.addEventListener('click', function (e) {
      if (!e.target.closest('.nc-ben-copiar')) return;
      var nome = nomeQuem();
      if (nome) apex.item(P + 'NOME_CORR').setValue(nome);
      if (valor('NUM_CPF')) apex.item(P + 'NUM_CPF_CORR').setValue(valor('NUM_CPF'));
      if (valor('DC_CPF')) apex.item(P + 'DC_CPF_CORR').setValue(valor('DC_CPF'));
      agendar();
    });
  }
  function montarRodape() {
    var col = document.querySelector('.t-Dialog-footer .t-ButtonRegion-col--content') || document.querySelector('.t-ButtonRegion .t-ButtonRegion-col--content');
    if (!col) return;
    col.closest('.t-ButtonRegion').classList.add('nc-ben-acoes');
    STATUS = el('div', 'nc-ben-status');
    STATUS.setAttribute('role', 'status');
    STATUS.setAttribute('aria-live', 'polite');
    col.insertBefore(STATUS, col.firstChild);
    STATUS.addEventListener('click', function (e) {
      if (e.target.closest('[data-salvar-lista]') && GRADE) { try { GRADE.acts.invoke('save'); } catch (x) {} setTimeout(agendar, 900); return; }
      var b = e.target.closest('[data-ir]'); if (!b) return;
      var c = document.getElementById(b.getAttribute('data-ir'));
      if (!c) return;
      c.scrollIntoView({ block: 'center', behavior: 'smooth' });
      var i = c.querySelector('select, input:not([type=hidden]), textarea');
      if (i) setTimeout(function () { i.focus(); }, 250);
    });
    [].forEach.call(document.querySelectorAll('.nc-ben-acoes .t-Button'), function (b) {
      var l = b.querySelector('.t-Button-label'); if (!l) return;
      var t = l.textContent.trim();
      if (/^salvar$/i.test(t)) { l.textContent = 'Salvar pensão'; b.classList.add('nc-ben-salvar'); }
      else if (/^(deletar|excluir)$/i.test(t)) {
        /* apagar é raro e não tem volta: sai do lado do Salvar e vai para o fim da janela */
        l.textContent = 'Excluir esta pensão'; b.classList.add('nc-ben-apagar');
        var fim = el('div', 'nc-ben-fim', '<p>Esta pensão não é mais descontada?</p>');
        fim.appendChild(b);
        RAIZ.appendChild(fim);
      }
      else if (/^criar$/i.test(t)) { l.textContent = 'Cadastrar pensão'; b.classList.add('nc-ben-salvar'); }
    });
  }

  /* ═══ [J16] ATUALIZAR A CADA MUDANÇA (BLOCO B) ═══════════════════════════════════════════
     O QUE FAZ  Roda a cada mudança e refaz: o alto (nome, parentesco, colaborador);
                acende o botão do PIX escolhido e ajusta o exemplo e o teclado da chave; mostra
                ou esconde o botão do titular; avisa CPF que não bate; esconde campos e seções
                que a página escondeu; e escreve o rodapé com o que falta (e o aviso de "lista
                de descontos com alteração não salva").
     LÊ DOS ITENS  NOME_LOV, NOME, GRAU_PARENTESCO, DSP_MATRICULA/MATRICULA, TP_ID_CHAVE_PIX,
                CHAVE_PIX, NOME_CORR, NUM_CPF, DC_CPF, NUM_CPF_CORR, DC_CPF_CORR.
     PODE MEXER os textos entre aspas ('Pensão para', 'Nova pensão alimentícia', 'Confira o
                CPF…', 'Falta preencher:', 'Tudo preenchido. Confira e salve.'…).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function nomeQuem() { return bonito(semCodigo(mostra('NOME_LOV')) || valor('NOME')); }
  function colaborador() {
    /* o nº e o nome vêm juntos no texto da caixa ("205818-NOME"); o valor da lista popup é só o nº */
    var dsp = cont('DSP_MATRICULA'), e = document.getElementById(P + (dsp && dsp.style.display !== 'none' ? 'DSP_MATRICULA' : 'MATRICULA'));
    var m = e ? String(e.value || '').trim() : '';
    var x = /^\s*(\d+)\s*-\s*(.+)$/.exec(m || '');
    return x ? { mat: x[1], nome: bonito(x[2]) } : (m ? { mat: '', nome: bonito(m) } : null);
  }
  function atualizar() {
    /* o alto */
    var nome = nomeQuem(), col = colaborador(), par = semCodigo(mostra('GRAU_PARENTESCO'));
    html(TOPO.querySelector('.nc-ben-av'), nome ? esc(iniciais(nome)) : svg(IC.pessoa));
    html(TOPO.querySelector('.nc-ben-tit'), nome ? 'Pensão para ' + esc(nome) : 'Nova pensão alimentícia');
    var de = [];
    if (par && !/selecione/i.test(par)) de.push('<span class="nc-ben-chip">' + esc(bonito(par)) + '</span>');
    if (col) de.push('<span>Descontada do salário de <b>' + esc(col.nome) + '</b>' + (col.mat ? ' (matrícula ' + esc(col.mat) + ')' : '') + '</span>');
    html(TOPO.querySelector('.nc-ben-de'), de.join(''));

    /* 04/10: Empresa e Matrícula de exibição (DSP_*) ficam à vista na seção "De quem é o
       desconto": são itens da página, e esconder item é só da página (auditoria das regras) */
    var nq = cont('NOME_LOV');
    var escolhe = nq && editavel('NOME_LOV') && document.getElementById(P + 'NOME_LOV').tagName === 'SELECT';
    html(SECS.quem.querySelector('.nc-ben-sec-dica'), escolhe ? 'Escolha a pessoa na lista: CPF, nascimento e parentesco vêm do cadastro dela.' : 'A pessoa que recebe a pensão.');

    /* PIX */
    var tipo = valor('TP_ID_CHAVE_PIX');
    if (PIXBOX) {
      var s = document.getElementById(P + 'TP_ID_CHAVE_PIX');
      classe(PIXBOX, 'is-travado', s.disabled);
      [].forEach.call(PIXBOX.querySelectorAll('.nc-ben-pix-op'), function (b) {
        var on = b.getAttribute('data-v') === tipo;
        classe(b, 'is-on', on);
        if (b.getAttribute('aria-checked') !== String(on)) b.setAttribute('aria-checked', String(on));
        b.tabIndex = on || (!tipo && b === PIXBOX.firstChild) ? 0 : -1;
      });
      var p = PIXBOX.__ops.filter(function (o) { return o.v === tipo; })[0];
      var k = document.getElementById(P + 'CHAVE_PIX');
      if (k) {
        var ph = p ? p.dica : '';
        if (k.getAttribute('placeholder') !== ph) k.setAttribute('placeholder', ph);
        var md = p ? p.modo : 'text';
        if (k.getAttribute('inputmode') !== md) k.setAttribute('inputmode', md);
      }
      /* 04/10: a caixa da chave PIX não sai mais da vista sem tipo escolhido (regra que a
         página não tem); só some se a própria página a esconder */
    }

    /* titular da conta */
    if (TITULAR) {
      var ncorr = bonito(valor('NOME_CORR')), cpf = valor('NUM_CPF').replace(/\D/g, ''), cpfc = valor('NUM_CPF_CORR').replace(/\D/g, '');
      var mesma = nome && ncorr && ncorr.toLowerCase() === nome.toLowerCase() && (!cpf || cpf === cpfc);
      var pode = nome && editavel('NOME_CORR');
      var pn = esc((nome || '').split(/\s+/)[0]);
      html(TITULAR, mesma ? '<span class="nc-ben-titular-ok">' + svg(IC.ok) + 'A conta está no nome de ' + pn + ', quem recebe a pensão.</span>'
        : pode ? '<button type="button" class="nc-ben-copiar">' + svg(IC.copiar) + '<span>A conta é de ' + pn + '? <b>Usar o nome e o CPF de ' + pn + '</b></span></button>' : '');
      classe(TITULAR, 'nc-ben-vazio', !mesma && !pode);
    }

    /* CPF que não bate */
    [['NUM_CPF', 'DC_CPF'], ['NUM_CPF_CORR', 'DC_CPF_CORR']].forEach(function (pr) {
      var c = cont(pr[0]); if (!c) return;
      var w = c.closest('.nc-ben-campo'), ok = cpfBate(valor(pr[0]), valor(pr[1]));
      var av = AVISOS[pr[0]];
      if (!av) { av = AVISOS[pr[0]] = el('p', 'nc-ben-aviso'); av.hidden = true; w.appendChild(av); }
      var h = ok === false ? svg(IC.alerta) + 'Confira o CPF: o número e o dígito não combinam.' : '';
      html(av, h);
      if (av.hidden !== !h) av.hidden = !h;
    });

    /* células e seções: some o que a página escondeu */
    CELS.forEach(function (w) {
      var vis = w.__cs.filter(function (c) { return !oculto(c); });
      classe(w, 'nc-ben-campo--fora', !vis.length);
      if (w.__cs.length > 1) w.__cs.forEach(function (c) { classe(c, 'nc-ben-par-fora', oculto(c)); });
    });
    Object.keys(SECS).forEach(function (k) {
      var sec = SECS[k];
      var tem = sec.querySelector('.nc-ben-campo:not(.nc-ben-campo--fora)');
      if (sec.hidden !== !tem) sec.hidden = !tem;
    });

    /* o que falta (obrigatórios da página que estão à vista e vazios) */
    if (STATUS) {
      var faltam = [];
      CELS.forEach(function (w) {
        if (w.classList.contains('nc-ben-campo--fora')) return;
        w.__cs.forEach(function (c) {
          if (oculto(c) || !c.classList.contains('is-required')) return;
          var n = c.id.replace(P, '').replace(/_CONTAINER$/, '');
          if (!valor(n) && !mostra(n)) faltam.push('<button type="button" class="nc-ben-falta" data-ir="' + c.id + '">' + esc(rotulo(c)) + '</button>');
        });
      });
      var pend = gradePendente() ? '<span class="nc-ben-pendente">' + svg(IC.alerta) + 'A lista de descontos tem alteração não salva <button type="button" class="nc-ben-falta" data-salvar-lista="1">Salvar lista</button></span>' : '';
      html(STATUS, pend + (faltam.length ? '<span class="nc-ben-status-rot">Falta preencher:</span>' + faltam.join('')
        : pend ? '' : '<span class="nc-ben-status-ok">' + svg(IC.ok) + 'Tudo preenchido. Confira e salve.</span>'));
    }
  }

  /* ═══ [J17] O MAESTRO (BLOCO B) ══════════════════════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a janela abre: põe a marca nc-ben (liga o visual
                do CSS), monta, e atualiza de novo a cada mudança de item, digitação, resposta
                do servidor e mudança de estilo/trava feita pelo APEX.
     SE DER ERRO  Aparece no Console (F12 › Console) como [Natcorp beneficiária].
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tudo() { montar(); if (RAIZ) atualizar(); }
  var agendado = false, MO = null;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () {
      agendado = false;
      try { tudo(); } catch (e) { if (window.console) console.warn('[Natcorp beneficiária]', e); }
      if (MO) MO.takeRecords();
    });
  }
  function iniciar() {
    document.body.classList.add('nc-ben');
    tudo();
    crescer();
    $(document).on('change', '[id^="' + P + '"]', agendar);
    $(document).on('input', '#nc-ben input', agendar);
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    if (window.MutationObserver && RAIZ) {
      MO = new MutationObserver(agendar);
      MO.observe(RAIZ, { attributes: true, subtree: true, attributeFilter: ['style', 'disabled'] });
    }
    setTimeout(function () { agendar(); crescer(); }, 700);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();

/* ██████████████████████████████████████████████████████████████████████████████████████████
   BLOCO C · LISTA "DEPENDENTES" DO PORTAL (app 600, página 131)               partes [J18] a [J22]
   ██████████████████████████████████████████████████████████████████████████████████████████
   A LISTA "Dependentes" do portal (app 600, página 131): as pessoas que o colaborador ou o
   candidato já tem no cadastro e os pedidos que ainda esperam o RH. Cada cartão leva à
   página 133 (o pedido). O que ela faz:
     · o alto: o que é esta lista e quantos estão cadastrados / esperando o RH;
     · os cartões em dois grupos — "Esperando o RH" (o pedido ainda não foi aprovado: a
       página marca com "| Requisição" e cor de aviso) e "Já cadastrados";
     · cada cartão: iniciais, nome, parentesco, a IDADE (da data de nascimento) e a situação;
     · o "Adicionar" da página vira "Incluir dependente", grande, logo abaixo do alto (a lista
       costuma ser longa). Se a página o esconde (quem só consulta), continua escondido;
     · "Prosseguir" vira "Continuar".
   Reconhecida pela lista cujos links levam o item …_NUM_DEPEND (sem teste de app/página).
   ===================================================================== */
(function () {
  'use strict';

  /* ═══ [J18] COMO A LISTA É RECONHECIDA (BLOCO C) ═════════════════════════════════════════
     O QUE FAZ  Procura uma lista (Media List) cujos links levem o item _NUM_DEPEND. Se a
                página tiver também o _EXCLUIR_DEPENDENTE, é a p133 (o pedido), não a lista: o
                bloco C para aqui e quem age é o bloco A.
     CUIDADO    Se o link dos cartões deixar de levar o NUM_DEPEND, a lista fica crua.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncDepLista || !window.apex || !window.apex.jQuery) return;
  var UL = [].filter.call(document.querySelectorAll('.t-MediaList'), function (u) {
    return !!u.querySelector('a.t-MediaList-itemWrap[href*="_NUM_DEPEND"]');
  })[0];
  var REG = UL && UL.closest('.t-Region');
  /* a página 133 também pode ter listas: esta é a que NÃO tem o formulário do dependente */
  if (!REG || document.querySelector('[id$="_EXCLUIR_DEPENDENTE_CONTAINER"]')) return;
  window.__ncDepLista = true;

  var $ = apex.jQuery;
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    familia: '<circle cx="8.5" cy="7.5" r="3"/><circle cx="16.5" cy="9" r="2.4"/><path d="M3 19.5a5.5 5.5 0 0 1 11 0M13.5 19.5a4 4 0 0 1 7.5-1.9"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    seta: '<path d="M9 6l6 6-6 6"/>'
  };
  /* ═══ [J19] FERRAMENTAS (BLOCO C) ════════════════════════════════════════════════════════
     O QUE É    Funções pequenas. A mais importante é idade('31/12/2010'): calcula a idade a
                partir da data de nascimento ("recém-nascido", "1 mês", "8 meses", "1 ano",
                "15 anos").
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d) { return '<svg class="nc-dl-ic" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function texto(e) { return e ? e.textContent.replace(/\s+/g, ' ').trim() : ''; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function oculto(e) { return !e || e.style.display === 'none' || getComputedStyle(e).display === 'none'; }
  function bonito(t) {
    t = String(t || '').trim();
    if (t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t)) t = t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); });
    return t.replace(/(\s)(De|Da|Do|Das|Dos|E)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); });
  }
  function iniciais(n) { var p = n.split(/\s+/).filter(function (w) { return w.length > 2; }); if (!p.length) p = n.split(/\s+/); return ((p[0] || '').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  function idade(t) {
    var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); if (!m) return '';
    var n = new Date(+m[3], +m[2] - 1, +m[1]), h = new Date();
    var meses = (h.getFullYear() - n.getFullYear()) * 12 + (h.getMonth() - n.getMonth()) - (h.getDate() < n.getDate() ? 1 : 0);
    if (meses < 0) return '';
    if (meses < 12) return meses <= 1 ? (meses === 1 ? '1 mês' : 'recém-nascido') : meses + ' meses';
    var a = Math.floor(meses / 12);
    return a + (a > 1 ? ' anos' : ' ano');
  }

  /* ═══ [J20] O ALTO E O "INCLUIR DEPENDENTE" (BLOCO C) ════════════════════════════════════
     O QUE FAZ  Cria o alto, "Seus dependentes", com a explicação e as contas ("3 cadastrados",
                "1 pedido esperando o RH"). O botão "Adicionar" da página vira "Incluir
                dependente", grande, logo abaixo do alto (a lista costuma ser longa). Se a página
                o esconde (quem só consulta), ele continua escondido. "Prosseguir" vira
                "Continuar".
     PODE MEXER 'Seus dependentes', a frase de explicação, 'Incluir dependente', 'Continuar'.
     CUIDADO    /^adicionar$/i e /^\s*prosseguir\s*$/i são os textos PROCURADOS nos botões do
                APEX. Se forem renomeados no APEX, mude aqui também.
     VISUAL     Natcorp_Dependentes.css › [C15] e [C16]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var TOPO, ADD, VAGA, GRUPOS = {};
  function montar() {
    TOPO = el('div', 'nc-dl-topo');
    TOPO.innerHTML = '<span class="nc-dl-topo-ic">' + svg(IC.familia) + '</span><div><h2 class="nc-dl-tit">Seus dependentes</h2>' +
      '<p class="nc-dl-txt">As pessoas da sua família que estão no seu cadastro: filhos, marido ou esposa, pais. <b>Toque numa pessoa</b> para ver ou corrigir os dados dela.</p>' +
      '<p class="nc-dl-contas"></p></div>';
    REG.parentNode.insertBefore(TOPO, REG);
    ADD = [].filter.call(REG.querySelectorAll('.t-Button'), function (b) { return /^adicionar$/i.test(texto(b)); })[0];
    VAGA = el('div', 'nc-dl-add');
    TOPO.parentNode.insertBefore(VAGA, TOPO.nextSibling);
    if (ADD) {
      var velho = ADD.closest('.container');
      var l = ADD.querySelector('.t-Button-label') || ADD;
      l.textContent = 'Incluir dependente';
      ADD.classList.add('nc-dl-add-bt');
      if (!ADD.querySelector('.nc-dl-ic')) ADD.insertAdjacentHTML('afterbegin', svg(IC.mais));
      VAGA.appendChild(ADD);
      if (velho && !velho.querySelector('.t-Button, .t-Form-fieldContainer, .t-Region, a, input, select, textarea')) velho.classList.add('nc-dl-oculto');
    }
    [].forEach.call(document.querySelectorAll('.t-Button .t-Button-label'), function (x) {
      if (/^\s*prosseguir\s*$/i.test(x.textContent)) x.textContent = 'Continuar';
    });
  }
  /* ═══ [J21] OS CARTÕES E OS DOIS GRUPOS (BLOCO C) ════════════════════════════════════════
     O QUE FAZ  preparar() lê cada item da lista do APEX (título "NOME | Parentesco |
                Requisição" e a descrição com "Nascimento: dd/mm/aaaa") e acrescenta o cartão:
                iniciais, nome, parentesco, idade e a situação. "| Requisição" no título (ou o
                link levar o COD_REQUISICAO) = pedido que ainda espera o RH.
                atualizar() separa os cartões em dois grupos, nesta ordem: "Esperando o RH" e
                "Já cadastrados", e escreve as contas do alto.
     PODE MEXER 'Pedido esperando o RH', 'Cadastrado', 'Ver pedido', 'Ver ou corrigir',
                os títulos e a dica dos grupos, 'Ninguém no cadastro ainda.'.
     CUIDADO    Depende do formato do título e da descrição da lista no APEX (a barra "|" entre
                as partes, "Requisição", "Nascimento:"). Se a consulta da lista mudar, confira aqui.
     VISUAL     Natcorp_Dependentes.css › [C17]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function preparar(li) {
    if (li.__nc) return li.__nc;
    var a = li.querySelector('a.t-MediaList-itemWrap'); if (!a) return null;
    var h = li.querySelector('.t-MediaList-title'), d = li.querySelector('.t-MediaList-desc');
    var partes = texto(h).split(/\s*\|\s*/);
    var nome = bonito(texto(h && h.querySelector('b')) || partes[0]);
    var resto = partes.slice(1).filter(Boolean);
    /* "| Requisição" (e o ícone de aviso) = pedido que ainda espera o RH; o link leva o nº do pedido */
    var pedido = resto.some(function (x) { return /requisi/i.test(x); }) || /_COD_REQUISICAO/.test(a.getAttribute('href') || '');
    var parentesco = resto.filter(function (x) { return !/requisi/i.test(x); }).join(', ');
    var nasc = /nascimento:\s*(\d{2}\/\d{2}\/\d{4})/i.exec(texto(d)), anos = nasc ? idade(nasc[1]) : '';
    var novo = el('span', 'nc-dl-item');
    novo.innerHTML = '<span class="nc-dl-av" aria-hidden="true">' + esc(iniciais(nome)) + '</span>' +
      '<span class="nc-dl-item-txt"><span class="nc-dl-nome">' + esc(nome) + '</span>' +
      '<span class="nc-dl-sub">' + esc([parentesco, anos].filter(Boolean).join(', ')) + '</span>' +
      (pedido ? '<span class="nc-dl-sit nc-dl-sit--pedido">' + svg(IC.relogio) + 'Pedido esperando o RH</span>' : '<span class="nc-dl-sit nc-dl-sit--ok">' + svg(IC.ok) + 'Cadastrado</span>') +
      '</span><span class="nc-dl-ver">' + (pedido ? 'Ver pedido' : 'Ver ou corrigir') + svg(IC.seta) + '</span>';
    a.classList.add('nc-dl-item-a');
    a.setAttribute('aria-label', nome + (parentesco ? ', ' + parentesco : '') + (anos ? ', ' + anos : '') + (pedido ? ', pedido esperando o RH' : ', cadastrado'));
    a.appendChild(novo);
    li.classList.add('nc-dl-li', pedido ? 'nc-dl-li--pedido' : 'nc-dl-li--ok');
    li.__nc = { pedido: pedido };
    return li.__nc;
  }
  function grupo(id, titulo, dica) {
    if (GRUPOS[id] && GRUPOS[id].parentNode) return GRUPOS[id];
    var g = el('li', 'nc-dl-grupo nc-dl-grupo--' + id, '<span class="nc-dl-grupo-tit">' + esc(titulo) + '</span>' + (dica ? '<span class="nc-dl-grupo-dica">' + esc(dica) + '</span>' : ''));
    g.setAttribute('role', 'presentation');
    GRUPOS[id] = g;
    return g;
  }
  function atualizar() {
    var ul = REG.querySelector('.t-MediaList');
    if (!ul) return;
    ul.classList.add('nc-dl-lista');
    var lis = [].slice.call(ul.querySelectorAll(':scope > li.t-MediaList-item'));
    var pedidos = [], ok = [];
    lis.forEach(function (li) { var d = preparar(li); if (d) (d.pedido ? pedidos : ok).push(li); });
    /* dois grupos, na ordem: o que espera o RH primeiro */
    if (!ul.__nc && (pedidos.length || ok.length)) {
      ul.__nc = true;
      if (pedidos.length) { ul.appendChild(grupo('pedido', 'Esperando o RH', 'Você já pediu. O RH vai conferir e aprovar.')); pedidos.forEach(function (li) { ul.appendChild(li); }); }
      if (ok.length) { ul.appendChild(grupo('ok', 'Já cadastrados', pedidos.length ? '' : '')); ok.forEach(function (li) { ul.appendChild(li); }); }
    }
    html(TOPO.querySelector('.nc-dl-contas'),
      (ok.length ? '<span class="nc-dl-conta">' + svg(IC.ok) + '<b>' + ok.length + '</b> ' + (ok.length > 1 ? 'cadastrados' : 'cadastrado') + '</span>' : '') +
      (pedidos.length ? '<span class="nc-dl-conta nc-dl-conta--pedido">' + svg(IC.relogio) + '<b>' + pedidos.length + '</b> ' + (pedidos.length > 1 ? 'pedidos esperando o RH' : 'pedido esperando o RH') + '</span>' : '') +
      (!ok.length && !pedidos.length ? '<span class="nc-dl-conta">Ninguém no cadastro ainda.</span>' : ''));
    classe(VAGA, 'nc-dl-oculto', !(ADD && !oculto(ADD)));
  }
  /* ═══ [J22] O MAESTRO (BLOCO C) ══════════════════════════════════════════════════════════
     O QUE FAZ  iniciar() monta o alto, põe a marca nc-dl (liga o visual do CSS) e atualiza a
                lista; atualiza de novo quando a página recarrega a região (ao fechar a janela
                do pedido, por exemplo).
     SE DER ERRO  Aparece no Console (F12 › Console) como [Natcorp dependentes · lista].
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var agendado = false, MO = null;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () {
      agendado = false;
      try { atualizar(); } catch (e) { if (window.console) console.warn('[Natcorp dependentes · lista]', e); }
      if (MO) MO.takeRecords();
    });
  }
  function iniciar() {
    montar();
    document.body.classList.add('nc-dl');
    atualizar();
    /* a lista é atualizada pela página (refresh da região ao fechar a janela) */
    $(document).on('apexafterrefresh', function () { setTimeout(agendar, 30); });
    if (window.MutationObserver) {
      MO = new MutationObserver(agendar);
      MO.observe(REG, { attributes: true, subtree: true, attributeFilter: ['style'] });
      MO.observe(VAGA, { attributes: true, subtree: true, attributeFilter: ['style'] });
    }
    setTimeout(agendar, 700);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();

/* ██████████████████████████████████████████████████████████████████████████████████████████
   BLOCO D · FICHA "DADOS DE DEPENDENTES" (app 300, página 22)                 partes [J23] a [J27]
   ██████████████████████████████████████████████████████████████████████████████████████████
   A ficha de UM dependente, só para consulta (a página traz o registro e não grava; o botão
   "Alterar Dados" leva ao pedido, a página 54, que é o bloco A). Quem abre é o colaborador,
   quase sempre no celular. Então:
     · o cartão do dependente: iniciais, nome, "Filho · 12 anos", nascimento, CPF e o nº;
     · "O que ele tem": imposto de renda, salário-família, planos, seguro e auxílios, cada um
       com um sinal de sim / não — o que a pessoa mais quer saber;
     · as partes por assunto (as mesmas palavras das outras telas de dependentes), só com o
       que está preenchido; "Sim/Não" em palavras; código e descrição juntos;
     · "Pedir alteração" (o botão "Alterar Dados" ORIGINAL) e "Voltar";
     · "Ver todos os campos" mostra as regiões originais.
   Nada é gravado; os campos continuam na página. Reconhecida pelos itens …_NUM_DEPEND e
   …_OPTOU_PL_MED, sem …_EXCLUIR_DEPENDENTE (que é o pedido).
   ===================================================================== */
(function () {
  'use strict';

  /* ═══ [J23] COMO A FICHA É RECONHECIDA (BLOCO D) ═════════════════════════════════════════ */
  if (window.__ncDepFicha || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_NUM_DEPEND_CONTAINER"]');
  if (!achado || !document.querySelector('[id$="_OPTOU_PL_MED_CONTAINER"]') || document.querySelector('[id$="_EXCLUIR_DEPENDENTE_CONTAINER"]')) return;
  window.__ncDepFicha = true;
  var P = achado.id.replace(/NUM_DEPEND_CONTAINER$/, '');
  var $ = apex.jQuery;

  /* ═══ [J24] O MAPA DA FICHA E OS TEXTOS (BLOCO D) ════════════════════════════════════════
     PODE MEXER  TEM: os sinais de "O que ele tem" ([item, texto]). PARTES: cada parte e os
                 campos dela ([item, rótulo]; item "CPF" e "CPF_MAE" juntam número + dígito;
                 "PLANO"/"PLANO2"… juntam código e descrição). Campo preenchido que não estiver
                 no mapa vai para "Outros dados": nada some.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var TEM = [
    ['INCID_IR', 'Imposto de renda'], ['INCID_SF', 'Salário-família'], ['OPTOU_PL_MED', 'Plano médico'],
    ['OPTOU_PL_ODO', 'Plano odontológico'], ['OPTANTE_SEGURO', 'Seguro de vida'], ['INCID_AUX_CRECHE', 'Auxílio-creche'],
    ['AUX_EXCEPCIONAL', 'Auxílio excepcional'], ['CART_VACIN', 'Carteira de vacinação']
  ];
  var PARTES = [
    { titulo: 'Quem é', icone: 'pessoa', campos: [['GRAU_PARENTESCO', 'Parentesco'], ['TIPO_DEPEND', 'Tipo'], ['SEXO_DEPEND', 'Sexo'], ['DT_NASC', 'Nascimento'],
      ['ESTADO_CIVIL', 'Estado civil'], ['CONDICAO_DEPEND', 'Condição'], ['IND_AGREGADO', 'Agregado'], ['DT_DEPENDENTE', 'Na folha desde'], ['FREQ_ESCOLAR', 'Frequência escolar']] },
    { titulo: 'Onde nasceu', icone: 'local', campos: [['PAIS_NASCIMENTO', 'País'], ['CIDADE_NASC', 'Cidade'], ['EST_NASC', 'Estado'],
      ['PAIS_NACIONALIDADE', 'Nacionalidade'], ['CLASS_TRAB_ESTRANG', 'Estrangeiro']] },
    { titulo: 'Documentos', icone: 'documento', campos: [['CPF', 'CPF'], ['TIPO_CERTIDAO', 'Certidão'], ['DATA_CERTIDAO', 'Data da certidão'], ['CARTORIO', 'Cartório'],
      ['NUM_REGISTRO', 'Registro'], ['NUM_LIVRO', 'Livro'], ['NUM_FOLHA', 'Folha'], ['DECL_NASC_VIVOS', 'Nascido vivo (DNV)'], ['COD_NACIONAL_SAUDE', 'Cartão SUS']] },
    { titulo: 'Mãe do dependente', icone: 'mae', campos: [['MAE_DEPEND', 'Nome'], ['CPF_MAE', 'CPF']] },
    { titulo: 'Plano médico', icone: 'escudo', campos: [['OPTOU_PL_MED', 'No plano do titular'], ['PLANO', 'Plano'], ['TIPO_PLANO', 'Tipo'], ['DT_ADESAO', 'Entrou em'],
      ['DT_ADESAO2', 'Saiu em'], ['INCID_PLANO_MED', 'Desconta na folha'], ['OBSERVACAO_AM', 'Observação']] },
    { titulo: 'Plano odontológico', icone: 'escudo', campos: [['OPTOU_PL_ODO', 'No plano do titular'], ['PLANO2', 'Plano'], ['TIPO_PLANO2', 'Tipo'],
      ['DT_ADESAO_FINAL', 'Entrou em'], ['DT_ADESAO2_FINAL', 'Saiu em'], ['OBSERVACAO_AO', 'Observação']] },
    { titulo: 'Outras informações', icone: 'mais', campos: [['DATA_BAIXA', 'Saiu do imposto de renda em'], ['MOT_INATIVACAO', 'Motivo da inativação'],
      ['DEPRPPS', 'Previdência própria'], ['MANEQUIM', 'Manequim'], ['CALCADO', 'Calçado']] }
  ];
  /* os campos que a ficha já mostra de outro jeito (o alto, os juntados) ou que não são do dependente */
  var JA = /^(NUM_DEPEND|NOME_DEPEND|NUM_CPF_CONJUGE|DC_CPF_CONJUGE|CPF_MAE_DEPEND|DC_CPF_MAE_DEPEND|CODIGO_PLANO2?|DESC_PLANO_MEDICO2?|CODIGO_TIPO2?|DESC_TIPO_PLANO_MEDICO2?|COD_EMPRESA|MATRICULA|DC_MATRICULA|OPTANTE_SEGURO|INCID_IR|INCID_SF|INCID_AUX_CRECHE|AUX_EXCEPCIONAL|CART_VACIN)$/;
  var T = { tem: 'O que ele tem', nao: 'não', sim: 'sim', anos: function (n) { return n === 1 ? '1 ano' : n + ' anos'; }, meses: function (n) { return n === 1 ? '1 mês' : n + ' meses'; },
    nasceu: 'Nasceu em', numero: function (n) { return 'Dependente nº ' + n; }, pedir: 'Pedir alteração', outros: 'Outros dados',
    todos: 'Ver todos os campos', ficha: 'Ver a ficha' };
  var IC = {
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    local: '<path d="M12 21s-6.5-5.6-6.5-11a6.5 6.5 0 0 1 13 0c0 5.4-6.5 11-6.5 11z"/><circle cx="12" cy="10" r="2.5"/>',
    documento: '<rect x="3" y="5" width="18" height="14" rx="2"/><circle cx="8.5" cy="11" r="2"/><path d="M5.5 16c.6-1.5 1.7-2.3 3-2.3s2.4.8 3 2.3M14 10h4.5M14 13.5h3"/>',
    mae: '<circle cx="9" cy="7" r="3.2"/><path d="M3 20a6 6 0 0 1 12 0"/><circle cx="17.5" cy="11.5" r="2.2"/><path d="M14.5 20a3 3 0 0 1 6 0"/>',
    escudo: '<path d="M12 3l7.5 3v5.5c0 4.6-3.2 8.2-7.5 9.5-4.3-1.3-7.5-4.9-7.5-9.5V6z"/><path d="M12 8.5v6M9 11.5h6"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    tracinho: '<path d="M7 12h10"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    lista: '<path d="M9 6.5h11M9 12h11M9 17.5h11"/><circle cx="4.8" cy="6.5" r="1.1"/><circle cx="4.8" cy="12" r="1.1"/><circle cx="4.8" cy="17.5" r="1.1"/>'
  };

  /* ═══ [J25] FERRAMENTAS (BLOCO D) ════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { t = String(t == null ? '' : t).replace(/ /g, ' ').replace(/\s+/g, ' ').trim(); return /^[-–—]$/.test(t) ? '' : t; }
  function svg(n) { return '<svg class="nc-dv-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  function bonito(t) {
    t = limpo(t); if (!t || t !== t.toUpperCase() || !/[A-Z]/.test(t)) return t;
    return t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); }).replace(/\s(De|Da|Do|Das|Dos|E)(?=\s)/g, function (m) { return m.toLowerCase(); });
  }
  /* o que a pessoa vê no item: o texto da opção numa lista, o valor num campo */
  function texto(nome) {
    /* campo só de leitura: o APEX desenha só o _DISPLAY (o item pode nem ter o id) */
    var d = $id(P + nome + '_DISPLAY'); if (d && limpo(d.textContent)) return limpo(d.textContent);
    var e = $id(P + nome); if (!e) return '';
    if (e.tagName === 'SELECT') { var o = e.options[e.selectedIndex]; return o && o.value !== '' ? limpo(o.text) : ''; }
    return limpo(e.value != null ? e.value : e.textContent);
  }
  function codigo(nome) { var e = $id(P + nome); return e ? limpo(e.value) : ''; }
  function data(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  function extenso(d) { return (d.getDate() === 1 ? '1º' : d.getDate()) + ' de ' + MESES[d.getMonth()] + ' de ' + d.getFullYear(); }
  function idade(d) {
    var h = new Date(), a = h.getFullYear() - d.getFullYear();
    if (h.getMonth() < d.getMonth() || (h.getMonth() === d.getMonth() && h.getDate() < d.getDate())) a--;
    if (a >= 1) return T.anos(a);
    var m = (h.getFullYear() - d.getFullYear()) * 12 + h.getMonth() - d.getMonth() - (h.getDate() < d.getDate() ? 1 : 0);
    return T.meses(Math.max(0, m));
  }
  /* CPF de número + dígito ("12345678" + "9") → "001.234.567-89"; 0 ou vazio → '' */
  function cpf(num, dc) {
    var n = String(codigo(num) || '').replace(/\D/g, ''), d = String(codigo(dc) || '').replace(/\D/g, '');
    if (!n || /^0+$/.test(n)) return '';
    var s = (n + (d ? ('0' + d).slice(-2) : '')).padStart(11, '0');
    return s.length === 11 ? s.slice(0, 3) + '.' + s.slice(3, 6) + '.' + s.slice(6, 9) + '-' + s.slice(9) : n + (d ? '-' + d : '');
  }
  function juntar(a, b) { var x = bonito(texto(a)), y = bonito(texto(b)); if (!x) return y; if (!y || y === x) return x; return x + ' - ' + y; }
  function valorDe(nome) {
    if (nome === 'CPF') return cpf('NUM_CPF_CONJUGE', 'DC_CPF_CONJUGE');
    if (nome === 'CPF_MAE') return cpf('CPF_MAE_DEPEND', 'DC_CPF_MAE_DEPEND');
    if (nome === 'PLANO') return juntar('CODIGO_PLANO', 'DESC_PLANO_MEDICO');
    if (nome === 'TIPO_PLANO') return juntar('CODIGO_TIPO', 'DESC_TIPO_PLANO_MEDICO');
    if (nome === 'PLANO2') return juntar('CODIGO_PLANO2', 'DESC_PLANO_MEDICO2');
    if (nome === 'TIPO_PLANO2') return juntar('CODIGO_TIPO2', 'DESC_TIPO_PLANO_MEDICO2');
    var t = texto(nome);
    if (/^0$/.test(t) && /NUM_|DECL_/.test(nome)) return '';
    if (/^\d{2}\/\d{2}\/1900$/.test(t)) return '';   /* 01/01/1900 = data não preenchida no cadastro */
    if (/^[SN]$/.test(t)) return t === 'S' ? 'Sim' : 'Não';   /* campo de texto com S/N */
    if (/^[A-Z]{2,3}$/.test(t)) return t;                     /* sigla (UF): fica em maiúsculas */
    return bonito(t);
  }

  /* ═══ [J26] MONTAR A FICHA (BLOCO D) ═════════════════════════════════════════════════════ */
  function montar() {
    var regDep = achado.closest('.t-Region'); if (!regDep) return;
    document.body.classList.add('nc-dv');
    /* as regiões do dependente (todas as que têm itens P…, menos a do colaborador) */
    var regs = [].filter.call(document.querySelectorAll('.t-Region'), function (r) {
      return r.querySelector('[id^="' + P + '"][id$="_CONTAINER"]') && !r.querySelector('img[id="' + P + 'FOTO"]') && !r.parentElement.closest('.t-Region');
    });
    regs.forEach(function (r) { r.classList.add('nc-dv-original'); });
    var nome = bonito(texto('NOME_DEPEND')) || 'Dependente';
    var nasc = data(texto('DT_NASC')), parent = bonito(texto('GRAU_PARENTESCO'));
    var iniciais = nome.split(/\s+/).filter(function (w) { return w.length > 2; }), ini = ((iniciais[0] || nome).charAt(0) + (iniciais.length > 1 ? iniciais[iniciais.length - 1].charAt(0) : '')).toUpperCase();
    var ficha = el('section', 'nc-dv-ficha');
    var c = cpf('NUM_CPF_CONJUGE', 'DC_CPF_CONJUGE');
    ficha.innerHTML =
      '<header class="nc-dv-cartao"><span class="nc-dv-ini" aria-hidden="true">' + esc(ini) + '</span><div class="nc-dv-quem">' +
        '<h2>' + esc(nome) + '</h2>' +
        '<p class="nc-dv-linha">' + esc([parent, nasc ? idade(nasc) : ''].filter(Boolean).join(' · ')) + '</p>' +
        '<p class="nc-dv-sub">' + esc([nasc ? T.nasceu + ' ' + extenso(nasc) : '', c ? 'CPF ' + c : '', texto('NUM_DEPEND') ? T.numero(texto('NUM_DEPEND')) : ''].filter(Boolean).join(' · ')) + '</p>' +
      '</div><div class="nc-dv-botoes"></div></header>' +
      '<div class="nc-dv-tem"><h3>' + esc(T.tem) + '</h3><ul>' + TEM.filter(function (x) { return $id(P + x[0]); }).map(function (x) {
        var v = codigo(x[0]), sim = v === 'S', nao = v === 'N';
        return '<li class="nc-dv-tem-' + (sim ? 'sim' : nao ? 'nao' : 'vazio') + '"><span class="nc-dv-tem-sinal" aria-hidden="true">' + svg(sim ? 'ok' : 'tracinho') + '</span><span>' + esc(x[1]) + '<b>' + (sim ? T.sim : nao ? T.nao : '—') + '</b></span></li>';
      }).join('') + '</ul></div>';
    /* as partes; o que não estiver no mapa e estiver preenchido vai para "Outros dados" */
    var usados = {};
    PARTES.forEach(function (pt) { pt.campos.forEach(function (x) { usados[x[0]] = 1; }); });
    var outros = [].map.call(document.querySelectorAll('.nc-dv-original [id^="' + P + '"][id$="_CONTAINER"]'), function (cx) {
      var nm = cx.id.slice(P.length).replace(/_CONTAINER$/, ''); if (usados[nm] || JA.test(nm) || /^DISPLAY/.test(nm)) return null;
      var l = cx.querySelector('.t-Form-label'); return l ? [nm, limpo(l.textContent)] : null;
    }).filter(Boolean);
    var partes = PARTES.concat(outros.length ? [{ titulo: T.outros, icone: 'mais', campos: outros }] : []);
    ficha.insertAdjacentHTML('beforeend', '<div class="nc-dv-partes">' + partes.map(function (pt) {
      var linhas = pt.campos.map(function (x) { var v = valorDe(x[0]); return v ? '<div><dt>' + esc(x[1]) + '</dt><dd>' + esc(v) + '</dd></div>' : ''; }).join('');
      return linhas ? '<section class="nc-dv-parte"><h3>' + svg(pt.icone) + esc(pt.titulo) + '</h3><dl>' + linhas + '</dl></section>' : '';
    }).join('') + '</div>');
    var todos = el('button', 'nc-dv-todos', svg('lista') + '<span>' + esc(T.todos) + '</span>'); todos.type = 'button';
    ficha.appendChild(todos);
    regDep.parentNode.insertBefore(ficha, regDep);
    /* os botões ORIGINAIS: "Alterar Dados" (vira "Pedir alteração") e "Voltar" */
    var lugar = ficha.querySelector('.nc-dv-botoes');
    [].forEach.call(regDep.querySelectorAll('.t-Region-headerItems--buttons .t-Button, .t-Region-buttons .t-Button'), function (b) {
      if (b.closest('.js-maximizeButtonContainer')) return;
      var t = limpo(b.textContent);
      if (/alterar/i.test(t)) { b.classList.add('nc-dv-pedir'); var lb = b.querySelector('.t-Button-label'); if (lb) lb.textContent = T.pedir; [].forEach.call(b.querySelectorAll('.t-Icon'), function (i) { i.remove(); }); b.insertAdjacentHTML('afterbegin', svg('lapis')); lugar.appendChild(b); }
      else if (/voltar/i.test(t)) { b.classList.add('nc-dv-voltar'); b.classList.remove('t-Button--hot'); lugar.insertBefore(b, lugar.firstChild); }
    });
    todos.addEventListener('click', function () {
      var on = document.body.classList.toggle('nc-dv-todos-on');
      todos.querySelector('span').textContent = on ? T.ficha : T.todos;
    });
  }

  /* ═══ [J27] O MAESTRO (BLOCO D) ══════════════════════════════════════════════════════════ */
  var foi = false;
  function iniciar() { if (foi) return; foi = true; try { montar(); } catch (e) { if (window.console) console.warn('[Natcorp dependentes · ficha]', e); } }
  $(window).one('apexreadyend', function () { setTimeout(iniciar, 0); });
  $(function () { setTimeout(iniciar, 1500); });
  if (document.readyState === 'complete') setTimeout(iniciar, 200);
})();
