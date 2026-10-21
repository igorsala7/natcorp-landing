# Resumo do quadro de posições (headcount) — página 30 do app 200

Pedido (13/10/2026): a consulta "Headcount" (as posições/vagas do `cl_vaga`) fácil para quem tem pouca
instrução, com o olhar de RH/DP de **controle do quadro**. A página continua igual (relatório, Pesquisar,
a região Centro de Custo quando vem de outra tela); acima do relatório entra o **Resumo do quadro de
posições**, da mesma família dos resumos de Afastamentos, Férias, Quadro e Acidentes. Abre fechado (só
os 5 números); "Ver análise completa" abre o resto; "Tela cheia" também vale aqui.

## O que o painel mostra

**Agora** — cada número abre a lista; tocar numa posição ABRE a ficha dela (página 31):

| Número | O que conta |
|---|---|
| Posições aprovadas | posições **ativas**, com a barra "X% preenchido" (ocupadas × vagas) |
| Vagas abertas | posição ativa sem ninguém. "Vaga há N dias" conta da última saída (ou do início da posição); âmbar depois de 60 dias; mostra se já tem requisição |
| Trabalhando sem posição (vermelho) | colaborador ativo sem posição, ou com uma posição que não existe naquela filial — gente fora do quadro aprovado |
| Mais de uma pessoa na posição (vermelho) | posição **não compartilhada** com 2 pessoas ou mais (com os nomes) |
| Cadastro a conferir (âmbar) | a posição diz uma coisa e a realidade outra: "disponível" mas ocupada; "não disponível" mas vazia; ativa com a data fim vencida; suspensa/extinta com gente |

**Onde estão as posições**: a frase (ativas, ocupadas, vagas, % preenchido, suspensas, extintas, quantas
vagas têm requisição, quem está fora do quadro, pessoas a mais) e 5 quadros:
- **Aprovado e ocupado** por hierarquia (ou filial, cargo, função, c. custo contábil, vínculo, empresa):
  a barra é o aprovado, cheia = ocupada, verde = vaga, vermelho = gente a mais; as linhas com mais vagas
  e excesso vêm primeiro;
- **Situação das posições** (Ativa / Suspensa / Extinta);
- **Vagas há mais tempo**;
- **Cargos com mais vagas**;
- **Liderança**: quantas posições de gestor têm alguém e quais estão vagas.

**Filtrar este resumo**: as colunas do relatório (vários valores em cada uma); tocar numa barra também
filtra. A tabela não muda.

## Regras (PODE MEXER no `[H1]` do .src.js)

- **Ocupada** = há colaborador com situação < 90 e `cad_vaga` = a posição, na mesma empresa e filial.
- `VAGA_VELHA = 60` dias para o selo âmbar.
- "Trabalhando sem posição" respeita o mesmo alcance do relatório (P30_EMP/FILIAL/CCUSTO e os acessos
  `f_acesso_fil` / `F_Acesso_CC`). Com filtro de função, c. custo contábil ou situação no painel, essas
  pessoas saem da conta (não têm essas colunas).
- O significado de "Disponível" foi lido como "livre para preencher". Se na empresa ele quer dizer
  outra coisa, tire as duas primeiras regras do "a conferir" (`p.conferir` em `desenhar`).

## Instalar

1. Subir `login/Natcorp_Posicoes.js` e `login/Natcorp_Posicoes.css`.
2. Importar `f200_page_30.sql` (feita da exportação de 13/10 17:45): File URLs, Static ID **IR** no
   relatório e o processo **NC_POSICOES_INDICADORES** (Ajax Callback, **só leitura**).
3. Conferir: "Posições aprovadas" contra o relatório filtrado por Situação = Ativa.

## Arquivos

| Peça | Fonte | Gera |
|---|---|---|
| A tela | `Natcorp_Posicoes.src.js` | `python3 gerar-posicoes.py` |
| A roupa | `Natcorp_Afastamentos.src.css` (seção `[A13]`) | `node gerar-app.mjs` e depois `gerar-posicoes.py` (cópia) |
| Os números | `NC_POSICOES_INDICADORES.plsql.sql` | entra pelo `aplicar-posicoes-pagina30.py` |
| A página | `f200_page_30.ORIGINAL.sql` | `python3 aplicar-posicoes-pagina30.py f200_page_30.ORIGINAL.sql f200_page_30.sql` |

## Cuidados

- **Não testado no banco.** A consulta das posições é a do relatório (mesmos filtros, acessos e a regra
  do painel PO). A tela foi conferida na 200:30 com dados de teste montados das linhas do relatório.
- O detalhe (página 31) vem com o checksum do servidor, só para as posições das listas (até 6.000).
- "pos" é escrito à mão no PL/SQL (milhares de posições); se faltar uma vírgula o JSON quebra e o painel
  mostra o aviso com o erro.
