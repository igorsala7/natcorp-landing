# Requisição de Dependentes (app 200, página 132) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Público: colaboradores e gestores, muitos pelo celular e com pouca intimidade com sistemas.
O desenho troca o formulário de 33 campos por **uma pergunta por vez**:

1. **Quem é o dependente?** — cartões com os dependentes de hoje e "Incluir novo dependente".
   Tocar num cartão escolhe na lista `P132_NUM_DEPEND`; a ação "Popula Dados Dependente" da
   página carrega os dados, como sempre. Num pedido gravado a lista fica fechada no escolhido
   (+ "Trocar dependente").
2. **O que você quer fazer?** — só para quem já é dependente: *Corrigir ou completar dados* /
   *Tirar da lista* (é o `P132_EXCLUIR_DEPENDENTE`, N/S). No "tirar", as seções fecham (os dados
   não mudam) — mas os obrigatórios vazios continuam contando na barra, porque o servidor valida.
3. **Seções por assunto** — Quem é · Onde nasceu · Documentos · Mãe · Benefícios e descontos ·
   Uniforme. O mapa campo → seção (e a largura de cada um) é `SECOES` no `.src.js`. Campo novo
   que não estiver no mapa aparece em **Outros dados**: nada some.
4. **Documentos** e a **barra do rodapé** com o que falta.

## Arquivos (Workspace Images)

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Dependentes.css` | o desenho (gerado de `Natcorp_Dependentes.src.css` por `gerar-app.mjs`) |
| `Natcorp_Dependentes.js` | o comportamento (gerado de `Natcorp_Dependentes.src.js` por `gerar-dependentes.py`) |

A ficha do colaborador e a marca **"Alterado"** vêm do `Natcorp_Style_Min.css` (padrão global).

## O contrato: classes nas regiões

Aplicadas por `aplicar-dependentes-pagina132.py` (pelos nomes; roda uma vez só):

| Região | Classe |
| --- | --- |
| Colaborador | `nc-dep-colaborador` |
| &P132_TITULO. | `nc-dep-solicitacao` |
| Dados do Dependente | `nc-dep-form` |
| Documentos (UPLOAD_DOCS) | `nc-dep-anexos` |
| Botões | `nc-dep-acoes` |

O `Natcorp_Dependentes.js` entra **no fim** da lista de JavaScript da página, depois de
`jquery.maskedinput`, `forms-functions` e `jquery.maskMoney`.

## O que é da página (não do desenho) — conferido na exportação de 29/09

- **Depois de criado, o pedido continua editável nesta página.** Nenhum item tem condição de
  somente leitura; "Esconde Campos (Save)" só esconde Empresa/Matrícula e trava nº e data.
  Se existe trava por situação do pedido, ela está fora desta página (lista, aprovação).
- **Salvar gera um NOVO número de pedido** (`(SAVE) PRE-UPDATE` usa `SEQ_ALTERACAO_CADASTRAL`) e
  o `(SAVE) ON-UPDATE` apaga os pedidos pendentes mais antigos do mesmo dependente.
- **Campo alterado:** o processo "Pintar Campos" compara `DEPENDENTES_TEMP` (o pedido) com
  `DEPENDENTES` (o de hoje) e pinta de amarelo o que difere. A Skin mostra isso em âmbar com a
  etiqueta "Alterado".
- **Comprovantes:** a validação "Valida comprovantes" chama `prc_valida_req_dep_docs` (no banco);
  a regra de quais documentos exigir está lá, não na página.
- **I.R. / Salário Família** são ajustados por JS da página (grau, idade, condição); **Data Laudo**
  só é pedida com condição "Inválido" (validação "Valida DTLAUDO") — a página só a TRAVA fora disso, e o desenho a deixa à vista (travada) desde 04/10.
- Voltar para "Incluir novo dependente" não limpa os campos do anterior (comportamento da página).

## Desligar

Tire as URLs do `Natcorp_Dependentes` (CSS e o último JS da lista).


# Página 133 do app 600 (portal "Conhecendo Você") — os MESMOS arquivos

"Editar: Requisição de Dependentes (Colab.)": o pedido que o colaborador fez no portal, visto por
quem aprova (a página só traz Aprovar / Reprovar / Enviar E-mail; Criar e Salvar não vêm).

Sem classes no APEX: o .js acha o prefixo (`P133_`) e as regiões pelo que elas têm — a do
`NUM_DEPEND` (formulário), a do `COD_REQUISICAO` (vai para o alto), "Documentos", "Pensão
Alimentícia" e os botões. Na p132 as classes do export continuam valendo.

- **O alto**: "Dependentes de Tony · Pedido nº 883 · feito em 02/09/2024" e **"N campos alterados
  neste pedido"** (o servidor pinta de amarelo — `background-color: yellow` — o campo mudado) com
  **"Ver só o que mudou"** (só os campos amarelos; seção sem mudança sai).
- **O dependente do pedido**: um cartão só (o nome vem do `NUM_DEPEND_DISPLAY`), sem "Trocar".
- **Cada seção** diz quantos campos mudaram ("4 alterados").
- **Documentos e Pensão Alimentícia** depois das seções, na largura toda.
- **A decisão** (barra no pé): resumo + Reprovar · Enviar e-mail · Aprovar (os botões do APEX,
  com as mesmas ações). No celular, Aprovar em cima, largura toda.
- O portal usa o modelo de **rótulo flutuante** (o rótulo mora dentro da caixa): as regras de
  rótulo em cima pulam `.t-Form-fieldContainer--floatingLabel`, e as seções ficam uma por linha
  (a coluna da foto come a largura).

Página 133 › JavaScript/CSS › URLs de arquivo (à mão — não veio exportação):
`#WORKSPACE_IMAGES#Natcorp_Dependentes.js` e `#WORKSPACE_IMAGES#Natcorp_Dependentes.css`.
O pedido novo pelo portal (Adicionar novo / Editar existente, com Criar/Salvar) NÃO foi visto
funcionando: conferir quando houver um.


