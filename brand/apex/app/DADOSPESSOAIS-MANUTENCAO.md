# Dados Pessoais — portal Conhecendo Você (app 600, página 1) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Quem usa: o próprio colaborador ou candidato, 9 em cada 10 pelo celular, muitos com pouca
leitura. A página tem 17 blocos e mais de 130 campos e **grava sozinha a cada campo mudado**
(ação dinâmica "change | input,.selectlist,.textarea → Executar PL/SQL"). O desenho não muda
valor, não dispara change e não grava.

| Arquivo | O quê |
| --- | --- |
| `Natcorp_DadosPessoais.css` | o desenho (gerado de `Natcorp_DadosPessoais.src.css` por `gerar-app.mjs`) |
| `Natcorp_DadosPessoais.js` | o comportamento (gerado por `gerar-dadospessoais.py`) |

Página 1 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_DadosPessoais.js`;
CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_DadosPessoais.css` (à mão — não veio
exportação). Sem classe no APEX e sem teste de app/página: o .js reconhece a página por
`…_NOME_MAE` + `…_NUM_CPF_DISPLAY` + `…_TIPO_MIDIA`. Soma-se ao `Natcorp_Formulario_Celular.js`
(teclado certo, datas, "Ir para seção"), que continua na aplicação.

## O que muda

- **O alto**: "Olá, Tony!", "Seu cadastro está 68% completo" (o `P0_PERCENTUAL` da página) com
  a barra, e "O que você escreve é salvo na hora. Não precisa apertar botão de salvar" — ou
  "Seus dados estão aqui só para consulta" quando todos os campos vêm travados (sessão do RH /
  colaborador sem permissão). "Ver tudo aberto" mostra a página como era.
- **Sete capítulos** no lugar dos 17 blocos: Sobre você · Onde você mora · Telefone e e-mail ·
  Sua família · Seus documentos · Medidas e saúde · Conta para o salário. Um aberto por vez;
  cada um diz "12 de 16" (campos com resposta, só os que estão à vista), a linha do pé mostra o
  quanto, e vira **Completo** com o visto verde. Se a página marcar obrigatórios (a borda roxa
  de 2 px do `P1_ITENS_OBRIGATORIO`), aparece "Faltam N".
- **Continuar: <próximo capítulo>** no fim de cada um; no último, "Pronto! Ir para Cursos e
  Formações" (o link da etapa seguinte do próprio assistente).
- A primeira vez abre o primeiro capítulo com campo vazio; depois, o capítulo aberto fica
  guardado (sessionStorage) — a página recarrega quando fecha a janela de anexos.
- **Documentos**: cada um diz Preenchido / "3 de 5" / Vazio; os que nem todo mundo tem dizem
  ("Só se você tiver carteira de motorista", "Para homens: o certificado do serviço militar"…).
  O clipe "Anexos" vira **Enviar foto**. Endereço: "mande a foto de uma conta de luz, água ou
  telefone".
- **Rótulos** em palavras de todo dia (`ROTULOS` e `BLOCOS` no .js): "Nome da mãe", "Celular",
  "Tipo de sangue", "Nome do marido ou esposa", "Tempo de residência" (era "Residênciia").
- **"Salvando…" / "Salvo"** no pé da tela a cada campo que a página grava; erro do servidor ou
  da rede vira "Não foi salvo. Confira a internet e tente de novo."
- O botão "Ir para seção" do Formulario_Celular sai nesta página (os capítulos são a lista).

## Tela larga (a partir de 1180 px) — 03/10

Pedido: os dados ficavam longe, com muita rolagem (etapas + título + cartão "Cadastro" empurravam o
primeiro campo para o pé da tela; o conteúdo ocupava 8/12 da largura, recuado). Agora:

