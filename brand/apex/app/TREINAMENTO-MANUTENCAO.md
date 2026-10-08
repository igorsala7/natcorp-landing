# Requisição de Treinamento (app 200, página 118) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Público: gestores que inscrevem um colaborador numa turma de treinamento; muitos com pouca
intimidade com sistemas, também no celular. O desenho segue o que a página já faz: **o gestor
escolhe quem, o curso e a turma; a turma traz o resto**.

1. **Quem vai participar?** — Empresa, **Colaborador** (o item Matrícula) e **Origem do pedido**
   (o item Tipo Origem), com rótulo em cima. Pedido gravado: a ficha do colaborador (padrão global
   da Skin) e a origem como mais um dado dela.
2. **Qual treinamento?** — Curso e Turma. O que a turma traz e a página trava (tipo, entidade,
   datas, horários, local) vira o **cartão da turma**: "09/06 a 13/06/2025 · 5 dias",
   "09:00 às 12:00", "Quem dá o treinamento", e do Local só as linhas com conteúdo.
   Sem curso na lista: "Nenhum curso disponível para inscrição agora".
3. **Recado para o RH (opcional)** — a Observação.
4. A **barra do rodapé** com o que falta; "Criar" aparece como "Enviar pedido".

## Arquivos (Workspace Images)

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Treinamento.css` | o desenho (gerado de `Natcorp_Treinamento.src.css` por `gerar-app.mjs`) |
| `Natcorp_Treinamento.js` | o comportamento (gerado por `gerar-treinamento.py`, com a ilustração `ilustracoes/treinamento/aula.png`) |

## O contrato: classes nas regiões

Aplicadas por `aplicar-treinamento-pagina118.py` (pelos nomes; roda uma vez só):

| Região | Classe |
| --- | --- |
| &P118_TITULO. | `nc-tre-solicitacao` |
| Aprovadores | `nc-tre-aprovadores` |
| Colaborador Solicitado | `nc-tre-colaborador` |
| Turma | `nc-tre-turma` |
| Botões | `nc-tre-acoes` |

## O que é da página (não do desenho) — conferido na exportação de 29/09

- **Pedido gravado não muda:** a ação "Disable Column (Save)" (condição: `P118_COD_REQUISICAO`
  preenchido) trava tudo — curso, turma, observação e o que a turma trouxe. A tela diz "A turma
  deste pedido já está definida". A **Situação** continua editável (e mostra/esconde botões).
- **Pedido novo:** "Disable Column (Create)" trava o que a turma preenche. `COD_TURMA` depende de
  `COD_CURSO` + `EMP_SOLICITADO`; a turma traz os dados por PL/SQL.
- **Criar/Salvar** ficam numa tabela na coluna do meio da região Botões (o desenho arruma a barra).
- Campo travado **só sai da vista enquanto não tem erro**: se o servidor reclamar dele, ele volta.

## Desligar

Tire as duas URLs de arquivo da página. A ficha global do colaborador continua (é da Skin).

---

# Requisição de Curso (app 200, página 120) — os MESMOS arquivos

O `Natcorp_Treinamento.js` reconhece a página 120 e monta o pedido de curso novo:

1. **Qual curso você precisa?** — **Nome do curso** (com exemplo) e **Tipo do curso** em botões
   grandes. Os botões escolhem na lista `P120_COD_TIPO`, que continua na página, fora da vista.
2. **Conte mais sobre o curso (opcional)** — a Observação.
3. **Quem está pedindo** — a ficha do Solicitante (o próprio gestor: o link "Criar Requisição"
   já passa empresa e matrícula do usuário), depois do curso e sem número.
4. Pedido gravado: tudo travado pela página → **cartão do curso** (nome, tipo, descrição).

| Região | Classe |
| --- | --- |
| &P120_TITULO. | `nc-tre-solicitacao` |
| Aprovadores | `nc-tre-aprovadores` |
| Curso | `nc-tre-curso` |
| Solicitante | `nc-tre-colaborador` |
| Botões | `nc-tre-acoes` |

Aplicadas por `aplicar-treinamento-pagina120.py`. Conferido na exportação de 29/09: **nem Nome do
Curso nem Tipo são obrigatórios no item** (o asterisco do Tipo vem do modelo do rótulo). A barra
avisa quando falta o nome, mas não impede o envio — quem decide continua sendo a página.


# Indicação de Curso (app 200, página 126) — os MESMOS arquivos

O `Natcorp_Treinamento.js` reconhece a indicação pelos ITENS (`…_MOTIVO_INDICACAO` +
`…_CURSO_EXISTENTE`), não pelo número, e monta:

- **o alto**: "Indicar para um curso" / "Indicação para curso" com nº, data e quem indicou
  (gravada = tem ROWID: o nº nasce antes, no foco do Criar), a Situação no canto;
- **① Quem você está indicando?** (Solicitado: Empresa e Colaborador; gravada, a ficha com foto);
- **② Para qual curso?** — "Curso existente?" vira dois cartões ("Um curso que já existe" /
  "Um curso novo"); a lista do APEX continua (escondida) e dispara a ação que alterna Curso e
  Nome do curso. O tipo em botões (os mesmos da 120);
- **③ Por que você está indicando?** (Motivo) e **④ Quem oferece o curso** (Informações do
  contato; sempre à vista, como na página — auditoria 04/10);
- gravada (tudo travado): o **cartão do curso** (nome, da empresa/novo, tipo, motivo, contato);
- a barra do rodapé: o que falta (empresa, colaborador, curso ou nome, tipo, **motivo** — não é
  obrigatório na página, mas sem ele quem aprova não decide) e "Criar" como "Enviar indicação".

Classes (aplicar-treinamento-pagina126.py, por títulos): `&P126_TITULO.` nc-tre-solicitacao,
Aprovadores nc-tre-aprovadores, Solicitado nc-tre-colaborador, Curso nc-tre-curso, Botões
nc-tre-acoes. Exportação `f200_page_126.sql` APLICADA em 30/09 (backup `.ORIGINAL.sql`).

## O que é da página (lido das ações dinâmicas)

- O **foco** no botão Criar (focusin) dispara: habilitar campos, data/situação, o nº da indicação
  (`Seq_Indicacao_Curso.NextVal`) e **insere os aprovadores** — antes do envio. O desenho não mexe
  nisso: o botão só muda de lugar e de rótulo.
- "Curso Existente?" = Sim mostra Curso e esconde Nome do curso (e o contrário).
- Colaborador escolhido e gravado: a página esconde Empresa/Matrícula e mostra a ficha (foto e
  dados) — só no carregamento (condição da região).

## Defeitos da própria página (30/09)

- **A lista de Aprovadores filtra pela página 118**: a consulta usa `:p118_cod_requisicao` (cópia
  da 118) e não `:P126_COD_INDICACAO` — o caminho da aprovação vem sempre vazio. O desenho mostra
  Aprovar/Reprovar mesmo sem o caminho (para quem pode decidir), sem inventar a lista. Correção no
  APEX: trocar o bind nas duas partes do `union`.
- **Regra do desenho aprendida aqui**: a célula (`.nc-tre-celula`) punha `display` no contêiner e
  vencia o `.hide()` da ação dinâmica (Curso e Nome do curso apareciam juntos). Agora a regra pula
  quem está com `style="display: none"` e a célula some junto.

## Regras da página (auditoria 04/10)

**Conferido** contra `f200_page_118.ORIGINAL.sql` (19 ações dinâmicas / 28 ações, 2 validações,
10 processos, 8 botões), `f200_page_120.ORIGINAL.sql` (12 / 19, 1, 10, 7) e
`f200_page_126.ORIGINAL.sql` (14 / 24, 1, 11, 8; 11 itens com só leitura por condição). Sem
processo `NC_…`. Chips do tipo e cartões "Curso existente?" gravam por `apex.item().setValue` e
ficam desabilitados com o item travado; Criar/Salvar/Aprovar/Reprovar são os botões da página
(só mudam de lugar e de rótulo); o "Falta" só avisa, não bloqueia.

**Mudou:**
- `[J7]` (126) "Quem oferece o curso" (`INFORMACOES_CONTATO`) fica à vista também com curso
  existente — a página não o esconde (a DA "Curso Existente" só troca Curso ↔ Nome do curso).
- `[C3]` a regra que põe a Origem travada na ficha (`display: block`) ganhou
  `:not([style*="none"])`.

**Para decisão:**
- Campos travados que o cartão mostra saem da vista (118: os da turma; 120/126 gravados: o
  formulário vira o cartão); voltam com erro do servidor. É esconder item da página, com o valor
  repetido no cartão.
- A região da solicitação sai da vista: a Situação e o botão de quem pediu vão para o alto; nº,
  data e solicitante viram texto. Num pedido novo, o botão de quem pediu fica escondido.
- A região Aprovadores some quando não tem linha nem botão à vista.
- (126) o "Falta" pede o Motivo, que a página não exige (só aviso).
- (126) itens com "só leitura" por condição de servidor: conferir na página viva que a lista
  "Curso existente?" e o Tipo continuam `<select>` (se virarem texto, os cartões não montam).
