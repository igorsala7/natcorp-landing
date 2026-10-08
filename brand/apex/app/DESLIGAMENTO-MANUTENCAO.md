# Requisição de Desligamento (app 200, página 59): como dar manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A página em que o gestor pede o desligamento de um colaborador. O uso é **70% no computador**.
O tom do desenho é sereno: nada festivo, e cor só onde há informação (situação, aprovação e o
que falta).

| Arquivo | Onde fica no APEX | Fonte neste repositório |
|---|---|---|
| `Natcorp_Desligamento.css` | Página 59 › CSS › URLs de arquivo | `brand/apex/app/Natcorp_Desligamento.src.css` |
| `Natcorp_Desligamento.js` | Página 59 › JavaScript › URLs de arquivo | `brand/apex/app/Natcorp_Desligamento.src.js` (+ duas ilustrações de `ilustracoes/desligamento/`) |

## A tela

- **No alto:**
  - Na edição, aparece o cartão do colaborador: foto, nome, matrícula, empresa, e uma linha com
    "como · aviso · último dia". Também mostra o tempo de casa, o contrato (as datas de
    experiência só num contrato determinado) e PCD. À direita fica a ficha da requisição: nº,
    abertura, situação, quem pediu e "Alterar situação", que abre a lista do próprio APEX.
  - Na criação, o alto é uma faixa baixa, "Novo desligamento", que passa a mostrar o nome assim
    que a matrícula é escolhida.
- **Aprovação:** a faixa horizontal, a mesma da Requisição de Pessoal. Numa requisição cancelada
  ou reprovada, ela mostra "Interrompida".
- **Formulário em seções, na ordem do APEX:** Quem vai sair · Como vai ser · Datas e cumprimento
  do aviso · E depois · Por que.
  - Cada seção começa num campo-marco (Situação, Data de Comunicação, Haverá Reposição,
    Justificativa) e vai até o próximo. Um campo novo no Page Designer cai sozinho na seção do
    trecho onde estiver.
  - Cada seção diz "Pronto" ou "Falta N campos". Numa requisição só para leitura, não diz nada.
- **"Na prática":** ao lado de Situação e Motivo, traduz o que já está escolhido. Por exemplo,
  "93 - Inic Empregador S/Jc" vira "Iniciativa da empresa, sem justa causa", e aparece também o
  que o aviso indenizado ou trabalhado significa.
- **Linha do tempo do aviso:** da comunicação até o último dia, com dia da semana e "daqui a N
  dias". Avisa quando as datas estão invertidas. A estimativa do aviso proporcional é só uma
  referência.
- **E depois:** o botão "Criar Requisição de Pessoal" fica ao lado de "Haverá reposição?". A
  pergunta "algo que desabone" ganha um cartão com o porquê do cuidado.
- **Carta:** muda de lugar e de tom conforme a hora:

  | Situação da requisição | Como a carta aparece |
  |---|---|
  | a página mostrou o **"Alerta Anexo de Carta"** | pendência destacada no fim do formulário, "Anexe o aviso assinado antes de criar", e entra no "Falta" da barra (sem o anexo, o Criar volta com o erro do art. 477) |
  | aprovada | logo abaixo da aprovação: gerar → assinar → anexar → conferência do RH (`P59_CHECK_DOCUMENTO`) |
  | outros casos | uma linha no fim, com os botões que a página mostrar, discretos |
  | cancelada ou reprovada | some |

  Um passo cujo botão a página não mostra sai da trilha. Na criação, por exemplo, "Imprima a
  Carta" não existe.
- **Barra do rodapé:** Voltar, o que falta (clicar leva ao campo) e Criar/Salvar. Numa
  requisição só para leitura, o Voltar fica no alto, onde estava.

## A regra: a estrutura é do APEX

Campos e botões são os do APEX. Mudam de lugar na tela, mas continuam com as mesmas ações
dinâmicas. **O desenho não esconde nem trava nada que a página mostre, e o que a página
esconde continua escondido.**

Duas lições pagas nesta página:
- O `!important` do CSS não pode vencer o `display: none` das ações dinâmicas: os contêineres
  usam `:not([style*="none"])`.
- `classList.toggle(classe, x)` precisa de `x` booleano. Em SELECT, `readOnly` é `undefined`,
  e `toggle(c, undefined)` inverte a classe em vez de tirar.

Numa requisição gravada, somem da tela só estes casos:
- campo travado e vazio que não é obrigatório;
- campo cuja lista a ação dinâmica escondeu, deixando o rótulo sozinho (Tipo de Aviso Prévio,
  Indic. Cumprimento).

Na criação, nenhum campo some. O campo travado diz "Preenchido pelo sistema" ou "Libera
conforme as respostas anteriores". A Data de Demissão, com aviso trabalhado, explica que é
calculada a partir da data de comunicação.

### Regiões (Aparência › Classes CSS)

| Classe | Região |
|---|---|
| `nc-desl-solicitacao` | &P59_TITULO. |
| `nc-desl-perfil` | Colaborador Solicitado (`COLABORADOR`) |
| `nc-desl-aprovadores` | Aprovadores |
| `nc-desl-form` | Informações para Desligamento |
| `nc-desl-acoes` | Botões (Voltar / Criar / Salvar) |

