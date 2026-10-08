# Ontologia de recrutamento — instalação e uso

Compara **cada candidato do banco de talentos** com os **requisitos da requisição de pessoal** e dá
uma nota de aderência explicável, item por item. Substitui a comparação "por palavras" feita na
tela por uma **ontologia**: conceitos (formações, cursos, conhecimentos, ocupações, áreas), os vários
nomes de cada um (sinônimos, siglas, abreviações) e as relações entre eles (mais amplo/mais
específico, relacionado).

Tudo fica em objetos `ONT_*` próprios. **Nenhuma tabela existente é alterada.**

## Instalação (nesta ordem)

| # | Script | O que faz | Altera? |
|---|---|---|---|
| 00 | `00_conferir.sql` | Confere tabelas, colunas, privilégios e pacotes; mostra as escalas da base | só lê |
| 01 | `01_tabelas.sql` | Cria as tabelas `ONT_*` | cria |
| 02 | `02_ont_texto.sql` | Tipos + pacote `ONT_TEXTO` (normalizar e comparar texto) | cria |
| 03 | `03_visoes.sql` | `ONT_V_CANDIDATO` (montada sozinha: acha cada coluna em `INF_PESSOAIS_CANDIDATO` ou `INF_FUNC_CANDIDATO`) e `ONT_V_CAND_FONTE` | cria |
| 04 | `04_ont_ontologia.sql` | Pacote `ONT_ONTOLOGIA` (conceitos, classificação, curadoria) | cria |
| 05 | `05_ont_aderencia.sql` | Pacote `ONT_ADERENCIA` (a nota) | cria |
| 06 | `06_municipios.sql` | Coordenadas dos 5.571 municípios (IBGE) | carrega |
| 07 | `07_carga.sql` | Ajustes, pesos, vocabulário, **179 conceitos / 570 termos / 43 relações** e o catálogo `HABILIDADE` da base | carrega |
| 09 | `09_testes.sql` | **56 testes** (comparação, classificação, falsos positivos, hierarquia, distância, escalas). Termina com erro se algum falhar | só lê |
| 08 | `08_rotina.sql` | Agenda a rotina noturna (02:00) | agenda |

Rodar como o **dono das tabelas de RH** (ou um esquema com acesso a elas), em SQL*Plus, SQLcl ou
SQL Developer ("Executar script", F5). Todos os arquivos são ASCII puro: o resultado não depende do
`NLS_LANG` do cliente.

**O 03 para com erro** se um mesmo `COD_CANDIDATO` aparecer duas vezes (sinal de que a chave do
candidato inclui a empresa) — nesse caso, avise antes de seguir: a junção da visão precisa mudar.
Os scripts criam tudo com `nls_length_semantics = char` (tamanhos em caracteres, não bytes).

**Antes do 01:** o `00_conferir.sql` não pode mostrar `FALTA` nas partes 1 e 3. `AVISO` na parte 2 é
aceitável (o critério correspondente fica sem dado). Confira na parte 4 se os códigos de
`TIPO_MODALIDADE` batem com o padrão (H = home office, T = teletrabalho, S = semipresencial,
P = presencial) — se não baterem, ajuste `MODALIDADES_SEM_DISTANCIA` e `MODALIDADES_PARCIAIS`
(abaixo).

**Depois do 07:** confira as duas listas que ele imprime (ordem da instrução e dos níveis de
conhecimento). Corrija o que vier vazio ou errado:

```sql
update ont_instrucao_ordem set ordem = 9, conferido = 'S' where cod = '9';
update ont_nivel_ordem     set ordem = 4, conferido = 'S' where codigo = '5';
commit;
```

**Primeira carga** (o banco inteiro; rode fora do horário de uso e veja o tempo em `ONT_LOG`):

```sql
exec ont_aderencia.rotina_noturna
select * from ont_log order by id desc;
```

## Como a nota é calculada

`nota = Σ(peso × nota do critério) ÷ Σ(peso) × 100`, **só com os critérios que se aplicam à vaga**.

