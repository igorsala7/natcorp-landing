# Linha do Tempo (app 200, página 108) — como dar manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md).

No alto do relatório da página entra um seletor com três jeitos de ver os mesmos fatos:

| Vista | O que mostra | Para quem |
|---|---|---|
| **Tabela** | o Interactive Report de sempre | quem filtra, exporta, ordena |
| **Trajetória** | um **Gantt**: uma faixa por assunto (contrato e lotação, remuneração, férias e saúde, desenvolvimento, ponto); cada fato é uma barra do começo ao fim, com a régua e o "hoje"; **zoom em Anos · Meses · Semanas · Dias** (botões − e +, ou Ctrl + roda do mouse); **passar o mouse** mostra um resumo direto (assunto, título, período e duração, motivo); tocar mostra os detalhes completos | ver a carreira de uma vez, ou um mês dia a dia |
| **Cronologia** | os fatos em lista, por ano (o mais recente em cima), com filtros por assunto; o ponto resumido por mês ("2 faltas ou atrasos (14:40 h)"), que abre a lista do mês | leitura rápida, celular |

A escolha fica guardada no navegador de cada pessoa.

## De onde vêm os dados

Do processo da página **`NC_LINHA_TEMPO_DADOS`** (Processing › Ajax Callback), criado pelo
script de aplicação. Ele lê a mesma `vw_linha_do_tempo` que o relatório, com o mesmo filtro
**Fato** (`P108_FATO`) e a mesma checagem de acesso (`f_acesso_pg_apex`), e devolve os fatos em
JSON — a coluna `descricao` ("(Cargo) Gerente … Motivo: Admissão") vai como texto da barra e
`titulo` como o nome do fato, como o plugin fazia. Quem pode ver salário é decidido **no servidor** (`fnct_trata_verif_sal_nivel`) — a tela não
consegue pedir salário que a pessoa não pode ver. Quando o relatório é atualizado (o filtro
mudou), os fatos são buscados de novo.

Até 02/10 os dados vinham da região do plugin TimelineJS. A região foi apagada; o JS ainda
aceita o plugin se ele existir numa outra página, mas não precisa mais dele.

## Arquivos

| Arquivo | Onde fica no APEX | Fonte |
|---|---|---|
| `Natcorp_LinhaTempo.js` | Página 108 › JavaScript › File URLs: `#WORKSPACE_IMAGES#Natcorp_LinhaTempo.js` | `brand/apex/app/Natcorp_LinhaTempo.src.js` (`python3 gerar-linhatempo.py`) |
| `Natcorp_LinhaTempo.css` | Página 108 › CSS › File URLs: `#WORKSPACE_IMAGES#Natcorp_LinhaTempo.css` | `brand/apex/app/Natcorp_LinhaTempo.src.css` (`node gerar-app.mjs`) |
| `NC_LINHA_TEMPO_DADOS` | Página 108 › Processing › Ajax Callback | `aplicar-linhatempo-pagina108.py` (o PL/SQL está no script) |

Nada precisa de classe: o JS acha sozinho o Interactive Report.

**Se a Trajetória ficar em branco:** o processo `NC_LINHA_TEMPO_DADOS` não está na página (a
importação foi de uma exportação sem ele). Rode o script na exportação e importe de novo.

## Situações comuns

- **Um assunto novo caiu em "Outros":** no `.src.js`, parte `[J2]`, lista `FAIXAS`: uma linha
  com o nome que vem na coluna Fato (sem acento, em minúsculas), o nome na tela, o assunto e o
  jeito (`estado` · `periodo` · `marco` · `ponto`).
- **Cor de um assunto:** `[J2]`, lista `ASSUNTOS` (use as cores da marca, com a reserva).
- **Os botões de zoom:** `[J6]`, lista `ESCALAS`.
- **O texto de um fato veio inteiro, sem separar motivo/valor:** a view mudou o formato do
  título; ajuste `[J4]` (`lerFato`). Nada quebra enquanto isso.

## Aplicar numa exportação da página

```sh
python3 brand/apex/app/aplicar-linhatempo-pagina108.py f200_page_108.sql
```

Põe as duas URLs de arquivo, o comentário da página e o processo `NC_LINHA_TEMPO_DADOS` (com id
novo, no fim dos processos). Acha a página pelo conteúdo (o Interactive Report sobre
`vw_linha_do_tempo`), não altera duas vezes e não toca em mais nada. Exporte a página da mesma
base em que vai importar. A exportação de 02/10 18h35 (já sem o plugin) está aplicada.

## Por que o arquivo espera a página ficar pronta (02/10)

