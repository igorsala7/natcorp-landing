# Consultas do Portal — o motor `Natcorp_Consulta` (app 300)

As páginas de consulta do Portal do Colaborador eram relatórios interativos; o colaborador quer VER
os pedidos dele de forma clara, no celular — as ferramentas do relatório ficam em segundo plano
(pedido de 04/10). Um motor só serve a todas: lê o relatório pelos TÍTULOS das colunas e monta
cartões. O que é de cada página fica numa RECEITA. A consulta de Férias (300:77) tem desenho próprio
(`Natcorp_FeriasConsulta`), mais rico.

Arquivos: `Natcorp_Consulta.src.js` / `.src.css` → `../login/Natcorp_Consulta.js` / `.css`.
JS: `python3 gerar-consulta.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-consulta.py f300_page_NNN.sql` (genérico: app 300, item P<n>_OK, IR).

| Página | Receita | Aplicada |
|---|---|---|
| 133 Alteração de Endereço | `P133_` — "Seus pedidos de mudança de endereço", "Pedir mudança de endereço", lembra do comprovante; mesma tabela e regra da 135 | 04/10 (`f300_page_133.ORIGINAL.sql`) |
| 135 Alteração Cadastral | `P135_` — "Seus pedidos de alteração de dados", "Pedir alteração de dados", situação "Em andamento" (toda linha de INF_PESSOAIS_PORTAL é pedido em andamento: a 136 recusa outro), um pedido por vez | 04/10 (`f300_page_135.ORIGINAL.sql`) |

## Como fica

- **Colaborador** (quando a página mostra): cartão curto com foto, nome, matrícula, situação,
  admissão e o botão original "Visualizar".
- **Criar**: o botão ORIGINAL (por texto: Criar/Novo/Incluir/Adicionar), grande, com o texto da receita.
  Receita com `umAberto` e um pedido aberto na lista: "Ver meu pedido" vira o principal, o criar fica
  discreto e um aviso explica que já há um pedido em andamento.
- **Cartão**: "Pedido N" (coluna Requisição/Pedido), "feito em …" (1ª coluna Data…), a situação com as
  cores do sistema (coluna Situação/Status, ou a da receita), "Pedido por" e "Colaborador" só quando
  não são a própria pessoa, empresa só com mais de uma na lista, os outros dados com o título da
  coluna (6 à vista, o resto em "Mais N dados"), "Ver pedido" (o lápis da linha). Dado que é a
  própria pessoa ("205818 - Tony Oliveira") não aparece — no Portal quem vê é ela.
- **Situação**: com coluna de situação e mais de uma: botões com a contagem e a bolinha da cor;
  cancelados e reprovados guardados atrás de um botão em "Todos".
- **Tabela**: "Ver como tabela" / "Ver em cartões" (por página, no aparelho).

## Nova consulta

1. Exporte a página e rode `aplicar-consulta.py`.
2. Se quiser textos próprios, crie a receita em `[K2]` do JS com o prefixo dos itens (`P117_`…).
   Sem receita: "Seus pedidos", o rótulo original do botão, e a situação da coluna.

## Cuidados

- O `.a-IRR` é montado pelo JS do relatório DEPOIS dos arquivos da página: o motor reconhece a página
  por P<n>_OK e procura o relatório na montagem (0 s, 0,8 s, apexreadyend, 3 s).
- Em cartões esconde a cópia grudenta do cabeçalho (`.nc-sticky-header-clone`, arquivo da equipe).
- Fica fora do Tabela/Cartões geral (`Natcorp_Registros`): página com desenho próprio.
- Testado em 04/10 no Portal: 135 (sem pedidos: o vazio) e, com dados, a 117 Treinamento (13 pedidos,
  4 situações) — celular e computador, abas de teste da mesma sessão.

## App 300 inteiro (f300.sql) — 04/10

O app 300 é alterado direto na exportação COMPLETA. `./montar-f300.sh` monta o `f300.sql` a partir da
exportação intocada `f300.ORIGINAL.sql` (sempre do zero, mesmo resultado):

1. `aplicar-consultas-app300.py` — o motor nas 41 páginas de relatório interativo da lista `PAGINAS`
   (com receita por página em `[K2]`). Fora: 3, 47 (Abono Individual), 29, 96, 100, 106 (o relatório é
   parte de uma tela de trabalho), 77 (desenho próprio), 108 (Linha do Tempo).
2. `aplicar-redesenhos-app300.py` — os desenhos já feitos nas MESMAS páginas de outros apps:

| 300 | Desenho (de) | Observação |
|---|---|---|
| 17 Dados Funcionais | Ficha (200:17) | sem as seções Benefícios/Dependentes (não existem no 300) |
| 54 Editar Dependentes | Dependentes (200:132) | cópia antiga aberta pelas 22 e 58; sem região Documentos |
| 108 Linha do Tempo | LinhaTempo (200:108) | processo NC_LINHA_TEMPO_DADOS novo (id com o nº do app) |
| 118 / 120 Treinamento / Curso | Treinamento (200:118/120) | na 120, "Colaborador Solicitante" no lugar de "Solicitante"; sem Aprovadores |
| 132 Editar Dependentes | Dependentes (200:132) | |
| 168 Editar Benefícios | Beneficios (200:168) | regiões novas com ids da faixa fixa 28299916800000000NN |
| 714 Marcação - Abono | Abono (9503:714) | |
| 716 Hora Extra | HoraExtra (9503:716) | |

Não levados: 140/144 Avaliação (a do 300 é outra página — metade das regiões difere), 863 GED
(variante sem Filtros/Terceiros — fica com o motor), 38 e 53 (cópias antigas da 136/134 que nada abre),
3 (Ponto 9503:203 tem só 47% dos campos). O executor roda o script de sempre sobre o trecho da página
(regiões opcionais e nomes alternativos por variável de ambiente, só nele); confere que nada fora das
páginas mudou e que nenhum identificador novo se repete. Texto que vai para a exportação: só Latin-1.

**Testar antes de importar:** a prévia do navegador mostra o motor das consultas (injeta os arquivos);
os desenhos da tabela acima dependem das classes da exportação — só aparecem com o f300.sql importado
(importar primeiro em dev).
