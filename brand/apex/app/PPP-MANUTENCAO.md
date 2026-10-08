# Requisição de PPP / Laudo (app 2943, página 61) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A janela aberta pela aba **Requisição de PPP** do Painel do Operador (200:775 embute o app 2943; a
lista é a página 60, "Criar Requisição" e cada pedido abrem a 61). O gestor pede um documento de
saúde e segurança do trabalho para um colaborador; o Médico do Trabalho e o Técnico de Segurança
analisam e registram o andamento em "Desdobramentos".

| Arquivo | O quê |
| --- | --- |
| `Natcorp_PPP.css` | o desenho (gerado de `Natcorp_PPP.src.css` por `gerar-app.mjs`) |
| `Natcorp_PPP.js` | o comportamento (gerado por `gerar-ppp.py`) |

App 2943 › Página 61 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_PPP.js` (no fim da
lista); CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_PPP.css`. Já aplicado em `f2943_page_61.sql`
por `aplicar-ppp.py` (original em `f2943_page_61.ORIGINAL.sql`); numa exportação nova já aplicada, o
script só troca o comentário da página. Reconhece a página pelos itens
`…_TIPO_SOLICITACAO` e `…_MATRICULA_SOLICITADO` (sem teste de app/página). Nada é gravado pelo
desenho; o toque num cartão faz `apex.item().setValue` na lista de verdade.

## O que muda

**Pedido novo**
- Abertura "Pedir PPP ou laudo" com o caminho do pedido: você pede → o Médico e o Técnico analisam →
  o documento fica pronto neste pedido.
- **1. Para quem é?** Empresa e Colaborador (os campos do alto, sem nº nem situação).
- **2. O que você precisa?** A lista "Objeto da Solicitação" vira 4 cartões com o nome por extenso e
  para que serve: PPP, LTCAT, LI (Laudo de Insalubridade) e Perícia. Código desconhecido na lista
  vira cartão só com o texto dela.
- **3. Conte mais e anexe** (opcional), com exemplo no campo.
- Acima dos botões: "Falta: Empresa · Colaborador · O documento" (o toque leva ao campo) ou "Tudo
  certo. Pode enviar."; "Criar" → **Enviar pedido**.
- O Acompanhamento (Desdobramentos) não aparece antes de o pedido existir.

**Pedido gravado**
- Cabeçalho: nº, situação em cor (Concluída / aprovada = verde, reprovada = vermelho, cancelada =
  neutro, o resto = amarelo), o documento, para quem (nome + matrícula), quem pediu e quando — no
  lugar dos campos soltos do alto.
- As abas Detalhes · Aprovadores · Desdobramentos viram uma página só: **O que foi pedido** (o
  cartão do documento, a observação e "Baixar o anexo (85KB)"), o **caminho da aprovação** (o mesmo
  das outras requisições; Aprovar/Reprovar dentro para quem aprova) e o **Acompanhamento**.
- Só leitura (sem botão Salvar à vista): somem as caixas vazias (observação, observação do
  aprovador) e a área de arrastar arquivo.
- Título da janela: "Pedir PPP ou laudo" / "Pedido nº 57700 · PPP / laudo".

## Defeitos da página (não mexidos — são do APEX)

1. A lista de desdobramentos mostra o HTML do ícone do usuário como texto — o desenho troca pelas
   iniciais de quem escreveu. A causa está na consulta da região Desdobramentos, coluna `user_icon`:
   `'<span> <aria-hidden="true" class="fa fa-user fa-2x"></span>'` é HTML malformado (o certo seria
   `<span aria-hidden="true" class="fa fa-user fa-2x"></span>`) e a coluna sai escapada.
2. Os desdobramentos do pedido 57700 dizem só "CR----" (texto gravado assim; parece um código de
   status montado sem os campos).
3. Situações sem acento no banco ("Concluida") — o desenho acentua na tela.

## Não visto funcionando

- O **Enviar pedido** de verdade (nada foi enviado nos testes) e as validações do servidor.
- A tela de quem aprova e a do Médico/Técnico (Aprovar/Reprovar, Adicionar desdobramento).
- Um pedido com vários aprovadores e um reprovado.

## Desligar

Tire as duas URLs de arquivo da página 61 do app 2943.

## Regras da página (auditoria 04/10)

Conferido contra `f2943_page_61.ORIGINAL.sql`: 11 ações dinâmicas (Cancel Dialog, fechar após
Aprovar/Reprovar, alertify, "Hide Fields" na abertura, Dispara Alerta, mostrar/esconder o Salvar por
P61_ITEM_VALIDACAO, Valida Sit Req, Sinaliza preenchimento, atualizar Desdobramentos), sem validações,
7 processos (número do pedido, DML do formulário, Post_Insert, Post_Update, fechar, padrões do painel
PC, init), 7 botões (Salvar/Aprovar/Reprovar com condição de servidor; Delete Never). Os cartões
escrevem na lista por `setValue` e somem/ficam só leitura com ela; os botões são os originais.

**Mudou:** `desenharLeitura()` — a "Observação do Aprovador" vazia não some mais quando a página a
deixa editável (aprovador com etapa pendente); continua saindo a caixa vazia que é só leitura.

**Para decidir:**
- Pedido gravado sem o Salvar à vista: os campos do alto saem da vista (o cabeçalho os repete), e
  entre eles está a **Situação** (P61_COD_SIT_REQ), que a página deixa como lista editável, com a
  ação "Valida Sit Req". Sem Salvar nada grava, mas a ação PL/SQL roda ao trocar — conferir se a
  troca de situação nessa tela é de uso de alguém.
- A observação vazia some no modo leitura mesmo sendo campo editável (sem Salvar não há como gravar).
- A Observação do Aprovador não tem processo que a grave na página (é coluna de outra região e o
  Aprovar/Reprovar só redireciona); a condição de só leitura consulta `APROVA_ABONO` (tabela do abono,
  não do PPP) — defeito da página, não mexido.
- As abas viram uma página só (`.a-Tabs-panel` sempre à vista); hoje nenhuma ação esconde região.

**Diagnóstico (04/10, cliente: "PPP precisa salvar"):** `P61_OBS_APROVADOR` é item `DB_COLUMN`, e o
processo de gravação é `NATIVE_FORM_DML` (formulário novo, fonte na região), que ignora itens
`DB_COLUMN` — por isso nunca gravou, nem antes do desenho. A condição de só leitura dele consulta
`APROVA_ABONO` (tabela de outro assunto); a da PPP é `APROVA_SOLICITACAO_PPP`. Correção proposta, só
depois de confirmar que a coluna `SOLICITACAO_PPP.OBS_APROVADOR` existe: item com fonte
`REGION_SOURCE_COLUMN` na região do formulário (122393573600097451979) e a condição na tabela certa.

**Decidido (04/10, cliente):** o desenho fica como está; o ajuste do OBS_APROVADOR na página é do programador.
