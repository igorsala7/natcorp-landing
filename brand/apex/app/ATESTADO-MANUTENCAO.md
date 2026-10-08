# Requisição de Atestados e Afastamentos — Medicina Ocupacional (app 2937, página 91) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A janela aberta pela lista de atestados (p90 "Requisição de Atestados e Afastamentos", botão
"Criar Requisição" ou o link de cada linha). Serve para registrar um atestado médico, uma licença
(casamento, falecimento, doação de sangue, paternidade…) ou um afastamento pelo INSS/acidente.
**Não é o abono de marcações do ponto** (esse é o `Natcorp_Ponto`, app 9503).

Três públicos na mesma janela: o operador do RH/medicina (escolhe empresa e colaborador), o
gestor (Painel do Gestor: registra o da equipe) e o próprio colaborador (Painel do Colaborador: a
página esconde empresa e colaborador). Depois, quem aprova abre o mesmo pedido (Aprovar/Reprovar).

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Atestado.css` | o desenho (gerado de `Natcorp_Atestado.src.css` por `gerar-app.mjs`) |
| `Natcorp_Atestado.js` | o comportamento (gerado por `gerar-atestado.py`) |
| `aplicar-atestado.py` | põe as duas URLs e o comentário numa exportação da página |

Página 91 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Atestado.js` (no FIM da lista:
depois de maskedinput, forms-functions e maskMoney); CSS › URLs de arquivo:
`#WORKSPACE_IMAGES#Natcorp_Atestado.css`. Já aplicado em `f2937_page_91.sql` (original em
`f2937_page_91.ORIGINAL.sql`). Reconhece a janela pelos itens `…_COD_ATESTADO_MEDICO` e
`…_DT_INICIO_AFASTAMENTO` (ou o `_DSP` da consulta) — sem teste de app/página.

## O que muda — pedido novo

