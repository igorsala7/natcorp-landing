# Requisição de Benefícios (app 200, página 168) — como dar manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A tela tem um desenho próprio, feito por dois arquivos da página:

| Arquivo | Onde fica no APEX | Fonte neste repositório |
|---|---|---|
| `Natcorp_Beneficios.css` | Página 168 › CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Beneficios.css` | `brand/apex/app/Natcorp_Beneficios.src.css` |
| `Natcorp_Beneficios.js` | Página 168 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Beneficios.js` | `brand/apex/app/Natcorp_Beneficios.src.js` (+ ilustrações) |

O mesmo `Natcorp_Beneficios.js/.css` desenha também os benefícios da **Alteração Funcional
(página 116)**: os itens e relatórios têm os mesmos nomes, com o prefixo `P116_` (ver
`MOVIMENTACAO-MANUTENCAO.md`). Ao mudar este desenho, confira as duas páginas.

## A regra: a estrutura é do APEX

**Ordem, colunas, títulos, rótulos e botões estão no Page Designer e aparecem na tela do
mesmo jeito.** Os arquivos não movem, não renomeiam e não duplicam nada. Para mudar a tela,
mude o APEX — o desenho acompanha.

O CSS/JS só **redesenha quem tem uma classe CSS** posta no APEX:

### Regiões (Aparência › Classes CSS)

| Classe | Região | O que o desenho faz | De onde lê |
|---|---|---|---|
| `nc-ben-perfil-regiao` | Colaborador Solicitado | Cartão com iniciais (ou foto), nome, matrícula, situação, "na empresa desde", data de vigência. Os campos de Colab Info saem da vista. | `P168_MATRICULA_DISPLAY`, `P168_COD_EMPRESA_DISPLAY`, `P168_SITUACAO_COLAB`, `P168_DT_ADMISSAO`, `P168_DT_VIGENCIA`, `P168_FOTO_COLAB` |
| `nc-ben-medidor` | Seu valor para benefícios | A barra do saldo, com uma cor por benefício e a frase do que falta. Os itens da região saem da vista (continuam sendo a fonte). Sem colaborador, a região não aparece. | `P168_TOTAL`, `P168_SALDO` e as linhas de `nc-ben-pacote` |
| `nc-ben-escolha` | Adicionar um benefício | Só o respiro do botão "Adicionar ao pacote" | — |
| `nc-ben-pacote` | Seu novo pacote | Cada linha vira um cartão com ilustração e o que muda em relação a hoje (Novo / Igual a hoje / + R$…) | colunas `BENEFICIO`, `TIPO_BENEFICIO`, `VALOR_TOTAL`, `REMOVER` |
| `nc-ben-hoje` | O que você tem hoje | O mesmo cartão, mais discreto; marca o que sai do pacote | colunas `BENEFÍCIO`, `TIPO_BENEFÍCIO`, `VALOR_TOTAL` |
| `nc-ben-acoes` | Botões | Presa ao pé da tela, com o resumo do pacote ao lado dos botões | — |
| `nc-ben-coluna-pacote` | Pacote (sem moldura) | Só o espaço entre as regiões de dentro | — |

### Itens (Avançado › Classes CSS)

No Universal Theme essa classe vai para o contêiner do item (`t-Form-fieldContainer`); o
desenho acha o campo dentro dele.

A lista/campo **continua sendo o item de verdade**. O desenho aparece dentro do próprio item,
logo abaixo do rótulo; quando uma ação dinâmica esconde o item, o desenho some junto.
Clicar num botão/cartão faz `apex.item(...).setValue(...)`: as mesmas ações dinâmicas e
cascatas de sempre disparam, e as validações continuam no servidor.

