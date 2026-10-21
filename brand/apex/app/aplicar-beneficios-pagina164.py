"""Acrescenta o painel de BENEFÍCIOS a uma EXPORTAÇÃO da página 164 do app 200 ("Benefícios").

    python3 aplicar-beneficios-pagina164.py f200_page_164.ORIGINAL.sql f200_page_164.sql

O que muda (o resto da página fica como veio — filtros, os relatórios IR_1/IR_4, ações, o botão IA):
  1. a página ganha os File URLs  #WORKSPACE_IMAGES#Natcorp_BenefPainel.js / .css
  2. entra o processo Ajax Callback NC_BENEF_INDICADORES (os números), com o PL/SQL de
     NC_BENEF_INDICADORES.plsql.sql — no processo entra uma ficha curta e os símbolos fora do
     Latin-1 viram texto simples (o banco troca … por ¿).
CUIDADO  O NC_BENEF_INDICADORES.plsql.sql traz a consulta do IR_1 e o WHERE do IR_4 (quem pode ver
         quem) copiados da exportação de 08/10. Se os relatórios mudarem, copie de novo para lá.
Guia: BENEFPAINEL-MANUTENCAO.md.
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
FONTE = os.path.join(AQUI, 'NC_BENEF_INDICADORES.plsql.sql')
JS = "#WORKSPACE_IMAGES#Natcorp_BenefPainel.js"
CSS = "#WORKSPACE_IMAGES#Natcorp_BenefPainel.css"
ID_PROCESSO = '990164000000000002'

if len(sys.argv) != 3:
    raise SystemExit(__doc__)
ent, sai = sys.argv[1], sys.argv[2]
s = open(ent, encoding='utf-8').read()

def troca(a, b):
    global s
    if s.count(a) != 1:
        raise SystemExit('esperava 1 ocorrência de: ' + a[:90] + ' (achei %d)' % s.count(a))
    s = s.replace(a, b)

TROCA = {'─': '-', '═': '=', '…': '...', '→': '->', '≠': '<>', '≥': '>=', '≤': '<=', '—': '-', '–': '-',
         '“': '"', '”': '"', '‘': "'", '’': "'", '•': '-', '×': 'x', '−': '-'}
def latin1(t):
    for k, v in TROCA.items():
        t = t.replace(k, v)
    ruim = sorted({c for c in t if ord(c) > 255})
    if ruim:
        raise SystemExit('caracteres fora do Latin-1 no PL/SQL: ' + ' '.join(ruim))
    return t

def junta(texto):
    linhas = texto.rstrip('\n').split('\n')
    return 'wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join("'" + l.replace("'", "''") + "'" for l in linhas) + '))'

if 'NC_BENEF_INDICADORES' in s or 'Natcorp_BenefPainel' in s:
    raise SystemExit('esta exportação já tem o painel: rode sobre o .ORIGINAL.sql')
if 'p_javascript_file_urls' in s or 'p_css_file_urls' in s:
    raise SystemExit('a página já tem File URLs: juntar à mão (este script supõe que não há)')

# 1. os arquivos da página
troca(",p_autocomplete_on_off=>'ON'\n,p_inline_css=>",
      ",p_autocomplete_on_off=>'ON'\n,p_javascript_file_urls=>'%s'\n,p_css_file_urls=>'%s'\n,p_inline_css=>" % (JS, CSS))

# 2. o processo dos números, no fim do último bloco (antes do end_environment)
fonte = open(FONTE, encoding='utf-8').read()
corpo = latin1('/* NATCORP - painel de beneficios (Natcorp_BenefPainel.js). FONTE: brand/apex/app/NC_BENEF_INDICADORES.plsql.sql\n'
               '   (guia BENEFPAINEL-MANUTENCAO.md). Mude la e aplique de novo com aplicar-beneficios-pagina164.py. */\n'
               + fonte[fonte.index('\ndeclare\n') + 1:])   # a LINHA 'declare' (a ficha do arquivo também cita a palavra)
processo = """wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(%s)
,p_process_sequence=>40
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_BENEF_INDICADORES'
,p_process_sql_clob=>%s
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""" % (ID_PROCESSO, junta(corpo))
fim = "end;\n/\nprompt --application/end_environment\n"
troca(fim, processo + fim)

open(sai, 'w', encoding='utf-8').write(s)
print(os.path.basename(sai), len(s.encode()) // 1024, 'KB · File URLs + NC_BENEF_INDICADORES')
