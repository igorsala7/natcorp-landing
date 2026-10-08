# Comunicação de Acidente/Incidente — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Página "Criar/Editar: Comunicação de Acidente/Incidente" do app SEG_CTRL_NATCORP (2943), página 91,
aberta da lista (p90) dentro do Painel do Operador (p200:784). Duas pessoas usam a mesma página:

- **quem comunica** (gestor ou o próprio colaborador, pouca prática, também no celular): 6 passos
  na ordem em que se conta um acidente — Quem, Quando, Onde, Parte do corpo, O que aconteceu,
  Atendimento e registros. O rodapé gruda no pé da tela e diz o que falta; "Criar Requisição"
  aparece como "Enviar comunicação".
- **quem analisa** (Médico do Trabalho, Técnico de Segurança): a comunicação gravada abre com o
  cabeçalho (nº, aberta em/por, situação) e o **Caracterização CAT** no alto, e a **ficha do
  acidente** — pessoa, dia da semana e hora, horas trabalhadas antes, local, a parte atingida
  marcada na figura (vista de frente: D é o lado direito da pessoa), o relato e os sinais
  (atendimento médico, B.O., óbito). Depois, "Todos os dados da comunicação" e a Aprovação.

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Acidente.css` | o desenho (gerado de `Natcorp_Acidente.src.css` por `gerar-app.mjs`) |
| `Natcorp_Acidente.js` | o comportamento (gerado por `gerar-acidente.py`) — vale para a p91 E para a p92 |

Nas TRÊS páginas (p91, a janela p92 "Parte do Corpo Atingida" e a p31 da análise): JavaScript › URLs de arquivo
`#WORKSPACE_IMAGES#Natcorp_Acidente.js`; CSS › URLs de arquivo `#WORKSPACE_IMAGES#Natcorp_Acidente.css`. **Sem classe no APEX e sem teste de app/página**:
o script acha o prefixo dos itens sozinho (pelo `…_ESPEC_LOCAL_ACIDENTE` na p91, pelo
`…_COD_PARTE_LESADA` + `…_LATERALIDADE` na p92); sem os itens, não faz nada.

## Na criação (o que muda o que o médico vai ler depois)

- **Confira antes de enviar**: no fim, a mesma ficha que quem analisa vai ver, montada ao vivo.
- **Parte do corpo**: o Adicionar só funciona depois do colaborador e da data (ver abaixo); antes
  disso ele fica apagado e diz o que falta, com links para o passo. Se o colaborador for trocado
  depois da data, o script dispara de novo o change da data (uma vez por combinação) para a página
  remontar o endereço da janela com o colaborador certo.
- **Datas**: "Hoje" / "Ontem" na data do acidente; "Mesmo dia do acidente" no último dia trabalhado
  (usam `setValue` com o change — as ações da página rodam como se fosse digitado).
- **Relato**: "Me ajude a contar" escreve as três perguntas (o que fazia, o que aconteceu, o que
  causou); texto curto demais ou só com as perguntas vira aviso e entra no "Falta".
