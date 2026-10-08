#!/bin/sh
# Monta o f300.sql (app 300 inteiro) a partir da exportação intocada f300.ORIGINAL.sql:
#   1. o motor das consultas (Natcorp_Consulta) nas páginas de relatório interativo;
#   2. os desenhos já feitos nas mesmas páginas de outros apps (Ficha, Treinamento, Dependentes,
#      Benefícios, Linha do Tempo, Abono, Hora Extra);
#   3. o Contrato de Gestão (106 + 109, Natcorp_Contrato);
#   4. Normas e Procedimentos (56 + 57, Natcorp_Normas);
#   5. a consulta de Benefícios (89, Natcorp_BeneficiosConsulta);
#   6. Marcações de Ponto e o mapa (28 + 9998, Natcorp_Marcacoes);
#   7. a ficha do dependente (22, Natcorp_Dependentes bloco D);
#   8. a Folha do Mês (74, Natcorp_Folha + o processo NC_FOLHA_DADOS) e as Ocorrências (104, NC_OCORR_DADOS);
#   9. os Cursos do cargo (90, Natcorp_Cursos + o processo NC_CURSOS_DADOS).
# Rodar de novo sempre parte do ORIGINAL: o resultado é o mesmo. Exportação nova do app? Salve-a
# como f300.ORIGINAL.sql e rode este arquivo.
set -e
cd "$(dirname "$0")"
python3 aplicar-consultas-app300.py f300.ORIGINAL.sql f300.sql
python3 aplicar-redesenhos-app300.py f300.sql f300.sql
python3 aplicar-contrato-app300.py f300.sql f300.sql
python3 aplicar-normas-app300.py f300.sql f300.sql
python3 aplicar-beneficiosconsulta-app300.py f300.sql f300.sql
python3 aplicar-marcacoes-app300.py f300.sql f300.sql
python3 aplicar-dependentes-ficha-app300.py f300.sql f300.sql
python3 aplicar-folha-app300.py f300.sql f300.sql
python3 aplicar-cursos-app300.py f300.sql f300.sql