# Janela "Cadastro de Beneficiárias" (app 9132, página 3) — os MESMOS arquivos

A pensão alimentícia de um dependente, aberta pelo **Editar** da região Pensão Alimentícia da
p133. Quem usa é o colaborador. O .js a reconhece pelos itens (`…_NOME_LOV` + `…_CHAVE_PIX` +
`…_CONTA_CORRENTE`), sem classe no APEX e sem teste de app/página. Os ~40 campos das duas
regiões (Pensionista / Correntista) e as abas Ofício / Processo de Pagamento viram:

- **O alto**: "Pensão para Fulana", o parentesco e "Descontada do salário de Tony (matrícula …)"
  (vem do `DSP_MATRICULA`; Empresa e Matrícula continuam à vista na seção "De quem é o desconto" — 04/10).
- **Quem recebe** — nome, parentesco, tipo, nascimento, CPF, RG.
- **O que a Justiça decidiu** — nº do ofício, ordem, valor da garantia, datas e o texto do
  ofício (4 linhas, cresce com o texto; a página abria com 20).
- **Endereço e telefone** — o CEP e o telefone em duas caixas lado a lado (CEP – final,
  DDD + número).
- **Para onde vai o dinheiro** — titular (com **"A conta é de Fulana? Usar o nome e o CPF"**,
  que copia `NOME`/`NUM_CPF`/`DC_CPF` para os campos do titular), banco e conta (número –
  dígito lado a lado) e a **chave PIX**: o tipo vira botões (CPF ou CNPJ · Celular · E-mail ·
  Chave aleatória · Sem PIX; a lista continua escondida e é a enviada) e a caixa da chave (sempre
  à vista — 04/10) ganha o exemplo do formato e o teclado certo no celular conforme o tipo.
- **Quanto é descontado** — a grade interativa "Processo de Pagamento" (processo, tipo de
  pensão, percentual, retenção do FGTS), tirada da aba, na largura toda: só "Adicionar
  processo" e "Salvar lista" na barra. Alteração não salva na grade aparece no rodapé.
- **CPF que não bate** (número × dígito): aviso embaixo do campo; não impede salvar.
- **Rodapé**: o que falta (obrigatórios da página, cada um leva ao campo) + Cancelar e
  **Salvar pensão**. O **Excluir** saiu de perto do Salvar: fica no fim da janela.
- Rótulos em palavras de todo dia (`ROTULOS` no .js); o servidor continua usando os dele nas
  mensagens de erro. Teclado de números no celular nos campos que só têm números (o dígito de
  agência e conta fica de fora: pode ser X).

