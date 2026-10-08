# Normas e Procedimentos — `Natcorp_Normas` (app 300, páginas 56 e 57)

Pedido de 04/10: "a página onde o colaborador consulta as normas e procedimentos precisa de uma
visualização diferente, que faça mais sentido para o propósito de consultar as normas". O público tem
baixa instrução e ~70% usa o celular. O propósito é **achar uma regra e ler com calma**. Por isso a 56
saiu do motor de consultas (`Natcorp_Consulta`) e ganhou desenho próprio.

Arquivos: `Natcorp_Normas.src.js` / `.src.css` → `../login/Natcorp_Normas.js` / `.css`.
JS: `python3 gerar-normas.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-normas-app300.py f300.sql` (o `montar-f300.sh` já chama).

## 56 · o índice

- **Topo:** "Normas da empresa", uma frase do que fazer, a busca grande e "14 normas · Você já leu 2 de 14".
- **Busca:** acha na hora, sem acento e sem maiúscula, por todas as palavras digitadas.
- **Grupos:** saem do título "Assunto - Norma" (o primeiro hífen).
  - Um grupo cujo nome é o começo de outro entra no maior.
  - Título sem hífen vai para "Outros assuntos", sempre no fim.
  - Com um grupo só, os títulos de grupo não aparecem.
- **Nomes:** abreviações por extenso (`ABREV`: Pgto → Pagamento, Transf. → Transferência, Rh → RH). As palavras
  que o cadastro gravou sem acento ganham acento (`ACENTOS`: Ferias → Férias, Predio → Prédio…). O resto fica como veio.
- **Desenho por assunto:** a primeira regra de `DESENHOS` que achar a palavra no título. Sem regra, sai um livro.
- **"Já leu":** fica no aparelho (`localStorage` `nc-nm-lidas`), marcado quando a 57 abre com texto.
- **Tocar:** abre o link ORIGINAL da linha, a janela da 57. O nome da norma vai junto por
  `sessionStorage` (`nc-nm-abrindo`), porque a 57 só recebe o código.
- **"Ver como tabela":** devolve o relatório original.

## 57 · a leitura

- **Topo:** nome da norma (o da lista, ou o "ASSUNTO:" do texto), o grupo e "Leitura de cerca de N minutos"
  (130 palavras por minuto).
- **Ouvir:** a voz do próprio celular (`speechSynthesis`, pt-BR), em pedaços curtos. Ela para em "Parar", em
  "Entendi" e ao fechar a janela.
- **Letra maior:** 17 → 19 → 21 px e volta. Fica guardada no aparelho (`nc-nm-tamanho`).
- **O texto é lido do jeito que foi cadastrado (`partesDoTexto`):**

  | No cadastro | Na tela |
  |---|---|
  | `ASSUNTO: X` | some (o nome já está no topo) |
  | `1. OBJETIVO` | título com o número |
  | linha curta toda em maiúsculas | título sem número |
  | `2.1 …` ou `1 - …` | item com o número ao lado |
  | o resto | parágrafos |

  O "¿" que o banco grava no lugar de travessão ou apóstrofo vira "–" ou "'". Com 3 ou mais títulos, aparecem
  os atalhos "Ir para".
- **Entendi:** fecha a janela (`apex.navigation.dialog.cancel`). Na 56, o "Já leu" é atualizado.

Nada é gravado no sistema.

## Conferido em 04/10 (Playwright, sessão real)

- **56:** 14 normas em 2 grupos, no desktop e no celular. A busca "ferias" acha 2. A busca "xyz" mostra o aviso.
  "Já leu" conta depois de fechar a janela.
- **57:** testada nos dois formatos de texto (Treinamento: numerado com 4 atalhos; Táxi: título em
  maiúsculas e itens "1 -"). Conferidos "Letra maior" e "Entendi".