| O quê | Como |
|---|---|
| Etapas do assistente | uma linha só (círculo + nome ao lado), ~50 px — em TODAS as etapas do app 600 (Natcorp_Paginas [C10], `@app:has(#pFlowId[value="600"])`) |
| Título "Dados Pessoais" (HeroRegion) | some quando há etapas (repete a etapa ativa) — em qualquer largura |
| Cartão "Cadastro" | vai para a **coluna da foto** (`#t_Body_side`, que já é fixa), em cartão CLARO com a faixa rosa: % em Roxo, barra, "salvo na hora", os botões do fluxo do RH em pé e o **sumário dos capítulos** (número/visto, nome, "Faltam 2"/"3 de 8"/"Completo"; tocar abre e rola). Marca `nc-dp-com-lado` no body. No celular volta para o alto (âncora `<!--nc-dp-resumo-->`) e o sumário some |
| "Foto" e "Currículo" | lado a lado (a coluna fica mais baixa e o sumário cabe) |
| Conteúdo | largura toda (`nc-dp-col-principal`); colunas espaçadoras sem região somem (`nc-dp-col-lado-vazia`), e linhas sem nada à vista também (`nc-dp-linha-vazia`, conferido 1,2 s depois da carga) |
| Campos | a grade do APEX vira UMA grade de 12 por bloco (`.row` = `display: contents`): campo de linha inteira → meia linha, de meia → um quarto; texto de 60+ caracteres (rua, bairro, nomes) fica com meia (`nc-dp-col-meia`); caixa de texto grande, várias caixinhas ou bloco dentro → linha inteira (`nc-dp-col-larga`); coluna sem nada à vista some (`nc-dp-col-vazia`, pelo estilo CALCULADO) |

CUIDADO: o clearfix do tema (`::before`/`::after` da linha e do contêiner) vira célula da grade quando a
linha se dissolve — está desligado em [C8]; sem isso "Empresa" ia parar no meio da linha.

Medido (1320×760, a janela do currículo do RH): primeiro campo a **336 px** do topo (antes ~745); o
capítulo "Onde você mora" (9 campos) inteiro numa tela. Celular (390): como antes, sem rolagem lateral.

## Aberta dentro de outra tela (RH: Administração de Pessoal › Informações do Colaborador)

