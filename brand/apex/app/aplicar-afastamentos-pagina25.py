"""Ajusta a EXPORTAÇÃO da página 25 do app 200 ("Controle de Funcionários Afastados") para o painel
"Resumo dos afastamentos".

    python3 aplicar-afastamentos-pagina25.py f200_page_25.ORIGINAL.sql f200_page_25.sql

O que muda (o resto da página fica como veio — regiões, itens, relatório, ações, o botão IA):
  1. a página ganha os File URLs  #WORKSPACE_IMAGES#Natcorp_Afastamentos.js / .css
  2. entra o processo Ajax Callback NC_AFAST_INDICADORES (os números), com o PL/SQL de
     NC_AFAST_INDICADORES.plsql.sql — a ficha grande fica no arquivo; no processo entra uma curta, e
     os símbolos fora do Latin-1 viram texto simples (o banco troca … por ¿).
Rodar de novo sobre o ORIGINAL dá o mesmo resultado. Guia: AFASTAMENTOS-MANUTENCAO.md.
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
FONTE = os.path.join(AQUI, 'NC_AFAST_INDICADORES.plsql.sql')
JS = "#WORKSPACE_IMAGES#Natcorp_Afastamentos.js"
CSS = "#WORKSPACE_IMAGES#Natcorp_Afastamentos.css"
ID_PROCESSO = '990025000000000002'

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
         '“': '"', '”': '"', '‘': "'", '’': "'"}
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
    return 'wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join("'" + l.replace("'", "''") + "'" for l in linhas) + '))'

if 'NC_AFAST_INDICADORES' in s or 'Natcorp_Afastamentos' in s:
    raise SystemExit('esta exportação já tem o painel: rode sobre o .ORIGINAL.sql')

# 1. os arquivos da página
troca(",p_autocomplete_on_off=>'ON'\n,p_javascript_code=>",
      ",p_autocomplete_on_off=>'ON'\n,p_javascript_file_urls=>'%s'\n,p_javascript_code=>" % JS)
troca("\n,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'#PARAMETROS",
      "\n,p_css_file_urls=>'%s'\n,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'#PARAMETROS" % CSS)

# 2. o processo dos números, logo depois do processo "usuario"
fonte = open(FONTE, encoding='utf-8').read()
corpo = latin1('/* NATCORP - painel de afastamentos (Natcorp_Afastamentos.js). FONTE: brand/apex/app/NC_AFAST_INDICADORES.plsql.sql\n'
               '   (guia AFASTAMENTOS-MANUTENCAO.md). Mude la e aplique de novo com aplicar-afastamentos-pagina25.py. */\n'
               + fonte[fonte.index('\ndeclare\n') + 1:])   # a LINHA 'declare' (a ficha do arquivo também cita a palavra)
processo = """wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(%s)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_AFAST_INDICADORES'
,p_process_sql_clob=>%s
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""" % (ID_PROCESSO, junta(corpo))
troca("""'v_usuario := usuario.busca_user;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""", """'v_usuario := usuario.busca_user;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""" + processo)

open(sai, 'w', encoding='utf-8').write(s)
print(os.path.basename(sai), len(s.encode()) // 1024, 'KB · File URLs + NC_AFAST_INDICADORES')