As URLs de arquivo da página são carregadas **antes** de o APEX montar o plugin. Por isso o
`Natcorp_LinhaTempo.js` só começa quando o APEX avisa que a página está pronta
(`apexreadyend`) e acha o plugin pelo **componente** dele (o widget `sb.timeline`), não pelo
desenho do TimelineJS — esse desenho só aparece depois que os dados chegam do servidor. A
primeira versão procurava o desenho e, numa página recém-aberta, parava em silêncio.

## O zoom e o resumo do mouse (02/10)

- **Escalas** (`[J6]`, lista `ESCALAS`): *Anos* cabe a carreira inteira na largura; *Meses*,
  *Semanas* e *Dias* deixam o gráfico mais largo (3,2 · 12 · 36 pixels por dia) e ele rola para o
  lado, com os nomes das faixas presos à esquerda e o nome de cada barra acompanhando a rolagem.
  Ao trocar de escala, a data do meio continua no meio (com Ctrl + roda, a que está debaixo do
  mouse); ao sair de *Anos*, a tela vai para o fato tocado ou para hoje. "Ir para hoje" volta.
- **Ponto:** somado por mês só em *Anos*; nas outras escalas, cada ocorrência no seu dia.
- **Régua em dois andares:** ano/meses · mês/semanas · mês/dias (fim de semana mais claro).
  As linhas de dia e semana são um fundo listrado (milhares de dias sem milhares de elementos).
- **Resumo do mouse** (`[J7]`): um cartão escuro com o assunto, o título, o período com a
  duração e o motivo (no ponto: as horas e a apuração). Some ao rolar. No celular não há mouse:
  tocar abre os detalhes, como antes.

## Página 121 — vários colaboradores (02/10)

Os mesmos dois arquivos. Quando os fatos vêm de mais de uma pessoa, a tela muda sozinha:

- **Trajetória:** uma linha por colaborador ("1864 - Bruno Cirilo de Morais", com o centro de
  custo e a situação embaixo, e o número de fatos). Fechada, a linha mostra a vida funcional
  (linha fina) e um tracinho por mudança, da cor do assunto — passar o mouse resume, tocar abre
  os detalhes. Tocar no nome abre as faixas daquela pessoa. Até 8 pessoas, já abrem abertas.
- **No alto:** buscar por nome ou matrícula, ordenar (Nome · Mais fatos · Mais recente) e
  Abrir/Fechar todos. Aparecem 100 pessoas e o botão "Mostrar mais".
- **Cronologia:** de quem é cada fato, a mesma busca; 300 itens e "Mostrar mais".

Quem decide é o dado: o processo da 121 manda, em cada fato, quem é a pessoa:

```json
{ "events": [ { "group": "Salário",
                "start_date": { "year": 2025, "month": 5, "day": 1 }, "end_date": { },
                "text": { "headline": "(Salário) 2.592,56 Percentual: 10,00% Motivo: Acordo Coletivo",
                          "text": "Salário" },
                "quem": { "id": "700-1864", "mat": "1864", "nome": "Bruno Cirilo De Morais",
                          "sub": "100101 - Conselho de Administração · Ativo" } } ],
  "cortado": false }
```

`cortado: true` mostra o aviso "Mostrando os primeiros N fatos. Use os filtros…" (o processo
corta num limite para não pesar). Na 121 a chamada não manda itens: usa os filtros que já estão
na sessão (os do último "Pesquisar"), então o gráfico mostra o mesmo que a Tabela.

### Aplicar na exportação da 121

```sh
python3 brand/apex/app/aplicar-linhatempo-pagina121.py f200_page_121.sql
```

Põe as duas URLs, o comentário e o processo `NC_LINHA_TEMPO_DADOS`. O **FROM e o WHERE do
processo são copiados do relatório da própria exportação** — mudou o filtro do relatório,
exporte de novo e rode o script num arquivo sem o processo (ou apague o processo antes) para
ele acompanhar. Salário: só para quem `f_acesso_salario_apex` deixa ver (quem não pode não
recebe a linha de salário; na Tabela ela aparece sem o valor). Limite: 20.000 fatos, com aviso.
A exportação de 02/10 19h36 está aplicada (original em `f200_page_121.ORIGINAL.sql`).

## Arrastar o Gantt (02/10)

Clicar e arrastar o gráfico com o mouse move a linha do tempo para os lados (sem a barra de
rolagem). Quem faz é o `Natcorp_Registros.js` (global, `[R9]`), não este arquivo: o lugar
`.nc-lt-gantt` está na lista `ONDE` de lá. Um clique normal numa barra continua abrindo os
detalhes; soltar depois de arrastar não abre.

## Página 26 — Férias (02/10)

Os mesmos dois arquivos (`Natcorp_LinhaTempo.js` e `.css`) nas URLs de arquivo da página 26, e o
processo **`NC_LINHA_TEMPO_DADOS`** (Ajax Callback), que entrega **todos** os períodos que o
relatório traria — não só a página aberta da Tabela:

