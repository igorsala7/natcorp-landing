# Requisição de Serviço de Terceiros (app 2290, página 186) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A página aberta pela aba **Requisição de Serviços de Terceiros** do Painel do Operador (200:804
embute 2290:186; "Voltar" leva à lista 2290:185). O gestor pede a contratação de uma empresa
terceirizada e comprova, em 22 perguntas com 11 anexos, que os funcionários dela têm os documentos
de segurança do trabalho.

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Terceiros.css` | o desenho (gerado de `Natcorp_Terceiros.src.css` por `gerar-app.mjs`) |
| `Natcorp_Terceiros.js` | o comportamento (gerado por `gerar-terceiros.py`) |

App 2290 › Página 186 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Terceiros.js` (no fim
da lista); CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Terceiros.css`. Já aplicado em `f2290_page_186.sql`
por `aplicar-terceiros.py` (original em `f2290_page_186.ORIGINAL.sql`): a URL que a página já tinha
(`jquery.mask`) continua, com a nossa no fim da lista, e o comentário da página ("ABACAXI") continua no
alto, com o nosso embaixo. Numa exportação nova já aplicada, o script só troca o nosso trecho do
comentário. Reconhece a página pelos
itens `…_IND_VINCULO_EMPREG` e `…_COD_TERCEIRO` (sem teste de app/página). Nada é gravado pelo desenho.

**O stepper "Página única / Etapas" é do time** (`Natcorp_Allow_Unload_Iframes.js` monta, a partir da
classe `nc-stepper-host` da região, as seções numeradas e as pendências; o visual está no
`Natcorp_Style_Min.css`). **Não alterar esse arquivo.** O `Natcorp_Terceiros` só acrescenta dentro das
seções e convive com os dois modos (a barra do pé abre a etapa certa antes de levar ao campo).

## O que muda

- **Abertura** "Contratar um serviço de terceiro" e a **lista de documentos para pedir à empresa
  contratada**, em palavras simples (Registro de trabalho, ASO, certificados NR35/NR33/NR10/solda,
  EPI, FISPQ, NR 18, APR, ART…), com **Copiar a lista** e **Mandar pelo WhatsApp** (abre o WhatsApp
  com o texto escrito; a pessoa escolhe para quem). Cada item fica marcado quando o anexo entra. Sem
  produto químico, a FISPQ sai da lista.
- **Perguntas**: cada uma vira um cartão com o número, **a pergunta em outras palavras** (em negrito)
  e, embaixo, o texto oficial (menor, sem mudar nada dele). As siglas são explicadas uma vez por
  bloco ("ASO = exame médico do trabalho: diz se a pessoa pode fazer o serviço").
- **"Veio marcado · confira" → "Conferido"**: as respostas já chegam "Sim"; quando a pessoa toca na
  resposta, a pergunta fica conferida. Cada bloco mostra no cabeçalho "3 de 5 conferidas" e
  "1 de 3 anexos". A marca de conferido não é gravada (vale só enquanto a página está aberta).
- **"Não"** deixa o cartão em amarelo com "Quem aprova vai ver. Se puder, explique na Observação do
  pedido."; **"Não se aplica"** diz que o serviço não precisa disso.
- **Produto químico = Não** recolhe as perguntas 14 e 15 e o anexo H (FISPQ) — os valores ficam.
- **Anexos**: cada um com o nome simples, o texto oficial embaixo e "Falta anexar" / "Anexado"
  (com o nome do arquivo escolhido).
- Dicas curtas em Tipo de Atividade, Descrição, Empresa Contratada, Representante Administrativo,
  Responsável Técnico e Nº do Contrato — **entre o nome do campo e a caixa**, nunca embaixo: as linhas
  desta página alinham os campos pela base, e texto embaixo empurrava a caixa para cima.
- **Alinhamento das linhas** (fora da Segurança): as linhas alinham as caixas pela base e o JS
  (`igualarRotulos`) dá a mesma altura à área do nome em cada linha — nomes na mesma altura, caixas
  na mesma base, mesmo quando só um campo tem dica ou quando a lista de seleção tem outro espaçamento.
  Recalcula ao redimensionar; empilhado no celular, não mexe.
- **Prestador por assunto**: "A empresa contratada" (Empresa Contratada, CNPJ, Cadastrar nova
  empresa, E-mail, Representante Administrativo) e "O contrato" (Nº do Contrato, Previsão de Início e
  de Término). Os campos só mudam de lugar dentro da região (ids, nomes e ações intactos); as linhas
  antigas vazias se recolhem.
- **"Cadastrar Empresas Terceirizadas" → "Cadastrar nova empresa"**, secundário (contorno), com a
  altura exata das caixas e na mesma base (medido no campo vizinho; a Skin força 40 px com
  `!important`, então a altura vai com prioridade). No celular fica logo abaixo da Empresa Contratada.
- A **Observação** ocupa a largura toda (era uma caixa de 252 px).
- **Barra no pé** (presa embaixo): "Falta: Empresa · Filial · Centro de Custo +11 campos · 0 de 11
  anexados" (no celular, uma linha: "Faltam 14 campos · 0 de 11 anexados"); o toque leva ao campo; e
  **Enviar pedido** (clica o "Criar", que também passa a se chamar "Enviar pedido").
- **Pedido gravado** (não visto): cabeçalho com nº, situação, empresa contratada, prazo, local,
  descrição e quem pediu; a aprovação vira o caminho das outras requisições se a página tiver o
  relatório de aprovadores (`th#APROVADOR`).

