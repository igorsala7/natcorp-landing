# Cursos e Formações — portal Conhecendo Você (app 600, página 5) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Quem usa: o próprio colaborador ou candidato, 9 em cada 10 pelo celular, muitos com pouca
leitura. Quatro listas (MediaList) — Instrução/Formação, Cursos e Certificações, Idiomas,
Habilidades — cada uma com um "Adicionar" que abre uma janela (p6, p8, p12, p10) e um "Mais
Informações" (…_OBS). Fechar a janela envia a página (apexafterclosedialog → SUBMIT_PAGE).
O desenho não muda valor e não grava.

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Formacao.css` | o desenho (gerado de `Natcorp_Formacao.src.css` por `gerar-app.mjs`) |
| `Natcorp_Formacao.js` | o comportamento (gerado por `gerar-formacao.py`) |

Página 5 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Formacao.js`;
CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Formacao.css` (à mão — não veio exportação).
Sem classe no APEX e sem teste de app/página: reconhece a página pelos quatro "Mais
Informações" (`…_FORMACAO_ESCOLAR_OBS`, `…_CURSO_OBS`, `…_IDIOMA_OBS`, `…_HABILIDADE_OBS`).

## O que muda

- **O alto**: "O que você estudou e o que sabe fazer", "Não precisa ter tudo", e os quatro
  assuntos com quantos itens cada um tem ("4 itens", "nada ainda") — o toque rola até ele.
- **Nomes e dicas**: Escola e faculdade · Cursos · Idiomas · O que você faz bem, cada um com
  exemplos ("informática, segurança, atendimento…").
- **Cada item vira um cartão**: nome, nível em roxo (MBA, 40 horas, Intermediário), os
  detalhes com rótulos de todo dia (Entidade → "Onde estudou", Local → "Onde fez", Data de
  Conclusão → "Terminou em"), a situação (Concluído verde, Não Concluído amarelo) e "Editar".
  O cartão inteiro continua sendo o link da página (abre a janela de editar). Idioma ganha o
  nível em quatro pontos (Básico · Intermediário · Avançado · Fluente).
- **"Adicionar …"**: o botão da página vai para o fim da lista, grande, tracejado, dizendo o
  quê ("Adicionar curso"). A ação do "ready" esconde os quatro para quem só consulta: continua
  escondido (some a vaga dele, nunca o botão).
- **Lista vazia**: "Nenhuma habilidade por enquanto. Toque em “Adicionar habilidade”." (a
  frase da página, "Habilidades não informadas", sai).
- **"Mais Informações"** vazio fica recolhido em "Escrever mais sobre isso"; travado e vazio,
  some; com texto, aparece. Rótulo "Quer contar mais alguma coisa?", 3 linhas que crescem.
- "Prosseguir" vira **Continuar**.

## O que é da página (visto em 30/09)

- O selo dos Idiomas mostra **"#LIST_BADGE#"**: a coluna do selo não está ligada no relatório
  (o desenho não mostra o selo quando ele vem assim). Os títulos vêm em "Iniciais Maiúsculas"
  (o desenho devolve "de", "e", "em" para minúsculas).
- Há uma ação "P1_INSTRUCAO change" copiada da página 1 (o item não existe aqui).
- O "Mais Informações" não tem ação de gravar ao mudar: tudo indica que só o Prosseguir
  (request SAVE) o grava, e sair pela barra de etapas no alto o perde. Não conferido (a
  sessão do RH o traz travado) — vale testar com um candidato.

## Desligar

Tire as duas URLs de arquivo da página.

## Regras da página (auditoria 04/10)

Conferido contra `f600.ORIGINAL.sql` (página 5): 11 ações dinâmicas (as "Dialog Closed" submetem;
"Permite Alterar = N" esconde os 4 Adicionar e desabilita os 4 "…_OBS" na abertura), 3 validações
("Valida Instrução"; "Valida Formacao_Obs" e "Valida Curso_Obs" — obrigatórias quando a regra do
currículo pede e `P_PERMITE_ALTERAR = 'S'`), 3 processos (Pintar Campos põe `is-required`;
Fetch/Process Row), 11 botões; as 4 listas têm condição de servidor por permissão.

- Os Adicionar são os MESMOS botões do APEX (só mudam de lugar/rótulo); quem grava é o Prosseguir.
- **Mudou (04/10)**:
  - `Natcorp_Formacao.src.js` [J5]: o "Mais informações" (…_OBS) obrigatório (`is-required`) ou com
    erro de validação fica SEMPRE à vista — antes, vazio, ficava recolhido atrás de "Escrever mais
    sobre isso" e a pessoa não achava o campo que a validação cobrava.
  - `Natcorp_Formacao.src.css` [C5]: a regra do botão Adicionar (display: inline-flex) ganhou
    `:not([style*="none"])`, para nunca vencer o esconder do "Permite Alterar = N".
- Para decidir: o …_OBS travado pela página e VAZIO some (link e caixa). Não tem o que ler, mas é
  um item da página que deixa de aparecer; se preferirem, mostrar a caixa travada vazia.
