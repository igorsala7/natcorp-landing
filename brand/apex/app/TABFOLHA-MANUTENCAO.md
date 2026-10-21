# Comparativos de Históricos Financeiros - Tabular — página 58 do app 9181

Os **18 fechamentos mais recentes** lado a lado (uma coluna por mês), para o RH conferir a folha e ver a
tendência. É a MESMA tela da Consolidação (página 50, `CONSOLFOLHA-MANUTENCAO.md`), no modo "vários
meses": o `Natcorp_ConsolFolha.js` reconhece a 58 pelo campo `P58_HISTOCORR` (`[T]` no cabeçalho do .src.js).

## Como a página original funciona (lido da exportação de 13/10)

- Não se escolhe mês: os campos *Período 1/2* estão como **Nunca exibir** e as validações deles,
  desligadas. Cada relatório é um PIVOT montado por PL/SQL (função que devolve o SQL) com as **18 datas
  distintas mais recentes da tabela base** do tipo (`tb_ocorr*`) — da tabela inteira, não só da empresa
  escolhida (mês sem dado da empresa sai vazio). Os títulos das colunas vêm de `P21_DT1…P21_DT18`
  (processo "Set Itens Data").
- **Defeito da página (não mexido):** o "Set Itens Data" não tem o tipo **EFCCAR** (Empresa › Filial ›
  Class. Cargo): nesse tipo as colunas de mês ficam sem título.
- As colunas "Incide FGTS" e "Incide IR" estão trocadas na consulta (`incid_ir` como FGTS) — como na 55.
- A ação "Expandir IR após Pesquisa" só dispara com `P58_PESQUISA = 'SX'`: na prática não maximiza.

## O que a pessoa vê

- **Ver a folha por** no lugar do "Tipo Histórico" (as 18 formas em 3 assuntos).
- **Os últimos fechamentos da folha** (acima da tabela): mês conferido (18 botões; começa no mais
  recente), cartões, *Mês a mês em números* (18 colunas + Média + Variação), *Para conferir*, gráfico
  *Mês a mês* (no celular, o nome de 1 mês a cada 3), tabelas por mês ordenáveis com *Só o que mudou*,
  *Copiar para o Excel*, variação em % ou R$ e o âmbar do **mês fora do normal da linha** — com 18 meses
  é o que mais ajuda a achar o mês estranho. Tocar numa linha filtra a tabela ("=" / "em").

## De onde vêm os números

Processo `NC_TAB_RESUMO` (só leitura): pega a consulta do relatório da **Consolidação (página 50)** do mesmo
tipo, acha nela a tabela base (`FROM TB_OCORRn`, conferida), escolhe os 18 meses pela MESMA regra da 58
(`select distinct data_ref … order by desc` + `rownum < 19`), troca `:P50_DATA_REF` pela lista e
`:P50_x` por `:P58_x`, e soma no banco. Os nomes de coluna para filtrar vêm dos metadados do relatório da
58 (`apex_application_page_ir_col`): pelo nome e, nos níveis, pelo tipo de nível (NOME_CCUSTO na 50 =
NOME_CENTRO_DE_CUSTO na 58).

**Desempenho:** são 18 meses do tipo escolhido (EFCCCAR = o mais detalhado). A soma é no banco, mas pode
levar alguns segundos; o painel mostra "Ainda somando".

## Instalar

1. Subir `login/Natcorp_ConsolFolha.js` e `.css` (os mesmos das páginas 50 e 55).
2. Importar `f9181_page_58.sql` (exportação de 13/10 + `aplicar-tabfolha-pagina58.py`).

## Arquivos

| Peça | Fonte | Gera |
|---|---|---|
| A tela | `Natcorp_ConsolFolha.src.js` (`[M1]` PAGINAS.tab) | `python3 gerar-consolfolha.py` |
| A roupa | `Natcorp_Afastamentos.src.css` (`[A14]`) | `node gerar-app.mjs` e `gerar-consolfolha.py` |
| Os números | `NC_TAB_RESUMO.plsql.sql` | entra pelo `aplicar-tabfolha-pagina58.py` |
| A página | `f9181_page_58.ORIGINAL.sql` | `python3 aplicar-tabfolha-pagina58.py f9181_page_58.ORIGINAL.sql f9181_page_58.sql` |

## Cuidados

- **Não testado no banco.** Conferido na 9181:58 (casca 200:799) com o JS injetado e a resposta simulada
  (dados reais da 50 repetidos em 18 meses). Conferir no 1º uso: os totais de um mês do resumo contra a
  soma da coluna daquele mês na tabela.
- Depende dos relatórios da página 50. Mexeu no JS: conferir as páginas 50, 55 e 58.
