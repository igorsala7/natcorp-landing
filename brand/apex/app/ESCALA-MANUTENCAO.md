# Requisição de Escala para Colaborador (a janela "Criar/Editar") — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Quem pede é o gestor ou o próprio colaborador, muitas vezes com pouca prática e pelo celular.
A janela vira **5 passos** (o mesmo desenho numerado do Desligamento), e os "Não/Sim" viram
escolhas que se explicam sozinhas:

1. **Quem vai mudar de escala?** (no plantão: "Quem vai fazer o plantão?") — Empresa, Colaborador.
2. **O que você precisa?** — o item *Plantão?* em dois cartões: **Mudar a escala** (N) /
   **Fazer plantão** (S). **"Onde vai ser o plantão?"** (o C.Custo Plantão) fica sempre à vista;
   a página só o libera no plantão (04/10).
3. **Qual vai ser a nova escala?** (plantão: "Como vai ser o plantão?") — Local de trabalho,
   Jornada ("Quantas horas a pessoa trabalha."), Escala ("Os dias e os horários de trabalho.").
4. **Por quanto tempo?** — o item *Exceção* em dois cartões: **Definitiva** (N) / **Só por um
   tempo** (S) + Começa em / Termina em e o resumo: "De 01/10/2026 a 15/10/2026 · 15 dias. Depois
   volta a escala de hoje." Fim antes do início: aviso em vermelho.
5. **Por que você está pedindo?** — Motivo, "Explique o pedido" (a Justificativa).

Cada passo mostra "Falta N campos" / "Pronto". O rodapé lista o que falta (tocar leva ao campo; no
celular os três primeiros e "+N") e **Criar** aparece como **Enviar pedido**. Com uma aba só
("Escala"), a barra de abas sai; volta quando há a aba Aprovadores (pedido gravado).

## Arquivos (Workspace Images)

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Escala.css` | o desenho (gerado de `Natcorp_Escala.src.css` por `gerar-app.mjs`) |
| `Natcorp_Escala.js` | o comportamento (gerado por `gerar-escala.py`) |

Na página: JavaScript › URLs de arquivo `#WORKSPACE_IMAGES#Natcorp_Escala.js`; CSS › URLs de
arquivo `#WORKSPACE_IMAGES#Natcorp_Escala.css`. **Sem classe no APEX e sem teste de app/página**:
o script trabalha com os itens `P179_*` (se não os achar, não faz nada).

## O que é da página (não do desenho) — lido das ações dinâmicas em 29/09

- *Plantão = Sim*: PL/SQL valida (SEMCONSELHO / ERR_MSG) e o C.Custo Plantão é liberado;
  *Não*: ele é limpo e travado. A lista de Jornada depende de Plantão, Empresa e C.Custo Plantão.
- Escolher a Escala: PL/SQL valida e, se houver erro, abre o alerta (ERR_MSG, alertify).
- *Empresa* ou *Exceção* mudam `P179_MOSTRA_CRIAR` (PL/SQL). Quando é "N" a página **esconde o
  Criar e põe Exceção = Sim** — a empresa só aceita pedido por um tempo. Se a pessoa escolheu
  "Definitiva" e voltou sozinho, a tela explica: "Nesta empresa a troca definitiva não é feita por
  aqui: o pedido fica como Só por um tempo."
- Pedido gravado (P179_ROWID): a região Requisição e a aba Aprovadores aparecem.
- **Regra da folha**: nada põe `display` no botão Criar nem nos contêineres dos itens (as ações
  dinâmicas escondem/mostram; o gerador põe !important).
- A Skin trava o rádio em 38 px (`.apex-item-grid-row` com overflow escondido) e dá
  `min-width: max-content` à opção — os cartões desfazem os dois só dentro deles.

## Pedido já gravado (edição) — 29/09

- **Cabeçalho do pedido** no lugar da região Requisição: "Pedido de escala nº …", "Aberto em …",
  a situação em selo colorido (verde aprovado, vermelho recusado/cancelado, âmbar aguardando) com
  "desde …". Se o item Situação estiver liberado para quem abriu, o campo vai para dentro do
  cabeçalho (é o mesmo campo, só mudou de lugar). A região original fica escondida.
- **Aprovação** vira uma linha do tempo (quem, o que decidiu, quando e a justificativa), lida do
  relatório da aba Aprovadores (`th#APROVADOR`); redesenha a cada atualização do relatório.
- A barra de abas some quando sobra só uma aba ou quando a aprovação já está na tela — menos
  quando a aba Aprovadores tem botões da página (Aprovar, Reprovar, Aprovar termo) (04/10).
- **Jornada**: no pedido gravado ela é exibição (`span#P179_COD_JORNADA_DISPLAY`) e o valor vai no
  item oculto `P179_COD_JORNADA` ("117"). O script só encurta o TEXTO da exibição para
  "117 · DAS 08:00 AS 13:00…"; **o item enviado nunca é tocado**.

## Desligar

Tire as duas URLs de arquivo da página.

## Exportação aplicada (30/09)

`aplicar-escala-pagina179.py` aplicou em `f9503_page_179.sql`: URLs do Natcorp_Escala (JS e CSS) e o
comentário da página; o resto do arquivo é idêntico ao exportado (conferido). Backup `.ORIGINAL.sql`.

## Regras da página (auditoria 04/10)

**Conferido** (exportação `f9503_page_179.ORIGINAL.sql`): 13 ações dinâmicas (27 ações), 6 validações,
9 processos, 26 itens, 9 botões, região Escala só leitura com ROWID. Nenhum processo `NC_` nosso:
o desenho não grava nada.
- Montagem 40 ms depois do `ready`: as ações de abertura (Nova Requisicao, Desabilita C.Custo,
  Mostra/Oculta Botões) agem por id de região, item e botão — mover os campos não as atrapalha.
- Cartões de Plantão/Exceção: são os rádios do APEX (o clique é no rádio; `change` → ações). O
  "Exceção = Sim" forçado pela página aparece sozinho no cartão.
- CSS: os contêineres respeitam `style="display:none"` (`:not([style*="none"])`); nada força o Criar.
- "Enviar pedido" é o Criar original; a lista "Falta" só informa, não bloqueia.

**Mudou**
- O "Onde vai ser o plantão?" não some mais fora do plantão: a página só o limpa e desabilita
  (`Natcorp_Escala.src.js`, [J8]).
- A barra de abas fica quando a aba Aprovadores tem Aprovar/Reprovar/Aprovar termo: antes, com a
  aprovação desenhada no fim do formulário, a barra sumia e esses botões ficavam presos na aba
  escondida (`Natcorp_Escala.src.js`, [J4] abas()).

**Para decidir**
- Pedido gravado: a região Requisição sai e o cabeçalho mostra nº, data, situação e "desde"; o item
  Situação (editável na página) vai para o cabeçalho. Nenhum dado some, mas é região escondida pelo
  desenho.

