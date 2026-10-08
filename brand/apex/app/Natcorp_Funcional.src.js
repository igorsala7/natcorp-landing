/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · INFORMAÇÕES FUNCIONAIS  —  o "arrumador" da tela (JavaScript)                  ║
   ║  App 600 · Página 35 · a etapa "Dados Funcionais" que o RH abre em                        ║
   ║  Administração de Pessoal › Informações do Colaborador                                    ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   A página tem mais de 200 campos em 9 abas (Identificação, Lotação, Cargo/Salário, Folha,
   Horário, Pagamentos/Convênios, Previdência Privada, Seguro de Vida, Ocorrências
   Disciplinares). A maior parte é CONSULTA (campos só de leitura vindos da folha) e uma parte
   se edita depois de "Alterar Dados". Este arquivo deixa isso mais fácil de ler:
     1. A FICHA NO ALTO: situação (Ativo em verde), cargo, local, contrato, jornada e salário,
        lidos dos campos da página. Tocar num dado abre a aba dele e mostra o campo.
     2. AS ABAS: em letra normal ("Cargo e salário"), com ícone. No computador quebram linha em
        vez de esconder metade atrás de uma seta; no celular rolam de lado.
     3. CONSULTA × EDIÇÃO: campo só de leitura vira "ficha" (fundo leve, sem borda, sem o botão
        de lista/calendário); o que se edita continua caixa branca — o olho acha o editável.
        Campo vazio mostra "—".
     4. AS AÇÕES: "Alterar Dados" em destaque; as consultas (Evolução Salarial, Políticas de
        Cálculo…) sob o título "Consultas desta aba". A página desliga as que não servem à aba
        aberta, e as desligadas saem da vista. No celular, as ações sobem para antes das abas.
     5. RÓTULOS: jargão encurtado e os rótulos trocados da página corrigidos (o "Sindicato" que
        dizia "Tipo ATS", o tempo de serviço "sem adesão" que dizia "com adesão"…).

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda valor nenhum e não grava nada: o APEX continua dono de tudo.
     • Não decide o que é editável: quem trava e libera campos é o APEX ("Alterar Dados").
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX e continua
       funcionando normalmente. Nada se perde.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 35 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Funcional.js
     Página 35 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Funcional.css
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Funcional.css.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Esta página NÃO usa classes postas no APEX. O arquivo se reconhece sozinho:
     • só funciona se a página tiver os três itens …_SITUACAO_DSP, …_SALARIO_DSP e
       …_JORNADA_DSP (em qualquer página que não os tenha, ele não faz nada);
     • a região de abas tem o Static ID  TABS ;
     • o botão de editar se chama exatamente "Alterar Dados";
     • as consultas são os outros botões da mesma coluna do "Alterar Dados".
   Se um desses nomes mudar no APEX, a parte correspondente do desenho deixa de aparecer.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J1]  Configuração ........................ a ficha do alto e os rótulos novos  PODE MEXER
     [J2]  Ferramentas ......................... funções pequenas usadas no arquivo todo
     [J3]  Montar (uma vez) .................... cria a ficha, arruma abas e ações   PODE MEXER
     [J4]  Atualizar (sempre) .................. preenche a ficha, consulta × edição PODE MEXER
     [J5]  O maestro ........................... decide QUANDO cada parte roda        CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Consultas desta aba'  →  'Outras consultas'
     Quero mudar o rótulo de um campo (ou desfazer uma troca feita aqui)
       → [J1], lista ROTULOS. Cada linha é  NOME_DO_ITEM_SEM_O_P35: 'Rótulo novo',
         Para devolver o rótulo do APEX, apague a linha inteira daquele item.
         O ideal é corrigir o rótulo no próprio APEX e depois apagar a linha daqui.
     Quero mostrar outro dado na ficha do alto (ou tirar um)  → [J1], lista FATOS.
     Uma aba ficou com o ícone errado                          → [J1], lista ABA_IC.
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp funcional].
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
     P + 'SALARIO_DSP'      junta os textos: vira 'P35_SALARIO_DSP', o nome do item no APEX.
     valor(…)               lê o que está num item do APEX (veja [J2]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* CUIDADO: estas linhas impedem que o arquivo rode duas vezes ou fora do APEX, e o fazem
     desistir em silêncio se a página não tiver os três itens que a reconhecem
     (…_SITUACAO_DSP, …_SALARIO_DSP, …_JORNADA_DSP). Não apague. */
  if (window.__ncFuncional || !window.apex || !window.apex.jQuery) return;
  var achado = document.querySelector('[id$="_SITUACAO_DSP_CONTAINER"]');
  if (!achado || !document.querySelector('[id$="_SALARIO_DSP_CONTAINER"]') || !document.querySelector('[id$="_JORNADA_DSP_CONTAINER"]')) return;
  window.__ncFuncional = true;

  var $ = apex.jQuery;
  /* O começo do nome dos itens ('P35_'), descoberto sozinho a partir do item SITUACAO_DSP.
     Por isso, se a página for copiada para outro número, NADA precisa mudar aqui. */
  var P = achado.id.replace(/SITUACAO_DSP_CONTAINER$/, '');

  /* ═══ [J1] CONFIGURAÇÃO ═══════════════════════════════════════════════════════════════════
     O QUE É    As listas que dizem O QUE a tela mostra. É a parte mais fácil de mexer.
       FATOS    os dados da ficha do alto, na ordem em que aparecem. Cada linha tem:
                  itens  → os itens a tentar, sem o P35_ (vale o primeiro que tiver valor)
                  rot    → o rótulo que aparece em cima do dado
                  ic     → o ícone (um dos nomes da lista IC logo abaixo)
                  data   → (opcional) item com a data mostrada como "desde …"
                  dinheiro: true → (opcional) põe "R$ " na frente do valor
       ROTULOS  rótulos novos para campos da página:  ITEM_SEM_P35: 'Rótulo que aparece'
       ABA_IC   qual ícone cada aba recebe, pelo nome dela: [/pedaço do nome/i, 'ícone']
     PODE MEXER as três listas. Para acrescentar, copie uma linha inteira e troque os textos.
     CUIDADO    Cada linha termina em vírgula, menos a última da lista. O rótulo 'Situação' é
                usado também para pintar a situação de verde/vermelho/amarelo (em [J4]): se
                trocar esse texto, troque também lá.
     VISUAL     Natcorp_Funcional.css › [C2] (ficha) e [C3] (abas)
     ════════════════════════════════════════════════════════════════════════════════════════ */

  /* PODE MEXER: a ficha do alto — {itens, rótulo, ícone}; vale o primeiro item que tiver valor */
  var FATOS = [
    { itens: ['SITUACAO_DSP'], rot: 'Situação', ic: 'pulso', data: 'DATASIT_DSP' },
    { itens: ['CARGO_DSP', 'FUNCAO_DSP'], rot: 'Cargo', ic: 'maleta' },
    { itens: ['LOCAL_DSP'], rot: 'Local', ic: 'local' },
    { itens: ['TPCONTRATO_DSP'], rot: 'Contrato', ic: 'contrato' },
    { itens: ['JORNADA_DSP', 'COD_HORARIO_DSP', 'REG_TRAB_DSP'], rot: 'Jornada', ic: 'relogio' },
    { itens: ['SALARIO_DSP', 'TOTAL_REMUNERACAO'], rot: 'Salário', ic: 'dinheiro', dinheiro: true }
  ];
  /* PODE MEXER: rótulos novos — ITEM (sem o P35_): 'como o rótulo deve aparecer'.
     Vários corrigem rótulos trocados na própria página (ex.: NUM_SIND_DISS_DSP dizia
     "Tipo ATS"; TSA_PAT_S_ADES_* diziam "com adesão"). O certo é corrigir no APEX. */
  var ROTULOS = {
    TMPPARCIAL_DSP: 'Horas por semana (contrato parcial)', QTD_DIAS_DSP: 'Dias de contrato',
    DATA_CONTRATO_PRZ_DETERMINADO: 'Término do contrato', QTD_DIAS_PRORROG_DSP: 'Dias de prorrogação',
    DT_LOCAL_TRAB: 'No local desde', QUALIFCC_DSP: 'Qualificação (código)',
    VLR_AUX_TIPO_MODALIDADE: 'Auxílio home office / semipresencial', DT_VLR_AUX_TIPO_MODALIDADE: 'Vigência do auxílio',
    ADTO_SALARIAL_DSP: 'Adiantamento salarial?', PERC_ADIANT: '% do adiantamento',
    IND_CONTR_SINDICAL: 'Pagou sindicato no ano?', REQUEREU_DSP: 'Requereu seguro-desemprego?',
    DESC_CONTRIB_ASSIST_DSP: 'Paga contribuição sindical?', TIPO_ATS_DSP: 'Adicional por tempo de serviço (ATS)',
    DT_BASE_ATS_DSP: 'Data base do ATS', DT_FIM_ATS: 'Data fim do ATS', PERC_ATS: '% do ATS',
    ISENCAO_IAPAS_DSP: 'INSS?', ISENCAO_IR_DSP: 'Imposto de Renda?',
    MATRICULA_SINDICATO: 'Nº de sócio no sindicato',
    NUM_SIND_DISS_DSP: 'Sindicato do dissídio',
    DT_REG_TRAB: 'Regime desde', TRAB_INTERMITENTE: 'Trabalho intermitente?', TOLER_PONTO: 'Tolerância do ponto',
    MARCA_PONTO_DSP: 'Marca ponto?', TP_REGISTRO_PONTO: 'Tipo de registro do ponto', PARAM_BH_DSP: 'Banco de horas (parâmetro)',
    TP_ID_CHAVE_PIX: 'Tipo de chave PIX', DT_RETRATACAO_FGTS: 'Data da retratação',
    DT_ADESAO: 'Adesão (início)', DT_ADESAO_FINAL: 'Adesão (fim)', DT_ADESAO2: 'Adesão (início)', DT_ADESAO2_FINAL: 'Adesão (fim)',
    TSA_PAT_C_ADES_ANOS: 'Patrocinadora com adesão (anos)', TSA_PAT_C_ADES_MESES: 'Patrocinadora com adesão (meses)',
    TSA_PAT_S_ADES_ANOS: 'Patrocinadora sem adesão (anos)', TSA_PAT_S_ADES_MESES: 'Patrocinadora sem adesão (meses)',
    TSA_NAO_PAT_ANOS: 'Não patrocinadora (anos)', TSA_NAO_PAT_MESES: 'Não patrocinadora (meses)',
    TSA_OUTRAS_EMP_ANOS: 'Outras empresas (anos)', TSA_OUTRAS_EMP_MESES: 'Outras empresas (meses)'
  };
  /* Os ícones (desenhos pequenos) usados na tela, no formato SVG. Não precisa mexer. */
  var IC = {
    pulso: '<path d="M3 12h4l2.5-6 4 12 2.5-6H21"/>',
    maleta: '<rect x="3" y="7" width="18" height="13" rx="2.5"/><path d="M8.5 7V5.5A1.5 1.5 0 0 1 10 4h4a1.5 1.5 0 0 1 1.5 1.5V7M3 12.5h18"/>',
    local: '<path d="M12 21s-6.5-5.6-6.5-11a6.5 6.5 0 0 1 13 0c0 5.4-6.5 11-6.5 11z"/><circle cx="12" cy="10" r="2.5"/>',
    contrato: '<path d="M6 3.5h8l4 4v13H6z"/><path d="M14 3.5v4h4M9 12h6M9 15.5h6"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    dinheiro: '<rect x="2.5" y="6" width="19" height="12" rx="2"/><circle cx="12" cy="12" r="2.6"/><path d="M6 9.5v5M18 9.5v5"/>',
    cracha: '<rect x="4" y="3.5" width="16" height="17" rx="2.5"/><circle cx="12" cy="10" r="2.6"/><path d="M8 16.5c.8-1.6 2.3-2.4 4-2.4s3.2.8 4 2.4"/>',
    calc: '<rect x="5" y="3" width="14" height="18" rx="2.5"/><path d="M8 7h8M8.5 11.5h1M11.5 11.5h1M14.5 11.5h1M8.5 15h1M11.5 15h1M14.5 15h1"/>',
    cartao: '<rect x="2.5" y="5.5" width="19" height="13" rx="2"/><path d="M2.5 10h19M6 14.5h4"/>',
    cofre: '<rect x="3" y="4.5" width="18" height="15" rx="2"/><circle cx="12" cy="12" r="3.2"/><path d="M12 8.8v1M12 14.2v1M6 19.5v1.5M18 19.5v1.5"/>',
    escudo: '<path d="M12 3l7.5 3v5.5c0 4.6-3.2 8.2-7.5 9.5-4.3-1.3-7.5-4.9-7.5-9.5V6z"/><path d="M9 12l2.2 2.2L15.5 10"/>',
    alerta: '<path d="M12 3.5l9.5 16.5h-19z"/><path d="M12 10v4.5M12 17.2v.1"/>',
    lapis: '<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    olho: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="3"/>'
  };
  /* PODE MEXER: o ícone de cada aba — [/pedaço do nome da aba/i, 'nome do ícone em IC'].
     Aba que não casa com nenhuma linha recebe o ícone 'contrato'. */
  var ABA_IC = [[/identifica/i, 'cracha'], [/lota/i, 'local'], [/cargo|sal[aá]rio/i, 'maleta'], [/folha/i, 'calc'],
    [/hor[aá]rio/i, 'relogio'], [/pagamento|conv[eê]nio/i, 'cartao'], [/previd/i, 'cofre'], [/seguro/i, 'escudo'], [/ocorr|disciplin/i, 'alerta']];

  /* ═══ [J2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       valor('ITEM')      o que está no item P35_ITEM ('-' ou vazio contam como vazio)
       campo('ITEM')      o campo P35_ITEM na tela
       limpo(texto)       tira o código da frente: "01-ATIVO" → "Ativo",
                          "[I] - PRAZO INDETERMINADO" → "Prazo indeterminado"
       frase(texto)       "SUPERVISOR DE SETOR" → "Supervisor de setor" (siglas continuam em
                          maiúsculas: RH, TI, CLT, SP…)
       renomear(item, t)  troca o rótulo do item na tela (usado com a lista ROTULOS)
       mostrar('ITEM')    abre a aba do item, rola até ele e o faz piscar
     PODE MEXER a lista SIGLAS: palavras que ficam sempre em MAIÚSCULAS. Acrescente separando
                por |  (ex.: |rh|ti|  →  |rh|ti|sesmt| ).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function svg(d) { return '<svg class="nc-fu-ic" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function html(e, h) { if (e && e.__h !== h) { e.__h = h; e.innerHTML = h; } }
  function classe(e, c, on) { if (e && e.classList.contains(c) !== !!on) e.classList.toggle(c, !!on); }
  function campo(n) { return document.getElementById(P + n); }
  function valor(n) { var e = campo(n); if (!e) return ''; var v = String(e.value || e.textContent || '').trim(); return /^[-–—]?$/.test(v) ? '' : v; }
  var SIGLAS = /\b(rh|ti|dp|sac|cd|clt|cipa|ltda|sa|mg|sp|rj|pr|rs|sc|ba|go|df|pe|ce|es)\b/g;
  function frase(t) {
    t = String(t || '').trim().toLowerCase().replace(SIGLAS, function (m) { return m.toUpperCase(); });
    return t.charAt(0).toUpperCase() + t.slice(1);
  }
  /* quase tudo em maiúsculas (ex.: "DAS 06:30 Às 12:30") conta como maiúsculas */
  function gritado(t) { var l = String(t).replace(/[^A-Za-zÀ-ÿ]/g, ''); return l.length > 2 && l.replace(/[^A-ZÀ-Ý]/g, '').length / l.length > .7; }
  /* "01-ATIVO" → "Ativo"; "[I] - PRAZO INDETERMINADO" → "Prazo indeterminado"; "624-SUPERVISOR DE SETOR" → "Supervisor de setor" */
  function limpo(t) {
    t = String(t || '').replace(/^\s*\[[^\]]*\]\s*-?\s*/, '').replace(/^\s*[\w.\/]{1,8}\s*-\s*/, '').trim();
    return gritado(t) ? frase(t) : t;
  }
  function renomear(n, t) {
    var l = document.getElementById(P + n + '_LABEL');
    if (!l || l.getAttribute('data-nc-fu')) return;
    for (var i = 0; i < l.childNodes.length; i++) {
      var x = l.childNodes[i];
      if (x.nodeType === 3 && x.textContent.trim()) { x.textContent = t + ' '; l.setAttribute('data-nc-fu', '1'); return; }
    }
  }
  function abaDe(c) { var p = c && c.closest('.a-Tabs-panel'); return p ? document.querySelector('#' + p.id + '_tab a, [aria-controls="' + p.id + '"] a') : null; }
  function mostrar(n) {
    var c = document.getElementById(P + n + '_CONTAINER'); if (!c) return;
    var a = abaDe(c); if (a) a.click();
    setTimeout(function () {
      c.scrollIntoView({ block: 'center', behavior: 'smooth' });
      c.classList.remove('nc-fu-pisca'); void c.offsetWidth; c.classList.add('nc-fu-pisca');
    }, 120);
  }

  /* ═══ [J3] MONTAR (roda uma vez, quando a página abre) ═══════════════════════════════════
     O QUE FAZ  • troca os rótulos da lista ROTULOS;
                • cria a caixa da ficha do alto, logo acima da linha das abas;
                • reescreve o nome de cada aba em letra normal e põe o ícone;
                • acha o botão "Alterar Dados" e marca a coluna dele como a coluna das ações;
                  os outros botões dessa coluna viram "consultas", com o título
                  "Consultas desta aba" em cima;
                • cria a linha de aviso "Os campos com fundo claro são só de consulta…".
     CUIDADO    O botão precisa se chamar exatamente "Alterar Dados" (maiúsculas não
                importam). Se ele for renomeado no APEX, troque o texto aqui também
                (procure  alterar dados  logo abaixo).
     PODE MEXER o texto 'Consultas desta aba'.
     VISUAL     Natcorp_Funcional.css › [C2] (ficha), [C3] (abas), [C5] (ações)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FICHA, ACOES;
  function montar() {
    Object.keys(ROTULOS).forEach(function (n) { renomear(n, ROTULOS[n]); });

    /* a ficha: logo abaixo do cabeçalho do colaborador (a região que diz nome, empresa, admissão) */
    var tabs = document.getElementById('TABS') || achado.closest('.t-TabsRegion');
    var linha = tabs && tabs.closest('.row');
    FICHA = el('div', 'nc-fu-ficha');
    FICHA.setAttribute('aria-label', 'Resumo funcional');
    if (linha) linha.parentNode.insertBefore(FICHA, linha); else if (tabs) tabs.parentNode.insertBefore(FICHA, tabs);
    FICHA.addEventListener('click', function (e) { var b = e.target.closest('[data-item]'); if (b) mostrar(b.getAttribute('data-item')); });

    /* as abas em letra normal, com ícone */
    [].forEach.call(document.querySelectorAll('.t-Tabs-item .t-Tabs-link'), function (a) {
      if (a.getAttribute('data-nc-fu')) return;
      var t = a.textContent.replace(/\s+/g, ' ').trim();
      var nome = frase(t).replace(/\s*\/\s*/g, ' e ');
      var ic = (ABA_IC.filter(function (x) { return x[0].test(t); })[0] || [0, 'contrato'])[1];
      a.setAttribute('data-nc-fu', '1');
      a.innerHTML = svg(IC[ic]) + '<span>' + esc(nome) + '</span>';
    });
    if (tabs) tabs.classList.add('nc-fu-abas');

    /* as ações da coluna ao lado: "Alterar Dados" em destaque, o resto como consultas */
    var alt = [].filter.call(document.querySelectorAll('.t-Button'), function (b) { return /^\s*alterar dados\s*$/i.test(b.textContent); })[0];
    /* a coluna da direita é a IRMÃ da coluna das abas na mesma linha da grade */
    var col = alt && linha ? [].filter.call(linha.children, function (c) { return c.contains(alt) && !c.contains(tabs); })[0] : null;
    if (col) {
      col.classList.add('nc-fu-acoes');
      alt.classList.add('nc-fu-alterar');
      var consultas = [].filter.call(col.querySelectorAll('.t-Button'), function (b) { return b !== alt; });
      consultas.forEach(function (b) { b.classList.add('nc-fu-consulta'); });
      if (consultas.length) {
        /* o título entra antes do pedaço (filho direto da coluna) que tem a primeira consulta */
        var bloco = consultas[0]; while (bloco.parentElement && bloco.parentElement !== col) bloco = bloco.parentElement;
        var bAlt = alt; while (bAlt.parentElement && bAlt.parentElement !== col) bAlt = bAlt.parentElement;
        var titulo = el('p', 'nc-fu-acoes-tit', 'Consultas desta aba');
        if (bloco === bAlt) { /* alterar e consultas no mesmo pedaço: o título vai logo depois do Alterar */
          var x = alt; while (x.parentElement && !x.parentElement.contains(consultas[0])) x = x.parentElement;
          x.parentNode.insertBefore(titulo, x.nextSibling);
        } else bloco.parentNode.insertBefore(titulo, bloco);
      }
      ACOES = col;
    }
    var aviso = el('p', 'nc-fu-modo');
    aviso.hidden = true;
    if (tabs) tabs.parentNode.insertBefore(aviso, tabs);
  }

  /* ═══ [J4] ATUALIZAR (roda de novo a cada mudança) ═══════════════════════════════════════
     O QUE FAZ  • preenche a ficha do alto com a lista FATOS (cada dado é um botão que leva ao
                  campo). A situação fica verde se "ativo"; o ícone dela fica vermelho se
                  "demitido/desligado/rescisão/inativo", e amarelo nos outros casos;
                • marca cada campo como CONSULTA (só leitura) ou EDIÇÃO, olhando se o APEX o
                  deixou readonly/disabled. Campo de consulta vazio mostra "—";
                • escreve o aviso do alto, que muda conforme haja campo editável ou não;
                • esconde as consultas que a página desligou para a aba aberta.
     LÊ DOS ITENS  os da lista FATOS (SITUACAO_DSP, DATASIT_DSP, CARGO_DSP, FUNCAO_DSP,
                LOCAL_DSP, TPCONTRATO_DSP, JORNADA_DSP, COD_HORARIO_DSP, REG_TRAB_DSP,
                SALARIO_DSP, TOTAL_REMUNERACAO) e todos os campos dentro da região TABS.
     PODE MEXER as frases do aviso ('Os campos com fundo claro são…', 'Para mudar, toque em…').
     VISUAL     Natcorp_Funcional.css › [C2] (ficha) e [C4] (consulta × edição)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function atualizar() {
    /* a ficha */
    var h = FATOS.map(function (f) {
      /* 04/10: item que a PÁGINA escondeu (ex.: "Show/Hide Duplo Vínculo" esconde SALARIO_DSP e
         mostra o salário do duplo vínculo; "Hide Show Itens" troca CARGO_DSP pelo editável) não
         entra na ficha: a ficha não mostra o que a página tirou da vista */
      var n = f.itens.filter(function (x) { var c = document.getElementById(P + x + '_CONTAINER'); return valor(x) && !(c && c.style.display === 'none'); })[0];
      if (!n) return '';
      var v = limpo(valor(n));
      if (f.dinheiro) v = /^[\d.,]+$/.test(v) ? 'R$ ' + v : v.replace(/^R\$\s*/, 'R$ ');
      var cls = '';
      if (f.rot === 'Situação') cls = /ativ/i.test(v) && !/inativ/i.test(v) ? ' nc-fu-fato--ok' : /demit|deslig|rescis|inativ/i.test(v) ? ' nc-fu-fato--fim' : ' nc-fu-fato--aviso';
      var desde = f.data && valor(f.data) ? '<span class="nc-fu-fato-sub">desde ' + esc(valor(f.data)) + '</span>' : '';
      return '<button type="button" class="nc-fu-fato' + cls + '" data-item="' + n + '"><span class="nc-fu-fato-ic">' + svg(IC[f.ic]) + '</span>' +
        '<span class="nc-fu-fato-txt"><span class="nc-fu-fato-rot">' + esc(f.rot) + '</span><span class="nc-fu-fato-v">' + esc(v) + '</span>' + desde + '</span></button>';
    }).join('');
    html(FICHA, h);
    FICHA.hidden = !h;

    /* consulta × edição: campo só de leitura vira ficha; vazio mostra "—" */
    [].forEach.call(document.querySelectorAll('#TABS .t-Form-fieldContainer, .nc-fu-abas .t-Form-fieldContainer'), function (c) {
      var i = c.querySelector('input:not([type=hidden]), textarea, select');
      if (!i) return;
      var so = !!(i.readOnly || i.disabled);
      classe(c, 'nc-fu-leitura', so);
      if (so && i.tagName !== 'SELECT' && !i.getAttribute('placeholder')) i.setAttribute('placeholder', '—');
    });
    var editaveis = [].filter.call(document.querySelectorAll('#TABS .t-Form-fieldContainer'), function (c) { return c.style.display !== 'none' && !c.classList.contains('nc-fu-leitura') && c.querySelector('input:not([type=hidden]), select, textarea'); }).length;
    var aviso = document.querySelector('.nc-fu-modo');
    if (aviso) {
      var temAlt = !!document.querySelector('.nc-fu-alterar');
      html(aviso, svg(IC.olho) + '<span>Os campos com fundo claro são <b>só de consulta</b> (vêm da folha). ' +
        (editaveis ? 'Os de caixa branca podem ser mudados.' : temAlt ? 'Para mudar, toque em <b>Alterar Dados</b>.' : '') + '</span>');
      aviso.hidden = false;
    }
    /* consultas apagadas pela página (não servem à aba aberta): saem da vista */
    if (ACOES) [].forEach.call(ACOES.querySelectorAll('.nc-fu-consulta'), function (b) { classe(b, 'nc-fu-apagada', b.disabled || b.getAttribute('aria-disabled') === 'true'); });
    if (ACOES) { var t = ACOES.querySelector('.nc-fu-acoes-tit'); if (t) t.hidden = !ACOES.querySelector('.nc-fu-consulta:not(.nc-fu-apagada)'); }
  }

  /* ═══ [J5] O MAESTRO: QUANDO CADA PARTE RODA ═════════════════════════════════════════════
     O QUE FAZ  iniciar() roda uma vez quando a página abre: monta ([J3]), põe a marca nc-fu na
                página (é ela que liga o CSS) e atualiza ([J4]). Depois, manda atualizar de
                novo sempre que algo muda: um campo é alterado, outra aba é aberta, uma ação
                dinâmica traz valores do servidor, "Alterar Dados" libera campos.
     CUIDADO    Não mude a ordem montar → nc-fu → atualizar.
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp funcional] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var agendado = false, MO = null;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () {
      agendado = false;
      try { atualizar(); } catch (e) { if (window.console) console.warn('[Natcorp funcional]', e); }
      if (MO) MO.takeRecords();
    });
  }
  function iniciar() {
    montar();
    document.body.classList.add('nc-fu');
    atualizar();
    $(document).on('change', '[id^="' + P + '"]', agendar);
    $(document).on('atabsactivate', agendar);
    $(document).ajaxComplete(function () { setTimeout(agendar, 30); });
    if (window.MutationObserver) {
      /* "Alterar Dados" libera campos (readonly/disabled) e a troca de aba liga/desliga as consultas */
      MO = new MutationObserver(agendar);
      var alvo = document.getElementById('TABS'); if (alvo) MO.observe(alvo, { attributes: true, subtree: true, attributeFilter: ['readonly', 'disabled', 'style'] });
      if (ACOES) MO.observe(ACOES, { attributes: true, subtree: true, attributeFilter: ['disabled', 'aria-disabled', 'style'] });
    }
    setTimeout(agendar, 800);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
