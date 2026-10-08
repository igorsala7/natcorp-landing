# Requisição de Hora Extra (app 9503, página 716) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A janela aberta pela aba **Requisição de Hora Extra** do Painel do Operador (200:795 embute a lista
9503:138; "Criar Requisição" e cada pedido abrem a 716). O gestor ou o próprio colaborador pede
autorização para fazer hora extra num dia e horário; quem aprova autoriza.

| Arquivo | O quê |
| --- | --- |
| `Natcorp_HoraExtra.css` | o desenho (gerado de `Natcorp_HoraExtra.src.css` por `gerar-app.mjs`) |
| `Natcorp_HoraExtra.js` | o comportamento (gerado por `gerar-horaextra.py`) |

App 9503 › Página 716 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_HoraExtra.js` (no fim
da lista); CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_HoraExtra.css`. Já aplicado em `f9503_page_716.sql`
por `aplicar-horaextra.py` (original em `f9503_page_716.ORIGINAL.sql`); numa exportação nova já
aplicada, o script só troca o comentário da página. Atenção: é a página **716** (a janela), não a
lista 138. Reconhece a página pelos
itens `…_HORA_INICIAL`, `…_HORA_FINAL` e `…_DATA_PONTO` (sem teste de app/página). Nada é gravado pelo
desenho; os atalhos usam `apex.item().setValue` e disparam as ações da página como a digitação.

## O que muda

**Pedido novo**
- Abertura "Pedir hora extra" — *peça antes de fazer: a hora extra só vale depois de autorizada* —
  com o caminho: você pede → quem aprova autoriza → você faz as horas e elas entram no ponto.
- **1. Quem vai fazer a hora extra?** Empresa e "Quem vai fazer". Tocar na caixa abre a lista (antes
  só o botãozinho do lado abria).
