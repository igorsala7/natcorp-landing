# Requisição de Exames (app 2937, página 61) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A página aberta pela aba **Requisição de Exames** do Painel do Operador (200:774 embute a lista
2937:60; "Criar Requisição" e cada pedido abrem a 61). O gestor pede o exame médico de um candidato
(admissional) ou de um colaborador (periódico, mudança de função, retorno ao trabalho, demissional,
perícia) e escolhe o dia e o horário na agenda (janela 2937:75). O Médico do Trabalho avalia; aprovado,
o compromisso fica na agenda médica. (Mesmo app do Atestado, p91 — outra página.)

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Exames.css` | o desenho (gerado de `Natcorp_Exames.src.css` por `gerar-app.mjs`) |
| `Natcorp_Exames.js` | o comportamento (gerado por `gerar-exames.py`) |

App 2937 › Página 61 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Exames.js` (no fim da
lista); CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Exames.css`. Reconhece a página pelos itens
`…_TIPO_PACIENTE`, `…_COD_TIPO_CONSULTA` e `…_COD_PACIENTE` (sem teste de app/página). Nada é gravado.
Já aplicado em `f2937_page_61.sql` por `aplicar-exames.py` (original em `f2937_page_61.ORIGINAL.sql`).

## O que muda

**Pedido novo**
- Abertura "Pedir um exame médico" com o caminho: você pede e escolhe o dia e o horário → o Médico do
  Trabalho avalia e aprova → o exame fica na agenda médica.
- Passos **1 Quem vai fazer o exame? · 2 Que exame? · 3 Quando? · 4 Alguma observação?**; o nome do
  campo em cima da caixa (a região tinha nomes à esquerda).
- **Candidato / Colaborador** em dois cartões ("Vai ser contratado" / "Já trabalha na empresa").
- **Tipos de exame em cartões**, a partir das opções que a lista traz (o código muda de base para base;
  o nome é que casa: Admissional, Periódico, Mudança de função, Retorno ao trabalho, Demissional,
  Perícia — cada um com uma frase simples; outro nome vira cartão só com o texto). O toque faz
  `setValue` na lista (as ações da página rodam: data de desligamento, cargo/função/local propostos,
  grupo de exames). A lista depende de Tipo de Paciente, Empresa e Paciente: vazia, o cartão diz
  "Escolha a empresa e quem vai fazer o exame (passo 1)". O "Exame" (ASO) fica à vista, como na página (auditoria 04/10).
- **O cartão da consulta** no passo 3: sem horário, "Ainda sem dia e horário" + **Escolher dia e
  horário** (clica o botão "Agenda - Datas e Horários" da página, que fica fora de vista); com horário,
  o dia em destaque (mês, número, ano), o dia da semana, "08:00 às 08:30", o médico e "Trocar horário".
- Barra no pé: "Exame demissional para Tony em 01/10", o que falta (o toque leva ao campo ou abre a
  agenda) e **Enviar pedido** (clica o "Criar").

**Pedido gravado** (padrão das outras requisições; código - descrição em tudo)
- Cabeçalho: nº, situação, "Exame periódico · ASO", "Para 633339 - Alves · colaborador", empresa e
  filial com código, grupo de exames / desligamento / cargo proposto quando houver, o cartão da
  consulta, a observação e quem pediu.
- **Linha de ações** logo abaixo: a **Situação** (a lista continua editável, com a ação da página),
  **Salvar**, **Cancelar este pedido** e **Voltar** — vindos da coluna lateral e do rodapé; o "Voltar"
  repetido sai de vista. A coluna lateral (só leitura) some e o conteúdo ocupa a largura toda.
- A aprovação logo abaixo, na largura toda (o caminho do PPP/Hora Extra; Aprovar/Reprovar só com
  etapa pendente). O painel "Informações", vazio em leitura, sai.

## Cores (pedido do usuário, 30/09)

O roxo cheio fica **só no registro da agenda** (o bilhete com dia, horário e médico), nos dois modos:
a abertura do pedido novo e o cabeçalho do pedido gravado são cartões claros (borda leve, texto
escuro, ícones em roxo; a situação em etiqueta colorida). Sem horário, o aviso "Ainda sem dia e
horário" também é claro. As regras estão no fim do `Natcorp_Exames.src.css` ("tom claro").

## Cuidados

- A Skin prende os rádios em `.apex-item-grid-row` (38 px, conteúdo cortado) e as opções flutuam: a
  grade dos dois cartões vai nessa linha interna (ver [[apex-avaliacao-p140]] na memória).
- Os contêineres dos campos têm margem de -8 px que a Skin compensa com 8 px de espaço nas colunas do
  nome e da caixa: ao pôr o nome em cima, manter esses 8 px (senão a primeira letra some).
- O horário é escolhido na janela 2937:75 ("Pesquisar Horário para Encaminhamento": médico, data,
  hora inicial e final) — ainda sem desenho.

## Não visto funcionando

- O **Enviar pedido** de verdade, as mensagens do servidor (alertify) e a escolha de um horário na
  agenda (a janela foi aberta e fechada sem escolher).
- A lista de exames do **Candidato** (vazia no teste — depende do cadastro).
- A tela do Médico do Trabalho com etapa pendente.

## Desligar

Tire as duas URLs de arquivo da página 61 do app 2937.

## Regras da página (auditoria 04/10)

Conferido contra `f2937_page_61.ORIGINAL.sql`: 37 ações dinâmicas, 5 validações, 9 processos,
11 botões, as condições de só leitura (itens e região Agendamento) e as condições de exibição.

- Monta no "ready" do jQuery (antes das ações de abertura), mas as ações acham tudo por id e o
  desenho relê o estado a cada mudança/Ajax — sem efeito nas regras. Os cartões gravam por
  `setValue` só as opções da lista; "Enviar pedido" clica o Criar original (que reabilita os itens e
  submete); Aprovar/Reprovar/Cancelar/Suspender/Em andamento são os originais.
- **Mudou (CSS):** `.nc-ex-reg .t-Form-fieldContainer` tinha `display:block` (com `!important`),
  que vencia o esconder das ações: data do desligamento, cargo/função/local propostos e grupo de
  exames apareciam sempre. Agora `[style*="none"]` vence (`[C7]`).
- **Mudou (JS):** o "Exame" (ASO) não some mais antes de escolher o tipo (mostrar/esconder que a
  página não tem).
- **Mudou (JS+CSS):** no pedido gravado, toda a parte de campos saía da vista, inclusive o que a
  página ainda deixa mudar com o Salvar: o **horário** e a **observação** enquanto não há agenda e a
  **data do desligamento**. A região com campo editável fica à vista (`nc-ex-edita`), e o cartão
  da consulta (também no cabeçalho) volta a ter "Escolher dia e horário" quando não há agenda e há
  Salvar (a mesma regra de só leitura da região Agendamento).
- **Para decidir:** no pedido gravado, a coluna "Requisição" some; a data da situação e a empresa do
  solicitante não aparecem em outro lugar.