## Defeitos da página (não mexidos — são do APEX)

1. **Os 11 anexos são obrigatórios mesmo quando a resposta é "Não" ou "Não se aplica"** (nenhuma
   ação dinâmica muda isso): quem responde "Não se aplica" ao ART do andaime ainda precisa anexar
   o ART. Vale revisar no APEX (condição de obrigatoriedade pelo item IND_…).
2. **Todas as respostas vêm marcadas "Sim"** (valor padrão): quem não lê envia tudo "Sim".
3. Não existe a pergunta 5 (a numeração salta de 4 para 6) nem o anexo D; a pergunta 15 tem um
   pedaço da 12 colado no fim ("…e EPI estão preenchidas corretamente contemplando número de C.A.").
4. Situações sem acento no banco ("Concluida", "Suspensao") — o desenho acentua na tela.

## Não visto funcionando

- O **Enviar pedido** de verdade e as validações do servidor (nada foi enviado nos testes).
- Um **pedido gravado** e a tela de quem aprova (a lista 185 não trouxe pedidos no teste).
- Anexar arquivo de verdade (o "Anexado" foi conferido pela lógica, não com arquivo).

## Desligar

Tire as duas URLs de arquivo da página 186 do app 2290.

## Regras da página (auditoria 04/10)

Conferido contra `f2290_page_186.ORIGINAL.sql`: 18 ações dinâmicas (20 ações), 21 validações, 9
processos, condições de regiões/botões. Nenhum processo Ajax nosso (`NC_…`); "Enviar pedido" clica o
Criar original; Aprovar/Reprovar são os botões originais. As ações de abertura agem por id.

Corrigido:
- Com "13. Produto químico = Não", o desenho **recolhia** as perguntas 14 (FISPQ) e 15 (alertas) e o
  anexo da FISPQ — esconder que a página não tem. E a página EXIGE "Não" nelas nesse caso
  (validações "Valida P186_IND_PROD_FISPQ " e "Valida P186_IND_ALERTAS_MANUSEIOS"): com o "Sim" que
  vem marcado, o erro caía num campo fora da vista. Agora as três ficam à vista; o anexo da FISPQ só
  deixa de contar no placar e na barra; a nota diz "marque Não…"; o aviso amarelo de "Não" não
  aparece nessas duas quando o "Não" é o exigido.

Para decisão: nada pendente desta página.
