# Lançamentos Diversos (reembolso) — app 2060 REQ_REEMBOLSO_NATCORP, páginas 2 e 11

Pedido de 04/10: é a página em que o colaborador faz uma requisição de lançamento, quase sempre um **pedido de
reembolso**. Ela deve fazer sentido para esse propósito. O público tem baixa instrução e ~70% usa o celular.
(O lançamento em lote do RH é outra página, a 7: `Natcorp_Reembolso`.)

| Página | O que é | Desenho |
|---|---|---|
| 2 | a lista dos pedidos (Requisição de Lançamentos Diversos) | motor `Natcorp_Consulta`, receita **A2060_P2_** |
| 11 | a janela do pedido (Criar/Editar: Lançamentos Diversos) | `Natcorp_Lancamento.js/.css` |

Exportações: `python3 aplicar-lancamentos-2060.py f2060_page_2.sql` e `… f2060_page_11.sql`. Os dois já foram
aplicados em 04/10; os originais estão em `*.ORIGINAL.sql`. Só as duas URLs de arquivo e o comentário mudam.

## Página 2 (a lista)

- **Topo:** "Seus pedidos de reembolso" e uma frase do que é. **"Fazer um pedido"** é o botão original "Criar Requisicao".
- **Cartões:** "Pedido 57743", "feito em 4 de outubro de 2026", a situação com as cores do sistema e "Ver pedido" (a lupa da
  coluna "Detalhes").
- **Dados escondidos:** o que é da própria pessoa (empresa, matrícula, cargo…) não aparece (`ocultar`).
- **Filtros no celular:** a região Filtros vai para **depois** da lista (`filtrosDepois`). Ela mora na coluna lateral do modelo,
  então é movida no DOM só no celular.
- **Mudanças no motor (valem para todas as listas):**
  - o motor procura receita por app (`A<app>_P<pág>_`) antes da do número da página;
  - acha o botão de criar que fica na região (posição TOP), e não só na barra do relatório;
  - entende como ação da linha uma coluna de link só com ícone ("Detalhes", "Ver"…).
- **Para enriquecer os cartões (sugestão ao programador):** o relatório da 2 não traz o QUE foi pedido nem o VALOR. Com as
  colunas "Processo" e "Valor" no SQL, o cartão mostra "Reembolso de despesa · R$ 50,00" sem mudar o desenho
  (receita: `principal: 'Processo', valor: 'Valor'`).

## Página 11 (o pedido)

- **Topo:**
  - "Novo pedido" + "Preencha as 3 partes…";
  - ou, num pedido já feito, "Pedido nº 57743", a situação colorida e "Aberto em …".
  - "Para: Tony Oliveira · Natcorp do Brasil". Os campos Empresa e Colaborador saem da vista.
  - O título da janela vira "Novo pedido" ou "Seu pedido".
- **Sem abas:** "Mostrar Tudo / Lançamentos / Anexos" saem. O desenho clica em "Mostrar Tudo" e esconde a barra das abas.
  "Dados da Requisição" (nº, data, situação) sai da vista no pedido já feito, porque o alto já diz.
- **1 · O que você está pedindo:** Tipo de pedido (Processo), Lançamento (Evento), Tipo de reembolso, Motivo.
- **2 · A nota e o valor:**
  - Data da nota ou recibo;
  - Horas | Minutos, Dias, Metragem, Valor/metro: só quando a página mostra;
  - Valor da nota, com "R$" na frente e teclado numérico;
  - **Valor que será lançado** em verde. Quando ficar diferente do valor da nota, aparece "Ficou diferente do valor da nota
    porque o seu plano tem um limite.";
  - comentário opcional.
- **3 · A foto da nota:** "Foto da nota ou recibo" e "Outra foto (opcional)", com `accept="image/*,application/pdf"`.
  No celular, isso oferece a câmera.
- **Botões:** **"Enviar pedido"** = o botão Criar. Salvar, Voltar, Aprovar e Reprovar continuam os originais.
- **Aprovação:** o **caminho da aprovação**, o MESMO desenho das outras requisições (`Natcorp_Beneficios` [J12]/[C12]: Requisição,
  Desligamento, Treinamento, Atestado). Ele fica logo abaixo do alto do pedido:
  - o resumo ("Aprovado por Master", "1 de 2 · aguardando Fulano", "é a sua vez");
  - os aprovadores em linha, ligados por um fio;
  - as justificativas;
  - Aprovar/Reprovar dentro dele.
  No celular, a linha abre por "Ver o caminho" (04/10, pedido de padronização).
- **Tamanhos (04/10):** os do padrão das requisições.
  - Rótulos com 14 px, o alto com 19 px, os títulos das partes com 16 px.
  - Campos e botões no tamanho do tema. No celular, os campos usam 16 px, porque abaixo disso o iPhone aumenta a tela ao tocar.
  - Os selos de situação têm altura de 26 px, 12 px de respiro nas laterais e não quebram linha.
- **Ordem na tela:** é visual. A grade do APEX vira `display: contents` e cada campo ganha `order` (ORDEM no JS); os itens não
  mudam de lugar no DOM.
- **CUIDADO:** toda regra que muda o `display` de um `.t-Form-fieldContainer` leva `:not([style*="none"])`. Sem isso, os campos
  que a página esconde (horas, dias, metragem…) apareciam. Isso aconteceu no 1º teste e foi corrigido. A mesma guarda foi
  posta no Contrato e no Colab.

## Para o programador (encontrado em 04/10)

- **Escrita de depuração:** a ação dinâmica **"Recupera dados do processo"** (change de P11_COD_PROCESSO) grava na tabela
  **TESTEX** (`DELETE … LIKE 'ANDRE%'`, `INSERT … 'ANDRE P11_EMP = …'`, `COMMIT`). Isso parece sobra de depuração em
  produção: cada escolha de processo escreve no banco. Por isso o Processo NÃO foi trocado nos testes.
- **Evento:** a lista de Evento traz `rownum = 1`. É sempre uma opção, preenchida depois do processo.
