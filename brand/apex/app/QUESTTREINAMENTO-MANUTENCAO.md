# Questionário do treinamento — app 9104, página 2 (manutenção)

Onde o colaborador responde a avaliação do treinamento que acabou de fazer. **70% no celular,
90% com pouca instrução escolar** (pedido de 04/10/2026). Desenhado primeiro para 390px.

Arquivos: `Natcorp_QuestTreinamento.src.js` → `../login/Natcorp_QuestTreinamento.js`
(`python3 gerar-questtreinamento.py`); `Natcorp_QuestTreinamento.src.css` → `../login/…css`
(`node gerar-app.mjs`, lista AVULSAS). Exportação: `python3 aplicar-questtreinamento-pagina2.py
f9104_page_2.sql` (aplicada em 04/10; original em `f9104_page_2.ORIGINAL.sql`).

**Para subir:** importar `f9104_page_2.sql` e pôr `Natcorp_QuestTreinamento.js` e `.css` no
Workspace Images. A página 3 (a janela de uma pergunta) não muda.

## Como ficou (decidido 04/10, noite: "sempre começa informando os parâmetros, do jeito original, com um novo estilo, e então surgem as perguntas")

| Tela | O quê |
|---|---|
| Parâmetros | Os 5 campos ORIGINAIS — Empresa, Curso, Turma, Matrícula, Questionário — e a Data da resposta, todos à vista, num cartão: rótulo em letra normal em cima, campo de 54px; uma coluna no celular, duas no computador (Turma e Data na linha inteira). A região "Parâmetros" é só MUDADA para dentro do cartão: listas em cascata, janelas de busca (abrem na casca, pelo `Natcorp_Lov.js`) e ações da página como sempre. **Começar** confere o que falta ("Falta escolher: curso, turma.", campo em vermelho) e clica o Pesquisar original. |
| Perguntas | "Pergunta 3 de 14" com a trilha, a pergunta grande, **Ouvir** (voz do celular), respostas em botões grandes: escala Ótimo/Bom/Regular/Ruim/Péssimo com **carinhas** (só quando TODAS as respostas da pergunta são da escala), Sim/Não com sinal. **Um toque grava e passa para a próxima.** Escrita: caixa de texto, grava ao avançar. Anterior/Próxima presos no pé da tela no celular. |
| "Qual?" | Pergunta escrita curta (≤ 30 letras) logo depois de uma Sim/Não vira parte dela: só aparece se a resposta for Sim. |
| Fim | "Obrigado!" (ou "Quase lá — faltam N"), Sair (= Voltar original) e "Suas respostas", tocáveis para mudar. **Trocar** = Filtrar original (destrava os campos, limpa o questionário) e volta aos parâmetros. |

Tentativas descartadas no mesmo dia (não voltar a elas sem pedido): escolha em 5 passos com um campo
por tela; "Quem é você?" (busca da pessoa) + "os treinamentos dela" (processos NC_QUEST_PESSOAS e
NC_QUEST_TREINOS — já tirados do script; se ficaram no APEX depois de um import, podem ser apagados).
Cópia do JS/CSS dessa versão: só no histórico desta conversa.

## Como lê e grava


- **NC_QUEST_PERGUNTAS** (Ajax Callback): perguntas (`tr_questionario_perguntas` + `tr_perguntas`,
  por `cod_pergunta`, como a lista), respostas possíveis (`tr_questionario_respostas` +
  `tr_respostas`, por `cod_resposta`, como a janela 3) e a resposta já dada
  (`tr_questionario_participante`).
- **NC_QUEST_SALVAR**: x01 pergunta, x02 resposta, x03 texto. Regra da janela 3: nota =
  `valor_resposta` da resposta; `data_resposta`, `usuario` e `dt_atualizacao` = agora. Atualiza;
  sem a linha, cria. Devolve a data para o item `P2_DT_RESPOSTA`.
- Os dois **conferem** que a pessoa é participante da turma com a mesma regra de acesso da lista
  "Matrícula" (`F_Acesso_Emp_PG_APEX`, `f_acesso_pg_apex`, candidato `tipo_participante = 'C'`) e
  que o questionário é da turma; o SALVAR confere também pergunta e resposta. A janela 3 tinha
  essa garantia pelo checksum dos parâmetros; o Ajax não tem.
