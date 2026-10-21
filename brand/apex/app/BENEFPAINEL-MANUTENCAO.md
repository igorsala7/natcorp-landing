# Resumo dos benefícios — página 164 do app 200

Pedido (08/10/2026): indicadores indispensáveis de gestão de benefícios na consulta de Benefícios,
fáceis para quem tem pouca instrução. A página continua igual (filtros, os relatórios, o botão IA);
acima do relatório entra um resumo. Mesmo desenho dos painéis 200:16, 25 e 26.

A página tem duas consultas (**Opção de Consulta**, `P164_OPCAO`) e o resumo acompanha a que está na
tela:

| Opção | Relatório | De onde vêm os números |
|---|---|---|
| Colaboradores (C) | `IR_1` | `BI_BENEFICIOS` do usuário (`:P_USUARIO`) — quem enche é o "Processo Consulta" no **Pesquisar** (`PKG_CONSULTA_BENEFICIOS`), já com filtros e segurança. O painel usa a MESMA consulta do relatório (a união do VT com `MEIO_FUNC`/`UTILIZACAO`/`CUSTO_MEIO` + os outros índices) |
| Dependentes (D) | `IR_4` | `VW_BI_BENEFICIOS_DEPEND` com as permissões (`permissao_func/pess/depend`) e `F_Acesso` — o WHERE está COPIADO da exportação de 08/10 |

O painel nasce **compacto** (só a faixa "Hoje", ~130 px) com o botão **Ver análise completa**: a
tabela é a função principal e aparece logo abaixo.

## Colaboradores

**Hoje** (cada número de alerta abre a lista de quem são, até 300):

| Número | Regra |
|---|---|
| Custo do mês | soma do "Valor Compra" das linhas do **mês de referência** = a compra mais recente da tabela. Embaixo, a média por pessoa que teve compra |
| Com benefício | pessoas na tabela; embaixo, quantas com VT e com plano de saúde em vigor |
| Recebem sem trabalhar | situação ≠ 01 (afastado ou desligado) desde ANTES do mês de referência e com compra maior que zero nesse mês. Alerta de custo indevido |
| Benefício parado | benefício em vigor cuja última compra é anterior ao mês de referência: aberto no cadastro, sem compra — encerrar ou corrigir |
| Terminam em 60 dias | data fim entre hoje e hoje + 60 |

Alerta com zero fica **verde, "Ninguém"**.

**Análise**: frase do mês (total, pessoas, média; planos de saúde e seguros não têm compra — o custo
vem na fatura da operadora), *Para onde vai o dinheiro* (por benefício, toque = busca na tabela),
*Custo por centro de custo*, *Quem participa de cada benefício* (pessoas com o índice em vigor),
*Vale-transporte: os maiores valores* e *Quem tem o maior custo* (30 maiores), *Planos de saúde por
operadora*.

**Linhas repetidas**: a tabela repete a mesma compra (uma vez por faixa de valor mínimo/máximo, e o VT
por meio de transporte). O painel conta cada benefício UMA vez por pessoa + índice + código + tipo +
início + mês de referência. Na base de teste: 417 linhas → 309.

## Dependentes

| Número | Regra |
|---|---|
| Dependentes nos planos | dependentes distintos com adesão final vazia ou futura e sem baixa; embaixo, titulares e a média |
| Filhos com 21 anos ou mais | Filho/Filha/Enteado(a), 21+, fora a condição "inválido" — conferir o direito (o contrato costuma aceitar até 21, ou 24 se estuda) |
| Fazem 21 anos em 90 dias | só quando a data de nascimento é visível ao usuário |
| CPF a corrigir | vazio ou com dígito verificador errado — só quando o CPF é visível (permissão de CPF dos dependentes); sem permissão, "—" |
| Saem do plano em 60 dias | adesão final entre hoje e hoje + 60 |

**Análise**: parentesco, idade (faixas da própria view), por plano, titulares com mais dependentes.
Nomes que a permissão esconde viram "Dependente nº X" / "Matrícula X".

## Instalar

1. Subir para o Workspace Images: `login/Natcorp_BenefPainel.js` e `login/Natcorp_BenefPainel.css`.
2. Importar `f200_page_164.sql` no app 200 = a exportação de 08/10 23:30 (`f200_page_164.ORIGINAL.sql`,
   base com deslocamento 805756123742460090) + os File URLs + o processo `NC_BENEF_INDICADORES`:
   ```
   python3 aplicar-beneficios-pagina164.py f200_page_164.ORIGINAL.sql f200_page_164.sql
   ```

## Arquivos

| O quê | Fonte | Gera |
|---|---|---|
| Os números (servidor) | `NC_BENEF_INDICADORES.plsql.sql` | entra no processo pelo aplicar |
| A tela | `Natcorp_BenefPainel.src.js` | `python3 gerar-benefpainel.py` → `../login/Natcorp_BenefPainel.js` |
| A roupa | `Natcorp_Afastamentos.src.css` (a MESMA dos 4 painéis) | `node gerar-app.mjs` e `python3 gerar-benefpainel.py` → `../login/Natcorp_BenefPainel.css` |

## Cuidados

- As colunas da `BI_BENEFICIOS` vêm como TEXTO ("01/06/2026", "1170,4"): o PL/SQL lê com `dt()` e `n()`,
  que não quebram (texto estranho = vazio). Se a tabela passar a guardar DATE/NUMBER, continua
  funcionando (`to_char` antes de ler).
- O painel de Colaboradores mostra o que o último **Pesquisar** gravou na `BI_BENEFICIOS` — igual à
  tabela. Mudar um filtro sem Pesquisar não muda nenhum dos dois.
- Por isso o resumo guardado na aba (10 min) só vale quando a pessoa VOLTA à página (botão voltar):
  em toda carga nova ele recalcula. Antes (08/10) aparecia o número antigo e, num segundo, o novo.
- Custo do mês acima de R$ 100 mil aparece curto no quadrinho ("R$ 730 mil", "R$ 10,7 milhões"); o
  valor exato fica ao passar o mouse e na frase da análise.
- Lições das páginas 16, 25 e 26: instr no lugar de TABLE() (o WHERE do IR_4 foi convertido), uma
  passada só, variáveis antes das funções, chave de array nunca nula, NVL2/DECODE só dentro de SQL,
  o aplicar corta o PL/SQL na LINHA `declare`.
- **Não testado no banco**: a tela foi conferida na 200:164 com números tirados do download dos dois
  relatórios (custo de jun/2026 R$ 102.474, 5 afastados com compra somando R$ 3.091, 15 parados). Ao
  instalar, conferir o "Custo do mês" contra a soma da coluna Valor Compra filtrada pelo mês de
  referência. Erro do processo vem com `[passo: …]`.
