"""Ajusta a EXPORTAÇÃO da página 58 do app 9181 ("Comparativos de Históricos Financeiros - Tabular",
os 18 últimos fechamentos) para o "Ver a folha por" em assuntos e o resumo mês a mês.

    python3 aplicar-tabfolha-pagina58.py f9181_page_58.ORIGINAL.sql f9181_page_58.sql

O que muda (o resto fica como veio — os 18 relatórios, filtros, ações dinâmicas, validações, botões IA):
  1. a página ganha os File URLs  #WORKSPACE_IMAGES#Natcorp_ConsolFolha.js / .css (o MESMO arquivo das
     páginas 50 e 55: reconhece a 58 pelo campo P58_HISTOCORR)
  2. entra o processo Ajax Callback NC_TAB_RESUMO (só leitura), com o PL/SQL de
     NC_TAB_RESUMO.plsql.sql (acentos em unistr, como o APEX exporta).
Rodar de novo sobre o ORIGINAL dá o mesmo resultado. Guia: TABFOLHA-MANUTENCAO.md.
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
FONTE = os.path.join(AQUI, 'NC_TAB_RESUMO.plsql.sql')
JS = "#WORKSPACE_IMAGES#Natcorp_ConsolFolha.js"
CSS = "#WORKSPACE_IMAGES#Natcorp_ConsolFolha.css"
ID_PROCESSO = '990958000000000002'

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

if 'NC_TAB_RESUMO' in s or 'Natcorp_ConsolFolha' in s:
    raise SystemExit('esta exportação já tem o painel: rode sobre o .ORIGINAL.sql')

# 1. os arquivos da página
troca(",p_autocomplete_on_off=>'OFF'\n,p_javascript_code=>",
      ",p_autocomplete_on_off=>'OFF'\n,p_javascript_file_urls=>'%s'\n,p_javascript_code=>" % JS)
troca("\n,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'#PARAMETROS",
      "\n,p_css_file_urls=>'%s'\n,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'#PARAMETROS" % CSS)

# 2. o processo do resumo, no fim da página
fonte = open(FONTE, encoding='utf-8').read()
corpo = latin1('/* NATCORP - 18 fechamentos (Natcorp_ConsolFolha.js). FONTE: brand/apex/app/NC_TAB_RESUMO.plsql.sql\n'
               '   (guia TABFOLHA-MANUTENCAO.md). Mude la e aplique de novo com aplicar-tabfolha-pagina58.py. SO LE: nao grava nada. */\n'
               + fonte[fonte.index('\ndeclare\n') + 1:])
processo = """wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(%s)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_TAB_RESUMO'
,p_process_sql_clob=>%s
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""" % (ID_PROCESSO, junta(corpo))
troca("""end;
/
prompt --application/end_environment""", processo + """end;
/
prompt --application/end_environment""")

fora = sorted({c for c in s if ord(c) > 255})
if fora:
    raise SystemExit('caractere fora do Latin-1 na exportação: %r' % fora)
open(sai, 'w', encoding='utf-8').write(s)
print(os.path.basename(sai), len(s.encode()) // 1024, 'KB · File URLs + NC_TAB_RESUMO')
