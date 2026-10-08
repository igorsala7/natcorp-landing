# Alteração Funcional (app 200, página 116) — como dar manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A página em que o gestor movimenta, transfere e promove um colaborador. O desenho vem de quatro
arquivos da página:

| Arquivo | Onde fica no APEX | Fonte neste repositório |
|---|---|---|
| `Natcorp_Movimentacao.css` / `.js` | Página 116 › CSS / JavaScript › URLs de arquivo | `brand/apex/app/Natcorp_Movimentacao.src.css` / `.src.js` |
| `Natcorp_Beneficios.css` / `.js` | idem (os benefícios são os mesmos da página 168) | `brand/apex/app/Natcorp_Beneficios.src.css` / `.src.js` |

## Para quem é esta tela

O gestor, **60% no computador e 40% no celular**. No computador, cada bloco mostra "Hoje"
numa coluna estreita e "Como fica" ao lado; no celular, um embaixo do outro.

## A regra: a estrutura é do APEX

Ordem, colunas, títulos, rótulos e botões estão no Page Designer e aparecem na tela do mesmo
jeito. O CSS/JS só **redesenha quem tem uma classe** posta no APEX, e não valida nada: motivos,
datas, pisos, parcelamento e benefícios obrigatórios continuam nas ações dinâmicas e nos pacotes.

### Regiões (Aparência › Classes CSS)

| Classe | Região | O que o desenho faz |
|---|---|---|
| `nc-ben-perfil-regiao` | Colaborador Solicitado | Cartão com iniciais (ou foto), nome, matrícula, **cargo hoje**, situação e tempo de casa |
| `nc-mov-intencoes` | O que você quer fazer? (`INTENCOES`, as caixas `P116_BLK_*`) | Cartões por intenção. Cada cartão só **marca as caixas** que já existem; as ações dinâmicas abrem e fecham os blocos como sempre. As caixas aparecem em "Outra alteração". Também a data comum ("A partir de quando vale a mudança?") |
| `nc-mov-alteracoes` | Alterações (`OPCOES`) | Só tira da vista as abas repetidas ("Mostrar Tudo / Empresa / Filial…") |
| `nc-mov-bloco` | cada bloco de Alterações (Empresa, Cargo / Função, Salário…) | Um cartão: nome do bloco e a mudança no alto ("Supervisor de Setor → Gerente") |
| `nc-mov-hoje` | a região "…Atual" do bloco | Coluna "Hoje": os campos de leitura viram texto; os espaçadores vazios somem |
| `nc-mov-depois` | a região "…Proposta" do bloco | Coluna "Como fica": o formulário |
| `nc-mov-salario` | Salário (junto com `nc-mov-bloco`) | "R$ 21.495,65 → R$ 23.645,22 (+10%)" para salário, remuneração variável e total; e a nota do parcelamento numa requisição nova |
| `nc-mov-resumo` | Resumo da movimentação (`RESUMO_MOVIMENTACAO`) | Vazia no APEX: o JS escreve cada mudança e o que falta (datas e motivos). Blocos abertos sem mudança vão numa linha só |
| `nc-mov-acoes` | Botões (`BOTOES`), no fim da página | O que falta, ao lado de "Enviar movimentação" |
| `nc-ben-medidor`, `nc-ben-hoje`, `nc-ben-escolha`, `nc-ben-pacote` | Valor para benefícios (`SALDO_BENEFICIOS`), O que ele tem hoje, Adicionar um benefício, Novo pacote | O desenho da página 168 (ver `BENEFICIOS-MANUTENCAO.md`) |

### Itens (Avançado › Classes CSS; vai para o contêiner do item)

| Classe | Itens | Desenho |
|---|---|---|
| `nc-mov-moeda` | `P116_SALARIO`, `P116_REMUNERACAO_VARIAVEL`, `P116_TOTAL_REMUNERACAO` | O valor de leitura em reais (R$ 21.495,65) |
| `nc-ben-segmento` / `nc-ben-chips` / `nc-ben-cartoes` / `nc-ben-valor` | `P116_OPCAO` / `P116_BENEFICIO` / `P116_TIPO_BENEFICIO` / `P116_VALOR` | Como na página 168 |

