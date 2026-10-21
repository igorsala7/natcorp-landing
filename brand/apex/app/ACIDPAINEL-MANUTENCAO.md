# Resumo dos acidentes de trabalho — página 150 do app 200

Pedido (13/10/2026): a consulta "Acidente de Trabalho" fácil para quem tem pouca instrução, com o
olhar de RH/DP. A página continua igual (filtros à esquerda, relatório); acima do relatório entra o
**Resumo dos acidentes de trabalho**, da mesma família dos resumos de Afastamentos (25), Férias (26)
e Quadro (16). Abre **fechado** (só os 5 números); "Ver análise completa" abre o resto e fica lembrado.

## O que o painel mostra

**Agora** (não depende do período). Cada número abre a lista de quem são:

| Número | O que conta | Lista |
|---|---|---|
| Sem acidente no trabalho | dias desde o último acidente **típico** (trajeto, doença e ocorrência ficam de fora, como na NBR 14280); âmbar com menos de 7 dias | os acidentes mais recentes |
| Afastados por acidente | quem está hoje numa situação cujo nome tem "ACID" (ex.: 13 - Acid. Trabalho > 15) | quem está fora há mais tempo primeiro, com a volta prevista |
| Com estabilidade | quem voltou de afastamento por acidente com **mais de 15 dias** e está nos 12 meses seguintes (art. 118 da Lei 8.213) | a estabilidade que acaba antes primeiro; âmbar com 30 dias ou menos |
| Sem número da CAT (vermelho) | acidente dos últimos 24 meses, que não é ocorrência nem cancelado, sem "Número da CAT" | o mais novo primeiro, com "Prazo era 02/10" (1º dia útil depois do acidente) |
| Análise não concluída (âmbar) | acidente dos últimos 24 meses com a investigação Pendente (ou sem situação) | a mais antiga primeiro |

Tocar num **acidente** abre a análise dele (página 151, a mesma da lupa da tabela). Tocar numa
**pessoa** filtra a tabela por ela (a busca do próprio relatório, na coluna Colaborador).

**No período** (12 meses · 2 anos · 5 anos · Tudo — fica lembrado): a frase ("87 acidentes com 40
pessoas, 12 no trajeto… 49 precisaram se afastar"), "de cada 1.000 pessoas do quadro, X se
acidentaram", a comparação com o período anterior do mesmo tamanho, e 6 quadros: quando
aconteceram (mês a mês), que tipo, **em que dia e hora** (7 dias × madrugada/manhã/tarde/noite; a
casa mais escura tem mais acidentes), onde mais acontece (por local de trabalho, filial, centro de
custo…), em que cargo e quem se acidentou mais de uma vez.

**Filtrar este resumo**: as colunas (empresa, filial, centro de custo, unidade, atividade, cargo,
local, tipo), vários valores em cada uma; tocar numa barra também filtra. A tabela não muda.

## Regras escolhidas (PODE MEXER, no `[K1]` do .src.js)

- **Tipo pelo nome** (a tabela `acidente_tipo` muda de base para base): "ocorrência/incidente/quase"
  = não é acidente e não pede CAT; "trajeto"; "doen" = doença do trabalho; o resto = típico.
- **Hora 00:00** é tratada como "sem hora" (é como o sistema guarda a hora em branco); fica fora do
  quadro Dia e hora e é contada embaixo dele.
- `PEND_MESES = 24`: até onde CAT e análise pendentes são cobradas.
- O prazo da CAT pula sábado e domingo; **feriado não é conhecido** aqui.
- A data final da estabilidade é contada da volta (fim da situação no histórico): **conferir com a
  carta do INSS** — a lista diz isso.

## Instalar

1. Subir para o Workspace Images: `login/Natcorp_AcidPainel.js` e `login/Natcorp_AcidPainel.css`.
2. Importar `f200_page_150.sql` (feita da exportação de 13/10 16:18 — se a página mudou depois,
   pedir outra exportação e rodar de novo o passo de gerar). Ela traz: os dois File URLs, o Static
   ID **IR** no relatório e o processo **NC_ACID_INDICADORES** (Ajax Callback, **só leitura**).
3. Conferir na página: os números contra o relatório (ex.: "Sem número da CAT" contra a coluna).

Sem o processo, o painel mostra o aviso e a tabela funciona normalmente.

## Arquivos

| Peça | Fonte | Gera |
|---|---|---|
| A tela | `Natcorp_AcidPainel.src.js` | `python3 gerar-acidpainel.py` → `../login/Natcorp_AcidPainel.js` |
| A roupa | `Natcorp_Afastamentos.src.css` (seção `[A11]`) | `node gerar-app.mjs` e depois `gerar-acidpainel.py` (cópia) |
| Os números | `NC_ACID_INDICADORES.plsql.sql` | entra na exportação pelo `aplicar-acidpainel-pagina150.py` |
| A página | `f200_page_150.ORIGINAL.sql` | `python3 aplicar-acidpainel-pagina150.py f200_page_150.ORIGINAL.sql f200_page_150.sql` |

## Cuidados

- **Não testado no banco**: o PL/SQL foi escrito a partir da consulta do relatório e das colunas da
  análise (p31 do app 2943: STATUS_CAT, NUM_PROTOCOLO, QTDE_DIAS_TRATAMENTO, AFASTAMENTO_IMEDIATO).
  A tela foi conferida na 200:150 com dados de teste montados das linhas do relatório.
- Os filtros da página são lidos da sessão (o "Pesquisar" grava antes); aberta da ficha
  (P150_EMP/P150_MAT), vale só aquela pessoa, como o relatório.
- O link da análise vem pronto do servidor (`apex_page.get_url`, com o checksum).
- O que estiver acentuado no PL/SQL vai para a exportação em `unistr(...)`, como o APEX exporta.
