# Requisição de Pessoal (app 2010, página 52): como dar manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A página em que o gestor abre um processo seletivo, e o selecionador acompanha. Os dois veem a
mesma tela. O uso é **70% no computador**, e um gestor chega a abrir 50 destas por dia, por isso
o desenho gira em torno de uma pergunta: **o que falta para esta vaga sair?**

| Arquivo | Onde fica no APEX | Fonte neste repositório |
|---|---|---|
| `Natcorp_Requisicao.css` | Página 52 › CSS › URLs de arquivo | `brand/apex/app/Natcorp_Requisicao.src.css` |
| `Natcorp_Requisicao.js` | Página 52 › JavaScript › URLs de arquivo, depois dos três que já estavam | `brand/apex/app/Natcorp_Requisicao.src.js` (+ a ilustração de `ilustracoes/beneficios/recrutamento.png`) |

## A tela

- **Resumo no alto:** cargo, posições e as marcas da vaga, mais a estrutura (Empresa, Filial,
  Centro de custo, Unidade administrativa e Unidade de negócio). Os outros dados ficam em
  "+ Detalhes". Numa requisição nova, sem cargo ainda, o resumo vira só uma faixa com "x de N
  etapas completas".
- **Suspender / Revisar / Cancelar** (região Botões Requisição): no canto direito do resumo,
  numa tela a partir de 1100px. Abaixo do resumo em telas menores.
- **Aprovação:** uma faixa horizontal abaixo do resumo, com o caminho de aprovadores e, para
  quem pode decidir, os botões Aprovar e Reprovar do APEX.
- **Etapas:** uma por vez. No computador, o menu fica à esquerda e acompanha a rolagem; no
  celular, fica numa barra horizontal no alto. A situação de cada etapa sai dos campos
  obrigatórios dela. A troca de etapa é animada, e a etapa aberta é lembrada ao recarregar.
  Um erro do servidor abre a etapa em que o erro está.
- **Seções como ficha:** os dados se leem como documento. "Editar" abre o formulário, que nunca
  sai da página; o botão não aparece quando a seção não é editável.
- **Última etapa, Prévia do anúncio:** a vaga como o candidato vai vê-la, e a conferência
  "Antes de publicar".

## A regra: a estrutura é do APEX

Ordem, títulos, rótulos, itens, botões, validações, processos e ações dinâmicas estão no Page
Designer. O CSS/JS só **redesenha quem tem uma classe `nc-req-*`** e nunca valida nada. Os
botões e links que ele mostra (Aprovar, Reprovar, a lupa do aprovador, o × de uma linha, o
Editar de um relatório) **são os elementos originais do APEX mudados de lugar**, com as mesmas
ações dinâmicas. Não são cópias.

### Regiões (Aparência › Classes CSS)

| Classe | Região | O que o desenho faz |
|---|---|---|
| `nc-req-etapas` | Steppers | Monta o resumo, a faixa de aprovação e o menu das etapas |
| `nc-req-etapa` | Identificação, Cargo, Remuneração, Perfil, Detalhamento, **Candidatos**, **Prévia do anúncio** | Uma por vez. O nome no menu é o título da região |
| `nc-req-solicitacao` (+ `nc-req-ficha`) | Solicitação (antes "&P52_TITULO.") | Número, origem, situação (com cadeado e "desde"), motivo, data de abertura e o solicitante |
| `nc-req-aprovadores` | Aprovadores | A faixa horizontal abaixo do resumo |
| `nc-req-acoes` | Botões Requisição | O lugar das ações descrito acima |
| `nc-req-ficha` | Informações da Vaga, Empresa e Estrutura, Local de Trabalho, Publicação de Vaga, Cargo, Horário Contratual, Controle de Frequência, Remuneração, Insalubridade / Periculosidade, Projeto e Contrato, Gestor, Avaliador, Características do Candidato, Parecer | Modo leitura, com Editar / Concluir |
| `nc-req-lista` | os relatórios dentro de Requisitos Técnicos e Desempenho da Função | As linhas viram etiquetas agrupadas em Obrigatório / Desejável. O × é o link Apagar original |
| `nc-req-grupo` | Requisitos Técnicos, Desempenho da Função | Agrupam as listas |
| `nc-req-plano` | Indicação Para Avaliar Requisição | Agrupa Gestor e Avaliador |
| `nc-req-opcional` | Indicação de Candidato, Perfil da Vaga | Seção que se pode pular ("Indicar um candidato" no cabeçalho) |
| `nc-req-escrita` | Detalhamento da Requisição | A descrição, com o contador de caracteres |
| `nc-req-textos` | Parecer, Perfil da Vaga | Campos de texto longo em duas colunas |
| `nc-req-pessoas` | Colaboradores Inscritos, Candidatos Inscritos | Cartões de pessoa |
| `nc-req-candidatos` | etapa Candidatos (`CANDIDATOS`) | Condição: **P52_ROWID não nulo**. Numa requisição nova, a etapa não existe |
| `nc-req-etapa-previa` / `nc-req-previa` | Prévia do anúncio (`PREVIA_ETAPA`) / Como o candidato vai ver (`PREVIA_ANUNCIO`) | Regiões vazias: o JS desenha. Sem o JS, o CSS as esconde |

