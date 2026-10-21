// Monta <build>/documento.html e <build>/capas.html a partir de <doc>/conteudo.md.
// Chamado por toolkit/gerar.mjs; não rode direto.
//
// Marcadores de componente aceitos no Markdown (detalhe em referencia/marcadores.md):
//   ::: capitulo N | Título | Subtítulo        (linha única; abre página nova; 0 = capa + "Como ler")
//   ::: cards ... :::                           (cada "### Título" + parágrafo vira um cartão; "### 1. X" vira "Camada 01")
//   ::: voce-sabia ... :::                      (caixa "Você sabia?")
//   ::: passos ... :::                          (lista numerada com trilho)
//   ::: destaque ... :::                        (painel roxo: '#### título', subtítulo, '### colunas', '> rodapé')
//   ::: confirmar ... :::                       (caixa âmbar "A confirmar pela Natcorp" com linhas para preencher)
//   ::: figura nome | legenda                   (linha única; nome = SVG gerado por figuras/)
// Tabelas: "✓ Atende", "ℹ Informado pela Natcorp" e "⚠ A confirmar pela Natcorp" viram selos; "[preencher: x]" vira campo.
// Parágrafo só com **negrito** vira título de tabela.
import { readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { Marked } from 'marked';
import { C, ico } from './lib.mjs';

export default function montar({ doc, build, config }) {
const fonte = join(doc, 'conteudo.md');
const design = build;
const AJUSTES = { figuras: {}, quebras: [], trocas: [], ...(config.ajustes || {}) };

// ---------------------------------------------------------------- utilidades
const esc = (s) => String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
const dois = (n) => String(n).padStart(2, '0');

// aspas tipográficas e selos, aplicados só aos trechos de texto (fora das tags)
function poliTexto(html) {
  return html.split(/(<[^>]+>)/).map((seg) => {
    if (seg.startsWith('<')) return seg;
    return seg
      .replace(/&quot;/g, '"')
      .replace(/(^|[\s(\[{>«])"/g, '$1“')
      .replace(/"/g, '”');
  }).join('');
}
function selos(html) {
  return html
    .replace(/[“"]?✓ Atende[”"]?/g, '<span class="pill pill--ok">Atende</span>')
    .replace(/(<td>)ℹ Informado pela Natcorp(<\/td>)/g, '$1<span class="pill pill--info">Informado<br>pela Natcorp</span>$2')
    .replace(/[“"]?ℹ Informado pela Natcorp[”"]?/g, '<span class="pill pill--info">Informado pela Natcorp</span>')
    .replace(/(<td>)⚠ A confirmar pela Natcorp(<\/td>)/g, '$1<span class="pill pill--confirmar">A confirmar<br>pela Natcorp</span>$2')
    .replace(/[“"]?⚠ A confirmar pela Natcorp[”"]?/g, '<span class="pill pill--confirmar">A confirmar pela Natcorp</span>')
    .replace(/\[preencher:\s*([^\]]+)\]\.?\s*/g, (_, d) => `<span class="preencher"><span class="preencher__dica">${d.trim()}</span></span>`);
}
const acabamento = (html) => selos(poliTexto(html));

// ícones dos cartões, por palavra-chave do título (ordem importa)
const REGRAS_ICONE = [
  ...(config.icones || []).map(([re, nome]) => [new RegExp(re, 'i'), nome]),
  [/você sabia/i, 'lampada'], [/âmbar|confirmar/i, 'ampulheta'], [/selos?/i, 'ok'],
  [/coletor/i, 'celular'], [/dois jeitos/i, 'tablet'], [/grava primeiro|nenhuma marcação sem dono/i, 'cofre'],
  [/painel|regras/i, 'ajuste'], [/camadas oracle|servidor em/i, 'servidor'], [/parceiros/i, 'escudo'],
  [/^aparelho$|aparelho conhecido/i, 'tablet'], [/internet segura/i, 'cadeado'], [/api da empresa/i, 'tomada'],
  [/oracle database/i, 'banco'], [/sistema natcorp/i, 'painel'],
  [/azure face|rosto/i, 'rosto'], [/entra id|login|credenciais|token/i, 'chave'], [/firebase/i, 'sino'],
  [/volta ao início/i, 'relogio'], [/publicidade/i, 'escudo'], [/não vai no envio/i, 'envelope'],
  [/nunca sai/i, 'celular'], [/área privada/i, 'cadeado'], [/criptografada/i, 'cadeado'], [/envio resiliente/i, 'sincronia'],
  [/confiança/i, 'ajuste'], [/dúvida/i, 'lupa'], [/totem sem/i, 'alerta'], [/administração/i, 'pessoa'],
  [/comprovante/i, 'doc'], [/espelho/i, 'grafico'], [/ajuste/i, 'ajuste'],
];
const ICONE_EXTRA = {
  semrede: '<path d="M2 8.8a15 15 0 0 1 20 0M5 12.6a10 10 0 0 1 14 0M8.5 16.3a5 5 0 0 1 7 0"/><path d="M12 20h.01"/><path d="M3 3l18 18"/>',
  lampada: '<path d="M9 18h6M10 21h4"/><path d="M12 3a6 6 0 0 0-3.6 10.8c.7.6 1.1 1.4 1.1 2.2h5c0-.8.4-1.6 1.1-2.2A6 6 0 0 0 12 3z"/>',
};
function iconeCartao(titulo) {
  const achou = REGRAS_ICONE.find(([re]) => re.test(titulo));
  const nome = achou ? achou[1] : 'ok';
  const g = ICONE_EXTRA[nome]
    ? `<g fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round">${ICONE_EXTRA[nome]}</g>`
    : ico(nome, 0, 0, 24, 'currentColor', 1.9);
  return `<div class="card__icone"><svg viewBox="0 0 24 24" aria-hidden="true">${g}</svg></div>`;
}

// ---------------------------------------------------------------- Markdown
const larguras = {
  'Aspecto|App pessoal|Totem compartilhado': [22, 39, 39],
  'Situação|O que o aplicativo faz|O que o registro informa': [33, 37, 30],
  'Estado|Ícone|Texto da tela|O que significa|O que fazer': [19, 15, 26, 21, 19],
  'Regra|O que controla|Efeito para o colaborador': [22, 36, 42],
  'Dado|De onde vem|Para que serve|Para onde vai': [21, 22, 23, 34],
  'Serviço|Empresa|O que recebe|Para quê|Quando': [16, 12, 30, 20, 22],
  'Onde|O que guarda|Para quê|Por quanto tempo': [17, 43, 21, 19],
  'Tipo|O que é|Condição de validade|Dispositivo': [20, 26, 31, 23],
  '#|O que a norma pede (dispositivo)|Como o NatPonto apoia|Status': [6, 38, 41, 15],
  '#|O que a lei pede (dispositivo)|Como o NatPonto apoia|Status': [6, 38, 41, 15],
  'Dado|Finalidade|Base legal sugerida|Observação': [21, 20, 28, 31],
  'Tema|Empresa cliente (empregadora e controladora)|Natcorp (desenvolvedora e operadora)|Base': [15, 33, 31, 21],
  'Tema|O que a Natcorp informa|Onde aparece|Situação': [17, 45, 14, 24],
  'Tema|Padrão Natcorp': [34, 66],
  'Etapa|Regra da política': [22, 78],
  'Classificação|Exemplos|Controles mínimos': [18, 40, 42],
  'Categoria|O que é registrado|Para quê': [19, 47, 34],
  'Métrica|Padrão da política': [36, 64],
  'Severidade|Exemplos|Tratamento padrão': [14, 44, 42],
  'Situação|Prazo padrão': [58, 42],
  'Tema|Empresa cliente (controladora)|Natcorp (operadora)': [18, 41, 41],
  'Serviço|Empresa|Finalidade|Quando é usado': [22, 16, 38, 24],
  'Tema|Natcorp|Empresa cliente': [16, 42, 42],
  'Papel|Responsabilidades': [26, 74],
  'Pergunta|Resposta|Capítulo': [36, 52, 12],
  'Família de APIs|Para que serve': [30, 70],
  'Credencial|O que é|Como é protegida': [17, 43, 40],
};
Object.assign(larguras, config.larguras || {});
const ESTADOS = { Enviando: 'enviando', Recebido: 'recebido', Registrado: 'registrado', 'Precisa de atenção': 'atencao' };

function novoMarked() {
  const m = new Marked({ gfm: true });
  m.use({
    renderer: {
      table(tok) {
        const cab = tok.header.map((c) => c.text);
        const chave = cab.join('|');
        const inl = (c) => this.parser.parseInline(c.tokens);
        // Glossário: vira lista de definições em duas colunas
        if (chave === 'Termo|O que significa') {
          return `<dl class="glossario">${tok.rows.map((row) =>
            `<div><dt>${inl(row[0])}</dt><dd>${inl(row[1])}</dd></div>`).join('')}</dl>\n`;
        }
        const w = larguras[chave];
        const n = cab.length;
        const cls = ['tabela', `tabela--c${n}`];
        if (cab[0] === '#') cls.push('tabela--req');
        if (chave.startsWith('Estado|')) cls.push('tabela--estados');
        if (tok.rows.length <= 5) cls.push('tabela--curta');
        const col = w ? `<colgroup>${w.map((p) => `<col style="width:${p}%">`).join('')}</colgroup>` : '';
        const th = tok.header.map((c) => `<th>${inl(c)}</th>`).join('');
        const corpo = tok.rows.map((row) => `<tr>${row.map((c, i) => {
          let h = inl(c);
          if (i === 0 && chave.startsWith('Estado|')) {
            h = h.replace(/<strong>([^<]+)<\/strong>\s*\(([^)]+)\)/, (_, nome, cor) =>
              `<span class="estado estado--${ESTADOS[nome] || 'enviando'}">${nome}</span><span class="nota estado__cor">${cor}</span>`);
          }
          return `<td>${h}</td>`;
        }).join('')}</tr>`).join('\n');
        return `<table class="${cls.join(' ')}">${col}<thead><tr>${th}</tr></thead><tbody>\n${corpo}\n</tbody></table>\n`;
      },
      paragraph(tok) {
        const h = this.parser.parseInline(tok.tokens);
        // parágrafo só com negrito = título de tabela
        const m = h.match(/^<strong>([^<]+)<\/strong>$/);
        if (m) return `<h3 class="titulo-tabela">${m[1]}</h3>\n`;
        return `<p>${h}</p>\n`;
      },
    },
  });
  return m;
}
const marked = novoMarked();
const md = (s) => marked.parse(s);
const mdInline = (s) => marked.parseInline(s);

// ---------------------------------------------------------------- blocos
function cartoes(corpo, ctx) {
  const partes = corpo.split(/^### /m).filter((p) => p.trim());
  const n = partes.length;
  const grade = n === 3 || n === 6 ? 'cards cards--3' : 'cards';
  const html = partes.map((p, i) => {
    const [titulo, ...resto] = p.split('\n');
    let tt = titulo.trim();
    const num = tt.match(/^(\d+)\.\s+(.*)$/);
    let rotulo = '';
    if (num) { rotulo = `<div class="card__rotulo">Camada ${dois(num[1])}</div>`; tt = num[2]; }
    const ultimoImpar = n % 2 === 1 && n !== 3 && i === n - 1;
    const extra = ctx.cap === 0 ? amostraComoLer(tt) : '';
    return `<div class="card${ultimoImpar ? ' card--largo' : ''}">${iconeCartao(tt)}${rotulo}<div class="card__titulo">${mdInline(tt)}</div>${md(resto.join('\n').trim())}${extra}</div>`;
  }).join('\n');
  return `<div class="${grade}${n === 5 ? ' cards--5' : ''}">\n${html}\n</div>\n`;
}
function amostraComoLer(titulo) {
  if (/Você sabia/.test(titulo)) return '<div class="card__amostra"><span class="mini-callout">Você sabia?</span></div>';
  if (/âmbar/.test(titulo)) return '<div class="card__amostra"><span class="pill pill--confirmar">A confirmar pela Natcorp</span></div>';
  return '';
}
// Painel de destaque: título, subtítulo, colunas com ícone e um rodapé que amarra as colunas.
function destaque(corpo) {
  const ls = corpo.split('\n');
  let titulo = '', sub = [], cols = [], pe = [];
  for (const l of ls) {
    if (/^#### /.test(l)) titulo = l.slice(5).trim();
    else if (/^### /.test(l)) cols.push({ h: l.slice(4).trim(), txt: [] });
    else if (/^> /.test(l)) pe.push(l.slice(2).trim());
    else if (l.trim()) (cols.length ? cols[cols.length - 1].txt : sub).push(l.trim());
  }
  const icone = (h) => {
    const nome = /sem internet/i.test(h) ? 'semrede' : /lenta|instável/i.test(h) ? 'relogio' : /delay/i.test(h) ? 'ampulheta' : /GET|consulta/i.test(h) ? 'lupa' : /POST|importação/i.test(h) ? 'pacote' : /contingência/i.test(h) ? 'servidor' : 'cofre';
    const g = ICONE_EXTRA[nome]
      ? `<g fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round">${ICONE_EXTRA[nome]}</g>`
      : ico(nome, 0, 0, 24, 'currentColor', 1.9);
    return `<span class="destaque__icone"><svg viewBox="0 0 24 24" aria-hidden="true">${g}</svg></span>`;
  };
  return `<aside class="destaque">
<div class="destaque__titulo">${mdInline(titulo)}</div>
${sub.length ? `<p class="destaque__sub">${mdInline(sub.join(' '))}</p>` : ''}
<div class="destaque__cols">${cols.map((c) => `<div class="destaque__col">${icone(c.h)}<div class="destaque__h">${mdInline(c.h)}</div><p>${mdInline(c.txt.join(' '))}</p></div>`).join('')}</div>
${pe.map((x) => `<p class="destaque__pe">${mdInline(x)}</p>`).join('')}
</aside>\n`;
}
function voceSabia(corpo) {
  return `<aside class="callout"><div class="callout__titulo">Você sabia?</div>${md(corpo.trim())}</aside>\n`;
}
function passos(corpo) {
  const itens = corpo.trim().split(/\n(?=\d+\.\s)/).map((l) => l.replace(/^\d+\.\s+/, '').trim());
  return `<ol class="passos passos--texto">\n${itens.map((i) => `<li><p>${mdInline(i)}</p></li>`).join('\n')}\n</ol>\n`;
}
function confirmar(corpo) {
  const linhas = corpo.trim().split('\n');
  let titulo = '';
  if (/^\*\*.+\*\*$/.test(linhas[0].trim())) { titulo = linhas.shift().trim().replace(/^\*\*|\*\*$/g, ''); }
  const resto = linhas.join('\n').trim();
  let dentro;
  if (/^\|/m.test(resto)) {
    dentro = md(resto).replace('class="tabela', 'class="tabela tabela--confirmar');
  } else {
    const itens = resto.split('\n').filter((l) => /^\s*-\s+/.test(l)).map((l) => l.replace(/^\s*-\s+/, ''));
    dentro = itens.map((it) => {
      const m = it.match(/^(.*?):?\s*\[preencher:\s*([^\]]+)\]\s*$/);
      const perg = m ? m[1].replace(/:\s*$/, '') : it;
      const dica = m ? m[2].trim() : '';
      return `<div class="confirmar__item"><div class="confirmar__pergunta">${mdInline(perg)}</div><div class="confirmar__resposta">${dica ? `<span class="confirmar__dica">${esc(dica)}</span>` : ''}</div></div>`;
    }).join('\n');
  }
  return `<div class="confirmar">
<div class="confirmar__topo"><div class="confirmar__titulo">${mdInline(titulo)}</div><span class="pill pill--confirmar">A confirmar pela Natcorp</span></div>
${dentro}
</div>\n`;
}
function figura(arg, ctx) {
  const [nomeBruto, legenda = ''] = arg.split('|').map((s) => s.trim());
  const nome = nomeBruto.replace(/^NOVA:/, '');
  ctx.fig += 1;
  const num = `${ctx.cap}.${ctx.fig}`;
  // a legenda inteira vai para o rodapé da figura (sem título repetido acima)
  const titulo = '', texto = legenda;
  const aj = AJUSTES.figuras[nome] || {};
  const cls = ['figura', aj.pagina ? 'figura--pagina' : '', aj.classe || ''].filter(Boolean).join(' ');
  const estilo = aj.largura ? ` style="--fig-largura:${aj.largura}"` : '';
  return `<figure class="${cls}"${estilo}>
${titulo ? `<div class="figura__titulo">${mdInline(titulo)}</div>` : ''}<div class="figura__arte"><!--#svg ${nome}.svg--></div>
<figcaption><b>Figura ${num}</b><span>${mdInline(texto)}.</span></figcaption>
</figure>\n`;
}

// ---------------------------------------------------------------- capítulos
const bruto = readFileSync(fonte, 'utf8').replace(/<!--[\s\S]*?-->/g, '');
const linhas = bruto.split('\n');
const capitulos = [];
let atual = null;
for (const l of linhas) {
  const m = l.match(/^::: capitulo\s+(\d+)\s*\|\s*([^|]+)\|\s*(.+)$/);
  if (m) { atual = { n: +m[1], titulo: m[2].trim(), sub: m[3].trim(), linhas: [] }; capitulos.push(atual); continue; }
  if (atual) atual.linhas.push(l);
}

function corpoCapitulo(cap) {
  const ctx = { cap: cap.n, fig: 0 };
  const out = [];
  let buf = [];
  const flush = () => { if (buf.join('').trim()) out.push(md(buf.join('\n'))); buf = []; };
  const ls = cap.linhas;
  for (let i = 0; i < ls.length; i++) {
    const l = ls[i];
    const fig = l.match(/^:::\s*figura\s+(.+)$/);
    if (fig) { flush(); out.push(figura(fig[1], ctx)); continue; }
    const bl = l.match(/^:::\s*(cards|voce-sabia|passos|confirmar|destaque)\s*$/);
    if (bl) {
      flush();
      const dentro = [];
      i++;
      while (i < ls.length && ls[i].trim() !== ':::') { dentro.push(ls[i]); i++; }
      const c = dentro.join('\n');
      out.push({ cards: () => cartoes(c, ctx), 'voce-sabia': () => voceSabia(c), passos: () => passos(c), confirmar: () => confirmar(c), destaque: () => destaque(c) }[bl[1]]());
      continue;
    }
    buf.push(l);
  }
  flush();
  let html = out.join('\n');
  // primeiro parágrafo do capítulo = lead
  html = html.replace(/^\s*<p>/, '<p class="lead">');
  for (const q of (AJUSTES.quebras || []).filter((x) => x.cap === cap.n)) {
    const alvo = `<h2>${q.antes}`;
    if (!html.includes(alvo)) console.warn('AVISO: quebra não encontrada:', q.cap, q.antes);
    html = html.replace(alvo, `<h2 class="quebra">${q.antes}`);
  }
  return html;
}

function minutos(cap) {
  const palavras = cap.linhas.join(' ').replace(/[|:#*\-]/g, ' ').split(/\s+/).filter(Boolean).length;
  return Math.max(1, Math.round(palavras / 200));
}

function abertura(cap, { titulo, sub, olho }) {
  const h2s = cap.linhas.filter((l) => /^## /.test(l)).map((l) => l.replace(/^## /, '').split(':')[0].trim()).filter((t) => t !== titulo);
  const nesta = h2s.slice(0, 5).map((h) => `<span>${mdInline(h)}</span>`).join('');
  return `<header class="abertura">
    <div class="abertura__num" data-n="${dois(cap.n)}">${dois(cap.n)}</div>
    <div>
      <div class="abertura__olho olho">${olho}</div>
      <h1 class="abertura__titulo">${esc(titulo)}</h1>
      <p class="abertura__sub">${esc(sub)}</p>
      ${nesta ? `<div class="abertura__nesta">${nesta}</div>` : ''}
    </div>
    ${trilha()}
  </header>`;
}

// ---- identidade visual Natcorp: símbolo oficial (para contorno e trilha) e assinaturas
const SIMBOLO_D = readFileSync(join(design, 'marca', 'natcorp-simbolo-purple.svg'), 'utf8').match(/<path d="([^"]+)"/)[1];
const contorno = (cor, opac) => `<div class="contorno" aria-hidden="true"><svg viewBox="0 0 140 140"><path d="${SIMBOLO_D}" fill="none" stroke="${cor}" stroke-opacity="${opac}" stroke-width=".22"/></svg></div>`;
const trilha = () => `<div class="trilha" aria-hidden="true">${[1, .78, .56, .34, .12].map((o) =>
  `<svg viewBox="0 0 140 140"><path d="${SIMBOLO_D}" fill="#511C76" fill-opacity="${o}"/></svg>`).join('')}</div>`;

const TOTAL_CAP = Math.max(...capitulos.map((c) => c.n));
const capa = config.capa || {};
const cc = config.contracapa || {};
const marcaProduto = capa.marcaProduto ? `<img class="capa__app" src="marca/${capa.marcaProduto}" alt="">` : '<div class="capa__app" style="height:26mm" aria-hidden="true"></div>';
let secoes = '';
for (const cap of capitulos) {
  if (cap.n === 0) {
    // capa
    secoes += `<section class="capa">
  ${contorno('#511C76', .24)}
  <img class="capa__logo" src="marca/natcorp-logo-horizontal-color.svg" alt="Natcorp">
  ${marcaProduto}
  <div class="capa__olho">${esc(capa.olho || 'Documento técnico')}</div>
  <h1 class="capa__titulo">${esc(capa.titulo[0])}<em>${esc(capa.titulo[1] || '')}</em></h1>
  <p class="capa__sub">${esc(cap.sub)}</p>
  ${trilha()}
  <div class="capa__rodape"><span><b>Natcorp</b> · ${esc(capa.data || '')}</span><span>${esc(capa.tipo || 'Documento informativo')}</span></div>
</section>\n`;
    // "Como ler": o parágrafo antes do "## Como ler" vira o subtítulo da abertura
    const idx = cap.linhas.findIndex((l) => /^## Como ler/.test(l));
    const antes = cap.linhas.slice(0, idx).join(' ').trim();
    const titulo = cap.linhas[idx].replace(/^## /, '').trim();
    const resto = { ...cap, linhas: cap.linhas.slice(idx + 1) };
    secoes += `<section class="capitulo capitulo--00">
  ${abertura(cap, { titulo, sub: antes, olho: 'Antes de começar · <b>2 minutos</b>' })}
  ${corpoCapitulo(resto)}
</section>\n`;
    continue;
  }
  const olho = cap.n === TOTAL_CAP ? `Capítulo <b>${TOTAL_CAP}</b> de ${TOTAL_CAP} · consulta`
      : `Capítulo <b>${dois(cap.n)}</b> de ${TOTAL_CAP} · ${minutos(cap)} minuto${minutos(cap) > 1 ? 's' : ''}`;
  secoes += `<section class="capitulo capitulo--${dois(cap.n)}">
  ${abertura(cap, { titulo: cap.titulo, sub: cap.sub, olho })}
  ${corpoCapitulo(cap)}
</section>\n`;
}

secoes += `<section class="contracapa">
  ${contorno('#FFFFFF', .32)}
  <img class="contracapa__logo" src="marca/natcorp-logo-horizontal-white.svg" alt="Natcorp">
  <p class="contracapa__frase">${cc.frase || 'Todo o RH.<br>Um único sistema.'}</p>
  <div class="contracapa__nota"><span class="contracapa__app">${cc.marcaProduto ? `<img src="marca/${cc.marcaProduto}" alt="">` : ''}<span><b>${esc(cc.nome || config.titulo)}</b><br>${esc(cc.sub || '')}</span></span><span>natcorp.com.br</span></div>
</section>\n`;

// ajustes finos de diagramação (quebras pontuais), declarados em ajustes.mjs
for (const [de, para] of AJUSTES.trocas) {
  if (!secoes.includes(de)) { console.warn('AVISO: ajuste não encontrado:', de.slice(0, 60)); continue; }
  secoes = secoes.replace(de, para);
}

let html = `<!doctype html>
<html lang="pt-BR">
<head>
<meta charset="utf-8">
<title>${esc(config.titulo)}</title>
<link rel="stylesheet" href="estilo.css">
<link rel="stylesheet" href="documento.css">
</head>
<body>
${secoes}
</body>
</html>
`;
html = html.replace(/<!--(?!#svg)[\s\S]*?-->\s*/g, ''); // nenhum comentário de especificação no HTML final
html = acabamento(html);
// parágrafo com dois selos seguidos de explicação (cartão "Selos de status") vira legenda alinhada
html = html.replace(/<p>(<span class="pill [^"]+">[^<]+<\/span>)\s*([^<]+?\.)\s*(<span class="pill [^"]+">[^<]+<\/span>)\s*([^<]+?)<\/p>/g,
  '<div class="legenda legenda--card"><span>$1</span><span>$2</span><span>$3</span><span>$4</span></div>');
// selos dentro de atributos não existem; garante que o marcador de SVG não foi tocado
html = html.replace(/<!--#svg\s+([\w./-]+)\s*-->/g, (m) => m.replace(/[“”]/g, '"'));

const travessao = (html.match(/—/g) || []).length;
const meiaRisca = (html.match(/ – /g) || []).length;
writeFileSync(join(design, 'documento.html'), html);
// capa e contracapa em página sem margem (sangram até a borda); o render.mjs as troca no PDF final
const pecas = (secoes.match(/<section class="capa">[\s\S]*?<\/section>/) || [''])[0] + '\n' +
  (secoes.match(/<section class="contracapa">[\s\S]*?<\/section>/) || [''])[0];
writeFileSync(join(design, 'capas.html'), `<!doctype html>
<html lang="pt-BR">
<head>
<meta charset="utf-8">
<title>${esc(config.titulo)} · capas</title>
<link rel="stylesheet" href="estilo.css">
<style>@page { margin: 0; @bottom-left { content: none; } @bottom-right { content: none; } }</style>
</head>
<body>
${pecas}
</body>
</html>
`);
console.log(`documento.html: ${capitulos.length} capítulos · travessões: ${travessao} · meia-risca como travessão: ${meiaRisca}`);
return { capitulos: capitulos.length, travessao, meiaRisca };
}
