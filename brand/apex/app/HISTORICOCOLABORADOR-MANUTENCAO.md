# Histórico do colaborador — app 2937, página 6

A janela "Cadastro de Dados de Funcionários": onde o médico busca o passado do colaborador que
está atendendo. As 9 abas viraram um histórico de leitura rápida; atestados e doenças se lançam e
corrigem ali mesmo, numa gaveta (pedido do cliente em 04/10: "não quer editar no interactive grid").
As abas originais ficam a um toque ("Tabelas"), só para consultar.

Arquivos: `Natcorp_HistoricoColaborador.src.js` / `.src.css` → `../login/…js` / `.css`.
JS: `python3 gerar-historicocolaborador.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-historicocolaborador-pagina6.py f2937_page_6.sql` (aplicada em 03/10;
reaplicada em 04/10 para destravar as grades; original em `f2937_page_6.ORIGINAL.sql`).

## Como ficou

| Onde | O quê |
|---|---|
| Alto (fixo) | `código - nome`, idade, cargo, setor, local, filial, empresa |
| Esquerda | **Atenção**: restrições (com Editar), doença sem término, atestado em vigor ("Afastado até…"), exame vencido / vence em 30 dias (o último de cada exame), vacina com dose atrasada, acidente nos últimos 365 dias · **Sangue** (tipo e fator RH — os campos originais) · **O que a função faz** |
| Direita | **Linha do tempo**: tudo junto, por ano, com filtro por tipo (com quantos) e busca. Tocar abre os detalhes, com "Ver consulta" / "Abrir análise" (os links dos relatórios) e **Editar** (atestados e doenças) ou "Ver na tabela" (o resto) |
| Alto da linha do tempo | **Novo atestado** · **Nova doença** (só se a página deixa incluir) |
| Gaveta | a ficha do registro, por assunto (atestado: O atestado · Quem atestou · Afastamento); Salvar · Cancelar · Excluir |
| "Tabelas" | as abas originais, só para consultar (Editar/Salvar/Adicionar Linha da grade escondidos; Salvar das restrições continua) |
| Rodapé | Voltar · Salvar (os originais) |

## Fontes (achadas pelo conteúdo)

| Tipo | De onde | Como é achado |
|---|---|---|
| Exames, Atestados, Doenças | grades (modelo: valor + texto da lista) | colunas `COD_EXAME`, `DT_ATESTADO_MEDICO`, `COD_DOENCA`+`DT_INICIO` |
| Consultas, Acidentes | relatórios clássicos | id da coluna `DT_CONSULTA`, `DT_ACIDENTE` |
| Consulta ocupacional, Vacinas, Atividades | relatórios interativos | cabeçalho "Data Agd Consulta", "Vacina", "Descrição de Atividades" |

Relatório com mais páginas do que a tela mostra → aviso "Há mais … do que a tela mostra" com
"Ver na tabela". Para acabar com o aviso, aumente as linhas por página do relatório no APEX.

## A gaveta (lançar e corrigir)

É a **"vista de um registro" (Single Row View) da própria grade**, como na Agenda Médica (2937:10):
a região da grade sai da aba, entra na gaveta enquanto ela está aberta e volta ao fechar. Por isso
as listas (CID, médico, motivo, entidade), os valores padrão (empresa e matrícula vêm de
P6_COD_EMPRESA / P6_MATRICULA), as validações de obrigatório e a gravação são os da grade.

- **Salvar** = o salvar da grade → processo "Save Interactive Grid Data" (já existia na página).
- **Novo** = a ação "Adicionar Linha" da grade; **Cancelar** / Esc / tocar fora desfaz a linha
  (Esc e tocar fora perguntam antes se algo foi preenchido). **Excluir** pede confirmação.
- **Quais campos e com que nome**: `FICHAS` no topo do JS (`[H2]`). Coluna fora da lista não aparece.
- **Quando aparece**: só se a grade é editável e o esquema de autorização deixa (incluir para
  "Novo", alterar para "Editar", excluir para "Excluir"). Por isso o `aplicar-…` tira o
  **Read Only: Always** das regiões **Doenças** e **Atestados** — sem isso não há botão nenhum.
- **Exames ficam fora**: a grade de exames não tem chave primária e a consulta junta três tabelas
  (EXAME_FUNC, RESULTADO, ENTIDADE) com colunas calculadas (RESULTADO, ENTIDADE) e filtra
  TIPO_ENTIDADE IN (1,7) — destravada, daria erro ao gravar, e exame novo de outra entidade
  sumiria da lista. Exame se lança no Lançamento de Exames (2937:11), que tem todos os campos.
