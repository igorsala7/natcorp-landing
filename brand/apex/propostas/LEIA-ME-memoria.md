# Vazamento de memória na casca (200:791) — medido e CORRIGIDO em 07/10/2026

**Aplicado (com o ok do usuário) em `brand/apex/login/Natcorp_Allow_Unload_Iframes.js`.** O arquivo de antes está em
`Natcorp_Allow_Unload_Iframes.antes-0710.js`; o `.memoria.diff` mostra tudo o que mudou.

## O que acontece
`Natcorp_Allow_Unload_Iframes.js` (arquivo da equipe), módulos **barra de rolagem horizontal flutuante** (linhas ~1614–1999)
e **cabeçalho grudento via JavaScript** (~2027–2494): quando rodam DENTRO de um iframe, criam elementos no `<body>` da
página de CIMA (`CONTEXTO_TELA.body.appendChild($barra[0])` e `...($wrapper[0])`) e prendem ouvintes `scroll`/`resize`
nela. Nada disso é removido quando a página do iframe é trocada. Os elementos órfãos seguram a página antiga inteira
(DOM, CSS de 1,3 MB, scripts) — **um documento a mais preso por página aberta na casca**.

## Medido (aba de teste, casca 200:791 com REQ_PESSOAL_NATCORP:51, 6 trocas de página, coleta de lixo forçada)
| Arquivo | Documentos | Nós |
|---|---|---|
| atual | 9 → **15** | 8.000 → **17.348** |
| sem o arquivo | 9 → 9 | igual |
| sem só os módulos 5 e 6 | 9 → 9 | igual |
| **corrigido** (`Natcorp_Allow_Unload_Iframes.corrigido.js`) | 9 → **9** | 8.000 → **8.000** |

Na casca, após 3 trocas: atual = 4 `.nc-hscroll-float` empilhadas; corrigido = 1 (a da página aberta). A barra e o
cabeçalho continuam funcionando.
Numa aba usada pelo usuário por alguns minutos: 19 documentos e 76 mil nós vivos (uma aba nova: ~9 e ~8 mil), processo
da aba em 377 MB.

## A correção (diff em `Natcorp_Allow_Unload_Iframes.memoria.diff`)
Nos dois módulos: guarda o que foi criado na página de cima e, no `pagehide` do iframe, remove esses elementos e solta
os ouvintes `scroll`/`resize` da página de cima. Nada muda quando a página não está num iframe.

## Também corrigido no mesmo arquivo (07/10)
- `var DEBUG = false` (o `log()` mandava os próprios iframes para o console, que os segura com o DevTools aberto).
- `atualizarTudo` (de 1 em 1 s, nos dois módulos) não faz nada com a aba em segundo plano (`document.hidden`).
- "Maximizar (TESTE)": trocar de página com a região maximizada deixava a região na casca, por cima de tudo (e presa na
  memória). Agora sai no `pagehide`, com o Esc e a classe do body. Testado: antes 1 região sobrando, depois 0.