- **Atendimento médico** entra no "Falta" (a página não exige, mas sem ele a ficha fica "Não
  informado"). O documento do atendimento fica sempre à vista (04/10: não espera mais o "Sim" — a página não tem essa regra).
- **No caminho do trabalho** a pergunta vira "Em que ponto do caminho?" e a ficha mostra o endereço
  como "Local de trabalho", não como o lugar do acidente.
- **Janela p92**: o lado em quatro botões (a lista do APEX continua escondida e é a enviada) e a
  figura marcando a parte enquanto se escolhe; "Criar" aparece como "Adicionar parte".
- "Nova" é decidida pelo `P91_ROWID` vazio, não pelo nº: a página já preenche `P91_COD_REQ` ao
  escolher o colaborador (e ele volta preenchido se o envio der erro).

## A análise — p31 "Criar/Editar: Comunicação de Acidente de Trabalho" (Médico do Trabalho / Técnico)

O mesmo arquivo reconhece a p31 pelo `…_COD_MED_EMIT_CAT_1` + `…_DIAGNO_PROVAVEL` (a p91 é cópia
da 31 e carrega o Diagnóstico numa região "NEVER" — só o Diagnóstico não basta) e desenha outra coisa:

- **Cabeçalho do caso**: "Análise do acidente nº …", pessoa, dia da semana e hora, o status
  (Pendente/Concluída) e os relatórios "Investigação (PDF)" e "CAT (PDF)".
- **O caso fixo à esquerda** (desce junto ao rolar): pessoa, quando, onde, a parte do corpo na
  figura (lida da grade interativa da região PARTE), o relato e os sinais (afastamento imediato,
  internação, afastamento com dias, óbito, registro policial). No celular, só o essencial e "Ver
  mais do caso".
- **Quatro frentes no lugar das 13 abas**, cada uma dizendo quantos obrigatórios faltam:
  Atendimento médico (quem atendeu → lesão → internação e afastamento → observações), Classificação
  da CAT (tipo, CAT, classificação, iniciativa, óbito, B.O., nº da CAT, SINAN), Acidente e local
  (quem/quando/onde, relato e a grade das partes) e Investigação (avaliador, fatores, serviço,
  consequência, testemunhas, terceiros, EPIs, custo, plano, 6Ms, conclusão). A frente aberta fica
  guardada por análise (sessionStorage).
- **O perfil manda**: só entra numa frente a aba que a própria página deixou à vista (o "ready"
  esconde as de segurança e os fatores para a área médica).
- Listas curtas (Sim/Não, Inicial/Reabertura/Com Óbito…) viram botões — a lista do APEX continua
  escondida e é a enviada; "Mesmo dia do acidente" / "Hoje" na data do atendimento; "Cadastrar
  médico" logo abaixo do Médico.
- **Barra do pé**: os obrigatórios que faltam (cada um leva ao campo, trocando de frente) e o
  Salvar, que também responde a Ctrl+S / ⌘S.
- **Investigação**, na ordem de uma investigação (Quem investiga → O que a pessoa fazia → Por que
  aconteceu (6Ms) → Consequências → Quem viu → Proteção e custos → O que fazer e conclusão), com o
  índice das seções no alto ("N de M preenchidas"; grade conta só colunas visíveis — a linha em
  branco traz usuário/data escondidos). Exemplos nos campos (cada M dos 6Ms, danos, providências).
  O que repete o caso (Código/Empresa/Colaborador, Empresa/Colaborador da parte do corpo) sai.
- **Grades interativas** (partes do corpo, EPIs, custos): na barra da grade só "Adicionar …" e
  "Salvar lista" (rótulos pela API de ações do IG; "Redefinir" escondido pela API; busca, Ir,
  Ações e o botão Editar escondidos por CSS) e uma linha de "como usar". Alteração não salva numa
  grade aparece na barra do pé com "Salvar lista".
- **Testemunhas/Terceiros**: o botão Adicionar mora DENTRO da barra do relatório (.a-IRR-buttons):
  só a busca e o "Ações" saem. Rótulo "Adicionar testemunha" / "Adicionar terceiro".
- Campos do B.O. só com "Houve registro policial = Sim"; dias e alta só com "Houve afastamento =
  Sim" (ou com valor). Caixas de texto crescem com o texto (altura por variável: a Skin trava).
- A grade das partes é uma região própria dentro de PARTE: o id sai do elemento `.a-IG`
  ("…_ig"). A coluna "Cód. Parte Lesada" traz o NOME da parte; "Descrição" é o texto livre.
- **Acidente NOVO** (a p31 aberta pelo "Criar", `P31_ROWID` vazio — 04/10): a frente "Acidente e
  local" vem primeiro (`ORDEM_NOVO`), o cabeçalho diz "Nova comunicação de acidente" (sem situação e
  sem os PDFs, que pedem o acidente gravado), o caso à esquerda vira guia ("Escolha o colaborador",
  "Falta a data e a hora", "Falta o local", "Toque para…") e o "Criar" vai para a barra do pé como
  "Criar comunicação" (Ctrl+S). O Criar grava tudo de uma vez (formulário, textos das regiões e as
  grades de partes, EPIs e custos); Avaliadores e Arquivos/Fotos só aparecem depois de gravado.
