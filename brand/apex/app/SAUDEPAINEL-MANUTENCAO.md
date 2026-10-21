# Saúde e segurança do trabalho — app 2937, página 5

O painel acima da lista "Dados de Funcionário" (a lista que leva ao Histórico do colaborador, a
janela da página 6). Para o médico do trabalho, o engenheiro e o técnico de segurança, o analista
de DP e a diretoria de RH. Feito em 19/10.

## Arquivos

| O quê | Fonte | Gera / sobe |
|---|---|---|
| Tela | `Natcorp_SaudePainel.src.js` | `python3 gerar-saudepainel.py` → `../login/Natcorp_SaudePainel.js` |
| Roupa | `Natcorp_Afastamentos.src.css` seção **[A18]** (+ as peças do ponto [A16]/[A17]) | `node gerar-app.mjs` e depois `python3 gerar-saudepainel.py` → `../login/Natcorp_SaudePainel.css` (cópia do Afastamentos.css) |
| Números | `NC_SAUDE_INDICADORES.plsql.sql` | entra na página pelo `aplicar-saudepainel-pagina5.py` |
| Página | `f2937_page_5.sql` (original: `f2937_page_5.ORIGINAL.sql`) | `python3 aplicar-saudepainel-pagina5.py f2937_page_5.ORIGINAL.sql f2937_page_5.sql` |

O aplicar põe: os File URLs (`#WORKSPACE_IMAGES#Natcorp_SaudePainel.js` / `.css`), o **Static ID
`COLABORADORES`** no relatório e o processo **Ajax Callback `NC_SAUDE_INDICADORES`**. Página já
importada com o painel: o mesmo comando troca só o PL/SQL do processo.

**Ordem para subir:** primeiro `Natcorp_SaudePainel.js` e `.css` no Workspace Images; depois importar
`f2937_page_5.sql`. (A CDN guarda 24 h até um 404 — subir o arquivo antes de a página pedir.)

## O que mostra

**Para agir hoje** (a situação de HOJE, vale em qualquer período) — tocar mostra quem, com
"Abrir o histórico" (a janela da 6, pelo mesmo endereço do lápis):

| Número | Regra |
|---|---|
| Exame vencido | o ÚLTIMO de cada exame (exame_func, entidade 1/7, como a grade da 6) com "próximo exame" já passado; + quem não tem exame nenhum |
| Exame vence em 30 dias | o mesmo, vencendo de hoje a 30 dias ("hora de convocar") |
| Afastados hoje | atestado em vigor hoje (com dias) **ou** situação funcional de afastamento (pelo NOME: `AFASTA` no [S1]; férias nunca) |
| 15 dias de atestado (INSS) | dias de atestado nos últimos 60 dias (o atual conta inteiro) > 15; também lista quem tem 11 a 15. Mostra quantos dias são do mesmo grupo da CID — conferir o motivo antes de encaminhar |
| Estabilidade por acidente | a regra do painel de Acidentes (200:150): voltou de afastamento por acidente (situação com ACID) com mais de 15 dias e está nos 12 meses seguintes (art. 118) |
| Vacina atrasada | a ÚLTIMA dose de cada vacina com a próxima dose já passada (vencendo em 30 dias aparece no quadro Vacinas) |
| Restrição ou doença em aberto | restricao_medica com texto; func_doenca sem término |

**No período** (padrão: últimos 12 meses; atalhos Últimos 12 meses · Este ano · Últimos 3 meses ·
Este mês; De/Até até 2 anos):

| Número | Regra |
|---|---|
| Absenteísmo por doença | dias de atestado dentro do período, até hoje ÷ (pessoas × dias de calendário do período até hoje) |
| Atestados | atestados que COMEÇAM no período; ocupacionais à parte |
| Acidentes | analise_acidente + analise_func com data no período; com afastamento e dias perdidos |
| Dias sem acidente | desde o último acidente da lista toda (e desde o último com afastamento) — não muda com o período nem com os filtros do resumo |
| Exames feitos | exames no período; inaptos e alterados pelo NOME do resultado (`INAPTO`/`ALTERADO` no [S1]) |
| Atendimentos | consultas (consulta_medica) no período |

**Quadros** (cada um com Ampliar): Mês a mês (dias perdidos, atestados, acidentes, exames,
atendimentos) · Exames periódicos (PCMSO), com as 4 caixas que escolhem a faixa (vencidos há +90
dias, até 90, vencem em 30, sem exame) · Causas dos afastamentos (por CID ou por grupo da CID-10:
tabela `CAPS` no [S1]) · Onde (por empresa, filial, setor, local, cargo ou faixa de idade, com 5
indicadores; tocar filtra o resumo) · Acidentes do período (por tipo e a lista) · Vacinas.

**Filtrar este resumo**: as colunas da tabela + faixa de idade, vários valores; não muda a lista.

## Regras de dados

- **As pessoas** são EXATAMENTE as do relatório (a mesma consulta: informacoes_funcionais +
  inf_pessoais_cad + local_trab, os mesmos filtros P5_*, lidos da sessão — o Pesquisar grava antes).
  Filtros feitos dentro do relatório (menu Ações) não entram.
- Os nomes das colunas (Empresa, Filial, Setor, Local, Cargo) são os mesmos textos da tabela, para o
  "ver na lista" achar.
- Datas chegam como **dias a partir de hoje** (hoje = 0). JSON só com inteiros.
- Só lê. Nada é gravado. Sem `TABLE(apex_string.split)` no PL/SQL (ORA-22905 nesta base).
- Acima de 10.000 pessoas o resumo corta e pede para filtrar.

## Conferido / pendente

- **Conferido (19/10):** réplica local com 3.000 pessoas simuladas, 1440 px e 390 px — sem erro,
  nada estoura do quadro; listas, filtro pela barra de "Onde", CID/grupo, Ampliar (Esc devolve o
  foco), período, "Abrir o histórico". Na página 5 VIVA (navegador de teste, dados simulados só na
  aba): o painel ao lado dos Filtros, réguas em 4 + 3 e 3 + 3.
- **NÃO testado no Oracle:** o PL/SQL (`NC_SAUDE_INDICADORES`). Se der erro, o painel mostra a
  mensagem do banco com o passo (`[passo: consulta]`, `estabilidade`, `montar`) e a lista continua.
  Pontos a conferir com dados reais: `analise_func.quantidade_dias_afastamento` (tipo não está na
  exportação — lido como texto inteiro), `atestado_funcionario.qtde_horas_abonadas` (texto: "8",
  "08:00"), o tempo com muitas pessoas.
- **Conferir com o SESMT:** se "Afastados hoje" pela situação pega as situações certas (regra pelo
  nome); se os nomes de resultado "Inapto/Alterado" são os da base; se o "Sem exame registrado"
  deve ignorar admitidos há poucos dias.
