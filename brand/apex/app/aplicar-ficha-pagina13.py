"""Nome completo no título da janela "Dados do Colaborador" (página 13 do Painel do Operador).

    python3 aplicar-ficha-pagina13.py f202_page_13.sql [saida.sql]

O título (P13_TITULO_COLAB) é montado pelo processo popula_campos com
Initcap(nvl(p.nome_social, p.nome)): quem tem nome social cadastrado aparecia só com ele
("Tony"). Pedido do usuário em 01/10: o título traz o NOME COMPLETO; o nome social, quando
existe e é diferente, vem logo abaixo ("Nome social: Tony"), com o estilo .nc-ficha-social do
Natcorp_Paginas.

Muda só o processo popula_campos: duas colunas novas no cursor (nome_civil e nome_social) e a
linha que monta o título. :P13_NOME continua igual (outros pontos do app o usam).
Acha tudo pelo texto, nunca pelos IDs. Rodar de novo não altera duas vezes.
"""
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f202_page_13.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA

s = open(ENTRADA, encoding='utf-8').read()

if 'nc-ficha-social' in s:
    print('já aplicado:', ENTRADA)
    sys.exit(0)

# 1. o cursor ganha o nome civil e o nome social em colunas próprias
COL = "'       Initcap(nvl(p.nome_social,p.nome)) nome2,',\n"
assert s.count(COL) == 1, 'coluna nome2 do cursor não encontrada (ou repetida)'
s = s.replace(COL, COL +
              "'       Initcap(p.nome) nome_civil,',\n"
              "'       Initcap(p.nome_social) nome_social,',\n")

# 2. o título: nome completo; o nome social embaixo quando for outro
TIT = "':P13_TITULO_COLAB := ''<h3>''||v_c1.nome2||''</h3>'';',\n"
assert s.count(TIT) == 1, 'linha do P13_TITULO_COLAB não encontrada (ou repetida)'
s = s.replace(TIT,
              "':P13_TITULO_COLAB := ''<h3>''||apex_escape.html(v_c1.nome_civil)||''</h3>''||',\n"
              "'    case when v_c1.nome_social is not null and upper(trim(v_c1.nome_social)) <> upper(trim(v_c1.nome_civil))',\n"
              "'         then ''<p class=\"nc-ficha-social\">Nome social: <b>''||apex_escape.html(v_c1.nome_social)||''</b></p>''',\n"
              "'    end;',\n")

open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok →', SAIDA)
