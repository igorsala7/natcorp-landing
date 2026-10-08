# Lançamento de Exames — app 2937, página 11

A janela "Manutenção de Exames Médicos" (aberta pelo botão **Exames** do Exame Médico Ocupacional,
2937:19). É onde o médico lança e corrige os exames do paciente. O Interactive Grid de 18 colunas
virou um histórico legível com uma ficha para lançar.

Arquivos: `Natcorp_LancamentoExames.src.js` / `.src.css` → `../login/Natcorp_LancamentoExames.js` /
`.css`. JS: `python3 gerar-lancamentoexames.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-lancamentoexames-pagina11.py f2937_page_11.sql` (aplicada em 03/10;
original em `f2937_page_11.ORIGINAL.sql`).

## Como ficou

| Onde | O quê |
|---|---|
| Alto da janela (fixo) | `código - nome`, idade, cargo, setor, local, empresa, sangue · Trocar paciente · Cadastro de Médico / Entidade (botões originais) |
| Situação | o último de cada exame, com o próximo: vencido / vence em breve (30 dias) / em dia · "Lançar de novo" |
| Histórico | do mais novo ao mais antigo: data, exame, tipo, ocupacional, procedimento, resultado (cor), próximo, médico · busca · filtro por exame · ícone da Audiometria (link da página 95) |
| Tocar num exame | **Resumo** só leitura (desenhado pelo JS, sem passar pelo grid) com Editar · Lançar de novo · Excluir (com confirmação) |
| Editar / Lançar exame / Lançar de novo | **Ficha** = a vista de um registro do grid numa gaveta, em 4 partes, atalhos +6 meses / +1 ano / +2 anos para o próximo exame, aviso do código do laboratório no Toxicológico |

"Lançar de novo" traz do anterior: exame, tipo, ocupacional, ordem, complemento, médico, origem,
entidade e procedimento; a data vem com hoje; resultado e próximo vêm vazios.

## O que NÃO mudou

O grid é o motor: dados, listas, validação "Obriga se Toxicológico", processos do salvar ("Set
ENTIDADE", "Atualiza Tipo Prest Serv", o DML do grid) e a ação SET CGC. Os ids das colunas
(`C130937…`) não aparecem no código — mudam de base para base; o JS pergunta ao grid
(`modelColumns[col].elementId`).

## Armadilhas já pagas (ler antes de mexer na ficha)

1. **A vista de um registro fica presa num registro se for fechada e reaberta** — mostra os campos de
   outro exame. Testado: com `gotoCell` + `next/previous-record` (o caminho da Agenda Médica) errava.
   O jeito que acertou 15 de 15: abrir a vista UMA vez e nunca fechar; para trocar de exame, sair da
   edição → `recordView('option','recordOffset', posição)` → entrar na edição; e **conferir** (o
   registro e a data no campo). Sem bater, tenta de novo uma vez e, se não, não abre.
2. **A ação SET CGC roda toda vez que um registro entra em edição** (é o jeito do grid: ao ativar a
   linha, os campos disparam "change"). Ela reescreve o CNPJ e deixa o registro "alterado". Por isso:
   Cancelar reverte o exame, e Salvar reverte qualquer OUTRO registro alterado antes de chamar o
   salvar — só vai para o banco o exame da ficha.
3. **Defeito da própria página (não corrigido aqui):** a SET CGC não tem tratamento para exame sem
   entidade (valor `*1`): `SELECT … INTO` sem linha → "Ocorreu um erro ao tentar processar as
   informações." Acontecia também no grid original ao editar essas linhas. Correção sugerida no
   PL/SQL da ação: `exception when no_data_found then :CGC_LAB := null; :DC_CGC_LAB := null;`.
4. Nome de variável: a lista do histórico (`lista`) e a função da ordem do grid colidiram uma vez —
   a ficha ficava "abrindo" para sempre. A abertura agora tem prazo de 4 s.

## Testar sem gravar

Aba nova com a URL da janela (mesma sessão); antes de injetar, trocar a ação `save` do grid:
`ig.interactiveGrid('getActions').lookup('save').action = function(){…}` (anotar o que iria e
disparar `interactivegridsave` com `{status:'success'}`). Fechar a aba com `runBeforeUnload: false`.

## Regras da página (auditoria 04/10)

Conferido contra `f2937_page_11.ORIGINAL.sql`: 3 ações dinâmicas, 1 validação ("Obriga se
Toxicológico", do grid), 4 processos (salvar do grid, Set ENTIDADE, Atualiza Tipo Prest Serv,
Retorna Informações Funcionário). O grid tem o Salvar na barra (`SAVE`).

- Monta depois do `apexreadyend`. CNPJ e dígito continuam desligados pela ação SET CGC. Trocar a
  matrícula continua submetendo a página. Médico/Entidade são os botões originais.
- **Mudou:** "Salvar exame" fica fora da ficha (vista de um registro), que só passa um campo para o
  grid com Tab — o último campo digitado ficava de fora (e, se era o único, nada era salvo). Agora a
  ficha é copiada para o registro antes de salvar (`sincronizarFicha`, `[X9]`); os atalhos +6 meses
  / +1 ano também escrevem no campo, para a cópia não desfazê-los.
- **Mudou:** "Lançar de novo" copia também CNPJ e dígito do laboratório com a entidade (na página,
  quem os preenche é a ação SET CGC ao escolher a entidade, e a cópia pelo modelo não a dispara).
- **Para decidir:** "Lançar exame" já vem com a data de hoje (a coluna não tem padrão; o valor
  aparece na ficha); "Excluir" grava na hora (no original: apagar a linha e Salvar).

**Decidido (04/10, cliente):** "Lançar exame" abre com a data em branco — quem informa é a pessoa.
