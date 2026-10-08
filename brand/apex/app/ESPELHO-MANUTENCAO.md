# Espelho de Ponto — `Natcorp_Espelho` (app 9506 FREQ_REL_NATCORP, página 45)

Pedido de 04/10: a página foi feita para o colaborador conferir o espelho de ponto e assinar, sem precisar
gerar o PDF (`espelho_de_ponto.pdf` é o modelo). A estética estava ruim e ela não era intuitiva para o público
do Portal: baixa instrução e uso pelo celular. O desenho segue o propósito em **3 passos**: escolher o
período, conferir e assinar.

Arquivos: `Natcorp_Espelho.src.js` / `.src.css` → `../login/`. JS: `python3 gerar-espelho.py`. CSS: `gerar-app.mjs`
(AVULSAS). Exportação: `python3 aplicar-espelho-pagina45.py f9506_page_45.sql` (aplicado em 04/10; o original está em
`f9506_page_45.ORIGINAL.sql`). Só as duas URLs de arquivo e o comentário mudam.

## O que a página mostra

1. **Escolha o período:** a região ORIGINAL "Parâmetros", com Data Inicial/Final, Tipo Relatório e as opções.
   - O cabeçalho dela dá lugar ao passo 1.
   - "Listar Relatório" vira **"Ver meu espelho"** (o mesmo botão, com as ações dele: validação, cálculo dos totais e atualização
     dos relatórios).
   - "Gerar Relatório" vira **"Baixar em PDF"**.
2. **Confira o seu ponto:**
   - **Período por extenso.**
   - **Resumo em números grandes:** Horas previstas e Banco de horas antes, no período, agora e remanescente. São os campos
     que a página calcula (P45_HORAS_PREVISTAS, P45_SALDO_BH_*, P45_SALDO_ATUAL).
   - **"Resumo do período":** os eventos do relatório `regiaoevento`.
   - **Filtros:** Todos · Com ocorrência · Sem marcação.
   - **Os dias, por mês.** Cada dia tem:
     - a data e o dia da semana;
     - as batidas como horários (o texto "06:30 12:30 ------- -------" é separado; os "-------" são posições vazias);
     - "Descanso semanal remunerado" com uma lua;
     - "Sem marcação" em laranja quando havia horas previstas;
     - "Previsto 06:00 · Trabalhou 07:00";
     - as **ocorrências** como etiquetas (`OCORR` no JS): laranja = tira horas (Atraso/saída antes, Falta, A menos, Banco −);
       verde = soma (A mais, Banco +); neutro = DSR, atraso compensado e entrada/saída acima de 1h;
     - a justificativa.
   - **Todas as linhas de uma vez:** o relatório vem de 50 em 50. O desenho pede 1000 por página (`_search`) e tenta de novo
     até 3 vezes, porque o pedido feito enquanto o espelho ainda monta se perde.
3. **Assine:** a região ORIGINAL do termo (texto, aceite P45_OPCAO e botão Assinar) muda de lugar para cá. Quem
   mostra e esconde continua sendo a página (CONTROLE_ASSINATURA etc.). As assinaturas feitas (`regiaoassinatura`)
   viram "Assinado em …". O passo só aparece quando há termo para assinar ou assinatura feita.

- **"Montando o seu espelho…"** (04/10), enquanto o relatório monta (~1 min):
  - um relógio com os ponteiros girando;
  - uma barra que anda;
  - o espelho em esqueleto (6 dias com brilho passando);
  - uma frase que troca a cada 6 s (`T.frases`);
  - o tempo que já passou.
  Começa no clique em "Ver meu espelho" e termina no `apexafterrefresh` do `regiaolist`. Se a validação recusar
  (P45_MENSAGEM2), o carregamento para. Depois que os primeiros 50 dias chegam, "Trazendo os outros dias do período…"
  aparece no alto da lista. Quem pediu menos movimento no aparelho vê tudo parado. "Ver meu espelho" sempre volta
  ao modo espelho, mesmo que a pessoa tenha escolhido a tabela.
- **"Ver como tabela":** devolve as regiões originais (Espelho, Totais, Eventos, Horas Previstas, Assinatura).
- **Cartão do colaborador:** é a peça global `Natcorp_Colab`. O app 9506 não carrega o Natcorp_Temas (que traz as peças globais),
  então o Natcorp_Espelho a carrega da mesma pasta. O Colab passou a aceitar `_COD_EMPRESA_1` e `_SITUACAO_1`.

## Observações

- **Dados da base de teste:** "H Trab" vem 00:00 em quase todos os dias, mesmo com batidas. É o que o relatório devolve.
- **Tipo Relatório:** no teste, com "A - Espelho Abonado" o relatório veio vazio; com "N - Espelho Detalhado" veio. A consulta da
  região não usa o tipo. Vale o programador conferir.
- **Assinar:** NUNCA testar clicando (grava `pe_espelho_ponto_assinado`).
