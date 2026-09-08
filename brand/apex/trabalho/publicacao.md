# Publicação — o que precisa acontecer para a folha funcionar em produção

Medido em 07/09/2026 no ambiente de homologação (`natcorpbr.com.br/apex/dev`).

## 1. As fontes NÃO estão no servidor — bloqueador

```
GET /apex/dev/natcorp/r/files/static/v995/manrope-latin.woff2      → 404
GET /apex/dev/natcorp/r/files/static/v995/manrope-latin-ext.woff2  → 404
```

A folha declara `src:url("#WORKSPACE_IMAGES#manrope-latin.woff2")`. O token só resolve para o
diretório onde ficam os arquivos estáticos — hoje `.../static/v995/`. Sem os dois `woff2` lá,
o `@font-face` falha e **toda a tipografia cai para fonte de sistema**: título de região,
micro-caixa-alta de 11px, `tabular-nums` das colunas numéricas, a escala de meios-pontos
(15,5 · 13,5 · 12,5 · 11,5 · 10,5). A calibragem inteira foi feita em Manrope.

Verificado também: **a página do APEX não carrega nenhum link de Google Fonts.** Não há
segunda fonte de Manrope no ambiente. Se o `@font-face` falhar, não há de onde ela vir.

Os arquivos existem prontos em `brand/apex/fonts/`. Subir os dois junto com o CSS.

> Isto passou despercebido durante quase toda a sessão porque o servidor de pré-visualização
> local servia os `woff2` pelo nome do arquivo. A fonte aparecia nas medições ao vivo, mas
> vinha do laço de teste, não do ambiente. Lição: um rig de teste que preenche uma lacuna do
> ambiente esconde exatamente a lacuna que ele preenche.

## 2. Registrar a folha em *File URLs*

`Natcorp_UI.css` substitui `Natcorp_Style_Min.css` nos apps **100, 200, 700, 9113, 9610 e 2010**.

- O **2010** foi descoberto por estar dentro de um iframe — não aparece na navegação normal.
- O **9300** (NatDocs) fica de fora por decisão do cliente: carrega ainda `Natcorp_Style.css` e
  `Natcorp_Zoom_Mobile.css`, que não vieram no material.
- O caminho estático é versionado (`v986` → `v995` entre o material entregue e hoje). Conferir
  a versão corrente antes de montar a URL.

## 3. Rollback

Repor o `Natcorp_Style_Min.css` anterior em *File URLs*. O arquivo está versionado no repositório
em `brand/apex/APEX Style/APEX/`.

## Como medir sem publicar

Não é mais necessário servidor local. O Playwright lê o arquivo do disco e injeta:

```js
await page.evaluate(() => {                       // ambiente limpo
  document.querySelectorAll('style').forEach(s => {
    if (/--nc-azul|--nc-roxo/.test(s.textContent || '')) s.remove();
  });
  for (const l of document.querySelectorAll('link[rel=stylesheet]'))
    if (/Natcorp_Style_Min\.css/.test(l.href)) l.disabled = true;
});
// Manrope: o ambiente não a tem, e sem ela a métrica medida é de outra fonte
await page.addStyleTag({ url: 'https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&display=block' });
await page.addStyleTag({ path: '…/brand/apex/Natcorp_UI.css' });
```

**Sempre remover injeções anteriores.** Uma cópia velha da folha (`nc-v2`, 75 KB) ficou aplicada
por várias medições desta sessão sem que eu notasse; as conclusões foram refeitas em ambiente
limpo e se confirmaram, mas a contaminação era real.
