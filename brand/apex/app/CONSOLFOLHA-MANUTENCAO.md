# Consolidação do Histórico Financeiro — página 50 do app 9181

> O mesmo `Natcorp_ConsolFolha.js` serve a página 55 (Comparativos), em modo comparação: ver
> `COMPFOLHA-MANUTENCAO.md`. Mexeu no JS, conferir as DUAS páginas.

Pedido (13/10/2026): a consulta da consolidação do histórico financeiro (o resultado do fechamento da
folha, visto de 18 formas pelo campo "Histórico Por") fácil para quem tem pouca instrução, com o olhar
de RH/DP de **conferência da folha** e análise do período. Abre pela casca 200:799 (menu Histórico
Financeiro). Tudo da página continua igual: os 18 relatórios, os filtros, as ações dinâmicas, a
validação, os botões IA e o "Expandir IR após Pesquisa" (que maximiza a tabela).

## 1. "Ver a folha por" (no lugar do "Histórico Por")

O campo era uma lista de 18 textos corridos ("Empresa, Filial, Ccusto, Cargo"). Agora é o botão
**Ver a folha por: Empresa › Filial › Centro de custo › Cargo** que abre as formas em 3 assuntos —
*Estrutura da empresa*, *Cargos*, *Custos* — cada uma com uma frase do que mostra ("Cada setor de cada
filial"). Escolher **preenche o campo original** (`setValue` + change): as ações "Show Hide Filtros…"
mostram/escondem os filtros como sempre. O campo original continua na página, escondido. Trocou a forma:
o aviso "Agora toque em Pesquisar…" e o Pesquisar pulsa 3 vezes. Lista em `FORMAS` (`[C1]`) — os
valores (`v`) NÃO podem mudar.

## 2. O resumo da folha

Acima da tabela, DENTRO da região do relatório (a página maximiza a tabela depois do Pesquisar e o
resumo vai junto). Abre fechado (só os números); "Ver análise completa"; "Tela cheia" também vale.

**Números** (do ÚLTIMO mês, com o selo da variação sobre o anterior; com vários meses, a soma do
período aparece embaixo): Ganhos · Descontos · Líquido · Pessoas na folha · **Para conferir**. O número
do cartão se ajusta à largura do cartão (`--n` = quantos caracteres; CSS `100cqi ÷ caracteres`): nunca
corta nem desce de linha.

**Mês conferido** (13/10, 2ª rodada): com 2 meses ou mais, botões de mês acima dos números. Os
cartões, o "Para conferir", a frase, a coluna em destaque e a Variação passam a ser do mês escolhido,
comparado com o anterior a ele (também se escolhe tocando no mês no gráfico ou na tabela abaixo dos
cartões). **Mês a mês em números**, logo abaixo dos cartões: Ganhos, Descontos, Líquido, Pessoas e
Ganho médio por pessoa, uma coluna por mês + Média + Variação — a referência dos outros meses.

**Dinheiro** sempre na máscara `R$1.234,90` (função `rs()`; negativo `-R$1.234,90`).

**Para conferir** existe SEMPRE (com um mês também). Mostra, em grupos:
- *Verbas que mudaram* do penúltimo para o último mês: novas, que sumiram, ou mais de 20% e R$ 500;
- *Locais que mudaram* (o 1º nível com mais de um membro — a filial, o setor…): ganhos que apareceram,
  sumiram ou mudaram mais de 20% e R$ 5.000;
- *Valores negativos* no último mês: verba com total negativo; local com líquido negativo.
Com zero, o cartão diz que não há nada (e, com um mês só, pede 2 meses para comparar).

**Análise** (13/10, v2): a frase do mês; *Mês a mês*; *Por origem*; *Onde está o custo* (níveis do
"por", com pessoas); *Para onde vai o dinheiro*; *Descontos*; *Encargos e informativas*; *As verbas que
mais pesam* (ganhos e descontos). **Um mês**: barras com o valor do mês. **Dois ou mais**: cada quadro é
uma TABELA — uma coluna por mês, linha Total, coluna Variação (selo âmbar quando ≥ 20%, nova ou sumiu).
A tabela rola de lado com o nome parado; no celular abre já no fim (último mês à vista).

**Recursos de conferência** (13/10, 2ª rodada):
- *Mês a mês* (gráfico na largura toda): ganhos, descontos e líquido lado a lado; botões para ligar e
  desligar cada série e a linha tracejada da média; passar o mouse/foco num mês mostra os valores
  dele embaixo, com a variação sobre o anterior; tocar = conferir aquele mês.
- Tabelas: tocar no título da coluna ORDENA (nome A–Z; números do maior para o menor; de novo inverte);
  **Só o que mudou** (≥ 20% e R$ 500, nova ou sumiu); **Copiar para o Excel** (TSV, números sem R$,
  na ordem e filtro da tela); **Variação em % ou R$** (vale para todas); célula âmbar = o mês foge mais
  de 20% (e R$ 500) da MEDIANA da linha (mediana para que um mês muito fora marque só ele; 3+ meses).
- No celular, a tabela abre com o mês conferido logo depois do nome.

**Ver na tabela** = o FILTRO do próprio relatório (o mesmo de Ações › Filtro), pelo widget do IR
(`_action('FILTER')`, f01 = `COLUMN`, coluna, operador, expressão):
- um valor → `Nome Ocorrência = 'X'`; vários → `Nome Ocorrência em 'A,B,C'` (separado por vírgula, como
  o filtro de exemplo do usuário em 13/10);
- grupo de verbas (Para onde vai o dinheiro, Descontos) e "Ver todas na tabela" do Para conferir → "em"
  com as verbas do grupo; origem → `Origem =`; local → coluna do nome do nível (`Nome Filial =`…);
- tocar de novo noutra coisa da mesma coluna TROCA o filtro que o resumo pôs (id guardado em
  sessionStorage `nc-cf-filtros:IR_n`); um filtro posto à mão na mesma coluna é DESLIGADO (caixinha
  desmarcada, não apagado), senão os dois somariam e a tabela ficaria vazia;
- nome com vírgula não entra no "em" (a vírgula separa os valores) — a mensagem avisa;
- sem a v2 do processo (nomes exatos) cai na busca da tabela, como antes.

Antes da 1ª pesquisa, no lugar da tabela: **Conferir a folha em 3 passos**.

## As regras (`[R1]` do .src.js e o PL/SQL)

- O processo `NC_CONSOL_RESUMO` **não repete as 18 consultas**: lê a consulta do relatório que está na
  tela (`apex_application_page_regions`, Static ID IR_1…IR_18 vindo em x01) e soma em cima dela pelo
  `apex_exec` (que liga os `:P50_*` da sessão). Os números do resumo são os da tabela, por construção.
- As colunas mudam de nome entre os relatórios (COD_OCORR × OCORRENCIA, INCID_LIQ × LIQUIDO × "Líquido",
  NOME_COD_GERENCIAL × NOME_GERENCIAL): os papéis são achados pelo nome; o que sobra, aos pares código
  + nome, são os níveis.
- Ganho = Provento que incide no líquido; Desconto = Desconto que incide no líquido; Líquido = ganhos −
  descontos; Encargos = tipo Informativa. Verbas 996–999 e 9996–9999 (totais) não entram.
- **v2 (13/10): os nomes vêm como estão no banco** (sem initcap) e o JSON traz `cols` (o nome da coluna
  de cada papel neste relatório): o filtro "em" compara texto EXATO ("ADIANTAMENTO  (C / INC.)", com os
  dois espaços). O JS deixa bonito só para ler (`bonito()`, siglas como FGTS/INSS continuam siglas).
- O resumo é o da PESQUISA (a consulta do relatório): os filtros postos na tabela não mudam o resumo.
- Pessoas na folha = em cada grupo do relatório, a verba de provento da **Folha** com mais pessoas;
  somado entre os grupos. É uma conta aproximada (a tabela não traz matrícula).

## Instalar

1. Subir `login/Natcorp_ConsolFolha.js` e `login/Natcorp_ConsolFolha.css` (o workspace do 9181 é o mesmo
   das outras — o Natcorp_Style_Min vem da mesma pasta).
2. Importar `f9181_page_50.sql` (exportação de 13/10 + `aplicar-consolfolha-pagina50.py`): File URLs e o
   processo `NC_CONSOL_RESUMO` v2 (Ajax Callback, **só leitura**). Subir o JS novo com o processo v1
   ainda instalado funciona, mas o "Ver na tabela" volta a ser a busca (os nomes v1 vinham em initcap).
3. Conferir: Ganhos/Descontos do último mês contra a soma da coluna Total Valor da tabela filtrada por
   Tipo Rubrica, e "Pessoas na folha" contra a folha do mês.

## Arquivos

| Peça | Fonte | Gera |
|---|---|---|
| A tela | `Natcorp_ConsolFolha.src.js` | `python3 gerar-consolfolha.py` |
| A roupa | `Natcorp_Afastamentos.src.css` (seção `[A14]`) | `node gerar-app.mjs` e depois `gerar-consolfolha.py` (cópia) |
| Os números | `NC_CONSOL_RESUMO.plsql.sql` | entra pelo `aplicar-consolfolha-pagina50.py` |
| A página | `f9181_page_50.ORIGINAL.sql` | `python3 aplicar-consolfolha-pagina50.py f9181_page_50.ORIGINAL.sql f9181_page_50.sql` |

## Cuidados

- **Não testado no banco.** O desenho foi conferido na 9181:50 (pela casca 200:799) com dados de teste;
  a tabela real tinha 357.383 linhas (Empresa › Filial › C.Custo › Cargo, jan–mar/2026): o resumo soma
  no banco e manda só os totais.
- **Tela cheia + tabela maximizada** (corrigido 13/10, no Natcorp_Registros [R11] e no [A12] do CSS): o
  maximizar do IR deixa o body com `visibility: hidden` — o envelope da tela cheia herdava e só a tabela
  aparecia; agora `.nc-af-tela { visibility: visible }`. O Esc é tratado no próprio envelope (antes do
  documento), senão o IR restaurava a tabela por trás e a tela cheia ficava aberta.
- Sem `INCID_LIQ` preenchido em `ocorr_pagto`, ganhos e descontos saem zerados: conferir no 1º uso.
