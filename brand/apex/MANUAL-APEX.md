# Manual do desenho Natcorp no Oracle APEX

**Para quem é:** desenvolvedores APEX que conhecem Page Designer, itens, regiões e ações
dinâmicas, mas **nunca mexeram com CSS ou JavaScript**. Não precisa saber nada além disso.

**Como usar este manual:** leia a parte 1 inteira uma vez (10 minutos). Depois, volte só à
receita de que precisar (parte 4) ou à parte 5 quando algo der errado.

| Parte | Assunto | Quando ler |
|---|---|---|
| [1](#1-como-tudo-funciona) | Como tudo funciona | **uma vez, antes de tudo** |
| [2](#2-o-caminho-de-uma-mudança) | O caminho de uma mudança: editar → gerar → subir → conferir | antes da primeira mudança |
| [3](#3-cores-e-tamanhos-da-marca) | Cores e tamanhos da marca | ao mexer em cor ou tamanho |
| [4](#4-receitas) | Receitas: as mudanças mais comuns, passo a passo | sempre que precisar |
| [5](#5-quando-algo-dá-errado) | Quando algo dá errado | quando a tela ficar estranha |
| [6](#6-mapa-dos-arquivos) | Mapa dos arquivos: qual arquivo cuida de qual página | para achar o arquivo certo |
| [7](#7-regras-de-ouro) | Regras de ouro | uma vez, e antes de subir algo |
| [8](#8-glossário) | Glossário | quando aparecer uma palavra estranha |

---

## 1. Como tudo funciona

### As três camadas de uma página

Toda página modernizada tem três camadas. Só a primeira é do APEX. As outras duas são
arquivos de texto que o APEX carrega junto com a página.

```
  ┌───────────────────────────────────────────────────────────────────────────────┐
  │  1. APEX — o ESQUELETO e o CÉREBRO                                            │
  │     itens, regiões, botões, ações dinâmicas, validações, processos, banco.    │
  │     Tudo o que é REGRA continua aqui, do jeito que sempre foi.                │
  ├───────────────────────────────────────────────────────────────────────────────┤
  │  2. JavaScript (Natcorp_X.js) — o ARRUMADOR                                   │
  │     quando a página abre, ele MUDA AS COISAS DE LUGAR: junta campos em        │
  │     seções, monta um cartão com os dados do colaborador, escreve ajudas       │
  │     ("Iniciativa da empresa, sem justa causa"), mostra o que falta preencher. │
  ├───────────────────────────────────────────────────────────────────────────────┤
  │  3. CSS (Natcorp_X.css) — a ROUPA                                             │
  │     cores, tamanhos, espaços, bordas, cantos arredondados, e como a tela se   │
  │     arruma no celular.                                                        │
  └───────────────────────────────────────────────────────────────────────────────┘
```

Uma comparação que ajuda: o APEX constrói a casa e instala a parte elétrica. O JS arruma os
móveis. O CSS pinta as paredes. **Se você tirar o JS e o CSS, a casa continua de pé e a
luz continua acendendo**: a página volta ao visual padrão do APEX e funciona normalmente.

### O que os arquivos NUNCA fazem

Esta é a promessa que todo arquivo nosso cumpre. Se um dia você achar algo que a quebre,
é um defeito:

- **Não criam campos.** Todo campo que aparece na tela é um item do APEX.
- **Não validam e não gravam nada.** Quem valida e grava é o APEX, como sempre.
- **Não mudam o valor que vai para o banco.** Uma máscara de dinheiro, por exemplo, muda só
  o que a pessoa VÊ. O valor enviado ao Oracle é o mesmo de antes.
- **Não decidem nada.** Se o APEX travou um campo, ele continua travado. Se uma ação
  dinâmica escondeu algo, continua escondido. O desenho só muda a aparência.

### Dois tipos de arquivo: os gerais e os de página

| Tipo | Arquivos | Onde está ligado no APEX | Vale para |
|---|---|---|---|
| **Geral** | `Natcorp_Style_Min.css` (contém o nosso CSS geral: menu, cabeçalho, regiões, campos, botões, relatórios, janelas) | Shared Components › User Interface Attributes › CSS › File URLs | **todas** as páginas do app |
| **Geral** | `Natcorp_Temas.js` (as "Cores do sistema") | Shared Components › User Interface Attributes › JavaScript › File URLs (app 200) | todas as páginas |
| **De página** | `Natcorp_<Assunto>.js` + `Natcorp_<Assunto>.css` | Page Designer › a página › JavaScript › File URLs, e CSS › File URLs | só aquela página (ou poucas, veja a parte 6) |

Todos ficam em **Shared Components › Static Workspace Files** e são chamados por
`#WORKSPACE_IMAGES#Nome_Do_Arquivo.js`. O `#WORKSPACE_IMAGES#` é trocado pelo APEX pelo
endereço da pasta de arquivos do workspace.

### O "combinado" entre a página e o arquivo

O JS precisa saber **quem é quem** na página. Ele descobre de três formas, e cada arquivo
lista as suas na ficha do topo, em "O COMBINADO COM O APEX":

1. **Por classes nas regiões.** No Page Designer, a região tem `nc-desl-form` em
   *Appearance › CSS Classes*. O JS procura essa etiqueta. **Se alguém apagar a classe,
   aquela parte do desenho some, e só ela.**
2. **Pelo nome dos itens.** O JS lê `P59_NOME_SOCIAL`, `P59_DT_ADMISSAO`… **Se um item for
   renomeado, o JS precisa ser atualizado** (receita R5).
3. **Pelo título de região, texto de botão ou nome de coluna de relatório.** Por exemplo, o
   botão cujo texto tem "Imprim" vira o passo "Gerar a carta". Isso também está escrito na
   ficha do arquivo.

### Como os arquivos estão organizados por dentro

Todos os arquivos seguem o mesmo padrão. Aprendendo a ler um, você lê todos:

```
┌ A FICHA (topo do arquivo) ─────────────────────────────────────────────────┐
│  O QUE ESTE ARQUIVO FAZ · O QUE ELE NÃO FAZ · ONDE ELE ENTRA NO APEX       │
│  O COMBINADO COM O APEX · ÍNDICE · RECEITAS RÁPIDAS · LEGENDA              │
│  COMO LER UM ARQUIVO JS/CSS EM 30 SEGUNDOS                                 │
└────────────────────────────────────────────────────────────────────────────┘
┌ [J1] PRIMEIRA PARTE ═══════════════  (no CSS: [C1], [C2]…)                 ┐
│  O QUE FAZ · COMO · LÊ DOS ITENS · PODE MEXER · CUIDADO · VISUAL           │
└────────────────────────────────────────────────────────────────────────────┘
   … o código da parte …
┌ [J2] SEGUNDA PARTE ════════════════                                         ┐
   …
```

- **O índice tem códigos entre colchetes:** `[J3]` no JS, `[C2]` no CSS. Para ir direto a
  uma parte, use **Ctrl+F** (no Mac, **Cmd+F**) e digite o código, por exemplo `[J3]`.
- **Cada parte do JS diz onde está o visual dela** ("VISUAL Natcorp_Desligamento.css ›
  [C2]"), e cada parte do CSS diz quem a monta ("montado pelo JS em [J3]").
- **As marcas nos comentários:**

  | Marca | Quer dizer |
  |---|---|
  | `PODE MEXER` | Trecho feito para você mudar: textos, listas, títulos. |
  | `CUIDADO` | Leia o comentário antes. Uma mudança aqui pode quebrar a tela. |
  | (sem marca) | Funciona sozinho. Só mexa se souber o que está fazendo. |

### Ler JavaScript em 30 segundos

```js
/* Isto é um comentário. O navegador ignora: é só para pessoas lerem. */
// Isto também: tudo depois de duas barras, até o fim da linha.

var P = 'P59_';                          // guarda o texto 'P59_' com o nome P
var nome = texto(P + 'NOME_SOCIAL');     // lê o que a pessoa vê no item P59_NOME_SOCIAL

function montarTopo() {                  // uma "receita" com nome. Só roda quando
  ...                                    // alguém escreve montarTopo() em outro lugar
}

if (nome) { ... }                        // "se houver nome, faça o que está entre { }"
'Quem vai sair'                          // um texto. Muitas vezes, é o que aparece na tela
```

Três sinais que **nunca** se apagam: o `;` no fim da linha, e os pares `{ }`, `( )`, `' '`.
Apagar um deles quebra o arquivo inteiro. A parte 5 explica como perceber isso.

### Ler CSS em 30 segundos

Cada regra tem duas partes: **QUEM** (em que pedaço da tela vale) e **COMO** (a aparência).

```css
@app.nc-desl .nc-desl-topo {      /* QUEM: o cartão do alto da página 59 */
  border-radius: 18px;            /* COMO: cantos arredondados de 18 pontinhos */
  background: #fff;               /*       fundo branco */
  padding: 22px;                  /*       espaço por dentro, entre a borda e o conteúdo */
}
```

| Você vai ver | Quer dizer |
|---|---|
| `.algo` (com ponto) | uma **classe**: uma etiqueta posta num pedaço da tela, pelo APEX ou pelo JS |
| `@app` | atalho que dá prioridade às nossas regras sobre as do tema do APEX |
| `html body:is(.t-PageBody…):not(#nc-a1):not(#nc-a2)` | é o mesmo `@app`, por extenso. Aparece no arquivo que sobe para o APEX |
| `:not(#nc-desl-x)` | "peso extra" para vencer uma regra do tema. Pode ignorar ao ler |
| `!important` | o mesmo "vencer o tema". No arquivo que sobe, toda linha tem um |
| `@media (max-width: 767px) { … }` | as regras de dentro só valem em telas de até 767 pontos (celular) |
| `var(--nc-roxo)` | uma **cor da marca pelo nome** (parte 3). Acompanha o tema de cores escolhido |
| `px` | pixel, um pontinho da tela. O texto normal tem 14 a 16px |

---

## 2. O caminho de uma mudança

### Onde ficam os arquivos

```
brand/apex/
├── MANUAL-APEX.md                ← este manual
├── app/                          ← AS FONTES: é aqui que se edita
│   ├── Natcorp_Desligamento.src.js
│   ├── Natcorp_Desligamento.src.css
│   ├── DESLIGAMENTO-MANUTENCAO.md   ← o guia daquela página (a tela, as decisões, as lições)
│   ├── gerar-desligamento.py        ← o "gerador" do JS daquela página
│   └── gerar-app.mjs                ← o gerador de TODOS os CSS
└── login/                        ← OS ARQUIVOS PRONTOS: é daqui que se sobe para o APEX
    ├── Natcorp_Desligamento.js
    ├── Natcorp_Desligamento.css
    └── Natcorp_Style_Min.css
```

**Por que existe uma "fonte" (`.src`) e um "pronto"?** O arquivo pronto recebe coisas que
seriam chatas de escrever à mão: o CSS ganha o `!important` e o prefixo longo em todas as
linhas, e o JS ganha as ilustrações embutidas. Você escreve o simples (`.src`) e o gerador
produz o completo.

### Caminho A, o normal: com o repositório

1. **Antes de tudo, guarde uma cópia** do arquivo `.src` que vai mexer (ou confira que o Git
   está em dia). É o seu "desfazer".
2. **Edite a fonte**, em `brand/apex/app/Natcorp_X.src.js` ou `.src.css`. Use um editor de
   código (VS Code, Notepad++), **nunca o Word**: ele troca as aspas e estraga o arquivo.
3. **Gere o arquivo pronto.** No terminal, na pasta do projeto:
   - CSS: `node brand/apex/app/gerar-app.mjs`. Gera TODOS os CSS, os de página e o geral.
   - JS: `python3 brand/apex/app/gerar-<assunto>.py`, por exemplo
     `python3 brand/apex/app/gerar-desligamento.py`. A parte 6 diz o gerador de cada página.
4. **Suba o arquivo pronto** (da pasta `brand/apex/login/`) em
   *Shared Components › Static Workspace Files*, **substituindo** o arquivo de mesmo nome.
   O nome tem que ser idêntico, inclusive maiúsculas: `Natcorp_Desligamento.js` não é
   `natcorp_desligamento.js`.
5. **Confira** (parte 5, "Conferir uma mudança"): abra a página numa **aba nova** e force o
   recarregamento com **Ctrl+Shift+R** (no Mac, **Cmd+Shift+R**).

### Caminho B, a exceção: mudança pequena e urgente, sem o repositório

1. Em *Static Workspace Files*, **baixe** o arquivo e guarde uma cópia intacta (o desfazer).
2. Edite a outra cópia no editor de código.
3. **No CSS pronto**, toda linha nova precisa terminar em `!important;` e começar com o
   mesmo prefixo das vizinhas. Copie uma regra parecida e mude só o valor.
4. Suba, substituindo, e confira (passo 5 acima).
5. **Obrigatório: faça a mesma mudança na fonte `.src`** (ou avise quem cuida do
   repositório). Se não fizer, **a próxima geração apaga a sua mudança**, porque o arquivo
   pronto é refeito a partir da fonte.

---

## 3. Cores e tamanhos da marca

### As cores, pelo nome

Use sempre o **nome** (`var(--nc-roxo)`), não o código (`#511C76`). Há dois motivos:

- se a cor da marca mudar, muda num lugar só;
- **o usuário pode escolher outro tema** em *Cores* (menu do usuário), e só as cores
  escritas pelo nome acompanham o tema. Uma cor escrita por código fica roxa para sempre,
  mesmo no tema "Esmeralda".

| Nome | Cor (Padrão Natcorp) | Para que serve |
|---|---|---|
| `var(--nc-roxo)` | `#511C76` roxo | a cor principal: botões principais, títulos de destaque, linhas de cabeçalho |
| `var(--nc-azul)` | `#2C1A63` azul profundo | o roxo ao passar o mouse; fundos escuros |
| `var(--nc-rosa)` | `#C95788` rosa | acentos, detalhes que pedem atenção leve |
| `var(--nc-ameixa, #9A408A)` | `#9A408A` ameixa | tom entre o roxo e o rosa (escreva assim, com a reserva) |
| `var(--nc-realce)` | `#E4A9C4` rosa claro | realces suaves, fundos de destaque |
| `var(--nc-tinta)` | `#1B1238` quase preto | o texto principal |
| `var(--nc-grafite)` | `#4A4460` cinza escuro | textos secundários, explicações |
| `var(--nc-cinza)` | `#8E88A3` cinza médio | textos de apoio, desativados |
| `var(--nc-nevoa)` | `#E9E5F1` cinza-lilás claro | bordas e linhas divisórias |
| `var(--nc-nevoa2)` | `#F1EDF6` mais claro | fundos de áreas secundárias |
| `var(--nc-off)` | `#F4F2F7` quase branco | fundo de blocos |
| `var(--nc-tela)` | `#FCFBFE` branco lilás | fundo da página |
| `var(--nc-bom)` | `#1F7A52` verde | sucesso, "Aprovar", "Pronto" |
| `var(--nc-ruim)` | `#B8323F` vermelho | erro, "Reprovar", datas trocadas |
| `var(--nc-alerta)` | `#F5B700` amarelo | aviso. **Texto em cima: `var(--nc-alerta-texto)`**, nunca branco |
| `var(--nc-info)` | `#A63F6E` | botões de informação |

O branco é `#fff` (não muda com o tema). Estas cores são definidas no começo de
`Natcorp_Paginas.src.css` (o bloco `:root`). **Não mude ali** sem falar com o design: muda
o sistema inteiro.

### Tamanhos

| O quê | Valor de referência |
|---|---|
| Texto normal | 14 a 16px |
| Texto pequeno (letra miúda, notas) | 12 a 13px |
| Título de seção | 18 a 22px |
| Espaço pequeno entre coisas | 8px · médio 12–16px · grande 24px |
| Cantos arredondados | campos e botões 8–12px · cartões 14–18px |
| Fonte | Inter, embutida no arquivo geral (com "ss04": I, l e 1 diferentes). Em CSS novo, use a pilha `"Inter NC", Inter, ui-sans-serif, system-ui, "Segoe UI", Arial, sans-serif` (ou `var(--nc-font)`); em colunas de números, `font-variant-numeric: tabular-nums` |

**Celular:** nada tocável menor que **44px** de altura (o dedo precisa acertar), e texto de
campo com pelo menos **16px** (abaixo disso o iPhone dá zoom sozinho ao tocar no campo).

---

## 4. Receitas

Cada receita diz **onde** e **o que** fazer. Ao terminar qualquer uma, siga a parte 2
(gerar → subir) e a parte 5 (conferir).

### R1. Trocar um texto que aparece na tela

1. Abra o `.src.js` da página (parte 6).
2. **Ctrl+F** por um pedaço do texto, por exemplo `Quem vai sair`.
3. Troque **só o que está entre as aspas**, mantendo as aspas:
   `titulo: 'Quem vai sair'` → `titulo: 'Colaborador'`
4. **Cuidado com o apóstrofo:** dentro de `'…'` não pode haver outro `'`. Para escrever
   *d’água*, use o apóstrofo curvo `’` (copie daqui), que não fecha o texto.
5. Se o texto tiver `<b>…</b>`, isso é negrito: mantenha os dois pedaços.

Não achou o texto no JS? Então ele vem do APEX (rótulo do item, título da região, texto
de ajuda). Mude no Page Designer, como sempre.

### R2. Trocar uma cor

1. Abra o `.src.css` da página e ache a parte certa pelo índice (por exemplo, `[C2]`).
2. Ache a linha com `color:` (cor do texto), `background:` (fundo) ou `border` (borda).
3. Troque pelo **nome** de uma cor da parte 3: `color: var(--nc-grafite);`

### R3. Texto maior/menor, mais/menos espaço

- Tamanho do texto: `font-size: 15px;`. Mude o número.
- Espaço **por dentro** da caixa (entre a borda e o conteúdo): `padding`.
- Espaço **por fora** (até o vizinho): `margin`. Entre itens de uma lista: `gap`.
- `padding: 22px 22px 20px;` são os lados na ordem **cima, lados, baixo**. Com quatro
  números, a ordem é **cima, direita, baixo, esquerda** (sentido do relógio).

### R4. Criei um campo novo e ele não aparece, ou aparece no lugar errado

Na maioria das páginas, **um campo novo aparece sozinho**: o JS lê os campos na ordem do
APEX e põe cada um na seção do trecho onde ele está. Então:

1. **Aparece na seção errada?** Mude a **Sequence** do campo no Page Designer para o trecho
   certo. Não precisa mexer no JS. A ficha de cada arquivo diz como as seções são divididas.
2. **Não aparece de jeito nenhum?** Provavelmente o campo foi posto numa região que o
   desenho **absorve** (esconde e mostra os dados de outro jeito, como o cartão do alto).
   Abra o JS, procure a parte que monta aquele pedaço e siga a receita de lá. Exemplo
   real: o `P59_NOME_SOCIAL` (receita "MOSTRAR UM DADO NOVO NO CARTÃO" em
   `Natcorp_Desligamento.src.js › [J3]`).
3. Confira também o básico do APEX: condição de exibição, Authorization, Server-side
   Condition. O desenho nunca mostra o que o APEX esconde.

### R5. Renomeei um item, uma região ou uma coluna no APEX

1. Abra o `.src.js` da página e faça **Ctrl+F pelo nome antigo, sem o prefixo**. Para
   `P59_DT_ADMISSAO`, procure `DT_ADMISSAO`, porque o JS escreve `P + 'DT_ADMISSAO'`.
2. Troque todas as ocorrências pelo nome novo.
3. Para **título de região, texto de botão ou nome de coluna**, procure o texto antigo.
   Esses aparecem dentro de barras, como `/imprim/i`: é um **padrão de busca** que acha
   qualquer botão com "imprim" no texto (maiúscula ou minúscula). Mude só as letras entre as
   barras.
4. Para uma **classe** de região (`nc-…`), o nome na região e no arquivo têm que ser iguais.
   Prefira não renomear classes.

### R6. Copiei a página para outro número (ex.: 59 → 159)

No começo do `.src.js` existe `var P = 'P59_';`. Troque para `'P159_'` e gere. Se a nova
página ficar no lugar da antiga, basta isso. Se as duas continuarem existindo, as duas
precisam do arquivo. Fale com quem cuida do repositório: normalmente se faz um arquivo para
as duas, e não uma cópia.

### R7. Levar o desenho para uma página em outro app ou workspace

Siga `brand/apex/app/TRANSPLANTAR-PAGINA.md`. Os arquivos não dependem do número do app:
basta a página ter os mesmos itens e classes, e os arquivos estarem no workspace
(`#WORKSPACE_IMAGES#` é por workspace).

### R8. Desligar o desenho de uma página (emergência)

1. Page Designer › a página › **JavaScript › File URLs**: apague a linha
   `#WORKSPACE_IMAGES#Natcorp_X.js`. Faça o mesmo em **CSS › File URLs**.
2. Salve. A página volta ao visual padrão do APEX e **continua funcionando**.
3. Guarde as duas linhas apagadas num lugar seguro, para pôr de volta depois.

### R9. Mudar algo só no celular (ou só no computador)

No `.src.css`, as regras dentro de `@media (max-width: 767px) { … }` só valem no
celular. Ache a parte "Celular" pelo índice e mude lá. Para valer só no computador, a
regra tem que estar **fora** desse bloco, e a regra de dentro dele desfaz no celular.

### R10. Voltar atrás

- **Com o repositório:** `git checkout -- brand/apex/app/Natcorp_X.src.js`, gere e suba de novo.
- **Sem o repositório:** suba a cópia intacta que você guardou (parte 2, passo 1).
- **O Static Workspace Files não guarda versões antigas.** A cópia é por sua conta.

### R11. Criar ou mudar um tema de cores

Não se faz à mão. Siga `brand/apex/app/TEMAS-MANUTENCAO.md`: os temas são gerados por
`gerar-temas.py` a partir de uma lista de paletas.

---

## 5. Quando algo dá errado

### Conferir uma mudança

1. Abra a página numa **aba nova**. Não recarregue uma aba em que alguém esteja trabalhando:
   o recarregamento pode derrubar a sessão.
2. Force o recarregamento: **Ctrl+Shift+R** (Mac: **Cmd+Shift+R**). Sem isso, o navegador
   pode mostrar o arquivo antigo, guardado na memória dele (o "cache").
3. Confira a mudança **no computador e no celular** (ou no modo celular do navegador:
   F12 › o ícone de celular no alto à esquerda).
4. Abra o **Console** (F12 › aba Console) e veja se apareceu alguma mensagem vermelha.

### Sintomas e o que fazer

| O que você vê | O que costuma ser | O que fazer |
|---|---|---|
| A página está "crua", no visual padrão do APEX | O JS não carregou ou quebrou | 1. F12 › **Network** (Rede), recarregue, procure `Natcorp_X.js`. Se estiver vermelho com **404**, o arquivo não está no workspace com esse nome exato. 2. Se carregou, vá ao **Console** e procure a mensagem vermelha (linha abaixo). |
| No Console: `SyntaxError` / `Unexpected token` / `missing ) after…` | Um sinal foi apagado ou sobrou na última edição (`;` `{ }` `( )` `' '`) | O Console mostra o arquivo e o **número da linha**: clique e veja. Compare com a cópia intacta. Na dúvida, suba a cópia intacta (R10). |
| No Console: `[Natcorp desligamento] TypeError…` (com o nome da página) | O desenho rodou, mas não achou algo que esperava (item renomeado, região sem a classe) | A página continua funcionando. Veja R5 (renomear) e o "COMBINADO" na ficha do arquivo. |
| As cores e os espaços mudaram, mas a arrumação não (ou o contrário) | Só um dos dois arquivos (JS ou CSS) carregou ou está atualizado | Confira os dois em File URLs e suba os dois. |
| Mudei e "nada aconteceu" | Cache, ou subiu para o lugar errado, ou editou a fonte e não gerou | Ctrl+Shift+R. Confira em Static Workspace Files a data do arquivo. Confira se gerou (parte 2, passo 3). |
| Uma regra de CSS nova não vale | No arquivo pronto faltou o `!important` ou o prefixo | Edite a fonte `.src.css` e gere (o gerador põe os dois). No caminho B, copie a forma de uma regra vizinha. |
| Um campo sumiu da tela | Região absorvida, ou o APEX escondeu (condição/ação dinâmica) | Receita R4. |
| A cor está roxa mesmo com outro tema | Cor escrita por código (`#511C76`) | Troque pelo nome (parte 3). |

### Testar sem risco

- Nunca teste clicando em **Criar, Enviar, Salvar ou Aprovar** em dados reais. Use um
  registro de teste ou só observe a tela.
- Não deixe dados pessoais (prints com nome e CPF de colaboradores) salvos em pastas
  compartilhadas.

---

## 6. Mapa dos arquivos

Cada linha: o arquivo, a tela, o app e a página, o gerador do JS e o guia detalhado (em
`brand/apex/app/`). O CSS de todas é gerado por `gerar-app.mjs`.

| Arquivos | Tela | App · Página | Gerador do JS | Guia |
|---|---|---|---|---|
| `Natcorp_Style_Min.css` | **o geral**: menu, cabeçalho, regiões, campos, botões, relatórios, janelas, login | todos (User Interface) | — | `../LEIA-ME.md` |
| `Natcorp_Temas.js` | as "Cores do sistema" | 200 (User Interface) | `gerar-temas.py` | `TEMAS-MANUTENCAO.md` |
| `Natcorp_Desligamento` | Requisição de Desligamento | 200 · 59 | `gerar-desligamento.py` | `DESLIGAMENTO-MANUTENCAO.md` |
| `Natcorp_Ferias` | Requisição de Férias | 200 · 78 | `gerar-ferias.py` | `FERIAS-MANUTENCAO.md` |
| `Natcorp_Movimentacao` | Alteração Funcional | 200 · 116 | `gerar-movimentacao.py` | `MOVIMENTACAO-MANUTENCAO.md` |
| `Natcorp_Treinamento` | Requisição de Treinamento | 200 · 118, 120, 126 | `gerar-treinamento.py` | `TREINAMENTO-MANUTENCAO.md` |
| `Natcorp_Dependentes` | Requisição de Dependentes | 200 · 132 / 600 · 131 e 133 / 9132 · 3 | `gerar-dependentes.py` | `DEPENDENTES-MANUTENCAO.md` |
| `Natcorp_Cadastro` | Alteração Cadastral e de Endereço | 200 · 136 e 134 | `gerar-cadastro.py` | `CADASTRO-MANUTENCAO.md` |
| `Natcorp_AlteracaoVaga` | Alteração de Vaga | 200 · 163 | `gerar-alteracao-vaga.py` | — (veja a ficha do arquivo) |
| `Natcorp_Beneficios` | Requisição de Benefícios | 200 · 168 e 116 (dentro da Alteração Funcional) / 600 · 168 | `gerar-beneficios.py` | `BENEFICIOS-MANUTENCAO.md` |
| `Natcorp_Ficha` | Dados Funcionais (ficha do RH) | 200 · 17 | `gerar-ficha.py` | `FICHA-MANUTENCAO.md` |
| `Natcorp_Requisicao` | Requisição de Pessoal / de Posição | 2010 · 52 / 200 · 76 | `gerar-requisicao.py` | `REQUISICAO-MANUTENCAO.md` |
| `Natcorp_DadosPessoais` | Dados Pessoais (Conhecendo Você) | 600 · 1 | `gerar-dadospessoais.py` | `DADOSPESSOAIS-MANUTENCAO.md` |
| `Natcorp_Formacao` | Cursos e Formações | 600 · 5 | `gerar-formacao.py` | `FORMACAO-MANUTENCAO.md` |
| `Natcorp_Carta` | Carta de Apresentação | 600 · 14 | `gerar-carta.py` | `CARTA-MANUTENCAO.md` |
| `Natcorp_LinhaTempo` | Linha do Tempo (Tabela · Trajetória · Cronologia); na 26, Férias (período aquisitivo, parcelas, prazos) | 200 · 108, 121 e 26 | `gerar-linhatempo.py` | `LINHATEMPO-MANUTENCAO.md` |
| `Natcorp_AgendaMedica` | Agenda do dia do médico por cima do Interactive Grid (lista, painel, gaveta de agendar) | 2937 · 10 | `gerar-agendamedica.py` | `AGENDAMEDICA-MANUTENCAO.md` |
| `Natcorp_Registros` | Tabela · Cartões em todo Interactive/Classic Report (celular abre em Cartões); CSS no Style_Min, JS trazido pelo Natcorp_Temas.js | sistema todo | `gerar-registros.py` | `REGISTROS-MANUTENCAO.md` |
| `Natcorp_BancoTalentos` | Banco de Talentos: vaga escolhida com aderência por requisito, filtros num painel, cartão por candidato | 9110 · 182 | `gerar-bancotalentos.py` | `BANCOTALENTOS-MANUTENCAO.md` |
| `Natcorp_Editor` | o editor de texto rico (CKEditor) em todo o sistema: moldura fluida, barra plana que quebra sozinha, "Mais" para os botões raros, letra confortável ao escrever; CSS no Style_Min, JS trazido pelo Natcorp_Temas.js | sistema todo | `gerar-editor.py` | `EDITOR-MANUTENCAO.md` |
| `Natcorp_Lov` | a janela do Popup LOV com várias colunas vira cartões legíveis (busca marcada, teclado, Cartões \| Tabela); CSS no Style_Min, JS trazido pelo Natcorp_Temas.js | sistema todo | `gerar-lov.py` | `LOV-MANUTENCAO.md` |
| `Natcorp_Empregos` | Empregos Anteriores | 600 · 17 | `gerar-empregos.py` | `EMPREGOS-MANUTENCAO.md` |
| `Natcorp_Funcional` | Dados Funcionais (RH, Conhecendo Você) | 600 · 35 | `gerar-funcional.py` | `FUNCIONAL-MANUTENCAO.md` |
| `Natcorp_Ponto` | Tratativa de Abono (ponto) | 9503 · 203 | `gerar-ponto.py` | `PONTO-MANUTENCAO.md` |
| `Natcorp_Abono` | Marcação - Abono (janela) | 9503 · 714 | `gerar-abono.py` | `ABONO-MANUTENCAO.md` |
| `Natcorp_Apuracao` | Requisição de Apuração (janela) | 9503 · 181 | `gerar-apuracao.py` | `APURACAO-MANUTENCAO.md` |
| `Natcorp_HoraExtra` | Requisição de Hora Extra | 9503 · 716 | `gerar-horaextra.py` | `HORAEXTRA-MANUTENCAO.md` |
| `Natcorp_Escala` | Requisição de Escala (janela) | 9503 · 179 | `gerar-escala.py` | `ESCALA-MANUTENCAO.md` |
| `Natcorp_Avaliacao` | Avaliação de desempenho | 9118 · 140 e 144 | `gerar-avaliacao.py` | `AVALIACAO-MANUTENCAO.md` |
| `Natcorp_Documentos` | Consulta de Documentos | 2210 · 865 | `gerar-documentos.py` | `DOCUMENTOS-MANUTENCAO.md` |
| `Natcorp_Reembolso` | Reembolsos em lote | 2060 · 7 | `gerar-reembolso.py` | `REEMBOLSO-MANUTENCAO.md` |
| `Natcorp_Terceiros` | Serviço de Terceiros | 2290 · 186 | `gerar-terceiros.py` | `TERCEIROS-MANUTENCAO.md` |
| `Natcorp_IndMovimentacao` | Indicação de Movimentação | 2280 · 184 | `gerar-indmovimentacao.py` | `INDMOVIMENTACAO-MANUTENCAO.md` |
| `Natcorp_Exames` | Requisição de Exames | 2937 · 61 | `gerar-exames.py` | `EXAMES-MANUTENCAO.md` |
| `Natcorp_Agenda` | Agenda do exame (janela) | 2937 · 75 | `gerar-agenda.py` | `AGENDA-MANUTENCAO.md` |
| `Natcorp_Atestado` | Atestados e Afastamentos | 2937 · 91 | `gerar-atestado.py` | `ATESTADO-MANUTENCAO.md` |
| `Natcorp_Acidente` | Comunicação de Acidente | 2943 · 91, 92, 31 | `gerar-acidente.py` | `ACIDENTE-MANUTENCAO.md` |
| `Natcorp_PPP` | Requisição de PPP / Laudo | 2943 · 61 | `gerar-ppp.py` | `PPP-MANUTENCAO.md` |

**Arquivos que NÃO são nossos e não se alteram:** `Natcorp_Allow_Unload_Iframes.js`,
`iframe_handling.js`, `natcorp-theme.js`, `natcorp_iframe_apex.css` e a parte de cima do
`Natcorp_Style_Min.css` (a Natcorp Skin original, acima do divisor "NOVAS IMPLEMENTAÇÕES").
São da equipe e fazem coisas de que outras telas dependem.

---

## 7. Regras de ouro

1. **A regra é do APEX; o desenho é dos arquivos.** Obrigatório, validação, condição,
   permissão e cálculo se resolvem no Page Designer. Nunca no JS.
2. **Nunca mude o valor que vai para o banco.** Máscaras e traduções são só para os olhos.
3. **Guarde uma cópia antes de mexer.** O Static Workspace Files não tem "desfazer".
4. **Edite a fonte (`.src`) e gere.** Mexeu no arquivo pronto numa emergência? Repita na
   fonte no mesmo dia.
5. **Uma mudança por vez, e confira** (parte 5) antes da próxima. Duas mudanças juntas que
   dão errado não dizem qual das duas quebrou.
6. **Teste em aba nova, com Ctrl+Shift+R, no computador e no celular.** Muita gente usa o
   sistema pelo celular.
7. **Cores pelo nome** (`var(--nc-roxo)`), nunca pelo código.
8. **Código e descrição juntos:** onde o desenho mostra um código, mostre também a descrição:
   "700 - Natcorp do Brasil", nunca só um dos dois.
9. **Escreva para quem lê pouco.** Os usuários são colaboradores, gestores e candidatos, muitos
   com pouca familiaridade com tecnologia. Frases curtas, palavras do dia a dia, sem sigla
   sem explicação.
10. **Num comentário, nunca escreva barra-asterisco nem asterisco-barra** (os sinais que
    abrem e fecham o comentário). O comentário acabaria no meio e o resto do texto viraria
    código quebrado.
11. **Não altere os arquivos da equipe** (lista no fim da parte 6).
12. **Todo painel com título leva a faixa da região.** Igual ao cabeçalho de região da Skin: o
    título numa faixa que atravessa o cartão de ponta a ponta, com a linha de baixo
    `2px solid var(--nc-rosa)` — a cor de destaque do tema, nunca o rosa fixo. Nos desenhos, o
    bloco "FAIXA DA REGIÃO" no fim de cada `.src.css` faz isso; as margens negativas dele são o
    recuo de dentro do cartão (mudou um, mude o outro). Não vale para o cabeçalho com o nome da
    pessoa nem para barras de filtro.

---

## 8. Glossário

| Palavra | O que é |
|---|---|
| **CSS** | A linguagem da aparência: cores, tamanhos, espaços. A "roupa" da tela. |
| **JS / JavaScript** | A linguagem que faz a página "agir" no navegador. Aqui: o "arrumador". |
| **Fonte / `.src`** | O arquivo que se edita. O gerador transforma a fonte no arquivo pronto. |
| **Arquivo pronto** | O que sobe para o APEX (pasta `brand/apex/login/`). |
| **Gerador** | Pequeno programa (`gerar-…`) que produz o arquivo pronto a partir da fonte. |
| **Classe** | Uma etiqueta num pedaço da tela. No APEX: *Appearance › CSS Classes*. No CSS aparece com ponto: `.nc-desl-form`. |
| **Seletor** | A parte "QUEM" de uma regra de CSS: diz em que pedaço da tela a regra vale. |
| **Propriedade / valor** | A parte "COMO": `color` (propriedade) `: var(--nc-roxo)` (valor). |
| **px** | Pixel, um pontinho da tela. Medida de tamanho. |
| **padding / margin / gap** | Espaço por dentro / por fora / entre itens de uma lista. |
| **@media** | "Só nestas telas". `@media (max-width: 767px)` = só no celular. |
| **Variável de cor** | Uma cor com nome: `var(--nc-roxo)`. Segue o tema escolhido. |
| **!important** | "Esta regra vence as outras." Necessário para vencer o tema do APEX. O gerador põe sozinho. |
| **@app** | Atalho que o gerador troca pelo prefixo que dá prioridade às nossas regras. |
| **Função** | Uma "receita" com nome no JS: `function montarTopo() { … }`. |
| **Variável (JS)** | Um valor guardado com nome: `var P = 'P59_';`. |
| **Expressão regular** | Um padrão de busca entre barras, como `/imprim/i`: acha textos que contenham "imprim". O `i` no fim ignora maiúsculas. |
| **SVG** | Desenho feito de texto (os ícones). Não precisa mexer. |
| **Console** | A "caixa de mensagens" do navegador (F12 › Console). É lá que aparecem os erros. |
| **Cache** | A memória do navegador, que guarda arquivos para abrir mais rápido. Às vezes mostra a versão antiga: Ctrl+Shift+R resolve. |
| **Região absorvida** | Região do APEX que o JS esconde e cujos dados ele mostra de outro jeito (num cartão, por exemplo). |
| **Campo-marco** | O campo que abre uma seção do formulário. Os campos seguintes caem nessa seção até o próximo marco. |
| **Tema** | Uma paleta de cores escolhida pelo usuário em *Cores*. Só cores escritas pelo nome acompanham. |
| **`#WORKSPACE_IMAGES#`** | Atalho do APEX para a pasta de arquivos do workspace. |
| **404** | "Arquivo não encontrado": o nome está errado ou o arquivo não subiu. |
