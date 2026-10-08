/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CHAMADA DE PACIENTES  —  o painel da TV (JavaScript)                          ║
   ║  App 2936 (Medicina Ocupacional - Chamada de Pacientes) · Página 1 ("Painel")            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: CHAMADA-MANUTENCAO.md.

   ── ONDE ELA FICA ─────────────────────────────────────────────────────────────────────────
   Num monitor grande na parede da sala de espera. Quem olha está sentado a alguns metros,
   esperando ouvir/ver a própria senha. Por isso: números enormes, contraste alto, nada que
   precise de clique, e o SOM + a VOZ fazem metade do trabalho (quem não está olhando ouve).

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
     • O PAINEL: as duas filas lado a lado — Cadastro (guichê) e Atendimento médico (local) —
       cada uma com a senha chamada agora (grande) e as anteriores; relógio no alto;
     • A CHAMADA: senha nova toma a tela por alguns segundos (senha gigante + para onde ir),
       com um som de sino moderno (sintetizado, sem arquivo) e a senha FALADA pela voz do
       computador ("Senha 0 4 0 0 0 1. Guichê 2."). Depois a senha fica marcada no painel;
     • AO VIVO, SEM RECARREGAR: lê as chamadas a cada 4 s pelo processo NC_CHAMADA_ESTADO
       (Ajax Callback, mesma regra das regiões e das ações antigas: anuncia e marca como
       anunciada). Assim o som, ligado uma vez, continua ligado o dia todo;
     • DE RESERVA (sem o processo): lê as regiões antigas a cada carga da página (a página
       continua recarregando sozinha, como sempre) e anuncia pela senha dos itens P1_SENHA_*;
     • CLARO POR PADRÃO (pedido de 04/10); o escuro é uma opção dos Ajustes desta TV;
     • AJUSTES (ao mexer o mouse): som, voz, tema escuro, volume, testar chamada, tela cheia.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não mostra nome de paciente (a página nunca mostrou: só senha). Não grava nada além do que
     a página já gravava (marcar a chamada como anunciada, no processo).

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 1 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Chamada.js
     Página 1 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Chamada.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [CH0] Antes de tudo: a marca e o bipe antigo desligado            CUIDADO
     [CH1] Ajustes (filas, textos, tempos)                             PODE MEXER
     [CH2] Ferramentas e ícones
     [CH3] O som (sino sintetizado) e a voz
     [CH4] Ler as chamadas: ao vivo (processo) ou da página (reserva)
     [CH5] O painel
     [CH6] A chamada em tela cheia (fila de anúncios)
     [CH7] Relógio, ajustes na tela, "ligar o som"
     [CH8] O maestro
