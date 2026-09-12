// Gera as páginas estáticas de acesso aos portais dos clientes (portais-standalone/<slug>/index.html)
// a partir de src/content/clientPortals.json, com as ilustrações de marca dos módulos.
// A página é autônoma (CSS e JS embutidos, favicon em data URI, fonte pelo Google Fonts), então a
// mesma pasta pode ser copiada para o servidor atual.
//
// NÃO escreve mais em public/. O site novo atende /portais/<cliente> pela rota do SPA, agora
// pré-renderizada como todas as outras — e o prerender roda depois da cópia do public/, então
// esta página sobrescreveria aquela (ou o contrário, dependendo da ordem). Duas páginas
// diferentes disputando a mesma URL é bug esperando a hora. Esta continua sendo gerada, fora
// da entrega, para quem precisar subir a pasta num servidor sem o site novo.
//
import { copyFileSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs'
import { resolve } from 'node:path'

const root = resolve(import.meta.dirname, '..')
const siteUrl = (process.env.VITE_SITE_URL || 'https://www.natcorp.com.br').replace(/\/$/, '')
const clients = JSON.parse(readFileSync(resolve(root, 'src/content/clientPortals.json'), 'utf8'))
const logoSvg = readFileSync(resolve(root, 'public/brand/natcorp-horizontal.svg'), 'utf8').replace(/<svg /, '<svg class="logo" ')
const symbolSvg = readFileSync(resolve(root, 'public/brand/natcorp-symbol.svg'), 'utf8')
const faviconUri = 'data:image/svg+xml,' + encodeURIComponent(readFileSync(resolve(root, 'public/favicon.svg'), 'utf8'))
/* Contorno do símbolo (manual, seção 10): os quatro módulos em um traço, sangrando pelo canto. */
const outlinePaths = [...symbolSvg.matchAll(/<path d="([^"]+)"/g)].map((m) => m[1])
const outlineSvg = `<svg class="contorno" viewBox="0 0 8 8" aria-hidden="true" focusable="false">${outlinePaths.map((d) => `<path d="${d}" fill="none" stroke="currentColor" stroke-width="0.04"/>`).join('')}</svg>`

const esc = (s) => String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;')

const css = `
:root{--roxo:#511C76;--roxo-hover:#3E1A6F;--azul:#2C1A63;--rosa:#C95788;--ameixa:#9A408A;--tinta:#1B1238;--grafite:#4A4460;--cinza:#8E88A3;--nevoa:#E9E5F1;--off:#F4F2F7;--branco:#fff;--raio:20px;--sombra:0 1px 2px rgba(27,18,56,.04),0 10px 30px -12px rgba(27,18,56,.16);--sombra-alta:0 2px 4px rgba(27,18,56,.05),0 24px 48px -16px rgba(81,28,118,.28);--ease:cubic-bezier(.22,1,.36,1)}
*,*::before,*::after{box-sizing:border-box}
html{-webkit-text-size-adjust:100%;scroll-behavior:smooth}
body{margin:0;font-family:Manrope,"Segoe UI",system-ui,-apple-system,Arial,sans-serif;font-size:16px;line-height:1.5;color:var(--tinta);background:var(--off);-webkit-font-smoothing:antialiased;min-height:100vh;display:flex;flex-direction:column}
a{color:var(--roxo)}
::selection{background:var(--roxo);color:#fff}
:focus-visible{outline:2px solid var(--roxo);outline-offset:3px;border-radius:6px}
.pular{position:absolute;left:-999px;top:8px;background:#fff;color:var(--roxo);padding:8px 14px;border-radius:8px;font-weight:700;box-shadow:var(--sombra-alta);z-index:50}
.pular:focus{left:12px}
.container{width:100%;max-width:1160px;margin:0 auto;padding:0 20px}
/* cabeçalho */
.topo{background:#fff;border-bottom:1px solid var(--nevoa);position:sticky;top:0;z-index:20}
.topo .container{display:flex;align-items:center;justify-content:space-between;gap:16px;height:68px}
.marca{display:flex;align-items:center;gap:14px;text-decoration:none;color:inherit}
.logo{height:30px;width:auto;display:block}
.cliente{display:inline-flex;align-items:center;gap:8px;padding:6px 12px;border-radius:999px;background:var(--off);color:var(--grafite);font-size:12.5px;font-weight:700;letter-spacing:.02em;white-space:nowrap}
.cliente::before{content:"";width:8px;height:8px;border-radius:2px;transform:rotate(45deg);background:linear-gradient(135deg,var(--ameixa),var(--roxo))}
.topo nav{display:flex;gap:6px}
.topo nav a svg{width:16px;height:16px;flex:none}
.topo nav a{display:inline-flex;align-items:center;gap:6px;padding:8px 14px;border-radius:999px;font-size:14px;font-weight:700;color:var(--grafite);text-decoration:none;transition:background .25s var(--ease),color .25s var(--ease)}
.topo nav a:hover{background:var(--off);color:var(--roxo)}
/* abertura */
.abertura{position:relative;overflow:hidden;padding:56px 0 24px;text-align:center}
.contorno{position:absolute;right:-9%;top:-40%;height:170%;width:auto;color:var(--roxo);opacity:.10;pointer-events:none}
.abertura .container{position:relative}
.olho{display:inline-flex;align-items:center;gap:10px;font-size:12px;font-weight:700;letter-spacing:.16em;text-transform:uppercase;color:var(--roxo)}
.olho::before{content:"";width:22px;height:1px;background:var(--rosa)}
.olho::after{content:"";width:22px;height:1px;background:var(--rosa)}
h1{margin:14px 0 10px;font-size:clamp(2.1rem,5vw,3.4rem);line-height:1.04;font-weight:800;letter-spacing:-.02em;color:var(--tinta)}
h1 span{color:var(--roxo)}
.lead{margin:0 auto;max-width:34rem;font-size:clamp(1rem,1.5vw,1.15rem);color:var(--grafite)}
.continuar{display:none;margin:22px auto 0;align-items:center;gap:12px;padding:8px 8px 8px 16px;border-radius:999px;background:#fff;border:1px solid var(--nevoa);box-shadow:var(--sombra);font-size:14px;color:var(--grafite);text-decoration:none;max-width:100%}
.continuar.ativo{display:inline-flex}
.continuar strong{color:var(--tinta);font-weight:700}
.continuar b{display:inline-flex;align-items:center;gap:6px;padding:8px 14px;border-radius:999px;background:var(--roxo);color:#fff;font-weight:700;white-space:nowrap}
/* cartões */
.portais{display:grid;grid-template-columns:repeat(auto-fit,minmax(min(100%,300px),1fr));gap:18px;padding:26px 0 8px;list-style:none;margin:0}
.cartao{position:relative;display:flex;flex-direction:column;height:100%;background:#fff;border:1px solid var(--nevoa);border-radius:var(--raio);box-shadow:var(--sombra);overflow:hidden;text-decoration:none;color:inherit;transition:transform .5s var(--ease),box-shadow .5s var(--ease),border-color .5s var(--ease)}
.cartao:hover,.cartao:focus-visible{transform:translateY(-4px);box-shadow:var(--sombra-alta);border-color:rgba(81,28,118,.35)}
.cartao:focus-visible{outline-offset:0}
.cartao figure{margin:0;aspect-ratio:16/10;background:#fff;border-bottom:1px solid var(--nevoa);overflow:hidden}
.cartao img{display:block;width:100%;height:100%;object-fit:cover;transition:transform .7s var(--ease)}
.cartao:hover img{transform:scale(1.03)}
.corpo{display:flex;flex-direction:column;gap:6px;padding:18px 20px 20px;flex:1}
.publico{font-size:11.5px;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:var(--rosa)}
.cartao h2{margin:0;font-size:1.25rem;line-height:1.2;font-weight:800;letter-spacing:-.01em;color:var(--tinta)}
.cartao p{margin:0;font-size:14.5px;color:var(--grafite);flex:1}
.entrar{margin-top:10px;display:inline-flex;align-items:center;gap:8px;align-self:flex-start;padding:10px 16px;border-radius:999px;background:var(--roxo);color:#fff;font-size:14px;font-weight:700;transition:background .25s var(--ease),gap .25s var(--ease)}
.entrar svg{width:16px;height:16px;transition:transform .3s var(--ease)}
.cartao:hover .entrar{background:var(--roxo-hover)}
.cartao:hover .entrar svg{transform:translateX(3px)}
.cartao.ultimo{border-color:rgba(201,87,136,.6)}
.cartao.ultimo::after{content:"Último acesso";position:absolute;top:12px;left:12px;padding:4px 10px;border-radius:999px;background:var(--rosa);color:#fff;font-size:11px;font-weight:700;letter-spacing:.04em}
.cartao.pendente .entrar{background:var(--off);color:var(--grafite)}
/* ajuda */
.ajuda{padding:40px 0 48px}
.ajuda h2{margin:0 0 6px;font-size:clamp(1.4rem,2.4vw,1.8rem);font-weight:800;letter-spacing:-.02em}
.ajuda>.container>p{margin:0 0 20px;color:var(--grafite)}
.ajuda-grade{display:grid;grid-template-columns:repeat(auto-fit,minmax(min(100%,260px),1fr));gap:14px}
.ajuda-item{background:#fff;border:1px solid var(--nevoa);border-radius:16px;padding:18px 20px;box-shadow:var(--sombra)}
.ajuda-item h3{margin:0 0 6px;font-size:1rem;font-weight:800;display:flex;align-items:center;gap:10px}
.ajuda-item h3 span{display:inline-flex;align-items:center;justify-content:center;width:32px;height:32px;border-radius:10px;background:var(--off);color:var(--roxo)}
.ajuda-item h3 svg{width:16px;height:16px}
.ajuda-item p{margin:0;font-size:14.5px;color:var(--grafite)}
.canais{list-style:none;margin:10px 0 0;padding:0;display:flex;flex-direction:column;gap:6px}
.canais a{display:inline-flex;align-items:center;gap:8px;font-size:14.5px;font-weight:700;color:var(--roxo);text-decoration:none}
.canais a:hover{text-decoration:underline;text-underline-offset:3px}
.canais svg{width:16px;height:16px;color:var(--cinza)}
/* rodapé */
.rodape{margin-top:auto;background:var(--azul);color:rgba(255,255,255,.72);padding:26px 0;font-size:13px}
.rodape .container{display:flex;flex-wrap:wrap;align-items:center;justify-content:space-between;gap:12px 24px}
.rodape strong{color:#fff;font-weight:700}
.rodape a{color:#fff;font-weight:600;text-decoration:none}
.rodape a:hover{text-decoration:underline;text-underline-offset:3px}
.rodape nav{display:flex;flex-wrap:wrap;gap:16px}
/* entrada suave */
@media (prefers-reduced-motion:no-preference){
  .abertura .container>*,.portais>li,.ajuda-item{animation:subir .7s var(--ease) both}
  .portais>li:nth-child(2){animation-delay:.06s}.portais>li:nth-child(3){animation-delay:.12s}.portais>li:nth-child(4){animation-delay:.18s}.portais>li:nth-child(5){animation-delay:.24s}.portais>li:nth-child(6){animation-delay:.3s}
  @keyframes subir{from{opacity:0;transform:translateY(16px)}to{opacity:1;transform:none}}
}
@media (max-width:640px){
  .topo .container{height:60px}.logo{height:26px}.topo nav a span{display:none}.cliente{display:none}
  .abertura{padding:36px 0 12px}.corpo{padding:16px}.cartao figure{aspect-ratio:16/9}
}
@media print{.topo nav,.continuar,.rodape{display:none}.cartao{break-inside:avoid;box-shadow:none}}
`.trim()

const icon = {
  arrow: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M5 12h14M13 6l6 6-6 6"/></svg>',
  key: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="8" cy="15" r="4"/><path d="M10.9 12.1 20 3M15 8l3 3M18 5l2 2"/></svg>',
  user: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 3.6-7 8-7s8 3 8 7"/></svg>',
  life: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="9"/><circle cx="12" cy="12" r="3.5"/><path d="m5.6 5.6 3.9 3.9M14.5 14.5l3.9 3.9M18.4 5.6l-3.9 3.9M9.5 14.5l-3.9 3.9"/></svg>',
  phone: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M5 4h4l2 5-2.5 1.5a11 11 0 0 0 5 5L15 13l5 2v4a2 2 0 0 1-2 2A16 16 0 0 1 3 6a2 2 0 0 1 2-2"/></svg>',
  chat: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 12a8 8 0 0 1-11.6 7.1L4 21l1.9-5.4A8 8 0 1 1 21 12z"/></svg>',
  mail: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="m3 7 9 6 9-6"/></svg>',
  globe: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3a14 14 0 0 1 0 18M12 3a14 14 0 0 0 0 18"/></svg>',
}

const contato = { phone: '+55 11 5096-0711', phoneHref: 'tel:+551150960711', whatsapp: '+55 11 97446-6729', whatsappHref: 'https://wa.me/5511974466729', email: 'contato@natcorp.com.br' }

function page(slug, c) {
  const cards = c.portais
    .map((p) => {
      const href = p.url || '#ajuda'
      const cls = p.url ? 'cartao' : 'cartao pendente'
      const label = p.url ? 'Entrar' : 'Em configuração'
      return `<li><a class="${cls}" href="${esc(href)}" data-portal="${esc(p.id)}" data-nome="${esc(p.nome)}" aria-label="${esc(label === 'Entrar' ? `Entrar: ${p.nome}` : `${p.nome}: acesso em configuração`)}"${p.url ? ' rel="noopener"' : ''}>
        <figure><img src="img/${esc(p.id)}.svg" alt="" width="1200" height="800" loading="lazy" decoding="async"></figure>
        <div class="corpo">
          <span class="publico">${esc(p.publico)}</span>
          <h2>${esc(p.titulo)}</h2>
          <p>${esc(p.descricao)}</p>
          <span class="entrar">${label}${icon.arrow}</span>
        </div>
      </a></li>`
    })
    .join('\n')

  const title = `Portais ${c.name}: acesso ao sistema | Natcorp`
  const description = `Acesse os portais ${c.name}: ${c.portais.map((p) => p.titulo).join(', ')}. Entre com o usuário e a senha fornecidos pela sua empresa.`
  const canonical = `${siteUrl}/portais/${slug}/`

  return `<!doctype html>
<html lang="pt-BR">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>${esc(title)}</title>
<meta name="description" content="${esc(description)}">
<meta name="robots" content="noindex, follow">
<meta name="theme-color" content="#511C76">
<link rel="canonical" href="${canonical}">
<link rel="icon" href="${faviconUri}" type="image/svg+xml">
<meta property="og:type" content="website">
<meta property="og:locale" content="pt_BR">
<meta property="og:site_name" content="Natcorp">
<meta property="og:title" content="${esc(`Portais ${c.name}`)}">
<meta property="og:description" content="${esc(description)}">
<meta property="og:url" content="${canonical}">
<meta property="og:image" content="${siteUrl}/og-image.png">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Manrope:wght@500;600;700;800&display=swap">
<style>${css}</style>
</head>
<body>
<a class="pular" href="#portais">Pular para os portais</a>
<header class="topo">
  <div class="container">
    <a class="marca" href="${siteUrl}/" title="Natcorp">${logoSvg}${c.name.toLowerCase() === 'natcorp' ? '' : `<span class="cliente">${esc(c.name)}</span>`}</a>
    <nav aria-label="Atalhos">
      <a href="#ajuda">${icon.life}<span>Precisa de ajuda?</span></a>
      <a href="${siteUrl}/" rel="noopener">${icon.globe}<span>natcorp.com.br</span></a>
    </nav>
  </div>
</header>
<main id="conteudo">
  <section class="abertura" aria-labelledby="titulo">
    ${outlineSvg}
    <div class="container">
      <p class="olho">Portais ${esc(c.name)}</p>
      <h1 id="titulo">${esc(c.titulo).replace(/portais/i, (m) => `<span>${m}</span>`)}</h1>
      <p class="lead">${esc(c.subtitulo)}</p>
      <a class="continuar" id="continuar" href="#" hidden><span>Continuar de onde parou: <strong id="continuar-nome"></strong></span><b>Entrar${icon.arrow}</b></a>
    </div>
  </section>
  <section id="portais" class="container" aria-label="Portais disponíveis">
    <ul class="portais">
${cards}
    </ul>
  </section>
  <section id="ajuda" class="ajuda" aria-labelledby="ajuda-titulo">
    <div class="container">
      <h2 id="ajuda-titulo">Precisa de ajuda para entrar?</h2>
      <p>Três situações resolvem quase tudo. Se não for nenhuma delas, fale com a gente.</p>
      <div class="ajuda-grade">
        <div class="ajuda-item"><h3><span>${icon.user}</span>Primeiro acesso</h3><p>${esc(c.ajuda.primeiroAcesso)}</p></div>
        <div class="ajuda-item"><h3><span>${icon.key}</span>Esqueci minha senha</h3><p>${esc(c.ajuda.senha)}</p></div>
        <div class="ajuda-item"><h3><span>${icon.life}</span>Suporte Natcorp</h3><p>${esc(c.ajuda.suporte)}</p>
          <ul class="canais">
            <li><a href="${contato.whatsappHref}" rel="noopener" target="_blank">${icon.chat}WhatsApp ${esc(contato.whatsapp)}</a></li>
            <li><a href="${contato.phoneHref}">${icon.phone}${esc(contato.phone)}</a></li>
            <li><a href="mailto:${contato.email}">${icon.mail}${esc(contato.email)}</a></li>
          </ul>
        </div>
      </div>
    </div>
  </section>
</main>
<footer class="rodape">
  <div class="container">
    <p><strong>Natcorp</strong> · Todo o RH em um único sistema. Acesso restrito a usuários autorizados; os dados são tratados conforme a LGPD.</p>
    <nav aria-label="Links"><a href="${siteUrl}/">natcorp.com.br</a>${c.termosUrl ? `<a href="${esc(c.termosUrl)}" rel="noopener">Termos de uso</a>` : ''}<a href="${siteUrl}/seguranca">Segurança e privacidade</a></nav>
  </div>
</footer>
<script>
(function(){
  var chave='natcorp:portal:${esc(slug)}';
  var ultimo=null;try{ultimo=localStorage.getItem(chave)}catch(e){}
  var cartoes=document.querySelectorAll('.cartao[data-portal]');
  for(var i=0;i<cartoes.length;i++){
    cartoes[i].addEventListener('click',function(){
      if(this.classList.contains('pendente'))return;
      try{localStorage.setItem(chave,this.getAttribute('data-portal'))}catch(e){}
    });
    if(ultimo&&cartoes[i].getAttribute('data-portal')===ultimo&&!cartoes[i].classList.contains('pendente')){
      cartoes[i].classList.add('ultimo');
      var c=document.getElementById('continuar');
      c.href=cartoes[i].getAttribute('href');
      document.getElementById('continuar-nome').textContent=cartoes[i].getAttribute('data-nome');
      c.hidden=false;c.classList.add('ativo');
    }
  }
})();
</script>
</body>
</html>
`
}

let total = 0
for (const [slug, c] of Object.entries(clients)) {
  if (slug.startsWith('_')) continue
  const dir = resolve(root, 'portais-standalone', slug)
  mkdirSync(resolve(dir, 'img'), { recursive: true })
  for (const p of c.portais) {
    copyFileSync(resolve(root, 'brand/modulos/ilustracoes/svg', `${p.ilustracao}.svg`), resolve(dir, 'img', `${p.id}.svg`))
  }
  writeFileSync(resolve(dir, 'index.html'), page(slug, c))
  const pend = c.portais.filter((p) => !p.url).map((p) => p.titulo)
  console.log(`portais/${slug}: ${c.portais.length} portais${pend.length ? ` (sem URL: ${pend.join(', ')})` : ''}`)
  total++
}
console.log(`portais: ${total} cliente(s) em portais-standalone/ (fora da entrega)`)