- **As abas que viram regiões das frentes** (04/10, "faltando regiões e itens" na 2ª base): o seletor de
  abas do APEX inicia DEPOIS do desenho e esconde de novo (`style="display:none"`) as abas não ativas —
  sumiam relato, partes, investigação inteira e o Arquivos/Fotos. O CSS dá `display:block` às
  `.nc-aci-inv`, e `escondido()`/`secoesInv()` ignoram esse display (só valem o perfil e o `nc-aci-oculto`).
- **Perfil ao vivo**: a ação "Area Segurança / Médica" roda depois do desenho (espera o servidor), então
  todas as regiões entram nas frentes e `sincronizarPerfil()` segue a aba (`ID_tab`) ou a própria região
  (Avaliadores): fora do perfil → `.nc-aci-perfil-fora`; bloco e frente vazios somem. Para a área
  médica, Fator pessoal / Ato inseguro / Condição insegura somem e a região "Fatores" sai.
- **Grades (partes, EPIs, custos)**: barra/títulos/rodapé "grudentos" do IG ficam no lugar (o rodapé
  ficava por cima da linha).
- **Auditoria** (scratchpad `auditar31.js`): carrega a página com o desenho bloqueado, lista campos,
  regiões e botões à vista, e confere onde cada um foi parar. Resultado 04/10: tudo nas frentes,
  menos os campos condicionais (B.O. só com registro policial = Sim; dias e alta só com afastamento = Sim).
- **Listas em cartões** (04/10, `[J20]`): partes do corpo, EPIs, custos (grades) e testemunhas da
  empresa / de fora (relatórios) viram cartões com "Adicionar …" no fim; a grade e o relatório originais
  continuam na página, escondidos (`.nc-aci-grade-orig`, `.t-IRR-region`).
  · Grades: o cartão abre uma GAVETA com a ficha da própria grade (campos e nomes em `LISTAS`). Acidente
    GRAVADO: Salvar = salvar da grade, na hora. Acidente NOVO: a linha fica na lista ("vai junto ao criar")
    e é gravada pelo "Criar comunicação" — o código do acidente só nasce no Criar (PRE-INSERT). Obrigatório
    vazio (ex.: o EPI) avisa e não fecha. Custos mostram o total.
  · Relatórios: o cartão abre a janela de sempre (p33 / p34, o lápis da linha); "Adicionar" aperta o botão
    original; ao fechar a janela o relatório é buscado de novo.
  · Relatórios com cabeçalho fixo: o APEX faz DUAS tabelas a-IRR-table (a 1ª só cabeçalho, a 2ª com as
    linhas). Ler só a 1ª dava "nenhuma testemunha" (04/10). As células são casadas com a coluna pelo id
    (td headers="C<id>" ↔ th a[data-column]). Testemunhas da empresa não têm lápis nesta página (só
    consulta); as de fora abrem a p34.
  · "Adicionar testemunha" só existe se o acidente ainda não tem testemunha da empresa E o usuário tem a
    autorização do botão (é da página): sem ele, o cartão vazio diz que não está liberado.
  · Gaveta (04/10, 2ª rodada): a ficha da grade só passa o valor para a grade quando o foco vai para
    OUTRO campo dela (Tab) — clicar no Salvar da gaveta não passa; antes de salvar, `sincronizarFichaX()`
    copia cada campo do formulário para a grade (o "Como ficou" digitado se perdia). A gravação é pelo
    MODELO (`model.save()`): a grade das partes não tem Salvar na barra e, assim, a ação "save" existe mas
    não faz nada (dava "Confira os campos destacados" sem campo nenhum). Erro do servidor: mostra a
    mensagem do registro. A caixa de texto do APEX vem num embrulho que não estica (208 px numa moldura
    de 514): o embrulho estica e tocar na moldura põe o cursor no campo.
  · Abrir o registro certo (`irParaX`, o jeito da 2937:11): a "vista de um registro" abre UMA vez e
    nunca fecha; trocar = sai da edição → `recordOffset` = posição (sem excluídos) → entra na edição →
    confere o id. Fechar e reabrir a deixava presa: "Dados não encontrados" depois de um registro novo
    cancelado (04/10).
  · A região da grade é a do id do IG sem "_ig" (o modelo dela não tem .t-Region: `closest('.t-Region')`
    pegava a região de fora com os cartões junto).