| Classe | Item | Desenho |
|---|---|---|
| `nc-ben-segmento` | `P168_OPCAO` | Dois botões lado a lado |
| `nc-ben-chips` | `P168_BENEFICIO` | Botões pequenos com ilustração; com **uma** opção só, a pessoa toca nela (04/10) |
| `nc-ben-cartoes` | `P168_TIPO_BENEFICIO` | Cartões ilustrados |
| `nc-ben-valor` | `P168_VALOR` | Campo grande com − / + e uma régua; avisa quando o mínimo do benefício passa do saldo livre (`P168_VALOR_MIN`, `P168_VALOR_MAX`, `P168_SALDO`) |

## O pedido gravado (30/09) — sem classe no APEX

Estas três partes aparecem só com a requisição já criada e são achadas pelo CONTEÚDO (não
precisam de classe nem de reimportar a página no app 200; basta subir os dois arquivos):

| O quê | Como é achado | O desenho |
|---|---|---|
| O pedido | a região que tem `P168_COD_REQ` (título "Requisição de Benefícios: Nº …") | faixa com nº, situação em cor, "Aberto em … por …" e o botão do solicitante. Os campos continuam na região, fora da vista |
| A aprovação | a tabela com a coluna `APROVADOR` | o **caminho da aprovação** das outras requisições: sobe para baixo do pedido, resumo ("1 de 2 · aguardando Fulano"), aprovadores em linha, justificativas; os botões **Aprovar/Reprovar** do APEX vão para dentro ("é a sua vez"). Celular: "Ver o caminho" |
| Benefícios Requisitados | ID estático `BENEFICIOS_REQUISITADOS` (ou título "Benefícios Requisitados…"); o JS põe `nc-ben-requisitados` | os mesmos cartões do pacote; a coluna Operação vira selo: **Novo** (Inserido, ou "-" que não existe hoje = troca), **Continua**, **Sai do pacote** (o valor de antes riscado, no lugar do R$ 0,00); o total diz "+ R$ … em relação a hoje" |

