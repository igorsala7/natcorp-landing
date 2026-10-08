# Banco de Talentos — app 9110, página 182 ("Candidatos")

Onde o recrutador procura, no banco de talentos, quem combina com a vaga aberta. Antes: 9 botões
de filtro que abriam 9 janelas (sem mostrar o que estava ativo) e um relatório de 36 colunas com o
NOME na 4ª, formação/cursos/empregos em células altíssimas escondidas à direita. Agora: a vaga
escolhida no alto, os filtros num painel só e um cartão por candidato com a aderência à vaga.

Arquivos: `Natcorp_BancoTalentos.src.js` / `.src.css` → `../login/…js` / `.css`.
JS: `python3 gerar-bancotalentos.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-bancotalentos-pagina182.py f9110_page_182.sql` (aplicada em 03/10;
original em `f9110_page_182.ORIGINAL.sql`).

## O que o script muda na exportação

| Onde | O quê |
|---|---|
| JavaScript › File URLs | `#WORKSPACE_IMAGES#Natcorp_BancoTalentos.js` |
| CSS › File URLs | a de antes (`natcorp_iframe_apex.css`) **+** `#WORKSPACE_IMAGES#Natcorp_BancoTalentos.css` |
| Comentário da página | o nosso bloco no alto |
| Processo NOVO `NC_BT_VAGA` | Ajax Callback, **só leitura**. `x01 = LISTA` → as vagas abertas `{vagas:[{processo,cargo,filial}]}` (mesma regra da lista "Processo Seletivo" da janela de inclusão: `cod_sit_req = 5`, não confidencial). `x01 = nº` → os requisitos da requisição (instrução, formações, cursos, conhecimentos com nível, experiências, idiomas, tempo de serviço, cidade), as mesmas tabelas da descrição da vaga (9113:38). Não achou → `{erro}` |

Nenhum item, região, botão, ação dinâmica, consulta ou processo existente é tocado.

## Como ficou

| Onde | O quê |
|---|---|
| **Para qual vaga?** (alto da coluna) | **recolhível** (começa recolhida; lembra a escolha do recrutador em `nc-bt-vaga-aberta`, gravada só no toque do título); recolhida, mostra embaixo do título a vaga comparada ("57463 · Analista…") ou "Nenhuma vaga escolhida". Aberta: campo "Nº ou cargo da vaga" com as vagas abertas como sugestões (nº, cargo, filial); escolher uma sugestão já compara; Enter ou "Comparar com a vaga" também. A vaga fica guardada no navegador (`nc-bt-vaga`) e volta depois do Pesquisar. "Não comparar" desliga |
| **Quem buscar** | Externos \| Internos \| Selecionados num toque (escreve no `P182_TIPO`, dispara as ações da página e pesquisa), período e Indicados |
| **Filtros** | cada grupo com ícone (pessoa, capelo, certificado, balões, estrela, casa, bandeira, acessibilidade, prédio — `GRUPOS`, 3ª coluna; cinza fechado, roxo aberto/ativo); "Quem buscar" e "Filtros" também com ícone. Cada janela vira um grupo que abre e fecha: Dados pessoais, Formação, Cursos, Idiomas, Habilidades, Onde mora, Nacionalidade, PCD, Empresa e lotação. O grupo mostra quantos campos estão preenchidos e tem "Limpar …" (o botão "Limpar Filtro" original). "Limpar tudo" no título. **Pesquisar** (o botão original) fica preso no pé da coluna |
| Resultados — cabeçalho | título do relatório à vista, "50 candidatos nesta página (1 - 50)", Ordenar (Como no relatório · Mais aderentes à vaga · Atualizados por último · Nome; lembrado em `nc-bt-ordem`), Cartões \| Tabela (`nc-bt-visao`), Cadastrar |
| Perfil da vaga | "Comparando com a vaga Analista de Sistemas Junior 57463": requisitos **Exigido** (borda cheia) e **Desejável** (tracejada), e a nota de que a aderência é estimada |
| Filtrando por | uma etiqueta por campo preenchido ("Idioma: Inglês ×"); tirar a etiqueta limpa o campo e aparece "Filtros mudaram — Pesquisar" |
| Cartão do candidato | caixa de seleção · iniciais · nome (abre o cadastro), nome social, código · idade, cidade · selos (situação, Em processo seletivo, PCD, Disponível) · instrução, tempo de experiência (somado dos empregos), cargo pretendido · **Última experiência** (o emprego com a data de entrada mais recente: cargo · empresa · "out/2017 a abr/2026 (8 anos e 6 meses)" ou "desde …, atual"; sem empregos: "Sem experiência registrada"; colaborador interno não mostra) · **aderência** (% e "3 de 3 exigidos"; verde ≥ 80, âmbar ≥ 50) · ✓/✗ por requisito (✗ vermelho só nos exigidos) · atalhos Currículo, E-mail, WhatsApp, LinkedIn (os links originais) · seta que abre Formação, Idiomas, Cursos, Habilidades, Experiência, Sobre, contatos e "Abrir o cadastro completo" |
| Seleção | marcar aparece a barra escura "N candidatos selecionados · **Incluir em Processo** · Limpar seleção". A janela de inclusão já abre com a vaga comparada no campo Processo Seletivo (se ele estiver vazio) |
| Tabela | o relatório interativo original, inteiro |
| Celular | uma coluna; o cartão empilha (aderência ao lado do nome, atalhos embaixo) |