- **Documento / Documento B.O.** (04/10): o anexo é o da Skin (132 px, nuvem e "Arraste o arquivo…", campo
  transparente por cima). Uma regra antiga daqui zerava a altura e sobrava só a linha tracejada — parecia
  não ter onde anexar. Regra DA PÁGINA que de fato tira o anexo: a região Atendimento Médico e os dois
  campos ficam só leitura quando há Nº da CAT e ela foi emitida há mais de 45 dias.
- **Cada linha do caso leva ao campo** (pessoa → Colaborador, Quando → Data, Onde → Tipo de local,
  figura → Partes do corpo, Relato → relato), trocando de frente se precisar — também no acidente gravado.

## O que é da página (não do desenho) — lido das ações dinâmicas em 29/09

- Escolher Empresa/Colaborador: PL/SQL traz nome, CPF, filial, local, cargo e o endereço do local
  de trabalho (CEP e endereço ficam travados — vêm do cadastro).
- B.O. = Sim mostra Departamento, nº, data e documento; Óbito = Sim mostra a data do óbito.
- A frequência do dia (jornada, escala, batidas) aparece quando há jornada — vai no passo 2.
- As partes do corpo: o botão Adicionar abre a janela p92; ao fechar, o relatório atualiza.
- **Regra da folha**: nada põe `display` no botão Criar nem nos contêineres dos itens. As únicas
  classes que escondem são as do próprio .js (`nc-aci-oculto`: cartão da pessoa sem pessoa,
  documento do atendimento quando não houve atendimento, campo que a página já escondia por CSS).
- O tema põe `overflow: hidden` no corpo; aqui vira `overflow: clip` (só nesta página) para o
  rodapé poder grudar.

## Defeitos da própria página (encontrados em 29/09, sem o nosso script)

- **A janela da parte do corpo nasce com o colaborador errado.** O endereço dela
  (`P91_URL_PARTE_LESADA`) só é montado no change da DATA do acidente, com o colaborador e o nº
  daquele instante. Medido: data escolhida antes → endereço `…P92_COD_REQ:365785,PO,,,` (empresa,
  matrícula e nº vazios). Sem o nosso script, as partes adicionadas assim não se ligam à
  comunicação. Correção no APEX: remontar o endereço também no change de Empresa/Colaborador (ou
  montá-lo no clique do Adicionar). O script contorna disparando o change da data de novo.
- Antes da data, o Adicionar faz `eval("")`: não abre nada e não diz nada.
- O clique do Adicionar liga um Timer "infinite" de 2 s que atualiza a região para sempre.
- **Laço nas horas.** As ações de `P91_HOR_ACIDENTE`, `P91_HORAS_TRAB` e `P91_HORA_ATEND` formatam
  o valor com `item.setValue(...)`, que dispara `change` de novo → a ação roda de novo → "Maximum
  call stack size exceeded" (conferido digitando 06:30 em Horas trabalhadas). O valor fica certo,
  mas a pilha estoura. Correção no APEX: `item.setValue(horasFormatadas, null, true)` (o terceiro
  argumento suprime o change) ou só chamar `setValue` quando o valor mudou.
- **Horas trabalhadas editável** na comunicação já concluída (os outros campos viram exibição).
- O código do "ready" mostra/esconde abas que não existem nesta página (`#SERVICO_tab`,
  `#CONSEQUENCIA_tab`…) — cópia de outra página; não quebra, mas confunde.

## Desligar

Tire as duas URLs de arquivo da página.

## Exportações aplicadas (30/09)