| Critério | Quando entra | Nota |
|---|---|---|
| Instrução | sempre que a requisição tem | nível ≥ pedido: 1 · um degrau abaixo: 0,5 |
| Formação, Curso, Conhecimento, Experiência | cada item da requisição | mesmo conceito ou **mais específico**: 1 · mais amplo: 0,5 · relacionado: o peso da relação · não concluído: × 0,5 · habilidade com nível abaixo: × 0,6. Requisito que não virou conceito: comparação de texto |
| Tempo de experiência | anos/meses pedidos | anos somados **sem contar duas vezes empregos simultâneos** ÷ anos pedidos |
| Idioma | cada idioma pedido | mesmo idioma com nível ≥: 1 · nível abaixo: 0,5 |
| **Distância** | vaga **presencial** (semipresencial com peso pela metade). **Home office e teletrabalho: não entra** | até 10 km: 1 · cai em linha reta até 60 km: 0 |
| **PCD** | só em **vaga PCD** | PCD de um dos tipos marcados na vaga: 1 · PCD de outro tipo: 0,5 · não PCD: 0 e **marcado como eliminado** (vai para o fim da lista, com o motivo) |
| Cargo pretendido | o candidato informou | o da vaga: 1 · outro: 0 |
| Local pretendido | o candidato informou e a vaga é presencial | o da vaga: 1 · outro: 0 |
| Salário | os dois informados | pretensão ≤ teto da vaga: 1 · até 20% acima: cai até 0 |

**Idade e sexo da requisição não entram na nota** (CLT art. 373-A; Lei 9.029/95).

### Distância — de onde vem cada ponto

- **Candidato:** coordenada do próprio CEP, se `ONT_GEO_CEP` tiver o CEP → senão o **município do
  CEP** (`TABELA_CEP.COD_MUN_IBGE`) → senão o município pelo **nome da cidade + UF**.
- **Vaga:** o mesmo para o **local de trabalho** da requisição → senão o município da **filial**.
- A distância é a linha reta × 1,25 (estimativa do caminho por ruas).
- **Precisão:** com município, a distância é **entre municípios** — dois endereços na mesma cidade
  dão 0 km (a evidência diz "distância entre municípios"). Para precisão de bairro/rua, carregue
  `ONT_GEO_CEP` (CEP → latitude/longitude, por exemplo de um serviço de geocodificação); ela passa
  a ter prioridade sozinha, sem mudar mais nada.

### Ajustes (`ONT_CONFIG`) e pesos (`ONT_PESO`) — PODE MEXER

```sql
select * from ont_config;   -- RAIO_IDEAL_KM, RAIO_MAXIMO_KM, FATOR_ROTA, MODALIDADES_SEM_DISTANCIA,
                            -- PCD_MODO (ELIMINATORIO | PESO), DISTANCIA_SEM_DADO (NEUTRO | ZERO) ...
select * from ont_peso;     -- peso exigido / desejável de cada critério; ATIVO = 'N' desliga
update ont_config set valor = '15' where chave = 'RAIO_IDEAL_KM'; commit;
```

## Usar

```sql
exec ont_aderencia.calcular(12345)            -- uma requisição (cod_req)
exec ont_aderencia.calcular_processo(57463)   -- pelo nº do processo seletivo

-- o ranking: eliminados por último, depois a maior nota
select a.cod_candidato, a.pct, a.exig_ok || '/' || a.exig_total exigidos, a.distancia_km, a.eliminado, a.motivo
  from ont_aderencia a where a.cod_req = 12345
 order by a.eliminado, a.pct desc, a.exig_ok desc, a.distancia_km nulls last;

-- por que este candidato tem esta nota
select criterio, requisito, exige, peso, nota, evidencia
  from ont_aderencia_item where cod_req = 12345 and cod_candidato = 987 order by seq;

-- JSON pronto para a tela (o Ajax Callback da página chama isto)
select ont_aderencia.ranking_json(12345, 50) from dual;
```

