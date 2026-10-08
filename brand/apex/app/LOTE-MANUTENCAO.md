# Ajustar vários dias — página 715 do app 9503

Pedido do cliente (08/10/2026): o operador faz ~30 ajustes de marcação por colaborador e cuida de
~30 colaboradores — 900 janelas da 714 abertas uma a uma. A página **715** mostra todos os dias do
período de UM colaborador; a pessoa muda os horários (à mão ou pelos atalhos) e toca em **Salvar**
uma vez. O servidor cria **um pedido de ajuste por horário mudado** — o mesmo pedido que a 714 cria.

A página **714 não foi alterada**.

## Como chega lá

Tratativa de Abono (9503:203) → botão **Ajustar vários dias** (na barra da grade "Marcações"; no
desenho Natcorp_Ponto ele aparece na linha de cima e no menu **Lançar**). O botão abre a 715 em
janela com `P715_EMP, P715_MAT, P715_DT_INI, P715_DT_FIM, P715_OPCAO` (o colaborador, o período e a
visão de Marcações da 203; P/Q = plantão). Ao fechar com **Concluir**, a ação que a região
Marcações já tem (`IR - Dialog Closed Refresh Region_1`) refaz a grade e atualiza a tela.

## Como se usa (2ª versão, 08/10: folha de ponto)

Uma linha por dia (40 px; ~10 dias na janela de 1100×640, a 1ª versão em cartões mostrava 4), as
posições em colunas alinhadas, o previsto em cinza dentro da caixa vazia.

- Digitar `0900`, `9`, `930`, `9:30` ou `9h30` → vira 09:00 / 09:30. Texto que não é horário fica
  vermelho e trava o Salvar até corrigir (Esc volta ao que era).
- **Enter** na caixa vazia usa o previsto e desce para o dia seguinte (Enter, Enter, Enter preenche a
  coluna); Enter na caixa cheia só desce; Shift+Enter sobe; ↑ ↓ andam na coluna; ← → na linha.
- **Preencher previstos** (barra de cima) = o que falta nos dias com problema; a seta ao lado tem
  "trocando também o que está diferente" e "todos os dias de trabalho".
- Motivo e observação valem para todos; no fim da linha, o balão dá outro motivo só àquele dia.
- Caixa roxa com pontinha = vai virar pedido · verde com ✓ = pedido criado · vermelha = não pôde
  (a mensagem abre numa linha logo abaixo do dia) · tracejada com cadeado = já tem pedido aberto.
- Celular: a mesma folha com caixas de 44 px, barra de cima rola junto, observação atrás de um toque.

## Arquivos

| O quê | Arquivo | Como gerar |
|---|---|---|
| Exportação da 715 (página nova) | `f9503_page_715.sql` | `python3 gerar-pagina715.py` |
| Processo que lê os dias | `NC_LOTE_DIAS.plsql.sql` | entra na exportação (ou colar à mão) |
| Processo que cria os pedidos | `NC_LOTE_CRIAR.plsql.sql` | entra na exportação (ou colar à mão) |
| A tela | `Natcorp_Lote.src.js` → `../login/Natcorp_Lote.js` | `python3 gerar-lote.py` |
| A roupa | `Natcorp_Lote.src.css` → `../login/Natcorp_Lote.css` | `node gerar-app.mjs` |
| Botão na 203 | `f9503_page_203.sql` | `python3 aplicar-ponto-pagina203.py f9503_page_203.ORIGINAL.sql f9503_page_203.sql` |

Os modelos da 715 (página, região) e o deslocamento de ids vêm de `f9503_page_714.ORIGINAL.sql`:
importar a 715 na MESMA base de onde veio essa exportação. Em outra base, exportar a 714 de lá,
trocar o `.ORIGINAL.sql` e gerar de novo.

## O que o NC_LOTE_CRIAR faz, por horário (igual à 714)

Validações, na ordem da 714: motivo preenchido · comprovante (motivo que pede anexo volta como erro
daquele horário — o lote não leva arquivo) · Diferente Batida · Data Limite ·
`pkg_pe_abono.valida_posicao` · `pkg_pe_abono.fnc_valperiodoabonopainel` · `prc_valida_qtd_abono`.
`fnc_vallimiteabono` não roda — na 714 ela só roda com P714_COD_EMPRESA/MATRICULA preenchidos, o
que não acontece quando a janela abre pela grade.

Criação: PRE-INSERT (`seq_requisicao`) + Popula Horas + insert em `pe_req_tratamento_batimentos`
(situação 1, datas truncadas como a máscara DD/MM/RRRR da 714) + `pkg_pe_abono.post_insert` +
`pkg_pe_abono.prc_apuracaoreqabono` + "Atualiza batida plantão" (P/Q). Cada horário tem o seu
`savepoint`: o que falha volta e os outros seguem. Mensagem de `post_insert`/apuração vai como aviso
do horário criado (a 714 também não desfaz o pedido nesse caso).

**Não faz** (continua na 714, um por vez): apagar marcação, enviar marcação para outra posição,
anexar comprovante, replicar por N dias.

Acesso: o mesmo da lista "Colaborador" da 714 por painel (PG/PO/PC); perfil com
`pe_perfil_abono_geral.bloqueia = 'S'` não cria (como o botão Criar da 714).

## Testar

1. Instalar `f9503_page_715.sql` e `f9503_page_203.sql`; subir `Natcorp_Lote.js/.css` e `Natcorp_Ponto.js/.css`.
2. 203 de um colaborador com dias vermelhos → **Ajustar vários dias** → os dias aparecem com o previsto.
3. Ajustar UM dia só e salvar; conferir o pedido na lista "Requisições de Abono" e na grade —
   deve ficar igual a um pedido feito pela 714 (mesma situação, horas, motivo, apuração).
4. Só depois, um lote maior.