Página 3 do app 9132 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Dependentes.js`;
CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Dependentes.css` (à mão — não veio exportação).
É o mesmo workspace do portal (os arquivos já servem às duas).

## O que é da página (visto em 30/09, sem o nosso script)

- **CEP e CPF são guardados em duas partes numéricas**: o CEP 04602-000 aparece como `4602` e
  `0` (o zero da frente some). Só se corrige no APEX (tipo texto ou máscara com zeros).
- Ao abrir, a página avisa "Pensionista não cadastrado como dependente!!" (alertify, pelo
  `MENSAGEM_DEPENDENTES`) — com erro de digitação ("depedente").
- Fechar a janela dispara, na p133, a ação do "apexafterclosedialog": PL/SQL + **envio da
  página 133**.
- O texto do ofício tinha `resize: both` (arrastava para o lado e quebrava a tela).


# Lista "Dependentes" do portal (app 600, página 131) — os MESMOS arquivos

A etapa 5 do Conhecendo Você: a lista (MediaList) dos dependentes do colaborador ou do
candidato; cada cartão leva à página 133 (o pedido); o "Adicionar" também (novo pedido). O
terceiro bloco do `Natcorp_Dependentes.js` a reconhece pela lista cujos links levam
`…_NUM_DEPEND` numa página SEM o formulário do dependente (`…_EXCLUIR_DEPENDENTE`).

- **O alto**: "Seus dependentes", o que é a lista, "Toque numa pessoa…" e as contas
  ("10 cadastrados", "2 pedidos esperando o RH").
- **Dois grupos**: "Esperando o RH" (a página marca o pedido com "| Requisição", cor de aviso e
  o nº do pedido no link) e "Já cadastrados". Só os cartões são reordenados; os links são os
  mesmos.
- **Cada cartão**: iniciais, nome (MAIÚSCULAS viram "Jose Augusto da Silva"), parentesco e a
  **idade** calculada da "Data de Nascimento", a situação (Pedido esperando o RH / Cadastrado) e
  "Ver pedido" / "Ver ou corrigir" (no celular, só a seta). O selo "-" da página sai.
- **"Incluir dependente"**: o "Adicionar" da página, grande, logo abaixo do alto (a lista costuma
  ser longa). A ação do "ready" o esconde para quem só consulta: continua escondido.
- "Prosseguir" vira **Continuar**.

Página 131 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Dependentes.js`;
CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Dependentes.css` (à mão).

O que é da página: a região de aviso "Sobre" ("Adicione um novo dependente ou Edite…") é
escondida pelo "ready"; o selo da lista vem sempre "-".

## Regras da página (auditoria 04/10)

