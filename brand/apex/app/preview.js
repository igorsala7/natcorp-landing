// Pré-visualização ao vivo das folhas locais no APEX, dentro do navegador do Playwright
// (MCP browser_run_code, com este arquivo em "filename").
//
// - O pedido do Natcorp_Login.css (que toda página do workspace já faz, no <head>) é
//   respondido com o Natcorp_Preview.css do disco; o do Natcorp_Style_Min.css (a Skin
//   combinada que o cliente sobe desde 27/09), com a cópia local dela (login + menu + páginas, montado por
//   gerar-app.mjs). Fica na MESMA posição do arquivo real: o theme42.js mede cabeçalho e
//   barras já com o CSS novo, como vai ser em produção. Vale também nas modais (iframe).
// - Página sem esse <link> (outro workspace) ganha um, criado no DOMContentLoaded.
// - A cada 2 s a página relê o arquivo; se mudou, troca o <link> — sem F5. Mudança de
//   ALTURA (cabeçalho, barra de título) pede F5: o tema só mede ao carregar.
// - Um selo no canto inferior esquerdo avisa que a tela mostra a versão LOCAL.
// Nada disso toca o servidor: só este navegador vê. Fechou o navegador, acabou.
async (page) => {
  const PREVIEW = '/Users/igor_sala/instalacoes/Projetos/natcorp-landing/.playwright-mcp/Natcorp_Preview.css'
  const SKIN_LOCAL = '/Users/igor_sala/instalacoes/Projetos/natcorp-landing/brand/apex/login/Natcorp_Style_Min.css'
  const ctx = page.context()
  await ctx.unrouteAll({ behavior: 'ignoreErrors' })
  await ctx.route('**/__nc_preview__/**', (r) =>
    r.fulfill({ path: PREVIEW, contentType: 'text/css; charset=utf-8', headers: { 'cache-control': 'no-store' } }),
  )
  await ctx.route(/Natcorp_Login\.css/, (r) =>
    r.fulfill({ path: PREVIEW, contentType: 'text/css; charset=utf-8', headers: { 'cache-control': 'no-store' } }),
  )
  /* Desde 27/09 o cliente sobe a Skin COMBINADA (Natcorp_Style_Min.css = Skin + o nosso CSS,
     mantida pelo gerar-app.mjs) e as páginas não pedem mais o Natcorp_Login.css. O pedido
     dela é respondido com a cópia local — a Skin intacta e a nossa parte atualizada. */
  await ctx.route(/Natcorp_Style_Min(\.min)?\.css/, (r) =>
    r.fulfill({ path: SKIN_LOCAL, contentType: 'text/css; charset=utf-8', headers: { 'cache-control': 'no-store' } }),
  )
  /* Folhas e scripts AVULSOS de página (Natcorp_Beneficios.css/.js — página 168 do app 200):
     o pedido do arquivo publicado, quando a página já o referencia, e o do __nc_preview__
     são respondidos com o arquivo local. Enquanto a página ainda não os referencia, o script
     abaixo os acrescenta — só na página deles. */
  const AVULSOS = '/Users/igor_sala/instalacoes/Projetos/natcorp-landing/brand/apex/login/'
  await ctx.route(/Natcorp_Beneficios(\.min)?\.(css|js)(\?|$)/, (r) => {
    const ext = r.request().url().match(/\.(css|js)(\?|$)/)[1]
    r.fulfill({ path: AVULSOS + 'Natcorp_Beneficios.' + ext, contentType: (ext === 'css' ? 'text/css' : 'application/javascript') + '; charset=utf-8', headers: { 'cache-control': 'no-store' } })
  })
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      const app = (document.getElementById('pFlowId') || {}).value, pag = (document.getElementById('pFlowStepId') || {}).value
      if (app !== '200' || pag !== '168') return
      if (!document.querySelector('link[href*="Natcorp_Beneficios"]')) {
        const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Beneficios.css?v=' + Date.now(); document.head.appendChild(l)
      }
      if (!document.querySelector('script[src*="Natcorp_Beneficios"]')) {
        const s = document.createElement('script'); s.src = '/__nc_preview__/Natcorp_Beneficios.js?v=' + Date.now(); document.body.appendChild(s)
      }
    })
  })
  /* Requisição de Pessoal (app 2010, página 52), ainda sem as classes no APEX: o
     simular-requisicao-p52.js faz o que o script de exportação vai fazer, e o
     Natcorp_Requisicao.css/.js desenham por cima — a cada carga da página, também numa
     requisição nova. */
  const APP = '/Users/igor_sala/instalacoes/Projetos/natcorp-landing/brand/apex/app/'
  await ctx.route(/Natcorp_Requisicao(\.min)?\.(css|js)(\?|$)/, (r) => {
    const ext = r.request().url().match(/\.(css|js)(\?|$)/)[1]
    r.fulfill({ path: AVULSOS + 'Natcorp_Requisicao.' + ext, contentType: (ext === 'css' ? 'text/css' : 'application/javascript') + '; charset=utf-8', headers: { 'cache-control': 'no-store' } })
  })
  await ctx.route(/simular-requisicao-p52\.js/, (r) => r.fulfill({ path: APP + 'simular-requisicao-p52.js', contentType: 'application/javascript; charset=utf-8', headers: { 'cache-control': 'no-store' } }))
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      const app = (document.getElementById('pFlowId') || {}).value, pag = (document.getElementById('pFlowStepId') || {}).value
      if (app !== '2010' || pag !== '52' || window.__ncReqPreview) return
      window.__ncReqPreview = true
      const v = Date.now()
      if (!document.querySelector('link[href*="Natcorp_Requisicao"]')) { const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Requisicao.css?v=' + v; document.head.appendChild(l) }
      const carregar = (src, depois) => { const s = document.createElement('script'); s.src = src; s.onload = depois || null; document.body.appendChild(s) }
      const ir = () => carregar('/__nc_preview__/simular-requisicao-p52.js?v=' + v, () => { if (!document.querySelector('script[src*="Natcorp_Requisicao.js"]')) carregar('/__nc_preview__/Natcorp_Requisicao.js?v=' + v) })
      if (window.apex && window.apex.jQuery) apex.jQuery(ir); else window.addEventListener('load', ir)
    })
  })
  /* Requisição de Posição (app 200, página 76): o mesmo Natcorp_Requisicao.css/.js da
     Requisição de Pessoal, com o simular-requisicao-p76.js no lugar do script de exportação. */
  await ctx.route(/simular-requisicao-p76\.js/, (r) => r.fulfill({ path: APP + 'simular-requisicao-p76.js', contentType: 'application/javascript; charset=utf-8', headers: { 'cache-control': 'no-store' } }))
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      const app = (document.getElementById('pFlowId') || {}).value, pag = (document.getElementById('pFlowStepId') || {}).value
      if (app !== '200' || pag !== '76' || window.__ncReqPreview) return
      window.__ncReqPreview = true
      const v = Date.now()
      if (!document.querySelector('link[href*="Natcorp_Requisicao"]')) { const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Requisicao.css?v=' + v; document.head.appendChild(l) }
      const carregar = (src, depois) => { const s = document.createElement('script'); s.src = src; s.onload = depois || null; document.body.appendChild(s) }
      const ir = () => carregar('/__nc_preview__/simular-requisicao-p76.js?v=' + v, () => { if (!document.querySelector('script[src*="Natcorp_Requisicao.js"]')) carregar('/__nc_preview__/Natcorp_Requisicao.js?v=' + v) })
      if (window.apex && window.apex.jQuery) apex.jQuery(ir); else window.addEventListener('load', ir)
    })
  })
  /* Requisição de Alteração de Vaga (app 200, página 163) */
  await ctx.route(/Natcorp_AlteracaoVaga(\.min)?\.(css|js)(\?|$)/, (r) => {
    const ext = r.request().url().match(/\.(css|js)(\?|$)/)[1]
    r.fulfill({ path: AVULSOS + 'Natcorp_AlteracaoVaga.' + ext, contentType: (ext === 'css' ? 'text/css' : 'application/javascript') + '; charset=utf-8', headers: { 'cache-control': 'no-store' } })
  })
  await ctx.route(/simular-alteracao-p163\.js/, (r) => r.fulfill({ path: APP + 'simular-alteracao-p163.js', contentType: 'application/javascript; charset=utf-8', headers: { 'cache-control': 'no-store' } }))
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      const app = (document.getElementById('pFlowId') || {}).value, pag = (document.getElementById('pFlowStepId') || {}).value
      if (app !== '200' || pag !== '163' || window.__ncAltPreview) return
      window.__ncAltPreview = true
      const v = Date.now()
      if (!document.querySelector('link[href*="Natcorp_AlteracaoVaga"]')) { const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_AlteracaoVaga.css?v=' + v; document.head.appendChild(l) }
      const carregar = (src, depois) => { const s = document.createElement('script'); s.src = src; s.onload = depois || null; document.body.appendChild(s) }
      const ir = () => carregar('/__nc_preview__/simular-alteracao-p163.js?v=' + v, () => { if (!document.querySelector('script[src*="Natcorp_AlteracaoVaga.js"]')) carregar('/__nc_preview__/Natcorp_AlteracaoVaga.js?v=' + v) })
      if (window.apex && window.apex.jQuery) apex.jQuery(ir); else window.addEventListener('load', ir)
    })
  })
  /* Requisição de Alteração Cadastral (app 200, página 136) */
  await ctx.route(/Natcorp_Cadastro(\.min)?\.(css|js)(\?|$)/, (r) => {
    const ext = r.request().url().match(/\.(css|js)(\?|$)/)[1]
    r.fulfill({ path: AVULSOS + 'Natcorp_Cadastro.' + ext, contentType: (ext === 'css' ? 'text/css' : 'application/javascript') + '; charset=utf-8', headers: { 'cache-control': 'no-store' } })
  })
  await ctx.route(/simular-cadastro-p136\.js/, (r) => r.fulfill({ path: APP + 'simular-cadastro-p136.js', contentType: 'application/javascript; charset=utf-8', headers: { 'cache-control': 'no-store' } }))
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      const app = (document.getElementById('pFlowId') || {}).value, pag = (document.getElementById('pFlowStepId') || {}).value
      if (app !== '200' || pag !== '136' || window.__ncCadPreview) return
      window.__ncCadPreview = true
      const v = Date.now()
      if (!document.querySelector('link[href*="Natcorp_Cadastro"]')) { const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Cadastro.css?v=' + v; document.head.appendChild(l) }
      const carregar = (src, depois) => { const s = document.createElement('script'); s.src = src; s.onload = depois || null; document.body.appendChild(s) }
      const ir = () => carregar('/__nc_preview__/simular-cadastro-p136.js?v=' + v, () => { if (!document.querySelector('script[src*="Natcorp_Cadastro.js"]')) carregar('/__nc_preview__/Natcorp_Cadastro.js?v=' + v) })
      if (window.apex && window.apex.jQuery) apex.jQuery(ir); else window.addEventListener('load', ir)
    })
  })
  /* Requisição de Dependentes (app 200, página 132) */
  await ctx.route(/Natcorp_Dependentes(\.min)?\.(css|js)(\?|$)/, (r) => {
    const ext = r.request().url().match(/\.(css|js)(\?|$)/)[1]
    r.fulfill({ path: AVULSOS + 'Natcorp_Dependentes.' + ext, contentType: (ext === 'css' ? 'text/css' : 'application/javascript') + '; charset=utf-8', headers: { 'cache-control': 'no-store' } })
  })
  await ctx.route(/simular-dependentes-p132\.js/, (r) => r.fulfill({ path: APP + 'simular-dependentes-p132.js', contentType: 'application/javascript; charset=utf-8', headers: { 'cache-control': 'no-store' } }))
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      const app = (document.getElementById('pFlowId') || {}).value, pag = (document.getElementById('pFlowStepId') || {}).value
      if (app !== '200' || pag !== '132' || window.__ncDepPreview) return
      window.__ncDepPreview = true
      const v = Date.now()
      if (!document.querySelector('link[href*="Natcorp_Dependentes"]')) { const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Dependentes.css?v=' + v; document.head.appendChild(l) }
      const carregar = (src, depois) => { const s = document.createElement('script'); s.src = src; s.onload = depois || null; document.body.appendChild(s) }
      const ir = () => carregar('/__nc_preview__/simular-dependentes-p132.js?v=' + v, () => { if (!document.querySelector('script[src*="Natcorp_Dependentes.js"]')) carregar('/__nc_preview__/Natcorp_Dependentes.js?v=' + v) })
      if (window.apex && window.apex.jQuery) apex.jQuery(ir); else window.addEventListener('load', ir)
    })
  })
  /* Requisição de Treinamento e Requisição de Curso (app 200, páginas 118 e 120) */
  await ctx.route(/Natcorp_Treinamento(\.min)?\.(css|js)(\?|$)/, (r) => {
    const ext = r.request().url().match(/\.(css|js)(\?|$)/)[1]
    r.fulfill({ path: AVULSOS + 'Natcorp_Treinamento.' + ext, contentType: (ext === 'css' ? 'text/css' : 'application/javascript') + '; charset=utf-8', headers: { 'cache-control': 'no-store' } })
  })
  await ctx.route(/simular-treinamento-p118\.js/, (r) => r.fulfill({ path: APP + 'simular-treinamento-p118.js', contentType: 'application/javascript; charset=utf-8', headers: { 'cache-control': 'no-store' } }))
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      const app = (document.getElementById('pFlowId') || {}).value, pag = (document.getElementById('pFlowStepId') || {}).value
      if (app !== '200' || (pag !== '118' && pag !== '120') || window.__ncTrePreview) return
      window.__ncTrePreview = true
      const v = Date.now()
      if (!document.querySelector('link[href*="Natcorp_Treinamento"]')) { const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Treinamento.css?v=' + v; document.head.appendChild(l) }
      const carregar = (src, depois) => { const s = document.createElement('script'); s.src = src; s.onload = depois || null; document.body.appendChild(s) }
      const ir = () => carregar('/__nc_preview__/simular-treinamento-p118.js?v=' + v, () => { if (!document.querySelector('script[src*="Natcorp_Treinamento.js"]')) carregar('/__nc_preview__/Natcorp_Treinamento.js?v=' + v) })
      if (window.apex && window.apex.jQuery) apex.jQuery(ir); else window.addEventListener('load', ir)
    })
  })
  /* Dados Funcionais (app 200, página 17): a ficha do colaborador */
  await ctx.route(/Natcorp_Ficha(\.min)?\.(css|js)(\?|$)/, (r) => {
    const ext = r.request().url().match(/\.(css|js)(\?|$)/)[1]
    r.fulfill({ path: AVULSOS + 'Natcorp_Ficha.' + ext, contentType: (ext === 'css' ? 'text/css' : 'application/javascript') + '; charset=utf-8', headers: { 'cache-control': 'no-store' } })
  })
  await ctx.route(/simular-ficha-p17\.js/, (r) => r.fulfill({ path: APP + 'simular-ficha-p17.js', contentType: 'application/javascript; charset=utf-8', headers: { 'cache-control': 'no-store' } }))
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      const app = (document.getElementById('pFlowId') || {}).value, pag = (document.getElementById('pFlowStepId') || {}).value
      if (app !== '200' || pag !== '17' || window.__ncDfPreview) return
      window.__ncDfPreview = true
      const v = Date.now()
      if (!document.querySelector('link[href*="Natcorp_Ficha"]')) { const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Ficha.css?v=' + v; document.head.appendChild(l) }
      const carregar = (src, depois) => { const s = document.createElement('script'); s.src = src; s.onload = depois || null; document.body.appendChild(s) }
      const ir = () => carregar('/__nc_preview__/simular-ficha-p17.js?v=' + v, () => { if (!document.querySelector('script[src*="Natcorp_Ficha.js"]')) carregar('/__nc_preview__/Natcorp_Ficha.js?v=' + v) })
      if (window.apex && window.apex.jQuery) apex.jQuery(ir); else window.addEventListener('load', ir)
    })
  })
  /* Avaliação (app 9118, páginas 140 e 144): a jornada e a pergunta. Até a exportação, o
     simular-avaliacao-p140.js põe as classes pelos títulos. */
  await ctx.route(/Natcorp_Avaliacao(\.min)?\.(css|js)(\?|$)/, (r) => {
    const ext = r.request().url().match(/\.(css|js)(\?|$)/)[1]
    r.fulfill({ path: AVULSOS + 'Natcorp_Avaliacao.' + ext, contentType: (ext === 'css' ? 'text/css' : 'application/javascript') + '; charset=utf-8', headers: { 'cache-control': 'no-store' } })
  })
  await ctx.route(/simular-avaliacao-p140\.js/, (r) => r.fulfill({ path: APP + 'simular-avaliacao-p140.js', contentType: 'application/javascript; charset=utf-8', headers: { 'cache-control': 'no-store' } }))
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      const pag = (document.getElementById('pFlowStepId') || {}).value
      if (window.__ncAvPreview || !((pag === '140' && document.getElementById('P140_COD_AVALIACAO')) || (pag === '144' && document.getElementById('P144_ORDEM_COUNT')))) return
      window.__ncAvPreview = true
      const v = Date.now()
      if (!document.querySelector('link[href*="Natcorp_Avaliacao"]')) { const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Avaliacao.css?v=' + v; document.head.appendChild(l) }
      const carregar = (src, depois) => { const s = document.createElement('script'); s.src = src; s.onload = depois || null; document.body.appendChild(s) }
      const ir = () => carregar('/__nc_preview__/simular-avaliacao-p140.js?v=' + v, () => { if (!document.querySelector('script[src*="Natcorp_Avaliacao.js"]')) carregar('/__nc_preview__/Natcorp_Avaliacao.js?v=' + v) })
      if (window.apex && window.apex.jQuery) apex.jQuery(ir); else window.addEventListener('load', ir)
    })
  })
  /* Janela aberta pelo APEX na página de CIMA (a p140 roda num iframe da p768): o script acima não
     chega nesse iframe no Playwright. A página de cima olha os iframes que carregam e põe o
     desenho neles. (Em produção a p144 carrega os arquivos pelas próprias URLs.) */
  await ctx.addInitScript(() => {
    document.addEventListener('load', (e) => {
      const f = e.target
      if (!f || f.tagName !== 'IFRAME') return
      let w, d
      try { w = f.contentWindow; d = f.contentDocument } catch (x) { return }
      if (!d || w.__ncAvPreview) return
      const pag = (d.getElementById('pFlowStepId') || {}).value
      if (!((pag === '140' && d.getElementById('P140_COD_AVALIACAO')) || (pag === '144' && d.getElementById('P144_ORDEM_COUNT')))) return
      w.__ncAvPreview = true
      const v = Date.now()
      if (!d.querySelector('link[href*="Natcorp_Avaliacao"]')) { const l = d.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Avaliacao.css?v=' + v; d.head.appendChild(l) }
      const carregar = (src, depois) => { const s = d.createElement('script'); s.src = src; s.onload = depois || null; d.body.appendChild(s) }
      carregar('/__nc_preview__/simular-avaliacao-p140.js?v=' + v, () => { if (!d.querySelector('script[src*="Natcorp_Avaliacao.js"]')) carregar('/__nc_preview__/Natcorp_Avaliacao.js?v=' + v) })
    }, true)
  })
  /* Requisição de Escala para Colaborador (janela "Criar/Editar", itens P179_*): Natcorp_Escala */
  await ctx.route(/Natcorp_Escala(\.min)?\.(css|js)(\?|$)/, (r) => {
    const ext = r.request().url().match(/\.(css|js)(\?|$)/)[1]
    r.fulfill({ path: AVULSOS + 'Natcorp_Escala.' + ext, contentType: (ext === 'css' ? 'text/css' : 'application/javascript') + '; charset=utf-8', headers: { 'cache-control': 'no-store' } })
  })
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      if (window.__ncEscPreview || !document.getElementById('P179_COD_ESCALA_CONTAINER')) return
      window.__ncEscPreview = true
      const v = Date.now()
      if (!document.querySelector('link[href*="Natcorp_Escala"]')) { const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Escala.css?v=' + v; document.head.appendChild(l) }
      const ir = () => { if (!document.querySelector('script[src*="Natcorp_Escala.js"]')) { const s = document.createElement('script'); s.src = '/__nc_preview__/Natcorp_Escala.js?v=' + v; document.body.appendChild(s) } }
      if (window.apex && window.apex.jQuery) apex.jQuery(ir); else window.addEventListener('load', ir)
    })
  })
  /* Comunicação de Acidente/Incidente (SEG_CTRL_NATCORP, "Criar/Editar" P91_* e a janela da parte
     do corpo P92_*): Natcorp_Acidente */
  await ctx.route(/Natcorp_Acidente(\.min)?\.(css|js)(\?|$)/, (r) => {
    const ext = r.request().url().match(/\.(css|js)(\?|$)/)[1]
    r.fulfill({ path: AVULSOS + 'Natcorp_Acidente.' + ext, contentType: (ext === 'css' ? 'text/css' : 'application/javascript') + '; charset=utf-8', headers: { 'cache-control': 'no-store' } })
  })
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      if (window.__ncAciPreview || !(document.querySelector('[id$="_ESPEC_LOCAL_ACIDENTE_CONTAINER"]') || document.querySelector('[id$="_LATERALIDADE_CONTAINER"]'))) return
      window.__ncAciPreview = true
      const v = Date.now()
      if (!document.querySelector('link[href*="Natcorp_Acidente"]')) { const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Acidente.css?v=' + v; document.head.appendChild(l) }
      const ir = () => { if (!document.querySelector('script[src*="Natcorp_Acidente.js"]')) { const s = document.createElement('script'); s.src = '/__nc_preview__/Natcorp_Acidente.js?v=' + v; document.body.appendChild(s) } }
      if (window.apex && window.apex.jQuery) apex.jQuery(ir); else window.addEventListener('load', ir)
    })
  })
  /* Consulta de Documentos (app 2210 CONS_GED_NATCORP, página 865): a pasta do colaborador.
     Sem classe no APEX: o .js reconhece a página e o relatório sozinho. */
  await ctx.route(/Natcorp_Documentos(\.min)?\.(css|js)(\?|$)/, (r) => {
    const ext = r.request().url().match(/\.(css|js)(\?|$)/)[1]
    r.fulfill({ path: AVULSOS + 'Natcorp_Documentos.' + ext, contentType: (ext === 'css' ? 'text/css' : 'application/javascript') + '; charset=utf-8', headers: { 'cache-control': 'no-store' } })
  })
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      const app = (document.getElementById('pFlowId') || {}).value, pag = (document.getElementById('pFlowStepId') || {}).value
      if (app !== '2210' || pag !== '865' || window.__ncGedPreview) return
      window.__ncGedPreview = true
      const v = Date.now()
      if (!document.querySelector('link[href*="Natcorp_Documentos"]')) { const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Documentos.css?v=' + v; document.head.appendChild(l) }
      const ir = () => { if (!document.querySelector('script[src*="Natcorp_Documentos.js"]')) { const s = document.createElement('script'); s.src = '/__nc_preview__/Natcorp_Documentos.js?v=' + v; document.body.appendChild(s) } }
      if (window.apex && window.apex.jQuery) apex.jQuery(ir); else window.addEventListener('load', ir)
    })
  })
  /* Requisição de Desligamento (app 200, página 59), ainda sem as classes no APEX: o
     simular-desligamento-p59.js põe as classes, e o Natcorp_Desligamento.css/.js desenham. */
  await ctx.route(/Natcorp_Desligamento(\.min)?\.(css|js)(\?|$)/, (r) => {
    const ext = r.request().url().match(/\.(css|js)(\?|$)/)[1]
    r.fulfill({ path: AVULSOS + 'Natcorp_Desligamento.' + ext, contentType: (ext === 'css' ? 'text/css' : 'application/javascript') + '; charset=utf-8', headers: { 'cache-control': 'no-store' } })
  })
  await ctx.route(/simular-desligamento-p59\.js/, (r) => r.fulfill({ path: APP + 'simular-desligamento-p59.js', contentType: 'application/javascript; charset=utf-8', headers: { 'cache-control': 'no-store' } }))
  await ctx.addInitScript(() => {
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => {
      const app = (document.getElementById('pFlowId') || {}).value, pag = (document.getElementById('pFlowStepId') || {}).value
      if (app !== '200' || pag !== '59' || window.__ncDeslPreview) return
      window.__ncDeslPreview = true
      const v = Date.now()
      if (!document.querySelector('link[href*="Natcorp_Desligamento"]')) { const l = document.createElement('link'); l.rel = 'stylesheet'; l.href = '/__nc_preview__/Natcorp_Desligamento.css?v=' + v; document.head.appendChild(l) }
      const carregar = (src, depois) => { const s = document.createElement('script'); s.src = src; s.onload = depois || null; document.body.appendChild(s) }
      const ir = () => carregar('/__nc_preview__/simular-desligamento-p59.js?v=' + v, () => { if (!document.querySelector('script[src*="Natcorp_Desligamento.js"]')) carregar('/__nc_preview__/Natcorp_Desligamento.js?v=' + v) })
      if (window.apex && window.apex.jQuery) apex.jQuery(ir); else window.addEventListener('load', ir)
    })
  })
  await ctx.addInitScript(() => {
    if (window.__ncPreview) return
    window.__ncPreview = true
    const URL_CSS = '/__nc_preview__/Natcorp_Preview.css'
    let assinatura = ''
    const assinar = (t) => { let h = 0; for (let i = 0; i < t.length; i += 7) h = (h * 31 + t.charCodeAt(i)) | 0; return t.length + ':' + h }
    const aplicar = (primeira) => {
      const velho = document.getElementById('nc-preview') || document.querySelector('link[href*="Natcorp_Login.css"]')
      // na primeira conferência o <link> real já trouxe o arquivo local: não troca nada
      if (primeira && velho) { velho.id = 'nc-preview'; return }
      const novo = document.createElement('link')
      novo.id = 'nc-preview'
      novo.rel = 'stylesheet'
      novo.href = URL_CSS + '?v=' + Date.now()
      // o novo entra no MESMO lugar do velho e só então o velho sai: a tela não pisca
      novo.onload = () => velho && velho !== novo && velho.remove()
      if (velho && velho.parentNode) velho.parentNode.insertBefore(novo, velho.nextSibling)
      else document.head.appendChild(novo)
    }
    const conferir = async () => {
      try {
        const t = await (await fetch(URL_CSS + '?c=' + Date.now(), { cache: 'no-store' })).text()
        const a = assinar(t)
        if (a !== assinatura) { const primeira = !assinatura; assinatura = a; aplicar(primeira); marcar() }
      } catch (e) {}
    }
    const marcar = () => {
      if (window.top !== window) return
      let s = document.getElementById('nc-preview-selo')
      if (!s) {
        s = document.createElement('div')
        s.id = 'nc-preview-selo'
        s.style.cssText = 'position:fixed;left:12px;bottom:12px;z-index:2147483647;pointer-events:none;' +
          'font:600 11.5px/1 Manrope,system-ui,sans-serif;color:#fff;background:rgba(27,18,56,.82);' +
          'padding:7px 11px;border-radius:999px;box-shadow:0 6px 18px -8px rgba(0,0,0,.5)'
        document.body.appendChild(s)
      }
      s.textContent = '● CSS local · ' + new Date().toLocaleTimeString('pt-BR')
    }
    ;(f => document.readyState === 'loading' ? document.addEventListener('DOMContentLoaded', f) : f())(() => { conferir(); setInterval(conferir, 2000) })
  })
  /* Faxina: assim que uma cópia atualizada (#nc-preview) termina de carregar, a cópia do
     <head> — servida no carregamento da página, com o CSS daquele momento — sai. Sem isto,
     uma regra APAGADA da fonte continuaria valendo pela cópia velha até o F5. Guarda própria
     (__ncFaxina2): roda mesmo num navegador que já tinha uma versão anterior deste script.
     Observa o `document`, não o `documentElement`: o script roda antes de o <html> existir,
     e observe(null) lançava exceção (a 1ª versão morreu assim, com a guarda já marcada). */
  await ctx.addInitScript(() => {
    if (window.__ncFaxina2) return
    window.__ncFaxina2 = true
    const faxinar = (link) => link.addEventListener('load', () => {
      document.querySelectorAll('link[href*="Natcorp_Login.css"]').forEach((velho) => velho !== link && velho.remove())
    }, { once: true })
    new MutationObserver((mudancas) => {
      for (const m of mudancas) for (const n of m.addedNodes) if (n.id === 'nc-preview' && n.tagName === 'LINK') faxinar(n)
    }).observe(document, { childList: true, subtree: true })
  })
  await page.reload()
  return 'pré-visualização ligada em ' + page.url()
}