- Testado na prévia só com a grade em modo leitura (abrir, campos, fechar, Esc, celular). A
  gravação de verdade só dá para conferir com a página importada — conferir lançando, editando e
  excluindo um atestado de teste.

## Cuidados

- O desenho **não grava por conta própria**: lê as grades e os relatórios; a gaveta usa o salvar da grade. A caixa Sangue é montada UMA vez porque os campos
  originais (P6_TIPO_SANGUINEO, P6_FATOR_RH) moram nela — redesenhar com `innerHTML` os tiraria
  do formulário e o Salvar deixaria de enviá-los.
- A região de dados (empresa, matrícula…) sai da vista; seus itens continuam no formulário.
- Em "Tabelas", as grades recebem um `resize` (estavam escondidas).
- Dentro do IG moram dois medidores de tamanho e o contêiner escondido dos campos de edição, com
  1000–1800 px de largura: na gaveta o `.a-IG` leva `overflow: clip` (sem isso a ficha rolava para o lado).
- Ícone em `url("data:image/svg+xml,…")` SEM `;charset=utf-8`: o gerador põe `!important` em todo `;`
  e quebra a URL (a seta do select sumia).
- **Horas** (`HORA_INICIO_AFASTAMENTO`, `HORA_TERMINO_AFASTAMENTO`): texto de 5 posições no banco, com
  "1100", "11:00", "930" misturados. Na gaveta: máscara 00:00 ao digitar, o do banco aparece como HH:MM
  sem marcar o registro como alterado, hora inválida avisa no campo e barra o salvar, e ao salvar o
  registro vai SEMPRE com ":" (`fmtHora`, `prepararHoras`, `horasNoPadrao`). Conferido no envio.
- **Último campo digitado**: a ficha da grade só passa o valor para a grade quando o foco vai para
  outro campo dela (Tab); clicar direto em Salvar deixava o último campo de fora. `sincronizarFicha()`
  copia os campos da ficha do formulário para a grade antes de salvar (04/10; provado na 2943:31).
- **Falha ao gravar**: a grade dispara `interactivegridsave` também quando falha (`{status: "fail"}`).
  Só conta como salvo com status ok e modelo sem pendência; senão a gaveta fica aberta e avisa.
- O Esc da gaveta é tratado na captura (`window`, `stopImmediatePropagation`): sem isso a janela do
  APEX também ouve o Esc e fecha a página inteira.

## Regras da página (auditoria 04/10)

Conferido contra `f2937_page_6.ORIGINAL.sql`: 3 ações dinâmicas (Cancel Dialog; Motivo → DESC_MOTIVO;
término → QTDE_DIAS_AFASTAMENTO), 1 validação (restrição obrigatória no SAVE_REST), 7 processos (2 de
carga, SAVE do sangue, 3 Save Interactive Grid Data, SAVE_REST), 3 botões, colunas das 3 grades.
A única diferença na exportação é a já decidida: sem "Read Only: Always" em Doenças e Atestados
(Exames continua só leitura). Botões Voltar/Salvar/Salvar das restrições: os originais, à vista.
Montagem no `apexreadyend` (a página não tem ação de abertura).

**Mudou:** `salvarFicha()` espera as chamadas Ajax pendentes (até 6 s) antes de copiar a ficha e
salvar — o último campo mexido dispara a ação da coluna (Motivo, Qtd. dias) ao sair dele, que é o
próprio clique no Salvar; antes, o valor que a ação traz podia ficar de fora da gravação.

**Para decidir:**
- Doenças: as colunas `COD_DOENCA` (obrigatória) e `DT_INICIO` continuam **Read Only: Always** na
  grade. "Nova doença" abre a ficha com CID e início travados — a doença nova não tem como ganhar CID.
  Ou se tira o "só leitura" dessas duas colunas (no APEX/aplicar), ou se esconde "Nova doença".
- Horas do afastamento: a gaveta barra o salvar com hora inválida (a página aceita qualquer texto)
  e grava "HH:MM" mesmo no que veio "1100" do banco. É mais rígido que a página (decisão anterior).
- Prédio, andar e sala (P6_PREDIO/ANDAR/SALA) saem da vista com a região de dados e não estão no alto.

**Decidido (04/10, cliente):** "Nova doença" fica como no original — sem o botão de novo
(`SEM_NOVO = ['doenca']`); abrir e corrigir uma doença existente continua.
