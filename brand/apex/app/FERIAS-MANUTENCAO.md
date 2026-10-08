# Requisição de Férias (página 78 dos apps 200 e 300) — como dar manutenção

> A página 78 do **app 300** é a mesma do app 200 (conferido em 02/10: mesmas regiões, itens,
> botões e condições). Os mesmos dois arquivos e o mesmo script servem para as duas.

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A tela tem um desenho próprio, feito por dois arquivos da página:

| Arquivo | Onde fica no APEX | Fonte neste repositório |
|---|---|---|
| `Natcorp_Ferias.css` | Página 78 › CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Ferias.css` | `brand/apex/app/Natcorp_Ferias.src.css` |
| `Natcorp_Ferias.js` | Página 78 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Ferias.js` | `brand/apex/app/Natcorp_Ferias.src.js` (+ a ilustração) |

## Para quem é esta tela

**90% do uso é no celular**, por colaboradores com pouca familiaridade com leitura e com os
termos do RH. Por isso: uma pergunta por vez, frases no lugar de gráficos, letra de 16px ou
mais, botões de 48px ou mais, e só o que decide à vista. Ao mexer, confira primeiro num
celular (390px de largura).

## A regra: a estrutura é do APEX

**Ordem, colunas, títulos, rótulos e botões estão no Page Designer e aparecem na tela do
mesmo jeito.** Os arquivos não movem, não renomeiam e não duplicam nada. Para mudar a tela,
mude o APEX — o desenho acompanha.

O CSS/JS só **redesenha quem tem uma classe CSS** posta no APEX:

### Regiões (Aparência › Classes CSS)

| Classe | Região | O que o desenho faz | De onde lê |
|---|---|---|---|
| `nc-fer-direito` | Suas férias (`PER`) | Abre com duas frases: "Você tem N dias de férias" e "Você precisa começar até …", e o botão "Ver os detalhes do período" | `P78_SALDO_1`, `P78_DT_LIMITE_REQ` |
| `nc-fer-detalhes` | Período de Férias (`PERIODO_FERIAS`) e Dados (`DADOS`) | **Recolhidas**: só aparecem com "Ver os detalhes do período". Abertas, os campos viram quadros compactos | — |
| `nc-fer-parte` | 1ª, 2ª e 3ª parte (`PARCELA1..3`) | O formulário de cada parte | datas e dias de cada uma, para a linha do tempo |
| `nc-fer-programada` | As partes já programadas (`2_PARCELA1..3`) | O mesmo, com o selo "Já programada" (é o pedido anterior que já virou oficial) | idem |
| `nc-fer-linha` | Confira suas férias (`LINHA_FERIAS`) | Cada parte em frases: "Começa: terça-feira, 5 de janeiro de 2027" / "Volta ao trabalho: …"; avisa, por escrito, quando uma parte começa depois do limite ou cruza com outra | as partes à vista e `P78_DT_LIMITE_REQ` |
| `nc-fer-acoes` | Botões (`BOTOES`) | O último cartão da página: diz o que falta ("Falta escolher o dia de início de 1 parte" / "Pronto: 30 dias escolhidos") ao lado dos botões | a opção e as partes à vista |
| `nc-fer-colaborador` | Colaborador Solicitado (`COLABORADOR`) | O cartão do colaborador: foto (ou iniciais), nome, "Matrícula … · empresa", filial, situação e "Na empresa desde" com os anos de casa — o mesmo da Requisição de Benefícios. Colab Foto e Colab Info saem da vista; no pedido novo a escolha do colaborador (a lupa) continua no alto | `P78_MATRICULA_DISPLAY`, `P78_COD_EMPRESA_DISPLAY`, `P78_SITUACAO_COLAB`, `P78_DT_ADMISSAO`, `P78_FOTO_COLAB`, a filial de `P78_MATRICULA` |

`LINHA_FERIAS` é **vazia no APEX de propósito**: quem desenha é o JS. Se o JS não carregar,
o CSS a esconde.

### Itens (Avançado › Classes CSS)