```sh
python3 brand/apex/app/aplicar-linhatempo-pagina26.py f200_page_26.sql
```

O FROM e o WHERE do processo são **copiados do relatório** da exportação (`VW_CONSULTA_FERIAS` e os
filtros P26_…; o Pesquisar faz submit, então os filtros estão na sessão). As parcelas são PARC1,
PARC2 e **PARC4** (a 3ª parcela é a coluna 4 no banco, como no relatório). Limite: 20.000 períodos,
com aviso. Exportação de 02/10 aplicada (original em `f200_page_26.ORIGINAL.sql`).

**De onde o desenho pega os dados, nesta ordem:** 1º o processo; 2º o plugin TimelineJS antigo
(só nas páginas onde ele é a fonte — na de Férias, a região "Linha do Tempo" do plugin mostra
outra coisa e nunca é usada); 3º, na de Férias sem o processo, as linhas que a Tabela desenhou
(com o aviso "mostrando os registros 1 - 50 do relatório"). A região antiga do plugin na 26 pode
ficar ou ser apagada — o desenho não depende dela.

O relatório é reconhecido pelas colunas **Data Inicial / Data Final Período Aquisitivo**. Em cada
pessoa, uma faixa por período aquisitivo ("2020/2021 · Pendente · saldo 30 dias"):

| No gráfico | Vem das colunas |
|---|---|
| faixa clara "Aquisitivo" | Data Inicial / Final Período Aquisitivo |
| contorno tracejado "Para gozar" | do fim do aquisitivo até a Data Limite Início de Férias |
| barra cheia "1ª · 15 dias" | Data Saída / Retorno / Nº Dias Parc. 1–3 (+ Pagamento, Abono, 13º nos detalhes) |
| losango (prazo) | Data Limite Início de Férias; vermelho = vencido com saldo, âmbar = vence em até 60 dias (`PERTO`), grafite = em aberto, verde = sem saldo |

Situação **Cancelado, Quitado, Gozado, Pago, Encerrado…** não tem prazo a cobrar (`RESOLVIDO`).
A página abre em **Prazo mais perto** (quem está mais perto de perder o prazo em cima) e em
**Meses**, no prazo da primeira pessoa da lista; arrastar ou "Ir para hoje" leva ao resto.
A Cronologia lista as parcelas e os prazos (o período aquisitivo e o "para gozar" ficam só no
gráfico). Coluna escondida em Ações › Colunas não entra.

O `Natcorp_Registros.js` (Tabela · Cartões) não entra na 26: página com a Linha do Tempo é de
desenho próprio.

## Desempenho do Gantt (02/10)

Em Semanas e Dias o gráfico é largo (30 anos em Dias = 392.000 px). Antes, a régua, a grade e as
listras eram desenhadas na largura toda (11 mil rótulos em Dias) e o nome das barras longas era
re-medido a cada quadro — o quadro chegava a 327 ms e o navegador travava. Agora:

- régua, grade e listras só numa **janela** de três larguras de tela em volta do que se vê,
  redesenhada quando a rolagem chega perto da borda (`janela()` em `[J6]`); a posição vai por
  variável (`--nc-lt-j0`, `--nc-lt-jw`) porque a folha gerada põe `!important` em tudo;
- as medidas das barras são lidas **uma vez** ao desenhar; a cada quadro só se escreve;
- sem `will-change` nos nomes das barras.

Medido na 26 (17 pessoas abertas) e na 108: 13–14 ms por quadro em todas as escalas (antes: Meses
35, Semanas 46, Dias 327).

## Regras da página (auditoria 04/10)

**Conferido** contra `f200_page_108.ORIGINAL.sql` (2 ações, ambas "Nunca"; 2 processos),
`f200_page_121.ORIGINAL.sql` (7 ações, 2 processos) e `f200_page_26.ORIGINAL.sql` (4 ações,
3 processos). Os processos `NC_LINHA_TEMPO_DADOS` (nossos, Ajax) só LEEM: mesma consulta do
relatório, com `f_acesso_pg_apex` / `F_ACESSO` e o salário só para quem pode ver
(`fnct_trata_verif_sal_nivel` / `f_acesso_salario_apex`), calculado no servidor; nenhum
INSERT/UPDATE/DELETE. O desenho monta no `apexreadyend`, não esconde item nem botão da página
(Pesquisar, Filtros, IA continuam os da página) e não grava. **Sem problemas.**

**Observação:** em Trajetória/Cronologia a tabela do relatório sai da vista — e com ela o botão
IA da barra de busca; o modo fica lembrado no navegador (volta com "Tabela").
