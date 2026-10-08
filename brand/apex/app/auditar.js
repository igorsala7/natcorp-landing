// Auditoria de ícones e cantos na página aberta (MCP browser_evaluate, com o conteúdo desta função).
// Ícone: CORTADO (caixa menor que o glifo, ou recortado por ancestral com overflow oculto) ou
// DESCENTRALIZADO (em recipiente só de ícone, centro a mais de 1,5 px do centro do recipiente).
// Cartão: região com borda cujo raio não é o padrão, ou cujo filho com fundo cobre o canto.
() => {
  const vis = (e) => { const r = e.getBoundingClientRect(); const s = getComputedStyle(e); return r.width > 0 && r.height > 0 && s.visibility !== 'hidden' && s.display !== 'none'; };
  const nome = (e) => e.tagName.toLowerCase() + (e.id ? '#' + e.id : '') + '.' + [...e.classList].filter(c => !/^fa-(fw|lg)$/.test(c)).slice(0, 3).join('.');
  const onde = (e) => { const c = e.closest('.t-Region, .t-Header, .t-Body-nav, .t-Body-title, .ui-dialog'); const t = c?.querySelector('.t-Region-title')?.innerText?.trim(); return c ? (t ? '«' + t.slice(0, 24) + '»' : nome(c).slice(0, 30)) : '?'; };
  const icones = [...document.querySelectorAll('.t-Icon, .fa, .apex-item-icon, .a-Icon, .ui-icon')].filter(vis).filter(e => { const b = getComputedStyle(e, '::before'); return b.content && b.content !== 'none' && b.content !== '""' || /fa-|icon-/.test(e.className); });
  const problemas = [];
  for (const i of icones) {
    const r = i.getBoundingClientRect(); const b = getComputedStyle(i, '::before'); const fs = parseFloat(getComputedStyle(i).fontSize);
    const bw = parseFloat(b.width) || fs, bh = parseFloat(b.height) || fs;
    if (r.width + 0.5 < Math.min(bw, fs) || r.height + 0.5 < Math.min(bh, fs)) problemas.push(`CORTADO (caixa ${Math.round(r.width)}×${Math.round(r.height)} < glifo ${Math.round(Math.min(bw, fs))}) ${nome(i)} em ${onde(i)}`);
    let a = i.parentElement;
    while (a && a !== document.body) { const s = getComputedStyle(a); if (/hidden|clip/.test(s.overflow + s.overflowX + s.overflowY)) { const ra = a.getBoundingClientRect(); if (r.left < ra.left - .5 || r.right > ra.right + .5 || r.top < ra.top - .5 || r.bottom > ra.bottom + .5) { problemas.push(`CORTADO por ${nome(a).slice(0, 40)} (ícone ${Math.round(r.left)}–${Math.round(r.right)} × ${Math.round(r.top)}–${Math.round(r.bottom)}, recipiente ${Math.round(ra.left)}–${Math.round(ra.right)} × ${Math.round(ra.top)}–${Math.round(ra.bottom)}) ${nome(i)} em ${onde(i)}`); } break; } a = a.parentElement; }
    const cont = i.closest('.t-Card-icon, .t-MediaList-icon, .t-Button--noLabel, .t-Button--headerTree, .a-Button--popupLOV, .ui-datepicker-trigger, .a-Button--calendar, .ui-dialog-titlebar-close, .t-Region-headerIcon');
    if (cont && vis(cont)) { const rc = cont.getBoundingClientRect(); const dx = (r.left + r.width / 2) - (rc.left + rc.width / 2), dy = (r.top + r.height / 2) - (rc.top + rc.height / 2); if (Math.abs(dx) > 1.5 || Math.abs(dy) > 1.5) problemas.push(`DESCENTRALIZADO dx=${dx.toFixed(1)} dy=${dy.toFixed(1)} ${nome(i)} em ${nome(cont).slice(0, 36)} ${onde(i)}`); }
  }
  const cartoes = [];
  for (const g of [...document.querySelectorAll('.t-Region, .t-Card, .t-MediaList-itemWrap, .t-BadgeList-wrap, .ui-dialog, .apex-rds')].filter(vis)) {
    const s = getComputedStyle(g); if (s.borderTopWidth === '0px' && s.boxShadow === 'none' && s.backgroundColor === 'rgba(0, 0, 0, 0)') continue;
    const cantos = [s.borderTopLeftRadius, s.borderTopRightRadius, s.borderBottomRightRadius, s.borderBottomLeftRadius].map(parseFloat);
    if (new Set(cantos).size > 1 || cantos[0] === 0) cartoes.push(`RAIO DESIGUAL ${cantos.join('/')} ${nome(g).slice(0, 50)} ${onde(g)}`);
    const R = cantos[0]; if (!R || s.overflow !== 'visible') continue; const rg = g.getBoundingClientRect();
    for (const f of g.querySelectorAll(':scope > *, :scope > * > *')) { if (!vis(f)) continue; const fs = getComputedStyle(f); if (fs.backgroundColor === 'rgba(0, 0, 0, 0)' && fs.backgroundImage === 'none') continue; const rf = f.getBoundingClientRect(); const topo = Math.abs(rf.top - rg.top) < 2, base = Math.abs(rf.bottom - rg.bottom) < 2; if ((topo && parseFloat(fs.borderTopLeftRadius) < R - 2) || (base && parseFloat(fs.borderBottomLeftRadius) < R - 2)) cartoes.push(`FILHO COBRE O CANTO ${nome(f).slice(0, 40)} (fundo ${fs.backgroundColor}, raio ${fs.borderTopLeftRadius}/${fs.borderBottomLeftRadius}) em ${nome(g).slice(0, 34)} ${onde(g)}`); }
  }
  return { url: location.search.slice(0, 30), iconesVistos: icones.length, problemasIcone: [...new Set(problemas)], cartoes: [...new Set(cartoes)] };
}