*/
(function () {
  'use strict';

  /* ═══ [CH0] ANTES DE TUDO ════════════════════════════════════════════════════════════════
     Este arquivo carrega no <head>, ANTES do JavaScript da página. A marca __ncChamada faz o
     código antigo (recarregar a cada 10 s / 5 min e as ações que tocam o bipe e marcam a
     chamada) ficar parado — a exportação da página põe essa condição nele. E o "Play" antigo
     (dois bipes de onda pura) vira mudo: quem toca agora é o [CH3].
     CUIDADO  Sem a exportação aplicada, o código antigo roda como sempre (é o modo reserva).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncChamadaCarregado) return;
  window.__ncChamadaCarregado = true;
  window.__ncChamada = true;
  try { Object.defineProperty(window, 'Play', { configurable: true, get: function () { return function () {}; }, set: function () {} }); } catch (e) { /* ok */ }

  /* ═══ [CH1] AJUSTES ══════════════════════════════════════════════════════════════════════
     PODE MEXER  os nomes das filas e do lugar ("Guichê", "Local" — dá para pôr "Consultório"),
                 os tempos e o texto do rodapé.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FILAS = [
    { chave: 'cadastro', status: 'C', regiao: 'CADASTRO', item: 'P1_SENHA_CAD', nome: 'Cadastro', lugar: 'Guichê', icone: 'prancheta' },
    { chave: 'medico', status: 'M', regiao: 'MEDICO', item: 'P1_SENHA_MED', nome: 'Atendimento médico', lugar: 'Local', icone: 'medico' }
  ];
  var CFG = {
    titulo: 'Chamada de pacientes',
    rodape: 'Quando a sua senha aparecer, dirija-se ao local indicado.',
    agoraSeg: 300,          /* até 5 min a senha fica como "chamando agora" (como a página antiga) */
    anteriores: 4,          /* quantas anteriores por fila */
    intervalo: 4000,        /* ao vivo: de quanto em quanto tempo lê as chamadas (ms) */
    telaCheiaMs: 9000,      /* quanto tempo a chamada fica na tela cheia (no mínimo) */
    destaqueMs: 30000,      /* depois, quanto tempo a senha fica marcada no painel */
    repetirVoz: true        /* fala a senha duas vezes, como nos aeroportos */
  };

  /* ═══ [CH2] FERRAMENTAS E ÍCONES ═════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function txt(e) { return e ? e.textContent.replace(/\s+/g, ' ').trim() : ''; }
  function valor(id) { try { return (window.apex && apex.item(id).getValue()) || ''; } catch (e) { var x = document.getElementById(id); return x ? x.value : ''; } }
  var IC = {
    prancheta: '<rect x="5" y="4.5" width="14" height="16" rx="2.2"/><path d="M9 3.5h6v2.5H9zM9 11h6M9 14.5h6M9 18h3.5"/>',
    medico: '<path d="M6 3.5v5a4 4 0 0 0 8 0v-5"/><path d="M10 12.5v2.5a4.5 4.5 0 0 0 9 0v-2"/><circle cx="19" cy="11" r="2"/>',
    seta: '<path d="M4.5 12h14M13 6.5l5.5 5.5-5.5 5.5"/>',
    som: '<path d="M4.5 9.5h3.2L12 5.8v12.4l-4.3-3.7H4.5z"/><path d="M15.5 9a4 4 0 0 1 0 6M18 6.5a7.5 7.5 0 0 1 0 11"/>',
    mudo: '<path d="M4.5 9.5h3.2L12 5.8v12.4l-4.3-3.7H4.5z"/><path d="M16 9.5l5 5M21 9.5l-5 5"/>',
    ajustes: '<circle cx="12" cy="12" r="3"/><path d="M12 2.8v2.4M12 18.8v2.4M2.8 12h2.4M18.8 12h2.4M5.5 5.5l1.7 1.7M16.8 16.8l1.7 1.7M5.5 18.5l1.7-1.7M16.8 7.2l1.7-1.7"/>',
    tela: '<path d="M4 9V4h5M15 4h5v5M20 15v5h-5M9 20H4v-5"/>',
    wifi: '<path d="M3 9.5a13 13 0 0 1 18 0M6.5 13a8 8 0 0 1 11 0M10 16.5a3 3 0 0 1 4 0"/><path d="M4 4l16 16"/>'
  };
  function ic(n, cls) { return '<svg class="nc-ch-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  function guardar(k, v) { try { localStorage.setItem('nc-chamada-' + k, JSON.stringify(v)); } catch (e) { /* ok */ } }
  function lembrar(k, padrao) { try { var v = localStorage.getItem('nc-chamada-' + k); return v === null ? padrao : JSON.parse(v); } catch (e) { return padrao; } }
  var PREF = { som: lembrar('som', true), voz: lembrar('voz', true), volume: lembrar('volume', 0.8), escuro: lembrar('escuro', false) };   /* claro por padrão */

  /* ═══ [CH3] O SOM E A VOZ ════════════════════════════════════════════════════════════════
     O sino: três notas subindo (mi, sol#, si — um acorde maior, que soa como "atenção, é com
     você" sem assustar), cada uma com o som fundamental e dois harmônicos que somem devagar,
     e um eco curto que dá corpo. Tudo sintetizado: não depende de arquivo de áudio.
     A voz: a do próprio computador da TV (português do Brasil, se houver). A senha é falada
     dígito a dígito ("0 4 0 0 0 1"), que é como se lê num papel.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var CTX = null, SAIDA = null;
  function audio() {
    if (CTX) return CTX;
    var A = window.AudioContext || window.webkitAudioContext; if (!A) return null;
    CTX = new A();
    SAIDA = CTX.createGain(); SAIDA.gain.value = PREF.volume;
    /* eco curto: atraso + realimentação, abafado (soa como uma sala, não como um bipe) */
    var atraso = CTX.createDelay(1), volta = CTX.createGain(), filtro = CTX.createBiquadFilter();
    atraso.delayTime.value = 0.16; volta.gain.value = 0.28; filtro.type = 'lowpass'; filtro.frequency.value = 2800;
    SAIDA.connect(CTX.destination); SAIDA.connect(atraso); atraso.connect(filtro); filtro.connect(volta); volta.connect(atraso); filtro.connect(CTX.destination);
    return CTX;
  }
  function somLigado() { var c = audio(); return !!c && c.state === 'running'; }
  function nota(f, t0, forca) {
    var c = CTX, g = c.createGain();
    g.gain.setValueAtTime(0.0001, t0);
    g.gain.exponentialRampToValueAtTime(0.32 * forca, t0 + 0.012);
    g.gain.exponentialRampToValueAtTime(0.0001, t0 + 1.9);
    g.connect(SAIDA);
    [[1, 'sine', 1], [2, 'sine', 0.22], [3.01, 'triangle', 0.06]].forEach(function (h) {
      var o = c.createOscillator(), gh = c.createGain();
      o.type = h[1]; o.frequency.value = f * h[0]; gh.gain.value = h[2];
      o.connect(gh); gh.connect(g); o.start(t0); o.stop(t0 + 2);
    });
  }
  function sino() {
    if (!PREF.som) return 0;
    var c = audio(); if (!c || c.state !== 'running') return 0;
    var t = c.currentTime + 0.05;
    nota(659.25, t, 1); nota(830.61, t + 0.17, 0.9); nota(987.77, t + 0.34, 1);
    return 1900;   /* ms até a voz entrar */
  }
  var VOZ = window.speechSynthesis || null, VOZ_PT = null;
  /* a voz: português do Brasil, das NATURAIS primeiro (Google, Microsoft, Luciana do Mac…); as vozes
     de brincadeira que alguns sistemas trazem (Eddy, Vovó, Rocko…) nunca são escolhidas */
  var BOAS = /google portugu|microsoft (maria|francisca|thalita|antonio|daniel)|luciana|felipe|fernanda|joana|catarina/i;
  var BRINCADEIRA = /eddy|flo\b|grandma|grandpa|reed|rocko|sandy|shelley|bad news|bahh|bells|boing|bubbles|cellos|good news|jester|organ|superstar|trinoids|whisper|wobble|zarvox|albert|fred|junior|kathy|ralph/i;
  function acharVoz() {
    if (!VOZ) return;
    var v = VOZ.getVoices().filter(function (x) { return /^pt/i.test(x.lang) && !BRINCADEIRA.test(x.name); });
    var nota = function (x) { return (BOAS.test(x.name) ? 4 : 0) + (/^pt(-|_)br/i.test(x.lang) ? 2 : 0) + (x.localService ? 0 : 1); };
    v.sort(function (a, b) { return nota(b) - nota(a); });
    VOZ_PT = v[0] || null;
  }
  if (VOZ) { acharVoz(); VOZ.onvoiceschanged = acharVoz; }
  function falavel(senha) {
    var s = String(senha || '').trim();
    /* "040001" → "0 4 0 0 0 1"; "A123" → "A, 1 2 3" */
    return s.replace(/([A-Za-z]+)(\d)/, '$1, $2').replace(/\d/g, function (d) { return d + ' '; }).trim();
  }
  function falar(f, ch) {
    return new Promise(function (ok) {
      if (!PREF.voz || !VOZ) { ok(); return; }
      var frase = 'Senha ' + falavel(ch.senha) + '. ' + (ch.local ? f.lugar + ' ' + ch.local + '.' : f.nome + '.');
      var vezes = CFG.repetirVoz ? 2 : 1, n = 0;
      var uma = function () {
        var u = new SpeechSynthesisUtterance(frase);
        u.lang = 'pt-BR'; u.rate = 0.9; u.volume = Math.min(1, PREF.volume + 0.15); if (VOZ_PT) u.voice = VOZ_PT;
        u.onend = u.onerror = function () { if (++n < vezes) setTimeout(uma, 900); else ok(); };
        VOZ.speak(u);
      };
      VOZ.cancel(); uma();
      setTimeout(ok, 15000);   /* garantia: sem voz no aparelho, não trava a fila */
    });
  }

  /* ═══ [CH4] LER AS CHAMADAS ══════════════════════════════════════════════════════════════
     Cada fila vira { atual, anteriores[], novas[] } (senha, local, hora).
     AO VIVO: NC_CHAMADA_ESTADO devolve { cadastro: { novas, ultimas }, medico: {…}, agora }
              — "novas" são as chamadas ainda não anunciadas (o processo já as marca como
              anunciadas, como fazia a ação antiga); "ultimas" as da última hora, com os
              segundos desde a chamada (seg).
     RESERVA: as regiões da página (CADASTRO, MEDICO e as duas HISTORICO, na ordem) e os
              itens P1_SENHA_CAD / P1_SENHA_MED (senha chamada que ainda não tocou).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function doProcesso(r) {
    return FILAS.map(function (f) {
      var q = r[f.chave] || {}, ult = q.ultimas || [];
      var atual = ult[0] && +ult[0].seg <= CFG.agoraSeg ? ult[0] : null;
      return { atual: atual, anteriores: ult.slice(atual ? 1 : 0, (atual ? 1 : 0) + CFG.anteriores), novas: q.novas || [] };
    });
  }
  function daPagina() {
    var hist = document.querySelectorAll('[id="HISTORICO"]');
    return FILAS.map(function (f, k) {
      var r = document.getElementById(f.regiao);
      var s = r && r.querySelector('.senha, .senha_chamando'), l = r && r.querySelector('.local, .local_chamando');
      var atual = s ? { senha: txt(s), local: txt(l), hora: '' } : null;
      var lista = [], h = hist[k];
      if (h) [].forEach.call(h.querySelectorAll('.hist_senha, .hist_local'), function (x) {
        if (x.classList.contains('hist_senha')) lista.push({ senha: txt(x), local: '' });
        else if (lista.length) lista[lista.length - 1].local = txt(x);
      });
      if (atual && lista[0] && lista[0].senha === atual.senha) lista.shift();
      var nova = valor(f.item);
      return { atual: atual, anteriores: lista.slice(0, CFG.anteriores), novas: nova ? [{ senha: nova, local: atual && atual.senha === nova ? atual.local : '' }] : [] };
    });
  }

  /* ═══ [CH5] O PAINEL ═════════════════════════════════════════════════════════════════════ */
  var RAIZ, PAINEIS = [], ULT = [], DESTAQUE = {};
  function htmlFila(f, d) {
    var a = d.atual, novo = a && DESTAQUE[f.chave] === a.senha;
    var agora = a
      ? '<div class="nc-ch-agora' + (novo ? ' is-novo' : '') + '"><p class="nc-ch-rot">Chamando agora</p>' +
          '<p class="nc-ch-senha" aria-label="Senha ' + esc(a.senha) + '">' + esc(a.senha) + '</p>' +
          (a.local ? '<p class="nc-ch-local">' + ic('seta') + '<span>' + esc(f.lugar) + ' <b>' + esc(a.local) + '</b></span></p>' : '') + '</div>'
      : '<div class="nc-ch-agora is-vazio"><p class="nc-ch-espera">Aguarde a sua senha</p><p class="nc-ch-espera-sub">Ela aparece aqui quando for a sua vez.</p></div>';
    var ant = d.anteriores.length
      ? '<ol class="nc-ch-lista">' + d.anteriores.map(function (x) {
          return '<li><span class="nc-ch-lista-senha">' + esc(x.senha) + '</span><span class="nc-ch-lista-local">' + (x.local ? esc(f.lugar) + ' <b>' + esc(x.local) + '</b>' : '') + '</span>' +
            (x.hora ? '<span class="nc-ch-lista-hora">' + esc(x.hora) + '</span>' : '') + '</li>';
        }).join('') + '</ol>'
      : '<p class="nc-ch-lista-vazia">Nenhuma chamada na última hora.</p>';
    return '<header class="nc-ch-fila-cab">' + ic(f.icone) + '<h2>' + esc(f.nome) + '</h2></header>' + agora +
      '<section class="nc-ch-ant" aria-label="Chamadas anteriores de ' + esc(f.nome) + '"><h3>Anteriores</h3>' + ant + '</section>';
  }
  function desenhar(dados) {
    dados.forEach(function (d, k) {
      var chave = JSON.stringify([d.atual, d.anteriores, DESTAQUE[FILAS[k].chave] || '']);
      if (ULT[k] === chave) return;   /* nada mudou: não redesenha (sem piscar) */
      ULT[k] = chave; PAINEIS[k].innerHTML = htmlFila(FILAS[k], d);
    });
  }

  /* ═══ [CH6] A CHAMADA EM TELA CHEIA ══════════════════════════════════════════════════════
     As novas entram numa fila e são anunciadas uma de cada vez: tela cheia (a cor da marca
     abre do centro), o sino, a voz (duas vezes) — no mínimo telaCheiaMs. Depois a senha fica
     marcada no painel por destaqueMs.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FILA_ANUNCIOS = [], ANUNCIANDO = false, TELA;
  function anunciar(f, ch) { FILA_ANUNCIOS.push({ f: f, ch: ch }); proximo(); }
  function proximo() {
    if (ANUNCIANDO || !FILA_ANUNCIOS.length) return;
    ANUNCIANDO = true;
    var a = FILA_ANUNCIOS.shift(), f = a.f, ch = a.ch;
    TELA.innerHTML = '<div class="nc-ch-chamada-in"><p class="nc-ch-chamada-fila">' + ic(f.icone) + esc(f.nome) + '</p>' +
      '<p class="nc-ch-chamada-rot">Senha</p><p class="nc-ch-chamada-senha">' + esc(ch.senha) + '</p>' +
      (ch.local ? '<p class="nc-ch-chamada-local">' + ic('seta') + '<span>' + esc(f.lugar) + ' <b>' + esc(ch.local) + '</b></span></p>' : '') + '</div>';
    TELA.setAttribute('aria-hidden', 'false');
    TELA.classList.remove('is-saindo'); void TELA.offsetWidth; TELA.classList.add('is-aberta');
    var inicio = Date.now();
    var espera = sino();
    setTimeout(function () {
      falar(f, ch).then(function () {
        var resta = Math.max(0, CFG.telaCheiaMs - (Date.now() - inicio));
        setTimeout(function () {
          TELA.classList.add('is-saindo');
          DESTAQUE[f.chave] = ch.senha; ULT = []; if (MODELO) desenhar(MODELO);
          setTimeout(function () { if (DESTAQUE[f.chave] === ch.senha) { delete DESTAQUE[f.chave]; ULT = []; if (MODELO) desenhar(MODELO); } }, CFG.destaqueMs);
          setTimeout(function () { TELA.classList.remove('is-aberta', 'is-saindo'); TELA.setAttribute('aria-hidden', 'true'); ANUNCIANDO = false; proximo(); }, 650);
        }, resta);
      });
    }, espera || 300);
  }

  /* ═══ [CH7] RELÓGIO, AJUSTES NA TELA, "LIGAR O SOM" ══════════════════════════════════════
     O navegador só deixa tocar som depois de alguém clicar na página (regra dos navegadores).
     Enquanto o som não estiver liberado, uma faixa no pé pede um clique; liberado uma vez, fica
     (ao vivo a página não recarrega). Os ajustes aparecem ao mexer o mouse e somem sozinhos.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  var DIAS = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'];
  function relogio() {
    var d = new Date(), h = RAIZ.querySelector('.nc-ch-hora'), dt = RAIZ.querySelector('.nc-ch-data');
    if (h) h.textContent = ('0' + d.getHours()).slice(-2) + ':' + ('0' + d.getMinutes()).slice(-2);
    if (dt) dt.textContent = DIAS[d.getDay()] + ', ' + d.getDate() + ' de ' + MESES[d.getMonth()];
  }
  function faixaSom() {
    var b = RAIZ.querySelector('.nc-ch-ligar');
    var precisa = (PREF.som || PREF.voz) && !somLigado();
    b.hidden = !precisa;
    var st = RAIZ.querySelector('[data-estado-som]');
    if (st) st.innerHTML = PREF.som && somLigado() ? ic('som') : ic('mudo');
  }
  function liberarSom() {
    var c = audio(); if (c && c.state !== 'running') c.resume().then(faixaSom, faixaSom);
    if (VOZ) { try { var u = new SpeechSynthesisUtterance(' '); u.volume = 0; VOZ.speak(u); } catch (e) { /* ok */ } }
    setTimeout(faixaSom, 300);
  }
  var OCIO = null;
  function mexeu() {
    RAIZ.classList.add('is-mexendo');
    clearTimeout(OCIO); OCIO = setTimeout(function () { RAIZ.classList.remove('is-mexendo'); RAIZ.querySelector('.nc-ch-ajustes').hidden = true; }, 5000);
  }
  function montarAjustes() {
    var p = RAIZ.querySelector('.nc-ch-ajustes');
    p.innerHTML = '<h2>Ajustes desta TV</h2>' +
      '<label><input type="checkbox" data-pref="som"' + (PREF.som ? ' checked' : '') + '> Som de chamada</label>' +
      '<label><input type="checkbox" data-pref="voz"' + (PREF.voz ? ' checked' : '') + '> Falar a senha</label>' +
      '<label><input type="checkbox" data-pref="escuro"' + (PREF.escuro ? ' checked' : '') + '> Tema escuro</label>' +
      '<label class="nc-ch-vol">Volume <input type="range" min="0.1" max="1" step="0.05" value="' + PREF.volume + '" data-pref="volume"></label>' +
      '<div class="nc-ch-ajustes-bt"><button type="button" data-testar>Testar chamada</button><button type="button" data-tela>' + ic('tela') + 'Tela cheia</button></div>';
  }

  /* ═══ [CH8] O MAESTRO ════════════════════════════════════════════════════════════════════ */
  var MODELO = null, VISTAS = {}, FALHAS = 0, AO_VIVO = false;
  function receber(dados, primeira) {
    MODELO = dados;
    desenhar(dados);
    /* as novas das DUAS filas, na ordem em que foram chamadas (a mais antiga primeiro: seg maior) */
    var todas = [];
    dados.forEach(function (d, k) { d.novas.forEach(function (ch, i) { todas.push({ f: FILAS[k], ch: ch, seg: ch.seg == null ? -i : +ch.seg }); }); });
    todas.sort(function (a, b) { return b.seg - a.seg; });
    todas.forEach(function (x) {
      var id = x.f.chave + '|' + x.ch.senha + '|' + (x.ch.hora || '');
      if (VISTAS[id]) return; VISTAS[id] = 1;
      anunciar(x.f, x.ch);
    });
    RAIZ.classList.toggle('is-offline', false);
  }
  function lerAoVivo(primeira) {
    apex.server.process('NC_CHAMADA_ESTADO', {}, { dataType: 'json' })
      .done(function (r) {
        if (!r || !r.cadastro) { if (primeira) reserva(); return; }
        AO_VIVO = true; FALHAS = 0;
        receber(doProcesso(r), primeira);
        setTimeout(lerAoVivo, CFG.intervalo);
      })
      .fail(function () {
        if (primeira) { reserva(); return; }
        FALHAS++;
        RAIZ.classList.toggle('is-offline', FALHAS >= 3);
        if (FALHAS >= 30) { location.reload(); return; }   /* ~2 min sem resposta: recarrega */
        setTimeout(lerAoVivo, CFG.intervalo);
      });
  }
  /* reserva: a página antiga recarrega sozinha; a cada carga lê o que ela desenhou */
  function reserva() {
    AO_VIVO = false;
    /* a página recarrega a cada 10 s: a chamada precisa caber nesse tempo (voz uma vez só) */
    CFG.repetirVoz = false; CFG.telaCheiaMs = 7000;
    receber(daPagina(), true);
  }
  function montar() {
    RAIZ = el('div', 'nc-ch' + (PREF.escuro ? ' is-escuro' : ''));
    RAIZ.setAttribute('role', 'main');
    RAIZ.innerHTML =
      '<header class="nc-ch-topo"><span class="nc-ch-logo" role="img" aria-label="Natcorp"></span><h1>' + esc(CFG.titulo) + '</h1>' +
        '<div class="nc-ch-relogio"><span class="nc-ch-hora"></span><span class="nc-ch-data"></span></div></header>' +
      '<div class="nc-ch-filas">' + FILAS.map(function (f) { return '<section class="nc-ch-fila" data-fila="' + f.chave + '" aria-label="' + esc(f.nome) + '"></section>'; }).join('') + '</div>' +
      '<footer class="nc-ch-pe"><p>' + esc(CFG.rodape) + '</p><span class="nc-ch-pe-status"><span class="nc-ch-sem-rede">' + ic('wifi') + 'Sem conexão, tentando de novo…</span><span data-estado-som></span>' +
        '<button type="button" class="nc-ch-bt-ajustes" data-ajustes aria-label="Ajustes">' + ic('ajustes') + '</button></span></footer>' +
      '<div class="nc-ch-ajustes" hidden></div>' +
      '<button type="button" class="nc-ch-ligar" hidden>' + ic('som') + 'Clique em qualquer lugar da tela para ligar o som das chamadas</button>' +
      '<div class="nc-ch-chamada" role="alert" aria-live="assertive" aria-hidden="true"></div>';
    document.body.appendChild(RAIZ);
    document.body.classList.add('nc-ch-ativo');
    PAINEIS = [].slice.call(RAIZ.querySelectorAll('.nc-ch-fila'));
    TELA = RAIZ.querySelector('.nc-ch-chamada');
    montarAjustes();
    relogio(); setInterval(relogio, 1000);
    /* qualquer clique ou tecla libera o som; os botões dos ajustes fazem o resto */
    document.addEventListener('pointerdown', liberarSom, true);
    document.addEventListener('keydown', liberarSom, true);
    document.addEventListener('mousemove', mexeu);
    RAIZ.addEventListener('click', function (ev) {
      var b = ev.target.closest('button');
      if (!b) return;
      if (b.hasAttribute('data-ajustes')) { var p = RAIZ.querySelector('.nc-ch-ajustes'); p.hidden = !p.hidden; mexeu(); return; }
      if (b.hasAttribute('data-testar')) { anunciar(FILAS[0], { senha: '000000', local: '1' }); return; }
      if (b.hasAttribute('data-tela')) { var d = document.documentElement; if (!document.fullscreenElement && d.requestFullscreen) d.requestFullscreen(); else if (document.exitFullscreen) document.exitFullscreen(); return; }
    });
    RAIZ.addEventListener('change', function (ev) {
      var k = ev.target.getAttribute('data-pref'); if (!k) return;
      PREF[k] = ev.target.type === 'checkbox' ? ev.target.checked : +ev.target.value;
      guardar(k, PREF[k]);
      if (k === 'volume' && SAIDA) SAIDA.gain.value = PREF.volume;
      if (k === 'escuro') RAIZ.classList.toggle('is-escuro', PREF.escuro);
      faixaSom();
    });
    audio(); faixaSom(); setInterval(faixaSom, 3000);
    lerAoVivo(true);
  }
  var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(function () { try { montar(); } catch (e) { if (window.console) console.warn('[Natcorp chamada]', e); } }, 0); };
  if (document.readyState === 'complete') vai();
  else { if (window.apex && apex.gPageContext$) apex.jQuery(apex.gPageContext$).one('apexreadyend', vai); window.addEventListener('load', vai); }
})();
