# Empregos Anteriores — portal Conhecendo Você (app 600, página 17) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Uma lista (MediaList) dos empregos do colaborador ou do candidato; cada cartão abre a janela
"Editar: Empregos Anteriores" (p18) e o "Adicionar" abre a mesma janela vazia. Fechar a
janela envia a página (apexafterclosedialog → SUBMIT_PAGE). Para quem só consulta, o "ready"
esconde o Adicionar. O desenho não muda valor e não grava.

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Empregos.css` | o desenho (gerado de `Natcorp_Empregos.src.css` por `gerar-app.mjs`) |
| `Natcorp_Empregos.js` | o comportamento (gerado por `gerar-empregos.py`) |

Página 17 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Empregos.js`;
CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Empregos.css` (à mão — não veio exportação).
A página não tem itens de formulário: o .js acha a lista pela região de id estático
`EMPREGOS_ANTERIORES` (o mesmo id está no título grande — vale o que é `.t-Region`).

## O que muda

- **O alto**: "Onde você já trabalhou", o que colocar e "Se ainda não trabalhou, é só tocar em
  Continuar"; com empregos, "Ao todo: 10 meses de trabalho em 1 emprego" (soma das durações).
- **Linha do tempo**, do mais recente para o mais antigo (só reordena os cartões): empresa
  (MAIÚSCULAS viram "Organizações Acme"), cargo em roxo, "abr/2023 até fev/2024" com a
  duração ("10 meses", "1 ano e 3 meses"), salário "por mês" (Mensal/Horista/Semanal…), cidade
  ("São Paulo/SP") e "Editar". Sem data de término: selo "Emprego atual", ponto rosa, "até hoje".
  O cartão lê a descrição da página ("Data de Início: …", "Data de Término: …", "Salário: …
  - Mensal", "Local: …"); linha com outro rótulo aparece como veio.
- **"Adicionar emprego"**: o botão da página no fim, grande, tracejado (some a vaga, nunca o
  botão, quando a página o esconde).
- **Vazio**: "Nenhum emprego por enquanto. Toque em “Adicionar emprego”…".
- "Prosseguir" vira **Continuar**.

## O que é da página

- Há oito ações "change" de itens que não existem aqui (`P17_SALARIO_ANT1..3`,
  `P17_DATA_ADM_EMP1..3`, `P17_DATA_DESL_EMP1..3`): sobra de uma versão antiga da página.

## Desligar

Tire as duas URLs de arquivo da página.

## Regras da página (auditoria 04/10)

Conferido contra `f600.ORIGINAL.sql` (página 17): 13 ações dinâmicas (as máscaras de salário e
datas são de itens que não existem mais; "Report/Adicionar - Close Dialog" submetem a página;
"Permite Alterar = 'N'" ESCONDE o botão ADICIONAR na abertura), nenhuma validação, 3 processos
(Pintar Campos, PAGE BRANCH FORWARD/BACK), 7 botões, região da lista com condição de servidor
(`permissao_pess.empregos_ant`).

- O botão Adicionar é o MESMO do APEX (só muda de lugar/rótulo): a ação de fechar a janela e o
  esconder da página continuam valendo pelo id.
- **Mudou (04/10)**: a regra `.nc-em-add .t-Button.nc-em-add-bt` (display: inline-flex, que vira
  !important) ganhou `:not([style*="none"])` — antes ela venceria o esconder da página se o JS não
  escondesse a vaga junto. Agora o esconder vale por si.
- Nada pendente.
