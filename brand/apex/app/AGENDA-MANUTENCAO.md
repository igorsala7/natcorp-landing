# Agenda do exame (app 2937, página 75) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A janela "Pesquisar Horário para Encaminhamento", aberta pelo botão **Agenda - Datas e Horários** da
Requisição de Exames (2937:61; no desenho, "Escolher dia e horário"). O gestor escolhe o médico, o dia
e a faixa de horário, pesquisa e toca num horário livre; a janela fecha devolvendo `P75_P_ROWID`,
`P75_P_DATA_AGENDA_DSP`, `P75_P_HORA_INI` e `P75_P_HORA_TER` para a 61.

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Agenda.css` | o desenho (gerado de `Natcorp_Agenda.src.css` por `gerar-app.mjs`) |
| `Natcorp_Agenda.js` | o comportamento (gerado por `gerar-agenda.py`) |

App 2937 › Página 75 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Agenda.js` (no fim da
lista); CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Agenda.css`. Já aplicado em `f2937_page_75.sql`
por `aplicar-agenda.py` (original em `f2937_page_75.ORIGINAL.sql`). Reconhece a página pelos itens
`…_PRESTADOR_MEDICINA`, `…_DATA` e `…_HORA_INICIO` (sem teste de app/página). Nada é gravado.

## O que muda

- Título da janela "Escolher dia e horário" e, dentro, "Escolher dia e horário do exame" com o que
  fazer em uma frase. O título repetido da página sai.
- Campos com o nome em cima e caixas no padrão das outras telas (44 px, borda leve, foco roxo):
  - **Médico** na largura toda; lista vazia → "Nenhum médico com horário livre na agenda"; empresa
    vazia → "a empresa do pedido não chegou a esta janela, e os horários não vão aparecer".
  - **Dia**: atalhos Hoje / Amanhã / próximos dias úteis e o dia por extenso; a caixa e o botão do
    calendário do plugin (`dynamicDateTimePicker`) juntos, como o seletor de data do APEX.
  - **A partir de / Até** lado a lado: o relógio do plugin (com ícone de calendário) dá lugar ao
    seletor de hora do aparelho (`type="time"`, valor hh:mm, o formato do plugin); atalhos **Manhã**
    (07–12), **Tarde** (12–18), **Qualquer hora** (em branco).
- **Pesquisar → "Ver horários livres"**, na largura toda (é o botão da página: faz o submit).
- **O relatório vira a lista de horários livres**: "4 horários livres · toque no que for melhor",
  agrupada por dia ("Sexta-feira, 2 de outubro"), cada horário um cartão "08:00 às 08:30 · Dra. Maria
  Silva · Escolher" — o toque clica o link da linha do relatório (o "fechar devolvendo" continua o da
  página). A barra de busca do relatório ("Ir") sai de vista. As colunas são reconhecidas pelo NOME do
  cabeçalho (Data/Dia, Hora Início/Inicial, Hora Término/Final/Fim, Médico/Prestador); outra coluna vira
  "rótulo: valor" no cartão. Antes de pesquisar: "Os horários livres aparecem aqui"; sem resultado:
  "Nenhum horário livre com esse filtro — tente outro dia ou deixe as horas em branco".

## Defeito da página (não mexido — é do APEX)

**No pedido NOVO os horários nunca aparecem.** A pesquisa (consulta do relatório) filtra
`H.cod_empresa = :P75_COD_EMPRESA_AUX`, e o botão da 61 monta o endereço da 75 quando a página carrega
(`p_button_redirect_url … :&P61_COD_REQ.,&P61_COD_EMP_PACIENTE.`), antes de a pessoa escolher a
empresa — vai vazio. Num pedido gravado vem certo (`…:57657,700`).
A lista de **médicos não depende da empresa**: traz todo médico do trabalho (`Tipo_Prest_Serv = '1'`)
com algum horário livre a partir de hoje. Vazia = não há horário livre na agenda (é o caso do
ambiente de teste) — o aviso diz isso.
Correção sugerida (mínima): na 75, computação *Before Header* em `P75_COD_EMPRESA_AUX` — "se nulo,
`:P61_COD_EMP_PACIENTE`" (conferir que o valor da 61 está na sessão quando a janela abre; se não
estiver, botão da 61 "Definido por ação dinâmica" que envia `P61_COD_EMP_PACIENTE` e abre a janela).

## O relatório (da exportação)

Colunas à vista: Empresa (`EMPRESA_DSP`), Data Agenda (`DATA_AGENDA`), Horário (`HORA_INIC_PREVISTO`,
HH24:MI — não há coluna de término), Médico (`COD_PREST_SERV`, "código - Nome") e Selecionar
(`LINKS`: `apex.submit` com `FECHAR_DIALOG` e os itens `P75_P_*`; o processo "Novo" fecha a janela
devolvendo). O desenho reconhece pelo nome do cabeçalho e não repete a Empresa no cartão.

## Não visto funcionando

- **Nenhum horário livre** na agenda do ambiente de teste: a lista foi conferida com uma tabela de
  exemplo (com as mesmas colunas da exportação).
- A escolha de um horário de verdade (fechar a janela devolvendo os itens).

## Desligar

Tire as duas URLs de arquivo da página 75 do app 2937.

## Regras da página (auditoria 04/10)

Conferido contra `f2937_page_75.ORIGINAL.sql`: 1 ação dinâmica (Pesquisar → submit), 1 validação
(data não menor que hoje), 1 processo (fechar a janela), 1 botão.

- Os atalhos de dia e de faixa gravam por `setValue`; "Ver horários livres" clica o Pesquisar;
  "Escolher" clica o link da linha do relatório. A página não tem ação de abertura nem
  mostrar/esconder, então montar no "ready" do jQuery não atrapalha.
- Sem problemas.
