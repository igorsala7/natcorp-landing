# Detalhe do Processo Seletivo — app 9113, página 29 ("Descrição da Vaga")

Onde o recrutador administra um processo: a vaga, as etapas e os candidatos inscritos (abrir,
CV, e-mail, WhatsApp, LinkedIn, mudar de fase). Aberta da lista de processos (página 28).
Antes: a vaga numa coluna lateral estreita, cartões de etapa soltos e um relatório de 20 colunas
com ícones grandes. Agora: a ficha da vaga no alto, o funil das etapas e uma linha por candidato.

Arquivos: `Natcorp_ProcessoDetalhe.src.js` / `.src.css` → `../login/…js` / `.css`.
JS: `python3 gerar-processodetalhe.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-processodetalhe-pagina29.py f9113_page_29.sql` (aplicada em 03/10;
original em `f9113_page_29.ORIGINAL.sql`). O comentário da página guardava CSS antigo do time:
o nosso bloco entra NO ALTO e o antigo fica embaixo, intacto.

## Como ficou

**Desde 03/10 (2ª versão), duas colunas.** À direita só os CANDIDATOS (a visão principal do
selecionador). À esquerda, fixa ao rolar: **A vaga** (situação, prazo com contagem, "Dados da vaga"
recolhível — começa fechado e lembra a escolha em `nc-pd-vaga-aberta` —, as 4 ações em 2 colunas),
**Etapas** em pé como funil (número, nome, quantos e uma barra do tamanho da etapa no total; tocar
filtra) e **Sinais** (bolinha da cor, nome, quantos; tocar filtra). A barra dos candidatos é UMA
linha: "Candidatos 28" (vira "3 de 28" com filtro) · busca na hora (nome, código, e-mail, cidade,
cargo, fase, celular; Esc limpa; com mais páginas no relatório, Enter usa a busca dele) · ordem ·
Lista | Tabela · Incluir candidato. Na Lista a barra do relatório (lupa/Ir/Ações) sai; na Tabela volta.
Até 1000 px: uma coluna; etapas e sinais deitados, rolando de lado.

Tabela da 1ª versão (o que continua valendo dentro da nova arrumação):

| Onde | O quê |
|---|---|
| Título | "Analista de sistemas junior 57463" (sem maiúsculas gritando; o número em cinza) |
| A vaga (ficha) | situação em selo · Empresa, Filial, Centro de custo, Selecionador (`código - Nome`), Ativa desde, Prazo (+ "vencido há N dias" / "faltam N dias" em Aberta/Publicada) e Publicação · os botões ORIGINAIS: Detalhes da Vaga, Requisição, Anotações das Fases, Processo Seletivo, Finalizar Processo (quando o APEX mostra) |
| Candidatos (alto) | **Incluir candidato** · **Lista \| Tabela** (lembrada no navegador, `nc-pd-visao`; Tabela = o relatório original) · o FUNIL: Todos › Triagem › … com quantos em cada; tocar filtra a lista |
| Busca | a barra do relatório interativo (lupa, Ir, Ações) fica entre o funil e a lista, como sempre |
| Linha do candidato | caixa de seleção · iniciais · nome (abre o candidato, página 32), código, Externo/Interno · idade, sexo, cidade · último cargo e instrução · sinais (Aprovado, Abaixo da nota de corte, Restrição, Documentos, PCD) · etapa "5 Admissão marcada" + "desde" + estrelas (só se tem nota) · atalhos CV/e-mail/WhatsApp/LinkedIn (os links originais) |
| Seleção | marcar aparece a barra escura "N candidatos selecionados" com **Mudar fase** (o botão original) e Limpar seleção |
| Sinais que filtram | "Faltam documentos 27", "Documentos OK 1", "PCD 1", "Aprovados na etapa", "Com restrição", "Abaixo da nota de corte" — só os que existem; somam com a etapa do funil |
| Ordenar | Como no relatório · Etapa mais adiantada · Nome · Atualizados por último · Maior nota (lembrado, `nc-pd-ordem`) |
| Mais sobre o candidato | tocar na linha (ou na seta) abre: Contato (e-mail e celular com copiar — o celular vem do link do WhatsApp —, LinkedIn), Perfil (nascimento e idade, sexo, dependentes, instrução, último cargo, cidade) e No processo (etapa, aprovado, situação, documentos, restrição, última atualização; selecionador/avaliação/resultado se a coluna estiver à vista no relatório) + Abrir ficha completa, Currículo, Enviar e-mail |
| Janela Mudança de fase | no alto, quem vai mudar (nomes e etapa de hoje); Cancelar · Aprovar candidato · Confirmar fase numa linha só no pé |
| Janela Incluir candidato | uma linha explica: externo ou interno, e entra na etapa 1 - Triagem inicial |
| Celular | linha vira cartão (sem iniciais; etapa e atalhos embaixo); ficha em 2 colunas; "mais sobre" em uma coluna |

## Cuidados

