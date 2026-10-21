# Lançamentos de ocorrências — página 5 do app 9132 (Movimentações Financeiro)

Pedido (09/10/2026): os "Parâmetros de Pesquisa" tomavam a página inteira e os lançamentos (Inserir /
Alterar | Excluir / Calcular Folha + o relatório) só apareciam depois, lá embaixo.

## Como ficou
- **Duas colunas** (montadas pelo JS, sem trocar o modelo da página): à esquerda a região PSQ1 ("Filtros"),
  no meio a região BLOCO (processo, botões, relatório). A coluna rola por dentro, com a altura que sobra na tela
  (`--lc-alto`, medida pelo JS) — o tema põe `overflow:hidden` nos contêineres de fora e o "preso no rodapé" da
  página não funciona; o pé (resumo + Pesquisar) fica preso no fundo da coluna.
- **Processo em cartões** (escolha única, setas do teclado andam): escrevem no P5_PROCESSO (escondido) com
  valor e texto da lista estática — as ações "Atribui Processo TXT" e "Disable Report" seguem disparando. O erro
  da validação do Processo aparece em cima dos cartões.
- **Grupos**: Empresa e período (obrigatórios) · De quem (com "Demitidos": data e mês/ano da demissão, que as
  ações da página só liberam com situação de demitido) · Quais lançamentos · Quem lançou. Faixas De/Até de
  admissão e validade. Rótulos em escrita normal (o aplicar troca os 22 prompts).
- **Antes de pesquisar**, o meio mostra o passo a passo, que vai se marcando. **No celular**, depois de pesquisar
  os filtros viram um resumo com "Mudar filtros".

## Cuidados (o que mordeu na 1ª montagem, 09/10)
- "Parametros", "Processo" e "Filtros" usam a moldura **Blank with Attributes**: são `div#R<id>` SEM `.t-Region`.
  O JS acha a "Parametros" como a região-avó do P5_PROCESSO e monta os grupos DENTRO dela (a ação
  "Disable Report" escuta o `change` dessa região).
- Este app usa **rótulo flutuante**: as faixas De/Até não usam a coluna de 34 px da 200:21.
- O cartão do processo só é marcado DEPOIS de os grupos entrarem na página (fora do documento o APEX não acha
  o valor da lista).
- A região PSQ1 deixou de ser recolhível (moldura padrão, a mesma da BLOCO): a ação "Expand Collapse
  Parametros" continua na página e não tem mais o que recolher.

## Arquivos
| O quê | Fonte | Gera |
|---|---|---|
| Colunas, grupos, cartões, guia | `Natcorp_LancOcorr.src.js` | `python3 gerar-lancocorr.py` → `../login/Natcorp_LancOcorr.js` |
| A roupa da página | `Natcorp_LancOcorr.src.css` | `node gerar-app.mjs` → `../login/Natcorp_LancOcorr.css` |
| Os grupos de filtros (os mesmos da 200:21) | `Natcorp_HistFiltros.src.css` (`#PARAMETROS` e `#PSQ1`) | `node gerar-app.mjs` → `../login/Natcorp_HistFiltros.css` |
| A página | `f9132_page_5.ORIGINAL.sql` | `python3 aplicar-lancocorr-pagina5.py f9132_page_5.ORIGINAL.sql f9132_page_5.sql` |

Testar SEMPRE pela moldura do app 200 (a página abre num quadro da 200:767), nunca abrindo a URL do 9132 solta.