### As categorias do passo 2 (no `Natcorp_Movimentacao.src.js`, lista `CATEGORIAS`)

Tocar numa categoria abre a lista do que pode mudar nela; cada item marca ou desmarca a caixa
`P116_BLK_*` de verdade (as ações de sempre mostram o bloco e, ao desmarcar, o escondem e LIMPAM
o que foi preenchido). O estado vem sempre das caixas.

| Categoria | Itens (caixa) |
|---|---|
| Vaga (headcount controlado) | Vaga (`VAGA`), Salário (`SALARIO`) — no APEX, marcar a Vaga desmarca os outros blocos |
| Promoção | Cargo e função (`CARGO`), Salário (`SALARIO`) |
| Transferência | Empresa, Filial, Centro de custo (`HIERARQUIA`), Unidade administrativa (`UNID_ADM`), Atividade, Centro de custo contábil e unidade de negócio (`CCUSTO_CONT`), Local de trabalho, Sindicato, Valor faturável |
| Jornada ou horário | Jornada, Horário, Tipo de modalidade |
| Reajuste de salário | Salário (um toque, sem lista) |
| Situação | Situação (um toque, sem lista) |

"Variável e benefícios" e "Outra alteração" saíram (30/09): todo bloco está numa categoria.
As caixas de verdade ficam fora da vista. O bloco do item que a pessoa acaba de marcar abre
sozinho (`BLOCO_DE` liga a caixa ao título do bloco); nenhum outro abre contra um toque dela.

**Pedido novo:** ao escolher o colaborador, uma ação do APEX marca TODAS as caixas. O desenho as
desmarca uma vez, só se estiverem quase todas marcadas (8+), sem nada preenchido e sem erro de
envio. Desde 04/10 desmarca COM o change (as ações de cada caixa escondem o bloco e limpam os
campos, como se a pessoa desmarcasse); antes era em silêncio — ver "Regras da página" no fim.

## O que o desenho faz (30/09, no padrão das outras requisições)

**Pedido novo (gestor):** (a "data comum" — "Usar esta data nos blocos abertos" — saiu em 30/09)
quatro passos numerados nos títulos — 1 Quem vai mudar (o cartão do
colaborador), 2 O que você quer fazer (as intenções), 3 Preencha como fica (os blocos abertos),
4 Confira e explique (o resumo + o Parecer). No pé, uma barra fixa com a frase ("Tony · muda
cargo / função"), os botões vermelhos do que falta (o valor novo do bloco aberto, datas e
motivos vazios, o motivo do Parecer) — tocar leva ao campo, e numa lista popup já a abre — e o
**Enviar movimentação**, que clica o `CREATE` de verdade (o original fica escondido). O Parecer
ganha "Por que essa mudança?" e começos de frase (lista `MOTIVOS` no `.src.js`).

**Pedido gravado (RH, diretoria, remuneração):** o título da região `&P116_TITULO.` vira
"Pedido nº 57702" com a situação em selo; abaixo, quem abriu, quando e o cargo de quem abriu
(o que `P116_SOLICITANTE` diz). Número, data e solicitante saem dos campos (já estão no
cabeçalho); a **Situação continua** quando é editável. A região **Aprovadores** sobe para logo
abaixo, na largura toda, como o caminho (aprovou / aguardando / na fila); Aprovar e Reprovar só
aparecem ali quando há uma etapa pendente e os botões vieram do servidor. "O que muda neste
pedido" (o resumo) sobe para logo depois do colaborador. Se nenhum campo dos blocos abertos é
editável, os cartões de intenção somem (leitura). Com o `SAVE` à vista, a barra do pé mostra
**Salvar alterações**.

