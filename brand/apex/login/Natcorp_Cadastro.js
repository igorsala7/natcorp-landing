/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · ALTERAÇÃO CADASTRAL E DE ENDEREÇO  —  o "arrumador" da tela (JavaScript)    ║
   ║  App 200 · Páginas 136 (Alteração Cadastral) e 134 (Alteração de Endereço)             ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ──────────────────────────────────────────────────────────────────
   O DESENHO da tela em que o colaborador (ou o gestor, por ele) pede para atualizar dados
   pessoais: endereço, telefone, banco, documentos… A página 134 (Alteração de Endereço) é o
   mesmo pedido só com Endereço, Contato, Estado civil e Formação, e usa este MESMO arquivo.
   Público com pouca familiaridade com sistemas e pouca leitura, quase sempre no celular.
   A ideia:
     • primeiro a pergunta "O que você quer atualizar?", com cartões grandes (ícone + duas
       palavras);
     • só os blocos escolhidos aparecem, já com os dados de hoje preenchidos;
     • o que for mudado fica marcado e mostra "antes: …";
     • a lista dos documentos que o RH pede para o que mudou (comprovante de endereço etc.);
     • no fim, "Confira antes de enviar" (de → para) e a barra com o que falta e "Enviar pedido".

   ── O QUE ELE NÃO FAZ ───────────────────────────────────────────────────────────────────────
     • Não cria campos, não valida, não grava nada no banco: a ESTRUTURA é toda do APEX.
     • Quem exige o comprovante é o servidor (a validação do APEX). Aqui só se mostra a lista.
     • Se este arquivo for retirado da página, a tela volta às abas do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ──────────────────────────────────────────────────────────────────
     Página 136 (e 134) › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Cadastro.js
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Cadastro.css.
     Este é o arquivo-FONTE (.src.js). O arquivo que sobe (o .js de mesmo nome, em brand/apex/login)
     é gerado a partir dele pelo gerar-*.py da página: edite ESTE arquivo (manual, parte 2).

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ────────────────────────────────────
   Classes postas nas regiões (Page Designer › clique na região › Appearance › CSS Classes):
     nc-cad-colaborador  região "Colaborador" (empresa e matrícula) → "De quem são os dados"
     nc-cad-solicitacao  região "Requisição de Alteração Cadastral" (nº, data, solicitante) → vai
                         para o alto
     nc-cad-seletor      região "Seletor" (as abas Mostrar Tudo / Dados Pessoais / Documentos) →
                         sai da tela (os cartões substituem as abas)
     nc-cad-tema-XXX     cada bloco de dados, com o assunto dele (XXX = um id da lista TEMAS, [J1]):
                         endereco, contato, banco, pessoais, familia, estudo, documentos,
                         uniforme, deficiencia
     nc-cad-anexos       região "Documentos (Upload)" → "Comprovantes", perto do fim
     nc-cad-acoes        região dos botões (Voltar / Criar / Salvar) → barra fixa no rodapé
   Um bloco sem nc-cad-tema-* continua onde estava.
   Página SEM as classes (a 134 recebeu só as URLs de arquivo): o próprio arquivo põe as mesmas
   classes pelos TÍTULOS das regiões — o mesmo mapa do aplicar-cadastro-pagina136.py (lista
   CONTRATO, em [J4]). O prefixo dos itens (P134_ / P136_) vem da própria página.
   Os campos, botões e ações dinâmicas continuam os do APEX: aqui eles só MUDAM DE LUGAR.

   ── ÍNDICE: as partes deste arquivo ─────────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Os assuntos (os cartões) ............ títulos, frases e ícones dos cartões   PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  Lembrar a escolha e o "antes" ....... o que fica guardado no navegador       CUIDADO
     [J4]  O combinado pelos títulos ........... título da região → assunto            PODE MEXER
     [J5]  A montagem .......................... a pergunta, os cartões, a ordem        PODE MEXER
     [J6]  O alto: de quem são os dados ........ "Atualizar meus dados"                 PODE MEXER
     [J7]  Os cartões e os blocos .............. o que mudou, "antes: …"
     [J8]  Os comprovantes ..................... que documento cada mudança pede       PODE MEXER
     [J9]  Confira antes de enviar ............. a lista de → para
     [J10] A barra do rodapé ................... o que falta + "Enviar pedido"          PODE MEXER
     [J11] O maestro ........................... decide QUANDO cada parte é montada    CUIDADO

   ── RECEITAS RÁPIDAS ────────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'O que você quer atualizar?'  →  'O que vai mudar?'
     Criei um bloco de dados novo (uma região) e ele não aparece nos cartões
       → no Page Designer, dê à região a classe de um assunto que já existe, ex.: nc-cad-tema-contato.
         Sem a classe, o bloco fica onde estava (fora dos cartões).
     Quero um ASSUNTO novo (um cartão novo)
       → [J1]: copie uma linha de TEMAS e troque id, titulo, dica e icone; depois dê às regiões
         a classe nc-cad-tema-<id novo>.
     Uma mudança nova precisa pedir documento                → [J8], DOC_BLOCO ou DOC_CAMPO
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp cadastro].
         O manual, parte 5, explica o que fazer com a mensagem.

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
     P + 'MATRICULA'        junta os textos: vira 'P136_MATRICULA', o nome do item no APEX.
     texto(…) / valor(…)    leem o que está num item do APEX (veja [J2]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: esta linha impede que o arquivo rode duas vezes (se a URL estiver repetida na
     página, por exemplo) e que rode fora do APEX. Não apague. */
  if (window.__ncCadastro || !window.apex || !window.apex.jQuery) return;
  window.__ncCadastro = true;

  var $ = apex.jQuery;
  /* o prefixo vem da página (P136_ na Alteração Cadastral, P134_ na de Endereço): ele é
     DESCOBERTO pelo item DATA_SOLICITACAO. Se a página for copiada para outro número, nada muda
     aqui; sem esse item, vale 'P136_'. */
  var achado = document.querySelector('[id$="_DATA_SOLICITACAO_CONTAINER"], [id$="_DATA_SOLICITACAO"]');
  var P = achado ? achado.id.replace(/DATA_SOLICITACAO(_CONTAINER)?$/, '') : 'P136_';
  var ILU = {"ficha": "data:image/png;base64,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"};

  /* ═══ [J1] OS ASSUNTOS (OS CARTÕES) ════════════════════════════════════════════════════════
     O QUE É    TEMAS é a lista dos cartões de "O que você quer atualizar?", na ordem em que as pessoas
                mais pedem. Cada linha é um assunto:
                  id           o nome usado na classe da região: nc-cad-tema-<id>
                  titulo       o título grande do cartão ('Endereço')
                  dica         a frase curta embaixo ('Mudança de casa'). Num bloco de 1 ou 2 campos,
                               a frase vira os nomes dos próprios campos (ver dicaDe em [J5]).
                  icone        o desenho do cartão (um nome da lista IC, logo abaixo)
                  comprovante  o exemplo de documento (opcional)
                Só aparece o cartão de um assunto que tenha pelo menos uma região com a classe dele.
     PODE MEXER titulo, dica, comprovante e a ORDEM das linhas (é a ordem dos cartões na tela).
     CUIDADO    Não mude o id de um assunto sem mudar também a classe nc-cad-tema-<id> nas regiões
                do APEX e o mapa CONTRATO em [J4].
     VISUAL     Natcorp_Cadastro.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: os assuntos, na ordem em que as pessoas mais pedem; "dica" é a frase curta do
     cartão e "comprovante" o exemplo mostrado junto do anexo */
  var TEMAS = [
    { id: 'endereco', titulo: 'Endereço', dica: 'Mudança de casa', icone: 'casa', comprovante: 'conta de luz, água ou telefone' },
    { id: 'contato', titulo: 'Telefone e e-mail', dica: 'Número novo', icone: 'telefone' },
    { id: 'banco', titulo: 'Banco e PIX', dica: 'Conta do salário', icone: 'banco', comprovante: 'cartão ou extrato da conta' },
    { id: 'pessoais', titulo: 'Meus dados', dica: 'Nome, estado civil…', icone: 'pessoa', comprovante: 'certidão de casamento ou documento com o nome novo' },
    { id: 'familia', titulo: 'Família', dica: 'Mãe, pai, cônjuge', icone: 'familia' },
    { id: 'estudo', titulo: 'Estudo', dica: 'Curso concluído', icone: 'estudo', comprovante: 'diploma ou declaração da escola' },
    { id: 'documentos', titulo: 'Documentos', dica: 'RG, CPF, título…', icone: 'documento', comprovante: 'foto do documento' },
    { id: 'uniforme', titulo: 'Uniforme', dica: 'Tamanho de roupa', icone: 'camisa' },
    { id: 'deficiencia', titulo: 'Deficiência', dica: 'Informar ou atualizar', icone: 'acessivel', comprovante: 'laudo médico' }
  ];
  /* 04/10: a 136 do Portal (app 300) não tem o campo PIX — lá o cartão é só "Banco" */
  if (!document.getElementById(P + 'CHAVE_PIX')) TEMAS.forEach(function (t) { if (t.id === 'banco') t.titulo = 'Banco'; });
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    casa: '<path d="M3.5 11L12 4l8.5 7"/><path d="M5.5 9.5V20h13V9.5"/><path d="M10 20v-5.5h4V20"/>',
    telefone: '<rect x="6.5" y="2.5" width="11" height="19" rx="2.5"/><path d="M10.5 18.5h3"/>',
    banco: '<path d="M3 9.5L12 4l9 5.5"/><path d="M5 10v7M9.5 10v7M14.5 10v7M19 10v7M3 20h18"/>',
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    familia: '<circle cx="8" cy="7.5" r="3"/><circle cx="16.5" cy="9" r="2.5"/><path d="M2.5 19.5a5.5 5.5 0 0 1 11 0M13 19.5a4 4 0 0 1 8 0"/>',
    estudo: '<path d="M2.5 9l9.5-4.5L21.5 9 12 13.5z"/><path d="M6.5 11v5c1.5 1.5 3.5 2.3 5.5 2.3s4-.8 5.5-2.3v-5M21.5 9v5"/>',
    documento: '<rect x="3" y="5" width="18" height="14" rx="2"/><circle cx="8.5" cy="11" r="2"/><path d="M5.5 16c.6-1.5 1.7-2.3 3-2.3s2.4.8 3 2.3M14 10h4.5M14 13.5h3"/>',
    camisa: '<path d="M8 3.5L3.5 7l2.5 3.5L8 9.5V20.5h8V9.5l2 1 2.5-3.5L16 3.5c-.8 1.3-2.2 2-4 2s-3.2-.7-4-2z"/>',
    acessivel: '<circle cx="12" cy="4.5" r="1.8"/><path d="M12 7.5v6h4.5l2 5M12 10.5h4"/><path d="M8.5 11a5.5 5.5 0 1 0 7 7.2"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    clipe: '<path d="M16.5 7.5l-7 7a2 2 0 0 0 2.8 2.8l7.4-7.4a4 4 0 0 0-5.7-5.7L6.6 11.6a6 6 0 0 0 8.5 8.5l5.4-5.4"/>',
    seta: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>'
  };

  /* ═══ [J2] FERRAMENTAS ═════════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       texto(P + 'ITEM')   o que a PESSOA VÊ no item (o nome da opção escolhida numa lista)
       valor(P + 'ITEM')   o que o APEX GUARDA no item (o código da opção)
       porClasse('x')      as regiões que têm a classe x no APEX
       travado(id)         se o APEX travou o campo (só leitura / desabilitado)
       rotulo(c)           o nome do campo, como aparece na tela
     QUANDO MEXER  Quase nunca.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function vazio(t) { return !t || /^\s*(-\s*selecione\s*-|-\s*todos\s*-|-)\s*$/i.test(t); }
  function codigo(t) { var m = String(t || '').match(/^\s*([\w.]+)\s+-\s+/); return m ? m[1] : ''; }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim(); }
  function maiusculas(t) { return t.length > 3 && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t); }
  function capitalizar(t) { return String(t || '').toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); }); }
  function bonito(t) { t = String(t || ''); if (maiusculas(t)) t = capitalizar(t); return t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); }); }
  function valor(id) { var it = apex.item(id); return it && it.node ? String(it.getValue() || '') : ''; }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-cad-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function porClasse(cls) { return [].slice.call(document.querySelectorAll('.t-Region.' + cls + ', .t-ButtonRegion.' + cls)); }
  function escondido(e, ate) { for (; e && e !== ate && e !== document.body; e = e.parentElement) if (e.style && e.style.display === 'none' || e.hidden) return true; return false; }
  function texto(id) {
    var e = document.getElementById(id);
    if (!e) return '';
    if (e.tagName === 'SELECT') { var o = e.options[e.selectedIndex]; return o && o.value !== '' && !vazio(o.text) ? o.text.trim() : ''; }
    if (e.type === 'hidden') { var d = document.getElementById(id + '_DISPLAY'); return d ? d.textContent.trim() : ''; }
    var v = String(e.value || '').trim();
    return vazio(v) ? '' : v;
  }
  function travado(id) {
    var c = document.getElementById(id + '_CONTAINER'), e = document.getElementById(id);
    if (!e) return true;
    if (c && c.classList.contains('apex-item-wrapper--popup-lov')) return !!(e.disabled || e.classList.contains('apex_disabled'));
    return !!(e.disabled || e.classList.contains('apex_disabled') || e.readOnly && e.tagName !== 'SELECT');
  }
  function rotulo(c) { var l = c && c.querySelector('.t-Form-label'); if (!l) return ''; var k = l.cloneNode(true); [].forEach.call(k.querySelectorAll('.u-VisuallyHidden'), function (x) { x.remove(); }); return k.textContent.replace(/\s+/g, ' ').trim(); }
  function temaDe(reg) { var m = reg.className.match(/\bnc-cad-tema-([\w-]+)/); return m ? m[1] : ''; }

  /* ═══ [J3] LEMBRAR A ESCOLHA E O "ANTES" ═══════════════════════════════════════════════════
     O QUE FAZ  • ESCOLHIDOS = os cartões que a pessoa tocou. Num pedido já gravado, a escolha é
                  lembrada (no navegador, só nesta aba) para quando a pessoa voltar à página.
                • INICIAL = os valores de hoje de cada campo, guardados uma vez quando a página abre
                  (depois das ações dinâmicas da carga). É com eles que se sabe o que MUDOU.
                • O "antes" sobrevive ao envio: se o servidor recusar (ex.: falta comprovante), a
                  página volta com o que a pessoa DIGITOU, e ler o "antes" dali apagaria todas as
                  marcas. Por isso o retrato é guardado na hora de enviar e devolvido quando a página
                  volta para a mesma pessoa (até 30 minutos).
     CUIDADO    Tudo isto fica no sessionStorage (a memória da aba do navegador): nada vai para o
                banco. Mexer aqui pode fazer as marcas de "mudou" sumirem depois de um erro.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ESCOLHIDOS = {}, INICIAL = null, TODOS = false;
  /* a escolha é lembrada só para o mesmo pedido já gravado (volta à página); um pedido novo
     começa sempre sem escolha */
  var CHAVE = valor(P + 'COD_REQ') ? 'nc-cad-escolhidos-' + valor(P + 'COD_REQ') : '';
  try { if (CHAVE) { var guard = JSON.parse(sessionStorage.getItem(CHAVE) || '{}'); if (guard && typeof guard === 'object') ESCOLHIDOS = guard; } } catch (e) { /* sem armazenamento: começa sem escolha */ }
  function guardar() { if (!CHAVE) return; try { sessionStorage.setItem(CHAVE, JSON.stringify(ESCOLHIDOS)); } catch (e) { /* ok */ } }
  /* 04/10: a 134 é a ALTERAÇÃO DE ENDEREÇO — o bloco Endereço já começa aberto (é só o que aparece;
     nenhum dado muda). Os outros blocos continuam a um toque. */
  if (P === 'P134_' && !Object.keys(ESCOLHIDOS).length) ESCOLHIDOS.endereco = true;

  /* os campos de dados (todos os contêineres dos blocos com assunto) */
  function camposDe(reg) { return [].slice.call(reg.querySelectorAll('.t-Form-fieldContainer')).filter(function (c) { return c.closest('.t-Region') === reg; }); }
  function blocos() { return [].slice.call(document.querySelectorAll('.t-Region[class*="nc-cad-tema-"]')); }
  /* o valor de hoje é o que a página trouxe; guardado uma vez, depois das ações de carga */
  function guardarInicial() {
    INICIAL = {};
    blocos().forEach(function (reg) { camposDe(reg).forEach(function (c) { var id = c.id.replace(/_CONTAINER$/, ''); INICIAL[id] = { v: valor(id), t: texto(id) }; }); });
  }
  /* o "antes" sobrevive ao envio: se o servidor recusar (ex.: falta comprovante), a página volta
     com o que a pessoa DIGITOU nos campos, e ler o "antes" dali apagaria todas as marcas. Guarda
     o retrato na hora de enviar e devolve quando a página voltar para a mesma pessoa. */
  var RASCUNHO = 'nc-cad-rascunho';
  function pessoa() { return valor(P + 'COD_EMPRESA') + '|' + valor(P + 'MATRICULA'); }
  function guardarRascunho() {
    if (!INICIAL) return;
    try { sessionStorage.setItem(RASCUNHO, JSON.stringify({ p: pessoa(), i: INICIAL, e: ESCOLHIDOS, t: Date.now() })); } catch (e) { /* ok */ }
  }
  function recuperarInicial() {
    var nReq = valor(P + 'COD_REQ'), r = null;
    try {
      if (nReq) { var s = JSON.parse(sessionStorage.getItem('nc-cad-inicial-' + nReq) || 'null'); if (s && s.i) r = s; }
      var d = JSON.parse(sessionStorage.getItem(RASCUNHO) || 'null');
      /* só logo depois de um envio (a página voltou do servidor) e para a mesma pessoa */
      var voltou = /wwv_flow\.accept/.test(location.pathname) || !!nReq;
      if (!r && d && d.i && voltou && d.p === pessoa() && Date.now() - d.t < 30 * 60 * 1000) r = d;
      if (!voltou) sessionStorage.removeItem(RASCUNHO);
      if (r && nReq) { sessionStorage.setItem('nc-cad-inicial-' + nReq, JSON.stringify({ i: r.i, e: r.e })); sessionStorage.removeItem(RASCUNHO); }
    } catch (e) { r = null; }
    if (!r) return false;
    INICIAL = r.i;
    if (r.e && typeof r.e === 'object') Object.keys(r.e).forEach(function (k) { ESCOLHIDOS[k] = true; });
    guardar();
    return true;
  }
  function mudou(id) { return !!INICIAL && INICIAL[id] !== undefined && INICIAL[id].v !== valor(id); }

  /* ═══ [J4] O COMBINADO PELOS TÍTULOS ═══════════════════════════════════════════════════════
     O QUE FAZ  Se NENHUMA região tiver a classe nc-cad-tema-* (caso da 134, que recebeu só as URLs),
                o próprio arquivo põe as classes, lendo o TÍTULO de cada região:
                  CONTRATO  'Título da região': 'assunto'   (o assunto é um id de TEMAS, [J1])
                Também reconhece "Colaborador", "Seletor", "Documentos (Upload)" e "Botões", e a
                região que tem o nº do pedido (COD_REQ) vira a da solicitação.
     PODE MEXER a lista CONTRATO. Se o título de uma região mudar no APEX, mude aqui também.
     CUIDADO    O título tem que ser IGUAL ao do APEX, com acento e maiúsculas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- o contrato, quando a página não o tem ----------
     Os mesmos nomes do aplicar-cadastro-pagina136.py: título da região → classe. Só entra se
     nenhuma região já tiver nc-cad-tema-* (a 136 aplicada fica como está). */
  var CONTRATO = {
    'Endereço': 'endereco', 'Contato': 'contato', 'Dados Bancários': 'banco', 'Dados Pessoais': 'pessoais',
    'Dados da Mãe': 'familia', 'Dados do Pai': 'familia', 'Dados do Conjuge': 'familia', 'Formação / Escolaridade': 'estudo',
    'Identidade': 'documentos', 'CPF': 'documentos', 'Reservista': 'documentos', 'Título de Eleitor': 'documentos',
    'Carteira Nacional de Habilitação': 'documentos', 'PIS / PASEP': 'documentos', 'Carteira Profissional': 'documentos',
    'Habilitação Profissional': 'documentos', 'Medidas': 'uniforme', 'Portador de Necessidades': 'deficiencia'
  };
  function tituloDe(r) { var h = r.querySelector(':scope > .t-Region-header .t-Region-title, :scope > .t-ButtonRegion-wrap .t-ButtonRegion-title'); return h ? h.textContent.replace(/\s+/g, ' ').trim() : ''; }
  function contratoPorTitulo() {
    if (document.querySelector('.t-Region[class*="nc-cad-tema-"]')) return;
    var regs = [].slice.call(document.querySelectorAll('.t-Region, .t-ButtonRegion'));
    regs.forEach(function (r) {
      var t = tituloDe(r);
      if (CONTRATO[t]) r.classList.add('nc-cad-tema-' + CONTRATO[t]);
      else if (t === 'Colaborador' || r.id === 'COLABORADOR') r.classList.add('nc-cad-colaborador');
      else if (t === 'Seletor') r.classList.add('nc-cad-seletor');
      else if (r.id === 'UPLOAD_DOCS' || /^Documentos( \(Upload\))?$/.test(t)) r.classList.add('nc-cad-anexos');
      else if (t === 'Botões' && r.querySelector('.t-Button')) r.classList.add('nc-cad-acoes');
    });
    /* nº, data e solicitante: a região que tem o nº do pedido (na 136 o título é &P136_TITULO.) */
    var req = document.getElementById(P + 'COD_REQ');
    var sol = req && req.closest('.t-Region');
    if (sol && !/nc-cad-(tema|colaborador)/.test(sol.className)) sol.classList.add('nc-cad-solicitacao');
  }

  /* ═══ [J5] A MONTAGEM ══════════════════════════════════════════════════════════════════════
     O QUE FAZ  Roda uma vez: cria o alto (com a ilustração), a pergunta "O que você quer atualizar?"
                com os cartões, a caixa dos blocos (na ORDEM de TEMAS), os comprovantes depois dos
                blocos, e "Confira antes de enviar". As regiões Seletor e da solicitação somem e as
                colunas que ficaram vazias também.
     PODE MEXER os textos entre aspas: a pergunta, a explicação, 'Escolha acima o que você quer
                atualizar.'
     VISUAL     Natcorp_Cadastro.css › [C2], [C3] e [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var TOPO = null, ESCOLHA = null, CAIXA = null, RESUMO = null;
  /* a frase do cartão: a do assunto; num bloco de um ou dois campos (a 134 tem só o Estado
     civil em "Meus dados"), os próprios campos */
  function dicaDe(t) {
    var regs = [].slice.call(document.querySelectorAll('.t-Region.nc-cad-tema-' + t.id));
    var cs = []; regs.forEach(function (r) { cs = cs.concat(camposDe(r)); });
    if (!cs.length || cs.length > 2) return t.dica;
    var nomes = cs.map(function (c) { return rotulo(c); }).filter(Boolean);
    if (!nomes.length) return t.dica;
    var f = nomes.join(' e ');
    return f.charAt(0).toUpperCase() + f.slice(1).toLowerCase();
  }
  function montar() {
    if (TOPO) return;
    contratoPorTitulo();
    var col = porClasse('nc-cad-colaborador')[0];
    var ancora = col || blocos()[0];
    if (!ancora) return;
    var linha = ancora.closest('.row') || ancora;

    TOPO = el('section', 'nc-cad-topo'); TOPO.id = 'nc-cad-topo';
    TOPO.innerHTML = (ILU.ficha ? '<img class="nc-cad-topo-ilu" alt="" src="' + ILU.ficha + '">' : '') + '<div class="nc-cad-topo-txt" data-slot="txt"></div>';
    linha.parentNode.insertBefore(TOPO, linha);

    ESCOLHA = el('section', 'nc-cad-escolha'); ESCOLHA.id = 'nc-cad-escolha';
    ESCOLHA.setAttribute('aria-labelledby', 'nc-cad-escolha-t');
    ESCOLHA.innerHTML = '<h2 id="nc-cad-escolha-t">O que você quer atualizar?</h2><p>Toque em um ou mais. Só eles vão aparecer, com os dados de hoje já preenchidos.</p>' +
      '<div class="nc-cad-cartoes" role="group" aria-label="Assuntos">' + TEMAS.filter(function (t) { return document.querySelector('.nc-cad-tema-' + t.id); }).map(function (t) {
        return '<button type="button" class="nc-cad-cartao" data-tema="' + t.id + '" aria-pressed="false"><span class="nc-cad-cartao-ic" aria-hidden="true">' + svg(IC[t.icone]) + '</span>' +
          '<span class="nc-cad-cartao-tit">' + esc(t.titulo) + '</span><span class="nc-cad-cartao-dica">' + esc(dicaDe(t)) + '</span><span class="nc-cad-cartao-marca" aria-hidden="true">' + svg(IC.ok) + '</span><span class="nc-cad-cartao-conta" data-slot="conta"></span></button>';
      }).join('') + '</div><button type="button" class="nc-cad-todos" data-slot="todos"></button>';
    CAIXA = el('div', 'nc-cad-blocos'); CAIXA.id = 'nc-cad-blocos';
    var vazioMsg = el('p', 'nc-cad-blocos-vazio', 'Escolha acima o que você quer atualizar.');
    vazioMsg.id = 'nc-cad-blocos-vazio';

    /* a escolha vem depois de "de quem são os dados" (o gestor escolhe a pessoa antes) */
    var depois = col ? (col.closest('.row') || col) : linha;
    depois.parentNode.insertBefore(ESCOLHA, depois.nextSibling);
    ESCOLHA.parentNode.insertBefore(vazioMsg, ESCOLHA.nextSibling);
    vazioMsg.parentNode.insertBefore(CAIXA, vazioMsg.nextSibling);

    /* os blocos saem das abas e dos agrupadores e entram na caixa, na ordem dos assuntos */
    TEMAS.forEach(function (t) {
      [].forEach.call(document.querySelectorAll('.t-Region.nc-cad-tema-' + t.id), function (reg) {
        reg.setAttribute('data-tema', t.id);
        CAIXA.appendChild(reg);
      });
    });
    porClasse('nc-cad-seletor').forEach(function (s) { s.classList.add('nc-cad-absorvida'); });
    porClasse('nc-cad-solicitacao').forEach(function (s) { s.classList.add('nc-cad-absorvida'); });
    [].forEach.call(document.querySelectorAll('.t-Body-contentInner .col'), function (c) {
      if (!c.closest('.nc-cad-blocos') && !c.querySelector('.t-Region:not(.nc-cad-absorvida), .t-ButtonRegion, .nc-cad-topo, .nc-cad-escolha') && c.querySelector('.nc-cad-absorvida')) c.classList.add('nc-cad-col-vazia');
    });

    /* comprovantes: depois dos blocos */
    var anexos = porClasse('nc-cad-anexos')[0];
    if (anexos) {
      CAIXA.parentNode.insertBefore(anexos, CAIXA.nextSibling);
      var dica = el('div', 'nc-cad-anexos-dica'); dica.id = 'nc-cad-anexos-dica';
      var corpo = anexos.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
      if (corpo) corpo.insertBefore(dica, corpo.firstChild);
    }
    RESUMO = el('section', 'nc-cad-resumo'); RESUMO.id = 'nc-cad-resumo'; RESUMO.setAttribute('aria-live', 'polite');
    (anexos || CAIXA).parentNode.insertBefore(RESUMO, (anexos || CAIXA).nextSibling);

    ESCOLHA.addEventListener('click', function (e) {
      var b = e.target.closest('.nc-cad-cartao');
      if (b) {
        var t = b.getAttribute('data-tema');
        ESCOLHIDOS[t] = !ESCOLHIDOS[t];
        if (!ESCOLHIDOS[t]) delete ESCOLHIDOS[t];
        guardar(); agendar();
        if (ESCOLHIDOS[t]) setTimeout(function () { var r = CAIXA.querySelector('[data-tema="' + t + '"]'); if (r) r.scrollIntoView({ behavior: 'smooth', block: 'start' }); }, 80);
        return;
      }
      if (e.target.closest('.nc-cad-todos')) { TODOS = !TODOS; agendar(); }
    });
  }

  /* ═══ [J6] O ALTO: DE QUEM SÃO OS DADOS ════════════════════════════════════════════════════
     O QUE FAZ  "Atualizar meus dados" (quando a pessoa pede para si) ou "Atualizar dados de Fulano",
                com nome, matrícula e empresa, e o nº e a data do pedido, se já existir. Sem pessoa
                escolhida: "Primeiro escolha a pessoa em Colaborador".
     LÊ DOS ITENS  MATRICULA, COD_EMPRESA, MAT_SOLICITANTE, COD_REQ, DATA_SOLICITACAO.
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_Cadastro.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarTopo() {
    var mat = texto(P + 'MATRICULA'), cod = codigo(mat) || valor(P + 'MATRICULA');
    var nome = bonito(semCodigo(mat));
    /* 04/10: no Portal (app 300) a lista da matrícula mostra só o número; o nome está no campo de
       exibição MATRICULA_DISPLAY ("205818 - Tony Oliveira") */
    if (!nome || /^\d+$/.test(nome)) {
      var disp = texto(P + 'MATRICULA_DISPLAY');
      if (disp && !/^\d+$/.test(semCodigo(disp))) { nome = bonito(semCodigo(disp)); cod = cod || codigo(disp); }
    }
    var emp = bonito(semCodigo(texto(P + 'COD_EMPRESA')));
    var proprio = !!cod && cod === valor(P + 'MAT_SOLICITANTE');
    var nReq = valor(P + 'COD_REQ');
    var dt = texto(P + 'DATA_SOLICITACAO');
    TOPO.querySelector('[data-slot="txt"]').innerHTML = nome ?
      '<h1 class="nc-cad-topo-tit">' + (proprio ? 'Atualizar meus dados' : 'Atualizar dados de ' + esc(nome.split(' ')[0])) + '</h1>' +
      '<p class="nc-cad-topo-quem"><b>' + esc(nome) + '</b>' + (cod ? ' · matrícula ' + esc(cod) : '') + (emp ? ' · ' + esc(emp) : '') + '</p>' +
      (nReq ? '<p class="nc-cad-topo-req">Pedido nº <b>' + esc(nReq) + '</b>' + (dt ? ' · feito em ' + esc(dt) : '') + '</p>' : '') :
      '<h1 class="nc-cad-topo-tit">Atualizar dados cadastrais</h1><p class="nc-cad-topo-quem">Primeiro escolha a pessoa em "Colaborador".</p>';
  }

  /* ═══ [J7] OS CARTÕES E OS BLOCOS ══════════════════════════════════════════════════════════
     O QUE FAZ  A cada mudança: marca cada campo que mudou (compara com INICIAL, [J3]) e mostra
                "antes: …" na linha do nome do campo; conta as mudanças em cada bloco e em cada
                cartão; mostra só os blocos escolhidos (ou todos, com "Ver todos os dados"). Um bloco
                com mudança fica escolhido sozinho (ex.: a página voltou com erro).
     PODE MEXER os textos 'mudança', 'Mostrar só o que escolhi', 'Ver todos os dados'.
     VISUAL     Natcorp_Cadastro.css › [C3] (cartões) e [C4] (blocos e o "antes")
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function atualizar() {
    var algum = false, contaTema = {}, total = 0;
    blocos().forEach(function (reg) {
      var t = temaDe(reg), n = 0;
      camposDe(reg).forEach(function (c) {
        var id = c.id.replace(/_CONTAINER$/, '');
        var m = mudou(id);
        c.classList.toggle('nc-cad-mudou', m);
        /* o "Antes" fica na linha do rótulo, à direita: o campo não desce e a linha continua
           alinhada com os vizinhos */
        var w = c.querySelector('.t-Form-labelContainer') || c;
        var nota = w.querySelector(':scope > .nc-cad-antes');
        if (m) {
          n++;
          var antes = INICIAL[id].t;
          var html = 'antes: <b>' + (antes ? esc(antes) : 'vazio') + '</b>';
          if (!nota) { nota = el('span', 'nc-cad-antes'); w.appendChild(nota); }
          if (nota.innerHTML !== html) { nota.innerHTML = html; nota.title = 'Antes: ' + (antes || 'vazio'); }
        } else if (nota) nota.remove();
      });
      contaTema[t] = (contaTema[t] || 0) + n;
      total += n;
      /* um bloco com mudança fica escolhido (ex.: a página voltou com erro).
         04/10: e também um bloco com campo que a VALIDAÇÃO da página marcou (ex.: "Valida UF"
         num bloco não escolhido) — senão a mensagem apontava para um campo fora da vista */
      var erro = camposDe(reg).some(function (c) { return c.classList.contains('is-error') || !!c.querySelector('.apex-page-item-error'); });
      if ((n || erro) && !ESCOLHIDOS[t]) { ESCOLHIDOS[t] = true; guardar(); }
      var ver = TODOS || !!ESCOLHIDOS[t];
      reg.classList.toggle('nc-cad-fora', !ver);
      if (ver && !escondido(reg)) algum = true;
      var cab = reg.querySelector(':scope > .t-Region-header .t-Region-headerItems--title');
      if (cab) {
        var b = cab.querySelector('.nc-cad-bloco-conta');
        if (!b) { b = el('span', 'nc-cad-bloco-conta'); cab.appendChild(b); }
        b.textContent = n ? n + (n === 1 ? ' mudança' : ' mudanças') : '';
      }
    });
    [].forEach.call(ESCOLHA.querySelectorAll('.nc-cad-cartao'), function (b) {
      var t = b.getAttribute('data-tema'), on = !!ESCOLHIDOS[t];
      b.setAttribute('aria-pressed', String(on));
      b.classList.toggle('is-on', on);
      var c = b.querySelector('[data-slot="conta"]');
      c.textContent = contaTema[t] ? contaTema[t] + (contaTema[t] === 1 ? ' mudança' : ' mudanças') : '';
    });
    ESCOLHA.querySelector('[data-slot="todos"]').textContent = TODOS ? 'Mostrar só o que escolhi' : 'Ver todos os dados';
    document.getElementById('nc-cad-blocos-vazio').hidden = algum;
    montarAnexos();
    montarResumo(total);
    montarBarra(total);
  }

  /* ═══ [J8] OS COMPROVANTES ═════════════════════════════════════════════════════════════════
     O QUE FAZ  Monta a lista de documentos para anexar a partir do que MUDOU, e marca cada um como
                "Anexado" ou "Falta anexar" lendo as linhas do relatório de anexos. Com documento
                faltando, a barra do rodapé mostra "Anexar N documentos".
     PODE MEXER • DOC_BLOCO:  'Título da região': 'Nome do documento'
                • DOC_CAMPO:  ITEM_SEM_PREFIXO: 'Nome do documento'  (para campos de "Meus dados")
     CUIDADO    O nome do documento tem que ser IGUAL ao da lista "Tipo Arquivo" da janela de upload
                (página 864): é assim que a pessoa acha o tipo certo e que o arquivo sabe que já foi
                anexado.
     VISUAL     Natcorp_Cadastro.css › [C5]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* comprovantes: o exemplo muda conforme o que foi escolhido */
  /* documentos para anexar: saem do que MUDOU. O nome é o mesmo da lista "Tipo Arquivo" da
     janela de upload (página 864), para a pessoa achar e escolher igual. Por bloco (título da
     região) e, em Meus dados, só para os campos que pedem documento. */
  /* PODE MEXER: título da região → nome do documento (igual à lista "Tipo Arquivo") */
  var DOC_BLOCO = {
    'Endereço': 'Comprovante de Endereço',
    'Dados Bancários': 'Comprovante de Dados Bancários',
    'Formação / Escolaridade': 'Instrução / Formação Escolar',
    'Portador de Necessidades': 'Laudo Médico - PCD',
    'Identidade': 'Documento Identidade',
    'CPF': 'CPF',
    'Reservista': 'Reservista',
    'Título de Eleitor': 'Título de Eleitor',
    'Carteira Nacional de Habilitação': 'CNH',
    'PIS / PASEP': 'PIS',
    'Carteira Profissional': 'Carteira de Trabalho',
    'Habilitação Profissional': 'Habilitação Profissional'
  };
  var DOC_CAMPO = { NOME: 'Documento Identidade', DT_NASC: 'Documento Identidade', SEXO: 'Documento Identidade', ESTADO_CIVIL: 'Documento Identidade' };
  function tituloRegiao(reg) { var h = reg.querySelector(':scope > .t-Region-header .t-Region-title'); return h ? h.textContent.replace(/\s+/g, ' ').trim() : ''; }
  function semAcento(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase(); }
  function docsPedidos() {
    var pedidos = [];
    blocos().forEach(function (reg) {
      var tit = tituloRegiao(reg);
      camposDe(reg).forEach(function (c) {
        var id = c.id.replace(/_CONTAINER$/, '');
        if (!mudou(id)) return;
        var d = DOC_CAMPO[id.replace(P, '')] || DOC_BLOCO[tit];
        if (d && pedidos.indexOf(d) < 0) pedidos.push(d);
      });
    });
    return pedidos;
  }
  /* o que já foi anexado: as linhas do relatório de anexos (o tipo aparece no texto da linha) */
  function anexados() {
    var reg = porClasse('nc-cad-anexos')[0];
    if (!reg) return '';
    /* só as linhas do relatório: a própria lista de conferência mora na mesma região e,
       lida junto, faria cada documento "se achar" anexado */
    return semAcento([].filter.call(reg.querySelectorAll('.t-Report-report tbody tr, .a-IRR-table tr, .a-GV-table tbody tr'), function (tr) {
      return !tr.closest('#nc-cad-anexos-dica');
    }).map(function (tr) { return tr.textContent; }).join(' | '));
  }
  var DOCS_FALTAM = [];
  function montarAnexos() {
    var d = document.getElementById('nc-cad-anexos-dica');
    if (!d) return;
    var reg = porClasse('nc-cad-anexos')[0];
    var pedidos = docsPedidos(), ja = anexados();
    DOCS_FALTAM = pedidos.filter(function (x) { return ja.indexOf(semAcento(x)) < 0; });
    reg.classList.toggle('nc-cad-anexos--pede', pedidos.length > 0);
    reg.classList.toggle('nc-cad-anexos--falta', DOCS_FALTAM.length > 0);
    if (!pedidos.length) {
      d.className = 'nc-cad-docs nc-cad-docs--livre';
      d.innerHTML = '<p class="nc-cad-docs-tit">' + svg(IC.clipe) + '<span>Nenhum documento é pedido para o que você mudou até agora.</span></p>';
      return;
    }
    var ok = pedidos.length - DOCS_FALTAM.length;
    d.className = 'nc-cad-docs';
    d.innerHTML = '<p class="nc-cad-docs-tit">' + svg(IC.clipe) + '<span><b>Anexe ' + (pedidos.length === 1 ? 'este documento' : 'estes ' + pedidos.length + ' documentos') + '</b> para o RH conferir o que mudou' +
      (DOCS_FALTAM.length ? '' : ' — tudo anexado') + '</span><span class="nc-cad-docs-conta">' + ok + ' de ' + pedidos.length + '</span></p>' +
      '<ul class="nc-cad-docs-lista">' + pedidos.map(function (x) {
        var feito = DOCS_FALTAM.indexOf(x) < 0;
        return '<li class="' + (feito ? 'is-ok' : 'is-falta') + '"><span class="nc-cad-docs-marca" aria-hidden="true">' + svg(feito ? IC.ok : IC.clipe) + '</span><span class="nc-cad-docs-nome">' + esc(x) + '</span>' +
          '<span class="nc-cad-docs-estado">' + (feito ? 'Anexado' : 'Falta anexar') + '</span></li>';
      }).join('') + '</ul>' +
      (DOCS_FALTAM.length ? '<p class="nc-cad-docs-como">Toque em <b>Anexar</b>, escolha o <b>Tipo Arquivo</b> com o mesmo nome da lista e envie a foto ou o PDF.</p>' : '');
  }

  /* ═══ [J9] CONFIRA ANTES DE ENVIAR ═════════════════════════════════════════════════════════
     O QUE FAZ  A lista de tudo o que mudou: nome do campo, o valor de antes → o valor novo, com o
                total no título. Some quando nada mudou.
     PODE MEXER o título 'Confira antes de enviar' e o 'vazio'.
     VISUAL     Natcorp_Cadastro.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarResumo(total) {
    if (!RESUMO) return;
    var lista = [];
    blocos().forEach(function (reg) { camposDe(reg).forEach(function (c) {
      var id = c.id.replace(/_CONTAINER$/, '');
      if (!mudou(id)) return;
      var a = INICIAL[id].t, n = texto(id);
      lista.push('<li><span class="nc-cad-resumo-rot">' + esc(rotulo(c)) + '</span><span class="nc-cad-de">' + (a ? esc(a) : 'vazio') + '</span>' + svg(IC.seta, 'nc-cad-ic nc-cad-resumo-seta') + '<span class="nc-cad-para">' + (n ? esc(n) : 'vazio') + '</span></li>');
    }); });
    RESUMO.hidden = !lista.length;
    RESUMO.innerHTML = '<h2>Confira antes de enviar <span>' + total + '</span></h2><ul>' + lista.join('') + '</ul>';
  }

  /* ═══ [J10] A BARRA DO RODAPÉ ══════════════════════════════════════════════════════════════
     O QUE FAZ  A região nc-cad-acoes vai para depois do "Confira" e vira a barra: o que falta
                (campos obrigatórios vazios dos blocos à vista e documentos a anexar; tocar leva ao
                lugar) ou "Você mudou N dados". No celular, a lista de campos vira um botão só ("Falta
                6 campos"). O botão "Criar" passa a se chamar "Enviar pedido".
                Num pedido só para leitura (sem botão de enviar), a barra não é montada.
     COMO SABE O QUE É OBRIGATÓRIO  Pelo próprio APEX: campo com "Value Required" ligado.
     PODE MEXER os textos entre aspas: 'Falta', 'Enviar pedido', 'Nada foi mudado ainda.'…
     VISUAL     Natcorp_Cadastro.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function faltas() {
    return [].slice.call(document.querySelectorAll('.nc-cad-blocos .t-Form-fieldContainer.is-required, .nc-cad-colaborador .t-Form-fieldContainer.is-required')).filter(function (c) {
      var id = c.id.replace(/_CONTAINER$/, '');
      var reg = c.closest('.t-Region');
      return !escondido(c) && !(reg && reg.classList.contains('nc-cad-fora')) && !travado(id) && vazio(valor(id)) && vazio(texto(id));
    });
  }
  function montarBarra(total) {
    var ac = porClasse('nc-cad-acoes')[0];
    if (!ac) return;
    var enviar = [].some.call(ac.querySelectorAll('.t-Button'), function (b) { return !/voltar|fechar/i.test(b.textContent) && !escondido(b); });
    ac.classList.toggle('nc-cad-acoes--leitura', !enviar);
    if (!enviar) return;
    if (!ac.dataset.ncMovida) {
      ac.dataset.ncMovida = '1';
      RESUMO.parentNode.insertBefore(ac, RESUMO.nextSibling);
      /* na 134 os botões moravam no título da página: o tema mediu a altura dele com eles na
         carga e deixava o vão; o evento dele mede de novo */
      setTimeout(function () { apex.jQuery(window).trigger('apexwindowresized'); }, 0);
      /* nesta página o "Criar" fica na coluna do meio (numa tabela): o aviso do que falta entra
         na própria linha da barra, e o CSS põe cada um no lugar (computador e celular) */
      var alvo = ac.querySelector('.t-ButtonRegion-wrap') || ac;
      var s = el('div', 'nc-cad-status'); s.id = 'nc-cad-status'; s.setAttribute('aria-live', 'polite');
      alvo.appendChild(s);
      s.addEventListener('click', function (e) {
        var b = e.target.closest('[data-ir]'); if (!b) return;
        var c = document.getElementById(b.getAttribute('data-ir')); if (!c) return;
        c.scrollIntoView({ behavior: 'smooth', block: 'center' });
        var i = c.querySelector('input:not([type=hidden]), select, textarea'); if (i) setTimeout(function () { i.focus({ preventScroll: true }); }, 350);
      });
    }
    var f = faltas();
    var fd = DOCS_FALTAM.length;
    /* no celular a lista de campos vira um botão só ("Falta 6 campos"), que leva ao primeiro */
    var docsHtml = fd ? '<button type="button" class="nc-cad-falta nc-cad-falta--doc" data-ir="' + (porClasse('nc-cad-anexos')[0] || {}).id + '">' + (fd === 1 ? 'Anexar 1 documento' : 'Anexar ' + fd + ' documentos') + '</button>' : '';
    document.getElementById('nc-cad-status').innerHTML = f.length || fd ? '<span class="nc-cad-status-rot">Falta</span> ' + (f.length ?
      f.map(function (c) { return '<button type="button" class="nc-cad-falta nc-cad-so-largo" data-ir="' + c.id + '">' + esc(rotulo(c)) + '</button>'; }).join('') +
      '<button type="button" class="nc-cad-falta nc-cad-so-celular" data-ir="' + f[0].id + '">' + f.length + (f.length === 1 ? ' campo' : ' campos') + '</button>' : '') + docsHtml :
      total ? '<span class="nc-cad-status-ok">' + svg(IC.ok) + 'Você mudou ' + total + (total === 1 ? ' dado' : ' dados') + '</span>' :
      '<span class="nc-cad-status-nada">Nada foi mudado ainda.</span>';
    /* o botão de enviar diz o que faz */
    [].forEach.call(ac.querySelectorAll('.t-Button'), function (b) {
      if (/^\s*criar\s*$/i.test(b.textContent) && !b.dataset.ncRotulo) { b.dataset.ncRotulo = '1'; var l = b.querySelector('.t-Button-label') || b; l.textContent = 'Enviar pedido'; }
    });
  }

  /* ═══ [J11] O MAESTRO: QUANDO CADA PARTE É MONTADA ═════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a página abre: põe a marca nc-cad no corpo da página (é
                dela que o visual depende) e monta tudo. 900 milésimos depois (quando as ações
                dinâmicas da carga já rodaram) guarda os valores de hoje. Depois, redesenha a cada
                mudança: campo alterado, ação dinâmica que traz valores, janela que fecha. Trocar a
                pessoa (MATRICULA / COD_EMPRESA) recomeça a escolha e os valores de hoje.
     CUIDADO    Não mude os tempos (900, 1800) nem a ordem das chamadas: são eles que garantem que o
                "antes" seja o valor do banco, e não um valor ainda carregando.
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp cadastro] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tudo() {
    montar();
    if (!TOPO) return;
    montarTopo();
    atualizar();
  }
  var agendado = false, MO = null;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () {
      agendado = false;
      try { tudo(); } catch (e) { if (window.console) console.warn('[Natcorp cadastro]', e); }
      if (MO) MO.takeRecords();
    });
  }
  function iniciar() {
    document.body.classList.add('nc-cad');
    tudo();
    /* os valores de hoje: depois das ações dinâmicas da carga */
    setTimeout(function () { if (!recuperarInicial()) guardarInicial(); agendar(); }, 900);
    $(document).on('apexbeforepagesubmit', guardarRascunho);
    var form = document.getElementById('wwvFlowForm'); if (form) form.addEventListener('submit', guardarRascunho, true);
    $(document).on('change', '[id^="' + P + '"]', function (e) {
      /* trocou a pessoa: os dados de hoje passam a ser os dela */
      if (new RegExp('^' + P + '(MATRICULA|COD_EMPRESA)(_HIDDENVALUE)?$').test(e.target.id)) {
        INICIAL = null; ESCOLHIDOS = {}; guardar();
        clearTimeout(window.__ncCadT); window.__ncCadT = setTimeout(function () { guardarInicial(); agendar(); }, 1800);
      }
      agendar();
    });
    $(document).on('input', '.nc-cad-blocos input, .nc-cad-blocos textarea', agendar);
    $(document).on('apexafterrefresh', agendar);
    /* valores trazidos do servidor por ação dinâmica (Executar PL/SQL, "itens a retornar")
       chegam SEM o evento change: sem isto a tela ficava com a leitura de antes da resposta */
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    $(document).on('apexafterclosedialog dialogclose', function () { setTimeout(agendar, 80); });
    if (window.MutationObserver && CAIXA) {
      MO = new MutationObserver(agendar);
      MO.observe(CAIXA, { attributes: true, subtree: true, attributeFilter: ['style', 'disabled'] });
    }
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
