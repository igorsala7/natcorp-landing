# Informações Funcionais — etapa "Dados Funcionais" (app 600, página 35) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Aberta pelo RH em Administração de Pessoal › Informações do Colaborador (200:799 → 9180:11 →
600:35, em iframe). Mais de 200 campos em 9 abas (região de abas `TABS`: Identificação,
Lotação, Cargo/Salário, Folha, Horário, Pagamentos/Convênios, Previdência Privada, Seguro de
Vida, Ocorrências Disciplinares). A maior parte é CONSULTA (itens `…_DSP` só de leitura, vindos
da folha); "Alterar Dados" libera o que se edita; as consultas da direita (Distribuição Custo,
Políticas de Cálculo, Evolução Salarial…) são ligadas/desligadas pela página conforme a aba
(`P35_ABA`). O desenho não muda valor e não grava.

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Funcional.css` | o desenho (gerado de `Natcorp_Funcional.src.css` por `gerar-app.mjs`) |
| `Natcorp_Funcional.js` | o comportamento (gerado por `gerar-funcional.py`) |

Página 35 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Funcional.js`;
CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Funcional.css` (à mão — não veio exportação).
Reconhece a página por `…_SITUACAO_DSP` + `…_SALARIO_DSP` + `…_JORNADA_DSP`.

## O que muda

- **Ficha no alto** (abaixo da faixa do colaborador): Situação (Ativo em verde, "desde …"),
  Cargo, Local, Contrato, Jornada, Salário — sem o código ("01-ATIVO" → "Ativo"). Tocar num dado
  abre a aba dele, rola até o campo e o acende. No celular, duas colunas, sem ícone.
- **Abas** em letra normal com ícone ("Cargo e salário", "Pagamentos e convênios"); no
  computador quebram linha (a seta do slider sai); no celular rolam de lado.
- **Consulta × edição**: campo só de leitura (readonly/disabled) com fundo claro, sem borda e
  sem o botão de lista/calendário; vazio mostra "—". O que se edita fica em caixa branca com
  borda. Uma linha explica: "Os campos com fundo claro são só de consulta (vêm da folha)…". A
  classe acompanha o "Alterar Dados" (observa readonly/disabled).
- **Ações**: "Alterar Dados" em destaque; as demais sob "Consultas desta aba"; as que a página
  desliga para a aba aberta saem da vista. No celular as ações vêm antes das abas, e o texto do
  botão aparece (o tema o escondia).
- O "Ir para seção" do Formulario_Celular sai daqui (listava as 23 regiões de todas as abas).
- **Rótulos**: jargão encurtado (`ROTULOS` no .js) e os trocados da página corrigidos.

## O que é da página (visto em 30/09)

- Rótulos trocados: `NUM_SIND_DISS_DSP` dizia "Tipo ATS - Adicional por Tempo de Serviço";
  `TSA_PAT_S_ADES_*` diziam "Patrocinadora com Adesão" (são "sem adesão"); `TSA_OUTRAS_EMP_MESES`
  dizia "Não Patrocinadora - Meses". O desenho corrige na tela; o certo é corrigir no APEX.
- "I N S S?" com letras separadas; "Motivo Alteração" com parêntese sobrando no valor
  ("RETORNO DE AFASTAMENTO)") — dado.

## Não visto funcionando

O estado depois de "Alterar Dados" (clicar roda PL/SQL) e as abas Seguro de Vida e Ocorrências
Disciplinares com linhas (são relatórios com "Adicionar").

## Desligar

Tire as duas URLs de arquivo da página.

## Regras da página (auditoria 04/10)

Conferido contra `f600.ORIGINAL.sql` (página 35): 59 ações dinâmicas (116 ações: liga/desliga de
itens por "Set Itens Disable"/"Enable Itens", trocas DSP × editável por "Hide Show Itens", duplo
vínculo, PIS/PASEP, estatutário, consultas ligadas/desligadas por aba via `P35_ABA`, "Destaca Itens
Obrigatórios" com borda inline), 22 validações (todas função PL/SQL no servidor), 4 processos
(Fetch/Process Row, Atualiza Dados PIS PASEP, Set Parâmetros), 28 botões.

- O desenho não move campo, não grava e não mexe em valor; abas e "mostrar" usam o clique da aba.
- **Mudou (04/10)**:
  - `Natcorp_Funcional.src.css` [C4]: a cor de borda dos campos (consulta = transparente; edição =
    lilás) foi para regras à parte com `:not([style*="border-color"])`. Antes ela (com !important)
    apagava a borda roxa de 2px que o "Destaca Itens Obrigatórios" põe nos obrigatórios.
  - `Natcorp_Funcional.src.js` [J4]: a ficha do alto ignora item cujo contêiner a página escondeu
    (`display:none`) — ex.: no duplo vínculo a página esconde `SALARIO_DSP` e a ficha mostrava esse
    salário mesmo assim.
- Para decidir: as consultas que a página DESLIGA na aba aberta (Evolução Salarial, Políticas de
  Cálculo, Distribuição Custo…) saem da vista (`.nc-fu-apagada`). A página só as desabilita; quem
  procura "Evolução Salarial" fora da aba Cargo e salário não a encontra. Opção: mostrá-las
  apagadas em vez de sumir.
