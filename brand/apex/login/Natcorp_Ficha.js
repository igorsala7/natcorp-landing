/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · DADOS FUNCIONAIS (a ficha do colaborador) — o "arrumador" da tela (JavaScript) ║
   ║  App 200 · Página 17 · o perfil que o RH consulta e confere o dia inteiro                 ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns. Guia desta página: brand/apex/app/FICHA-MANUTENCAO.md

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quando a página 17 abre, ele REORGANIZA o que o APEX já desenhou, como um perfil:
     • o alto: faixa da marca, foto grande, nome, situação, as ações da página e os 6 fatos
       que identificam a pessoa (matrícula, empresa, admissão + tempo de casa, cargo, filial,
       centro de custo);
     • a navegação à esquerda (fixa ao rolar), com busca de campo (tecla "/") e as seções com
       a contagem de cada uma. Ela substitui as abas, que continuam no APEX (em "Mostrar
       Tudo"), fora da vista;
     • as seções organizadas por ASSUNTO, não pela ordem do APEX (Dados Pessoais vira
       Identificação, Nacionalidade, Escolaridade, Contato, Deficiência, Banco…), com resumos:
       7 "Não" de deficiência viram "Nenhuma deficiência declarada"; campos vazios vão para
       "N campos sem informação"; Cargos/Salários abre com salário, total e benefícios em R$
       (com o "olho" para esconder os valores);
     • Dependentes em cartões (o relatório tem 56 colunas) e Ocorrências numa linha do tempo,
       com a tabela original a um clique ("Ver tabela completa");
     • copiar com um clique (o campo desabilitado não deixa selecionar o texto);
     • a janela "Benefícios": os benefícios em cartões, por grupo, com todas as linhas (o
       relatório vinha paginado de 15 em 15).

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não grava nem apaga nada: a página é só de consulta (não tem botão de gravar).
     • Não cria campos: os itens, os relatórios e os botões continuam na página (fora da vista
       quando o desenho os mostra de outro jeito).
     • Se este arquivo for retirado da página, a tela volta ao visual padrão do APEX, com as
       abas, e continua funcionando normalmente.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 17 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Ficha.js
     O visual (cores, tamanhos, espaços) fica no arquivo-irmão: Natcorp_Ficha.css.
     A janela "Documentos" é OUTRO app (2210, página 865): veja DOCUMENTOS-MANUTENCAO.md.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Classes postas nas regiões (Page Designer › clique na região › Appearance › CSS Classes;
   já aplicadas pelo aplicar-ficha-pagina17.py):
     nc-df-colaborador   região "Colaborador" (foto, empresa, matrícula, situação…) → o alto
     nc-df-info          região "Informações" (a das abas)        → a navegação e as seções
     nc-df-beneficios    região "Benefícios Relatório" (na janela "Benefícios")
                                                                   → os benefícios em cartões
   As seções são reconhecidas pelo TÍTULO de cada região de dentro de "Informações"
   ("Dados Pessoais", "Documentos", "Lotação"…): veja a lista SECOES em [J2].
   Sem nc-df-colaborador OU sem nc-df-info, a ficha não é montada e a página fica no padrão.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J0]  Começo ................................. o prefixo dos itens (P17_)
     [J1]  Ícones ................................. os desenhos pequenos (não precisa mexer)
     [J2]  Seções, grupos e parentesco ............ como os campos se agrupam      PODE MEXER
     [J3]  Ferramentas ............................ funções pequenas usadas no arquivo todo
     [J4]  A montagem ............................. a ordem em que tudo é montado    CUIDADO
     [J5]  O alto ................................. foto, nome, situação, 6 fatos     PODE MEXER
     [J6]  As seções e os campos .................. grupos, vazios, valores em R$     PODE MEXER
     [J7]  Dependentes em cartões ................. lê o relatório de dependentes     CUIDADO
     [J8]  Ocorrências: a linha do tempo .......... lê o relatório de ocorrências     CUIDADO
     [J9]  A janela "Benefícios" .................. cartões por grupo, todas as linhas PODE MEXER
     [J10] A navegação à esquerda ................. a lista de seções e a busca
     [J11] Copiar com um clique ................... e o aviso "copiado"              PODE MEXER
     [J12] A busca de campo ....................... o que casa acende, o resto recua
     [J13] A navegação fixa ao rolar .............. e qual seção está à vista
     [J14] Os cliques e as teclas (o maestro) ..... liga tudo                         CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Nenhuma deficiência declarada'  →  'Sem deficiência'
     Um campo novo caiu em "Outros dados", e não no grupo certo
       → [J2], lista SECOES: acrescente uma palavra do RÓTULO dele no padrão de busca do grupo
         certo. Leia o CUIDADO de [J2].
     Criei uma região nova dentro de "Informações" (uma aba nova)
       → ela já aparece como seção, com ícone padrão. Para dar ícone e grupos, acrescente o
         TÍTULO dela em SECOES ([J2]), igualzinho ao título do APEX.
     Renomeei o título de uma região/aba e ela perdeu os grupos (ou o ícone)
       → os títulos em SECOES ([J2]) precisam ser iguais aos do APEX. Troque lá também.
     Apareceu um grau de parentesco com sigla (ex.: "XX") num cartão de dependente
       → [J2], lista PARENTESCO: acrescente  XX: 'Nome',  no mesmo formato.
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure um erro em vermelho que cite
         Natcorp_Ficha.js. O manual, parte 5, explica o que fazer com a mensagem.

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
     P + 'MATRICULA'        junta os textos: vira 'P17_MATRICULA', o nome do item no APEX.
     textoCampo(…)          lê o que aparece num campo do APEX (veja [J3]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* ═══ [J0] COMEÇO ════════════════════════════════════════════════════════════════════════
     CUIDADO    A linha abaixo impede que o arquivo rode duas vezes (URL repetida na página, por
                exemplo) e que rode fora do APEX. Não apague.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncFicha || !window.apex || !window.apex.jQuery) return;
  window.__ncFicha = true;

  var $ = apex.jQuery;
  /* O começo do nome dos itens desta página. Se a página for copiada para outro número
     (ex.: 117), troque aqui para 'P117_' — e mais nada no arquivo. */
  var P = 'P17_';

  /* ═══ [J1] ÍCONES ════════════════════════════════════════════════════════════════════════
     Os desenhos pequenos da tela (pessoa, documento, prédio…), no formato SVG. Os nomes
     (pessoa, documento…) são usados em SECOES ([J2]) para escolher o ícone de cada seção.
     Não precisa mexer.
     ════════════════════════════════════════════════════════════════════════════════════════ */

  var IC = {
    pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    documento: '<rect x="3" y="5" width="18" height="14" rx="2"/><circle cx="8.5" cy="11" r="2"/><path d="M5.5 16c.6-1.5 1.7-2.3 3-2.3s2.4.8 3 2.3M14 10h4.5M14 13.5h3"/>',
    predio: '<path d="M4 20.5V5.5A1.5 1.5 0 0 1 5.5 4h7A1.5 1.5 0 0 1 14 5.5v15"/><path d="M14 9.5h4.5A1.5 1.5 0 0 1 20 11v9.5M3 20.5h18M7.5 8h3M7.5 11.5h3M7.5 15h3M17 13.5v.01M17 17v.01"/>',
    maleta: '<rect x="3" y="7" width="18" height="13" rx="2"/><path d="M8.5 7V5.5A1.5 1.5 0 0 1 10 4h4a1.5 1.5 0 0 1 1.5 1.5V7M3 12.5h18"/>',
    folha: '<path d="M6 3.5h12v17l-2-1.3-2 1.3-2-1.3-2 1.3-2-1.3-2 1.3z"/><path d="M9 8.5h6M9 12h6M9 15.5h3"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    familia: '<circle cx="8" cy="7.5" r="3"/><circle cx="16.5" cy="9" r="2.5"/><path d="M2.5 19.5a5.5 5.5 0 0 1 11 0M13 19.5a4 4 0 0 1 8 0"/>',
    alerta: '<path d="M12 3.5l9 16H3z"/><path d="M12 10v4M12 17v.01"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4 4"/>',
    ok: '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>',
    olho: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="3"/>',
    olhoFechado: '<path d="M3 3l18 18"/><path d="M10.6 5.6A9.7 9.7 0 0 1 12 5.5C18 5.5 21.5 12 21.5 12a17 17 0 0 1-3.1 3.9M6.1 7.2C3.8 8.9 2.5 12 2.5 12S6 18.5 12 18.5a9 9 0 0 0 4-.9"/><path d="M9.9 9.9a3 3 0 0 0 4.2 4.2"/>',
    seta: '<path d="M9 6l6 6-6 6"/>',
    cracha: '<rect x="4.5" y="3.5" width="15" height="17" rx="2.5"/><circle cx="12" cy="10" r="2.5"/><path d="M8.5 16c.7-1.4 2-2.2 3.5-2.2s2.8.8 3.5 2.2M10 3.5v2h4v-2"/>',
    calendario: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M8 3v4M16 3v4"/>',
    alvo: '<circle cx="12" cy="12" r="8.5"/><circle cx="12" cy="12" r="4"/><circle cx="12" cy="12" r=".6"/>',
    tabela: '<rect x="3.5" y="4.5" width="17" height="15" rx="2"/><path d="M3.5 9.5h17M3.5 14.5h17M9.5 9.5v10"/>'
  };

  /* ═══ [J2] SEÇÕES, GRUPOS E PARENTESCO ═══════════════════════════════════════════════════
     O QUE FAZ  SECOES diz, para cada região de dentro de "Informações" (pelo TÍTULO dela no
                APEX), qual ícone ela ganha e em que GRUPOS os campos dela se dividem.
                  ic       o nome do ícone (um dos nomes de [J1])
                  grupos   [nome do grupo, /palavras do rótulo/i] — o campo vai para o PRIMEIRO
                           grupo cujas palavras aparecem no RÓTULO dele. O que não casar com
                           nenhum vai para "Outros dados".
                  numeros  (só em Cargos / Salários) os campos que viram valores em R$ no alto
                           da seção, com o "olho" para esconder
                  curto    o nome mais curto na navegação à esquerda
                  tipo     'dependentes' / 'ocorrencias': a seção vira cartões / linha do tempo
                PARENTESCO traduz as siglas do grau de parentesco dos dependentes (FO → Filho).
     PODE MEXER • o nome dos grupos ('Identificação', 'Contato'…) — é o que aparece na tela;
                • as palavras dos padrões de busca: separadas por | ("ou"). Para um campo novo
                  cair num grupo, acrescente |palavra (em minúsculas, sem acento ou com [ãa]);
                • PARENTESCO: cada par é  SIGLA: 'Nome',.
     CUIDADO    • O título (ex.: 'Dados Pessoais') tem que ser IGUAL ao título da região no APEX,
                  com maiúsculas e acentos. Região com título que não está aqui ainda aparece,
                  mas com ícone de documento e sem grupos.
                • A ORDEM dos grupos importa: o primeiro que casar vence.
                • Sinais especiais dos padrões: ^ = "começa com"; [ãa] = "ã ou a"; \s* =
                  "espaço opcional"; \. = um ponto de verdade. Só troque se souber.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: título da região no APEX → { ícone, grupos: [nome, /palavras/i], … } */
  /* as seções: título da região no APEX → ícone, nome curto na navegação e os grupos por assunto
     (rótulo → grupo; o primeiro que casar vence; o que não casar vai para "Outros dados") */
  var SECOES = {
    'Dados Pessoais': { ic: 'pessoa', grupos: [
      ['Identificação', /^(sexo|estado civil|data de nascimento|grupo [ée]tnico|nome da m[ãa]e|nome do pai|ra[çc]a)/i],
      ['Nacionalidade', /(nacionalidade|nascimento|estrangeiro|resid[êe]ncia)/i],
      ['Escolaridade', /(instru[çc][ãa]o|forma[çc][ãa]o)/i],
      ['Contato', /(endere[çc]o|e-?mail|telefone|celular)/i],
      ['Deficiência', /(deficien|reabilitad)/i],
      ['Banco', /(banco|modalidade|tipo de conta|ag[êe]ncia|pix)/i]] },
    'Documentos': { ic: 'documento', grupos: [
      ['Conselho regional', /(conselho|n[úu]mero de registro|^regi[ãa]o$)/i],
      ['Identidade e CPF', /(identidade|emiss[ãa]o|cpf|identifica[çc][ãa]o civil|reside)/i],
      ['Trabalho', /(carteira profissional|pis|pasep|ctps)/i],
      ['Eleitor e reservista', /(eleitor|reservista)/i]] },
    'Lotação': { ic: 'predio', grupos: [
      ['Onde trabalha', /(filial|unidade|local|modalidade)/i],
      ['Centro de custo', /(c\.?\s*custo)/i]] },
    'Cargos / Salários': { ic: 'maleta', numeros: /^(sal[áa]rio|total remunera[çc][ãa]o|benef[íi]cios)$/i, grupos: [
      ['Cargo e função', /(cargo|cbo|fun[çc][ãa]o|grupo de trabalho|m[ãa]o de obra|cipa|categoria|grupo salarial|ponto de faixa)/i],
      ['Remuneração', /(sal[áa]rio|benef|aux[íi]lio|remunera|insalubridade|periculosidade)/i]] },
    'Folha': { ic: 'folha' },
    'Horário': { ic: 'relogio' },
    'Dependentes': { ic: 'familia', tipo: 'dependentes' },
    'Ocorrências Disciplinares': { ic: 'alerta', tipo: 'ocorrencias', curto: 'Ocorrências' }
  };
  /* PODE MEXER: sigla do grau de parentesco: 'como aparece no cartão' */
  var PARENTESCO = { FO: 'Filho', FA: 'Filha', EO: 'Esposo', EA: 'Esposa', DO: 'Enteado', DA: 'Enteada', NO: 'Neto', NA: 'Neta',
    IO: 'Irmão', IA: 'Irmã', VO: 'Avô', VA: 'Avó', SO: 'Sogro', SA: 'Sogra', TO: 'Tio', TA: 'Tia', BO: 'Sobrinho', BA: 'Sobrinha',
    PO: 'Primo', PA: 'Prima', CO: 'Companheiro', CA: 'Companheira', PI: 'Pai', MA: 'Mãe', OT: 'Outros', TU: 'Tutelado' };

  /* ═══ [J3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       textoCampo(caixa)  o que a PESSOA VÊ num campo (o nome da opção escolhida numa lista)
       rotulo(caixa)      o rótulo do campo ("Data de Nascimento")
       tituloDe(região)   o título da região
       porClasse('x')     as regiões que têm a classe x no APEX
       bonito('JOAO DA SILVA')  → "Joao da Silva" (maiúsculas viram letra normal)
       brl('1234,56')     → "R$ 1.234,56"
       guardado(…)        lembra uma escolha no navegador da pessoa (o "olho" dos valores)
     QUANDO MEXER  Quase nunca.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function vazio(t) { return !t || /^\s*(-\s*selecione\s*-|-|—|\.\.-|null)\s*$/i.test(t); }
  function codigo(t) { var m = String(t || '').match(/^\s*([\w.]+)\s+-\s+/); return m ? m[1] : ''; }
  function semCodigo(t) { return String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '').trim(); }
  function maiusculas(t) { return t.length > 3 && t === t.toUpperCase() && /[A-ZÀ-Ý]{3}/.test(t); }
  function capitalizar(t) { return String(t || '').toLowerCase().replace(/(^|[\s(/-])(\S)/g, function (m, a, b) { return a + b.toUpperCase(); }); }
  function bonito(t) { t = String(t || '').trim(); if (maiusculas(t)) t = capitalizar(t); return t.replace(/(\s)(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (m, a, w) { return a + w.toLowerCase(); }); }
  function svg(d, cls) { return '<svg class="' + (cls || 'nc-df-ic') + '" viewBox="0 0 24 24" aria-hidden="true">' + d + '</svg>'; }
  function porClasse(cls) { return [].slice.call(document.querySelectorAll('.t-Region.' + cls)); }
  function semAcento(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase(); }
  function escondido(e, ate) { for (; e && e !== ate && e !== document.body; e = e.parentElement) if (e.style && e.style.display === 'none' || e.hidden) return true; return false; }
  function rotulo(c) { var l = c && c.querySelector('.t-Form-label'); if (!l) return ''; var k = l.cloneNode(true); [].forEach.call(k.querySelectorAll('.u-VisuallyHidden'), function (x) { x.remove(); }); return k.textContent.replace(/\s+/g, ' ').trim(); }
  function tituloDe(reg) { var h = reg.querySelector(':scope > .t-Region-header .t-Region-title'); return h ? h.textContent.replace(/\s+/g, ' ').trim() : ''; }
  function corpoDe(reg) { return reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg; }
  function textoCampo(c) {
    var id = c.id.replace(/_CONTAINER$/, '');
    var e = document.getElementById(id);
    var marcado = c.querySelector('input[type="radio"]:checked, input[type="checkbox"]:checked');
    if (marcado) { var l2 = c.querySelector('label[for="' + marcado.id + '"]'); return l2 ? l2.textContent.trim() : marcado.value; }
    if (!e) return '';
    if (e.tagName === 'SELECT') { var o = e.options[e.selectedIndex]; return o && o.value !== '' && !vazio(o.text) ? o.text.trim() : ''; }
    if (e.tagName === 'INPUT' || e.tagName === 'TEXTAREA') return /^(radio|checkbox)$/.test(e.type) || vazio(e.value) ? '' : String(e.value).trim();
    var t = e.textContent.replace(/\s+/g, ' ').trim();
    return vazio(t) ? '' : t;
  }
  function data(t) { var m = String(t || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function anos(d) {
    if (!d) return -1; var h = new Date();
    var n = h.getFullYear() - d.getFullYear(); if (h.getMonth() < d.getMonth() || h.getMonth() === d.getMonth() && h.getDate() < d.getDate()) n--;
    return n;
  }
  function brl(t) {
    var s = String(t || '').trim(); if (!/^-?[\d.]+(,\d+)?$/.test(s)) return s;
    var n = parseFloat(s.replace(/\./g, '').replace(',', '.')); if (!isFinite(n)) return s;
    return 'R$ ' + n.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  }
  function iniciais(nome) { var p = bonito(nome).split(/\s+/).filter(function (w) { return w.length > 2; }); return ((p[0] || '').charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : '')).toUpperCase(); }
  function guardado(k, v) { try { if (v === undefined) return localStorage.getItem(k); localStorage.setItem(k, v); } catch (e) { return null; } return null; }

  /* ═══ [J4] A MONTAGEM ════════════════════════════════════════════════════════════════════
     O QUE FAZ  montar() é chamada uma vez, quando a página abre:
                  1. acha as regiões nc-df-colaborador e nc-df-info (sem elas, para aqui);
                  2. clica na aba "Mostrar Tudo" (para todas as seções existirem na tela) e
                     esconde as abas;
                  3. monta o alto ([J5]);
                  4. cria a coluna da navegação e a das seções, e leva cada região de dentro
                     de "Informações" para a coluna das seções ([J6]);
                  5. monta a navegação ([J10]) e a janela Benefícios ([J9]);
                  6. liga os cliques e as teclas ([J14]).
     CUIDADO    Não mude a ordem: a navegação precisa das seções prontas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var COL, INFO, HERO, NAV, NAVLUGAR, MAIN, BUSCA, AVISO, SECS = [];
  var NOME = '', COD = '', SIT = {}, FOTO = '';
  function montar() {
    COL = porClasse('nc-df-colaborador')[0];
    INFO = porClasse('nc-df-info')[0];
    if (!COL || !INFO) return false;
    document.body.classList.add('nc-df');

    /* as abas: "Mostrar Tudo" (a navegação nova rola até a seção) e fora da vista */
    var tudo = INFO.querySelector('#SHOW_ALL_tab a, .apex-rds-first a');
    if (tudo && !INFO.querySelector('#SHOW_ALL_tab.apex-rds-selected, .apex-rds-first.apex-rds-selected')) tudo.click();
    var rds = INFO.querySelector('.apex-rds-container'); if (rds) rds.classList.add('nc-df-oculto');
    INFO.classList.add('nc-df-com-layout');

    montarHero();

    /* a disposição: navegação à esquerda + as seções */
    var corpo = corpoDe(INFO);
    var layout = el('div', 'nc-df-layout');
    NAVLUGAR = el('aside', 'nc-df-lado');
    NAV = el('nav', 'nc-df-nav'); NAV.setAttribute('aria-label', 'Seções da ficha');
    NAVLUGAR.appendChild(NAV);
    MAIN = el('div', 'nc-df-main');
    layout.appendChild(NAVLUGAR); layout.appendChild(MAIN);
    corpo.insertBefore(layout, corpo.firstChild);

    var regs = [].slice.call(corpo.querySelectorAll('.t-Region')).filter(function (r) {
      return r.parentElement.closest('.t-Region') === INFO && tituloDe(r) && !r.closest('.nc-df-layout');
    });
    regs.forEach(function (r) { MAIN.appendChild(r); montarSecao(r); });
    /* o que sobrou da grade original (colunas que ficaram vazias) sai da vista */
    [].forEach.call(corpo.querySelectorAll(':scope > .container'), function (k) { if (!k.querySelector('.t-Region')) k.classList.add('nc-df-oculto'); });

    montarNav();
    montarBeneficios();
    AVISO = el('div', 'nc-df-aviso'); AVISO.setAttribute('role', 'status'); AVISO.setAttribute('aria-live', 'polite');
    document.body.appendChild(AVISO);
    ligar();
    return true;
  }

  /* ═══ [J5] O ALTO ════════════════════════════════════════════════════════════════════════
     O QUE FAZ  Na região nc-df-colaborador, monta o cartão do alto: faixa da marca com as
                ações (os botões do cabeçalho da região, trazidos para cá), a foto (ou as
                iniciais), o nome, a situação (verde se ativo, vermelho se demitido/desligado),
                o motivo, o nome social e os 6 fatos. Clicar num fato copia o valor.
     LÊ DOS ITENS  P17_MATRICULA, P17_COD_EMPRESA, P17_SITUACAO, P17_DT_ADMISSAO,
                P17_DESCR_MOT_SIT, P17_NOME_SOCIAL, P17_FOTO; e, pelos RÓTULOS dos campos de
                "Informações": "Cargo", "Filial" e "C.Custo".
     PODE MEXER os rótulos dos fatos — o 2º texto em cada  fato('ícone', 'Rótulo', …):
                'Matrícula', 'Empresa', 'Admissão', 'Cargo', 'Filial', 'Centro de custo'.
                E os textos 'desde', 'Nome social:', 'anos de casa'.
     VISUAL     Natcorp_Ficha.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarHero() {
    var v = function (n) { var c = document.getElementById(P + n + '_CONTAINER'); return c ? textoCampo(c) : ''; };
    var mat = v('MATRICULA'), cod = codigo(mat), nome = bonito(semCodigo(mat)) || 'Colaborador';
    var emp = v('COD_EMPRESA'), sit = v('SITUACAO'), adm = v('DT_ADMISSAO'), mot = v('DESCR_MOT_SIT'), social = v('NOME_SOCIAL');
    var foto = COL.querySelector('#' + P + 'FOTO_CONTAINER img');
    var partes = sit.split(/\s+-\s+/);
    var sitNome = bonito(partes[1] || partes[0] || ''), sitData = partes[2] || '';
    var tom = /ativo/i.test(sitNome) && !/inativo/i.test(sitNome) ? 'ok' : /demit|deslig|rescis|inativo|falec/i.test(sitNome) ? 'nao' : 'meio';
    var a = anos(data(adm));
    function porRot(re) { var c = [].slice.call(INFO.querySelectorAll('.t-Form-fieldContainer')).filter(function (k) { return re.test(rotulo(k)); })[0]; return c ? textoCampo(c) : ''; }
    var cargo = bonito(semCodigo(porRot(/^cargo$/i))), filial = bonito(semCodigo(porRot(/^filial$/i))), cc = bonito(semCodigo(porRot(/^c\.?\s*custo$/i)));

    var corpo = corpoDe(COL);
    [].forEach.call(corpo.querySelectorAll(':scope > .container'), function (k) { k.classList.add('nc-df-oculto'); });
    COL.classList.add('nc-df-com-hero');
    HERO = el('section', 'nc-df-hero'); HERO.setAttribute('aria-label', 'Colaborador');
    function fato(ic, rot, val, copia) {
      if (!val) return '';
      return '<div class="nc-df-fato"' + (copia ? ' data-copiar-valor="' + esc(copia) + '" data-copiar-rotulo="' + esc(rot) + '" title="Clique para copiar"' : '') + '>' +
        '<span class="nc-df-fato-ic" aria-hidden="true">' + svg(IC[ic]) + '</span><dl><dt>' + esc(rot) + '</dt><dd>' + val + '</dd></dl></div>';
    }
    HERO.innerHTML =
      '<div class="nc-df-hero-faixa"><div class="nc-df-hero-acoes" data-slot="acoes"></div></div>' +
      '<div class="nc-df-hero-corpo">' +
        '<div class="nc-df-foto">' + (foto && foto.getAttribute('src') ? '<img alt="" src="' + esc(foto.getAttribute('src')) + '">' : '<span>' + esc(iniciais(nome)) + '</span>') + '</div>' +
        '<div class="nc-df-quem">' +
          '<h1 class="nc-df-nome">' + esc(nome) + '</h1>' +
          '<p class="nc-df-linha">' +
            (sitNome ? '<span class="nc-df-sit nc-df-sit--' + tom + '"><i aria-hidden="true"></i>' + esc(sitNome) + (sitData ? '<span> desde ' + esc(sitData) + '</span>' : '') + '</span>' : '') +
            (mot ? '<span class="nc-df-mot">' + esc(bonito(semCodigo(mot).replace(/\)\s*$/, ''))) + '</span>' : '') +
            (social && semAcento(social) !== semAcento(nome.split(' ')[0]) ? '<span class="nc-df-mot">Nome social: <b>' + esc(social) + '</b></span>' : '') +
          '</p>' +
        '</div>' +
      '</div>' +
      '<div class="nc-df-fatos">' +
        fato('cracha', 'Matrícula', esc(cod), cod) +
        fato('predio', 'Empresa', esc(bonito(emp)), emp) +
        fato('calendario', 'Admissão', esc(adm) + (a >= 0 ? '<span class="nc-df-sutil">' + (a === 0 ? 'menos de 1 ano' : a + (a === 1 ? ' ano de casa' : ' anos de casa')) + '</span>' : ''), adm) +
        fato('maleta', 'Cargo', esc(cargo), cargo) +
        fato('predio', 'Filial', esc(filial), filial) +
        fato('alvo', 'Centro de custo', esc(cc), cc) +
      '</div>';
    corpo.insertBefore(HERO, corpo.firstChild);
    /* as ações da região (a ficha do colaborador, Documentos) vão para a faixa */
    var acoes = HERO.querySelector('[data-slot="acoes"]');
    [].forEach.call(COL.querySelectorAll(':scope > .t-Region-header .t-Button'), function (b) { acoes.appendChild(b); });
    NOME = nome; COD = cod; SIT = { nome: sitNome, tom: tom }; FOTO = foto && foto.getAttribute('src');
  }

  /* ═══ [J6] AS SEÇÕES E OS CAMPOS ═════════════════════════════════════════════════════════
     O QUE FAZ  Cada região de "Informações" vira uma seção: ícone e contagem no título
                ("12 informações"), e os campos divididos nos grupos de SECOES ([J2]).
                • Campos vazios vão para "N campos sem informação", fechados.
                • Os 7 "Não" de deficiência viram "Nenhuma deficiência declarada" (com "ver
                  detalhes").
                • Em Cargos/Salários, salário, total e benefícios aparecem em R$ no alto, com
                  o "olho" para esconder (a escolha fica lembrada no navegador).
                • O valor de cada campo é mostrado como TEXTO (quebra linha, dá para ler); o
                  item do APEX continua no lugar, fora da vista.
                • Botões que estavam no meio dos campos vão para o cabeçalho da seção.
     PODE MEXER os textos entre aspas: 'Outros dados', 'campos sem informação',
                'Nenhuma deficiência declarada', 'Esconder valores', 'Mostrar valores'…
     VISUAL     Natcorp_Ficha.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarSecao(reg) {
    var tit = tituloDe(reg), cfg = SECOES[tit] || { ic: 'documento' };
    var id = 'nc-df-sec-' + semAcento(tit).replace(/[^a-z0-9]+/g, '-');
    reg.classList.add('nc-df-sec');
    var cab = reg.querySelector(':scope > .t-Region-header');
    var h = cab && cab.querySelector('.t-Region-title');
    if (h && !h.dataset.nc) { h.dataset.nc = '1'; h.innerHTML = '<span class="nc-df-sec-ic" aria-hidden="true">' + svg(IC[cfg.ic]) + '</span><span class="nc-df-sec-tit">' + esc(tit) + '</span><span class="nc-df-sec-res" data-slot="res"></span>'; }
    var item = { reg: reg, tit: tit, curto: cfg.curto || tit, ic: cfg.ic, id: reg.id || id, conta: 0 };
    if (!reg.id) reg.id = id;
    SECS.push(item);
    if (cfg.tipo === 'dependentes') return montarDependentes(item);
    if (cfg.tipo === 'ocorrencias') return montarOcorrencias(item);
    montarCampos(item, cfg);
  }

  var VALORES = null;
  function montarCampos(item, cfg) {
    var reg = item.reg, corpo = corpoDe(reg);
    var campos = [].slice.call(corpo.querySelectorAll('.t-Form-fieldContainer'));
    var botoes = [].slice.call(corpo.querySelectorAll('.container .t-Button'));
    var caixa = el('div', 'nc-df-campos');
    corpo.insertBefore(caixa, corpo.firstChild);
    var grupos = {}, ordem = [], vazios = [], nums = [];
    (cfg.grupos || []).forEach(function (g) { ordem.push(g[0]); });
    campos.forEach(function (c) {
      c.classList.add('nc-df-campo');
      var r = rotulo(c), t = textoCampo(c);
      if (cfg.numeros && cfg.numeros.test(r) && t) { c.classList.add('nc-df-numero'); nums.push(c); espelhar(c); return; }
      espelhar(c);
      if (!t) { vazios.push(c); return; }
      var g = 'Outros dados';
      (cfg.grupos || []).some(function (x) { if (x[1].test(r)) { g = x[0]; return true; } return false; });
      if (!grupos[g]) { grupos[g] = []; if (ordem.indexOf(g) < 0) ordem.push(g); }
      grupos[g].push(c);
    });
    if (nums.length) {
      var numeros = el('div', 'nc-df-numeros');
      nums.forEach(function (c) { numeros.appendChild(c); });
      var olho = el('button', 'nc-df-olho'); olho.type = 'button';
      numeros.appendChild(olho);
      caixa.appendChild(numeros);
      VALORES = { caixa: numeros, olho: olho };
      mostrarValores(guardado('nc-df-valores') !== 'ocultos');
    }
    var cheios = ordem.filter(function (g) { return grupos[g] && grupos[g].length; });
    cheios.forEach(function (g) {
      var lista = grupos[g];
      var bloco = el('section', 'nc-df-grupo');
      /* 7 "Não" de deficiência dizem uma coisa só */
      var todosNao = /defici/i.test(g) && lista.every(function (c) { return /^n[ãa]o$/i.test(textoCampo(c)); });
      bloco.innerHTML = (cheios.length === 1 && g === 'Outros dados' ? '' : '<h4 class="nc-df-grupo-tit">' + esc(g) + '</h4>') +
        (todosNao ? '<p class="nc-df-resumo">' + svg(IC.ok) + '<span>Nenhuma deficiência declarada</span><button type="button" class="nc-df-link" data-abrir>ver detalhes</button></p>' : '');
      var grade = el('div', 'nc-df-grade' + (todosNao ? ' nc-df-fechado' : ''));
      lista.forEach(function (c) { if (textoCampo(c).length > 34) c.classList.add('nc-df-largo'); grade.appendChild(c); });
      bloco.appendChild(grade);
      caixa.appendChild(bloco);
    });
    if (vazios.length) {
      var v = el('section', 'nc-df-grupo nc-df-vazios');
      v.innerHTML = '<button type="button" class="nc-df-link nc-df-vazios-bt" data-abrir aria-expanded="false">' + svg(IC.seta) + vazios.length + (vazios.length === 1 ? ' campo sem informação' : ' campos sem informação') + '</button>';
      var gv = el('div', 'nc-df-grade nc-df-fechado');
      vazios.forEach(function (c) { gv.appendChild(c); });
      v.appendChild(gv);
      caixa.appendChild(v);
    }
    /* os botões que estavam no meio dos campos (ex.: Benefícios) vão para o cabeçalho da seção */
    if (botoes.length) {
      var hb = reg.querySelector(':scope > .t-Region-header .t-Region-headerItems--buttons') || reg.querySelector(':scope > .t-Region-header');
      botoes.forEach(function (b) { b.classList.add('nc-df-sec-bt'); hb.insertBefore(b, hb.firstChild); });
    }
    [].forEach.call(corpo.querySelectorAll(':scope > .container'), function (k) { k.classList.add('nc-df-oculto'); });
    item.conta = campos.length - vazios.length;
    resumo(item, item.conta + (item.conta === 1 ? ' informação' : ' informações'));
  }
  function mostrarValores(ver) {
    if (!VALORES) return;
    VALORES.caixa.classList.toggle('is-oculto', !ver);
    VALORES.olho.setAttribute('aria-pressed', String(!ver));
    VALORES.olho.innerHTML = svg(ver ? IC.olhoFechado : IC.olho) + '<span>' + (ver ? 'Esconder valores' : 'Mostrar valores') + '</span>';
  }
  function resumo(item, txt) { var s = item.reg.querySelector('[data-slot="res"]'); if (s) s.textContent = txt; }

  /* o valor vira texto (quebra linha; o item do APEX fica no lugar, fora da vista) */
  function espelhar(c) {
    var t = textoCampo(c);
    c.classList.toggle('nc-df-vazio', !t);
    if (t) { c.setAttribute('data-copiar', '1'); c.setAttribute('title', 'Clique para copiar'); } else { c.removeAttribute('data-copiar'); c.removeAttribute('title'); }
    var ic = c.querySelector('.t-Form-inputContainer') || c;
    var sp = ic.querySelector(':scope > .nc-df-valor');
    if (!sp) { sp = el('span', 'nc-df-valor'); ic.appendChild(sp); }
    var mostra = t ? (c.classList.contains('nc-df-numero') ? brl(t) : t) : '—';
    if (sp.textContent !== mostra) sp.textContent = mostra;
    c.classList.add('nc-df-espelho');
  }

  /* ═══ [J7] DEPENDENTES EM CARTÕES ════════════════════════════════════════════════════════
     O QUE FAZ  A seção "Dependentes" (relatório interativo de 56 colunas) vira cartões: nome,
                parentesco, idade, data de baixa, o CPF (clique copia) e selos (IR,
                Salário-família, Plano médico, Vacinação). Clicar no cartão abre o dependente
                (o mesmo link da linha do relatório). "Ver tabela completa" volta à tabela.
     LÊ DAS COLUNAS (pelo TEXTO do cabeçalho da coluna, sem acento):
                Nome Dependente, Grau de Parentesco, Num cpf, Data de Nascimento, Sexo Depend,
                Data Baixa, Incide I.R., Incide Sal. Família, Incide Plano Médico,
                Carteira de Vacinação.
     CUIDADO    Se o cabeçalho de uma dessas colunas mudar no relatório, aquele dado some do
                cartão. Mude também aqui (procure  col(tr, '  logo abaixo).
     PODE MEXER os nomes dos selos (1º texto de cada par: 'IR', 'Salário-família'…) e
                'CPF não informado', 'Nenhum dependente cadastrado.'.
     VISUAL     Natcorp_Ficha.css › [C4] (alternar cartões / tabela, dependentes)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function linhasIR(reg) {
    /* relatório com cabeçalho fixo: o APEX separa a tabela do CABEÇALHO e a do CORPO — lê as duas */
    var tabelas = [].slice.call(reg.querySelectorAll('table.a-IRR-table'));
    var ths = {}, linhas = [];
    tabelas.forEach(function (t) {
      [].forEach.call(t.querySelectorAll('th[id]'), function (th) { var k = semAcento(th.textContent.trim()); if (k && !ths[k]) ths[k] = th.id; });
      [].forEach.call(t.querySelectorAll('tr'), function (tr) { if (tr.querySelector('td[headers]')) linhas.push(tr); });
    });
    return { linhas: linhas, ths: ths };
  }
  var DEPS = null;
  function alternador(reg, caixa, rotTabela, rotCartoes) {
    var corpo = corpoDe(reg);
    var bt = el('button', 'nc-df-link nc-df-tabela-bt'); bt.type = 'button';
    bt.innerHTML = svg(IC.tabela) + '<span>' + rotTabela + '</span>';
    corpo.insertBefore(bt, corpo.firstChild);
    corpo.insertBefore(caixa, bt);
    reg.classList.add('nc-df-em-cartoes');
    bt.addEventListener('click', function () {
      var tabela = reg.classList.toggle('nc-df-em-cartoes') === false;
      bt.querySelector('span').textContent = tabela ? rotCartoes : rotTabela;
    });
  }
  function montarDependentes(item) {
    var caixa = el('div', 'nc-df-deps'); caixa.setAttribute('data-slot', 'cartoes');
    alternador(item.reg, caixa, 'Ver tabela completa', 'Ver em cartões');
    DEPS = item;
    desenharDependentes();
  }
  function desenharDependentes() {
    if (!DEPS) return;
    var reg = DEPS.reg, caixa = reg.querySelector('[data-slot="cartoes"]');
    var ir = linhasIR(reg), ths = ir.ths;
    function col(tr, nome) { var h = ths[semAcento(nome)]; var td = h && tr.querySelector('td[headers="' + h + '"]'); var x = td ? td.textContent.replace(/\s+/g, ' ').trim() : ''; return vazio(x) ? '' : x; }
    var html = ir.linhas.map(function (tr, i) {
      var nome = bonito(col(tr, 'Nome Dependente')), grau = col(tr, 'Grau de Parentesco'), cpf = col(tr, 'Num cpf');
      var nasc = col(tr, 'Data de Nascimento'), idade = anos(data(nasc));
      var sexo = col(tr, 'Sexo Depend'), baixa = col(tr, 'Data Baixa');
      var chips = [['IR', col(tr, 'Incide I.R.')], ['Salário-família', col(tr, 'Incide Sal. Família')], ['Plano médico', col(tr, 'Incide Plano Médico')], ['Vacinação', col(tr, 'Carteira de Vacinação')]]
        .filter(function (x) { return /^s/i.test(x[1]); }).map(function (x) { return '<span class="nc-df-chip">' + esc(x[0]) + '</span>'; }).join('');
      var cpfOk = cpf && /[1-9]/.test(cpf.replace(/-\d{2}$/, ''));
      return '<article class="nc-df-dep' + (baixa ? ' is-baixa' : '') + '" data-i="' + i + '" data-busca="' + esc(semAcento(nome + ' ' + (PARENTESCO[grau] || grau) + ' ' + cpf)) + '" tabindex="0" role="button" aria-label="' + esc('Abrir dados de ' + nome) + '">' +
        '<span class="nc-df-dep-av' + (/^f/i.test(sexo) ? ' is-f' : '') + '" aria-hidden="true">' + esc(iniciais(nome)) + '</span>' +
        '<div class="nc-df-dep-txt"><h4>' + esc(nome) + '</h4><p>' + esc(PARENTESCO[grau] || grau || 'Dependente') + (idade >= 0 && idade < 110 ? ' · ' + idade + (idade === 1 ? ' ano' : ' anos') : '') + (baixa ? ' · <b>baixa em ' + esc(baixa) + '</b>' : '') + '</p>' +
          (cpfOk ? '<button type="button" class="nc-df-dep-cpf" data-copiar-valor="' + esc(cpf) + '" data-copiar-rotulo="CPF de ' + esc(nome.split(' ')[0]) + '" title="Clique para copiar">CPF ' + esc(cpf) + '</button>' : '<span class="nc-df-dep-cpf is-vazio">CPF não informado</span>') +
          (chips ? '<div class="nc-df-chips">' + chips + '</div>' : '') + '</div>' +
        '<span class="nc-df-dep-ir" aria-hidden="true">' + svg(IC.seta) + '</span></article>';
    }).join('');
    var pag = ((reg.querySelector('.a-IRR-pagination, .a-IRR-paginationWrap') || {}).textContent || '').trim();
    if (caixa.getAttribute('data-html') !== html) { caixa.setAttribute('data-html', html); caixa.innerHTML = html || '<p class="nc-df-vazio-msg">Nenhum dependente cadastrado.</p>'; }
    DEPS.conta = ir.linhas.length;
    resumo(DEPS, ir.linhas.length + (ir.linhas.length === 1 ? ' dependente' : ' dependentes') + (/de\s+\d+/i.test(pag) ? ' · ' + pag : ''));
    atualizarNav();
  }

  /* ═══ [J8] OCORRÊNCIAS: A LINHA DO TEMPO ═════════════════════════════════════════════════
     O QUE FAZ  A seção "Ocorrências Disciplinares" vira uma linha do tempo: data, tipo,
                "Concluída em … por …" ou "Em aberto", motivo e selos (Suspenso N dias,
                Advertência verbal/escrita, Entregue, Início, Protocolo — clique copia).
                Suspensão e justa causa ganham destaque ("grave").
     LÊ DAS COLUNAS (pelo nome da coluna no relatório, sem acento): ocorrencia, motivo,
                dt_conclusao, usuario_conclusao, protocolo, suspenso, dias, adv_verbal,
                adv_escrita, concluido, dt_inicio. A data vem da quebra de grupo do relatório.
     CUIDADO    Coluna renomeada no relatório = dado que some da linha do tempo.
     PODE MEXER os textos entre aspas ('Advertência verbal', 'Em aberto',
                'Nenhuma ocorrência disciplinar.'…).
     VISUAL     Natcorp_Ficha.css › [C4] (ocorrências)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarOcorrencias(item) {
    var reg = item.reg;
    var caixa = el('ol', 'nc-df-tempo');
    alternador(reg, caixa, 'Ver tabela completa', 'Ver linha do tempo');
    var itens = [], dataAtual = '';
    [].forEach.call(reg.querySelectorAll('table.t-Report-report tr'), function (tr) {
      var brk = tr.querySelector('td.apex_report_break');
      if (brk) { dataAtual = brk.textContent.trim(); return; }
      var cel = {}; [].forEach.call(tr.querySelectorAll('td[headers]'), function (td) { cel[semAcento(td.getAttribute('headers').replace(/_\d+$/, ''))] = td.textContent.replace(/\s+/g, ' ').trim(); });
      if (!Object.keys(cel).length) return;
      itens.push({ data: dataAtual, c: cel });
    });
    function v(c, k) { var x = c[k]; return x && !vazio(x) ? x : ''; }
    caixa.innerHTML = itens.map(function (o) {
      var c = o.c, tipo = bonito(semCodigo(v(c, 'ocorrencia')));
      var grave = /suspens|justa/i.test(tipo);
      var concl = v(c, 'dt_conclusao'), quem = v(c, 'usuario_conclusao'), prot = v(c, 'protocolo');
      var meta = [];
      if (/^sim$/i.test(v(c, 'suspenso'))) meta.push('Suspenso' + (v(c, 'dias') ? ' ' + v(c, 'dias') + (v(c, 'dias') === '1' ? ' dia' : ' dias') : ''));
      if (/^sim$/i.test(v(c, 'adv_verbal'))) meta.push('Advertência verbal');
      if (/^sim$/i.test(v(c, 'adv_escrita'))) meta.push('Advertência escrita');
      if (/^sim$/i.test(v(c, 'concluido'))) meta.push('Entregue');
      if (v(c, 'dt_inicio')) meta.push('Início ' + v(c, 'dt_inicio'));
      return '<li class="nc-df-oc' + (grave ? ' is-grave' : '') + '" data-busca="' + esc(semAcento(tipo + ' ' + v(c, 'motivo') + ' ' + o.data + ' ' + prot)) + '">' +
        '<span class="nc-df-oc-ponto" aria-hidden="true"></span>' +
        '<time class="nc-df-oc-data">' + esc(o.data) + '</time>' +
        '<div class="nc-df-oc-cartao"><div class="nc-df-oc-cab"><h4>' + esc(tipo || 'Ocorrência') + '</h4>' +
          '<span class="nc-df-oc-st' + (concl ? ' is-ok' : '') + '">' + (concl ? 'Concluída em ' + esc(concl) + (quem ? ' por ' + esc(quem) : '') : 'Em aberto') + '</span></div>' +
          (v(c, 'motivo') ? '<p class="nc-df-oc-motivo">' + esc(bonito(v(c, 'motivo'))) + '</p>' : '') +
          '<div class="nc-df-chips">' + meta.map(function (m) { return '<span class="nc-df-chip">' + esc(m) + '</span>'; }).join('') +
          (prot ? '<button type="button" class="nc-df-chip nc-df-chip--copiar" data-copiar-valor="' + esc(prot) + '" data-copiar-rotulo="Protocolo" title="Clique para copiar">Protocolo ' + esc(prot) + '</button>' : '') + '</div>' +
        '</div></li>';
    }).join('') || '<li class="nc-df-vazio-msg">Nenhuma ocorrência disciplinar.</li>';
    item.conta = itens.length;
    resumo(item, itens.length ? itens.length + (itens.length === 1 ? ' ocorrência' : ' ocorrências') : 'nenhuma');
  }

  /* ═══ [J9] A JANELA "BENEFÍCIOS" ═════════════════════════════════════════════════════════
     O QUE FAZ  Na região nc-df-beneficios (dentro da janela "Benefícios"): aumenta a janela,
                pede ao relatório TODAS as linhas (ele vinha de 15 em 15) e mostra cada
                benefício num cartão, com ícone pelo tipo, por grupo, com filtros por grupo.
                Benefícios com data de fim no passado ficam em "N encerrados", fechados.
                Data de fim em 2090 ou depois conta como "sem fim".
                "Ver relatório original" volta à tabela.
     PODE MEXER • ACENTOS: palavras que o cadastro manda sem acento. Par  palavra: 'com acento',.
                • tipoBeneficio: as palavras que decidem o ÍCONE de cada benefício (saude,
                  dente, talher…). Para um benefício novo ganhar o ícone certo, acrescente
                  |palavra (em minúsculas, sem acento) na linha certa. A ordem importa:
                  a primeira linha que casar vence.
                • os textos entre aspas ('Encerrado', 'benefícios ativos', 'Todos'…).
     CUIDADO    As colunas são lidas pelo COMEÇO do nome: tipo…, valor…, data_in…, data_fim…,
                benef…. As linhas de total são reconhecidas pelo texto ("Benefício total",
                "Índice total", "Total do relatório").
     VISUAL     Natcorp_Ficha.css › [C6]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ICB = {
    saude: '<path d="M20.5 8.8c0 5.2-8.5 11.2-8.5 11.2S3.5 14 3.5 8.8A4.3 4.3 0 0 1 12 6.6a4.3 4.3 0 0 1 8.5 2.2z"/><path d="M6.5 12h3l1.5-2.5 2 4.5 1.5-2h3"/>',
    dente: '<path d="M7.5 3.5c-2.5 0-4 2-4 4.5 0 3 1.5 4 2 7s.8 5.5 2.3 5.5c1.6 0 1.6-5 4.2-5s2.6 5 4.2 5c1.5 0 1.8-2.5 2.3-5.5s2-4 2-7c0-2.5-1.5-4.5-4-4.5-1.8 0-2.7 1-4.5 1s-2.7-1-4.5-1z"/>',
    talher: '<path d="M7 3v7.5M4.5 3v5a2.5 2.5 0 0 0 5 0V3M7 10.5V21"/><path d="M17 21V3c-2.2 1-3.5 3.5-3.5 7v3.5H17"/>',
    cesta: '<path d="M3 10h18l-1.8 9a1.5 1.5 0 0 1-1.5 1.2H6.3a1.5 1.5 0 0 1-1.5-1.2z"/><path d="M8 10l3-6M16 10l-3-6M9 14v3M12 14v3M15 14v3"/>',
    onibus: '<rect x="4.5" y="3.5" width="15" height="15" rx="2.5"/><path d="M4.5 11h15M8 18.5v2M16 18.5v2M8 15h.01M16 15h.01M8 7h8"/>',
    carro: '<path d="M4 16.5V12l2-5a2 2 0 0 1 1.9-1.3h8.2A2 2 0 0 1 18 7l2 5v4.5"/><rect x="3" y="12" width="18" height="5" rx="1.5"/><path d="M6 17v2.5M18 17v2.5M7 14.5h.01M17 14.5h.01"/>',
    halter: '<path d="M6.5 7v10M17.5 7v10M3.5 9.5v5M20.5 9.5v5M6.5 12h11"/>',
    cofrinho: '<path d="M4.5 11.5c0-3.3 3.1-6 7-6 1.4 0 2.8.4 3.9 1l2.6-1v3c.9.8 1.5 1.8 1.8 3H21v3h-1.3c-.5 1.4-1.6 2.6-3 3.3V20h-3v-1.5a8 8 0 0 1-2.6 0V20h-3v-2.1c-2.2-1.1-3.6-3.2-3.6-6.4z"/><path d="M15.5 10.5h.01M9.5 8.5h3"/>',
    escudo: '<path d="M12 3l7.5 3v5.5c0 4.6-3.2 8.2-7.5 9.5-4.3-1.3-7.5-4.9-7.5-9.5V6z"/><path d="M9 12l2 2 4-4"/>',
    capelo: '<path d="M2.5 9L12 4.5 21.5 9 12 13.5z"/><path d="M6.5 11v4.5c1.5 1.3 3.5 2 5.5 2s4-.7 5.5-2V11M21.5 9v5"/>',
    megafone: '<path d="M3.5 10v4a1 1 0 0 0 1 1H7l7 4V5L7 9H4.5a1 1 0 0 0-1 1z"/><path d="M17.5 9a4 4 0 0 1 0 6M7.5 15l1 5h2.5l-1-5"/>',
    presente: '<rect x="3.5" y="8" width="17" height="4" rx="1"/><path d="M5 12v7.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V12M12 8v12.5M12 8S10.5 3.5 8 4.5 9 8 12 8zM12 8s1.5-4.5 4-3.5S15 8 12 8z"/>'
  };
  /* o tipo do benefício pelo nome (e pelo grupo): serve para os que o relatório ainda não mostrou */
  function tipoBeneficio(txt) {
    var s = semAcento(txt);
    if (/odonto|dent/.test(s)) return 'dente';
    if (/saude|medic|unimed|hosp|amil|bradesco saude|sulamerica|hapvida|vitallis|medisantas|clinic/.test(s)) return 'saude';
    if (/cesta/.test(s)) return 'cesta';
    if (/refei|restaur|ticket|aliment|va|vr|sodexo|alelo|pluxee|vale.?refe/.test(s)) return 'talher';
    if (/transporte|vt|onibus|bhbus|rodovi|metro|passe|mobilidade|serrana/.test(s)) return 'onibus';
    if (/carro|veicul|combust|frota|estaciona/.test(s)) return 'carro';
    if (/academia|gym|wellhub|gympass|totalpass|fitness/.test(s)) return 'halter';
    if (/previd|aposent|pgbl|vgbl/.test(s)) return 'cofrinho';
    if (/seguro/.test(s)) return 'escudo';
    if (/creche|escola|educa|bolsa|curso|faculdade|idioma/.test(s)) return 'capelo';
    if (/campanha|premio|bonus/.test(s)) return 'megafone';
    return 'presente';
  }
  /* PODE MEXER: palavra sem acento (em minúsculas): 'como deve aparecer' */
  /* só na tela: as palavras mais comuns do cadastro vêm sem acento ("Plano Medico", "Locacao") */
  var ACENTOS = { beneficio: 'benefício', beneficios: 'benefícios', medico: 'médico', medica: 'médica', odontologico: 'odontológico',
    previdencia: 'previdência', alimentacao: 'alimentação', refeicao: 'refeição', locacao: 'locação', veiculo: 'veículo',
    basica: 'básica', rodoviario: 'rodoviário', saude: 'saúde', odontologica: 'odontológica', familia: 'família', vitalicio: 'vitalício' };
  function acentuar(t) {
    return String(t || '').replace(/[A-Za-zÀ-ÿ]+/g, function (w) {
      var a = ACENTOS[w.toLowerCase()]; if (!a) return w;
      return w.charAt(0) === w.charAt(0).toUpperCase() ? a.charAt(0).toUpperCase() + a.slice(1) : a;
    });
  }
  function dataFim(t) {
    var d = data(t); if (!d) return { tipo: 'aberto' };
    if (d.getFullYear() >= 2090) return { tipo: 'aberto' };                 /* 2094, 2099: "sem data de fim" */
    return d < new Date() ? { tipo: 'passado', txt: t } : { tipo: 'futuro', txt: t };
  }
  var BN = null;
  function montarBeneficios() {
    var reg = porClasse('nc-df-beneficios')[0];
    if (!reg) return;
    var corpo = corpoDe(reg);
    var caixa = el('div', 'nc-df-bn'); caixa.setAttribute('aria-live', 'polite');
    caixa.innerHTML = '<p class="nc-df-bn-carregando">Carregando os benefícios…</p>';
    corpo.insertBefore(caixa, corpo.firstChild);
    var bt = el('button', 'nc-df-link nc-df-bn-tabela'); bt.type = 'button';
    bt.innerHTML = svg(IC.tabela) + '<span>Ver relatório original</span>';
    corpo.appendChild(bt);
    reg.classList.add('nc-df-em-cartoes');
    bt.addEventListener('click', function () {
      var tabela = reg.classList.toggle('nc-df-em-cartoes') === false;
      bt.querySelector('span').textContent = tabela ? 'Ver em cartões' : 'Ver relatório original';
    });
    BN = { reg: reg, caixa: caixa, filtro: 'todos', todas: false };
    caixa.addEventListener('click', function (e) {
      var f = e.target.closest('[data-filtro]');
      if (f) { BN.filtro = f.getAttribute('data-filtro'); desenharBeneficios(); return; }
      var enc = e.target.closest('[data-encerrados]');
      if (enc) { var g = enc.closest('.nc-df-bn-grupo'); g.classList.toggle('is-enc-aberto'); enc.setAttribute('aria-expanded', String(g.classList.contains('is-enc-aberto'))); }
    });
    /* a janela maior, e todas as linhas de uma vez (o relatório vem de 15 em 15) */
    var dlg = reg.closest('.ui-dialog-content, .t-DialogRegion');
    if (dlg) $(dlg).on('dialogopen', function () {
      try { $(dlg).dialog('option', { width: Math.min(1000, window.innerWidth - 24), height: Math.min(780, window.innerHeight - 40), position: { my: 'center', at: 'center', of: window } }); } catch (x) { /* ok */ }
      carregarTodas();
    });
    $(reg).on('apexafterrefresh', function () { setTimeout(desenharBeneficios, 20); });
    desenharBeneficios();
    if (dlg && $(dlg).is(':visible')) carregarTodas();
  }
  function carregarTodas() {
    if (!BN || BN.todas) return;
    var sel = BN.reg.querySelector('select[onchange*="paginate"]');
    var m = sel && sel.getAttribute('onchange').match(/paginate\('(\d+)',\s*'([^']+)'/);
    BN.todas = true;
    if (m && apex.widget && apex.widget.report && apex.widget.report.paginate) apex.widget.report.paginate(m[1], m[2], { min: 1, max: 1000, fetched: 15 });
  }
  function lerBeneficios() {
    var grupos = [], g = null, b = null, total = '';
    [].forEach.call(BN.reg.querySelectorAll('table.t-Report-report tr'), function (tr) {
      var brk = tr.querySelector('td.apex_report_break');
      if (brk) { g = { nome: acentuar(bonito(brk.textContent.trim())), itens: [], total: '' }; grupos.push(g); b = null; return; }
      var cel = {};
      [].forEach.call(tr.querySelectorAll('td[headers]'), function (td) {
        var h = semAcento(td.getAttribute('headers')).replace(/_\d+$/, '');
        var k = /^tipo/.test(h) ? 'tipo' : /^valor/.test(h) ? 'valor' : /^data_in/.test(h) ? 'ini' : /^data_fim/.test(h) ? 'fim' : /^benef/.test(h) ? 'nome' : h;
        cel[k] = td.textContent.replace(/\u00a0/g, ' ').replace(/\s+/g, ' ').trim();
      });
      if (!Object.keys(cel).length) return;
      var nome = cel.nome || '';
      if (/^benef[íi]cio total/i.test(nome)) { if (b) b.total = cel.valor; return; }
      if (/^[íi]ndice total/i.test(nome)) { if (g) g.total = cel.valor; return; }
      if (/^total do relat/i.test(nome)) { total = cel.valor; return; }
      if (!g) { g = { nome: 'Benefícios', itens: [], total: '' }; grupos.push(g); }
      if (nome) { b = { nome: nome, linhas: [], total: '' }; g.itens.push(b); }
      if (b) b.linhas.push({ tipo: vazio(cel.tipo) ? '' : cel.tipo, valor: vazio(cel.valor) ? '' : cel.valor, ini: vazio(cel.ini) ? '' : cel.ini, fim: vazio(cel.fim) ? '' : cel.fim });
    });
    grupos.forEach(function (gr) { gr.itens.forEach(function (it) {
      it.ativo = it.linhas.some(function (l) { return dataFim(l.fim).tipo !== 'passado'; });
      var mapa = {}, ordem = [];
      it.linhas.forEach(function (l) { var k = l.tipo + '|' + l.valor + '|' + l.fim; if (!mapa[k]) { mapa[k] = { tipo: l.tipo, valor: l.valor, fim: l.fim, n: 0 }; ordem.push(k); } mapa[k].n++; });
      it.grupos = ordem.map(function (k) { return mapa[k]; });
      it.desde = it.linhas.map(function (l) { return l.ini; }).filter(Boolean).sort(function (a, c) { return data(a) - data(c); })[0] || '';
      var fins = it.linhas.map(function (l) { return dataFim(l.fim); });
      it.fim = it.ativo ? (fins.filter(function (f) { return f.tipo === 'futuro'; })[0] || null) : fins.filter(function (f) { return f.tipo === 'passado'; }).sort(function (a, c) { return data(c.txt) - data(a.txt); })[0];
      it.ic = tipoBeneficio(it.nome + ' ' + it.linhas.map(function (l) { return l.tipo; }).join(' ') + ' ' + gr.nome);
    }); });
    return { grupos: grupos, total: total };
  }
  function cartaoBeneficio(it) {
    var linhas = it.grupos.map(function (x) {
      return '<li><span class="nc-df-bn-l-tipo" title="' + esc(x.tipo) + '">' + esc(acentuar(bonito(semCodigo(x.tipo))) || 'Sem tipo') + '</span>' +
        (x.n > 1 ? '<em class="nc-df-bn-l-n" title="' + x.n + ' lançamentos iguais">' + x.n + '×</em>' : '') +
        '<b class="nc-df-bn-l-valor">' + (x.valor ? esc(x.valor.replace(/^R\$\s*/, 'R$ ')) : '—') + '</b></li>';
    }).join('');
    var datas = [it.desde ? 'Desde ' + esc(it.desde) : '', it.fim && it.fim.tipo === 'futuro' ? 'até ' + esc(it.fim.txt) : ''].filter(Boolean).join(' · ');
    var total = it.total && !vazio(it.total) ? it.total.replace(/^R\$\s*/, 'R$ ') : '';
    return '<article class="nc-df-bn-card' + (it.ativo ? '' : ' is-encerrado') + '">' +
      '<span class="nc-df-bn-ic nc-df-bn-ic--' + it.ic + '" aria-hidden="true">' + svg(ICB[it.ic]) + '</span>' +
      '<div class="nc-df-bn-txt"><div class="nc-df-bn-cab"><h4>' + esc(acentuar(bonito(semCodigo(it.nome)))) + '</h4>' +
        (it.ativo ? '' : '<span class="nc-df-bn-fim">Encerrado' + (it.fim ? ' em ' + esc(it.fim.txt) : '') + '</span>') + '</div>' +
        '<ul class="nc-df-bn-linhas">' + linhas + '</ul>' +
        (datas ? '<p class="nc-df-bn-datas">' + datas + '</p>' : '') + '</div>' +
      '<div class="nc-df-bn-total">' + (total ? '<b>' + esc(total) + '</b><span>' + (it.linhas.length > 1 ? 'total de ' + it.linhas.length + ' lançamentos' : 'valor') + '</span>' : '<span class="nc-df-bn-semvalor">sem valor</span>') + '</div>' +
    '</article>';
  }
  function desenharBeneficios() {
    if (!BN) return;
    var d = lerBeneficios();
    if (!d.grupos.length) { BN.caixa.innerHTML = '<p class="nc-df-vazio-msg">Nenhum benefício cadastrado.</p>'; return; }
    var todos = [], ativos = 0;
    d.grupos.forEach(function (g) { g.itens.forEach(function (it) { todos.push(it); if (it.ativo) ativos++; }); });
    var enc = todos.length - ativos;
    if (BN.filtro !== 'todos' && !d.grupos[+BN.filtro]) BN.filtro = 'todos';
    var html =
      '<div class="nc-df-bn-topo"><div class="nc-df-bn-resumo"><b>' + ativos + '</b> ' + (ativos === 1 ? 'benefício ativo' : 'benefícios ativos') + (enc ? '<span> · ' + enc + (enc === 1 ? ' encerrado' : ' encerrados') + '</span>' : '') + '</div>' +
        (d.total ? '<div class="nc-df-bn-soma"><span>Total do relatório</span><b>' + esc(d.total.replace(/^R\$\s*/, 'R$ ')) + '</b></div>' : '') + '</div>' +
      (d.grupos.length > 1 ? '<div class="nc-df-bn-filtros" role="group" aria-label="Filtrar por grupo">' +
        '<button type="button" data-filtro="todos" aria-pressed="' + (BN.filtro === 'todos') + '">Todos <em>' + todos.length + '</em></button>' +
        d.grupos.map(function (g, i) { return '<button type="button" data-filtro="' + i + '" aria-pressed="' + (BN.filtro === String(i)) + '">' + svg(ICB[tipoBeneficio(g.nome + ' ' + g.itens.map(function (x) { return x.nome; }).join(' '))]) + esc(g.nome) + ' <em>' + g.itens.length + '</em></button>'; }).join('') + '</div>' : '') +
      d.grupos.map(function (g, i) {
        if (BN.filtro !== 'todos' && BN.filtro !== String(i)) return '';
        var at = g.itens.filter(function (x) { return x.ativo; }), en = g.itens.filter(function (x) { return !x.ativo; });
        return '<section class="nc-df-bn-grupo"><header class="nc-df-bn-g-cab"><h3>' + esc(g.nome) + '</h3>' + (g.total ? '<span>' + esc(g.total.replace(/^R\$\s*/, 'R$ ')) + '</span>' : '') + '</header>' +
          (at.length ? '<div class="nc-df-bn-lista">' + at.map(cartaoBeneficio).join('') + '</div>' : '<p class="nc-df-bn-nenhum">Nenhum benefício ativo neste grupo.</p>') +
          (en.length ? '<button type="button" class="nc-df-link nc-df-bn-enc-bt" data-encerrados aria-expanded="false">' + svg(IC.seta) + en.length + (en.length === 1 ? ' encerrado' : ' encerrados') + '</button><div class="nc-df-bn-lista nc-df-bn-encerrados">' + en.map(cartaoBeneficio).join('') + '</div>' : '') +
        '</section>';
      }).join('');
    /* preserva o que estava aberto */
    var abertos = [].map.call(BN.caixa.querySelectorAll('.nc-df-bn-grupo.is-enc-aberto h3'), function (h) { return h.textContent; });
    BN.caixa.innerHTML = html;
    [].forEach.call(BN.caixa.querySelectorAll('.nc-df-bn-grupo'), function (s) { if (abertos.indexOf(s.querySelector('h3').textContent) >= 0) { s.classList.add('is-enc-aberto'); var b = s.querySelector('[data-encerrados]'); if (b) b.setAttribute('aria-expanded', 'true'); } });
  }

  /* ═══ [J10] A NAVEGAÇÃO À ESQUERDA ═══════════════════════════════════════════════════════
     O QUE FAZ  Monta a coluna da esquerda: a mini-ficha (foto, nome, matrícula, situação), a
                caixa "Buscar campo…" (atalho: tecla /) e a lista de seções com a contagem de
                cada uma. Clicar numa seção rola até ela.
     PODE MEXER 'Buscar campo…'.
     VISUAL     Natcorp_Ficha.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarNav() {
    NAV.innerHTML =
      '<div class="nc-df-mini" aria-hidden="true"><span class="nc-df-mini-foto">' + (FOTO ? '<img alt="" src="' + esc(FOTO) + '">' : esc(iniciais(NOME))) + '</span>' +
        '<span class="nc-df-mini-txt"><b>' + esc(NOME) + '</b><span class="nc-df-mini--' + (SIT.tom || 'meio') + '">' + esc([COD, SIT.nome].filter(Boolean).join(' · ')) + '</span></span></div>' +
      '<label class="nc-df-busca">' + svg(IC.busca) + '<span class="u-VisuallyHidden">Buscar campo</span>' +
        '<input type="search" id="nc-df-busca" autocomplete="off" spellcheck="false" placeholder="Buscar campo…" aria-describedby="nc-df-busca-conta"><kbd aria-hidden="true">/</kbd></label>' +
      '<p class="nc-df-busca-conta" id="nc-df-busca-conta" aria-live="polite"></p>' +
      '<ul class="nc-df-nav-lista">' + SECS.map(function (s) {
        return '<li><a href="#' + esc(s.id) + '" data-alvo="' + esc(s.id) + '">' + svg(IC[s.ic]) + '<span>' + esc(s.curto) + '</span><em data-conta></em></a></li>';
      }).join('') + '</ul>';
    BUSCA = NAV.querySelector('input');
    atualizarNav();
  }
  function atualizarNav() {
    if (!NAV) return;
    SECS.forEach(function (s) { var a = NAV.querySelector('[data-alvo="' + s.id + '"] [data-conta]'); if (a) a.textContent = s.conta ? s.conta : ''; });
  }
  function irPara(id) {
    var r = document.getElementById(id); if (!r) return;
    window.scrollTo({ top: r.getBoundingClientRect().top + window.pageYOffset - topo() - 16, behavior: 'smooth' });
  }

  /* ═══ [J11] COPIAR COM UM CLIQUE ═════════════════════════════════════════════════════════
     O QUE FAZ  Clicar num campo, num fato do alto, num CPF ou num protocolo copia o valor e
                mostra um aviso por 1,7 segundo ("Matrícula copiado: 12345").
     PODE MEXER 'copiado', 'Copiado', 'Não deu para copiar'.
     VISUAL     Natcorp_Ficha.css › [C4] (o aviso de "copiado")
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var tAviso = 0;
  function avisar(txt) { AVISO.innerHTML = svg(IC.ok) + esc(txt); AVISO.classList.add('is-on'); clearTimeout(tAviso); tAviso = setTimeout(function () { AVISO.classList.remove('is-on'); }, 1700); }
  function copiar(valor, nomeCampo) {
    function ok() { avisar((nomeCampo ? nomeCampo + ' copiado' : 'Copiado') + ': ' + (valor.length > 40 ? valor.slice(0, 40) + '…' : valor)); }
    function antigo() {
      var t = el('textarea'); t.value = valor; t.setAttribute('readonly', ''); t.style.position = 'fixed'; t.style.opacity = '0';
      document.body.appendChild(t); t.select();
      try { document.execCommand('copy'); ok(); } catch (e) { avisar('Não deu para copiar'); }
      t.remove();
    }
    if (navigator.clipboard && window.isSecureContext) navigator.clipboard.writeText(valor).then(ok, antigo); else antigo();
  }

  /* ═══ [J12] A BUSCA DE CAMPO ═════════════════════════════════════════════════════════════
     O QUE FAZ  Enquanto a pessoa digita em "Buscar campo…", os campos, dependentes e
                ocorrências que contêm o texto (no rótulo ou no valor, sem ligar para acento)
                acendem, e o resto fica apagado. Enter vai ao próximo; Esc limpa.
                Um campo achado dentro de um grupo fechado faz o grupo abrir.
     PODE MEXER 'resultado', 'resultados', 'Enter vai ao próximo', 'Nada encontrado'.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ACHADOS = [], POS = -1;
  function buscar() {
    var q = semAcento(BUSCA.value.trim());
    var alvos = [].slice.call(MAIN.querySelectorAll('.nc-df-campo, .nc-df-dep, .nc-df-oc'));
    alvos.forEach(function (c) { c.classList.remove('nc-df-achou', 'nc-df-apagado', 'nc-df-atual'); });
    MAIN.classList.toggle('nc-df-buscando', !!q);
    ACHADOS = []; POS = -1;
    var conta = document.getElementById('nc-df-busca-conta');
    if (!q) { conta.textContent = ''; return; }
    alvos.forEach(function (c) {
      var hay = c.hasAttribute('data-busca') ? c.getAttribute('data-busca') : semAcento(rotulo(c) + ' ' + textoCampo(c));
      var hit = hay.indexOf(q) >= 0;
      c.classList.add(hit ? 'nc-df-achou' : 'nc-df-apagado');
      if (hit) { ACHADOS.push(c); var g = c.closest('.nc-df-fechado'); if (g) abrir(g); }
    });
    conta.textContent = ACHADOS.length ? ACHADOS.length + (ACHADOS.length === 1 ? ' resultado' : ' resultados') + ' · Enter vai ao próximo' : 'Nada encontrado';
  }
  function irProximo() {
    if (!ACHADOS.length) return;
    if (POS >= 0 && ACHADOS[POS]) ACHADOS[POS].classList.remove('nc-df-atual');
    POS = (POS + 1) % ACHADOS.length;
    var c = ACHADOS[POS]; c.classList.add('nc-df-atual');
    window.scrollTo({ top: c.getBoundingClientRect().top + window.pageYOffset - window.innerHeight / 2 + 40, behavior: 'smooth' });
  }
  function abrir(grade) {
    grade.classList.remove('nc-df-fechado');
    var bloco = grade.closest('.nc-df-grupo');
    var bt = bloco && bloco.querySelector('[data-abrir]');
    if (bt) { bt.setAttribute('aria-expanded', 'true'); if (bt.classList.contains('nc-df-vazios-bt')) bt.classList.add('is-aberto'); else bt.hidden = true; }
  }

  /* ═══ [J13] A NAVEGAÇÃO FIXA AO ROLAR ════════════════════════════════════════════════════
     O QUE FAZ  Em telas largas (1100px ou mais), a navegação fica presa ao rolar a página e
                marca a seção que está à vista. Isto é feito aqui, no JS, porque o recurso
                normal do CSS para isso ("sticky") não funciona nesta página: o tema do APEX
                põe "overflow" nos blocos de fora, e o sticky deixa de grudar.
     CUIDADO    topo() mede a barra do alto do APEX para a navegação não ficar debaixo dela.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function topo() {
    var b = 0;
    [document.querySelector('.t-Body-title'), document.querySelector('.t-Header')].forEach(function (x) { if (x && getComputedStyle(x).position === 'fixed') b = Math.max(b, x.getBoundingClientRect().bottom); });
    return Math.max(0, Math.round(b));
  }
  var LARGA = window.matchMedia ? window.matchMedia('(min-width: 1100px)') : { matches: true };
  function aoRolar() {
    var t = topo();
    var r = NAVLUGAR.getBoundingClientRect(), fim = MAIN.getBoundingClientRect().bottom, h = NAV.offsetHeight;
    var fixa = LARGA.matches && r.top < t + 16;
    var desce = fixa ? Math.min(0, fim - (t + 16 + h)) : 0;
    NAV.classList.toggle('is-fixa', fixa);
    NAV.style.top = fixa ? (t + 16 + desce) + 'px' : '';
    NAV.style.left = fixa ? r.left + 'px' : '';
    NAV.style.width = fixa ? r.width + 'px' : '';
    NAV.classList.toggle('is-colada', HERO.getBoundingClientRect().bottom < t);
    var atual = SECS[0];
    SECS.forEach(function (s) { if (!escondido(s.reg) && s.reg.getBoundingClientRect().top <= t + 90) atual = s; });
    if (window.innerHeight + window.pageYOffset >= document.documentElement.scrollHeight - 4) atual = SECS[SECS.length - 1];
    [].forEach.call(NAV.querySelectorAll('[data-alvo]'), function (a) {
      var on = !!atual && a.getAttribute('data-alvo') === atual.id;
      a.classList.toggle('is-atual', on);
      if (on) a.setAttribute('aria-current', 'true'); else a.removeAttribute('aria-current');
    });
  }

  /* ═══ [J14] OS CLIQUES E AS TECLAS (O MAESTRO) ═══════════════════════════════════════════
     O QUE FAZ  ligar() é chamada uma vez, no fim da montagem. Ela escuta:
                • os cliques: abrir grupos fechados, o "olho", a navegação, copiar, abrir um
                  dependente;
                • as teclas: "/" leva à busca; Enter/Espaço num cartão de dependente o abre;
                • a rolagem e o tamanho da janela (para a navegação fixa);
                • o relatório de dependentes recarregado (filtro, página): os cartões são
                  refeitos.
     CUIDADO    A ordem dos testes dentro do clique importa: o primeiro que reconhecer o clique
                encerra (return). Clique em link, botão ou relatório nunca copia.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function abrirDependente(card) {
    var tr = DEPS && linhasIR(DEPS.reg).linhas[+card.getAttribute('data-i')];
    var a = tr && tr.querySelector('td a[href]');
    if (a) a.click();
  }
  function ligar() {
    document.addEventListener('click', function (e) {
      var ab = e.target.closest('[data-abrir]');
      if (ab) {
        var bloco = ab.closest('.nc-df-grupo'); var g = bloco && bloco.querySelector('.nc-df-grade');
        if (g && g.classList.contains('nc-df-fechado')) abrir(g);
        else if (g && ab.classList.contains('nc-df-vazios-bt')) { g.classList.add('nc-df-fechado'); ab.classList.remove('is-aberto'); ab.setAttribute('aria-expanded', 'false'); }
        return;
      }
      if (e.target.closest('.nc-df-olho')) { var ver = VALORES.caixa.classList.contains('is-oculto'); mostrarValores(ver); guardado('nc-df-valores', ver ? 'visiveis' : 'ocultos'); return; }
      var nav = e.target.closest('.nc-df-nav [data-alvo]');
      if (nav) { e.preventDefault(); irPara(nav.getAttribute('data-alvo')); return; }
      var f = e.target.closest('[data-copiar-valor]');
      if (f) { e.preventDefault(); e.stopPropagation(); copiar(f.getAttribute('data-copiar-valor'), f.getAttribute('data-copiar-rotulo')); return; }
      var dep = e.target.closest('.nc-df-dep');
      if (dep) { abrirDependente(dep); return; }
      if (e.target.closest('a, button, .t-Button, label.apex-item-option, .a-IRR, .t-Report')) return;
      if (String(window.getSelection && window.getSelection()) !== '') return;
      var c = e.target.closest('.nc-df-main .nc-df-campo[data-copiar]');
      if (c) copiar(textoCampo(c), rotulo(c));
    });
    document.addEventListener('keydown', function (e) {
      var dep = e.target.closest && e.target.closest('.nc-df-dep');
      if (dep && (e.key === 'Enter' || e.key === ' ') && e.target === dep) { e.preventDefault(); abrirDependente(dep); return; }
      if (e.key !== '/' || e.ctrlKey || e.metaKey || e.altKey) return;
      var a = document.activeElement;
      if (a && (/^(INPUT|TEXTAREA|SELECT)$/.test(a.tagName) || a.isContentEditable)) return;
      e.preventDefault(); BUSCA.focus(); BUSCA.select();
    });
    BUSCA.addEventListener('input', buscar);
    BUSCA.addEventListener('keydown', function (e) {
      if (e.key === 'Enter') { e.preventDefault(); irProximo(); }
      if (e.key === 'Escape') { BUSCA.value = ''; buscar(); BUSCA.blur(); }
    });
    var agendado = false;
    function agendar() { if (agendado) return; agendado = true; requestAnimationFrame(function () { agendado = false; aoRolar(); }); }
    window.addEventListener('scroll', agendar, { passive: true });
    window.addEventListener('resize', agendar);
    aoRolar();
    /* o relatório de dependentes recarregado (filtro, página): os cartões são refeitos */
    $(document).on('apexafterrefresh', function () { setTimeout(desenharDependentes, 30); });
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(montar); });
  else $(montar);
})();
