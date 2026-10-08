# Histórico de consultas — app 2937, página 26

A janela "Consulta Matricula" (agora com o título "Histórico de consultas"), aberta pela Agenda
(página 10): o passado do paciente na agenda médica, para o médico consultar. Antes, eram 5
campos de pesquisa e uma planilha de 10 colunas. Agora é um histórico de leitura rápida.

Arquivos: `Natcorp_HistoricoConsultas.src.js` / `.src.css` → `../login/…js` / `.css`.
JS: `python3 gerar-historicoconsultas.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-historicoconsultas-pagina26.py f2937_page_26.sql` (aplicada em 03/10;
original em `f2937_page_26.ORIGINAL.sql`). **Não confundir** com `aplicar-linhatempo-pagina26.py`
(página 26 do app 200, Férias).

## Como ficou

| Onde | O quê |
|---|---|
| Alto | `código - nome`, funcionário ou candidato, `código - empresa` · **Trocar paciente** |
| Resumo | uma frase: "6 consultas de 2019 a 2026 · 1 realizada · 1 veio sem atendimento · 4 faltas" |
| Faixa de comparecimento | uma marca por consulta, da mais antiga à mais nova, entre a 1ª e a última data, na cor da situação. Tocar leva à consulta (limpa filtros se preciso) |
| Próxima consulta | data, hora, tipo e profissional, se houver uma marcada |
| Filtros | Período (Tudo · 12 meses · 3 anos · Escolher datas) · Situação e Tipo (com quantos) · Profissional · busca (tecla `/`) · "Limpar filtros" |
| Lista | por ano (cabeçalho fixo ao rolar), da mais nova à mais antiga: dia/mês/dia da semana, tipo (cor da Agenda), profissional, horários numa frase ("Marcada 08:00–08:30 · chegou 07:52 · atendido 08:05–08:21 (16 min) · esperou 13 min"), situação |
| Lista \| Tabela | Tabela = o relatório original (exportar, imprimir). Só o Período vale nela |

**Situações** (a mesma cor na faixa, no selo e no filtro):

| Situação | Regra |
|---|---|
| Realizada | `realizou = 'S'` |
| Veio, não foi atendido | `compareceu = 'S'` e não realizou |
| Agendada | data de hoje em diante, sem as duas marcas |
| Faltou | data passada e `compareceu = 'N'` |
| Sem registro | data passada sem marca nenhuma |

Hora `00:00` é tratada como vazia (o banco guarda assim a hora de chegada não informada).

## Vindo da Agenda

No painel do paciente da Agenda (página 10), seção Paciente: **Histórico de consultas**. O
`Natcorp_AgendaMedica.js` guarda `{emp, empTxt, tipo, pac, pacTxt, t}` em sessionStorage
(`nc-hc-abrir`) e aperta o botão original `CONSULTA_MATRICULA`. Aqui, empresa e tipo são escritos
primeiro, espera-se a cascata (que limpa o paciente) e só então o paciente. O lembrete vale 60 s e
é apagado ao ser lido. O botão "Consultar por matrícula" do dia continua abrindo a pesquisa.

## O que a exportação muda

- URLs de arquivo, comentário e título da janela.
- **Defeito corrigido:** os campos Data Inicial / Data final existiam e a ação dinâmica atualizava
  o relatório, mas a consulta não os usava. Agora usa (`dd/mm/yyyy`), e as datas vão no envio.
- Processo novo `NC_HIST_CONSULTAS` (Ajax Callback): o histórico em JSON, da mesma tabela do
  relatório (`agendas_medicos_horarios`), com o nome do tipo (`tipo_consulta`) e do profissional
  (`prestador_servico`, tipo 1). Lê os itens P26_* (pageItems).

**Sem o processo**, a página fica como era (nenhuma mudança na tela).

## Cuidados

- Só lê: nada é gravado.
- A pesquisa original (empresa, tipo, paciente) vive dentro de "Trocar paciente"; as datas, na
  barra de filtros. Os itens são os mesmos — a ação dinâmica "Atualiza informações" continua.
- Aberta solta numa aba, a 26 não abre ("Não é possível renderizar…", é janela): testar pela Agenda.

## Testar sem o processo no servidor

Aba nova com a sessão atual → Agenda → painel do paciente → Histórico de consultas. Na janela,
injetar um falso de `apex.server.process('NC_HIST_CONSULTAS')` que leia as linhas do relatório
"Horários" da própria janela, depois o CSS e o JS.

## Regras da página (auditoria 04/10)

Conferido contra `f2937_page_26.ORIGINAL.sql`: 1 ação dinâmica ("Atualiza informações": trocar
datas/paciente/empresa atualiza o relatório), sem validações nem processos de gravação, sem botões.
O desenho só lê; os itens de pesquisa são os originais e todo valor posto por ele (período, vinda da
Agenda) passa por `apex.item().setValue` (a ação roda). Montagem no `apexreadyend`. Sem mudanças.

**Para saber:** a exportação aplicada muda a consulta do relatório "Horários" (passa a usar
P26_DATA_INICIAL / P26_DATA_FINAL, antes ignorados) — correção de defeito, já descrita acima; quem
importar a página leva essa mudança. `NC_HIST_CONSULTAS` lê a mesma tabela, sem gravar.