## A aderência (Natcorp_BancoTalentos.src.js [B6])

Calculada NA TELA com o texto que o próprio relatório traz de cada candidato — é estimativa e está
escrito assim. Peso: exigido 3, desejável 1 (`PESO`).

| Requisito | Atende quando |
|---|---|
| Instrução (exigido) | o nível do candidato é igual ou maior (fundamental < médio < técnico < superior < pós < mestrado < doutorado; "incompleto" vale um degrau abaixo) |
| Formação, curso | o texto do requisito casa com UMA linha da formação/cursos (regras abaixo) |
| Conhecimento | idem, em qualquer linha (formação, cursos, habilidades, empregos, qualificação, pretensões) |
| Experiência | idem, numa linha dos empregos, qualificação ou cargos |
| Idioma (exigido) | mesmo idioma e nível igual ou maior (básico < intermediário < avançado < fluente < nativo) |
| Tempo de serviço | soma das datas dos empregos ("dd/mm/aaaa à dd/mm/aaaa"; sem fim = até hoje) |
| Local | mora na mesma cidade da vaga |

### Texto contra texto (desde 03/10, 2ª versão)

Sempre **uma linha do cadastro de cada vez** — "analista" de um emprego não soma com "negócios" de
outro. Em cada linha e no requisito: sem acento/maiúscula/pontuação, sem "de/da/em…"; e então

1. **Sinônimos** (`EQUIVALENTES`): no requisito viram o nome principal; no cadastro são
   ACRESCENTADOS (as palavras do candidato continuam valendo). "Gestão de Pessoas" = "Recursos
   Humanos" = "RH"; "Contabilidade" = "Ciências Contábeis"; "DP" = "Departamento Pessoal"…
2. **Abreviações que não são começo da palavra** (`ABREVIACOES`): an = analista, op = operador,
   ass = assistente, jr/sr/pl.
3. **Plural = singular**: negócios/negócio, contábeis/contábil, gestões/gestão.
4. Duas palavras casam se forem iguais, se uma for o **começo** da outra com 3+ letras, nos dois
   sentidos (adm ⇄ administração, eng ⇄ engenheiro/engenharia), ou se, com 6+ letras, diferirem em
   **uma letra** (adminstração).
5. Requisito de até 2 palavras: todas; de 3 ou mais: 60%.

Passar o mouse no ✓ mostra a linha do cadastro onde achou.

Conferido em 03/10 com 22 pares (antes 5 ✓, agora 17 ✓; os 5 que devem falhar continuam ✗ — Direito ×
Administração, Téc. em Enfermagem × Tecnologia em Logística, Aux. Administrativo × Administração de
Empresas, "analista" e "negócios" em empregos diferentes) e nos 50 candidatos reais da página: nenhum
falso positivo em "Adm. Empresas" e "Gestão de Pessoas".

**Para melhorar:** acrescente em `EQUIVALENTES` os nomes que o RH usa para a mesma coisa (uma linha
por grupo, sem acento). É o ponto de maior ganho.

## CUIDADO

