# Processos Seletivos — app 9113, página 28 ("Relação de Vagas")

Onde o recrutador acompanha os processos seletivos (previstos, em aberto, publicados, fechados…).
Antes: um cartão enorme por vaga (3 por tela), cada dado com o rótulo na frente, e os filtros
mais usados no meio de outros 13 campos. Agora: uma linha por processo, em colunas.

Arquivos: `Natcorp_ProcessosSeletivos.src.js` / `.src.css` → `../login/…js` / `.css`.
JS: `python3 gerar-processosseletivos.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-processosseletivos-pagina28.py f9113_page_28.sql` (aplicada em 03/10;
original em `f9113_page_28.ORIGINAL.sql`).

## Como ficou

| Onde | O quê |
|---|---|
| Alto dos resultados (faixa da região) | o total ("493 processos") · **Minhas vagas \| Todas as vagas** (pesquisa na hora) · busca (Enter pesquisa em TODOS, campo P28_PESQUISAR) · **Lista \| Tabela** (Tabela = o relatório interativo original; troca e pesquisa) |
| Situação | botões de um toque: Todas · Prevista · Em aberto (código 5 = Aberta e Publicada) · Fechada · Cancelada · Reprovada → P28_STATUS + Pesquisar |
| Linhas | Vaga (cargo, nº, empresa · filial, CC · UA) · Fase ("1 Triagem inicial") · Candidatos · Selecionador (`código - Nome`) · Prazo de contratação (+ "vencido há N dias" / "faltam N dias" nas Abertas/Publicadas; âmbar a partir de 7 dias) · Situação. Tocar abre a página 29 (o link de sempre); Prevista não tem processo, não é link |
| Filtros (coluna) | título "Filtros" com a faixa, **Limpar filtros**, Pesquisar fixo no pé; Enter num campo pesquisa. De quem, Situação e Tipo de relatório saíram daqui (estão no alto) |
| Celular | cada processo vira um cartão; situação rola de lado |
| Paginação | a original, 50 por página (era 25) |

## Cuidados

- **As linhas são LIDAS do "Relatório de Vagas 1"** (lista de mídia): cargo no `<h3><b>`, número
  no `<p>` seguinte, dados como `<b>Rótulo: </b>valor<br>`. Os rótulos são reconhecidos pelo nome
  (`CAMPOS` em `[P3]`): mudou o rótulo na consulta, mude lá.
- Tudo que filtra escreve nos itens P28_* e aperta o **Pesquisar original** (a ação "Search", que
  marca P28_PESQUISAR_SN e envia a página).
- A grade desta página é a antiga (larguras em %, não flex) e a região tinha uma coluna vazia de
  recuo: o CSS esconde a coluna vazia e põe a região em 100%.
- Situações e cores: `[P1]` do JS e `[C1]` do CSS (o código tem de ser o da lista do P28_STATUS:
  Prevista 1, Fechada 2, Cancelada 3, Reprovada 4, Aberta 5).

## Regras da página (auditoria 04/10)

Conferido contra `f9113_page_28.ORIGINAL.sql`: 7 ações dinâmicas (12 ações), 2 processos, 5 botões,
as condições das duas regiões "VAGAS" (Lista = `P28_RELATORIO` C, Tabela = I).
- Situação, Minhas/Todas e Lista/Tabela gravam nos itens originais por `apex.item().setValue` e
  apertam o Pesquisar original (ação "Search": marca `P28_PESQUISAR_SN` e envia). A busca do alto
  escreve em `P28_PESQUISAR`/`P28_PESQUISAR_1` (o que estiver na página). Nada grava no banco.
- Os três campos guardados (Tipo de consulta, Status, Tipo de relatório) não têm ação que os
  mostre/esconda; as regras de CSS só põem `display` nos nossos elementos.
- Nada mudou. Sem pendências.
