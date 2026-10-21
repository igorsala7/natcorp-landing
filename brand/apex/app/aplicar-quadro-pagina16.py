"""Acrescenta o painel "Resumo do quadro de pessoas" a uma EXPORTAÇÃO da página 16 do app 200
("Informações Funcionais").

    python3 aplicar-quadro-pagina16.py f200_page_16.ORIGINAL.sql f200_page_16.sql

O que muda (o resto da página fica como veio — regiões, itens, relatório, ações, o botão IA):
  1. a página ganha os File URLs  #WORKSPACE_IMAGES#Natcorp_Quadro.js / .css
  2. entra o processo Ajax Callback NC_QUADRO_INDICADORES (os números), com o PL/SQL de
     NC_QUADRO_INDICADORES.plsql.sql — no processo entra uma ficha curta e os símbolos fora do
     Latin-1 viram texto simples (o banco troca … por ¿).
CUIDADO  O NC_QUADRO_INDICADORES.plsql.sql traz a SEGURANÇA do relatório (quem pode ver quem) copiada
         da exportação de 08/10. Se o WHERE do relatório mudar, copie de novo para lá.
Guia: QUADRO-MANUTENCAO.md.
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
FONTE = os.path.join(AQUI, 'NC_QUADRO_INDICADORES.plsql.sql')
JS = "#WORKSPACE_IMAGES#Natcorp_Quadro.js"
CSS = "#WORKSPACE_IMAGES#Natcorp_Quadro.css"
ID_PROCESSO = '990016000000000002'

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

if 'NC_QUADRO_INDICADORES' in s or 'Natcorp_Quadro' in s:
    raise SystemExit('esta exportação já tem o painel: rode sobre o .ORIGINAL.sql')
if 'p_javascript_file_urls' in s or 'p_css_file_urls' in s:
    raise SystemExit('a página já tem File URLs: juntar à mão (este script supõe que não há)')

# 1. os arquivos da página (antes do p_group_id, onde a exportação os poria)
troca(",p_autocomplete_on_off=>'ON'\n,p_group_id=>",
      ",p_autocomplete_on_off=>'ON'\n,p_javascript_file_urls=>'%s'\n,p_css_file_urls=>'%s'\n,p_group_id=>" % (JS, CSS))

# 2. o processo dos números, no fim do último bloco (antes do end_environment)
fonte = open(FONTE, encoding='utf-8').read()
corpo = latin1('/* NATCORP - painel do quadro de pessoas (Natcorp_Quadro.js). FONTE: brand/apex/app/NC_QUADRO_INDICADORES.plsql.sql\n'
               '   (guia QUADRO-MANUTENCAO.md). Mude la e aplique de novo com aplicar-quadro-pagina16.py. */\n'
               + fonte[fonte.index('\ndeclare\n') + 1:])   # a LINHA 'declare' (a ficha do arquivo também cita a palavra)
processo = """wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(%s)
,p_process_sequence=>40
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_QUADRO_INDICADORES'
,p_process_sql_clob=>%s
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""" % (ID_PROCESSO, junta(corpo))
fim = "end;\n/\nprompt --application/end_environment\n"
troca(fim, processo + fim)

open(sai, 'w', encoding='utf-8').write(s)
print(os.path.basename(sai), len(s.encode()) // 1024, 'KB · File URLs + NC_QUADRO_INDICADORES')