No Universal Theme essa classe vai para o contêiner do item (`t-Form-fieldContainer`); o
desenho acha o campo dentro dele.

A lista/campo **continua sendo o item de verdade**. O desenho aparece dentro do próprio item,
logo abaixo do rótulo; quando uma ação dinâmica esconde o item, o desenho some junto.
Clicar num botão/cartão faz `apex.item(...).setValue(...)`: as mesmas ações dinâmicas e
cascatas de sempre disparam, e as validações continuam no servidor (e nas packages).

| Classe | Itens | Desenho |
|---|---|---|
| `nc-fer-opcao` | `P78_OPCAO_FERIAS`, `P78_OPCAO_FERIAS_A` | Primeiro "Você quer vender dias das suas férias?" (Não / Sim); depois só as opções que servem para a resposta, da mais simples para a mais dividida ("Tudo de uma vez", "Em 2 vezes"…), com o sinal de marcado. A pergunta da venda é só da tela — o que vale é a opção da lista; trocar a resposta desfaz uma opção que não serve mais. Lê o texto `N Parcela(s): X dias de férias + Y dias de abono`. Só desenha a lista que está à vista. |
| `nc-fer-simnao` | `P78_HAVERA_REP`, `P78_OPCAO_13SAL1/2/4` | Botões Não / Sim |
| `nc-fer-dias` | `P78_NUM_DIAS_PARC1/2/4_LST`, `P78_DIAS_ABONO_PEC1/2/4_LST` | Um botão por quantidade. Com **uma** opção só, a pessoa toca nela (não é escolhida sozinha, 04/10); depois a pergunta vira frase ("São 15 dias de férias nesta parte"); a venda com só "nenhum" some depois de escolhida |
| `nc-fer-retorno` | `P78_DT_RETORNO_PARC1/2/4` | A volta dita em frase: "Você volta a trabalhar na quarta-feira, 20 de janeiro de 2027." |

A 3ª parte usa os itens de número **4** (`…PARC4`), como no APEX.

## Situações comuns

- **Tirar o desenho de um item ou região:** tire a classe. Ele volta ao normal do APEX.
- **Desligar tudo:** tire as duas URLs de arquivo da página e ponha `LINHA_FERIAS` em
  Condição › Nunca.
- **Mudar título, rótulo, ordem ou coluna:** direto no APEX. Nada a mudar nos arquivos.
- **Nova opção de divisão das férias:** nada a fazer, desde que o texto siga o formato
  `N Parcela(s): X dias de férias + Y dias de abono`. Em outro formato, o cartão mostra o
  texto inteiro. Se a lista não tiver opções com venda (ou só tiver com venda), a pergunta
  "Você quer vender dias?" não aparece.
- **As partes aparecem antes de escolher a opção:** quem mostra/esconde as partes são as
  ações dinâmicas da página (pela opção, inclusive `P78_OPCAO_FERIAS_A`), não o desenho.
- **Renomear um item `P78_*` listado acima:** ajuste também o `Natcorp_Ferias.src.js` (ou o
  desenho daquele pedaço para de funcionar em silêncio).
- **"Requisição não permitida! Já existe uma outra em andamento":** é a validação do
  sistema. Nesse caso o botão "Enviar pedido de férias" não aparece — é o comportamento
  certo, não um defeito do desenho.

## Aplicar numa exportação da página

```sh
python3 brand/apex/app/aplicar-ferias-pagina78.py f200_page_78.sql
```

Exporte a página 78 **do mesmo ambiente onde vai importar** (os IDs internos mudam a cada
release; de outro ambiente a importação falha com ORA-02291). O script acha tudo pelos nomes
e para, sem gravar nada, se não achar algum.

## Gerar os arquivos

```sh
node brand/apex/app/gerar-app.mjs         # gera ../login/Natcorp_Ferias.css (e as folhas gerais)
python3 brand/apex/app/gerar-ferias.py    # gera ../login/Natcorp_Ferias.js com a ilustração
```

Suba `brand/apex/login/Natcorp_Ferias.css` e `Natcorp_Ferias.js` em Workspace Images.

## Pedido já feito (02/10)

