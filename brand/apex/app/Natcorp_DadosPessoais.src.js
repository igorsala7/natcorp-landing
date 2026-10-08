/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · DADOS PESSOAIS  —  o "arrumador" da tela (JavaScript)                          ║
   ║  App 600 · Página 1 · portal Conhecendo Você: o cadastro que o próprio colaborador ou     ║
   ║  candidato preenche (e que o RH também abre, pela ficha do app 200)                       ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── QUEM USA ──────────────────────────────────────────────────────────────────────────────
   Quase todos pelo celular, muitos com pouca leitura. A página tem 17 blocos e mais de 130
   campos numa rolagem só — o que assusta. Por isso ela é dividida em capítulos.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
     1. O ALTO: "Olá, Tony", quanto do cadastro está pronto (o P0_PERCENTUAL da página) e a
        frase que tranquiliza: o que se preenche é salvo na hora, não tem botão de salvar.
     2. SETE CAPÍTULOS no lugar dos 17 blocos soltos — Sobre você, Onde você mora, Telefone e
        e-mail, Sua família, Seus documentos, Medidas e saúde, Conta para o salário —
        abertos um de cada vez. Cada capítulo diz quantos campos já têm resposta; no fim de
        cada um, "Continuar" abre o próximo; no último, o botão leva à etapa seguinte do
        portal. "Ver tudo aberto" mostra a página como era.
     3. DOCUMENTOS: cada um diz se já está preenchido; os que nem todo mundo tem (CNH,
        passaporte, conselho…) dizem "só se você tiver". O clipe "Anexos" vira "Enviar foto".
     4. RÓTULOS em palavras de todo dia ("Nome da mãe", "Celular", "Tipo de sangue").
     5. "Salvando…" / "Salvo" no pé da tela a cada campo que a página grava sozinha.
     6. TELA LARGA (a partir de 1180 px): o cartão "Cadastro" vai para a coluna da foto, com o
        SUMÁRIO dos capítulos (tocar abre); o conteúdo usa a largura toda e os campos ficam em
        até 4 por linha — muito menos rolagem. No celular, tudo como antes.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda valor nenhum, não dispara "change" e não grava nada. O APEX continua dono de
       tudo: os campos, as ações dinâmicas e a GRAVAÇÃO AUTOMÁTICA a cada campo mudado.
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 1 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_DadosPessoais.js
     Página 1 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_DadosPessoais.css
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_DadosPessoais.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Esta página NÃO usa classes postas no APEX. O arquivo se reconhece sozinho pelos itens
   …_NOME_MAE, …_NUM_CPF_DISPLAY e …_TIPO_MIDIA ("Como conheceu"); sem eles, não faz nada.
     • Cada capítulo junta os BLOCOS (regiões) onde estão os itens da lista CAPS ([J1]).
       O bloco é achado pelo item, nunca pelo id da região.
     • Usa o item P0_PERCENTUAL (página 0) para o "% completo".
     • No fluxo de alteração (RH), usa os botões com Static ID REQ_ALT_CAD, SAVE_REQ,
       CANC_ALT_CAD e DEL_ALT_CAD (veja [J4]).

   ── CUIDADO: O "LIBERA CAMPOS" ────────────────────────────────────────────────────────────
   (lido nas ações da página) O "Libera Campos" DESABILITA todo input/select/BUTTON dentro de
   #CAMPOS_REGION, #ENDERECO, #CONTATO, #INF_ADICIONAIS e #DOCUMENTOS. Por isso:
     • nada sai de dentro dessas regiões: os capítulos são montados no lugar, só com classes;
     • os controles deste arquivo NÃO são <button> (seriam desabilitados junto) — são
       blocos comuns que se comportam como botão (veja comoBotao em [J2]).

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Configuração ........................ capítulos, blocos e rótulos          PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  Contar as respostas ................. quantos campos de cada bloco têm valor
     [J4]  Montar (uma vez) .................... capítulos, o alto, os botões do RH   PODE MEXER
     [J5]  Abrir e seguir ...................... abrir um capítulo, ir para o próximo
     [J6]  Atualizar (sempre) .................. estados, contadores, frases do alto  PODE MEXER
     [J7]  "Salvando…" / "Salvo" ............... o aviso no pé da tela               PODE MEXER
     [J8]  O maestro ........................... decide QUANDO cada parte roda        CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Ver tudo aberto'  →  'Mostrar tudo'
     Quero mudar o nome ou a frase de um capítulo                → [J1], lista CAPS.
     Quero mudar o rótulo de um campo (ou devolver o do APEX)    → [J1], lista ROTULOS.
     Criei um bloco (região) novo e ele não entrou em capítulo nenhum
       → [J1], lista CAPS: acrescente um item desse bloco na lista "itens" do capítulo certo.
         Um bloco que não entra em nenhum capítulo continua aparecendo como era.
     Quero mudar a dica de um documento ("Só se você tiver…")   → [J1], lista BLOCOS.
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp dados pessoais].
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
     P + 'NOME_MAE'         junta os textos: vira 'P1_NOME_MAE', o nome do item no APEX.
     valor(…)               lê o que está num item do APEX (veja [J2]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: estas linhas impedem que o arquivo rode duas vezes ou fora do APEX, e o fazem
     desistir em silêncio se a página não tiver …_NOME_MAE, …_NUM_CPF_DISPLAY e …_TIPO_MIDIA.
     Não apague. */
  if (window.__ncDadosPessoais || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_NOME_MAE_CONTAINER"]');
  if (!achado || !document.querySelector('[id$="_NUM_CPF_DISPLAY_CONTAINER"]') || !document.querySelector('[id$="_TIPO_MIDIA_CONTAINER"]')) return;
  window.__ncDadosPessoais = true;

  var $ = apex.jQuery;
  /* O começo do nome dos itens ('P1_'), descoberto sozinho a partir do item NOME_MAE.
     Se a página for copiada para outro número, NADA muda aqui. */
  var P = achado.id.replace(/NOME_MAE_CONTAINER$/, '');

  /* ═══ [J1] CONFIGURAÇÃO ═══════════════════════════════════════════════════════════════════
     O QUE É    As listas que dizem COMO a página é dividida e o que ela escreve. É a parte
                mais fácil de mexer.
       CAPS     os 7 capítulos. Cada linha tem:
                  id     → nome interno (NÃO mude: o visual e a memória do navegador usam)
                  titulo → o título do capítulo     dica → a frase embaixo do título
                  icone  → um dos nomes da lista IC
                  itens  → UM item (sem o P1_) de cada bloco que entra no capítulo. O
                           arquivo acha o bloco (região) onde o item mora e o põe aqui.
       BLOCOS   título novo e dica de cada bloco, pelo mesmo item usado em CAPS.
       ROTULOS  rótulos novos para os campos:  ITEM_SEM_P1: 'Rótulo que aparece'
     PODE MEXER as três listas. Para acrescentar, copie uma linha inteira e troque os textos.
     CUIDADO    Cada linha termina em vírgula, menos a última da lista. A ORDEM dos capítulos
                na tela é a ordem dos blocos na página, não a ordem desta lista.
     VISUAL     Natcorp_DadosPessoais.css › [C3] (capítulos) e [C4] (blocos e documentos)
     ════════════════════════════════════════════════════════════════════════════════════════ */

  /* PODE MEXER: os capítulos, na ordem da página. "itens": um item de cada bloco que entra no capítulo
     (o bloco é achado pelo item, nunca pelo id da região) */
  var CAPS = [
    { id: 'voce', titulo: 'Sobre você', dica: 'Seu nome, nascimento e onde você nasceu.', icone: 'pessoa', itens: ['NOME', 'NACIONALIDADE'] },
    { id: 'casa', titulo: 'Onde você mora', dica: 'Seu endereço, com o CEP.', icone: 'casa', itens: ['CEP_DISPLAY'] },
    { id: 'contato', titulo: 'Telefone e e-mail', dica: 'Para a empresa conseguir falar com você.', icone: 'telefone', itens: ['E_MAIL'] },
    { id: 'familia', titulo: 'Sua família', dica: 'Mãe, pai, marido ou esposa e mais algumas perguntas.', icone: 'familia', itens: ['NOME_MAE'] },
    { id: 'docs', titulo: 'Seus documentos', dica: 'O número de cada documento e a foto dele.', icone: 'documento', itens: ['NUM_CPF_DISPLAY', 'TIPO_IDENT', 'PRIMEIRO_EMPREGO', 'CNH', 'NUM_CART_PROF', 'NUM_TIT_ELEITOR', 'SIGLA_CONS_REG', 'CERTIF_RESERV', 'ANO_INSS', 'NUM_PASSAPORTE', 'NR_RIC'] },
    { id: 'corpo', titulo: 'Medidas e saúde', dica: 'Tamanho do uniforme, cor e tipo de sangue.', icone: 'camisa', itens: ['ALTURA'] },
    { id: 'banco', titulo: 'Conta para o salário', dica: 'Banco, agência e número da conta.', icone: 'banco', itens: ['BANCO'] }
  ];
  /* PODE MEXER: os blocos com nome de repartição ganham nome de gente; e os que nem todo mundo tem dizem */
  var BLOCOS = {
    NOME: { titulo: 'Seus dados' },
    NACIONALIDADE: { titulo: 'Onde você nasceu' },
    CEP_DISPLAY: { titulo: 'Endereço', dica: 'Em "Enviar foto", mande a foto de uma conta de luz, água ou telefone.' },
    NOME_MAE: { titulo: 'Família e outras informações' },
    TIPO_IDENT: { titulo: 'Identidade (RG)' },
    PRIMEIRO_EMPREGO: { titulo: 'PIS', dica: 'O número do PIS está na carteira de trabalho.' },
    CNH: { titulo: 'Carteira de motorista (CNH)', dica: 'Só se você tiver carteira de motorista.' },
    NUM_CART_PROF: { titulo: 'Carteira de trabalho' },
    NUM_TIT_ELEITOR: { titulo: 'Título de eleitor' },
    SIGLA_CONS_REG: { titulo: 'Conselho profissional', dica: 'Só para profissão com registro em conselho (enfermagem, medicina, engenharia…).' },
    CERTIF_RESERV: { titulo: 'Reservista (serviço militar)', dica: 'Para homens: o certificado do serviço militar.' },
    ANO_INSS: { titulo: 'Tempo de INSS', dica: 'Quanto tempo você já contribuiu com o INSS, se souber.' },
    NUM_PASSAPORTE: { titulo: 'Passaporte', dica: 'Só se você tiver passaporte.' },
    NR_RIC: { titulo: 'Documento de outro país (DNI)', dica: 'Só para quem nasceu fora do Brasil.' },
    ALTURA: { titulo: 'Medidas e saúde' },
    BANCO: { titulo: 'Conta para o salário', dica: 'A conta precisa estar no seu nome.' }
  };
  /* PODE MEXER: rótulos novos — ITEM (sem o P1_): 'como o rótulo deve aparecer'.
     Para devolver o rótulo do APEX, apague a linha daquele item. */
  var ROTULOS = {
    NOME: 'Nome completo', NOME_SOCIAL: 'Nome social (como prefere ser chamado)', INSTRUCAO: 'Escolaridade',
    DT_NAC: 'Data de nascimento', POSSUI_SOCIO: 'É sócio de alguma empresa?',
    PAIS_NACIONALIDADE: 'País da nacionalidade', PAIS_NASCIMENTO: 'País onde nasceu', UF_NACTO: 'Estado onde nasceu',
    NATURALIDADE_0: 'Cidade onde nasceu', NATURALIDADE_1: 'Cidade onde nasceu', ANO_CHEGADA: 'Ano em que chegou ao Brasil',
    CLASS_TRAB_ESTRANG: 'Situação do estrangeiro', TMPRESID: 'Tempo de residência',
    PAIS_RESIDENCIA: 'País onde mora', UF: 'Estado', TIPO_LOGRADOURO: 'Tipo (rua, avenida…)', ENDERECO: 'Nome da rua',
    END_REFERENCIA: 'Ponto de referência',
    E_MAIL: 'E-mail pessoal', E_MAIL_FUNCIONAL: 'E-mail do trabalho', TELEFONE_CELULAR_DISPLAY: 'Celular',
    TELEFONE_DISPLAY: 'Outro telefone', TELEFONE_COMERC_DISPLAY: 'Telefone do trabalho',
    TELEFONE_RECADOS_DISPLAY: 'Telefone para recado', NOME_CONTATO: 'Nome de quem atende o recado',
    NOME_MAE: 'Nome da mãe', NUM_CPF_MAE_DISPLAY: 'CPF da mãe', NOME_PAI: 'Nome do pai', NUM_CPF_PAI_DISPLAY: 'CPF do pai',
    NOME_CONJUGE: 'Nome do marido ou esposa', NUM_CPF_CONJUGE_DISPLAY: 'CPF do marido ou esposa',
    POSSUI_DEPENDENTE: 'Tem dependentes?', IND_DEF_FIS: 'Tem alguma deficiência (PCD)?', RAIS_IND_DEF_MULTIPLA: 'Múltipla',
    IND_DEF_FIS_BR: 'Reabilitado pelo INSS', TIPO_MIDIA: 'Como conheceu a empresa?',
    NUM_CPF_DISPLAY: 'Número do CPF', TIPO_IDENT: 'Tipo de documento', NUM_IDENTIDADE: 'Número do RG',
    EMISSAO: 'Data de emissão', EST_EMIS_IDENT: 'Estado que emitiu', ORG_EMIS_IDENT: 'Órgão que emitiu (ex.: SSP)',
    PRIMEIRO_EMPREGO: 'É o seu primeiro emprego?', NUM_PIS_PASEP: 'Número do PIS', DT_OPCAO_PIS: 'Data de cadastro do PIS',
    CNH: 'Número da CNH', N_REGISTRO_CNH: 'Nº de registro', DT_1_HABILIT_CNH: 'Data da 1ª habilitação',
    DT_EMISSAO_CNH: 'Data de emissão', DT_VALID_CNH: 'Validade', UF_CNH: 'Estado',
    EST_EMIS_PROF: 'Estado que emitiu', VALID_CART_TRAB: 'Validade (só estrangeiro)',
    IND_EXIMIDO_TIT: 'Dispensado do título?', NUM_TIT_ELEITOR: 'Número do título', CIDADE_EMIS_TITULO: 'Cidade',
    IND_EXIMIDO_RES: 'Dispensado da reservista?', CERTIF_RESERV: 'Número do certificado',
    COD_RACA_COR: 'Cor ou raça', TIPO_SANGUINEO: 'Tipo de sangue', FATOR_RH: 'Fator RH (+ ou −)',
    NUM_CAMISA: 'Tamanho da camisa', NUM_CALCA: 'Tamanho da calça', NUM_CALCADO: 'Número do calçado',
    ALTURA: 'Altura (ex.: 1,70)', PESO: 'Peso (kg)',
    NUM_CONTA: 'Número da conta', DC_CONTA: 'Dígito', COD_TP_TRANS_BCA: 'Tipo de conta'
  };
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    familia: '<circle cx="8.5" cy="7.5" r="3"/><circle cx="16.5" cy="9" r="2.4"/><path d="M3 19.5a5.5 5.5 0 0 1 11 0M13.5 19.5a4 4 0 0 1 7.5-1.9"/>',
    casa: '<path d="M3.5 11L12 4l8.5 7"/><path d="M6 9.5V20h12V9.5"/><path d="M10 20v-5h4v5"/>',
    telefone: '<rect x="6.5" y="2.5" width="11" height="19" rx="2.5"/><path d="M10.5 18.5h3"/>',
    documento: '<rect x="3" y="5" width="18" height="14" rx="2"/><circle cx="8.5" cy="11" r="2"/><path d="M5.5 16c.6-1.5 1.7-2.3 3-2.3s2.4.8 3 2.3M14 10h4.5M14 13.5h3"/>',
    camisa: '<path d="M8 3.5L3.5 7l2.5 3.5L8 9.5V20.5h8V9.5l2 1 2.5-3.5L16 3.5c-.8 1.3-2.2 2-4 2s-3.2-.7-4-2z"/>',
    banco: '<path d="M3 9.5L12 4l9 5.5z"/><path d="M5.5 10.5v7M10 10.5v7M14 10.5v7M18.5 10.5v7M3 20.5h18"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    seta: '<path d="M6 9l6 6 6-6"/>',
    ir: '<path d="M5 12h13M13 6l6 6-6 6"/>',
    nuvem: '<path d="M7 18.5h10.5a4 4 0 0 0 .6-7.95A6 6 0 0 0 6.6 9.1 4.7 4.7 0 0 0 7 18.5z"/><path d="M9.5 13.5l2 2 3.5-3.8"/>',
    alerta: '<path d="M12 3.5l9.5 16.5h-19z"/><path d="M12 10v4.5M12 17.2v.1"/>',
    olho: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="3"/>'
  };

  /* ═══ [J2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS:
       valor(P + 'ITEM')   o que o APEX guarda no item
       cont('ITEM')        o bloco inteiro do campo na tela (rótulo + campo)
       bloco(campo)        a região-cartão onde o campo mora (sobe pelas regiões "sem UI",
                           que são só contêineres)
       renomear(item, t)   troca o rótulo do item na tela
       guardar / lembrar   anotam no navegador (só nesta aba) qual capítulo estava aberto,
                           para a página voltar igual depois de recarregar
       comoBotao(e, fn)    faz um bloco comum se comportar como botão (clique, Enter, espaço)
                           — ver o CUIDADO do "Libera Campos" no alto
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-dp-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function cont(n) { return document.getElementById(P + n + '_CONTAINER'); }
  function valor(id) { var it = apex.item(id); return it && it.node ? String(it.getValue() || '').trim() : ''; }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function attr(e, a, v) { if (e && e.getAttribute(a) !== v) e.setAttribute(a, v); }
  function bonito(t) {
    t = String(t || '').trim();
    if (t === t.toUpperCase()) t = t.toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); });
    return t.replace(/(\s)(De|Da|Do|Das|Dos|E)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); });
  }
  function guardar(k, v) { try { sessionStorage.setItem('nc-dp-' + k, v); } catch (e) {} }
  function lembrar(k) { try { return sessionStorage.getItem('nc-dp-' + k); } catch (e) { return null; } }
  /* o bloco de cima de um item: sobe pelas regiões até a que tem cara de cartão (as "sem UI"
     são só contêineres, como DOCUMENTOS) */
  function bloco(c) {
    var r = c && c.closest('.t-Region');
    while (r && r.parentElement) {
      var pai = r.parentElement.closest('.t-Region');
      if (!pai || pai.classList.contains('t-Region--noUI')) break;
      r = pai;
    }
    return r;
  }
  function escondido(e, ate) { for (; e && e !== ate && e !== document.body; e = e.parentElement) if (e.style && e.style.display === 'none') return true; return false; }
  function renomear(n, t) {
    var l = document.getElementById(P + n + '_LABEL');
    if (!l || l.getAttribute('data-nc-dp')) return;
    for (var i = 0; i < l.childNodes.length; i++) {
      var x = l.childNodes[i];
      if (x.nodeType === 3 && x.textContent.trim()) { x.textContent = t + ' '; l.setAttribute('data-nc-dp', '1'); return; }
    }
  }
  /* um "botão" que a página não desabilita (ver o CUIDADO no alto) */
  function comoBotao(e, fn) {
    e.setAttribute('role', 'button');
    e.tabIndex = 0;
    e.addEventListener('click', fn);
    e.addEventListener('keydown', function (ev) { if (ev.key === 'Enter' || ev.key === ' ') { ev.preventDefault(); fn(ev); } });
  }

  /* ═══ [J3] CONTAR AS RESPOSTAS ═══════════════════════════════════════════════════════════
     O QUE FAZ  Conta, num bloco, quantos campos existem, quantos têm valor e quantos
                OBRIGATÓRIOS ainda estão vazios. Campos só de exibição e escondidos não contam.
     COMO SABE O QUE É OBRIGATÓRIO  Pelo "Value Required" do APEX (is-required) ou pela borda
                roxa de 2px que a própria página põe nos obrigatórios (P1_ITENS_OBRIGATORIO).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function campos(r) {
    return [].filter.call(r.querySelectorAll('.t-Form-fieldContainer'), function (c) {
      if (/display-only|display-image/.test(c.className) || escondido(c, r)) return false;
      return !!c.querySelector('input:not([type=hidden]), select, textarea, fieldset, .apex-item-group--popup-lov');
    });
  }
  function respondido(c) { return !!valor(c.id.replace(/_CONTAINER$/, '')); }
  /* obrigatório: a página marca com borda roxa de 2px (P1_ITENS_OBRIGATORIO) */
  function obrigatorio(c) {
    if (c.classList.contains('is-required')) return true;
    var i = c.querySelector('input:not([type=hidden]), select, textarea');
    return !!(i && /border-width:\s*2px/.test(i.getAttribute('style') || '') && /(81,\s*28,\s*118|#511c76)/i.test(i.getAttribute('style') || ''));
  }
  function contar(regs) {
    var t = 0, f = 0, falta = 0;
    regs.forEach(function (r) {
      if (r.style.display === 'none') return;
      campos(r).forEach(function (c) { t++; if (respondido(c)) f++; else if (obrigatorio(c)) falta++; });
    });
    return { t: t, f: f, falta: falta };
  }

  /* ═══ [J4] MONTAR (roda uma vez, quando a página abre) ═══════════════════════════════════
     O QUE FAZ  • troca os rótulos (ROTULOS);
                • para cada capítulo de CAPS, acha os blocos, troca o título/dica de cada um
                  (BLOCOS), e cria o cabeçalho do capítulo (número, título, dica, "3 de 8",
                  seta) e o "Continuar" do fim;
                • cria o alto (montarResumo) e a caixinha do "Salvando…" (montarAviso);
                • no fluxo do RH, sobe os botões REQ_ALT_CAD, SAVE_REQ, CANC_ALT_CAD e
                  DEL_ALT_CAD para o alto (montarAcoes).
     CUIDADO    Os blocos NÃO saem do lugar (ver o "Libera Campos" no alto): o capítulo só
                os marca com classes, e o CSS esconde os fechados.
     PODE MEXER o texto 'Enviar foto: ' (o nome do clipe para o leitor de tela).
     VISUAL     Natcorp_DadosPessoais.css › [C2] (alto), [C3] (capítulos), [C4] (blocos)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var LISTA = [], ABERTO = null, TUDO = false, RESUMO = null, AVISO = null;
  function montar() {
    Object.keys(ROTULOS).forEach(function (n) { renomear(n, ROTULOS[n]); });
    var usados = [];
    CAPS.forEach(function (cap) {
      var regs = [];
      cap.itens.forEach(function (n) {
        var c = cont(n), r = bloco(c);
        if (!r || regs.indexOf(r) >= 0 || usados.indexOf(r) >= 0) return;
        regs.push(r); usados.push(r);
        prepararBloco(r, BLOCOS[n] || {}, cap.id === 'docs');
      });
      if (!regs.length) return;
      regs.sort(function (a, b) { return a.compareDocumentPosition(b) & Node.DOCUMENT_POSITION_FOLLOWING ? -1 : 1; });
      regs.forEach(function (r) { r.classList.add('nc-dp-r'); r.setAttribute('data-nc-cap', cap.id); });

      var cab = el('div', 'nc-dp-cap');
      cab.id = 'nc-dp-cap-' + cap.id;
      cab.innerHTML = '<span class="nc-dp-num" aria-hidden="true"></span>' +
        '<span class="nc-dp-cap-txt"><span class="nc-dp-cap-tit">' + esc(cap.titulo) + '</span><span class="nc-dp-cap-dica">' + esc(cap.dica) + '</span></span>' +
        '<span class="nc-dp-cap-est"></span><span class="nc-dp-cap-seta">' + svg(IC.seta) + '</span>' +
        '<span class="nc-dp-cap-barra" aria-hidden="true"><i></i></span>';
      regs[0].parentNode.insertBefore(cab, regs[0]);
      var fim = el('div', 'nc-dp-fim');
      var ult = regs[regs.length - 1];
      ult.parentNode.insertBefore(fim, ult.nextSibling);
      var item = { cap: cap, regs: regs, cab: cab, fim: fim };
      comoBotao(cab, function () { abrir(ABERTO === item && !TUDO ? null : item, true); });
      comoBotao(fim, function () { seguir(item); });
      LISTA.push(item);
    });
    if (!LISTA.length) return;
    /* a numeração segue a ordem da tela, não a da lista acima */
    LISTA.sort(function (a, b) { return a.cab.compareDocumentPosition(b.cab) & Node.DOCUMENT_POSITION_FOLLOWING ? -1 : 1; });
    montarResumo();
    montarIndice();
    montarAviso();
    marcarColunas();
  }
  function prepararBloco(r, b, doc) {
    var h = r.querySelector(':scope > .t-Region-header');
    var t = h && h.querySelector('.t-Region-title');
    if (t && b.titulo && !t.getAttribute('data-nc-dp')) { t.textContent = b.titulo; t.setAttribute('data-nc-dp', '1'); }
    if (h && (b.dica || doc) && !h.querySelector('.nc-dp-bloco-extra')) {
      var x = el('div', 'nc-dp-bloco-extra');
      x.innerHTML = (doc ? '<span class="nc-dp-doc-est"></span>' : '') + (b.dica ? '<span class="nc-dp-bloco-dica">' + esc(b.dica) + '</span>' : '');
      var tt = h.querySelector('.t-Region-headerItems--title');
      (tt || h).appendChild(x);
      if (doc) r.classList.add('nc-dp-doc');
    }
    /* o clipe: "Enviar foto" (o CSS troca a palavra; aqui só o nome para o leitor de tela) */
    [].forEach.call(r.querySelectorAll(':scope > .t-Region-header .t-Button'), function (bt) {
      if (bt.querySelector('.fa-paperclip')) { bt.classList.add('nc-dp-anexo'); attr(bt, 'aria-label', 'Enviar foto: ' + (t ? t.textContent : '')); }
    });
  }
  function montarResumo() {
    RESUMO = el('div', 'nc-dp-resumo');
    RESUMO.innerHTML = '<div class="nc-dp-resumo-txt"><h2 class="nc-dp-ola"></h2><p class="nc-dp-pronto"></p>' +
      '<div class="nc-dp-medidor" aria-hidden="true"><i></i></div><p class="nc-dp-salva"></p><div class="nc-dp-acoes"></div></div>' +
      '<div class="nc-dp-ver" data-ver="1">' + svg(IC.olho) + '<span></span></div>';
    LISTA[0].cab.parentNode.insertBefore(RESUMO, LISTA[0].cab);
    comoBotao(RESUMO.querySelector('.nc-dp-ver'), function () { TUDO = !TUDO; guardar('tudo', TUDO ? '1' : ''); agendar(); });
  }
  /* O SUMÁRIO DOS CAPÍTULOS (tela larga): fica DENTRO do cartão "Cadastro", na coluna da foto.
     Uma linha por capítulo com o número (ou o visto), o nome e quanto falta; tocar abre o
     capítulo e rola até ele. Fora da coluna (celular), some: lá os capítulos já são a lista.
     A coluna da foto NÃO está entre as regiões do "Libera Campos": aqui pode ser <button>. */
  var INDICE = null;
  function montarIndice() {
    INDICE = el('nav', 'nc-dp-indice');
    INDICE.setAttribute('aria-label', 'Capítulos do cadastro');
    LISTA.forEach(function (it) {
      var b = el('button', 'nc-dp-ind');
      b.type = 'button';
      b.innerHTML = '<span class="nc-dp-ind-num" aria-hidden="true"></span><span class="nc-dp-ind-tit">' + esc(it.cap.titulo) + '</span><span class="nc-dp-ind-est"></span>';
      b.addEventListener('click', function () { abrir(it, true); });
      it.ind = b;
      INDICE.appendChild(b);
    });
    RESUMO.insertBefore(INDICE, RESUMO.querySelector('.nc-dp-ver'));
  }

  /* TELA LARGA: o conteúdo usa a largura toda. A coluna dos capítulos é a "principal"; as colunas
     vizinhas que não têm região à vista (espaçadores da grade, 2/12 de cada lado) somem. */
  /* 04/10: região ou botão que a PÁGINA escondeu (display:none inline) pode voltar por ação
     dinâmica — ex.: o "Alerta: Informações Obrigatórias" reaparece quando o "Refresh Documents"
     recalcula P1_ALERTA depois de enviar um documento. A linha/coluna dele não pode sumir pelo
     nosso CSS (que vence o "mostrar" da página); escondida, ela não ocupa altura mesmo. */
  function voltaPelaPagina(x) {
    return !!x.querySelector('.t-Region[style*="none"], .t-Alert[style*="none"], .t-HeroRegion[style*="none"], .t-Button[style*="none"]');
  }
  function marcarColunas() {
    /* linhas do conteúdo sem NADA à vista (região só com itens escondidos): viravam um vão */
    [].forEach.call(document.querySelectorAll('.t-Body-contentInner > .container > .row'), function (row) {
      if (row.querySelector('.nc-dp-cap, .nc-dp-resumo, .nc-dp-r')) return;
      var temAlgo = (row.innerText || '').trim() !== '' ||
        [].some.call(row.querySelectorAll('input:not([type=hidden]), select, textarea, img, .t-Button, iframe'), function (x) { return x.offsetWidth > 0 || x.offsetHeight > 0; });
      classe(row, 'nc-dp-linha-vazia', !temAlgo && !voltaPelaPagina(row));
    });
    LISTA.forEach(function (it) {
      [it.cab].concat(it.regs).forEach(function (x) {
        var col = x.closest('.col'); if (!col || !col.parentNode) return;
        col.classList.add('nc-dp-col-principal');
        [].forEach.call(col.parentNode.children, function (v) {
          if (v === col || v.classList.contains('nc-dp-col-principal')) return;
          var temRegiao = [].some.call(v.querySelectorAll('.t-Region, .t-HeroRegion, .t-Button'), function (r) { return r.offsetHeight > 0; });
          classe(v, 'nc-dp-col-lado-vazia', !temRegiao && !voltaPelaPagina(v));
        });
      });
    });
  }

  /* CAMPOS NA TELA LARGA (o CSS [C8] arruma em até 4 por linha): coluna da grade sem nada à
     vista (campo escondido pelas ações da página) some, para não deixar buraco; coluna com caixa
     de texto grande, várias caixinhas de marcar ou um bloco dentro ocupa a linha toda. */
  /* escondido pelo estilo CALCULADO (inline, classe ou tipo hidden) entre o elemento e a coluna —
     a própria coluna não conta: ela pode estar escondida por nós mesmos */
  function oculto(x, col) {
    for (var e = x; e && e !== col; e = e.parentElement) {
      var st = getComputedStyle(e);
      if (st.display === 'none' || st.visibility === 'hidden') return true;
    }
    return false;
  }
  function marcarCampos(regs) {
    regs.forEach(function (r) {
      [].forEach.call(r.querySelectorAll('.t-Region-body > .container > .row > .col'), function (col) {
        var vis = [].some.call(col.querySelectorAll('.t-Form-fieldContainer, .t-Region, .t-Button, img, table'), function (x) { return !oculto(x, col); });
        classe(col, 'nc-dp-col-vazia', !vis);
        var radios = col.querySelectorAll('input[type=radio]').length;
        /* texto que pode ser longo (rua, bairro, referência, nomes: 60+ caracteres) não fica com 1/4 da linha */
        classe(col, 'nc-dp-col-meia', [].some.call(col.querySelectorAll('input[type=text], input:not([type])'), function (i) { return i.maxLength >= 60; }));
        classe(col, 'nc-dp-col-larga', !!col.querySelector('textarea, .t-Region, input[type=checkbox] ~ input[type=checkbox], .checkbox_group, .apex-item-checkbox') || radios > 4);
      });
    });
  }

  /* o cartão "Cadastro" vai para a coluna da foto quando ela está à vista (tela larga) e volta
     para o alto dos capítulos no celular. A âncora marca o lugar original. */
  var ANCORA = null, LARGA = window.matchMedia ? window.matchMedia('(min-width: 1180px)') : null;
  function posicionarLado() {
    var lado = document.getElementById('t_Body_side');
    if (!RESUMO) return;
    if (!ANCORA) { ANCORA = document.createComment('nc-dp-resumo'); RESUMO.parentNode.insertBefore(ANCORA, RESUMO); }
    var noLado = !!(lado && LARGA && LARGA.matches && getComputedStyle(lado).display !== 'none' && lado.offsetWidth > 150);
    if (noLado && RESUMO.parentNode !== lado) lado.appendChild(RESUMO);
    if (!noLado && RESUMO.parentNode === lado) ANCORA.parentNode.insertBefore(RESUMO, ANCORA.nextSibling);
    classe(document.body, 'nc-dp-com-lado', noLado);
    marcarColunas();
  }

  /* O FLUXO DE ALTERAÇÃO (a página aberta pelo RH ou pelo "Dados do Colaborador" do app 200):
     os campos chegam travados, "Alterar Meus Dados" (REQ_ALT_CAD) os libera e a mudança vira uma
     SOLICITAÇÃO (SAVE_REQ pergunta "Deseja prosseguir com a criação da solicitação de
     alteração?"). Ali não se promete "salvo na hora": os botões do fluxo sobem para o alto, com
     a frase do que fazer. As ações da página continuam mostrando/escondendo cada um pelo id. */
  var BOTOES_ALT = ['REQ_ALT_CAD', 'SAVE_REQ', 'CANC_ALT_CAD', 'DEL_ALT_CAD'];
  var ALT = !!document.getElementById('REQ_ALT_CAD');
  function montarAcoes() {
    var box = RESUMO && RESUMO.querySelector('.nc-dp-acoes');
    if (!box || !ALT) return;
    BOTOES_ALT.forEach(function (id) {
      var b = document.getElementById(id);
      if (b && b.parentNode !== box) { b.classList.add('nc-dp-acao', 'nc-dp-acao--' + id.toLowerCase().replace(/_/g, '-')); box.appendChild(b); }
    });
  }
  function rotuloBotao(id) { var b = document.getElementById(id); return b ? (b.textContent || '').replace(/\s+/g, ' ').trim() : ''; }
  function botaoVisivel(id) { var b = document.getElementById(id); return !!(b && b.style.display !== 'none' && getComputedStyle(b).display !== 'none'); }
  function montarAviso() {
    AVISO = el('div', 'nc-dp-aviso');
    AVISO.setAttribute('role', 'status');
    AVISO.setAttribute('aria-live', 'polite');
    AVISO.hidden = true;
    document.body.appendChild(AVISO);
  }

  /* ═══ [J5] ABRIR E SEGUIR ═════════════════════════════════════════════════════════════════
     O QUE FAZ  abrir(capítulo)  abre um capítulo (fecha os outros) e rola até ele, sem parar
                                 embaixo da barra fixa do alto.
                seguir(capítulo) o "Continuar" do fim: abre o próximo capítulo; no último,
                                 vai para a próxima etapa do portal (a barra de etapas do alto);
                                 sem próxima etapa, fecha tudo.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function abrir(item, rolar) {
    TUDO = false; guardar('tudo', '');
    ABERTO = item;
    guardar('aberto', item ? item.cap.id : '-');
    atualizar();
    if (rolar && item) {
      var alvo = item.cab;
      setTimeout(function () {
        var topo = alvo.getBoundingClientRect().top + window.pageYOffset - alturaFixa() - 12;
        window.scrollTo({ top: Math.max(topo, 0), behavior: 'smooth' });
      }, 30);
    }
  }
  function seguir(item) {
    var i = LISTA.indexOf(item);
    if (i < LISTA.length - 1) { abrir(LISTA[i + 1], true); return; }
    /* 04/10: no último capítulo, quem segue é o "Prosseguir" ORIGINAL da página (SAVE/CREATE):
       é ele que submete, roda as validações e grava (Process Row of INF_PESSOAIS_CANDIDATO e
       "Cadastra Candidato" só rodam com SAVE/CREATE) e leva à próxima etapa (P_NEXT_PAGE). O link
       da barra de etapas pulava tudo isso. Sem Prosseguir à vista (fluxo do RH, consulta), segue
       como antes. */
    var gravar = prosseguir();
    if (gravar) { gravar.click(); return; }
    var prox = proximaEtapa();
    if (prox) { window.location.href = prox.href; return; }
    abrir(null, true);
  }
  /* o botão "Prosseguir" da página (SAVE ou CREATE: a página mostra um ou outro), se estiver à vista */
  function prosseguir() {
    return [].filter.call(document.querySelectorAll('.t-Button'), function (b) {
      return /^\s*prosseguir\s*$/i.test(b.textContent) && !b.disabled && !b.closest('.nc-dp-acoes') &&
        b.style.display !== 'none' && getComputedStyle(b).display !== 'none';
    })[0] || null;
  }
  function proximaEtapa() {
    var at = document.querySelector('.t-WizardSteps-step.is-active');
    var n = at && at.nextElementSibling;
    while (n && !n.matches('.t-WizardSteps-step')) n = n.nextElementSibling;
    var a = n && n.querySelector('a.t-WizardSteps-wrap[href]');
    return a ? { href: a.getAttribute('href'), nome: (n.querySelector('.t-WizardSteps-label').firstChild || {}).textContent } : null;
  }
  function alturaFixa() {
    var h = 0;
    [].forEach.call(document.querySelectorAll('.t-Header, .t-Body-title'), function (x) {
      var s = getComputedStyle(x);
      if (/fixed|sticky/.test(s.position)) h = Math.max(h, x.getBoundingClientRect().bottom);
    });
    return Math.min(h, window.innerHeight / 2);
  }

  /* ═══ [J6] ATUALIZAR (roda de novo a cada mudança) ═══════════════════════════════════════
     O QUE FAZ  • em cada capítulo: esconde se não tem campo à vista; mostra "Completo",
                  "Faltam 2" (obrigatórios) ou "3 de 8"; pinta a barrinha de progresso;
                  escreve o "Continuar: …" / "Pronto! Ir para …" / "Fechar" do fim;
                • em cada documento: "Preenchido", "1 de 3" ou "Vazio";
                • no alto: "Olá, Fulano!" (no portal) ou "Cadastro de Fulano" (aberta dentro de
                  outra tela, pelo RH), o "% completo" e a frase do que fazer.
     AS FRASES DO ALTO dependem da situação:
                  portal, campos livres ......... "O que você escreve é salvo na hora…"
                  fluxo do RH, campos travados .. "Os dados estão travados. Para mudar…"
                  fluxo do RH, campos liberados . "Mude o que precisar. No fim, toque em…"
                  tudo travado .................. "…só para consulta."
     PODE MEXER todas essas frases e 'Completo', 'Falta', 'Preenchido', 'Vazio', 'Continuar:',
                'Pronto! Ir para', 'Ver tudo aberto', 'Ver um capítulo por vez'.
     VISUAL     Natcorp_DadosPessoais.css › [C2] (alto) e [C3] (capítulos)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var HABILITADO = false;
  var EMBUTIDA = (function () { try { return window.self !== window.top; } catch (e) { return true; } })();
  /* 04/10: o Prosseguir recarrega a página com os erros das validações (86 delas, junto do campo).
     Campo com erro num capítulo FECHADO ficava invisível — a pessoa via o aviso e não achava o
     campo. Quando aparece erro novo, abre o capítulo do primeiro campo com erro (uma vez por
     conjunto de erros: depois a pessoa abre e fecha o que quiser). */
  var ERROS_VISTOS = '';
  function abrirErro() {
    var ids = [], alvo = null;
    LISTA.forEach(function (it) {
      it.regs.forEach(function (r) {
        [].forEach.call(r.querySelectorAll('.t-Form-fieldContainer.is-error, .apex-page-item-error, [aria-invalid="true"]'), function (e) {
          ids.push(e.id); if (!alvo) alvo = it;
        });
      });
    });
    var sig = ids.join(',');
    if (sig === ERROS_VISTOS) return;
    ERROS_VISTOS = sig;
    if (alvo && !TUDO && ABERTO !== alvo) { ABERTO = alvo; guardar('aberto', alvo.cap.id); }
  }
  function atualizar() {
    abrirErro();
    HABILITADO = LISTA.some(function (it) { return it.regs.some(function (r) { return !!r.querySelector('input:not([type=hidden]):not(:disabled), select:not(:disabled), textarea:not(:disabled)'); }); });
    LISTA.forEach(function (it, i) {
      var q = contar(it.regs);
      var vis = it.regs.some(function (r) { return r.style.display !== 'none'; }) && q.t > 0;
      it.cab.hidden = !vis;
      var aberto = TUDO || ABERTO === it;
      var completo = q.t > 0 && q.f === q.t;
      classe(it.cab, 'is-aberto', aberto && !TUDO);
      classe(it.cab, 'is-completo', completo);
      classe(it.cab, 'is-falta', q.falta > 0);
      attr(it.cab, 'aria-expanded', String(aberto));
      it.cab.style.setProperty('--nc-dp-p', q.t ? Math.round(q.f / q.t * 100) + '%' : '0%');
      html(it.cab.querySelector('.nc-dp-num'), completo ? svg(IC.ok) : '<b>' + (i + 1) + '</b>');
      html(it.cab.querySelector('.nc-dp-cap-est'), completo ? '<span class="nc-dp-est-ok">Completo</span>'
        : q.falta ? '<span class="nc-dp-est-falta">Falta' + (q.falta > 1 ? 'm ' + q.falta : ' 1') + '</span>'
        : '<span class="nc-dp-est-n"><b>' + q.f + '</b> de ' + q.t + '</span>');
      it.regs.forEach(function (r) { classe(r, 'nc-dp-fechado', !aberto); });
      if (aberto) marcarCampos(it.regs);
      if (it.ind) {
        it.ind.hidden = !vis;
        classe(it.ind, 'is-aberto', aberto && !TUDO);
        classe(it.ind, 'is-completo', completo);
        if (aberto && !TUDO) attr(it.ind, 'aria-current', 'step'); else if (it.ind.hasAttribute('aria-current')) it.ind.removeAttribute('aria-current');
        html(it.ind.querySelector('.nc-dp-ind-num'), completo ? svg(IC.ok) : String(i + 1));
        html(it.ind.querySelector('.nc-dp-ind-est'), completo ? '<span class="nc-dp-est-ok">Completo</span>'
          : q.falta ? '<span class="nc-dp-est-falta">Falta' + (q.falta > 1 ? 'm ' + q.falta : ' 1') + '</span>'
          : '<span class="nc-dp-est-n">' + q.f + ' de ' + q.t + '</span>');
      }
      it.fim.hidden = !aberto || TUDO;
      if (!it.fim.hidden) {
        var prox = LISTA.slice(i + 1).filter(function (x) { return !x.cab.hidden; })[0], et = !prox && proximaEtapa();
        /* 04/10: com o Prosseguir da página à vista, o último "Continuar" clica nele (ver seguir) */
        var gr = !prox && prosseguir();
        html(it.fim, prox ? '<span>Continuar: <b>' + esc(prox.cap.titulo) + '</b></span>' + svg(IC.ir)
          : (et || gr) ? '<span>Pronto! Ir para <b>' + esc(String((et && et.nome) || 'a próxima etapa').trim()) + '</b></span>' + svg(IC.ir)
          : '<span>Fechar</span>' + svg(IC.ok));
      }
      /* documentos: cada um diz se já tem resposta */
      it.regs.forEach(function (r) {
        var est = r.querySelector('.nc-dp-doc-est'); if (!est) return;
        var d = contar([r]);
        html(est, !d.t ? '' : d.f === d.t ? '<span class="nc-dp-doc-ok">' + svg(IC.ok) + 'Preenchido</span>'
          : d.f ? '<span class="nc-dp-doc-meio">' + d.f + ' de ' + d.t + '</span>' : '<span class="nc-dp-doc-vazio">Vazio</span>');
      });
    });
    if (RESUMO) {
      /* aberta dentro de outra tela (o RH, a ficha do app 200): "Cadastro de Fulano"; no portal, "Olá, Fulano!" */
      var inteiro = bonito(valor(P + 'NOME')), nome = bonito(valor(P + 'NOME_SOCIAL') || valor(P + 'NOME')).split(/\s+/)[0];
      html(RESUMO.querySelector('.nc-dp-ola'), EMBUTIDA ? (inteiro ? 'Cadastro de ' + esc(inteiro) : 'Cadastro') : nome ? 'Olá, ' + esc(nome) + '!' : 'Seu cadastro');
      var pc = parseFloat(String(valor('P0_PERCENTUAL')).replace(',', '.'));
      var temPc = !isNaN(pc);
      html(RESUMO.querySelector('.nc-dp-pronto'), temPc ? (EMBUTIDA ? 'O cadastro está <b>' : 'Seu cadastro está <b>') + Math.round(pc) + '% completo</b>.' : 'Preencha um capítulo de cada vez.');
      RESUMO.querySelector('.nc-dp-medidor').hidden = !temPc;
      RESUMO.style.setProperty('--nc-dp-pc', (temPc ? Math.max(0, Math.min(100, pc)) : 0) + '%');
      montarAcoes();
      var fraseAlt = !ALT ? '' : !HABILITADO && botaoVisivel('REQ_ALT_CAD')
        ? svg(IC.olho) + '<span>Os dados estão travados. Para mudar algum, toque em <b>' + esc(rotuloBotao('REQ_ALT_CAD') || 'Alterar') + '</b>.</span>'
        : HABILITADO && botaoVisivel('SAVE_REQ')
        ? svg(IC.nuvem) + '<span>Mude o que precisar. No fim, toque em <b>' + esc(rotuloBotao('SAVE_REQ') || 'Salvar') + '</b>: a mudança vai para o RH conferir.</span>'
        : '';
      /* 04/10 (cliente): sem a frase "o que você escreve é salvo na hora" — era nossa e não é
         verdade: a página só grava no Prosseguir (SAVE/CREATE). No preenchimento normal, nada. */
      var frase = fraseAlt || (HABILITADO && !ALT ? ''
        : HABILITADO ? svg(IC.nuvem) + '<span>Mude o que precisar.</span>'
        : svg(IC.olho) + '<span>' + (EMBUTIDA ? 'Os dados estão aqui só para consulta.' : 'Seus dados estão aqui só para consulta.') + '</span>');
      html(RESUMO.querySelector('.nc-dp-salva'), frase);
      RESUMO.querySelector('.nc-dp-salva').hidden = !frase;
      var box = RESUMO.querySelector('.nc-dp-acoes');
      box.hidden = !BOTOES_ALT.some(botaoVisivel);
      html(RESUMO.querySelector('.nc-dp-ver span'), TUDO ? 'Ver um capítulo por vez' : 'Ver tudo aberto');
      classe(document.body, 'nc-dp-tudo', TUDO);
    }
  }

  /* ═══ [J7] "SALVANDO…" / "SALVO" ══════════════════════════════════════════════════════════
     O QUE FAZ  A página grava sozinha cada campo mudado (é uma ação dinâmica dela). Aqui só se
                AVISA: ao mudar um campo aparece "Salvando…"; quando o servidor responde,
                "Salvo" (some em 1,8 s) ou "Não foi salvo…" (some em 6 s). No fluxo do RH a
                mudança vira solicitação, então não se anuncia "Salvo".
     IMPORTANTE Este aviso não grava nada: só observa a resposta do servidor.
     PODE MEXER os textos 'Salvando…', 'Salvo', 'Não foi salvo. Confira a internet…'.
     VISUAL     Natcorp_DadosPessoais.css › [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- "Salvando…" / "Salvo" (a página grava sozinha a cada campo mudado) ---------- */
  var ESPERA = 0, T_AVISO = null, MEXEU = false;
  ['pointerdown', 'keydown'].forEach(function (t) { document.addEventListener(t, function () { MEXEU = true; }, true); });
  function avisar(tipo) {
    if (!AVISO) return;
    clearTimeout(T_AVISO);
    html(AVISO, tipo === 'salvando' ? '<span class="nc-dp-gira" aria-hidden="true"></span>Salvando…'
      : tipo === 'salvo' ? svg(IC.ok) + 'Salvo'
      : svg(IC.alerta) + 'Não foi salvo. Confira a internet e tente de novo.');
    AVISO.className = 'nc-dp-aviso nc-dp-aviso--' + tipo;
    AVISO.hidden = false;
    if (tipo !== 'salvando') T_AVISO = setTimeout(function () { AVISO.hidden = true; }, tipo === 'salvo' ? 1800 : 6000);
  }
  function mudou(e) {
    /* 04/10 (cliente): o aviso "Salvando…/Salvo" sai — a página não grava a cada campo (o
       "Monitor Changes" só marca P1_CHANGES = 'Y'); o "Salvo" anunciava uma gravação que não há.
       Grava só o Prosseguir. A função fica (desligada) para não mexer na ordem do maestro. */
    return;
    var t = e.target;
    /* no fluxo de alteração a mudança vira solicitação: não se anuncia "Salvo" */
    if (ALT || !t || t.type === 'hidden' || t.disabled || t.getAttribute('monitor_changes') === 'N' || !t.closest('.nc-dp-r')) return;
    /* antes do primeiro toque/tecla da pessoa, nada é anunciado: ao abrir, as ações da página
       calculam a idade, a maioridade… (mudança por código) e o aviso dizia "Salvo" sem nada
       ter sido salvo. Depois do primeiro toque vale tudo (lista e calendário também mudam
       por código, e esses gravam de verdade) */
    if (!MEXEU) return;
    ESPERA = Date.now();
    avisar('salvando');
    setTimeout(function () { if (ESPERA && Date.now() - ESPERA >= 7900) { ESPERA = 0; AVISO.hidden = true; } }, 8000);
  }
  function respondeu(ev, xhr) {
    if (!ESPERA) return;
    ESPERA = 0;
    var j = xhr && xhr.responseJSON;
    avisar(xhr && (xhr.status >= 400 || (j && j.error)) ? 'erro' : 'salvo');
  }

  /* ═══ [J8] O MAESTRO: QUANDO CADA PARTE RODA ═════════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a página abre: monta ([J4]), põe a marca nc-dp na
                página (é ela que liga o CSS), escolhe qual capítulo abrir (o que estava aberto
                antes; na primeira vez, o primeiro que ainda tem campo sem resposta) e
                atualiza ([J6]). Depois atualiza de novo a cada campo mudado, a cada resposta
                do servidor e quando as ações da página mostram/escondem/habilitam campos.
     CUIDADO    Não mude a ordem das chamadas em iniciar().
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp dados pessoais] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var agendado = false, MO = null;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () {
      agendado = false;
      try { atualizar(); } catch (e) { if (window.console) console.warn('[Natcorp dados pessoais]', e); }
      if (MO) MO.takeRecords();
    });
  }
  function iniciar() {
    montar();
    if (!LISTA.length) return;
    document.body.classList.add('nc-dp');
    TUDO = lembrar('tudo') === '1';
    var guardado = lembrar('aberto');
    var ini = guardado === '-' ? null : LISTA.filter(function (it) { return it.cap.id === guardado; })[0];
    /* primeira vez: abre o primeiro capítulo que ainda tem campo sem resposta */
    if (guardado === null) ini = LISTA.filter(function (it) { var q = contar(it.regs); return q.t && q.f < q.t; })[0] || null;
    ABERTO = ini || null;
    atualizar();
    posicionarLado();
    if (LARGA) { if (LARGA.addEventListener) LARGA.addEventListener('change', posicionarLado); else if (LARGA.addListener) LARGA.addListener(posicionarLado); }
    $(document).on('change', '.nc-dp-r', function (e) { mudou(e); agendar(); });
    $(document).on('input', '.nc-dp-r input, .nc-dp-r textarea', agendar);
    $(document).ajaxComplete(function (ev, xhr) { respondeu(ev, xhr); setTimeout(agendar, 30); });
    $(document).ajaxError(function (ev, xhr) { if (ESPERA) { ESPERA = 0; avisar('erro'); } });
    if (window.MutationObserver) {
      /* as ações da página mostram, escondem e habilitam campos */
      MO = new MutationObserver(agendar);
      LISTA.forEach(function (it) { it.regs.forEach(function (r) { MO.observe(r, { attributes: true, subtree: true, attributeFilter: ['style', 'disabled'] }); }); });
      if (RESUMO) MO.observe(RESUMO.querySelector('.nc-dp-acoes'), { attributes: true, subtree: true, attributeFilter: ['style'] });
    }
    setTimeout(agendar, 900);
    setTimeout(marcarColunas, 1200);   /* depois das ações de carga da página, que escondem itens */
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
