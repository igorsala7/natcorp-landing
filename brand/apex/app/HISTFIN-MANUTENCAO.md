# Histórico Financeiro — página 21 dos apps 200 e 9181

> **App 9181 (13/10):** a MESMA página (mesmos campos, ações, processos e relatório), com o botão IA a mais e
> SEM a junção com `distribuicao_custo` e as 4 colunas contábeis. Recebe o mesmo desenho pelo mesmo script —
> `aplicar-histfin-pagina21.py` lê o app na exportação e usa os ids do perfil dele (`PERFIS`: o modelo de
> página com coluna e a moldura "Filtros" vêm das páginas 50/55/58 do 9181). Os passos de `distribuicao_custo`
> e das colunas contábeis são pulados ali (não existem). Mesmos `Natcorp_HistFin.js/.css`.
> ```
> python3 aplicar-histfin-pagina21.py f9181_page_21.ORIGINAL.sql f9181_page_21.sql
> ```

Pedido (09/10/2026): indicadores de gestão da folha na consulta do histórico financeiro, fáceis para
quem tem pouca instrução, e um fluxo melhor para escolher os parâmetros (antes: ~1.000 px de campos
numa grade de 4 colunas acima da tabela, 10 listas "Sim / Não" soltas, inicial e final separados).

## O que mudou na página (aplicar-histfin-pagina21.py)

- Modelo de página com a **coluna de filtros à esquerda** (o mesmo das consultas 16, 25, 26 e 164).
- A região "Parâmetros" virou **Filtros** (Static ID `PARAMETROS`), com a moldura da 164; os campos ficam
  um embaixo do outro, na ordem dos assuntos; "Período" virou "Meses".
- A região "Totais" ganhou o Static ID `TOTAIS`.
- O processo Ajax Callback `NC_HISTFIN_INDICADORES`.
- Nada mais: ações dinâmicas (Popula_Data, Submit, Disable Histórico), processos, listas em cascata e o
  relatório ficaram como vieram.

## Os filtros (Natcorp_HistFin.js, parte F)

Os campos ORIGINAIS reunidos em grupos (o JS move, não copia — o APEX continua dono deles):

| Grupo | Campos | Abre |
|---|---|---|
| Quando | Empresa, Meses | sempre |
| O que somar | as 10 origens (`P21_H_*`) viram **botões de marcar**; a lista "Sim / Não" fica escondida e recebe o valor ("Folha", "Ferias", "13 Salario"…) | sempre |
| De quem | faixas Filial, Centro de custo, Matrícula (De / Até), Situação, Vínculo, Sindicato, faixa Data de admissão | se tiver filtro (ou se a pessoa deixou aberto) |
| Quais verbas | Tipo de evento, Ocorrência | idem |
| Mais opções | faixas Centro de custo contábil e Data de retenção, "Esconder as linhas de total" (`P21_OCULTAR`) | idem |

O número ao lado do grupo diz quantos filtros estão em uso. No **pé da coluna** (preso enquanto se rola):
o resumo em palavras do que vai ser pesquisado (meses, o que soma, quantos filtros a mais) e o MESMO
botão Pesquisar (com a ação dinâmica "Submit"). Mudou um filtro: o pé fica âmbar, "toque em Pesquisar
para atualizar a tabela" (as mudanças do primeiro 1,5 s são das listas em cascata se preenchendo e não
contam). Com a página aberta pela ficha do colaborador (`P21_MAT`), os grupos sem campos não aparecem.

## O resumo da folha (Natcorp_HistFin.js, parte J)

Acima da tabela (`HST`), compacto por padrão. Os números são da **última pesquisa** (filtros da sessão,
sem pageItems) — o mesmo que a tabela mostra.

**No período**: Ganhos · Descontos · Líquido (média por pessoa por mês) · Horas extras (pessoas, % dos
ganhos, horas) · Saldo negativo (descontos maiores que os ganhos no mês — a pessoa fica devendo; abre a
lista). Líquido ZERO não é alerta: é o normal de quem passou o mês de férias ou recebeu tudo adiantado.