- **Arquivo do currículo (ícone do documento): o link da consulta original apontava para o app
  ERRADO.** Era `f?p=&APP_ID.:1:…APPLICATION_PROCESS=GET_UPLOAD_FILES:::GET_TIPO_ITEM,…` — no 9110
  o processo e os itens não existem e dava **ERR-1002 "Não foi possível localizar o ID do item
  GET_TIPO_ITEM no aplicativo 9110"** (já era assim na Tabela; no cartão o ícone ficou mais à vista).
  Conferido 03/10: o download só funciona no app de processos seletivos (`RS_PRC_<base>`, o 9113).
  Corrigido nos 3 relatórios pela exportação (`RS_PRC_'||:P_BASE||'`, o mesmo padrão do link do
  candidato) e, enquanto ela não é importada, pelo JS ([B8] `corrigirArquivo`), na lista e na Tabela.

- **A barra de seleção é `position: fixed`, não sticky.** No tema um contêiner acima corta a rolagem e
  o sticky não gruda: até 03/10 (noite), nos Cartões a barra ficava depois dos 50 cartões e o
  recrutador não via o "Incluir em Processo" (na Tabela parecia funcionar só porque a lista some).
  O JS ([B9] `alinharBarra`) põe left/width iguais aos da coluna dos resultados, e a lista ganha
  84 px de respiro embaixo enquanto a barra está à vista.

- **A vaga comparada NÃO é o `P182_PS`.** O `P182_PS` filtra a lista de **Selecionados** pelo
  processo (`p.ps = :P182_PS`), só aparece nesse modo e a página o limpa ao trocar o tipo — ele
  continua no grupo "Empresa e lotação", como era.
- As colunas são lidas pelo **título** (`COLUNAS`, [B2]). Renomeou uma coluna no relatório, ajuste lá.
- Os grupos são as janelas pelo **título** (`GRUPOS`, [B3]). Janela nova = linha nova ali.
- O "Incluir em Processo" da barra é o botão original movido; só sai da janela de inclusão quem
  confirma nela.
- Os nomes dos requisitos ficam como o RH digitou; só os que vieram TODO em maiúsculas são
  arrumados (siglas como SQL, RH, NR 35 continuam em maiúsculas — `SIGLAS`).

## Testado em 03/10 (aba nova, sessão viva, NC_BT_VAGA simulado — o processo ainda não estava importado)

Painel e 9 grupos, etiquetas (o idioma mostra "Inglês", não o código), comparação com a vaga,
ordem por aderência, seleção → barra → janela de inclusão com a vaga preenchida (aberta e fechada
sem confirmar; seleção desfeita), Cartões ↔ Tabela, 1440 px e 390 px sem rolagem lateral.

## Regras da página (auditoria 04/10)

Conferido contra `f9110_page_182.ORIGINAL.sql`: 59 ações dinâmicas (88 ações), 4 processos, 42
botões, as 9 janelas de filtro. NC_BT_VAGA (nosso) só LÊ (sem insert/update/delete).
- **Corrigido:** `.nc-bt-bt` punha `display: inline-flex` com `!important` nos botões originais
  movidos; "Incluir em Processo", que as ações "(Show/Hide) Add Candidato PS" escondem sem
  selecionados, aparecia mesmo escondido. Agora `.nc-bt-bt[style*="none"]` continua escondido.
- Conferido sem problema: os filtros são os MESMOS itens (movidos), "Limpar" é o Limpar Filtro
  original, Pesquisar é o original; os botões Confirmar/Cancelar das janelas só fechavam a janela;
  Período/Indicados/Nº processo continuam com o mostrar/esconder das ações "Tipo"; a caixa do
  cartão aperta a original (`salvar_ids`).
- **Para decisão:** ao abrir a janela "Incluir em processo seletivo", o desenho PREENCHE
  `P182_PROCESSO_SELETIVO` com a vaga que está sendo comparada (se o campo estiver vazio). A
  pessoa vê antes de confirmar, mas é um valor que ela não escolheu nesse campo; e a lista
  sugerida vem do NC_BT_VAGA, não da LOV `LOV_PS_ABERTOS` do campo.

**Decidido (04/10, cliente):** o processo seletivo já preenchido com a vaga comparada fica (aprovado).
