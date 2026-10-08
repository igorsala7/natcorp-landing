# Consulta de Documentos (app 2210 CONS_GED_NATCORP, página 865) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Abre em janela a partir da ficha do colaborador (app 200, página 17, botão "Documentos") e de
outras telas. Público: o RH, que confere a pasta de cada pessoa.

O desenho é uma **pasta**:

1. **O alto** — quantos documentos (e arquivos, quando há versões), o **último envio** e há quanto
   tempo; a busca (atalho `/`), **Por assunto / Mais recentes** e o **Adicionar documento** (o
   próprio botão do APEX, trazido para cá — o onclick é o mesmo).
2. **As abas** — uma por assunto presente, com a contagem: Identificação, Saúde, Formação e
   cursos, Segurança do trabalho, Endereço e banco, Contrato e vida funcional, Outros documentos,
   Dependentes. O assunto sai do NOME do documento (lista `ASSUNTOS` no .js) e do tipo de
   sub-item: Acidente de Trabalho e EPI → Segurança; Atestados Médicos → Saúde; Dependente →
   Dependentes, por pessoa. **Tipo novo no cadastro não quebra nada**: sem palavra conhecida, vai
   para "Outros documentos" com o ícone genérico.
3. **Um cartão por documento** — o mesmo tipo, do mesmo dono, com várias Sequências vira UM
   cartão ("2 arquivos"), com as versões dentro; o mais novo na frente. "Ver" e o lápis CLICAM no
   link original da linha (Visualizar → GLOBAL_APP_NATCORP:2; Editar → 2210:860).
4. **Mais recentes** — os mesmos cartões por mês de atualização (o que chegou por último).
5. **Ver tabela completa** — o relatório interativo original, com filtros e download.

O relatório vem de 50 em 50; havendo próxima página, o script pede todas (o mesmo que "Linhas por
página" no menu Ações — fica salvo na sessão do relatório, como se o usuário tivesse escolhido).

## Arquivos (Workspace Images)

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Documentos.css` | o desenho (gerado de `Natcorp_Documentos.src.css` por `gerar-app.mjs`) |
| `Natcorp_Documentos.js` | o comportamento (gerado por `gerar-documentos.py`) |

As URLs (`#WORKSPACE_IMAGES#Natcorp_Documentos.js` / `.css`) e o comentário da página também
são postos pelo `aplicar-documentos-pagina865.py`.

O app 2210 é outro aplicativo, mas do mesmo workspace: as imagens são as mesmas, e ele já carrega
o `Natcorp_Style_Min.css` (de onde vêm a ficha do colaborador e os ícones `--nc-ic-*`).

## O contrato: classe nas regiões

Aplicada por `aplicar-documentos-pagina865.py` (pelos nomes; roda uma vez só):

| Região | Classe |
| --- | --- |
| Documentos Colaborador | `nc-ged-docs` |
| Documentos Candidato | `nc-ged-docs` |
| Documentos Terceiro | `nc-ged-docs` |
| Documentos Outros | `nc-ged-docs` |

O APEX mostra só a região do `P865_TIPO` (o processo de carga escolhe pelo item preenchido:
MAT → Colaborador, CAND → Candidato, TERCEIRO, OUTROS); as quatro filtram UMA pessoa, então a
pasta vale para todas. Sem a classe, o script usa o relatório interativo da página.

## O que é da página (não do desenho) — conferido na exportação de 29/09

- "Ver" e "Editar" são achados pelo DESTINO do link na linha (a 860 é o upload), não pela
  coluna: o relatório tem duas colunas "Visualizar" e o usuário pode esconder qualquer uma.
- As ações "… Dialog Closed" (refresh do relatório depois do upload) escutam a REGIÃO; o
  Adicionar muda de lugar mas continua dentro dela.
- O "Documento" é `tipo - descrição (data do arquivo)`: o cartão mostra o tipo em cima, a
  descrição como título e a data como "Data do documento".
- Tipos que o usuário não tem permissão de ver (`f_permissao_docs`) nem chegam à tela.
- O botão da ficha (app 200, p17) abre `CONS_GED_&P_BASE.:865`: o número do app muda de base para
  base; o script reconhece a página pelo alias também.

## Desligar

Tire as duas URLs de arquivo da página 865.

## Regras da página (auditoria 04/10)

**Conferido** contra `f2210_page_865.ORIGINAL.sql`: 9 ações dinâmicas (13 ações), nenhuma
validação, 1 processo, 12 botões, as 4 regiões por `P865_TIPO` (condição de servidor). O
Adicionar é o botão da página (mesmo onclick; as ações "… Dialog Closed" escutam a região, onde
ele continua); "Ver"/"Editar" clicam no link original da linha; nada é gravado nem escondido além
do relatório (a um clique em "Ver tabela completa"). **Sem problemas.**

**Observação:** pedir todas as linhas grava "Linhas por página" na sessão do relatório do usuário
(efeito colateral já descrito acima).

## A mesma pasta no Portal do Colaborador (app 300, página 863) — 04/10

A página 863 do app 300 ("Gerenciamento Eletrônico de Documento (GED)") é uma cópia da 865 do app 2210.
Ela tem as regiões Documentos Colaborador e Documentos Candidato, sem Terceiro e Outros, e os mesmos links:
o lápis vai para a 860 (upload) e "Visualizar" abre a janela. Recebe o MESMO desenho, com os mesmos arquivos
`Natcorp_Documentos.js/.css`.

- **Aplicação:** `aplicar-redesenhos-app300.py`, par (863 → 2210:865). A página é renomeada só no arquivo temporário, e o
  `aplicar-documentos-pagina865.py` aceita a falta de Terceiro/Outros pelo `NC_REGIOES_OPCIONAIS`. O
  `montar-f300.sh` já faz tudo.
- **Motor de consultas:** a 863 saiu do `Natcorp_Consulta`. Ela não está mais na lista do `aplicar-consultas-app300.py`, e
  a receita P863_ foi apagada.
- **Celular:** o cabeçalho flutuante do relatório (`.nc-sticky-header-clone`, arquivo da equipe) aparecia no alto
  da tela por cima da pasta. Agora fica escondido enquanto a pasta está aberta (regra no [C2] do CSS).
- **Conferido no Playwright, sessão real (Tony):** 10 documentos e 13 arquivos; abas Identificação, Saúde, Formação e cursos e
  Dependentes; versões ("2 arquivos"); dependentes por pessoa. Testado no desktop e no celular.