**Análise**: com 2 meses ou mais, a frase compara o último com o anterior, e entram *Mês a mês*, *O que
mais mudou* (verbas, "subiu / caiu R$") e *Líquido que mais mudou* (pessoas). Sempre: *Para onde vai o
dinheiro* e *Descontos* (por categoria da verba), *Ganhos por centro de custo*, *Por tipo de cálculo*,
*Quem fez mais hora extra*, *Faltas e atrasos descontados*, *Encargos da empresa*. Com o resumo montado, a
região Totais sai (o resumo mostra os mesmos totais).

## As regras (NC_HISTFIN_INDICADORES.plsql.sql)

- Os dados são os do processo **Totais** da página (o mesmo WITH inf/hist, o mesmo NOT EXISTS em
  `VIEW_MAT_HISTORICOS_MES`) — os totais do resumo batem com a região Totais (conferido: R$ 949.568,97 e
  R$ 488.113,81 em mai+jun/2026).
- Tipo da verba (a regra da região Totais e da Folha do Mês 300:74): `quatro_digitos_ocorr` N → provento
  1-499, desconto 500-899; S → 1-4999 e 5000-8999; só com `incid_liq = 'S'`. 996-999 / 9996-9999 são os
  totais da folha e não entram.
- Categoria = `Fnct_Nome_Cod_Gerencial` (o cadastro da verba). Horas extras = categoria que começa com
  "Horas Extras" (no cliente de teste inclui DSR e periculosidade, porque o cadastro as pôs lá); Faltas =
  começa com "Faltas"; Encargos da empresa = "Encargos Empresa" (FGTS e afins).
- Valor só de quem o usuário pode ver (`F_Acesso_Salario_Apex`, a regra da coluna Valor); quem fica de
  fora é contado e a frase avisa.
- Meses: a faixa mín–máx usa o índice de `data_ref`; a lista confere o mês exato.

## Achado na própria página (não mexido)

O relatório junta `distribuicao_custo` e **repete as linhas** de quem tem o custo dividido em 2+ centros
(12 pessoas na base de teste): a soma das linhas repetidas é R$ 68.065,51 — exatamente a diferença entre a
soma da coluna Valor e a região Totais. Quem somar a coluna no relatório (ou no download) conta duas vezes.
Para o time decidir: tirar a junção, ou trazer a distribuição como coluna agregada.

## Instalar

1. `node gerar-app.mjs` e `python3 gerar-histfin.py`; subir `login/Natcorp_HistFin.js` e `login/Natcorp_HistFin.css`.
2. Importar `f200_page_21.sql` (= `f200_page_21.ORIGINAL.sql`, exportação de 09/10 00:28, + o aplicar):
   ```
   python3 aplicar-histfin-pagina21.py f200_page_21.ORIGINAL.sql f200_page_21.sql
   ```

## Arquivos

| O quê | Fonte | Gera |
|---|---|---|
| Os números | `NC_HISTFIN_INDICADORES.plsql.sql` | entra no processo pelo aplicar |
| Filtros + resumo | `Natcorp_HistFin.src.js` | `gerar-histfin.py` → `../login/Natcorp_HistFin.js` |
| A roupa | `Natcorp_Afastamentos.src.css` (painéis) + `Natcorp_HistFiltros.src.css` (filtros) | `gerar-app.mjs` + `gerar-histfin.py` → `../login/Natcorp_HistFin.css` |

## Cuidados

- **Não testado no banco** (nem o PL/SQL nem o novo modelo de página): a tela foi conferida na 200:21 com
  a coluna simulada e números tirados do download. Ao importar: conferir os totais contra a região Totais
  (esconda o resumo para vê-la) e o Pesquisar no pé da coluna. Erro do processo vem com `[passo: …]`.