**Benefícios (30/09) — o mesmo arranjo da Requisição de Benefícios (200:168):** no APEX a linha
é 4 + 3 + 5 colunas e "Adicionar um benefício" ficava espremido em 3/12. O JS marca a linha
(`nc-mov-ben-grade`) e o CSS a refaz como na 168: **pedido novo** — Adicionar à esquerda (5/12);
à direita (7/12) o Novo pacote e, embaixo dele, O que ele tem hoje. **Pedido gravado** — os
Requisitados e depois o de hoje, na largura toda, sem a barra do saldo (a 168 também não a
mostra). Celular: Adicionar → Novo pacote → Hoje. No pedido gravado o "Novo pacote" existe
escondido e vazio: o Natcorp_Beneficios.js usa os Requisitados no lugar dele (`itensDoPacote`)
para comparar "hoje" e para a barra do saldo (antes marcava tudo como "Sai do pacote").

**"Adicionar um benefício" por dentro (30/09), também como na 168:** na exportação, "Quanto neste
benefício?" dividia a linha com Quantidade e Total (4/4/4) e ficava esmagado (o −/+ e o aviso
de saldo cortados). O script de aplicação põe a estrutura da 168: `P116_VALOR` com sequência
2715 (antes do mínimo), numa linha só dele; `P116_VALOR_MIN` "Valor mínimo", `P116_VALOR_MAX`
"A empresa paga até", `P116_QUANTIDADE` e `P116_TOT_MULTIPLO` com 3 colunas cada, numa linha;
"Escolha o benefício" em linha própria; o botão `ADICIONAR` "Adicionar ao pacote". Rodar o
script num arquivo já aplicado faz só esta parte. O CSS (Natcorp_Beneficios) alinha as quatro
caixas pela base e as põe em 2 × 2 no celular.

**Salário (30/09):** Salário | % aumento, Remuneração variável | % aumento RV e Total | %
aumento total ficam lado a lado, como o APEX os põe (a ação dinâmica calcula um pelo outro); o
% numa coluna estreita, também no celular. Uma linha acima do par diz "Digite o salário novo ou
o % de aumento: um calcula o outro". O rótulo `P116_PERC_SALARIO` vira "% Aumento Salário"
(era "% Aumento Rem."). Atenção: as regras de coluna do bloco valem SÓ para Hoje | Como fica
(`.nc-mov-bloco > .t-Region-bodyWrap > .t-Region-body > .container > .row`); uma versão sem o
`>` empilhava os campos de dentro.

**A fila de blocos (30/09):** com 7 ou mais blocos abertos, Hoje | Como fica lado a lado virava
uma página sem fim. Agora cada bloco é uma **linha** (estado, nome, "hoje → como fica" e o selo
Pronto / Falta N / Preencher; no pedido gravado, Muda / Sem mudança) e só **um** fica aberto —
tocar na linha abre/fecha. Aberto: a coluna Hoje sai da vista (continua no DOM) e cada campo de
"Como fica" traz **"Hoje: …" logo acima da caixa** (pareados pelo rótulo, sem "(…)", acentos e
"Atual/Proposto"); o que só existe do lado de hoje vira a linha "Também hoje". No pé, **Continuar:
<próximo bloco que falta>** (no último, "Conferir o resumo"). O passo 3 mostra o placar "N de M
blocos prontos". Abre sozinho: no pedido novo, o primeiro que falta; um bloco que uma intenção
acabou de abrir; um bloco com erro do servidor; o bloco do campo tocado na barra do pé. No
pedido gravado, todos começam fechados (o resumo está no alto). O bloco Salário também "muda"
quando só a remuneração variável muda. Abrir/fechar não mexe em nenhuma caixa `P116_BLK_*`.

**O quadro Antes | Depois (30/09) — a olhada de quem aprova:** o resumo virou um quadro com uma
linha por CAMPO que muda (Cargo, Função, Salário, Total…): o antes apagado, o depois em destaque
numa coluna tingida, % nos valores em dinheiro; agrupado por bloco com "Motivo" e "A partir de".
Vem dos próprios blocos (cada campo de "Como fica" preenchido × o seu par de hoje, pelo rótulo;
igual a hoje não entra; %, parcelamento, "para treinamento" e categoria ficam de fora). No pedido
gravado a ordem é: cabeçalho (numa faixa, com a Situação ao lado) → **"O que muda para <nome>"**
→ a decisão (Aprovar/Reprovar vão para baixo do quadro, só na vez de quem vê) → o caminho da
aprovação → o colaborador → os blocos. No celular, as mesmas colunas Antes | Depois, o campo em
cima. No pedido novo, o mesmo quadro é o passo 4, com o "Falta" de cada bloco.

