"""Aplica o novo desenho à EXPORTAÇÃO da página 7 do app 9132 (Lançamentos de Ocorrências — a janela
onde o gestor lança horas, faltas e valores).

    python3 aplicar-lancficha-pagina7.py f9132_page_7.ORIGINAL.sql f9132_page_7.sql

O que muda: SÓ os File URLs da página (#WORKSPACE_IMAGES#Natcorp_LancFicha.js e .css).
A grade, as 13 validações, as 25 ações dinâmicas, os processos, o LOG e os botões ficam como vieram:
o desenho é todo do JS/CSS (a ficha é a "vista de um registro" da própria grade).
Sem ordem de itens a acertar (a lição da 9132:5): o JS não move nem apaga item de página — move o
grid (que não é item) e insere o seu próprio HTML.
Guia: LANCFICHA-MANUTENCAO.md.
"""
import sys

JS = "#WORKSPACE_IMAGES#Natcorp_LancFicha.js"
CSS = "#WORKSPACE_IMAGES#Natcorp_LancFicha.css"

if len(sys.argv) != 3:
    raise SystemExit(__doc__)
ent, sai = sys.argv[1], sys.argv[2]
s = open(ent, encoding='utf-8').read()
if 'Natcorp_LancFicha' in s:
    raise SystemExit('esta exportação já tem o desenho: rode sobre o .ORIGINAL.sql')
if 'p_javascript_file_urls' in s or 'p_css_file_urls' in s:
    raise SystemExit('a página já tem File URLs: juntar à mão (este script supõe que não há)')
a = ",p_autocomplete_on_off=>'OFF'\n,p_javascript_code_onload=>"
if s.count(a) != 1:
    raise SystemExit('não achei o cabeçalho da página 7 como esperado')
s = s.replace(a, ",p_autocomplete_on_off=>'OFF'\n,p_javascript_file_urls=>'%s'\n,p_css_file_urls=>'%s'\n,p_javascript_code_onload=>" % (JS, CSS))
open(sai, 'w', encoding='utf-8').write(s)
print('ok →', sai)
