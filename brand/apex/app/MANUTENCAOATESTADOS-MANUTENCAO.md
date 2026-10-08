# Manutenção de Atestados — app 2937, página 12

Onde o profissional de saúde lança e corrige os atestados de um colaborador. Público com pouca
intimidade com tecnologia: a grade virou cartões, e lançar/corrigir é numa gaveta com a ficha
por assunto (pedido de 04/10, "a mesma lógica da página anterior" = Histórico do colaborador, 2937:6).

Arquivos: `Natcorp_ManutencaoAtestados.src.js` / `.src.css` → `../login/…js` / `.css`.
JS: `python3 gerar-manutencaoatestados.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-manutencaoatestados-pagina12.py f2937_page_12.sql` (aplicada em 04/10;
original em `f2937_page_12.ORIGINAL.sql`). Só File URLs + comentário: a grade já era editável.

## Como ficou

| Onde | O quê |
|---|---|
| Colaborador | a busca original (Empresa, Matrícula — mudar a matrícula recarrega a página) + cartão: `número - nome`, situação (Desligado em vermelho), idade, cargo, setor, local, onde fica, sangue. Os 10 campos de leitura originais saem da vista. Cancelar / Cadastro de Médico / Cadastro de Entidade em contorno (a ação principal é "Lançar atestado") |
| Resumo | Hoje (afastado até… / sem término / não está afastado) · dias afastado nos últimos 60 dias · nos últimos 12 meses (`JANELA_CURTA`, `JANELA_LONGA`) |
| Cartões | por ano do início; tipo, período com dias e horas, motivo (se diferente do tipo), CID, médico, clínica, alta programada, perícia, observação; marcas "Em vigor", "Sem término", "Ocupacional". Busca a partir de 6 atestados |
| Gaveta | O atestado · Quem atestou · Afastamento · Mais informações, com dicas. Lançar atestado / Salvar · Cancelar · Excluir |
| Tabela | a grade original, só consulta (Editar/Salvar/Adicionar escondidos; barra, títulos e paginação não grudam mais) |

## A gaveta

É a **"vista de um registro" (Single Row View) da própria grade**, como na p6 e na Agenda Médica: a
região `#ATESTADO` entra na gaveta enquanto ela está aberta e volta ao fechar. Por isso continuam
valendo, sem nada copiado:

- as listas (tipo; motivo que depende do tipo; CID; médico; entidade) e os padrões;
- as ações dinâmicas das colunas: dias ↔ término, conferência de férias (mensagem pelo alertify),
  justificativa que vem do tipo, horas que ligam/desligam pela situação do tipo;
- as validações (férias, término, exclusão) e o salvar com os processos "Set ENTIDADE",
  "Set DESC_MOTIVO", "Set Dados Complementares", "Pre_DEL", "Post_INS_UPD".

Depois de gravar, a grade é buscada de novo (o servidor completa campos).

- **Campos, nomes, blocos e dicas**: `FICHA` (`[M2]` do JS). Coluna fora da lista não aparece.
- **Campo travado** (tipo, motivo, início em atestado já gravado; dias/término já preenchidos):
  vira texto em fundo cinza; tipo, motivo e médico mostram o nome, não só o código.

## Cuidados (aprendidos aqui — valem para toda gaveta de Single Row View)

- A ficha do grid **reescreve as classes dos campos a cada registro**. Ordem, largura e o que aparece
  vão numa folha `<style id="nc-ma-ficha">` presa ao **ID** do campo (`C…_CONTAINER`), feita uma vez;
  nome e dica são conferidos a cada abertura. Com classes, os campos sumiam na 2ª abertura.
- **Cancelar linha nova**: `revertRecords` NÃO tira linha inserida (APEX 19.2) — é `deleteRecords`.
- Dentro do IG há medidores de 1000–1800 px: `.a-IG` com `overflow: clip` na gaveta.
- **Horas** (`HORA_INICIO_AFASTAMENTO`, `HORA_TERMINO_AFASTAMENTO`): texto de 5 posições no banco, com
  "1100", "11:00", "930" misturados. Na gaveta: máscara 00:00 ao digitar, o do banco aparece como HH:MM
  sem marcar o registro como alterado, hora inválida avisa no campo e barra o salvar, e ao salvar o
  registro vai SEMPRE com ":" (`fmtHora`, `prepararHoras`, `horasNoPadrao`). Conferido no envio.
- **Último campo digitado**: a ficha da grade só passa o valor para a grade quando o foco vai para
  outro campo dela (Tab); clicar direto em Salvar deixava o último campo de fora. `sincronizarFicha()`
  copia os campos da ficha do formulário para a grade antes de salvar (04/10; provado na 2943:31).
- **Falha ao gravar**: a grade dispara `interactivegridsave` também quando falha (`{status: "fail"}`).
  Só conta como salvo com status ok e modelo sem pendência; senão a gaveta fica aberta e avisa.
- Esc em captura (`window`, `stopImmediatePropagation`); calendário e alertify abertos ficam com o
  próprio Esc.
- Atestados antigos gravados sem zeros ("7" no lugar de "007") não acham o texto na lista: o nome
  é emprestado de outro atestado com o mesmo código (tipo, motivo, médico). Sem nenhum, fica o código.
- O balão de ajuda do portal fica no canto de baixo à direita: o rodapé da gaveta tem 88 px à direita.
- Testado na prévia sem gravar: abrir vários, lançar e cancelar (a grade fica sem alteração), celular
  390 px sem rolagem lateral, Tabela. **Gravar de verdade**: conferir com a página importada, lançando
  e excluindo um atestado de teste.

## Regras da página (auditoria 04/10)

Conferido contra `f2937_page_12.ORIGINAL.sql` (a exportação aplicada só muda URLs e comentário):
23 ações dinâmicas (dias ↔ término, validar_dt, férias, justificativa e situação pelo tipo, horas
liga/desliga por COD_SIT_FUNC, alertas pelo P12_MENSAGEM, "Verifica Existe Dt. Término NULL" na
abertura, submit ao trocar a matrícula…), 8 validações (desligado, férias, início, término, exclusão),
8 processos (carga, Set ENTIDADE, Set DESC_MOTIVO, Set Dados Complementares, Pre_DEL, DML, Post_INS_UPD).
Tudo continua sendo da grade: a gaveta é a vista de um registro e Salvar é o salvar da grade.
Os 10 campos de leitura saem da vista mas estão todos no cartão. Botões Cancelar / Cadastro de
Médico / Cadastro de Entidade: os originais. Montagem no `apexreadyend`.

**Mudou:** `salvarFicha()` espera as chamadas Ajax pendentes (até 6 s) antes de copiar a ficha e
salvar — o último campo mexido dispara as ações da coluna ao sair dele (o clique no Salvar), e o
valor que elas trazem (término pelos dias, justificativa…) podia ficar de fora.

**Para decidir:**
- Horas: a gaveta barra o salvar com hora inválida e grava "HH:MM" no que veio sem ":" — mais rígido
  que a página. Com as horas desligadas pela ação "Habilita e Desabilita", `horasNoPadrao` ainda pode
  reescrever um valor antigo sem ":" (campo desligado).
- Em "Tabela" o Salvar da grade fica escondido e a página não tem outro botão de salvar: o que for
  editado direto na tabela só grava ao salvar alguma ficha na gaveta (que salva o modelo todo).
