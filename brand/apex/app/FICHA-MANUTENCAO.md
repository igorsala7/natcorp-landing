# Dados Funcionais (app 200, página 17) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Público: o RH, que abre esta ficha centenas de vezes por dia para consultar e conferir. Página só
de consulta: o desenho não grava nada.

1. **O alto** — faixa da marca, foto grande, nome, situação, os 6 fatos (matrícula, empresa,
   admissão + tempo de casa, cargo, filial, C.Custo) e as ações da página (os botões do APEX,
   trazidos para cá: Benefícios, Documentos…).
2. **Navegação à esquerda** — fixa ao rolar (feita em JS: o tema põe `overflow` e o sticky não
   funciona), com busca de campo (atalho `/`) e a contagem de cada seção. Substitui as abas, que
   continuam no APEX em "Mostrar Tudo", fora da vista.
3. **Seções por assunto** — Dados Pessoais (Identificação, Nacionalidade, Escolaridade, Contato,
   Deficiência, Banco), Documentos, Lotação, Cargos/Salários (valores em R$ com o olho para
   esconder), Folha, Horário; campos vazios recolhidos em "N campos sem informação".
4. **Dependentes em cartões** e **Ocorrências em linha do tempo**, com a tabela original a um
   clique. Clique num campo copia o valor.
5. **Janela Benefícios** — cartões por grupo, todas as linhas (o relatório vinha de 15 em 15),
   encerrados recolhidos.

A janela **Documentos** é outro app (2210 CONS_GED, página 865): ver `DOCUMENTOS-MANUTENCAO.md`.

## Arquivos (Workspace Images)

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Ficha.css` | o desenho (gerado de `Natcorp_Ficha.src.css` por `gerar-app.mjs`) |
| `Natcorp_Ficha.js` | o comportamento (gerado por `gerar-ficha.py`) |

## O contrato: classes nas regiões

Aplicadas por `aplicar-ficha-pagina17.py` (pelos nomes; roda uma vez só), com as URLs dos dois
arquivos e o comentário da página:

| Região | Classe |
| --- | --- |
| Colaborador | `nc-df-colaborador` |
| Informações | `nc-df-info` |
| Benefícios Relatório (dentro da janela Benefícios) | `nc-df-beneficios` |

O CSS em linha da página (`#BTN_BENEFICIOS`, `#BTTPVINC`, `#BTDUPVINC`) fica como está.

## Desligar

Tire as duas URLs de arquivo da página 17.

## Regras da página (auditoria 04/10)

**Conferido** contra `f200_page_17.ORIGINAL.sql`: 3 ações dinâmicas (5 ações: abrir Benefícios,
travar 3 itens no "ready", abrir modal), nenhuma validação, 2 processos de carga, 5 botões,
condições de servidor (salário por `FNCT_TRATA_VERIF_SAL_NIVEL`, Dependentes por permissão).
Página só de consulta: o desenho não grava; os botões (Benefícios, duplo vínculo, ficha,
Documentos) só mudam de lugar; o Seletor de abas fica em "Mostrar Tudo" (permitido).
A página 13 do PO_NATCORP (`aplicar-ficha-pagina13.py`) só muda o título no processo
`popula_campos` (nome completo + nome social): não mexe em regra; exportação não está na pasta.

**Mudou:**
- `[C4]` a regra que põe `display: block` nos campos das seções ganhou `:not([style*="none"])`
  (hoje nenhuma ação esconde campo aqui; é proteção).

**Para decisão:**
- Os itens do Colaborador saem da vista (os valores vão para o alto) e os campos vazios ficam
  atrás de "N campos sem informação": esconder item da página, numa tela só de leitura.
