---
name: documento-tecnico
description: Cria e atualiza documentos técnicos em PDF da Natcorp para TI, Segurança da Informação, auditoria e jurídico de clientes (ex.: "Infraestrutura e segurança", "NatPonto por dentro"), no padrão visual da marca (A4, capa, capítulos, cartões, infográficos SVG, questionário de fornecedor). Usar quando pedirem um documento, whitepaper, dossiê técnico ou de segurança, resposta a questionário de fornecedor em formato de documento, ou alteração nos PDFs existentes.
---

# Documento técnico Natcorp

Pedido do dono, 21/10/2026: *"Gostaria que essa parte de criação de documentação estivesse no projeto
natcorp-landing também, com todas as instruções que foram utilizadas [...] para que os documentos
saiam na mesma qualidade e formato."*

Esta skill reúne o processo e o motor que geraram o **"NatPonto por dentro"** (47 páginas, out/2026) e o
**"Infraestrutura e segurança"** (23 páginas, 21/10/2026). Os dois foram migrados para cá e são
regerados por este motor **idênticos pixel a pixel** aos originais.

## Onde as coisas moram

| | |
|---|---|
| Motor (vai para o git) | `.claude/skills/documento-tecnico/toolkit/` |
| Regras e referências | `.claude/skills/documento-tecnico/referencia/` |
| Documentos de trabalho (fora do git) | `material-interno/documentos-tecnicos/<slug>/` |
| Exemplos completos | `material-interno/documentos-tecnicos/infraestrutura-e-seguranca/` e `natponto-por-dentro/` |

Cada documento: `documento.config.mjs` (capa, contracapa, rodapé, figuras, ícones, larguras, ajustes),
`conteudo.md` (o texto, com marcadores), `figuras/fig_*.mjs` (infográficos), `assets/` (imagens),
`fonte/` (notas com citações e textos brutos), `INTERNO - NAO ENVIAR - ...md` (lacunas e divergências)
e, depois de gerar, `build/` (HTML, SVGs, PNGs) e o PDF final.

`material-interno/` está no `.gitignore` de propósito: fontes brutas, questionários de clientes e o
relatório INTERNO nunca devem ir para o repositório.

## Preparar o ambiente (uma vez por máquina)

```bash
cd .claude/skills/documento-tecnico/toolkit && npm install      # marked + playwright-core
python3 -c "import pymupdf, PIL"                                  # PyMuPDF e Pillow (pip install pymupdf pillow)
```
O PDF é impresso pelo Chrome de testes do Playwright (`~/Library/Caches/ms-playwright/chromium-*`), achado
sozinho; para outro Chrome, `CHROME_PATH=...`. Sem nenhum, `npx playwright-core install chromium` na
pasta do toolkit. **Instale sempre dentro do toolkit**: rodar `npm i` numa pasta sem `package.json`
grava na pasta pessoal do usuário (aconteceu em 21/10/2026).

## Comandos

```bash
# documento novo (cria material-interno/documentos-tecnicos/<slug>/ com modelos)
node .claude/skills/documento-tecnico/toolkit/novo.mjs <slug> "Título linha 1" "linha 2 em destaque"

# gerar figuras + HTML + PDF + PNGs (rodar da raiz do natcorp-landing)
node .claude/skills/documento-tecnico/toolkit/gerar.mjs material-interno/documentos-tecnicos/<slug>
#   --sem-png  pula as prévias   ·   --so-html  só monta o HTML
```

## O processo (na ordem)

1. **Briefing.** Preencher `fonte/00_briefing.md`: pedido nas palavras do dono, público, fontes,
   esqueleto de capítulos. Se faltar contexto que só o dono tem (público, o que pode ser dito), perguntar
   antes de escrever.
2. **Fontes.** Levantar e anotar com citação literal e origem → `referencia/fontes.md`. Fontes grandes:
   agentes em paralelo, um por grupo, cada um gravando seu arquivo de notas.
3. **Cruzar.** Comparar números e afirmações entre fontes; a versão mais conservadora vai para o PDF, a
   divergência vai para o INTERNO.
4. **Escrever** `conteudo.md` com os marcadores (`referencia/marcadores.md`) e as regras de
   `referencia/redacao.md`: **só o que está conforme**, zero travessão, sem endpoints, IPs, chaves ou
   nomes de clientes.
5. **Figuras** em `figuras/` seguindo a gramática de `referencia/figuras.md`; copie a figura mais parecida
   dos documentos existentes em vez de começar do zero.
6. **Gerar** e **revisar visualmente**: `build/png/folha-1.png` (visão geral) e as páginas de figura em
   tamanho real. Corrigir caixa com sobra, página quase vazia, rótulo sobreposto, selo invisível.
7. **Checklist** (`referencia/checklist.md`) e **relatório INTERNO** atualizado.
8. **Entregar**: caminho do PDF, o que mudou, o que foi verificado e o que depende do dono.

## O que já foi decidido pelo dono (não perguntar de novo)
- Sem caixas "A confirmar pela Natcorp" no PDF final (21/10/2026): o tema omitido vai para o INTERNO.
- Sem versão do Oracle Database. Backups "múltiplas vezes ao dia". RPO até 6 h, RTO até 4 h, DR acionado
  em até 4 h (indisponibilidade severa). Holding: diversas empresas e filiais no mesmo sistema.
- APIs e NatPonto em capítulos separados. APIs: figura das camadas (ORDS, permissões, banco), tipos de
  credencial, portal, exemplos GET/POST, construtor de APIs com figura; sem lista de endpoints (muda por cliente).
- Texto visível: "modo multiusuário" (nunca "totem"), "aparelho" (não "tablet").

## Ferramentas usadas na produção (registro fiel)
Nenhuma skill de design foi usada para montar estes documentos: o padrão visual vem deste motor, que segue
o Manual de Identidade Natcorp v1.2 (cores, Manrope, símbolo, capa e contracapa sangradas). Na produção
foram usados: agentes em paralelo para levantar fontes; o navegador do Playwright (MCP) para ler o site e
o portal de APIs, que bloqueiam leitura simples; a ferramenta Read para o PDF da política; Pillow e PyMuPDF
para as prévias. Se for redesenhar o sistema visual (não só um documento novo), a skill `impeccable` é a
indicada; para ler PDFs complexos, `anthropic-skills:pdf`.

## Armadilhas já pagas
- O acabamento tipográfico do montador troca aspas retas por curvas em todo texto do HTML, inclusive CSS
  inline: por isso o rodapé é gravado no `estilo.css` da build, não num `<style>` do HTML.
- Regras de ícone de um documento ficam no `icones` do config dele: na base do motor elas mudaram ícones
  do outro documento.
- Inserir um capítulo exige renumerar os seguintes **e** as referências "capítulo N" **e** a coluna
  "Capítulo" do questionário de fornecedor.
- Remover um bloco pode deixar uma página quase vazia (uma caixa sozinha): funda o bloco ao texto anterior.
- Figura com altura fixa sobrando gera caixa vazia; calcule a altura pelo conteúdo.
