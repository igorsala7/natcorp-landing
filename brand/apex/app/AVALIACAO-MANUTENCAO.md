# Avaliação de desempenho (app 9118, páginas 140 e 144) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Quem responde é, na maior parte, o **colaborador pelo celular** (9 em 10 acessos) — e também o
gestor, o par, o comitê. No celular a tabela de 9 colunas escondia a pergunta e a resposta, e a
faixa de opções da pergunta cortava "Insatisfatório" e "Fraco". O desenho vira uma **trilha**.

## Duas pessoas, a mesma página

- **Quem responde** (colaborador, celular): o alto com a trilha e "continuar", perguntas em
  **cartões**, dados do avaliado recolhidos ("Ver dados").
- **Quem valida** (avaliador/RH, computador): **resumo das perguntas** — média por competência
  (barra na escala) e a distribuição das respostas, com a média geral —, as perguntas em
  **linhas** com a coluna das respostas alinhada (resposta, pontos da escala, nota), e o perfil do
  avaliado aberto (tempo de casa, faltas no período, formação, empresa).

## Página 140 — a avaliação

1. **O alto** — diz o que falta ("Faltam 5 de 23 perguntas" / "Vamos começar" / "Todas
   respondidas"), mostra a **trilha** (um traço por pergunta, agrupado por competência), o botão
   que **continua de onde parou** (abre a primeira pergunta sem resposta) e as **etapas** que o
   APEX mostra, com o andamento: Perguntas (x de y), Plano de desenvolvimento, Feedback,
   Comentário, Conclusão (campos preenchidos). Tocar numa etapa rola até ela.
2. **Fatos** — tipo (Autoavaliação, Avaliação do gestor…), ciclo, data e avaliador (com o botão
   do perfil). O formulário "Avaliação" chega todo travado (ação dinâmica): sai da vista; se algo
   nele vier editável, ele continua.
3. **Imprimir** — os botões de Relatórios (Ficha de Registro, Comitê de Carreira, Avaliação),
   trazidos para o alto, com o mesmo clique.
4. **Resultado** — os três números lado a lado, e o Pedido de Recurso.
5. **Perguntas em cartões por competência**, com a resposta e a nota à vista; tocar abre a pergunta
   (clica no link "Editar" da linha). "Ver como tabela" volta ao relatório.
6. **Avaliado** — o perfil: foto, nome, função e matrícula, situação ("Ativo · desde…") e os
   fatos que pesam numa avaliação — tempo de casa (da admissão), faltas no período ("Nenhuma
   falta" em verde), formação/instrução, empresa/filial. Os valores chegam por ação dinâmica
   (PL/SQL) depois de abrir: o perfil é refeito quando as chamadas terminam.
7. **Plano de desenvolvimento como PDI** — "O que favoreceu" (Aspectos Facilitadores, Pontos
   Fortes), "O que desenvolver" (Aspectos Dificultadores, Pontos a Desenvolver, Fatores Externos) e
   "Próximos passos" (Plano de Ação, Encaminhamentos), com uma dica em cada campo editável.
8. **Comentário como conversa** — Avaliador, Avaliado e Examinador com ícone; o único campo
   editável ganha "seu comentário"; os travados e vazios dizem "Ainda sem comentário".
9. **Textos** (plano, comentário, conclusão) — crescem com o texto; travados e vazios ficam numa
   linha ("Ainda sem texto").
10. **Barra de baixo** — "Salvar" sempre à mão, avisando "Há texto ainda não salvo" (as respostas
   das perguntas gravam sozinhas; os textos, só com Salvar). **"Deletar" vai para o fim da página**
   como "Excluir esta avaliação", longe do polegar.

## Página 140 em CRIAÇÃO (nova avaliação)

A página abre sem avaliado. O alto vira **"Nova avaliação"** com três passos que acompanham o
preenchimento: ① a avaliação e a data → ② quem será avaliado (botão "Escolher quem será
avaliado" rola e põe o foco em Empresa) → ③ as perguntas (abrem depois). Os formulários
"Avaliação" e "Avaliado" ganham rótulo em cima; no Avaliado, uma dica e Empresa | Matrícula lado a
lado. O "Aviso" (avaliação anônima) fica fora da vista enquanto não tem texto.

**Cuidado (já custou um bug, 29/09):** na região Avaliado só o bloco das sub-regiões Colab Foto /
Colab Info sai da vista (o cartão do perfil as substitui). **Empresa e Matrícula do avaliado são
do APEX**: aparecem na criação e em "Alterar Colaborador" e as ações dinâmicas escondem depois.
Esconder o corpo inteiro da região impedia escolher o avaliado. Do mesmo jeito, o **Salvar** e o
**Excluir** acompanham o `display` que o APEX dá a eles, e a região "Botões" só some enquanto não
tem botão à mostra — nada disso é decidido uma vez só, ao abrir.

## Página 144 — a pergunta (janela)

- Barra de progresso ("Pergunta 3 de 23"), a competência, a pergunta em letra grande e a descrição.
- As opções em **cartões de toque** de largura toda, com a escala em pontos (5 → 1).
- Depois de escolher, a página grava e se recarrega (é da página): aparece **"Resposta salva:
  Regular"** e a "Próxima" fica em destaque.
- Resposta escrita (perguntas "D"): campo grande, "Salvando…" / "Resposta salva" ao sair do campo.
- Rodapé com rótulo: **Anterior · Próxima**, e "Voltar à lista" (na última pergunta, "Concluir").
- Resposta que pede plano de ação: o aviso diz para tocar em **Indicar ação** (o botão "Ações")
  antes de seguir — as setas de "alerta" continuam as da página.
- Avaliação fechada: aviso "fechada para respostas", opções só para consulta.

## Arquivos (Workspace Images)

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Avaliacao.css` | o desenho das duas páginas (gerado de `Natcorp_Avaliacao.src.css` por `gerar-app.mjs`) |
| `Natcorp_Avaliacao.js` | o comportamento (gerado por `gerar-avaliacao.py`) |

As DUAS páginas levam as duas URLs (`#WORKSPACE_IMAGES#Natcorp_Avaliacao.js` / `.css`). O script
reconhece a página pelos itens (`P140_COD_AVALIACAO`, `P144_ORDEM_COUNT`), não pelo número do app.

## O contrato: classes nas regiões

Aplicadas por **`aplicar-avaliacao.py`** (pelos nomes; reconhece se é a 140 ou a 144; roda uma
vez só), junto com as duas URLs de arquivo e o comentário de cada página. Aplicado em 29/09 em
`f9118_page_140.sql` e `f9118_page_144.sql` (os originais ficaram em `*.ORIGINAL.sql`):

    python3 aplicar-avaliacao.py f9118_page_140.sql
    python3 aplicar-avaliacao.py f9118_page_144.sql

| Página | Região | Classe |
| --- | --- | --- |
| 140 | Botões | `nc-av-acoes` |
| 140 | Avaliação | `nc-av-dados` |
| 140 | Relatórios | `nc-av-relatorios` |
| 140 | Resultado | `nc-av-resultado` |
| 140 | Questões | `nc-av-questoes` |
| 140 | Plano de Desenvolvimento | `nc-av-plano` |
| 140 | Feedback | `nc-av-feedback` |
| 140 | Comentário | `nc-av-comentario` |
| 140 | Conclusão | `nc-av-conclusao` |
| 144 | &P144_TITULO. ("Pergunta N de M") | `nc-av-pergunta` |
| 144 | Respostas | `nc-av-respostas` |

## O que é da página (não do desenho) — lido das ações dinâmicas em 29/09

- 140: as regiões Feedback, Questões, Plano, Comentário e Conclusão são mostradas/escondidas por
  ação dinâmica conforme a avaliação — as etapas acompanham (observador de estilo). O relatório
  Questões é atualizado quando a janela da pergunta fecha → os cartões são refeitos.
- 144: escolher uma opção grava (PL/SQL) e **submete a página**; a resposta escrita grava no
  `focusout`. `P144_CARACTERISTICA = 'D'` é pergunta escrita. `P144_IND_ACOES_DIVERSAS = 'S'` pede
  plano de ação: `VALIDAR_FECHAMENTO` troca Próxima/Anterior pelas versões "alerta".
- Questões: 100 linhas por página (máximo 500); o script pede todas se houver mais de 100.
- Salvar é o botão CREATE e Deletar o DELETE, os dois "definidos por ação dinâmica"; nenhum JS da
  página depende da posição dos elementos que o desenho muda de lugar (conferido na exportação).
- Regiões que o desenho não toca: Plano de Sucessão, Recurso do Avaliado, Relatório: Avaliação.
- **Regra da folha**: nada põe `display` em regiões, `BTN_NEXT/PREV_*`, `P144_ACAO`, no contêiner
  das opções ou na resposta escrita — o gerador põe `!important` e venceria o `.hide()` do APEX.

## A escala do resumo

A média por competência é desenhada sobre uma escala de 1 a N, onde N é a maior nota que aparece
nas perguntas e **no mínimo 5** (o questionário padrão vai de 1 a 5). Um questionário de 1 a 4
apareceria sobre 5 — se existir, trocar a regra em `desenharQuestoes` (AV.escala).

## Pré-visualização (preview.js)

Com a p140 dentro do iframe da p768, o APEX abre a janela da pergunta na página de CIMA; o
script de pré-visualização não chegava nesse iframe (a primeira pergunta abria sem o desenho).
O preview.js agora também põe o desenho nos iframes que carregam. Em produção isso não existe: a
p144 carrega os arquivos pelas próprias URLs.

## Desligar

Tire as duas URLs de arquivo das páginas 140 e 144.

## Regras da página (auditoria 04/10)

Conferido contra `f9118_page_140.ORIGINAL.sql` (88 ações dinâmicas / 225 ações, 1 validação, 13
processos, 21 botões) e `f9118_page_144.ORIGINAL.sql` (16 / 25 ações, 6 processos, 7 botões).
- Os botões movidos (Salvar, Excluir, impressões, perfil do avaliador) não ganham `display` nosso;
  a barra e o fim seguem o `style` que o APEX dá a eles; BT_REQ1-4 ficam na região "Botões", que só
  sai da vista sem botão à mostra. O avaliador anônimo (IND_OMITE_AVALIADOR) não aparece nos fatos.
- Campos e regiões que as ações mostram/escondem mantêm o `[style*="none"]`; na 144 as opções são
  os rádios originais (a ação "Insere / Deleta Resposta RG" grava e submete), a resposta escrita
  grava no `focusout` da página.
- O desenho monta 60 ms (140) / 30 ms (144) depois do "ready": as ações de abertura síncronas
  (travar, esconder) já rodaram; as de PL/SQL refazem o perfil e os fatos no `ajaxComplete`. Na
  144, se a ação "Reavaliação" (PL/SQL) travar as opções depois disso, só o aviso "fechada para
  respostas" deixa de aparecer — os rádios continuam travados pelo APEX.
- Nada mudou. Sem pendências.