## Curadoria — como a ontologia aprende

A rotina noturna põe em `ONT_PENDENTE` os textos do cadastro (formação, curso, habilidade, cargo
dos empregos) e das requisições **que não viraram nenhum conceito**, agrupados, com quantas vezes
aparecem e uma **sugestão**. Os mais frequentes primeiro:

```sql
select p.id, p.ocorrencias, p.origem, p.exemplo, c.nome sugestao
  from ont_pendente p left join ont_conceito c on c.id = p.sugestao_id
 where p.status = 'ABERTO' order by p.ocorrencias desc;
```

Para cada um, uma de três ações (cada uma já reclassifica quem tinha aquele texto):

```sql
-- é outro nome de um conceito que existe
exec ont_ontologia.resolver_pendente(p_pendente_id => 15, p_conceito_id => 42)

-- é um conceito novo (opcional: dizer de qual ele é um tipo)
declare v number; begin
  v := ont_ontologia.criar_conceito_de_pendente(15, 'FORMACAO', 'Gestão de Seguros', p_amplo_id => 7);
end;
/
-- não interessa
exec ont_ontologia.ignorar_pendente(15)
commit;
```

Criar e ligar conceitos à mão:

```sql
declare v number; begin
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Analista de Processos',
         'Analista de Melhoria Contínua; Analista de Processos Sr', p_amplo => 'Gestão da Qualidade');
  ont_ontologia.relacionar(v, 'RELACIONADO', ont_ontologia.conceito_id('OCUPACAO', 'Analista de Negócios'), 0.5);
  ont_ontologia.recalcular_fecho;
  commit;
end;
/
```

A ontologia inicial está em `gerar_carga.py` (legível, com acentos). Para mudar a **carga
inicial**, edite o `.py` e rode `python3 gerar_carga.py`: ele confere se dois conceitos disputam o
mesmo termo e gera de novo o `07_carga.sql` e o `09_testes.sql`.

## Comparação de texto — as regras

O mesmo normalizador vale para termos, cadastro e requisição: minúsculas, sem acento, sem
pontuação (`NR-35` → `nr35`, `T.I.` → `ti`, `PL/SQL` → `plsql`, `C#` → `csharp`), sem palavras fracas
(`de`, `da`, `em`… em `ONT_PALAVRA_FRACA`), abreviações que não são começo da palavra expandidas
(`an.` → analista, em `ONT_ABREVIACAO`) e plural → singular. Duas palavras casam se forem iguais; se
a do texto for o **começo** da outra com 3+ letras **e não for uma palavra conhecida** (`adm` casa
com administração, mas "excel" não casa com "excelente" nem "java" com "javascript"); ou, com 6+
letras, se diferirem em **uma letra** (erro de digitação). Um conceito é reconhecido numa linha
quando **todas** as palavras de um dos seus nomes aparecem nela; fica o mais específico.

## Rotina noturna (`ONT_ROTINA_NOTURNA`, 02:00)

1. refaz o fecho da hierarquia;
2. reclassifica **só os candidatos alterados** desde a última rotina (a 1ª vez, todos);
3. recalcula **todas as vagas abertas** (`COD_SIT_REQ = 5` com processo seletivo);
4. apaga resultados de vagas que fecharam.

Erros de uma vaga não param as outras (ficam em `ONT_LOG`).

## Desinstalar

`99_remover.sql` apaga todos os objetos `ONT_*` e a rotina. A curadoria se perde — exporte
`ONT_CONCEITO`, `ONT_TERMO` e `ONT_RELACAO` antes, se quiser guardar.

## Próximo passo (tela)

Com isto instalado, o `NC_BT_VAGA` da página 182 passa a chamar
`ont_aderencia.garantir(cod_req)` e `ont_aderencia.ranking_json(...)`, e o Banco de Talentos mostra
o ranking do **banco inteiro** (não só os 50 da página) com a evidência de cada critério.