**Conferido** contra `f200_page_132.ORIGINAL.sql` (39 ações dinâmicas / 61 ações, 9 validações,
18 processos, 8 botões) e `f600.ORIGINAL.sql` p131 (6 / 8, 1 processo, 9 botões) e p133
(51 / 98, 8 validações, 21 processos, 18 botões). App 9132 p3 (pensão): **sem exportação na
pasta** — só o código foi revisto. Os cartões (dependente, Corrigir/Tirar, tipo PIX, "Usar os
dados") gravam por `apex.item().setValue` e respeitam item travado/escondido; Criar/Salvar,
Aprovar/Reprovar e Adicionar são os botões da página (o Criar da 132 dispara pelas ações de
`focusin` dele, intactas).

**Mudou:**
- `[J6]` a Data Laudo não sai mais da vista fora do "Inválido": a página só a trava.
- `[J6]` os cartões de dependente somem quando a página esconde a lista `NUM_DEPEND` (p133,
  "Inicia": dependente novo digitado pelo nome) — antes ficavam à vista, desabilitados.
- `[J6]` no "Tirar da lista", seção com campo marcado pela validação da página não fica fechada.
- `[J16]` (p3 da pensão) Empresa e Matrícula de exibição (`DSP_*`) voltam à vista, e a caixa da
  chave PIX não some mais sem tipo escolhido (regras que a página não tem).
- `[C17]` o "Incluir dependente" (p131) ganhou `:not([style*="none"])`: o `display` não vence o
  "Permite Alterar = 'N'" que esconde o botão.

**Para decisão:**
- A região da solicitação (`&P132_TITULO.`) sai da vista (nº, data e solicitante vão para o alto);
  o botão `p132_btn_solicitante` fica escondido junto.
- No "Tirar da lista", as seções fecham (com "Ver os dados de …"): é esconder campos por uma
  regra que a página não tem, embora com o botão para abrir.
- p3 (pensão): as regiões antigas saem da vista depois que os campos são levados; o que não for
  campo (botão de região, texto) ficaria escondido — conferir com a exportação quando vier.
- p133: na barra da decisão, só os botões que a página mostra entram; nada mais a decidir.

## Bloco D · a ficha "Dados de Dependentes" (app 300, página 22) — 04/10

A ficha de UM dependente, só para consulta. A página traz o registro (Fetch Row) e não grava; "Alterar Dados" leva à 54
(o pedido, bloco A). É reconhecida por `…_NUM_DEPEND` + `…_OPTOU_PL_MED`, sem `…_EXCLUIR_DEPENDENTE`.

- **Cartão:** iniciais, nome, "Filho · 12 anos" (idade pela data de nascimento), "Nasceu em …", CPF (número + dígito
  juntos, formatado) e o nº do dependente. Ali ficam também **"Pedir alteração"** (o "Alterar Dados" original) e "Voltar".
- **"O que ele tem"** (lista `TEM` em [J24]): imposto de renda, salário-família, plano médico e odontológico, seguro de vida,
  auxílio-creche, auxílio excepcional e carteira de vacinação. Sinal verde = sim, tracinho = não.
- **Partes** (lista `PARTES`): Quem é, Onde nasceu, Documentos, Mãe do dependente, Plano médico, Plano odontológico,
  Outras informações.
  - Só aparece o que está preenchido. Plano e tipo juntam código + descrição.
  - 01/01/1900 conta como vazio. "S"/"N" viram Sim/Não. A UF fica em maiúsculas.
  - Campo preenchido fora do mapa vai para "Outros dados": nada some.
- **Valores:** campos só de leitura vêm do `_DISPLAY`, porque o APEX não desenha o item com o id.
- **"Ver todos os campos":** mostra as regiões originais (`body.nc-dv-todos-on`).
- **Exportação:** `aplicar-dependentes-ficha-app300.py`, chamado pelo `montar-f300.sh`.
- **Cartão do colaborador:** é a peça global Natcorp_Colab. Aqui o campo do colaborador é `P22_MATRICULA_1`, porque `P22_MATRICULA` é a
  matrícula do dependente. O Colab passou a tentar `MATRICULA`, `MATRICULA_DESC` e `MATRICULA_1`, nessa ordem.

## Página 300:54 (Requisição de Dependentes do Portal) — BLOCO A, 04/10

É a mesma requisição da 200:132; as classes `nc-dep-*` e as URLs entram pelo
`aplicar-redesenhos-app300.py` (passo 2 do `montar-f300.sh`). Três diferenças da 132:

- **Não tem `EXCLUIR_DEPENDENTE`** (não tira da lista). O bloco A é reconhecido também pela classe
  `nc-dep-form` na região da lista; sem o item, os botões "Corrigir / Tirar da lista" não aparecem e
  o alto diz "Incluir um dependente ou corrigir os dados".
- **CPF em dois campos**: `NUM_CPF_CONJUGE` + `DC_CPF_CONJUGE` e `CPF_MAE_DEPEND` + `DC_CPF_MAE_DEPEND`
  (na 132 é um `_DISPLAY` só). Estão no mapa SECOES (4 + 2) e no [C4] do CSS; o nome da mãe ganha a
  linha inteira quando o CPF dela vem dividido.
- **Sem a região Documentos** (anexos): a parte some sozinha.

## Ajustes de 04/10 (pedido já gravado, 300:132)

- **Rótulos da mesma linha com a mesma altura** (`alinharRotulos()` no [J10]): um rótulo que quebra
  em duas linhas não desce mais a caixa dele. Roda a cada atualização e ao mudar a largura da tela.
- **Dependente incluído por este pedido**: o APEX põe na lista uma opção com o NÚMERO como texto
  ("13"). O cartão e a pergunta 2 usam o campo Nome (`nomeDe()`), e o cartão diz "Dependente deste pedido".
- **O alto quebra linha**: "N campos alterados" desce para baixo do título (antes espremia
  "Dependentes de Tony" em duas linhas).
- A etiqueta "Alterado" saiu da linha do rótulo: é global, no Natcorp_Paginas [C19].
