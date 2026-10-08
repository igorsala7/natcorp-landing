# Requisição de Reembolsos / Lançamentos Diversos em lote (app 2060, página 7) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A página aberta pela aba **Requisição de Reembolsos** do Painel do Operador (200:798 embute o app
2060 — `REQ_REEMBOLSO_NATCORP`; a lista é a página 2, "Lançamentos Diversos em Lote" abre a 7).
O gestor lança um **evento da folha** (a rubrica: reembolso de almoço com cliente, estacionamento,
bônus, desconto por celular quebrado…) para várias pessoas de uma vez:

1. **Parâmetros** (empresa, processo e filtros de elegibilidade) → **Pesquisar** (submit
   `PESQUISAR`) devolve as matrículas elegíveis;
2. **Lançamentos**: Eventos e Motivos, Valores (horas/minutos/dias/R$), Datas, Observações;
3. **Matrículas Elegíveis** (relatório interativo com a caixa `f01` de cada pessoa, já marcada)
   → **Criar Requisicao** (submit `CRIAR_REQUISICAO`) grava para as marcadas.

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Reembolso.css` | o desenho (gerado de `Natcorp_Reembolso.src.css` por `gerar-app.mjs`) |
| `Natcorp_Reembolso.js` | o comportamento (gerado por `gerar-reembolso.py`) |

App 2060 › Página 7 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Reembolso.js` (no fim
da lista); CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Reembolso.css`. Já aplicado em `f2060_page_7.sql`
por `aplicar-reembolso.py` (original em `f2060_page_7.ORIGINAL.sql`); numa exportação nova já aplicada,
o script só troca o comentário da página. Reconhece a página pelos itens `…_COD_PROCESSO` e `…_EVENTOS` / `…_COD_ELEGIBILIDADE` (sem
teste de app/página). Nada é gravado pelo desenho.

## O que muda

- **Os três passos** no alto (Quem vai receber → O que lançar → Conferir e enviar), com o passo
  atual marcado; cada região ganha o número dela no título.
- **1. Quem vai receber?** Empresa e "Processo da folha" à vista; os demais filtros (filial,
  sindicato, centro de custo, unidade, atividade, cargo, situação) em "Filtrar mais" (abre sozinho
  se algum tiver valor; depois do primeiro toque, vale a escolha da pessoa — "Esconder os filtros"
  fecha mesmo com filtro preenchido, e o botão fechado mostra "N filtros em uso"). O Perfil (só leitura) continua à vista (04/10). "Pesquisar" → **Buscar as
  pessoas**. Depois da busca o passo vira um resumo em chips ("Filial Natcorp do Brasil Fil 97 ·
  2 pessoas encontradas") com **Mudar a busca**.
- **2. O que você vai lançar?** "Tipo de lançamento" (o evento) e Motivo, com a explicação do que é
  evento; **Quanto** (valor em R$ grande, ou horas/minutos/dias — "é o valor de cada pessoa");
  **Quando**: as datas que o sistema já decidiu (vigência, dia limite, efetivação, parcelas) ganham
  em cima a frase "Entra na folha de junho de 2026, pode ser lançado até o dia 30, 1 parcela" e
  continuam à vista (04/10); ficam "Vale a partir de / Vale até". **Explicação** com exemplo no campo.
- **3. Confira quem vai receber** (sai de dentro do cartão do passo 2): "N de N pessoas marcadas",
  **Marcar todas / Desmarcar todas** (as caixas da página atual do relatório), colunas sem nenhum
  dado fora da vista (antes de criar, Evento/Motivo/Qtd… vêm "-"); "Selecionar" → "Incluir",
  "Upload" → "Anexo", "Download" → "Baixar".
  No pedido gravado o bloco da busca se chama "Parâmetros" (a lista é que é "Quem vai receber").
  No pedido gravado a lista não tem caixas de marcar: o topo diz só "N pessoas neste pedido"
  (sem Marcar/Desmarcar).
- **Barra do pé** (presa embaixo): "Você vai lançar **Diferença Salarial** de **R$ 150,00** para
  **2 pessoas** · total R$ 300,00", o que falta (tipo, motivo, valor ou quantidade, pelo menos 1
  pessoa — o toque leva ao campo) e **Enviar lançamentos** (é o "Criar Requisicao").
- **Pedido gravado**: cabeçalho com nº, situação em cor, data e "Já efetivado / Ainda não
  efetivado na folha" no lugar da região "Requisição"; a busca resumida; e o **caminho da
  aprovação** (o mesmo das outras requisições), com Aprovar/Reprovar dentro para quem aprova.
  "Cancelar" → "Cancelar este pedido".

## Defeitos da página (não mexidos — são do APEX)

1. **Coluna "Upload" (janela página 8)**: abre com `ERR-1002 Não foi possível localizar o ID do
   item "P8_VALIDA_PAINEL"` (processo `popula_campos` da página 8 grava num item que não existe).
2. **Coluna "Download"**: o link vai para a LISTA (`f?p=2060:2…`), não para o arquivo — quem clica
   perde tudo o que preencheu na página 7.
3. O segundo "Data Validade Inicial" é o `P7_DATA_VALIDADE_FINAL` (rótulo repetido; o desenho
   mostra "Vale até").
4. Rótulos sem acento no APEX ("Parametros", "Matriculas Elegiveis", "Observacoes", "Criar
   Requisicao", "Data Vigencia Efetivacao") — o desenho troca na tela.

## Não visto funcionando

- O **Enviar lançamentos** de verdade (nada foi enviado nos testes) e as validações do servidor.
- A tela de quem aprova (o usuário de teste não é aprovador).
- Um relatório com muitas pessoas (paginado): "Marcar todas" só alcança as caixas da página
  atual do relatório.

## Desligar

Tire as duas URLs de arquivo da página 7 do app 2060.

## Regras da página (auditoria 04/10)

**Conferido** (exportação `f2060_page_7.ORIGINAL.sql`): 17 ações dinâmicas (31 ações), 8 validações,
7 processos, 57 itens, 10 botões, condições de região (P7_PESQUISA, P7_USA_METRAGEM, P7_COD_REQ).
Nenhum processo `NC_` nosso: o desenho não grava nada.
- Ações de abertura (Mostra para valor/hora/dias, Oculta anexo, Mostra Metragem, Show do Criar)
  agem por id de item, região e botão: mover a lista de matrículas não atrapalha o Refresh dela.
- O CSS não força `display` em contêiner de item, região da página nem botão.
- "Pesquisar", "Criar Requisicao", "Cancelar", Aprovar/Reprovar são os originais (só o rótulo muda).
  Marcar/Desmarcar todas mexe nas caixas f01 existentes, pula as desabilitadas e dispara `change`.

**Mudou** (`Natcorp_Reembolso.src.js`)
- O item Perfil (só leitura) não some mais ([J4]).
- Vigência, Dia limite, Efetivação e Parcelas (só leitura) não somem mais: a frase fica em cima
  deles ([J5]).
- A região Aprovadores só some sem aprovadores se também não tiver Aprovar/Reprovar; e, fora da
  "sua vez", os dois botões voltam ao lugar original em vez de sumir com a faixa ([J9]).

**Para decidir**
- Pedido gravado: os itens da região Requisição (nº, data, situação, efetivação — só leitura)
  saem de vista e o cabeçalho os repete. É região de dado escondida pelo desenho.
- Depois da busca, o passo 1 fecha num resumo (os itens e o "Pesquisar" voltam com "Mudar a
  busca"); no pedido gravado ele fica só como resumo, sem como abrir (os itens não têm botão de
  gravar nesse modo).
- Filtros recolhidos em "Filtrar mais" (abre com um toque; o botão diz quantos estão em uso).

