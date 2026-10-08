# Consulta Médica — app 2937, página 40

A janela em que o médico registra a consulta (aberta pela Agenda Médica, 2937:10). As 12 abas
viraram uma ficha só, na ordem do atendimento, com um trilho para ir direto a cada parte.

Arquivos: `Natcorp_ConsultaMedica.src.js` / `.src.css` → `../login/Natcorp_ConsultaMedica.js` / `.css`.
JS: `python3 gerar-consultamedica.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-consultamedica-pagina40.py f2937_page_40.sql` (aplicada em 03/10;
original em `f2937_page_40.ORIGINAL.sql`).

## Como ficou

| Onde | O quê |
|---|---|
| Alto (fixo) | `código - nome`, idade, empresa, médico, especialidade · tipo de consulta · data e entrada · Dados do funcionário / Atestado de Saúde Ocupacional / Imprimir (botões originais) |
| Trilho (esquerda; no celular, faixa no alto) | Dados da consulta · **Ouvir**: relato, anamnese, antecedentes, gestação · **Examinar**: exame físico · **Concluir**: diagnóstico, conduta · **Prescrever e orientar**: receituário, posologia, encaminhamento · **Trabalho**: atividades, recomendação. Marca ✓ o que já tem registro, acende a parte na tela, fica vermelha com erro do servidor |
| Ficha | as regiões das abas, uma embaixo da outra; antecedentes em botões de marcar; "Outras doenças"/"Uso de medicamentos" abrem o campo só quando marcados; textos crescem e mostram o limite; entrada/saída em `hh : mm` (travadas pela página) |
| Rodapé (fixo) | Voltar · o que falta (a saída) · "Consulta em andamento" · **Finalizar consulta** |

- **Finalizar** é o botão original (CREATE), com a pergunta "Deseja finalizar a consulta?" de sempre.
  A hora de saída é gravada pelo servidor no Finalizar (processo "Set Values"); o desenho não escreve nela.
- **Sair sem finalizar** (Voltar, Dados do funcionário, ASO) numa consulta nova com algo escrito pede
  confirmação no rodapé — a consulta só é gravada ao Finalizar (a página não tem "salvar rascunho").

## O que NÃO mudou

As regiões são **movidas** inteiras das abas para a ficha (TAB1…TAB10 pelo Static ID; Anamnese,
Antecedentes e Gestante pelos campos P40_TEXTO_ANAMNESE, P40_ALERGIA, P40_IND_GESTANTE). Por isso
seguem valendo: a trava do pré-atendimento ("Disable Tabs" desliga TAB1…TAB10 até "Iniciar
Atendimento" — o desenho mostra o aviso com o botão), os relatórios com seus botões Adicionar e
janelas, as ações dinâmicas (idade, tipo de exame, dias da recomendação, gestante, outras doenças),
as validações e os processos. O formulário de empresa/matrícula (quando o paciente já veio da
Agenda) só sai da vista; o "TIPO EXAME" fica à vista (auditoria 04/10).

Obs.: Anamnese e Antecedentes não têm Static ID — a trava do pré-atendimento da página não as
desliga (já era assim nas abas).

## Armadilhas já pagas

1. O rodapé da janela já tem a região de botões (Voltar/Finalizar) em colunas: colocar algo entre
   elas quebrava (`insertBefore` fora do pai). O desenho monta o próprio rodapé e muda os botões
   originais para ele.
2. A área que rola (`.t-Dialog-bodyWrapperIn`) é `position:absolute` no tema: o trilho fica ao
   lado com `left: 236px` na área, não com flex.
3. A Skin desenha moldura, ícone e linha rosa em toda região com seletores de 1 id: as sub-regiões
   ganham a marca `nc-cm-sub` e as regras usam `:not(#nc-cm-x)`.
4. A região de empresa/matrícula não tem a classe `t-Region` (modelo sem moldura): é achada pelo
   `[id^="R"]` mais perto do campo.

## Testar sem gravar

Aba nova com a URL da janela (mesma sessão), `apex.submit = function(){}` antes de injetar.
**Nunca** apertar Finalizar em teste: a ação CREATE grava (sequência e MT_CHAMADA_PACIENTE_STATUS)
antes do submit. Fechar a aba com `runBeforeUnload: false`.

## Regras da página (auditoria 04/10)

Conferido contra `f2937_page_40.ORIGINAL.sql`: 24 ações dinâmicas, 4 validações (recomendação:
datas, descrição, 90 dias), 16 processos, 12 botões e as condições de só leitura.

- **"Finalizar grava antes do submit" é da própria página:** a ação CREATE pergunta, gera a
  sequência, grava `MT_CHAMADA_PACIENTE_STATUS` ('F') e só então submete. O desenho clica o botão
  original e não pula nada. Risco da página (não do desenho): se uma validação barrar o submit
  (datas da recomendação), o status 'F' já foi gravado.
- Monta depois do `apexreadyend`; as regiões são movidas inteiras (trava TAB1…TAB10, relatórios,
  Adicionar). Gestante, outras doenças e uso de medicamentos seguem as ações da página.
- **Mudou (CSS):** `.nc-cm-bt` tinha `display:inline-flex` (com `!important`), que trazia de volta o
  botão **Atestado de Saúde Ocupacional** escondido pelas ações "Exibe/Oculta ATES_SAUD_OCUP" e
  "Create: ATES_SAUD_OCUP" (consulta nova; tipo de exame vazio). Agora `[style*="none"]` vence.
- **Mudou (JS):** o **TIPO EXAME** (campo de texto editável; decide o botão ASO) volta à vista.
- **Mudou (JS):** saiu o "Agora" da saída e o preenchimento da saída antes do Finalizar: a ação
  "Disable Horarios" trava os quatro campos de hora e o processo "Set Values" grava a saída no
  submit (o valor do desenho era sobrescrito de qualquer jeito).
- **Para decidir:**
  - consulta NOVA: empresa e matrícula são editáveis na página, mas a região some quando já vêm da
    Agenda (e Cargo/Função/Local `_DSP` não aparecem em lugar nenhum);
  - "Outras doenças" / "Uso de medicamentos": a página só DESLIGA a região até marcar; o desenho a
    recolhe quando desligada e vazia (na prática o mesmo, mas é esconder onde a página desliga);
  - "Sair sem finalizar?" é uma confirmação a mais (não impede).
