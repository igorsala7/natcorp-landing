# Contrato de Gestão — `Natcorp_Contrato` (app 300, páginas 106 e 109)

Pedido de 04/10: na 106 o colaborador vê o resultado das metas que o gestor avaliou. Tocando numa meta,
abre a 109, onde a meta é respondida ou conferida. O público tem baixa instrução e ~70% usa o celular,
então tudo é muito didático.

Arquivos: `Natcorp_Contrato.src.js` / `.src.css` → `../login/Natcorp_Contrato.js` / `.css`.
JS: `python3 gerar-contrato.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-contrato-app300.py f300.sql` (o `montar-f300.sh` já chama).

## 106 · "Suas metas"

- **Topo:**
  - "Suas metas" e o período por extenso, tirado de `P106_CICLO`;
  - a etiqueta da dimensão;
  - a nota final (`P106_RESULTADO_FINAL`), ou "A nota final ainda não saiu";
  - o aviso de cancelado.
- **Botões ORIGINAIS** movidos para o topo, com uma frase do que fazem: Concluir, Revisar, Adicionar Meta (que estava na
  barra do relatório) e Gerar Relatório ("Baixar em PDF"). A página continua mostrando e escondendo cada um
  pelas ações dinâmicas. O desenho segue o `display: none` delas (`:has(> .t-Button[style*="none"])`).
- **Pessoas:** Colaborador e Quem avalia, cada um com a foto, o nome, o cargo ou área e o botão Visualizar original.
  A foto é a imagem ORIGINAL movida, não um pedido novo. As regiões Contrato, Avaliador e Colaborador saem da vista.
- **Como a nota é dividida:** uma barra com o pedaço de cada meta, do tamanho do peso. As metas usam o roxo do tema em
  intensidades, e o número de cada meta repete a cor do cartão. Embaixo, "As metas somam 100%" ou o aviso
  do que falta.
- **Cartão por meta**, lido do relatório pelo TÍTULO das colunas (`COLS`):
  - o nome e a categoria;
  - "Vale N% da nota";
  - "O que fazer", só quando a Ação é diferente do nome;
  - Meta combinada × Alcançado (ou "Ainda sem resultado"), com números em formato brasileiro (5.000);
  - "Cumpriu X% da meta" e a barra, só quando há % atingido.
  Tocar no cartão abre o lápis da linha.
- **"Ver como tabela":** devolve o relatório.

## 109 · a meta

- **Topo:**
  - "Meta 1 de 5" e a régua, lidos de `P109_ROWID_COUNT`;
  - o nome (o texto da lista Objetivo);
  - a categoria e "Vale N% da nota".
  O título da janela vira "Sua meta", "Editar meta" ou "Nova meta".
- **Só leitura** (`P109_BTN_SAVE` e `P109_BTN_CREATE` diferentes de 'S'): os campos saem da vista e a meta vira texto. Aparecem "O que fazer"
  (se for diferente do nome), Meta combinada × Alcançado e Cumpriu.
- **Editando:** os MESMOS campos, rótulo em cima, em duas partes ("A meta" e "O resultado"), cada um com uma frase de ajuda
  (`T.dicas`). Alguns rótulos ficam no dia a dia (`T.rotulos`). Quando o Tipo é Percentual, aparece "%" ao lado de Meta e Alcançado.
  Habilitar e desabilitar continua com as ações dinâmicas.
- **Botões de baixo, com texto:** Meta anterior | Próxima meta, Salvar (largura toda), Feedback | Voltar e Apagar meta.
  CUIDADO: o `display` dos botões só vale sem `display: none` no style. Foi assim que eu mostrei Salvar e
  Deletar escondidos pela página (corrigido em 04/10).

## Conferido em 04/10 (Playwright, sessão real; contrato 2024 do Tony)

- **106:** desktop e celular.
- **109:** só leitura no celular e no desktop. O modo de edição foi simulado SÓ na tela, sem enviar nada: Salvar visível e
  Alcançado habilitado.
- O contrato de teste está concluído (status C), então o modo de edição real não foi visto com dados do servidor.
  Conferir na primeira avaliação aberta.