### Somente o sistema altera

`P52_DT_SIT_REQ` (Data de Situação) fica **somente leitura na tela**. Continua sendo um item
comum no APEX: o `readonly` não impede o envio, então os processos que gravam a data seguem
iguais. A lista é `SO_SISTEMA`, no `.src.js`.

## O que o script muda na exportação

- as classes da tabela acima;
- **a etapa "Vaga e Local" deixa de existir.** Empresa e Estrutura, Local de Trabalho e
  Publicação de Vaga passam para a Identificação (sequências 50, 60 e 70), e "Vaga e Local"
  (`VAGA`) fica em Condição › Nunca. As duas ações dinâmicas de mousemove presas a ela ("Vaga:
  Popular Campos_3" e "(Mouse Move) Popular Campos Y") já estavam desligadas (`return 1=2`). O
  botão "New" dela também já era Nunca;
- etapas novas: **Candidatos**, com os dois relatórios de inscritos (que saem de Desempenho da
  Função), e **Prévia do anúncio**, a última;
- o título "&P52_TITULO." passa a ser "Solicitação". O número e a situação já aparecem no
  resumo, e o item `P52_TITULO` continua sendo calculado;
- rótulos: "DDD" no primeiro campo de telefone da indicação (`P52_DDD_INDICADO`), e
  "Observações para o recrutamento" (`P52_OBSERVACAO`). O limite de caracteres agora aparece no
  contador;
- as duas URLs de arquivo e o comentário da página.

## Situações comuns

- **Seção nova numa etapa:** ponha `nc-req-ficha` para lê-la como documento. Sem classe, ela
  aparece como formulário comum.
- **Etapa nova:** região filha de Steppers com `nc-req-etapa`. Ela entra no menu sozinha, na
  ordem da sequência.
- **Lista nova de requisitos:** relatório com `nc-req-lista`, dentro de um `nc-req-grupo`.
- **Mudar o que o resumo mostra:** as listas `fatos` e `detalhes` em `montarResumo`, no `.src.js`.
- **Mais um campo que só o sistema altera:** acrescente o nome em `SO_SISTEMA`.
- **Renomear um item `P52_*` citado no `.src.js`:** ajuste também o `.src.js`.
- **Desligar tudo:** tire as duas URLs de arquivo. Candidatos continua sendo uma etapa comum.
  Prévia do anúncio some sozinha, porque o CSS a esconde sem o JS.

## Aplicar numa exportação da página

```sh
python3 brand/apex/app/aplicar-requisicao-pagina52.py f2010_page_52.sql
```

Exporte a página 52 **do mesmo ambiente onde vai importar**, porque os IDs mudam de um ambiente
para o outro. O script acha tudo pelos nomes e, se não achar algum, para sem gravar nada. Num
arquivo em que o desenho já foi aplicado, também para sem gravar.

## Gerar os arquivos

```sh
node brand/apex/app/gerar-app.mjs            # gera ../login/Natcorp_Requisicao.css (e os outros)
python3 brand/apex/app/gerar-requisicao.py   # gera ../login/Natcorp_Requisicao.js
```

Suba os dois arquivos de `brand/apex/login/` em Workspace Images.

## Pré-visualizar sem importar

O `preview.js` injeta `simular-requisicao-p52.js` antes do JS. Ele faz no navegador o que o
script faz na exportação, e **não vai para o Workspace Images**.

## Requisição de Posição (app 200, página 76)

Usa o **mesmo** `Natcorp_Requisicao.css/.js` da página 52. O JS reconhece as duas páginas
(`PAGINAS`, no começo do `.src.js`). Os itens têm os mesmos nomes, com estas exceções:

| Na p. 52 | Na p. 76 |
|---|---|
| `COD_REQ` · `DT_REQ` · `COD_SIT_REQ` | `COD_REQUISICAO` · `DATA_REQUISICAO` · `COD_SIT_REQUISICAO` |
| `QTD_POSICAO` · `COD_MOT_REQ` | `QTDE_VAGAS` · `MOT_ABERT_VAGA` |
| `COD_CCUSTO_DSP` · `COD_UNIDADE_ADM_DSP` · `COD_CCUSTO_CONTAB_DSP` · `COD_ATIVIDADE_DSP` | `COD_CCUSTO` · `COD_UNIDADE_ADM` · `COD_CCUSTO_CONTAB` · `ATIVIDADE` |
| `OBSERVACAO` | `TEXTO` |

Um item que não existe numa das páginas fica vazio no resumo e na prévia, sem erro.

**O que o script muda na exportação:** a página 76 tinha as seções soltas dentro de
"Informações de Vaga" (`INF_VAGA`). O `aplicar-requisicao-pagina76.py`:
- põe `nc-req-etapas` em `INF_VAGA`;
- cria as cinco etapas filhas dela, na ordem da página, e passa as seções para dentro:

  | Etapa (`region_name`) | Seções |
  |---|---|
  | Identificação (`IDENTIFICACAO`) | "&P76_TITULO.", que passa a se chamar "Solicitação", e Informações da Vaga |
  | Cargo (`CARGO_ETAPA`) | Cargo, Frequência |
  | Remuneração (`REMUNERACAO_ETAPA`) | Remuneração, Insalubridade / Periculosidade, Projeto, Contrato, Vaga Faturável |
  | Perfil (`PERFIL_ETAPA`) | PCD, Ferramentas de Apoio / Equipamentos |
  | Detalhamento (`DETALHAMENTO_ETAPA`) | Descrição de Atividades, Observações / Políticas / Detalhes da Vaga |

- cria a etapa "Prévia do anúncio" (`PREVIA_ETAPA`), com o anúncio (`PREVIA_ANUNCIO`);
- põe as classes das seções: `nc-req-ficha`, `nc-req-lista` em Ferramentas, `nc-req-escrita`,
  `nc-req-textos` e `nc-req-aprovadores` em Aprovadores;
- acrescenta as URLs dos arquivos e o comentário da página.

A ordem das seções é a mesma de antes, e os IDs das regiões não mudam: as ações dinâmicas que
mostram ou escondem seções continuam valendo. **Seção nova:** crie como filha de uma etapa.

```sh
python3 brand/apex/app/aplicar-requisicao-pagina76.py f200_page_76.sql
```

A página 76 não tem as listas de requisitos (formação, experiência, idiomas). Por isso o
"Antes de publicar" confere 3 itens: cargo, descrição e período de divulgação (Data de Início e
Data de Encerramento).

## Regras da página (auditoria 04/10)

**Conferido** contra as exportações originais (`f2010_page_52.ORIGINAL.sql`, igual à `_v2`, e
`f200_page_76.ORIGINAL.sql`): p52 — 199 ações dinâmicas, 34 validações, 33 processos, 56 botões;
p76 — 65 ações, 14 validações, 12 processos, 12 botões. O `aplicar-*.py` não muda item, botão,
validação nem processo (só classes e, na p76, o agrupamento das seções em etapas).
`f207_page_52.sql` é outra versão da página, sem o desenho: fora desta auditoria.

O desenho não grava, não valida, não troca controle, não põe valor e não esconde item nem região
de dado (só respeita os escondidos pela página: etapa, seção e campo com `display:none` saem do
menu, da leitura e da contagem do que falta). Nenhuma regra CSS força `display` em campo, região
ou botão que uma ação dinâmica esconda.

**Mudou**
- **Quando monta:** agora no `apexreadyend` (depois das ações de abertura), com reserva de 3 s.
  Na p76 a ação "Enable/Disable" faz `$("#INF_VAGA *").attr("disabled").off("click")` numa
  requisição gravada; montado antes, a faixa de Aprovadores (região de FORA de `INF_VAGA`) já
  tinha sido levada para dentro, e Aprovar/Reprovar ficavam desabilitados e sem o clique.
- **Linha só com botão** não é mais tratada como "linha vazia" no CSS: "Enviar arquivo"
  (`BT_ENVIAR_ARQUIVO`, p52, situação 1) sumia.
- **Seção como ficha com botão da página no corpo** (o do solicitante; `ADD_LOCAL` na p76) conta
  como editável: há sempre "Editar" para chegar ao botão.

**Para decisão**
- `P52_DT_SIT_REQ` somente leitura **só pelo desenho** (`SO_SISTEMA`; a p76 não tem o item): a
  página deixa editar (a ação "Set Dt_Sit_Req" a preenche ao mudar a situação). É regra mais
  rígida que a da página: manter (e levar para o APEX) ou tirar.