"O que você tem hoje", no pedido gravado, passa a comparar com o que foi PEDIDO (antes dizia "Sai
do pacote" em tudo, porque comparava com um "Seu novo pacote" que não existe nessa tela).
Nada disso vale na página 116 (a Alteração Funcional tem a tela dela).

## O portal do candidato (app 600, página 168)

A MESMA folha e o MESMO script desenham a escolha de benefícios do candidato (etapa "Benefícios"
do Conhecendo Você). O `aplicar-app600.py` põe o contrato na exportação do app 600: a região
"Seu valor para benefícios", as classes, os rótulos, "Enviar pedido" / "Adicionar ao pacote" e
as três listas (Opção, Benefício, Tipo) como LISTA DE SELEÇÃO com rótulo em cima (eram Popup
LOV — sem as opções na página não há botões nem cartões). Diferenças que o script trata sozinho:
o candidato é `P168_COD_CANDIDATO` (não há matrícula nem "o que você tem hoje": nada de "Novo" em
tudo) e o pacote vem em MediaList (o texto do SQL — "<b>Academia</b> | R$ 109,00", "Tipo de
Benefício: …", o link Remover — vira o mesmo cartão; o link é o do APEX, movido).
Cuidado ao testar: o processo "usuario" (antes do cabeçalho) APAGA a lista temporária do
candidato a cada carregamento da página.

## Situações comuns

- **Tirar o desenho de um item ou região:** tire a classe. Ele volta ao normal do APEX.
- **Mostrar/esconder regiões:** a ação dinâmica "Show Region" (quando `P168_MATRICULA` muda)
  mostra ou esconde, junto com as outras, "Seu valor para benefícios", "Pacote" e "Botões":
  sem colaborador escolhido, nenhuma delas aparece — nem a barra com "Enviar pedido".
- **Desligar tudo:** tire as duas URLs de arquivo da página.
- **Mudar título, rótulo, ordem ou coluna:** direto no APEX. Nada a mudar nos arquivos.
- **Renomear um item `P168_*` ou uma coluna dos relatórios listados acima:** ajuste também o
  `Natcorp_Beneficios.src.js` (ou o desenho daquele pedaço para de funcionar em silêncio).
- **Novo tipo de benefício:** nada a fazer — a ilustração é escolhida pelo nome
  (combustível, refeição, carro, previdência, academia, educação, saúde, odontológico,
  transporte, seguro; os demais usam a do presente).

## Gerar os arquivos

```sh
node brand/apex/app/gerar-app.mjs            # gera ../login/Natcorp_Beneficios.css (e as folhas gerais)
python3 brand/apex/app/gerar-beneficios.py   # gera ../login/Natcorp_Beneficios.js com as ilustrações
```

Suba `brand/apex/login/Natcorp_Beneficios.css` e `Natcorp_Beneficios.js` em Workspace Images.

## Regras da página (auditoria 04/10)

**Conferido** contra a exportação original (`f200_page_168.ORIGINAL.sql`: 43 ações dinâmicas,
9 validações, 12 processos, 12 botões), a 168 do app 600 (`f600.sql`: 32 ações, 6 validações,
10 processos) e, na 116, só o que este desenho toca (escolha, saldo, cartão do colaborador).
O desenho não grava nada por outro caminho: Adicionar, Remover, Enviar pedido, Salvar,
Aprovar/Reprovar são os botões/links originais; Opção, Benefício, Tipo e Valor gravam por
`apex.item().setValue` (as ações de change rodam).

**Mudou:**
- CSS [C13]: a regra que punha `display: block` nos itens de "Adicionar um benefício" vencia o
  esconder das ações dinâmicas (Benefício, Tipo, Valor, Mínimo, Máximo, Quantidade, Total na 168,
  116 e 600). Agora respeita `style="display:none"`.
- CSS [C11]: no pedido gravado, a **Situação** (`P168_COD_SIT_REQ`, lista editável, com a ação
  `valida_sit_req` e o Salvar) ficava fora da vista. Agora aparece logo abaixo da faixa.
- JS [J12]: Aprovar/Reprovar ficavam presos na região escondida quando a leitura da tabela não
  dava "é a sua vez", e os que uma ação escondia na abertura nunca voltavam. Agora todo botão que
  a página mostra vai para a faixa da aprovação.
- JS [J5]: o cartão do colaborador só aparece com o item real (matrícula/candidato) preenchido —
  na 116, "Selecionar colaborador" mostrava os campos de escolha e o cartão os escondia.
- JS [J14]: remonta também no `apexreadyend` (depois das ações de abertura).

**Para decisão (não mudado):**
- O `aplicar` da 168 acrescentou à ação "Show Region" esconder a região **Botões** sem
  colaborador: some também o **Voltar** (CANCEL/CANCEL_1), que na página original estava sempre lá.
- [J9] O "Adicionar" é barrado no navegador quando o valor sai da faixa mínimo–(máximo ∩ saldo);
  com só o mínimo cadastrado (sem máximo) o desenho trata como **valor fixo** (campo só leitura).
  Se `pkg_req_beneficio.valida_valor` aceitar valores acima do mínimo sem máximo, o desenho é
  mais rígido que a página.
- [J9] Ao escolher o Tipo, o valor começa no mínimo (por `setValue`) quando o que veio não é
  válido; [J8] com uma opção só de Benefício, ela é escolhida sozinha. Ambos visíveis, mas são
  valores que a pessoa não tocou.
- TOTAL, SALDO e os campos de "Colab Info" são campos de texto editáveis no original (sem
  "Desabilitado" na 168 do app 200); o desenho os mostra como texto (barra/cartão).

**Decidido (04/10, cliente: "precisa ter o botão voltar"):** as 2 ações que escondiam/mostravam a
região BOTOES (com o Voltar) pelo colaborador foram tiradas de `f200_page_168.sql` (base 2, no lugar;
NUNCA regenerar esse arquivo do ORIGINAL) e o `aplicar-beneficios-pagina168.py` não as procura mais.

**Decidido (04/10, cliente):** Benefício com uma opção só não é escolhido sozinho; o valor começando no mínimo da faixa fica (aprovado).
