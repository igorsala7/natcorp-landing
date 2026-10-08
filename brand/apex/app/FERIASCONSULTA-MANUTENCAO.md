# Consulta de Requisição de Férias — app 300 (Portal do Colaborador), página 77

A lista dos pedidos de férias do colaborador (o pedido em si é a 78, `Natcorp_Ferias`). Era um
relatório interativo de 25 colunas; o colaborador quer VER os pedidos de forma clara, e as
ferramentas do relatório ficam em segundo plano (pedido de 04/10). 80% no celular.

Arquivos: `Natcorp_FeriasConsulta.src.js` / `.src.css` → `../login/Natcorp_FeriasConsulta.js` / `.css`.
JS: `python3 gerar-feriasconsulta.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-feriasconsulta-pagina77.py f300_page_77.sql` (aplicada em 04/10; original
em `f300_page_77.ORIGINAL.sql`). Só as File URLs e o comentário da página.

## Como ficou

| Onde | O quê |
|---|---|
| Colaborador | A região "Colaborador" (só com `P77_MAT`) vira um cartão curto: foto, nome, matrícula e situação, "Na empresa desde…", e o botão original "Visualizar" (página 13) |
| Pedir férias | O botão ORIGINAL "Criar Requisição" com outro rótulo, grande, no alto — as ações dele (validação da matrícula, ação judicial, alerta) continuam |
| Próximas férias | Quando há uma saída de hoje em diante num pedido que não está cancelado/reprovado: a data por extenso, os dias e "Faltam N dias" |
| Situação | Botões com a contagem (Todos · Cancelada 19 · Reprovada 1 · Concluída 1…), filtram na hora (só a página carregada) |
| Cartão | A situação em cor e ícone, "Pedido 55477 · aberto em 28 jul 2020", as PARTES ("Sai 3 ago → Volta 2 set 2020", "30 dias", "Vendeu 10 dias", "Adiantamento do 13º"), o período aquisitivo com o saldo, "Pedido por" quando não foi a própria pessoa, "Pedir de novo" (link original, quando existe) e "Ver pedido" (o lápis da linha). Tocar no cartão = Ver pedido |
| Encerrados | Em "Todos", cancelados e reprovados ficam atrás de "Ver cancelados e reprovados (N)"; pela situação, aparecem direto e mais discretos |
| Tabela | "Ver como tabela" mostra o relatório original com busca, Ações, colunas; "Ver em cartões" volta. A escolha fica no aparelho |

## Regras da página (conferidas)

- Consulta, paginação (o relatório continua na página e pagina; os cartões se refazem no
  `apexafterrefresh`), o botão Criar com as 4 ações dinâmicas, o processo `popula_colab` e o
  desvio "Ir" (P77_OK) não mudam. Os links são os ORIGINAIS (`click()` no link da linha).
- Fica fora do padrão Tabela/Cartões geral (`Natcorp_Registros`): página com desenho próprio.

## Cuidados

- Os dados são lidos pelo **título das colunas** (`COLS` no JS, sem acento): renomear coluna no
  relatório ou escondê-la (Ações › Colunas) tira a informação do cartão.
- "Matrícula Solicitada" tem link quebrado na página (`#MAT_SOLICITADO#` não existe na consulta):
  não é usado no cartão. Correção: trocar por `#MATRICULA#` no link da coluna.
- Ação "Carrega Plugin" (alertify "Teste") roda no `ready` só no resultado FALSO — não aparece; não mexido.
- Testado em 04/10 com 21 pedidos reais (celular 390 px e computador, cartões e tabela) numa aba de
  teste da mesma sessão. "Próximas férias" não apareceu (nenhuma saída futura nos dados).

## Corrigido depois de importar (04/10)

- **O desenho não entrava na página importada:** o JS exigia o relatório (`.a-IRR`) já pronto ao rodar,
  mas o `.a-IRR` é montado pelo JS do próprio relatório DEPOIS dos arquivos da página. Agora reconhece
  a página só pelos itens (P77_OK, P77_ALERT_ACAO_JURIDICO) e procura o relatório na montagem (tenta
  de novo em 0 s, 0,8 s, no apexreadyend e em 3 s). No teste anterior funcionava porque o script foi
  posto com a página já carregada — testar SEMPRE pelo caminho real (página importada).
- **Títulos das colunas no alto da tela, por cima da trilha:** a cópia "grudenta" do cabeçalho
  (`.nc-sticky-header-clone`, do `Natcorp_Allow_Unload_Iframes.js` da equipe) continuava à vista com a
  tabela escondida. Sai no modo cartões.
