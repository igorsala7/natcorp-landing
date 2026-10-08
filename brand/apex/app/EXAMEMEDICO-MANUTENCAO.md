# Exame Médico Ocupacional — app 2937, página 19

A janela (modal) que a Agenda Médica (2937:10) abre para o médico fazer o exame. O médico passa o
dia nela, consulta atrás de consulta. As 3 abas e os 57 campos soltos viraram uma ficha na ordem do
atendimento.

Arquivos: `Natcorp_ExameMedico.src.js` / `.src.css` (fontes) → `../login/Natcorp_ExameMedico.js` /
`.css` (sobem para o Workspace Images). JS: `python3 gerar-examemedico.py`. CSS: `gerar-app.mjs`
(está na lista AVULSAS). Exportação: `python3 aplicar-examemedico-pagina19.py f2937_page_19.sql`
(aplicada em 03/10; original em `f2937_page_19.ORIGINAL.sql`).

## Como ficou

| Onde | O quê |
|---|---|
| Alto da janela (fixo; no celular rola com a ficha) | `código - nome`, idade, função e há quanto tempo, setor, depto, empresa, admissão, RG, CTPS; tipo de exame em cor; data do exame |
| Esquerda | Mudança de função (só no tipo M) → Sinais vitais → Exames complementares |
| Direita | Parecer e ASO: Apto/Inapto, data do resultado, validade, nº do ASO, feito na empresa, conduta, procedimento, médicos |
| Rodapé da janela (fixo) | Exames · Relatório ASO · "Alterações não salvas" · Salvar exame |

Cada parte tem o contador "3 de 5" (campos preenchidos).

## O que NÃO mudou (de propósito)

- **Nenhum campo foi criado.** Os contêineres do APEX (rótulo + campo + lugar do erro) são mudados de
  lugar **dentro da mesma região** (adicionais, wecker, complementares). Por isso a trava do
  pré-atendimento continua valendo: com `P19_PRE_ATEND = 'S'` (processo "Pre-Atendimento") a ação
  "Disable Tabs" põe `apex_disabled` nas três regiões e nos botões, até o médico apertar
  **Iniciar Atendimento** (ação "Insere MT_CHAMADA_PACIENTE_STATUS", que grava o início e libera).
  O desenho põe esse botão original num aviso no alto; o aviso some quando as regiões voltam.
- O Salvar (`SAVE`, exame já gravado) ou o Criar (`INSERT`, exame novo), o Relatório ASO e o Exames
  (vai para a página 11) são **os botões originais**, mudados para o rodapé.
- As validações do Salvar são as da página: procedimento obrigatório; com procedimento, o resultado.
  O rodapé só avisa antes ("Para salvar, falta o procedimento e o resultado").
- O IMC continua calculado no banco (ação dinâmica do peso/altura). Os dados do coordenador também.
- A região "Informações Cadastrais" e as abas ficam na página, escondidas (os itens ocultos vão no
  submit).

## Comportamentos que ajudam o médico

- **Enter** num campo de texto vai para o próximo. No texto livre, Enter pula linha.
- **Ctrl+S / ⌘S** sai do campo, espera as ações dinâmicas (até 3 s) e aperta o Salvar.
- **Jeito rápido de digitar** (`ARRUMAR`, roda na fase de captura do `change`, ANTES da ação dinâmica):
  altura `170` → `1,70`; peso/temperatura com ponto → vírgula; temperatura `365` → `36,5`;
  pressão `12080` → `120/80` (`x`, `-`, espaço também viram `/`).
- **Referências** (só avisam, nada bloqueia): IMC classificado (OMS); PA ≥ 140/90 ou < 90/60;
  temperatura ≥ 37,8 ou < 35; pulso > 100 ou < 60. Ficam em `[E2]` do JS.
- **Apto / Inapto**: botões que fazem `apex.item('P19_RESULT_EXAME').setValue('1', '1 - APTO')`. Se o
  exame vier com um código que não está em `RESULTADOS`, a lista original aparece no lugar.
- **Validade** e **Feito na empresa**: um botão por opção da própria lista (lidas do `<select>`,
  validade em ordem de prazo). Embaixo, "Vale até" = data do resultado + validade (vermelho se vencido).
- **Data do resultado diferente da do exame** → aviso + botão "Usar dd/mm/aaaa".

## Armadilhas já pagas

1. **"Ocorreu um erro ao tentar processar as informações"** ao digitar `70.5` e dar Enter: o Enter
   disparava `change` pelo jQuery, que **não passa** pelo ouvinte nativo de captura → a ação
   dinâmica do IMC recebia o ponto. Não dispare `change` à mão: mover o foco basta.
2. Montar a tabela da acuidade **fora da página** e procurar o campo com `getElementById` → `null`.
   Dentro do `mover()` tudo é procurado pelo próprio contêiner.
3. A Skin desenha a seta da lista com `background-image`: nos campos use `background-color`, nunca
   `background`.
4. A altura vai para o banco **em metros com vírgula** (`1,70`); `170` dá IMC 0.

## Testar sem gravar

Abrir a URL da janela numa aba NOVA (mesma sessão), `apex.submit = function(){}` antes de injetar,
e fechar a aba com `runBeforeUnload: false` (o APEX pergunta "sair sem salvar?" e trava o recarregar).
Não clicar no Salvar original sem trocar o `apex.submit`.

## Para aplicar

1. Subir `Natcorp_ExameMedico.js` e `.css` para o Workspace Images (app 2937).
2. Página 19 › JavaScript › File URLs: `#WORKSPACE_IMAGES#Natcorp_ExameMedico.js`;
   CSS › File URLs: `#WORKSPACE_IMAGES#Natcorp_ExameMedico.css` — ou rodar o
   `aplicar-examemedico-pagina19.py` sobre a exportação e importar.

## Regras da página (auditoria 04/10)

Conferido contra `f2937_page_19.ORIGINAL.sql`: 10 ações dinâmicas, 2 validações (procedimento;
resultado com procedimento), 9 processos, 7 botões e as condições de só leitura dos itens.

- Monta depois do `apexreadyend`; a trava do pré-atendimento ("Disable Tabs") continua nas regiões
  e nos botões originais (o desenho só lê a classe). Apto/Inapto, Validade e "Feito na empresa"
  gravam por `setValue`, respeitam a trava e somem com o campo. Os botões são os originais.
- **Mudou (CSS):** `.nc-em-campo` tinha `display:flex` (com `!important`), que vencia o esconder da
  ação AD_PROPOSTOS (cargo/função/filial/local fora do tipo M). Agora `[style*="none"]` vence (`[C…]`
  "o contêiner do campo").
- **Mudou (JS):** no exame NOVO (sem ROWID) o **Tipo de exame** é editável e obrigatório (e o tipo M
  mostra a mudança de função), mas estava na região de cadastro escondida. Os itens dessa região que
  estiverem editáveis (tipo, data, empresa, paciente) vêm para uma parte "Dados do exame" no alto da
  ficha; só leitura continua no cabeçalho.
- **Para decidir:** nada pendente nas regras. (O cabeçalho mostra o código do tipo quando ele é
  lista editável — só aparência.)
