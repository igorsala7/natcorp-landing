// Mede o que outra folha do APEX impõe no login e esta ainda não desfaz.
//
// Para cada elemento do login (e seus ::before/::after), lista as propriedades que o
// Natcorp_Style_Min.css declara e o Natcorp_Login.css NÃO declara — prioridade não decide
// essas, só um "zerar" explícito — com o valor que o elemento tem com aquela folha
// desligada, em 1440 e 1100 px. O que muda entre as duas larguras vem marcado RESPONSIVO:
// escreva à mão (auto, none), nunca o px medido.
//
// Rodar no Playwright (MCP browser_run_code), com o login do app aberto. O resultado vira
// a seção "Zerar o outro redesenho do login" de Natcorp_Login.src.css.
// Ajuste o caminho do CSS abaixo para o seu checkout.
async (page) => {
  const CSS = '/caminho/para/brand/apex/login/Natcorp_Login.css'
  const coletar = () => page.evaluate(() => {
    const natcorp = [...document.styleSheets].find(s => /Natcorp_Style_Min\.css/.test(s.href || ''));
    const nossa = [...document.styleSheets].find(s => !s.href && [...s.cssRules].some(r => (r.selectorText || '').includes('nc-p1')));
    const els = [...new Set([document.documentElement, document.body, document.getElementById('wwvFlowForm'), ...document.querySelectorAll('.t-Body, .t-Body *, .t-Login-container, .t-Login-container *')])].filter(e => e === document.documentElement || e.getClientRects().length || e.matches('.t-Login-header,.t-Login-body,.t-Login-container'));
    const nome = (e) => e === document.documentElement ? 'html' : e === document.body ? 'body' : e.id === 'wwvFlowForm' ? '#wwvFlowForm' : (() => { const c = [...e.classList].filter(c => /^(t-|apex-item-|a-)/.test(c) && !/--(hot|icon|iconRight|gapTop|gapBottom|colorBG|wizard|defaultIcons|success)$/.test(c)); return e.tagName.toLowerCase() + (c[0] ? '.' + c[0] : ''); })();
    const regras = (sheet) => { const out = []; const walk = (rs) => { for (const r of rs) { if (r.cssRules && !r.selectorText) { if (!r.media || matchMedia(r.media.mediaText).matches) walk(r.cssRules); } else if (r.selectorText) out.push(r); } }; walk(sheet.cssRules); return out; };
    const declara = (sheet) => { const m = new Map(); for (const r of regras(sheet)) for (const parte of r.selectorText.split(/,(?![^(]*\))/)) { const ps = /::?(before|after)\s*$/.test(parte) ? '::' + parte.match(/::?(before|after)\s*$/)[1] : ''; const base = parte.replace(/::?(before|after|placeholder|-webkit-input-placeholder)\s*$/, '').trim() || '*'; for (const e of els) { let ok = false; try { ok = e.matches(base); } catch (x) {} if (!ok) continue; const k = nome(e) + ps; const s = m.get(k) || new Set(); for (let i = 0; i < r.style.length; i++) if (!r.style[i].startsWith('--')) s.add(r.style[i]); m.set(k, s); } } return m; };
    const deles = declara(natcorp), nossos = declara(nossa);
    const alvo = {}; for (const [k, s] of deles) { const f = [...s].filter(p => !(nossos.get(k) || new Set()).has(p)); if (f.length) alvo[k] = f; }
    natcorp.disabled = true;
    const limpo = {}; for (const e of els) for (const ps of ['', '::before', '::after']) { const k = nome(e) + ps; if (!alvo[k]) continue; const cs = getComputedStyle(e, ps || null); limpo[k] = limpo[k] || {}; for (const p of alvo[k]) { const v = cs.getPropertyValue(p); if (limpo[k][p] !== undefined && limpo[k][p] !== v) limpo[k][p] = '§VARIA§'; else limpo[k][p] = v; } }
    natcorp.disabled = false;
    return limpo;
  });
  await page.setViewportSize({ width: 1440, height: 900 });
  await page.reload();
  await page.evaluate(() => document.querySelector('link[href*="Natcorp_Login.css"]')?.remove());
  await page.addStyleTag({ path: CSS });
  await page.evaluate(() => document.fonts.ready);
  await page.waitForTimeout(500);
  const a = await coletar();
  await page.setViewportSize({ width: 1100, height: 760 }); await page.waitForTimeout(400);
  const b = await coletar();
  await page.setViewportSize({ width: 1440, height: 900 });
  const out = {}; for (const k of Object.keys(a)) { out[k] = {}; for (const p of Object.keys(a[k])) out[k][p] = a[k][p] === (b[k] || {})[p] ? a[k][p] : [a[k][p], (b[k] || {})[p], 'RESPONSIVO']; }
  return JSON.stringify(out);
}