A MESMA página 1 abre dentro de iframes (200:799 → 9180 → CV_NATCORP:1), com a etapa "Dados
Funcionais" no assistente, Empresa/Filial/Data de Admissão, o botão "Currículo" e o fluxo de
ALTERAÇÃO: os campos chegam travados, **"Alterar Meus Dados"** (REQ_ALT_CAD) os libera e a
mudança vira uma solicitação (**Salvar** = SAVE_REQ, que pergunta "Deseja prosseguir com a criação
da solicitação de alteração?"; **Desconsiderar Alterações** = CANC_ALT_CAD). Nesse caso o desenho:

- diz **"Cadastro de Tony Oliveira"** e "O cadastro está 68% completo" (a página embutida não é
  "Olá, Tony!"; no portal, aberto direto, continua o "Olá");
- sobe REQ_ALT_CAD, SAVE_REQ, CANC_ALT_CAD e DEL_ALT_CAD para o cartão do alto (as ações da página
  continuam mostrando/escondendo cada um pelo id) e diz o que fazer: "Os dados estão travados.
  Para mudar algum, toque em Alterar Meus Dados" → "Mude o que precisar. No fim, toque em
  Salvar: a mudança vai para o RH conferir";
- **não** mostra "salvo na hora" nem o "Salvando…/Salvo" (ali a mudança é uma solicitação).

Não visto: o estado depois de "Alterar Meus Dados" (clicar executa PL/SQL da página).

## Cuidados (lidos nas ações da página)

- O "Libera Campos" faz `$('input,select,button', '#CAMPOS_REGION,#ENDERECO,#CONTATO,
  #INF_ADICIONAIS,#DOCUMENTOS').prop('disabled', …)`. Por isso **nenhuma região sai do lugar**
  (os capítulos são montados só com classes e cabeçalhos inseridos) e os controles do desenho
  são `div role="button"`, não `<button>` — senão seriam desabilitados junto.
- Duas regiões têm o mesmo id `ENDERECO` (Nacionalidade e Endereço): `#ENDERECO` da página só
  alcança a primeira. Defeito da página.
- Fechar a janela de anexos (p864) envia a página (apexafterclosedialog → SUBMIT_PAGE).
- Ao testar: nunca mudar valor de campo (grava). Na sessão do RH tudo vem desabilitado.

## Não visto funcionando

O modo candidato com campos habilitados (o "Salvando…/Salvo" só foi lido no código, não visto
gravando) e a página com `P1_ITENS_OBRIGATORIO` preenchido (o "Faltam N").

## Desligar

Tire as duas URLs de arquivo da página.

## Regras da página (auditoria 04/10)

Conferido contra `f600.ORIGINAL.sql` (página 1): 72 ações dinâmicas (137 ações), 150 validações
(86 com erro junto do campo), 27 processos, 25 botões. O que importa ao desenho: "Libera Campos"
(Page Load / Change Item / Req. Ativa) desabilita input/select/button por região e pinta os
obrigatórios com borda inline; dezenas de NATIVE_HIDE/SHOW de itens e regiões; "Alerta:
Informações Obrigatórias" mostra/esconde a região Alerta conforme `P1_ALERTA`, que o "Refresh
Documents" recalcula depois de fechar a janela de documentos; Prosseguir = SAVE ou CREATE (submit).

- Conferido e certo: nada sai das regiões do "Libera Campos" (capítulos só por classe; controles
  são div role=button); nenhum controle trocado, nenhum valor posto; a borda dos obrigatórios não
  é sobrescrita; os botões do fluxo do RH são os originais (só mudam de lugar).
- **Mudou (04/10)** em `Natcorp_DadosPessoais.src.js`:
  - [J5] o "Continuar" do ÚLTIMO capítulo ("Pronto! Ir para …") agora CLICA o Prosseguir original
    (SAVE/CREATE) quando ele está à vista. Antes ia pelo link da barra de etapas — sem submit, sem
    as 150 validações e sem os processos que gravam (Process Row of INF_PESSOAIS_CANDIDATO e
    "Cadastra Candidato" só rodam com SAVE/CREATE). Sem Prosseguir (fluxo do RH, consulta), segue
    como antes.
  - [J6] erro de validação num capítulo fechado: o capítulo do primeiro campo com erro abre sozinho
    (uma vez por conjunto de erros).
  - [J4] `marcarColunas`: linha/coluna que tem região ou botão escondido PELA PÁGINA (display:none
    inline) não recebe mais `nc-dp-linha-vazia`/`nc-dp-col-lado-vazia` — o CSS (!important)
    impedia a região Alerta de reaparecer quando a ação da página a mostra.
- **Para decidir (URGENTE)**: pela exportação, a página NÃO grava a cada campo. O "Monitor
  Changes" só faz `:p1_changes := 'Y'` (sem enviar o campo) e nenhum outro processo/ação grava no
  banco fora do submit (SAVE/CREATE/SAVE_REQ). Então "O que você escreve é salvo na hora. Não
  precisa apertar botão de salvar" e o aviso "Salvo" (que anuncia a resposta desse Ajax) estão
  errados: quem sai pela barra de etapas ou fecha o navegador perde o que digitou. Confirmar numa
  sessão de teste (mudar um campo, sair sem Prosseguir, voltar) e, confirmado, trocar a frase e
  tirar o "Salvando…/Salvo". Só não foi possível ver `#APP_IMAGES#forms-functions.js`/`cards.js`.

**Decidido (04/10, cliente):** a frase "O que você escreve é salvo na hora" e o indicador
"Salvando… / Salvo" eram do desenho, não da página — saíram (`mudou()` desligado, `.nc-dp-salva`
escondido quando vazio). A gravação é a da página, como sempre foi.
