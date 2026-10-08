# Feedback: Colaborador — app 9118, página 150

Onde o colaborador lê os feedbacks que recebeu dos líderes. Abre no Portal do Colaborador (casca
300:180, moldura com `P_PAINEL = PC`). Fora do Portal (painel do gestor) a mesma página mostra o filtro,
o botão "Feedback" e o "Editar". Público do Portal: muitos com pouca leitura, 80% no celular (04/10).

Arquivos: `Natcorp_Feedback.src.js` / `.src.css` → `../login/Natcorp_Feedback.js` / `.css`.
JS: `python3 gerar-feedback.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-feedback-pagina150.py f9118_page_150.sql` (aplicada em 04/10; original em
`f9118_page_150.ORIGINAL.sql`). Só as File URLs e o comentário da página.

## Como ficou

| Onde | O quê |
|---|---|
| O alto | "Feedbacks" + "Aqui ficam os retornos que seus líderes deram sobre o seu trabalho." (no gestor: "Os feedbacks que você recebeu e os que você deu."). No celular, ícone e título na mesma linha |
| Resumo | "N feedbacks" (o total da paginação) e a **média das estrelas** — só quando todos estão na tela e há 2 ou mais com nota |
| Por ano | Os feedbacks agrupados por ano (o mais novo primeiro), com o ano como divisória |
| Cartão | Iniciais de quem deu (cor fixa por nome), "De <nome>" sem caixa alta, data por extenso ("23 de janeiro de 2026", "Hoje", "Ontem"), "Novo" nos últimos 30 dias, título grande, texto com as quebras de linha, estrelas grandes com "N de 5" (nota 0 = sem estrelas), "Ouvir" |
| Gestor | Filtro em três botões (os textos da lista original: Todos / Meus Feedbacks / Feedbacks Criados por Mim), "Para: <quem recebeu>", e "Editar" nos que a pessoa escreveu (o link original da coluna ACTIONS) |
| Vazio | "Você ainda não recebeu feedback — Quando seu líder registrar um feedback para você, ele aparece aqui." (gestor: "Nenhum feedback encontrado") |
| Paginação | A original (15 por página), com links grandes; com uma página só, o "linha(s) 1 - 8 de 8" sai |

## Regras da página (conferidas)

- A consulta decide o que aparece (público, `colab_visualiza`, painel, filtro): o desenho só lê.
- O filtro escreve na lista original (`setValue`), que envia a página como antes.
- O botão "Feedback" (novo) e as ações "Add Feedback" (recarregam a lista ao fechar a janela) são os
  originais; a lista se redesenha no `apexafterrefresh`.
- A ação "Feedback" (mostra/esconde a lista por `P150_FEEDBACK`, item que não existe na página) não é
  forçada: o desenho fica dentro da região.

## Cuidados

- **Defeito da consulta (não corrigido):** em `USER_NAME`, o cargo embaixo do "Autor" é
  `fnct_nome_cargo(i.cargo)` — o cargo de quem RECEBEU, não de quem escreveu. O cartão não mostra
  esse cargo. Para mostrar o do autor: usar `ix.cargo` na consulta.
- Lê o modelo Comments: `.t-Comments-info` ("Autor: …", `.t-Comments-date`, `.t-Comments-actions a`),
  `.t-Comments-comment` (`<b>` = título; o que vem antes = quem recebeu; `input[name=PONTUACAO]` = nota),
  `.t-Comments-userIcon.backgroundColorPink` = escrito pela própria pessoa. Mudou a consulta → conferir.
- Testado em 04/10 no Portal (celular 390 px e computador) com os 8 feedbacks reais, pela casca 300:180
  numa aba de teste da mesma sessão. O modo gestor (filtro, Para, Editar) não foi visto na tela.