Ao abrir um pedido existente (cancelado, em aprovação…), o APEX trava os campos. O desenho
acompanha: **mostra só a resposta escolhida**, sem botões para trocar, sem a pergunta "Você
quer vender dias?" e sem a frase "Confira e envie" no pé.

Dois defeitos achados no app 300, que valiam também para o app 200:

- **A lista de opções vinha repetida** (722 linhas para 9 opções: no pedido já feito a lista
  não é filtrada pela empresa). O desenho agora usa a primeira de cada valor — antes, eram
  centenas de cartões, vários "marcados".
- **A linha do tempo dizia "volta no dia seguinte"**: a página tem itens auxiliares escondidos
  com o mesmo começo de nome (`P78_DT_RETORNO_PARC1_X`, `P78_NUM_DIAS_PARC1_DSP`), vazios no
  pedido já feito. O desenho agora ignora os escondidos e prefere o que tem valor.

## O pedido, a aprovação e o colaborador (02/10) — `[J10]`–`[J12]` / `[C11]`–`[C13]`

O mesmo padrão das outras requisições (Benefícios, Alteração Funcional, Indicação de
Movimentação), com o **cabeçalho claro** (sem fundo roxo cheio):

- **O pedido** — achado sem classe: a região que contém `P78_COD_SOLICITACAO`. Vira um cartão:
  "Pedido de férias nº 55477", a situação numa etiqueta colorida e "Aberto em 28/07/2020 por
  Tony Oliveira · 624 - Supervisor de Setor". No pedido novo: "Novo pedido de férias" e quem
  pede. Os campos Requisição, Data, Solicitante, Usuário e Data de Atualização saem da vista
  (o cartão diz o mesmo); a **Situação continua à vista quando o APEX deixa trocar**. O botão
  de ver quem pediu vai para dentro do cartão (o mesmo botão).
- **A aprovação** — achada sem classe: o relatório com a coluna `APROVADOR`. Sai da coluna
  estreita da direita e vai para logo abaixo do pedido, na largura toda (a coluna vazia some).
  Vira o caminho: "Pedido cancelado · 1 de 5 aprovou", cada aprovador com o sinal (aprovou,
  reprovou, é a vez, na fila) e o que escreveu. **Tocar no nome abre os Dados do Colaborador**
  — a mesma lupa do relatório. No celular, a lista abre por "Ver o caminho". Se a página
  ganhar botões "Aprovar"/"Reprovar", eles vêm para dentro da faixa quando é a vez.
  Não renomeie as colunas APROVADOR, DATA, STATUS, JUSTIFICATIVA.
- **O colaborador** — classe `nc-fer-colaborador` (o script põe): o cartão descrito acima.

**Cores (02/10, 2ª rodada):** a etiqueta da situação e a faixa da aprovação seguem o esquema da
Marcação - Abono e da Tratativa de Abono — âmbar `#FFF4DE`/`#6B4700` (em andamento), verde
`#E4F4EA`/`#1E6B45` (aprovada, concluída), vermelho `#FBEAEC`/`#9B2230` (cancelada, reprovada),
com o ícone (relógio, certo, x). A lista `TOM`, em `[J10]`, decide a cor pelo texto da situação.
As partes já programadas não têm mais estilo próprio nos campos: valem os campos desativados
de toda a página (Natcorp_Paginas.css), iguais aos da 1ª parte.

**O saldo do pedido já feito (02/10, 3ª rodada):** "Você tinha 22,5 dias de férias — quando fez
este pedido, em 28 de julho de 2020". O número vem da coluna SALDO do pedido, que o APEX põe
no HTML de `P78_SALDO_1`; logo depois a ação dinâmica "(Pesquisa) Matricula: Popula_Campos 1"
troca o item pelo saldo de HOJE. O desenho lê o valor original (sem mexer no item). Os campos
de "Ver os detalhes do período" (Saldo Bruto, Saldo Final…) continuam mostrando o que a ação
dinâmica calcula — para eles mostrarem a época do pedido, a ação precisa não rodar quando
`P78_COD_SOLICITACAO` está preenchido (mudança no APEX). Saldo com meio dia ("22.5") agora é
lido certo (antes virava 225). Rótulos e campos das partes já programadas seguem o mesmo
padrão das partes novas (16px/700; o dia de começar em 17px).

