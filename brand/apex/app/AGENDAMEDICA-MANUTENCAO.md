# Agenda Médica (app 2937 · página 10) — guia de manutenção

A página "Controle de Agendas Médicas" (aberta dentro da Medicina Ocupacional, 200:762) deixa de
ser um Interactive Grid com 11 botões e vira uma **agenda do dia** para o médico — 70% no
computador (lista + painel lado a lado), o resto no celular (o painel sobe de baixo).

## O que o médico vê

- **O alto:** o dia por extenso ("Segunda-feira, 5 de outubro · Hoje") com ‹ Hoje › e o
  calendário; o profissional, a sala e a empresa (**Alterar** abre os filtros de sempre); o resumo
  do dia — agendados, na clínica, atendidos, livres — que também filtra a lista; Relatório e
  Consultar por matrícula; "Atualizado às…".
- **A lista:** um horário por linha (Manhã / Tarde / Noite): a hora, o estado, o paciente
  (colaborador ou candidato), o tipo de consulta (cor por tipo), senha, pré-atendimento e **um**
  botão com o próximo passo — Agendar → Marcar chegada → Concluir. Três ou mais bloqueados em
  sequência viram uma linha. No dia de hoje, a linha "agora".
- **O painel do horário:** Agendado → Chegou → Atendido, o próximo passo em destaque e **só as
  ações que valem agora**, em Atendimento (Avaliação médica, Consulta médica, Consulta
  ocupacional, ASO), Paciente (Dados do colaborador/candidato, Chamar paciente) e Agenda (Editar,
  Remarcar, Desmarcar, Desfazer chegada, Reabrir).
- **Agendar / Editar:** uma gaveta com a ficha do próprio grid só com Tipo de paciente, Paciente,
  Tipo de consulta e Observação.
- **Atualiza sozinho** a cada minuto (sem nada sendo editado) — substitui o "Clique aqui para
  atualizar".

## Como funciona (o grid continua sendo o motor)

| O médico faz | Por baixo |
|---|---|
| toca num horário | a linha é escolhida no grid → a `regra_negocio` da página liga/desliga os botões; o painel mostra só os ligados |
| Avaliação médica, ASO, Remarcar… | o **botão original** é apertado (salva antes, se preciso, e abre a tela, como sempre) |
| Marcar chegada / Concluir / Bloquear | `COMPARECEU` / `REALIZOU` / `BLOQUEADO` mudam no grid e o **salvar do grid** grava (com o processo "Bloqueia outras empresas") |
| Desmarcar | pergunta no painel → `desmarcarConsulta()` da página → salvar do grid |
| Agendar / Editar | a "vista de um registro" do grid (Single Row View), com a lista de pacientes que depende do tipo e as validações de sempre |
| troca o dia | `P10_DATA_AGENDA` muda → a ação dinâmica da página atualiza o grid e, se o dia não tem agenda, pergunta se cria |

As regras são as da página: chegada só com paciente; atendido só depois da chegada; com a
chegada marcada, Desmarcar/Remarcar/Editar somem; colaborador tem Consulta médica e Dados do
colaborador (e Consulta ocupacional quando a ASO permite), candidato tem Dados do candidato.

## Arquivos

| Arquivo | Onde | Fonte |
|---|---|---|
| `Natcorp_AgendaMedica.js` | Página 10 › JavaScript › File URLs | `Natcorp_AgendaMedica.src.js` (`python3 gerar-agendamedica.py`) |
| `Natcorp_AgendaMedica.css` | Página 10 › CSS › File URLs | `Natcorp_AgendaMedica.src.css` (`node gerar-app.mjs`) |

```sh
python3 brand/apex/app/aplicar-agendamedica-pagina10.py f2937_page_10.sql
```
Põe só as duas URLs e o comentário (nada mais da página muda). Exportação de 03/10 aplicada
(original em `f2937_page_10.ORIGINAL.sql`). Para desligar: tirar as duas URLs.

## Situações comuns

- **Um tipo de consulta novo ficou sem cor:** `[A2]` do `.src.js`, lista `CONSULTAS` (código → tom)
  e `[C1]` do `.src.css`.
- **Mudar o nome de uma ação:** `[A2]`, lista `ACOES` (o botão original é achado pelo nome).
- **Atualizar mais ou menos vezes:** `[A2]`, `A_CADA` (segundos).
- **Histórico de consultas (03/10):** no painel do paciente, seção Paciente. Guarda o paciente em
  sessionStorage (`nc-hc-abrir`) e aperta `CONSULTA_MATRICULA`; a janela 26 abre já com ele
  (ver `HISTORICOCONSULTAS-MANUTENCAO.md`). Some se o botão `CONSULTA_MATRICULA` não estiver na página.
- **Celular/tablet: a janela abria atrás do painel (03/10, corrigido).** O painel de baixo para cima
  tinha z-index 1000, acima das janelas do APEX — Avaliação médica, ASO etc. abriam escondidas. Com
  uma janela aberta (`:has(.ui-widget-overlay)`), o painel e o fundo descem para z-index 50 (`[C…]`
  celular do `.src.css`).

## Regras da página (auditoria 04/10)

Conferido contra `f2937_page_10.ORIGINAL.sql`: 22 ações dinâmicas, 0 validações, 3 processos
(salvar do grid, "Bloqueia outras empresas", "Popula COD_EMPRESA"), 13 botões e a `regra_negocio`
da página. O grid tem o Salvar na barra (`SAVE`): gravar pelo `save` do grid roda os processos.

- O desenho monta depois do `apexreadyend`; as ações de abertura (desligar botões, grid em edição)
  não dependem de posição. Os botões de ação são os originais, apertados pelo painel (só os ligados).
- **Mudou:** a gaveta (vista de um registro) só passa um campo para o grid com Tab; o "Salvar" da
  gaveta fica fora da ficha e perdia o último campo digitado. Agora os quatro campos são copiados
  para o registro antes de salvar (`sincronizarFicha`, `[A8]`).
- **Mudou:** Marcar chegada / Concluir / Bloquear / Desfazer / Desmarcar mudam o grid pelo modelo,
  o que não dispara a ação "Throw Checkbox Actions"; a `regra_negocio` agora roda logo depois
  (`regra()`, `[A9]`) — sem isso, Remarcar e Desmarcar continuavam ligados depois da chegada.
- **Para decidir:**
  - a gaveta mostra só tipo de paciente, paciente, tipo de consulta e observação; o grid original
    deixava mudar também **Atende área de seleção** (caixa) e **COD_REQ** (número) — hoje não há
    onde mudá-los;
  - a página deixa **bloquear** um horário agendado ou com paciente na clínica (BLOQUEADO só trava
    depois de "realizado"); o desenho só oferece Bloquear em horário livre;
  - **Desmarcar** grava na hora (pergunta no painel → `desmarcarConsulta()` → salvar do grid); no
    original, o botão só limpava a linha e esperava o Salvar;
  - a atualização automática usa o `refresh` do grid, não o submit "REFRESH" do botão original.
