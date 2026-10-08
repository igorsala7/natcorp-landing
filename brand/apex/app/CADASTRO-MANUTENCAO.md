# Requisição de Alteração Cadastral (app 200, página 136) e de Alteração de Endereço (página 134) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Público: gestores e colaboradores, muitos pelo celular e com pouca intimidade com sistemas.
O desenho troca a página de abas por **"O que você quer atualizar?"**: a pessoa toca no assunto
(Endereço, Telefone e e-mail, Banco e PIX…) e só aqueles campos aparecem, já com os dados de hoje.

## Arquivos (Workspace Images)

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Cadastro.css` | o desenho (gerado de `Natcorp_Cadastro.src.css` por `gerar-app.mjs`) |
| `Natcorp_Cadastro.js` | o comportamento (gerado de `Natcorp_Cadastro.src.js` por `gerar-cadastro.py`, com a ilustração embutida) |

A ficha do colaborador (foto, nome, empresa, situação, admissão) **não** vem daqui: é o padrão
global do `Natcorp_Style_Min.css`, igual em todas as páginas com a região "Colaborador".

## O contrato: classes nas regiões

Aplicadas por `aplicar-cadastro-pagina136.py` (pelos nomes das regiões; roda uma vez só):

| Região | Classe | Na tela |
| --- | --- | --- |
| Colaborador | `nc-cad-colaborador` | de quem são os dados |
| &P136_TITULO. | `nc-cad-solicitacao` | nº, data e solicitante no alto |
| Seletor | `nc-cad-seletor` | sai da tela (os cartões substituem as abas) |
| cada bloco de dados | `nc-cad-tema-XXX` | aparece quando o cartão do assunto é escolhido |
| Documentos (Upload) | `nc-cad-anexos` | a lista dos comprovantes que faltam |
| Botões | `nc-cad-acoes` | barra fixa: o que falta + "Enviar pedido" |

Assuntos (`XXX`): `endereco` · `contato` · `banco` · `pessoais` · `familia` (Mãe, Pai, Cônjuge) ·
`estudo` · `documentos` (Identidade, CPF, Reservista, Título, CNH, PIS, CTPS, Habilitação
Profissional) · `uniforme` (Medidas) · `deficiencia`.
**Bloco novo:** dê a ele uma classe de assunto existente. Sem classe, ele fica onde estava.

## A página 134 (Alteração de Endereço), 30/09

O MESMO par de arquivos. A 134 é a 136 recortada: Colaborador, "Requisição de Alteração Cadastral"
(solicitante), Dados Pessoais (só Estado civil) com Endereço, Contato e Formação dentro,
Documentos (UPLOAD_DOCS) e Botões no título da página.

- **Exportação aplicada** (`f200_page_134.sql`, original em `f200_page_134.ORIGINAL.sql`) por
  `aplicar-cadastro-pagina134.py`: as mesmas classes pelos mesmos títulos (Colaborador,
  &P134_TITULO., Endereço, Contato, Dados Pessoais, Formação / Escolaridade, Documentos,
  Botões), as duas URLs de arquivo e o comentário da página. O que a 134 não tem é pulado.
- Página ainda SEM as classes (uma cópia não aplicada): o JS põe as mesmas classes pelos títulos
  (o mapa `CONTRATO` do `.src.js`). Com as classes, esse caminho não entra.
  O prefixo (P134_ / P136_) vem do item `…_DATA_SOLICITACAO`.
- Cartões: Endereço, Telefone e e-mail, Meus dados ("Estado civil" — num bloco de 1 ou 2
  campos o cartão diz os próprios campos) e Estudo.
- Os botões moravam no título da página: depois de descer para a barra, o JS dispara o
  `apexwindowresized` do tema, senão sobrava o vão da altura medida na carga.
- Regra da própria página: para quem já tem pedido aberto, o alerta "Já existe a requisição N
  em andamento!" aparece ao escolher a matrícula.

## Comportamentos que valem saber

- **"Enviar pedido"** é só o texto do botão Criar; no APEX ele continua CREATE / Criar.
- **Antes → agora.** Os valores de hoje são guardados na carga; cada campo mudado mostra
  "antes: …" no rótulo e entra no resumo "Confira antes de enviar". Trocar de pessoa zera tudo.
- **Comprovantes.** O **servidor exige** o comprovante (validação fora da página: "Anexe o(s)
  seguinte(s) comprovante(s): …"). A lista na tela é deduzida do que mudou — só Endereço →
  Comprovante de Endereço foi confirmado contra o servidor. As associações ficam em `DOC_BLOCO`
  e `DOC_CAMPO` no `.src.js`, com os nomes da lista **Tipo Arquivo** da janela de anexo; o
  "Anexado" procura esse nome nas linhas do relatório de anexos.
- **Envio recusado.** O APEX redesenha a página em `/wwv_flow.accept` com o que foi DIGITADO.
  Para as marcas "antes" não sumirem, o JS guarda o retrato no envio (sessionStorage) e o
  devolve para a mesma empresa + matrícula.

## Desligar

Tire as duas URLs de arquivo da página. A ficha global do colaborador continua (é da skin).

## Regras da página (auditoria 04/10)

**Conferido** contra `f200_page_136.ORIGINAL.sql` (27 ações dinâmicas / 52 ações, 7 validações,
11 processos, 8 botões) e `f200_page_134.ORIGINAL.sql` (19 / 33, 1 validação, 11 processos, 7
botões). Não há processo `NC_…` nosso. As ações de abertura (Desabilita Campos, Esconde/Mostra
Mat, Esconde Campos Def., Popula URL_DOCS, Popula Campos na 134) acham os itens pelo NOME, não
pela região: montar no "ready" não as atrapalha. O desenho não grava, não valida e não escreve em
item (nenhum `setValue`); "Enviar pedido" é o próprio CREATE (com a DA dele). O CSS não força
`display` em campo, região ou botão.

**Mudou:**
- `[J7]` bloco com campo marcado pela VALIDAÇÃO da página (ex.: "Valida UF", "Valida Agência")
  fica escolhido sozinho: antes, num bloco não escolhido, a mensagem apontava para um campo fora
  da vista.

**Para decisão:**
- A região da solicitação (`&P13x_TITULO.`) sai da vista: nº e data aparecem no alto, mas o
  item `SOLICITANTE` e o botão `p13x_btn_solicitante` (ficha de quem pediu) ficam escondidos.
- Os blocos não escolhidos nos cartões ficam fora da vista (substituem as abas do Seletor —
  permitido); obrigatórios deles não entram no "Falta".
- O "antes" é lido 900 ms depois do "ready": na 134 a ação "Popula Campos (S/ Portal)" traz os
  dados por Ajax na abertura; se ela demorar mais, os campos aparecem como "mudados" e a lista de
  comprovantes pede documento à toa (só informativo; o servidor é quem exige).

## Portal do Colaborador — app 300, página 136 (04/10)

A mesma página existe no Portal, com o mesmo desenho (`Natcorp_Cadastro.js/.css`). Exportação
`f300_page_136.sql` aplicada com o mesmo `aplicar-cadastro-pagina136.py` (aceita app 200 ou 300;
original em `f300_page_136.ORIGINAL.sql`).

Diferenças do app 300: sem PIX (`CHAVE_PIX`, `TP_ID_CHAVE_PIX`) e sem os campos de estrangeiro
(`PAIS_RESIDENCIA`, `RESIDE_BRASIL`, `CLASS_TRAB_ESTRANG`, `TMPRESID`); 3 ações a menos (forca_valor,
Set old CPF, Limpa Digito); as validações de comprovante do 200 viram uma só, "Valida Documentos"
(pacote no servidor decide os comprovantes).

Ajustes no JS para o Portal: o cartão do banco vira "Banco" quando a página não tem `CHAVE_PIX`; no
alto, o nome vem de `MATRICULA_DISPLAY` quando a lista da matrícula mostra só o número.
Testado em 04/10 no Portal (celular 390 px e computador) numa aba de teste da mesma sessão, sem enviar.

## Portal — Alteração de Endereço, app 300 página 134 (04/10)

Mesmo desenho; `f300_page_134.sql` aplicada com `aplicar-cadastro-pagina134.py` (aceita app 200 ou 300;
original `f300_page_134.ORIGINAL.sql`). Igual à 134 do app 200, mais a validação "Valida comprovante
endereço" (exige o anexo tipo 18 quando o endereço muda). Nova regra no JS (vale nos dois apps): na 134
o bloco **Endereço já começa aberto** — só a tela; os outros blocos continuam a um toque.
Testado pelo caminho real (133 → "Pedir mudança de endereço" → 134) numa aba de teste, sem enviar.
