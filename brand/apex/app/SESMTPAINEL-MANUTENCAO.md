# Resumo das consultas — página 39 do app 2937 (Pesquisa Consulta Médica)

Pedido (13/10/2026): dados para o SESMT na lista de consultas, fáceis para quem tem pouca instrução.
**Decidido com o cliente (13/10):** o painel usa SÓ o que a página mostra — as MESMAS tabelas, junções e
filtro de acesso do relatório (`consulta_medica`, `inf_pessoais_cad`, `informacoes_funcionais_cad`,
`prestador_servico`, `tipo_consulta`; `f_acesso`). ASO vencido, exames, restrições e doenças (outras tabelas)
ficam para os dashboards das páginas delas. Pedidos do cliente atendidos: quantitativos de colaboradores,
por tipo de consulta, consultas no mês, consultas na semana.

## O que a pessoa vê

**Os números** (acima da tabela, sempre à vista):

| Número | Regra | Tocar |
|---|---|---|
| Consultas na semana | da segunda-feira até hoje · colaboradores diferentes · comparada com os MESMOS dias da semana passada | abre por tipo de consulta e por médico, com o "antes" (número e marca na barra) |
| Consultas no mês | do dia 1 até hoje · comparada com os MESMOS dias do mês passado | idem |
| Colaboradores atendidos | pessoas diferentes nos últimos 12 meses (e no mês, na semana) | — |
| Total de consultas | tudo o que a tabela tem, de quantos colaboradores, desde quando | — |

A comparação com o período anterior é NEUTRA (sem verde/vermelho): mais ou menos consultas não é bom nem ruim.

**No período** (12 meses · 2 anos · 5 anos · Tudo): a frase (consultas, colaboradores, o tipo mais comum,
comparação com o período anterior, quem mais atendeu) e os quadros *Consultas no tempo*, *Por tipo de
consulta* (com "ASO periódico" etc. embaixo quando o tipo tem `classificacao_aso`), *Por médico*, *Idade de quem
foi atendido*. Tipo e médico filtram a tabela (`DESCRICAO_CONSULTA =`, `ATENDENTE =`), o filtro da própria tabela.

## Os números (NC_SESMT_INDICADORES.plsql.sql)

- `cons`: consultas por mês × tipo × médico × faixa de idade (as contas do período no navegador).
- `dia`: os últimos 70 dias, dia a dia (a divisão da semana e do mês, e a deles anterior).
- `jan`: consultas e colaboradores DIFERENTES de cada janela (semana, semana anterior, mês, mês anterior,
  12/24/60 meses, tudo) — colaborador diferente não se soma por mês, por isso vem pronto.
- Cada bloco se protege sozinho; o motivo de uma falha vem em `falhas`.
- **APEX 19.2:** `apex_json.write(valor)` de item de lista NÃO tem `p_write_null` (deu PLS-00306 no 1º import);
  vazio vai como `'-'`.

## Achados na base e na página (não mexidos)

- A tabela é ordenada por `cod_cons_rel_paciente desc` (o código da consulta), não pela data.
- Na base de teste a consulta mais recente é de abr/2024: os 12 meses vêm vazios — o painel diz isso e
  sugere "Tudo".
- Os tipos usados (Abono, Perícia, Retorno, Avaliação, Contestação) não têm `classificacao_aso` no cadastro.
- Candidatos (ASO admissional antes de virar funcionário) não aparecem: a tabela exige cadastro funcional.

## Instalar

1. `node gerar-app.mjs` e `python3 gerar-sesmtpainel.py`; subir `login/Natcorp_SesmtPainel.js` e `.css`.
2. Importar `f2937_page_39.sql` (`python3 aplicar-sesmt-pagina39.py f2937_page_39.ORIGINAL.sql f2937_page_39.sql`).

## Cuidados

- Conferido na 2937:39 (casca 200:762), computador e celular, com o JS injetado e resposta SIMULADA.
  A 1ª versão do processo rodou na base do cliente (dados reais vistos); esta versão (v2) ainda não.
