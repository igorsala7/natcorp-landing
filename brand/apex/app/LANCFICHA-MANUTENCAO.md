# Lançamentos de Ocorrências — página 7 do app 9132 (a janela onde se lança)

Pedido (09/10/2026, /impeccable): é aqui que o GESTOR da área lança os eventos de folha e os valores dos
colaboradores dele. Ele não é do RH, conhece pouco o assunto e muitas vezes tem pouca instrução. A grade de
17 colunas ("DT. INÍCIO VALIDADE", "Nº PARCELA ORIG.", "FAIXA"…) não servia para ele.

## Como ficou
- **No alto:** o processo (Folha e rescisão, Férias…), a empresa e o mês da pesquisa, os **3 passos** e a chave
  **Ficha | Tabela**.
  - Os passos são Preencha → Salve → Processe.
  - O passo 1 só fica feito quando o lançamento aberto tem as 4 respostas.
- **À esquerda:** os lançamentos em **cartões**.
  - Cada cartão mostra o evento, quanto (10 h 30 min / R$ 150,00), para quem e o mês.
  - A situação aparece em cor: Salvo, Falta salvar, Precisa corrigir ou Em branco.
  - O botão "Novo lançamento" fica no topo da lista.
- **À direita:** a **ficha**, que é a "vista de um registro" da própria grade. As perguntas são:
  - **Para quem?** Empresa, e depois dois cartões: "Escolher colaboradores" (abre a lista de matrículas) ou
    "Todos da pesquisa".
    - A matrícula vazia sempre quis dizer TODOS. O cartão deixa isso escrito.
    - Se ninguém foi escolhido, o Salvar pergunta antes de gravar.
  - **O que você vai lançar?** O evento, e a Família só em Pagamentos diversos (coluna da página).
  - **Quanto?** Escolhido o evento, cada campo ganha um selo:
    - **Preencha**: o evento exige o campo;
    - **Este evento aceita**;
    - **Não se usa neste evento** (o campo fica apagado);
    - **Apague: este evento não usa**;
    - **Não precisa: já tem horas** (ou: já tem valor).
    - Os selos seguem os indicadores IND_UNID1/IND_UNID2/IND_VALOR/IND_FAIXA, que a ação "Atribui
      Indicadores" já trazia. São as mesmas regras das validações "Valida Valor / Hora Qtd. / Min. Dia / Faixa".
  - **Em qual folha entra?** Mês da folha e data de retenção. A dica diz qual mês foi escolhido na pesquisa.
  - **Vale por mais de um mês?** Validade e parcelas. Começa recolhida, com o resumo "Vale de … a …"; as
    datas são as que a página preenche.
  - **Dias da falta.** Também começa recolhida.
  - **Quer deixar um recado?**
  - Uma pergunta recolhida abre sozinha se tiver erro dentro.
- **"Como vai ficar"**, ao lado da ficha: o lançamento lido numa frase ("Lançar 10 h 30 min de Horas
  extras 50% para todos os colaboradores da pesquisa, na folha de maio de 2026.") e a lista do que falta.
- **Pé da ficha:** Salvar · Salvar e lançar outro · Descartar (ou Desfazer) · Excluir.
  - Um lançamento por vez: trocar de lançamento com algo por salvar pede para salvar ou descartar.
- **Pé da janela** (os botões da própria página):
  - "Sair sem processar" é o antigo Cancelar, que APAGA os lançamentos. Agora confirma antes quando há algo.
  - As caixas viraram "Incluir desligados / transferidos", com explicação.
  - Uma frase diz por que o "Processar lançamentos" está desligado ("Salve o lançamento aberto…").
- **Processando:** aviso de espera ("Não feche esta janela").
- **Com erro no processamento:** o LOG vira "Alguns lançamentos não foram feitos", com explicação e o
  motivo quebrando linha.
- **Tabela:** a grade original, em edição, para quem prefere digitar em linhas.
  - A janela SEMPRE abre na Ficha. A 1ª versão guardava a escolha no navegador e abria direto na Tabela.
  - Ao voltar para a região, a grade precisa de `interactiveGrid('resize')`. Sem isso, ela ficava com a
    largura da ficha e cortava as colunas depois de "Ocorrência" (09/10). O `grid('resize')` da vista
    não basta.
- **Celular:** a lista ocupa a tela; a ficha abre por cima, com "voltar".

## O que NÃO mudou
Tudo o que é regra continua igual: a grade, as 13 validações, as 25 ações dinâmicas, os processos, o
Processar (confirmação → envio → processamento ao voltar) e o LOG.
- O Salvar da ficha é o "save" da grade.
- O Processar é o botão da página.
- A exportação só ganhou os File URLs.

## Cuidados (o que mordeu na montagem, 09/10)
- **`data-owning-region`.** O JS tira o grid (`.a-IG`) de dentro da região IGOCORR e o põe na ficha. O
  APEX acha a região de um campo subindo pelo HTML.
  - Sem a região, as listas das colunas que dependem da Empresa (Evento, Mês, Colaboradores, Família)
    iam ao servidor sem o contexto da linha. A resposta era "Ocorreu um erro ao tentar processar as
    informações".
  - O atributo `data-owning-region="IGOCORR"` no grid resolve: o `apex.region.findClosest` lê esse
    atributo antes de subir pelo HTML.
  - A mesma correção foi para a grade padrão (Natcorp_Grade).
- **Excluir uma linha nova.** Depois de `deleteRecords`, o APEX limpa o `inserted` dos metadados: guardar
  antes.
- **Linha nova logo depois de fechar a vista.** Às vezes a grade ainda não aceita a linha nova: o JS
  tenta de novo, até 5 vezes.
- **A vista refaz os campos.** A cada registro a vista reescreve as classes dos campos. Por isso:
  - ordem, largura, o que aparece e os selos vão numa folha presa ao ID de cada campo (`#nc-lf-folha`);
  - e em atributos da ficha (`data-q-*`, `data-quem`, `is-fecha-*`).
- **Janelas na casca.** A confirmação (`apex.message.confirm`) e a lista (popup LOV) abrem na casca, a
  janela de fora.
- **Sem ordem de itens a acertar** (a lição da 9132:5). O JS não move nem apaga item de página.
- **A grade padrão fica de fora** desta página: é página com desenho próprio, e a região ganha `nc-grade-nao`.

## Arquivos
| O quê | Fonte | Gera |
|---|---|---|
| Lista, ficha, resumo, pé | `Natcorp_LancFicha.src.js` | `python3 gerar-lancficha.py` → `../login/Natcorp_LancFicha.js` |
| A roupa | `Natcorp_LancFicha.src.css` | `node gerar-app.mjs` → `../login/Natcorp_LancFicha.css` (avulsa) |
| A página | `f9132_page_7.ORIGINAL.sql` | `python3 aplicar-lancficha-pagina7.py f9132_page_7.ORIGINAL.sql f9132_page_7.sql` |

Os nomes, as dicas e as perguntas da ficha ficam na lista FICHA ([L1]); os textos dos passos em [L5].

## Teste (09/10, na prévia, sem gravar)
- **Testado:**
  - preencher (Todos, Horas extras 50%, maio, 10 h 30 min);
  - escolher um colaborador;
  - selos do Quanto;
  - "Como vai ficar";
  - Ficha ↔ Tabela;
  - Descartar com confirmação;
  - Salvar em branco (aviso);
  - celular (400 px);
  - o LOG (simulado só na tela).
- **Não testado:**
  - Salvar de verdade;
  - Processar;
  - o LOG com erro real.

Testar SEMPRE pela moldura 200:767 (9132:5 → Inserir Lançamentos).