**Importação com erro de constraint (02/10):** a região nova "Confira suas férias" tinha o MESMO
id fixo nas páginas 78 dos apps 200 e 300. Agora o script gera um id por aplicação
(`28299` + app + `0078` + `0000001`, ex.: app 300 → `28299030000780000001`) e para se ele já
existir no arquivo. Se a importação ainda falhar com ORA-02291 ("chave mãe não encontrada"), a
exportação veio de outra base: exporte da mesma base em que vai importar.

## Regras da página (auditoria 04/10)

**Conferido** (exportações originais `f200_page_78.ORIGINAL.sql` e `f300_page_78.ORIGINAL.sql`):
app 200 — 139 ações dinâmicas (235 ações), 44 validações, 23 processos, 9 botões; app 300 — 142
ações dinâmicas (252 ações), 42 validações, 23 processos, 11 botões (Aprovar/Reprovar por ação
dinâmica, além dos _1 por janela). Gravar continua só nos botões originais (Criar, Salvar,
Aprovar, Reprovar); o desenho não cria Ajax nem valida nada; os controles trocados (cartões,
Não/Sim, dias) gravam por `apex.item().setValue`, ficam dentro do contêiner do item (somem
quando a página o esconde) e respeitam `disabled`/readonly.

**O que mudou**
- O desenho começa no `apexreadyend` (com 3 s de reserva), depois das ações de abertura:
  "Disable Fields Consult" (trava as partes), "Opção de Parcelas"/"Estagiário" (mostram e
  escondem campos), "Hide Aprov Sit <> 1" e, no app 300, "Hide / Show Aprovações". Antes ele
  lia campo aberto/botão à vista e podia escolher a opção única de uma lista que ia sumir.
- CSS: `.t-Form-fieldContainer` de "Ver os detalhes" e dos itens `nc-fer-opcao/simnao/dias`
  com rótulo à esquerda ganharam `:not([style*="none"])` — o `display` com `!important`
  trazia de volta `P78_OPCAO_FERIAS`/`_1` escondidos pela ação dinâmica.
- Aprovar/Reprovar: a decisão aparece sempre que a página os mostra (antes só com "é a sua
  vez"; fora disso ficavam no cabeçalho escondido do relatório). Antes de reescrever a faixa
  eles voltam ao lugar de origem — reescritos com eles dentro, saíam da página e a ação
  dinâmica que os mostra (app 300, mudança de situação) não os achava.

**Fica para decisão**
- Lista com UMA opção é escolhida sozinha (`setValue`); na venda com só "0", o item ainda some
  (`nc-fer-sem-pergunta`) e o 0 vai gravado sem a pessoa ver. A validação "Valida abono
  parcela1 obrigatorio" passa por isso. Confirmar se é o que o negócio quer.
- O cartão do pedido esconde os campos que ele repete (`nc-fer-dito`: nº, data, solicitante,
  usuário, atualização; a Situação quando não dá para trocar) e o cartão do colaborador
  esconde Colab Foto/Colab Info e, no pedido já feito, `P78_MATRICULA_1` (`nc-fer-fora`). São
  itens/regiões da página: a lição de 2943:31 manda não esconder — a informação continua no
  cartão, mas é decisão de produto.
- "Período de Férias" e "Dados" ficam recolhidos atrás de "Ver os detalhes do período"
  (regiões de dado escondidas pelo desenho, abríveis por botão).
- Se a página mostrar Aprovar/Reprovar sem nenhuma linha no relatório de aprovadores, a região
  some inteira (`nc-fer-aprov--vazio`) — não acontece hoje (a condição dos botões exige o
  aprovador na APROVA_FERIAS).

**Decidido (04/10, cliente):** lista com uma opção só NÃO é escolhida sozinha — aparece como botão para a pessoa tocar; vira frase depois de escolhida.
