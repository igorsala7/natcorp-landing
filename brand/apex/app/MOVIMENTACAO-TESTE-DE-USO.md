# Alteração Funcional (200:116) — teste de uso acompanhado (30/09/2026, 23:08–23:20)

Pedido novo para um colaborador (Transferência + cargo + salário + benefícios), envio recusado; depois
edição de um pedido gravado (56517), salvar recusado três vezes. Acompanhado ao vivo: cada toque, o
console e a rede. Nada foi gravado.

## Do desenho (Natcorp_Movimentacao / Natcorp_Beneficios) — corrigir

| # | O que aconteceu | Correção |
|---|---|---|
| 1 | Ao escolher o colaborador, a ação dinâmica do APEX marca TODAS as caixas P116_BLK_* (pedido novo): 12 blocos abertos, as 6 intenções aparecem marcadas sem escolha, o bloco Empresa fica vazio e o envio falha ("é preciso informar a empresa proposta") | No pedido novo, começar com tudo desmarcado; só abre o que a pessoa escolher no passo 2 |
| 2 | Marcar/desmarcar uma caixa (ou tocar numa intenção) apaga o que estava preenchido no bloco — 6 blocos preenchidos voltaram a "Falta" | Antes de desmarcar um bloco com dados: confirmar ("Isso apaga o que você preencheu em Filial") |
| 3 | A fila briga com o toque: tocar em Empresa (3×) não abriu; Filial/Atividade abriram e fecharam | Abrir sozinho só o 1º bloco de uma intenção recém-tocada; nunca contra um toque da pessoa |
| 4 | Valor do benefício: Adicionar com o campo vazio (4×), fora da faixa (2×), valor fixo não mostrado (Gympass "deve ser 117") — sempre caixa de OK | Mostrar a faixa ("De R$ 39 a R$ 60") e o valor fixo; começar no mínimo; Adicionar só com valor válido; aviso no campo |
| 5 | A régua mandou 751,40399 → "acima do saldo de 751,4" | Arredondar a centavos; parar no saldo arredondado para baixo |
| 6 | Cada toque no +/− chama o servidor (33 chamadas em 4 s) | Mudar o número na hora; mandar ao servidor quando a pessoa parar |
| 7 | Sobra de R$ 0,40 / R$ 340 recusada no envio ("saldo para ser distribuído") | Na barra do pé: "Falta distribuir R$ 0,40" |
| 8 | Benefício obrigatório só cobrado no envio, num parágrafo enorme | Em "Adicionar um benefício": "Obrigatório: escolha um entre …" |
| 9 | "Usar esta data nos blocos abertos" pôs data na 2ª situação ("fora do limite") | Pular "2ª …" e blocos sem mudança |
| 10 | Data 3 meses à frente: "não pode ser maior que a data atual + 45 dias" (só no envio) | Calendário com máximo hoje + 45; aviso ao lado da data |
| 11 | Erros do envio aparecem no topo; a pessoa estava em Benefícios | Erros na barra do pé, cada um levando ao campo; abrir o bloco do erro |
| 12 | "Falta: Motivo da mudança" antes de existir colaborador; "Outro Colaborador" sem colaborador | Só depois de escolher o colaborador |
| 13 | Frase da barra ilegível com 10+ mudanças | "Tony · 10 mudanças" + as 2 primeiras |
| 14 | "Remover Benefício Complementar do pacote" | Nome do benefício ("Remover Reembolso combustível") |
| 15 | Pedido antigo (2022) editado: "Data menor que a Referência da Folha" | Avisar ao abrir: a data do pedido já passou da folha |

## Do APEX (para o time)

- **Lentidão**: cada ação dispara 50–150 chamadas (escolher colaborador ~60, centro de custo 121 em 5,5 s,
  marcar blocos 141–148), picos de 3,4 s / 8,1 s / 8,2 s (abrir o pedido gravado: 53 chamadas, uma de 8,2 s);
  13 canceladas numa só rajada. `get_lov_display` levou 1,1–1,7 s cada (11 seguidas).
- **Erros no log do servidor** (Level = ERROR) a cada Salvar/envio: View Identifier 14917891, 14917919,
  14917925, 14917927 — ver em Monitorar Atividade › depuração.
- **Regras só no envio**: Transporte × Combustível; benefício obrigatório; saldo inteiro distribuído.
- **Cancelar um pedido exige acertar os benefícios** (Situação → Cancelada + Salvar recusado pelas
  validações de benefícios): a validação não deveria valer para cancelar.
- **Anexo**: no navegador controlado pelo teste a janela de arquivo é interceptada (não é defeito da página).

## O que funcionou

- "Continuar: <próximo bloco>" foi usado bloco a bloco do começo ao fim.
- O par valor ↔ % (salário e remuneração variável) nos dois sentidos.
- O quadro Antes | Depois acompanhou cada mudança na hora, no pedido novo e no gravado.
- Os começos de frase do motivo ("Cobrir uma vaga").
