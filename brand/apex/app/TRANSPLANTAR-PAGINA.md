# Transplantar uma página do APEX para outro app / workspace / base

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

O APEX só instala a exportação de uma página no app de onde ela saiu. `transplantar-pagina.py`
converte o arquivo para o destino, e o resultado importa pelo App Builder de lá como se a página
tivesse sido exportada ali — sem sobrepor o app inteiro.

```
python3 transplantar-pagina.py f200_page_17.sql --destino f207.sql
python3 transplantar-pagina.py f200_page_17.sql --destino f207.sql -o f207_page_17.nova.sql
python3 transplantar-pagina.py PAGINA.sql --destino DESTINO_COMPLETO.sql --origem ORIGEM_COMPLETO.sql   # apps diferentes
```

**Pelo navegador:** abra `transplantar-pagina.html` (duplo clique; funciona sem internet e nenhum
arquivo sai do computador). Solte as páginas, o destino e — só para apps diferentes — a origem
completa, e toque em Converter: cada página vem com o relatório e o botão para baixar o `.sql`
(`f<app>_page_<n>.transplantada.sql`). Mesma lógica do script, conferida: o arquivo baixado é
idêntico ao `f207_page_17.sql` que o APEX exportou.

`--destino` pode ser a exportação COMPLETA do app de destino (confere tudo) ou só uma exportação de
página de lá (confere o que aquela página usa; o resto sai como "NÃO CONFERIDO").

## O que o script faz

1. Troca o cabeçalho `import_begin` pelo do destino (workspace, app, deslocamento, dono).
2. Traduz os IDs (`wwv_flow_api.id(N)`):
   - **mesma linhagem** — cópias do mesmo app. Todo ID difere por UMA constante. O script a mede
     (diferença dos `p_default_id_offset` dos cabeçalhos; se não bastar, pela interface de
     usuário) e só aceita se **todas** as referências externas da página existirem no destino;
   - **por nome** — apps que não são cópias. Cada componente compartilhado que a página usa
     (modelos de página/região/rótulo/botão/relatório, breadcrumb, grupo de páginas, interface,
     autorização, lista…) vira o do destino com o mesmo tipo e nome (e o mesmo "pai"). Os
     componentes da própria página ganham IDs novos, conferidos contra o destino.
3. Para e explica quando não dá: componente sem correspondente ou ambíguo, colisão de IDs, destino
   em versão mais antiga. Avisa links com o número do app de origem escrito à mão (`f?p=200:`) e
   código que cita o esquema de origem.

**A página de destino é substituída inteira** (o arquivo começa com `remove_page`): exporte a de
lá antes. Tabelas, pacotes e funções do SQL/PL/SQL precisam existir no esquema de destino.

## O que foi medido (29/09/2026) — a prova

| Caso | Resultado |
| --- | --- |
| página 17: app 200 → 207 (outro workspace, mesmo banco) | **idêntico** ao `f207_page_17.sql` exportado pelo APEX (só a linha da data muda) |
| página 17: app 207 → 202, **por nome** (sem usar a constante) | **idêntico** à página 17 dentro do `f202.sql` |
| página 17: app 207 → 202, mesma linhagem | idêntico à página 17 dentro do `f202.sql` |
| página 168: app 200 da outra base → base certa, com **só uma página** de referência | 495 de 495 IDs iguais (constante −1521564454019637036, achada pela interface de usuário; a do cabeçalho não servia) |

- 202 × 207 (cópias em workspaces diferentes): os 44.137 IDs diferem pela diferença exata dos
  `p_default_id_offset`; fora o cabeçalho, mudam só o dono (`p_owner`) e o alias (`p_alias`).
- Entre BASES diferentes a constante não é a dos cabeçalhos — por isso o script mede e confere.
- No 19.2 o `create_row_template_patch` usa o MESMO id do `create_row_template` que ele estende.

## Ainda não tratado: descer de versão (5.0 / 5.1 / 18.2 / 19.2)

Os parâmetros dos `wwv_flow_api.create_*` mudam entre as versões; uma página do 19.2 traz
parâmetros que o 5.0 não conhece. Para o script tirar o que o destino não aceita, falta o catálogo
de cada versão — rodar em UMA base de cada versão e salvar o resultado em CSV:

```sql
select object_name, argument_name, position
  from all_arguments
 where owner = 'APEX_190200'          -- APEX_050000, APEX_050100, APEX_180200
   and package_name = 'WWV_FLOW_API'
 order by object_name, position;
```

Tipos de região que não existem na versão antiga (Interactive Grid antes do 5.1, gráficos JET)
não têm conversão: o script vai parar e dizer quais são.
