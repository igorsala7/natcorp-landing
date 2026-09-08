# Entrega — como aplicar no APEX

Três arquivos, todos para o **mesmo** diretório de arquivos estáticos onde já mora o
`Natcorp_Style_Min.css` de hoje.

| Arquivo | O que é |
| --- | --- |
| `Natcorp_Style_Min.css` | a folha nova, **com o mesmo nome do atual** |
| `manrope-latin.woff2` | fonte da marca — obrigatória |
| `manrope-latin-ext.woff2` | fonte da marca — obrigatória |

## Por que o mesmo nome

Substituir o **conteúdo** do arquivo não encosta em nenhum objeto APEX: a referência em
*Shared Components › User Interface Attributes › Desktop › Cascading Style Sheets › File URLs*
continua exatamente como está, nas seis aplicações. Subir com um nome novo obrigaria a editar
esse atributo em cada uma — o que a restrição do projeto não permite.

## Passos

1. **Shared Components › Static Workspace Files** (ou Application Files, onde o
   `Natcorp_Style_Min.css` está hoje).
2. Subir os **três** arquivos, substituindo o CSS existente.
3. Limpar o cache do navegador (`Ctrl+Shift+R`). O APEX versiona o caminho
   (`.../static/v995/` → `v996/`), então normalmente a troca já vem sem cache.
4. Conferir em uma tela de cada tipo: uma lista (Colaboradores), um formulário grande
   (Requisição de Alteração Funcional), a home e uma modal.

## As fontes não são opcionais

Medido em 07/09/2026: os dois `woff2` respondem **404** no ambiente, e a página do APEX
**não carrega nenhum link de Google Fonts**. Sem eles no mesmo diretório, o `@font-face` falha
e a tipografia inteira cai para fonte de sistema — título de região, micro-caixa-alta das
colunas, `tabular-nums`, a escala de meios-pontos. A calibragem foi feita em Manrope.

O CSS aponta para elas por **caminho relativo** (`url("manrope-latin.woff2")`), e não pelo token
`#WORKSPACE_IMAGES#`: o APEX **não** substitui tokens dentro de arquivo estático — o CSS de hoje
é servido com o token literal, e o navegador lê o `#` como âncora. O caminho relativo resolve a
partir da URL da própria folha e sobrevive à troca de versão do diretório.

## Ordem de carga

Esta folha precisa ser a **última** da lista em *File URLs*, depois do CSS compilado pelo
Theme Roller:

```
oj-alta → Core.min → Theme-Standard.min → <theme roller>.css → ESTA FOLHA
```

Se subir na lista, dezenas de regras param de valer em silêncio.

## Rollback

Subir de volta o arquivo antigo com o mesmo nome. Ele está versionado em
`brand/apex/APEX Style/APEX/Natcorp_Style_Min.css`. Nenhuma outra ação — a referência
em *File URLs* nunca mudou.

## O que ainda fica de fora

- **App 9300 (NatDocs)** — excluído por decisão sua; carrega outras duas folhas que não vieram
  no material.
- **App 2010** — vive dentro de um iframe e tem registro próprio de CSS; conferir se aponta para
  o mesmo arquivo.
- **Interactive Grid** — único widget grande sem tratamento próprio; herda o Universal Theme.
- Segunda onda combinada: densidade do Interactive Report, menu lateral em gradiente da marca,
  situações como pílulas tonais.

O arquivo **não é minificado**, apesar do nome (o atual também não é). Os comentários registram
o motivo de cada decisão e os erros que não podem voltar — vale mais que os ~60 KB economizados.