`aplicar-acidente.py` (reconhece 91, 31 ou 92 pelos itens) aplicou em `f2943_page_91.sql` e
`f2943_page_31.sql`: URLs do Natcorp_Acidente no fim da lista de JS, URL do CSS e o comentário da
página — o resto do arquivo é idêntico ao exportado (conferido). Backups `.ORIGINAL.sql`.
A p92 não veio: ponha as duas URLs à mão (ou mande a exportação e rode o mesmo script).

**04/10 — segunda base.** Veio `f2943_page_31(1).sql`, de outra base (todos os IDs deslocados de
1552299555837261587; o conteúdo é idêntico ao de 30/09). Aplicado com o mesmo script (backup
`f2943_page_31(1).ORIGINAL.sql`). Nessa base as p91 e p92 também ainda não têm o desenho.

## Regra de ouro: o desenho segue as regras da PÁGINA (04/10)

Pedido do cliente: "todos os itens e regiões precisam respeitar as regras definidas na página (ações
dinâmicas, validações, processos)". O que isso mudou na análise (p31):

| Antes (desenho) | Agora |
|---|---|
| Montava 40 ms após o "ready" — "Read Only Local Acidente" (procura os campos em `#LOCAL`) podia rodar depois e não achá-los | monta no `apexreadyend`, depois de TODAS as ações de abertura (fallback 3 s) |
| Escondia B.O. e dias/alta até "Sim" (regra inventada) | não esconde; só as ações da página escondem (ex.: Data do óbito, ação "Óbito") |
| Escondia os `_DSP` que repetem o caso | `REPETIDOS = []`: o que a página mostra, aparece |
| Partes do corpo gravavam na hora (ajax) | grade SEM Salvar na barra grava com o Salvar/Criar da página (onde roda "ao menos uma Parte Lesada"); a gaveta diz "Pronto", o cartão "Será gravado ao tocar em Salvar", a barra avisa; exclusão fica riscada até o Salvar |
| Botões de escolha ficavam à vista com a lista escondida pela página | somem junto (`sel.style.display === 'none'`) |

EPIs e custos têm Salvar na barra no original: continuam gravando na hora (com as validações da coluna,
ex.: "Valida COD_EQUIP"). Conferido em aba de teste (desenho bloqueado × desenho): itens escondidos,
travados e à vista iguais ao original.

## Regras da página (auditoria 04/10) — comunicação p91 e janela p92

Conferido contra `f2943_page_91.ORIGINAL.sql`: 48 ações dinâmicas ativas (+2 "Never"), 14 validações,
16 processos, 14 botões, 5 computações, 160 itens (read-only/required/condições). A p92 não tem
exportação: conferida só pelo código.

- **Montagem (40 ms após o "ready")**: mantida. Nenhuma ação de abertura da p91 procura campos por
  região/posição (todas por id de item ou de região: `apex.item(...)`, `#FREQUENCIA`, `#AVALIADOR`), e o
  que o desenho lê do estado é recalculado a cada change/ajax.
- **Mudou**: o "Documento do atendimento" (`P91_ARQ`) não é mais escondido até "Sim" (regra inventada;
  com "Não" depois de anexar, o arquivo ia escondido no envio). O botão "Caracterização CAT" no
  cabeçalho respeita o "Hide Botão Caracterização" (o CSS forçava `display` por cima). A paginação do
  relatório das partes do corpo voltou (da 16ª parte em diante ficava escondida). Na p92, os botões do
  lado travam quando a lista `LATERALIDADE` está desabilitada.
- **Para decisão**: (1) a região "Requisição" (nº, situação, datas, solicitante — só leitura) sai da
  tela na comunicação gravada e vira o cabeçalho; a empresa do solicitante não aparece no cabeçalho.
  (2) O "Adicionar parte do corpo" fica bloqueado enquanto o endereço da janela não é o do colaborador
  e nº atuais, e o desenho re-dispara o change da data (contorno do defeito da página, acima). (3) O
  "Falta" pede "Atendimento médico" e trata o relato só com o roteiro como vazio — a página não exige
  nenhum dos dois (o envio continua livre; o roteiro sozinho passa no "Value Required"). (4) p92: os
  botões do lado não oferecem o valor vazio da lista (se a página aceita lado em branco, só pela lista).
