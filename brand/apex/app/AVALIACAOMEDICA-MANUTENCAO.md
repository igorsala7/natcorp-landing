# Avaliação Médica — app 2937, páginas 105 e 102

A "Cadastro de Avaliações Médicas" (105): onde o médico aplica um questionário (histórico de
saúde etc.) para chegar ao diagnóstico. Antes, cada pergunta abria uma janela (102), e a lista
recarregava a página inteira ao fechar. Agora o questionário inteiro fica na 105, com a resposta
na própria linha; a 102 continua existindo (é o caminho de reserva) e também ganhou desenho.

Arquivos: `Natcorp_AvaliacaoMedica.src.js` / `.src.css` → `../login/…js` / `.css` (um par para
as duas páginas). JS: `python3 gerar-avaliacaomedica.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportações: `python3 aplicar-avaliacaomedica-pagina105.py f2937_page_105.sql` e
`python3 aplicar-avaliacaomedica-pagina102.py f2937_page_102.sql` (aplicadas em 03/10;
originais em `f2937_page_105.ORIGINAL.sql` e `f2937_page_102.ORIGINAL.sql`).

## Como ficou

| Onde | O quê |
|---|---|
| 105 — alto | avatar, `matrícula - nome`, Avaliação, Questionário, Data, Avaliador, Tipo, Empresa · Relatório da avaliação |
| 105 — barra fixa | "12 de 17 respondidas" + barra · **Todas / Faltam N** · "Ir para a próxima sem resposta" |
| 105 — perguntas | cartões na ordem do questionário; subperguntas (03.01, 03.02) DENTRO do cartão da mãe (03), ligadas por um fio que sai do número dela e faz uma curva até cada uma; número "03.**01**" (mãe apagada, filha em destaque). No filtro Faltam, a mãe respondida com filha pendente fica recolhida ("Respondida: …") para a filha não aparecer sem contexto. Alternativa = botão com atalho 1–9: um toque **salva e passa à próxima**. Texto: salva 1,2 s depois de parar de digitar e ao sair do campo. "Salvo às hh:mm" em cada uma |
| 105 — teclado | 1–9 escolhem na pergunta em foco · ↓ / ↑ andam entre perguntas |
| 105 — rodapé | Voltar · Excluir avaliação (os originais) |
| 102 — janela | "Pergunta 03" + a pergunta grande · alternativas em botões (1–9) · texto com "salva ao sair do campo" · Fechar à esquerda, **‹ Anterior · Próxima ›** / Finalizar à direita · ← → no teclado |

**"Descreva".** Há perguntas de múltipla escolha cuja alternativa pede texto ("Descreva",
"Especifique" — ex.: "Qual atividade física pratica e com qual frequência?"). Na página original
a caixa de texto só existia nas perguntas Dissertativas: o médico marcava "Descreva" e não tinha
onde escrever. Agora, ao escolher essa alternativa, abre a caixa sob ela (o cursor já entra nela),
a tela **não** passa para a próxima, e o texto grava junto com a alternativa
(`resp_texto_livre`). Trocar para outra alternativa grava o texto vazio. A pergunta só conta como
respondida com o texto escrito. A regra é `ALT_TEXTO` no topo do JS (DESCREV / ESPECIFI) — a
MESMA da condição do item P102_RESP_DISSERTATIVA na exportação da 102; mudou uma, mude a outra.

Criando uma avaliação nova (P105_ROWID vazio), a 105 fica como era: o desenho só entra depois
de a avaliação existir.

## Os dois processos da 105 (Ajax Callback, postos pelo script)

| Processo | Faz |
|---|---|
| `NC_AVAL_PERGUNTAS` | lê as perguntas do questionário (`questionario_questoes2_1` + `questoes_1`), a resposta já gravada (`avaliacao_medica_respostas`) e as alternativas (`resposta_1` + `questionario_questoes_1`) |
| `NC_AVAL_SALVAR` | grava UMA resposta: `update` da linha da pergunta; se não existir, `insert` (mesmas colunas da ação "SALVAR ALTERNATIVA" da 102, `requer_atencao = 'N'`). Devolve `{ok:true}` ou `{ok:false, erro}` |

**Sem os processos** (exportação antiga importada, ou processo apagado), a 105 mostra a lista
original com roupa nova e a janela 102 de sempre — sem aviso de erro. É o caminho de reserva.

## Cuidados

- **102: quem grava é a página.** Os botões escrevem na lista original
  (`P102_RESP_ALTERNATIVA`) e o `change` dispara a ação "SALVAR ALTERNATIVA" (duas ações
  PL/SQL encadeadas). O desenho espera `$.active` zerar antes de clicar no **Próximo original**
  — trocar isso por um redirecionamento próprio pularia a gravação.
- **102 só navega dentro da janela.** Aberta solta numa aba, o Próximo original não faz nada
  (com ou sem o desenho): testar sempre abrindo a pergunta pela 105.
- A região original da 102 fica fora da vista com os itens ocultos dentro; a caixa de texto é
  levada para o desenho (continua o mesmo item, com a ação "Salvar Dissertativa").
- **Subperguntas aninhadas (03/10):** a mãe é a última pergunta de nível menor (pelo tamanho do
  `numero_ordem`). Com as filhas dentro do cartão da mãe, toda busca do JS numa pergunta é
  `:scope > …` (senão pega os botões das filhas). O comprimento do fio é medido (`fios()`, com
  ResizeObserver); no celular o fio corre no recuo da borda do cartão.
- Gravação em fila na 105: duas respostas rápidas não se atropelam (uma de cada vez).
- 102 e o "Descreva": o script da 102 muda a condição do item `P102_RESP_DISSERTATIVA` para ele
  existir também nas perguntas com alternativa DESCREV/ESPECIFI (antes: só nas Dissertativas). As
  duas ações que gravam já levam alternativa e texto juntos — nada mais muda no servidor.
- `AVANCAR` (topo do JS) liga/desliga o "passa à próxima" nas duas páginas.

## Testar sem gravar

Aba nova com a sessão atual. Na 105, trocar `apex.server.process` por um falso antes de
injetar o JS; na janela 102, trocar `apex.server.plugin` por um falso **que chame
`opt.success`** (sem isso a segunda ação da DA nunca roda e o teste engana).

## Regras da página (auditoria 04/10)

Conferido contra os originais: **105** — 2 ações dinâmicas (Submit Page ao trocar a avaliação, só na
criação; REFRESH ao fechar a janela 102), 6 processos (fetch, DML do formulário, apagar respostas no
DELETE, limpar cache), 4 cálculos, 2 desvios, 7 botões (Salvar/SAVE_QUEST/ATUALIZAR são Never).
**102** — 4 ações (Cancel Dialog, SALVAR ALTERNATIVA, Salvar Dissertativa, Finalizar), 4 processos.
Na 105 criando (sem P105_ROWID) a página fica como era; com a avaliação, os campos do formulário
(todos só leitura pela página) estão no alto e Relatório / Voltar / Excluir avaliação são os originais.
A 102 grava pelas ações dela (setValue → change) e navega pelo Próximo original. Sem mudanças no JS/CSS.

**Divergências do `NC_AVAL_SALVAR` (nosso) com a gravação da 102 — para decidir, nada alterado:**
- A 102 só grava com valor (condição "não nulo" nas duas ações); a 105 também grava texto **apagado**
  (apagar a resposta dissertativa grava vazio) e grava o texto enquanto se digita (1,2 s).
- A 102 cria a linha a partir do ROWID da pergunta, juntando questionário/formação/questão (só cria se
  a pergunta é do questionário); o nosso confia em `x01` (questão) e `x04` (ordem) vindos do navegador.
- A 102 acha a linha por `data_avaliacao = :P102_DATA_AVALIACAO` (conversão implícita); o nosso usa
  `trunc(data_avaliacao) = to_date(…,'dd/mm/yyyy')`. Mesmo resultado com as datas sem hora.
- Erro no banco: a 102 mostra a mensagem do APEX; o nosso devolve `{ok:false}` e a pergunta mostra
  "Não salvou · Tentar de novo" (o erro vai só para o console).
- A 102 tem a mudança de condição do item P102_RESP_DISSERTATIVA ("Descreva") feita pelo aplicar —
  decisão anterior, já documentada acima.

**Decidido (04/10, cliente: "mantém as ações que o programa original faz"):** `NC_AVAL_SALVAR` foi
reescrito para fazer o mesmo que as ações da p102 — sem valor não grava; se a resposta não existe,
insere pelo questionário (formação/questionário/pergunta) e dá commit; depois atualiza
`cod_resposta` e `resp_texto_livre` comparando `to_date(data_avaliacao,'dd/mm/yyyy')`. O texto livre
grava ao sair da caixa (só com texto alterado). `x04` não é mais usado. Importar `f2937_page_105.sql`.
