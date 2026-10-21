# Resumo do quadro de pessoas — página 16 do app 200

Pedido (08/10/2026): indicadores indispensáveis de gestão de pessoas na consulta de dados pessoais e
funcionais (Informações Funcionais), fáceis para quem tem pouca instrução. A página continua igual;
acima do relatório (Static ID `INF_FUNC_PESS`) entra o **Resumo do quadro de pessoas**. Mesmo
desenho dos painéis de afastamentos (200:25) e férias (200:26).

A página só mostra dados depois do **Pesquisar** (`P16_PESQUISA = S`): antes disso o painel
convida a escolher os filtros. Depois, calcula com os MESMOS filtros e a MESMA segurança (quem pode
ver quem) do relatório. A **situação** da página (Ativos/Demitidos/Todos) não entra: o resumo precisa
de ativos e de quem saiu nos últimos 12 meses.

## O que mostra

**Hoje** (cada número abre a lista de quem são, até 300; o quadro ativo não abre lista):

| Número | Regra |
|---|---|
| Quadro ativo | situação < 90; embaixo, trabalhando (01) · afastados (02–89) |
| Experiência acabando | ativo com DT_CONTRATO (fim do 1º prazo, prorrogar?) ou DT_PRORROG (fim da experiência, efetivar?) entre hoje e hoje + 15 |
| Cota de PCD | Lei 8.213 art. 93, POR EMPRESA sobre os ativos: 100–200 = 2% · 201–500 = 3% · 501–1000 = 4% · +1000 = 5%; PCD = Deficiente ou Reabilitado = S. Com filtro de filial/centro de custo/… mostra "—" e explica (a cota é da empresa toda). Cumprida = verde "Em dia". Abre a conta por empresa |
| Documentos vencendo | validade do conselho regional, ou CNH de categoria C/D/E, vencida ou em até 30 dias (data antes de 1950 = sem data) |
| Cadastro incompleto | ativo sem PIS, CPF ou conta bancária (trava eSocial e folha) |

**Últimos 12 meses e perfil**: entraram (admissão nos 12 meses), saíram (situação ≥ 90 com data de
situação nos 12 meses), **rotatividade** = ((entraram + saíram)/2) / quadro médio, em palavras ("de
cada 100 vagas, N trocaram de pessoa") — não aparece se o quadro de 12 meses atrás der ≤ 0
(cadastro com saída antes da admissão); % mulheres/homens e jovens aprendizes (categoria do vínculo
103). Quadros: entradas e saídas por mês (duas colunas), por que saíram (a situação de
desligamento), onde estão (centros de custo, toque = busca pelo CÓDIGO na tabela), tempo de casa,
idade, escolaridade (faixas só de leitura, com %).

Tocar numa pessoa busca pelo NOME na tabela (a matrícula fica noutra coluna e o "texto da linha
contém" não juntaria as duas).

### A tabela continua sendo a página (modo compacto)

O painel abre **fechado**: só a faixa "Hoje" (≈130 px) e o botão **Ver análise completa**; o
relatório aparece logo abaixo, sem rolar. Aberto, o botão vira **Mostrar menos**. A escolha fica no
navegador (`localStorage`, chave do painel; `'0'` = aberto). O mesmo vale para a 25 e a 26.

### As três abas da análise

Aberto, o período vem em abas (a última escolhida fica salva em `nc-qd-aba`):

| Aba | Aparece | O que tem |
|---|---|---|
| Quadro e movimento | sempre | o bloco "Últimos 12 meses e perfil" acima |
| Remuneração | só se `remun.acesso` = quem vê salário pela `F_Acesso_Salario_Apex` (a MESMA regra da coluna Salário da tabela). Sem acesso, a aba não existe | folha do mês, média mulheres × homens, possível equiparação, sem reajuste, adicionais |
| Contratos e jornada | sempre | aviso prévio, ponto, perfil do vínculo, jornada |

**Remuneração** (só ativos, situação < 90, com salário liberado):

| Número | Regra |
|---|---|
| Possível equiparação | mesmo CARGO e mesma FILIAL, colega ganha **10% ou mais**, diferença de tempo no cargo **< 2 anos** e de admissão **< 4 anos** (CLT art. 461). É um alerta para conferir, não um passivo |
| Mulheres ganham menos | média geral F × M; o quadro "No mesmo cargo" compara só cargos com 2+ de cada (Lei 14.611) |
| Sem reajuste | último reajuste há mais de 12 e de 24 meses |
| Adicionais | insalubridade (por grau) e periculosidade |
| Dispersão por cargo | por cargo: menor–maior (linha), meio do quadro (caixa = 1º a 3º quartil) e mediana, todos na MESMA escala; os 30 de maior amplitude |

**Contratos e jornada**: em aviso prévio (data do aviso nos últimos 90 dias), quem não bate ponto
(líderes — classe LD/GR — separados dos demais), aposentados ativos, intermitentes, sindicalizados,
com adiantamento, estrangeiros, 60+ anos; mão de obra direta/indireta, modalidade, jornada mensal
("1 hora por mês" no singular) e classes.

## Instalar

1. Subir para o Workspace Images: `login/Natcorp_Quadro.js` e `login/Natcorp_Quadro.css`.
2. Importar `f200_page_16.sql` no app 200 = a exportação de 08/10 20:37 (`f200_page_16.ORIGINAL.sql`,
   base com deslocamento 805756123742460090) + os File URLs + o processo `NC_QUADRO_INDICADORES`:
   ```
   python3 aplicar-quadro-pagina16.py f200_page_16.ORIGINAL.sql f200_page_16.sql
   ```

## Arquivos

| O quê | Fonte | Gera |
|---|---|---|
| Os números (servidor) | `NC_QUADRO_INDICADORES.plsql.sql` | entra no processo pelo aplicar |
| A tela | `Natcorp_Quadro.src.js` | `python3 gerar-quadro.py` → `../login/Natcorp_Quadro.js` |
| A roupa | `Natcorp_Afastamentos.src.css` (a MESMA dos 3 painéis) | `node gerar-app.mjs` e `python3 gerar-quadro.py` → `../login/Natcorp_Quadro.css` |

## Cuidados

- A SEGURANÇA do relatório (USUARIO_ORACLE, filiais, centros de custo, hierarquia, gestor direto,
  distribuição de custo) está COPIADA no `NC_QUADRO_INDICADORES.plsql.sql` a partir da exportação de
  08/10. Se o WHERE do relatório mudar, copie de novo — o painel nunca pode mostrar mais gente que a
  tabela.
- Lições das páginas 25 e 26: instr no lugar de TABLE(), uma passada só (a consulta tem DISTINCT:
  cada pessoa conta uma vez), variáveis antes das funções, chave de array nunca nula, listas por
  registro (sem write_raw), PIS/CPF comparados como TEXTO, o aplicar corta o PL/SQL na LINHA declare.
  NVL2 e DECODE só existem dentro de SQL: numa expressão PL/SQL dão PLS-00201 — usar `case when` (08/10).
- Salário NUNCA sai do servidor para quem não tem `F_Acesso_Salario_Apex = 'S'`: o `case` zera o
  valor por pessoa ANTES de somar. Não trocar por um filtro no JS.
- **Não testado no banco**: a tela foi conferida na 200:16 com números tirados do download do
  relatório. Ao instalar, conferir "Quadro ativo" contra a tabela com Situação = Ativos, e a "Folha
  do mês" contra a soma da coluna Salário. Erro do processo vem com `[passo: …]`.
