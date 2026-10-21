# Conferência do ponto — página 204 do app 9503 (Abono Individual)

Pedido (19/10/2026): um dashboard na 204, a lista de colaboradores que leva à Tratativa de Abono (203).
Ele traz os dados mais relevantes para conferir o ponto eletrônico e os eventos de apuração, para o
DP, o RH e os gestores, de forma fácil para quem tem pouca instrução. A página continua igual
(filtros e relatório); acima do relatório entra a **Conferência do ponto**.

**As pessoas são as do relatório.** O processo usa a consulta do relatório "Colaboradores", com:
- as duas metades (Colaboradores Diretos Sim e Não);
- a mesma segurança (`RETORNA_MOSTRA`, gestor ou suplente do centro de custo ou da subseção, e o
  gestor não vê a si mesmo no painel PG);
- os mesmos filtros `P204_*`.

De cada pessoa, o processo lê as **mesmas tabelas que a 203 mostra**. Isso foi pedido pelo cliente
("aproveite as queries conhecidas das aplicações").

## O que a pessoa vê

**Cabeçalho:** "Período do ponto: 01/10 a 31/10 · fecha em 12 dias · 64 colaboradores". O período é
o da 203 (processo `popula_colab`), por empresa e pelo painel de quem olha:

| Painel | Período |
|---|---|
| PO | `DATA_INI_REF_PONTO` a `DATA_FIM_REF_PONTO` |
| PG | `DT_INI/FIM_PONTO_GESTOR` (sem elas, as de referência) |
| outro | `DT_INI/FIM_PONTO_COLAB` |

Com empresas de períodos diferentes, aparece "conforme a empresa".

**Para conferir antes de fechar** (sempre à vista; o painel nasce compacto, como os outros). Cada
número abre a lista de quem é, na ordem do que pede ação, com **Abrir o ponto** (vai para a 203 da
pessoa):

| Número | Regra | Ordem da lista |
|---|---|---|
| Batida faltando | dias JÁ PASSADOS com número ÍMPAR de batidas (posição com horário — o abonado no lugar do original — ou com justificativa) | mais dias primeiro, com as datas |
| Pedidos esperando | pedidos abertos (`cod_sit_req = 1`) com data do ponto no período: ajuste de marcação, apuração, hora extra | quem espera há mais tempo |
| Sem nenhuma batida | situação 01 (trabalhando), período já começou, nenhuma batida | nome |
| Ajustadas à mão | % das batidas com `hora_batida_abono` | mais batidas ajustadas |
| Banco de horas | saldo do período = créditos − débitos (eventos BANCO) | quem deve mais |

**No período** ("Ver análise completa"):
- **a frase:** pessoas, dias, batidas, % ajustada; folha, crédito, débito e saldo do banco;
- **Dia a dia:** pessoas com batida faltando em cada dia. O fim de semana fica mais claro, o dia
  com mais fica em vermelho, e os dias que ainda não chegaram ficam sem barra;
- **O que a apuração gerou:** cada evento, com as horas, as pessoas e a parte do total, e a etiqueta
  Crédito / Débito (banco de horas) ou Folha. Tocar mostra quem tem, com Abrir o ponto;
- **Onde há mais para conferir · por [Centro de custo ▾]:** dias faltando + pedidos, por qualquer
  coluna (centro de custo, gestor, filial…). Tocar filtra o resumo, e o botão pequeno mostra na lista;
- **Banco de horas:** cada pessoa com o saldo; quem deve mais primeiro.

**Filtrar este resumo:** Empresa, Filial, Centro de Custo, Gestor, Unidade Adm., Atividade, Cargo,
Sindicato e Vínculo, com vários valores por coluna, igual à 200:25. A tabela não muda.

## Os números (NC_PONTO_INDICADORES.plsql.sql)

**Uma consulta só:**
- `pop` (a consulta do relatório) e `per` (o período e a jornada) são materializados;
- `UNION ALL` de pessoas, batidas por dia, eventos e pedidos;
- `RETORNA_MOSTRA` roda uma vez por pessoa.

**Eventos:** a regra é a do quadro "Período" da 203 (Consolidação):
- sem o `id_apuracao` 9020 e sem plantão;
- jornada tipo 2 (`pe_jornadas`) só os eventos consolidados (`id_apuracao > 9000`) do último dia;
- as outras jornadas, todos os dias do período.