O bloco da carta usa o "Alerta Anexo de Carta" (título contendo "anexo de carta"), os botões
"Imprima a Carta" e "Anexe a Carta Assinada" e os itens `P59_CARTA_ANEXADA`,
`P59_EXISTE_ANEXO`, `P59_DT_ARQUIVO` e `P59_CHECK_DOCUMENTO`.

## Comportamentos da própria página (não são do desenho)

Vistos nos testes de 28/09, comparando com a página original:

- **Na volta com erro (depois de Criar), o Motivo fica vazio.** O item tem cascata de
  `P59_SIT_DESLIG,P59_TIPO_CONTRATO`: a página recarrega a lista, e o servidor devolve o texto
  sem o código. É preciso escolher o Motivo de novo.
- **Na volta com erro, "Imprima a Carta" aparece e "Anexe a Carta Assinada" some.**
  - "Imprima" só é renderizado quando a consulta em `reports_desligamento` encontra Aviso,
    Situação e Motivo, o que na criação ainda não acontece.
  - "Anexe" é renderizado com `P59_UPLOAD_CARTA_DESLIG = 'S'`, e uma ação dinâmica na carga o
    esconde quando a requisição ainda não tem situação.
  - Com isso, depois de um Criar recusado por falta de anexo, o usuário fica sem o botão de
    anexar. **Vale corrigir no APEX:** manter na volta com erro a mesma regra de exibição de antes
    do envio.
- **Os alertas (alertify)** vêm de `P59_MENSAGEM`, que o servidor preenche quando um dado viola
  uma regra (matrícula com requisição em andamento, datas no passado…). Com dados válidos, não há
  alerta nem na página original.
- **No navegador de testes (Playwright), a janela de escolher arquivo é capturada** e o arquivo
  não chega ao campo. No navegador normal, abre como sempre.

## Aplicar numa exportação da página

```sh
python3 brand/apex/app/aplicar-desligamento-pagina59.py f200_page_59.sql
```

Exporte a página 59 **do mesmo ambiente onde vai importar**. O script acha as regiões pelo
título e para sem gravar nada se não achar alguma, ou se o desenho já estiver aplicado.

## Gerar os arquivos

```sh
node brand/apex/app/gerar-app.mjs              # gera ../login/Natcorp_Desligamento.css (e os outros)
python3 brand/apex/app/gerar-desligamento.py   # gera ../login/Natcorp_Desligamento.js
```

Suba os dois arquivos de `brand/apex/login/` em Workspace Images.

## Campo novo numa região absorvida (01/10 — P59_NOME_SOCIAL)

As regiões "Colaborador Solicitado" (com a "Colab Info" dentro) e a do título ficam ESCONDIDAS
(`nc-desl-absorvida`): o topo é montado pelo .js a partir de uma lista fixa de campos (nome,
matrícula, empresa, admissão, contrato, situação, deficiência). **Campo novo posto nessas regiões
não aparece sozinho** — precisa entrar no `montarTopo()` do `Natcorp_Desligamento.src.js`.
O `P59_NOME_SOCIAL` entrou assim: nome completo em destaque e "Nome social: …" logo abaixo
(quando houver e for diferente), como na janela "Dados do Colaborador".

## Regras da página (auditoria 04/10)

Conferido contra `f200_page_59.ORIGINAL.sql`: 60 ações dinâmicas (93 ações), 12 validações,
15 processos, 16 botões e as condições/só-leitura dos itens e regiões, item por item do
checklist (montagem cedo, mostrar/esconder, CSS × `display:none`, controles, gravação,
validações, só leitura, botões, abas, valores postos).

O que já estava certo: nenhum controle trocado, nenhum valor posto pelo desenho, nenhuma
gravação própria (Criar/Salvar/Aprovar/Reprovar são os originais, só mudam de lugar); os
contêineres no CSS respeitam `[style*="none"]`; o "Falta" da barra só informa, não bloqueia;
os botões do cabeçalho do formulário (Imprima a Carta OLD/NEW — mutuamente exclusivos —,
Anexe a Carta Assinada, Criar Requisição de Pessoal) e o "Visualizar" do colaborador são
movidos, nunca escondidos.

Mudou (`Natcorp_Desligamento.src.js`):
- **"Alterar situação" nunca aparecia.** `escondido(sit)` contava o `[hidden]` da própria gaveta
  do desenho, então `P59_COD_SIT_DESLIGAMENTO` — que a página libera nas situações 1, 5 e 6
  (cancelar a requisição, `Cancela_Req`) — ficava inalcançável. Agora só conta o que a página
  esconde/trava, inclusive a região do título escondida na criação ("Hide Region").
- **Remonta no `apexreadyend`** (e aos 3 s): as ações de abertura (Habilita/Desabilita Campos,
  Alerta Anexo de Carta, Hide Region) rodam depois da primeira montagem e mudam o que o
  desenho lê; nenhuma delas procura campo por região, então mover cedo não as quebra.

Para decisão:
- Numa requisição gravada, campo **travado, vazio e não obrigatório** some (`nc-desl-sem-valor`).
  É esconder item que a página mostra (vazio e só leitura); manter ou voltar a mostrar?
- Se o relatório "Aprovadores" vier sem linhas mas a página renderizar Aprovar/Reprovar (o
  usuário aprovador sem linha em `usuario_oracle`), a região some com os botões. Caso teórico
  (a condição dos botões e o relatório leem a mesma `aprova_desligamento`).