- Lições das páginas 16/25/26/164: instr no lugar de TABLE(), variáveis antes das funções, NVL2/DECODE só
  dentro de SQL, chave de array nunca nula.

## Desempenho (medido em 09/10, empresa 700, 1 mês, folha do mês + meses anteriores)

| Etapa | Tempo |
|---|---|
| Página depois do Pesquisar (processo Totais + 1ª página do relatório) | 85,6 s |
| Resumo (NC_HISTFIN_INDICADORES) | 13,0 s |
| PRC_DADOS_IR (widget NATI recolhe TODAS as linhas do relatório para a IA, sozinho, 2 s após abrir) | 119 s |
| Busca rápida no relatório (cada busca refaz a consulta inteira) | > 20 s |

Sugestões, da maior economia para a menor:
1. **Não rodar o relatório ao abrir** — hoje o Popula_Campos já preenche o mês e "Folha", e cada abertura da
   página paga a consulta inteira antes de a pessoa escolher nada. Condição no relatório (e no Totais):
   `:P21_PESQUISA = 'S'` (como a 16 faz).
2. **NATI sob demanda** — o PRC_DADOS_IR recolhe 100% das linhas ao abrir. Só recolher quando a pessoa pede
   algo sobre o relatório, ou mandar um resumo agregado.
3. **Funções por linha** — o SELECT chama ~15 funções PL/SQL por linha (nomes de empresa, filial, centro de
   custo, sindicato, funcionário, categoria, F_Acesso_Salario_Apex e 4 × fnc_BuscaDadosEstrutContabil). Com
   20 mil pessoas × ~70 verbas = 1,4 milhão de linhas por mês → ~20 milhões de chamadas, e o ORDER BY obriga
   a calcular todas antes da 1ª página. Mais barato: trocar por JOIN nas tabelas de nome; onde não der,
   `(select fnct_x(...) from dual)` — o Oracle guarda o resultado para entradas repetidas (a mesma conta
   contábil aparece milhares de vezes). F_Acesso_Salario_Apex: uma vez por pessoa no WITH `inf`.
4. **distribuicao_custo** — a junção repete linhas (valor somado em dobro) e custa uma junção por linha: tirar,
   ou trazer agregado por pessoa.
5. **Totais duplicado** — o resumo já calcula os mesmos totais (e esconde a região): desligar o processo Totais
   economiza a 2ª passada em toda carga.
6. **Índices** — `MWV_HISTORICOS(data_ref, cod_empresa)` (ou partição por mês) e, para o NOT EXISTS,
   `MWV_HISTORICOS_MES(cod_empresa, matricula, data_ref, cod_ocorr, origem)`.
7. **Sem ORDER BY na fonte** — a ordem vai no relatório salvo; e conferir o plano com `DBMS_XPLAN.DISPLAY_CURSOR`
   num cliente de 20 mil, com os binds reais.

### Aplicado na página (09/10, passo 6 do aplicar)
- Funções por linha do relatório viram `(select f(...) from dual)` (mesmos valores; o Oracle reaproveita as
  entradas repetidas): nomes de empresa, filial, centro de custo, unidade, atividade, local, c. custo contábil,
  funcionário, sindicato, categoria, `F_Acesso_Salario_Apex` e as 4 de `fnc_BuscaDadosEstrutContabil`.
- `distribuicao_custo`: de junção para `exists` (as MESMAS pessoas) + a coluna "Dist. C. Custo Contábil" por
  subconsulta (o menor código, se houver mais de um). As linhas deixam de se repetir: a soma da coluna Valor
  passa a bater com a região Totais.
- Sem Pesquisar (`P21_PESQUISA` diferente de S) o relatório, o Totais e o resumo não calculam; aberto pela ficha
  do colaborador (`P21_MAT`) calculam como antes. A mensagem do relatório vazio já era "Preencha os Parâmetros e
  Pesquise".
- Não mexido: colunas, ordem (ORDER BY 1,10,19), filtros, ações dinâmicas. Índices e a NATI ficam para o time.
