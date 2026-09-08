# Product — Sistema Natcorp em Oracle APEX

<!-- impeccable:product-schema 1 -->

Registro do **sistema interno em Oracle APEX** da Natcorp, o produto que os clientes operam.
É um registro próprio, irmão do site institucional documentado no `README.md` da raiz: as duas
superfícies compartilham a marca, mas não os usuários, nem o modo de uso, nem as restrições.

## Platform

web

## Users

**Operador de RH/DP** — passa a jornada inteira dentro do sistema. Vive no *Painel do Operador*
(app 200): Colaboradores, folha, eSocial, carga de dados, consultas, relatórios. Conhece o sistema
de cor, trabalha por varredura e repetição, e mede o dia em quantas linhas conseguiu resolver.
Telas densas são ferramenta de trabalho, não defeito.

**Gestor** — entra pontualmente, com um objetivo fechado. Vive no *Painel do Gestor* (app 100):
aprovar requisições, consultar o time, abrir uma alteração funcional, ver aniversários e
organograma. Não conhece o sistema; cada visita é um reencontro.

Confirmado pelo cliente: **as duas jornadas pesam igual**. Quando densidade e clareza entrarem em
conflito, a decisão é tomada tela a tela — densidade nas telas do operador, clareza nas do gestor —
e nunca por uma regra única aplicada ao sistema inteiro.

**Outros públicos evidenciados nas páginas salvas, ainda não priorizados:** recrutadores e
candidatos (apps 700, 9113, 9610 — *Recrutamento e Seleção*) e usuários de assinatura de documentos
(app 9300 — *NatDocs*, com cadastro de usuários, assistente de assinatura e configuração LDAP).

## Product Purpose

Sistema de gestão de pessoas para grandes empresas, reunindo Departamento Pessoal, Recursos Humanos
e Medicina e Segurança do Trabalho em uma base única, com mais de 30 módulos integrados. É o produto
que a landing institucional vende sob a frase "Todo o RH. Um único sistema."

Sucesso, para este registro: o cliente reconhece a Natcorp na tela e o trabalho do dia sai mais
rápido — sem que ninguém precise reaprender onde as coisas ficam.

## Positioning

Escopo integrado (DP + RH + SESMT na mesma base) com mais de 35 anos de operação em folhas de
grande porte, mais a NATI atuando dentro do sistema. O que um concorrente não copia sem mentir é a
amplitude do escopo somada ao tempo de estrada em folha complexa.

## Operating Context

Seis aplicações APEX em produção, todas sob o mesmo tema e a mesma folha de estilo global:

| App | O que é | Páginas de referência salvas |
| --- | --- | --- |
| 100 | Painel do Gestor, requisições (pessoal, desligamento, férias, alteração funcional, posição, benefícios, exames, ponto) | `f100-1`, `f100-115`, `f100-116`, `100-1500` |
| 200 | Painel do Operador, Colaboradores, Linha do Tempo, feedbacks | `200-2`, `200-13`, `200-108` |
| 700 / 9113 / 9610 | Recrutamento e Seleção (inclusive páginas-moldura com iframe) | `700-68`, `9113-*`, `9610-30` |
| 9300 | NatDocs: usuários, assistente de assinatura, processos, LDAP | `9300-*`, `f9300-*` |

- **Ambientes:** desenvolvimento/apresentação em `natcorpbr.com.br/apex/dev` (dados fictícios,
  credenciais fornecidas pelo cliente) e produção. Existe um aviso de homologação injetado por JS
  (`aviso-homologacao.js`).
- **Uso real:** jornada inteira no desktop para o operador; visitas curtas para o gestor. Há
  páginas com iframe, modais sobre modais, Interactive Reports de 12 colunas, Interactive Grid
  editável, organograma em Google Charts e botões flutuantes (NATI e chamado interno).
- **Navegadores e zoom ainda não confirmados pelo cliente.** O material herdado assume Chrome e
  Edge no desktop mais celular, e zoom entre 90% e 125%; tratar como hipótese até confirmação.

## Capabilities and Constraints

**Restrição dura, confirmada pelo cliente e acima de qualquer ambição visual:**
a entrega é **um único arquivo CSS global**, carregado por cima dos estilos padrão do APEX.
Nenhum outro objeto pode ser alterado — nem template, nem página, nem item, nem processo,
nem JavaScript, nem atributo de região ou de gráfico. Dentro do CSS a liberdade é ampla
(reorganizar layout, esconder cromo, reordenar com `order`, gerar conteúdo com `::before`),
mas nada sai do arquivo.

Consequência direta: continuam **fora de escopo** o Theme Roller, as opções de template, classes de
página por tela, o relatório padrão do Interactive Report e as cores de série dos gráficos JET —
mesmo quando forem o caminho mais curto para o resultado.

**Ambiente técnico** (verificado nas páginas salvas):

- Oracle APEX **19.2.0.00.18**, Universal Theme (`Core.min.css` + `Theme-Standard.min.css`),
  estilo compilado pelo Theme Roller (`5600920228396345731.css`, `13128045157688011527.css`),
  Font APEX, Oracle JET (`oj-alta`) nos gráficos, jQuery UI, Select2, SweetAlert2, Alertify,
  toastr, `theme42.js`.
- **Ordem de carga do CSS** (a brecha que a máscara usa): `oj-alta` → `Core.min` →
  `Theme-Standard.min` → tema do Theme Roller → `Natcorp_Style_Min.css` → *a máscara entra aqui*.
- O `Natcorp_Style_Min.css` em produção hoje tem ~14 KB, não é minificado apesar do nome, e usa
  `!important` em larga escala. É o baseline atual.
