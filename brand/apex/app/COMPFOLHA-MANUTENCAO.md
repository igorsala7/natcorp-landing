# Comparativos de Históricos Financeiros — página 55 do app 9181

A folha de **dois meses lado a lado** (Período 1 → Período 2), para o RH conferir o fechamento e
explicar o que mudou. É a MESMA tela da Consolidação (página 50, `CONSOLFOLHA-MANUTENCAO.md`): o
`Natcorp_ConsolFolha.js` reconhece a 55 pelo campo `P55_HISTOCORR` e entra em **modo comparação**.

## O que a pessoa vê

**Filtros (à esquerda)**
- "Tipo Histórico" vira **Ver a folha por** (as 18 formas em 3 assuntos; preenche o campo original).
- Embaixo de *Período 1*: "o mês de antes: a base da comparação"; embaixo de *Período 2*: "o mês que
  você quer conferir".
- **Atalhos**: *Último mês × anterior*, *Mesmo mês do ano passado* (mostram os meses no botão) e
  **Inverter** (troca o 1 com o 2). Preenchem os campos originais e pedem o Pesquisar.
- Aviso quando o Período 1 é **depois** do Período 2 (tudo o que subiu apareceria como queda) ou
  quando os dois são o mesmo mês.

**Comparação da folha (acima da tabela)**
- *Comparando Período 1 · mai/2025 → Período 2 · jun/2025* (e o aviso, se a ordem estiver trocada).
- Cartões do **Período 2** com o valor do **Período 1 embaixo** e a variação: Ganhos, Descontos,
  Líquido, Pessoas, Para conferir.
- **Os dois períodos em números**: Período 1 · Período 2 · Diferença (R$) · Variação (%).
- Análise: gráfico *Período 1 × Período 2*, e as tabelas (Por origem, Onde está o custo, Para onde vai o
  dinheiro, Descontos, Encargos, As verbas que mais pesam) com **Período 1 · Período 2 · Diferença ·
  Variação**, ordenáveis, *Só o que mudou*, *Copiar para o Excel*. Âmbar = mudou mais de 20%, apareceu
  ou sumiu. Tocar numa linha filtra a tabela (filtro "=" / "em", como na 50).
- *Para conferir*: verbas e locais que mudaram, valores negativos. **Verba nova** (só no Período 2)
  aparece com o aviso "não aparece na tabela comparativa" (ver abaixo) e não filtra.

## De onde vêm os números — e um defeito da tabela original

A consulta de cada relatório da 55 junta os meses **partindo do Período 1** (`a ... b(+)`):
1. **verba que só existe no Período 2 não aparece na tabela** (nem o valor dela entra);
2. a junção **não usa a origem** (`horas_ferias`: Folha, 13º, Rescisão…): num mês com a mesma verba em
   duas origens, as linhas podem se multiplicar.

Por isso o processo `NC_COMP_RESUMO` **não soma a tabela da 55**. Ele roda a consulta do relatório da
**Consolidação (página 50)** do mesmo "Tipo Histórico" (mesmas tabelas `tb_ocorr*`), com os filtros da 55
(`:P50_x` → `:P55_x`) e `:P50_DATA_REF` → `'Período1:Período2'` (datas validadas antes), e soma no banco o
fechamento de cada mês — inclusive as verbas novas e a quantidade de pessoas. Os nomes de coluna para
**filtrar** a tabela são lidos da tabela da 55 (x01 = `IR_n`).

**Conferir no 1º uso:** o total de Ganhos do resumo contra a soma da coluna do Período 1/2 da tabela. Se
diferirem, é o defeito acima (ou duplicação por origem). A correção da tabela é trocar a junção por
`FULL OUTER JOIN` incluindo `horas_ferias` — mexe na regra da página, então **não foi feita** sem o OK.

## Instalar

1. Subir `login/Natcorp_ConsolFolha.js` e `login/Natcorp_ConsolFolha.css` (os mesmos da página 50).
2. Importar `f9181_page_55.sql` (exportação de 13/10 + `aplicar-compfolha-pagina55.py`): File URLs e o
   processo `NC_COMP_RESUMO` (Ajax Callback, **só leitura**).

## Arquivos

| Peça | Fonte | Gera |
|---|---|---|
| A tela | `Natcorp_ConsolFolha.src.js` (`[M1]` qual página, `[M2]` os períodos; o resto é o da 50) | `python3 gerar-consolfolha.py` |
| A roupa | `Natcorp_Afastamentos.src.css` (`[A14]`, "MODO COMPARAÇÃO") | `node gerar-app.mjs` e `gerar-consolfolha.py` |
| Os números | `NC_COMP_RESUMO.plsql.sql` (x01 = `MESES` → os meses para os atalhos) | entra pelo `aplicar-compfolha-pagina55.py` |
| A página | `f9181_page_55.ORIGINAL.sql` | `python3 aplicar-compfolha-pagina55.py f9181_page_55.ORIGINAL.sql f9181_page_55.sql` |

## Cuidados

- **Não testado no banco.** A tela foi conferida na 9181:55 (pela casca 200:799) com o JS injetado e a
  resposta do processo simulada a partir dos dados REAIS da página 50 (mai → jun/2025).
- Depende dos relatórios da página 50 (condição `P50_OCORRENCIA` = código). Mudou a 50, conferir a 55.
- Colunas "Incide FGTS" e "Incide IR" da tabela original estão TROCADAS na consulta (`incid_ir fgts`,
  `incid_fgts ir`) — defeito da página, não mexido.