- **A caixa nossa APERTA a original** (`.checkbox_item`, f01). O JS da própria página grava a
  seleção no servidor (`salvar_ids`, 800 ms depois) e dispara `apexafterrefresh` no `#partnersIRR`;
  as DAs contam `P29_SELECTED_N` e mostram o Mudar Fase. A nossa lista se redesenha nesse evento.
  Testar seleção = desmarcar depois (fica gravada na coleção da sessão).
- **As colunas são reconhecidas pelo TÍTULO do `th`** (`COLUNAS` em `[D1]`); as células trazem o id
  da coluna em `td[headers]`. Mudou o título de uma coluna no relatório, mude lá.
- O funil vem dos cartões "Visualizar candidato(s) por etapa" (título = etapa, subtítulo = quantos)
  e filtra pela coluna Fase sem acento/maiúsculas. Filtra só a página de linhas à vista; se houver
  mais páginas, a lista avisa.
- Os cartões contam pelo processo (29) e o relatório lista o que a consulta dele traz (28 em 57463):
  a diferença é da consulta original, não do desenho.
- Candidato sem nome no cadastro aparece como "Nome não informado" (continua tocável).
- O botão "hot" do tema pinta o rótulo de branco: o CSS devolve a cor (`[C6]`).
- **Sticky da coluna**: o tema põe `overflow: hidden` em .t-Body, .t-Body-main, .t-Body-content e
  .container — vira caixa de rolagem e o sticky quebra (a coluna nascia 140 px abaixo e subia com a
  página). Nesta página eles ficam `overflow: clip` (corta igual, sem caixa de rolagem). O `top` é a
  altura do cabeçalho fixo, medida pelo JS em `--nc-pd-topo`.
- A região "Relação de Candidatos" é MOVIDA para dentro de `.nc-pd-layout > .nc-pd-principal`; os
  cliques (etapas, sinais, linhas) são ouvidos no `.nc-pd-layout`.
- A coluna dos atalhos tem largura fixa (`--nc-pd-colunas`) para a Etapa alinhar em toda linha.
- **"Aprovar Candidato" original estava ERRADO** (03/10): o endereço usa `&P32_COD_CANDIDATO.`,
  `&P32_FILIAL.`… — itens da PÁGINA 32, que guardam o último candidato aberto na ficha nesta
  sessão (ou nada). Aprovava o candidato errado ou abria a p3 vazia. O JS troca o clique: abre a
  ficha (p32) do candidato selecionado, onde "Aprovar Candidato" usa os dados certos. Conserto
  definitivo no APEX: o botão BTN_APROVACAO não pode usar itens P32_*.
- **"Finalizar Processo" nunca aparece**: a condição do botão devolve `false` nos dois ramos
  (desligado pelo time). A página 33 não foi redesenhada por isso.
- "Data da Fase" não está à vista no relatório: a linha mostra "atualizado em" (Data Atualização)
  e não "desde" — são datas diferentes.

## Quantos candidatos (04/10)

O relatório vem paginado (50 por página, "1 - 50" sem total). O número ao lado de "Candidatos"
era a página à vista e dizia 50 num processo de 163. Agora:
- sem filtro no relatório: o total vem do FUNIL (`ETAPAS_N`, lido dos cartões de etapa — o
  servidor conta): Todos ou a etapa escolhida; ao lado, "N nesta página" quando a lista só
  cobre a página; embaixo, "Mostrando 51–100 de 163";
- busca e sinais (filtram só a página à vista): "N nesta página";
- com filtro no próprio relatório (Enter na busca): o funil não vale mais, conta-se a página.
Ainda vale: escolher uma etapa filtra SÓ a página à vista (a Triagem tem 52, mas nenhuma nas
50 primeiras linhas deste processo).

## Regras da página (auditoria 04/10)

Conferido contra `f9113_page_29.ORIGINAL.sql`: 17 ações dinâmicas (41 ações), 1 validação
(VALIDA_CAND_EXISTENTE), 6 processos, 14 botões.
- **Corrigido:** `.nc-pd-bt` punha `display: inline-flex` (com `!important`) nos botões ORIGINAIS
  movidos — "Mudar Fase", que as ações "(Show/Hide) Selected Buttons" escondem sem selecionados,
  aparecia mesmo escondido pela página. Agora `.nc-pd-bt[style*="none"]` continua escondido
  (`.src.css`, logo depois da regra `.nc-pd-bt`).
- Conferido sem problema: a caixa da linha APERTA a original (`salvar_ids`, `P29_SELECTED_N`);
  Confirmar fase / Incluir são os botões e as janelas originais (Alertify + submit + validação);
  as ações vão para a ficha (todos os botões das regiões escondidas são movidos antes).
- **Para decisão:** "Aprovar candidato" (BTN_APROVACAO) teve o clique TROCADO pelo desenho (03/10):
  em vez de abrir a página 3 com os itens P32_* (bug da página: candidato da última ficha aberta),
  abre a ficha (p32) do selecionado. É um comportamento diferente do original — o conserto
  definitivo é no APEX (o botão não pode usar itens P32_*); até lá, manter ou devolver o original
  é decisão do cliente.