- Os parâmetros são os campos e o **Pesquisar originais** (as ações da página validam, travam os
  campos e recarregam a lista, como sempre); "Trocar" é o **Filtrar** original.

## Cuidados

- Botões achados pelo TÍTULO (Pesquisar, Filtrar, Voltar), não pelo id (os ids mudam entre bases).
- Os campos e a lista original ficam escondidos, não apagados: são eles que guardam a escolha.
  Sem os processos (exportação não importada), a lista original volta, com a janela de sempre.
- O app 9104 **não carrega o `Natcorp_Style_Min.css`**: o CSS desta página tem as próprias cores e
  a fonte (Inter, com reserva do sistema). Se o app passar a carregar a Skin, as variáveis `--nc-*`
  do tema entram sozinhas.
- Barra Anterior/Próxima é `position: fixed` no celular (sticky não gruda no tema).
- Ao testar: escolher respostas GRAVA. A prévia do navegador de teste usa um stub que lê as
  perguntas pelas janelas da página 3 (só leitura) e **não grava**.

## Não visto funcionando

Os quatro processos no Oracle (pessoa e treinamentos: prévia com os 17 participantes REAIS da turma
testada, sem a contagem de respondidas; confirmar se o app 9104 tem P_EMPRESA_USER/P_MATRICULA_USER) (só a prévia com o stub, com os dados reais de 700 / Atendimento ao
Cliente / turma 1 / 006530 / questionário 1). Depois de importar: responder uma pergunta, recarregar
e conferir que a resposta e a nota estão na tabela (e na lista original).

## Desligar

Tire as duas URLs de arquivo da página 2. Os processos podem ficar (ninguém os chama).

## Cuidados do cartão dos parâmetros

- A região é MUDADA de lugar; o cartão entra na página ANTES de mexer nos rótulos e ligar os avisos
  (fora dela, `getElementById` não acha — foi o defeito da primeira versão).
- As linhas e colunas da grade do APEX ficam `display: contents`; o clearfix delas (`::before`/
  `::after`) é desligado, senão vira célula vazia e abre vão entre os campos.
- Os campos de busca (curso, matrícula) são `readonly` no APEX: não usar `input[readonly]` para o
  visual de "só leitura" (só a Data da resposta tem esse visual).
- Em produção a página abre pela casca 200:765 (TR_MENU) num iframe, pelo apelido `TR_PRC_NATCORP:2`;
  o app tem `P_EMPRESA_USER`/`P_MATRICULA_USER`.

## Regras da página (auditoria 04/10)

Conferido contra `f9104_page_2.ORIGINAL.sql` (8 ações dinâmicas / 17 ações, 1 processo, 4
botões) e a janela `f9104_page_3.sql` (3 / 7 ações, 4 processos: Form DML na
TR_QUESTIONARIO_PARTICIPANTE, "Atualização Genérica de Dados", Close Dialog).
- Os parâmetros são os itens originais; "Começar" exige os mesmos 5 campos que a ação
  VerifParametros e clica o Pesquisar original; "Trocar" é o Filtrar original. Nada mudou no código.
- **Para decisão — NC_QUEST_SALVAR × janela 3 (o que a gravação faz diferente):**
  1. `data_resposta`: a janela 3, ao ALTERAR, mantém a data da primeira resposta (a linha que a
     atualizaria está comentada em "Atualização Genérica"); o SALVAR grava `sysdate` a cada troca.
  2. Grava sempre as duas colunas: responder alternativa zera `resposta_dis`; responder texto zera
     `resposta_alt` e `nota_resposta`. A janela 3 deixava a outra coluna como estava.
  3. Sem a checagem de atualização perdida (a janela usava `lost update = VALUES`).
  4. **Excluir resposta sumiu:** a janela 3 tinha o botão Excluir (DELETE) com a resposta gravada;
     no fluxo novo não há como apagar uma resposta (só trocar). Também o "Reset" (BT_RESET) da
     barra do título fica fora da vista.
  5. O SALVAR acrescenta conferências (participante da turma com a regra de acesso da LOV
     Matrícula, pergunta do questionário, resposta da pergunta) — mais rígido que a janela, que
     confiava no checksum da URL.