**Pedido gravado (30/09, segunda versão):** cabeçalho → colaborador → "O que muda para <nome>"
(o motivo do gestor no alto, o quadro Antes | Depois, os benefícios — o que entra, sai, muda e o
total — e a decisão) → o caminho da aprovação. O passo 2 e os blocos com todos os campos
(Alterações, Benefícios, Parecer) ficam recolhidos em **Ver todos os campos do pedido**; um
"Falta" da barra que aponte para dentro deles os abre sozinho.

**Barra do pé:** depois de um envio recusado, "O envio voltou com N problemas · Ver quais" (a
lista do APEX fica no alto da página); "Distribuir R$ X em benefícios" quando sobra saldo;
"Motivo da mudança" só depois de escolher o colaborador; com 4+ mudanças, a frase resume
("Tony · 10 mudanças: filial, cargo e mais 8"). "Outro Colaborador" só com colaborador escolhido.

**Valor do benefício (Natcorp_Beneficios):** rótulo em cima e campo na largura toda (na 116 os
itens vêm com rótulo ao lado, 2/12 cada); a faixa à vista ("Escolha um valor de R$ 39,00 até
R$ 60,00"); atalhos Mínimo / Máximo (ou "Tudo o que sobra"); o campo já começa no mínimo; valor
fixo (mínimo = máximo, ou só mínimo — ex.: Gympass R$ 117) preenchido e travado; − e + mudam na
hora e só mandam ao servidor quando a pessoa para; centavos arredondados e o teto é o saldo
arredondado para baixo; "Adicionar" com valor fora da faixa é barrado com o aviso no campo (sem
a caixa de OK do APEX).

**Desempenho:** o desenho redesenha uma vez por respiro (120 ms) e no fim de cada rajada
(`ajaxStop`), não a cada chamada. Para medir no console: `__ncMovT` (vezes e milissegundos).

**Hoje → Novo em cada campo (01/10):** no bloco aberto, cada campo que tem par de hoje vira uma
linha só: à esquerda a caixa cinza com o selo **Hoje** (só leitura), uma seta rosa e o campo
**novo** com a marca roxa à esquerda; no alto do bloco a legenda "Hoje → Como fica (novo)".
Campos sem par (motivo novo, %, "para treinamento", categoria) ocupam a linha sozinhos. No
celular, a caixa de hoje fica em cima do campo. **Largura:** todas as regiões de primeiro nível
na largura toda (o passo 2 ficava em 8/12 no APEX). **"Ver todos os campos do pedido"** abre e
rola até "O que você quer fazer?".

**Quadro, 01/10:** cada linha do Depois traz **"A partir de"** e **"Motivo"** informados
(motivo/data vão com o campo que vem antes deles no bloco — Cargo tem os seus, Função os dela;
os que vêm antes de qualquer campo valem para o bloco; totais não levam). O título de cada grupo
é uma faixa própria (fundo claro e marca roxa à esquerda). **Barra do pé** dentro da página:
`left`/`right` seguem a `.t-Body-content` (240 px com o menu aberto, 48 recolhido, 0 no
celular), por variáveis CSS que o JS atualiza (resize, ResizeObserver, fim da transição do menu).

**Máscara de dinheiro (01/10) — R$ 999.999.990,90, sem mudar o que vai ao Oracle:** os campos
de dinheiro guardam o número PURO (vírgula decimal, sem ponto de milhar e sem "R$": `5200`,
`4028,85`) — é assim que as ações dinâmicas os preenchem e que o banco recebe. A máscara NÃO
mexe nesse campo: uma caixa de exibição (`nc-moeda`, sem `name`) fica por cima e o campo de
verdade (`nc-moeda-real`) sai da vista e do Tab. Ao sair da caixa, o número puro vai ao campo
de verdade por `apex.item().setValue` (dispara as ações de sempre); quando o servidor muda o
campo, a caixa se atualiza (change + ajaxStop). Campos: `P116_SALARIO_PROP`,
`P116_REMUNERACAO_VARIAVEL_PROP`, `P116_TOTAL_REMUNERACAO_PROP` (só leitura),
`P116_VLR_AUX_TIPO_MOD_PROP`, `P116_VALOR_FATURAVEL_PROP`, `P116_VAGA_VALOR_FAT_PROP`,
`P116_VAGA_VLR_AUX_TP_MODAL_PROP` (lista `CAMPOS_MOEDA` no .src.js) e o valor do benefício
(`P116_VALOR`/`P168_VALOR`, sem o "R$" porque a moldura já mostra). O código mora no
Natcorp_Beneficios (`window.ncMoeda`), que carrega antes nas duas páginas. Entrar no campo
seleciona o valor; digitar "5300" mostra "R$ 5.300" e, ao sair, "R$ 5.300,00".

Cuidado ao procurar o campo do valor do benefício no JS: com a máscara há TRÊS inputs no
contêiner (a caixa `nc-moeda`, a régua `nc-ben-regua` e o campo de verdade). `item()` no
Natcorp_Beneficios pula os dois primeiros — antes de 01/10 ele achava a caixa e a régua e o
"Tudo o que sobra" escreviam nela, sem nada chegar ao APEX.

**Rolagem (01/10):** toda ida a uma região ("Continuar", tocar num bloco, "Conferir o resumo",
"Ver todos os campos") passa por `rolarAte()`: desconta a barra fixa do topo (`.t-Header`, 48 px,
medida na hora) e deixa 12 px de folga. Não usar `scrollIntoView({block:'start'})` — ele ignora
a barra e o título fica por baixo dela. Como os blocos que abrem e fecham ainda mudam de altura
durante a rolagem, ela confere onde parou e acerta (até 3 vezes). Medido: título a 60 px, no
computador e no celular.

**Celular (medido em 390 px, 01/10):** nenhum transbordo, nenhuma letra abaixo de 12 px. Os
cinzas de apoio (Antes do quadro, "Hoje", rótulos da Skin) subiram para ≈ 6–9:1; no celular os
campos têm 44 px e letra de 16 px (o iPhone não dá zoom ao tocar), os botões dos cabeçalhos
das regiões ("Refazer Distribuição") 40 px e a bolinha da régua 26 px. Os rótulos dos campos só
de leitura vêm da Skin com seletor mais forte — a regra usa `:not(#nc-mov-x)` só para somar peso.

Os códigos ficam em tudo: "624 - Supervisor de Setor", "700 - Natcorp do Brasil" (só a caixa
das palavras de ligação muda).

## Situações comuns

- **Bloco novo em Alterações** (com um "…Atual" e um "…Proposta"): ponha `nc-mov-bloco` no pai,
  `nc-mov-hoje` e `nc-mov-depois` nos filhos. O script faz isso sozinho para qualquer bloco
  nesse formato.
- **Mudar o que uma intenção marca:** a lista `INTENCOES` no `Natcorp_Movimentacao.src.js`.
- **Tirar o desenho de um item ou região:** tire a classe.
- **Desligar tudo:** tire as URLs de arquivo da página e ponha `RESUMO_MOVIMENTACAO` em
  Condição › Nunca.
- **O parcelamento não aparece numa requisição nova:** é assim no APEX — a região "Parcelamento
  de Aumento Salarial" só existe quando já há parcelas gravadas para a solicitação. O desenho
  diz isso ao lado de "Parcelamento de Aumento de Salário = Sim".
- **"Valor para benefícios" aparece também na consulta:** a região nova não é escondida pelas
  ações "(Pesquisa) Consulta Req. Benef.". Se incomodar, acrescente a ela um Hide nessas ações.
- **Renomear um item `P116_*` citado acima:** ajuste também o `.src.js`.

## Aplicar numa exportação da página

```sh
python3 brand/apex/app/aplicar-movimentacao-pagina116.py f200_page_116.sql
```

Exporte a página 116 **do mesmo ambiente onde vai importar**. Em 30/09 aplicado sobre a
exportação de 30/09 (backup em `f200_page_116.ORIGINAL.sql`; a base de 28/09 ficou em
`f200_page_116.ORIGINAL-2809.sql`).

Para testar sem importar: `simular-movimentacao-p116.js` faz no navegador o que o script faz na
página (classes, regiões novas, botões no fim). Injete-o ANTES do Natcorp_Beneficios.js e do
Natcorp_Movimentacao.js, numa aba nova. O script acha tudo pelos nomes e
para, sem gravar nada, se não achar algum.

## Gerar os arquivos

```sh
node brand/apex/app/gerar-app.mjs              # gera ../login/Natcorp_Movimentacao.css (e as outras)
python3 brand/apex/app/gerar-movimentacao.py   # gera ../login/Natcorp_Movimentacao.js
python3 brand/apex/app/gerar-beneficios.py     # gera ../login/Natcorp_Beneficios.js (168 e 116)
```

Suba os quatro arquivos de `brand/apex/login/` em Workspace Images.

## Regras da página (auditoria 04/10)

**Conferido** contra `f200_page_116.ORIGINAL.sql` (30/09, sem desenho): 329 ações dinâmicas
(681 ações), 84 validações, 39 processos, 12 botões, as condições e os "só leitura" dos itens.
O `.sql` aplicado não acrescenta nenhum processo Ajax `NC_…` (o único sob demanda,
`get_lov_display`, já é da página): nada grava por fora do botão da página. O Enviar/Salvar da
barra só clica o `CREATE`/`SAVE` de verdade (validações e processos são dele). As ações de
abertura são todas por nome de item ou id de região: mover regiões não as afeta, e o desenho
monta antes delas — o que mantém a ordem certa com o seletor de abas ("Mostrar tudo" antes das
ações que escondem os blocos). Não trocar para `apexreadyend` sem rever isso.

**Corrigido:**
- Cartões do passo 2 ignoravam o estado das caixas `P116_BLK_*`: marcavam caixa que a página
  esconde (as outras quando a Vaga é marcada; Situação / C.Custo contábil pela permissão) ou
  desabilita ("Desabilita Salario"/"Desabilita Cargo" com `P116_IND_REQ_ALT_*` = N; Salário só
  leitura com vaga escolhida; Vaga só leitura no pedido gravado). Agora `estadoCaixa()`: caixa
  escondida não aparece; travada aparece sem toque; só a livre marca.
- O "desmarcar tudo" do pedido novo (`zerarCaixas`) desmarcava em silêncio (sem change) e
  escondia o bloco por conta própria: as ações de cada caixa não rodavam e os valores ficavam nos
  campos escondidos, indo no envio. Agora desmarca com change (como a pessoa desmarcaria) e
  deixa a página esconder e limpar; caixa travada fica como está.
- Barra do pé: o botão clicava o `SAVE` mesmo depois de a página escondê-lo no próprio clique
  (contra envio em dobro). Agora só clica o original à vista e habilitado, e fica desabilitado
  junto com ele.
- CSS: `.nc-mov-hoje .t-Form-fieldContainer { display:flex }` vencia o esconder das ações
  (Grade/Faixa salarial etc.); agora `:not([style*="none"])`.

**Fica para decisão:**
- Pedido gravado: Nº, data e solicitante (`nc-mov-dito`) e a Situação travada saem dos campos e
  aparecem só no cabeçalho — são itens da página escondidos (o valor continua à vista no título).
- Pedido gravado: Alterações, Benefícios e Parecer ficam recolhidos em "Ver todos os campos";
  um erro do servidor num campo de lá não abre o recolhido sozinho (a barra lista o erro).
- Bloco aberto: a coluna "Hoje" sai da vista (o valor vai ao lado de cada campo e em "Também
  hoje"); "Valor para benefícios" some na consulta (como na 168).