- **Título da janela**: "Novo atestado ou afastamento" (no lugar de "Criar/Editar: Requisição de
  Atestados e Afastamentos"). O .js troca o título no documento de fora (mesmo site).
- **Abertura**: o que ter em mãos (as datas e o atestado para fotografar). Para o colaborador
  (sem a parte "Quem"), fala com ele: "Mande o seu atestado para o RH".
- **A região "Dados do Atestado" em partes**, na ordem de quem tem o papel na mão. As linhas do
  APEX são MOVIDAS para dentro de cada parte (os itens continuam os mesmos):

  | Parte | Itens |
  | --- | --- |
  | Quem se afastou | COD_EMPRESA, MATRICULA |
  | Que afastamento é | COD_ATESTADO_MEDICO ("Tipo de afastamento") + pílula "Conta em dias/horas", DT_ATESTADO_MEDICO, COD_MOTIVO, COD_JUSTIFICATIVA ("Justificativa no ponto") |
  | Quando | DT_INICIO ("Primeiro dia"), HORA_INICIO ("Das"), QTDE_DIAS ("Quantos dias"), DT_TERMINO ("Último dia"), HORA_TERMINO ("Até"), e os `_DSP` da consulta |
  | Quem atendeu | COD_ENTIDADE_DSP ("Hospital, clínica ou posto") + Cadastrar, COD_PREST_SERV + Cadastrar médico, COD_DOENCA ("CID") |
  | O atestado | ARQ_1_ANEXO, ARQ_IMG, OBSERVACAO |
  | INSS e acidente (recolhida) | TIPO_ACIDENTE_ES, DT_ALT_PROG, DT_PERICIA — abre sozinha se já tiver algo |

  Parte sem nenhum campo à vista some (ex.: "Quem" no Painel do Colaborador).
- **Tipo "dias/horas"**: o item TIPO_ATESTADO (texto "DIAS"/"HORAS" posto pela ação "Dia ou Hora")
  sai de cena; vira a pílula embaixo do tipo e a frase da parte Quando. As horas só aparecem quando
  o tipo conta em horas (a ação "Seta parametro" da página já mostra/esconde; o .js também esconde
  enquanto não há tipo).
- **Atalhos** (todos por `apex.item().setValue` com o change — as ações da página rodam):
  "Hoje"/"Ontem" no primeiro dia; **1, 2, 3, 5, 7, 15** em "Quantos dias" (a ação "Set
  DT_TERMINO_AGASTAMENTO" calcula o último dia; some quando conta em horas); "Mesmo dia" no último
  dia (a ação "New_1" calcula os dias). A hora digitada "0830" vira "08:30" enquanto digita.
- **A frase que confere o período**: "3 dias: de qua, 30/09 a sex, 02/10" ou "3 horas e 45 min:
  qua, 30/09, das 08:30 às 12:15"; em vermelho se o último dia estiver antes do primeiro ou a hora
  de fim antes da de início.
- **O atestado**: um cartão grande "Tire uma foto do atestado ou escolha o arquivo" (o campo de
  arquivo continua, escondido, e é ele que vai no envio); depois de escolher, a prévia da foto
  (ou o ícone do PDF), o nome e o tamanho; acima de 10 MB fica vermelho e diz o que fazer (a ação
  "FileSize" da página ainda dá o alerta e esconde o Criar).
- **Rodapé**: "Falta: Empresa · Tipo de afastamento · …" (toque leva ao campo e abre a lista, se
  for lista); no celular, os dois primeiros e "+N". Tudo preenchido: "Tudo preenchido. Pode
  enviar." "Criar" aparece como **Enviar pedido**.

## O que muda — pedido gravado

- **Título da janela**: "Atestado nº 57462".
- **Cabeçalho**: nº, situação em cor (1 Em aberto = "Esperando aprovação" amarelo; 2 Concluída e
  5 Aprovada verdes; 4 Reprovada vermelho; 3 Cancelada e 6 Suspensa cinza), tipo e pessoa, a frase
  do período, "Pedido em … por …", "Situação desde" e "Última alteração" quando diferem. As
  regiões **Requisição** e **Log** ficam escondidas (classe `nc-at-oculto`; continuam na página).
- **Leitura**: campos vazios saem; o "[Código 010]" sai do texto; as frases de ajuda saem; o
  anexo vira "Baixar o atestado (17 KB)" (a folha geral desenhava a área "arraste outro para
  substituir", que em leitura não existe).
- **O caminho da aprovação** (o mesmo desenho da Requisição, do Desligamento e do Treinamento):
  a região "Aprovadores" sobe para logo abaixo do cabeçalho e vira uma faixa — "Aprovação",
  o resumo ("1 de 2 · aguardando Fulano", "Aprovado por todos", "Reprovado por …", "Pedido
  cancelado · 2 de 2 aprovaram"), os aprovadores em linha ligados por um fio (verde = aprovou,
  vermelho = reprovou, âmbar = é a vez, cinza = na fila) e o que cada um escreveu. No celular o
  caminho abre por "Ver o caminho". A timeline e a sub-região "Justificativa" continuam na
  página, escondidas: a faixa lê delas e se refaz no refresh da região.
- **Quem aprova**: a faixa ganha contorno âmbar, "é a sua vez", "Confira o atestado e decida." e
  os botões **Reprovar / Aprovar** do APEX dentro dela (os mesmos botões, com os mesmos cliques e
  as ações "Aprovar/Reprovar Dialog Closed"). Na região "Botões" fica só "Cancelar este pedido".
- Situação 1 com todos os aprovadores de acordo: o selo do cabeçalho diz "Em aberto" (não
  "Esperando aprovação").
- "Cancelar" vira **Cancelar este pedido** (não se confunde com "Voltar"); "Salvar" (o
  solicitante no próprio pedido em aberto) vira **Salvar alterações**.

## Defeitos da página (não mexidos — são do APEX)

1. **"Limpa campois"** (change do primeiro dia) limpa `QTDE_DIAS_AFASTAMENTO` e
   `DT_TERMINO_AFASTAMENTO_DSP` — o `_DSP`, não o último dia de verdade. Trocar o primeiro dia
   deixa o último dia antigo com "Quantos dias" vazio. Corrigir: afetar `P91_DT_TERMINO_AFASTAMENTO`.
2. **"Set QTD DIAS AFASTAMENTO"**, **"Valida se tem atestado funcionario"** e
   **"prc_valida_ferias_DTF"** disparam no change de `P91_DT_TERMINO_AFASTAMENTO_DSP` (item de
   exibição): nunca rodam pela pessoa. Quem calcula os dias é a "New_1".
3. **"Valida se tem atestado funcionario"** (hoje NEVER) faz `DELETE`/`INSERT` na tabela `TESTEX`
   e `COMMIT` — depuração esquecida. Se alguém religar, grava lixo a cada data. Apagar essas linhas.
4. Ações que não fazem nada (itens ou seletores que não existem): **"New"** (seletor
   `justificativa` → `alert('teste')`), **"Desabilita/Habilita"** (`P91_DIAS_HORAS_PONTO` →
   `alert('OK')`), **"Dispara Alerta Datas"** e **"Valida data inicioe final"**
   (`P91_MENSAGEM_DATA`, `P91_MENSAGEM_DATA_FINAL`).
5. **"New_1"**: itens a enviar `P91_DT_TERMINO_AFASTAMENTO,, P91_DT_INICIO_AFASTAMENTO` (vírgula
   dupla e espaço).
6. **"Seta Hora tERMINO"** (NEVER) devolve `P91_DT_TERMINO_AFASTAMENTO_DSP` em vez da hora.
7. **Horas travadas**: "Configura Campos Situacao" só libera as horas quando `COD_SIT_FUNC = '01'`,
   mas a validação "HORA ou DIA" exige as horas em todo tipo que conta em horas. Se houver um tipo
   em horas com outra situação funcional, ninguém consegue enviar. **A conferir** com um tipo real
   em horas (nos testes, os tipos vistos contam em dias).
8. Restos de cópia: processo "Initialize form Cadastro de Vacinação", JavaScript de carregamento
   com itens de vacina (comentado), P91_OCUPACIONAL com condição `1=2`, botão "Solicitar Revisão"
   (NEVER), rótulos "Qtde Dias Afastamento Dsp"/"Dt Termino Afastamento Dsp" (o .js renomeia).
9. Dados: o pedido 57462 é de um tipo que conta em DIAS e tem horas 17:00–18:00 gravadas. O
   cabeçalho segue o tipo ("1 dia"); os campos de hora aparecem porque têm valor.

## Testado (30/09, base de teste, sessão do operador)

Desktop 1280 e celular 390, criação e consulta (57462 em aberto, 57622 concluída com anexo): sem
erro de JavaScript, sem rolagem de lado. Na criação: Empresa, Hoje, 3 dias (a página calculou o
último dia 02/10), tipo 003 (motivo 216 veio sozinho, "conta em dias"), o caminho de horas (tipo
simulado "HORAS" → as horas apareceram, "0830" virou "08:30", "Mesmo dia" → a página pôs 1 dia),
foto escolhida (prévia e tamanho), "+4" do rodapé abriu a lista do tipo. Tudo fechado com "Voltar",
**nada enviado**.

## Não visto funcionando

- O envio de verdade (Enviar pedido / Salvar alterações) e as validações do servidor voltando
  com erro na tela.
- A tela de quem aprova DE VERDADE: o usuário de teste não é aprovador; o "é a sua vez" foi visto
  com dois botões de mentira (sem ação) e um aprovador marcado como pendente só na tela.
- O Painel do Colaborador (empresa e colaborador escondidos) e o do Gestor.
- Um tipo que conte em horas de verdade (só simulado).

## Desligar

Tire as duas URLs de arquivo da página.

## Regras da página (auditoria 04/10)

Conferido contra `f2937_page_91.ORIGINAL.sql`: 42 ações dinâmicas (68 ações), 12 validações, 16
processos, condições de itens/regiões/botões. Nenhum processo Ajax nosso (`NC_…`); nada grava por
outro caminho (Enviar pedido/Salvar/Aprovar/Reprovar/Cancelar são os botões originais). As ações de
abertura escondem/travam por id (não por posição), então montar no "ready" não as atrapalha.

Corrigido:
- Atalhos (Hoje/Ontem, 1-15 dias, Mesmo dia) apareciam e gravavam no campo **só leitura** (região
  "Dados do Atestado" travada depois de aprovada: o APEX deixa só um input hidden). Agora somem e
  não agem quando o campo não é editável.
- As horas eram escondidas com o tipo ainda vazio — inclusive no pedido gravado, onde
  `TIPO_ATESTADO` não é carregado. Agora só se escondem com o tipo em DIAS, como a ação "Seta
  parametro" (com o tipo vazio aparecem, como na página).

Para decisão (não mexido):
- No pedido gravado, as regiões **Requisição** e **Log** (itens só leitura) ficam escondidas e o
  cabeçalho mostra o mesmo conteúdo (falta só `COD_EMP_SOLICITANTE`).
- `TIPO_ATESTADO` (só leitura) sai de cena e vira a pílula "Conta em dias/horas"; campos só leitura
  vazios saem da leitura; "INSS e acidente" nasce recolhida no pedido novo (abre num toque).