- Largura do menu (240 px), altura do cabeçalho (48 px) e os deslocamentos de `t-Body-nav` /
  `t-Body-side` são calculados pelo tema e pelo `theme42.js`, não por CSS estático.
- App 9300 (NatDocs) carrega ainda `Natcorp_Style.css` e `Natcorp_Zoom_Mobile.css`, que **não estão
  no material entregue**.

**Decisões confirmadas pelo cliente:**

1. **A entrega substitui o `Natcorp_Style_Min.css`.** Um único arquivo novo toma o lugar do atual em
   *File URLs*. A folha nasce limpa: não herda os `!important` acumulados nem os blocos comentados,
   e não precisa vencer o arquivo anterior — precisa apenas vencer o tema. O rollback é repor o
   arquivo antigo, que fica versionado aqui.
2. **A máscara v1 foi descartada por ficar longe do modelo**, não por quebrar nada. O diagnóstico é
   de ambição, não de risco: ela melhorou a superfície e continuou com cara de APEX. A próxima
   versão precisa ir materialmente mais longe dentro do mesmo limite de um arquivo CSS.
3. **Navegadores:** Chrome, Edge, Safari e Firefox atuais; sem legado. Estão liberados `:has()`,
   `grid`, container queries e CSS moderno em geral — a alavanca decisiva para uma máscara que só
   pode agir por folha de estilo.

**Ainda em aberto:** níveis de zoom oficialmente suportados e as duas folhas do app 9300
(`Natcorp_Style.css`, `Natcorp_Zoom_Mobile.css`), que não vieram no material.

## Brand Commitments

- **Manual de Identidade Visual Natcorp v1.2** (setembro de 2026) — vinculante. Tokens em
  `tailwind.config.js` (`colors.brand`) e `src/index.css` na raiz do repositório.
- **Manrope** como tipografia da marca; arquivos `woff2` self-hosted já preparados em
  `brand/apex/fonts/` para ambientes sem acesso ao Google Fonts.
  **Dependência de publicação, medida em 07/09/2026:** os dois `woff2` respondem **404** no
  ambiente (`.../static/v995/`), e a página do APEX não carrega nenhum link de Google Fonts.
  Enquanto não forem subidos junto com o CSS, o `@font-face` falha e a tipografia inteira cai
  para fonte de sistema — a calibragem foi feita em Manrope. Ver `trabalho/publicacao.md`.
- **Layout-alvo declarado vinculante pelo cliente:** `brand/app-referencia/natcorp-app.html` —
  a aplicação SaaS de referência com a identidade Natcorp.
- **Protótipo do novo módulo** (fora do APEX) disponível em `http://localhost:3015` — modo
  apresentação, opção Admin. Referência secundária de linguagem visual.
- O símbolo, os ícones dos 31 módulos e a geometria do logotipo já existem em vetor
  (`public/brand/`, `brand/modulos/`, `src/components/brand/logo-paths.ts`).

## Evidence on Hand

**Existe:**

- 32 páginas APEX salvas com HTML, CSS e JS completos, em `brand/apex/APEX Style/APEX/`.
- 11 capturas do sistema atual em `brand/apex/APEX Style/APEX/Screens/`.
- `Natcorp_Style_Min.css` (o que está em produção) e `original_Natcorp_Style_Min.css`.
- Acesso ao ambiente de apresentação com dados fictícios, cedido pelo cliente.
- Protótipo do novo módulo rodando localmente.
- Máscara v1 (`Natcorp_Style_Modern.css`, 1750 linhas) com `LEIA-ME.md`, capturas antes/depois e
  roteiro de teste — **descartada pelo cliente**. Vale como evidência de uma tentativa e como
  levantamento técnico do tema; não é fundação para a próxima versão.

**Não existe — e não pode ser inventado:**

- Pesquisa com usuários, entrevistas, testes de usabilidade.
- Métricas de uso, telas mais acessadas, tempo de tarefa, volume de erros.
- Auditoria de acessibilidade.
- Qualquer número de desempenho, satisfação ou adoção.

## Product Principles

1. **Nada pode quebrar.** Funcionalidade existente é intocável; entre um ganho visual e um risco
   funcional, o risco decide.
2. **A entrega cabe em um arquivo, e o rollback em uma linha.** Toda ambição precisa passar por
   essa agulha.
3. **As duas jornadas pesam igual.** Operador e gestor não competem: cada tela é resolvida pelo
   trabalho que acontece nela.
4. **Modernizar não pode custar produtividade a quem já sabe usar.** Quem opera o sistema há anos
   precisa continuar encontrando tudo onde estava, no mesmo número de cliques.
5. **Consistência vale mais que efeito.** O sistema tem hoje dois estilos de botão, quatro sistemas
   de mensagem e regiões com tratamentos diferentes; unificar rende mais do que qualquer novidade.

## Accessibility & Inclusion

- O sistema tem **Modo de Leitor de Tela** nativo do APEX, acessível pelo rodapé. É funcionalidade
  existente e não pode ser prejudicada.
- As páginas trazem os papéis ARIA do Universal Theme (`tree`, `treeitem`, `tablist`, `tab`,
  `tabpanel`, `combobox`, `menu`, `navigation`). CSS que os esvazie visualmente — esconder um
  elemento que o leitor anuncia, ou remover a marca de foco — quebra acessibilidade sem quebrar
  função, e por isso passa despercebido.
- **Foco visível** precisa sobreviver em botões, links, campos e itens de menu.
- Nenhum padrão formal (WCAG e nível) foi estabelecido pelo cliente. A confirmar.
