# Janelas do processo seletivo — app 9113, páginas 38, 10, 13, 3 e 35

Um arquivo para as cinco janelas abertas da página 29 e da ficha do candidato (p32). Cada parte
reconhece a sua janela pelos itens (P38_URL, P10_PROCESSO, P13_COD_PROCESSO, P3_DT_CONTRATACAO,
P35_TEMPLATE_EMAIL) e põe `nc-pj-38`… no body.

Arquivos: `Natcorp_ProcessoJanelas.src.js` / `.src.css` → `../login/…`. JS: `python3
gerar-processojanelas.py`. CSS: `gerar-app.mjs` (AVULSAS). **Sem exportações aqui**: em cada uma
Exportação: `python3 aplicar-recrutamento-paginas.py f9113_page_38.sql f9113_page_10.sql f9113_page_13.sql
f9113_page_3.sql f9113_page_35.sql` (aplicada em 03/10; originais em `*.ORIGINAL.sql`): as duas URLs e o
comentário em cada uma; na 3, o conserto da data (abaixo).
"Requisição" (p36) ficou de fora a pedido.

## Como ficou

| Janela | O quê |
|---|---|
| 38 Detalhes da vaga | link para candidatos com **Copiar link** e **Abrir**; "Como o candidato vê o anúncio"; "Descrição da vaga" em texto legível (não mais tudo em negrito) |
| 10 Anotações das fases | "+" vira **Adicionar anotação**; vazio explicado; DESCRIÇÃO como texto |
| 13 Processo seletivo | ficha "Processo 57463 · Finalizado" com cargo, empresa, filial, CC, vaga, requisição; "Classificação e responsável" (o que se edita); seções abertas; campo só de leitura vira texto; vazio sai; seção toda vazia diz "Nada informado" |
| 3 Aprovar candidato | "Aprovar <nome>" + o que acontece; data de contratação em destaque; **Confirmar aprovação**; se abrir sem candidato, aviso vermelho para usar a ficha |
| 35 Enviar e-mail | **"Nova mensagem", como no Mail do macOS**: barra no alto (título, assunto em cinza, **Fechar** e **Enviar** — os botões originais movidos; o pé da janela some), linhas finas sem caixa — **Para** (iniciais, nome, nome social, e-mail; fase · empresa à direita; sem e-mail: aviso), **Modelo** ("preenche o assunto e a mensagem"), **Assunto** (repetido na barra) — e o corpo ocupando a altura que sobra (`ed.resize`). O editor tem o desenho geral (EDITOR-MANUTENCAO.md) |

## Cuidados

- "Só de leitura" = input/textarea readonly SEM botão de lista/calendário. Campo com botão
  continua campo (ainda se escolhe).
- No modelo "floating label" a caixa do rótulo é flex lado a lado e fica com 0 px: o CSS empilha
  (`flex-direction: column`) e devolve 8 px à esquerda (a linha do grid tem margem -8 e corta).
- **3 — data de contratação**: o processo "Atualiza Data" (depois do cabeçalho) fazia SEMPRE
  `:= hoje + 7`, por cima da data lida do registro. Agora `NVL(:P3_DT_CONTRATACAO, hoje + 7)`.
- **38 — link**: a ação "Popula URL" (ao abrir) reescreve P38_URL; na base de teste aponta para
  `/jobs_dev`. O cartão acompanha o item (MutationObserver).
- **35 — "Para"**: P35_NOME chega como "Fulana (Nome Social)" quando o candidato não está no
  processo; o sufixo sai. A dica "Escolher um modelo preenche o assunto e a mensagem" é a ação
  "Set Template Email" da própria página.
- **10 — anotação**: tocar num item abre a página 11 (edição da anotação), "Adicionar" também.
- 33 Finalizar processo não foi feito: o botão nunca aparece (condição sempre falsa).

## Regras da página (auditoria 04/10)

Conferido contra os `.ORIGINAL.sql`: p38 (1 ação dinâmica, 2 processos), p10 (4/5 ações), p13
(11/18 ações, 5 validações, 7 processos), p3 (11/19 ações, 5 validações, 7 processos), p35 (5/6
ações, 1 validação, 4 processos).
- **Corrigido (p35):** o campo "E-mail" (P35_TO_EMAIL) é EDITÁVEL na página e é para ele que o
  processo "Processo Envia E-mail" manda; sumia junto com a região "Colab Info". Agora o mesmo item
  vai para uma linha "E-mail:" logo abaixo de "Para" (o endereço sai do "Para" para não repetir).
- **Corrigido (p10):** `.nc-pj-bt-mais` (o "Adicionar anotação") punha `display: inline-flex` com
  `!important` e vencia a ação Hide_ADD_HISTORICO (sem processo escolhido). Agora respeita o
  `style="display:none"`. O mesmo cuidado foi posto nos botões movidos da p35.
- Conferido sem problema: p13 e p3 só escondem campos `readonly` (os da ficha do alto); as ações
  de abertura que mostram/escondem campos na p3 rodam antes do desenho; p38 acompanha o P38_URL
  reescrito pela ação "Popula URL".
- **Para decisão:** a regra comum "campo só de leitura VAZIO sai da tela" (p10/13/3/35) esconde
  itens que a página mostra (vazios e travados). Não perde dado nem regra, mas é esconder por
  conta própria; se o cliente quiser o rigor total, basta tirar a classe `nc-pj-vazio` em `[J2]`.
