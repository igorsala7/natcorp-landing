# Pré-atendimento (triagem) — app 2937, página 74 (manutenção)

A janela em que a ENFERMAGEM faz a triagem antes da consulta, aberta pela Agenda Médica (página 10,
coluna do pré-atendimento). Irmã da página 19 (Exame Médico): mesmo padrão (04/10/2026).

Arquivos: `Natcorp_PreAtendimento.src.js` → `../login/Natcorp_PreAtendimento.js` (`python3 gerar-preatendimento.py`);
`Natcorp_PreAtendimento.src.css` → `../login/…css` (`node gerar-app.mjs`, AVULSAS). Exportação:
`python3 aplicar-preatendimento-pagina74.py f2937_page_74.sql` (aplicada em 04/10; original em `.ORIGINAL.sql`)
— só as URLs de arquivo e o comentário.

**Para subir:** importar `f2937_page_74.sql` e pôr `Natcorp_PreAtendimento.js` e `.css` no Workspace Images.

## Como ficou (os mesmos campos, na mesma ordem)

| Parte | O quê |
|---|---|
| O paciente — registro feito | A região de leitura (…_TXT) vira um cartão: nome e código, funcionário/candidato · empresa, **alergia em destaque** (se houver e não for "nega"), atendimento, data e hora, atendente. |
| O paciente — registro novo | "Atendimento": data, tipo do atendimento (a pessoa escolhe, mesmo com uma opção só), atendente; empresa, **Funcionário/Candidato em dois botões** (escrevem na lista original), paciente (por último: a lista dele depende das outras). "Realizado às" vazio sai. |
| Sinais vitais | Cartões em 4 colunas, unidade dentro do campo: **pressão "120 / 80 mmHg"** (os dois campos originais lado a lado), saturação (% SpO₂), frequência (bpm), temperatura (°C), altura (m), peso (kg), **IMC calculado na hora** (peso ÷ altura², escrito no P74_IMC, que não é gravado) com a classificação. Avisos (só avisam): pressão ≥ 140/90 ou < 90/60, saturação < 95%, frequência > 100 ou < 60, febre ≥ 37,8 °C ou < 35 °C. |
| Anotações | Alergias, Atendimento de enfermagem, Relato do paciente — com a orientação (a ajuda "?" da página) à vista e o contador; **"Nega alergias."** num toque com o campo vazio. |
| Rodapé | Os botões originais (Voltar, Criar/Salvar) e o estado: "Para criar, falta: …" (pelo VALOR dos itens) ou "Alterações não salvas". |
| Teclado | Enter avança; Ctrl+S/⌘S salva (espera as chamadas ao banco); "170" → 1,70; "365" → 36,5; "84.3" → 84,3; "12080" (ou 120/80, 120x80) na máxima → 120 e 80. |

## Cuidados

- Os campos são só MUDADOS de lugar (dentro das mesmas regiões): o Criar/Salvar, o processo que põe o
  paciente na SALA DE ESPERA da chamada, a validação da data e a ação "HIDE" (registro novo × feito) continuam.
- O banco quer vírgula decimal: o ARRUMAR roda na captura do "change", antes da ação do IMC. Nunca
  disparar "change" à mão antes.
- A busca do paciente mostra "- Selecione -" como texto quando vazia: o "falta" lê o VALOR (`apex.item`).
- CSS: regra de esconder um campo precisa de 3 classes (`.nc-pa-campo.t-Form-fieldContainer.nc-pa-oculto`),
  senão perde para o `display: flex` do campo.
- Testar sem apertar Criar/Salvar (grava e põe o paciente na sala de espera da TV de chamada).

## Não visto funcionando

Um registro real já feito (a prévia simulou os textos na tela) e o Salvar/Criar no servidor.

## Regras da página (auditoria 04/10)

Conferido contra `f2937_page_74.ORIGINAL.sql`: 4 ações dinâmicas ("HIDE" das regiões pelo ROWID,
IMC ×2, Cancel), 1 validação (data), 5 processos, 3 botões.

- Monta depois do `apexreadyend`. Registro novo × gravado segue a mesma regra da ação "HIDE"
  (P74_ROWID). Funcionário/Candidato grava por `setValue` na lista original (só as opções dela).
  Criar/Salvar e Voltar são os originais. "Nega alergias" só com o campo vazio, por `setValue`.
- O IMC calculado na tela vai para `P74_IMC`, que não tem origem no banco (só de ver); a ação do
  banco continua.
- Sem violação corrigida.
- **Para decidir:** com uma opção só, o **Tipo do atendimento** já vem escolhido (por `setValue`,
  à vista) — padrão que a página não tem.

**Decidido (04/10, cliente):** o tipo do atendimento não é mais escolhido sozinho com uma opção só.
