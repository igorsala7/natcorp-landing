"""Ajusta a EXPORTAÇÃO da página 150 do app 200 ("Acidente de Trabalho", a consulta) para o painel
"Resumo dos acidentes de trabalho".

    python3 aplicar-acidpainel-pagina150.py f200_page_150.ORIGINAL.sql f200_page_150.sql

O que muda (o resto da página fica como veio — filtros, relatório, ações, a região Colaborador):
  1. a página ganha os File URLs  #WORKSPACE_IMAGES#Natcorp_AcidPainel.js / .css
  2. o relatório ganha o Static ID "IR" (o painel usa a busca dele: IR_search_field)
  3. entra o processo Ajax Callback NC_ACID_INDICADORES (só leitura), com o PL/SQL de
     NC_ACID_INDICADORES.plsql.sql — a ficha grande fica no arquivo; no processo entra uma curta, e
     os símbolos fora do Latin-1 viram texto simples (o banco troca … por ¿).
Rodar de novo sobre o ORIGINAL dá o mesmo resultado. Guia: ACIDPAINEL-MANUTENCAO.md.
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
FONTE = os.path.join(AQUI, 'NC_ACID_INDICADORES.plsql.sql')
JS = "#WORKSPACE_IMAGES#Natcorp_AcidPainel.js"
CSS = "#WORKSPACE_IMAGES#Natcorp_AcidPainel.css"
ID_PROCESSO = '990150000000000002'

if len(sys.argv) != 3:
    raise SystemExit(__doc__)
ent, sai = sys.argv[1], sys.argv[2]
s = open(ent, encoding='utf-8').read()

def troca(a, b):
    global s
    if s.count(a) != 1:
        raise SystemExit('esperava 1 ocorrência de: ' + a[:80] + ' (achei %d)' % s.count(a))
    s = s.replace(a, b)

TROCA = {'─': '-', '═': '=', '…': '...', '→': '->', '≠': '<>', '≥': '>=', '≤': '<=', '—': '-', '–': '-',
         '“': '"', '”': '"', '‘': "'", '’': "'", '×': 'x', '•': '*'}
def latin1(t):
    for k, v in TROCA.items():
        t = t.replace(k, v)
    ruim = sorted({c for c in t if ord(c) > 255})
    if ruim:
        raise SystemExit('caracteres fora do Latin-1 no PL/SQL: ' + ' '.join(ruim))
    return t

def junta(texto):
    """no formato da exportação: uma linha por item, aspas dobradas"""
    linhas = texto.rstrip('\n').split('\n')
    def item(l):
        l = l.replace("'", "''")
        if all(ord(c) < 128 for c in l):
            return "'" + l + "'"
        # como o próprio APEX exporta: acento vira unistr('\00E7'), e a barra vira \005C
        return "unistr('" + ''.join(c if ord(c) < 128 and c != '\\' else '\\%04X' % ord(c) for c in l) + "')"
    return 'wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(item(l) for l in linhas) + '))'

if 'NC_ACID_INDICADORES' in s or 'Natcorp_AcidPainel' in s:
    raise SystemExit('esta exportação já tem o painel: rode sobre o .ORIGINAL.sql')

# 1. os arquivos da página
troca(",p_autocomplete_on_off=>'ON'\n,p_inline_css=>",
      ",p_autocomplete_on_off=>'ON'\n,p_javascript_file_urls=>'%s'\n,p_css_file_urls=>'%s'\n,p_inline_css=>" % (JS, CSS))

# 2. o Static ID do relatório
troca(",p_plug_name=>'Acidente de Trabalho'\n,p_region_template_options=>'#DEFAULT#'\n,p_plug_template=>",
      ",p_plug_name=>'Acidente de Trabalho'\n,p_region_name=>'IR'\n,p_region_template_options=>'#DEFAULT#'\n,p_plug_template=>")

# 3. o processo dos números, logo depois do processo "popula_colab"
fonte = open(FONTE, encoding='utf-8').read()
corpo = latin1('/* NATCORP - painel de acidentes (Natcorp_AcidPainel.js). FONTE: brand/apex/app/NC_ACID_INDICADORES.plsql.sql\n'
               '   (guia ACIDPAINEL-MANUTENCAO.md). Mude la e aplique de novo com aplicar-acidpainel-pagina150.py. SO LE: nao grava nada. */\n'
               + fonte[fonte.index('\ndeclare\n') + 1:])
processo = """wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(%s)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_ACID_INDICADORES'
,p_process_sql_clob=>%s
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""" % (ID_PROCESSO, junta(corpo))
troca("""':p150_matricula_display := :p150_mat;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""", """':p150_matricula_display := :p150_mat;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""" + processo)

fora = sorted({c for c in s if ord(c) > 255})
if fora:
    raise SystemExit('caractere fora do Latin-1 na exportação: %r' % fora)
open(sai, 'w', encoding='utf-8').write(s)
print(os.path.basename(sai), len(s.encode()) // 1024, 'KB · File URLs + Static ID IR + NC_ACID_INDICADORES')