- **2. Em que dia?** Atalhos Hoje / Amanhã / Sábado e o dia por extenso ("amanhã, quinta-feira, 1 de
  outubro").
- **3. Em que horário?** "Começa às" e "Termina às" lado a lado. O **relógio de ponteiros**
  (bootstrap-clockpicker, que abria sozinho e começava na hora atual) foi trocado pelo **seletor de
  hora do próprio aparelho** (`input type="time"`): o mesmo do despertador do celular, e ele só
  aceita hora válida (a página aceitava "25:00"). O valor continua "HH:MM". Atalhos **1 a 4 horas**
  preenchem o fim a partir do começo. A **régua do dia** (0h–24h, madrugada e noite mais escuras)
  mostra o bloco pedido e "4 horas de hora extra, das 22:00 às 02:00 · termina no dia seguinte";
  avisa quando o fim é igual ao começo ou quando passa de 10 horas.
- **4. Por que precisa?** Começos de motivo que escrevem na caixa (Entrega com prazo curto, Cobrir a
  falta de um colega, Muito movimento, Inventário, Fechamento do mês, Manutenção fora do horário).
- Rodapé: "4 horas · amanhã, quinta-feira, 1 de outubro · 22:00 às 02:00", o que falta (o toque
  leva ao campo) e **Enviar pedido** (é o "Criar").

**Pedido gravado**
- Cabeçalho: nº, situação em cor, "Hora extra de Bruno Cirilo de Morais · matrícula 1864", o dia
  por extenso, "18:00 às 22:00 · 4 horas" na régua, o motivo e quem pediu e quando — no lugar dos
  campos soltos do alto e da região Hora Extra (só leitura).
- As abas Hora Extra · Aprovadores viram uma página só; a aprovação é o caminho das outras
  requisições. **Aprovar/Reprovar** entram no caminho quando há uma etapa pendente; fora disso ficam
  no lugar original, à vista sempre que a condição do botão (Valida_Sequencia) os mostrar (04/10).

## Cuidados

- As horas são um item **plugin** (`PLUGIN_DE.DANIELH.CLOCKPICKER`), não um campo de texto: o
  desenho remove o relógio que o plugin liga e troca o tipo do campo para `time`; o valor enviado
  continua "HH:MM". No "Criar", a validação "Valida Horas Extras" (`PKG_REQ_HE.fnc_VerifLimiteHorasExtras`
  e `fnc_ValBancoHrsTotalHrs`) confere o limite de horas e o banco de horas com esses valores.

- A ação da página no *focusout* das horas manda e devolve **os dois** horários. Enquanto ela está a
  caminho (e o servidor atende um pedido por vez na sessão), o campo pode aparecer vazio por um
  instante. O atalho de duração espera a página terminar (`ajaxStop`) antes de ler o começo e pôr o
  fim — senão a resposta atrasada apagava o fim recém-posto.
- A lista das abas deste app **envolve** as regiões (o `ul.apex-rds` contém a Hora Extra e os
  Aprovadores): esconder o contêiner das abas some com tudo. O CSS usa `display: contents` nele e
  esconde só os `li`.
- A região do alto (título "Abonar Marcação", sem cabeçalho) guarda os itens E, mais abaixo, as abas:
  o "topo" é o `.container` dos itens, nunca a região.

## Defeitos da página (não mexidos — são do APEX)

1. A região do alto se chama "Abonar Marcação" (cópia da página de abono; o título não aparece).
2. Situações sem acento no banco ("Concluida", "Suspensao") — o desenho acentua na tela.
3. Sem o desenho, a hora aceita qualquer texto ("25:00" passa pela ação da página).

## Não visto funcionando

- O **Enviar pedido** de verdade (nada foi enviado nos testes) e as mensagens de validação do servidor
  (alertify) com empresa e colaborador preenchidos.
- A tela de quem aprova com uma etapa pendente (Aprovar/Reprovar dentro do caminho).
- O seletor de hora num celular de verdade (testado no Chrome; iPhone e Android mostram o seletor
  deles).

## Desligar

Tire as duas URLs de arquivo da página 716 do app 9503.

## Regras da página (auditoria 04/10)

**Conferido** (exportação `f9503_page_716.ORIGINAL.sql`): 19 ações dinâmicas (28 ações), 2 validações,
9 processos, 25 itens, 5 botões. Nenhum processo `NC_` nosso: o desenho não grava nada.
- Ações de abertura (Hide Fields, Disable Fields) agem por ITEM, não por região: montar no `ready`
  não as atrapalha; o relógio só vira `type=time` se o campo não estiver desabilitado (a conferência
  de 700 ms roda depois do Disable Fields).
- Atalhos (dia, duração, motivo) gravam por `apex.item().setValue` (+ `focusout` nas horas): Valida_Data
  e Dois Pontos rodam. "Criar"/"Salvar" são os botões originais (só trocam de rótulo).
- "OK: Show Create" e "Hide / Show Aprovações" esconderiam botões, mas na exportação estão SEM botão
  afetado (defeito da página) — nada a respeitar.

**Mudou**
- Aprovar/Reprovar não saem mais de vista quando o desenho acha que não há etapa pendente: a
  condição do botão na página (Valida_Sequencia) é quem decide (`Natcorp_HoraExtra.src.js`, [J9]).
- A região Aprovadores só some vazia quando também não tem Aprovar/Reprovar nem a observação
  editável — ela guarda os dois botões e o OBS_APROVADOR.
- A caixa OBS_APROVADOR vazia só some se estiver só leitura (o aprovador pendente pode escrever).

**Para decidir**
- Pedido gravado sem "Salvar" (`nc-he-leitura`): os campos do alto e a região Hora Extra saem de
  vista e o cabeçalho mostra os mesmos dados. Nada editável se perde (sem Salvar não há gravação),
  mas o select COD_SIT_REQ (editável na página, com a ação Valida Sit Req) fica escondido nesse modo.

