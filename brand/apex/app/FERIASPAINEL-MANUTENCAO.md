# Resumo das férias — página 26 do app 200

Pedido (08/10/2026): indicadores de gestão na consulta de Férias, fáceis para quem tem pouca
instrução. A página continua igual (filtros, relatório e o seletor Tabela · Trajetória · Cronologia
do Natcorp_LinhaTempo); acima do relatório entra um **Resumo das férias**. Mesmo desenho do
painel de afastamentos da 200:25 (ver AFASTAMENTOS-MANUTENCAO.md).

## O que o painel mostra

**Hoje** — cada número abre a lista de quem são (até 300), já na ordem que importa:

| Número | Regra | Ordem da lista |
|---|---|---|
| De férias hoje | alguma parcela com saída ≤ hoje < retorno (sem retorno: saída + dias) | quem volta antes |
| Saem nos próximos 30 dias | saída entre amanhã e hoje + 30 | quem sai antes |
| Prazo vencido (vermelho) | saldo > 0 e a data limite para COMEÇAR já passou — paga em dobro (CLT art. 137) | o prazo vencido há mais tempo |
| Vencem em até 60 dias (âmbar) | saldo > 0, limite entre hoje e hoje + 60, sem saída marcada de hoje em diante | o prazo mais perto |
| Dois períodos acumulados | 2+ períodos completos (fim do aquisitivo < hoje) com saldo | mais dias para tirar |

**Planejamento**: "N pessoas têm X dias de férias para tirar, dos quais Y de períodos já completos"
e "Z% das pessoas estão com as férias em dia (sem prazo vencido)" (arredondado para BAIXO); saídas
de férias por mês (sem filtro de datas: 2 meses para trás e 9 para a frente; com filtro: o período);
onde há férias vencidas (centros de custo); quem tem mais dias para tirar; como tiram (1, 2 ou 3
partes, venda de dias, adiantamento do 13º — barras só de leitura).

Tocar numa pessoa ou num centro de custo filtra a TABELA pela busca do próprio relatório
(`IR_1_search_field` + "Ir"). Se o LinhaTempo estiver em Trajetória/Cronologia, volta antes para a
Tabela; espera a página terminar o que estava carregando (até 8 s) — um clique na busca durante um
carregamento se PERDE (visto em 08/10).

### A tabela continua sendo a página (modo compacto)

O painel abre **fechado**: só a faixa "Hoje" (≈130 px) e o botão **Ver análise completa**; o
relatório aparece logo abaixo, sem rolar. Aberto, o botão vira **Mostrar menos**. A escolha fica no
navegador (`localStorage`; `'0'` = aberto). Mesmo comportamento na 16, 25 e 26 (pedido 08/10).

## Instalar

1. Subir para o Workspace Images: `login/Natcorp_FeriasPainel.js` e `login/Natcorp_FeriasPainel.css`.
2. Importar `f200_page_26.sql` no app 200. Ele é a exportação de 08/10 22:35 (`f200_page_26.EXPORT-0810.sql`,
   da base com deslocamento 805756123742460090 — a mesma da página 25; já com o LinhaTempo) + os File
   URLs do painel + o processo `NC_FERIAS_INDICADORES`. Refazer:
   ```
   python3 aplicar-feriaspainel-pagina26.py f200_page_26.EXPORT-0810.sql f200_page_26.sql
   ```
   (A `f200_page_26.ORIGINAL.sql` de 02/10 é da OUTRA base do app 200 — não importar nesta. Página
   nova sem o LinhaTempo: rodar antes o `aplicar-linhatempo-pagina26.py`.)

## Arquivos

| O quê | Fonte | Gera |
|---|---|---|
| Os números (servidor) | `NC_FERIAS_INDICADORES.plsql.sql` | entra no processo pelo aplicar |
| A tela | `Natcorp_FeriasPainel.src.js` | `python3 gerar-feriaspainel.py` → `../login/Natcorp_FeriasPainel.js` |
| A roupa | `Natcorp_Afastamentos.src.css` (a MESMA dos afastamentos) | `node gerar-app.mjs` e depois `python3 gerar-feriaspainel.py` → `../login/Natcorp_FeriasPainel.css` |

## Cuidados

- O processo segue as lições da 25: filtro de lista com `instr` (nada de TABLE() no PL/SQL:
  ORA-22905), uma passada só com somas em memória (nada de GROUPING SETS), nome
  (`fnct_nome_func`) só de quem vai para as listas, variáveis antes das funções no declare, chave
  de array nunca nula. Devolve `tempos` (centésimos por parte).
- O NC_LINHA_TEMPO_DADOS (da Trajetória) corta em 20.000 períodos — por isso o painel tem processo
  próprio, que soma TUDO sem devolver as linhas.
- **Não testado no banco**: a tela foi conferida na 200:26 com números tirados dos dados da
  Trajetória (cortados em 20 mil). Ao instalar, conferir "Prazo vencido" contra a tabela.
- Base de teste: milhares de prazos vencidos (cadastro antigo nunca fechado) — o painel mostra isso.