A jornada é lida no FIM do período; a 203 lê no dia escolhido (P203_DATA), que costuma ser o mesmo
tipo.

**JSON:**
- `pes` traz as colunas em números e o resto do link;
- `dm` e `da` são uma tira de dígitos por pessoa (batidas e ajustadas por dia);
- `ev` é [pessoa, evento, minutos] e `req` é [pessoa, tipo, pedidos, dias esperando].

As contas e os filtros são feitos no navegador.

**O link da 203 sai do `apex_page.get_url`:** a 203 tem proteção "C" (checksum), e um link montado
no navegador seria recusado. O começo comum vai uma vez só (`u0`).

**Limites:** até 8.000 pessoas (acima, o painel avisa e pede para filtrar) e até 62 dias por período.

**Tempos:** o JSON devolve `tempos` (centésimos de segundo) para achar o peso se ficar lento.

## Instalar

1. `node gerar-app.mjs` e `python3 gerar-pontopainel.py`. Subir `login/Natcorp_PontoPainel.js` e
   `login/Natcorp_PontoPainel.css` (cópia do `Natcorp_Afastamentos.css`, a roupa dos painéis; as
   peças só dele estão na seção [A16] do `Natcorp_Afastamentos.src.css`).
2. Importar o `f9503.sql` (o `montar-f9503.py` já põe o painel na 204). Para uma página avulsa:
   `python3 aplicar-pontopainel-pagina204.py <exportação da 204> <saída>`.

**Subir o JS e o CSS ANTES de importar.** Página importada antes pede um arquivo que não existe, e
o CDN guarda o 404 por 24 h.

## Cuidados

- **NÃO TESTADO NO BANCO.** O PL/SQL foi escrito a partir das consultas da 204 e da 203. As colunas
  de `PE_TRATAMENTO_BATIMENTOS` foram conferidas em 5 exportações. A tela foi conferida numa réplica
  local da 204, com resposta SIMULADA, a 1440 e 390 px.
- **Ao instalar, conferir:**
  - o número de colaboradores do cabeçalho contra o total do relatório;
  - para 2 ou 3 pessoas, os eventos do "O que a apuração gerou" contra o quadro "Período" da 203;
  - os pedidos contra "Requisições de Abono/Apuração/Hora Extra".
- **Se der erro**, o painel mostra o texto do Oracle e o passo. A lista continua funcionando.
- **"Batida faltando"** é o número ímpar de batidas no dia (a regra de sempre do DP). As
  divergências de horário (fora da tolerância), que a 203 pinta, não entram: dependem da jornada de
  cada dia, por pessoa e posição.
- **Não filtrar com `TABLE()`** de `apex_string.split` nem de coleção: dá ORA-22905 nesta base,
  dentro do PL/SQL. Os filtros de escolha múltipla usam `instr`, com o mesmo resultado.
- **Só lê.** Não grava nada.

## Versão 2 (19/10, à tarde): período no painel, gestão, riscos à CLT, quadros com escolha e Ampliar

Pedido do cliente, depois de ver a v1 com dados reais:
- data inicial e final no painel, com o mês corrente como padrão;
- mais indicadores de gestão (absenteísmo e outros), para a operação do DP e para a estratégia da
  diretoria de RH;
- gráficos que não estourem com volume, com seleção de faixa e com maximizar.

**Período:** fica na barra logo abaixo do título, sempre à vista (também no modo compacto):
- atalhos Este mês (o padrão), Mês passado, Período do ponto (o fechamento da empresa) e Últimos 30
  dias;
- De / Até em campos de data; "Ver" ou Enter aplica;
- vai ao servidor em `x01`/`x02`, com até 6 meses (`MAX_DIAS` = 186; acima disso corta e avisa);
- o cache (10 min na aba) é por filtros + datas.

**Duas réguas:**

| Para conferir (operação) | Regra |
|---|---|
| Batida faltando | dias passados com batidas ímpares |
| Pedidos esperando | situação 1, com quantos dias o mais antigo espera |
| Sem nenhuma batida | situação 01, nenhuma batida no período |
| **Riscos à CLT** | dias passados com: descanso < 11 h entre um dia e outro (art. 66) · mais de 10 h trabalhadas (art. 59) · intervalo < 1 h com mais de 6 h trabalhadas, ou sem intervalo (art. 71). Calculado no servidor pelas batidas (pares 1-2, 3-4…, horário do dia em minutos, virada de meia-noite tratada) |
| Ajustadas à mão | % das batidas com `hora_batida_abono` |

