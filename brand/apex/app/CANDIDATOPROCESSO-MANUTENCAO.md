# Candidato no processo — app 9113, página 32 ("Dados do Candidato")

A ficha do candidato dentro de um processo (aberta pela seta da lista da página 29). Antes: 9 abas
em maiúsculas, dados numa tabela de 5 colunas com rótulos azuis, o mesmo dado em duas abas
(Dados do candidato × Dados pessoais; Fases × Avaliações), relatórios largos para 4 linhas e o
link do WhatsApp quebrado (`<a … <="" a="">` engolia o resto da célula).

Arquivos: `Natcorp_CandidatoProcesso.src.js` / `.src.css` → `../login/…js` / `.css`.
JS: `python3 gerar-candidatoprocesso.py`. CSS: `gerar-app.mjs` (AVULSAS).
Exportação: `python3 aplicar-recrutamento-paginas.py f9113_page_32.sql` (aplicada em 03/10; original em
`f9113_page_32.ORIGINAL.sql`): as duas URLs de arquivo e o comentário — nada mais.

## Como ficou

| Onde | O quê |
|---|---|
| Alto | a VAGA, como na página 29: título "Analista de sistemas junior **57463**" (de `P32_DESC_PROCESSO`) e "Ficha do candidato"; o nome da pessoa NÃO vai no alto (repetia o cartão — pedido 04/10); **Pessoa anterior** ao lado de Voltar |
| Cartão do candidato | logo abaixo do alto, ANTES da barra das etapas (vai para o `.t-Body-fullContent`, onde a barra mora); iniciais, nome completo (do relatório Dados pessoais) + código, nome social, idade · cidade, etapa de hoje, estrelas; e-mail e celular com **copiar** e **WhatsApp**; Aprovar candidato · Avaliar fase · Ver currículo (os botões originais) |
| Abas | pílulas com ícone, como na página 35, numa linha (no celular rolam de lado); ao lado do nome, quantos itens a aba tem (`ABAS[4]` diz o que contar; Documentos = anexados/total, pela classe `classe_ok`); aba sem nada fica apagada. O `min-height` que o APEX grava no painel é anulado (a aba curta ficava com um vão). Ordem: Resumo · Fases e avaliações · Questionário · Anotações · Documentos · Linha do tempo · Outros processos (as abas "Dados pessoais" e "Fases" saem: o conteúdo está em Resumo e em Fases e avaliações) |
| Resumo | grupos Contato, Perfil, Endereço, No processo, Identificação (CPF, nome social) |
| Fases e avaliações | linha do tempo: cada fase com selo Aprovado/Em andamento, desde, avaliação, motivo, avaliado em, avaliador, nota, resultado e o lápis original ("Avaliar") |
| Questionário | por fase e questionário (nota máxima): pergunta, resposta, nota e peso (",5" vira "0,5") |
| Outros processos | uma linha por processo: situação, cargo e número, empresa · filial · CC, selecionador, fase, prazo; o atual marcado "este processo" |
| Ver tabela | em cada aba transformada, devolve o relatório original |

## Cuidados

- **As estrelas do cartão são o item original `P32_PONTUACAO`, movido** (não um desenho). Clicar
  dispara a ação "Update Pontuacao" (`update candidato set pontuacao`, com commit). Até 04/10 o
  cartão desenhava estrelas próprias, só de leitura, e a gravação parou. Ao testar, não clicar
  nelas: grava.

- **Aprovar candidato** (BTN_APROVACAO_NEW): se a requisição está em revisão (P32_SIT_REQUISICAO = 0)
  avisa e para; senão `apex.submit('APROVADO')` e o desvio "Goto 3" abre a janela 3 com os P32_* desta
  ficha. É por isso que a página 29 manda o "Aprovar" para cá. A ação "Chama tela de Aprovação" (com o
  alerta "Teste envio mensagem.") está NEVER — sobra de teste, não roda.

- Os relatórios têm **duas** `table.a-IRR-table` (cabeçalho fixo sem dados + a de dados): o leitor
  pega títulos de qualquer uma e linhas de quem tem `td[headers]`.
- Colunas reconhecidas pelo **título** (sem acento, minúsculo). Regiões: "DADOS DO CANDIDATO",
  "ANOTAÇÕES", "TIMELINE…" pelo título; Fases/Avaliações/Histórico pelos static ids FASES,
  AVALIACOES, VAGAS (estáveis entre bases; os R5… não).
- A barra das etapas mora na mesma região que "Pessoa anterior": só a COLUNA vazia do botão sai.
- Documentos anexos: o desenho é o global (Natcorp_Paginas [C10]); corrigido em 03/10 — com um
  anexo na lista, os obrigatórios pendentes viravam "Opcional" e a faixa dizia "todos enviados".

## Regras da página (auditoria 04/10)

Conferido contra `f9113_page_32.ORIGINAL.sql`: 20 ações dinâmicas (31 ações), 1 validação, 11
processos, 3 desvios, 13 botões.
- **Corrigido (sumiam):** "Remover Aprovação" (BTN_EXCLUIR_APROVACAO) e "Excluir Candidato"
  (EXCLUIR_CANDIDATO) moram no cabeçalho da região "DADOS DO CANDIDATO", que o Resumo esconde; só
  Aprovar/Avaliar/CV eram levados para o cartão. Agora vão junto (`[K3]`, lista das ações).
- **Corrigido:** `.nc-cp-bt` punha `display: inline-flex` com `!important` e vencia o `hide` da
  ação "Sit. Concluida" (esconde Excluir Candidato quando a requisição está concluída). Agora
  `.nc-cp-bt[style*="none"]` continua escondido.
- Conferido sem problema: as estrelas são o item original P32_PONTUACAO (ação "Update Pontuacao");
  as abas "Dados pessoais" e "Fases" saem mas todas as colunas visíveis delas estão no Resumo /
  Fases e avaliações; "Confirmar Indicação" e "Dados funcionais" continuam como abas.
- Sem pendências.
