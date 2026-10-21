"""Liga o olho de "ver a senha" (Natcorp_Senha.js) nas EXPORTAÇÕES das páginas 900 e 901 do app 200.

    python3 aplicar-senha-paginas.py f200_page_900.sql [saida.sql]
    python3 aplicar-senha-paginas.py f200_page_901.sql [saida.sql]

O script reconhece a página pelo CONTEÚDO: uma página com campo de senha (NATIVE_PASSWORD).
A única mudança é a linha JavaScript › File URLs com #WORKSPACE_IMAGES#Natcorp_Senha.js
(visível no Page Designer). Nenhum item, região, validação ou ação dinâmica é tocado; o desenho
está no Natcorp_Style_Min.css, que o app já carrega.
Roda de novo sobre um arquivo já alterado: não altera duas vezes. Guia: SENHA-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f200_page_900.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
JS = '#WORKSPACE_IMAGES#Natcorp_Senha.js'
s = open(ENTRADA, encoding='utf-8').read()

if "p_display_as=>'NATIVE_PASSWORD'" not in s:
    sys.exit('esta página não tem campo de senha (NATIVE_PASSWORD)')
if JS in s:
    print('já aplicado:', ENTRADA)
    sys.exit(0)
if re.search(r'^,p_javascript_file_urls=>', s, re.M):
    sys.exit('a página já tem JavaScript › File URLs: acrescente à mão a linha ' + JS)
m = re.search(r'^,p_autocomplete_on_off=>.*\n', s, re.M) or re.search(r"^,p_step_title=>.*\n", s, re.M)
if not m:
    sys.exit('não achei onde pôr a URL (p_autocomplete_on_off / p_step_title)')
s = s[:m.end()] + ",p_javascript_file_urls=>'" + JS + "'\n" + s[m.end():]
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok:', SAIDA, '(+ File URLs ' + JS + ')')