| Indicadores de gestão (estratégia) | Regra |
|---|---|
| **Absenteísmo** | horas de ausência (faltas + atrasos + saídas antecipadas + ausências justificadas) ÷ horas PREVISTAS. As previstas vêm do `pkg_espelho_ponto.CF_TOTAL_HORAS_PREVISTAS` (SQL dinâmico, até 20 s no total). Se menos da metade das pessoas tiver previstas, a base vira **trabalhadas + ausências** e o número diz "estimado". A regra aparece embaixo da régua |
| Horas extras | total, % das horas da base, quem passou do limite de **2 h por dia útil já passado** |
| Banco de horas | saldo do período (créditos − débitos), quem deve, quem tem 40 h ou mais |
| Faltas | horas e pessoas |
| Atrasos e saídas | horas e pessoas |

**As categorias dos eventos** saem do NOME do evento (lista `CATS` no `[J1]` do JS, PODE MEXER):
- justificada: ATESTAD, ABONAD, ABONO, JUSTIFICAD (começo de palavra: "INJUSTIFICADAS" é falta),
  LICEN, DECLARA;
- falta: FALTA;
- atraso: ATRAS;
- saída: SAÍDA ou ANTECIPAD;
- hora extra: EXTRA ou H.E.;
- noturno: NOTURN;
- DSR: DSR ou REPOUSO.

Eventos do banco são sempre "banco". **Ao instalar, conferir com o DP** se os nomes dos eventos da
empresa caem na categoria certa: tocar em "O que a apuração gerou" → Ausências / Horas extras.

**Quadros:** três por linha.
- **Dia a dia** (ocupa 2):
  - mostrar Batida faltando, Riscos à CLT ou Bateram o ponto;
  - acima de 62 dias, uma coluna por semana;
  - ARRASTAR sobre as colunas (ou Enter numa coluna e Enter em outra) escolhe um trecho, e
    "Ver só este trecho" recalcula para essas datas.
- **O que a apuração gerou:** Todos · Ausências · Horas extras · Banco de horas · Outros.
- **Onde:** por qualquer coluna e por indicador (Para conferir · Absenteísmo · Horas extras ·
  Banco · Riscos). Tocar filtra o resumo.
- **Banco de horas:** por faixa (Devendo +10h · até 10h · Até 10h a mais · +10h a mais).
- **Riscos à CLT:** os 3 contadores e quem tem.
- **Mês a mês:** só com 2 meses ou mais; ausências e horas extras, lado a lado.

**Ampliar**, em cada quadro:
- abre o quadro por cima da página, com todas as linhas e o gráfico alto;
- fecha no "Fechar", no Esc ou tocando fora, e o foco volta ao botão;
- no celular ocupa a tela toda.

**Volume:**
- no cartão e ao lado da barra, só o número curto ("23 mil h"); o exato vai na dica;
- o detalhe desce para uma linha própria, que corta com "…";
- conferido com 3.000 pessoas: nenhum elemento passa da borda do cartão ou do quadro, a 1440 px e
  a 390 px.

**O JSON v2** (ver a ficha do NC_PONTO_INDICADORES.plsql.sql):
- `df`: riscos por dia, de 0 a 7;
- `tr`: minutos trabalhados;
- `pv`: minutos previstos (-1 = sem);
- `ev` ganhou o mês;
- `req` vem por situação;
- novos: `meses`, `ini`, `fim`, `dias` e `prev`.

**Instalar a v2:**
1. `node gerar-app.mjs` e `python3 gerar-pontopainel.py`.
2. Subir `login/Natcorp_PontoPainel.js` e `.css` (o mesmo nome: substitui).
3. Importar `f9503_page_204.sql`. É a exportação de 19/10 15:14 (cópia em
   `f9503_page_204.IMPORTADA-1514.sql`) com só o PL/SQL do processo trocado
   (`aplicar-pontopainel-pagina204.py` troca quando a página já tem o painel).

O JS v2 com o processo v1 não funciona direito (faltam os campos novos). Subir os dois juntos, e o
JS antes de importar.

**Não testado no banco:**
- a parte nova do SQL (as batidas por dia com funções analíticas, os riscos, os eventos por mês, os
  pedidos por situação);
- a chamada das horas previstas.

A tela foi conferida na réplica local, com resposta simulada de 3.000 pessoas.
